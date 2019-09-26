Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDC6BF724
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfIZQvS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 12:51:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33612 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZQvR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 12:51:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so2192316pfl.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WzmNz7XRd5OiN6BFcznbPwBICwFGdE61Elyfk5RsfWY=;
        b=dS/DPqHyZLMaS2lJxibjNycVbnf0mJgFgGg10uqrOf//mwnDXXhdArCuzNugEf8ShP
         bGmmuAsYMCxyiI1B4NERevJu7nNWjjlPP6nqbCb74lo3iguhjhmY6M1btERTzmLHjyIj
         57F+JI1l825F4d3JwlGCqUnReWmRX5rpGuWKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WzmNz7XRd5OiN6BFcznbPwBICwFGdE61Elyfk5RsfWY=;
        b=qMoCy4Pv0u0FO1BMyHCa/uGZXkYP0RQiNrGmHSYtbvplzGdcRkEOBVPFa5MJe+tpy8
         MVDgrp2BW3Wa6zhRuVIwWda/nzPtoHcH7sA/ZjPNEQHjTYxPQF4J4mV11KDMEMtySygo
         MOIAcogR8h673bO+NjRMrTG8X4z52K9bbJ/iorDwxqH2KpFhJ+w0P1SCsqT+b/mbQAqH
         uapj+AIdIEQbX9jiwLMnEOf291+L77j4qc6LqA1Vwr7pmU6tM+rPNxnTh+U5joHJJRix
         nUsdExYPhzJ0Etn8Dy2mn2Oa5w6BuFxGeWx+B0XzoeITz6F7mj71KlsCUZR4I+5WF8Lx
         C78A==
X-Gm-Message-State: APjAAAWcCIeLbpMb8nWc3wBWYktOeP3wERVKVwkX+wx1vPXBmnt4CI3e
        KEhx1AXtTM/7k2HbM+GD2+Vumw==
X-Google-Smtp-Source: APXvYqzaMUF2LR6+lvtMW6Moq1c0qAzEitFFg2b2QE97EIYjBkRBo0Q7IIO5yCKcjUfwoT5ECrS8rg==
X-Received: by 2002:a62:c141:: with SMTP id i62mr4807427pfg.64.1569516675649;
        Thu, 26 Sep 2019 09:51:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n6sm2380789pgp.12.2019.09.26.09.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 09:51:15 -0700 (PDT)
Date:   Thu, 26 Sep 2019 09:51:13 -0700
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
Subject: Re: [PATCH 1/2] devfreq: Rename devfreq_update_status() to
 devfreq_update_stats() and viceversa
Message-ID: <20190926165113.GP133864@google.com>
References: <CGME20190925184505epcas2p3f8f4395f37df4b1fe33309393e8af4df@epcas2p3.samsung.com>
 <20190925184314.30251-1-mka@chromium.org>
 <3fb18474-b31e-bc7e-8b6a-660904a19443@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fb18474-b31e-bc7e-8b6a-660904a19443@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 26, 2019 at 10:36:04AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> I'm not sure that it is necessary. I think that it depends on
> personal opinions.

I disagree that this is about personal opinions. A function name should
give clues about what a function is doing and not be misleading. Once
these criteria are met personal opinions can come into play.

devfreq_update_status() updates statistics, not any status, hence the
name neither indicates what the function is doing, and it is misleading,
especially since there is another function dealing with the 'status'.

devfreq_update_stats() updates the 'status' of the device, not any
statistics/stats, as in the other case, the name doesn't indicate that
and is misleading.

If you still don't agree that the names are poor, could you please make
an argument about why the current function names are good/ok, besides
"that's how it's currently done"?

> There are no correct answer perfectly.

I agree that there is no one answer, but the current naming is clearly
poor, and we should aim to improve it. Whether that involves swapping the
function names or come up with new ones is a different question.

> Also, after this changes, there are no any beneficial.
> It touch the history rather than behavior improvement.

You are focussing exclusively on functional improvements, and you are right
that this patch doesn't change anything in functional terms.

However I disagree that there are no benefits. Naming is important, ideally
code should be self explanatory, which requires using proper function and
variable names, misleading names are particularly bad. Keeping poor names
for the sake of history sounds like a bad idea, please avoid getting attached
to them. Fortunately internal kernel APIs can be changed, and the ones in
question aren't widely used.

> On 19. 9. 26. 오전 3:43, Matthias Kaehlcke wrote:
> > devfreq has two functions with very similar names, devfreq_update_status()
> > and devfreq_update_stats(). _update_status() currently updates
> > frequency transitions statistics, while _update_stats() retrieves the
> > device 'status'. The function names are inversed with respect to what
> > the functions are actually doing, rename devfreq_update_status() to
> > devfreq_update_stats() and viceversa.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > We could also rename the current devfreq_update_stats() to
> > devfreq_refresh_status() to make it easier to distinguish it from
> > devfreq_update_stats().
> > ---
> >  drivers/devfreq/devfreq.c                 | 12 ++++++------
> >  drivers/devfreq/governor.h                |  4 ++--
> >  drivers/devfreq/governor_passive.c        |  2 +-
> >  drivers/devfreq/governor_simpleondemand.c |  2 +-
> >  drivers/devfreq/tegra30-devfreq.c         |  2 +-
> >  5 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 446490c9d635..fb4318d59aa9 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -151,11 +151,11 @@ static int set_freq_table(struct devfreq *devfreq)
> >  }
> >  
> >  /**
> > - * devfreq_update_status() - Update statistics of devfreq behavior
> > + * devfreq_update_stats() - Update statistics of devfreq behavior
> >   * @devfreq:	the devfreq instance
> >   * @freq:	the update target frequency
> >   */
> > -int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
> > +int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
> >  {
> >  	int lev, prev_lev, ret = 0;
> >  	unsigned long cur_time;
> > @@ -191,7 +191,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
> >  	devfreq->last_stat_updated = cur_time;
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL(devfreq_update_status);
> > +EXPORT_SYMBOL(devfreq_update_stats);
> >  
> >  /**
> >   * find_devfreq_governor() - find devfreq governor from name
> > @@ -311,7 +311,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> >  	freqs.new = new_freq;
> >  	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> >  
> > -	if (devfreq_update_status(devfreq, new_freq))
> > +	if (devfreq_update_stats(devfreq, new_freq))
> >  		dev_err(&devfreq->dev,
> >  			"Couldn't update frequency transition information.\n");
> >  
> > @@ -450,7 +450,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
> >  		return;
> >  	}
> >  
> > -	devfreq_update_status(devfreq, devfreq->previous_freq);
> > +	devfreq_update_stats(devfreq, devfreq->previous_freq);
> >  	devfreq->stop_polling = true;
> >  	mutex_unlock(&devfreq->lock);
> >  	cancel_delayed_work_sync(&devfreq->work);
> > @@ -1398,7 +1398,7 @@ static ssize_t trans_stat_show(struct device *dev,
> >  	unsigned int max_state = devfreq->profile->max_state;
> >  
> >  	if (!devfreq->stop_polling &&
> > -			devfreq_update_status(devfreq, devfreq->previous_freq))
> > +			devfreq_update_stats(devfreq, devfreq->previous_freq))
> >  		return 0;
> >  	if (max_state == 0)
> >  		return sprintf(buf, "Not Supported.\n");
> > diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> > index bbe5ff9fcecf..e11f447be2b5 100644
> > --- a/drivers/devfreq/governor.h
> > +++ b/drivers/devfreq/governor.h
> > @@ -64,9 +64,9 @@ extern void devfreq_interval_update(struct devfreq *devfreq,
> >  extern int devfreq_add_governor(struct devfreq_governor *governor);
> >  extern int devfreq_remove_governor(struct devfreq_governor *governor);
> >  
> > -extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
> > +extern int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq);
> >  
> > -static inline int devfreq_update_stats(struct devfreq *df)
> > +static inline int devfreq_update_status(struct devfreq *df)
> >  {
> >  	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
> >  }
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index be6eeab9c814..1c746b96d3db 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -110,7 +110,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
> >  		goto out;
> >  
> >  	if (devfreq->profile->freq_table
> > -		&& (devfreq_update_status(devfreq, freq)))
> > +		&& (devfreq_update_stats(devfreq, freq)))
> >  		dev_err(&devfreq->dev,
> >  			"Couldn't update frequency transition information.\n");
> >  
> > diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> > index 3d809f228619..2cbf26bdcfd6 100644
> > --- a/drivers/devfreq/governor_simpleondemand.c
> > +++ b/drivers/devfreq/governor_simpleondemand.c
> > @@ -25,7 +25,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
> >  	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
> >  	struct devfreq_simple_ondemand_data *data = df->data;
> >  
> > -	err = devfreq_update_stats(df);
> > +	err = devfreq_update_status(df);
> >  	if (err)
> >  		return err;
> >  
> > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> > index a6ba75f4106d..536273a811fe 100644
> > --- a/drivers/devfreq/tegra30-devfreq.c
> > +++ b/drivers/devfreq/tegra30-devfreq.c
> > @@ -526,7 +526,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
> >  	unsigned int i;
> >  	int err;
> >  
> > -	err = devfreq_update_stats(devfreq);
> > +	err = devfreq_update_status(devfreq);
> >  	if (err)
> >  		return err;
> >  
> > 
> 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
