Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF42247B46
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 01:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgHQXyy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 19:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHQXyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 19:54:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328BCC061389;
        Mon, 17 Aug 2020 16:54:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so19411839ljj.4;
        Mon, 17 Aug 2020 16:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B9j2rJAHaH9GTstMqd8/V24VpPo4i+kvnYjj1zy9ZbI=;
        b=Ba0QocY5V2Cd3RBKfnPOqKJ4d72b31eSRlJVZOdcE9KUxaSrswBjhU2oeUhrMwR+6k
         8y+dWmCcIeoK6bNopJIritd5RhYLiqo+89fLH6w+BDRXaMskbTTmxV0W2bZjdsBYI0a/
         mSO2sYx0ZSa6oT/yuCBpA/qjLzEOXHrP6NNYOxduO5dW8FxN9Oqv/ayMrmwYWjOLtgpW
         5L2JuBe/UDmRMeEASOb7fsbsPKNpohZGnMF8XcR2o11vG7igCRo158mnNXm06HbkTtpn
         /nHHzDC2mdyeZ7NOViIfnmSe1rY9eFb62PC++Q385GTAt8jxvLp/7CeF12jXCB7JLepF
         DxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B9j2rJAHaH9GTstMqd8/V24VpPo4i+kvnYjj1zy9ZbI=;
        b=RslBCGgz1HpMrlI4L88Gs/Va9sdLHSO2FxxT4z2RAp1Rd69QbMlzDxM0+E0Eu3/srL
         yD3AW6NMHv85lseJEMV4zYsUsWHe0la/rsHZDLCVzMzC0uwViPaZpBnuXd+gMoP/j3KM
         SIDV6VjN1hw1NbKvBT5aBPyKhhxTvcor/syKyB9fn/2tjpc+rlcD0z0v1xFW37C1j246
         xr1sQHsm5VFC10+hw2+jtw7zDIp5frhtVid4KcRDegyut3WKVcmn7WHgPjrW5FeH/W0G
         U23pvupSrszHqoTPaqJUUvS2hDmegONol09+MF+5ckrD71gtphklpB4anPHi72UVpWRN
         lJSg==
X-Gm-Message-State: AOAM5321n8J3+AFr2gFzFJXzqyCXjWvRGVIPdO2IfGM5SOQMncoz3gai
        nrwncgPmQXTHjQgCPU93jGRO4x+Vtq8=
X-Google-Smtp-Source: ABdhPJyMEB4dK3y0hsRbrHMeMEPHnBoUtbd2/FAQY/4ShbzfhGpwv0eXn2rhIPoUcrK5lhbuV5putg==
X-Received: by 2002:a2e:9908:: with SMTP id v8mr8455202lji.410.1597708491489;
        Mon, 17 Aug 2020 16:54:51 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id j6sm5920963lfp.44.2020.08.17.16.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 16:54:50 -0700 (PDT)
Subject: Re: [PATCH v1] thermal: core: Fix use-after-free in
 thermal_zone_device_unregister()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200817234833.23954-1-digetx@gmail.com>
Message-ID: <60ffd8e3-ca65-d0ff-4a7a-067923fc5ddd@gmail.com>
Date:   Tue, 18 Aug 2020 02:54:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817234833.23954-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.08.2020 02:48, Dmitry Osipenko пишет:
> The user-after-free bug in thermal_zone_device_unregister() is reported by
> KASAN. It happens because struct thermal_zone_device is released during of
> device_unregister() invocation, and hence the "tz" variable shouldn't be
> touched by thermal_notify_tz_delete(tz->id).
> 
> Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/thermal/thermal_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 72bf159bcecc..56c355f684df 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1516,7 +1516,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register);
>   */
>  void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  {
> -	int i;
> +	int i, tz_id;
>  	const struct thermal_zone_params *tzp;
>  	struct thermal_cooling_device *cdev;
>  	struct thermal_zone_device *pos = NULL;
> @@ -1525,6 +1525,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  		return;
>  
>  	tzp = tz->tzp;
> +	tz_id = tz->id;
>  
>  	mutex_lock(&thermal_list_lock);
>  	list_for_each_entry(pos, &thermal_tz_list, node)
> @@ -1560,14 +1561,13 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  	cancel_delayed_work_sync(&tz->poll_queue);
>  
>  	thermal_set_governor(tz, NULL);
> -

Woops, this line wasn't intended to be removed. Let me send a v2.

>  	thermal_remove_hwmon_sysfs(tz);
>  	ida_simple_remove(&thermal_tz_ida, tz->id);
>  	ida_destroy(&tz->ida);
>  	mutex_destroy(&tz->lock);
>  	device_unregister(&tz->device);
>  
> -	thermal_notify_tz_delete(tz->id);
> +	thermal_notify_tz_delete(tz_id);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>  
> 

