//打印物体朝向

using UnityEngine;
using System.Collections;

public class ForwardDebugger : MonoBehaviour {

	public GameObject source;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
		if (source != null && Time.frameCount % 10 == 0) {
			Debug.Log (source.transform.forward);
		}
	}
}
