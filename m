Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3225C66E661
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 19:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjAQSrb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 13:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjAQSiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 13:38:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C3728C
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 10:11:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so31477207wrb.11
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 10:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuB0/1oIZU7naJsrCvEPte3S8NGjCSc48/6v7Yv614o=;
        b=F1AJutEnIGzlzqZ91dn2z6HCPCt1BqwQ+wDKHaXfyADSarcYTWIihGnxbAFKlT1khN
         lYA/q6jfDmH/2KiHyMSR2w9vJwzKtt7+YqL041yvo5Ja+LOtedjm2TLvFg1vPQarD9Xw
         rDwqpi2gE+UcR95HLk2fFOZZzpZyHyXZYO4HNcNzb70u7LW0LrVbRDVyvP4BFumKqZgT
         piMCZf/iKW4U3D224tNtl57LG+0PJWaqrj0AKQMOp8DKhBT7lNXuXbbiUEZ6KS3MGjdq
         fxdfWLA0M2NbAvE1oApiZCcpF4h26pkg/fBwI55IqpNMf+l0BBweCHBvt2DCYxBRCcgk
         Az9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuB0/1oIZU7naJsrCvEPte3S8NGjCSc48/6v7Yv614o=;
        b=Vev3QN36EfBpC8/dA6Zxn7qLEZOrd93TdAEBvKDgA4h2ggsnhBnVLsaNKVaaNIfxjP
         ba7K9cBSAC0w+S9ANg52IIKseT0Asm+qUWwlsQgXmRtV4wvTR1FrX/lQVlYu8JvdeJQu
         NDvp2LuFD63VKcaEf7WhNYzpNj4nyqmIITXoonhjNomMqDrwKPa6GNXR8T6tqDZfqFWP
         qmK7trAcFntx6gKfrqWxhoL/2tK3Z9VBMKWmxSHga3ahSgpwRnfQOgUdvAGcNay7gt5B
         kd3t/brfQ/D0uJ9cdBTzaLR3AR797KobK4cXJSQG82seEZXJzd5VWov3GHfmiTnTNF3W
         MrqQ==
X-Gm-Message-State: AFqh2ko1k02nLDVRPmv47GW1OB+h/OtW155N8MoXPLfwI8aoPaR5F/Kf
        2224M5Wc/BiVnhQlO1ij1N/6iw==
X-Google-Smtp-Source: AMrXdXtLQ9Mo0FGP5+jiuuFnCFH4rp8V/fgLMDAfyBHmQ4/rpo5mUT7wGskX5hjlQVEZNE+7jGw4lg==
X-Received: by 2002:adf:f612:0:b0:2bb:dc9f:b241 with SMTP id t18-20020adff612000000b002bbdc9fb241mr3900834wrp.9.1673979075508;
        Tue, 17 Jan 2023 10:11:15 -0800 (PST)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b002bdf5832843sm8501445wrm.66.2023.01.17.10.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 10:11:15 -0800 (PST)
Message-ID: <26cc4bea-1e0b-2d41-fbf3-aae3ab6dfcfe@linaro.org>
Date:   Tue, 17 Jan 2023 18:11:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
 <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
 <24afe142-f835-29af-fca6-d00e864b0c82@huawei.com>
 <20230117043653.4n2dfruh36x4uazj@vireshk-i7>
 <CAJZ5v0ihaNHneyRwd8nWYUhGKGRpHrVFi7gJsp_g9MX=oLc9Eg@mail.gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAJZ5v0ihaNHneyRwd8nWYUhGKGRpHrVFi7gJsp_g9MX=oLc9Eg@mail.gmail.com>
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



On 17/01/2023 13:39, Rafael J. Wysocki wrote:
> On Tue, Jan 17, 2023 at 5:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 16-01-23, 20:38, Yang Yingliang wrote:
>>> The 'cdev' will be freed after calling put_device(), it can not be accessed
>>> anymore.
>>
>> I surely missed the class's release callback :(
>>
>> How about this then, it clears this in a better way, i.e. what entity
>> is responsible for what exactly. This can be divided in a few patches
>> for sure.
> 
> It looks good to me, but then I haven't caught the release bug too.

it's a fun one:

https://lore.kernel.org/linux-pm/20230101174342.58351-1-caleb.connolly@linaro.org/

I don't see any issues with this suggested patch, however I don't think
I could comfortably attach my SoB to it given the larger code reordering
and my complete lack of experience with this subsystem.

Would a Tested-by be acceptable?
> 
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index f17ab2316dbd..5555bf827a0f 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -774,6 +774,9 @@ static void thermal_release(struct device *dev)
>>         } else if (!strncmp(dev_name(dev), "cooling_device",
>>                             sizeof("cooling_device") - 1)) {
>>                 cdev = to_cooling_device(dev);
>> +               thermal_cooling_device_destroy_sysfs(cdev);
>> +               kfree(cdev->type);
>> +               ida_free(&thermal_cdev_ida, cdev->id);
>>                 kfree(cdev);
>>         }
>>  }
>> @@ -910,17 +913,18 @@ __thermal_cooling_device_register(struct device_node *np,
>>
>>         ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
>>         if (ret)
>> -               goto out_kfree_type;
>> +               goto out_cdev_type;
>>
>>         thermal_cooling_device_setup_sysfs(cdev);
>>         ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>> +       if (ret)
>> +               goto out_cooling_dev;
>> +       ret = device_register(&cdev->device);
>>         if (ret) {
>> -               thermal_cooling_device_destroy_sysfs(cdev);
>> -               goto out_kfree_type;
>> +               /* thermal_release() handles rest of the cleanup */
>> +               put_device(&cdev->device);
>> +               return ret;
>>         }
>> -       ret = device_register(&cdev->device);
>> -       if (ret)
>> -               goto out_kfree_type;
>>
>>         /* Add 'this' new cdev to the global cdev list */
>>         mutex_lock(&thermal_list_lock);
>> @@ -939,11 +943,10 @@ __thermal_cooling_device_register(struct device_node *np,
>>
>>         return cdev;
>>
>> -out_kfree_type:
>> +out_cooling_dev:
>>         thermal_cooling_device_destroy_sysfs(cdev);
>> +out_cdev_type:
>>         kfree(cdev->type);
>> -       put_device(&cdev->device);
>> -       cdev = NULL;
>>  out_ida_remove:
>>         ida_free(&thermal_cdev_ida, id);
>>  out_kfree_cdev:
>> @@ -1104,11 +1107,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>>
>>         mutex_unlock(&thermal_list_lock);
>>
>> -       ida_free(&thermal_cdev_ida, cdev->id);
>> -       device_del(&cdev->device);
>> -       thermal_cooling_device_destroy_sysfs(cdev);
>> -       kfree(cdev->type);
>> -       put_device(&cdev->device);
>> +       device_unregister(&cdev->device);
>>  }
>>  EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>>
>> --
>> viresh

-- 
Kind Regards,
Caleb (they/them)
