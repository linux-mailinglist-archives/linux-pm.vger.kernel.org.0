Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657477352A3
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 12:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFSKhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 06:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjFSKgk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 06:36:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAF210D8
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 03:36:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so3264696f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687170994; x=1689762994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejTbf4LoKogG/Ln74Pk82fARkIEkMJUQlIgg7+Wp5uA=;
        b=cZQ+XdV0cjSiIJUue049gOJ63z1o+Bm5BMwN6K6EFzSIeJ2SA4ke+YkuxraSHYmD0l
         GS3bEUP9EtuBl1eb2X6tCSnGoII1m/WAJz06o4ET91pEjInQeQ42DiNbxpC/twP9V+/4
         3Gj8yMNImEbdRJJwLeisOgfI/NoxFJuCHxF+VALOIrOzuhzEqhEIFBplsYCjF/a10tnI
         93KH7LnGYk/4r4aEFokFTEp+oClEb9EyG5/Cu7axXD4WnV3YngObv9H6xS1EVDVCWXEg
         JqEgrW4F7TutEVFS2z8zooJ30Ze8SDHs0hicd8RmpwFoOTWTm5I87VesPwdguUs099q/
         0mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687170994; x=1689762994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejTbf4LoKogG/Ln74Pk82fARkIEkMJUQlIgg7+Wp5uA=;
        b=lqpgwLEfzd3cLbW0Djefs8qt3j/vi1GrjfAccHWdbXX284RyOWqLwYNYuxR2WGFBsE
         68aMsQ/DxK1IvSPb2vM+8dAgeWMiSPi0SgTr2s5SJXIPjTvIWdR34DGh+RI9//Xmcuch
         nvbNKGbl8xnBjhWdsRhEblUqGnGOhYExwkKgszBgnTfX52HEWW8cYw1YQ4dFcFqFj2JP
         gReEKRi/ERjmQTBkV5sjjX45ZTMlRuoAf7tHPwVq5suS8DGrcLPTHpKC1biwz7S4tfGE
         teRNKR+hG4IaArRvSF1VPM6j1lwcFmBPu9094SMyQTXE1TerhpgOLx+sqgsNuQrvXT+A
         2oSQ==
X-Gm-Message-State: AC+VfDy//Hgbq1UlAYdyl8/E8s3cO9rPPHZIr7BWyqPb0rw9tlxEQZbF
        LmFwSlRe6bmxPoRzAcfVyfh4CA==
X-Google-Smtp-Source: ACHHUZ77/vPLkGtrYJe9RkVK0QQ5x+vBGoIstm3Y3I16fnaPGyjwJGTc1YvxW4AFSsIPL8eUKmuIaw==
X-Received: by 2002:a05:600c:21d6:b0:3f9:a4e:190b with SMTP id x22-20020a05600c21d600b003f90a4e190bmr3629171wmj.7.1687170994150;
        Mon, 19 Jun 2023 03:36:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id l17-20020a1c7911000000b003f9b0f640b1sm2558593wme.22.2023.06.19.03.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 03:36:33 -0700 (PDT)
Message-ID: <e69ada00-dd2b-4b95-b639-346929832910@linaro.org>
Date:   Mon, 19 Jun 2023 12:36:33 +0200
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Thierry,

are you planning to send a new version ?


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

