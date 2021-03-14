Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8409733A441
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 11:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhCNKtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhCNKs5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 06:48:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B1C061574
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 03:48:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x16so4165902wrn.4
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A3yM0E2XIIeHhpwSsShTH8f57YtVpUZzWbcZcvUk0cc=;
        b=pdx2zG07Ivkui/nQ7jBCP+23ASSB2fnCc+vt+2JsM1t2Vgl/TWPbh5allOMrITOLVP
         C7VGHUxbIg42pGUQsCbtZux7kOIFOZUsMaf6AoczHbdOkWhKxQ7NEL30VAzeTtq9v/yG
         BHbVFl37j6bCV9zAtqRE8ieUzeQEFZXYM3rDoHRUSo+xxHEnZGmLsOpZKf4bfAF++Pvq
         +gEiVSKe377nsa6Lr3DxGO/YU4Esl9qnLTd4Xt5T4+o0dBwhT0VtkU9NW/o8gk7C8LZP
         0S/LiHEjpOmJI/4BIsk6oFPxrBEOqyv/DQfydenSSqBoC1ySgw22J9/5FvX1z975ogqc
         Dwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3yM0E2XIIeHhpwSsShTH8f57YtVpUZzWbcZcvUk0cc=;
        b=q7hhcVB9Z4nJ/RnXWFP4ewFFqaUR5RkQVR8MTFwdIQfE264MT1GXAjzxRQmfkdtcQv
         Y6JIBRhp9jBylqI7aPif2ScYnpWK9MJ7w7KSw0m90D5Eek4KX9Swb+AB444BtSASqFe4
         9zjDhIj9gPyMS7WxFuCLSsGPcFfLnPQ3yr8s8603VbllrP0lxBidkz4R6XQMGPVZfeg9
         m7fHOENr/bfe9QozQHWfTn9obtNBBJCfjGObj8XZpOAhmmK7oUh0R/SWev+P23D3W3hJ
         8dG/oGUJ8COVQTbcy5ssgKQAdiBJKHuD82eEfhqfoXTj050r9XGOysd+SAaXWm6J4xQh
         V/Vg==
X-Gm-Message-State: AOAM533N4vK8WIIojhZSC5eF68JtqerkIXNSB0qjl7pDuls0K2I2wYl3
        xC9eXCYVPaT2lbJsOgDAPTr96w==
X-Google-Smtp-Source: ABdhPJxO8AnD0OFEBp/F/EJSgQl90d9XEpEQ5+VL6JbW6iyuR3wYJ0lz4RCYVItN/ay1Czl6qu1e+g==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr22900596wrn.349.1615718935094;
        Sun, 14 Mar 2021 03:48:55 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1ed:80a3:b8d6:f6d3? ([2a01:e34:ed2f:f020:1ed:80a3:b8d6:f6d3])
        by smtp.googlemail.com with ESMTPSA id f14sm9019461wmf.7.2021.03.14.03.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 03:48:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] thermal/drivers/core: Use a char pointer for the
 cooling device name
To:     Ido Schimmel <idosch@idosch.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Jiri Pirko <jiri@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:MELLANOX ETHERNET SWITCH DRIVERS" <netdev@vger.kernel.org>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
 <YE3dMM7tqk5BbD/l@shredder.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f4d7d072-2c4f-2d9d-8628-0c8c83b76f4d@linaro.org>
Date:   Sun, 14 Mar 2021 11:48:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YE3dMM7tqk5BbD/l@shredder.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Ido,

On 14/03/2021 10:53, Ido Schimmel wrote:
> On Fri, Mar 12, 2021 at 06:03:12PM +0100, Daniel Lezcano wrote:
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 996c038f83a4..9ef8090eb645 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -960,10 +960,7 @@ __thermal_cooling_device_register(struct device_node *np,

[ ... ]

>>  /**
>> @@ -1172,6 +1177,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>>  	device_del(&cdev->device);
>>  	thermal_cooling_device_destroy_sysfs(cdev);
>>  	put_device(&cdev->device);
>> +	kfree(cdev->type);
>>  }
>>  EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
> 
> I'm getting the following user-after-free with this patch [1]. Fixed by:
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9ef8090eb645..c8d4010940ef 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1176,8 +1176,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>         ida_simple_remove(&thermal_cdev_ida, cdev->id);
>         device_del(&cdev->device);
>         thermal_cooling_device_destroy_sysfs(cdev);
> -       put_device(&cdev->device);
>         kfree(cdev->type);
> +       put_device(&cdev->device);

Indeed 'thermal_release' frees the cdev pointer and is called by
put_device, then kfree use the pointer right after.

Thanks for the fix

  -- Daniel




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
