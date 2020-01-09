Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24F0135094
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 01:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgAIAha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 19:37:30 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37559 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIAh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 19:37:29 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200109003725epoutp013dec8d64f420a7b4c4ade13f819df86c~oEOUKtA0C2589325893epoutp01Y
        for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2020 00:37:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200109003725epoutp013dec8d64f420a7b4c4ade13f819df86c~oEOUKtA0C2589325893epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578530245;
        bh=ubKOg8BqyfSEFcGyWynZHq64lBt4jscp3VPrAxVeJ/c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lhJO2/TGMaC6BZVKbzyFIT/2RROdqFeB9GEoFqYwpzo8TkoYkq9s67eFJusVR/opr
         Ksrk6PSy7NC8UvkaDHp1SqCOp+1rrzXYRfDxaPvzFZ1d9m0w1fSk1LXeqbT3a00SRm
         UhxsQydxkRX8crnZPfawts60OQM8x6QNXIGvhsRc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200109003724epcas1p2c933a9a80dbe36b5b2c15eafd1ab1b72~oEOTrO5kF1908719087epcas1p2b;
        Thu,  9 Jan 2020 00:37:24 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47tRyp0KS7zMqYkb; Thu,  9 Jan
        2020 00:37:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.54.48019.1C5761E5; Thu,  9 Jan 2020 09:37:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200109003721epcas1p3bd050a8ee7480e2524ce0bbd4f57bbcf~oEOQfnn2Y2401324013epcas1p3M;
        Thu,  9 Jan 2020 00:37:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109003721epsmtrp12b291067f5b744cb42625490da8a95ad~oEOQeyK5v0153101531epsmtrp1a;
        Thu,  9 Jan 2020 00:37:21 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-4e-5e1675c1980f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.60.10238.1C5761E5; Thu,  9 Jan 2020 09:37:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200109003721epsmtip151db60696701d4681895c21c79f2341e~oEOQOOmVU2276822768epsmtip1h;
        Thu,  9 Jan 2020 00:37:21 +0000 (GMT)
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
Message-ID: <402b0752-d750-b57b-fbb2-a8de59dbaa96@samsung.com>
Date:   Thu, 9 Jan 2020 09:44:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <3381b9a0-1023-f11c-1348-44f9de0e0e17@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmru6hUrE4gzOSFvfntTJanN7/jsVi
        4o0rLBarPz5mtFhz+xCjxY8Np5gtNi7Itjjb9IbdYsXdj6wWl3fNYbP43HuE0WJhUwu7xdoj
        d9ktbjeuYHPg81gzbw2jx+W+XiaPHXeXMHrsnHWX3WPTqk42jzvX9rB5bHy3g8nj76z9LB59
        W1YxenzeJBfAFZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQP0gJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/X
        ytDAwMgUqDAhO2P+icCCszYVL272sjUwLtTrYuTkkBAwkTh+YSpbFyMXh5DADkaJ0wtOMkI4
        nxglFq66xgThfGOU+LbsDRNMy/slO9khEnsZJSbtmQBV9Z5RonXPFLAqYQFvifldS1hAbBGB
        BIkjf/6BFTELTGGSmHu6lxkkwSagJbH/xQ02EJtfQFHi6o/HjCA2r4CdxKbOU2CDWARUJP72
        TgazRQXCJE5ua4GqEZQ4OfMJ2AJOAVuJyY/3s4PYzALiEreezGeCsOUlmrfOZgZZLCFwil3i
        zs+TUD+4SHy5s4cFwhaWeHV8CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9F1ghEsYS+5eCXMQB
        tEFTYv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR0SYEUaIscfnBXagTJCUWt3eyTWBUmoXk
        nVlIXpiF5IVZCMsWMLKsYhRLLSjOTU8tNiwwQY7uTYzg1K1lsYNxzzmfQ4wCHIxKPLwMSmJx
        QqyJZcWVuYcYJTiYlUR4tXRE4oR4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjCv5JXEG5oa
        GRsbW5gYmpkaGiqJ83L8uBgrJJCeWJKanZpakFoE08fEwSnVwCjzSXme1MWF+VPu7A+69rEk
        NSs4cGHu//u5R9TD1Ofy2jhd5kpRv6oy637P9UbnBZ/e7az9MGN+cEJnwcnHi1PWT3j7I42T
        19Py3xLJ/wzOdZfWn/y3j+erQs7BjTWpO68GTdrx59XWTeYi2x8n5Bk/X/F1C5+t+Lx13eds
        /Z9uvXxxzYGj+c+5lViKMxINtZiLihMBwHacvvMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnO7BUrE4g40beC3uz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG1xtukNu8WKux9ZLS7vmsNm8bn3CKPFwqYWdou1
        R+6yW9xuXMHmwOexZt4aRo/Lfb1MHjvuLmH02DnrLrvHplWdbB53ru1h89j4bgeTx99Z+1k8
        +rasYvT4vEkugCuKyyYlNSezLLVI3y6BK2P+icCCszYVL272sjUwLtTrYuTkkBAwkXi/ZCd7
        FyMXh5DAbkaJ8ydesUEkJCWmXTzK3MXIAWQLSxw+XAxR85ZRYk/HKlaQGmEBb4n5XUtYQGwR
        gQSJv/8/MoIUMQtMYZKY03uLEaKjl1nib/9mZpAqNgEtif0vboBt4BdQlLj64zEjiM0rYCex
        qfMUE4jNIqAi8bd3MpgtKhAmsXPJYyaIGkGJkzOfgG3jFLCVmPx4PzuIzSygLvFn3iVmCFtc
        4taT+UwQtrxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0u
        zUvXS87P3cQIjmItzR2Ml5fEH2IU4GBU4uFlUBKLE2JNLCuuzD3EKMHBrCTCq6UjEifEm5JY
        WZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDo7xZhu9yweRt9haH
        eLPUeEwLP+4vfv9M65vm4yOzeeUDLxr+1nSO3eCuEtyssmy5ndiLev1axni/M1+eifxYeTUy
        sZXL+1kBU56svq5G2ImW+/lHxaexXuL4Mi+94I2m3Z2Uh4y7bFmSytc5hbA9+3b+en+H/PPb
        b0R1H7esValOfrZHefZBJZbijERDLeai4kQATxcuO94CAAA=
X-CMS-MailID: 20200109003721epcas1p3bd050a8ee7480e2524ce0bbd4f57bbcf
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
        <92367824-d0ac-1be3-e432-292ea1796143@samsung.com>
        <e58888d7-9803-da5e-1054-690fe52284a1@samsung.com>
        <3381b9a0-1023-f11c-1348-44f9de0e0e17@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/8/20 11:23 PM, Dmitry Osipenko wrote:
> 08.01.2020 15:01, Chanwoo Choi пишет:
>> On 1/8/20 7:56 PM, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 1/8/20 6:31 AM, Dmitry Osipenko wrote:
>>>> Hello Chanwoo,
>>>>
>>>> 07.01.2020 12:05, Chanwoo Choi пишет:
>>>>> Add new devfreq_transitions debugfs file to track the frequency transitions
>>>>> of all devfreq devices for the simple profiling as following:
>>>>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>>>>
>>>>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>>>>> in Kconfig in order to save the transition history.
>>>>>
>>>>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>>>>> - time_ms	: Change time of frequency transition. (unit: millisecond)
>>>>> - dev_name	: Device name of h/w.
>>>>> - dev		: Device name made by devfreq core.
>>>>> - parent_dev	: If devfreq device uses the passive governor,
>>>>> 		  show parent devfreq device name.
>>>>> - load_%	: If devfreq device uses the simple_ondemand governor,
>>>>> 		  load is used by governor whene deciding the new frequency.
>>>>> 		  (unit: percentage)
>>>>> - old_freq_hz	: Frequency before changing. (unit: hz)
>>>>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>>>>
>>>>> [For example on Exynos5422-based Odroid-XU3 board]
>>>>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>>>>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>>>>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>>>>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>>>>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>>>>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>>>>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>>>>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>>>>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>>>>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>>>>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>>>>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>>>>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>>>>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>>>>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>>>>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>>>>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>>>>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>>>>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>>>>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>>>>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>>>>> [snip]
>>>>>
>>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> ---
>>>>>  drivers/devfreq/Kconfig            |  13 +++
>>>>>  drivers/devfreq/devfreq.c          | 126 +++++++++++++++++++++++++++++
>>>>>  drivers/devfreq/governor.h         |   3 +
>>>>>  drivers/devfreq/governor_passive.c |   2 +
>>>>>  include/linux/devfreq.h            |   1 +
>>>>>  5 files changed, 145 insertions(+)
>>>>>
>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>>> index 0b1df12e0f21..84936eec0ef9 100644
>>>>> --- a/drivers/devfreq/Kconfig
>>>>> +++ b/drivers/devfreq/Kconfig
>>>>> @@ -74,6 +74,19 @@ config DEVFREQ_GOV_PASSIVE
>>>>>  	  through sysfs entries. The passive governor recommends that
>>>>>  	  devfreq device uses the OPP table to get the frequency/voltage.
>>>>>  
>>>>> +comment "DEVFREQ Debugging"
>>>>> +
>>>>> +config NR_DEVFREQ_TRANSITIONS
>>>>> +	int "Maximum storage size to save DEVFREQ Transitions (10-1000)"
>>>>> +	depends on DEBUG_FS
>>>>> +	range 10 1000
>>>>> +	default "100"
>>>>> +	help
>>>>> +	  Show the frequency transitions of all devfreq devices via
>>>>> +	  '/sys/kernel/debug/devfreq/devfreq_transitions' for the simple
>>>>> +	  profiling. It needs to decide the storage size to save transition
>>>>> +	  history of all devfreq devices.
>>>>> +
>>>>>  comment "DEVFREQ Drivers"
>>>>>  
>>>>>  config ARM_EXYNOS_BUS_DEVFREQ
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index c7f5e4e06420..7abaae06fa65 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -268,6 +268,57 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>>>  }
>>>>>  EXPORT_SYMBOL(devfreq_update_status);
>>>>> +/**
>>>>> + * devfreq_update_transitions() - Update frequency transitions for debugfs file
>>>>> + * @devfreq:	the devfreq instance
>>>>> + * @old_freq:	the previous frequency before changing the frequency
>>>>> + * @new_freq:	the new frequency after frequency is changed
>>>>> + */
>>>>> +struct devfreq_transitions {
>>>>> +	struct devfreq *devfreq;
>>>>> +	struct devfreq_freqs freqs;
>>>>> +	unsigned long load;
>>>>> +} debugfs_transitions[CONFIG_NR_DEVFREQ_TRANSITIONS];
>>>>> +
>>>>> +static spinlock_t devfreq_debugfs_lock;
>>>>
>>>> This could be:
>>>>
>>>> static DEFINE_SPINLOCK(devfreq_debugfs_lock);
>>>>
>>>> and then spin_lock_init() isn't needed.
>>>
>>> OK
>>>
>>>>
>>>>
>>>> Also, The "<linux/spinlock.h>" should be included directly by devfreq.c
>>>
>>> OK.
>>>
>>>>
>>>>> +static int debugfs_transitions_index;
>>>>> +
>>>>> +void devfreq_update_transitions(struct devfreq *devfreq,
>>>>> +			unsigned long old_freq, unsigned long new_freq,
>>>>> +			unsigned long busy_time, unsigned long total_time)
>>>>> +{
>>>>> +	unsigned long load;
>>>>> +	int i;
>>>>> +
>>>>> +	if (!devfreq_debugfs || !devfreq || (old_freq == new_freq))
>>>>> +		return;
>>>>> +
>>>>> +	spin_lock_nested(&devfreq_debugfs_lock, SINGLE_DEPTH_NESTING);
>>>>> +
>>>>> +	i = debugfs_transitions_index;
>>>>> +
>>>>> +	/*
>>>>> +	 * Calculate the load and if load is larger than 100,
>>>>> +	 * initialize to 100 because the unit of load is percentage.
>>>>> +	 */
>>>>> +	load = (total_time == 0 ? 0 : (100 * busy_time) / total_time);
>>>>> +	if (load > 100)
>>>>> +		load = 100;
>>>>> +
>>>>> +	debugfs_transitions[i].devfreq = devfreq;
>>>>> +	debugfs_transitions[i].freqs.time = ktime_to_ms(ktime_get());
>>>>> +	debugfs_transitions[i].freqs.old = old_freq;
>>>>> +	debugfs_transitions[i].freqs.new = new_freq;
>>>>> +	debugfs_transitions[i].load = load;
>>>>> +
>>>>> +	if (++i == CONFIG_NR_DEVFREQ_TRANSITIONS)
>>>>> +		i = 0;
>>>>> +	debugfs_transitions_index = i;
>>>>> +
>>>>> +	spin_unlock(&devfreq_debugfs_lock);
>>>>> +}
>>>>> +EXPORT_SYMBOL(devfreq_update_transitions);
>>>>
>>>> What about EXPORT_SYMBOL_GPL()?
>>>
>>> I'll remove it.
>>
>> Ah. It is needed to support module build.
>> it is used by passive governor.
> 
> My point was about the "GPL" part. The EXPORT_SYMBOL_GPL() prohibits
> closed source drivers to use the exported API.

I'm sorry of my misunderstanding.
OK. I'll use EXPORT_SYMBOL_GPL()

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
