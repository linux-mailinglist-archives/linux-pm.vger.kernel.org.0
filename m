Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC76A4EA
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfGPJ3Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:29:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43112 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfGPJ3Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:29:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190716092921euoutp02e066fd2df375075e78eb27695f1c0cf6~x2TPBm5Yq0545505455euoutp02H
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 09:29:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190716092921euoutp02e066fd2df375075e78eb27695f1c0cf6~x2TPBm5Yq0545505455euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563269362;
        bh=xG1GYZ4VManiJC8402HGYqtsY33SunbKSVnVLULcw+o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dn2spAJJ9XyyswwuCViYa/xYsSid94Ip8o9ixtvtczyV2EL0Ltw0kl2sSe4gK5DfK
         /r5QnyrH5L7Pfmqc58LkeLaR+ItNKqcoIrVkGO/gQf5XovtKoPJoj9HLoaC6GoflMO
         AKF+dR6Y5DV94V0+InbYsQNgY3+Dah+61iy9+eJg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190716092921eucas1p1bf923c1d5b5521f5514a216c7cb08f97~x2TOZRzI01783717837eucas1p1C;
        Tue, 16 Jul 2019 09:29:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6C.18.04298.0F89D2D5; Tue, 16
        Jul 2019 10:29:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190716092920eucas1p16360d8851854e851c1dc347f4f244fa2~x2TNphaea1653416534eucas1p1B;
        Tue, 16 Jul 2019 09:29:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716092920eusmtrp2e15ecc71272b373f5d8af8ef713c60c4~x2TNbes0Y2388223882eusmtrp2T;
        Tue, 16 Jul 2019 09:29:20 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-ce-5d2d98f0b92e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0B.1E.04146.0F89D2D5; Tue, 16
        Jul 2019 10:29:20 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716092919eusmtip2dcf6e39bd4bc687df70cc7fb89edb6e6~x2TM9zZC52513025130eusmtip2B;
        Tue, 16 Jul 2019 09:29:19 +0000 (GMT)
Subject: Re: [PATCH] driver core: Remove device link creation limitation
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2c8cc126-ca59-6bae-9fbc-5a011fc8cfd2@samsung.com>
Date:   Tue, 16 Jul 2019 11:29:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3121545.4lOhFoIcdQ@kreacher>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7ofZujGGrSvtbFoXryezaJl1iIW
        i8u75rBZfO49wmjx4rm0xZnTl1gtug79ZbM4vjbcgcNjwaZSjzvX9rB57J+7ht2jt/kdm8eW
        q+0sHp83yXnMaN/GGsAexWWTkpqTWZZapG+XwJWxa/4d9oKXsxgrFjU4NzBOrexi5OSQEDCR
        mDy1kamLkYtDSGAFo8TpGaugnC+MEu9frGWEcD4zSjTuaGXrYuQAa1m+WgAivpxR4tKKPWwQ
        zltGic9H17KAzBUW8JD4/f8DO4gtIhAnsXjeZWaQImaBx4wSrw/vYwRJsAkYSnS97WIDsXkF
        7CQ23T8M1swioCpx/d1RsLioQIzEzjc9zBA1ghInZz4Bq+EU0JJ48WUb2BxmAXmJ7W/nMEPY
        4hK3nswH+0FC4Bi7xI2tO5ggPnWReHvnHDuELSzx6vgWKFtG4v9OmIZmRomH59ayQzg9jBKX
        m2YwQlRZSxw+fpEVFADMApoS63fpQ4QdJZqmf4KGC5/EjbeCEEfwSUzaNp0ZIswr0dEmBFGt
        JjHr+Dq4tQcvXGKewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlpsmJdarlecmFtcmpeu
        l5yfu4kRmJ5O/zv+aQfj10tJhxgFOBiVeHhP7NGJFWJNLCuuzD3EKMHBrCTCa/tVO1aINyWx
        siq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QDo+xij3vL3GZf7XVr
        Nfre7XNp47flztFMMTMyj9X1uGVZXV1d+6hVYneuZNtj6ykf56zZe2PCpD13rq6aKeP+SWyd
        YcqEheXS35VZ31lnnPQJrj2ddjnXr1hFJy7xvZuwiPCSU6f7a/e+/Ob6432zkMnRhW/sahfO
        Xrv19Nckaxeu2tikTU5nuJRYijMSDbWYi4oTAfXOk0BLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xe7ofZujGGnxq5LdoXryezaJl1iIW
        i8u75rBZfO49wmjx4rm0xZnTl1gtug79ZbM4vjbcgcNjwaZSjzvX9rB57J+7ht2jt/kdm8eW
        q+0sHp83yXnMaN/GGsAepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJexa/4d9oKXsxgrFjU4NzBOrexi5OCQEDCRWL5aoIuRi0NIYCmjxKueiaxd
        jJxAcRmJk9MaoGxhiT/Xutggil4zSmzfNokFJCEs4CHx+/8HdhBbRCBO4tz9l2BFzAIPGSXe
        71/MBJIQEqiVuHDqLNgkNgFDia63IJM4OXgF7CQ23T8MNohFQFXi+rujYHFRgRiJfWe2s0PU
        CEqcnPkErIZTQEvixZdtjCA2s4CZxLzND5khbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0
        zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgNG479nPzDsZLG4MPMQpwMCrx8J7Y
        oxMrxJpYVlyZe4hRgoNZSYTX9qt2rBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnAxNFXkm8
        oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxnbZFt63tixuKqKbnN5c
        yz4SnFIxq1bpjjezwG/50talF7pjWH/F/75Vxig2wVjkevIZ/huK0o+7HyhEV5Zx67xNb+bT
        PDWjJfTcPaOPfP8Oex7J6pTOF9Xet9Vlyr6g1gepKpI3bmdvSYoz2Om5cscSmeNt8StsjqvF
        KZi213z1Cv3HvCFZiaU4I9FQi7moOBEAclJgStwCAAA=
X-CMS-MailID: 20190716092920eucas1p16360d8851854e851c1dc347f4f244fa2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190710101954epcas3p4e286836fa42a328cbd2d52b6852fa7c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190710101954epcas3p4e286836fa42a328cbd2d52b6852fa7c7
References: <CGME20190710101954epcas3p4e286836fa42a328cbd2d52b6852fa7c7@epcas3p4.samsung.com>
        <3121545.4lOhFoIcdQ@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 2019-07-10 12:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Exynos IOMMU works fine with those changes.

> ---
>   Documentation/driver-api/device_link.rst |    4
>   drivers/base/core.c                      |  169 +++++++++++++++++--------------
>   drivers/base/power/runtime.c             |    4
>   include/linux/device.h                   |    4
>   4 files changed, 102 insertions(+), 79 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -124,6 +124,50 @@ static int device_is_dependent(struct de
>   	return ret;
>   }
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
>   static int device_reorder_to_tail(struct device *dev, void *not_used)
>   {
>   	struct device_link *link;
> @@ -179,9 +223,9 @@ void device_pm_move_to_tail(struct devic
>    * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
>    * ignored.
>    *
> - * If DL_FLAG_STATELESS is set in @flags, the link is not going to be managed by
> - * the driver core and, in particular, the caller of this function is expected
> - * to drop the reference to the link acquired by it directly.
> + * If DL_FLAG_STATELESS is set in @flags, the caller of this function is
> + * expected to release the link returned by it directly with the help of either
> + * device_link_del() or device_link_remove().
>    *
>    * If that flag is not set, however, the caller of this function is handing the
>    * management of the link over to the driver core entirely and its return value
> @@ -201,9 +245,16 @@ void device_pm_move_to_tail(struct devic
>    * be used to request the driver core to automaticall probe for a consmer
>    * driver after successfully binding a driver to the supplier device.
>    *
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
>    *
>    * A side effect of the link creation is re-ordering of dpm_list and the
>    * devices_kset list by moving the consumer device and all devices depending
> @@ -223,7 +274,8 @@ struct device_link *device_link_add(stru
>   	    (flags & DL_FLAG_STATELESS &&
>   	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
>   		      DL_FLAG_AUTOREMOVE_SUPPLIER |
> -		      DL_FLAG_AUTOPROBE_CONSUMER)) ||
> +		      DL_FLAG_AUTOPROBE_CONSUMER |
> +		      DL_FLAG_MANAGED)) ||
>   	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
>   	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
>   		      DL_FLAG_AUTOREMOVE_SUPPLIER)))
> @@ -236,6 +288,9 @@ struct device_link *device_link_add(stru
>   		}
>   	}
>   
> +	if (!(flags & DL_FLAG_STATELESS))
> +		flags |= DL_FLAG_MANAGED;
> +
>   	device_links_write_lock();
>   	device_pm_lock();
>   
> @@ -262,15 +317,6 @@ struct device_link *device_link_add(stru
>   		if (link->consumer != consumer)
>   			continue;
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
>   		if (flags & DL_FLAG_PM_RUNTIME) {
>   			if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
>   				pm_runtime_new_link(consumer);
> @@ -281,6 +327,7 @@ struct device_link *device_link_add(stru
>   		}
>   
>   		if (flags & DL_FLAG_STATELESS) {
> +			link->flags |= DL_FLAG_STATELESS;
>   			kref_get(&link->kref);
>   			goto out;
>   		}
> @@ -299,6 +346,11 @@ struct device_link *device_link_add(stru
>   			link->flags &= ~(DL_FLAG_AUTOREMOVE_CONSUMER |
>   					 DL_FLAG_AUTOREMOVE_SUPPLIER);
>   		}
> +		if (!(link->flags & DL_FLAG_MANAGED)) {
> +			kref_get(&link->kref);
> +			link->flags |= DL_FLAG_MANAGED;
> +			device_link_init_status(link, consumer, supplier);
> +		}
>   		goto out;
>   	}
>   
> @@ -325,48 +377,10 @@ struct device_link *device_link_add(stru
>   	kref_init(&link->kref);
>   
>   	/* Determine the initial link state. */
> -	if (flags & DL_FLAG_STATELESS) {
> +	if (flags & DL_FLAG_STATELESS)
>   		link->status = DL_STATE_NONE;
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
>   	/*
>   	 * Some callers expect the link creation during consumer driver probe to
> @@ -528,7 +542,7 @@ static void device_links_missing_supplie
>    * mark the link as "consumer probe in progress" to make the supplier removal
>    * wait for us to complete (or bad things may happen).
>    *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>    */
>   int device_links_check_suppliers(struct device *dev)
>   {
> @@ -538,7 +552,7 @@ int device_links_check_suppliers(struct
>   	device_links_write_lock();
>   
>   	list_for_each_entry(link, &dev->links.suppliers, c_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		if (link->status != DL_STATE_AVAILABLE) {
> @@ -563,7 +577,7 @@ int device_links_check_suppliers(struct
>    *
>    * Also change the status of @dev's links to suppliers to "active".
>    *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>    */
>   void device_links_driver_bound(struct device *dev)
>   {
> @@ -572,7 +586,7 @@ void device_links_driver_bound(struct de
>   	device_links_write_lock();
>   
>   	list_for_each_entry(link, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		/*
> @@ -593,7 +607,7 @@ void device_links_driver_bound(struct de
>   	}
>   
>   	list_for_each_entry(link, &dev->links.suppliers, c_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
> @@ -605,6 +619,13 @@ void device_links_driver_bound(struct de
>   	device_links_write_unlock();
>   }
>   
> +static void device_link_drop_managed(struct device_link *link)
> +{
> +	link->flags &= ~DL_FLAG_MANAGED;
> +	WRITE_ONCE(link->status, DL_STATE_NONE);
> +	kref_put(&link->kref, __device_link_del);
> +}
> +
>   /**
>    * __device_links_no_driver - Update links of a device without a driver.
>    * @dev: Device without a drvier.
> @@ -615,18 +636,18 @@ void device_links_driver_bound(struct de
>    * unless they already are in the "supplier unbind in progress" state in which
>    * case they need not be updated.
>    *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>    */
>   static void __device_links_no_driver(struct device *dev)
>   {
>   	struct device_link *link, *ln;
>   
>   	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers, c_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
> -			__device_link_del(&link->kref);
> +			device_link_drop_managed(link);
>   		else if (link->status == DL_STATE_CONSUMER_PROBE ||
>   			 link->status == DL_STATE_ACTIVE)
>   			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> @@ -643,7 +664,7 @@ static void __device_links_no_driver(str
>    * %__device_links_no_driver() to update links to suppliers for it as
>    * appropriate.
>    *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>    */
>   void device_links_no_driver(struct device *dev)
>   {
> @@ -652,7 +673,7 @@ void device_links_no_driver(struct devic
>   	device_links_write_lock();
>   
>   	list_for_each_entry(link, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		/*
> @@ -680,7 +701,7 @@ void device_links_no_driver(struct devic
>    * invoke %__device_links_no_driver() to update links to suppliers for it as
>    * appropriate.
>    *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>    */
>   void device_links_driver_cleanup(struct device *dev)
>   {
> @@ -689,7 +710,7 @@ void device_links_driver_cleanup(struct
>   	device_links_write_lock();
>   
>   	list_for_each_entry_safe(link, ln, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
> @@ -702,7 +723,7 @@ void device_links_driver_cleanup(struct
>   		 */
>   		if (link->status == DL_STATE_SUPPLIER_UNBIND &&
>   		    link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
> -			__device_link_del(&link->kref);
> +			device_link_drop_managed(link);
>   
>   		WRITE_ONCE(link->status, DL_STATE_DORMANT);
>   	}
> @@ -724,7 +745,7 @@ void device_links_driver_cleanup(struct
>    *
>    * Return 'false' if there are no probing or active consumers.
>    *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>    */
>   bool device_links_busy(struct device *dev)
>   {
> @@ -734,7 +755,7 @@ bool device_links_busy(struct device *de
>   	device_links_write_lock();
>   
>   	list_for_each_entry(link, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		if (link->status == DL_STATE_CONSUMER_PROBE
> @@ -764,7 +785,7 @@ bool device_links_busy(struct device *de
>    * driver to unbind and start over (the consumer will not re-probe as we have
>    * changed the state of the link already).
>    *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>    */
>   void device_links_unbind_consumers(struct device *dev)
>   {
> @@ -776,7 +797,7 @@ void device_links_unbind_consumers(struc
>   	list_for_each_entry(link, &dev->links.consumers, s_node) {
>   		enum device_link_state status;
>   
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		status = link->status;
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1624,7 +1624,7 @@ void pm_runtime_remove(struct device *de
>    * runtime PM references to the device, drop the usage counter of the device
>    * (as many times as needed).
>    *
> - * Links with the DL_FLAG_STATELESS flag set are ignored.
> + * Links with the DL_FLAG_MANAGED flag unset are ignored.
>    *
>    * Since the device is guaranteed to be runtime-active at the point this is
>    * called, nothing else needs to be done here.
> @@ -1641,7 +1641,7 @@ void pm_runtime_clean_up_links(struct de
>   	idx = device_links_read_lock();
>   
>   	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
> -		if (link->flags & DL_FLAG_STATELESS)
> +		if (!(link->flags & DL_FLAG_MANAGED))
>   			continue;
>   
>   		while (refcount_dec_not_one(&link->rpm_active))
> Index: linux-pm/include/linux/device.h
> ===================================================================
> --- linux-pm.orig/include/linux/device.h
> +++ linux-pm/include/linux/device.h
> @@ -829,12 +829,13 @@ enum device_link_state {
>   /*
>    * Device link flags.
>    *
> - * STATELESS: The core won't track the presence of supplier/consumer drivers.
> + * STATELESS: The core will not remove this link automatically.
>    * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
>    * PM_RUNTIME: If set, the runtime PM framework will use this link.
>    * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
>    * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
>    * AUTOPROBE_CONSUMER: Probe consumer driver automatically after supplier binds.
> + * MANAGED: The core tracks presence of supplier/consumer drivers (internal).
>    */
>   #define DL_FLAG_STATELESS		BIT(0)
>   #define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
> @@ -842,6 +843,7 @@ enum device_link_state {
>   #define DL_FLAG_RPM_ACTIVE		BIT(3)
>   #define DL_FLAG_AUTOREMOVE_SUPPLIER	BIT(4)
>   #define DL_FLAG_AUTOPROBE_CONSUMER	BIT(5)
> +#define DL_FLAG_MANAGED			BIT(6)
>   
>   /**
>    * struct device_link - Device link representation.
> Index: linux-pm/Documentation/driver-api/device_link.rst
> ===================================================================
> --- linux-pm.orig/Documentation/driver-api/device_link.rst
> +++ linux-pm/Documentation/driver-api/device_link.rst
> @@ -78,8 +78,8 @@ typically deleted in its ``->remove`` ca
>   driver is compiled as a module, the device link is added on module load and
>   orderly deleted on unload.  The same restrictions that apply to device link
>   addition (e.g. exclusion of a parallel suspend/resume transition) apply equally
> -to deletion.  Device links with ``DL_FLAG_STATELESS`` unset (i.e. managed
> -device links) are deleted automatically by the driver core.
> +to deletion.  Device links managed by the driver core are deleted automatically
> +by it.
>   
>   Several flags may be specified on device link addition, two of which
>   have already been mentioned above:  ``DL_FLAG_STATELESS`` to express that no
>
>
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

