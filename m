Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C10E139F64
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 03:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgANCQD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 21:16:03 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35146 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgANCQC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 21:16:02 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200114021557epoutp044017218e8f9109a0cf05b2347632f2fa~pnyyA6y0f0108801088epoutp04S
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 02:15:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200114021557epoutp044017218e8f9109a0cf05b2347632f2fa~pnyyA6y0f0108801088epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578968157;
        bh=OjHGQsaPHZyYn4enX7XMl477/5nJU8/MOaR87n1tsEg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=h1g6HG3ZhbwmwDEZs9X+1bTOKDiz2dXkm0WXwzwm97xDGXasAH+04NKJaeyZiunDx
         TGy+5Q/67GkAhLWbHJSbOCdaieWTaAz5636uWEKXtQ7N1muH5NbfiOyzQh2fc22eOz
         V1h60qUo5d4OGGtxD4ekt6ewjxZ2D559pXvvMpeI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200114021557epcas1p47439ec34e546504a1ae5c87740d2afde~pnyxW_9xm2335023350epcas1p4v;
        Tue, 14 Jan 2020 02:15:57 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47xYwB2xF3zMqYkV; Tue, 14 Jan
        2020 02:15:54 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.71.51241.7542D1E5; Tue, 14 Jan 2020 11:15:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200114021550epcas1p149762e9eb9367d420c2eaf054656c533~pnyrFpgie1802918029epcas1p1B;
        Tue, 14 Jan 2020 02:15:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200114021550epsmtrp1407f2cbc4fa1a91e6326faa1abf85581~pnyrE0cXp0827108271epsmtrp1Y;
        Tue, 14 Jan 2020 02:15:50 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-5c-5e1d245778fa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.FE.10238.6542D1E5; Tue, 14 Jan 2020 11:15:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200114021550epsmtip261501e6642765a8a44864ec293ef7dd6~pnyq0EtWe1150211502epsmtip2K;
        Tue, 14 Jan 2020 02:15:50 +0000 (GMT)
Subject: Re: [PATCH v3] PM / devfreq: Add debugfs support with
 devfreq_summary file
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9635588e-66c2-14d5-9d84-43dbce976722@samsung.com>
Date:   Tue, 14 Jan 2020 11:23:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20ebd8e0-f74c-335c-4af8-35c3dc81902f@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmvm64imycwcINshb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmBz4PNYM28No8flvl4mjx13lzB67Jx1l91j06pONo871/aweWx8t4PJ4++s/Swe
        fVtWMXp83iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkD9IGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/
        18rQwMDIFKgwITtj8/Qz7AXzHCrmX/rA3sD4Ub+LkZNDQsBEYtvGdqYuRi4OIYEdjBKzNz1m
        gXA+MUr0f2pkhnC+MUr8evSHDabl8obLjBCJvYwSP891QFW9Z5RoW9zBClIlLBAqsX3HH0YQ
        W0QgQeLIn39gS5gFpjBJzD3dywySYBPQktj/4gbYWH4BRYmrPx6DNfAK2EkcXXYXbBCLgKrE
        8ePNYLaoQJjEyW0tUDWCEidnPmEBsTkFbCXmnDoANpNZQFzi1pP5TBC2vETz1tlg10kIHGOX
        aPrzEGgZB5DjIrHxDzvEO8ISr45vgbKlJF72t0HZ1RIrTx5hg+jtYJTYsv8CK0TCWGL/0slM
        IHOYBTQl1u+ChqSixM7fcxkh9vJJvPvawwqxileio00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQ
        fDMLyQezkHwwC2HZAkaWVYxiqQXFuempxYYFpsjRvYkRnLy1LHcwHjvnc4hRgINRiYdXI0cm
        Tog1say4MvcQowQHs5II76ZzUnFCvCmJlVWpRfnxRaU5qcWHGE2BgT2RWUo0OR+YWfJK4g1N
        jYyNjS1MDM1MDQ2VxHk5flyMFRJITyxJzU5NLUgtgulj4uCUamA8zzFVPD3iW3hP+bOg73rz
        VZ7Nmvjjeu8HjnfiDXuuvNu/Z1bTvpll7FXX9NV85wdKHJ3yQsqlPMTOy0pAYYV922qpvJfT
        7gnEhi1kCTuwj8lc1uSZ3m3rx24bOsuOKYa2zNDtmP3BJrd1yh7HvFmxa393GZo/Se3u7D0l
        v+P1Hae5R54LvC9RYinOSDTUYi4qTgQA5VmnwPQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvG6YimycQc9ZEYv781oZLU7vf8di
        MfHGFRaL1R8fM1qsuX2I0eLHhlPMFhsXZFucbXrDbrHi7kdWi8u75rBZfO49wmixsKmF3WLt
        kbvsFrcbV7A58HmsmbeG0eNyXy+Tx467Sxg9ds66y+6xaVUnm8eda3vYPDa+28Hk8XfWfhaP
        vi2rGD0+b5IL4IrisklJzcksSy3St0vgytg8/Qx7wTyHivmXPrA3MH7U72Lk5JAQMJG4vOEy
        YxcjF4eQwG5GiT8L9zJDJCQlpl08CmRzANnCEocPF0PUvGWU2Nn9jQ2kRlggVOLc89usILaI
        QILE3/8fwQYxC0xhkpjTewtq6kFGie4jXWAdbAJaEvtf3ACz+QUUJa7+eMwIYvMK2EkcXXYX
        bBKLgKrE8ePNYLaoQJjEziWPmSBqBCVOznzCAmJzCthKzDl1AOxSZgF1iT/zLkHZ4hK3nsxn
        grDlJZq3zmaewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5y
        fu4mRnAca2nuYLy8JP4QowAHoxIPb0OeTJwQa2JZcWXuIUYJDmYlEd5N56TihHhTEiurUovy
        44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamDsObZjybaNeqdCTkQe7Gp6
        2sts91vA6sAbFbUL58yt5tZy7M2IutZtUfTXqSAk98Wcl7khytquQbNlc4o4FlcmFNidOtJ1
        c33v+rbVOY0mb4PT5EMK8i+KfjixaMbRco2HVeeif5nqbYvhZPz6eN4swZglX5t5Hb748doU
        +bklWJT4cU0zrVJiKc5INNRiLipOBAAqEbCn3wIAAA==
X-CMS-MailID: 20200114021550epcas1p149762e9eb9367d420c2eaf054656c533
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200114013826epcas1p23a4c6c39f043dd09d33d48541288c1bd
References: <CGME20200114013826epcas1p23a4c6c39f043dd09d33d48541288c1bd@epcas1p2.samsung.com>
        <20200114014540.31490-1-cw00.choi@samsung.com>
        <20ebd8e0-f74c-335c-4af8-35c3dc81902f@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/14/20 10:45 AM, Dmitry Osipenko wrote:
> 14.01.2020 04:45, Chanwoo Choi пишет:
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
>> - old_freq_Hz	: Frequency before changing. (unit: Hz)
>> - new_freq_Hz	: Frequency after changed. (unit: Hz)
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
>> Changes from v2:
>> - Show 'null' at 'parent_dev' field when governor of devfreq device
>>   is not passive
>> Changes from v1:
>> - Drop the patch about 'devfreq_transitions' debugfs file
>> - Modify from 'hz' to 'Hz'
>> - Edit the indentation of 'devfreq_summary' when show summary
>> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir
>>
>>  drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 84 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 89260b17598f..c5ef2d194b1b 100644
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
>> @@ -1643,6 +1645,79 @@ static struct attribute *devfreq_attrs[] = {
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
>> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
>> +							DEVFREQ_NAME_LEN)) {
>> +			struct devfreq_passive_data *data = devfreq->data;
>> +
>> +			if (data)
>> +				p_devfreq = data->parent;
>> +		} else {
>> +			p_devfreq = NULL;
>> +		}
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
>> @@ -1659,6 +1734,15 @@ static int __init devfreq_init(void)
>>  	}
>>  	devfreq_class->dev_groups = devfreq_groups;
>>  
>> +	
> If you'll you'll take a look at [2], you may notice notice that it
> checks whether devfreq_debugfs IS_ERR [3] and then bails out.
> 
> [2] https://protect2.fireeye.com/url?k=a5047d02-f8ca7cd1-a505f64d-000babff317b-ed64c541cd573190&u=https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L432
> [3] https://protect2.fireeye.com/url?k=0a43fffa-578dfe29-0a4274b5-000babff317b-1c1c1062bfaeb0fc&u=https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L316
> 
> Thus you could simply remove the above error handling, making code to
> look cleaner.
> 
> 

OK. I'll modify it as following: Do you agree?

	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
	debugfs_create_file("devfreq_summary", 0444,
			devfreq_debugfs, NULL,
			&devfreq_summary_fops);


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
