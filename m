Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3421334E4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 22:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAGVbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 16:31:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33898 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgAGVbf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 16:31:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so860009lfc.1;
        Tue, 07 Jan 2020 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ndo3ngO0Jwi+A5ZK5R0unBiVsHre3YGn+c1daP6kx+U=;
        b=TklxvwlptMdpZ+6rrnc5AoJ8lGDyMlLKZnh1aGHW1pbC7zQC4jsdqkkznEoHZ/3NcJ
         PwDdc58T+IlkDEREAuqqeaKtJZPhNqaOj+G5rMaadINvT/y0K16pDSwy+EXa025I+Wip
         LKjWFFD5dZ3vrQ04WeRBKCfm6m+IzlCLaZjuEh6o+SR7W8PnwVUzY/B3g8coFE0CAWex
         8Jy+fuTr+Szk9iM25vOGf2A8ftKEKpwhv4I0ZqQuOYdKA4hBG7Vum7G0cLHrWhhCjCrf
         fLWZg/ReX3FBPuXZ4m4rVnVIEvJDeb0NLmlbWdqInE4TYYsKoqiYnzOBokdP6o/DdzDm
         djmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ndo3ngO0Jwi+A5ZK5R0unBiVsHre3YGn+c1daP6kx+U=;
        b=RhMLZeDqf9SU4TSdfEN8W0J7tR8YQp8FyPkwfAQu6ag6C4mgKithqCbGkpPzK4AS/R
         K00yQ0ZbP6Agg5DJyxqLha2ZblefEkm0kUYjEstlsrRl8AIDuTMFEW98xyQFMnFBfU4E
         iL6HNpuqZWfLi0DjT3BcUPTvHL0ndkF69at8NDPXBppfRf+sfxRo2LZPX5LeorkhIiY1
         aGIomGbyWZ+4Uvrx/S1I2IryoHLMPBBaGI5P/G2YttMMwAEbE/sHoiAVRdnqLxMI36Sh
         7aO03aqUdT+3v7jAxPHeXzVOkZhReQe9WjDQoMs5iZu8VXOQl0A5yPBMpCw5xmpzjmU5
         HUkA==
X-Gm-Message-State: APjAAAUYSVJd8i98iFyD8KGVqVP91etDj/8mrlNjmmBnLQJqcBqXZ5BL
        5GZR5nYpxzrq/IejSWMnl8w=
X-Google-Smtp-Source: APXvYqxqdFmxCAhDL9VtM6NNduerrH4n4GKUMEeesHig6Twk7oJqWcihiUYaaAjNQ03gTAz5FiroTw==
X-Received: by 2002:a19:491a:: with SMTP id w26mr858491lfa.98.1578432691516;
        Tue, 07 Jan 2020 13:31:31 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r12sm316428ljh.105.2020.01.07.13.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 13:31:30 -0800 (PST)
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
Message-ID: <2c259936-f099-a239-9d6b-08f9b253644f@gmail.com>
Date:   Wed, 8 Jan 2020 00:31:29 +0300
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

Hello Chanwoo,

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

This could be:

static DEFINE_SPINLOCK(devfreq_debugfs_lock);

and then spin_lock_init() isn't needed.


Also, The "<linux/spinlock.h>" should be included directly by devfreq.c

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

What about EXPORT_SYMBOL_GPL()?

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
> +	spin_lock(&devfreq_debugfs_lock);> +	for (count = 0; count < CONFIG_NR_DEVFREQ_TRANSITIONS; count++) {
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

The 'extern' attribute isn't needed for function prototypes defined in
header files.
