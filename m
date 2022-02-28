Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF04C658D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Feb 2022 10:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiB1JTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Feb 2022 04:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiB1JTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Feb 2022 04:19:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70352517FC
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 01:18:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so14321739wrb.6
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 01:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xBnaBUHZiPf/i/GVor2BUnhBpMNuYKQlp76LBNPvktw=;
        b=tAUuZnh7Q/7PVBNFl5bqBPz8uipl74wfKp++VpfCBb6I3TcOWUm+RWRdMw/+NSsDpR
         iO0CwKBTEwGQkGVFAEHOe7CW92jl/yOOY/1RiZfNCyGElC+NuQu7FMFNkrloj5jSxaIb
         xQLs5uEFi+kVehbQ309LGTs1EnkdgYCM7n9Qq4uwEESFSH6ZaiY9JzxWL3viCb5cJR6F
         6HE2dgN4cekvkZQhLH9SzK+GZQzxy8agwQM29L31hQ35G7x49Hr8n+ZAJB596uqRHscS
         /CLlQg7aDn4Rs/ttlMw8xwCR2dl4t8KTOx1jNCkkEIqY4WMUx1+AdGZu/uM4y+irwSxr
         iQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBnaBUHZiPf/i/GVor2BUnhBpMNuYKQlp76LBNPvktw=;
        b=IpaeoXnGYvFKlbbJuU5Pjk5OJ0xvEmLFPjLqbJnFPl8e9J8RGawj8O4SYSbZIWbEoS
         jq0KLU+FINgoYgB4zKHjDWh5V+Cr+TGH11TF5w1RX2xqQv8q1TtSM55lbc7Wn8wsKjgN
         ysqL8D0XvTJE+2SJJPxKiyx2prYcpc8Ift6CceRE8n7NN668eJ66u5t2CLmiC8BLh2i6
         gz8HEQpSz9e40I1NmbNXE/+UmuOS89qHf5FuzPFohBGnXwN19GZssJl4qc9KgYUx0MJj
         oNSbhpoqBgzZ7ujMF1oDEeWMns4j0XnG85FJiqngmP1EjqQXhAwDwYG4+jFM86JJBqjv
         s6Mg==
X-Gm-Message-State: AOAM53280tPCGlra6zBZ2+pvC6/nrL4yasyZYYzZcwgApLlBFVLpu0Vs
        fWD/x3ALBvPsbXlEpoJA1mjqHg==
X-Google-Smtp-Source: ABdhPJyhIOuDwrLOhXqZCbd1kJmuFIcDWggB3nehLm9VOcXw1SVXcysCsHDjHdKed4MmZLMKAJAI3A==
X-Received: by 2002:adf:ec08:0:b0:1ef:d7e1:c70 with SMTP id x8-20020adfec08000000b001efd7e10c70mr2070406wrn.257.1646039914037;
        Mon, 28 Feb 2022 01:18:34 -0800 (PST)
Received: from ?IPV6:2a01:cb05:8f8a:1800:1c97:b8d1:b477:d53f? (2a01cb058f8a18001c97b8d1b477d53f.ipv6.abo.wanadoo.fr. [2a01:cb05:8f8a:1800:1c97:b8d1:b477:d53f])
        by smtp.gmail.com with ESMTPSA id j27-20020adfd21b000000b001e519f3e0d0sm9900265wrh.7.2022.02.28.01.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:18:33 -0800 (PST)
Message-ID: <03877d75-0a4a-3365-7005-9f493d8810cf@smile.fr>
Date:   Mon, 28 Feb 2022 10:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drivers/thermal/ti-soc-thermal: Add hwmon support
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     j-keerthy@ti.com, edubezval@gmail.com
References: <20220218104725.2718904-1-romain.naour@smile.fr>
 <c6b8e5fd-4315-859f-b4a2-a3a055143ddf@linaro.org>
From:   Romain Naour <romain.naour@smile.fr>
In-Reply-To: <c6b8e5fd-4315-859f-b4a2-a3a055143ddf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Le 25/02/2022 à 12:46, Daniel Lezcano a écrit :
> 
> Hi Romain,
> 
> I'll apply the patch.

You're welcome!

> 
> In the future, use the scripts/get_maintainer.pl -f <file> to get the recipients
> of your patch if you have a doubt about who to send it to.

I wasn't sure if it was needed to send the patch to both mailing list.
I was only subscribed to linux-omap until now.

Best regards,
Romain


> 
> Thanks
> 
>   -- Daniel
> 
> On 18/02/2022 11:47, Romain Naour wrote:
>> Expose ti-soc-thermal thermal sensors as HWMON devices.
>>
>>    # sensors
>>    cpu_thermal-virtual-0
>>    Adapter: Virtual device
>>    temp1:        +54.2 C  (crit = +105.0 C)
>>
>>    dspeve_thermal-virtual-0
>>    Adapter: Virtual device
>>    temp1:        +51.4 C  (crit = +105.0 C)
>>
>>    gpu_thermal-virtual-0
>>    Adapter: Virtual device
>>    temp1:        +54.2 C  (crit = +105.0 C)
>>
>>    iva_thermal-virtual-0
>>    Adapter: Virtual device
>>    temp1:        +54.6 C  (crit = +105.0 C)
>>
>>    core_thermal-virtual-0
>>    Adapter: Virtual device
>>    temp1:        +52.6 C  (crit = +105.0 C)
>>
>> Similar to imx_sc_thermal d2bc4dd91da6095a769fdc9bc519d3be7ad5f97a.
>>
>> No need to take care of thermal_remove_hwmon_sysfs() since
>> devm_thermal_add_hwmon_sysfs() (a wrapper around devres) is
>> used. See c7fc403e40b0ea18976a59e968c23439a80809e8.
>>
>> Signed-off-by: Romain Naour <romain.naour@smile.fr>
>> ---
>>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> index f84375865c97..0959632b2170 100644
>> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
>> @@ -21,6 +21,7 @@
>>     #include "ti-thermal.h"
>>   #include "ti-bandgap.h"
>> +#include "../thermal_hwmon.h"
>>     /* common data structures */
>>   struct ti_thermal_data {
>> @@ -189,6 +190,9 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>>       ti_bandgap_set_sensor_data(bgp, id, data);
>>       ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
>>   +    if (devm_thermal_add_hwmon_sysfs(data->ti_thermal))
>> +        dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
>> +
>>       return 0;
>>   }
>>   
> 
> 

