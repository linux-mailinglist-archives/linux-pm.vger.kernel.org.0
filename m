Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809DA4ADFE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 00:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfFRWos (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 18:44:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57310 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRWos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 18:44:48 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id a04ace6452f9df28; Wed, 19 Jun 2019 00:44:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PM: wakeup: Add routine to help fetch wakeup source object.
Date:   Wed, 19 Jun 2019 00:44:44 +0200
Message-ID: <3448272.3g8bHhgBA9@kreacher>
In-Reply-To: <20190520095238.29210-1-ran.wang_1@nxp.com>
References: <20190520095238.29210-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, May 20, 2019 11:52:36 AM CEST Ran Wang wrote:
> Some user might want to go through all registered wakeup sources
> and doing things accordingly. For example, SoC PM driver might need to
> do HW programming to prevent powering down specific IP which wakeup
> source depending on. And is user's responsibility to identify if this
> wakeup source he is interested in.

I guess the idea here is that you need to walk wakeup devices and you noticed
that there was a wakeup source object for each of them and those wakeup
source objects were on a list, so you could walk wakeup devices by walking
the list of wakeup source objects.

That is fair enough, but the changelog above doesn't even talk about that.
 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v4:
> 	- None.
> 
> Change in v3:
> 	- Adjust indentation of *attached_dev;.
> 
> Change in v2:
> 	- None.
> 
>  drivers/base/power/wakeup.c |   18 ++++++++++++++++++
>  include/linux/pm_wakeup.h   |    3 +++
>  2 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5b2b6a0..6904485 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -14,6 +14,7 @@
>  #include <linux/suspend.h>
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
> +#include <linux/of_device.h>
>  #include <linux/pm_wakeirq.h>
>  #include <trace/events/power.h>
>  
> @@ -226,6 +227,22 @@ void wakeup_source_unregister(struct wakeup_source *ws)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_unregister);
> +/**
> + * wakeup_source_get_next - Get next wakeup source from the list
> + * @ws: Previous wakeup source object, null means caller want first one.
> + */
> +struct wakeup_source *wakeup_source_get_next(struct wakeup_source *ws)
> +{
> +	struct list_head *ws_head = &wakeup_sources;
> +
> +	if (ws)
> +		return list_next_or_null_rcu(ws_head, &ws->entry,
> +				struct wakeup_source, entry);
> +	else
> +		return list_entry_rcu(ws_head->next,
> +				struct wakeup_source, entry);
> +}
> +EXPORT_SYMBOL_GPL(wakeup_source_get_next);

This needs to be arranged along the lines of wakeup_sources_stats_seq_start/next/stop()
because of the SRCU protection of the list.

>  
>  /**
>   * device_wakeup_attach - Attach a wakeup source object to a device object.
> @@ -242,6 +259,7 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
>  		return -EEXIST;
>  	}
>  	dev->power.wakeup = ws;
> +	ws->attached_dev = dev;
>  	if (dev->power.wakeirq)
>  		device_wakeup_attach_irq(dev, dev->power.wakeirq);
>  	spin_unlock_irq(&dev->power.lock);
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 0ff134d..913b2fb 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -50,6 +50,7 @@
>   * @wakeup_count: Number of times the wakeup source might abort suspend.
>   * @active: Status of the wakeup source.
>   * @has_timeout: The wakeup source has been activated with a timeout.
> + * @attached_dev: The device it attached to
>   */
>  struct wakeup_source {
>  	const char 		*name;
> @@ -70,6 +71,7 @@ struct wakeup_source {
>  	unsigned long		wakeup_count;
>  	bool			active:1;
>  	bool			autosleep_enabled:1;
> +	struct device		*attached_dev;

Please (a) call it just dev and (b) move it up (before wakeirq, say).

>  };
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -101,6 +103,7 @@ static inline void device_set_wakeup_path(struct device *dev)
>  extern void wakeup_source_remove(struct wakeup_source *ws);
>  extern struct wakeup_source *wakeup_source_register(const char *name);
>  extern void wakeup_source_unregister(struct wakeup_source *ws);
> +extern struct wakeup_source *wakeup_source_get_next(struct wakeup_source *ws);
>  extern int device_wakeup_enable(struct device *dev);
>  extern int device_wakeup_disable(struct device *dev);
>  extern void device_set_wakeup_capable(struct device *dev, bool capable);
> 




