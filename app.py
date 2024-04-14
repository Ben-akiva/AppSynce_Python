import requests

# Function to create a new test table
def create_test_table(lock_id, username, email):
    # Define the API endpoint
    url = "https://gjdrxegffbgvvhlccebndqhm3m.appsync-api.eu-north-1.amazonaws.com/graphql"

    # Define the GraphQL mutation for creating a new test table
    mutation = """
    mutation CreateTestTable($input: CreateTestTableInput!) {
        createTestTable(input: $input) {
            LockID
            ID
            username
            email
        }
    }
    """

    # Set the request headers
    headers = {
        "Content-Type": "application/json",
        "x-api-key": "da2-wambhqbn3bfype2xoahgppufoe"
    }

    # Define the variables for the mutation
    variables = {
        "input": {
            "LockID": lock_id,
            "username": username,
            "email": email
        }
    }

    # Send the request
    response = requests.post(url, headers=headers, json={"query": mutation, "variables": variables})

    # Check if the request was successful
    if response.status_code == 200:
        data = response.json()
        if "errors" in data:
            print("Error:", data["errors"])
            return None
        return data["data"]["createTestTable"]
    else:
        print("Error:", response.text)
        return None

# Function to update an existing test table
def update_test_table(lock_id, new_username, new_email):
    # Define the API endpoint
    url = "https://gjdrxegffbgvvhlccebndqhm3m.appsync-api.eu-north-1.amazonaws.com/graphql"

    # Define the GraphQL mutation for updating an existing test table
    mutation = """
    mutation UpdateTestTable($input: UpdateTestTableInput!) {
        updateTestTable(input: $input) {
            LockID
            ID
            username
            email
        }
    }
    """

    # Set the request headers
    headers = {
        "Content-Type": "application/json",
        "x-api-key": "da2-wambhqbn3bfype2xoahgppufoe"
    }

    # Define the variables for the mutation
    variables = {
        "input": {
            "LockID": lock_id,
            "username": new_username,
            "email": new_email
        }
    }

    # Send the request
    response = requests.post(url, headers=headers, json={"query": mutation, "variables": variables})

    # Check if the request was successful
    if response.status_code == 200:
        data = response.json()
        if "errors" in data:
            print("Error:", data["errors"])
            return None
        return data["data"]["updateTestTable"]
    else:
        print("Error:", response.text)
        return None

# Function to list all users in the test table
def list_users():
    # Define the API endpoint
    url = "https://gjdrxegffbgvvhlccebndqhm3m.appsync-api.eu-north-1.amazonaws.com/graphql"

    # Define the GraphQL query for listing all test records
    query = """
    query ListTests {
        listTestTables {
            items {
                LockID
                username
                email
            }
        }
    }
    """

    # Set the request headers
    headers = {
        "Content-Type": "application/json",
        "x-api-key": "da2-wambhqbn3bfype2xoahgppufoe"
    }

    # Send the request
    response = requests.post(url, headers=headers, json={"query": query})

    # Check if the request was successful
    if response.status_code == 200:
        data = response.json()
        if "errors" in data:
            print("Error:", data["errors"])
            return None
        users = data["data"]["listTestTables"]["items"]
        if users:
            for user in users:
                print("ID:", user["LockID"])
                print("Username:", user["username"])
                print("Email:", user["email"])
                print()
        else:
            print("No users found.")
    else:
        print("Error:", response.text)

# Function to prompt user for action
def prompt_user():
    while True:
        print("Menu:")
        print("1. Add a user")
        print("2. List users")
        choice = input("Enter your choice (1 or 2): ")

        if choice == "1":
            lock_id = input("Enter ID: ")
            username = input("Enter username: ")
            email = input("Enter email: ")

            # Create a new user
            new_user = create_test_table(lock_id, username, email)
            if new_user:
                print("New User:", new_user)
        elif choice == "2":
            print("Listing all users:")
            list_users()
        else:
            print("Invalid choice. Please enter 1 or 2.")

# Main function
def main():
    prompt_user()

if __name__ == "__main__":
    main()
