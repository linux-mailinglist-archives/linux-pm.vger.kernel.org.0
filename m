Return-Path: <linux-pm+bounces-21489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B036CA2ABEA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 15:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E84188994A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD213C816;
	Thu,  6 Feb 2025 14:55:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89D23644D;
	Thu,  6 Feb 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738853753; cv=none; b=tbDrJXsiThp4cjevKmuvfW5gcdGo20Vqsb2TR2yBwU7gSY4mFoSnXQPTtN9Gzw6yHoWNgTnZGqPErsmyNbb7CS+jir8QkaBHA+KEeUQocVe+eUdbmW7JbVXFdRmLm2Mkm1egPvCpJ7JnWXtPLcA2JWsw1P4FLT1RYrr4XTFHGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738853753; c=relaxed/simple;
	bh=5Mcfzo+f7cMwKxlMLNVrhCbFbv9u0PgrDR37PwKykSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI/vDWhizeQvzUI8Q67ebzKX92WlZu790uURz2hZ8JtW8Go0H/IdCnqHxEL0NSP1MXO8opmmjtB+kz+ZQpS2cNd1yN8ZVvdTCIQ813RTFbqDohBqdTxlJPOo2KmBggRUbdVSfDQyJkCmDbO9O/cLRr3ivlGTBushDZDImsuMQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A253B12FC;
	Thu,  6 Feb 2025 06:56:13 -0800 (PST)
Received: from [10.57.77.211] (unknown [10.57.77.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696CE3F58B;
	Thu,  6 Feb 2025 06:55:49 -0800 (PST)
Message-ID: <a24219b3-ef14-4694-914a-3c4004f3008e@arm.com>
Date: Thu, 6 Feb 2025 14:55:47 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 1/5] cpuidle: menu: Drop a redundant local
 variable
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <13699686.uLZWGnKmhe@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <13699686.uLZWGnKmhe@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 14:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Local variable min in get_typical_interval() is updated, but never
> accessed later, so drop it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -117,7 +117,7 @@
>  static unsigned int get_typical_interval(struct menu_device *data)
>  {
>  	int i, divisor;
> -	unsigned int min, max, thresh, avg;
> +	unsigned int max, thresh, avg;
>  	uint64_t sum, variance;
>  
>  	thresh = INT_MAX; /* Discard outliers above this value */
> @@ -125,7 +125,6 @@
>  again:
>  
>  	/* First calculate the average of past intervals */
> -	min = UINT_MAX;
>  	max = 0;
>  	sum = 0;
>  	divisor = 0;
> @@ -136,9 +135,6 @@
>  			divisor++;
>  			if (value > max)
>  				max = value;
> -
> -			if (value < min)
> -				min = value;
>  		}
>  	}
>  
> 
> 
> 

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

