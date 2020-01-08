Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36111344EB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgAHOXt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 09:23:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41912 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHOXs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 09:23:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so2571571lfp.8;
        Wed, 08 Jan 2020 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MEqBGsSI7zzflI8IN1QThmHm41BW1b/LInp0ccjStXc=;
        b=BNKP26iSRnefl+ClXTFYwUBGJOSDSvdU1/eZOd+Mm7Fr0000VPeUrVygs+FGNe8xi1
         YJ0tQ5C4K2tjYVhoSGVKWJwprq88Lxiv7Rd2WWi4Ao3j528H5rgSUuV3rjkAvJITg6SE
         jPVrskZHU96pX1PSMhq5KGuH+6ycMNsq0IjQ/pqwHIxamRp6Ql3bB7xcQIu5LZBRY00o
         uBxnUSjLspUc99gXr7Vt90EJQ/omupIIoFVCVtel8V2YGWVocLzEN7eHcqFg+990mAOQ
         LRdBi3gHVr2Y/1Rez+RXfqOYYo9VrBIuyZ8UsCe8LSM+XjnKRbMikysLmlD1oSvFMlIe
         6ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MEqBGsSI7zzflI8IN1QThmHm41BW1b/LInp0ccjStXc=;
        b=Nf0n01mUdWXzmS3ETkH8Ze3SwohT3SdNobeLGxPtEwkPNIWfYXC5eK4TZa2woq/Lkf
         nBtopzqWDr/T71BlEbUQ4tSTWpswX05vlpMpVGB1lK1AmdIwzoj/rVDTcT3C5qBziMK6
         mQ1HY2Ic++25iYLYEG342I5WPDtpWOk7In9aM+yploG3B8PxzUOaRaZKFph9Lk/QUq7R
         4nqt1jG+vXX/W7Khu7Kx1TFAszKEZSgkVtcGof5/ULeJruuXSpMTgQghmg3tSIhUBCPe
         oceV2d6OWqyBcJ6Snav3p7KHDzghtc5AkoDTV8zRA+x4F6dwYshd1JY0Cgl9FCZclHpP
         nyvw==
X-Gm-Message-State: APjAAAVMgmsKcKdzOx3Y2qdjMFUdrgXjIxHLg5pwC1YhJVCu7eT/J5GL
        VfjjcSX5LBUedOHpwp4iEwY=
X-Google-Smtp-Source: APXvYqzT4EM6QMxDqh62Oy8XjjiPDOPWGzwlK8Xu0ArhAGAxUH3w8na8HcQ1w83W7C/QDc78AteJvA==
X-Received: by 2002:a05:6512:48c:: with SMTP id v12mr3187710lfq.56.1578493425959;
        Wed, 08 Jan 2020 06:23:45 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n11sm1361581ljg.15.2020.01.08.06.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:23:45 -0800 (PST)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20200107090519.3231-1-cw00.choi@samsung.com>
 <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
 <20200107090519.3231-3-cw00.choi@samsung.com>
 <2c259936-f099-a239-9d6b-08f9b253644f@gmail.com>
 <92367824-d0ac-1be3-e432-292ea1796143@samsung.com>
 <e58888d7-9803-da5e-1054-690fe52284a1@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3381b9a0-1023-f11c-1348-44f9de0e0e17@gmail.com>
Date:   Wed, 8 Jan 2020 17:23:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e58888d7-9803-da5e-1054-690fe52284a1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.01.2020 15:01, Chanwoo Choi пишет:
> On 1/8/20 7:56 PM, Chanwoo Choi wrote:
>> Hi,
>>
>> On 1/8/20 6:31 AM, Dmitry Osipenko wrote:
>>> Hello Chanwoo,
>>>
>>> 07.01.2020 12:05, Chanwoo Choi пишет:
>>>> Add new devfreq_transitions debugfs file to track the frequency transitions
>>>> of all devfreq devices for the simple profiling as following:
>>>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>>>
>>>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>>>> in Kconfig in order to save the transition history.
>>>>
>>>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>>>> - time_ms	: Change time of frequency transition. (unit: millisecond)
>>>> - dev_name	: Device name of h/w.
>>>> - dev		: Device name made by devfreq core.
>>>> - parent_dev	: If devfreq device uses the passive governor,
>>>> 		  show parent devfreq device name.
>>>> - load_%	: If devfreq device uses the simple_ondemand governor,
>>>> 		  load is used by governor whene deciding the new frequency.
>>>> 		  (unit: percentage)
>>>> - old_freq_hz	: Frequency before changing. (unit: hz)
>>>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>>>
>>>> [For example on Exynos5422-based Odroid-XU3 board]
>>>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>>>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>>>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>>>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>>>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>>>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>>>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>>>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>>>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>>>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>>>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>>>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>>>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>>>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>>>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>>>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>>>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>>>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>>>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>>>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>>>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>>>> [snip]
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  drivers/devfreq/Kconfig            |  13 +++
>>>>  drivers/devfreq/devfreq.c          | 126 +++++++++++++++++++++++++++++
>>>>  drivers/devfreq/governor.h         |   3 +
>>>>  drivers/devfreq/governor_passive.c |   2 +
>>>>  include/linux/devfreq.h            |   1 +
>>>>  5 files changed, 145 insertions(+)
>>>>
>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>> index 0b1df12e0f21..84936eec0ef9 100644
>>>> --- a/drivers/devfreq/Kconfig
>>>> +++ b/drivers/devfreq/Kconfig
>>>> @@ -74,6 +74,19 @@ config DEVFREQ_GOV_PASSIVE
>>>>  	  through sysfs entries. The passive governor recommends that
>>>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>>>>  
>>>> +comment "DEVFREQ Debugging"
>>>> +
>>>> +config NR_DEVFREQ_TRANSITIONS
>>>> +	int "Maximum storage size to save DEVFREQ Transitions (10-1000)"
>>>> +	depends on DEBUG_FS
>>>> +	range 10 1000
>>>> +	default "100"
>>>> +	help
>>>> +	  Show the frequency transitions of all devfreq devices via
>>>> +	  '/sys/kernel/debug/devfreq/devfreq_transitions' for the simple
>>>> +	  profiling. It needs to decide the storage size to save transition
>>>> +	  history of all devfreq devices.
>>>> +
>>>>  comment "DEVFREQ Drivers"
>>>>  
>>>>  config ARM_EXYNOS_BUS_DEVFREQ
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index c7f5e4e06420..7abaae06fa65 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -268,6 +268,57 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>>  }
>>>>  EXPORT_SYMBOL(devfreq_update_status);
>>>> +/**
>>>> + * devfreq_update_transitions() - Update frequency transitions for debugfs file
>>>> + * @devfreq:	the devfreq instance
>>>> + * @old_freq:	the previous frequency before changing the frequency
>>>> + * @new_freq:	the new frequency after frequency is changed
>>>> + */
>>>> +struct devfreq_transitions {
>>>> +	struct devfreq *devfreq;
>>>> +	struct devfreq_freqs freqs;
>>>> +	unsigned long load;
>>>> +} debugfs_transitions[CONFIG_NR_DEVFREQ_TRANSITIONS];
>>>> +
>>>> +static spinlock_t devfreq_debugfs_lock;
>>>
>>> This could be:
>>>
>>> static DEFINE_SPINLOCK(devfreq_debugfs_lock);
>>>
>>> and then spin_lock_init() isn't needed.
>>
>> OK
>>
>>>
>>>
>>> Also, The "<linux/spinlock.h>" should be included directly by devfreq.c
>>
>> OK.
>>
>>>
>>>> +static int debugfs_transitions_index;
>>>> +
>>>> +void devfreq_update_transitions(struct devfreq *devfreq,
>>>> +			unsigned long old_freq, unsigned long new_freq,
>>>> +			unsigned long busy_time, unsigned long total_time)
>>>> +{
>>>> +	unsigned long load;
>>>> +	int i;
>>>> +
>>>> +	if (!devfreq_debugfs || !devfreq || (old_freq == new_freq))
>>>> +		return;
>>>> +
>>>> +	spin_lock_nested(&devfreq_debugfs_lock, SINGLE_DEPTH_NESTING);
>>>> +
>>>> +	i = debugfs_transitions_index;
>>>> +
>>>> +	/*
>>>> +	 * Calculate the load and if load is larger than 100,
>>>> +	 * initialize to 100 because the unit of load is percentage.
>>>> +	 */
>>>> +	load = (total_time == 0 ? 0 : (100 * busy_time) / total_time);
>>>> +	if (load > 100)
>>>> +		load = 100;
>>>> +
>>>> +	debugfs_transitions[i].devfreq = devfreq;
>>>> +	debugfs_transitions[i].freqs.time = ktime_to_ms(ktime_get());
>>>> +	debugfs_transitions[i].freqs.old = old_freq;
>>>> +	debugfs_transitions[i].freqs.new = new_freq;
>>>> +	debugfs_transitions[i].load = load;
>>>> +
>>>> +	if (++i == CONFIG_NR_DEVFREQ_TRANSITIONS)
>>>> +		i = 0;
>>>> +	debugfs_transitions_index = i;
>>>> +
>>>> +	spin_unlock(&devfreq_debugfs_lock);
>>>> +}
>>>> +EXPORT_SYMBOL(devfreq_update_transitions);
>>>
>>> What about EXPORT_SYMBOL_GPL()?
>>
>> I'll remove it.
> 
> Ah. It is needed to support module build.
> it is used by passive governor.

My point was about the "GPL" part. The EXPORT_SYMBOL_GPL() prohibits
closed source drivers to use the exported API.

