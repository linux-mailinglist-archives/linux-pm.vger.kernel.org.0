Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598D26796A8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 12:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjAXLbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 06:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAXLb3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 06:31:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F903E615
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 03:31:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so742797wro.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 03:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLLfocHfbHOL40uUXPgns0rpEqz3nPLXX2K2rRvVLrg=;
        b=DEXRUatr5utyB4EOK86e5LPurvKMapMmZDc2v0HM/kq1oNFxjcQzYCAx+ndneN4ERl
         0gDqmzKRQUJfHs/DacPephHXPIXVd2mHWDXz2sfNKlZkM67sgHgkihsWuhZLGyMaMFO1
         WVVwOvO0NWp3ZjRjsQwzCLi1MUrwf7dtefhaKkG9NPRRI1taxdIZ0h1tyZhXnr6bYiiI
         vr1CNLkQCgboDgT6uX51SCYemrxdhugTyM1DEX7W54H17bg2fiAYdWuwM+vdE5++R/WK
         3C26A6hIHVVhGe/Ez9hcZs8CRPPvfjeunNQGSq+xihDWl7tOTorthvz8rxJyXlVv+GKB
         wRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLLfocHfbHOL40uUXPgns0rpEqz3nPLXX2K2rRvVLrg=;
        b=Saf8adJ+2115uwRbdBql9NDfG7y4YNnDAfoSeEkgckNZZziW0F9qk/B1XGSvV8a3Kq
         fXPqutzdtUVTdz7/Ta38v4QRPeSaV/bORUVHVmmmKJQaU33z1PRNB6XEdKOKYfKo2lOn
         1kRykXoNeuBh21ycmRJShPrLcWPVTO6pMm2xe3FlebnuTr+DSZI2xyuCELAYCa7lrgW+
         Q8yzn4Nn9SVn41z9c2I0OAb5KxrwEb/B2cpHqadXX7opmanMnkqri/z5aFB4dwurEZ/J
         jqWtr0QZaL+FRyeO6edAxDNkyadNYGISVuKEE+vNa98GPWySW65TjCgaMyC2a6+3kd25
         GjbA==
X-Gm-Message-State: AFqh2kqIF9xoSQCp0DBQmQiuZxN/V+HEQhHOm2DN6fDt4KVF2pywSLdc
        DHI60iX6Y0w0xISAQHg9tZXxAqPwkQT3gZpf
X-Google-Smtp-Source: AMrXdXvjHkzAnZJ0fbZHcGRpy4aZpsopasdvyrp+0Xf7BVvh20Ocf8+v5SFmLRtxn0FLI76/7f6/TQ==
X-Received: by 2002:adf:f890:0:b0:2be:5a87:7727 with SMTP id u16-20020adff890000000b002be5a877727mr12963183wrp.15.1674559885893;
        Tue, 24 Jan 2023 03:31:25 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t14-20020a5d690e000000b002bdd96d88b4sm1627451wru.75.2023.01.24.03.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 03:31:25 -0800 (PST)
Message-ID: <3bcd80e7-5934-ca8d-ac86-9bc5b3a8a6ef@linaro.org>
Date:   Tue, 24 Jan 2023 12:31:24 +0100
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


Hi Miquel,

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

[ ... ]

> 
> Makes sense.
> 
> Nit: I would actually put that comment in the commit log rather than
> keeping it in the code, but whatever, that's a nice simplification.

Ok, I'll do the change.

>> +	armada_set_overheat_thresholds(priv, temperature, 0);
>> +	priv->overheat_sensor = tz;
>> +	priv->interrupt_source = sensor_id;
>> +	armada_enable_overheat_interrupt(priv);
>>   
>> -	return -EINVAL;
>> +	return 0;
>>   }
>>   
>>   static int armada_thermal_probe(struct platform_device *pdev)
> 
> LGTM so,
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for the review

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

