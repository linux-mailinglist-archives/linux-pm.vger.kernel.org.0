Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80FC631DEE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKUKOR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 05:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKUKOQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 05:14:16 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018322F
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 02:14:15 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l12so18065906lfp.6
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=huSdTSSPuNXnoZS/eHmsGnIE6FjPj9B88zrBs7fiZfk=;
        b=NeMpWLpw/VGYxrbuzW7jvw2Zj1Nfi3gDv98L2ZjOnbqAeGJjM8wn+VJxEVNkiRugSd
         OQ7Tmu6pMhD/aUFllBlGcL+AlFkZ45BPNURu7FAQQ2MCIIC6VLvPz2ip9wCP1YapZhd3
         o6/YUX4wwAo5UHnvEcz/ghquvvCy/58s5MJBKZHOl7FQxePuAbLZdDcePyjqv3XtvDX1
         oAajxBuaAmGLKZwomr/1bC1HqGit+Bs6twk6fbyyUFSBKry5hWiZao44wSNXy6tcSZzl
         EClSd9wu0hI94hhcaB+83s769n+Xk03DjJ/vOhGiQ5XZncTbY4PEWvTPBwgcXqFSqtQq
         xyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huSdTSSPuNXnoZS/eHmsGnIE6FjPj9B88zrBs7fiZfk=;
        b=3blpl1N8z1Glqcvz/wY+ypqWamTd1YMoHznihtul0uMduk0SAoOIE94mkiJ1Oogyyu
         eFV0lHGVJV8WpGEBiOm+TrajrAvC/mdoW4x2FDxfvCsbVkRCsTU41VH301h12diN10nK
         R/2h6MftXJSlFFb8KeudeXWUbfZzhK4bAkglz4HgJBraxx0aSnlyfL46hhzg8Pp2j8H5
         Fx/1Y8Pu2foLUCkEQdIeiIoeKylcE4zfREW7F7didUc+U9AHQEt/wbUuISyGC0pj0qLd
         ruRyRSmHH/n1sulvVNuk8VCoRVJMR4pifjQpkxirR+Km7LTGqHrqHxhQFu/KT8OChIRN
         4zjg==
X-Gm-Message-State: ANoB5pmOA2moob742nSnSqImiomgWz3mRpBJ2o6+tNDCtainCWEDrA6w
        fOjIDu/2BQZfWIN+ojEriSJ7Vg==
X-Google-Smtp-Source: AA0mqf5MIpJ8acuij7Zyzk0NHW7RM4Gxmqrv+yzfJWyhegkhGd3Kuk6wRQYO312yoIGdnWyPdbtHxQ==
X-Received: by 2002:a05:6512:25a8:b0:4aa:a6f8:f042 with SMTP id bf40-20020a05651225a800b004aaa6f8f042mr5296215lfb.405.1669025653696;
        Mon, 21 Nov 2022 02:14:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u15-20020a056512128f00b004a2ae643b99sm1965407lfs.170.2022.11.21.02.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:14:13 -0800 (PST)
Message-ID: <15a860d8-d134-5eab-1635-74622421c5d7@linaro.org>
Date:   Mon, 21 Nov 2022 11:14:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118133216.17037-4-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/11/2022 14:32, Walker Chen wrote:
> Add generic power domain driver for the StarFive JH71XX SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>

Thank you for your patch. There is something to discuss/improve.

> +
> +MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive JH71XX Power Domain Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/soc/starfive/pm_domains.h b/include/soc/starfive/pm_domains.h
> new file mode 100644
> index 000000000000..a20e28e9baf3
> --- /dev/null
> +++ b/include/soc/starfive/pm_domains.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Author: Walker Chen <walker.chen@starfivetech.com>
> + */
> +
> +#ifndef __SOC_STARFIVE_PMDOMAINS_H__
> +#define __SOC_STARFIVE_PMDOMAINS_H__
> +
> +#include <linux/types.h>
> +
> +void starfive_pmu_hw_event_turn_on(u32 mask);
> +void starfive_pmu_hw_event_turn_off(u32 mask);

These are not used outside of driver. Drop entire header file.


Best regards,
Krzysztof

