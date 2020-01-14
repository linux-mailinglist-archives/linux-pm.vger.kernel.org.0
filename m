Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F90139F9C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 03:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgANCwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 21:52:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40927 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgANCwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 21:52:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so12525497ljk.7;
        Mon, 13 Jan 2020 18:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LJGl9RPIMmwWgrrFWFdKl/8CYMH4TJ9TFmgSiZJKLOY=;
        b=ldPMbY34jBpu5kRDgnhSJX8756FVQyEFJ2dYsuLggcvNqf8tzY1s1N4iAbPbpU73W+
         ocwlh8Dz4i83ernkbJNmqf+K8e3VmuzArwvvbybdC+v/5cxBe8MyvNIQpbs/pkcymHye
         eZzeaVALveAAruw5ptpgoO1pjJgXBuveMCnAJpAruw6I+5fy6RFTHC7U2Z+1G/9JonSm
         6YrliZwcSUGZfaMrsfg8NYRL4uqiDaHblZaex9OOii0BI0Mw915JYl28bOCYaJ1h4cba
         J2pCEBdaZPOVdxA8lAUaiVl9EbFot6866ptI07gS9za3A0d+gjkV526f4XrRRZTCeOfS
         BhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LJGl9RPIMmwWgrrFWFdKl/8CYMH4TJ9TFmgSiZJKLOY=;
        b=B3Lw/n8Z0oyP+jCzaVNRovswP8fGey8rYXW6p7ENy+zBZhBBFeyWsB3O9V+RivjAtv
         mkQ/7CfnMoLXy6h0h/lcKNQ667onXa1KVeRuEBhPBc1EfSBEchJPUTuJ6Stxrup7HzdA
         J9rMMbmf8yC/I411Ufn9cF72SrezZwwcZ7ijqm2DF4YmGoosd4ZyTeiVpyM1+VHHWwXh
         3ZjRrYA+aeAiaEUS6k3uCgVf0EuCFbm6YkYYslZbEu3I2dcC23T2TZmqYWlMJqZPeDsJ
         WRq72bnYN4EEJbtx0RIXcYaUMBBq2AsleMtFidcEl05KJrdzxPIFC5gzGNxOST/GrSwT
         Kd0w==
X-Gm-Message-State: APjAAAXI+3JAtNCy9btd5AT5FgKbdi/85qercubWhS7PNlqwlj7U3qOJ
        WnjLMAzig5NL2YRRGoTO7hs=
X-Google-Smtp-Source: APXvYqzGr6Tf6DIW5TVS7bg/wTJFTDxmwZmitO3OCM+4gXWhi2pycX2v4BlFR1osvgMPbBbO6awcMw==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr12975816ljj.157.1578970352222;
        Mon, 13 Jan 2020 18:52:32 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i19sm6473496lfj.17.2020.01.13.18.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 18:52:31 -0800 (PST)
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
 <20ebd8e0-f74c-335c-4af8-35c3dc81902f@gmail.com>
 <9635588e-66c2-14d5-9d84-43dbce976722@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <23577185-ac0a-c7e7-74f0-dc2743419385@gmail.com>
Date:   Tue, 14 Jan 2020 05:51:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9635588e-66c2-14d5-9d84-43dbce976722@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.01.2020 05:23, Chanwoo Choi пишет:
> On 1/14/20 10:45 AM, Dmitry Osipenko wrote:
>> 14.01.2020 04:45, Chanwoo Choi пишет:
>>> Add debugfs interface to provide debugging information of devfreq device.
>>> It contains 'devfreq_summary' entry to show the summary of registered
>>> devfreq devices as following and the additional debugfs file will be added.
>>> - /sys/kernel/debug/devfreq/devfreq_summary
>>>
>>> [Detailed description of each field of 'devfreq_summary' debugfs file]
>>> - dev_name	: Device name of h/w.
>>> - dev		: Device name made by devfreq core.
>>> - parent_dev	: If devfreq device uses the passive governor,
>>> 		  show parent devfreq device name. Otherwise, show 'null'.
>>> - governor	: Devfreq governor.
>>> - polling_ms	: If devfreq device uses the simple_ondemand governor,
>>> 		  polling_ms is necessary for the period. (unit: millisecond)
>>> - cur_freq_Hz	: Current Frequency (unit: Hz)
>>> - old_freq_Hz	: Frequency before changing. (unit: Hz)
>>> - new_freq_Hz	: Frequency after changed. (unit: Hz)
>>>
>>> [For example on Exynos5422-based Odroid-XU3 board]
>>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>>> dev_name                       dev        parent_dev governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
>>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>>> 10c20000.memory-controller     devfreq0   null       simple_ondemand          0    165000000    165000000    825000000
>>> soc:bus_wcore                  devfreq1   null       simple_ondemand         50    532000000     88700000    532000000
>>> soc:bus_noc                    devfreq2   devfreq1   passive                  0    111000000     66600000    111000000
>>> soc:bus_fsys_apb               devfreq3   devfreq1   passive                  0    222000000    111000000    222000000
>>> soc:bus_fsys                   devfreq4   devfreq1   passive                  0    200000000     75000000    200000000
>>> soc:bus_fsys2                  devfreq5   devfreq1   passive                  0    200000000     75000000    200000000
>>> soc:bus_mfc                    devfreq6   devfreq1   passive                  0    333000000     83250000    333000000
>>> soc:bus_gen                    devfreq7   devfreq1   passive                  0    266000000     88700000    266000000
>>> soc:bus_peri                   devfreq8   devfreq1   passive                  0     66600000     66600000     66600000
>>> soc:bus_g2d                    devfreq9   devfreq1   passive                  0    333000000     83250000    333000000
>>> soc:bus_g2d_acp                devfreq10  devfreq1   passive                  0    266000000     66500000    266000000
>>> soc:bus_jpeg                   devfreq11  devfreq1   passive                  0    300000000     75000000    300000000
>>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive                  0    166500000     83250000    166500000
>>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive                  0    200000000    120000000    200000000
>>> soc:bus_disp1                  devfreq14  devfreq1   passive                  0    300000000    120000000    300000000
>>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive                  0    300000000    150000000    300000000
>>> soc:bus_mscl                   devfreq16  devfreq1   passive                  0    666000000     84000000    666000000
>>>
>>> [lkp: Reported the build error]
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>> Changes from v2:
>>> - Show 'null' at 'parent_dev' field when governor of devfreq device
>>>   is not passive
>>> Changes from v1:
>>> - Drop the patch about 'devfreq_transitions' debugfs file
>>> - Modify from 'hz' to 'Hz'
>>> - Edit the indentation of 'devfreq_summary' when show summary
>>> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir
>>>
>>>  drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 84 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 89260b17598f..c5ef2d194b1b 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -10,6 +10,7 @@
>>>  #include <linux/kernel.h>
>>>  #include <linux/kmod.h>
>>>  #include <linux/sched.h>
>>> +#include <linux/debugfs.h>
>>>  #include <linux/errno.h>
>>>  #include <linux/err.h>
>>>  #include <linux/init.h>
>>> @@ -33,6 +34,7 @@
>>>  #define HZ_PER_KHZ	1000
>>>  
>>>  static struct class *devfreq_class;
>>> +static struct dentry *devfreq_debugfs;
>>>  
>>>  /*
>>>   * devfreq core provides delayed work based load monitoring helper
>>> @@ -1643,6 +1645,79 @@ static struct attribute *devfreq_attrs[] = {
>>>  };
>>>  ATTRIBUTE_GROUPS(devfreq);
>>>  
>>> +/**
>>> + * devfreq_summary_show() - Show the summary of the devfreq devices
>>> + * @s:		seq_file instance to show the summary of devfreq devices
>>> + * @data:	not used
>>> + *
>>> + * Show the summary of the devfreq devices via 'devfreq_summary' debugfs file.
>>> + * It helps that user can know the detailed information of the devfreq devices.
>>> + *
>>> + * Return 0 always because it shows the information without any data change.
>>> + */
>>> +static int devfreq_summary_show(struct seq_file *s, void *data)
>>> +{
>>> +	struct devfreq *devfreq;
>>> +	struct devfreq *p_devfreq = NULL;

Looks like there is no need to pre-initialize the p_devfreq, please see
below.

>>> +	unsigned long cur_freq, min_freq, max_freq;
>>> +	unsigned int polling_ms;
>>> +
>>> +	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",
>>> +			"dev_name",
>>> +			"dev",
>>> +			"parent_dev",
>>> +			"governor",
>>> +			"polling_ms",
>>> +			"cur_freq_Hz",
>>> +			"min_freq_Hz",
>>> +			"max_freq_Hz");
>>> +	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",
>>> +			"------------------------------",
>>> +			"----------",
>>> +			"----------",
>>> +			"---------------",
>>> +			"----------",
>>> +			"------------",
>>> +			"------------",
>>> +			"------------");
>>> +
>>> +	mutex_lock(&devfreq_list_lock);
>>> +
>>> +	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
>>> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
>>> +							DEVFREQ_NAME_LEN)) {
>>> +			struct devfreq_passive_data *data = devfreq->data;
>>> +
>>> +			if (data)
>>> +				p_devfreq = data->parent;

			else
				p_devfreq = NULL;

Otherwise p_devfreq will be reused from a previous devfreq device if
that device has the data->parent.

>>> +		} else {
>>> +			p_devfreq = NULL;
>>> +		}
>>> +
>>> +		mutex_lock(&devfreq->lock);
>>> +		cur_freq = devfreq->previous_freq,
>>> +		get_freq_range(devfreq, &min_freq, &max_freq);
>>> +		polling_ms = devfreq->profile->polling_ms,
>>> +		mutex_unlock(&devfreq->lock);
>>> +
>>> +		seq_printf(s,
>>> +			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",
>>> +			dev_name(devfreq->dev.parent),
>>> +			dev_name(&devfreq->dev),
>>> +			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
>>> +			devfreq->governor_name,
>>> +			polling_ms,
>>> +			cur_freq,
>>> +			min_freq,
>>> +			max_freq);
>>> +	}
>>> +
>>> +	mutex_unlock(&devfreq_list_lock);
>>> +
>>> +	return 0;
>>> +}
>>> +DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>>> +
>>>  static int __init devfreq_init(void)
>>>  {
>>>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
>>> @@ -1659,6 +1734,15 @@ static int __init devfreq_init(void)
>>>  	}
>>>  	devfreq_class->dev_groups = devfreq_groups;
>>>  
>>> +	
>> If you'll you'll take a look at [2], you may notice notice that it
>> checks whether devfreq_debugfs IS_ERR [3] and then bails out.
>>
>> [2] https://protect2.fireeye.com/url?k=a5047d02-f8ca7cd1-a505f64d-000babff317b-ed64c541cd573190&u=https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L432
>> [3] https://protect2.fireeye.com/url?k=0a43fffa-578dfe29-0a4274b5-000babff317b-1c1c1062bfaeb0fc&u=https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L316
>>
>> Thus you could simply remove the above error handling, making code to
>> look cleaner.
>>
>>
> 
> OK. I'll modify it as following: Do you agree?

Looks good, thanks.

> 	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);

I'd also add a newline here, to ease reading of the code.

> 	debugfs_create_file("devfreq_summary", 0444,
> 			devfreq_debugfs, NULL,
> 			&devfreq_summary_fops);
> 
> 

