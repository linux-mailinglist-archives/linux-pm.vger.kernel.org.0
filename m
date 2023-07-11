Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0C74E8FF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGKIZV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjGKIZU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 04:25:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA0E6B
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 01:25:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso5457018f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689063917; x=1691655917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOhERrgy4Dgjs1P4t5ImERMArKjBrmI2sHen3jN1qjo=;
        b=LS74P2YoURG3ehmDJp1iLPkX0Bo0ilrIYDp3dKd0yDLZsbZ882ufspia//GC2AcYSa
         1Ft/zd3IVkhyc5OtI1iUMA+IfrjPGnL01cr0or9aQ6ma7JpU+aqHp4ID0CpBpk9nUljr
         MwmERasykKAUBobMO1DP8NVNHZO5egj22CtJCfLZyt54LTpqF4RL5SBqTJjitOWFdgLz
         EephXe92oeDQyPW/iGR+DIlGtpoGi5BvtEQbozxyORO8VZGxNXwrJZtwiB2DGO2XwWhY
         DJob1ke+TCO7t0KOWTUsxSKp7jtlKiNOgaORqmsDYLB+aS+H0DYfCJMdSkFimpFxZBT1
         S3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689063917; x=1691655917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOhERrgy4Dgjs1P4t5ImERMArKjBrmI2sHen3jN1qjo=;
        b=U18UgSX9FHtrLHngWH9vLN3pBkHj48dq8lYRfdLhZ+hj+BcDxYl+PpjZwl7n4SpUGS
         4InDXSS+T5kQPfe0OUVBKIKLeFqIoTrdPU+2VOySOjUIEeGyBvLjkvmarIPoZ7ABJ1gi
         GVSxyoUKF3mV1JpzgqIvfmNJtC7KihsvhdGwzvAPuY02sSfi95DCaOEgZXdr6BNVuZsa
         qnSc1hZYx74mez5QJxOR4hfGKsR+DsZLyzpTEcUOtkgKb0yDg+Qpg6RDEjlOW1RlcPoi
         fS2qmIC0i6NLU5MkDjsaPWvpPq8AOXzS1kRWRGBYibzI+tUNPFpZyN5LV5vBQp+elNya
         TRdQ==
X-Gm-Message-State: ABy/qLawwD1asDtxvQWQa/2WahMelQ+yIpFz2qv+K468chtGlXGGc9IZ
        eBKUnGPv7gWf6gc8IWxcRuYgXA==
X-Google-Smtp-Source: APBJJlE3w01jPs+NmtLyAG6IutWVWSah77FRCEWjeKjgj7Ip7BzfgLj9TZulACDBTiiiSsi+ILKGbA==
X-Received: by 2002:a05:6000:923:b0:314:10d8:b483 with SMTP id cx3-20020a056000092300b0031410d8b483mr14553642wrb.64.1689063917242;
        Tue, 11 Jul 2023 01:25:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm1583751wrx.48.2023.07.11.01.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 01:25:16 -0700 (PDT)
Message-ID: <fa218582-0ac1-ea8e-fcaf-222bdcf2bc6a@linaro.org>
Date:   Tue, 11 Jul 2023 10:25:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/10] thermal: tegra: Do not register cooling device
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230414125721.1043589-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thierry,

do you have an update for this series?

Thanks

   -- Daniel

On 14/04/2023 14:57, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hi,
> 
> this set of patches removes the registration of the SOCTHERM internal
> throttling mechanism as cooling device. Since this throttling starts
> automatically once a certain temperature threshold is crossed, it
> doesn't make sense to represent it as a cooling device, which are
> typically "manually" activated by the thermal framework when thermal
> sensors report temperature thresholds being crossed.
> 
> Instead of using the cooling device mechanism, this statically programs
> the throttling mechanism when it is configured in device tree. In order
> to do this, an additional device tree property is needed to replace the
> information that was previously contained in trip points.
> 
> There's a few preparatory patches to make the removal a bit simpler and
> also some follow up cleanups included as well.
> 
> Thierry
> 
> Thierry Reding (10):
>    dt-bindings: thermal: tegra: Document throttle temperature
>    thermal: tegra: Use driver-private data consistently
>    thermal: tegra: Constify SoC-specific data
>    thermal: tegra: Do not register cooling device
>    thermal: tegra: Use unsigned int where appropriate
>    thermal: tegra: Avoid over-allocation of temporary array
>    thermal: tegra: Remove gratuitous error assignment
>    thermal: tegra: Minor stylistic cleanups
>    arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
>    ARM: tegra: Rework SOCTHERM on Tegra124
> 
>   .../thermal/nvidia,tegra124-soctherm.yaml     |   7 +
>   arch/arm/boot/dts/tegra124.dtsi               |  65 +--
>   arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  63 +--
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  83 +---
>   drivers/thermal/tegra/soctherm.c              | 392 ++++++------------
>   drivers/thermal/tegra/soctherm.h              |   1 +
>   drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
>   drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
>   drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
>   9 files changed, 208 insertions(+), 415 deletions(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

