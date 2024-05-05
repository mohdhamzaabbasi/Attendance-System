import streamlit as st
import cv2
import numpy as np
import face_recognition
import pickle

# Load the face recognition model from the pickle file
with open('face_recognition_model.pkl', 'rb') as f:
    encodeknownlist = pickle.load(f)

# Function to mark attendance
def markAttendance(name):
    # Your existing code for marking attendance goes here
    pass

def main():
    st.title("Face Recognition System")

    # Capture video from webcam
    cap = cv2.VideoCapture(0)

    while True:
        # Read frame from the camera
        suc, img = cap.read()
        if suc:
            imgs = cv2.resize(img, (0, 0), None, 0.25, 0.25)
            imgs = cv2.cvtColor(imgs, cv2.COLOR_BGR2RGB)

            face_cur = face_recognition.face_locations(imgs)
            encode_cur = face_recognition.face_encodings(imgs, face_cur)

            for encodeface, faceloc in zip(encode_cur, face_cur):
                matches = face_recognition.compare_faces(encodeknownlist, encodeface)
                facedis = face_recognition.face_distance(encodeknownlist, encodeface)
                match_index = np.argmin(facedis)

                if matches[match_index]:
                    name = classNames[match_index].upper()
                    y1, x2, y2, x1 = faceloc
                    y1, x2, y2, x1 = y1 * 4, x2 * 4, y2 * 4, x1 * 4
                    cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)
                    cv2.rectangle(img, (x1, y2 - 35), (x2, y2), (0, 255, 0), cv2.FILLED)
                    cv2.putText(img, name, (x1 + 6, y2 - 6), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 2)
                    markAttendance(name)

            # Display the frame
            st.image(img, channels="BGR")

        if st.button("Stop"):
            break

    cap.release()

if __name__ == "__main__":
    main()
