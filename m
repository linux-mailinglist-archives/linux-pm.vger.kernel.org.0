Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02731344A2
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 15:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgAHOKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 09:10:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43305 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAHOKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 09:10:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so2534703lfq.10;
        Wed, 08 Jan 2020 06:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lccogS9yuZeqO6yaDuLngyZoEXMXcecoK7V3LfOAwng=;
        b=Q/yEIhePWop6iZnuc/p7XpzRa7dbBAZtPfY1oDh5x6gRFUhfQQaOf14s3r7ejc2rgl
         ihT2O8+2aUc+h6K94nKKlGTjXK2BojDW2oV/gEF3C/Pd9hDx2ZXEZE0fOg1X61SLN1fO
         O6s0Fj8bUk1AD5fr6gOMCjj4ISnK1MTF55UmqstVFbihYti3WzprO80V4XWiX/lYRwIY
         /7LfrnuWY0HOW/RtVU4TzwH9uW8wwt/i9V1TZSnqrOGc9pH370TkC1vy4BdEPO6+nHCS
         h2vHLbf62Q7THejpw0QknGFnARAgoVnWAy1n14tBvt+flMFUPcMuWw+XtvXKN9o9XpBP
         KVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lccogS9yuZeqO6yaDuLngyZoEXMXcecoK7V3LfOAwng=;
        b=E16Lv73f4bhr1IeqDNf5vGBIDUVo5A31ZM82myll6IeNNe2YASlfDPrHbw7aZJFl94
         LYmFRB4N9inBhdWL1VEmM0R24ZZSW5JCQqPhg71v4bSVWdY9sRA7EpU0vT/ciLz6MvPn
         Mt2EkDHXCXqm3WdsfhTqaaVi8/5bINUVoP6ZG93r46B0C+DTpFjfY8Hn/fT1U0Qkv2Pt
         0Ju6Jb1dcIlUBUZwcAmUytTbXcxA3vGSnsZ8u8Wy3E/vVyl4TNJ5sKcOWW8ic9AaB8SQ
         A+CXMJm5v4T9jLnRL1nA9c5Dsn9RqAY+lacPMLZMAFNR0yi0hnL/I5Gor105BNjJuNBw
         W6ww==
X-Gm-Message-State: APjAAAU/bWXdUBkdQUGim1W8uEGk6yQZ/NTUk5qLyfZ/R01MCuyayAeL
        1bzXW0DYh2Fo8XW6UIvZo9I=
X-Google-Smtp-Source: APXvYqy57EpODYVmCv5z+9GaBm/mCc9xTqG20VUlxfJcT/wJGEFqctdcZLlQoiGshlJ5tGcDCcNjkA==
X-Received: by 2002:ac2:4d04:: with SMTP id r4mr2942157lfi.77.1578492643361;
        Wed, 08 Jan 2020 06:10:43 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id m11sm1456718lfj.89.2020.01.08.06.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:10:42 -0800 (PST)
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
 <b64bf3d4-5b46-243b-495a-e1060af7a266@gmail.com>
 <9cfbdb8a-1326-e7e3-3a65-c3f8c45eaf19@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e93f6e16-e18d-bafd-5761-ffc8a2642149@gmail.com>
Date:   Wed, 8 Jan 2020 17:10:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9cfbdb8a-1326-e7e3-3a65-c3f8c45eaf19@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.01.2020 14:22, Chanwoo Choi пишет:
> On 1/8/20 6:56 AM, Dmitry Osipenko wrote:
>> 07.01.2020 12:05, Chanwoo Choi пишет:
>>> Add new devfreq_transitions debugfs file to track the frequency transitions
>>> of all devfreq devices for the simple profiling as following:
>>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>>
>>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>>> in Kconfig in order to save the transition history.
>>>
>>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>>> - time_ms	: Change time of frequency transition. (unit: millisecond)
>>> - dev_name	: Device name of h/w.
>>> - dev		: Device name made by devfreq core.
>>> - parent_dev	: If devfreq device uses the passive governor,
>>> 		  show parent devfreq device name.
>>> - load_%	: If devfreq device uses the simple_ondemand governor,
>>> 		  load is used by governor whene deciding the new frequency.
>>> 		  (unit: percentage)
>>> - old_freq_hz	: Frequency before changing. (unit: hz)
>>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>>
>>> [For example on Exynos5422-based Odroid-XU3 board]
>>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>>> [snip]
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  drivers/devfreq/Kconfig            |  13 +++
>>>  drivers/devfreq/devfreq.c          | 126 +++++++++++++++++++++++++++++
>>>  drivers/devfreq/governor.h         |   3 +
>>>  drivers/devfreq/governor_passive.c |   2 +
>>>  include/linux/devfreq.h            |   1 +
>>>  5 files changed, 145 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 0b1df12e0f21..84936eec0ef9 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -74,6 +74,19 @@ config DEVFREQ_GOV_PASSIVE
>>>  	  through sysfs entries. The passive governor recommends that
>>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>>>  
>>> +comment "DEVFREQ Debugging"
>>> +
>>> +config NR_DEVFREQ_TRANSITIONS
>>> +	int "Maximum storage size to save DEVFREQ Transitions (10-1000)"
>>> +	depends on DEBUG_FS
>>> +	range 10 1000
>>> +	default "100"
>>> +	help
>>> +	  Show the frequency transitions of all devfreq devices via
>>> +	  '/sys/kernel/debug/devfreq/devfreq_transitions' for the simple
>>> +	  profiling. It needs to decide the storage size to save transition
>>> +	  history of all devfreq devices.
>>> +
>>>  comment "DEVFREQ Drivers"
>>>  
>>>  config ARM_EXYNOS_BUS_DEVFREQ
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index c7f5e4e06420..7abaae06fa65 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -268,6 +268,57 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>  }
>>>  EXPORT_SYMBOL(devfreq_update_status);
>>>  
>>> +/**
>>> + * devfreq_update_transitions() - Update frequency transitions for debugfs file
>>> + * @devfreq:	the devfreq instance
>>> + * @old_freq:	the previous frequency before changing the frequency
>>> + * @new_freq:	the new frequency after frequency is changed
>>> + */
>>> +struct devfreq_transitions {
>>> +	struct devfreq *devfreq;
>>> +	struct devfreq_freqs freqs;
>>> +	unsigned long load;
>>> +} debugfs_transitions[CONFIG_NR_DEVFREQ_TRANSITIONS];
>>> +
>>> +static spinlock_t devfreq_debugfs_lock;
>>> +static int debugfs_transitions_index;
>>> +
>>> +void devfreq_update_transitions(struct devfreq *devfreq,
>>> +			unsigned long old_freq, unsigned long new_freq,
>>> +			unsigned long busy_time, unsigned long total_time)
>>> +{
>>> +	unsigned long load;
>>> +	int i;
>>> +
>>> +	if (!devfreq_debugfs || !devfreq || (old_freq == new_freq))
>>> +		return;
>>> +
>>> +	spin_lock_nested(&devfreq_debugfs_lock, SINGLE_DEPTH_NESTING);
>>> +
>>> +	i = debugfs_transitions_index;
>>> +
>>> +	/*
>>> +	 * Calculate the load and if load is larger than 100,
>>> +	 * initialize to 100 because the unit of load is percentage.
>>> +	 */
>>> +	load = (total_time == 0 ? 0 : (100 * busy_time) / total_time);
>>> +	if (load > 100)
>>> +		load = 100;
>>> +
>>> +	debugfs_transitions[i].devfreq = devfreq;
>>> +	debugfs_transitions[i].freqs.time = ktime_to_ms(ktime_get());
>>> +	debugfs_transitions[i].freqs.old = old_freq;
>>> +	debugfs_transitions[i].freqs.new = new_freq;
>>> +	debugfs_transitions[i].load = load;
>>> +
>>> +	if (++i == CONFIG_NR_DEVFREQ_TRANSITIONS)
>>> +		i = 0;
>>> +	debugfs_transitions_index = i;
>>> +
>>> +	spin_unlock(&devfreq_debugfs_lock);
>>> +}
>>> +EXPORT_SYMBOL(devfreq_update_transitions);
>>> +
>>>  /**
>>>   * find_devfreq_governor() - Find devfreq governor from name
>>>   * @name:	name of the governor
>>> @@ -401,6 +452,10 @@ static int set_target(struct devfreq *devfreq,
>>>  		return err;
>>>  	}
>>>  
>>> +	devfreq_update_transitions(devfreq, cur_freq, new_freq,
>>> +					devfreq->last_status.busy_time,
>>> +					devfreq->last_status.total_time);
>>> +
>>>  	freqs.new = new_freq;
>>>  	notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>>  
>>> @@ -1787,6 +1842,72 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
>>>  }
>>>  DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>>>  
>>> +/**
>>> + * devfreq_transitions_show() - Show the frequency transitions of the registered
>>> + *			devfreq devices via 'devfreq_transitions' debugfs file.
>>> + */
>>> +static int devfreq_transitions_show(struct seq_file *s, void *data)
>>> +{
>>> +	struct devfreq *devfreq = NULL;
>>> +	struct devfreq *p_devfreq = NULL;
>>> +	struct devfreq_freqs *freqs = NULL;
>>> +	unsigned long load;
>>> +	int i = debugfs_transitions_index;
>>> +	int count;
>>> +
>>> +	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
>>> +			"time_ms",
>>> +			"dev_name",
>>> +			"dev",
>>> +			"parent_dev",
>>> +			"load_%",
>>> +			"old_freq_hz",
>>> +			"new_freq_hz");
>>> +	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
>>> +			"----------",
>>> +			"------------------------------",
>>> +			"----------",
>>> +			"----------",
>>> +			"----------",
>>> +			"------------",
>>> +			"------------");
>>
>> Isn't this needed here?
>>
>> mutex_lock(&devfreq_list_lock);
> 
> It doesn't touch the devfreq instance of devfreq_list.
> So, it is not necessary locked of devfreq_list_lock.

What stops devfreq device to be removed by another CPU thread while this
function is in a process of execution?

This condition is unlikely to happen in practice ever, but technically
it should be possible to happen.

>>> +	spin_lock(&devfreq_debugfs_lock);
>>> +	for (count = 0; count < CONFIG_NR_DEVFREQ_TRANSITIONS; count++) {
>>> +		devfreq = debugfs_transitions[i].devfreq;
>>> +		freqs = &debugfs_transitions[i].freqs;
>>> +		load = debugfs_transitions[i].load;
>>> +
>>> +		i = (CONFIG_NR_DEVFREQ_TRANSITIONS == ++i) ? 0 : i;
>>> +		if (!devfreq)
>>> +			continue;
>>
>> I suppose debugfs_transitions[i].devfreq should be set to NULL when
>> devfreq device is removed, but I don't see it happening anywhere in this
>> patch.
> 
> When debugfs_transitions[] array is not fully filled out
> by devfreq_update_transitions(), debugfs_transitions[i].devfreq is NULL.
> In this case, if user execute 'cat /sys/kernel/debug/devfreq/devfreq_transitions',
> devfreq_transitions_show() need to check the debugfs_transitions[i].devfreq
> is NULL or not.
> 
> After filled out the debugfs_transitions[] array,
> actually, 'if(!devfreq)' is not necessary. Maybe, this style is inefficient
> It need to rework. I'll think again.

Imagine this situation:

1. there is a devfreq device, let's name it defreq123

2. the debugfs_transitions array is getting filled and now it has this
entry:

	debugfs_transitions[0].devfreq = defreq123

3. user removes defreq123 driver module

	# rmmod defreq123

4. the defreq123 is released now

5. at what memory location debugfs_transitions[0].devfreq is pointing now?
