Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D708BF7A4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfIZRfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 13:35:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45433 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfIZRfr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 13:35:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so1903299pgi.12
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M1z/PSbfMPHxY20cj2o02/blUYNffOk/J+PY57fO1pg=;
        b=ODT9B3Ji911newY0Bk4O9Fv9gX21qeAsPjVWStvDebI5v3qDix852xVOp9jb/yFj/J
         LxjbEVSzNeVOmuik3L9kBKp53/5oaVx5AEdQjINkYFQ32cRRVfTw8hKZmLGNIq18VfhE
         tgEjrndV1ZCk16tBf3+a9oR//TeWyhoRXJYGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M1z/PSbfMPHxY20cj2o02/blUYNffOk/J+PY57fO1pg=;
        b=ErPjeplYCETIQd8FZGxWnDWB9lCb+mqwL8zxGJR789Zzu0gERqVPB2ORyvjEH2O1kw
         xf+9oTM0IuOnS8u6nkulpmsRaVTBX1bi1lMLTKlhYuN2ZhCCatG3xLu3q4tOUG2MC0ET
         IsVPbmGTpESwqTRoIBoL4c5Y0pIKpOrax6Dl+XicdXmQpK4Vzq1aOO0TMymIPdtY1F33
         aq/rL/jBD9ktfipnLNKMlSV2CvHBknNaIBk2vZlyUAOEK229TrAdu83UxILGV2HNvxZh
         3DqDadJZe5r8CyXFvtA5/FXNNrKSz4dRp+JnsXF9dxgQBzPRpDsJBkg6HKhLFK2RfyOz
         mX9g==
X-Gm-Message-State: APjAAAUWl/ZY8ZHvl0wgems4G6iv9/H2cjfH++CQL41J4AZPrBq8ehm4
        qoCQbTp9hnaow4h34ZDJqGn7uA==
X-Google-Smtp-Source: APXvYqwrdqc7i35wjqExhmY6L1RMG9o2IADw+US9AdRF6M9+fOPVeZcAA6uRexxxO5jAVChhdTcosA==
X-Received: by 2002:a17:90a:8042:: with SMTP id e2mr4837928pjw.10.1569519346642;
        Thu, 26 Sep 2019 10:35:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b11sm2422475pgr.20.2019.09.26.10.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:35:45 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:35:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] devfreq: Rename df->previous_freq to df->cur_freq
Message-ID: <20190926173544.GS133864@google.com>
References: <20190925184314.30251-1-mka@chromium.org>
 <CGME20190925184504epcas2p30c0b7d775ddaa8132a098d3d0b53f76c@epcas2p3.samsung.com>
 <20190925184314.30251-2-mka@chromium.org>
 <6299e64b-086e-ddec-c485-8eb2241dcbe4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6299e64b-086e-ddec-c485-8eb2241dcbe4@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 26, 2019 at 10:41:24AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> I'm not objecting this patch.
> But, as I commented on previous patch,
> Actually, according to reference time of the 'df->previous_freq',
> 'previous_freq' is proper or 'cur_freq is proper.
> But, In the comment of 'struct devfreq', it means the configured time
> as following: It was the intention of author (Myungjoo).
> 	* @previous_freq:      previously configured frequency value.

The name made perfect sense in the context of the original commit
a3c98b8b2ede ("PM: Introduce devfreq: generic DVFS framework with
device-specific OPPs"), where the field was indeed only used to
store the previous frequency. However the devfreq sub-system has
evolved in the past 8 years, and nowadays the use is different.

> I think that it's not problem ans better to keep the name if possible.

IMO it's a strong signal that over 85% of the users of the variable
use it in a way that doesn't match it's name, i.e. you read the code
and wonder 'why is it using the previous frequency here???'. Code
should be as self explanatory as possible, misleading variable
don't help with that.

> I leave the final decision of this patch to Myungjoo.
> If he like this patch, I have no any objection.

Myungjoo, what do you think about the patch?

> On 19. 9. 26. 오전 3:43, Matthias Kaehlcke wrote:
> > The vast majority of code uses df->previous_freq to get the current
> > frequency of the devfreq device, not the previous one. Rename the
> > struct field to reflect this.
> > 
> > Add a comment to devfreq_update_stats() to make clear that df->cur_freq
> > must only be updated after calling this function in the context of a
> > frequency transition.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/devfreq/devfreq.c            | 28 ++++++++++++++++------------
> >  drivers/devfreq/governor_passive.c   |  6 +++---
> >  drivers/devfreq/governor_userspace.c |  2 +-
> >  drivers/devfreq/tegra20-devfreq.c    |  2 +-
> >  drivers/devfreq/tegra30-devfreq.c    |  2 +-
> >  include/linux/devfreq.h              |  4 ++--
> >  include/trace/events/devfreq.h       |  2 +-
> >  7 files changed, 25 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index fb4318d59aa9..bf42130bb4ec 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -154,6 +154,10 @@ static int set_freq_table(struct devfreq *devfreq)
> >   * devfreq_update_stats() - Update statistics of devfreq behavior
> >   * @devfreq:	the devfreq instance
> >   * @freq:	the update target frequency
> > + *
> > + * If the function is called in the context of a frequency transition
> > + * it expects df->cur_freq to contain the value *before* the transition.
> > + * The field must only be updated after calling devfreq_update_stats().
> >   */
> >  int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
> >  {
> > @@ -162,11 +166,11 @@ int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
> >  
> >  	cur_time = jiffies;
> >  
> > -	/* Immediately exit if previous_freq is not initialized yet. */
> > -	if (!devfreq->previous_freq)
> > +	/* Immediately exit if cur_freq is not initialized yet. */
> > +	if (!devfreq->cur_freq)
> >  		goto out;
> >  
> > -	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
> > +	prev_lev = devfreq_get_freq_level(devfreq, devfreq->cur_freq);
> >  	if (prev_lev < 0) {
> >  		ret = prev_lev;
> >  		goto out;
> > @@ -295,7 +299,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> >  	if (devfreq->profile->get_cur_freq)
> >  		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
> >  	else
> > -		cur_freq = devfreq->previous_freq;
> > +		cur_freq = devfreq->cur_freq;
> >  
> >  	freqs.old = cur_freq;
> >  	freqs.new = new_freq;
> > @@ -315,7 +319,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> >  		dev_err(&devfreq->dev,
> >  			"Couldn't update frequency transition information.\n");
> >  
> > -	devfreq->previous_freq = new_freq;
> > +	devfreq->cur_freq = new_freq;
> >  
> >  	if (devfreq->suspend_freq)
> >  		devfreq->resume_freq = cur_freq;
> > @@ -450,7 +454,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
> >  		return;
> >  	}
> >  
> > -	devfreq_update_stats(devfreq, devfreq->previous_freq);
> > +	devfreq_update_stats(devfreq, devfreq->cur_freq);
> >  	devfreq->stop_polling = true;
> >  	mutex_unlock(&devfreq->lock);
> >  	cancel_delayed_work_sync(&devfreq->work);
> > @@ -483,7 +487,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
> >  
> >  	if (devfreq->profile->get_cur_freq &&
> >  		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
> > -		devfreq->previous_freq = freq;
> > +		devfreq->cur_freq = freq;
> >  
> >  out:
> >  	mutex_unlock(&devfreq->lock);
> > @@ -644,7 +648,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  	devfreq->dev.release = devfreq_dev_release;
> >  	devfreq->profile = profile;
> >  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
> > -	devfreq->previous_freq = profile->initial_freq;
> > +	devfreq->cur_freq = profile->initial_freq;
> >  	devfreq->last_status.current_frequency = profile->initial_freq;
> >  	devfreq->data = data;
> >  	devfreq->nb.notifier_call = devfreq_notifier_call;
> > @@ -1235,14 +1239,14 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
> >  		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
> >  		return sprintf(buf, "%lu\n", freq);
> >  
> > -	return sprintf(buf, "%lu\n", devfreq->previous_freq);
> > +	return sprintf(buf, "%lu\n", devfreq->cur_freq);
> >  }
> >  static DEVICE_ATTR_RO(cur_freq);
> >  
> >  static ssize_t target_freq_show(struct device *dev,
> >  				struct device_attribute *attr, char *buf)
> >  {
> > -	return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
> > +	return sprintf(buf, "%lu\n", to_devfreq(dev)->cur_freq);
> >  }
> >  static DEVICE_ATTR_RO(target_freq);
> >  
> > @@ -1398,7 +1402,7 @@ static ssize_t trans_stat_show(struct device *dev,
> >  	unsigned int max_state = devfreq->profile->max_state;
> >  
> >  	if (!devfreq->stop_polling &&
> > -			devfreq_update_stats(devfreq, devfreq->previous_freq))
> > +			devfreq_update_stats(devfreq, devfreq->cur_freq))
> >  		return 0;
> >  	if (max_state == 0)
> >  		return sprintf(buf, "Not Supported.\n");
> > @@ -1413,7 +1417,7 @@ static ssize_t trans_stat_show(struct device *dev,
> >  
> >  	for (i = 0; i < max_state; i++) {
> >  		if (devfreq->profile->freq_table[i]
> > -					== devfreq->previous_freq) {
> > +					== devfreq->cur_freq) {
> >  			len += sprintf(buf + len, "*");
> >  		} else {
> >  			len += sprintf(buf + len, " ");
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index 1c746b96d3db..2d818eaceb39 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -114,7 +114,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
> >  		dev_err(&devfreq->dev,
> >  			"Couldn't update frequency transition information.\n");
> >  
> > -	devfreq->previous_freq = freq;
> > +	devfreq->cur_freq = freq;
> >  
> >  out:
> >  	mutex_unlock(&devfreq->lock);
> > @@ -134,11 +134,11 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
> >  
> >  	switch (event) {
> >  	case DEVFREQ_PRECHANGE:
> > -		if (parent->previous_freq > freq)
> > +		if (parent->cur_freq > freq)
> >  			update_devfreq_passive(devfreq, freq);
> >  		break;
> >  	case DEVFREQ_POSTCHANGE:
> > -		if (parent->previous_freq < freq)
> > +		if (parent->cur_freq < freq)
> >  			update_devfreq_passive(devfreq, freq);
> >  		break;
> >  	}
> > diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> > index af94942fcf95..566b8d1f0c17 100644
> > --- a/drivers/devfreq/governor_userspace.c
> > +++ b/drivers/devfreq/governor_userspace.c
> > @@ -26,7 +26,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
> >  	if (data->valid)
> >  		*freq = data->user_frequency;
> >  	else
> > -		*freq = df->previous_freq; /* No user freq specified yet */
> > +		*freq = df->cur_freq; /* No user freq specified yet */
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
> > index ff82bac9ee4e..f99bd6557df5 100644
> > --- a/drivers/devfreq/tegra20-devfreq.c
> > +++ b/drivers/devfreq/tegra20-devfreq.c
> > @@ -61,7 +61,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> >  	return 0;
> >  
> >  restore_min_rate:
> > -	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> > +	clk_set_min_rate(tegra->emc_clock, devfreq->cur_freq);
> >  
> >  	return err;
> >  }
> > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> > index 536273a811fe..7b3bf7a0b15f 100644
> > --- a/drivers/devfreq/tegra30-devfreq.c
> > +++ b/drivers/devfreq/tegra30-devfreq.c
> > @@ -474,7 +474,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> >  	return 0;
> >  
> >  restore_min_rate:
> > -	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> > +	clk_set_min_rate(tegra->emc_clock, devfreq->cur_freq);
> >  
> >  	return err;
> >  }
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index 2bae9ed3c783..21d0108df4c5 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -120,7 +120,7 @@ struct devfreq_dev_profile {
> >   *		reevaluate operable frequencies. Devfreq users may use
> >   *		devfreq.nb to the corresponding register notifier call chain.
> >   * @work:	delayed work for load monitoring.
> > - * @previous_freq:	previously configured frequency value.
> > + * @cur_freq:	the current frequency.
> >   * @data:	Private data of the governor. The devfreq framework does not
> >   *		touch this.
> >   * @min_freq:	Limit minimum frequency requested by user (0: none)
> > @@ -156,7 +156,7 @@ struct devfreq {
> >  	struct notifier_block nb;
> >  	struct delayed_work work;
> >  
> > -	unsigned long previous_freq;
> > +	unsigned long cur_freq;
> >  	struct devfreq_dev_status last_status;
> >  
> >  	void *data; /* private data for governors */
> > diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
> > index cf5b8772175d..916cfaed5489 100644
> > --- a/include/trace/events/devfreq.h
> > +++ b/include/trace/events/devfreq.h
> > @@ -22,7 +22,7 @@ TRACE_EVENT(devfreq_monitor,
> >  	),
> >  
> >  	TP_fast_assign(
> > -		__entry->freq = devfreq->previous_freq;
> > +		__entry->freq = devfreq->cur_freq;
> >  		__entry->busy_time = devfreq->last_status.busy_time;
> >  		__entry->total_time = devfreq->last_status.total_time;
> >  		__entry->polling_ms = devfreq->profile->polling_ms;
> > 
> 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
