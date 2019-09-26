Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0841BEC7D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 09:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfIZHWF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 03:22:05 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:42795 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfIZHWF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 03:22:05 -0400
Received: from [78.40.148.177] (helo=localhost)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iDO64-0006cN-BC; Thu, 26 Sep 2019 08:21:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Sep 2019 08:21:51 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] devfreq: Rename devfreq_update_status() to
 devfreq_update_stats() and viceversa
In-Reply-To: <20190925184314.30251-1-mka@chromium.org>
References: <20190925184314.30251-1-mka@chromium.org>
Message-ID: <3015d1aec68ca2b35a263d61bf13077e@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

/

On 2019-09-25 19:43, Matthias Kaehlcke wrote:
> devfreq has two functions with very similar names, 
> devfreq_update_status()
> and devfreq_update_stats(). _update_status() currently updates
> frequency transitions statistics, while _update_stats() retrieves the
> device 'status'. The function names are inversed with respect to what
> the functions are actually doing, rename devfreq_update_status() to
> devfreq_update_stats() and viceversa.

Wouldn't having devfreq_get_stats() be a better name for this if it
is retrieving the stats?

> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> We could also rename the current devfreq_update_stats() to
> devfreq_refresh_status() to make it easier to distinguish it from
> devfreq_update_stats().
> ---
>  drivers/devfreq/devfreq.c                 | 12 ++++++------
>  drivers/devfreq/governor.h                |  4 ++--
>  drivers/devfreq/governor_passive.c        |  2 +-
>  drivers/devfreq/governor_simpleondemand.c |  2 +-
>  drivers/devfreq/tegra30-devfreq.c         |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 446490c9d635..fb4318d59aa9 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -151,11 +151,11 @@ static int set_freq_table(struct devfreq 
> *devfreq)
>  }
> 
>  /**
> - * devfreq_update_status() - Update statistics of devfreq behavior
> + * devfreq_update_stats() - Update statistics of devfreq behavior
>   * @devfreq:	the devfreq instance
>   * @freq:	the update target frequency
>   */
> -int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
> +int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int lev, prev_lev, ret = 0;
>  	unsigned long cur_time;
> @@ -191,7 +191,7 @@ int devfreq_update_status(struct devfreq *devfreq,
> unsigned long freq)
>  	devfreq->last_stat_updated = cur_time;
>  	return ret;
>  }
> -EXPORT_SYMBOL(devfreq_update_status);
> +EXPORT_SYMBOL(devfreq_update_stats);
> 
>  /**
>   * find_devfreq_governor() - find devfreq governor from name
> @@ -311,7 +311,7 @@ static int devfreq_set_target(struct devfreq
> *devfreq, unsigned long new_freq,
>  	freqs.new = new_freq;
>  	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> 
> -	if (devfreq_update_status(devfreq, new_freq))
> +	if (devfreq_update_stats(devfreq, new_freq))
>  		dev_err(&devfreq->dev,
>  			"Couldn't update frequency transition information.\n");
> 
> @@ -450,7 +450,7 @@ void devfreq_monitor_suspend(struct devfreq 
> *devfreq)
>  		return;
>  	}
> 
> -	devfreq_update_status(devfreq, devfreq->previous_freq);
> +	devfreq_update_stats(devfreq, devfreq->previous_freq);
>  	devfreq->stop_polling = true;
>  	mutex_unlock(&devfreq->lock);
>  	cancel_delayed_work_sync(&devfreq->work);
> @@ -1398,7 +1398,7 @@ static ssize_t trans_stat_show(struct device 
> *dev,
>  	unsigned int max_state = devfreq->profile->max_state;
> 
>  	if (!devfreq->stop_polling &&
> -			devfreq_update_status(devfreq, devfreq->previous_freq))
> +			devfreq_update_stats(devfreq, devfreq->previous_freq))
>  		return 0;
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index bbe5ff9fcecf..e11f447be2b5 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -64,9 +64,9 @@ extern void devfreq_interval_update(struct devfreq 
> *devfreq,
>  extern int devfreq_add_governor(struct devfreq_governor *governor);
>  extern int devfreq_remove_governor(struct devfreq_governor *governor);
> 
> -extern int devfreq_update_status(struct devfreq *devfreq, unsigned 
> long freq);
> +extern int devfreq_update_stats(struct devfreq *devfreq, unsigned long 
> freq);
> 
> -static inline int devfreq_update_stats(struct devfreq *df)
> +static inline int devfreq_update_status(struct devfreq *df)
>  {
>  	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>  }
> diff --git a/drivers/devfreq/governor_passive.c
> b/drivers/devfreq/governor_passive.c
> index be6eeab9c814..1c746b96d3db 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -110,7 +110,7 @@ static int update_devfreq_passive(struct devfreq
> *devfreq, unsigned long freq)
>  		goto out;
> 
>  	if (devfreq->profile->freq_table
> -		&& (devfreq_update_status(devfreq, freq)))
> +		&& (devfreq_update_stats(devfreq, freq)))
>  		dev_err(&devfreq->dev,
>  			"Couldn't update frequency transition information.\n");
> 
> diff --git a/drivers/devfreq/governor_simpleondemand.c
> b/drivers/devfreq/governor_simpleondemand.c
> index 3d809f228619..2cbf26bdcfd6 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -25,7 +25,7 @@ static int devfreq_simple_ondemand_func(struct 
> devfreq *df,
>  	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
>  	struct devfreq_simple_ondemand_data *data = df->data;
> 
> -	err = devfreq_update_stats(df);
> +	err = devfreq_update_status(df);
>  	if (err)
>  		return err;
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c
> b/drivers/devfreq/tegra30-devfreq.c
> index a6ba75f4106d..536273a811fe 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -526,7 +526,7 @@ static int tegra_governor_get_target(struct
> devfreq *devfreq,
>  	unsigned int i;
>  	int err;
> 
> -	err = devfreq_update_stats(devfreq);
> +	err = devfreq_update_status(devfreq);
>  	if (err)
>  		return err;
