Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3477A14FB23
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2020 02:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgBBBIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Feb 2020 20:08:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42448 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBBBIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Feb 2020 20:08:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so10960992ljl.9;
        Sat, 01 Feb 2020 17:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KkxpqI/EsjGE/4RKhT6G//VJu5zP3wk8mfvrv9Ew9SA=;
        b=dl4Wcm9Ihv5Sg21kdP/quxulIbYBw5ctGbYxV3EOOUc5KTsCEDjnlPC0f24Nuv2fCR
         X7fK5sQCHGypkfDgt2qrvwxem3k9jxrKERoXG6ZtgK4/fgZSQx7fKwCasZow2U9+tqQe
         JSfNSydMI2RTe8InRKbZGVNdu4TG6HZE9rEXP8WKKIgh0W7UFUpol4+YOkAFhSy5hy/H
         t2PbgIW1wmwAmbDezD61WYXLy/om8Q+8Sldy2Z7cb6GBLuPYy0C6rNgq3rffi32yo2qx
         wXn55jBbjEslf83in2VsEFollo4MJpuHXt+hf4VAtTHUQ/V2bdf13ayiyN9xhDvwFRgg
         UN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KkxpqI/EsjGE/4RKhT6G//VJu5zP3wk8mfvrv9Ew9SA=;
        b=jKmrO+e58pDtgQR2laZOqKb4wesinuMg8Ae5X+QkGmFnuR12jNUqbU3yHy6TDRo8sU
         J0nBJ0FzOGtSHzErCgwwvc92hgObzJkLSzuQu2R6+PoGaF8ZkOu68roFzjZnPHsDrJ4t
         rWF5ParGIzewZZzhi4O8bIm+apgOm4vstinPyfDQ3t4EgZRszPusXnWmryr9wi5vriGf
         9qXd86N/BKuKEfIkQktniUZqDQtYlt+ww+V787QZhrRalS/xUUOCTzCWeHwG2bBnnuDs
         PZXYKA51JvwLDrL8cEL5dnNh2qyWcjSled4S7nQydFBr45AbyVFvvK8esrePx1kVAHdk
         OYNg==
X-Gm-Message-State: APjAAAXx7awglmvJDzPBvVUQ3ipJIZM8ubAeZ3ZqF+1w3YhXu8W68vfp
        wCRgYbaviDbi2O9xLOs0Q6A4WPXI
X-Google-Smtp-Source: APXvYqykYMLNDxOFQTCUm1Msd+TJagDhimZVAVXV1U8WmwhvwGpHe8sOK8r6Tr6az+IksMoG+HbRVQ==
X-Received: by 2002:a2e:880c:: with SMTP id x12mr10109100ljh.44.1580605698028;
        Sat, 01 Feb 2020 17:08:18 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l64sm6677014lfd.30.2020.02.01.17.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 17:08:17 -0800 (PST)
Subject: Re: [PATCH v6 07/12] ARM: tegra: Don't enable PLLX while resuming
 from LP1 on Tegra30
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191218202142.11717-1-digetx@gmail.com>
 <20191218202142.11717-8-digetx@gmail.com>
 <334ac00a0c83e4178e3195cca5d77acaf4a3fae7.camel@ziswiler.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <31e4cf7e-9bdc-c9f8-7e6d-a972f43fc5be@gmail.com>
Date:   Sun, 2 Feb 2020 04:08:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <334ac00a0c83e4178e3195cca5d77acaf4a3fae7.camel@ziswiler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.02.2020 01:57, Marcel Ziswiler пишет:
> Hi Dmitry
> 
> Finally, I came around giving this a try again on the Colibri T20 and
> Apalis/Colibri T30.
> 
> Overall, works like a charm and you may add the following to the entire
> series:
> 
> On Wed, 2019-12-18 at 23:21 +0300, Dmitry Osipenko wrote:
>> PLLX may be kept disabled if cpufreq driver selects some other clock
>> for
>> CPU. In that case PLLX will be disabled later in the resume path by
>> the
>> CLK driver, which also can enable PLLX if necessary by itself. Thus
>> there
>> is no need to enable PLLX early during resume. Tegra114/124 CLK
>> drivers do
>> not manage PLLX on resume and thus they are left untouched by this
>> patch.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
> Tested-on: Colibri T20, Apalis/Colibri T30 on resp. EvalBoards

Hello Marcel,

Thank you very much for the testing! Very appreciate that!

Could you please clarify whether you tried to enable the CPU DVFS by
including OPPs/etc into device-tree files of the tested boards?

>> ---
>>  arch/arm/mach-tegra/sleep-tegra30.S | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-
>> tegra/sleep-tegra30.S
>> index 9a20c93abe48..4f073869b8ac 100644
>> --- a/arch/arm/mach-tegra/sleep-tegra30.S
>> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
>> @@ -358,7 +358,6 @@ _no_pll_iddq_exit:
>>  
>>  	pll_enable r1, r0, CLK_RESET_PLLM_BASE, CLK_RESET_PLLM_MISC
>>  	pll_enable r1, r0, CLK_RESET_PLLC_BASE, CLK_RESET_PLLC_MISC
>> -	pll_enable r1, r0, CLK_RESET_PLLX_BASE, CLK_RESET_PLLX_MISC
>>  
>>  _pll_m_c_x_done:
>>  	pll_enable r1, r0, CLK_RESET_PLLP_BASE, CLK_RESET_PLLP_MISC
>> @@ -368,8 +367,18 @@ _pll_m_c_x_done:
>>  	pll_locked r1, r0, CLK_RESET_PLLP_BASE
>>  	pll_locked r1, r0, CLK_RESET_PLLA_BASE
>>  	pll_locked r1, r0, CLK_RESET_PLLC_BASE
>> +
>> +	/*
>> +	 * CPUFreq driver could select other PLL for CPU. PLLX will be
>> +	 * enabled by the Tegra30 CLK driver on an as-needed basis, see
>> +	 * tegra30_cpu_clock_resume().
>> +	 */
>> +	cmp	r10, #TEGRA30
>> +	beq	_pll_m_c_x_locked
>> +
>>  	pll_locked r1, r0, CLK_RESET_PLLX_BASE
>>  
>> +_pll_m_c_x_locked:
>>  	mov32	r7, TEGRA_TMRUS_BASE
>>  	ldr	r1, [r7]
>>  	add	r1, r1, #LOCK_DELAY
> 
> Unfortunately, that one does no longer apply after the following patch
> recently got applied on Wed Jan 8:
> 
> commit 1a3388d506bf ("ARM: tegra: Enable PLLP bypass during Tegra124
> LP1")
> 
> Thanks!

Yes, I'm aware about it and going to send out the updated version of the
patches soon. Meanwhile you could find recent rebase of the patches here
[1].

[1] https://github.com/grate-driver/linux/commits/master
