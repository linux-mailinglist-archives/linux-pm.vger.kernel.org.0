Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421E2552084
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiFTPWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbiFTPWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 11:22:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45018CCA
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 08:17:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g27so8481504wrb.10
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zrL5Ko404zTn2sYJajwJygSYjcByLv+eeU7NKJf9fRQ=;
        b=Dj0IODvlLKHMAhfvaoGfnoMmAfAx3IOmxYS3nagMCoZlJWf//OmKMweRJAErq381Dg
         urx+BkuXRjugobs2/XkV1aNZ7IGzadwGxZ4jhcVrMO8ifQb4O7PuAXhzk9eNrv+xjh0O
         hSR40o7ZIvUpJb10nMzwzZskS1ucP+EXvrPdbpRwgnxWQUU6qWNJlgRFZl2xtwWrBSBS
         xWL9gKfBPkpuaTf2nA1fq1hK0zlH/btnEs5CXeVr/+CTAybALZVYEC6vbgHbI1vkHcPA
         Wucy2Q32Te47VAHjUkD8lk7giyDh5OwUg97POcuszq/PeL7Y5asHC5KonSvDPTLJZo2Y
         Za+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zrL5Ko404zTn2sYJajwJygSYjcByLv+eeU7NKJf9fRQ=;
        b=C9iuuOcVaEMGyrmzDqo7SEC5NGlKAxjcsg6O2Uao40t+Y2DbQzy6nN7bX/fU3D2ySF
         pYDzNY+DbtaAI3lJ+YYAO77FcHXErogtB03HVuVD5yRFzfv1hzvSQMEAuTu/qZmlfAxF
         TfKmSz/I4vT5xQXiuk+mwp1UAJXvqDXOteO+NYieu98OnBh3vR6P+S6ECxSrcHf05QcJ
         FTGqQnc97gLHUD7FUd8bYKfpCGg6RKX/exgi+adUgZFNE/8N0uSQ3egZQ3M71ytYZuJz
         iR3lSHjVBxIkxlQZvWE0UcALCwA0sdg91SIFdDTMHnyevR7u7LH7VyaFtI5avTKiuCJP
         AXKA==
X-Gm-Message-State: AJIora/p+SXUqFbIDs4hgQG78Vk9sNgSNC+4KZ/RI9btFW9dqJ+OYtlY
        PIV7HlcsS7/xiubminlRpIoKOA==
X-Google-Smtp-Source: AGRyM1tG/281TeLKRYVvM91ypJ+UK28tXoNfhxwhSGRUzwBmfj6kfRFvOzRIyfKErQIzpUC1WcLCsw==
X-Received: by 2002:a05:6000:1686:b0:219:b932:ffba with SMTP id y6-20020a056000168600b00219b932ffbamr23977107wrd.227.1655738231674;
        Mon, 20 Jun 2022 08:17:11 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1c7:92c1:7b6f:f9? ([2a05:6e02:1041:c10:1c7:92c1:7b6f:f9])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b003975c7058bfsm15724611wmq.12.2022.06.20.08.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 08:17:10 -0700 (PDT)
Message-ID: <20db85cb-1d16-3aad-c9b0-0a2a602f20ec@linaro.org>
Date:   Mon, 20 Jun 2022 17:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] thermal/drivers/tegra: Remove get_trend function
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-2-daniel.lezcano@linaro.org>
 <6d5b2bfc-f449-668c-8c97-638eb806cb66@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6d5b2bfc-f449-668c-8c97-638eb806cb66@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/06/2022 14:44, Dmitry Osipenko wrote:
> 16.06.2022 23:25, Daniel Lezcano пишет:
>> The get_trend function does already what the generic framework does.
>>
>> Remove it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>>   static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
>>   {
>>   	u32 r;
>> @@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
>>   static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>>   	.get_temp = tegra_thermctl_get_temp,
>>   	.set_trip_temp = tegra_thermctl_set_trip_temp,
>> -	.get_trend = tegra_thermctl_get_trend,
>>   	.set_trips = tegra_thermctl_set_trips,
>>   };
>>   
> 
> The framework doesn't use the trip temperature, is it really the same?
> Previously, if temperature was above the trip and was dropping, then it
> was THERMAL_TREND_STABLE instead of THERMAL_TREND_DROPPING.

Actually, the only difference is the temp > trip and the temperature < 
last_temperature. It results in the STABLE trend and the governor does 
nothing.

With the core trend function for the same inputs, temperature < 
last_temperature results in a DROPPING but as temp > trip the 'throttle' 
boolean is true in the governor, and get_next_state() with DROPPING + 
throttle=true, results in nothing because the action happens when 
throttle=false.

All the combinations result at end at the same action from the governor.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
