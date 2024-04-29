Return-Path: <linux-pm+bounces-7252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF38B524E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 09:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA121F21AC9
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666613FF2;
	Mon, 29 Apr 2024 07:26:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D7134BE;
	Mon, 29 Apr 2024 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375563; cv=none; b=iW/+7hpS9/6+EjR9y50KqJ+crapm0wV1tA7yI2cmS9ALRN3ZTLWL8R6M/qkkW3gxOXKzP/kq7vfXMNdpJh9SfdEJhyx661bK2Wdnjr6Jxo0PcHEQF51n8bxtk7y54NkwjH1IaNU1VAsOVTxQ91u4zWoXuH9Z/QjgD3Ht6vUozvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375563; c=relaxed/simple;
	bh=C4Vk9bV097FSvsDqyI9ZG/4zzmDvRZlVq5Q782H8A3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvo3AK+M08aTXgD0CyDjFFDjbxS1p7KBlxmN7qQ19cfqdxG6CMsRjDdKmaCbXfd4KB6OaKvpARsxWSws1MvH36ShWBWTmxpYcbH23QcywkZn+Z9rUwZGvzoNlyuIsYBbUSP9R2QgliRwJMti/u8/Otxc0kUJtqpeuyP1vzOW5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05DC82F4;
	Mon, 29 Apr 2024 00:26:27 -0700 (PDT)
Received: from [10.57.65.146] (unknown [10.57.65.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E37213F73F;
	Mon, 29 Apr 2024 00:25:58 -0700 (PDT)
Message-ID: <112097fd-5c9a-412d-8e66-dfe632c8fce7@arm.com>
Date: Mon, 29 Apr 2024 08:25:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Add missing empty code line
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <3563200.iIbC2pHGDl@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3563200.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 15:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add missing empty line of code to thermal_zone_trip_id().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_trip.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -138,6 +138,7 @@ int thermal_zone_trip_id(const struct th
>   	 */
>   	return trip_to_trip_desc(trip) - tz->trips;
>   }
> +
>   void thermal_zone_trip_updated(struct thermal_zone_device *tz,
>   			       const struct thermal_trip *trip)
>   {
> 
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

