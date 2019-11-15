Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322E4FE040
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 15:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfKOOjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 09:39:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45271 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfKOOjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 09:39:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191115143944euoutp02f75017848a19bb612be9211885883022~XXPDnbjyP2481324813euoutp02g
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 14:39:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191115143944euoutp02f75017848a19bb612be9211885883022~XXPDnbjyP2481324813euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573828784;
        bh=qeYmgMpw3k0qDaYlkrZmS9Ht2MHgEojIzXblqAuaCdo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NTIM1ydBBG4qbuXBEqsSwP/SpyT2p7nPBmTCzWZ66TAqoqQsCjFIBugzN2xF5tv/u
         voFnBihbJ9FDBPXUTWh+eHxIjevjVlAblYU0mRLnhX+BIT4Gvl2JlcbD6e3UJqYEi9
         Ef0Mnb1L0yehJlWmVUm/aRtiWJ0Qg687HGjATFxk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191115143943eucas1p249821dec2b509e2252e8f87cb8b95ca5~XXPDGq7wY0342603426eucas1p2j;
        Fri, 15 Nov 2019 14:39:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 78.E8.04309.FA8BECD5; Fri, 15
        Nov 2019 14:39:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191115143943eucas1p23b9969a12b43e3e17acf20bc501ee176~XXPC2YvPx0338003380eucas1p2k;
        Fri, 15 Nov 2019 14:39:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191115143943eusmtrp2777a659cd9bb57ef6b78bee408db1516~XXPC1yCxK1835918359eusmtrp2I;
        Fri, 15 Nov 2019 14:39:43 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-30-5dceb8af61f3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.83.04166.FA8BECD5; Fri, 15
        Nov 2019 14:39:43 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191115143943eusmtip215162d59ee91818c68f2a7960387b764~XXPCO0OI42706827068eusmtip2h;
        Fri, 15 Nov 2019 14:39:43 +0000 (GMT)
Subject: Re: [PATCH 5/7] devfreq: move transition statistics to devfreq
 profile structure
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <429b16bb-3d5f-b00b-c5e9-365104ac8676@samsung.com>
Date:   Fri, 15 Nov 2019 15:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <72e517d9-725d-b05d-028f-153bb6684df3@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87rrd5yLNZjx0NJi44z1rBbXvzxn
        tVjwaQarxfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3uN24gs2B02PTqk42j74tqxg9Pm+S
        C2CO4rJJSc3JLEst0rdL4Mq4umEHe8GbxIo/f38zNjC2+3cxcnJICJhILHr0gr2LkYtDSGAF
        o8Sy49+YIJwvjBKdbf2MEM5nRom/698DlXGAtTx8JQ0RX84ocfh8EzOE85ZRYtPJlawgc4UF
        oiWeb/vODmKLCGhIzPx7BWwSs8BpJontH3+BJdgE9CUOnj3JAmLzCthJzPtxlRVkA4uAqsTS
        x0IgpqhAhMTpr4kQFYISJ2c+AavmFLCX+PnmMtgqZgFxiVtP5jNB2PIS29/OAbtHQuAQu8S6
        h88YIf50kVg55xM7hC0s8er4FihbRuL/TohmCYFyiacL+9ghmlsYJR60f2SBSFhLHD5+Eew2
        ZgFNifW79CHCjhIrvq9ggQQKn8SNt4IQN/BJTNo2nRkizCvR0SYEUa0q8fxUD9QmaYmu/+tY
        JzAqzULy2Swk38xC8s0shL0LGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCag0/+O
        f9nBuOtP0iFGAQ5GJR5eh8nnYoVYE8uKK3MPMUpwMCuJ8E55eyZWiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA+PckA2xS1x39rX0KKdHroh+/UOPtWvX
        R43Wksi0pQ/aul8FTC/mFrx0c5efpFD7m/NmLa2pHly3v7dcl/r/I/yHgJHNnZPvPbdsX5I2
        XSovdPvK7flZ067s3KL7ce3nnftbOU59PfBV48f7GZd64pfMe6h852k626E8nbas9JNePdU7
        9jWcN6hVYinOSDTUYi4qTgQAJ4F93TwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7rrd5yLNdg2UdVi44z1rBbXvzxn
        tVjwaQarxfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3uN24gs2B02PTqk42j74tqxg9Pm+S
        C2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4
        umEHe8GbxIo/f38zNjC2+3cxcnBICJhIPHwl3cXIxSEksJRRYu71qcxdjJxAcWmJxtOrmSBs
        YYk/17rYIIpeM0osWLePESQhLBAt8Xzbd3YQW0RAQ2Lm3yuMIEXMAmeZJFZe3c4K0fGNUWL6
        8w9sIFVsAvoSB8+eZAGxeQXsJOb9uMoKcgaLgKrE0sdCIGFRgQiJ59tvMEKUCEqcnPkErJxT
        wF7i55vLrCA2s4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUV
        o0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYNRtO/Zz8w7GSxuDDzEKcDAq8fA6TD4XK8SaWFZc
        mXuIUYKDWUmEd8rbM7FCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA9MCHkl8YamhuYWlobm
        xubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhg5ApZ9+3D531PJm7M/PEn+eu5Ii0bD
        71/hm98orJ557mqwtL9yMHfsPouV+z8efxqu/2Nd35lSywtNv3+2Sok83in1wHDNt3dLb0Rs
        qMk87Ld987GpipsvJTy+PTHu756P/sXBqz9uPqOdebZzptCzVUs79s50Dni/6MjqNK02uWO/
        TnM5HL99f58SS3FGoqEWc1FxIgDpExmc0AIAAA==
X-CMS-MailID: 20191115143943eucas1p23b9969a12b43e3e17acf20bc501ee176
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f@eucas1p2.samsung.com>
        <20191113091336.5218-6-k.konieczny@samsung.com>
        <72e517d9-725d-b05d-028f-153bb6684df3@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14.11.2019 03:02, Chanwoo Choi wrote:
> Hi Kamil,
> 
> The devfreq_dev_profile structure have to only contain the each devfreq device
> callback function/data which are used in the devfreq core.
> 
> The generated information after registered the devfreq device
> with devfreq_add_device() should be stored in the 'struct device'.
> 
> The devfreq core need to split out the data between user input
> data (struct devfreq_dev_profile) and the initialized/generated data
> by core (struct devfreq). It is not same with cpufreq. cpufreq
> don't require the any structure like 'devfreq_dev_profile'.
> 
> So, I can't agree.

What about putting stats structure inside devfreq ?

> On 11/13/19 6:13 PM, Kamil Konieczny wrote:
>> Move transition statistics to devfreq profile structure. This is for
>> preparation for moving transition statistics into separate struct.
>> It is safe to do as frequency table and maximum state information are
>> already present in devfreq profile structure and there are no devfreq
>> drivers using more than one instance of devfreq structure per devfreq
>> profile one.
>>
>> It also makes devfreq code more similar to cpufreq one.
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 115 +++++++++++++++++++-------------------
>>  include/linux/devfreq.h   |  25 ++++-----
>>  2 files changed, 70 insertions(+), 70 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 6e5a17f4c92c..70533b787744 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -128,7 +128,7 @@ static int set_freq_table(struct devfreq *devfreq)
>>  
>>  	profile->max_state = count;
>>  	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
>> -					profile->max_state,
>> +					count,
>>  					sizeof(*profile->freq_table),
>>  					GFP_KERNEL);
>>  	if (!profile->freq_table) {
>> @@ -157,29 +157,30 @@ static int set_freq_table(struct devfreq *devfreq)
>>   */
>>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  {
>> -	int lev, prev_lev, ret = 0;
>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>  	unsigned long long cur_time;
>> +	int lev, prev_lev, ret = 0;
>>  
>>  	cur_time = get_jiffies_64();
>>  
>>  	/* Immediately exit if previous_freq is not initialized yet. */
>>  	if (!devfreq->previous_freq) {
>> -		spin_lock(&devfreq->stats_lock);
>> -		devfreq->last_time = cur_time;
>> -		spin_unlock(&devfreq->stats_lock);
>> +		spin_lock(&profile->stats_lock);
>> +		profile->last_time = cur_time;
>> +		spin_unlock(&profile->stats_lock);
>>  		return 0;
>>  	}
>>  
>>  	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
>>  
>> -	spin_lock(&devfreq->stats_lock);
>> +	spin_lock(&profile->stats_lock);
>>  	if (prev_lev < 0) {
>>  		ret = prev_lev;
>>  		goto out;
>>  	}
>>  
>> -	devfreq->time_in_state[prev_lev] +=
>> -			 cur_time - devfreq->last_time;
>> +	profile->time_in_state[prev_lev] +=
>> +			 cur_time - profile->last_time;
>>  	lev = devfreq_get_freq_level(devfreq, freq);
>>  	if (lev < 0) {
>>  		ret = lev;
>> @@ -187,14 +188,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  	}
>>  
>>  	if (lev != prev_lev) {
>> -		devfreq->trans_table[(prev_lev *
>> -				devfreq->profile->max_state) + lev]++;
>> -		devfreq->total_trans++;
>> +		profile->trans_table[(prev_lev *
>> +				profile->max_state) + lev]++;
>> +		profile->total_trans++;
>>  	}
>>  
>>  out:
>> -	devfreq->last_time = cur_time;
>> -	spin_unlock(&devfreq->stats_lock);
>> +	profile->last_time = cur_time;
>> +	spin_unlock(&profile->stats_lock);
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(devfreq_update_status);
>> @@ -474,23 +475,23 @@ EXPORT_SYMBOL(devfreq_monitor_suspend);
>>  void devfreq_monitor_resume(struct devfreq *devfreq)
>>  {
>>  	unsigned long freq;
>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>  
>>  	mutex_lock(&devfreq->lock);
>>  	if (!devfreq->stop_polling)
>>  		goto out;
>>  
>> -	if (!delayed_work_pending(&devfreq->work) &&
>> -			devfreq->profile->polling_ms)
>> +	if (!delayed_work_pending(&devfreq->work) && profile->polling_ms)
>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>> -			msecs_to_jiffies(devfreq->profile->polling_ms));
>> +			msecs_to_jiffies(profile->polling_ms));
>>  
>> -	spin_lock(&devfreq->stats_lock);
>> -	devfreq->last_time = get_jiffies_64();
>> -	spin_unlock(&devfreq->stats_lock);
>> +	spin_lock(&profile->stats_lock);
>> +	profile->last_time = get_jiffies_64();
>> +	spin_unlock(&profile->stats_lock);
>>  	devfreq->stop_polling = false;
>>  
>> -	if (devfreq->profile->get_cur_freq &&
>> -		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
>> +	if (profile->get_cur_freq &&
>> +	    !profile->get_cur_freq(devfreq->dev.parent, &freq))
>>  		devfreq->previous_freq = freq;
>>  
>>  out:
>> @@ -657,7 +658,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	devfreq->data = data;
>>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>>  
>> -	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>> +	if (!profile->max_state && !profile->freq_table) {
>>  		mutex_unlock(&devfreq->lock);
>>  		err = set_freq_table(devfreq);
>>  		if (err < 0)
>> @@ -693,29 +694,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_out;
>>  	}
>>  
>> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
>> -			array3_size(sizeof(unsigned int),
>> -				    devfreq->profile->max_state,
>> -				    devfreq->profile->max_state),
>> -			GFP_KERNEL);
>> -	if (!devfreq->trans_table) {
>> +	profile->trans_table = devm_kzalloc(&devfreq->dev,
>> +					    array3_size(sizeof(unsigned int),
>> +							profile->max_state,
>> +							profile->max_state),
>> +					    GFP_KERNEL);
>> +	if (!profile->trans_table) {
>>  		mutex_unlock(&devfreq->lock);
>>  		err = -ENOMEM;
>>  		goto err_devfreq;
>>  	}
>>  
>> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>> -			devfreq->profile->max_state,
>> -			sizeof(*devfreq->time_in_state),
>> -			GFP_KERNEL);
>> -	if (!devfreq->time_in_state) {
>> +	profile->time_in_state = devm_kcalloc(&devfreq->dev,
>> +					      profile->max_state,
>> +					      sizeof(*profile->time_in_state),
>> +					      GFP_KERNEL);
>> +	if (!profile->time_in_state) {
>>  		mutex_unlock(&devfreq->lock);
>>  		err = -ENOMEM;
>>  		goto err_devfreq;
>>  	}
>>  
>> -	devfreq->last_time = get_jiffies_64();
>> -	spin_lock_init(&devfreq->stats_lock);
>> +	profile->last_time = get_jiffies_64();
>> +	spin_lock_init(&profile->stats_lock);
>>  
>>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>>  
>> @@ -1402,9 +1403,10 @@ static ssize_t trans_stat_show(struct device *dev,
>>  			       struct device_attribute *attr, char *buf)
>>  {
>>  	struct devfreq *devfreq = to_devfreq(dev);
>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>  	ssize_t len;
>>  	int i, j;
>> -	unsigned int max_state = devfreq->profile->max_state;
>> +	unsigned int max_state = profile->max_state;
>>  
>>  	if (!devfreq->stop_polling &&
>>  			devfreq_update_status(devfreq, devfreq->previous_freq))
>> @@ -1415,46 +1417,45 @@ static ssize_t trans_stat_show(struct device *dev,
>>  	len = sprintf(buf, "     From  :   To\n");
>>  	len += sprintf(buf + len, "           :");
>>  
>> -	spin_lock(&devfreq->stats_lock);
>> +	spin_lock(&profile->stats_lock);
>>  	for (i = 0; i < max_state; i++)
>>  		len += sprintf(buf + len, "%10lu",
>> -				devfreq->profile->freq_table[i]);
>> +				profile->freq_table[i]);
>>  
>>  	len += sprintf(buf + len, "   time(ms)\n");
>>  
>>  	for (i = 0; i < max_state; i++) {
>> -		if (devfreq->profile->freq_table[i]
>> -					== devfreq->previous_freq) {
>> +		if (profile->freq_table[i] == devfreq->previous_freq)
>>  			len += sprintf(buf + len, "*");
>> -		} else {
>> +		else
>>  			len += sprintf(buf + len, " ");
>> -		}
>> +
>>  		len += sprintf(buf + len, "%10lu:",
>> -				devfreq->profile->freq_table[i]);
>> +				profile->freq_table[i]);
>>  		for (j = 0; j < max_state; j++)
>>  			len += sprintf(buf + len, "%10u",
>> -				devfreq->trans_table[(i * max_state) + j]);
>> +				profile->trans_table[(i * max_state) + j]);
>>  		len += sprintf(buf + len, "%10llu\n", (u64)
>> -			jiffies64_to_msecs(devfreq->time_in_state[i]));
>> +			jiffies64_to_msecs(profile->time_in_state[i]));
>>  	}
>>  
>>  	len += sprintf(buf + len, "Total transition : %u\n",
>> -					devfreq->total_trans);
>> -	spin_unlock(&devfreq->stats_lock);
>> +					profile->total_trans);
>> +	spin_unlock(&profile->stats_lock);
>>  	return len;
>>  }
>>  static DEVICE_ATTR_RO(trans_stat);
>>  
>> -static void defvreq_stats_clear_table(struct devfreq *devfreq)
>> +static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
>>  {
>> -	unsigned int count = devfreq->profile->max_state;
>> -
>> -	spin_lock(&devfreq->stats_lock);
>> -	memset(devfreq->time_in_state, 0, count * sizeof(u64));
>> -	memset(devfreq->trans_table, 0, count * count * sizeof(int));
>> -	devfreq->last_time = get_jiffies_64();
>> -	devfreq->total_trans = 0;
>> -	spin_unlock(&devfreq->stats_lock);
>> +	unsigned int count = profile->max_state;
>> +
>> +	spin_lock(&profile->stats_lock);
>> +	memset(profile->time_in_state, 0, count * sizeof(u64));
>> +	memset(profile->trans_table, 0, count * count * sizeof(int));
>> +	profile->last_time = get_jiffies_64();
>> +	profile->total_trans = 0;
>> +	spin_unlock(&profile->stats_lock);
>>  }
>>  
>>  static ssize_t trans_reset_store(struct device *dev,
>> @@ -1464,7 +1465,7 @@ static ssize_t trans_reset_store(struct device *dev,
>>  {
>>  	struct devfreq *devfreq = to_devfreq(dev);
>>  
>> -	defvreq_stats_clear_table(devfreq);
>> +	defvreq_stats_clear_table(devfreq->profile);
>>  
>>  	return count;
>>  }
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 2ddf25993f7d..4ceb2a517a9c 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -91,6 +91,12 @@ struct devfreq_dev_status {
>>   * @freq_table:		Optional list of frequencies to support statistics
>>   *			and freq_table must be generated in ascending order.
>>   * @max_state:		The size of freq_table.
>> + * @total_trans:	Number of devfreq transitions
>> + * @trans_table:	Statistics of devfreq transitions
>> + * @time_in_state:	Statistics of devfreq states
>> + * @last_time:		The last time stats were updated
>> + * @stats_lock:		Lock protecting trans_table, time_in_state,
>> + *			last_time and total_trans used for statistics
>>   */
>>  struct devfreq_dev_profile {
>>  	unsigned long initial_freq;
>> @@ -104,6 +110,12 @@ struct devfreq_dev_profile {
>>  
>>  	unsigned long *freq_table;
>>  	unsigned int max_state;
>> +	/* information for device frequency transition */
>> +	unsigned int total_trans;
>> +	unsigned int *trans_table;
>> +	u64 *time_in_state;
>> +	unsigned long long last_time;
>> +	spinlock_t stats_lock;
>>  };
>>  
>>  /**
>> @@ -131,12 +143,6 @@ struct devfreq_dev_profile {
>>   * @suspend_freq:	 frequency of a device set during suspend phase.
>>   * @resume_freq:	 frequency of a device set in resume phase.
>>   * @suspend_count:	 suspend requests counter for a device.
>> - * @total_trans:	Number of devfreq transitions
>> - * @trans_table:	Statistics of devfreq transitions
>> - * @time_in_state:	Statistics of devfreq states
>> - * @last_time:		The last time stats were updated
>> - * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
>> - *			and total_trans used for statistics
>>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>>   *
>>   * This structure stores the devfreq information for a give device.
>> @@ -173,13 +179,6 @@ struct devfreq {
>>  	unsigned long resume_freq;
>>  	atomic_t suspend_count;
>>  
>> -	/* information for device frequency transition */
>> -	unsigned int total_trans;
>> -	unsigned int *trans_table;
>> -	u64 *time_in_state;
>> -	unsigned long long last_time;
>> -	spinlock_t stats_lock;
>> -
>>  	struct srcu_notifier_head transition_notifier_list;
>>  };
>>  
>>
> 
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

