Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CE92A7FF5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 14:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgKENu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 08:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbgKENu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 08:50:58 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7939C0613CF;
        Thu,  5 Nov 2020 05:50:57 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 11so1655032ljf.2;
        Thu, 05 Nov 2020 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rVeMayhPAIlsOkSvb4nuohXgqZynnes1X57YaEIU5uA=;
        b=Ddasc07+hJetg84HtPv08IWqTsehHI7PYy/jeaGYIJMoDTXsEyExRWysvl+tTQ41bV
         /j2IxQQVm0ZteUx0q9GRqWbGelcZmQqeTBU1e610olL21Mx9kCKCXpeD7yv+fBPhPss5
         JWaQSemcWu5a8N9oDcUPCtBRuEIam3SgIHjjL89rTHiS3g4tYrAgdbrD5yzq9B8oRV+R
         X49313jTw0H8+KNYPD17gwxEtzw2VFyHhb7tPlXimQMeln2atdQZ8+ifIA9+5H+QsPhw
         hXyq5ZtYxsMvnQTN+u8ByDguczGT5kPsEMzrxKxg8FUybmkzS3pehHwaSTMlDMRYoSUG
         Bgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rVeMayhPAIlsOkSvb4nuohXgqZynnes1X57YaEIU5uA=;
        b=S5UNIJeWTww+2E7aG1UxFfNw9TA2td/WbP4QYncBSWUk2nyH5ZECVxBux4Mc2IvfIm
         QyxKRR7NHa0tiO8K/yTYj2X26tXq/9RYNc5t5W2uRV/VCa7w/nziRo9tT45UlFjS4O2t
         bt82nA5Gq9MhRmJphXqk1JP9GOIS1d7CBQPZ1UnJ+gCxM0NB9HPnj8c+TITqUBKyO0g/
         +H6YcPVPkm5UtwBxwP10zL+5byCeBRUZRJzMLhhprL8U6GMuBi7tj34A7zJwEwzfOmmp
         L8PCJAivPdIv1IL7SSM2I/8UcvjU9+B7QzC8iDHylMaeUjKtVL987jR6gYPeum5KkIJ0
         Yh2w==
X-Gm-Message-State: AOAM532fn9Xy5Y12ZHtO+Vwf0NgUMIzZvUynJWF3E1bPTHgtTtgLSOE0
        /DFOmm7vOVhOPmp8+fIzF7txyj4hxS8=
X-Google-Smtp-Source: ABdhPJx9t/7UR0Azd8ghUvjNKS2td2e/Pij/noR4yugPoL3tOZYg7hWUhrN+++nNm81CO2+OQJZQJw==
X-Received: by 2002:a2e:9618:: with SMTP id v24mr859390ljh.51.1604584256138;
        Thu, 05 Nov 2020 05:50:56 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id z15sm186420lfd.79.2020.11.05.05.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 05:50:55 -0800 (PST)
Subject: Re: [PATCH v7 36/47] memory: tegra20-emc: Add devfreq support
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201104164923.21238-1-digetx@gmail.com>
 <CGME20201104165200epcas1p1c8f692fa2d5a01c01e4f8aca55462fb2@epcas1p1.samsung.com>
 <20201104164923.21238-37-digetx@gmail.com>
 <95e289fc-210c-1f8d-1b24-36e33ce96deb@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <05fbab83-517f-a0e3-24db-358bfc367d5b@gmail.com>
Date:   Thu, 5 Nov 2020 16:50:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <95e289fc-210c-1f8d-1b24-36e33ce96deb@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.11.2020 05:30, Chanwoo Choi пишет:
> On 11/5/20 1:49 AM, Dmitry Osipenko wrote:
>> Add devfreq support to the Tegra20 EMC driver. Memory utilization
>> statistics will be periodically polled from the memory controller and
>> appropriate minimum clock rate will be selected by the devfreq governor.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/Kconfig       |  2 +
>>  drivers/memory/tegra/tegra20-emc.c | 92 ++++++++++++++++++++++++++++++
>>  2 files changed, 94 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>> index ac3dfe155505..76e9a3b10839 100644
>> --- a/drivers/memory/tegra/Kconfig
>> +++ b/drivers/memory/tegra/Kconfig
>> @@ -12,6 +12,8 @@ config TEGRA20_EMC
>>  	tristate "NVIDIA Tegra20 External Memory Controller driver"
>>  	default y
>>  	depends on TEGRA_MC && ARCH_TEGRA_2x_SOC
>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>> +	select PM_DEVFREQ
>>  	select PM_OPP
> 
> nitpick. If you select PM_DEVFREQ, don't need to select 'PM_OPP'
> bacause PM_DEVFREQ use OPP as mandatory with 'select PM_OPP' in Kconfig.

Ok

...
>> +static int tegra_emc_devfreq_init(struct tegra_emc *emc)
>> +{
>> +	int err;
>> +
>> +	/*
>> +	 * PWR_COUNT is 1/2 of PWR_CLOCKS at max, and thus, the up-threshold
>> +	 * should be less than 50.  Secondly, multiple active memory clients
>> +	 * may cause over 20% of lost clock cycles due to stalls caused by
>> +	 * competing memory accesses.  This means that threshold should be
>> +	 * set to a less than 30 in order to have a properly working governor.
>> +	 */
>> +	emc->ondemand_data.upthreshold = 20;
>> +
>> +	/*
>> +	 * Reset statistic gathers state, select global bandwidth for the
>> +	 * statistics collection mode and set clocks counter saturation
>> +	 * limit to maximum.
>> +	 */
>> +	writel_relaxed(0x00000000, emc->regs + EMC_STAT_CONTROL);
>> +	writel_relaxed(0x00000000, emc->regs + EMC_STAT_LLMC_CONTROL);
>> +	writel_relaxed(0xffffffff, emc->regs + EMC_STAT_PWR_CLOCK_LIMIT);
>> +
>> +	emc->devfreq = devfreq_add_device(emc->dev, &tegra_emc_devfreq_profile,
>> +					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
>> +					  &emc->ondemand_data);
> 
> Do you want to use 'devfreq_add_device' instead of
> 'devm_devfreq_add_device()'? If you have to use 'devfreq_add_device'
> due to some reason, you need to call 'devfreq_remove_device' on exit.

The reason I didn't use the devm here is because the EMC-clk callback
should be unregistered *after* devfreq is removed.

Thinking a bit more about it, I guess the best variant will be to add
devm support to the clk callback registration and then it should be
possible to use devm for the devfreq. I'll try to implement it in v8,
thanks.

