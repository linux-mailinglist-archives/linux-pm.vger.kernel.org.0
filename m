Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A482A16843F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 17:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgBUQ44 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 11:56:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44000 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUQ44 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 11:56:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id s23so1975938lfs.10;
        Fri, 21 Feb 2020 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fwegg2HlpK4JF2aVbulA8/ftyIkohgE1V4kH8GxtBTQ=;
        b=IHVHZNzzf0h39DqUgOalVDx2Pu+ZXDeN6kdQ/YgaTnYu4QDzYWh120ep9v/CFboKMn
         n/4cOaZB5yVKfPdqM/LL3xKMVIHpSwX5rJZPWu7St5yzEPgHHaZK3VEMti5MpP3j7N5V
         LPJ2wpgTgAW5TglsqgCYQU5MRo/1Y3Is/jkSFye7gO2gXwHBXKpmbYcVm49rq2+fy2WV
         2u8xbgAS3VlDA+WFb+1tcRfmxHJnOsl6CWfYolsYAlyNFWvrBLw+l3lE5cch+VwCglqD
         /hMM03vZUCSBGwp5MIl2jWKrty3VwNZOiCOPg+OOgUS2vc9A4LUkXSYD3+I59OkBZrsw
         pjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fwegg2HlpK4JF2aVbulA8/ftyIkohgE1V4kH8GxtBTQ=;
        b=lbncgQHbtQ5JB4uzoSJzAAJ9JAWAuOPl0icho8V4NIenJ9Bhx5ryN8/oo2YyCS1h+b
         HLfmPIv3eUauy7VB3HaIORlQQqS1UFib8hV0QYoA58LUJpNC7QkeaGUGoIgWTgS2eG8P
         zvm4CBCXT3n7VSOJNOBHAqzGYHiUuCIDjd5VAeKm9/vaLS1nVV/lPORsCJ4XhEnz7Gxe
         WKVV5YZR2qavHTqwSimT8C8+0g0T0sEfeuGEtXIieDiPWXkVF9p9peHF1gPxOEmvBR50
         8w2C4I/5UNGDPRkdvUvl3n7zJ75NJgrlTE7s7rTiHrTZ2+5c9KGm0tpYdQL0tP6hbHoP
         F4+g==
X-Gm-Message-State: APjAAAUtvIVH4LCnGfgXpTzwaR8IwXKt7M0zxz7aha/jo6bGlpdn391H
        30Ab9lMhzC4jKzEeP5OYJE46FcYp
X-Google-Smtp-Source: APXvYqz1KcC8BVNZ2zdpxRkUqxE5VF2zYg0axagGhwMxvk27L/dzX50vdNsq5s0e6tdgX+XYfcTvAg==
X-Received: by 2002:ac2:52a5:: with SMTP id r5mr20491810lfm.19.1582304213465;
        Fri, 21 Feb 2020 08:56:53 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n3sm1957554lfk.61.2020.02.21.08.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:56:52 -0800 (PST)
Subject: Re: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where
 secondary CPU hangs on entering LP2
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-10-digetx@gmail.com>
 <20200221154318.GO10516@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <239a2b66-8da8-2e6c-d19d-9ed207ad0a64@gmail.com>
Date:   Fri, 21 Feb 2020 19:56:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200221154318.GO10516@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Daniel,

21.02.2020 18:43, Daniel Lezcano пишет:
> On Thu, Feb 13, 2020 at 02:51:26AM +0300, Dmitry Osipenko wrote:
>> It is possible that something may go wrong with the secondary CPU, in that
>> case it is much nicer to get a dump of the flow-controller state before
>> hanging machine.
>>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Jasper Korten <jja2000@gmail.com>
>> Tested-by: David Heidelberg <david@ixit.cz>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/cpuidle-tegra20.c | 47 +++++++++++++++++++++++++--
>>  1 file changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
>> index 9672c619f4bc..bcc158b72e67 100644
>> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
>> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
>> @@ -83,14 +83,57 @@ static inline void tegra20_wake_cpu1_from_reset(void)
>>  }
>>  #endif
>>  
>> +static void tegra20_report_cpus_state(void)
>> +{
>> +	unsigned long cpu, lcpu, csr;
>> +
>> +	for_each_cpu(lcpu, cpu_possible_mask) {
>> +		cpu = cpu_logical_map(lcpu);
>> +		csr = flowctrl_read_cpu_csr(cpu);
>> +
>> +		pr_err("cpu%lu: online=%d flowctrl_csr=0x%08lx\n",
>> +		       cpu, cpu_online(lcpu), csr);
>> +	}
>> +}
>> +
>> +static int tegra20_wait_for_secondary_cpu_parking(void)
>> +{
>> +	unsigned int retries = 3;
>> +
>> +	while (retries--) {
>> +		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
> 
> Oops I missed this one. Do not use ktime_get() in this code path, use jiffies.

Could you please explain what benefits jiffies have over the ktime_get()?

>> +
>> +		/*
>> +		 * The primary CPU0 core shall wait for the secondaries
>> +		 * shutdown in order to power-off CPU's cluster safely.
>> +		 * The timeout value depends on the current CPU frequency,
>> +		 * it takes about 40-150us  in average and over 1000us in
>> +		 * a worst case scenario.
>> +		 */
>> +		do {
>> +			if (tegra_cpu_rail_off_ready())
>> +				return 0;
>> +
>> +		} while (ktime_before(ktime_get(), timeout));
> 
> So this loop will aggresively call tegra_cpu_rail_off_ready() and retry 3
> times. The tegra_cpu_rail_off_ready() function can be called thoushand of times
> here but the function will hang 1.5s :/
> 
> I suggest something like:
> 
> 	while (retries--i && !tegra_cpu_rail_off_ready()) 
> 		udelay(100);
> 
> So <retries> calls to tegra_cpu_rail_off_ready() and 100us x <retries> maximum
> impact.
But udelay() also results into CPU spinning in a busy-loop, and thus,
what's the difference?
