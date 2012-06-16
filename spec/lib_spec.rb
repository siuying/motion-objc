describe "Using library with motion-objc" do
  it "include obj-c class" do
    "Hello World".to_data.MD5HexDigest.should == "b10a8db164e0754105b7a99be72e3fe5"
  end
end
