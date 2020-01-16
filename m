Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA413D743
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 10:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgAPJxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 04:53:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39178 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbgAPJxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 04:53:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200116095331euoutp013b0eb2681e8dcffc29123325469f4f20~qVU2X6pEM1422914229euoutp01A
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 09:53:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200116095331euoutp013b0eb2681e8dcffc29123325469f4f20~qVU2X6pEM1422914229euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579168411;
        bh=SfVT+JG/59LeZkSRjEbnmSptBIeLxVbqNaVU7HK4nn0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DC+TWIrGgfbXZ7chJsQyM+tdAnxXuJNCjk5gefrjeVdfOhCP6RE4f+8A76fWjUgRi
         PX917YRUuci5NDOxNkb5Mv0h+VzCLNm4QnXA8KXHZGXBITMTN886bV82lxmhDeXek2
         g2BQb4hr+zFfgvvqhLzdvULdNAcbB022DhQf3mqA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200116095330eucas1p2f3ad7888c9f32632135b4fbaeb92449c~qVU2Fh8PF2740127401eucas1p2F;
        Thu, 16 Jan 2020 09:53:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 24.B8.61286.A92302E5; Thu, 16
        Jan 2020 09:53:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116095330eucas1p1f9ca6178c8327bee69aff4c299c25272~qVU1yMTFN1793017930eucas1p1B;
        Thu, 16 Jan 2020 09:53:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116095330eusmtrp1cf63e834c84a2ade1df6d6a64ee27c86~qVU1w14DK0570305703eusmtrp1m;
        Thu, 16 Jan 2020 09:53:30 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-63-5e20329abdab
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 16.EC.07950.A92302E5; Thu, 16
        Jan 2020 09:53:30 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116095329eusmtip2cf1615c50975c93c79c5f650898e3ba1~qVU1Hf8k70074300743eusmtip2k;
        Thu, 16 Jan 2020 09:53:29 +0000 (GMT)
Subject: Re: [PATCH v4] PM / devfreq: Add debugfs support with
 devfreq_summary file
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <50b2f033-779c-63b7-f1f0-1af730237925@samsung.com>
Date:   Thu, 16 Jan 2020 10:53:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116050313.3564-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85OzuOZsdl+aRpMpJISrt9OKSJl6jzpTIqiEhry4MLncmO
        l26UqWVNHV4SbdqcUWm2bmJzRSGpFWtopFGSziwtW+RkXrqXNY+S337P8/8/PM//5aVwmUPk
        Sx1ISeM0KYpkOSkhzI+/d6zQrw6MX/nIvIJ5YziFGFuzk2CKu18QzKvxIRFzzTWAGFNPC2K+
        3XqKM7eNSUx79mcxU2d3iZiue1UkM1bYhpia7Fwxc73NLmZ6TtaRkXNZk8GE2C5dIcZa7JcQ
        e1dvF7MN9WdJtvflfZK97bRg7G99M8HqGusRO9YQECvZLQlP4JIPZHCa0Ih9ElXF6CiWWrb+
        UMEFHZGF+pZrEUUBvRZ0PwO1SELJ6DoEnR9KkVCMIzDYGwmhGEPg+Jojnpn4Zd4s9GsRXLR8
        JoViGIFR14FrkQc1j94J7zqfYW72ppVQabmDuU04fQUD64duwi2QdCg8bLdOsZSOgGyDa2qY
        oIPgt7McubfNp3eBbUIhWLzAen5wyu5BrwND3pcpO077wOvBakzgxdA0XIW7dwFdRsFkYa7I
        LQC9AQr6upDA8+DTk0axwIvAVlpACJwJ72t0YmE4F0F/nmtaCIPejh+k+yCcXgY374UK7Sio
        /dOPC6/iCd3DXsINnlBiLp9uS+HMaZngDoKhpwWYwH6gnbwhKkJy/axk+llp9LPS6P/vNSKi
        Hvlw6bw6keNXpXCZIbxCzaenJIbsP6huQP8+oO3Pk1ELmuhUtiCaQvI5UtWvgHiZSJHBH1a3
        IKBwubfUWuEfL5MmKA4f4TQH92rSkzm+BflRhNxHuuaiI05GJyrSuCSOS+U0MypGefhmIaUX
        Ic1/fskbP8K1Nu2B1piS4rHyqCbXg2d6dcz9uBztzbyaBW+3jC91atS97d9+pobMr3wfGXt8
        /dCD8FDU/vJYT7Vj09VqWOK/fSA4rGzca+Rjkkd+Ud2LmtVxJmO0snHhyOXuHbvswUdxc+xG
        9aSqWF5i7t22dc2Jc0v9oqKtcoJXKVYF4xpe8RdIm2VyfAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xe7qzjBTiDGYek7C4P6+V0eL0/ncs
        FhNvXGGxuP7lOavF6o+PGS3W3D7EaPFjwylmi40Lsi3ONr1ht1hx9yOrxeVdc9gsPvceYbRY
        2NTCbrH2yF12i9uNK9gc+D3WzFvD6HG5r5fJY8fdJYweO2fdZffYtKqTzePOtT1sHhvf7WDy
        +DtrP4tH35ZVjB6fN8kFcEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
        2aSk5mSWpRbp2yXoZcz49ImpYKptRc/cPpYGxns6XYwcHBICJhJ/tvl2MXJyCAksZZT49M4N
        xJYQkJZoPL2aCcIWlvhzrYuti5ELqOY1o8SWbW1gCWGBUIlDjVdYQGwRgSSJHVOamEGKmAWW
        MUmceNLGDNHRyyix4No0VpAqNgF9iYNnT4J18ArYSTTN+8gMYrMIqEr8fTedEcQWFYiQeL79
        BiNEjaDEyZlPwOo5Bawk5rV/A6tnFlCX+DPvEpQtLnHryXwmCFteYvvbOcwTGIVmIWmfhaRl
        FpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM+m3Hfm7Zwdj1LvgQowAHoxIP
        74F/cnFCrIllxZW5hxglOJiVRHhPzpCNE+JNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YELK
        K4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAeOL12VO2fNai23u+
        BnUvE/pecdlp7hudJ0+0fQWFqxZ+YTppdmJdyV/xg5J+f7mtri8Q7/4uVKIUwO18Ve36xYqH
        s4LNWnvSOpe/MZvcIKle5Ph86afoN/dlnj1kLezL2LSxWGD7P2HLWi4FU7eYlNrdG18dfda+
        oE3iZsK+i2fDJ25+V2oQqMRSnJFoqMVcVJwIAN9b5SQQAwAA
X-CMS-MailID: 20200116095330eucas1p1f9ca6178c8327bee69aff4c299c25272
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074
References: <CGME20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074@epcas1p2.samsung.com>
        <20200116050313.3564-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 16.01.2020 06:03, Chanwoo Choi wrote:
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

s/Frequency/frequency/

> - old_freq_Hz	: Frequency before changing. (unit: Hz)

min_freq_Hz : Minimum frequency (unit Hz)

> - new_freq_Hz	: Frequency after changed. (unit: Hz)

max_freq_Hz : Maximum frequency (unit Hz)

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
> Changes from v3:
> - Remove the unneeded checking of return value when calling debugfs_create_dir
> - Add missing IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) condition
> Changes from v2:
> - Show 'null' at 'parent_dev' field when governor of devfreq device
>   is not passive
> Changes from v1:
> - Drop the patch about 'devfreq_transitions' debugfs file
> - Modify from 'hz' to 'Hz'
> - Edit the indentation of 'devfreq_summary' when show summary
> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir
> 
> 
>  drivers/devfreq/devfreq.c | 82 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 89260b17598f..cceee8bc3c2f 100644
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
> @@ -1643,6 +1645,81 @@ static struct attribute *devfreq_attrs[] = {
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
> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
> +							DEVFREQ_NAME_LEN)) {
> +			struct devfreq_passive_data *data = devfreq->data;
> +
> +			if (data)
> +				p_devfreq = data->parent;
> +		} else {
> +			p_devfreq = NULL;
> +		}
> +#endif
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
> @@ -1659,6 +1736,11 @@ static int __init devfreq_init(void)
>  	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
> +	debugfs_create_file("devfreq_summary", 0444,
> +				devfreq_debugfs, NULL,
> +				&devfreq_summary_fops);
> +
>  	return 0;
>  }
>  subsys_initcall(devfreq_init);
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

