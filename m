Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED3133553
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 22:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgAGV4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 16:56:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34923 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgAGV4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 16:56:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so1197095lja.2;
        Tue, 07 Jan 2020 13:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dj6V9kuupxbOZ0Blj1z5gjna0xB0pxqUrwbQ6EUO2oQ=;
        b=Pw8pyR82BC8h9MsDA04dF9JuOU+bTik9DqQVPU/Udbos2dVWoPSyLyC/JEzg8GuNu4
         1VQypU2NFsXHHazqG+vht4NUIvrYAW7uDHCKz1tNxuKQo87XraAKM5//rjVYWzfLQLOC
         UVSiJupxSz4vbXgwLQZkVhmu7lEL9omqAbSKtQmymNaw8V32bLCLnxV93RxYQ7ioxiXe
         kc/TDjnEVg/0z1K8uxoqZ3quScVQKrJfGpSADxNaGvFxBvLxZCnOfklXiSLsOFTHt2bK
         XtldM5vSprdbkuIYeRtHjsOKLqPtSzdiks4pirssbEEDvSVIhl9a6xm6k93PXsV9Yw31
         522w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dj6V9kuupxbOZ0Blj1z5gjna0xB0pxqUrwbQ6EUO2oQ=;
        b=ZBudVEeMk+B9gOnBHs47pYX+H/hMukWJlzroUbhNv/gf7S0gQIRteUHVk9JGDDdhgT
         5EoPwSwBMEqx21yz8hAs3yCxKhsnBkr4MTzjDhRYeNVStPN1lQHz9o33/ooPHS2Do9Za
         lOqcpjRJyBCb4BQ6jMIHSoeiWpCeiMUo2f+1j+WTOSWeeWwtmSe4qhhbD2vyPspzz4/T
         IDPQjLmQck9qvLcQPkugKJjMXToIvDkwJmikdscOSrTn1nmYS3NFkJTKgtv8x66ts4PY
         nOttpr+a9iNWky07luVXaQqh5olubaGbUhoEa6x63TWpacCBxWGB76WR8NcSKXW5nJQX
         WEyQ==
X-Gm-Message-State: APjAAAX/uAX7khnAQ2tD93D9ESZQ7MyLukJ8m4QNwURUAI2zUGekpP1F
        9xADwXYifM/Awul4Uv8CHCQ=
X-Google-Smtp-Source: APXvYqwWX0tL/uB3qiI8SR3cuMKW6vccr1vW3ArnPY6hGFGa3ZANJXNEoQwQWl+b8aYfk5e4W8pfug==
X-Received: by 2002:a2e:89ce:: with SMTP id c14mr828186ljk.13.1578434204558;
        Tue, 07 Jan 2020 13:56:44 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w1sm395245lfe.96.2020.01.07.13.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 13:56:43 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b64bf3d4-5b46-243b-495a-e1060af7a266@gmail.com>
Date:   Wed, 8 Jan 2020 00:56:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200107090519.3231-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.01.2020 12:05, Chanwoo Choi пишет:
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
> - new_freq_hz	: Frequency after changed. (unit: hz)
> 
> [For example on Exynos5422-based Odroid-XU3 board]
> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
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
> +	load = (total_time == 0 ? 0 : (100 * busy_time) / total_time);
> +	if (load > 100)
> +		load = 100;
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

Isn't this needed here?

mutex_lock(&devfreq_list_lock);

> +	spin_lock(&devfreq_debugfs_lock);
> +	for (count = 0; count < CONFIG_NR_DEVFREQ_TRANSITIONS; count++) {
> +		devfreq = debugfs_transitions[i].devfreq;
> +		freqs = &debugfs_transitions[i].freqs;
> +		load = debugfs_transitions[i].load;
> +
> +		i = (CONFIG_NR_DEVFREQ_TRANSITIONS == ++i) ? 0 : i;
> +		if (!devfreq)
> +			continue;

I suppose debugfs_transitions[i].devfreq should be set to NULL when
devfreq device is removed, but I don't see it happening anywhere in this
patch.

> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> +		if (!strncmp(devfreq->governor_name,
> +				DEVFREQ_GOV_PASSIVE, DEVFREQ_NAME_LEN)) {

This could be:

if (IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) &&
    !strncmp(devfreq->governor_name,
		  DEVFREQ_GOV_PASSIVE, DEVFREQ_NAME_LEN)) {

> +			struct devfreq_passive_data *data = devfreq->data;
> +
> +			if (data)
> +				p_devfreq = data->parent;

const char *devname = "";

...

	if (data)
		devname = dev_name(data->parent);

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
>  	unsigned long old;
>  	unsigned long new;
>  };
> 

