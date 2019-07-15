Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850B269CE3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfGOUhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 16:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfGOUhN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jul 2019 16:37:13 -0400
Received: from localhost (unknown [88.128.80.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F39A2145D;
        Mon, 15 Jul 2019 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563223032;
        bh=f6vha8teZ7Sy/LhmbX8Bp2eqOvg07oKQIDJMB60rAoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpE0NTgYLB+9Yhlw2OTVeb/KKRgaAT0OZR8zmLJDkIjYW8vhFWb9D92fkh37F0r23
         62YYv/t32JesZf4+BoabX8nvU8CtjvDGmARuIOYUP2601S+j3n8GmORpzU4lExoVf2
         W4GyZ1tFIG2+U6fTJ9kfQtdMmAytXDZoQ85tpNXU=
Date:   Mon, 15 Jul 2019 22:36:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, rafael@kernel.org,
        hridya@google.com, sspatil@google.com, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190715203651.GA7513@kroah.com>
References: <CANA+-vAxU5jp6PQ26NU+UMc6iyw6KkBS9nbd6wj0qqkO-1WhYg@mail.gmail.com>
 <20190715201116.221078-1-trong@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715201116.221078-1-trong@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 15, 2019 at 01:11:16PM -0700, Tri Vo wrote:
> Userspace can use wakeup_sources debugfs node to plot history of suspend
> blocking wakeup sources over device's boot cycle. This information can
> then be used (1) for power-specific bug reporting and (2) towards
> attributing battery consumption to specific processes over a period of
> time.
> 
> However, debugfs doesn't have stable ABI. For this reason, create a
> 'struct device' to expose wakeup sources statistics in sysfs under
> /sys/class/wakeup/<name>/.
> 
> Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> source statistics in sysfs.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Tri Vo <trong@android.com>
> Tested-by: Tri Vo <trong@android.com>

Co-Developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
perhaps given that I rewrote the whole file last time?  :)


> ---
>  Documentation/ABI/testing/sysfs-power |  73 ++++++++++++-
>  drivers/base/power/Makefile           |   1 +
>  drivers/base/power/wakeup.c           |  12 ++-
>  drivers/base/power/wakeup_stats.c     | 148 ++++++++++++++++++++++++++
>  include/linux/pm_wakeup.h             |  19 ++++
>  kernel/power/Kconfig                  |  10 ++
>  kernel/power/wakelock.c               |  10 ++
>  7 files changed, 270 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/base/power/wakeup_stats.c

What changed from v2?  :)

> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index 18b7dc929234..ef92628e6fc3 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -300,4 +300,75 @@ Description:
>  		attempt.
>  
>  		Using this sysfs file will override any values that were
> -		set using the kernel command line for disk offset.
> \ No newline at end of file
> +		set using the kernel command line for disk offset.
> +
> +What:		/sys/class/wakeup/

My fault, this should be a new ABI/testing file, don't use sysfs-power
as it does not make any sense now, right?

> --- /dev/null
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wakeup statistics in sysfs
> + *
> + * Copyright (c) 2019 Linux Foundation <gregkh@linuxfoundation.org>

My fault on the original here, this line should be 2 lines:

> + * Copyright (c) 2019 Linux Foundation
> + * Copyright (c) 2019 Greg Kroah-Hartman <gregkh@linuxfoundation.org>

as those are two different entities that have copyright here on this
file.

> +config PM_SLEEP_STATS
> +	bool "Wakeup sources statistics"
> +	depends on PM_SLEEP
> +	help
> +	  Expose wakeup sources statistics to user space via sysfs. Collected
> +	  statistics are located under /sys/power/wakeup_sources. For more
> +	  information, read <file:Documentation/ABI/testing/sysfs-power>.

Filename should be changed.


> +
> +	  If in doubt, say N.
> +
>  config DPM_WATCHDOG
>  	bool "Device suspend/resume watchdog"
>  	depends on PM_DEBUG && PSTORE && EXPERT
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> index 4210152e56f0..32726da3d6e6 100644
> --- a/kernel/power/wakelock.c
> +++ b/kernel/power/wakelock.c
> @@ -122,6 +122,7 @@ static void __wakelocks_gc(struct work_struct *work)
>  
>  		if (!active) {
>  			wakeup_source_remove(&wl->ws);
> +			wakeup_source_sysfs_remove(&wl->ws);
>  			rb_erase(&wl->node, &wakelocks_tree);
>  			list_del(&wl->lru);
>  			kfree(wl->name);
> @@ -153,6 +154,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
>  	struct rb_node **node = &wakelocks_tree.rb_node;
>  	struct rb_node *parent = *node;
>  	struct wakelock *wl;
> +	int ret;
>  
>  	while (*node) {
>  		int diff;
> @@ -189,6 +191,14 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
>  	}
>  	wl->ws.name = wl->name;
>  	wl->ws.last_time = ktime_get();
> +
> +	ret = wakeup_source_sysfs_add(&wl->ws);
> +	if (ret) {
> +		kfree(wl->name);
> +		kfree(wl);
> +		return ERR_PTR(ret);
> +	}
> +
>  	wakeup_source_add(&wl->ws);
>  	rb_link_node(&wl->node, parent, node);
>  	rb_insert_color(&wl->node, &wakelocks_tree);

Nice, you got rid of the extra change in this file, making this much
simpler.

Can you make these minor tweaks?  If so, I'll be glad to queue this up
after 5.3-rc1 is out.

And I am guessing that you actually tested this all out, and it works
for you?  Have you changed Android userspace to use the new api with no
problems?

thanks,

greg k-h
