Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A972414031E
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 05:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAQEqp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 23:46:45 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:30537 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAQEqp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 23:46:45 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200117044642epoutp01ec1e7939352eddaae11d122c68f06917~qkyQOx0ci1000310003epoutp01I
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 04:46:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200117044642epoutp01ec1e7939352eddaae11d122c68f06917~qkyQOx0ci1000310003epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579236402;
        bh=8TyQ9j2geK6dsKVBQtGWrmSGr2S6AI2j1CFOQJE7FWU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IIAa5eZ86etjx89eJlJ7zlmLt0LcWDWMlXHlsdShzROmB4gw8uzBi0XkNTOWvZPaQ
         gNEdg2wyQ6AP5XwVI1izoO67M7KmmFLLa8pA67wseXBNxGyFyxLlWec2XJzN3vJtH6
         owCJjpkM5TuNV8VOlwKKbu4bo1jhMY7lhxV3dJzY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200117044641epcas1p2111c822e5bdf49a881456c9c481d7ad0~qkyPh9zoX0093500935epcas1p2G;
        Fri, 17 Jan 2020 04:46:41 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47zT6h4CGwzMqYkp; Fri, 17 Jan
        2020 04:46:36 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.0E.48498.C2C312E5; Fri, 17 Jan 2020 13:46:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200117044636epcas1p199cbea72715ca9f48562ff77094aa276~qkyKWCetE2541025410epcas1p1R;
        Fri, 17 Jan 2020 04:46:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117044636epsmtrp17bb2c2a92b5fbdd579bccf15e96976b8~qkyKU7w3O3159531595epsmtrp1r;
        Fri, 17 Jan 2020 04:46:36 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-e7-5e213c2c1ec1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.95.10238.B2C312E5; Fri, 17 Jan 2020 13:46:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200117044635epsmtip14b657370de78c342addc6ee218cd3d04~qkyKDmxfb1858018580epsmtip1f;
        Fri, 17 Jan 2020 04:46:35 +0000 (GMT)
Subject: Re: [PATCH v5] PM / devfreq: Add debugfs support with
 devfreq_summary file
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <628a2885-ff7d-9765-fc19-9e2bad6bab3b@samsung.com>
Date:   Fri, 17 Jan 2020 13:53:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200116105909.29281-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmga6OjWKcwdffihb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmBz4PNYM28No8flvl4mjx13lzB67Jx1l91j06pONo871/aweWx8t4PJ4++s/Swe
        fVtWMXp83iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkD9IGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/
        18rQwMDIFKgwITujZ114wXqbitvXH7M1MPbrdDFyckgImEjM2P+YrYuRi0NIYAejRE/HZTaQ
        hJDAJ0aJNcdzIRLfGCX2dh1k7WLkAOtYP7UAIr6XUeLxh/csEM57RomJV/pZQLqFBUIlZs3u
        YgWxRQSsJE7/72AGKWIWWMYkcfLZDbAiNgEtif0vboCt4xdQlLj64zEjiM0rYCfx9PV3sGYW
        AVWJzp6VYHFRgTCJk9taoGoEJU7OfAI2h1PAWmLxjUdg9cwC4hK3nsxngrDlJba/nQO2WELg
        FLvEyu6nrBBPu0i8WfmJBcIWlnh1fAs7hC0l8bK/Dcqullh58ggbRHMHo8SW/Regmo0l9i+d
        zAQKC2YBTYn1u/QhwooSO3/PZYRYzCfx7msPNLh4JTrahCBKlCUuP7jLBGFLSixu72SbwKg0
        C8k7s5C8MAvJC7MQli1gZFnFKJZaUJybnlpsWGCEHNmbGMGJW8tsB+Oicz6HGAU4GJV4eGcE
        KcQJsSaWFVfmHmKU4GBWEuE9OUM2Tog3JbGyKrUoP76oNCe1+BCjKTC0JzJLiSbnA7NKXkm8
        oamRsbGxhYmhmamhoZI473QXoDkC6YklqdmpqQWpRTB9TBycUg2M1ovObvA6siVEKOSbo85i
        5c69D9fOPNzPvDVloop7saW2MMcK3pzrDw531Dk/UlizdsOpWk2urmpFI93wS+vnGgQ/e1xu
        tbbaYs+J8mMK29rcy1PfZ23g3JeldHiK4wcFiVd/zDo92h64ZJgn7ZBRD/O6auL6VoVhy8Xt
        XHf27FbKSLCxaElXYinOSDTUYi4qTgQAaAsH2/IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7bCSnK62jWKcwfr9Nhb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmBz4PNYM28No8flvl4mjx13lzB67Jx1l91j06pONo871/aweWx8t4PJ4++s/Swe
        fVtWMXp83iQXwBXFZZOSmpNZllqkb5fAldGzLrxgvU3F7euP2RoY+3W6GDk4JARMJNZPLehi
        5OIQEtjNKLH41262LkZOoLikxLSLR5khaoQlDh8uBgkLCbxllHi9PhrEFhYIlfg04QcziC0i
        YCVx+n8HM8gcZoFlTBInnrQxQwztY5RYvfArC0gVm4CWxP4XN8AW8AsoSlz98ZgRxOYVsJN4
        +vo7K4jNIqAq0dmzEiwuKhAmsXPJYyaIGkGJkzOfgM3hFLCWWHzjEVg9s4C6xJ95l5ghbHGJ
        W0/mM0HY8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwBGtp7mC8vCT+EKMAB6MSD++MIIU4IdbEsuLK3EOMEhzMSiK8J2fIxgnxpiRW
        VqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAyMWWesoq4p4q29ae
        jeyJr3+IHxGV236qvMXHQ7Zov+6i34qrL7BlHnk9/+5f6RuXwq61rLv7w3bR1oefdoYs6WBc
        1HRbNibY6cq1ruwfn6Kz7t3hnrtj1i2T+kiOawwnJkRucav6IpNfKp3dwWZZkDpf6rTmRLWX
        5kw2b7OfT1Ka+cbr1uvtLkosxRmJhlrMRcWJAHi/goDcAgAA
X-CMS-MailID: 20200117044636epcas1p199cbea72715ca9f48562ff77094aa276
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116105149epcas1p36fa4867bae7d1a6f4827a8ddb4e75b35
References: <CGME20200116105149epcas1p36fa4867bae7d1a6f4827a8ddb4e75b35@epcas1p3.samsung.com>
        <20200116105909.29281-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/16/20 7:59 PM, Chanwoo Choi wrote:
> Add debugfs interface to provide debugging information of devfreq device.
> It contains 'devfreq_summary' entry to show the summary of registered
> devfreq devices as following and the additional debugfs file will be added.
> - /sys/kernel/debug/devfreq/devfreq_summary
> 
> [Detailed description of each field of 'devfreq_summary' debugfs file]
> - dev_name	: Device name of h/w
> - dev		: Device name made by devfreq core
> - parent_dev	: If devfreq device uses the passive governor,
> 		  show parent devfreq device name. Otherwise, show 'null'.
> - governor	: Devfreq governor name
> - polling_ms	: If devfreq device uses the simple_ondemand governor,
> 		  polling_ms is necessary for the period. (unit: millisecond)
> - cur_freq_Hz	: Current frequency (unit: Hz)
> - min_freq_Hz	: Minimum frequency (unit: Hz)
> - max_freq_Hz	: Maximum frequency (unit: Hz)
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
> Changes from v4:
> - Fix wrong patch description
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

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
