Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A086796C2
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 12:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjAXLga (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 06:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAXLg3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 06:36:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9C22DD9
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 03:36:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b7so13585111wrt.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 03:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHqk+22oS5L5hrjTVYV2FVxuNvyMMgE5wfu13RaKBHI=;
        b=IKmQwgTJ3fqVk5LxsqfjX4pjhw802ZEUZF0Sor3n/r0iaKIC83RelVFi4NmxFdAEkb
         mLNzvYUUVbWqG+Yr1A+N6QekLPP3bp0fXgdv+fFdjQSQ7Kj6jWjQ+sX+XhV8jvfbTcxG
         Gc3tJvqeGzQm6Mgy12I4P9KVXqzAF8koGdjvoAE3DZyV7UIkvZsYYAB5eEaPTqvYTOcL
         GvSRODrmtcpj0m83A+mJBL25rPW3YWnHDi2Rq8ueVYsXJmOaDqzQ8NzNDhW+a1orn6Hd
         dHICAhGK4r0RQ4Z92ZNmrhjIPyyM8WCrfvawB/Fsv/eOEPqy/xFRtofeFLiCJXFLVFSk
         WKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHqk+22oS5L5hrjTVYV2FVxuNvyMMgE5wfu13RaKBHI=;
        b=Kx77X7Xpo0tveQO2RiWAHLH/vLRLSFaT067BvjhobXr+rTetgGlDSBrO7tf62fiOiW
         daG1tnqEk1YnTdwZ1bc9unZCRoqTwtAr8HU5uc/2vRgM/8Dcoj0BjsJ7yWfzdcP7bDjN
         RDEComZnYgQJzJ/YCrwTUPjT5mmxRG/1JyiFQmvelDrQNvrsj8tF/9KSXDVXzMrKRJTg
         dfSaY/T8P9QFYArP1HOd6XaMbuoOQcjs/HQOpg1KLzJMzIkwJ7nPq47fvLXZELeAilP9
         kgCWAr/Kok6plILIH/F3dxoEkPp68X2pTToSWPLCGPoZq60z2gOXOjQsyr7OfEDvcB2u
         h3TQ==
X-Gm-Message-State: AFqh2kqxw6XsvKbLGbYdfIpu7logqW5m9HzSb5dQ+YCRWxQ1zrNoj6XY
        Ud8KaPsLCkQwHy8BNsg7F4TpyA==
X-Google-Smtp-Source: AMrXdXs5AgcQscFiiHc0uTWyqXxRF6dqTQWGuglp7wcRVmSr4c0IKvZWOZWejPMGB4jZC9JOSVxQLQ==
X-Received: by 2002:adf:f346:0:b0:242:88af:d88b with SMTP id e6-20020adff346000000b0024288afd88bmr25837285wrp.43.1674560184213;
        Tue, 24 Jan 2023 03:36:24 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i9-20020a5d5849000000b002bddac15b3dsm998435wrf.33.2023.01.24.03.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 03:36:23 -0800 (PST)
Message-ID: <4225f833-0f15-5780-5ef4-4cd9e05eca70@linaro.org>
Date:   Tue, 24 Jan 2023 12:36:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal/drivers/armada: Use the
 thermal_zone_get_crit_temp()
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230118222610.186088-1-daniel.lezcano@linaro.org>
 <20230124120458.412fc528@xps-13>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230124120458.412fc528@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/01/2023 12:04, Miquel Raynal wrote:
> Hi Daniel,
> 
> daniel.lezcano@linaro.org wrote on Wed, 18 Jan 2023 23:26:10 +0100:
> 
>> The driver browses the trip point to find out the critical trip
>> temperature. However the function thermal_zone_get_crit_temp() does
>> already that, so the routine is pointless in the driver.
>>
>> Use thermal_zone_get_crit_temp() instead of inspecting all the trip
>> points.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/armada_thermal.c | 38 +++++++++++++-------------------
>>   1 file changed, 15 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
>> index db040dbdaa0a..c6d51d8acbf0 100644
>> --- a/drivers/thermal/armada_thermal.c
>> +++ b/drivers/thermal/armada_thermal.c
>> @@ -784,34 +784,26 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
>>   					 int sensor_id)
>>   {
>>   	/* Retrieve the critical trip point to enable the overheat interrupt */
>> -	struct thermal_trip trip;
>> +	int temperature;
>>   	int ret;
>> -	int i;
>> -
>> -	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
>> -
>> -		ret = thermal_zone_get_trip(tz, i, &trip);
>> -		if (ret)
>> -			return ret;
>> -
>> -		if (trip.type != THERMAL_TRIP_CRITICAL)
>> -			continue;
>> -
>> -		ret = armada_select_channel(priv, sensor_id);
>> -		if (ret)
>> -			return ret;
>>   
>> -		armada_set_overheat_thresholds(priv, trip.temperature,
>> -					       trip.hysteresis);
>> -		priv->overheat_sensor = tz;
>> -		priv->interrupt_source = sensor_id;
>> +	ret = thermal_zone_get_crit_temp(tz, &temperature);
>> +	if (ret)
>> +		return ret;
>>   
>> -		armada_enable_overheat_interrupt(priv);
>> +	ret = armada_select_channel(priv, sensor_id);
>> +	if (ret)
>> +		return ret;
>>   
>> -		return 0;
>> -	}
>> +	/*
>> +	 * A critical temperature does not have a hysteresis
>> +	 */
> 
> Makes sense.
> 
> Nit: I would actually put that comment in the commit log rather than
> keeping it in the code, but whatever, that's a nice simplification.

Oh, actually, I added the comment because of the third parameter change 
for armada_set_overheat_thresholds(..., 0);

>> +	armada_set_overheat_thresholds(priv, temperature, 0);

I think it makes sense to keep the comment to clarify why we pass this 
zero temperature argument.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

