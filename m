Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DF211B61
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 07:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgGBFHZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 01:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgGBFHY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 01:07:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C868DC08C5C1;
        Wed,  1 Jul 2020 22:07:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so30047531ljo.0;
        Wed, 01 Jul 2020 22:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K8qAxukp9RFHBdE6WbPdUscXd1LN37Q3w/L7nkVqajo=;
        b=VqmofHQSAPlBpUCxL4rTflz7VqMU9XTFBswSFaT0mDdL6H43EXQ6FW5GHx4GlI7qGQ
         fEWxbeqBLWdHdB3DYZYDwPVZ0TiKrh8ErZ7LQelQzlLERoz5pvCKWWqfZaEFF2S7Qfxi
         nTsyD4aCv1sdijFfHId/0snc/8sfXCxZIWVg45Q9+5LcS+t2jODYxnCfWthpcsa1xAMi
         wUPvrBa4VAWOIzAfn3408W/wDQyJMf+AWsYE39v3QnoIg8h6UBoemF34AiS3v2wY97B3
         +G8SYZZqXujqM4GXX1thRU7Z0izEwGNmZA27wVvteuiL68sk+Y/utUm12dBmn44goyca
         d19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K8qAxukp9RFHBdE6WbPdUscXd1LN37Q3w/L7nkVqajo=;
        b=oEM7oMR4lWJMyqV451Zwlx02i5lgkpKZJoP9/jm44OKIDV+0M9OCqVy/o3DH9ruzU4
         2WU6sVqTD5i1eSPWoWyglMOKPO0l8FEKK9BAB+M5qz/2woBor+mLqNCFQn6O0aYjyEKf
         AuzXvfJnufDB9yCe5HGWgcz6Y9mwYxTUNY6hK1OEQyxM3+8ZdyqQHK7KOPAOdW+7G8CY
         sMzGYJpMQhxm+XmHJzlJ6x1+SnAo0Nv+SN1ZfllgLBboWsQktKWdWYM8HfNGZUWbaG4c
         AdfW+Gp43EXWf2T/nOniWtRlkJS3iWZSJJxyTH56kOCEHnskYUkNb0VIhQ64JwjbiiJA
         TzaQ==
X-Gm-Message-State: AOAM5334G8lK1a7xcI/4L2rSwHDyrewD2AltK5IhkowigPqXQkvudNWP
        Hn3gYiYOv3KN6+8zux/KRWBf0HnyslA=
X-Google-Smtp-Source: ABdhPJwLKDqPP4hbBy1c68/UE02Q/XfYccws317CV11krxYDMmfgvP+z/OUQQesuwn5uoDx9F/1QfA==
X-Received: by 2002:a2e:9b94:: with SMTP id z20mr13271728lji.404.1593666441965;
        Wed, 01 Jul 2020 22:07:21 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id w19sm1331770ljm.120.2020.07.01.22.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 22:07:20 -0700 (PDT)
Subject: Re: [PATCH v4 12/37] PM / devfreq: tegra20: Use MC timings for
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
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <CGME20200609131458epcas1p2c774a0302bcef2c02790c2cb8cad57a0@epcas1p2.samsung.com>
 <20200609131404.17523-13-digetx@gmail.com>
 <4ea7fe00-7676-3186-8222-6e0d0eb8ed1f@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4b22d3ee-f303-d81d-e261-187d4a46e749@gmail.com>
Date:   Thu, 2 Jul 2020 08:07:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4ea7fe00-7676-3186-8222-6e0d0eb8ed1f@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.07.2020 07:18, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 6/9/20 10:13 PM, Dmitry Osipenko wrote:
>> The clk_round_rate() won't be usable for building OPP table once
>> interconnect support will be added to the EMC driver because that CLK API
>> function limits the rounded rate based on the clk rate that is imposed by
>> active clk-users, and thus, the rounding won't work as expected if
>> interconnect will set the minimum EMC clock rate before devfreq driver is
>> loaded. The struct tegra_mc contains memory timings which could be used by
>> the devfreq driver for building up OPP table instead of rounding clock
>> rate, this patch implements this idea.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra20-devfreq.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
>> index 6469dc69c5e0..bf504ca4dea2 100644
>> --- a/drivers/devfreq/tegra20-devfreq.c
>> +++ b/drivers/devfreq/tegra20-devfreq.c
>> @@ -123,8 +123,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  {
>>  	struct tegra_devfreq *tegra;
>>  	struct tegra_mc *mc;
>> -	unsigned long max_rate;
>> -	unsigned long rate;
>> +	unsigned int i;
>>  	int err;
>>  
>>  	mc = tegra_get_memory_controller();
>> @@ -151,12 +150,17 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  
>>  	tegra->regs = mc->regs;
>>  
>> -	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>> -
>> -	for (rate = 0; rate <= max_rate; rate++) {
>> -		rate = clk_round_rate(tegra->emc_clock, rate);
>> +	if (!mc->num_timings) {
> 
> Could you explain what is meaning of 'num_timing?

The num_timings is the number of memory timings defined in a
device-tree. One timing configuration per memory clock rate.

> Also, why add the opp entry in case of mc->num_timings is zero?

Timings may be not defined in some device-trees at all and in this case
memory always running on a fixed clock rate.

The devfreq driver won't be practically useful if mc->num_timings is
zero since memory frequency can't be changed, but anyways we'd want to
load the devfreq driver in order to prevent confusion about why it's not
loaded.

For example, you may ask somebody to show contents of
/sys/class/devfreq/tegra20-devfreq/trans_stat and the person says to you
that this file doesn't exist, now you'll have to figure out what
happened to the devfreq driver.
