# Liszt-PayPrompt
防支付宝支付指示器,代码简单容易懂,易扩展
    <img src="https://github.com/LisztGitHub/Liszt-PayPrompt/blob/master/Liszt.gif" />
#
    #import <UIKit/UIKit.h>

    /** 显示完成回调Block*/
    typedef void (^PromptCompletionBlock)();


    @interface PromptView : UIView
    + (void)showSuccessInView:(UIView *)inView content:(NSString *)content;
    + (void)showSuccessInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration;
    /**
     *  加载成功
     *  @param inView 需要加载的View  建议(self.navigationController.view||self.view)
     *  @param duration 停留的时间
     *  @param completionBlock 加载完成回调
     */
    + (void)showSuccessInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration completion:(PromptCompletionBlock)completionBlock;


    + (void)showErrorInView:(UIView *)inView content:(NSString *)content;
    + (void)showErrorInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration;
    /**
     *  加载失败
     *  @param inView 需要加载的View  建议(self.navigationController.view||self.view)
     *  @param duration 停留的时间
     *  @param completionBlock 加载完成回调
     */
    + (void)showErrorInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration completion:(PromptCompletionBlock)completionBlock;


    + (void)showIndeterminateWithInView:(UIView *)inView content:(NSString *)content;
    + (void)showIndeterminateWithInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration;
    /**
     *  加载中
     *  @param inView 需要加载的View  建议(self.navigationController.view||self.view)
     *  @param duration 停留的时间
     *  @param completionBlock 加载完成回调
     */
    + (void)showIndeterminateWithInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration completion:(PromptCompletionBlock)completionBlock;


    + (void)showInView:(UIView *)inView content:(NSString *)content customView:(UIView *)customView;
    + (void)showInView:(UIView *)inView content:(NSString *)content customView:(UIView *)customView duration:(NSTimeInterval)duration;
    /**
     *  加载中
     *  @param inView 需要加载的View  建议(self.navigationController.view||self.view)
     *  @param duration 停留的时间
     *  @param completionBlock 加载完成回调
     */
    + (void)showInView:(UIView *)inView content:(NSString *)content customView:(UIView *)customView duration:(NSTimeInterval)duration completion:(PromptCompletionBlock)completionBlock;


    /**
     *  隐藏指示层
     */
    + (void)hideInView:(UIView *)inView;
    @end

