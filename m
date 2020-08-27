Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA8253DAE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0G0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 02:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgH0G0u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 02:26:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F4C061260
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 23:26:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so2599331pgl.11
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 23:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YNHyAuR7GB3EfiCouUkXKnHb9Hzrnqg6mjMpHBgNiO8=;
        b=c7RsnWL2XAhTx7DSd2Pafooc6DvgnJ2jSwpvJHQhuxQ+30JZQ3lZ7R78LrzdmkmoZ+
         mgtyt4+05RvlXNm5faEyrtJe7n7P9B1VYa4sch/ht6IAYDMogrykF50nGFbl3gh7u609
         5Z9tasKQ2aj1JEgOWF1l/5PMrvg1rgN7Ni4sVw/YWReBzYqLGCiXiALOZV9BmD4WWLKC
         /KQHUX8o+J+DhwCWNku/hJ/FB09sGWIaTIzrTLEba18Dqpt+Lvc74/DaJIeL3Cx8Mom5
         pdHIm5ykyAdQjQ6LEKBd24/g3QdjVRa/E5itZi6+Nnmz4EMpTXiZv3aJmzE049xltd8z
         YUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YNHyAuR7GB3EfiCouUkXKnHb9Hzrnqg6mjMpHBgNiO8=;
        b=GTAeRjrUNRQOAZm5O8VTbgHwxLcMUQJSazPwIXE0lPKYeOT2TnMJ8hLlEMntIy7/Dl
         rnBcO6ebZSmQdnufVPmICGG58xxA2Ul2lpuLg6J/bJboVAJFL0VI+r1tR/gzy5on4Q+q
         jwBsFkVcUQs0uQQWbgbAZfbSePHuSrxGyY3bNwh5v6AICUvNTRa9UTwYeZeOjJWAjojD
         cd9iXhzSM0BqztyN3emGkOCw/zkIZDogOaXQXLKZJumuid1d3ieK9SVytjELMmDJPFS1
         1kahbVClR0klHCjt6ao+PIjTFJNcX84fKi66fdY/XaZK9FeFhK+GD1uOhs/fZ2nT3Lok
         aR/g==
X-Gm-Message-State: AOAM532GRTLAT/b3RCBnlU02W16GPzimYL6vZvn4GHe9P5yVbLJMGZ4s
        rgxFOB/Z5Fx24apWwGj25flvuA==
X-Google-Smtp-Source: ABdhPJy6oNZf/4jPilo5d2a1xo9dBeE04Aa29ksfbQDk9Sq8XqX5IklGaZ3ChV7cRwosSpvmM3Ue1w==
X-Received: by 2002:a62:a10f:: with SMTP id b15mr15494230pff.253.1598509609722;
        Wed, 26 Aug 2020 23:26:49 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id z1sm1322747pff.178.2020.08.26.23.26.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 23:26:48 -0700 (PDT)
Date:   Thu, 27 Aug 2020 11:56:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rafael.j.wysocki@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling
 device's statistics
Message-ID: <20200827062646.adruzyyqq5uzlteq@vireshk-i7>
References: <20200818063005.13828-1-zbestahu@gmail.com>
 <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
 <20200826101319.00003048.zbestahu@gmail.com>
 <c3fd7949-b33a-aca3-8dd5-1c2df35fb63d@linaro.org>
 <20200827120327.00003740.zbestahu@gmail.com>
 <20200827051401.yryitpgq2gi3nkbh@vireshk-i7>
 <20200827142003.000071c1.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827142003.000071c1.zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-20, 14:20, Yue Hu wrote:
> Currenly, drivers/video/backlight does not call thermal_of_cooling_device_register()
> to register thermal cooling device. The issue happened in msm-4.19 kernel for
> QCOM/Android platform. Backlight in msm-4.19 kernel will register thermal cooling
> device as below:
> 
> +static int bd_cdev_get_max_brightness(struct thermal_cooling_device *cdev,
> +                                 unsigned long *state)
> +{
> + struct backlight_device *bd = (struct backlight_device *)cdev->devdata;
> +
> + *state = bd->props.max_brightness;
> +
> + return 0;
> +}
> 
> 
> +static struct thermal_cooling_device_ops bd_cdev_ops = {
> + .get_max_state = bd_cdev_get_max_brightness,
> 
> +static void backlight_cdev_register(struct device *parent,
> +                             struct backlight_device *bd)
> +{
> + if (of_find_property(parent->of_node, "#cooling-cells", NULL)) {
> +         bd->cdev = thermal_of_cooling_device_register(parent->of_node,
> +                         (char *)dev_name(&bd->dev), bd, &bd_cdev_ops);
> 
> And the bd->props.max_brightness is getting from video/backlight/qcom-wled.c. Maybe
> the driver should not assign 1024 to states/max_brightness. I'm not sure about it.
> So i consider to change memory allocation methord. That's the origin of the patch.

Thanks for the details. So this is not about upstream tree, as a rule
we aren't going to make changes here for any downstream tree.

Now coming back to the downstream driver, I also don't see a point in
returning bd->props.max_brightness as the max number of states there.
Maybe have 10 states, each occupying bd->props.max_brightness/10
brightness and so you will end up with 10 states only. But yeah,
whatever downstream decides on that.

-- 
viresh
