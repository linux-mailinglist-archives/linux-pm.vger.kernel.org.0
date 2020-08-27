Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF852253DF5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 08:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgH0GkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 02:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0GkL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 02:40:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B489C061263;
        Wed, 26 Aug 2020 23:40:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d19so2634172pgl.10;
        Wed, 26 Aug 2020 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGkIPkY7/Tr/n+KRhzB9iJ20Ouni7SAtUbHMAKz35wI=;
        b=QqH/zx43d2rOZerZHqtZMr0OSasSdneyzqwJa7nTSebiJ6jXPcp0TFCoaPtDwFoj9B
         TrZv4WoSbbFulbWUG3FSZupMWPiPDDe6UY+U4MeanKPN90dvzx/jBt7/LYRbPIayhhrp
         j8Cq2B44q5ZRvcLaholdJJUe5SAb2B9DCMFs9xe59RBX8PRJByLsLDdaOKxc4jUiD29m
         QlnMuexn934jkeAYw6mg7HO1Up7XcTQ626AICKEfTnH2PiTsApk+yjoYtGFXh5ZpYHv4
         ccCj9WMHPjUjMRxpKJpnlU75UgBYE56kdU+cgPivhtq8b68zSHWaM86x9Pimab6m6a0J
         Pu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGkIPkY7/Tr/n+KRhzB9iJ20Ouni7SAtUbHMAKz35wI=;
        b=ZCfp1/jQp4TOrlEmJ9Au7zQ+VsUYiheNr2SZu4isM5SHGTzXkFBEMbucM1vk4E6feg
         Ji3JJyl61eXSf3Ul13nUr9px95YDWTxavTsIlgSkwbZUfB18YO7R2FuyayrURjAFNyKj
         9o6+lKXhd9lO7M/VAjKR56JLuF0IWowvw8+1qTXMk8I8oh9ypBwSt3ejGkkf3kw4dgtx
         6vFJiB/d7g9IIpN+nk4rTzAtndjqFwyJaJ45+jDy3KntOK0ch8AheT5zX4+Y7q/ntgnV
         1jXr9LUJUrv6RRNiNJlB+2jp6uUIv0z3DWkctolskla0beptsizl00uXIEtdwymIzMBv
         fgvQ==
X-Gm-Message-State: AOAM5326Tvlm6ucRzaSLCSljRXklTTC+9D968YrPfILScMuo0iQZSJoi
        80jX4kUYI7nIXvrbv14mL4Q=
X-Google-Smtp-Source: ABdhPJzQtgYzuS98QoVEnuOTvC5luZC8+B5zrYxKkEtmHPR6yUALmNwc1xBoVigfmnWDJJlOIkl4qg==
X-Received: by 2002:a63:e245:: with SMTP id y5mr13294914pgj.51.1598510410118;
        Wed, 26 Aug 2020 23:40:10 -0700 (PDT)
Received: from localhost ([124.156.176.71])
        by smtp.gmail.com with ESMTPSA id c3sm1430751pfd.137.2020.08.26.23.40.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 23:40:09 -0700 (PDT)
Date:   Thu, 27 Aug 2020 14:40:13 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rafael.j.wysocki@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling
 device's statistics
Message-ID: <20200827144013.00004e01.zbestahu@gmail.com>
In-Reply-To: <20200827062646.adruzyyqq5uzlteq@vireshk-i7>
References: <20200818063005.13828-1-zbestahu@gmail.com>
        <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
        <20200826101319.00003048.zbestahu@gmail.com>
        <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
        <20200827120327.00003740.zbestahu@gmail.com>
        <20200827051401.yryitpgq2gi3nkbh@vireshk-i7>
        <20200827142003.000071c1.zbestahu@gmail.com>
        <20200827062646.adruzyyqq5uzlteq@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 27 Aug 2020 11:56:46 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 27-08-20, 14:20, Yue Hu wrote:
> > Currenly, drivers/video/backlight does not call thermal_of_cooling_device_register()
> > to register thermal cooling device. The issue happened in msm-4.19 kernel for
> > QCOM/Android platform. Backlight in msm-4.19 kernel will register thermal cooling
> > device as below:
> > 
> > +static int bd_cdev_get_max_brightness(struct thermal_cooling_device *cdev,
> > +                                 unsigned long *state)
> > +{
> > + struct backlight_device *bd = (struct backlight_device *)cdev->devdata;
> > +
> > + *state = bd->props.max_brightness;
> > +
> > + return 0;
> > +}
> > 
> > 
> > +static struct thermal_cooling_device_ops bd_cdev_ops = {
> > + .get_max_state = bd_cdev_get_max_brightness,
> > 
> > +static void backlight_cdev_register(struct device *parent,
> > +                             struct backlight_device *bd)
> > +{
> > + if (of_find_property(parent->of_node, "#cooling-cells", NULL)) {
> > +         bd->cdev = thermal_of_cooling_device_register(parent->of_node,
> > +                         (char *)dev_name(&bd->dev), bd, &bd_cdev_ops);
> > 
> > And the bd->props.max_brightness is getting from video/backlight/qcom-wled.c. Maybe
> > the driver should not assign 1024 to states/max_brightness. I'm not sure about it.
> > So i consider to change memory allocation methord. That's the origin of the patch.  
> 
> Thanks for the details. So this is not about upstream tree, as a rule
> we aren't going to make changes here for any downstream tree.

I at first thought it's a possible issue in upstream tree.

> 
> Now coming back to the downstream driver, I also don't see a point in
> returning bd->props.max_brightness as the max number of states there.
> Maybe have 10 states, each occupying bd->props.max_brightness/10
> brightness and so you will end up with 10 states only. But yeah,
> whatever downstream decides on that.
> 

Got it.

Thx.
