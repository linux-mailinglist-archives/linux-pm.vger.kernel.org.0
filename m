Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2634066BDB8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jan 2023 13:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjAPMWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Jan 2023 07:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjAPMWG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2023 07:22:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A651CF62
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 04:22:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r2so27300933wrv.7
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 04:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9Bkn9WI8q6+pAxoy+xAiQNIepCm3W6uVuVrE3UYNZQ=;
        b=lekGrZlRjmKjbdyvvXNFLZ3U5rdlbWsZav68sznHij/C81/RenCFdAA0dGLHD0Mn84
         bZF+X28iW4LsJKpE3k+wWO8LqDllWDuRd8avgVU1Wuay87+YYb1cgA5nSnyATDn8bvTz
         hUD+YaHdUfMG0Y97LsGuJMVTRhQ3scR4F5fc1ppuIoTRGiro5Kz1//ZAigMMl1r1ntCl
         /lCKUWNdpKR19JwXonST0kTZFi9diqxPIRifc/cGJ7k2BEft+vLhqlVATIPipmOXnh14
         gxTyP/oM7HmXxQrMxmM2NFQIENWNXM7EdY0chuLES/jsjU3HtfQnpA0IV5Z64GRZk9bC
         e8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Bkn9WI8q6+pAxoy+xAiQNIepCm3W6uVuVrE3UYNZQ=;
        b=hadvogsv8wrCmu/9XZGnIGAn1OKMT/AH5MEs9F1UOANY/EZooDn6pPEoYJG5hxPgT2
         JPVMgy8nTaaR3lNOrlWchjIavIWdL32NUh1rJ5mMPT3Gziqv6bsKItxn+qADyyEq//KI
         4Wo4fkA6gkvn5jQBEEsWusCdhE1k7CeW5uZDVMpQrLxTPWlU5CWAXM2Qc8GYRRV84oLI
         i5ULbcUV+U7xMc4ZFNMmP7cLW3ylRTggGZ8jd2Noza85bbYsB8rTirulorv8rKpy/svd
         kvSAmo2fv/IaJwZf5NMsdc+MdSP8J4UkqMWEP6PaHPCatKcnr673GZ6jjGotiNPtu57N
         XRMw==
X-Gm-Message-State: AFqh2kovna3XzJUdgl60G4GQyuuOKUY+7pELzdMQ1g9UH2DlrH/byAzj
        sPD3a/SUu3yId6qefj7tqV3gZw==
X-Google-Smtp-Source: AMrXdXvptQgl5pBXTlYYwhYZ3YEAkMFtiK5IwtdgyeBnll3CYaeCorBo7Faew8Wr2QR3Eldt+ovm7g==
X-Received: by 2002:adf:ec09:0:b0:2bd:dbbb:e7e2 with SMTP id x9-20020adfec09000000b002bddbbbe7e2mr10119552wrn.60.1673871723385;
        Mon, 16 Jan 2023 04:22:03 -0800 (PST)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6d49000000b002bc8130cca7sm18189571wri.23.2023.01.16.04.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 04:22:03 -0800 (PST)
Message-ID: <45cf54c0-2a77-c06a-b81a-823514f7c5e1@linaro.org>
Date:   Mon, 16 Jan 2023 12:22:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
 <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 16/01/2023 04:23, Viresh Kumar wrote:
> On 12-01-23, 15:47, Caleb Connolly wrote:
>> There is in invalid call to thermal_cooling_device_destroy_sysfs() and
>> another to put_device() in the error paths here. Fix them.
>>
>> Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> Changes since v2:
>>  * Rework and simplify into one patch following Yang's suggestions.
>>
>> V2: https://lore.kernel.org/all/20230103171811.204196-1-caleb.connolly@linaro.org/
>> ---
>>  drivers/thermal/thermal_core.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> Replied to an earlier version by mistake. Should it be like this ?

apologies for all the subject rewording.

I'm not 100% clear on the benefits/drawbacks to the different
approaches, am I right in thinking the improvement here (compared to my
patch) is in giving each error condition it's own path so there isn't
any ambiguity?
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..18db011d4d68 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -910,17 +910,15 @@ __thermal_cooling_device_register(struct device_node *np,
> 
>         ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
>         if (ret)
> -               goto out_kfree_type;
> +               goto out_cdev_type;
> 
>         thermal_cooling_device_setup_sysfs(cdev);
>         ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> -       if (ret) {
> -               thermal_cooling_device_destroy_sysfs(cdev);
> -               goto out_kfree_type;
> -       }
> +       if (ret)
> +               goto out_cooling_dev;
>         ret = device_register(&cdev->device);
>         if (ret)
> -               goto out_kfree_type;
> +               goto out_put_device;
> 
>         /* Add 'this' new cdev to the global cdev list */
>         mutex_lock(&thermal_list_lock);
> @@ -939,11 +937,12 @@ __thermal_cooling_device_register(struct device_node *np,
> 
>         return cdev;
> 
> -out_kfree_type:
> +out_put_device:
> +       put_device(&cdev->device);
> +out_cooling_dev:
>         thermal_cooling_device_destroy_sysfs(cdev);
> +out_cdev_type:
As far as I can tell this is give or take the same as the two patches I
had in v2 [1]?
>         kfree(cdev->type);
> -       put_device(&cdev->device);
> -       cdev = NULL;
Is removing the explicit null assignment here intentional?

>  out_ida_remove:
>         ida_free(&thermal_cdev_ida, id);
>  out_kfree_cdev:
> 

I'm happy to go ahead an submit a v4 based on this.

[1]:
https://lore.kernel.org/all/20230103171811.204196-1-caleb.connolly@linaro.org/

-- 
Kind Regards,
Caleb (they/them)
