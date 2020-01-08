Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010A5133A9C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 05:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgAHE4i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 23:56:38 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:36176 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgAHE4i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 23:56:38 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200108045633epoutp01fd8352c26c8f30005e94c1b163577c1e~n0HR19D6D1550815508epoutp01B
        for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2020 04:56:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200108045633epoutp01fd8352c26c8f30005e94c1b163577c1e~n0HR19D6D1550815508epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578459393;
        bh=ft0HpmCaDygXIvSjGBbn+OSjmgZCgue6VVZAms6WWlk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bURP+2/QXtz13EQG56ZSFyH810buNUamg8qlIinNtj0nWeaeZPaLa+RBbnUUKkqO0
         cT0isk/jnZBLS53woRPTgJXJhhGeQenMmk6BBfhifYrgegJISst0xQnVNXXS+kfIWz
         aiBjFvCcTs8pnvL+I5o1O0an5AOKQhXkWYBR3QbU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200108045632epcas1p37dccf9e0f2a0cd6c4b39edd2935f92bb~n0HRjvOAk2567025670epcas1p3V;
        Wed,  8 Jan 2020 04:56:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47sxmF2lmmzMqYlx; Wed,  8 Jan
        2020 04:56:29 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.ED.48019.CF0651E5; Wed,  8 Jan 2020 13:56:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200108045628epcas1p3514f1ac5508696046868e017448ecdbc~n0HNelthi1400414004epcas1p3g;
        Wed,  8 Jan 2020 04:56:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200108045628epsmtrp2b5a21d743d2156ff2292527db27ac94d~n0HNd_9Ni0573205732epsmtrp2i;
        Wed,  8 Jan 2020 04:56:28 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-bd-5e1560fcfa61
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.27.10238.CF0651E5; Wed,  8 Jan 2020 13:56:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200108045628epsmtip1775c44829de3257b8340a809b1bee070~n0HNUFW1s0515705157epsmtip1H;
        Wed,  8 Jan 2020 04:56:28 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Add missing function description and
 rename static functions
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <de7b3c55-a058-c8e8-4ebd-b2bb8dacf161@samsung.com>
Date:   Wed, 8 Jan 2020 14:03:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200107013523.27177-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTV/dPgmicwaEOfYuJN66wWJxtesNu
        cXnXHDaLz71HGC1uN65gc2D12LSqk82jb8sqRo/Pm+QCmKOybTJSE1NSixRS85LzUzLz0m2V
        vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAVioplCXmlAKFAhKLi5X07WyK8ktLUhUy
        8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjN+9p1hL2gOqnh25SVTA+Nnxy5G
        Tg4JAROJTb2nWLsYuTiEBHYwSnyY8BPK+cQoMXnzUjYI5xujxMx7u4EyHGAth/7FQ8T3Mkqc
        eHUaqug9o8S8jq3MIEXCAokSPx/ygKwQEbCSOP2/gxnEZhbwllj8djUjiM0moCWx/8UNNhCb
        X0BR4uqPx4wgrbwCdhKXzymChFkEVCR27TvKAmKLCoRJnNzWAtbKKyAocXLmE7A4p4C1RMvc
        bWwQ48Ulbj2ZzwRhy0tsfzuHGeQ0CYHLbBJ9X7YzQrzsAjT/MCuELSzx6vgWdghbSuLzu71s
        EHa1xMqTR9ggmjsYJbbsvwDVYCyxf+lkJpBDmQU0Jdbv0ocIK0rs/D2XEWIxn8S7rz3QsOKV
        6GgTgihRlrj84C4ThC0psbi9k20Co9IsJO/MQvLCLCQvzEJYtoCRZRWjWGpBcW56arFhgQly
        XG9iBCdGLYsdjHvO+RxiFOBgVOLh/bFYJE6INbGsuDL3EKMEB7OSCK+WDlCINyWxsiq1KD++
        qDQntfgQoykwtCcyS4km5wOTdl5JvKGpkbGxsYWJoZmpoaGSOC/Hj4uxQgLpiSWp2ampBalF
        MH1MHJxSDYzzzMTEauRZaqZObi5Vj+DQNPOa+89w4wWRyxG+Wk13qkK32h/zK/ix5Kq/wZfV
        21qeqJkftnJweC7UX3/2r17J6XeXDPzc8gU90nuuRLjohByfc13ylkFZt1uLz5Kd634cE4gq
        92f9ULrxsYdqyTZ+x5Q3ejLlir6buTlFJ5oknPpeFm51TImlOCPRUIu5qDgRAAgG9jqiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnO6fBNE4g/7bghYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFrcblzB5sDqsWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZfzsO8Ne
        0BxU8ezKS6YGxs+OXYwcHBICJhKH/sV3MXJxCAnsZpQ43LmDpYuREyguKTHt4lFmiBphicOH
        iyFq3jJKfP70lR2kRlggUaLj1ylWEFtEwEri9P8OZhCbWcBbYvHb1YwQDX2MEieuzQAbyiag
        JbH/xQ02EJtfQFHi6o/HjCALeAXsJC6fUwQJswioSOzadxSsXFQgTGLnksdMIDavgKDEyZlP
        wOKcAtYSLXO3sUHsUpf4M+8S1F5xiVtP5jNB2PIS29/OYZ7AKDwLSfssJC2zkLTMQtKygJFl
        FaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcIxoae5gvLwk/hCjAAejEg/vj8UicUKs
        iWXFlbmHGCU4mJVEeLV0gEK8KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1I
        LYLJMnFwSjUwljo/1nwa0dth/JdBIH1d5Rzj/Z4cp1jtpkTbsjv4aupPmrnpiXk578p1STtD
        DQ6cnBNsPC1EzdX4s8HlrB3XuKZb+BzJzro2b030zmO6d5ncHaW5J8Wfnbz6bDTHbSG/qldP
        qv74/Pw75eYPS6MzU2W6nZ79+f70fWof+6sWzXvnNz35ILPnvhJLcUaioRZzUXEiAEE5TC2N
        AgAA
X-CMS-MailID: 20200108045628epcas1p3514f1ac5508696046868e017448ecdbc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107012826epcas1p17480af9ce779b3c17f6a815cc78ed25b
References: <CGME20200107012826epcas1p17480af9ce779b3c17f6a815cc78ed25b@epcas1p1.samsung.com>
        <20200107013523.27177-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/7/20 10:35 AM, Chanwoo Choi wrote:
> Rename internal function name used by devfreq core without 'devfreq_'
> prefix in order to separate them from the exported functions.
> And add missing function description for improving the readability.
> 
> Lastly, add the comments of devfreq_add_device to increase
> the understanding of behavior of devfreq_add_device.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 81 +++++++++++++++++++++++++++++++--------
>  1 file changed, 64 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index acd21345a070..254f11b31824 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -48,7 +48,7 @@ static LIST_HEAD(devfreq_list);
>  static DEFINE_MUTEX(devfreq_list_lock);
>  
>  /**
> - * find_device_devfreq() - find devfreq struct using device pointer
> + * find_device_devfreq() - Find devfreq struct using device pointer
>   * @dev:	device pointer used to lookup device devfreq.
>   *
>   * Search the list of device devfreqs and return the matched device's
> @@ -73,6 +73,13 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +/**
> + * find_available_min_freq() - Find available min frequency via OPP interface
> + * @devfreq:	the devfreq instance
> + *
> + * Find available minimum frequency among the active OPP entries
> + * because could either enable or disable the frequency by using OPP interface.
> + */
>  static unsigned long find_available_min_freq(struct devfreq *devfreq)
>  {
>  	struct dev_pm_opp *opp;
> @@ -87,6 +94,13 @@ static unsigned long find_available_min_freq(struct devfreq *devfreq)
>  	return min_freq;
>  }
>  
> +/**
> + * find_available_max_freq() - Find available max frequency via OPP interface
> + * @devfreq:	the devfreq instance
> + *
> + * Find available maximum frequency among the active OPP entries
> + * because could either enable or disable the frequency by using OPP interface.
> + */
>  static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  {
>  	struct dev_pm_opp *opp;
> @@ -150,11 +164,11 @@ static void get_freq_range(struct devfreq *devfreq,
>  }
>  
>  /**
> - * devfreq_get_freq_level() - Lookup freq_table for the frequency
> + * get_freq_level() - Lookup freq_table for the frequency
>   * @devfreq:	the devfreq instance
>   * @freq:	the target frequency
>   */
> -static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
> +static int get_freq_level(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int lev;
>  
> @@ -165,6 +179,13 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>  	return -EINVAL;
>  }
>  
> +/**
> + * set_freq_table() - Fill out the freq_table of devfreq instance
> + * @devfreq:	the devfreq instance
> + *
> + * If freq_table array is NULL, fill out the freq_table array
> + * by using OPP interface because OPP is mandatory.
> + */
>  static int set_freq_table(struct devfreq *devfreq)
>  {
>  	struct devfreq_dev_profile *profile = devfreq->profile;
> @@ -218,7 +239,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	if (!devfreq->previous_freq)
>  		goto out;
>  
> -	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
> +	prev_lev = get_freq_level(devfreq, devfreq->previous_freq);
>  	if (prev_lev < 0) {
>  		ret = prev_lev;
>  		goto out;
> @@ -227,7 +248,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	devfreq->stats.time_in_state[prev_lev] +=
>  			cur_time - devfreq->stats.last_update;
>  
> -	lev = devfreq_get_freq_level(devfreq, freq);
> +	lev = get_freq_level(devfreq, freq);
>  	if (lev < 0) {
>  		ret = lev;
>  		goto out;
> @@ -246,7 +267,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  EXPORT_SYMBOL(devfreq_update_status);
>  
>  /**
> - * find_devfreq_governor() - find devfreq governor from name
> + * find_devfreq_governor() - Find devfreq governor from name
>   * @name:	name of the governor
>   *
>   * Search the list of devfreq governors and return the matched
> @@ -314,8 +335,17 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  	return governor;
>  }
>  
> -static int devfreq_notify_transition(struct devfreq *devfreq,
> -		struct devfreq_freqs *freqs, unsigned int state)
> +/**
> + * notify_transition() - Send the transition notification
> + * @name:	name of the governor
> + * @freqs:	the data containing the both old and new frequency
> + * @state:	the kind of notification
> + *
> + * Send the transition notification to the registered receivers
> + * in order to inform the frequency change.
> + */
> +static int notify_transition(struct devfreq *devfreq,
> +			struct devfreq_freqs *freqs, unsigned int state)
>  {
>  	if (!devfreq)
>  		return -EINVAL;
> @@ -337,8 +367,17 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>  	return 0;
>  }
>  
> -static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> -			      u32 flags)
> +/**
> + * set_target() - Set target frequency of devfreq instance
> + * @devfreq:	the devfreq instance
> + * @new_freq:	the target frequency
> + * @flags:	flags handed from devfreq framework
> + *
> + * Set the target frequency of which is decided by governor
> + * and then is adjusted with constraints.
> + */
> +static int set_target(struct devfreq *devfreq,
> +			unsigned long new_freq, u32 flags)
>  {
>  	struct devfreq_freqs freqs;
>  	unsigned long cur_freq;
> @@ -351,17 +390,17 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  
>  	freqs.old = cur_freq;
>  	freqs.new = new_freq;
> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> +	notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>  
>  	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
>  	if (err) {
>  		freqs.new = cur_freq;
> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> +		notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>  		return err;
>  	}
>  
>  	freqs.new = new_freq;
> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> +	notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>  
>  	if (devfreq_update_status(devfreq, new_freq))
>  		dev_err(&devfreq->dev,
> @@ -413,7 +452,7 @@ int update_devfreq(struct devfreq *devfreq)
>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>  	}
>  
> -	return devfreq_set_target(devfreq, freq, flags);
> +	return set_target(devfreq, freq, flags);
>  
>  }
>  EXPORT_SYMBOL(update_devfreq);
> @@ -421,7 +460,6 @@ EXPORT_SYMBOL(update_devfreq);
>  /**
>   * devfreq_monitor() - Periodically poll devfreq objects.
>   * @work:	the work struct used to run devfreq_monitor periodically.
> - *
>   */
>  static void devfreq_monitor(struct work_struct *work)
>  {
> @@ -739,11 +777,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	static atomic_t devfreq_no = ATOMIC_INIT(-1);
>  	int err = 0;
>  
> +	/* Check the parameter is valid */
>  	if (!dev || !profile || !governor_name) {
>  		dev_err(dev, "%s: Invalid parameters.\n", __func__);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	/* Check the device is already added or not */
>  	mutex_lock(&devfreq_list_lock);
>  	devfreq = find_device_devfreq(dev);
>  	mutex_unlock(&devfreq_list_lock);
> @@ -754,6 +794,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> +	/* Initialize the devfreq instance */
>  	devfreq = kzalloc(sizeof(struct devfreq), GFP_KERNEL);
>  	if (!devfreq) {
>  		err = -ENOMEM;
> @@ -798,6 +839,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
> +	/* Register a device for devfreq instance */
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);
> @@ -807,6 +849,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> +	/* Initialize the statistics of devfreq device behavior */
>  	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
>  			array3_size(sizeof(unsigned int),
>  				    devfreq->profile->max_state,
> @@ -831,10 +874,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->stats.total_trans = 0;
>  	devfreq->stats.last_update = get_jiffies_64();
>  
> +	/* Initialize notifiers for informing the transition of devfreq */
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
>  	mutex_unlock(&devfreq->lock);
>  
> +	/* Initialize PM QoS for applying the constraints */
>  	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
>  				     DEV_PM_QOS_MIN_FREQUENCY, 0);
>  	if (err < 0)
> @@ -859,6 +904,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	mutex_lock(&devfreq_list_lock);
>  
> +	/* Find the devfreq governor and start */
>  	governor = try_then_request_governor(devfreq->governor_name);
>  	if (IS_ERR(governor)) {
>  		dev_err(dev, "%s: Unable to find governor for the device\n",
> @@ -876,6 +922,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_init;
>  	}
>  
> +	/* Add the devfreq instance to global devfreq list finally */
>  	list_add(&devfreq->node, &devfreq_list);
>  
>  	mutex_unlock(&devfreq_list_lock);
> @@ -1076,7 +1123,7 @@ int devfreq_suspend_device(struct devfreq *devfreq)
>  
>  	if (devfreq->suspend_freq) {
>  		mutex_lock(&devfreq->lock);
> -		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
> +		ret = set_target(devfreq, devfreq->suspend_freq, 0);
>  		mutex_unlock(&devfreq->lock);
>  		if (ret)
>  			return ret;
> @@ -1106,7 +1153,7 @@ int devfreq_resume_device(struct devfreq *devfreq)
>  
>  	if (devfreq->resume_freq) {
>  		mutex_lock(&devfreq->lock);
> -		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
> +		ret = set_target(devfreq, devfreq->resume_freq, 0);
>  		mutex_unlock(&devfreq->lock);
>  		if (ret)
>  			return ret;
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
