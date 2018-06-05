//
//  UIControl+AXBlockWrapper.m
//  AXKit
//
//  Created by xaoxuu on 05/03/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "UIControl+AXBlockWrapper.h"
#import "AXEventTarget.h"


/**
 绑定事件

 @param control 控件
 @param events 事件
 @param handler 处理
 @return 响应者
 */
static inline AXEventTarget *bindAction(UIControl *control, UIControlEvents events, void (^handler)(__kindof UIControl *)){
    return [AXEventTarget targetWithControl:control controlEvents:events handler:handler];
}

@import ObjectiveC.runtime;

static const void *UIControlAXBlockWrapperKey = &UIControlAXBlockWrapperKey;

#pragma mark Category

@implementation UIControl (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UIControl *sender))handler forControlEvents:(UIControlEvents)controlEvents{
    // add a control events to target
    bindAction(self, controlEvents, handler);
}

- (void)ax_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents{
    [AXEventTarget removeControlEvents:controlEvents forControl:self];
}

- (NSUInteger)ax_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents{
    // get events
    NSMutableDictionary *events = objc_getAssociatedObject(self, UIControlAXBlockWrapperKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, UIControlAXBlockWrapperKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // get handlers from events
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    
    return handlers.count;
    
}

@end


#pragma mark - UIButton

@implementation UIButton (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UIButton *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    bindAction(self, controlEvents, handler);
}

- (void)ax_addTouchDownHandler:(void (^)(__kindof UIButton *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventTouchDown, handler);
}

- (void)ax_addTouchUpInsideHandler:(void (^)(__kindof UIButton *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventTouchUpInside, handler);
}


@end

#pragma mark - UISlider

@implementation UISlider (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UISlider *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    bindAction(self, controlEvents, handler);
}

- (void)ax_addTouchDownHandler:(void (^)(__kindof UISlider *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventTouchDown, handler);
}

- (void)ax_addValueChangedHandler:(void (^)(__kindof UISlider *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventValueChanged, handler);
}

- (void)ax_addTouchUpHandler:(void (^)(__kindof UISlider *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventTouchUpInside, handler);
    bindAction(self, UIControlEventTouchUpOutside, handler);
}

@end


#pragma mark - UISwitch

@implementation UISwitch (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UISwitch *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    bindAction(self, controlEvents, handler);
}

- (void)ax_addTouchDownHandler:(void (^)(__kindof UISwitch *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventTouchDown, handler);
}

- (void)ax_addValueChangedHandler:(void (^)(__kindof UISwitch *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventValueChanged, handler);
}

- (void)ax_addTouchUpInsideHandler:(void (^)(__kindof UISwitch *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventTouchUpInside, handler);
}

@end


#pragma mark - UISegmentedControl

@implementation UISegmentedControl (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UISegmentedControl *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    bindAction(self, controlEvents, handler);
}

- (void)ax_addValueChangedHandler:(void (^)(__kindof UISegmentedControl *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventValueChanged, handler);
}

@end


#pragma mark - UITextField

@implementation UITextField (AXBlockWrapper)

- (void)ax_addEventHandler:(void (^)(__kindof UITextField *sender))handler forControlEvents:(UIControlEvents)controlEvents {
    // add a control events to target
    bindAction(self, controlEvents, handler);
}

- (void)ax_addEditingBeginHandler:(void (^)(__kindof UITextField *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventEditingDidBegin, handler);
}

- (void)ax_addEditingChangedHandler:(void (^)(__kindof UITextField *sender))handler{
    // add a control events to target
    bindAction(self, UIControlEventEditingChanged, handler);
}

- (void)ax_addEditingEndOnExitHandler:(void (^)(__kindof UITextField *sender))handler{
    // resign first responder
    [self resignFirstResponder];
    // add a control events to target
    bindAction(self, UIControlEventEditingDidEndOnExit, handler);
}

- (void)ax_addEditingEndHandler:(void (^)(__kindof UITextField *sender))handler{
    // resign first responder
    [self ax_addEditingEndOnExitHandler:^(__kindof UITextField * _Nonnull sender) {
        // do nothing
    }];
    // add a control events to target
    bindAction(self, UIControlEventEditingDidEnd, handler);
}

@end




