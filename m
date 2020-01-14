Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA913A02C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 04:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgAND6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 22:58:04 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:11705 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgAND6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 22:58:04 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200114035801epoutp0128e791f875582c9313d64c8c48e8c880~ppL42-BW02116021160epoutp01U
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 03:58:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200114035801epoutp0128e791f875582c9313d64c8c48e8c880~ppL42-BW02116021160epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578974281;
        bh=92d0tp+GVa1m7QaOdb+J3A/gnKtcisqXMu66vexZEiQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pizlHU40Z3wM+UYh1p0RVwXsukIULTj1n1f894lYaMEKmOvWtzxkKfznD/4xiQc+8
         ABViiHmAEG1Y+XqiQ6LrMBY43e4fjM62VMVccgBV/fayyetG37/YQ+m938Dt4BZ20B
         Lk/0GX27lqAcoGYxdDaVReJd7VB4utegEZ44LmDg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200114035800epcas1p343d8cea6fe09454082c18a9a12294c6f~ppL4N9naB3166531665epcas1p3o;
        Tue, 14 Jan 2020 03:58:00 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47xc9y29Z4zMqYkZ; Tue, 14 Jan
        2020 03:57:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.D3.51241.64C3D1E5; Tue, 14 Jan 2020 12:57:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200114035758epcas1p112a87a0ccf886c45a98cd8594831da6d~ppL13aDJT2365223652epcas1p1o;
        Tue, 14 Jan 2020 03:57:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200114035758epsmtrp16e7b15e9c8821a05b98c3821dd01325f~ppL12jZ2-3063830638epsmtrp1z;
        Tue, 14 Jan 2020 03:57:58 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-0c-5e1d3c46749c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.17.06569.54C3D1E5; Tue, 14 Jan 2020 12:57:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200114035757epsmtip18df68dd0a5d385a40d6701acbaa4495c~ppL1p7lLg1292112921epsmtip10;
        Tue, 14 Jan 2020 03:57:57 +0000 (GMT)
Subject: Re: [PATCH v3] PM / devfreq: Add debugfs support with
 devfreq_summary file
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Organization: Samsung Electronics
Message-ID: <6f6b6508-67af-8024-c2a9-d0aec20507de@samsung.com>
Date:   Tue, 14 Jan 2020 13:05:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <948cee7a-6871-80fc-8819-d24dfc9abd9a@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmrq6bjWycwdl9Ahb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmBz4PNYM28No8flvl4mjx13lzB67Jx1l91j06pONo871/aweWx8t4PJ4++s/Swe
        fVtWMXp83iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkD9IGSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/
        18rQwMDIFKgwITtj9tKrbAU3Air2z7/C0sB4w7aLkZNDQsBEYteJa4xdjFwcQgI7GCW6e5ug
        nE+MEme3z2UBqRIS+MYo8fCNIkzHqteH2SGK9jJK7N8/iRnCec8ocWvKA3aQKmGBUIntO/4w
        gthsAloS+1/cYAOxRQQSJI78+ccE0sAsMIVJYu7pXmaQBL+AosTVH4/BGngF7CR+HJrHCmKz
        CKhKbJ58FGyoqECYxMltLVA1ghInZz4BO49TwF7iQNMbsHpmAXGJW0/mM0HY8hLNW2eDXSch
        cI5d4kPrQkaIH1wkHj7cwAJhC0u8Or6FHcKWknjZ3wZlV0usPHmEDaK5g1Fiy/4LrBAJY4n9
        SycDbeAA2qApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGWuPzgLhOELSmxuL2T
        bQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBKXJ0b2IEJ28tyx2Mx875HGIU4GBU
        4uHVyJGJE2JNLCuuzD3EKMHBrCTCu+mcVJwQb0piZVVqUX58UWlOavEhRlNgaE9klhJNzgdm
        lrySeENTI2NjYwsTQzNTQ0MlcV6OHxdjhQTSE0tSs1NTC1KLYPqYODilGhhnXQj+uHL6gaTQ
        +W9fXFQseRu2kJP/08kzl8UY789qu+UV+ruU+fzTxxNjojNC0wLfP756Xn1i0s79h1e+2mFw
        3v+YpuLDqQarGsWnaiT9bk5M337vb2FDnRzHlajg5tURSg8k6uVt3UoSz5/Y1vEj1u5Bi7nV
        xAUiij+NXOdeK1mrobXQ/Pp1JZbijERDLeai4kQAOEqOU/QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnK6rjWycwZEvVhb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmBz4PNYM28No8flvl4mjx13lzB67Jx1l91j06pONo871/aweWx8t4PJ4++s/Swe
        fVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlTF76VW2ghsBFfvnX2FpYLxh28XIySEhYCKx6vVh
        dhBbSGA3o8TvI7kQcUmJaRePMncxcgDZwhKHDxd3MXIBlbxllJjx6QoLSI2wQKjEuee3WUFs
        NgEtif0vbrCB2CICCRJ//39kBGlgFpjCJDGn9xYjRPc9JomzfyYwglTxCyhKXP3xGMzmFbCT
        +HFoHtgkFgFVic2Tj4JdJCoQJrFzyWMmiBpBiZMzn4Bt5hSwlzjQ9AasnllAXeLPvEvMELa4
        xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHMVaWjsYT5yIP8QowMGoxMPbkCcTJ8SaWFZcmXuIUYKDWUmEd9M5qTgh3pTE
        yqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjPVXf/wX8nLX+fky
        YH/1pIsnYm9cVP6/nGU2T8qv24t1tq5fd+6LscE5E9/bOkF8jvWHGy/P19K/omo49UPTGg4G
        13Z71lbdUxX2ZjfPblq5SrxbfEui9d853UfMduZZPgurtwphuKKXUmxysHvjK1P/NXuULnxx
        XDMncmlOBuOUr9PPLd3k7qTEUpyRaKjFXFScCADNNOl63gIAAA==
X-CMS-MailID: 20200114035758epcas1p112a87a0ccf886c45a98cd8594831da6d
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
        <9635588e-66c2-14d5-9d84-43dbce976722@samsung.com>
        <23577185-ac0a-c7e7-74f0-dc2743419385@gmail.com>
        <948cee7a-6871-80fc-8819-d24dfc9abd9a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/14/20 1:02 PM, Chanwoo Choi wrote:
> On 1/14/20 11:51 AM, Dmitry Osipenko wrote:
>> 14.01.2020 05:23, Chanwoo Choi пишет:
>>> On 1/14/20 10:45 AM, Dmitry Osipenko wrote:
>>>> 14.01.2020 04:45, Chanwoo Choi пишет:
>>>>> Add debugfs interface to provide debugging information of devfreq device.
>>>>> It contains 'devfreq_summary' entry to show the summary of registered
>>>>> devfreq devices as following and the additional debugfs file will be added.
>>>>> - /sys/kernel/debug/devfreq/devfreq_summary
>>>>>
>>>>> [Detailed description of each field of 'devfreq_summary' debugfs file]
>>>>> - dev_name	: Device name of h/w.
>>>>> - dev		: Device name made by devfreq core.
>>>>> - parent_dev	: If devfreq device uses the passive governor,
>>>>> 		  show parent devfreq device name. Otherwise, show 'null'.
>>>>> - governor	: Devfreq governor.
>>>>> - polling_ms	: If devfreq device uses the simple_ondemand governor,
>>>>> 		  polling_ms is necessary for the period. (unit: millisecond)
>>>>> - cur_freq_Hz	: Current Frequency (unit: Hz)
>>>>> - old_freq_Hz	: Frequency before changing. (unit: Hz)
>>>>> - new_freq_Hz	: Frequency after changed. (unit: Hz)
>>>>>
>>>>> [For example on Exynos5422-based Odroid-XU3 board]
>>>>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>>>>> dev_name                       dev        parent_dev governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
>>>>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>>>>> 10c20000.memory-controller     devfreq0   null       simple_ondemand          0    165000000    165000000    825000000
>>>>> soc:bus_wcore                  devfreq1   null       simple_ondemand         50    532000000     88700000    532000000
>>>>> soc:bus_noc                    devfreq2   devfreq1   passive                  0    111000000     66600000    111000000
>>>>> soc:bus_fsys_apb               devfreq3   devfreq1   passive                  0    222000000    111000000    222000000
>>>>> soc:bus_fsys                   devfreq4   devfreq1   passive                  0    200000000     75000000    200000000
>>>>> soc:bus_fsys2                  devfreq5   devfreq1   passive                  0    200000000     75000000    200000000
>>>>> soc:bus_mfc                    devfreq6   devfreq1   passive                  0    333000000     83250000    333000000
>>>>> soc:bus_gen                    devfreq7   devfreq1   passive                  0    266000000     88700000    266000000
>>>>> soc:bus_peri                   devfreq8   devfreq1   passive                  0     66600000     66600000     66600000
>>>>> soc:bus_g2d                    devfreq9   devfreq1   passive                  0    333000000     83250000    333000000
>>>>> soc:bus_g2d_acp                devfreq10  devfreq1   passive                  0    266000000     66500000    266000000
>>>>> soc:bus_jpeg                   devfreq11  devfreq1   passive                  0    300000000     75000000    300000000
>>>>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive                  0    166500000     83250000    166500000
>>>>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive                  0    200000000    120000000    200000000
>>>>> soc:bus_disp1                  devfreq14  devfreq1   passive                  0    300000000    120000000    300000000
>>>>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive                  0    300000000    150000000    300000000
>>>>> soc:bus_mscl                   devfreq16  devfreq1   passive                  0    666000000     84000000    666000000
>>>>>
>>>>> [lkp: Reported the build error]
>>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> ---
>>>>> Changes from v2:
>>>>> - Show 'null' at 'parent_dev' field when governor of devfreq device
>>>>>   is not passive
>>>>> Changes from v1:
>>>>> - Drop the patch about 'devfreq_transitions' debugfs file
>>>>> - Modify from 'hz' to 'Hz'
>>>>> - Edit the indentation of 'devfreq_summary' when show summary
>>>>> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir
>>>>>
>>>>>  drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 84 insertions(+)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index 89260b17598f..c5ef2d194b1b 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -10,6 +10,7 @@
>>>>>  #include <linux/kernel.h>
>>>>>  #include <linux/kmod.h>
>>>>>  #include <linux/sched.h>
>>>>> +#include <linux/debugfs.h>
>>>>>  #include <linux/errno.h>
>>>>>  #include <linux/err.h>
>>>>>  #include <linux/init.h>
>>>>> @@ -33,6 +34,7 @@
>>>>>  #define HZ_PER_KHZ	1000
>>>>>  
>>>>>  static struct class *devfreq_class;
>>>>> +static struct dentry *devfreq_debugfs;
>>>>>  
>>>>>  /*
>>>>>   * devfreq core provides delayed work based load monitoring helper
>>>>> @@ -1643,6 +1645,79 @@ static struct attribute *devfreq_attrs[] = {
>>>>>  };
>>>>>  ATTRIBUTE_GROUPS(devfreq);
>>>>>  
>>>>> +/**
>>>>> + * devfreq_summary_show() - Show the summary of the devfreq devices
>>>>> + * @s:		seq_file instance to show the summary of devfreq devices
>>>>> + * @data:	not used
>>>>> + *
>>>>> + * Show the summary of the devfreq devices via 'devfreq_summary' debugfs file.
>>>>> + * It helps that user can know the detailed information of the devfreq devices.
>>>>> + *
>>>>> + * Return 0 always because it shows the information without any data change.
>>>>> + */
>>>>> +static int devfreq_summary_show(struct seq_file *s, void *data)
>>>>> +{
>>>>> +	struct devfreq *devfreq;
>>>>> +	struct devfreq *p_devfreq = NULL;
>>
>> Looks like there is no need to pre-initialize the p_devfreq, please see
>> below.
>>
>>>>> +	unsigned long cur_freq, min_freq, max_freq;
>>>>> +	unsigned int polling_ms;
>>>>> +
>>>>> +	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",
>>>>> +			"dev_name",
>>>>> +			"dev",
>>>>> +			"parent_dev",
>>>>> +			"governor",
>>>>> +			"polling_ms",
>>>>> +			"cur_freq_Hz",
>>>>> +			"min_freq_Hz",
>>>>> +			"max_freq_Hz");
>>>>> +	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",
>>>>> +			"------------------------------",
>>>>> +			"----------",
>>>>> +			"----------",
>>>>> +			"---------------",
>>>>> +			"----------",
>>>>> +			"------------",
>>>>> +			"------------",
>>>>> +			"------------");
>>>>> +
>>>>> +	mutex_lock(&devfreq_list_lock);
>>>>> +
>>>>> +	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
> 
> #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) 
> 
>>>>> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
>>>>> +							DEVFREQ_NAME_LEN)) {
>>>>> +			struct devfreq_passive_data *data = devfreq->data;
>>>>> +
>>>>> +			if (data)
>>>>> +				p_devfreq = data->parent;
>>
>> 			else
>> 				p_devfreq = NULL;
>>
>> Otherwise p_devfreq will be reused from a previous devfreq device if
>> that device has the data->parent.
> 
> This path has the problem. I'm missing that.
> 
> 'struct devfreq_passive_data' is only defined
> when CONFIG_DEVFREQ_GOV_PASSIVE is enabled.
> 
> In case of when CONFIG_DEVFREQ_GOV_PASSIVE is disabled,
> p_devfreq should be initialized with NULL as following:
> I'll modify this patch as following:
> 
> struct devfreq *p_devfreq = NULL;
> 
> #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) 
> 	if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
> 		DEVFREQ_NAME_LEN)) {
> 		struct devfreq_passive_data *data = devfreq->data;
> 		if (data)
> 			p_devfreq = data->parent;
> 		else
> 			p_devfreq = NULL;
> #endif
> 
> 
>>
>>>>> +		} else {
>>>>> +			p_devfreq = NULL;
>>>>> +		}
>>>>> +
>>>>> +		mutex_lock(&devfreq->lock);
>>>>> +		cur_freq = devfreq->previous_freq,
>>>>> +		get_freq_range(devfreq, &min_freq, &max_freq);
>>>>> +		polling_ms = devfreq->profile->polling_ms,
>>>>> +		mutex_unlock(&devfreq->lock);
>>>>> +
>>>>> +		seq_printf(s,
>>>>> +			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",
>>>>> +			dev_name(devfreq->dev.parent),
>>>>> +			dev_name(&devfreq->dev),
>>>>> +			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
>>>>> +			devfreq->governor_name,
>>>>> +			polling_ms,
>>>>> +			cur_freq,
>>>>> +			min_freq,
>>>>> +			max_freq);
>>>>> +	}
>>>>> +
>>>>> +	mutex_unlock(&devfreq_list_lock);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>>>>> +
>>>>>  static int __init devfreq_init(void)
>>>>>  {
>>>>>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
>>>>> @@ -1659,6 +1734,15 @@ static int __init devfreq_init(void)
>>>>>  	}
>>>>>  	devfreq_class->dev_groups = devfreq_groups;
>>>>>  
>>>>> +	
>>>> If you'll you'll take a look at [2], you may notice notice that it
>>>> checks whether devfreq_debugfs IS_ERR [3] and then bails out.
>>>>
>>>> [2] https://protect2.fireeye.com/url?k=a5047d02-f8ca7cd1-a505f64d-000babff317b-ed64c541cd573190&u=https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L432
>>>> [3] https://protect2.fireeye.com/url?k=0a43fffa-578dfe29-0a4274b5-000babff317b-1c1c1062bfaeb0fc&u=https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L316
>>>>
>>>> Thus you could simply remove the above error handling, making code to
>>>> look cleaner.
>>>>
>>>>
>>>
>>> OK. I'll modify it as following: Do you agree?
>>
>> Looks good, thanks.
>>
>>> 	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
>>
>> I'd also add a newline here, to ease reading of the code.
> 
> ok.
> 
>>
>>> 	debugfs_create_file("devfreq_summary", 0444,
>>> 			devfreq_debugfs, NULL,
>>> 			&devfreq_summary_fops);

Because there is not checking of return value,
I think that it is more proper instead of adding the newline
between debugfs_create_dir and debugfs_create_file.

	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
	debugfs_create_file("devfreq_summary", 0444,
				devfreq_debugfs, NULL,
				&devfreq_summary_fops);

>>>
>>>
>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
