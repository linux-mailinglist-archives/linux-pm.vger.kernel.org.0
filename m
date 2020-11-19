Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A812B9099
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKSLEj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 06:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgKSLEj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 06:04:39 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91E0C0613D4
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 03:04:37 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so4873575wmd.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 03:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Ll8n6pQY8fl0D6AYBxyaK7tcS0BYALR8vZMjUAeVGo=;
        b=dxFlGSDgg6/rxMZBm4tFpnIyka/eaEQgWcLSSKFPgi1/bSNBSN9v++d+lS2Wm5we3E
         huAzryDbZnI2jzuEjT6GIcVB9M7nQIhlkPxuLAKedXDDCNH2G2i6wAqrJ7Aa8NN62+Wp
         /ZDnY0fsXbURbK/uLFD3c8VJzJivtonaxshAiR8uKakY0Fo2SXP0mnzYjZrZvi2mAZRu
         NgJoXJiCyOCr57RM4hLApp7A5HWomQbAPQAn6pH4AQwv6srtqsUwc1iNh7S7q8TqyQyv
         RESmp1SQD09UKpFU739vn0JGiCkVB9NlluGJ4Z3THfJzzAFlu30u6st/2cqWB5lxkjd1
         dL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Ll8n6pQY8fl0D6AYBxyaK7tcS0BYALR8vZMjUAeVGo=;
        b=bpeIaes98mZ1U9JnsMOjkX2YRjSkv0b8GV5GmW5pvyc4zowUd+WnB/N97Q6brAw55k
         N++VzhihXA75IdJb5PrXxYg550WQdoSyJ+i4EjLYZ7/20zV57XgJTMfzz4LnzdryNlRh
         DMvYSLzaFLsDoj2/Pdo2y+1AI3uE3MOGSkgNN/sxNghM1DahotjEG2aAR47ocgVkUlPW
         Y/4CGFLdruxCC1D+Ke2vt577+qvydTOxr33VCMLq0tVyraXJSguRMblijaGiHLXuewfn
         WH0pyLWiFCWPXqutyCBgBR5tFu9sidOD4r2TccQyVkbbDbkGQ4+zjUblcYMszRtO+hvp
         NElw==
X-Gm-Message-State: AOAM533cTNdLraAp1k6dPl6sab11KNDdO5I+N/2IWq/Wykvl8s6zKMNm
        NCqyS2mEgehng5MJOaUtOb+6rkGcC95grA==
X-Google-Smtp-Source: ABdhPJzJM0oxo1FX2/Ks4bvh5nMg7agaIwx345GcaPlxjq8ytLLBfQEHVNhnmHWnp/Lua+GWgFBMGA==
X-Received: by 2002:a1c:a752:: with SMTP id q79mr3851449wme.24.1605783875938;
        Thu, 19 Nov 2020 03:04:35 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:5150:1004:6c70:8db9? ([2a01:e34:ed2f:f020:5150:1004:6c70:8db9])
        by smtp.googlemail.com with ESMTPSA id j127sm9250584wma.31.2020.11.19.03.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 03:04:35 -0800 (PST)
Subject: Re: [PATCH v2 0/6] thermal: tegra: soctherm bugfixes
To:     Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200927150956.34609-1-kwizart@gmail.com>
 <CABr+WTnftetrMzC8bq+=RqOxqJ9EvYsU1LEZ5bVv-OptVksbjA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <90858129-bed7-eacf-915e-0c2b3acaa089@linaro.org>
Date:   Thu, 19 Nov 2020 12:04:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABr+WTnftetrMzC8bq+=RqOxqJ9EvYsU1LEZ5bVv-OptVksbjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/11/2020 12:00, Nicolas Chauvet wrote:
> Le dim. 27 sept. 2020 à 17:10, Nicolas Chauvet <kwizart@gmail.com> a écrit :
>>
>> When using tegra_soctherm driver on jetson-tk1, the following messages
>> can be seen:
>> from kernel: tegra_soctherm 700e2000.thermal-sensor:
>>  throttle-cfg: heavy: no throt prop or invalid prop
>>  soctherm: trip temperature -2147483647 forced to -127000
>>  thermtrip: will shut down when cpu reaches 101000 mC
>>  soctherm: trip temperature -2147483647 forced to -127000
>>  thermtrip: will shut down when gpu reaches 101000 mC
>>  soctherm: trip temperature -2147483647 forced to -127000
>>  thermtrip: will shut down when pll reaches 103000 mC
>>  throttrip: pll: missing hot temperature
>>  soctherm: trip temperature -2147483647 forced to -127000
>>  thermtrip: will shut down when mem reaches 101000 mC
>>  throttrip: mem: missing hot temperature
>>  IRQ index 1 not found
>>
>> This serie fixes two errors and two warnings that are reported in dmesg
>> It was compiled and tested at runtime on jetson-tk1 only.
>>
>>
>> v2:
>>  * Add missing tegra210 device-tree properties
>>  * Add the appropriate prefix for tegra soctherm
>>  * Use SoCs condition over of_compatible
>>
>>
>> Nicolas Chauvet (6):
>>   ARM: tegra: Add missing gpu-throt-level to tegra124 soctherm
>>   ARM: tegra: Add missing hot temperatures to tegra124 thermal-zones
>>   arm64: tegra: Add missing hot temperatures to tegra132 thermal-zones
>>   arm64: tegra: Add missing gpu-throt-level to tegra210 soctherm
>>   arm64: tegra: Add missing hot temperatures to tegra210 thermal-zones
>>   thermal: tegra: Avoid setting edp_irq when not relevant
>>
>>  arch/arm/boot/dts/tegra124.dtsi           | 11 +++++++
>>  arch/arm64/boot/dts/nvidia/tegra132.dtsi  | 10 ++++++
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi  | 13 ++++++++
>>  drivers/thermal/tegra/soctherm.c          | 38 +++++++++++++----------
>>  drivers/thermal/tegra/soctherm.h          |  1 +
>>  drivers/thermal/tegra/tegra124-soctherm.c |  1 +
>>  drivers/thermal/tegra/tegra132-soctherm.c |  1 +
>>  drivers/thermal/tegra/tegra210-soctherm.c |  1 +
>>  8 files changed, 60 insertions(+), 16 deletions(-)
>>
>> --
>> 2.25.4
> 
> Hello,
> This series is still pending review.
> 
> Thierry, do you expect some reviewers from the linux-pm (Zhang, Daniel ?)
> To me it seems like tegra specific changes, so maybe a Nvidia reviewer
> is awaited ?

I can apply the patch 6/6, other patches must go through arm-soc tree.

Thierry can you give your blessing ?

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
