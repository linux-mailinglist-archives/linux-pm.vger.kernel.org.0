Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B49E244CF5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHNQrL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNQrG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 12:47:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30578C061384;
        Fri, 14 Aug 2020 09:47:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so10566397ljn.11;
        Fri, 14 Aug 2020 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZmnQ4vUhgXM2is2ULbt6oEQrTJKTXGTCE402XB71Dck=;
        b=We/FVSeWrjP0+MIiJxhGwCzfNF3FWjWCzWB0nN5SzPgQeyXr9kou5Fg1G6xwmODZ9W
         zExpR2CW8OFInlbyttpitOEdHHPVzSF71HNvUTn4l1VP6YEPQPc5pGgNRcbcYUfYDWJN
         HUsiKIWEGgsiYUuz/OVIsK2RGGZwLMlO9vQWI+c3/aaEXs+0qdGtpf9rVeFD6fG7WeDf
         G1HKVVIYwVUN0QPDX+ccBKdcifMjTU2ihgqzA/QrFXkLPvkeW19oC7PqU9s4PagQK27z
         ewemK3ELH1ss9E0v2Qlqb6QFRu43KeADbn7yTJQVw00RXb8KL7qPH6taCW/IERgVRHJz
         g9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZmnQ4vUhgXM2is2ULbt6oEQrTJKTXGTCE402XB71Dck=;
        b=f7ro3F+b05bEuDvCo6+tbhx5QOGIMrsVYJ6mi+3gbpJRQclznO/sW8mBnsoZ29xSjB
         qiqNVO/wucws44bXDWSs4NqO9IrA1XpFnYb5EY4GiurGfiKa9vkFbmt0lvtnv4Kt3W+g
         G3PMioEEPUBU05cTcSk6kS50VTWsOtDkpJaRkdA09ThhMrbpIK3nUgE8/cWYRCvX/lM3
         0JlQ/bb7BHnQWjLY8MXyZztAmN+3LNAkY5iog9J72TT4TLn6AZTo8w9WFOHJyGP/98TR
         fPj+TMs5L5pqkBVdVC5XD42oYkwWXecESqrlhclysT4dj2bVs/FdU7rRzIY93LDEeClH
         20hA==
X-Gm-Message-State: AOAM530Z/lI4xWDCNgAFfmgq9b2m/hzUySYJ1vm/qfBiDRwKuHFXighM
        nTHm85AWa/WKHOW3F6ZDCDFlmG0y5Sc=
X-Google-Smtp-Source: ABdhPJxRFdX8dMKX0zpz4P0YHR+SyK3OD8HyoKXvo125A32O6XK/VTWaU2KYfAdlkk4oum8Xf4i2FQ==
X-Received: by 2002:a05:651c:106a:: with SMTP id y10mr1705452ljm.296.1597423624384;
        Fri, 14 Aug 2020 09:47:04 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id v23sm1992608lfa.5.2020.08.14.09.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 09:47:03 -0700 (PDT)
Subject: Re: [PATCH v5 13/36] PM / devfreq: tegra30: Use MC timings for
 building OPP table
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200814000621.8415-1-digetx@gmail.com>
 <CGME20200814000944epcas1p3dfd0104c5fa640695dfcd4949f6b1818@epcas1p3.samsung.com>
 <20200814000621.8415-14-digetx@gmail.com>
 <1b0d75fe-79af-70eb-8450-999a3bc72bac@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1de8aa41-8001-cf46-026c-b00f8df0b9a3@gmail.com>
Date:   Fri, 14 Aug 2020 19:47:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1b0d75fe-79af-70eb-8450-999a3bc72bac@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.08.2020 05:02, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> I add the minor comment. Except of some comments, it looks good to me.

Hello, Chanwoo! Thank you for the review!

...
>> +struct tegra_devfreq_soc_data {
>> +	const char *mc_compatible;
>> +};
>> +
>> +static const struct tegra_devfreq_soc_data tegra30_soc = {
>> +	.mc_compatible = "nvidia,tegra30-mc",
>> +};
>> +
>> +static const struct tegra_devfreq_soc_data tegra124_soc = {
>> +	.mc_compatible = "nvidia,tegra124-mc",
>> +};
.
>> +	soc_data = of_device_get_match_data(&pdev->dev);
> 
> I think that better to check whether 'soc_data' is not NULL.

It's a quite common misconception among kernel developers that
of_device_get_match_data() may "accidentally" return NULL, but it
couldn't if every driver's of_match[] entry has a non-NULL .data field
and because the OF-matching already happened at the driver's probe-time
[1], which is the case of this driver.

[1] https://elixir.bootlin.com/linux/v5.8/source/drivers/of/device.c#L189

Hence the NULL-checking is unnecessary.

When I first encountered the of_device_get_match_data(), I was also
thinking that adding the NULL-checks is a good idea, but later on
somebody pointed out to me (maybe Thierry) that it's unnecessary to do.

>> +
>> +	mc = tegra_get_memory_controller(soc_data->mc_compatible);
>> +	if (IS_ERR(mc))
>> +		return PTR_ERR(mc);
> 
> You better to add error log.

In practice we should get only -EPROBE_DEFER here ever. I'll consider
adding the message in the next revision, at least just for consistency.

Thanks!

...
>>  static const struct of_device_id tegra_devfreq_of_match[] = {
>> -	{ .compatible = "nvidia,tegra30-actmon" },
>> -	{ .compatible = "nvidia,tegra124-actmon" },
>> +	{ .compatible = "nvidia,tegra30-actmon",  .data = &tegra30_soc, },
>> +	{ .compatible = "nvidia,tegra124-actmon", .data = &tegra124_soc, },
>>  	{ },
>>  };


