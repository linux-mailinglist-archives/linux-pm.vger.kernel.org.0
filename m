Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B706BEA3E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 03:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391278AbfIZBgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 21:36:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:35036 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391285AbfIZBgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 21:36:50 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190926013645epoutp0169e3ef8583f7e3f845724f3b2db6cb02~H2TJ0a5mL2499324993epoutp01J
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 01:36:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190926013645epoutp0169e3ef8583f7e3f845724f3b2db6cb02~H2TJ0a5mL2499324993epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569461805;
        bh=efeQkkI/GwOn5cm9oJ3Su4nNPck2YkpwAZHroXpTd3I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KCagRc+eKmmR7yAyeC1pBUFCAMvBuSLGiOyoXxHC2VcXdGt7bQj6cdJeKViWIcX28
         7s5YMkWmJZxdHLWre/exHj9zjXs7hicYgnGytdXGtJFgTHPRW+v2C3Y+ofCk9EjfYn
         jyFj06ydn3AX6mjbg+D1SngJzfq1OfyBSm86sBCg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190926013645epcas1p409eaefb8771467a762ed3b5a6095924c~H2TJOYPxI0358503585epcas1p4J;
        Thu, 26 Sep 2019 01:36:45 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 46dyFk6Fg4zMqYkp; Thu, 26 Sep
        2019 01:36:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.1F.04085.A261C8D5; Thu, 26 Sep 2019 10:36:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190926013642epcas1p4f00d60318b696b2a0b620d2397042c64~H2TGn3F_G0361403614epcas1p4I;
        Thu, 26 Sep 2019 01:36:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190926013642epsmtrp239905443517725b824ad97618c753ff8~H2TGnA01h2314423144epsmtrp2f;
        Thu, 26 Sep 2019 01:36:42 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-93-5d8c162a1cb3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.32.04081.A261C8D5; Thu, 26 Sep 2019 10:36:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926013642epsmtip23e9a1454076c6399bad328eb920bbbac~H2TGTvBG91316713167epsmtip24;
        Thu, 26 Sep 2019 01:36:42 +0000 (GMT)
Subject: Re: [PATCH 2/2] devfreq: Rename df->previous_freq to df->cur_freq
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6299e64b-086e-ddec-c485-8eb2241dcbe4@samsung.com>
Date:   Thu, 26 Sep 2019 10:41:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925184314.30251-2-mka@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmnq6WWE+sQdshY4uzyw6yWbTMWsRi
        cbbpDbvF5V1z2Cw+9x5htOj8MovN4tKBBUwWnzc8ZrS43biCzWJfxwMmi5+75rE4cHvMbrjI
        4rFz1l12j5Z9t9g9epvfsXm833eVzaNvyypGj8+b5ALYo7JtMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZ3y++Im54LZfRfOqJ+wNjMccuhg5
        OSQETCR+n2tj7WLk4hAS2MEo8ejrBUYI5xOjxN2JV9ggnG+MElNPH2WEaTn4/SILRGIvo8S9
        361Q/e8ZJQ4em88CUiUs4CXxvPMbWEJEYC6TRM+9qewgDrNAM6PEpdVzmUCq2AS0JPa/uMEG
        YvMLKEpc/fEYbAevgJ3Ej893mEFsFgFViZavLWD1ogIREp8eHGaFqBGUODnzCdg2TgEziWdt
        u8DqmQXEJW49mc8EYctLNG+dzQyyWEJgHrtE67V3QAs4gBwXibUNjhD/CEu8Or6FHcKWkvj8
        bi8bhF0tsfLkETaI3g5GiS37L7BCJIwl9i+dzAQyh1lAU2L9Ln2IsKLEzt9zGSH28km8+9rD
        CrGKV6KjTQiiRFni8oO7TBC2pMTi9k62CYxKs5B8MwvJB7OQfDALYdkCRpZVjGKpBcW56anF
        hgXGyPG9iRGchLXMdzBuOOdziFGAg1GJh1cisjtWiDWxrLgy9xCjBAezkgjvLJmuWCHelMTK
        qtSi/Pii0pzU4kOMpsDAnsgsJZqcD8wQeSXxhqZGxsbGFiaGZqaGhkrivB7pDbFCAumJJanZ
        qakFqUUwfUwcnFINjNOX3J39+NM9q4fZi6Sul+6fIbl67t/ZV828F3Pq3urw+vp+deHNeVWe
        Kya4MilmvPnxVeCuYs+Diz8eptbw2VyT0Fh5XIyzX/7Pl5OFFfEymn+0IzL/fVL/Ev6A5byz
        24Wpj064rlp02HvO7KYDCV82G35+92qvsUTmXU/OsgsJFUHOB5eoObEosRRnJBpqMRcVJwIA
        NF0ZedgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSvK6WWE+sQfcWMYuzyw6yWbTMWsRi
        cbbpDbvF5V1z2Cw+9x5htOj8MovN4tKBBUwWnzc8ZrS43biCzWJfxwMmi5+75rE4cHvMbrjI
        4rFz1l12j5Z9t9g9epvfsXm833eVzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyPl/8xFxw
        26+iedUT9gbGYw5djJwcEgImEge/X2TpYuTiEBLYzSjxp3svI0RCUmLaxaPMXYwcQLawxOHD
        xRA1bxklOu4vYAWpERbwknje+Y0VJCEiMJ9J4tK6R2AOs0Azo8SSvv9QY7cySuyYuAdsLJuA
        lsT+FzfYQGx+AUWJqz8eg8V5Bewkfny+wwxiswioSrR8bWECsUUFIiQO75gFVSMocXLmExYQ
        m1PATOJZ2y6wemYBdYk/8y5B2eISt57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUV
        o2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwPGpp7mC8vCT+EKMAB6MSD++BsO5YIdbE
        suLK3EOMEhzMSiK8s2S6YoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQ
        WgSTZeLglGpgXL2n7AbzBIlMV8tcjluL30cn+51O2NVesk21KO/X/NBjN29rvldZJSP0e37Q
        7AmbDfdsy7edXH90k8NJC+2l80U7Wa9dZb1cd2Gu4sPuSreMHK2yixW1HAuT8p8xndZdcCRr
        I+8dhfvT3/n13f75SL8je2fWApmVjyW00yP80zYz9ijvP5HFo8RSnJFoqMVcVJwIAOfiA/TD
        AgAA
X-CMS-MailID: 20190926013642epcas1p4f00d60318b696b2a0b620d2397042c64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190925184504epcas2p30c0b7d775ddaa8132a098d3d0b53f76c
References: <20190925184314.30251-1-mka@chromium.org>
        <CGME20190925184504epcas2p30c0b7d775ddaa8132a098d3d0b53f76c@epcas2p3.samsung.com>
        <20190925184314.30251-2-mka@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I'm not objecting this patch.
But, as I commented on previous patch,
Actually, according to reference time of the 'df->previous_freq',
'previous_freq' is proper or 'cur_freq is proper.
But, In the comment of 'struct devfreq', it means the configured time
as following: It was the intention of author (Myungjoo).
	* @previous_freq:      previously configured frequency value.

I think that it's not problem ans better to keep the name if possible.

I leave the final decision of this patch to Myungjoo.
If he like this patch, I have no any objection.

On 19. 9. 26. 오전 3:43, Matthias Kaehlcke wrote:
> The vast majority of code uses df->previous_freq to get the current
> frequency of the devfreq device, not the previous one. Rename the
> struct field to reflect this.
> 
> Add a comment to devfreq_update_stats() to make clear that df->cur_freq
> must only be updated after calling this function in the context of a
> frequency transition.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c            | 28 ++++++++++++++++------------
>  drivers/devfreq/governor_passive.c   |  6 +++---
>  drivers/devfreq/governor_userspace.c |  2 +-
>  drivers/devfreq/tegra20-devfreq.c    |  2 +-
>  drivers/devfreq/tegra30-devfreq.c    |  2 +-
>  include/linux/devfreq.h              |  4 ++--
>  include/trace/events/devfreq.h       |  2 +-
>  7 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fb4318d59aa9..bf42130bb4ec 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -154,6 +154,10 @@ static int set_freq_table(struct devfreq *devfreq)
>   * devfreq_update_stats() - Update statistics of devfreq behavior
>   * @devfreq:	the devfreq instance
>   * @freq:	the update target frequency
> + *
> + * If the function is called in the context of a frequency transition
> + * it expects df->cur_freq to contain the value *before* the transition.
> + * The field must only be updated after calling devfreq_update_stats().
>   */
>  int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
>  {
> @@ -162,11 +166,11 @@ int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
>  
>  	cur_time = jiffies;
>  
> -	/* Immediately exit if previous_freq is not initialized yet. */
> -	if (!devfreq->previous_freq)
> +	/* Immediately exit if cur_freq is not initialized yet. */
> +	if (!devfreq->cur_freq)
>  		goto out;
>  
> -	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
> +	prev_lev = devfreq_get_freq_level(devfreq, devfreq->cur_freq);
>  	if (prev_lev < 0) {
>  		ret = prev_lev;
>  		goto out;
> @@ -295,7 +299,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  	if (devfreq->profile->get_cur_freq)
>  		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>  	else
> -		cur_freq = devfreq->previous_freq;
> +		cur_freq = devfreq->cur_freq;
>  
>  	freqs.old = cur_freq;
>  	freqs.new = new_freq;
> @@ -315,7 +319,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  		dev_err(&devfreq->dev,
>  			"Couldn't update frequency transition information.\n");
>  
> -	devfreq->previous_freq = new_freq;
> +	devfreq->cur_freq = new_freq;
>  
>  	if (devfreq->suspend_freq)
>  		devfreq->resume_freq = cur_freq;
> @@ -450,7 +454,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
>  		return;
>  	}
>  
> -	devfreq_update_stats(devfreq, devfreq->previous_freq);
> +	devfreq_update_stats(devfreq, devfreq->cur_freq);
>  	devfreq->stop_polling = true;
>  	mutex_unlock(&devfreq->lock);
>  	cancel_delayed_work_sync(&devfreq->work);
> @@ -483,7 +487,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  
>  	if (devfreq->profile->get_cur_freq &&
>  		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
> -		devfreq->previous_freq = freq;
> +		devfreq->cur_freq = freq;
>  
>  out:
>  	mutex_unlock(&devfreq->lock);
> @@ -644,7 +648,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->dev.release = devfreq_dev_release;
>  	devfreq->profile = profile;
>  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
> -	devfreq->previous_freq = profile->initial_freq;
> +	devfreq->cur_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
> @@ -1235,14 +1239,14 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
>  		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
>  		return sprintf(buf, "%lu\n", freq);
>  
> -	return sprintf(buf, "%lu\n", devfreq->previous_freq);
> +	return sprintf(buf, "%lu\n", devfreq->cur_freq);
>  }
>  static DEVICE_ATTR_RO(cur_freq);
>  
>  static ssize_t target_freq_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
> +	return sprintf(buf, "%lu\n", to_devfreq(dev)->cur_freq);
>  }
>  static DEVICE_ATTR_RO(target_freq);
>  
> @@ -1398,7 +1402,7 @@ static ssize_t trans_stat_show(struct device *dev,
>  	unsigned int max_state = devfreq->profile->max_state;
>  
>  	if (!devfreq->stop_polling &&
> -			devfreq_update_stats(devfreq, devfreq->previous_freq))
> +			devfreq_update_stats(devfreq, devfreq->cur_freq))
>  		return 0;
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
> @@ -1413,7 +1417,7 @@ static ssize_t trans_stat_show(struct device *dev,
>  
>  	for (i = 0; i < max_state; i++) {
>  		if (devfreq->profile->freq_table[i]
> -					== devfreq->previous_freq) {
> +					== devfreq->cur_freq) {
>  			len += sprintf(buf + len, "*");
>  		} else {
>  			len += sprintf(buf + len, " ");
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 1c746b96d3db..2d818eaceb39 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -114,7 +114,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>  		dev_err(&devfreq->dev,
>  			"Couldn't update frequency transition information.\n");
>  
> -	devfreq->previous_freq = freq;
> +	devfreq->cur_freq = freq;
>  
>  out:
>  	mutex_unlock(&devfreq->lock);
> @@ -134,11 +134,11 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
>  
>  	switch (event) {
>  	case DEVFREQ_PRECHANGE:
> -		if (parent->previous_freq > freq)
> +		if (parent->cur_freq > freq)
>  			update_devfreq_passive(devfreq, freq);
>  		break;
>  	case DEVFREQ_POSTCHANGE:
> -		if (parent->previous_freq < freq)
> +		if (parent->cur_freq < freq)
>  			update_devfreq_passive(devfreq, freq);
>  		break;
>  	}
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index af94942fcf95..566b8d1f0c17 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -26,7 +26,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>  	if (data->valid)
>  		*freq = data->user_frequency;
>  	else
> -		*freq = df->previous_freq; /* No user freq specified yet */
> +		*freq = df->cur_freq; /* No user freq specified yet */
>  
>  	return 0;
>  }
> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
> index ff82bac9ee4e..f99bd6557df5 100644
> --- a/drivers/devfreq/tegra20-devfreq.c
> +++ b/drivers/devfreq/tegra20-devfreq.c
> @@ -61,7 +61,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	return 0;
>  
>  restore_min_rate:
> -	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> +	clk_set_min_rate(tegra->emc_clock, devfreq->cur_freq);
>  
>  	return err;
>  }
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 536273a811fe..7b3bf7a0b15f 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -474,7 +474,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	return 0;
>  
>  restore_min_rate:
> -	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> +	clk_set_min_rate(tegra->emc_clock, devfreq->cur_freq);
>  
>  	return err;
>  }
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2bae9ed3c783..21d0108df4c5 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -120,7 +120,7 @@ struct devfreq_dev_profile {
>   *		reevaluate operable frequencies. Devfreq users may use
>   *		devfreq.nb to the corresponding register notifier call chain.
>   * @work:	delayed work for load monitoring.
> - * @previous_freq:	previously configured frequency value.
> + * @cur_freq:	the current frequency.
>   * @data:	Private data of the governor. The devfreq framework does not
>   *		touch this.
>   * @min_freq:	Limit minimum frequency requested by user (0: none)
> @@ -156,7 +156,7 @@ struct devfreq {
>  	struct notifier_block nb;
>  	struct delayed_work work;
>  
> -	unsigned long previous_freq;
> +	unsigned long cur_freq;
>  	struct devfreq_dev_status last_status;
>  
>  	void *data; /* private data for governors */
> diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
> index cf5b8772175d..916cfaed5489 100644
> --- a/include/trace/events/devfreq.h
> +++ b/include/trace/events/devfreq.h
> @@ -22,7 +22,7 @@ TRACE_EVENT(devfreq_monitor,
>  	),
>  
>  	TP_fast_assign(
> -		__entry->freq = devfreq->previous_freq;
> +		__entry->freq = devfreq->cur_freq;
>  		__entry->busy_time = devfreq->last_status.busy_time;
>  		__entry->total_time = devfreq->last_status.total_time;
>  		__entry->polling_ms = devfreq->profile->polling_ms;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
