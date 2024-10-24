Return-Path: <linux-pm+bounces-16359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE529AE258
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4511C21734
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A81B0F2B;
	Thu, 24 Oct 2024 10:19:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8E16FF3B;
	Thu, 24 Oct 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765141; cv=none; b=XQcJOXZoB+OcwAuq5LncsBLZA5lmHC4ibygDRFsOBiSqc56w0zAY9QHfDb7XDRDJWneIv1SEHE8+umcxnx9An0hZyB57S7fOiF/sta/00POappzwR1HQuC/IIzri9YolGGudpImXeBUv/ZxgG17AaH+5jV5xrSZJ5SP2c1MbLek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765141; c=relaxed/simple;
	bh=PUk3IqmlGCyU7ZIP8JMkimSthhPMe9k/JMkydjpVAhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtFqoUTZ+LHd5mhJClyr7Ug5BAVMZws7lIOJ4cuTOYf0eatyPWfQrSpE+Ryf0hF9KIm47mBQ0UA999xeTdQCbvFitclKPOf4Qz5R2YS93FtdyH02JL1IKmf4GQ63zecog+4Yom4k+vRbecTFVGqnK7ltQHj+U1ZmBwL+kIIPX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1171339;
	Thu, 24 Oct 2024 03:19:26 -0700 (PDT)
Received: from [10.57.55.74] (unknown [10.57.55.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39AE33F71E;
	Thu, 24 Oct 2024 03:18:56 -0700 (PDT)
Message-ID: <2312fd25-28b0-42f7-9017-8eb2e408bfe1@arm.com>
Date: Thu, 24 Oct 2024 11:20:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] thermal: core: Rearrange
 __thermal_zone_device_update()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4958885.31r3eYUQgx@rjwysocki.net>
 <3323276.44csPzL39Z@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3323276.44csPzL39Z@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 12:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In preparation for subsequent changes, move the invocations of
> thermal_thresholds_handle() and thermal_zone_set_trips() in
> __thermal_zone_device_update() after the processing of the
> temporary trip lists.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -588,10 +588,6 @@ void __thermal_zone_device_update(struct
>   			high = td->threshold;
>   	}
>   
> -	thermal_thresholds_handle(tz, &low, &high);
> -
> -	thermal_zone_set_trips(tz, low, high);
> -
>   	list_for_each_entry_safe(td, next, &way_up_list, list_node) {
>   		thermal_trip_crossed(tz, &td->trip, governor, true);
>   		list_del_init(&td->list_node);
> @@ -602,6 +598,10 @@ void __thermal_zone_device_update(struct
>   		list_del_init(&td->list_node);
>   	}
>   
> +	thermal_thresholds_handle(tz, &low, &high);
> +
> +	thermal_zone_set_trips(tz, low, high);
> +
>   	if (governor->manage)
>   		governor->manage(tz);
>   
> 
> 
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

