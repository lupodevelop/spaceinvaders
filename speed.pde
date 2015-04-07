class Speed extends ArrayList<Interval>{
  public float StartSpeed;
  public Speed(float startSpeed){
    StartSpeed=startSpeed;
    LoadIntervals("data/text/intervals.txt");
  }
  
  public void LoadIntervals(String path){
    String[] text = loadStrings(path);
    for(String s : text){
      String[] temp=s.split(";"); 
      this.add(new Interval(parseFloat(temp[0]),parseFloat(temp[1]),parseFloat(temp[2])));  // float1;float2;float3;
    }   
  }
  
  public float SetSpeed(float percentual){
    for(Interval in : this){
      float f = in.SetSpeed(percentual);
      if(f!=-1)
        return f*StartSpeed;
    }  
    return 0;  // if return -1 bug!!!
  }
}

class Interval{
  float max;
  float min;
  float value;
  public Interval(float max,float min,float value){
    this.max=max;
    this.min=min;
    this.value=value;
  }
  
  public float SetSpeed(float percentual){
    //println("max= "+max+" min= "+min+ "value= "+value);
    return max>=percentual && percentual>min?value:-1;
  }
}
