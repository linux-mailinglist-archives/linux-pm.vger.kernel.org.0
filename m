Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF8913400C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 12:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgAHLPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 06:15:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:61059 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAHLPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 06:15:33 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200108111530epoutp04684a5a32e6e798a402e362b2a6822016~n5SJboS0n0670406704epoutp04w
        for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2020 11:15:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200108111530epoutp04684a5a32e6e798a402e362b2a6822016~n5SJboS0n0670406704epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578482130;
        bh=IRrDxZuVyLnMElo+SajHPDtrFOhMpkvaPH1Ae9eOmMU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q70q4UbT0IphrHWBG2t+LQ9OUVY7oqLT3My1rDlMgJcJqC3eRgTFkB69BuneYDbtu
         u8bIsOs0gJkuMwC0N1PkXBLDHlOTlG0uymRvmA+r8sfz7ZLT0+W4mEIxNkKV8u8sQM
         ZNB8L7B9soFkd53zB8//inxIJ2TIxcmGRLDGdtkg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200108111529epcas1p4c73819317411b23573d635bed5faaec2~n5SIlhI7C2026320263epcas1p4A;
        Wed,  8 Jan 2020 11:15:29 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47t69V5zw3zMqYlm; Wed,  8 Jan
        2020 11:15:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.F6.51241.EC9B51E5; Wed,  8 Jan 2020 20:15:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200108111526epcas1p2c02627b3e57ff38f758029a4298f2655~n5SF9Elgn1138911389epcas1p2O;
        Wed,  8 Jan 2020 11:15:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200108111526epsmtrp2ce6766a347423d5e684ed9351788e60b~n5SF8PTkU1469614696epsmtrp2d;
        Wed,  8 Jan 2020 11:15:26 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-08-5e15b9ce3fa8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.A5.10238.EC9B51E5; Wed,  8 Jan 2020 20:15:26 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200108111526epsmtip12aec44ea8c28b464a623523bb9ab8afb~n5SFpj8x91201812018epsmtip1_;
        Wed,  8 Jan 2020 11:15:26 +0000 (GMT)
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
Message-ID: <9cfbdb8a-1326-e7e3-3a65-c3f8c45eaf19@samsung.com>
Date:   Wed, 8 Jan 2020 20:22:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <b64bf3d4-5b46-243b-495a-e1060af7a266@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOd87h9ICrflaQdywbeDRLYAI9lOphAeImMSdRE5Il/jAqHtoT
        2tDbegpeZhZ0eKERHBFv9YbTJQy7OBhDSsRq12haphvilgbtZAGTBU2JwpZ6YVnb4zL+Pe/z
        Pe/3Ps93YUjNOJ3DmG0uyWkTLSydQfX/mK8tvOvL2qZ9eJLjH53bj/hhf4zi2yP3Kf7yswnE
        ex8EEB//LkzyPZ31/J19T1V8V/RZGj86eIbmZ1qDiL+wr1nFfxuMqvgHe7voNQsF7zkvEkbb
        WglhIHoJCT5PVCX0drfQwsPfrtFCT2yAEOY8fkpo6+tGwkzve9UZm+vLTZJolJx5ks1gN5pt
        dRXs+k9q1tboV2m5Qq6MX83m2USrVMFWbaguXGe2JBKweY2ipSFBVYuyzBZXljvtDS4pz2SX
        XRWs5DBaHGWOIlm0yg22uiKD3fohp9WW6BPC7fUm3x9+2nHDsHMschM1oaMb3YhhAJfChYjd
        jTIYDR5AEPSFaaV4juB03Ecpxd8IvF99n+ZG6amO6+EuUlkYQjA+8gQpxTSC/cf7yaRqCV4P
        592XqCTOxNsh+PofIikicQcBZ4dbUyIaF4D/zwidxIvwMvg1PoGSptS4EgKXHUmawitgqmku
        tU8W3gSh/maUxGq8GEKnJlN8Oq6A4StjKXckzoaxyfOEgnPhix9Op5wCDqtgrv8xqUSogpe3
        fqYVvASmbvepFJwDM7GhN/xn8E0oSCvNhxD0+X95k18H/q+PEkmjJM6HK4PFCr0MfK/OImXw
        Qoj9dThNOWA1HDqgUSTLYXQ8Sij4bbh4sIX+ErGeeXE88yJ45kXw/D+sE1HdaKnkkK11ksw5
        9PNvuxelXndB2QC6dXdDAGEGsW+p4xczt2nSxEZ5lzWAgCHZTHXBygSlNoq7dktOe42zwSLJ
        AaRPnHY7mZNlsCf+is1Vw+lLdDodX8qt0nMcm61m4iNbNbhOdEn1kuSQnP/1EUx6ThMyzro7
        vHOh6atjn58kdXLT7S17ft9z5MXx6Rsl1i2Td4raZ01siznQVlucu/PTTP+Kd0If53d6Kps/
        Ogb2wdWd2Yahe4/oiQXsRO/Sx7FTO2adfZtL7z8NTx02177bERna+sGZRvW9aZ31fao7l7i6
        rtZ6LXyzI71n5ETV8gXlezf+xFKySeQKSKcs/gu2sM5U8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnO65naJxBv/mCFjcn9fKaHF6/zsW
        i4k3rrBYrP74mNFize1DjBY/Npxitti4INvibNMbdosVdz+yWlzeNYfN4nPvEUaLhU0t7BZr
        j9xlt7jduILNgc9jzbw1jB6X+3qZPHbcXcLosXPWXXaPTas62TzuXNvD5rHx3Q4mj7+z9rN4
        9G1ZxejxeZNcAFcUl01Kak5mWWqRvl0CV8bOh/vZCg4kV9y6cZCxgXGybxcjJ4eEgInEvlMr
        mLsYuTiEBHYzStw42MYMkZCUmHbxKJDNAWQLSxw+XAxR85ZRYu6KuWA1wgLeEvO7lrCA2CIC
        CRJ//39kBCliFpjCJDGn9xYjRMcHRom/jzrAOtgEtCT2v7jBBmLzCyhKXP3xmBFkA6+AncSh
        1QUgYRYBFYlXDX/BhooKhEnsXPKYCcTmFRCUODnzCVicU8BW4vT6W6wgNrOAusSfeZeYIWxx
        iVtP5jNB2PISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4
        NC9dLzk/dxMjOIq1NHcwXl4Sf4hRgINRiYf3x2KROCHWxLLiytxDjBIczEoivFo6QCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYhSq0Hny57zRnt11g
        HVOmvHBMz/yGj/b/ggTW96y8+v9zeE2TdLGBhv3bHtUq+RKTRItXq9QmPqhfUmN1l3NRg9e7
        Csmn853jHvYfC5u8nG/N5Wuffng+1Vbw3CQrtCf68LGKn0EXzrVazTLR37nLOK5ZfKujjfDh
        NOV3y7JzDfbGHV1QoJSlxFKckWioxVxUnAgAs9GJFt4CAAA=
X-CMS-MailID: 20200108111526epcas1p2c02627b3e57ff38f758029a4298f2655
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/8/20 6:56 AM, Dmitry Osipenko wrote:
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
>>  
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
>> +
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
> 
> Isn't this needed here?
> 
> mutex_lock(&devfreq_list_lock);

It doesn't touch the devfreq instance of devfreq_list.
So, it is not necessary locked of devfreq_list_lock.

> 
>> +	spin_lock(&devfreq_debugfs_lock);
>> +	for (count = 0; count < CONFIG_NR_DEVFREQ_TRANSITIONS; count++) {
>> +		devfreq = debugfs_transitions[i].devfreq;
>> +		freqs = &debugfs_transitions[i].freqs;
>> +		load = debugfs_transitions[i].load;
>> +
>> +		i = (CONFIG_NR_DEVFREQ_TRANSITIONS == ++i) ? 0 : i;
>> +		if (!devfreq)
>> +			continue;
> 
> I suppose debugfs_transitions[i].devfreq should be set to NULL when
> devfreq device is removed, but I don't see it happening anywhere in this
> patch.

When debugfs_transitions[] array is not fully filled out
by devfreq_update_transitions(), debugfs_transitions[i].devfreq is NULL.
In this case, if user execute 'cat /sys/kernel/debug/devfreq/devfreq_transitions',
devfreq_transitions_show() need to check the debugfs_transitions[i].devfreq
is NULL or not.

After filled out the debugfs_transitions[] array,
actually, 'if(!devfreq)' is not necessary. Maybe, this style is inefficient
It need to rework. I'll think again.

> 
>> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>> +		if (!strncmp(devfreq->governor_name,
>> +				DEVFREQ_GOV_PASSIVE, DEVFREQ_NAME_LEN)) {
> 
> This could be:
> 
> if (IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) &&
>     !strncmp(devfreq->governor_name,
> 		  DEVFREQ_GOV_PASSIVE, DEVFREQ_NAME_LEN)) {

Good. It is more clear. I'll edit it according to your comment.

> 
>> +			struct devfreq_passive_data *data = devfreq->data;
>> +
>> +			if (data)
>> +				p_devfreq = data->parent;
> 
> const char *devname = "";
> 
> ...
> 
> 	if (data)
> 		devname = dev_name(data->parent);
> 

'devname' word is too general. It is difficult to know
this name is for parent devfreq device. So, I prefer
to keep the origin style.

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
>>  
>>  static inline int devfreq_update_stats(struct devfreq *df)
>>  {
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>> index be6eeab9c814..05fa654239f5 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -109,6 +109,8 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>>  	if (ret < 0)
>>  		goto out;
>>  
>> +	devfreq_update_transitions(devfreq, devfreq->previous_freq, freq, 0, 0);
>> +
>>  	if (devfreq->profile->freq_table
>>  		&& (devfreq_update_status(devfreq, freq)))
>>  		dev_err(&devfreq->dev,
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 49cdb2378030..933692e5d867 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -196,6 +196,7 @@ struct devfreq {
>>  };
>>  
>>  struct devfreq_freqs {
>> +	s64 time;
>>  	unsigned long old;
>>  	unsigned long new;
>>  };
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
