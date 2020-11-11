Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FF2AE8AB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 07:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgKKGOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 01:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKGOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 01:14:46 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8971EC0613D1;
        Tue, 10 Nov 2020 22:14:44 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id e27so1621827lfn.7;
        Tue, 10 Nov 2020 22:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lEYEjKzJU66Ij93I8jWPRFuo7Pd1or5OxSnq43v1nCk=;
        b=u3C6K+j11FR9CFXaV+VOXGecYwd6QzEZya9r+zI3shRFCtNk2YKCxN+0npZuwEIP5C
         y824Nl/hx8yxsqA1zs7NdnQQ4rjDBNU4CDXEzxLFmOIjQEHkbFj0vh08mhIAruNoNkjO
         JSe6AuXggENBuikW7sMzMCwIVyV9mtMmIloNPUUfztbhK64OEhp8qhVFjdBPfwSDtzv0
         CFx1SNiEriNpMPICEFaLSNdvh/j6gevGUy5KZA5Itd0a6X6GNXIcEkEO8JXVXlPkWTEo
         pjW2AYh/fOcg+V51KLFlt9rZc091RaXAK5VssQMSItVKHd9NLTURjirC8byG1kwfQB4c
         hgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lEYEjKzJU66Ij93I8jWPRFuo7Pd1or5OxSnq43v1nCk=;
        b=aDAWuX5F5ejlDA2d7EN7Ygm2Dk8aEgUVnLPN4kjzIBiDwBwgMrpja6n1iAIJtYyHNj
         CmLxc/5NkAY3tnp7RKh4nkFFXOU7SyIRzD0JMv8rt75+K18ji00OUV0LABg00hKqxOWB
         s3hqC+ylzq138cKWnBD/F5P38sn9z9tIrS6hyP+f/1Nh7YNqoWwq15I65ZwIMjGVH5qE
         gRZM9KkrM44+2pTZhWCj/yUcKGecadCj9Pqi7vtNXuuCrGJ2ArPGbTVYRaC1G5F1c5Tk
         qOexjEo+WmZKLZ0WhhZHEzDNfyBLG3batB0t4jQ5e88fJRtwOgvSfy+vWFidpgHE+WOZ
         1gKA==
X-Gm-Message-State: AOAM532FSqu5iPQNuFHE0Rp6EWHqho+3Zm8yFABuoWgd1Z7V8a0FWF1k
        3QrpZlhkHT6iMAylFtwq0WA=
X-Google-Smtp-Source: ABdhPJzLehGf18xxtBKtRyrfI/6NG1g3yu2AS/fS5MEUZSbxrjK+f66FKyA/QSbiAyVs+WiZ9diPdA==
X-Received: by 2002:a19:8854:: with SMTP id k81mr2400616lfd.195.1605075283102;
        Tue, 10 Nov 2020 22:14:43 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id s5sm121375lfd.58.2020.11.10.22.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 22:14:42 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <185e9140-fdce-29ef-68c3-aa7da02b249d@gmail.com>
Date:   Wed, 11 Nov 2020 09:14:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111055313.tefidnmc7f4yb3jk@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.11.2020 08:53, Viresh Kumar пишет:
>> +static int tegra_emc_opp_table_init(struct tegra_emc *emc)
>> +{
>> +	struct opp_table *reg_opp_table = NULL, *clk_opp_table, *hw_opp_table;
>> +	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
>> +	const char *rname = "core";
>> +	int err;
>> +
>> +	/*
>> +	 * Legacy device-trees don't have OPP table and EMC driver isn't
>> +	 * useful in this case.
>> +	 */
>> +	if (!device_property_present(emc->dev, "operating-points-v2")) {
> I don't understand why you want to check this ? The below call to
> dev_pm_opp_of_add_table() will fail anyway and that should be good for
> you.
> 

The dev_pm_opp_of_add_table() will produce a error message which doesn't
give a clue about what's wrong, i.e. that device-tree needs to be updated.
