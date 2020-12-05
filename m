Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4688B2CFE99
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgLETxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 14:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgLETx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 14:53:28 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1693C0613D1;
        Sat,  5 Dec 2020 11:52:41 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s11so1863826ljp.4;
        Sat, 05 Dec 2020 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bBF57HirJUWNF1QYKQCv5cFAIUWWtnZdZjsBsF1FLJE=;
        b=IdysiPjmnPVweioFPBqM2j0kXFOrazfcFWyxe+MuLYeOEAC2vr1O37U8hUDQcLe8C5
         xxd+KyrAq4eW4uYdJ69QH+WpDKc1Dhg1DCO0Iey/XGIdIydoRgvfFbdoalfIsJWZq2Z3
         iMIgHy8nTthhfK6rf+aL8juA5ZMNuw7tVT+DeZbOcQcb+dyKG69/HmAjUD4ynpgbAqX/
         uR3sJlzTwaCm9CDD7IP5d1l5VJZ3pMesUY3XUJj+wr2zZa1kQwiYbkkFR9JrMiADJFqy
         j3koh2M3FZ5JzRfwgDddQORHcQCV+tUDVOUggU4P0PK6r4Tug67HItzMaZr5sx1jLQ82
         GBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bBF57HirJUWNF1QYKQCv5cFAIUWWtnZdZjsBsF1FLJE=;
        b=uYoYtlo/QRee2K8HOzaRcHCDc4/UxYIOJpbQcxgQrI3ku73g68Wm/lS69gO4XWChF/
         wIa0u5gmCd0cLXsimBV+g4HLh+Hs7gc8XucDJGgdyVW7bTwdn1RJIIqUGj4j/x+M441j
         SweuuM+/qnRFNtSk0TlMQb3rJyxo+edzRA47wcVLKnYimNaA0G2g1IxUbljDuoD7b9NI
         MzkxDQ+kudRGaRhkf59+cmu4NPpdr7bC49MvBRBpEZv1ryQUvs/nNNYmPLIuvmJeefGh
         a07DwGCj+aeDaLIyPaF0YH86W7d/yaSo0PpYErbfyEGDx2pXp5qXQpSLjIqLFyQsjlvI
         fK4w==
X-Gm-Message-State: AOAM530zKQx+6BcH+266KG8FD+lyhp9Bhxr3cII64zQYqGGwuFobnDGa
        8tDDlkZQHUTHe6EhHq3dNCoS1TPYPSY=
X-Google-Smtp-Source: ABdhPJzGAM8dSVUfPrR/U+Sun2Ezu5zVBu5XVo94j8F7KWeaq9PoGepIjjXZVKrnnHP9DQTWYaRB2Q==
X-Received: by 2002:a2e:8053:: with SMTP id p19mr5590859ljg.321.1607197960096;
        Sat, 05 Dec 2020 11:52:40 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.googlemail.com with ESMTPSA id p28sm2465992ljn.22.2020.12.05.11.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 11:52:39 -0800 (PST)
Subject: Re: [PATCH v11 04/10] memory: tegra124-emc: Make driver modular
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201203192439.16177-1-digetx@gmail.com>
 <20201203192439.16177-5-digetx@gmail.com> <X8pmqVRFaBtkwDtr@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <76eb57bf-feaf-ad86-a2d6-152897af7f2f@gmail.com>
Date:   Sat, 5 Dec 2020 22:52:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <X8pmqVRFaBtkwDtr@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.12.2020 19:41, Thierry Reding пишет:
...
>> +bool tegra124_clk_emc_driver_available(struct clk_hw *hw)
>> +{
>> +	struct tegra_clk_emc *tegra = container_of(hw, struct tegra_clk_emc, hw);
>> +
>> +	return tegra->prepare_timing_change && tegra->complete_timing_change;
>> +}
> 
> This looks a bit hackish and I prefer the way this was done for
> Tegra210.

I may have an opposite opinion :)

> But that's mostly an implementation detail and we can always
> restructure this if we want to.

This is true. I'm not saying that the current v11 variant is absolutely
ideal, but it should be good enough for the starter (IMO) and actually I
don't have any ideas right about what could be done better.

>> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
>> index e931319dcc9d..934520aab6e3 100644
>> --- a/drivers/clk/tegra/clk-tegra124.c
>> +++ b/drivers/clk/tegra/clk-tegra124.c
>> @@ -1500,6 +1500,26 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
>>  	writel(plld_base, clk_base + PLLD_BASE);
>>  }
>>  
>> +static struct clk *tegra124_clk_src_onecell_get(struct of_phandle_args *clkspec,
>> +						void *data)
>> +{
>> +	struct clk_hw *hw;
>> +	struct clk *clk;
>> +
>> +	clk = of_clk_src_onecell_get(clkspec, data);
>> +	if (IS_ERR(clk))
>> +		return clk;
>> +
>> +	hw = __clk_get_hw(clk);
>> +
>> +	if (clkspec->args[0] == TEGRA124_CLK_EMC) {
>> +		if (!tegra124_clk_emc_driver_available(hw))
>> +			return ERR_PTR(-EPROBE_DEFER);
>> +	}
>> +
>> +	return clk;
>> +}
> 
> Hm... why exactly do we need this? On Tegra210 and later, the EMC driver
> is the only consumer of the EMC clock and since it also provides some of
> the necessary parts to scale the EMC clock, that's a chicken and egg
> problem.

The T124 EMC driver has an existing active user for the EMC clock, the
devfreq/actmon driver which watches and drives the EMC clock rate. The
EMC clock shan't be requested by the devfreq driver until EMC driver is
ready, the only sensible way to achieve this is implemented by this patch.

The devfreq driver doesn't support T210 (yet?) and you should witness
the problem if you'll try to implement the T210 support.

> I'm not sure I fully understand how this is supposed to work
> here and why we can't do this in a similar way than Tegra210.

The CCF returns -EPROBE_DEFER for clk_get() only until clock provider is
registered, otherwise it returns a dummy/stub clock once provider is
available and clk (of the provider) isn't registered. The CCF provider
for the EMC clock is the tegra-clk driver, not the EMC driver.

Once clk_get() is invoked by a clk user, the CCF performs the clk lookup
using the DT specifier and this lookup is aborted with a -EPROBE_DEFER
from the clk_src_onecell_get() callback if EMC driver isn't loaded yet.
I don't think that there are any other variants to achieve this behaviour.

I also prefer to have a clean separation of the clk and EMC drivers
because this is a much more expressive variant than mixing drivers
together in obscure way. The pre-T210 EMC drivers don't need to touch
clk registers for programming of the memory timings, hence those EMC
drivers are in a bit better position than the T210 driver.

The T210 EMC driver also could have a cleaner separation by using a
special tegra-clk API for the clk/EMC functions, instead of shoving a
raw clk IO pointer to the EMC driver. It feels like I was already
suggesting this about a half-year ago, before the T210 driver was merged.
