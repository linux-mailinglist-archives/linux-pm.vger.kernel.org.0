Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8C1175D3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 20:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLIT1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 14:27:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35167 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfLIT1q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 14:27:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so6311645pjd.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 11:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kB1Dm5QdRvo+4ntSSP2QV88L91oQIBSmXvZFFUy0ooA=;
        b=PoJ1fJmMamJi9zmUxFThCbE3g18OtYx+ZbHroN6REARVBPp7YdFot6D8opjlokllNL
         6N6lRGKDBdpGC06SZAXrdviGmwlAZb74nsaj5RQl/6+7s93sxu4zheqUX/1AiQzE4I3M
         QUBedDSudYhvTsrHXcPIki6A/TIDu0zrvXaTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kB1Dm5QdRvo+4ntSSP2QV88L91oQIBSmXvZFFUy0ooA=;
        b=ukbD81dGEZ9KDTTy0OChe6Vm4RDbZRwWxbnMtGkBEts98R5PP/SQm5eETN1hg9khl1
         tl6acYIdehE/uVKoOTsoXWQcAcwS1EISaxCh93Kvua+/DNvc7FnAHa1dERBqGdLY4R96
         2hCNNuKgdwqHpvW22LOOWSdAHfov53b0oN7848ludwwvOVgkK820AtJOAs7Dac0GuCiR
         d3J/Xo0Zu2LlzKlMsu8evAPXqnhUuMxWmE8LKjpeQ1e0z3YFrDROn1ljBMUkaRctxVbw
         1YIYNH6DZ5ucVxd5rbaikCrneWXoRrVCpA4n/jtOPzPfDGNZdlsVPi7mXfa/dmzNWWHj
         nSFw==
X-Gm-Message-State: APjAAAVBbjPgAvfr9XCMGiBo17YNtIbTuEqcH4S/18vjbnCWemhozMwp
        Sonhcw5MjVT2mHzVbJIl5Bk72w==
X-Google-Smtp-Source: APXvYqzLvXqT8hfm/ru3JfLfbM93M1FuOEkMfJe5bZLb6DkkwtltgsbvJNl7gPppZoHhimF9CGXe7w==
X-Received: by 2002:a17:902:9007:: with SMTP id a7mr5337266plp.46.1575919664605;
        Mon, 09 Dec 2019 11:27:44 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id m13sm315926pga.70.2019.12.09.11.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 11:27:44 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:27:42 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 2/4] PM / devfreq: add possibility for delayed work
Message-ID: <20191209192742.GP228856@google.com>
References: <20191209144425.13321-1-k.konieczny@samsung.com>
 <CGME20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5@eucas1p2.samsung.com>
 <20191209144425.13321-3-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209144425.13321-3-k.konieczny@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, Dec 09, 2019 at 03:44:23PM +0100, Kamil Konieczny wrote:
> Current devfreq workqueue uses deferred timer. Introduce sysfs
> file delayed_timer and use it for change from deferred to
> delayed work. The default is to use old deferred one, which
> saves power, but can miss increased demand for higher bus
> frequency if timer was assigned to idle cpu.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-class-devfreq | 10 ++++
>  drivers/devfreq/devfreq.c                     | 46 ++++++++++++++++++-
>  include/linux/devfreq.h                       |  2 +
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 9758eb85ade3..07bfd0df6a4a 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -30,6 +30,16 @@ Description:
>  		target_freq when get_cur_freq() is not implemented by
>  		devfreq driver.
>  
> +What:		/sys/class/devfreq/.../delayed_timer
> +Date:		December 2019
> +Contact:	Kamil Konieczny <k.konieczny@samsung.com>
> +Description:
> +		This ABI shows or clears timer type used by devfreq
> +		workqueue. When 0, it uses default deferred timer.
> +		When set to 1 devfreq will use delayed timer. Example
> +		useage:
> +			echo 1 > /sys/class/devfreq/.../delayed_timer
> +
>  What:		/sys/class/devfreq/.../target_freq
>  Date:		September 2012
>  Contact:	Rajagopal Venkat <rajagopal.venkat@linaro.org>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 955949c6fc1f..c277d1770fef 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -445,7 +445,11 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>  	if (devfreq->governor->interrupt_driven)
>  		return;
>  
> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +	if (devfreq->delayed_timer)
> +		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
> +	else
> +		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +
>  	if (devfreq->profile->polling_ms)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
> @@ -698,6 +702,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
> +	devfreq->delayed_timer = false;

devfreq is zero initialized (allocated with kzalloc()), hence this is
unnecessary.

>  
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>  		mutex_unlock(&devfreq->lock);
> @@ -1288,6 +1293,44 @@ static ssize_t available_governors_show(struct device *d,
>  }
>  static DEVICE_ATTR_RO(available_governors);
>  
> +static ssize_t delayed_timer_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	int i;
> +
> +	i = to_devfreq(dev)->delayed_timer ? 1 : 0;
> +	return sprintf(buf, "%d\n", i);

get rid of 'i' and just use df->delayed_timer in sprintf().

> +}
> +
> +static ssize_t delayed_timer_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct devfreq *df = to_devfreq(dev);
> +	bool old_timer;

Not a great name, the variable doesn't hold a timer. I'd suggest something
like 'prev_val'.

> +	int value, ret;
> +
> +	if (!df->governor)
> +		return -EINVAL;
> +
> +	ret = kstrtoint(buf, 10, &value);
> +	if (ret || (value != 1 && value != 0))
> +		return -EINVAL;

use kstrtobool() instead of partially re-implementing it.

> +
> +	mutex_lock(&df->lock);
> +	old_timer = df->delayed_timer;
> +	df->delayed_timer = value == 0 ? false : true;

What's wrong with:

df->delayed_timer = value;

?

> +	mutex_unlock(&df->lock);

Does the locking as is actually provide any value? The use case seems to
be concurrent setting of the sysfs attribute. The lock is released after
the assignment, hence the value of 'df->delayed_timer' could be overwritten
before the condition below is evaluated.

If you want to protect against this case you need something like this:

// don't release the lock before evaluating the condition

> +	if (old_timer != df->delayed_timer) {
  	   	mutex_unlock(&df->lock);
> +		devfreq_monitor_stop(df);
> +		devfreq_monitor_start(df);
> +	}
  	else {
		mutex_unlock(&df->lock);
	}

I don't pretend it's pretty ;-)
