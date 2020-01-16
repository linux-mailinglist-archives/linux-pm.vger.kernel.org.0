Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7148413D74A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 11:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgAPKAL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 05:00:11 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63321 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgAPKAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 05:00:11 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200116100008epoutp0294c21774c537aa9e848e87dcb88db744~qVaoFVeCr0111101111epoutp021
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 10:00:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200116100008epoutp0294c21774c537aa9e848e87dcb88db744~qVaoFVeCr0111101111epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579168808;
        bh=MEoghVumURoxUB00h51rzO4YEcv5WlLCayoXPMnB0HA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RsTWMnLj/dHRxfTCqPmamAXVp9vnvEjqkNrBZQDagZ2csxr97uA9ahptY8Ah99EKe
         TYJ7oS5fEbEVYhVS70N3ybauZ5OVK+uTCLnDl2AAJOEcdLflq9oYNfLJ1SKT0J5Chy
         i7xZf/+i7dIfLyoyyMf7VoEHQJ1EzDDcyqHy3nMM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200116100007epcas1p2450126eb14072af0ed6ae6545ae4148c~qVanlh8tn0690106901epcas1p2Z;
        Thu, 16 Jan 2020 10:00:07 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47z06s2XnCzMqYm0; Thu, 16 Jan
        2020 10:00:05 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.05.48498.524302E5; Thu, 16 Jan 2020 19:00:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200116100004epcas1p4efae9ceadaa5261ad8729e76409c5484~qValGqGk31863218632epcas1p4s;
        Thu, 16 Jan 2020 10:00:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116100004epsmtrp14ba7c6c9c6cd3e18705f0dd376ed2aa5~qValF2UwI1337313373epsmtrp1B;
        Thu, 16 Jan 2020 10:00:04 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-60-5e20342522e7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.58.10238.424302E5; Thu, 16 Jan 2020 19:00:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116100004epsmtip2f9be879c908a0652d2278e5e26874dbf~qVak1_asA1026610266epsmtip2A;
        Thu, 16 Jan 2020 10:00:04 +0000 (GMT)
Subject: Re: [PATCH v4] PM / devfreq: Add debugfs support with
 devfreq_summary file
To:     Kamil Konieczny <k.konieczny@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fa6c9b94-2708-ff37-89ac-7071a5af4d7c@samsung.com>
Date:   Thu, 16 Jan 2020 19:07:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <50b2f033-779c-63b7-f1f0-1af730237925@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmga6qiUKcwfYOEYv781oZLU7vf8di
        MfHGFRaL1R8fM1qsuX2I0eLHhlPMFhsXZFss+DSD1eJs0xt2ixV3P7JaXN41h83ic+8RRouF
        TS3sFmuP3GW3uN24gs2B32PNvDWMHpf7epk8dtxdwuixc9Zddo9NqzrZPO5c28PmsfHdDiaP
        v7P2s3j0bVnF6PF5k1wAV1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5i
        bqqtkotPgK5bZg7QG0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE3OLS
        vHS95PxcK0MDAyNToMKE7IwNLWcYC+baV+xYXdvAeE6vi5GTQ0LARGJWVxtjFyMXh5DADkaJ
        vf+3sUM4nxglFk7+yQbhfGOUeL3vLytMy/J351kgEnsZJS7P3Q1V9Z5R4lX/ShaQKmGBUIlH
        l84zgdgiAukSE3+9BCtiFljGJHHy2Q2wIjYBLYn9L26wgdj8AooSV388ZgSxeQXsJN59OQ62
        jkVAVWL/0+9gNaICYRInt7VA1QhKnJz5BGwOp4C9xJypc9hBbGYBcYlbT+YzQdjyEtvfzmEG
        WSwhcI5d4u7qJ2wQP7hILNr5gwnCFpZ4dXwLO4QtJfGyvw3KrpZYefIIG0RzB6PElv0XoAFg
        LLF/6WSgZg6gDZoS63fpQ4QVJXb+nssIsZhP4t3XHlaQEgkBXomONiGIEmWJyw/uQq2VlFjc
        3sk2gVFpFpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAIObo3MYLTuJbZDsZF53wOMQpw
        MCrx8B74JxcnxJpYVlyZe4hRgoNZSYT35AzZOCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqc
        D8wxeSXxhqZGxsbGFiaGZqaGhkrivC4LgOYIpCeWpGanphakFsH0MXFwSjUw6t/YkpO/t26i
        oZ1aTVD8mVVGiiZVs/xPfjAvuXqzeqZPzeqsVxbLBSdejK2qcu+teteZe3DmMbHAqVniHCy8
        pfYyi+rkZp/rY1/+cfNdnqLKxqhFe3Wmzjg1Vcw7NXqOvOKkA1EyNXW6vjP/R627FLOScesK
        jpjuYIOCves7jz9NenRA/qO7EktxRqKhFnNRcSIAA7lAP/kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRiA+3bOzo6z5WkafippjkoS0haSH1Gu6M+hXxYUXWg29DDN3djx
        DuE9UFIqUdZhTQNL2SaoaM0MppuXVmnWLCwd/dgEiRyYllZauY1g/x54n+d7+XhJTDyDx5MF
        miJGr1GoJIQQf+KUJB3en7FPfqTBm44+m+oBemX34+ju3CyOLCtegKzzDoA2el9iqK+jEHV8
        M/DRVM1XAer2rPCR+5mRQKtNYwA9rKkToJ4xjwDNV3cTp6Joq8kKaHdzE4+2eToBPcR5BHS/
        uYGgFz48J+g+v41Hb3F2nG4eMAN6tT8xW3hFeCKPURWUMPr0rOvC/N6610D3QFZms9ysAtNp
        jSCChFQG7PK/wRuBkBRTwwB+cbYQoUEcbHs7jjUCcpujodPJhpxlAOurNvgBJ5q6AB3Vs3iA
        YygldNZyICBh1GMefOG7hYUKB4CWWiMWsAgqFdqX5oIboqhk+H7DCwIsorKgf20y+CpOHYD2
        xfWgs4e6CIc6vbyQsxu67vuC2yIoGTS2GgUBxqgUuGl6h4U4Fn7ytfNCnASfLhuxOyCaC8u5
        sIQLS7iwpAPgZhDH6Fi1Us1KdVINU5rGKtRssUaZlqtV94PgnVMP2YC7M8cBKBJIdoryNxPl
        Yr6ihC1Xb/+YxCQxIpdhr1wsylOUVzB6bY6+WMWwDpBA4pJY0aJm4rKYUiqKmEKG0TH6/1Me
        GRFfBcyRY9pFl71QzByt9FlP9t1Yl136+b1n9hgubz6+pjo/elWWlUn8KaM/Tpz5ZUyoHJyG
        fM29CvfSjt8tydJryQXApaU1oGHV4J08W2od6Gon4kexEeFCyrkR3BL5Y5wZyTMNSAziqYPD
        9tMZmY9y/6Lb2fVt/l3E1sxga4kEZ/MV0lRMzyr+AbArfanjAgAA
X-CMS-MailID: 20200116100004epcas1p4efae9ceadaa5261ad8729e76409c5484
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074
References: <CGME20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074@epcas1p2.samsung.com>
        <20200116050313.3564-1-cw00.choi@samsung.com>
        <50b2f033-779c-63b7-f1f0-1af730237925@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/16/20 6:53 PM, Kamil Konieczny wrote:
> Hi Chanwoo,
> 
> On 16.01.2020 06:03, Chanwoo Choi wrote:
>> Add debugfs interface to provide debugging information of devfreq device.
>> It contains 'devfreq_summary' entry to show the summary of registered
>> devfreq devices as following and the additional debugfs file will be added.
>> - /sys/kernel/debug/devfreq/devfreq_summary
>>
>> [Detailed description of each field of 'devfreq_summary' debugfs file]
>> - dev_name	: Device name of h/w.
>> - dev		: Device name made by devfreq core.
>> - parent_dev	: If devfreq device uses the passive governor,
>> 		  show parent devfreq device name. Otherwise, show 'null'.
>> - governor	: Devfreq governor.
>> - polling_ms	: If devfreq device uses the simple_ondemand governor,
>> 		  polling_ms is necessary for the period. (unit: millisecond)
>> - cur_freq_Hz	: Current Frequency (unit: Hz)
> 
> s/Frequency/frequency/
> 
>> - old_freq_Hz	: Frequency before changing. (unit: Hz)
> 
> min_freq_Hz : Minimum frequency (unit Hz)
> 
>> - new_freq_Hz	: Frequency after changed. (unit: Hz)
> 
> max_freq_Hz : Maximum frequency (unit Hz)

Right. Thanks for pointing out.

> 
>>
>> [For example on Exynos5422-based Odroid-XU3 board]
>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>> dev_name                       dev        parent_dev governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>> 10c20000.memory-controller     devfreq0   null       simple_ondemand          0    165000000    165000000    825000000
>> soc:bus_wcore                  devfreq1   null       simple_ondemand         50    532000000     88700000    532000000
>> soc:bus_noc                    devfreq2   devfreq1   passive                  0    111000000     66600000    111000000
>> soc:bus_fsys_apb               devfreq3   devfreq1   passive                  0    222000000    111000000    222000000
>> soc:bus_fsys                   devfreq4   devfreq1   passive                  0    200000000     75000000    200000000
>> soc:bus_fsys2                  devfreq5   devfreq1   passive                  0    200000000     75000000    200000000
>> soc:bus_mfc                    devfreq6   devfreq1   passive                  0    333000000     83250000    333000000
>> soc:bus_gen                    devfreq7   devfreq1   passive                  0    266000000     88700000    266000000
>> soc:bus_peri                   devfreq8   devfreq1   passive                  0     66600000     66600000     66600000
>> soc:bus_g2d                    devfreq9   devfreq1   passive                  0    333000000     83250000    333000000
>> soc:bus_g2d_acp                devfreq10  devfreq1   passive                  0    266000000     66500000    266000000
>> soc:bus_jpeg                   devfreq11  devfreq1   passive                  0    300000000     75000000    300000000
>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive                  0    166500000     83250000    166500000
>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive                  0    200000000    120000000    200000000
>> soc:bus_disp1                  devfreq14  devfreq1   passive                  0    300000000    120000000    300000000
>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive                  0    300000000    150000000    300000000
>> soc:bus_mscl                   devfreq16  devfreq1   passive                  0    666000000     84000000    666000000
>>
>> [lkp: Reported the build error]
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> Changes from v3:
>> - Remove the unneeded checking of return value when calling debugfs_create_dir
>> - Add missing IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) condition
>> Changes from v2:
>> - Show 'null' at 'parent_dev' field when governor of devfreq device
>>   is not passive
>> Changes from v1:
>> - Drop the patch about 'devfreq_transitions' debugfs file
>> - Modify from 'hz' to 'Hz'
>> - Edit the indentation of 'devfreq_summary' when show summary
>> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir
>>
>>
>>  drivers/devfreq/devfreq.c | 82 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 89260b17598f..cceee8bc3c2f 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/kmod.h>
>>  #include <linux/sched.h>
>> +#include <linux/debugfs.h>
>>  #include <linux/errno.h>
>>  #include <linux/err.h>
>>  #include <linux/init.h>
>> @@ -33,6 +34,7 @@
>>  #define HZ_PER_KHZ	1000
>>  
>>  static struct class *devfreq_class;
>> +static struct dentry *devfreq_debugfs;
>>  
>>  /*
>>   * devfreq core provides delayed work based load monitoring helper
>> @@ -1643,6 +1645,81 @@ static struct attribute *devfreq_attrs[] = {
>>  };
>>  ATTRIBUTE_GROUPS(devfreq);
>>  
>> +/**
>> + * devfreq_summary_show() - Show the summary of the devfreq devices
>> + * @s:		seq_file instance to show the summary of devfreq devices
>> + * @data:	not used
>> + *
>> + * Show the summary of the devfreq devices via 'devfreq_summary' debugfs file.
>> + * It helps that user can know the detailed information of the devfreq devices.
>> + *
>> + * Return 0 always because it shows the information without any data change.
>> + */
>> +static int devfreq_summary_show(struct seq_file *s, void *data)
>> +{
>> +	struct devfreq *devfreq;
>> +	struct devfreq *p_devfreq = NULL;
>> +	unsigned long cur_freq, min_freq, max_freq;
>> +	unsigned int polling_ms;
>> +
>> +	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",
>> +			"dev_name",
>> +			"dev",
>> +			"parent_dev",
>> +			"governor",
>> +			"polling_ms",
>> +			"cur_freq_Hz",
>> +			"min_freq_Hz",
>> +			"max_freq_Hz");
>> +	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",
>> +			"------------------------------",
>> +			"----------",
>> +			"----------",
>> +			"---------------",
>> +			"----------",
>> +			"------------",
>> +			"------------",
>> +			"------------");
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +
>> +	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
>> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
>> +							DEVFREQ_NAME_LEN)) {
>> +			struct devfreq_passive_data *data = devfreq->data;
>> +
>> +			if (data)
>> +				p_devfreq = data->parent;
>> +		} else {
>> +			p_devfreq = NULL;
>> +		}
>> +#endif
>> +
>> +		mutex_lock(&devfreq->lock);
>> +		cur_freq = devfreq->previous_freq,
>> +		get_freq_range(devfreq, &min_freq, &max_freq);
>> +		polling_ms = devfreq->profile->polling_ms,
>> +		mutex_unlock(&devfreq->lock);
>> +
>> +		seq_printf(s,
>> +			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",
>> +			dev_name(devfreq->dev.parent),
>> +			dev_name(&devfreq->dev),
>> +			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
>> +			devfreq->governor_name,
>> +			polling_ms,
>> +			cur_freq,
>> +			min_freq,
>> +			max_freq);
>> +	}
>> +
>> +	mutex_unlock(&devfreq_list_lock);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>> +
>>  static int __init devfreq_init(void)
>>  {
>>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
>> @@ -1659,6 +1736,11 @@ static int __init devfreq_init(void)
>>  	}
>>  	devfreq_class->dev_groups = devfreq_groups;
>>  
>> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
>> +	debugfs_create_file("devfreq_summary", 0444,
>> +				devfreq_debugfs, NULL,
>> +				&devfreq_summary_fops);
>> +
>>  	return 0;
>>  }
>>  subsys_initcall(devfreq_init);
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
