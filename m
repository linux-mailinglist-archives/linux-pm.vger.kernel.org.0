Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E49253D9B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgH0GUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 02:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgH0GUB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 02:20:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD3C06125E;
        Wed, 26 Aug 2020 23:20:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g6so2066370pjl.0;
        Wed, 26 Aug 2020 23:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DyhFZJ3L50RHCjnfyOFFSA1C8Bx+09mqhOcCqewIw0=;
        b=gBs5DsGVImY9h2NdkLBA8VAbLClDmYf5k2JzfxV4NQDIUkz5iE220JF3pbKR+IKQFK
         XEK8sV8YVio9/4ea8Kfz265u4SGZdsJ+SMCKBEMy9lskCqqCV5DHsDaury2NC+f08Nd6
         KCGYFjOFxHXZ+XzAcQyGjZsyDSfjMgL9yt23ODOP3CnLG54e5PXWusKtBta6yR/1vBGK
         6Q6fwPpgntt4QCeUPMufE4aTAidoXLekUL8434j9w4xOoz22S5FFaj4cNeFhPPmB3c2E
         LlUoBJjDV8K/g5JKVrhglMLbhDRwCQzkHBwo6Hx5tEUWyyD0Jitw7a+VGFJSo/I82FK/
         cf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DyhFZJ3L50RHCjnfyOFFSA1C8Bx+09mqhOcCqewIw0=;
        b=fvxoBQKFXrH1ZFvUcimaPL2nxJlots+PqgahwtwXR6bJ7eYUtY5yzzinFV9uSuUu2C
         PZbnf3+ix/XyuSniBafS4enrhthwIDSHGqDzTzsBiz85j3Ktko2zy2fUL99+Gi+nWdDm
         zywU8jeZk6OtyjlrxFxRTj0ts4/qf3uBtEan+6Uwxreo3pxlI/5/9YiLNIyWm2rZOqdi
         3fV2JYTmMdhnZXlmuSyTx/ZndJWbUQMb4OlH24Zjgo5ARdRBKUWMBP8GHi8w0Q6UcMXG
         N15z4MqeQLx51tcK4qZ3glZAMu6F1ydKIcNcHE/Vi1rPUdSFzmePGuJBP7dB27SQ/dlC
         yfiA==
X-Gm-Message-State: AOAM530AwzRGcefqWiquH5fGYC8fBNdTQf6kc5t/C1h1poM1OV3X3mT8
        YTRh9Hsd4dmrZ0NQ2t3NwnA=
X-Google-Smtp-Source: ABdhPJwGY57wBq9Nl0yoEK8w45h6104ykZ45Oyp8862f/UAYES7K8QKJ582f8eTRHoNYGRoft3kYFw==
X-Received: by 2002:a17:90b:fd8:: with SMTP id gd24mr4569589pjb.234.1598509200731;
        Wed, 26 Aug 2020 23:20:00 -0700 (PDT)
Received: from localhost ([124.156.176.71])
        by smtp.gmail.com with ESMTPSA id h65sm1269103pfb.210.2020.08.26.23.19.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 23:20:00 -0700 (PDT)
Date:   Thu, 27 Aug 2020 14:20:03 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rafael.j.wysocki@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling
 device's statistics
Message-ID: <20200827142003.000071c1.zbestahu@gmail.com>
In-Reply-To: <20200827051401.yryitpgq2gi3nkbh@vireshk-i7>
References: <20200818063005.13828-1-zbestahu@gmail.com>
        <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
        <20200826101319.00003048.zbestahu@gmail.com>
        <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
        <20200827120327.00003740.zbestahu@gmail.com>
        <20200827051401.yryitpgq2gi3nkbh@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 27 Aug 2020 10:44:01 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 27-08-20, 12:03, Yue Hu wrote:
> > Hi Daniel,
> > 
> > Now, i'm just focus on removing the kernel warning based on current code logic.
> > Commit 8ea229511e06 (thermal: Add cooling device's statistics in sysfs) added
> > the thermal statistics by viresh and viresh gived the patch an acknowledgement
> > in anther mail thread. 
> > 
> > Hi viresh,
> > 
> > Could you review the patch again about the question above?  
> 
> Yeah, I Acked it but the questions raised by Daniel are very valid and must be
> answered.

Yes, sure.

> 
> I understand that you only cared about fixing the warning, but maybe we need to
> fix the driver and the warning will go away by itself. If you don't want to do
> it, then someone who is responsible for the driver should do it.

Yes, maybe the patch is not totally correct. maybe the driver has issue. Let's
check the driver firstly.

> 
> Was it the acpi_video.c driver that you got the warning from ? I have added
> Rafael to the email in case that driver needs getting fixed.
> 

Currenly, drivers/video/backlight does not call thermal_of_cooling_device_register()
to register thermal cooling device. The issue happened in msm-4.19 kernel for
QCOM/Android platform. Backlight in msm-4.19 kernel will register thermal cooling
device as below:

+static int bd_cdev_get_max_brightness(struct thermal_cooling_device *cdev,
+                                 unsigned long *state)
+{
+ struct backlight_device *bd = (struct backlight_device *)cdev->devdata;
+
+ *state = bd->props.max_brightness;
+
+ return 0;
+}


+static struct thermal_cooling_device_ops bd_cdev_ops = {
+ .get_max_state = bd_cdev_get_max_brightness,

+static void backlight_cdev_register(struct device *parent,
+                             struct backlight_device *bd)
+{
+ if (of_find_property(parent->of_node, "#cooling-cells", NULL)) {
+         bd->cdev = thermal_of_cooling_device_register(parent->of_node,
+                         (char *)dev_name(&bd->dev), bd, &bd_cdev_ops);

And the bd->props.max_brightness is getting from video/backlight/qcom-wled.c. Maybe
the driver should not assign 1024 to states/max_brightness. I'm not sure about it.
So i consider to change memory allocation methord. That's the origin of the patch.

Thank you.

