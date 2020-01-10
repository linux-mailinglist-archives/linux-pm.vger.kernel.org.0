Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC701136944
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 09:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgAJI4f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 03:56:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48336 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgAJI4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 03:56:35 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200110085632euoutp024d4c321267db6099cfed8ce61e488e0c~oerY2TY6n3269532695euoutp02L
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2020 08:56:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200110085632euoutp024d4c321267db6099cfed8ce61e488e0c~oerY2TY6n3269532695euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578646592;
        bh=gjYrnibyVonHjD0K8flrXfXLZ6vyR+EocTb65Lq+ARk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IxloGf2Za8rDtz3E8dbHQMCFMWBudBUEaahlvThKSy6JcN3tLnhpZmy5EQEzWF4rg
         TWmPOAnTw0F/whsRLZZM9jP9CSpBtdpC4IucU6OGxUAN0q4hFqwaHU40zsNbNUX/6X
         CENFZe9btyKiCwg78O3wydAhF5wH6rSPD5sFUtrU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200110085632eucas1p1e5c13bf04532c7df0c10c9296903d13e~oerYj0LCs1164811648eucas1p1M;
        Fri, 10 Jan 2020 08:56:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A7.F0.61286.04C381E5; Fri, 10
        Jan 2020 08:56:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200110085631eucas1p28523b3a56f6f9431c822871aba68f617~oerX-CsiE1007610076eucas1p24;
        Fri, 10 Jan 2020 08:56:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200110085631eusmtrp20b02490cb95e1a9076d5aafb06681986~oerX_E0010176101761eusmtrp2h;
        Fri, 10 Jan 2020 08:56:31 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-79-5e183c40d100
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.74.08375.F3C381E5; Fri, 10
        Jan 2020 08:56:31 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200110085630eusmtip139a887c89a328d5e10753829e49a18f6~oerXLXub31728917289eusmtip1J;
        Fri, 10 Jan 2020 08:56:30 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <5e7db176-48c4-09a1-f9f4-6d92df636753@samsung.com>
Date:   Fri, 10 Jan 2020 09:56:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107090519.3231-3-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3bOtuNw9jkve9FuzCxK1MQuJ1MpqDgRUfZXdDGPelqiTttc
        WQSpeKlhkhaVM5y3zNRSh5mKYg7LzNTK0DW1xDIrsjAVspu1HSX/+/E878vzPh8fRcjGhG5U
        lCqBU6vYGIVIQtY9mun23hoIoeuS8kj6TX4aojtbvpB0tvklSfdPjQnpiom3iK4cMCH6e/UT
        gq4piKa7Uj6L6bKhCSHd23hDRE9ebEN0YUqqmL7TNiSmB5LLRFsXM5X5lYjpzbooYOqHShDT
        oB8SM8byCyJmsK9JxNR8qRcwv/UtJJNVW46YSeOyfZKDksBILibqJKf2DQ6THB+1aOMnDyfO
        pNWJk9DITh2yowCvh9d3csU6JKFkuAzB49o8wmrI8BSCtpKNvDGJ4HpHFTG/kVNUIeCNWwiu
        DPSL+I1xBDM9blZ2wrvBoCshreyMwyGv/p5tgcClAuh4b7YZIuwLrV0dNpbiYLiaPYusTGJP
        SKst/scU5YIPQOc0y484QkfuO9u4HQ6AwvRxWy6B5WB5ZxDwvBzuj9+YOzSbgu7qAzxvhw+t
        lwU8O8Gn9loxz0tgtsEwp5+C0cIs21MATkUwnDFB8sYWGOz+IbLeQ+A1UNXoy8vboMpYLLDK
        gB3APO7In+AAOXXXCF6Wwvl0GT/tCWNPMueS3EE3e1d4CSn0C4rpF5TRLyij/59bgMhyJOe0
        mlglp/FTcad8NGysRqtS+kTExRrRv+/X+af9Wz2afhFuQphCCnvpAxd5qEzIntScjjUhoAiF
        s/Sh2TVUJo1kT5/h1HFH1doYTmNC7hSpkEv9iz4ekWElm8BFc1w8p553BZSdWxJSSuQGr/uH
        QqKdSqubI0POOWZYilX+5u6I8B1HP4wmeUb17O3bNLghNTkg2CNnRXS+erj59maPsNGgTtfV
        gd5PV7i8Io5FHClKf77LUBFQMNLUssn+hMfZ8ETLhpVBpr3sro9LRr4GlC5a9WuNq/bms58h
        lsY9XmWZiSG6UHNrzdL9swpSc5z1W0uoNexfgDPBrXoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7r2NhJxBm++S1jcn9fKaHF6/zsW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzxcYF2RZnm96wW6y4+5HV4vKuOWwWn3uPMFos
        bGpht1h75C67xe3GFWwO/B5r5q1h9Ljc18vksePuEkaPnbPusntsWtXJ5nHn2h42j43vdjB5
        /J21n8Wjb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0Mp7eKi34HFPxs3UbewPjI7cuRk4OCQETiUmLVjN1MXJxCAksZZQ4eqmD
        CSIhLdF4ejWULSzx51oXG4gtJPCaUeLtlkgQW1jAW2J+1xIWEFtEIElix5QmZpBBzALLmCRO
        PGljhpi6l1FiwdK7YN1sAvoSB8+eBOvgFbCTmDbxPyOIzSKgKtG6ZTGYLSoQIfF8+w1GiBpB
        iZMzn4DVcwpYSSxsews2h1lAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpH0WkpZZSFpm
        IWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDqtx37uXkH46WNwYcYBTgYlXh4D4iK
        xwmxJpYVV+YeYpTgYFYS4T16QyxOiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBCSmvJN7Q
        1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAPjhF7f9TxbF086yiKxYdfu
        HOP/jT+unH/vWMtlukL6wLecr4GsN2u6VfqN771VeHsk//NatmD2wMlPFE+F9p/eGbfsW6vS
        Px2bzsl3tod2+ejuFy32yedIOC1SuXbK1nBev6lWJ8tO7JrGxtMyoerfwQ+995Q/rZ149sV/
        1ga5Mt3SrGcOjaV/lViKMxINtZiLihMBEU4KyhADAAA=
X-CMS-MailID: 20200110085631eucas1p28523b3a56f6f9431c822871aba68f617
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea
References: <20200107090519.3231-1-cw00.choi@samsung.com>
        <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
        <20200107090519.3231-3-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 07.01.2020 10:05, Chanwoo Choi wrote:
> Add new devfreq_transitions debugfs file to track the frequency transitions
> of all devfreq devices for the simple profiling as following:
> - /sys/kernel/debug/devfreq/devfreq_transitions
> 
> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
> in Kconfig in order to save the transition history.
> 
> [Detailed description of each field of 'devfreq_transitions' debugfs file]
> - time_ms	: Change time of frequency transition. (unit: millisecond)
> - dev_name	: Device name of h/w.
> - dev		: Device name made by devfreq core.
> - parent_dev	: If devfreq device uses the passive governor,
> 		  show parent devfreq device name.
> - load_%	: If devfreq device uses the simple_ondemand governor,
> 		  load is used by governor whene deciding the new frequency.
> 		  (unit: percentage)
> - old_freq_hz	: Frequency before changing. (unit: hz)

s/hz/Hz/

> - new_freq_hz	: Frequency after changed. (unit: hz)

s/hz/Hz/

> 
> [For example on Exynos5422-based Odroid-XU3 board]
> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz

s/hz/Hz/

> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000

Imho it is better to align freq numbers to right, for example:

14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000     67000000
14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000

> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
> [snip]
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/Kconfig            |  13 +++
>  drivers/devfreq/devfreq.c          | 126 +++++++++++++++++++++++++++++
>  drivers/devfreq/governor.h         |   3 +
>  drivers/devfreq/governor_passive.c |   2 +
>  include/linux/devfreq.h            |   1 +
>  5 files changed, 145 insertions(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 0b1df12e0f21..84936eec0ef9 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -74,6 +74,19 @@ config DEVFREQ_GOV_PASSIVE
>  	  through sysfs entries. The passive governor recommends that
>  	  devfreq device uses the OPP table to get the frequency/voltage.
>  
> +comment "DEVFREQ Debugging"
> +
> +config NR_DEVFREQ_TRANSITIONS
> +	int "Maximum storage size to save DEVFREQ Transitions (10-1000)"
> +	depends on DEBUG_FS
> +	range 10 1000
> +	default "100"
> +	help
> +	  Show the frequency transitions of all devfreq devices via
> +	  '/sys/kernel/debug/devfreq/devfreq_transitions' for the simple
> +	  profiling. It needs to decide the storage size to save transition
> +	  history of all devfreq devices.
> +
>  comment "DEVFREQ Drivers"
>  
>  config ARM_EXYNOS_BUS_DEVFREQ
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index c7f5e4e06420..7abaae06fa65 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -268,6 +268,57 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  }
>  EXPORT_SYMBOL(devfreq_update_status);
>  
> +/**
> + * devfreq_update_transitions() - Update frequency transitions for debugfs file
> + * @devfreq:	the devfreq instance
> + * @old_freq:	the previous frequency before changing the frequency
> + * @new_freq:	the new frequency after frequency is changed
> + */
> +struct devfreq_transitions {
> +	struct devfreq *devfreq;
> +	struct devfreq_freqs freqs;
> +	unsigned long load;
> +} debugfs_transitions[CONFIG_NR_DEVFREQ_TRANSITIONS];
> +
> +static spinlock_t devfreq_debugfs_lock;
> +static int debugfs_transitions_index;
> +
> +void devfreq_update_transitions(struct devfreq *devfreq,
> +			unsigned long old_freq, unsigned long new_freq,
> +			unsigned long busy_time, unsigned long total_time)
> +{
> +	unsigned long load;
> +	int i;
> +
> +	if (!devfreq_debugfs || !devfreq || (old_freq == new_freq))
> +		return;
> +
> +	spin_lock_nested(&devfreq_debugfs_lock, SINGLE_DEPTH_NESTING);
> +
> +	i = debugfs_transitions_index;
> +
> +	/*
> +	 * Calculate the load and if load is larger than 100,
> +	 * initialize to 100 because the unit of load is percentage.
> +	 */

Remove this comment, it is better to print numbers as they are so one can
find a problem.

> +	load = (total_time == 0 ? 0 : (100 * busy_time) / total_time);
> +	if (load > 100)
> +		load = 100;

Imho it should always be busy_time <= total_time, so

	if (load > 100) {
		WARN_ONCE(busy_time > total_time, "devfreq: busy_time > total_time");
		load = 100;
	}

Or drop this "if (load > 100) load=100;" and print load as is in logs.

> +
> +	debugfs_transitions[i].devfreq = devfreq;
> +	debugfs_transitions[i].freqs.time = ktime_to_ms(ktime_get());
> +	debugfs_transitions[i].freqs.old = old_freq;
> +	debugfs_transitions[i].freqs.new = new_freq;
> +	debugfs_transitions[i].load = load;
> +
> +	if (++i == CONFIG_NR_DEVFREQ_TRANSITIONS)
> +		i = 0;
> +	debugfs_transitions_index = i;
> +
> +	spin_unlock(&devfreq_debugfs_lock);
> +}
> +EXPORT_SYMBOL(devfreq_update_transitions);
> +
>  /**
>   * find_devfreq_governor() - Find devfreq governor from name
>   * @name:	name of the governor
> @@ -401,6 +452,10 @@ static int set_target(struct devfreq *devfreq,
>  		return err;
>  	}
>  
> +	devfreq_update_transitions(devfreq, cur_freq, new_freq,
> +					devfreq->last_status.busy_time,
> +					devfreq->last_status.total_time);
> +
>  	freqs.new = new_freq;
>  	notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>  
> @@ -1787,6 +1842,72 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>  
> +/**
> + * devfreq_transitions_show() - Show the frequency transitions of the registered
> + *			devfreq devices via 'devfreq_transitions' debugfs file.
> + */
> +static int devfreq_transitions_show(struct seq_file *s, void *data)
> +{
> +	struct devfreq *devfreq = NULL;
> +	struct devfreq *p_devfreq = NULL;
> +	struct devfreq_freqs *freqs = NULL;
> +	unsigned long load;
> +	int i = debugfs_transitions_index;
> +	int count;
> +
> +	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
> +			"time_ms",
> +			"dev_name",
> +			"dev",
> +			"parent_dev",
> +			"load_%",
> +			"old_freq_hz",
> +			"new_freq_hz");
> +	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
> +			"----------",
> +			"------------------------------",
> +			"----------",
> +			"----------",
> +			"----------",
> +			"------------",
> +			"------------");
> +
> +	spin_lock(&devfreq_debugfs_lock);
> +	for (count = 0; count < CONFIG_NR_DEVFREQ_TRANSITIONS; count++) {
> +		devfreq = debugfs_transitions[i].devfreq;
> +		freqs = &debugfs_transitions[i].freqs;
> +		load = debugfs_transitions[i].load;
> +
> +		i = (CONFIG_NR_DEVFREQ_TRANSITIONS == ++i) ? 0 : i;
> +		if (!devfreq)
> +			continue;
> +
> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> +		if (!strncmp(devfreq->governor_name,
> +				DEVFREQ_GOV_PASSIVE, DEVFREQ_NAME_LEN)) {
> +			struct devfreq_passive_data *data = devfreq->data;
> +
> +			if (data)
> +				p_devfreq = data->parent;
> +		} else {
> +			p_devfreq = NULL;
> +		}
> +#endif
> +		seq_printf(s, "%-10lld %-30s %-10s %-10s %-6ld %-12ld %-12ld\n",
> +			freqs->time,
> +			dev_name(devfreq->dev.parent),
> +			dev_name(&devfreq->dev),
> +			p_devfreq ? dev_name(&p_devfreq->dev) : "",
> +			load,
> +			freqs->old,
> +			freqs->new);
> +	}
> +	spin_unlock(&devfreq_debugfs_lock);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(devfreq_transitions);
> +
>  static int __init devfreq_init(void)
>  {
>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
> @@ -1808,9 +1929,14 @@ static int __init devfreq_init(void)
>  		devfreq_debugfs = NULL;
>  		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
>  	} else {
> +		spin_lock_init(&devfreq_debugfs_lock);
> +
>  		debugfs_create_file("devfreq_summary", 0444,
>  				devfreq_debugfs, NULL,
>  				&devfreq_summary_fops);
> +		debugfs_create_file("devfreq_transitions", 0444,
> +				devfreq_debugfs, NULL,
> +				&devfreq_transitions_fops);
>  	}
>  
>  	return 0;
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index dc7533ccc3db..01eecfdaf2d6 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -68,6 +68,9 @@ extern int devfreq_add_governor(struct devfreq_governor *governor);
>  extern int devfreq_remove_governor(struct devfreq_governor *governor);
>  
>  extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
> +extern void devfreq_update_transitions(struct devfreq *devfreq,
> +			unsigned long old_freq, unsigned long new_freq,
> +			unsigned long busy_time, unsigned long total_time);
>  
>  static inline int devfreq_update_stats(struct devfreq *df)
>  {
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index be6eeab9c814..05fa654239f5 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -109,6 +109,8 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>  	if (ret < 0)
>  		goto out;
>  
> +	devfreq_update_transitions(devfreq, devfreq->previous_freq, freq, 0, 0);
> +
>  	if (devfreq->profile->freq_table
>  		&& (devfreq_update_status(devfreq, freq)))
>  		dev_err(&devfreq->dev,
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 49cdb2378030..933692e5d867 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -196,6 +196,7 @@ struct devfreq {
>  };
>  
>  struct devfreq_freqs {
> +	s64 time;

Imho is should be moved to struct devfreq_transitions.
Or do you plan to change load calculations based on time ?

>  	unsigned long old;
>  	unsigned long new;
>  };
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

