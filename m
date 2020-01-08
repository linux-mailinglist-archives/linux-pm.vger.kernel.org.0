Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3078F133FA9
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 11:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgAHKtp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 05:49:45 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:36596 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgAHKto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 05:49:44 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200108104940epoutp026e90a695b0b792f5d294412d9a67eff8~n47mBleFr1033810338epoutp02c
        for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2020 10:49:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200108104940epoutp026e90a695b0b792f5d294412d9a67eff8~n47mBleFr1033810338epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578480580;
        bh=OJlFHd6ORh0dqFbuiWwag42dUqp3U0f4C3JPCcoMOR4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZIlZJJpjjY1FJKzgx66DAomCGmIrKS22MOkyWrlOdKLPaStDhzAAHM6nbA1O5mHFo
         XSwMO2PXlTJiJFxISHQJ8UJ7+Q7dLjt3qsxhsnftVkgeLfUQTCHV3CowBXICVqREB6
         dbebSeHM+ckEaPjiLWXvkohEt39+ZYWqlPMcW7FU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200108104939epcas1p38dd6bde7806b6ee51965ea08bf2a8eb3~n47k-mqaj1300413004epcas1p3P;
        Wed,  8 Jan 2020 10:49:39 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47t5bh7227zMqYkY; Wed,  8 Jan
        2020 10:49:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.7C.52419.0C3B51E5; Wed,  8 Jan 2020 19:49:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200108104935epcas1p4c6d3a15029df41860265a5ec0a5e341b~n47iAtgRl3174131741epcas1p4p;
        Wed,  8 Jan 2020 10:49:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200108104935epsmtrp297dbf143fa28c08f1dd729120be17ea1~n47h-2sbm3238832388epsmtrp2d;
        Wed,  8 Jan 2020 10:49:35 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-f6-5e15b3c0f868
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.B3.10238.FB3B51E5; Wed,  8 Jan 2020 19:49:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200108104935epsmtip15c19a26ebc0682f3c2905a040ad46761~n47hq12GU2919429194epsmtip19;
        Wed,  8 Jan 2020 10:49:35 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <92367824-d0ac-1be3-e432-292ea1796143@samsung.com>
Date:   Wed, 8 Jan 2020 19:56:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <2c259936-f099-a239-9d6b-08f9b253644f@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmvu6BzaJxBgffm1ncn9fKaHF6/zsW
        i4k3rrBYrP74mNFize1DjBY/Npxitti4INvibNMbdosVdz+yWlzeNYfN4nPvEUaLhU0t7BZr
        j9xlt7jduILNgc9jzbw1jB6X+3qZPHbcXcLosXPWXXaPTas62TzuXNvD5rHx3Q4mj7+z9rN4
        9G1ZxejxeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi0rx0veT8
        XCtDAwMjU6DChOyMOVf2sxe8C6k49uAyYwNjk2MXIyeHhICJxMr9p5i7GLk4hAR2MEps7/8A
        5XxilDh44DMThPONUaL50D9WmJZVk35CVe1llHiyFabqPaPE7Vk/GUGqhAW8JeZ3LWEBsUUE
        EiSO/PkHVsQsMIVJYu7pXmaQBJuAlsT+FzfYQGx+AUWJqz8egzXzCthJzPiwkQnEZhFQkXh5
        7i+YLSoQJnFyWwtUjaDEyZlPgBZwcHAK2EpcOyAEEmYWEJe49WQ+E4QtL9G8dTbYpRICp9gl
        Pja1sYHUSwi4SDz/IgnxjbDEq+Nb2CFsKYnP7/ayQdjVEitPHmGD6O1glNiy/wLU+8YS+5dO
        ZgKZwyygKbF+lz5EWFFi5++5jBB7+STefe1hhVjFK9HRJgRRoixx+cFdJghbUmJxeyfbBEal
        WUiemYXkg1lIPpiFsGwBI8sqRrHUguLc9NRiwwJj5NjexAhO3VrmOxg3nPM5xCjAwajEw/tj
        sUicEGtiWXFl7iFGCQ5mJRFeLR2gEG9KYmVValF+fFFpTmrxIUZTYFhPZJYSTc4H5pW8knhD
        UyNjY2MLE0MzU0NDJXFejh8XY4UE0hNLUrNTUwtSi2D6mDg4pRoY2SWO7f0hzPw5aZJCXs8H
        b9GSLdu/znZ2zWqomrXm8eLl9xccbWFfvCxf+GW/z/K7WlXpZ2Yuq59xyGHf8QK9M26bNNas
        VP+wpt+rxt96k0/p2fzMz1ahG6a/nK+9wVxmceCle2t275n8bU7CevkT+yIun9kudSd23ttC
        Uc4fPHUXN7eb5gn3/ldiKc5INNRiLipOBAAw8RDG8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSnO7+zaJxBu++G1rcn9fKaHF6/zsW
        i4k3rrBYrP74mNFize1DjBY/Npxitti4INvibNMbdosVdz+yWlzeNYfN4nPvEUaLhU0t7BZr
        j9xlt7jduILNgc9jzbw1jB6X+3qZPHbcXcLosXPWXXaPTas62TzuXNvD5rHx3Q4mj7+z9rN4
        9G1ZxejxeZNcAFcUl01Kak5mWWqRvl0CV8acK/vZC96FVBx7cJmxgbHJsYuRk0NCwERi1aSf
        zF2MXBxCArsZJfY9vssIkZCUmHbxKFCCA8gWljh8uBgkLCTwllFi98sEEFtYwFtiftcSFhBb
        RCBB4u//j4wgc5gFpjBJzOm9xQgx9AOjRNP6JWwgVWwCWhL7X9wAs/kFFCWu/ngMtoxXwE5i
        xoeNTCA2i4CKxMtzf8FsUYEwiZ1LHjNB1AhKnJz5hAXkIE4BW4lrB4RAwswC6hJ/5l1ihrDF
        JW49mc8EYctLNG+dzTyBUXgWku5ZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
        0rx0veT83E2M4BjW0tzBeHlJ/CFGAQ5GJR7eH4tF4oRYE8uKK3MPMUpwMCuJ8GrpAIV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpgrJTJ3nXm5aIrfufT
        rV7eWZVc9PeS+5V7spo77kkZp34U15soXMbzdgFjUmE4g+/hujVR999ND2qd5z5RudApwrHl
        +brpffysFo6WDaphEn1blZUPas5KPvHjy/or11UzjT+brOL7edMi9oJqr4L7UuY/PeK+QVvV
        b37W32Py7dVLjZYff64sUWIpzkg01GIuKk4EAC+nr+ndAgAA
X-CMS-MailID: 20200108104935epcas1p4c6d3a15029df41860265a5ec0a5e341b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea
References: <20200107090519.3231-1-cw00.choi@samsung.com>
        <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
        <20200107090519.3231-3-cw00.choi@samsung.com>
        <2c259936-f099-a239-9d6b-08f9b253644f@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 1/8/20 6:31 AM, Dmitry Osipenko wrote:
> Hello Chanwoo,
> 
> 07.01.2020 12:05, Chanwoo Choi пишет:
>> Add new devfreq_transitions debugfs file to track the frequency transitions
>> of all devfreq devices for the simple profiling as following:
>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>
>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>> in Kconfig in order to save the transition history.
>>
>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>> - time_ms	: Change time of frequency transition. (unit: millisecond)
>> - dev_name	: Device name of h/w.
>> - dev		: Device name made by devfreq core.
>> - parent_dev	: If devfreq device uses the passive governor,
>> 		  show parent devfreq device name.
>> - load_%	: If devfreq device uses the simple_ondemand governor,
>> 		  load is used by governor whene deciding the new frequency.
>> 		  (unit: percentage)
>> - old_freq_hz	: Frequency before changing. (unit: hz)
>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>
>> [For example on Exynos5422-based Odroid-XU3 board]
>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>> [snip]
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/Kconfig            |  13 +++
>>  drivers/devfreq/devfreq.c          | 126 +++++++++++++++++++++++++++++
>>  drivers/devfreq/governor.h         |   3 +
>>  drivers/devfreq/governor_passive.c |   2 +
>>  include/linux/devfreq.h            |   1 +
>>  5 files changed, 145 insertions(+)
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 0b1df12e0f21..84936eec0ef9 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -74,6 +74,19 @@ config DEVFREQ_GOV_PASSIVE
>>  	  through sysfs entries. The passive governor recommends that
>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>>  
>> +comment "DEVFREQ Debugging"
>> +
>> +config NR_DEVFREQ_TRANSITIONS
>> +	int "Maximum storage size to save DEVFREQ Transitions (10-1000)"
>> +	depends on DEBUG_FS
>> +	range 10 1000
>> +	default "100"
>> +	help
>> +	  Show the frequency transitions of all devfreq devices via
>> +	  '/sys/kernel/debug/devfreq/devfreq_transitions' for the simple
>> +	  profiling. It needs to decide the storage size to save transition
>> +	  history of all devfreq devices.
>> +
>>  comment "DEVFREQ Drivers"
>>  
>>  config ARM_EXYNOS_BUS_DEVFREQ
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index c7f5e4e06420..7abaae06fa65 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -268,6 +268,57 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  }
>>  EXPORT_SYMBOL(devfreq_update_status);
>> +/**
>> + * devfreq_update_transitions() - Update frequency transitions for debugfs file
>> + * @devfreq:	the devfreq instance
>> + * @old_freq:	the previous frequency before changing the frequency
>> + * @new_freq:	the new frequency after frequency is changed
>> + */
>> +struct devfreq_transitions {
>> +	struct devfreq *devfreq;
>> +	struct devfreq_freqs freqs;
>> +	unsigned long load;
>> +} debugfs_transitions[CONFIG_NR_DEVFREQ_TRANSITIONS];
>> +
>> +static spinlock_t devfreq_debugfs_lock;
> 
> This could be:
> 
> static DEFINE_SPINLOCK(devfreq_debugfs_lock);
> 
> and then spin_lock_init() isn't needed.

OK

> 
> 
> Also, The "<linux/spinlock.h>" should be included directly by devfreq.c

OK.

> 
>> +static int debugfs_transitions_index;
>> +
>> +void devfreq_update_transitions(struct devfreq *devfreq,
>> +			unsigned long old_freq, unsigned long new_freq,
>> +			unsigned long busy_time, unsigned long total_time)
>> +{
>> +	unsigned long load;
>> +	int i;
>> +
>> +	if (!devfreq_debugfs || !devfreq || (old_freq == new_freq))
>> +		return;
>> +
>> +	spin_lock_nested(&devfreq_debugfs_lock, SINGLE_DEPTH_NESTING);
>> +
>> +	i = debugfs_transitions_index;
>> +
>> +	/*
>> +	 * Calculate the load and if load is larger than 100,
>> +	 * initialize to 100 because the unit of load is percentage.
>> +	 */
>> +	load = (total_time == 0 ? 0 : (100 * busy_time) / total_time);
>> +	if (load > 100)
>> +		load = 100;
>> +
>> +	debugfs_transitions[i].devfreq = devfreq;
>> +	debugfs_transitions[i].freqs.time = ktime_to_ms(ktime_get());
>> +	debugfs_transitions[i].freqs.old = old_freq;
>> +	debugfs_transitions[i].freqs.new = new_freq;
>> +	debugfs_transitions[i].load = load;
>> +
>> +	if (++i == CONFIG_NR_DEVFREQ_TRANSITIONS)
>> +		i = 0;
>> +	debugfs_transitions_index = i;
>> +
>> +	spin_unlock(&devfreq_debugfs_lock);
>> +}
>> +EXPORT_SYMBOL(devfreq_update_transitions);
> 
> What about EXPORT_SYMBOL_GPL()?

I'll remove it.

> 
>>  /**
>>   * find_devfreq_governor() - Find devfreq governor from name
>>   * @name:	name of the governor
>> @@ -401,6 +452,10 @@ static int set_target(struct devfreq *devfreq,
>>  		return err;
>>  	}
>>  
>> +	devfreq_update_transitions(devfreq, cur_freq, new_freq,
>> +					devfreq->last_status.busy_time,
>> +					devfreq->last_status.total_time);
>> +
>>  	freqs.new = new_freq;
>>  	notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>  
>> @@ -1787,6 +1842,72 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
>>  }
>>  DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>>  
>> +/**
>> + * devfreq_transitions_show() - Show the frequency transitions of the registered
>> + *			devfreq devices via 'devfreq_transitions' debugfs file.
>> + */
>> +static int devfreq_transitions_show(struct seq_file *s, void *data)
>> +{
>> +	struct devfreq *devfreq = NULL;
>> +	struct devfreq *p_devfreq = NULL;
>> +	struct devfreq_freqs *freqs = NULL;
>> +	unsigned long load;
>> +	int i = debugfs_transitions_index;
>> +	int count;
>> +
>> +	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
>> +			"time_ms",
>> +			"dev_name",
>> +			"dev",
>> +			"parent_dev",
>> +			"load_%",
>> +			"old_freq_hz",
>> +			"new_freq_hz");
>> +	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
>> +			"----------",
>> +			"------------------------------",
>> +			"----------",
>> +			"----------",
>> +			"----------",
>> +			"------------",
>> +			"------------");
>> +
>> +	spin_lock(&devfreq_debugfs_lock);> +	for (count = 0; count < CONFIG_NR_DEVFREQ_TRANSITIONS; count++) {
>> +		devfreq = debugfs_transitions[i].devfreq;
>> +		freqs = &debugfs_transitions[i].freqs;
>> +		load = debugfs_transitions[i].load;
>> +
>> +		i = (CONFIG_NR_DEVFREQ_TRANSITIONS == ++i) ? 0 : i;
>> +		if (!devfreq)
>> +			continue;
>> +
>> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>> +		if (!strncmp(devfreq->governor_name,
>> +				DEVFREQ_GOV_PASSIVE, DEVFREQ_NAME_LEN)) {
>> +			struct devfreq_passive_data *data = devfreq->data;
>> +
>> +			if (data)
>> +				p_devfreq = data->parent;
>> +		} else {
>> +			p_devfreq = NULL;
>> +		}
>> +#endif
>> +		seq_printf(s, "%-10lld %-30s %-10s %-10s %-6ld %-12ld %-12ld\n",
>> +			freqs->time,
>> +			dev_name(devfreq->dev.parent),
>> +			dev_name(&devfreq->dev),
>> +			p_devfreq ? dev_name(&p_devfreq->dev) : "",
>> +			load,
>> +			freqs->old,
>> +			freqs->new);
>> +	}
>> +	spin_unlock(&devfreq_debugfs_lock);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(devfreq_transitions);
>> +
>>  static int __init devfreq_init(void)
>>  {
>>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
>> @@ -1808,9 +1929,14 @@ static int __init devfreq_init(void)
>>  		devfreq_debugfs = NULL;
>>  		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
>>  	} else {
>> +		spin_lock_init(&devfreq_debugfs_lock);
>> +
>>  		debugfs_create_file("devfreq_summary", 0444,
>>  				devfreq_debugfs, NULL,
>>  				&devfreq_summary_fops);
>> +		debugfs_create_file("devfreq_transitions", 0444,
>> +				devfreq_debugfs, NULL,
>> +				&devfreq_transitions_fops);
>>  	}
>>  
>>  	return 0;
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index dc7533ccc3db..01eecfdaf2d6 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
>> @@ -68,6 +68,9 @@ extern int devfreq_add_governor(struct devfreq_governor *governor);
>>  extern int devfreq_remove_governor(struct devfreq_governor *governor);
>>  
>>  extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
>> +extern void devfreq_update_transitions(struct devfreq *devfreq,
>> +			unsigned long old_freq, unsigned long new_freq,
>> +			unsigned long busy_time, unsigned long total_time);
> 
> The 'extern' attribute isn't needed for function prototypes defined in
> header files.
> 
> 

Right. I'll remove it.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
