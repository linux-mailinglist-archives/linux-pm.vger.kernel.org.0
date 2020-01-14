Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C719D13A029
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 04:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgANDzd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 22:55:33 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:10553 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgANDzc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 22:55:32 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200114035527epoutp01ca2c201c709412d3515e895d8566fbf8~ppJp-DYXO1931519315epoutp01G
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 03:55:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200114035527epoutp01ca2c201c709412d3515e895d8566fbf8~ppJp-DYXO1931519315epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578974127;
        bh=UDWGkYNGEi1iyIMMIbvw/nI1zCPp1J3Hcg3UfUbRys8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=X05yBL1b3L5MciWmwevoKSNVOqeS3kVAkj3NzJMjmHFbN6CIhI3YZQ4WnGbr5GXqx
         LezM1lTqqn70SUTNUWsejuOG2i/5IE2FVbNDsHNPP87noPlelhiqO6IDdgmQKdRu3E
         z44Y1f1Y3sHw2aJo1C/SqUyyxYVruBuA14x8X59g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200114035526epcas1p21a53f9c421fc94534bc6d3c07f041761~ppJpMqOeP0425404254epcas1p2P;
        Tue, 14 Jan 2020 03:55:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47xc704rrBzMqYkX; Tue, 14 Jan
        2020 03:55:24 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.4B.48498.CAB3D1E5; Tue, 14 Jan 2020 12:55:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200114035523epcas1p4bab8bddf110dbfb0756b60e930df2849~ppJmGOkm61365213652epcas1p4D;
        Tue, 14 Jan 2020 03:55:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200114035523epsmtrp2f45e0958c82f1ab1a6279a40ac27837c~ppJmCstKl0565805658epsmtrp25;
        Tue, 14 Jan 2020 03:55:23 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-79-5e1d3bac88e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.E6.06569.BAB3D1E5; Tue, 14 Jan 2020 12:55:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200114035523epsmtip1fb386db5244e3021547a0db9e043c891~ppJl11RWw1292112921epsmtip1h;
        Tue, 14 Jan 2020 03:55:23 +0000 (GMT)
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
Message-ID: <948cee7a-6871-80fc-8819-d24dfc9abd9a@samsung.com>
Date:   Tue, 14 Jan 2020 13:02:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <23577185-ac0a-c7e7-74f0-dc2743419385@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzH8/Su14O0eFbRn83k5YwzsiAcUPawWaLRmHOYjcXoH1sELnAB
        QnutvUJE/qkON0AhqMRoBaZzJvLiW8e0dbpqV0MAJRomQaGZQeLLXEocKsQxsraHGf99f8/v
        831++T4vNKEfpwx0ueQQ7ZJgZqlY8spva9NSuz9dWZD+7uUa/Ef7AYQHfCESHx75ncRdr54g
        3D3qR3jmUj+BL5+qwHf3/6XB54Kv1HjoWiuFpxoDCJ/eX6vB5wNBDR7dd47aEMd3t3cjfqip
        UcV7gj8i3usKanh3Zz3Fjw1fp/jLIY+K/9flI/mmnk7ET7kT8mO/qlhfJgoloj1JlIqtJeVS
        qYnN2164qdCYnc6lcjn4YzZJEiyiid28LT91S7k5nIBNqhLMleGlfEGW2bTc9XZrpUNMKrPK
        DhMr2krMthzbOlmwyJVS6bpiq+UTLj09wxgGiyrKDj6cVNkm8vbUDjlJJ7qe04BiaGCy4Njk
        uLoBxdJ6xoNg/PxLQin+RtDadX++eItg5uEz6r3lnreZVBo3EFysC1FKMYng5vSgJkItYXbA
        Vc8siuilTBEEZudUEYhgWlTQNtBIRBoUkwK+5yPRbRcxyfBg5knUoGNyYWTKTUY0yayGfYcG
        o0w8sxP6rtTOM4uh78RElIlhTPDo1vMoQzDL4dHE9ypFJ8I3P5+MZgCmXwPDV0NqJcNmaDvy
        Ail6CfzZ26NRtAGmQjfmc9ZAR1+AUsx1CHp89+bNmeA7ezQ8gQ5PWAsXr6Upy8ng/acNKYPj
        IPTmkDqCAKODum/1CrIKhh4HVYpeAWe+q6eaEetaEMe1IIJrQQTX/8NOIbITLRNtsqVUlDlb
        xsL7dqPo+07J9qAfBrf5EUMjVqtzSh8U6NVClVxt8SOgCXapzj1oKNDrSoTqvaLdWmivNIuy
        HxnDp32YMMQXW8O/RXIUcsaMzMxMnMVlGzmOXa6jZ+7v0jOlgkOsEEWbaH/vU9ExBifaW+89
        0/HrrtVG/9zAotBP9Bdjd+y9LcLdt493xB8Qzo7C5PRWz1yQ97egO+7XI9NHN2hb+y1jR6pP
        S7eMls9MHYEHzckfBd81Hdf2zyZ87oLEmFW7x1EnlXtMW9O1uHc0Ma4mri5ruOop/lrb/mHg
        l4YLtd6+ogsJzprbW25u/JIl5TKBSyHssvAfKxrNFvUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSnO5qa9k4g7PfFC3uz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG1xtukNu8WKux9ZLS7vmsNm8bn3CKPFwqYWdou1
        R+6yW9xuXMHmwOexZt4aRo/Lfb1MHjvuLmH02DnrLrvHplWdbB53ru1h89j4bgeTx99Z+1k8
        +rasYvT4vEkugCuKyyYlNSezLLVI3y6BK6P75numgifeFS2XG1gaGPdYdjFyckgImEhc2DmB
        pYuRi0NIYDejxMcJi5ghEpIS0y4eBbI5gGxhicOHiyFq3jJKvPm0gAWkRlggVOLc89usILaI
        QILE3/8fGUGKmAWmMEnM6b3FCNGxkkmi8+BkdpAqNgEtif0vbrCB2PwCihJXfzxmBLF5Bewk
        bnzeBDaVRUBVorHnHFiNqECYxM4lj5kgagQlTs58AlbDKWArcevgC7AaZgF1iT/zLjFD2OIS
        t57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFp
        Xrpecn7uJkZwHGtp7WA8cSL+EKMAB6MSD29DnkycEGtiWXFl7iFGCQ5mJRHeTeek4oR4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwMpqtvGndmyuY96xy
        25qMtnjf2PJ1Ez1UZhzcm/tI1S4q80DIhpPh8oLZU29XxF/6rbXyy/XyHiNztaBbiyOF1H1O
        bph/3uj5z1/M9Xmf5dRyDl2ur7C5nJZ/bZ/xtKPP/kT1qnx9KrHtzuq1F2YtPT4t9NWqTyyR
        SbnK9qUtfZyvluzyXGe4S4mlOCPRUIu5qDgRAEXVP8XfAgAA
X-CMS-MailID: 20200114035523epcas1p4bab8bddf110dbfb0756b60e930df2849
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/14/20 11:51 AM, Dmitry Osipenko wrote:
> 14.01.2020 05:23, Chanwoo Choi пишет:
>> On 1/14/20 10:45 AM, Dmitry Osipenko wrote:
>>> 14.01.2020 04:45, Chanwoo Choi пишет:
>>>> Add debugfs interface to provide debugging information of devfreq device.
>>>> It contains 'devfreq_summary' entry to show the summary of registered
>>>> devfreq devices as following and the additional debugfs file will be added.
>>>> - /sys/kernel/debug/devfreq/devfreq_summary
>>>>
>>>> [Detailed description of each field of 'devfreq_summary' debugfs file]
>>>> - dev_name	: Device name of h/w.
>>>> - dev		: Device name made by devfreq core.
>>>> - parent_dev	: If devfreq device uses the passive governor,
>>>> 		  show parent devfreq device name. Otherwise, show 'null'.
>>>> - governor	: Devfreq governor.
>>>> - polling_ms	: If devfreq device uses the simple_ondemand governor,
>>>> 		  polling_ms is necessary for the period. (unit: millisecond)
>>>> - cur_freq_Hz	: Current Frequency (unit: Hz)
>>>> - old_freq_Hz	: Frequency before changing. (unit: Hz)
>>>> - new_freq_Hz	: Frequency after changed. (unit: Hz)
>>>>
>>>> [For example on Exynos5422-based Odroid-XU3 board]
>>>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>>>> dev_name                       dev        parent_dev governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
>>>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>>>> 10c20000.memory-controller     devfreq0   null       simple_ondemand          0    165000000    165000000    825000000
>>>> soc:bus_wcore                  devfreq1   null       simple_ondemand         50    532000000     88700000    532000000
>>>> soc:bus_noc                    devfreq2   devfreq1   passive                  0    111000000     66600000    111000000
>>>> soc:bus_fsys_apb               devfreq3   devfreq1   passive                  0    222000000    111000000    222000000
>>>> soc:bus_fsys                   devfreq4   devfreq1   passive                  0    200000000     75000000    200000000
>>>> soc:bus_fsys2                  devfreq5   devfreq1   passive                  0    200000000     75000000    200000000
>>>> soc:bus_mfc                    devfreq6   devfreq1   passive                  0    333000000     83250000    333000000
>>>> soc:bus_gen                    devfreq7   devfreq1   passive                  0    266000000     88700000    266000000
>>>> soc:bus_peri                   devfreq8   devfreq1   passive                  0     66600000     66600000     66600000
>>>> soc:bus_g2d                    devfreq9   devfreq1   passive                  0    333000000     83250000    333000000
>>>> soc:bus_g2d_acp                devfreq10  devfreq1   passive                  0    266000000     66500000    266000000
>>>> soc:bus_jpeg                   devfreq11  devfreq1   passive                  0    300000000     75000000    300000000
>>>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive                  0    166500000     83250000    166500000
>>>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive                  0    200000000    120000000    200000000
>>>> soc:bus_disp1                  devfreq14  devfreq1   passive                  0    300000000    120000000    300000000
>>>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive                  0    300000000    150000000    300000000
>>>> soc:bus_mscl                   devfreq16  devfreq1   passive                  0    666000000     84000000    666000000
>>>>
>>>> [lkp: Reported the build error]
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>> Changes from v2:
>>>> - Show 'null' at 'parent_dev' field when governor of devfreq device
>>>>   is not passive
>>>> Changes from v1:
>>>> - Drop the patch about 'devfreq_transitions' debugfs file
>>>> - Modify from 'hz' to 'Hz'
>>>> - Edit the indentation of 'devfreq_summary' when show summary
>>>> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir
>>>>
>>>>  drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 84 insertions(+)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 89260b17598f..c5ef2d194b1b 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -10,6 +10,7 @@
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/kmod.h>
>>>>  #include <linux/sched.h>
>>>> +#include <linux/debugfs.h>
>>>>  #include <linux/errno.h>
>>>>  #include <linux/err.h>
>>>>  #include <linux/init.h>
>>>> @@ -33,6 +34,7 @@
>>>>  #define HZ_PER_KHZ	1000
>>>>  
>>>>  static struct class *devfreq_class;
>>>> +static struct dentry *devfreq_debugfs;
>>>>  
>>>>  /*
>>>>   * devfreq core provides delayed work based load monitoring helper
>>>> @@ -1643,6 +1645,79 @@ static struct attribute *devfreq_attrs[] = {
>>>>  };
>>>>  ATTRIBUTE_GROUPS(devfreq);
>>>>  
>>>> +/**
>>>> + * devfreq_summary_show() - Show the summary of the devfreq devices
>>>> + * @s:		seq_file instance to show the summary of devfreq devices
>>>> + * @data:	not used
>>>> + *
>>>> + * Show the summary of the devfreq devices via 'devfreq_summary' debugfs file.
>>>> + * It helps that user can know the detailed information of the devfreq devices.
>>>> + *
>>>> + * Return 0 always because it shows the information without any data change.
>>>> + */
>>>> +static int devfreq_summary_show(struct seq_file *s, void *data)
>>>> +{
>>>> +	struct devfreq *devfreq;
>>>> +	struct devfreq *p_devfreq = NULL;
> 
> Looks like there is no need to pre-initialize the p_devfreq, please see
> below.
> 
>>>> +	unsigned long cur_freq, min_freq, max_freq;
>>>> +	unsigned int polling_ms;
>>>> +
>>>> +	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",
>>>> +			"dev_name",
>>>> +			"dev",
>>>> +			"parent_dev",
>>>> +			"governor",
>>>> +			"polling_ms",
>>>> +			"cur_freq_Hz",
>>>> +			"min_freq_Hz",
>>>> +			"max_freq_Hz");
>>>> +	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",
>>>> +			"------------------------------",
>>>> +			"----------",
>>>> +			"----------",
>>>> +			"---------------",
>>>> +			"----------",
>>>> +			"------------",
>>>> +			"------------",
>>>> +			"------------");
>>>> +
>>>> +	mutex_lock(&devfreq_list_lock);
>>>> +
>>>> +	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {

#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) 

>>>> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
>>>> +							DEVFREQ_NAME_LEN)) {
>>>> +			struct devfreq_passive_data *data = devfreq->data;
>>>> +
>>>> +			if (data)
>>>> +				p_devfreq = data->parent;
> 
> 			else
> 				p_devfreq = NULL;
> 
> Otherwise p_devfreq will be reused from a previous devfreq device if
> that device has the data->parent.

This path has the problem. I'm missing that.

'struct devfreq_passive_data' is only defined
when CONFIG_DEVFREQ_GOV_PASSIVE is enabled.

In case of when CONFIG_DEVFREQ_GOV_PASSIVE is disabled,
p_devfreq should be initialized with NULL as following:
I'll modify this patch as following:

struct devfreq *p_devfreq = NULL;

#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) 
	if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
		DEVFREQ_NAME_LEN)) {
		struct devfreq_passive_data *data = devfreq->data;
		if (data)
			p_devfreq = data->parent;
		else
			p_devfreq = NULL;
#endif


> 
>>>> +		} else {
>>>> +			p_devfreq = NULL;
>>>> +		}
>>>> +
>>>> +		mutex_lock(&devfreq->lock);
>>>> +		cur_freq = devfreq->previous_freq,
>>>> +		get_freq_range(devfreq, &min_freq, &max_freq);
>>>> +		polling_ms = devfreq->profile->polling_ms,
>>>> +		mutex_unlock(&devfreq->lock);
>>>> +
>>>> +		seq_printf(s,
>>>> +			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",
>>>> +			dev_name(devfreq->dev.parent),
>>>> +			dev_name(&devfreq->dev),
>>>> +			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
>>>> +			devfreq->governor_name,
>>>> +			polling_ms,
>>>> +			cur_freq,
>>>> +			min_freq,
>>>> +			max_freq);
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&devfreq_list_lock);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>>>> +
>>>>  static int __init devfreq_init(void)
>>>>  {
>>>>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
>>>> @@ -1659,6 +1734,15 @@ static int __init devfreq_init(void)
>>>>  	}
>>>>  	devfreq_class->dev_groups = devfreq_groups;
>>>>  
>>>> +	
>>> If you'll you'll take a look at [2], you may notice notice that it
>>> checks whether devfreq_debugfs IS_ERR [3] and then bails out.
>>>
>>> [2] https://protect2.fireeye.com/url?k=a5047d02-f8ca7cd1-a505f64d-000babff317b-ed64c541cd573190&u=https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L432
>>> [3] https://protect2.fireeye.com/url?k=0a43fffa-578dfe29-0a4274b5-000babff317b-1c1c1062bfaeb0fc&u=https://elixir.bootlin.com/linux/v5.5-rc6/source/fs/debugfs/inode.c#L316
>>>
>>> Thus you could simply remove the above error handling, making code to
>>> look cleaner.
>>>
>>>
>>
>> OK. I'll modify it as following: Do you agree?
> 
> Looks good, thanks.
> 
>> 	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
> 
> I'd also add a newline here, to ease reading of the code.

ok.

> 
>> 	debugfs_create_file("devfreq_summary", 0444,
>> 			devfreq_debugfs, NULL,
>> 			&devfreq_summary_fops);
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
