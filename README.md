github代码
--------

如果本博客对您有帮助，希望可以得到您的赞赏！

swift 机器学习Core ML的简单调用小demo。完整代码附上：
https://github.com/Liuyubao/LYBCoreMLDemo

## iOS11 新增特性 ##
iOS11 SDK 的大的框架有两个，分别是集成机器学习的 Core ML 和创建增强现实 (AR) 应用的 ARKit。

## CoreML ##
官方介绍在此：https://developer.apple.com/documentation/coreml
主要用于Integrate machine learning models into your app.将机器学习相关model集成到你的app当中。

借助Core ML，您可以将经过培训的机器学习模型整合到您的应用程序中

![这里写图片描述](https://docs-assets.developer.apple.com/published/72e22672fd/c35ebf2d-ee94-4448-8fae-16420e7cc4ed.png)

Core ML将训练有素的机器学习模型集成到您的应用程序中。
一个训练有素的模型是将机器学习算法来训练数据集合的结果。该模型根据新的输入数据进行预测。例如，一个在某个地区的历史房价上受过培训的模型可能能够在给定卧室和浴室的数量时预测房屋的价格。

核心ML是领域特定框架和功能的基础。核心ML支持视觉图像分析，基本自然语言处理（例如类），并GameplayKit评估学会决策树。核心ML本身建立在像Accelerate和BNNS这样的低级原语以及金属性能着色器之上。NSLinguisticTagger
![这里写图片描述](https://docs-assets.developer.apple.com/published/bc34b3e6c2/db81e861-1e06-4d14-8915-90707d9b114c.png)

机器学习堆栈
核心ML针对器件性能进行了优化，最大限度地减少了内存占用量和功耗。在设备上严格运行可确保用户数据的隐私，并确保您的应用在网络连接不可用时保持功能和响应。


Xcode
-----

编辑器和编译器

速度就是生命，而开发者的生命都浪费在了等待编译上。Swift 自问世以来就备受好评，但是缓慢的编译速度，时有时无的语法提示，无法进行重构等工具链上的欠缺成为了最重要的黑点。Xcode 9 中编辑器进行了重写，支持了对 Swift 代码的重构 (虽然还很基础)，将 VCS 提到了更重要的位置，并添加了 GitHub 集成，可以进行同局域网的无线部署和调试。
![这里写图片描述](https://onevcat.com/assets/images/2017/xcode-git.png)

新的编译系统是使用 Swift 重写的，在进行了一些对比以后，编译速度确实有了不小的提升。虽然不知道是不是由于换成了 Swift 4，不过据说总编译时间从原来的三分半缩短到了两分钟半左右，可以说相当明显了。

Xcode 9 中的索引系统也使用了新的引擎，据称在大型项目中搜索最高可以达到 50 倍的速度。不过可能由于笔者所参加的项目不够大，这一点体会不太明显。项目里的 Swift 代码依然面临失色的情况。这可能是索引系统和编译系统没有能很好协同造成的，毕竟还是 beta 版本的软件，也许应该多给 Xcode 团队一些时间 (虽然可能到最后也就这样了)。

由于 Swift 4 编译器也提供了 Swift 3 的兼容 (在 Build Setting 中设置 Swift 版本即可)，所以如果没有什么意外的话，我可能会在之后的日常开发中使用 Xcode 9 beta，然后在打包和发布时再切回 Xcode 8 了。毕竟每次完整编译节省一分半钟的时间，还是一件很诱人的事情。

这次的 beta 版本质量出人意料地好，也许是因为这一两年来都是小幅革新式的改良，让 Apple 的软件团队有相对充足的时间进行开发的结果？总之，Xcode 9 beta 现在已经能很好地工作了。

Named Color
-----------

现在你可以在 xcassets 里添加颜色，然后在代码或者 IB 中引用这个颜色了。大概是这样的：
![这里写图片描述](https://onevcat.com/assets/images/2017/named-colors.png)

像是使用 IB 来构建 UI 的时候，一个很头疼的事情就是设计师表示我们要不换个主题色。你很可能需要到处寻找这个颜色进行替换。但是现在你只需要在 xcassets 里改一下，就能反应到 IB 中的所有地方了。


其他值得注意的变更
---------

- 拖拽 - 很标准的一套 iOS API，不出意外地，iOS 系统帮助我们处理了绝大部分工作，开发者几乎只需要处理结果。UITextView
和 UITextField 原生支持拖拽，UICollectionView 和 UITableView 的拖拽有一系列专用的
delegate 来表明拖拽的发生和结束。而你也可以对任意 UIView 子类定义拖拽行为。和 mac 上的拖拽不同，iOS
的拖拽充分尊重了多点触控的屏幕，所以可能你需要对一次多个的拖拽行为做些特别处理。
- 新的 Navigation title 设计 - iOS 11 的大多数系统 app
都采用了新的设计，放大了导航栏的标题字体。如果你想采用这项设计的话也非常简单，设置 navigation bar 的
prefersLargeTitles 即可。
- FileProvider 和 FileProviderUI - 提供一套类似 Files app
的界面，让你可以获取用户设备上或者云端的文件。相信会成为以后文档相关类 app 的标配。
- 不再支持 32 位 app - 虽然在 beta 1 中依然可以运行 32 位 app，但是 Apple 明确指出了将在后续的 iOS
11 beta 中取消支持。所以如果你想让自己的程序运行在 iOS 11 的设备上，进行 64 位的重新编译是必须步骤。
- DeviceCheck - 每天要用广告 ID 追踪用户的开发者现在有了更好地选择 (当然前提是用来做正经事儿)。DeviceCheck
允许你通过你的服务器与 Apple 服务器通讯，并为单个设备设置两个 bit 的数据。简单说，你在设备上用 DeviceCheck API
生成一个 token，然后将这个 token 发给自己的服务器，再由自己的服务器与 Apple 的 API
进行通讯，来更新或者查询该设备的值。这两个 bit 的数据用来追踪用户比如是否已经领取奖励这类信息。
- PDFKit - 这是一个在 macOS 上已经长期存在的框架，但却在 iOS 上姗姗来迟。你可以使用这个框架显示和操作 pdf 文件。
- IdentityLookup - 可以自己开发一个 app extension 来拦截系统 SMS 和 MMS 的信息。系统的信息 app
在接到未知的人的短信时，会询问所有开启的过滤扩展，如果扩展表示该消息应当被拦截，那么这则信息将不会传递给你。扩展有机会访问到事先指定的
server 来进行判断 (所以说你可以光明正大地获取用户短信内容了，不过当然考虑到隐私，这些访问都是匿名加密的，Apple
也禁止这类扩展在 container 里进行写入)。
- Core NFC - 在 iPhone 7 和 iPhone 7 Plus 上提供基础的近场通讯读取功能。看起来很
promising，只要你有合适的 NFC
标签，手机就可以进行读取。但是考虑到无法后台常驻，实用性就打了折扣。不过笔者不是很熟这块，也许能有更合适的场景也未可知。
- Auto Fill - 从 iCloud Keychain
中获取密码，然后自动填充的功能现在开放给第三方开发者了。UITextInputTraits 的 textContentType 中添加了
username 和 password，对适合的 text view 或者 text field 的 content type
进行配置，并填写 Info.plist 的相关内容，就可以在要求输入用户名密码时获取键盘上方的自动填充，帮助用户快速登录。


github代码
--------

如果本博客对您有帮助，希望可以得到您的赞赏！
完整代码附上：https://github.com/Liuyubao/LYBCoreMLDemo
