Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4132AED4A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 10:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgKKJRn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 04:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgKKJRl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 04:17:41 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA56C0613D1;
        Wed, 11 Nov 2020 01:17:40 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so1258834ljj.6;
        Wed, 11 Nov 2020 01:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OgKNdkVvaz+xa5pKH11vMf7kWHOOkyKTt0eLKCTWoyM=;
        b=Xcem9iSPQQT+omFF8Jq4Zxg1UFj1oGZ3AkgbegKWJF9ZE7/DUw7FesobvK4yzHXPME
         4ey+m/ni4ky0Npgfs3w2eq89einViRu52/6CUzh2vpvRbacsSeqlHfkk0qK/2VoR5cBG
         Nn3yHbgiDzKilCptKB6KIojaSc5A2GhXGEv61N8/E+wiUYYImiYre9geZZLyMkdb0d6W
         vtd61w2JFrestyRQW+NUPPoXgP0UMkQmiiSAwZeDItM86OOJ0n0Dxf2wOv7dG9X1/cN4
         /O2DyuDpOACib5hLZH7nYa6LM+P1Kt1AYGFKJEnBhTkk0WNkV75QgPdu2r5VpxrD2YCO
         le2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OgKNdkVvaz+xa5pKH11vMf7kWHOOkyKTt0eLKCTWoyM=;
        b=DxNrhQhah9RioumcPATWoD0zhkaBDrkiolKm1BduqbEClwzc1crNhvYzxe+J437TjR
         ZhViXtHlhjsNN6/th7VFumhWWA1OPWJ0BoHQXCknkV3JdqEZ03LQjfbF3/sdxGYtipwg
         2PMSQ7PWyJYVzL0qeK2geIf+6HrKbxWG6LasTujkBQVCgKUxG9c4CVvRc1JAIQGeuY7h
         xXpV4kMFHeVacW9znfTbVXLVkJ+NU76IjOcorn0cbrI672JCuXeWh3M2gojRIWswo1Zj
         DkCqSk1nbDJprY/MtlQIj/sOP4J93r7YMpaxs1pb/uJVZJlWfaIKa84nGYFQ44HZihw8
         kE3g==
X-Gm-Message-State: AOAM533XOaf91io5m49s4ET5fwcGK5ydeSmBRzbk96jvuZ/+dOT1PS4/
        ZdHVruLptWZRd64c0/KFtEA=
X-Google-Smtp-Source: ABdhPJzwEqcGv+xxwnbEjIK56TC9t3H5Pa/S/5wGVfme5kATJ46qhW11pu/k0uP4E+ggKdmGXgkSkw==
X-Received: by 2002:a2e:87d7:: with SMTP id v23mr931730ljj.467.1605086259116;
        Wed, 11 Nov 2020 01:17:39 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id j11sm162356lfg.69.2020.11.11.01.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 01:17:38 -0800 (PST)
Subject: Re: [PATCH v8 11/26] memory: tegra124-emc: Make driver modular
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-12-digetx@gmail.com> <20201111090434.GB4050@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f44b64f5-6b08-5f1e-4f9b-a73a1705d493@gmail.com>
Date:   Wed, 11 Nov 2020 12:17:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111090434.GB4050@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.11.2020 12:04, Krzysztof Kozlowski пишет:
>> -obj-$(CONFIG_TEGRA124_EMC)		+= clk-tegra124-emc.o
>> +obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-emc.o
>> +obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124-emc.o
> How is it related to modularization? It looks like different issue is
> fixed here.

The CONFIG_TEGRA124_EMC now could be 'm', while the clock code must be
built-in. The TEGRA124 EMC driver is used by T124 and T132 SoCs.

...
>> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
>> index 6b565f6b5f66..2da7c93c1a6c 100644
>> --- a/drivers/clk/tegra/clk.h
>> +++ b/drivers/clk/tegra/clk.h
>> @@ -881,18 +881,6 @@ void tegra_super_clk_gen5_init(void __iomem *clk_base,
>>  			void __iomem *pmc_base, struct tegra_clk *tegra_clks,
>>  			struct tegra_clk_pll_params *pll_params);
>>  
>> -#ifdef CONFIG_TEGRA124_EMC
>> -struct clk *tegra_clk_register_emc(void __iomem *base, struct device_node *np,
>> -				   spinlock_t *lock);
>> -#else
>> -static inline struct clk *tegra_clk_register_emc(void __iomem *base,
>> -						 struct device_node *np,
>> -						 spinlock_t *lock)
>> -{
>> -	return NULL;
>> -}
>> -#endif
> Why clock changes are so tightly coupled with making an EMC driver
> modular? Usually this should be a separate change - you adjust any
> dependencies to accept late or deferred probing, exported symbols,
> loosen the coupling between drivers, etc. and then you convert something
> to module.

Because the clock and EMC driver were not separated from each other
previously. The clock part can't be modularized easily and probably
shouldn't.

I'm not sure whether it's actually possible to split this patch without
taking a closer a look.

I'm also doubt that it would really worth the effort for a 100 lines of
a changed code.
