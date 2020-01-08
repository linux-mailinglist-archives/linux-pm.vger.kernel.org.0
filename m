Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B832D1344C4
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgAHOOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 09:14:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38130 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgAHOOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 09:14:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so3487618ljh.5;
        Wed, 08 Jan 2020 06:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CdGySK3pZXwB/PPQM7f/yyKxyshXDq+wMrNCv/37ldE=;
        b=hU51rfnbXlUtCFHfJVY73lxfJBkXeW5apar9eunE38IHx4FDr1MThm3o5ByCu7e9KS
         03l9d72YV4cz3jMWhItwPeSpzOrmhzzBYh7IrHITASuFMTFVlzI3Zqgs2epFUIlbS6Nl
         emZOUX/kINUoWWi30Ue8vQZQ0GgsVFdh4Yejls1f6UbB0Z2gG8b2FklsVEao40UVjmL1
         1fcEpt5e8Bb0HVDA6GyFS3biUQebvgpzq6KZoC2fbOaS8gPV7HuOv9iWPKi9RwDLH8QH
         fv2XUmu9Bm+6WiJj2hFTgBTGopG2Qel37v31AXE7IHWLDwic7WlK4XJtTBtweuON4QhR
         RY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CdGySK3pZXwB/PPQM7f/yyKxyshXDq+wMrNCv/37ldE=;
        b=TfMDIgv8wcV/LZyZ/XHKBNCNHhoiXDnR2JFNsUBHxxveQKBclwki0RKgO3y8QIGHl1
         70bfoENTGCFx4Dj+MXriH5henQDTYIGSTrak4lQYdXBl6HAvYV0jm7+nfvu6QE+l4IfO
         h//7KmXaip1cscy28oWk2U14ELzU2sMqrb1tl6w1n5e5MiaMThKLn51+3Nwel84mQCtS
         wsGDiDvUB0UTcAyKzBgdQEQPkwXk/qNyQGYlLDayFVfQPECjVdUGqEnefHYvsMSbf9er
         cyrgUnIKsgdd/GSYZQOF1w0vMyaPGte87jZw9i2+zyaphwz46JP/ZhLAaf3qXRAIxuFt
         9Vwg==
X-Gm-Message-State: APjAAAW9kmYXtRYuYNUemQgPwk6hmUT5D7FOBg6gj97Y1bUWk6i0A89n
        cgMfJ1a+Ci6bG4O4PPd4pBY=
X-Google-Smtp-Source: APXvYqwk+WIH8UvqGP8kAxbwsV/meTm5j1ausVAdtqrdXW3IiKJO6f04Hw9RNGhiubrx95mWIeDQlw==
X-Received: by 2002:a2e:9143:: with SMTP id q3mr3076177ljg.199.1578492861038;
        Wed, 08 Jan 2020 06:14:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id o10sm1479361lfn.20.2020.01.08.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:14:20 -0800 (PST)
Subject: Re: [PATCH 1/2] PM / devfreq: Add debugfs support with
 devfreq_summary file
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20200107090519.3231-1-cw00.choi@samsung.com>
 <CGME20200107085812epcas1p12121f8ef6492ed78053dea4977216788@epcas1p1.samsung.com>
 <20200107090519.3231-2-cw00.choi@samsung.com> <20200107211558.GA738324@yoga>
 <19fd2201-2a7d-46df-09cf-e39f6668b488@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <daf456c6-7897-3086-329c-e2fd76e75f37@gmail.com>
Date:   Wed, 8 Jan 2020 17:14:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <19fd2201-2a7d-46df-09cf-e39f6668b488@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.01.2020 10:56, Chanwoo Choi пишет:
> On 1/8/20 6:15 AM, Bjorn Andersson wrote:
>> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
>>
>>> Add debugfs interface to provide debugging information of devfreq device.
>>> It contains 'devfreq_summary' entry to show the summary of registered
>>> devfreq devices as following and the additional debugfs file will be added.
>>> - /sys/kernel/debug/devfreq/devfreq_summary
>>>
>>> [Detailed description of each field of 'devfreq_summary' debugfs file]
>>> - dev_name	: Device name of h/w.
>>> - dev		: Device name made by devfreq core.
>>> - parent_dev	: If devfreq device uses the passive governor,
>>> 		  show parent devfreq device name.
>>> - governor	: Devfreq governor.
>>> - polling_ms	: If devfreq device uses the simple_ondemand governor,
>>> 		  polling_ms is necessary for the period. (unit: millisecond)
>>> - cur_freq_hz	: Current Frequency (unit: hz)
>>> - old_freq_hz	: Frequency before changing. (unit: hz)
>>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>>
>>> [For example on Exynos5422-based Odroid-XU3 board]
>>> - In order to show the multiple governors on devfreq_summay result,
>>> change the governor of devfreq0 from simple_ondemand to userspace.
>>>
>>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>>> dev_name                       dev        parent_dev governor        polling_ms cur_freq_hz  min_freq_hz  max_freq_hz
>>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>>> 10c20000.memory-controller     devfreq0              userspace       0          206000000    165000000    825000000
>>> soc:bus_wcore                  devfreq1              simple_ondemand 50         532000000    88700000     532000000
>>> soc:bus_noc                    devfreq2   devfreq1   passive         0          111000000    66600000     111000000
>>> soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          222000000    111000000    222000000
>>> soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    75000000     200000000
>>> soc:bus_fsys2                  devfreq5   devfreq1   passive         0          200000000    75000000     200000000
>>> soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    83250000     333000000
>>> soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000    88700000     266000000
>>> soc:bus_peri                   devfreq8   devfreq1   passive         0          66600000     66600000     66600000
>>> soc:bus_g2d                    devfreq9   devfreq1   passive         0          0            83250000     333000000
>>> soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          0            66500000     266000000
>>> soc:bus_jpeg                   devfreq11  devfreq1   passive         0          0            75000000     300000000
>>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          0            83250000     166500000
>>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          0            120000000    200000000
>>> soc:bus_disp1                  devfreq14  devfreq1   passive         0          0            120000000    300000000
>>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          0            150000000    300000000
>>> soc:bus_mscl                   devfreq16  devfreq1   passive         0          0            84000000     666000000
>>
>> This looks quite useful.
>>
>>>
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> May I ask how the build test robot came up with this idea?
> 
> I'm missing the detailed what are the reported by kbuild test robot.
> It reported the possible build error. I'll add the following description
> on next version:
> 	[lkp: Reported the build error]
> 
>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 80 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 80 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> [..]
>>> +/**
>>> + * devfreq_summary_show() - Show the summary of the registered devfreq devices
>>> + *				via 'devfreq_summary' debugfs file.
>>
>> Please make this proper kerneldoc, i.e:
>>
>>  * func() - short description
>>  * @s:
>>  * @data:
>>  * 
>>  * Long description
>>  * 
>>  * Return: foo on bar
> 
> OK.
> 
>>
>> [..]
>>> @@ -1733,6 +1803,16 @@ static int __init devfreq_init(void)
>>>  	}
>>>  	devfreq_class->dev_groups = devfreq_groups;
>>>  
>>> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
>>> +	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs)) {
>>
>> Don't PTR_ERR() before IS_ERR().
> 
> Before checking IS_ERR(), have to check the PTR_ERR(devfreq_debugfs)
> is -ENODEV or not because debugfs_create_dir return the '-ENODEV'
> if DEBUG_FS is disabled. If return the -ENODEV, it is not error.

You could write it this way:

	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
	err = PTR_ERR_OR_ZERO(devfreq_debugfs);
	if (err && err != -ENODEV) {
	...
