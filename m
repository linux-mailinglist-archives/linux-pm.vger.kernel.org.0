Return-Path: <linux-pm+bounces-22206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A564A3841C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5A41894FE4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3121CA06;
	Mon, 17 Feb 2025 13:08:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F921C9E3;
	Mon, 17 Feb 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797722; cv=none; b=QShD1iGkKV5mC1sp51+KCT4r1oslf52rWCNCG+MfGIpuHJEfDuow9BcYCdButv6rLpTupUFHSoXTxtz4NUZT0HiTBqr3gxkUY9P3TnK0DHJaSLSSNfUbK2Dt8ogCTX+1c0l8rU238/X5WVcFtH9iQlXdMUHN2KZ3Fh09BJrOQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797722; c=relaxed/simple;
	bh=NT0HD0OzFevfLE2gDviP3hodCw4MjieThR7YtJxsnXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngB/5v5Q+c+4D1rTkngVd5PXbNMZ32/PiczDtREPsCg0uebDfvR4RA88Q4TvHapZ1eGjW2jYL1UAX7kH7WpW9L1JubHQsZByPnsEutMhBBUTr01eHrf0fry/xzT0jeiHuMN6npOrkrJbazHwppb9f7qtFWpaMZD79dKzVf+yxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E3B13D5;
	Mon, 17 Feb 2025 05:08:57 -0800 (PST)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48AA3F6A8;
	Mon, 17 Feb 2025 05:08:37 -0800 (PST)
Message-ID: <6dbc4f0a-4bcf-4539-bd39-5cc9d31a5bcf@arm.com>
Date: Mon, 17 Feb 2025 13:08:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 3/5] cpuidle: menu: Tweak threshold use in
 get_typical_interval()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <8490144.T7Z3S40VBb@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <8490144.T7Z3S40VBb@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 14:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To prepare get_typical_interval() for subsequent changes, rearrange
> the use of the data point threshold in it a bit and initialize that
> threshold to UINT_MAX which is more consistent with its data type.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -116,7 +116,7 @@
>   */
>  static unsigned int get_typical_interval(struct menu_device *data)
>  {
> -	unsigned int max, divisor, thresh = INT_MAX;
> +	unsigned int max, divisor, thresh = UINT_MAX;
>  	u64 avg, variance, avg_sq;
>  	int i;
>  
> @@ -129,8 +129,8 @@
>  	for (i = 0; i < INTERVALS; i++) {
>  		unsigned int value = data->intervals[i];
>  
> -		/* Discard data points above the threshold. */
> -		if (value > thresh)
> +		/* Discard data points above or at the threshold. */
> +		if (value >= thresh)
>  			continue;
>  
>  		divisor++;
> @@ -186,7 +186,7 @@
>  	if ((divisor * 4) <= INTERVALS * 3)
>  		return UINT_MAX;
>  
> -	thresh = max - 1;
> +	thresh = max;
>  	goto again;
>  }
>  

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


