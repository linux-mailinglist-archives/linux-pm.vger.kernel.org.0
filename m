Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5D13541B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 09:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgAIIHM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 03:07:12 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:48519 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgAIIHL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 03:07:11 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200109080705epoutp047a5c4398edd7bb135afad08a99d00d3a~oKW7uCY_70595505955epoutp04K
        for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2020 08:07:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200109080705epoutp047a5c4398edd7bb135afad08a99d00d3a~oKW7uCY_70595505955epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578557225;
        bh=4ThduY/fg6mZlY+PVL3B/X7vQCitjlaP5x5WJFS+V38=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LrgTtUFB6ik2LgsgUPB5N3eLOLU9tD6lEDZm0TICK1McBCUq8KJm5PmlAiXGvGRm1
         Qs2STZJZuyb5a46F+gkyU7NMGZpM3CfvMl1mWCI9Gzsl9Vck87Uaz5HlapGq4RIeFH
         ZciHQ58zQOdyHKU9FOq5/a0uGXi3mRdyJpXllLu0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200109080705epcas1p209c9d492a0c19c33fc6075c961bc105f~oKW7GNARm2460424604epcas1p2k;
        Thu,  9 Jan 2020 08:07:05 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47tdxf53QNzMqYkY; Thu,  9 Jan
        2020 08:07:02 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.14.57028.42FD61E5; Thu,  9 Jan 2020 17:07:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200109080659epcas1p36c6cc38f37f567525bd8ab94c1022e92~oKW1y-kRR0469504695epcas1p32;
        Thu,  9 Jan 2020 08:06:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109080659epsmtrp1b519d36034bbcb95de5310a9e82cb2e4~oKW1yMp3E1532815328epsmtrp1j;
        Thu,  9 Jan 2020 08:06:59 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-35-5e16df2497b4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.26.10238.32FD61E5; Thu,  9 Jan 2020 17:06:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200109080659epsmtip295c589f711704220604bdafa85277bac~oKW1iKvk80180801808epsmtip2q;
        Thu,  9 Jan 2020 08:06:59 +0000 (GMT)
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
Message-ID: <e9895970-7f73-0ac4-c9cd-4ad85d464e11@samsung.com>
Date:   Thu, 9 Jan 2020 17:14:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <e93f6e16-e18d-bafd-5761-ffc8a2642149@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmvq7KfbE4g+YTLBb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmBz4PNYM28No8flvl4mjx13lzB67Jx1l91j06pONo871/aweWx8t4PJ4++s/Swe
        fVtWMXp83iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkD9IGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/
        18rQwMDIFKgwITvjz/4u5oKzwRUbZq9kbmB86NDFyMkhIWAi8XzfWXYQW0hgB6PEi0UCXYxc
        QPYnRokbq6eyQTjfGCUOdC9mg+nof7KOHSKxl1Hi9JdVUFXvGSVmvf7JAlIlLOAtMb9rCZgt
        IpAgceTPPyaQImaBKUwSc0/3MoMk2AS0JPa/uAE2ll9AUeLqj8eMIDavgJ3EtBdbmUBsFgEV
        iY+bvoDViAqESZzc1gJVIyhxcuYTsAWcArYSv/c8AJvJLCAucevJfCYIW16ieetsZpDFEgLH
        2CUu3noH9YOLxNS7U9khbGGJV8e3QNlSEi/726DsaomVJ4+wQTR3MEps2X+BFSJhLLF/6WSg
        DRxAGzQl1u/ShwgrSuz8PZcRYjGfxLuvPawgJRICvBIdbUIQJcoSlx/cZYKwJSUWt3eyTWBU
        moXknVlIXpiF5IVZCMsWMLKsYhRLLSjOTU8tNiwwRI7uTYzg5K1luoNxyjmfQ4wCHIxKPLwM
        SmJxQqyJZcWVuYcYJTiYlUR4j94ACvGmJFZWpRblxxeV5qQWH2I0BYb2RGYp0eR8YGbJK4k3
        NDUyNja2MDE0MzU0VBLn5fhxMVZIID2xJDU7NbUgtQimj4mDU6qBMWXDl3dNFYw3OEQMe5yN
        c6J5eormnTu/cM7tiw8Ldy1QWmb962CQdGLE4oBDuQ+E8iQ+7M9Or3Wd6nth/rTFV/stnrkt
        /7Kp7h1foKNOX/PGZ3PWPV7ivFz7QwXPBt2Xl73ZGsRWzZv7QG7Sgs28GbuiL8/zURGWe3oz
        qsFPZNI6u+OeHyr7I5VYijMSDbWYi4oTATsMM5n0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7bCSvK7yfbE4g283RCzuz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG1xtukNu8WKux9ZLS7vmsNm8bn3CKPFwqYWdou1
        R+6yW9xuXMHmwOexZt4aRo/Lfb1MHjvuLmH02DnrLrvHplWdbB53ru1h89j4bgeTx99Z+1k8
        +rasYvT4vEkugCuKyyYlNSezLLVI3y6BK+PP/i7mgrPBFRtmr2RuYHzo0MXIySEhYCLR/2Qd
        O4gtJLCbUWLHhFiIuKTEtItHmbsYOYBsYYnDh4shSt4ySvScdgGxhQW8JeZ3LWEBsUUEEiT+
        /v/I2MXIxcEsMIVJYk7vLUaIhhtMEme6pUBsNgEtif0vbrCB2PwCihJXfzwGq+EVsJOY9mIr
        E4jNIqAi8XHTF7AaUYEwiZ1LHjNB1AhKnJz5BGwZp4CtxO89D5hBbGYBdYk/8y5B2eISt57M
        Z4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpe
        cn7uJkZwBGtp7mC8vCT+EKMAB6MSDy+DklicEGtiWXFl7iFGCQ5mJRHeozeAQrwpiZVVqUX5
        8UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTBacazbyMgZsNlvx6LGlwnT
        knWen4v++9xr1q5NApOvv77rHM2d1Cp74t0GD+8DQdOS5reZ3BJYa6r/b3GHtv2nI9WNSrP2
        9xyXuKH4K3cma16R+ORnK1Un9p57w3KpWfWcq+C5510vJ1xS1NQ3WRikInrR6csX14xfn72+
        RTTHl72TdlQtlXmrxFKckWioxVxUnAgAyuPIU9wCAAA=
X-CMS-MailID: 20200109080659epcas1p36c6cc38f37f567525bd8ab94c1022e92
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
        <b64bf3d4-5b46-243b-495a-e1060af7a266@gmail.com>
        <9cfbdb8a-1326-e7e3-3a65-c3f8c45eaf19@samsung.com>
        <e93f6e16-e18d-bafd-5761-ffc8a2642149@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/8/20 11:10 PM, Dmitry Osipenko wrote:
> 08.01.2020 14:22, Chanwoo Choi пишет:
>> On 1/8/20 6:56 AM, Dmitry Osipenko wrote:
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
>>>>  
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
>>>> +
>>>>  /**
>>>>   * find_devfreq_governor() - Find devfreq governor from name
>>>>   * @name:	name of the governor
>>>> @@ -401,6 +452,10 @@ static int set_target(struct devfreq *devfreq,
>>>>  		return err;
>>>>  	}
>>>>  
>>>> +	devfreq_update_transitions(devfreq, cur_freq, new_freq,
>>>> +					devfreq->last_status.busy_time,
>>>> +					devfreq->last_status.total_time);
>>>> +
>>>>  	freqs.new = new_freq;
>>>>  	notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>>>  
>>>> @@ -1787,6 +1842,72 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
>>>>  }
>>>>  DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>>>>  
>>>> +/**
>>>> + * devfreq_transitions_show() - Show the frequency transitions of the registered
>>>> + *			devfreq devices via 'devfreq_transitions' debugfs file.
>>>> + */
>>>> +static int devfreq_transitions_show(struct seq_file *s, void *data)
>>>> +{
>>>> +	struct devfreq *devfreq = NULL;
>>>> +	struct devfreq *p_devfreq = NULL;
>>>> +	struct devfreq_freqs *freqs = NULL;
>>>> +	unsigned long load;
>>>> +	int i = debugfs_transitions_index;
>>>> +	int count;
>>>> +
>>>> +	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
>>>> +			"time_ms",
>>>> +			"dev_name",
>>>> +			"dev",
>>>> +			"parent_dev",
>>>> +			"load_%",
>>>> +			"old_freq_hz",
>>>> +			"new_freq_hz");
>>>> +	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
>>>> +			"----------",
>>>> +			"------------------------------",
>>>> +			"----------",
>>>> +			"----------",
>>>> +			"----------",
>>>> +			"------------",
>>>> +			"------------");
>>>
>>> Isn't this needed here?
>>>
>>> mutex_lock(&devfreq_list_lock);
>>
>> It doesn't touch the devfreq instance of devfreq_list.
>> So, it is not necessary locked of devfreq_list_lock.
> 
> What stops devfreq device to be removed by another CPU thread while this
> function is in a process of execution?
> 
> This condition is unlikely to happen in practice ever, but technically
> it should be possible to happen.
> 
>>>> +	spin_lock(&devfreq_debugfs_lock);
>>>> +	for (count = 0; count < CONFIG_NR_DEVFREQ_TRANSITIONS; count++) {
>>>> +		devfreq = debugfs_transitions[i].devfreq;
>>>> +		freqs = &debugfs_transitions[i].freqs;
>>>> +		load = debugfs_transitions[i].load;
>>>> +
>>>> +		i = (CONFIG_NR_DEVFREQ_TRANSITIONS == ++i) ? 0 : i;
>>>> +		if (!devfreq)
>>>> +			continue;
>>>
>>> I suppose debugfs_transitions[i].devfreq should be set to NULL when
>>> devfreq device is removed, but I don't see it happening anywhere in this
>>> patch.
>>
>> When debugfs_transitions[] array is not fully filled out
>> by devfreq_update_transitions(), debugfs_transitions[i].devfreq is NULL.
>> In this case, if user execute 'cat /sys/kernel/debug/devfreq/devfreq_transitions',
>> devfreq_transitions_show() need to check the debugfs_transitions[i].devfreq
>> is NULL or not.
>>
>> After filled out the debugfs_transitions[] array,
>> actually, 'if(!devfreq)' is not necessary. Maybe, this style is inefficient
>> It need to rework. I'll think again.
> 
> Imagine this situation:
> 
> 1. there is a devfreq device, let's name it defreq123
> 
> 2. the debugfs_transitions array is getting filled and now it has this
> entry:
> 
> 	debugfs_transitions[0].devfreq = defreq123
> 
> 3. user removes defreq123 driver module
> 
> 	# rmmod defreq123
> 
> 4. the defreq123 is released now
> 
> 5. at what memory location debugfs_transitions[0].devfreq is pointing now?
> 
> 

You're right. It is my missing point.
Instead of storing the devfreq pointer into debugfs_transitions[].devfreq,
It is better to copy the necessary information to debugfs_transitions[]
for preventing the mentioned situation.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
