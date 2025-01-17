Return-Path: <linux-pm+bounces-20605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51659A14B72
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 09:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743311679A1
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD51F8689;
	Fri, 17 Jan 2025 08:49:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C373C1F8929;
	Fri, 17 Jan 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103779; cv=none; b=aHHP9RtXNzQmNT9wpv8xdtlubI8q6NsbFqYAXqCmE6OaymZo5vPkwDGQ52R8tMtSJSeTeGlhxOPTsUvuy+C5acy+bAt4VrQAOzfi7JBgiIkl4q3G5GdiHkFsKXtyciJakLM/fJ6U1AtwGbSIKsqds2TnWv2tA+9gyFm7QPxpj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103779; c=relaxed/simple;
	bh=N6Pdba2da79W4K2MF+ce0BhPYQjw1zbrmnTU2n3l3ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpE4rN45/5TyOTSKGEdVko11j+1+B+bNZrjrhd6Ve36rhZcCAfuQf/8W/MYhg//Q+ebjiJ9MFPaBm9/RS8GtPdxejgWGa8wsMen/WOJY1KQnjY1Y9MoTNRN/U3t4vzv77It5xIS/QuZSrMJc1RIRT1yc0imtLz/cPEKqAPAHDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D34B11FB;
	Fri, 17 Jan 2025 00:50:05 -0800 (PST)
Received: from [10.57.76.33] (unknown [10.57.76.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF013F73F;
	Fri, 17 Jan 2025 00:49:36 -0800 (PST)
Message-ID: <f65d008c-1ccb-42b6-8200-c1553d2057ea@arm.com>
Date: Fri, 17 Jan 2025 08:51:18 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal: gov_bang_bang: Relocate regulation logic
 description
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <2772026.mvXUDI8C0e@rjwysocki.net>
 <4987649.31r3eYUQgx@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4987649.31r3eYUQgx@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/25 19:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the regulation logic description from the bang_bang_trip_crossed()
> kerneldoc to the preamble.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_bang_bang.c |   43 +++++++++++++++++++---------------------
>   1 file changed, 21 insertions(+), 22 deletions(-)
> 
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -7,6 +7,27 @@
>    *  Based on step_wise.c with following Copyrights:
>    *  Copyright (C) 2012 Intel Corp
>    *  Copyright (C) 2012 Durgadoss R <durgadoss.r@intel.com>
> + *
> + * Regulation Logic: a two point regulation, deliver cooling state depending
> + * on the previous state shown in this diagram:
> + *
> + *                Fan:   OFF    ON
> + *
> + *                              |
> + *                              |
> + *          trip_temp:    +---->+
> + *                        |     |        ^
> + *                        |     |        |
> + *                        |     |   Temperature
> + * (trip_temp - hyst):    +<----+
> + *                        |
> + *                        |
> + *                        |
> + *
> + *   * If the fan is not running and temperature exceeds trip_temp, the fan
> + *     gets turned on.
> + *   * In case the fan is running, temperature must fall below
> + *     (trip_temp - hyst) so that the fan gets turned off again.
>    */
>   
>   #include <linux/thermal.h>
> @@ -38,28 +59,6 @@
>    * @tz: thermal_zone_device
>    * @trip: the trip point
>    * @crossed_up: whether or not the trip has been crossed on the way up
> - *
> - * Regulation Logic: a two point regulation, deliver cooling state depending
> - * on the previous state shown in this diagram:
> - *
> - *                Fan:   OFF    ON
> - *
> - *                              |
> - *                              |
> - *          trip_temp:    +---->+
> - *                        |     |        ^
> - *                        |     |        |
> - *                        |     |   Temperature
> - * (trip_temp - hyst):    +<----+
> - *                        |
> - *                        |
> - *                        |
> - *
> - *   * If the fan is not running and temperature exceeds trip_temp, the fan
> - *     gets turned on.
> - *   * In case the fan is running, temperature must fall below
> - *     (trip_temp - hyst) so that the fan gets turned off again.
> - *
>    */
>   static void bang_bang_trip_crossed(struct thermal_zone_device *tz,
>   				   const struct thermal_trip *trip,
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

