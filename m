Return-Path: <linux-pm+bounces-21676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB8A2EB00
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D8918859DF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B6B1CF5C0;
	Mon, 10 Feb 2025 11:25:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F2288A2;
	Mon, 10 Feb 2025 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186712; cv=none; b=FQpQiOYl5uzvdqQKvSQRq7vp217TLZi8Erqedy8cUZfCFOabnixCcONr4rqXnO4Lv95ci7cMBo0p+wfnRxG//4hAX2ron+cwHTj7S9Z0VexEz5EigvQAB1x5l6oYEfhBowklnKMVBns6IaMB25qQRgR0aM+xOJJGT+3qdqfukSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186712; c=relaxed/simple;
	bh=AevJJ+A4/vl0rMnJXDp7MPqelhzo4B16VM0ILy0ZqZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxmhqzJ2nHHYWGR7EInbowz9JLt8jENHBzj+Mcx2r5/qhSipqdJ5CG1Fnp1LsbXX2t1ZfqJrS6UH/ya/REXknRD9bxH6ljqAPwLS3/Bz5R7WL57CHkFrriDz2uvMET4Lfl1lTuzaM84vZv4udmOkiGQ+Hy3pKyyHyQpocfJ4FGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13F0B1007;
	Mon, 10 Feb 2025 03:25:32 -0800 (PST)
Received: from [10.57.77.229] (unknown [10.57.77.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34C6D3F5A1;
	Mon, 10 Feb 2025 03:25:09 -0800 (PST)
Message-ID: <764b2869-8023-45b2-bae9-5a24be1ea519@arm.com>
Date: Mon, 10 Feb 2025 11:25:07 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] PM: EM: Drop unused parameter from
 em_adjust_new_capacity()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <6137833.lOV4Wx5bFT@rjwysocki.net>
 <2369979.ElGaqSPkdT@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2369979.ElGaqSPkdT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/25 13:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The max_cap parameter is never used in em_adjust_new_capacity(), so
> drop it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   kernel/power/energy_model.c |    5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -728,8 +728,7 @@
>    * are correctly calculated.
>    */
>   static void em_adjust_new_capacity(struct device *dev,
> -				   struct em_perf_domain *pd,
> -				   u64 max_cap)
> +				   struct em_perf_domain *pd)
>   {
>   	struct em_perf_table __rcu *em_table;
>   
> @@ -800,7 +799,7 @@
>   			 cpu, cpu_capacity, em_max_perf);
>   
>   		dev = get_cpu_device(cpu);
> -		em_adjust_new_capacity(dev, pd, cpu_capacity);
> +		em_adjust_new_capacity(dev, pd);
>   	}
>   
>   	free_cpumask_var(cpu_done_mask);
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

