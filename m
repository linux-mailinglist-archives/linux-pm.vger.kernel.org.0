Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB4D34B74E
	for <lists+linux-pm@lfdr.de>; Sat, 27 Mar 2021 13:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhC0Muq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Mar 2021 08:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhC0Muq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 27 Mar 2021 08:50:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC8B619E5;
        Sat, 27 Mar 2021 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616849446;
        bh=sg1/Exkej0/n+wciolWG61NxonQWasHm41PjUh1+UAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4iQosa8TPDtYeRwOGJonLa/JNVKsHEfE9M8UGOsbhOLXK2opXbPGyDi8pC4R3StX
         Sy+OSpkQy06iKKwYJMMH0HCrMm9r0qkGIZtHUDYff0rAhCXblVVrvwDXI3EcuukxgR
         7LbBLqUYwFI+UUYLmk4gSolCUAv7F6ybziDfNLQo=
Date:   Sat, 27 Mar 2021 13:50:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
Message-ID: <YF8qIw4UBLnj9TCA@kroah.com>
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312130411.29833-2-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 02:04:08PM +0100, Daniel Lezcano wrote:
> A SoC can be differently structured depending on the platform and the
> kernel can not be aware of all the combinations, as well as the
> specific tweaks for a particular board.
> 
> The creation of the hierarchy must be delegated to userspace.
> 
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
> 
> When the node register in the list, the function will be dtpm_register
> where the previous semantic was to create the node. Thus, the
> functions are renamed to reflect their purpose.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> 
> V4:
>   - Fixed typo in the commit log
> 
> V2:
>   - Fixed error code path by dropping lock
> ---
>  drivers/powercap/dtpm.c     | 161 ++++++++++++++++++++++++++++++++++--
>  drivers/powercap/dtpm_cpu.c |   4 +-
>  include/linux/dtpm.h        |  12 ++-
>  3 files changed, 164 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 58433b8ef9a1..d00f55f0ee30 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -20,6 +20,7 @@
>  #include <linux/dtpm.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/kref.h>
>  #include <linux/powercap.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> @@ -34,6 +35,14 @@ static DEFINE_MUTEX(dtpm_lock);
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
> @@ -152,6 +161,138 @@ static int __dtpm_update_power(struct dtpm *dtpm)
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
> + * dtpm_get - Get a reference to a dtpm structure
> + * @name: the name of the dtpm device
> + *
> + * The function looks up in the list of the registered dtpm
> + * devices. If the dtpm device is not found, a virtual one is
> + * allocated. This function must be called to create a dtpm node in
> + * the powercap hierarchy.
> + *
> + * Return: a pointer to a dtpm structure, NULL if there is not enough
> + * memory
> + */
> +struct dtpm *dtpm_get(const char *name)
> +{
> +	struct dtpm *dtpm;
> +
> +	mutex_lock(&dtpm_lock);
> +	dtpm = __dtpm_lookup(name);
> +	if (!dtpm)
> +		dtpm = dtpm_alloc(NULL);
> +	else
> +		kref_get(&dtpm->kref);
> +	mutex_unlock(&dtpm_lock);
> +
> +	return dtpm;
> +}
> +
> +static void dtpm_release(struct kref *kref)
> +{
> +	struct dtpm *dtpm = container_of(kref, struct dtpm, kref);
> +
> +	kfree(dtpm);
> +}
> +
> +/**
> + * dtpm_put - Release a reference on a dtpm device
> + * @dtpm: a pointer to a dtpm structure
> + *
> + * Release the reference on the specified dtpm device. The last
> + * reference leads to a memory release.
> + */
> +void dtpm_put(struct dtpm *dtpm)
> +{
> +	kref_put(&dtpm->kref, dtpm_release);

You forgot to also grab the dtpm_lock before calling this, right?  What
is preventing a get and put from being called at the same time?

You protect things at get time, but not put from what I can see :(


> +}
> +
> +/**
> + * dtpm_register - Register the dtpm in the dtpm list
> + * @name: a name used as an identifier
> + * @dtpm: the dtpm node to be registered
> + *
> + * Stores the dtpm device in a list.
> + *
> + * Return: 0 on success, -EEXIST if the device name is already present
> + * in the list, -ENOMEM in case of memory allocation failure.
> + */
> +int dtpm_register(const char *name, struct dtpm *dtpm)
> +{
> +	struct dtpm_node *node;
> +	int ret;
> +
> +	mutex_lock(&dtpm_lock);
> +
> +	ret = -EEXIST;
> +	if (__dtpm_lookup(name))
> +		goto out_unlock;
> +
> +	ret = -ENOMEM;
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		goto out_unlock;
> +
> +	node->name = kstrdup(name, GFP_KERNEL);
> +	if (!node->name) {
> +		kfree(node);
> +		goto out_unlock;
> +	}
> +
> +	node->dtpm = dtpm;
> +
> +	list_add(&node->node, &dtpm_list);
> +
> +	pr_info("Registered %s\n", name);

When kernel code works properly, it is quiet.  This is debugging code a
the most, never something that everyone should be seeing all the time,
please remove.


> +
> +	ret = 0;
> +out_unlock:
> +	mutex_unlock(&dtpm_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * dtpm_unregister - Remove the dtpm device from the list
> + * @name: the dtpm device name to be removed
> + *
> + * Remove the dtpm device from the list of the registered devices.
> + */
> +void dtpm_unregister(const char *name)
> +{
> +	struct dtpm_node *node;
> +
> +	mutex_lock(&dtpm_lock);
> +
> +	list_for_each_entry(node, &dtpm_list, node) {
> +
> +		if (strcmp(name, node->name))
> +			continue;
> +
> +		list_del(&node->node);
> +		kfree(node->name);
> +		kfree(node);
> +
> +		pr_info("Unregistered %s\n", name);

Again, debugging code should be removed.

> +
> +		break;
> +	}
> +
> +	mutex_unlock(&dtpm_lock);
> +}
> +
>  /**
>   * dtpm_update_power - Update the power on the dtpm
>   * @dtpm: a pointer to a dtpm structure to update
> @@ -208,7 +349,7 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>  	if (root == dtpm)
>  		root = NULL;
>  
> -	kfree(dtpm);
> +	dtpm_put(dtpm);
>  
>  	return 0;
>  }
> @@ -370,6 +511,7 @@ struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
>  	if (dtpm) {
>  		INIT_LIST_HEAD(&dtpm->children);
>  		INIT_LIST_HEAD(&dtpm->sibling);
> +		kref_init(&dtpm->kref);
>  		dtpm->weight = 1024;
>  		dtpm->ops = ops;
>  	}
> @@ -378,28 +520,29 @@ struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
>  }
>  
>  /**
> - * dtpm_unregister - Unregister a dtpm node from the hierarchy tree
> - * @dtpm: a pointer to a dtpm structure corresponding to the node to be removed
> + * dtpm_destroy - Destroy a dtpm node from the hierarchy tree
> + * @dtpm: a pointer to a dtpm structure corresponding to the node to be
> + *	  removed and destroyed
>   *
>   * Call the underlying powercap unregister function. That will call
>   * the release callback of the powercap zone.
>   */
> -void dtpm_unregister(struct dtpm *dtpm)
> +void dtpm_destroy(struct dtpm *dtpm)
>  {
>  	powercap_unregister_zone(pct, &dtpm->zone);
>  
> -	pr_info("Unregistered dtpm node '%s'\n", dtpm->zone.name);
> +	pr_info("Destroyed dtpm node '%s'\n", dtpm->zone.name);

Again, please make pr_dbg().

And any reason why you are not using "real" struct devices in this
subsystem?  You seem to be rolling your own infrastructure for no good
reason.  I imagine you want sysfs support next, right?

thanks,

greg k-h
