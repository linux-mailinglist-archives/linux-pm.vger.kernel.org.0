Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3625FD32C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 04:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKODUI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 22:20:08 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:64631 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKODUI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 22:20:08 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191115032003epoutp011abc72e076d91449d5d6dc6edf2506dd~XN9nxI_Aj3228732287epoutp01X
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 03:20:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191115032003epoutp011abc72e076d91449d5d6dc6edf2506dd~XN9nxI_Aj3228732287epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573788004;
        bh=GLG0ggFWQbob1fPAgRQXtbKwGUMmaPgJe+A0vamZDeo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TSOOu549T0+oAa7loIGDAu9rxNSKXXRQvgHtdaziW191dtqQvnaa72RcBYyraPs+F
         VBs/JFPpX3v5/eoG12V5DEnaxFT0o1UhZ91cA8ITnLoPcBwQPVPQvfqG2ecEi/d1rX
         lPdmyAgbUozWbU9vjnMBufWJ3Rlnztc5G7yAuETg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191115032003epcas1p3e7bda3f6fb1e80e029146bf77e955da5~XN9nc_dXb0477604776epcas1p3v;
        Fri, 15 Nov 2019 03:20:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47Dk9s0FN0zMqYkX; Fri, 15 Nov
        2019 03:20:01 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.9F.04068.0691ECD5; Fri, 15 Nov 2019 12:20:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191115032000epcas1p478fc964dd8f06dc262ca0c3fd6858e44~XN9kJFK6C0162401624epcas1p4A;
        Fri, 15 Nov 2019 03:20:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191115032000epsmtrp15650bec40905ce911d4434b01e1eaa04~XN9kIINEL0970609706epsmtrp1b;
        Fri, 15 Nov 2019 03:20:00 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-8d-5dce1960e68e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.A2.24756.F591ECD5; Fri, 15 Nov 2019 12:19:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191115031959epsmtip12b01d12d3fb1ed51d189c73f2da6e26b~XN9j4qGLN2941129411epsmtip1e;
        Fri, 15 Nov 2019 03:19:59 +0000 (GMT)
Subject: Re: [PATCH 7/7] devfreq: move statistics to separate struct
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Kamil Konieczny <k.konieczny@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <85a29ce4-0f89-2b50-b046-dba747208933@samsung.com>
Date:   Fri, 15 Nov 2019 12:25:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <38350d81-e916-b386-6727-f4c85689c172@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUwTYRD167bbRa1+liojMVqWGGMN0BWLiwpeREnwB4kxUWNTN3RTCL3S
        LQTFqKCoeCHoD6xcCRIRReTwFtGKJyBG422rEYInGEUMaDzaLkb+vZl5b2bed1CE8gwZSqVZ
        nbzDyplpcrT07PWZkRHc5Ht6bT3J1hfXydiKr8UytqDrI8F2dp6Wsx25n+RsQ9djGfvwYgnJ
        9u9rRWxx5xUJW9vqkbMvcqrJRWMSG2ryycTGo1sS9zfVoMT+hqnJ0rXpC1J5zsg71Lw1xWZM
        s5ri6KSVhqUGXYyWiWBi2bm02spZ+Dg6YUVyxLI0s28nWp3JmTN8qWROEOio+AUOW4aTV6fa
        BGcczduNZnusPVLgLEKG1RSZYrPMY7Ta2TofcX166rnyaon9bSPK6m30yrei44VoNwqiAM+B
        Fx/75LvRaEqJzyO4drBbIgZfEQxd6pGJwXcET5o95D9J7ZEfw6xmBHebK4eDzwjKBjyBxsE4
        AdqLcgMKFWahtrpX6icR+I8Enl3dL/UXSKyBlndPA6TxOAweDXYFxAocD9+u9BN+LMXT4VVX
        vg9T1ES8GtoGOJEyAe4c7g60CcIL4faQV+7HBA6B593lEhFPg3O9JYR/LuA9cnDXvZSIFhLg
        eskTqYiD4cOtJrmIQ+F9wY5hnA3H77SSongXgqaW+zKxEA0tVQcl/oUIPBPqLkaJ6TC48LMU
        iYPHQd/AXpmfAlgBu3YoRUo4PHztGV5hMlTuzCcPINo1wo5rhAXXCAuu/8MqkLQGTeLtgsXE
        C4xdN/LCG1DgyWpiz6Ob91a4EaYQPVYBzzv0ShmXKWywuBFQBK1SHOpt1ysVRm7DRt5hMzgy
        zLzgRjrfYRcSoRNTbL4PYHUaGN3s6Ohodg4To2MYOkSx+FiVXolNnJNP53k77/ink1BBoVuR
        oXSK8YbzXSajWTer9LOLLJrUMRB79QHOme7tWf4mS+ae1x2edsOT8iXspvNXXk3etzJiaEbB
        ATopitOW/H7jDX40X7WkOHL7tk1e1enteSdUl3vi7+fWV/3QZ2WP0r7tm3oqfEv++AKXJpN5
        enKwLWKCSRsyatXmNeqWV2vX1RKNtFRI5RgN4RC4v84usQ7IAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnG685LlYg8VnbSw2zljParHg0wxW
        i/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbA7fHplWd
        bB6bl9R79G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8b2+SuYCp5vZqx4u/keewPjyomMXYyc
        HBICJhJrZ/9iArGFBHYzShz/Eg8Rl5SYdvEocxcjB5AtLHH4cHEXIxdQyVtGif+tE8HqhQVc
        JM5MamIDsUUELCTWrnjLAlLELNDILDFnzWc2iI7VTBJbzq0E28YmoCWx/8UNsA5+AUWJqz8e
        g8V5Bewkvuz7zAxiswioStx/3AlmiwpESDzffgOqRlDi5MwnLCA2p4C9xImf99hBbGYBdYk/
        8y4xQ9jiEreezGeCsOUltr+dwzyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zU
        cr3ixNzi0rx0veT83E2M4HjT0tzBeHlJ/CFGAQ5GJR5eiVtnY4VYE8uKK3MPMUpwMCuJ8E55
        eyZWiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBsa56bqS
        p16v2tvncsRh/kMjiT1rF9bvcvh7QCjd1U1I1fNn0CVOh7+Mfdv8J5q5GRjVnFV3ScnSODqL
        /fSs2wVXjFxq5k52Ud/X6mX0wTj1ItcUOx/fu5PvLAxa8sx8wvQtzR/jLl2e8nrujCm+3i4f
        PES6eLZe3rZBidfA4UJknuM/l9L7fwOVWIozEg21mIuKEwGviK69swIAAA==
X-CMS-MailID: 20191115032000epcas1p478fc964dd8f06dc262ca0c3fd6858e44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a@eucas1p2.samsung.com>
        <20191113091336.5218-8-k.konieczny@samsung.com>
        <4942d2ad-fef7-89be-91c1-c02c319546ff@samsung.com>
        <38350d81-e916-b386-6727-f4c85689c172@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bartlomiej,

On 11/15/19 3:01 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Chanwoo,
> 
> On 11/14/19 2:52 AM, Chanwoo Choi wrote:
>> Hi Kamil,
>>
>> The 'freq_table' and 'max_state' in the devfreq_dev_profile
>> were used in the ARM Mali device driver[1][2][3]. Although ARM Mali
>> device driver was posted to mainline kernel, they used
>> them for a long time. It means that this patch break
>> the compatibility. The ARM Mali drivers are very
>> important devfreq device driver. 
> 
> This argument is not a a technical one and the official upstream
> kernel policy is to not depend on out-of-tree drivers.
> 
> Besides the ARM Mali drivers are full of code like:
> 
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(x, y, z)
> ...
> #else
> ...
> #endif
> 
> so few more instances of similar code won't do any harm.. ;-)
> 
>> [1] https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/bifrost-kernel#
>> [2] https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/midgard-kernel
>> [3] https://developer.arm.com/tools-and-software/graphics-and-gaming/mali-drivers/utgard-kernel
> 
> I took a look at ARM Mali drivers source code anyway and I fail to
> see a rationale behind their behavior of doing 'freq_table' and
> 'max_state' initialization in the driver itself (instead of leaving
> it up to the devfreq core code, like all in-kernel drivers are doing
> already).
> 
> Could you please explain rationale behind ARM Mali drivers' special
> needs?
> 
> [ Both ARM Mali and devfreq core code are using generic PM OPP code
>   these days to do 'freq_table' and 'max_state' initialization, the
>   only difference seems to be that ARM Mali creates the frequency
>   table in the descending order (but there also seems to be no real
>   need for it). ]
> 
> Maybe this is an opportunity to simplify also the ARM Mali driver?

OK. I agree to simplify them on this time.
For touching the 'freq_table' and 'max_state', need to fix
the descending order of freq_table. 

The partition_enable_ops() in the drivers/thermal/devfreq_cooling.c 
requires the descending order of freq_table. Have to change it by using
the ascending time or support both ascending and descending order for freq_table.

1. Move freq_table, max_state of devfreq_dev_profile to struct devfreq
2. Edit partition_enable_ops() in the drivers/thermal/devfreq_cooling.c 
   by using ascending order instead of descending order.

> 
>> Also, the devfreq device driver specifies their own
>> information and data into devfreq_dev_profile structure 
>> before registering the devfreq device with devfreq_add_device().
>> This patch breaks the basic usage rule of devfreq_dev_profile structure.
> 
> Well, 'struct devfreq_stats *stats' can be trivially moved out of
> 'struct devfreq_profile' to 'struct devfreq' if you prefer it that
> way..
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> So, I can't agree this patch. Not ack.
>>
>> Regards,
>> Chanwoo Choi
>>
>> On 11/13/19 6:13 PM, Kamil Konieczny wrote:
>>> Count time and transitions between devfreq frequencies in separate struct
>>> for improved code readability and maintenance.
>>>
>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>> ---
>>>  drivers/devfreq/devfreq.c          | 156 ++++++++++++++++-------------
>>>  drivers/devfreq/exynos-bus.c       |   6 +-
>>>  drivers/devfreq/governor_passive.c |  26 +++--
>>>  include/linux/devfreq.h            |  43 ++++----
>>>  4 files changed, 129 insertions(+), 102 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index d79412b0de59..d85867a91230 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -105,10 +105,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>   */
>>>  static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>>>  {
>>> +	struct devfreq_stats *stats = devfreq->profile->stats;
>>>  	int lev;
>>>  
>>> -	for (lev = 0; lev < devfreq->profile->max_state; lev++)
>>> -		if (freq == devfreq->profile->freq_table[lev])
>>> +	for (lev = 0; lev < stats->max_state; lev++)
>>> +		if (freq == stats->freq_table[lev])
>>>  			return lev;
>>>  
>>>  	return -EINVAL;
>>> @@ -117,56 +118,64 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>>>  static int set_freq_table(struct devfreq *devfreq)
>>>  {
>>>  	struct devfreq_dev_profile *profile = devfreq->profile;
>>> +	struct devfreq_stats *stats;
>>>  	struct dev_pm_opp *opp;
>>>  	unsigned long freq;
>>> -	int i, count;
>>> +	int i, count, err = -ENOMEM;
>>>  
>>>  	/* Initialize the freq_table from OPP table */
>>>  	count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
>>>  	if (count <= 0)
>>>  		return -EINVAL;
>>>  
>>> -	profile->max_state = count;
>>> -	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
>>> -					count,
>>> -					sizeof(*profile->freq_table),
>>> -					GFP_KERNEL);
>>> -	if (!profile->freq_table) {
>>> -		profile->max_state = 0;
>>> +	stats = devm_kzalloc(devfreq->dev.parent,
>>> +			     sizeof(struct devfreq_stats), GFP_KERNEL);
>>> +	if (!stats)
>>>  		return -ENOMEM;
>>> -	}
>>>  
>>> -	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
>>> +	profile->stats = stats;
>>> +	stats->max_state = count;
>>> +	stats->freq_table = devm_kcalloc(devfreq->dev.parent,
>>> +					 count,
>>> +					 sizeof(*stats->freq_table),
>>> +					 GFP_KERNEL);
>>> +	if (!stats->freq_table)
>>> +		goto err_no_mem;
>>> +
>>> +	for (i = 0, freq = 0; i < count; i++, freq++) {
>>>  		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
>>>  		if (IS_ERR(opp)) {
>>> -			devm_kfree(devfreq->dev.parent, profile->freq_table);
>>> -			profile->max_state = 0;
>>> -			return PTR_ERR(opp);
>>> +			devm_kfree(devfreq->dev.parent, stats->freq_table);
>>> +			stats->max_state = 0;
>>> +			err = PTR_ERR(opp);
>>> +			goto err_no_mem;
>>>  		}
>>>  		dev_pm_opp_put(opp);
>>> -		profile->freq_table[i] = freq;
>>> +		stats->freq_table[i] = freq;
>>>  	}
>>>  
>>> -	profile->trans_table = devm_kzalloc(devfreq->dev.parent,
>>> -					    array3_size(sizeof(unsigned int),
>>> -							count, count),
>>> -					    GFP_KERNEL);
>>> -	if (!profile->trans_table)
>>> +	stats->trans_table = devm_kzalloc(devfreq->dev.parent,
>>> +					  array3_size(sizeof(unsigned int),
>>> +						      count, count),
>>> +					  GFP_KERNEL);
>>> +	if (!stats->trans_table)
>>>  		goto err_no_mem;
>>>  
>>> -	profile->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
>>> -					      sizeof(*profile->time_in_state),
>>> -					      GFP_KERNEL);
>>> -	if (!profile->time_in_state)
>>> +	stats->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
>>> +					    sizeof(*stats->time_in_state),
>>> +					    GFP_KERNEL);
>>> +	if (!stats->time_in_state)
>>>  		goto err_no_mem;
>>>  
>>> -	profile->last_time = get_jiffies_64();
>>> -	spin_lock_init(&profile->stats_lock);
>>> +	stats->last_time = get_jiffies_64();
>>> +	spin_lock_init(&stats->stats_lock);
>>>  
>>>  	return 0;
>>>  err_no_mem:
>>> -	profile->max_state = 0;
>>> -	return -ENOMEM;
>>> +	stats->max_state = 0;
>>> +	devm_kfree(devfreq->dev.parent, profile->stats);
>>> +	profile->stats = NULL;
>>> +	return err;
>>>  }
>>>  
>>>  /**
>>> @@ -176,7 +185,7 @@ static int set_freq_table(struct devfreq *devfreq)
>>>   */
>>>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>  {
>>> -	struct devfreq_dev_profile *profile = devfreq->profile;
>>> +	struct devfreq_stats *stats = devfreq->profile->stats;
>>>  	unsigned long long cur_time;
>>>  	int lev, prev_lev, ret = 0;
>>>  
>>> @@ -184,22 +193,21 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>  
>>>  	/* Immediately exit if previous_freq is not initialized yet. */
>>>  	if (!devfreq->previous_freq) {
>>> -		spin_lock(&profile->stats_lock);
>>> -		profile->last_time = cur_time;
>>> -		spin_unlock(&profile->stats_lock);
>>> +		spin_lock(&stats->stats_lock);
>>> +		stats->last_time = cur_time;
>>> +		spin_unlock(&stats->stats_lock);
>>>  		return 0;
>>>  	}
>>>  
>>>  	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>>>  
>>> -	spin_lock(&profile->stats_lock);
>>> +	spin_lock(&stats->stats_lock);
>>>  	if (prev_lev < 0) {
>>>  		ret = prev_lev;
>>>  		goto out;
>>>  	}
>>>  
>>> -	profile->time_in_state[prev_lev] +=
>>> -			 cur_time - profile->last_time;
>>> +	stats->time_in_state[prev_lev] += cur_time - stats->last_time;
>>>  	lev = devfreq_get_freq_level(devfreq, freq);
>>>  	if (lev < 0) {
>>>  		ret = lev;
>>> @@ -207,14 +215,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>  	}
>>>  
>>>  	if (lev != prev_lev) {
>>> -		profile->trans_table[(prev_lev *
>>> -				profile->max_state) + lev]++;
>>> -		profile->total_trans++;
>>> +		stats->trans_table[(prev_lev *
>>> +				stats->max_state) + lev]++;
>>> +		stats->total_trans++;
>>>  	}
>>>  
>>>  out:
>>> -	profile->last_time = cur_time;
>>> -	spin_unlock(&profile->stats_lock);
>>> +	stats->last_time = cur_time;
>>> +	spin_unlock(&stats->stats_lock);
>>>  	return ret;
>>>  }
>>>  EXPORT_SYMBOL(devfreq_update_status);
>>> @@ -504,9 +512,9 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>>>  			msecs_to_jiffies(profile->polling_ms));
>>>  
>>> -	spin_lock(&profile->stats_lock);
>>> -	profile->last_time = get_jiffies_64();
>>> -	spin_unlock(&profile->stats_lock);
>>> +	spin_lock(&profile->stats->stats_lock);
>>> +	profile->stats->last_time = get_jiffies_64();
>>> +	spin_unlock(&profile->stats->stats_lock);
>>>  	devfreq->stop_polling = false;
>>>  
>>>  	if (profile->get_cur_freq &&
>>> @@ -677,7 +685,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  	devfreq->data = data;
>>>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>>>  
>>> -	if (!profile->max_state && !profile->freq_table) {
>>> +	if (!profile->stats) {
>>>  		mutex_unlock(&devfreq->lock);
>>>  		err = set_freq_table(devfreq);
>>>  		if (err < 0)
>>> @@ -1282,6 +1290,7 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>  			      const char *buf, size_t count)
>>>  {
>>>  	struct devfreq *df = to_devfreq(dev);
>>> +	struct devfreq_stats *stats = df->profile->stats;
>>>  	unsigned long value;
>>>  	int ret;
>>>  
>>> @@ -1297,13 +1306,13 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>  			goto unlock;
>>>  		}
>>>  	} else {
>>> -		unsigned long *freq_table = df->profile->freq_table;
>>> +		unsigned long *freq_table = stats->freq_table;
>>>  
>>>  		/* Get minimum frequency according to sorting order */
>>> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
>>> +		if (freq_table[0] < freq_table[stats->max_state - 1])
>>>  			value = freq_table[0];
>>>  		else
>>> -			value = freq_table[df->profile->max_state - 1];
>>> +			value = freq_table[stats->max_state - 1];
>>>  	}
>>>  
>>>  	df->min_freq = value;
>>> @@ -1326,6 +1335,7 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>  			      const char *buf, size_t count)
>>>  {
>>>  	struct devfreq *df = to_devfreq(dev);
>>> +	struct devfreq_stats *stats = df->profile->stats;
>>>  	unsigned long value;
>>>  	int ret;
>>>  
>>> @@ -1341,11 +1351,11 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>  			goto unlock;
>>>  		}
>>>  	} else {
>>> -		unsigned long *freq_table = df->profile->freq_table;
>>> +		unsigned long *freq_table = stats->freq_table;
>>>  
>>>  		/* Get maximum frequency according to sorting order */
>>> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
>>> -			value = freq_table[df->profile->max_state - 1];
>>> +		if (freq_table[0] < freq_table[stats->max_state - 1])
>>> +			value = freq_table[stats->max_state - 1];
>>>  		else
>>>  			value = freq_table[0];
>>>  	}
>>> @@ -1373,14 +1383,15 @@ static ssize_t available_frequencies_show(struct device *d,
>>>  					  char *buf)
>>>  {
>>>  	struct devfreq *df = to_devfreq(d);
>>> +	struct devfreq_stats *stats = df->profile->stats;
>>>  	ssize_t count = 0;
>>>  	int i;
>>>  
>>>  	mutex_lock(&df->lock);
>>>  
>>> -	for (i = 0; i < df->profile->max_state; i++)
>>> +	for (i = 0; i < stats->max_state; i++)
>>>  		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
>>> -				"%lu ", df->profile->freq_table[i]);
>>> +				"%lu ", stats->freq_table[i]);
>>>  
>>>  	mutex_unlock(&df->lock);
>>>  	/* Truncate the trailing space */
>>> @@ -1398,9 +1409,10 @@ static ssize_t trans_stat_show(struct device *dev,
>>>  {
>>>  	struct devfreq *devfreq = to_devfreq(dev);
>>>  	struct devfreq_dev_profile *profile = devfreq->profile;
>>> +	struct devfreq_stats *stats = profile->stats;
>>> +	unsigned int max_state = stats->max_state;
>>>  	ssize_t len;
>>>  	int i, j;
>>> -	unsigned int max_state = profile->max_state;
>>>  
>>>  	if (!devfreq->stop_polling &&
>>>  			devfreq_update_status(devfreq, devfreq->previous_freq))
>>> @@ -1411,45 +1423,45 @@ static ssize_t trans_stat_show(struct device *dev,
>>>  	len = sprintf(buf, "     From  :   To\n");
>>>  	len += sprintf(buf + len, "           :");
>>>  
>>> -	spin_lock(&profile->stats_lock);
>>> +	spin_lock(&stats->stats_lock);
>>>  	for (i = 0; i < max_state; i++)
>>>  		len += sprintf(buf + len, "%10lu",
>>> -				profile->freq_table[i]);
>>> +				stats->freq_table[i]);
>>>  
>>>  	len += sprintf(buf + len, "   time(ms)\n");
>>>  
>>>  	for (i = 0; i < max_state; i++) {
>>> -		if (profile->freq_table[i] == devfreq->previous_freq)
>>> +		if (stats->freq_table[i] == devfreq->previous_freq)
>>>  			len += sprintf(buf + len, "*");
>>>  		else
>>>  			len += sprintf(buf + len, " ");
>>>  
>>>  		len += sprintf(buf + len, "%10lu:",
>>> -				profile->freq_table[i]);
>>> +				stats->freq_table[i]);
>>>  		for (j = 0; j < max_state; j++)
>>>  			len += sprintf(buf + len, "%10u",
>>> -				profile->trans_table[(i * max_state) + j]);
>>> +				stats->trans_table[(i * max_state) + j]);
>>>  		len += sprintf(buf + len, "%10llu\n", (u64)
>>> -			jiffies64_to_msecs(profile->time_in_state[i]));
>>> +			jiffies64_to_msecs(stats->time_in_state[i]));
>>>  	}
>>>  
>>>  	len += sprintf(buf + len, "Total transition : %u\n",
>>> -					profile->total_trans);
>>> -	spin_unlock(&profile->stats_lock);
>>> +					stats->total_trans);
>>> +	spin_unlock(&stats->stats_lock);
>>>  	return len;
>>>  }
>>>  static DEVICE_ATTR_RO(trans_stat);
>>>  
>>> -static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
>>> +static void defvreq_stats_clear_table(struct devfreq_stats *stats)
>>>  {
>>> -	unsigned int count = profile->max_state;
>>> -
>>> -	spin_lock(&profile->stats_lock);
>>> -	memset(profile->time_in_state, 0, count * sizeof(u64));
>>> -	memset(profile->trans_table, 0, count * count * sizeof(int));
>>> -	profile->last_time = get_jiffies_64();
>>> -	profile->total_trans = 0;
>>> -	spin_unlock(&profile->stats_lock);
>>> +	unsigned int count = stats->max_state;
>>> +
>>> +	spin_lock(&stats->stats_lock);
>>> +	memset(stats->time_in_state, 0, count * sizeof(u64));
>>> +	memset(stats->trans_table, 0, count * count * sizeof(int));
>>> +	stats->last_time = get_jiffies_64();
>>> +	stats->total_trans = 0;
>>> +	spin_unlock(&stats->stats_lock);
>>>  }
>>>  
>>>  static ssize_t trans_reset_store(struct device *dev,
>>> @@ -1459,7 +1471,7 @@ static ssize_t trans_reset_store(struct device *dev,
>>>  {
>>>  	struct devfreq *devfreq = to_devfreq(dev);
>>>  
>>> -	defvreq_stats_clear_table(devfreq->profile);
>>> +	defvreq_stats_clear_table(devfreq->profile->stats);
>>>  
>>>  	return count;
>>>  }
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index d9f377912c10..b212aae2bb3e 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -496,9 +496,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  	}
>>>  
>>>  out:
>>> -	max_state = bus->devfreq->profile->max_state;
>>> -	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>>> -	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
>>> +	max_state = profile->stats->max_state;
>>> +	min_freq = (profile->stats->freq_table[0] / 1000);
>>> +	max_freq = (profile->stats->freq_table[max_state - 1] / 1000);
>>>  	pr_info("exynos-bus: new bus device registered: %s (%6ld KHz ~ %6ld KHz)\n",
>>>  			dev_name(dev), min_freq, max_freq);
>>>  
>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>> index 58308948b863..b2d87a88335c 100644
>>> --- a/drivers/devfreq/governor_passive.c
>>> +++ b/drivers/devfreq/governor_passive.c
>>> @@ -18,6 +18,8 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>  	struct devfreq_passive_data *p_data
>>>  			= (struct devfreq_passive_data *)devfreq->data;
>>>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>>> +	struct devfreq_stats *parent_stats = parent_devfreq->profile->stats;
>>> +	struct devfreq_stats *stats;
>>>  	unsigned long child_freq = ULONG_MAX;
>>>  	struct dev_pm_opp *opp;
>>>  	int i, count, ret = 0;
>>> @@ -47,10 +49,14 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>  	 * device. And then the index is used for getting the suitable
>>>  	 * new frequency for passive devfreq device.
>>>  	 */
>>> -	if (!devfreq->profile || !devfreq->profile->freq_table
>>> -		|| devfreq->profile->max_state <= 0)
>>> +	if (!devfreq->profile || !devfreq->profile->stats ||
>>> +	    devfreq->profile->stats->max_state <= 0 ||
>>> +	    !parent_devfreq->profile ||	!parent_devfreq->profile->stats ||
>>> +	    parent_devfreq->profile->stats->max_state <= 0)
>>>  		return -EINVAL;
>>>  
>>> +	stats = devfreq->profile->stats;
>>> +	parent_stats = parent_devfreq->profile->stats;
>>>  	/*
>>>  	 * The passive governor have to get the correct frequency from OPP
>>>  	 * list of parent device. Because in this case, *freq is temporary
>>> @@ -68,21 +74,21 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>>>  	 * Get the OPP table's index of decided freqeuncy by governor
>>>  	 * of parent device.
>>>  	 */
>>> -	for (i = 0; i < parent_devfreq->profile->max_state; i++)
>>> -		if (parent_devfreq->profile->freq_table[i] == *freq)
>>> +	for (i = 0; i < parent_stats->max_state; i++)
>>> +		if (parent_stats->freq_table[i] == *freq)
>>>  			break;
>>>  
>>> -	if (i == parent_devfreq->profile->max_state) {
>>> +	if (i == parent_stats->max_state) {
>>>  		ret = -EINVAL;
>>>  		goto out;
>>>  	}
>>>  
>>>  	/* Get the suitable frequency by using index of parent device. */
>>> -	if (i < devfreq->profile->max_state) {
>>> -		child_freq = devfreq->profile->freq_table[i];
>>> +	if (i < stats->max_state) {
>>> +		child_freq = stats->freq_table[i];
>>>  	} else {
>>> -		count = devfreq->profile->max_state;
>>> -		child_freq = devfreq->profile->freq_table[count - 1];
>>> +		count = stats->max_state;
>>> +		child_freq = stats->freq_table[count - 1];
>>>  	}
>>>  
>>>  	/* Return the suitable frequency for passive device. */
>>> @@ -109,7 +115,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>>>  	if (ret < 0)
>>>  		goto out;
>>>  
>>> -	if (devfreq->profile->freq_table
>>> +	if (devfreq->profile->stats
>>>  		&& (devfreq_update_status(devfreq, freq)))
>>>  		dev_err(&devfreq->dev,
>>>  			"Couldn't update frequency transition information.\n");
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index 4ceb2a517a9c..8459af1a1583 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -64,6 +64,30 @@ struct devfreq_dev_status {
>>>   */
>>>  #define DEVFREQ_FLAG_LEAST_UPPER_BOUND		0x1
>>>  
>>> +/**
>>> + * struct devfreq_stats - Devfreq's transitions stats counters
>>> + * @freq_table:		Optional list of frequencies to support statistics
>>> + *			and freq_table must be generated in ascending order.
>>> + * @max_state:		The size of freq_table.
>>> + * @total_trans:	Number of devfreq transitions
>>> + * @trans_table:	Statistics of devfreq transitions
>>> + * @time_in_state:	Statistics of devfreq states
>>> + * @last_time:		The last time stats were updated
>>> + * @stats_lock:		Lock protecting trans_table, time_in_state,
>>> + *			last_time and total_trans used for statistics
>>> + */
>>> +struct devfreq_stats {
>>> +	unsigned long *freq_table;
>>> +	unsigned int max_state;
>>> +
>>> +	/* information for device frequency transition */
>>> +	unsigned int total_trans;
>>> +	unsigned int *trans_table;
>>> +	u64 *time_in_state;
>>> +	unsigned long long last_time;
>>> +	spinlock_t stats_lock;
>>> +};
>>> +
>>>  /**
>>>   * struct devfreq_dev_profile - Devfreq's user device profile
>>>   * @initial_freq:	The operating frequency when devfreq_add_device() is
>>> @@ -88,15 +112,7 @@ struct devfreq_dev_status {
>>>   *			from devfreq_remove_device() call. If the user
>>>   *			has registered devfreq->nb at a notifier-head,
>>>   *			this is the time to unregister it.
>>> - * @freq_table:		Optional list of frequencies to support statistics
>>> - *			and freq_table must be generated in ascending order.
>>> - * @max_state:		The size of freq_table.
>>> - * @total_trans:	Number of devfreq transitions
>>> - * @trans_table:	Statistics of devfreq transitions
>>> - * @time_in_state:	Statistics of devfreq states
>>> - * @last_time:		The last time stats were updated
>>> - * @stats_lock:		Lock protecting trans_table, time_in_state,
>>> - *			last_time and total_trans used for statistics
>>> + * @stats:		Statistics of devfreq states and state transitions
>>>   */
>>>  struct devfreq_dev_profile {
>>>  	unsigned long initial_freq;
>>> @@ -108,14 +124,7 @@ struct devfreq_dev_profile {
>>>  	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
>>>  	void (*exit)(struct device *dev);
>>>  
>>> -	unsigned long *freq_table;
>>> -	unsigned int max_state;
>>> -	/* information for device frequency transition */
>>> -	unsigned int total_trans;
>>> -	unsigned int *trans_table;
>>> -	u64 *time_in_state;
>>> -	unsigned long long last_time;
>>> -	spinlock_t stats_lock;
>>> +	struct devfreq_stats *stats;
>>>  };
>>>  
>>>  /**
>>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
