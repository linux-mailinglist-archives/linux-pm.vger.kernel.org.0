Return-Path: <linux-pm+bounces-16262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987039AB821
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 23:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A851F23A77
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0C18C325;
	Tue, 22 Oct 2024 21:01:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2B513AD2A;
	Tue, 22 Oct 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630891; cv=none; b=NEFx7IMY/aMX2EvUpUDEINRGslApHEmSP+teEFipMVh4/SUu6fwTCv6tPi9R/D2fxRoV6p084sMzNsvetia91pnMQjoa73Emp/GkvNu+I32cYnf7PzXnZqGn1ZvlfYyhRT+vdIB3VWo0xEYJmAQd1Niqix8T7yh51zN9XQSLisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630891; c=relaxed/simple;
	bh=kbH5A0s7EYlGoM2ZBjU6qQyaBtw62kYJyDsljH/dlJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HD6VisXZv1WHjrVj4r8aQ0uyGs1MVtuuHWaBeny5lnKlWLT3yUIkQBe7GNB/k1fn9Kb3dhIX1OeLsyIOEYjhoyD0rfvodRsHhRZ5yKk7azo4T7YfJhUOBebBt+XYDtzD8iNfXKAP/uAzRXfZRfiMRSVx/NXaTDI0U8CHa/DPcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14C2A497;
	Tue, 22 Oct 2024 14:01:58 -0700 (PDT)
Received: from [10.57.56.252] (unknown [10.57.56.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 361673F71E;
	Tue, 22 Oct 2024 14:01:27 -0700 (PDT)
Message-ID: <2fc850b3-93af-4d8e-8a64-1c95942e911b@arm.com>
Date: Tue, 22 Oct 2024 22:02:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] thermal: core: Add and use thermal zone guard
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4985597.31r3eYUQgx@rjwysocki.net>
 <1930069.tdWV9SEqCh@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1930069.tdWV9SEqCh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 10/10/24 23:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add and use a guard for thermal zone locking.
> 
> This allows quite a few error code paths to be simplified among
> other things and brings in a noticeable code size reduction for
> a good measure.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new iteration of
> 
> https://lore.kernel.org/linux-pm/3241904.5fSG56mABF@rjwysocki.net/
> 
> that has been combined with
> 
> https://lore.kernel.org/linux-pm/4613601.LvFx2qVVIh@rjwysocki.net/
> 
> and rebased on top of
> 
> https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/
> 
> and
> 
> https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
> 
> ---
>   drivers/thermal/thermal_core.c    |   61 +++++++---------------------
>   drivers/thermal/thermal_core.h    |    4 +
>   drivers/thermal/thermal_debugfs.c |   25 +++++++----
>   drivers/thermal/thermal_helpers.c |   17 ++-----
>   drivers/thermal/thermal_hwmon.c   |    5 --
>   drivers/thermal/thermal_netlink.c |   21 ++-------
>   drivers/thermal/thermal_sysfs.c   |   81 ++++++++++++++++----------------------
>   drivers/thermal/thermal_trip.c    |    8 ---
>   8 files changed, 86 insertions(+), 136 deletions(-)
> 


[snip]

Surprise, how the code can look smaller using that
style with 'guard'.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

