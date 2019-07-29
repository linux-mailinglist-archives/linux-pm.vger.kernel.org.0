Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A216B78FC6
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfG2PtD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 11:49:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36187 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbfG2PtC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 11:49:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so42442434lfc.3;
        Mon, 29 Jul 2019 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oZHNGmcwNeCcaACNpIQI9kWx89RjJOdvMaX6gZt+AZc=;
        b=lGQa4KNWBCMAtJA11dwI6SkdLRLCv2XDDSj9sAzk5wo+Nh1h3+rxc2Vx0tGApQCQfq
         T2aHyQL3n1uYO3ThOuBSn/blgcdsj2LVRuwLpF5gPLXFun6Rj8OM8qhEp3L7Pk9II0XV
         J+pHC7K8BUD5yRaQRwWbNlH3c+5zvtxMPgjjW5trCQr6gR/uL8A1PytlpgkN/SaLuwE1
         OnfLYniLsMyglJxuUYAYkWKlU4szf3v9t1A+uy9FqBfVkfiYoppJq9xM8t6CaOiZmJAM
         mTfWd4tgtxLS5xh8hWXR5/pD++FRdsiyB5XVvDCATiXpQnNifLt7Ty2JEv8tjBo6b4D7
         DD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oZHNGmcwNeCcaACNpIQI9kWx89RjJOdvMaX6gZt+AZc=;
        b=gRmjsyTGehaIi45pjL02Hpbu+b2LYEA5MqHgCamX1xFIkZODKyur8P/P7HyPZQxsr1
         Gc+Xxh3pArh7b9DxEEpp36hp8M9rtRVMCCK2oHSTxxDau7QSdDqif4FLHqXVn1/j7q2R
         8pw2uHVFYiLWPkF+K2bIC7esdzVhi+ZJ8kcGAIgJlft/NpUHUtAeMAl3O29n64tHT6Qk
         Mc+HLMbtSxf4MK9Y2j17wWoRT8I+fvOtD/pYor1T/eXlnpdQWmuQqasSAjXummAXpUkf
         r9xVuCCqQQ6mvozpTJMI/TdK/UO0iwXLI4t856Vv+O30swtDcDYUqNRfwWjIBoIhEcgA
         MRWA==
X-Gm-Message-State: APjAAAXDyn31xP/WnF5R7weiJzr9e7U0GYpQUoM10lbCAtYdVZILTSNE
        IROq9d+GbulNR3fvtbf85sI=
X-Google-Smtp-Source: APXvYqxVRV4oYd5Ux+zGbBXMHbJvgN8D0Nk11ncZLNYegNl9ElBVNehEYI6/m2AxY9Z8aoW1Z7lF9A==
X-Received: by 2002:a19:8c57:: with SMTP id i23mr50870933lfj.192.1564415339247;
        Mon, 29 Jul 2019 08:48:59 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id t63sm12878065lje.65.2019.07.29.08.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 08:48:58 -0700 (PDT)
Subject: Re: [PATCH v2] driver core: Remove device link creation limitation
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <2305283.AStDPdUUnE@kreacher>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c8960d91-4446-9acf-5575-e442a652bd05@gmail.com>
Date:   Mon, 29 Jul 2019 18:48:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2305283.AStDPdUUnE@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 18:21, Rafael J. Wysocki пишет:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] driver core: Remove device link creation limitation
> 
> If device_link_add() is called for a consumer/supplier pair with an
> existing device link between them and the existing link's type is
> not in agreement with the flags passed to that function by its
> caller, NULL will be returned.  That is seriously inconvenient,
> because it forces the callers of device_link_add() to worry about
> what others may or may not do even if that is not relevant to them
> for any other reasons.
> 
> It turns out, however, that this limitation can be made go away
> relatively easily.
> 
> The underlying observation is that if DL_FLAG_STATELESS has been
> passed to device_link_add() in flags for the given consumer/supplier
> pair at least once, calling either device_link_del() or
> device_link_remove() to release the link returned by it should work,
> but there are no other requirements associated with that flag.  In
> turn, if at least one of the callers of device_link_add() for the
> given consumer/supplier pair has not passed DL_FLAG_STATELESS to it
> in flags, the driver core should track the status of the link and act
> on it as appropriate (ie. the link should be treated as "managed").
> This means that DL_FLAG_STATELESS needs to be set for managed device
> links and it should be valid to call device_link_del() or
> device_link_remove() to drop references to them in certain
> sutiations.
> 
> To allow that to happen, introduce a new (internal) device link flag
> called DL_FLAG_MANAGED and make device_link_add() set it automatically
> whenever DL_FLAG_STATELESS is not passed to it.  Also make it take
> additional references to existing device links that were previously
> stateless (that is, with DL_FLAG_STATELESS set and DL_FLAG_MANAGED
> unset) and will need to be managed going forward and initialize
> their status (which has been DL_STATE_NONE so far).
> 
> Accordingly, when a managed device link is dropped automatically
> by the driver core, make it clear DL_FLAG_MANAGED, reset the link's
> status back to DL_STATE_NONE and drop the reference to it associated
> with DL_FLAG_MANAGED instead of just deleting it right away (to
> allow it to stay around in case it still needs to be released
> explicitly by someone).
> 
> With that, since setting DL_FLAG_STATELESS doesn't mean that the
> device link in question is not managed any more, replace all of the
> status-tracking checks against DL_FLAG_STATELESS with analogous
> checks against DL_FLAG_MANAGED and update the documentation to
> reflect these changes.
> 
> While at it, make device_link_add() reject flags that it does not
> recognize, including DL_FLAG_MANAGED.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
> -> v2:
>    * Add a check to device_link_add() to return NULL if unrecognized flags are
>      passed to it.
>    * Modify kerneldoc comments around DL_FLAG_MANAGED.
> 
> I've tentatively added the Tested-by tag from Marek, because I don't expect
> the changes made between the initial posting and the v2 to make any difference
> for him.
> 
> ---
>  Documentation/driver-api/device_link.rst |    4 
>  drivers/base/core.c                      |  176 +++++++++++++++++--------------
>  drivers/base/power/runtime.c             |    4 
>  include/linux/device.h                   |    4 
>  4 files changed, 106 insertions(+), 82 deletions(-)
> 
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -124,6 +124,50 @@ static int device_is_dependent(struct de
>  	return ret;
>  }
>  
> +static void device_link_init_status(struct device_link *link,
> +				    struct device *consumer,
> +				    struct device *supplier)
> +{
> +	switch (supplier->links.status) {
> +	case DL_DEV_PROBING:
> +		switch (consumer->links.status) {
> +		case DL_DEV_PROBING:
> +			/*
> +			 * A consumer driver can create a link to a supplier
> +			 * that has not completed its probing yet as long as it
> +			 * knows that the supplier is already functional (for
> +			 * example, it has just acquired some resources from the
> +			 * supplier).
> +			 */
> +			link->status = DL_STATE_CONSUMER_PROBE;
> +			break;
> +		default:
> +			link->status = DL_STATE_DORMANT;
> +			break;
> +		}
> +		break;
> +	case DL_DEV_DRIVER_BOUND:
> +		switch (consumer->links.status) {
> +		case DL_DEV_PROBING:
> +			link->status = DL_STATE_CONSUMER_PROBE;
> +			break;
> +		case DL_DEV_DRIVER_BOUND:
> +			link->status = DL_STATE_ACTIVE;
> +			break;
> +		default:
> +			link->status = DL_STATE_AVAILABLE;
> +			break;
> +		}
> +		break;
> +	case DL_DEV_UNBINDING:
> +		link->status = DL_STATE_SUPPLIER_UNBIND;
> +		break;
> +	default:
> +		link->status = DL_STATE_DORMANT;
> +		break;
> +	}
> +}
> +
>  static int device_reorder_to_tail(struct device *dev, void *not_used)
>  {
>  	struct device_link *link;
> @@ -165,6 +209,10 @@ void device_pm_move_to_tail(struct devic
>  	device_links_read_unlock(idx);
>  }
>  
> +#define DL_MANAGED_LINK_FLAGS (DL_FLAG_AUTOREMOVE_CONSUMER | \
> +			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
> +			       DL_FLAG_AUTOPROBE_CONSUMER)
> +
>  /**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
> @@ -179,9 +227,9 @@ void device_pm_move_to_tail(struct devic
>   * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
>   * ignored.
>   *
> - * If DL_FLAG_STATELESS is set in @flags, the link is not going to be managed by
> - * the driver core and, in particular, the caller of this function is expected
> - * to drop the reference to the link acquired by it directly.
> + * If DL_FLAG_STATELESS is set in @flags, the caller of this function is
> + * expected to release the link returned by it directly with the help of either
> + * device_link_del() or device_link_remove().
>   *
>   * If that flag is not set, however, the caller of this function is handing the
>   * management of the link over to the driver core entirely and its return value
> @@ -201,9 +249,16 @@ void device_pm_move_to_tail(struct devic
>   * be used to request the driver core to automaticall probe for a consmer
>   * driver after successfully binding a driver to the supplier device.
>   *
> - * The combination of DL_FLAG_STATELESS and either DL_FLAG_AUTOREMOVE_CONSUMER
> - * or DL_FLAG_AUTOREMOVE_SUPPLIER set in @flags at the same time is invalid and
> - * will cause NULL to be returned upfront.
> + * The combination of DL_FLAG_STATELESS and one of DL_FLAG_AUTOREMOVE_CONSUMER,
> + * DL_FLAG_AUTOREMOVE_SUPPLIER, or DL_FLAG_AUTOPROBE_CONSUMER set in @flags at
> + * the same time is invalid and will cause NULL to be returned upfront.
> + * However, if a device link between the given @consumer and @supplier pair
> + * exists already when this function is called for them, the existing link will
> + * be returned regardless of its current type and status (the link's flags may
> + * be modified then).  The caller of this function is then expected to treat
> + * the link as though it has just been created, so (in particular) if
> + * DL_FLAG_STATELESS was passed in @flags, the link needs to be released
> + * explicitly when not needed any more (as stated above).
>   *
>   * A side effect of the link creation is re-ordering of dpm_list and the
>   * devices_kset list by moving the consumer device and all devices depending
> @@ -220,10 +275,8 @@ struct device_link *device_link_add(stru
>  	struct device_link *link;
>  
>  	if (!consumer || !supplier ||
> -	    (flags & DL_FLAG_STATELESS &&
> -	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
> -		      DL_FLAG_AUTOREMOVE_SUPPLIER |
> -		      DL_FLAG_AUTOPROBE_CONSUMER)) ||
> +	    (flags & ~(DL_FLAG_STATELESS | DL_MANAGED_LINK_FLAGS)) ||
> +	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
>  	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
>  	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
>  		      DL_FLAG_AUTOREMOVE_SUPPLIER)))
> @@ -236,6 +289,9 @@ struct device_link *device_link_add(stru
>  		}
>  	}
>  
> +	if (!(flags & DL_FLAG_STATELESS))
> +		flags |= DL_FLAG_MANAGED;
> +
>  	device_links_write_lock();
>  	device_pm_lock();
>  
> @@ -262,15 +318,6 @@ struct device_link *device_link_add(stru
>  		if (link->consumer != consumer)
>  			continue;
>  
> -		/*
> -		 * Don't return a stateless link if the caller wants a stateful
> -		 * one and vice versa.
> -		 */
> -		if (WARN_ON((flags & DL_FLAG_STATELESS) != (link->flags & DL_FLAG_STATELESS))) {
> -			link = NULL;
> -			goto out;
> -		}
> -
>  		if (flags & DL_FLAG_PM_RUNTIME) {
>  			if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
>  				pm_runtime_new_link(consumer);
> @@ -281,6 +328,7 @@ struct device_link *device_link_add(stru
>  		}
>  
>  		if (flags & DL_FLAG_STATELESS) {
> +			link->flags |= DL_FLAG_STATELESS;
>  			kref_get(&link->kref);
>  			goto out;
>  		}
> @@ -299,6 +347,11 @@ struct device_link *device_link_add(stru
>  			link->flags &= ~(DL_FLAG_AUTOREMOVE_CONSUMER |
>  					 DL_FLAG_AUTOREMOVE_SUPPLIER);
>  		}
> +		if (!(link->flags & DL_FLAG_MANAGED)) {
> +			kref_get(&link->kref);
> +			link->flags |= DL_FLAG_MANAGED;
> +			device_link_init_status(link, consumer, supplier);
> +		}
>  		goto out;
>  	}
>  
> @@ -325,48 +378,10 @@ struct device_link *device_link_add(stru
>  	kref_init(&link->kref);
>  
>  	/* Determine the initial link state. */
> -	if (flags & DL_FLAG_STATELESS) {
> +	if (flags & DL_FLAG_STATELESS)
>  		link->status = DL_STATE_NONE;
> -	} else {
> -		switch (supplier->links.status) {
> -		case DL_DEV_PROBING:
> -			switch (consumer->links.status) {
> -			case DL_DEV_PROBING:
> -				/*
> -				 * A consumer driver can create a link to a
> -				 * supplier that has not completed its probing
> -				 * yet as long as it knows that the supplier is
> -				 * already functional (for example, it has just
> -				 * acquired some resources from the supplier).
> -				 */
> -				link->status = DL_STATE_CONSUMER_PROBE;
> -				break;
> -			default:
> -				link->status = DL_STATE_DORMANT;
> -				break;
> -			}
> -			break;
> -		case DL_DEV_DRIVER_BOUND:
> -			switch (consumer->links.status) {
> -			case DL_DEV_PROBING:
> -				link->status = DL_STATE_CONSUMER_PROBE;
> -				break;
> -			case DL_DEV_DRIVER_BOUND:
> -				link->status = DL_STATE_ACTIVE;
> -				break;
> -			default:
> -				link->status = DL_STATE_AVAILABLE;
> -				break;
> -			}
> -			break;
> -		case DL_DEV_UNBINDING:
> -			link->status = DL_STATE_SUPPLIER_UNBIND;
> -			break;
> -		default:
> -			link->status = DL_STATE_DORMANT;
> -			break;
> -		}
> -	}
> +	else
> +		device_link_init_status(link, consumer, supplier);
>  
>  	/*
>  	 * Some callers expect the link creation during consumer driver probe to
> @@ -528,7 +543,7 @@ static void device_links_missing_supplie
>   * mark the link as "consumer probe in progress" to make the supplier removal
>   * wait for us to complete (or bad things may happen).
>   *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
>   */
>  int device_links_check_suppliers(struct device *dev)
>  {
> @@ -538,7 +553,7 @@ int device_links_check_suppliers(struct
>  	device_links_write_lock();
>  
>  	list_for_each_entry(link, &dev->links.suppliers, c_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		if (link->status != DL_STATE_AVAILABLE) {
> @@ -563,7 +578,7 @@ int device_links_check_suppliers(struct
>   *
>   * Also change the status of @dev's links to suppliers to "active".
>   *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
>   */
>  void device_links_driver_bound(struct device *dev)
>  {
> @@ -572,7 +587,7 @@ void device_links_driver_bound(struct de
>  	device_links_write_lock();
>  
>  	list_for_each_entry(link, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		/*
> @@ -593,7 +608,7 @@ void device_links_driver_bound(struct de
>  	}
>  
>  	list_for_each_entry(link, &dev->links.suppliers, c_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
> @@ -605,6 +620,13 @@ void device_links_driver_bound(struct de
>  	device_links_write_unlock();
>  }
>  
> +static void device_link_drop_managed(struct device_link *link)
> +{
> +	link->flags &= ~DL_FLAG_MANAGED;
> +	WRITE_ONCE(link->status, DL_STATE_NONE);
> +	kref_put(&link->kref, __device_link_del);
> +}
> +
>  /**
>   * __device_links_no_driver - Update links of a device without a driver.
>   * @dev: Device without a drvier.
> @@ -615,18 +637,18 @@ void device_links_driver_bound(struct de
>   * unless they already are in the "supplier unbind in progress" state in which
>   * case they need not be updated.
>   *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
>   */
>  static void __device_links_no_driver(struct device *dev)
>  {
>  	struct device_link *link, *ln;
>  
>  	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers, c_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
> -			__device_link_del(&link->kref);
> +			device_link_drop_managed(link);
>  		else if (link->status == DL_STATE_CONSUMER_PROBE ||
>  			 link->status == DL_STATE_ACTIVE)
>  			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> @@ -643,7 +665,7 @@ static void __device_links_no_driver(str
>   * %__device_links_no_driver() to update links to suppliers for it as
>   * appropriate.
>   *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
>   */
>  void device_links_no_driver(struct device *dev)
>  {
> @@ -652,7 +674,7 @@ void device_links_no_driver(struct devic
>  	device_links_write_lock();
>  
>  	list_for_each_entry(link, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		/*
> @@ -680,7 +702,7 @@ void device_links_no_driver(struct devic
>   * invoke %__device_links_no_driver() to update links to suppliers for it as
>   * appropriate.
>   *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
>   */
>  void device_links_driver_cleanup(struct device *dev)
>  {
> @@ -689,7 +711,7 @@ void device_links_driver_cleanup(struct
>  	device_links_write_lock();
>  
>  	list_for_each_entry_safe(link, ln, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
> @@ -702,7 +724,7 @@ void device_links_driver_cleanup(struct
>  		 */
>  		if (link->status == DL_STATE_SUPPLIER_UNBIND &&
>  		    link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
> -			__device_link_del(&link->kref);
> +			device_link_drop_managed(link);
>  
>  		WRITE_ONCE(link->status, DL_STATE_DORMANT);
>  	}
> @@ -724,7 +746,7 @@ void device_links_driver_cleanup(struct
>   *
>   * Return 'false' if there are no probing or active consumers.
>   *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
>   */
>  bool device_links_busy(struct device *dev)
>  {
> @@ -734,7 +756,7 @@ bool device_links_busy(struct device *de
>  	device_links_write_lock();
>  
>  	list_for_each_entry(link, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		if (link->status == DL_STATE_CONSUMER_PROBE
> @@ -764,7 +786,7 @@ bool device_links_busy(struct device *de
>   * driver to unbind and start over (the consumer will not re-probe as we have
>   * changed the state of the link already).
>   *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links without the DL_FLAG_MANAGED flag set are ignored.
>   */
>  void device_links_unbind_consumers(struct device *dev)
>  {
> @@ -776,7 +798,7 @@ void device_links_unbind_consumers(struc
>  	list_for_each_entry(link, &dev->links.consumers, s_node) {
>  		enum device_link_state status;
>  
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		status = link->status;
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1624,7 +1624,7 @@ void pm_runtime_remove(struct device *de
>   * runtime PM references to the device, drop the usage counter of the device
>   * (as many times as needed).
>   *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>   *
>   * Since the device is guaranteed to be runtime-active at the point this is
>   * called, nothing else needs to be done here.
> @@ -1641,7 +1641,7 @@ void pm_runtime_clean_up_links(struct de
>  	idx = device_links_read_lock();
>  
>  	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>  			continue;
>  
>  		while (refcount_dec_not_one(&link->rpm_active))
> Index: linux-pm/include/linux/device.h
> ===================================================================
> --- linux-pm.orig/include/linux/device.h
> +++ linux-pm/include/linux/device.h
> @@ -829,12 +829,13 @@ enum device_link_state {
>  /*
>   * Device link flags.
>   *
> - * STATELESS: The core won't track the presence of supplier/consumer drivers.
> + * STATELESS: The core will not remove this link automatically.
>   * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
>   * PM_RUNTIME: If set, the runtime PM framework will use this link.
>   * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
>   * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
>   * AUTOPROBE_CONSUMER: Probe consumer driver automatically after supplier binds.
> + * MANAGED: The core tracks presence of supplier/consumer drivers (internal).
>   */
>  #define DL_FLAG_STATELESS		BIT(0)
>  #define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
> @@ -842,6 +843,7 @@ enum device_link_state {
>  #define DL_FLAG_RPM_ACTIVE		BIT(3)
>  #define DL_FLAG_AUTOREMOVE_SUPPLIER	BIT(4)
>  #define DL_FLAG_AUTOPROBE_CONSUMER	BIT(5)
> +#define DL_FLAG_MANAGED			BIT(6)
>  
>  /**
>   * struct device_link - Device link representation.
> Index: linux-pm/Documentation/driver-api/device_link.rst
> ===================================================================
> --- linux-pm.orig/Documentation/driver-api/device_link.rst
> +++ linux-pm/Documentation/driver-api/device_link.rst
> @@ -78,8 +78,8 @@ typically deleted in its ``->remove`` ca
>  driver is compiled as a module, the device link is added on module load and
>  orderly deleted on unload.  The same restrictions that apply to device link
>  addition (e.g. exclusion of a parallel suspend/resume transition) apply equally
> -to deletion.  Device links with ``DL_FLAG_STATELESS`` unset (i.e. managed
> -device links) are deleted automatically by the driver core.
> +to deletion.  Device links managed by the driver core are deleted automatically
> +by it.
>  
>  Several flags may be specified on device link addition, two of which
>  have already been mentioned above:  ``DL_FLAG_STATELESS`` to express that no
> 
> 
> 
> 

Hello Rafael,

This patch breaks NVIDIA Tegra DRM driver, which fails to probe now
using the recent linux-next.

	tegra-dc 54240000.dc: failed to link controllers
