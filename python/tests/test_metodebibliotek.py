import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.svm import SVC

# set up small vectors for using in tests
train_words = ["fish chips", "chips", "egg"]
train_labels = ["g1", "g1", "g2"]
test_words = ["chips", "egg"]
train_array = [[1, 0, 1], [1, 0, 0], [0, 1, 0]]


def test_CountVectorizer():
    """
    Test function for CountVectorizer using small goods names vector
    """
    vectorizer = CountVectorizer(analyzer='word')
    vectorizer.fit(train_words)
    train_vec = vectorizer.transform(train_words).toarray()
    assert (train_vec == train_array).sum() == 9, "CountVectorizer assesses array correctly"


def test_SVC():
    """
    Test function for SVC using a small example
    """
    test_vec = [[1, 0, 0], [0, 1, 0]]
    classifier_svm = SVC(random_state=0, kernel='linear')
    classifier_svm.fit(train_array, train_labels)
    pred_test = classifier_svm.predict(test_vec)
    assert all(pred_test == ['g1','g2']), "SVC model predicts correctly"
    

if __name__ == '__main__':
    test_CountVectorizer()
    test_SVC()
