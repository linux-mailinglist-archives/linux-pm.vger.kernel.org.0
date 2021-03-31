Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA43505F3
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhCaSEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 14:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234641AbhCaSEi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 14:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14EDF60FEE;
        Wed, 31 Mar 2021 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617213878;
        bh=qHDaN1KMJSUUTxSkRP+E10OYogTWb+vKb0/NzVhDPAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AysV+2ecgG+eh6ipY0k3gTeEcJ9rdbzVhR+/Pz7jMCfY1DKaJrB76Kc9TqiQUphmd
         qlcr22AO28UrxflyxTOPgPpW7y/KzHnGAAXfsOfq5mapd2mJ2Y9OT5HebXYb1+9hIF
         ijBLW80BbMGqFKrrOtvtDIKARBfSNe3mswlRrfYI=
Date:   Wed, 31 Mar 2021 20:04:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org
Subject: Re: [PATCH v5 2/5] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGS5s3t3FkiV9ax5@kroah.com>
References: <20210331110048.24956-1-daniel.lezcano@linaro.org>
 <20210331110048.24956-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331110048.24956-2-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 31, 2021 at 01:00:45PM +0200, Daniel Lezcano wrote:
> A SoC can be differently structured depending on the platform and the
> kernel can not be aware of all the combinations, as well as the
> specific tweaks for a particular board.
> 
> The creation of the hierarchy must be delegated to userspace.

Isn't that what DT is for?

> These changes provide a registering mechanism where the different
> subsystems will initialize their dtpm backends and register with a
> name the dtpm node in a list.
> 
> The next changes will provide an userspace interface to create
> hierarchically the different nodes. Those will be created by name and
> found via the list filled by the different subsystem.
> 
> If a specified name is not found in the list, it is assumed to be a
> virtual node which will have children and the default is to allocate
> such node.

There's no userspace portion here, so why talk about it?

> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> 
> V5:
>   - Decrease log level from 'info' to 'debug'
>   - Remove the refcount, it is pointless, lifetime cycle is already
>     handled by the device refcounting. The dtpm node allocator is in
>     charge of freeing it.
>   - Rename the functions to 'dtpm_add, dtpm_del, dtpm_lookup'
>   - Fix missing kfrees when deleting the node from the list
> V4:
>   - Fixed typo in the commit log
> V2:
>   - Fixed error code path by dropping lock
> ---
>  drivers/powercap/dtpm.c     | 121 ++++++++++++++++++++++++++++++++++--
>  drivers/powercap/dtpm_cpu.c |   8 +--
>  include/linux/dtpm.h        |   6 ++
>  3 files changed, 127 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 58433b8ef9a1..8df7adeed0cf 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -34,6 +34,14 @@ static DEFINE_MUTEX(dtpm_lock);
>  static struct powercap_control_type *pct;
>  static struct dtpm *root;
>  
> +struct dtpm_node {
> +	const char *name;
> +	struct dtpm *dtpm;
> +	struct list_head node;
> +};
> +
> +static LIST_HEAD(dtpm_list);
> +
>  static int get_time_window_us(struct powercap_zone *pcz, int cid, u64 *window)
>  {
>  	return -ENOSYS;
> @@ -152,6 +160,113 @@ static int __dtpm_update_power(struct dtpm *dtpm)
>  	return ret;
>  }
>  
> +static struct dtpm *__dtpm_lookup(const char *name)
> +{
> +	struct dtpm_node *node;
> +
> +	list_for_each_entry(node, &dtpm_list, node) {
> +		if (!strcmp(name, node->name))
> +			return node->dtpm;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * dtpm_lookup - Lookup for a registered dtpm node given its name
> + * @name: the name of the dtpm device
> + *
> + * The function looks up in the list of the registered dtpm
> + * devices. This function must be called to create a dtpm node in the
> + * powercap hierarchy.
> + *
> + * Return: a pointer to a dtpm structure, NULL if not found.
> + */
> +struct dtpm *dtpm_lookup(const char *name)
> +{
> +	struct dtpm *dtpm;
> +
> +	mutex_lock(&dtpm_lock);
> +	dtpm = __dtpm_lookup(name);
> +	mutex_unlock(&dtpm_lock);
> +
> +	return dtpm;
> +}
> +
> +/**
> + * dtpm_add - Add the dtpm in the dtpm list
> + * @name: a name used as an identifier
> + * @dtpm: the dtpm node to be registered
> + *
> + * Stores the dtpm device in a list. The list contains all the devices
> + * which are power capable in terms of limitation and power
> + * consumption measurements. Even if conceptually, a power capable
> + * device won't register itself twice, the function will check if it
> + * was already registered in order to prevent a misuse of the API.
> + *
> + * Return: 0 on success, -EEXIST if the device name is already present
> + * in the list, -ENOMEM in case of memory allocation failure.
> + */
> +int dtpm_add(const char *name, struct dtpm *dtpm)

Why not just use the name of the dtpm?

Where does this "new" name come from?  And why would it differ?

> +{
> +	struct dtpm_node *node;
> +	int ret;
> +
> +	mutex_lock(&dtpm_lock);
> +
> +	ret = -EEXIST;
> +	if (__dtpm_lookup(name))
> +		goto out_unlock;

Why do you have yet-another-list of these devices?  They are already all
on a list, why do you need another?

And you seem to be ignoring reference count issues here, you add a
reference counted pointer to a random list in the kernel and never
increment the reference count.  That's bad :(

So just don't use a new list please...

thanks,

greg k-h
