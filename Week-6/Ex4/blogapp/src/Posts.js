// src/Posts.js
import React from "react";

class Posts extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: [],
      error: null
    };
  }

  loadPosts() {
    fetch("https://jsonplaceholder.typicode.com/posts/1/comments")
      .then((res) => res.json())
      .then((data) => {
        const postList = data.slice(0, 4);
        this.setState({ posts: postList });
      })
      .catch((err) => {
        this.setState({ error: err });
      });
  }

  componentDidMount() {
    this.loadPosts();
  }

  componentDidCatch(error, info) {
    console.error("Caught error:", error);
    console.info("Error info:", info);
    alert("Something went wrong! See console for details.");
    this.setState({ error });
  }

  render() {
    const { posts, error } = this.state;

    if (error) {
      return <div>Something went wrong: {error.toString()}</div>;
    }

    return (
      <div>
        <h2>Posts</h2>
        {posts.map((post) => (
          <div key={post.id} style={{ marginBottom: "20px" }}>
            <h3>{post.title}</h3>
            <p>{post.body}</p>
          </div>
        ))}
      </div>
    );
  }
}

export default Posts;
