Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13E3FD3F0
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 06:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfKOFI4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 00:08:56 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:55328 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfKOFI4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 00:08:56 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191115050852epoutp04cd2b7ac319a450d44385d9084793dd7d~XPcoSS9ad2356523565epoutp04R
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 05:08:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191115050852epoutp04cd2b7ac319a450d44385d9084793dd7d~XPcoSS9ad2356523565epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573794532;
        bh=M+xaYc57w7cfX28HQhqG6Qe/mq8E08Eeyg87sY/1SiY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=I40feeBiq1sXxZWrHiqDH3VNNP/5euaFgSreDN5XnKStCDEbV2AjbL0v3yIxCUQ57
         x7qXag2rMKui6gPj/e5gqaAX2lay3UDywhmYemCm2gL1rqg4UuVDUSU176K0zLoyrn
         q2PsgLHEDrD4ldyFCVqTXFMKybvzYOwqLjsoLuGE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191115050852epcas1p3eea85cdff8f0952c006e21a1ee6f3bfe~XPcn6oA7C3265232652epcas1p3k;
        Fri, 15 Nov 2019 05:08:52 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47DmbM5TfpzMqYkk; Fri, 15 Nov
        2019 05:08:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.7D.04085.FD23ECD5; Fri, 15 Nov 2019 14:08:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191115050846epcas1p25caa56a664c439273e9365501de1d777~XPciwq2hZ0270402704epcas1p23;
        Fri, 15 Nov 2019 05:08:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191115050846epsmtrp2f380d1c416987ed4e228593041c34e6c~XPciv1FDq3091030910epsmtrp2c;
        Fri, 15 Nov 2019 05:08:46 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-3a-5dce32df755c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.C7.25663.ED23ECD5; Fri, 15 Nov 2019 14:08:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191115050846epsmtip18185556c2f67ebd305d8661eedc5a9e5~XPcilDBRk3157331573epsmtip17;
        Fri, 15 Nov 2019 05:08:46 +0000 (GMT)
Subject: Re: [PATCH 5/7] devfreq: move transition statistics to devfreq
 profile structure
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5f9fc7b9-9ede-dd6a-88c3-d88b546a4c2d@samsung.com>
Date:   Fri, 15 Nov 2019 14:14:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <55818555-e512-46bf-4ad5-ae9dcb27d32e@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRDN1223i1BdCsrID61rDIIgXWpxK4JnDMYjJGo8CNaFrqXQK92i
        ojFRjIgoisEQrQgYggcJigQvIoKAInJ5oQZFCaIQAhg5NcZo29XIvzfzvZk3b74hMHkB7k8Y
        zHbOZmaNFD5FfLsuUBnyMaw1Tvnlix9z89wNCVM4fE7CtLWVSZmWtAEp87IyD2dGsuoRU1rf
        KWXeHb6KLyeiy0uO49GnKkpQ9Ej5rBhsR/LSRI7VcTYFZ06w6AxmfSS1bpN2lVYdrqRDaA2z
        mFKYWRMXSa1eHxOyxmB0TkAp9rDGFGcqhuV5KjRqqc2SYucUiRbeHklxVp3RqrEu5FkTn2LW
        L0ywmJbQSmWY2knclZyY+7hLZK007Kt5f0t8CL3ZkokIAshF8CYnKhNNIeTkXQRNDcUiIRhG
        8PzbfUwIxhGM1GSJM5GHu2Ki/zkSHqoQXHrw4i/rK4IP2aMiF8uHjIXe2xNSl4YvyUFftdHF
        wcg+BOW57RIXByeDoLrvLe7C08g50P79E3JhGRkFWaVVbjUxOQ/OZ7wWu/pMJ7dB0xgrULyh
        8XyPm+JBLoO0J9nulhjpBx09BSIBz4Y7g3nu2YDsxaGk7IJEcLAauge+YgL2gf6GCqmA/WFk
        qAoX8AG41liPC8UZCCqqn/0tVkF1cY7INRBGBsKNylAhPQfu/byIBOGpMDR2UiLsVwYZ6XKB
        MhdednWKBDwTio4dx7MR5ZhkxzHJgmOSBcd/sUIkLkEzOCtv0nM8bVVN/uxy5D7OoMV3UVnr
        +lpEEojykkFHS5xcwu7hU021CAiM8pWdHWyOk8t0bOp+zmbR2lKMHF+L1M5ln8H8pydYnKdu
        tmtpdZhKpWIW0eFqmqb8ZCuuFMfJST1r55I5zsrZ/tWJCA//Q8gnfkCj6OcdjSceyWocPfEa
        3yA0sbvVO3xgq2fv5+QOhK31OE0dDdB67vwVk7/1VX49bExfEHyHGfJM2tBdSB8M+J10nY0Y
        7jQwt3rUfg9XaXJGfU4VHfixs+aw6MT2de9GI7yufNz7dHNs57jvka7Lujr9yub5wd7deZtC
        ZI1MHyXmE1k6CLPx7B+LmgQMsgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTvee0blYg7+tZhYbZ6xntVjwaQar
        xfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3uN24gs2Bw2PTqk42j74tqxg9Pm+SC2CO4rJJ
        Sc3JLEst0rdL4MqYduwBU8GuzIoDd7ayNDBeD+1i5OSQEDCR+P7qImMXIxeHkMBuRolfrzuZ
        IRKSEtMuHgWyOYBsYYnDh4tBwkICbxklrp6RBrGFBaIlnm/7zg5SIiKQKrH6YQhImFngBaNE
        c3swxMjVTBKPl/xiAkmwCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCfRu3YvC4jNIqAqMbPjGpgt
        KhAh8Xz7DagaQYmTM5+AxTkF7CWaTkxghVimLvFn3iVmCFtc4taT+UwQtrzE9rdzmCcwCs9C
        0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHEFaWjsYT5yI
        P8QowMGoxMMrcetsrBBrYllxZe4hRgkOZiUR3ilvz8QK8aYkVlalFuXHF5XmpBYfYpTmYFES
        55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYGRda2dgV5kmvL1lnWvZ3OKfkbmWkgdDTfJlLFYv
        UvltWljoJfp20zWDVNWXBY5XWNY123FUSrT/Dc3dN9Fte37FKYvQ6f0O5+/pSG84sOL3++6j
        rUYy9f963oe9srn0sMHJvGyDjVnwmRMOVkyC2yNm1isc8jR/JCVzLKTdzWAar5Ded9k0JZbi
        jERDLeai4kQAjFu52pwCAAA=
X-CMS-MailID: 20191115050846epcas1p25caa56a664c439273e9365501de1d777
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f@eucas1p2.samsung.com>
        <20191113091336.5218-6-k.konieczny@samsung.com>
        <72e517d9-725d-b05d-028f-153bb6684df3@samsung.com>
        <55818555-e512-46bf-4ad5-ae9dcb27d32e@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bartlomiej,

On 11/15/19 3:10 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Chanwoo,
> 
> On 11/14/19 3:02 AM, Chanwoo Choi wrote:
>> Hi Kamil,
>>
>> The devfreq_dev_profile structure have to only contain the each devfreq device
>> callback function/data which are used in the devfreq core.
>>
>> The generated information after registered the devfreq device
>> with devfreq_add_device() should be stored in the 'struct device'.
>>
>> The devfreq core need to split out the data between user input
>> data (struct devfreq_dev_profile) and the initialized/generated data
>> by core (struct devfreq). It is not same with cpufreq. cpufreq
> 
> How's about doing it the other way around -> moving 'freq_table' and
> 'max_state' from 'struct devfreq_dev_profile' to 'struct devfreq'?

I agree to move 'freq_table' and 'max_state' to 'struct devfreq
as I replied on patch7 from your reply. But, it have to be touched
with the ordering issue of freq_table on drivers/thermal/devfreq_cooling.c.

Regards,
Chanwoo Choi

> 
> They are both initialized/generated by the core during
> devfreq_add_device()->set_freq_table() for all in-kernel drivers.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics 
> 
>> don't require the any structure like 'devfreq_dev_profile'.
>>
>> So, I can't agree.
>>
>> Thanks.
>> Chanwoo Choi
>>
>>
>> On 11/13/19 6:13 PM, Kamil Konieczny wrote:
>>> Move transition statistics to devfreq profile structure. This is for
>>> preparation for moving transition statistics into separate struct.
>>> It is safe to do as frequency table and maximum state information are
>>> already present in devfreq profile structure and there are no devfreq
>>> drivers using more than one instance of devfreq structure per devfreq
>>> profile one.
>>>
>>> It also makes devfreq code more similar to cpufreq one.
>>>
>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 115 +++++++++++++++++++-------------------
>>>  include/linux/devfreq.h   |  25 ++++-----
>>>  2 files changed, 70 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 6e5a17f4c92c..70533b787744 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -128,7 +128,7 @@ static int set_freq_table(struct devfreq *devfreq)
>>>  
>>>  	profile->max_state = count;
>>>  	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
>>> -					profile->max_state,
>>> +					count,
>>>  					sizeof(*profile->freq_table),
>>>  					GFP_KERNEL);
>>>  	if (!profile->freq_table) {
>>> @@ -157,29 +157,30 @@ static int set_freq_table(struct devfreq *devfreq)
>>>   */
>>>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>  {
>>> -	int lev, prev_lev, ret = 0;
>>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>>  	unsigned long long cur_time;
>>> +	int lev, prev_lev, ret = 0;
>>>  
>>>  	cur_time = get_jiffies_64();
>>>  
>>>  	/* Immediately exit if previous_freq is not initialized yet. */
>>>  	if (!devfreq->previous_freq) {
>>> -		spin_lock(&devfreq->stats_lock);
>>> -		devfreq->last_time = cur_time;
>>> -		spin_unlock(&devfreq->stats_lock);
>>> +		spin_lock(&profile->stats_lock);
>>> +		profile->last_time = cur_time;
>>> +		spin_unlock(&profile->stats_lock);
>>>  		return 0;
>>>  	}
>>>  
>>>  	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>>>  
>>> -	spin_lock(&devfreq->stats_lock);
>>> +	spin_lock(&profile->stats_lock);
>>>  	if (prev_lev < 0) {
>>>  		ret = prev_lev;
>>>  		goto out;
>>>  	}
>>>  
>>> -	devfreq->time_in_state[prev_lev] +=
>>> -			 cur_time - devfreq->last_time;
>>> +	profile->time_in_state[prev_lev] +=
>>> +			 cur_time - profile->last_time;
>>>  	lev = devfreq_get_freq_level(devfreq, freq);
>>>  	if (lev < 0) {
>>>  		ret = lev;
>>> @@ -187,14 +188,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>  	}
>>>  
>>>  	if (lev != prev_lev) {
>>> -		devfreq->trans_table[(prev_lev *
>>> -				devfreq->profile->max_state) + lev]++;
>>> -		devfreq->total_trans++;
>>> +		profile->trans_table[(prev_lev *
>>> +				profile->max_state) + lev]++;
>>> +		profile->total_trans++;
>>>  	}
>>>  
>>>  out:
>>> -	devfreq->last_time = cur_time;
>>> -	spin_unlock(&devfreq->stats_lock);
>>> +	profile->last_time = cur_time;
>>> +	spin_unlock(&profile->stats_lock);
>>>  	return ret;
>>>  }
>>>  EXPORT_SYMBOL(devfreq_update_status);
>>> @@ -474,23 +475,23 @@ EXPORT_SYMBOL(devfreq_monitor_suspend);
>>>  void devfreq_monitor_resume(struct devfreq *devfreq)
>>>  {
>>>  	unsigned long freq;
>>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>>  
>>>  	mutex_lock(&devfreq->lock);
>>>  	if (!devfreq->stop_polling)
>>>  		goto out;
>>>  
>>> -	if (!delayed_work_pending(&devfreq->work) &&
>>> -			devfreq->profile->polling_ms)
>>> +	if (!delayed_work_pending(&devfreq->work) && profile->polling_ms)
>>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>>> -			msecs_to_jiffies(devfreq->profile->polling_ms));
>>> +			msecs_to_jiffies(profile->polling_ms));
>>>  
>>> -	spin_lock(&devfreq->stats_lock);
>>> -	devfreq->last_time = get_jiffies_64();
>>> -	spin_unlock(&devfreq->stats_lock);
>>> +	spin_lock(&profile->stats_lock);
>>> +	profile->last_time = get_jiffies_64();
>>> +	spin_unlock(&profile->stats_lock);
>>>  	devfreq->stop_polling = false;
>>>  
>>> -	if (devfreq->profile->get_cur_freq &&
>>> -		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
>>> +	if (profile->get_cur_freq &&
>>> +	    !profile->get_cur_freq(devfreq->dev.parent, &freq))
>>>  		devfreq->previous_freq = freq;
>>>  
>>>  out:
>>> @@ -657,7 +658,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  	devfreq->data = data;
>>>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>>>  
>>> -	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>>> +	if (!profile->max_state && !profile->freq_table) {
>>>  		mutex_unlock(&devfreq->lock);
>>>  		err = set_freq_table(devfreq);
>>>  		if (err < 0)
>>> @@ -693,29 +694,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  		goto err_out;
>>>  	}
>>>  
>>> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
>>> -			array3_size(sizeof(unsigned int),
>>> -				    devfreq->profile->max_state,
>>> -				    devfreq->profile->max_state),
>>> -			GFP_KERNEL);
>>> -	if (!devfreq->trans_table) {
>>> +	profile->trans_table = devm_kzalloc(&devfreq->dev,
>>> +					    array3_size(sizeof(unsigned int),
>>> +							profile->max_state,
>>> +							profile->max_state),
>>> +					    GFP_KERNEL);
>>> +	if (!profile->trans_table) {
>>>  		mutex_unlock(&devfreq->lock);
>>>  		err = -ENOMEM;
>>>  		goto err_devfreq;
>>>  	}
>>>  
>>> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>>> -			devfreq->profile->max_state,
>>> -			sizeof(*devfreq->time_in_state),
>>> -			GFP_KERNEL);
>>> -	if (!devfreq->time_in_state) {
>>> +	profile->time_in_state = devm_kcalloc(&devfreq->dev,
>>> +					      profile->max_state,
>>> +					      sizeof(*profile->time_in_state),
>>> +					      GFP_KERNEL);
>>> +	if (!profile->time_in_state) {
>>>  		mutex_unlock(&devfreq->lock);
>>>  		err = -ENOMEM;
>>>  		goto err_devfreq;
>>>  	}
>>>  
>>> -	devfreq->last_time = get_jiffies_64();
>>> -	spin_lock_init(&devfreq->stats_lock);
>>> +	profile->last_time = get_jiffies_64();
>>> +	spin_lock_init(&profile->stats_lock);
>>>  
>>>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>>>  
>>> @@ -1402,9 +1403,10 @@ static ssize_t trans_stat_show(struct device *dev,
>>>  			       struct device_attribute *attr, char *buf)
>>>  {
>>>  	struct devfreq *devfreq = to_devfreq(dev);
>>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>>  	ssize_t len;
>>>  	int i, j;
>>> -	unsigned int max_state = devfreq->profile->max_state;
>>> +	unsigned int max_state = profile->max_state;
>>>  
>>>  	if (!devfreq->stop_polling &&
>>>  			devfreq_update_status(devfreq, devfreq->previous_freq))
>>> @@ -1415,46 +1417,45 @@ static ssize_t trans_stat_show(struct device *dev,
>>>  	len = sprintf(buf, "     From  :   To\n");
>>>  	len += sprintf(buf + len, "           :");
>>>  
>>> -	spin_lock(&devfreq->stats_lock);
>>> +	spin_lock(&profile->stats_lock);
>>>  	for (i = 0; i < max_state; i++)
>>>  		len += sprintf(buf + len, "%10lu",
>>> -				devfreq->profile->freq_table[i]);
>>> +				profile->freq_table[i]);
>>>  
>>>  	len += sprintf(buf + len, "   time(ms)\n");
>>>  
>>>  	for (i = 0; i < max_state; i++) {
>>> -		if (devfreq->profile->freq_table[i]
>>> -					== devfreq->previous_freq) {
>>> +		if (profile->freq_table[i] == devfreq->previous_freq)
>>>  			len += sprintf(buf + len, "*");
>>> -		} else {
>>> +		else
>>>  			len += sprintf(buf + len, " ");
>>> -		}
>>> +
>>>  		len += sprintf(buf + len, "%10lu:",
>>> -				devfreq->profile->freq_table[i]);
>>> +				profile->freq_table[i]);
>>>  		for (j = 0; j < max_state; j++)
>>>  			len += sprintf(buf + len, "%10u",
>>> -				devfreq->trans_table[(i * max_state) + j]);
>>> +				profile->trans_table[(i * max_state) + j]);
>>>  		len += sprintf(buf + len, "%10llu\n", (u64)
>>> -			jiffies64_to_msecs(devfreq->time_in_state[i]));
>>> +			jiffies64_to_msecs(profile->time_in_state[i]));
>>>  	}
>>>  
>>>  	len += sprintf(buf + len, "Total transition : %u\n",
>>> -					devfreq->total_trans);
>>> -	spin_unlock(&devfreq->stats_lock);
>>> +					profile->total_trans);
>>> +	spin_unlock(&profile->stats_lock);
>>>  	return len;
>>>  }
>>>  static DEVICE_ATTR_RO(trans_stat);
>>>  
>>> -static void defvreq_stats_clear_table(struct devfreq *devfreq)
>>> +static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
>>>  {
>>> -	unsigned int count = devfreq->profile->max_state;
>>> -
>>> -	spin_lock(&devfreq->stats_lock);
>>> -	memset(devfreq->time_in_state, 0, count * sizeof(u64));
>>> -	memset(devfreq->trans_table, 0, count * count * sizeof(int));
>>> -	devfreq->last_time = get_jiffies_64();
>>> -	devfreq->total_trans = 0;
>>> -	spin_unlock(&devfreq->stats_lock);
>>> +	unsigned int count = profile->max_state;
>>> +
>>> +	spin_lock(&profile->stats_lock);
>>> +	memset(profile->time_in_state, 0, count * sizeof(u64));
>>> +	memset(profile->trans_table, 0, count * count * sizeof(int));
>>> +	profile->last_time = get_jiffies_64();
>>> +	profile->total_trans = 0;
>>> +	spin_unlock(&profile->stats_lock);
>>>  }
>>>  
>>>  static ssize_t trans_reset_store(struct device *dev,
>>> @@ -1464,7 +1465,7 @@ static ssize_t trans_reset_store(struct device *dev,
>>>  {
>>>  	struct devfreq *devfreq = to_devfreq(dev);
>>>  
>>> -	defvreq_stats_clear_table(devfreq);
>>> +	defvreq_stats_clear_table(devfreq->profile);
>>>  
>>>  	return count;
>>>  }
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index 2ddf25993f7d..4ceb2a517a9c 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -91,6 +91,12 @@ struct devfreq_dev_status {
>>>   * @freq_table:		Optional list of frequencies to support statistics
>>>   *			and freq_table must be generated in ascending order.
>>>   * @max_state:		The size of freq_table.
>>> + * @total_trans:	Number of devfreq transitions
>>> + * @trans_table:	Statistics of devfreq transitions
>>> + * @time_in_state:	Statistics of devfreq states
>>> + * @last_time:		The last time stats were updated
>>> + * @stats_lock:		Lock protecting trans_table, time_in_state,
>>> + *			last_time and total_trans used for statistics
>>>   */
>>>  struct devfreq_dev_profile {
>>>  	unsigned long initial_freq;
>>> @@ -104,6 +110,12 @@ struct devfreq_dev_profile {
>>>  
>>>  	unsigned long *freq_table;
>>>  	unsigned int max_state;
>>> +	/* information for device frequency transition */
>>> +	unsigned int total_trans;
>>> +	unsigned int *trans_table;
>>> +	u64 *time_in_state;
>>> +	unsigned long long last_time;
>>> +	spinlock_t stats_lock;
>>>  };
>>>  
>>>  /**
>>> @@ -131,12 +143,6 @@ struct devfreq_dev_profile {
>>>   * @suspend_freq:	 frequency of a device set during suspend phase.
>>>   * @resume_freq:	 frequency of a device set in resume phase.
>>>   * @suspend_count:	 suspend requests counter for a device.
>>> - * @total_trans:	Number of devfreq transitions
>>> - * @trans_table:	Statistics of devfreq transitions
>>> - * @time_in_state:	Statistics of devfreq states
>>> - * @last_time:		The last time stats were updated
>>> - * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
>>> - *			and total_trans used for statistics
>>>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>>>   *
>>>   * This structure stores the devfreq information for a give device.
>>> @@ -173,13 +179,6 @@ struct devfreq {
>>>  	unsigned long resume_freq;
>>>  	atomic_t suspend_count;
>>>  
>>> -	/* information for device frequency transition */
>>> -	unsigned int total_trans;
>>> -	unsigned int *trans_table;
>>> -	u64 *time_in_state;
>>> -	unsigned long long last_time;
>>> -	spinlock_t stats_lock;
>>> -
>>>  	struct srcu_notifier_head transition_notifier_list;
>>>  };
>>>  
>>>
> 
> 
> 
