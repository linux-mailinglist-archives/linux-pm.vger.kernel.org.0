Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC4139F27
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 02:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgANBqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 20:46:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44558 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgANBqm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 20:46:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id u71so12350113lje.11;
        Mon, 13 Jan 2020 17:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zBqQ5F0rr3XsOBwjCic4tQ8MkLzhDDsaq5brNGOxQw=;
        b=MrEkua6rTQG028tetietDv/93SDD64T/77UZMNQdjhfDml6FdzLMb+/sy9d0160TKZ
         2KbPfqgjaq4pE+b9BVQY8p9ZJb4MMLVdg2jreyVgqQYp4LeeUVIJQcEUnPkRi+Q3TQpv
         HpVpmohh2eNnYrUThv98PhDCTsxmj6tvB046wp1jW/SGgqZ41Y/0L5TZrtkEqQ6neo5U
         lZdYNWq7qaA1qSJX5h9EVWnfFKy+Wp1Uj0zGIpiDVV9Z2tqj5yfyiK7BKXrLb+/9JsoM
         UIsecC74dPjZjrNmM39Xtwsh4HmLHjMzPhvJoPIItRnV2evRyPILzgBcjNM7z76uP1yb
         HHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zBqQ5F0rr3XsOBwjCic4tQ8MkLzhDDsaq5brNGOxQw=;
        b=CqVKbjNnjJ2SAJY9oGJY/DuvCKwgHRxCDpOzIp/qbh/HxaDo7W6LgNFKvOnG9UsWCe
         T/vdqnwUl43QXnk7BWM73QLM2HxM76K7V/iCBkLKuiYxWWoRGmIN9PAlozJo1fcXr+8B
         xS4U5gVqVep8NJOSDCRGNJYdVyHPvYBjTCYN9GFKuo4fTFfU7qJ7n9UXUn4vGyFa9zvX
         ANAfyBGkXNI0Act5EVm0CioFYe9/rxdK/5Dp2RnE+PbHkdkRBknuULJF1329rtahgiSF
         lC6XFWKvZfFrpCAGgvbPXkDGNEx9LOtK7gLBOGR89ClqSVRxdMLoBJJYGGnRVkoGiDZV
         BqBw==
X-Gm-Message-State: APjAAAWUhq3n8sSSc1wAs/NvTCgVGCwSAdGMQGWm18DhBHX5Lb6HU7aV
        Tfcz/cVcxUQr4Wex/W3oC5M=
X-Google-Smtp-Source: APXvYqy9kiBZrUwI9OfgMImtDMS7U2OlI1aZ//6Mlwd0yyRCAe62LzYwN+Itsuv98cQgl5VUes04zA==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr12211492ljg.223.1578966400118;
        Mon, 13 Jan 2020 17:46:40 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r2sm6376775lfn.13.2020.01.13.17.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 17:46:39 -0800 (PST)
Subject: Re: [PATCH v3] PM / devfreq: Add debugfs support with devfreq_summary
 file
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <CGME20200114013826epcas1p23a4c6c39f043dd09d33d48541288c1bd@epcas1p2.samsung.com>
 <20200114014540.31490-1-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <20ebd8e0-f74c-335c-4af8-35c3dc81902f@gmail.com>
Date:   Tue, 14 Jan 2020 04:45:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200114014540.31490-1-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.01.2020 04:45, Chanwoo Choi пишет:
> Add debugfs interface to provide debugging information of devfreq device.
> It contains 'devfreq_summary' entry to show the summary of registered
> devfreq devices as following and the additional debugfs file will be added.
> - /sys/kernel/debug/devfreq/devfreq_summary
> 
> [Detailed description of each field of 'devfreq_summary' debugfs file]
> - dev_name	: Device name of h/w.
> - dev		: Device name made by devfreq core.
> - parent_dev	: If devfreq device uses the passive governor,
> 		  show parent devfreq device name. Otherwise, show 'null'.
> - governor	: Devfreq governor.
> - polling_ms	: If devfreq device uses the simple_ondemand governor,
> 		  polling_ms is necessary for the period. (unit: millisecond)
> - cur_freq_Hz	: Current Frequency (unit: Hz)
> - old_freq_Hz	: Frequency before changing. (unit: Hz)
> - new_freq_Hz	: Frequency after changed. (unit: Hz)
> 
> [For example on Exynos5422-based Odroid-XU3 board]
> $ cat /sys/kernel/debug/devfreq/devfreq_summary
> dev_name                       dev        parent_dev governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
> 10c20000.memory-controller     devfreq0   null       simple_ondemand          0    165000000    165000000    825000000
> soc:bus_wcore                  devfreq1   null       simple_ondemand         50    532000000     88700000    532000000
> soc:bus_noc                    devfreq2   devfreq1   passive                  0    111000000     66600000    111000000
> soc:bus_fsys_apb               devfreq3   devfreq1   passive                  0    222000000    111000000    222000000
> soc:bus_fsys                   devfreq4   devfreq1   passive                  0    200000000     75000000    200000000
> soc:bus_fsys2                  devfreq5   devfreq1   passive                  0    200000000     75000000    200000000
> soc:bus_mfc                    devfreq6   devfreq1   passive                  0    333000000     83250000    333000000
> soc:bus_gen                    devfreq7   devfreq1   passive                  0    266000000     88700000    266000000
> soc:bus_peri                   devfreq8   devfreq1   passive                  0     66600000     66600000     66600000
> soc:bus_g2d                    devfreq9   devfreq1   passive                  0    333000000     83250000    333000000
> soc:bus_g2d_acp                devfreq10  devfreq1   passive                  0    266000000     66500000    266000000
> soc:bus_jpeg                   devfreq11  devfreq1   passive                  0    300000000     75000000    300000000
> soc:bus_jpeg_apb               devfreq12  devfreq1   passive                  0    166500000     83250000    166500000
> soc:bus_disp1_fimd             devfreq13  devfreq1   passive                  0    200000000    120000000    200000000
> soc:bus_disp1                  devfreq14  devfreq1   passive                  0    300000000    120000000    300000000
> soc:bus_gscl_scaler            devfreq15  devfreq1   passive                  0    300000000    150000000    300000000
> soc:bus_mscl                   devfreq16  devfreq1   passive                  0    666000000     84000000    666000000
> 
> [lkp: Reported the build error]
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v2:
> - Show 'null' at 'parent_dev' field when governor of devfreq device
>   is not passive
> Changes from v1:
> - Drop the patch about 'devfreq_transitions' debugfs file
> - Modify from 'hz' to 'Hz'
> - Edit the indentation of 'devfreq_summary' when show summary
> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir
> 
>  drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 89260b17598f..c5ef2d194b1b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kmod.h>
>  #include <linux/sched.h>
> +#include <linux/debugfs.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -33,6 +34,7 @@
>  #define HZ_PER_KHZ	1000
>  
>  static struct class *devfreq_class;
> +static struct dentry *devfreq_debugfs;
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
> @@ -1643,6 +1645,79 @@ static struct attribute *devfreq_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(devfreq);
>  
> +/**
> + * devfreq_summary_show() - Show the summary of the devfreq devices
> + * @s:		seq_file instance to show the summary of devfreq devices
> + * @data:	not used
> + *
> + * Show the summary of the devfreq devices via 'devfreq_summary' debugfs file.
> + * It helps that user can know the detailed information of the devfreq devices.
> + *
> + * Return 0 always because it shows the information without any data change.
> + */
> +static int devfreq_summary_show(struct seq_file *s, void *data)
> +{
> +	struct devfreq *devfreq;
> +	struct devfreq *p_devfreq = NULL;
> +	unsigned long cur_freq, min_freq, max_freq;
> +	unsigned int polling_ms;
> +
> +	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",
> +			"dev_name",
> +			"dev",
> +			"parent_dev",
> +			"governor",
> +			"polling_ms",
> +			"cur_freq_Hz",
> +			"min_freq_Hz",
> +			"max_freq_Hz");
> +	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",
> +			"------------------------------",
> +			"----------",
> +			"----------",
> +			"---------------",
> +			"----------",
> +			"------------",
> +			"------------",
> +			"------------");
> +
> +	mutex_lock(&devfreq_list_lock);
> +
> +	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
> +							DEVFREQ_NAME_LEN)) {
> +			struct devfreq_passive_data *data = devfreq->data;
> +
> +			if (data)
> +				p_devfreq = data->parent;
> +		} else {
> +			p_devfreq = NULL;
> +		}
> +
> +		mutex_lock(&devfreq->lock);
> +		cur_freq = devfreq->previous_freq,
> +		get_freq_range(devfreq, &min_freq, &max_freq);
> +		polling_ms = devfreq->profile->polling_ms,
> +		mutex_unlock(&devfreq->lock);
> +
> +		seq_printf(s,
> +			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",
> +			dev_name(devfreq->dev.parent),
> +			dev_name(&devfreq->dev),
> +			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
> +			devfreq->governor_name,
> +			polling_ms,
> +			cur_freq,
> +			min_freq,
> +			max_freq);
> +	}
> +
> +	mutex_unlock(&devfreq_list_lock);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
> +
>  static int __init devfreq_init(void)
>  {
>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
> @@ -1659,6 +1734,15 @@ static int __init devfreq_init(void)
>  	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
> +	if (IS_ERR(devfreq_debugfs) && PTR_ERR(devfreq_debugfs) != -ENODEV) {
> +		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);

If you'll take a look at [1], you may notice that it could fail only in
a single place in the code and in that case the error message is already
printed.

[1] https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L543

> +	} else {
> +		debugfs_create_file("devfreq_summary", 0444,
> +				devfreq_debugfs, NULL,
> +				&devfreq_summary_fops);

If you'll you'll take a look at [2], you may notice notice that it
checks whether devfreq_debugfs IS_ERR [3] and then bails out.

[2] https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L432
[3] https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L316

Thus you could simply remove the above error handling, making code to
look cleaner.
