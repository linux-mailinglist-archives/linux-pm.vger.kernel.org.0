Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280512FA8F6
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 19:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393654AbhARSgR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 13:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407690AbhARSfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 13:35:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F774C061574;
        Mon, 18 Jan 2021 10:35:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s26so25409335lfc.8;
        Mon, 18 Jan 2021 10:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJQ7iXT5ZJJPGjCWc7ZOg3Jpy57FUNGSPots343V6k8=;
        b=IKNVZurPpwbxQi3xk/Clq+rIAj62XBhEdmVhP58GRiJjUuXEAZslFUxhoa/8kxXvEU
         gTtDcdLgFaZ0UAPzQYsdeZZzAOMi2CFP5sxEHPxqlrb3zopA1E6hEXeZ4ZY1zqyhioHB
         2uG/p2g1rOwbpVotyMsBqBcED5/MKoWGqt8Y4zul52D1FO8tyN0NbdDM/HmJkGQ8Vszn
         O8RS2tJNi+DAiFEPPyAc+R4t3r03xwTv54Qre2xRNCXq/SV6aF2/dgSFIKOEQMvZHNnG
         6zoXZaWQxf+C8IN+x6NPwMn6p4Zo8wj+5/RlNR76i6rmb87HRh2fq1ydUryxJgNr6fwQ
         3sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJQ7iXT5ZJJPGjCWc7ZOg3Jpy57FUNGSPots343V6k8=;
        b=D66WZexjx100P/T29vwEF322empwVZ2/Tadcqri2LI2ZJnkjap5fz8S5SfsuHHubzg
         SMw/VKj509wVpR2waau+eKf+IZaqQJlfr5/7SSSvNXzDSoZ94F9QzZDrZchkcv7Wgt+B
         rYta9UPB8lhqzcVVOLk93UQmLZ+cu5uT8CnSXsV2VsSjJElBEIvXCnVyACRV634zyDlm
         Hv3jFHybWAupzm7ewHl3aZ1LC/5TAoCTQf+GTH/8ge4jXvhB51I9NXTJAK5z8GbLZNkW
         QLi1Kbsrfl/4ecxFVmjSDLdoTpz2tIvjPuldoRmStnOj7lH7iH0yiEBmEXiPkHCXsZPl
         VEHQ==
X-Gm-Message-State: AOAM530ClZrJZewrkNUHBvf6BWVIAcAWpevQee4+m8I/A+nQGM0Xct9R
        ybqvHZgsTmddBgK5r09GchamuiATV04=
X-Google-Smtp-Source: ABdhPJyZo4KZcV7s56vOT07NUXhRMBh8KcsWPfNtNu+wnqlNtl80pkRMbSaZuOv2tb32jORs1eijvw==
X-Received: by 2002:ac2:4a75:: with SMTP id q21mr190165lfp.119.1610994906533;
        Mon, 18 Jan 2021 10:35:06 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id w24sm1980365lfl.199.2021.01.18.10.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:35:05 -0800 (PST)
Subject: Re: [PATCH v3 04/12] opp: Add dev_pm_opp_sync_regulators()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-5-digetx@gmail.com>
 <20210118082013.32y5tndlbw4xrdgc@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4acde958-91c1-bbcb-6e20-2d90cf0e57d3@gmail.com>
Date:   Mon, 18 Jan 2021 21:35:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210118082013.32y5tndlbw4xrdgc@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.01.2021 11:20, Viresh Kumar пишет:
>> +int dev_pm_opp_sync_regulators(struct device *dev)
>> +{
>> +	struct opp_table *opp_table;
>> +	struct regulator *reg;
>> +	int i, ret = 0;
>> +
>> +	/* Device may not have OPP table */
>> +	opp_table = _find_opp_table(dev);
>> +	if (IS_ERR(opp_table))
>> +		return 0;
>> +
>> +	/* Regulator may not be required for the device */
>> +	if (!opp_table->regulators)
>> +		goto put_table;
>> +
>> +	mutex_lock(&opp_table->lock);
> What exactly do you need this lock for ?

It is needed for protecting simultaneous invocations of
dev_pm_opp_sync_regulators() and dev_pm_opp_set_voltage().

The sync_regulators() should be invoked only after completion of the
set_voltage() in a case of Tegra power domain driver since potentially
both could be running in parallel. For example device driver may be
changing performance state in a work thread, while PM domain state is
syncing.

But maybe it will be better to move the protection to the PM driver
since we're focused on sync_regulators() and set_voltage() here, but
there are other OPP API functions which use regulators. I'll need to
take a closer look at it.
