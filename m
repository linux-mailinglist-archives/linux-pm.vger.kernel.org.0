Return-Path: <linux-pm+bounces-16356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA19AE23E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13181F2493A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0111C07E9;
	Thu, 24 Oct 2024 10:15:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37AD1B85E2;
	Thu, 24 Oct 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764902; cv=none; b=NulF5sImcXmiji28MvDR1+XJAlbHri3hG+xIBLzhZz5OJF3Y6j+JX0CtWPH9m7jx8xrvcPRhYU8aJ8FC6EOCltKOgg3ODPG5tSxIpPW/0G0Mr7Ie9yZ9IIlLlUcs4v0y+aFOaOzD/d+Ips6ASu2iQLNAoSPh7C1AByJ4i7dwM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764902; c=relaxed/simple;
	bh=ioyIm5LOdbNuODKOs1KeF/8buyzMS1XKKu9JAurUQJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izWxGVz5YUqczdORM40ecHQJ+MchYjflOzwUrGlzIGSAXmp5K50+zhhQngAysK9nXz66Q2HpVKsG7bfDnBftcC1guCiP+z67OGaQeGZfogzOXWLucAambx5jP9rrv8GTR1psZdXzF5XizhBZmIkcNXIOwRPnF8F43mZGXWMzbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A4B8339;
	Thu, 24 Oct 2024 03:15:28 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7CBA3F71E;
	Thu, 24 Oct 2024 03:14:57 -0700 (PDT)
Message-ID: <859a66c0-3b80-41eb-ac8b-d6fdd0f400ad@arm.com>
Date: Thu, 24 Oct 2024 11:16:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/10] thermal: core: Rename trip list node in struct
 thermal_trip_desc
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <2201558.irdbgypaU6@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2201558.irdbgypaU6@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since the list node field in struct thermal_trip_desc is going to be
> used for purposes other than trip crossing notification, rename it
> to list_node.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |   10 +++++-----
>   drivers/thermal/thermal_core.h |    2 +-
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -414,13 +414,13 @@ static void add_trip_to_sorted_list(stru
>   	struct thermal_trip_desc *entry;
>   
>   	/* Assume that the new entry is likely to be the last one. */
> -	list_for_each_entry_reverse(entry, list, notify_list_node) {
> +	list_for_each_entry_reverse(entry, list, list_node) {
>   		if (entry->notify_temp <= td->notify_temp) {
> -			list_add(&td->notify_list_node, &entry->notify_list_node);
> +			list_add(&td->list_node, &entry->list_node);
>   			return;
>   		}
>   	}
> -	list_add(&td->notify_list_node, list);
> +	list_add(&td->list_node, list);
>   }
>   
>   static void handle_thermal_trip(struct thermal_zone_device *tz,
> @@ -586,10 +586,10 @@ void __thermal_zone_device_update(struct
>   
>   	thermal_zone_set_trips(tz, low, high);
>   
> -	list_for_each_entry(td, &way_up_list, notify_list_node)
> +	list_for_each_entry(td, &way_up_list, list_node)
>   		thermal_trip_crossed(tz, &td->trip, governor, true);
>   
> -	list_for_each_entry_reverse(td, &way_down_list, notify_list_node)
> +	list_for_each_entry_reverse(td, &way_down_list, list_node)
>   		thermal_trip_crossed(tz, &td->trip, governor, false);
>   
>   	if (governor->manage)
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -31,7 +31,7 @@ struct thermal_trip_attrs {
>   struct thermal_trip_desc {
>   	struct thermal_trip trip;
>   	struct thermal_trip_attrs trip_attrs;
> -	struct list_head notify_list_node;
> +	struct list_head list_node;
>   	struct list_head thermal_instances;
>   	int notify_temp;
>   	int threshold;
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

