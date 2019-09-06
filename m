Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31048AC34F
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 01:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405731AbfIFXka (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 19:40:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33480 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405243AbfIFXka (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 19:40:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id t11so3919123plo.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2019 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pxKRv8jsRZzTGKhj+ioFhgpVS6Dzsmm59+PKHULgKG4=;
        b=f5qht4kBJty1w+M1QEqeEr7xM9Wdo7RR8Rao8IQtESokz+K0NhWhBs5VMOnCX7Rzey
         n3kQ0m28gB61aIOoyjV4+gonSGVif7/x2NLw+5C8dnvbzZ1XYCWVrxayUITMuHWvrBRj
         dD0g2Q/1aGyuTiMBmtgbjVBzyk5nKLsPhOcNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxKRv8jsRZzTGKhj+ioFhgpVS6Dzsmm59+PKHULgKG4=;
        b=IXr1zTdRwtxgW993w4AlkJDgJzldNBtTkMxEd00qbyiffdxcnwjPFg5GKSRoP/Z5Hd
         +m6D+aCPG+FxMz10D4qy+WoOdSGShw3n6Hy8PpVfMg+kQGihIqW38otr+EA6lDix6n7D
         0sW2d30arkupT6r8X5GiTRLVkaeaEX9UfgP2YVjTxXat4wr95a8caJgfcJsJoRGkwv/i
         xfsPhw7D5POiAUIt4QFAd1ae3Z/XM9exRLSpvDi31mVvDq4KBPypLXlYX52SnI6ip6MG
         N68S/aM5lJ6rU558ZgzPGc61KXBLjCvQgQSiNiAaRZfMIL7SEkudjx00YVnDiqIEjT/b
         aXCQ==
X-Gm-Message-State: APjAAAVTEKmL/PNdJAiYAHagnYkKgcomhQJXf/VdEBNyfDd6ovVVfSTV
        UxhiteP5D4x+Aoq+j83gSLzp2A==
X-Google-Smtp-Source: APXvYqy5ATiCVXAmYBmhNqO3VIuKk8WRC1Ed+4dSQcZvN9PCdHTA/UhyJBc1yPjVotkulRJugBZxhQ==
X-Received: by 2002:a17:902:864a:: with SMTP id y10mr11724408plt.294.1567813229347;
        Fri, 06 Sep 2019 16:40:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id m9sm927359pjf.11.2019.09.06.16.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:40:28 -0700 (PDT)
Date:   Fri, 6 Sep 2019 16:40:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org, bhe@redhat.com,
        dyoung@redhat.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, tbroch@chromium.org, trong@google.com
Subject: Re: [PATCH 1/2] power: sysfs: Add link to wakeup class device.
Message-ID: <20190906234025.GD133864@google.com>
References: <20190724174355.255314-1-ravisadineni@chromium.org>
 <20190724174355.255314-2-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190724174355.255314-2-ravisadineni@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ravi,

On Wed, Jul 24, 2019 at 10:43:54AM -0700, Ravi Chandra Sadineni wrote:
> https://patchwork.kernel.org/patch/11045069/ creates a virtual
> device

To refer to unsubmitted patches in the commit message it is
probably better to use the subject ("PM / wakeup: show wakeup
sources stats in sysfs") and add a link after '---', or say
"${subject}" [1] and put the link at the bottom of the commit message

You might want to try again now that the patch has landed :)

> under wakeup class for each wake capable device exposing all related
> sysfs attributes. But there isn't a symlink from the actual device
> node to these virtual devices. This patch creates a symlink from the
> actual device to the corresponding wakeup_source device under wakeup
> class.

> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  drivers/base/power/power.h  |  2 ++
>  drivers/base/power/sysfs.c  | 25 +++++++++++++++++++++++++
>  drivers/base/power/wakeup.c |  2 ++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index c511def48b48..32b0f5c080a9 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -67,6 +67,8 @@ extern void dpm_sysfs_remove(struct device *dev);
>  extern void rpm_sysfs_remove(struct device *dev);
>  extern int wakeup_sysfs_add(struct device *dev);
>  extern void wakeup_sysfs_remove(struct device *dev);
> +extern void wakeup_source_sysfs_link_add(struct device *dev);
> +extern void wakeup_source_sysfs_link_remove(struct device *dev);

the names seem a bit clunky, how about wakeup_sysfs_add/remove_link()?

>  extern int pm_qos_sysfs_add_resume_latency(struct device *dev);
>  extern void pm_qos_sysfs_remove_resume_latency(struct device *dev);
>  extern int pm_qos_sysfs_add_flags(struct device *dev);
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index d713738ce796..fbbdb7b16ac5 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -95,6 +95,7 @@
>  const char power_group_name[] = "power";
>  EXPORT_SYMBOL_GPL(power_group_name);
>  
> +static const char wakeup_source_symlink_name[] = "wakeup_source";
>  static const char ctrl_auto[] = "auto";
>  static const char ctrl_on[] = "on";
>  
> @@ -679,6 +680,30 @@ int dpm_sysfs_add(struct device *dev)
>  	return rc;
>  }
>  
> +void wakeup_source_sysfs_link_add(struct device *dev)
> +{
> +	struct wakeup_source *ws;
> +	int err;
> +
> +	ws = dev->power.wakeup;
> +	if (ws && ws->dev) {
> +		err = sysfs_add_link_to_group(&dev->kobj, power_group_name,
> +			&ws->dev->kobj, wakeup_source_symlink_name);
> +		if (err) {
> +			dev_err(dev,
> +				"could not add %s symlink err %d\n",

I'd suggest

				"could not add '%s' symlink: %d\n",

or

				"could not add 'wakeup_source' symlink: %d\n",

the latter is easier to grep.

> +				wakeup_source_symlink_name,
> +				err);
> +		}
> +	}
> +}
> +
> +void wakeup_source_sysfs_link_remove(struct device *dev)
> +{
> +	sysfs_remove_link_from_group(&dev->kobj, power_group_name,
> +		wakeup_source_symlink_name);
> +}
> +
>  int wakeup_sysfs_add(struct device *dev)
>  {
>  	return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index fe779fe13a7f..87dfe401b035 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -270,6 +270,7 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
>  	if (dev->power.wakeirq)
>  		device_wakeup_attach_irq(dev, dev->power.wakeirq);
>  	spin_unlock_irq(&dev->power.lock);
> +	wakeup_source_sysfs_link_add(dev);
>  	return 0;
>  }
>  
> @@ -391,6 +392,7 @@ static struct wakeup_source *device_wakeup_detach(struct device *dev)
>  	ws = dev->power.wakeup;
>  	dev->power.wakeup = NULL;
>  	spin_unlock_irq(&dev->power.lock);
> +	wakeup_source_sysfs_link_remove(dev);

you want to do this before the wakeup source is detached.
