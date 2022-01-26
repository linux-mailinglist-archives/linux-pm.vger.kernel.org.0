Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007ED49C928
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 12:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbiAZL5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 06:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiAZL5J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 06:57:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65756C06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 03:57:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f17so25339718wrx.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 03:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+sDiqoAJOrfRogurdk0Dhb2t5N6DFNFBvxVjM1SRD9c=;
        b=BLZ2z3i/uG0fFoNgk9obov7QqIMqTbuOtNpD733i1x5E5ynRFrWMD7MV+zAkhAdh2G
         Tn8Swt3wZOsV5mrTe61xN+NAlX9v78/r2D91GLkbPL0l+QGSdciUWd0/62Uf4rOkvDCO
         +KvyCNIDl3joOvlg9+PJ0V0lGjMfDi5yurz+FUEC5xzV7SIYPPEQyFL7MFxhAVQy2wIN
         ELdlpTsyFCKUscHzcRdrynZpmaF/xUFnAD1iwWCRQ5CmdchphCJyIMkZYG3+X4N8LT8K
         Ek2RkEwqw5GE1v+EgAbvSisWPjrA/kSru/bhlyyIL8pi8y7Ou363KFinH97lx8/EfYGr
         vU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+sDiqoAJOrfRogurdk0Dhb2t5N6DFNFBvxVjM1SRD9c=;
        b=M/25Y+flFGiWieheWL5hDv7JzjFslAEnNX07FhZ4gF1m3T2Xapra1fgDEftWERvJbZ
         pm/+gNmsWtml0FU2RTo9SdBCOv+z81Y2Z/VMlCJ86gXhNnt+xzziRUhRv2LFIMCe5VAa
         5vqcNa6qClSkulT3o7qxm2xq8zvMqgSKZzor3mrM3b+GlgV4vlxCs7VWhzxZWWtGA/5v
         n8ktgWqfBnr7m6pgy8b64b3rFvSrh/V2oV8EOmcuNIH6Ot3wvFVs9u7gide5/IHKO47C
         TWeeewG1I5qh7Ich6jkTVM8o6vbvGAqJG0JFz0GLjp9tK+oFJJmMPHcvdga6ni+zf3E/
         DZSw==
X-Gm-Message-State: AOAM533g3raYochiE+MiIWUdcEvIg9JqD8cnnSPLQyW5LVe5pLPDjnB3
        bkZakVT0SXp0MbrMGrXszze+Rw==
X-Google-Smtp-Source: ABdhPJwvFiWQmnLxmbLCubDFaS53TCJwcofdqT+kHyjit5OJpNOW52yfgJxIOmUzSM0XMynmEK6F4w==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr12509098wrr.699.1643198227874;
        Wed, 26 Jan 2022 03:57:07 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e? ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.googlemail.com with ESMTPSA id i2sm3403595wmq.23.2022.01.26.03.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 03:57:07 -0800 (PST)
Subject: Re: (subset) [PATCH 1/3] ARM: dts: exynos: drop old thermal
 properties from Exynos4210
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
 <164313029072.79782.14492454091056440886.b4-ty@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c4a6d5a4-647a-f80c-e487-a5434e744bae@linaro.org>
Date:   Wed, 26 Jan 2022 12:57:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <164313029072.79782.14492454091056440886.b4-ty@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/01/2022 18:04, Krzysztof Kozlowski wrote:
> On Sat, 22 Jan 2022 14:25:52 +0100, Krzysztof Kozlowski wrote:
>> The samsung,tmu_gain and samsung,tmu_reference_voltage properties of
>> Exynos Thermal Management Unit driver are not used since April 2018.
>> They were removed with commit fccfe0993b5d ("thermal: exynos: remove
>> parsing of samsung,tmu_gain property") and commit 61020d189dbc
>> ("thermal: exynos: remove parsing of samsung, tmu_reference_voltage
>> property"), so drop them also from Exynos4210 DTS.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/3] ARM: dts: exynos: drop old thermal properties from Exynos4210
>       commit: e20bd06fc421fba4099be51d3f56b9b1741b499b
> 

I guess up to me to pick 2 and 3


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
