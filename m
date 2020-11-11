Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0C2AEA32
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 08:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgKKHdG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 02:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgKKHdB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 02:33:01 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC11C0613D1;
        Tue, 10 Nov 2020 23:32:59 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so859538lfh.2;
        Tue, 10 Nov 2020 23:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5haJlrCzHhZjookFyzKI1ofwRfXaAn0aRWFtwOvZPM=;
        b=mBY07o0WYOO3KPVX9ikNGcfO0oosoLOui+74cafSO4z+uokoYQoq0NNwCqF4dWSBQ5
         H4Jhs5vLdQ191L3nLezXVMst6CirPN7bQCoBhNSlb1bR9C75HchTsOU4ddLT2LL6mAWX
         Dvk0b4S/anJkLgSMSsODY9QpIeCgvo7oURWz9oY8W8HBi4y3f1xW8y9rvism9ipr+zA+
         doQKmSlzb/V6dTwBAB93tluEkYwJaFc90gfqF2go5vzYx9Yi0iQKS7Xp3SXnuidOBMPV
         vEJtVgsKSxOpZIyNYQiqGQg42YW5BgyZS4y/d0WBXlhV8yZfOg9LrGbckxALMCFwa4Yf
         +iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5haJlrCzHhZjookFyzKI1ofwRfXaAn0aRWFtwOvZPM=;
        b=BNKbsErvONUOj/03siVmA6A63AmVpOLRpsYvVHesGAY4f8ANm1fW+G0YGzObc0/cvX
         rxohdoTNAxAb3cf9UHBX67dr+iMvYHEc+mP+iM3OF9/RnB0mT7XgA9SBqkiJPzUSuqxU
         xpMnXpBBLFYxzgmG59ebeBdfv4M/rtRrTydgZFXKrbJnhMegNqHImr+H9D93CXszBDec
         vr5OiRlawgkVEYMzM9KqkiyoRA5dGMzqQbbgSm50IB2zQb/dVVuJZmE+MTDi4d3AXxhG
         oMKGRIXRyBKnx+4zDD+jn5hN7Li/vZ5QP3QmE9eO8y9UjuNqldjPaTXPbCSsaVSdISub
         V8rA==
X-Gm-Message-State: AOAM531HVNV5llbfYCgk+TaLKR3x+C/EG/qXnh4BQFfJcwvEr8J8g2XA
        g1KHCvORn59nzxFQ7gp1csc=
X-Google-Smtp-Source: ABdhPJxhZEjV2QRG7aWHgF16Bn0c+eyj1kfpgdHs/q2P1g52eKn79RkzViwPJ+N7nj1DvZzVrM0B2Q==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr2226361lfl.382.1605079978165;
        Tue, 10 Nov 2020 23:32:58 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id q7sm92352ljp.81.2020.11.10.23.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 23:32:57 -0800 (PST)
Subject: Re: [PATCH v8 09/26] memory: tegra30: Support interconnect framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-10-digetx@gmail.com>
 <20201111055313.tefidnmc7f4yb3jk@vireshk-i7>
 <185e9140-fdce-29ef-68c3-aa7da02b249d@gmail.com>
 <20201111061855.2azilyhfoxwzpoir@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7f5c15c6-44d2-c997-442c-8f6670794f0e@gmail.com>
Date:   Wed, 11 Nov 2020 10:32:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111061855.2azilyhfoxwzpoir@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.11.2020 09:18, Viresh Kumar пишет:
> On 11-11-20, 09:14, Dmitry Osipenko wrote:
>> 11.11.2020 08:53, Viresh Kumar пишет:
>>>> +static int tegra_emc_opp_table_init(struct tegra_emc *emc)
>>>> +{
>>>> +	struct opp_table *reg_opp_table = NULL, *clk_opp_table, *hw_opp_table;
>>>> +	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
>>>> +	const char *rname = "core";
>>>> +	int err;
>>>> +
>>>> +	/*
>>>> +	 * Legacy device-trees don't have OPP table and EMC driver isn't
>>>> +	 * useful in this case.
>>>> +	 */
>>>> +	if (!device_property_present(emc->dev, "operating-points-v2")) {
>>> I don't understand why you want to check this ? The below call to
>>> dev_pm_opp_of_add_table() will fail anyway and that should be good for
>>> you.
>>>
>>
>> The dev_pm_opp_of_add_table() will produce a error message which doesn't
>> give a clue about what's wrong, i.e. that device-tree needs to be updated.
> 
> If you think that you need to print something more, then you can do
> that in the error message you print when dev_pm_opp_of_add_table()
> fails. I would suggest to drop this redundant check here.
> 

Please give the rationale.
