Return-Path: <linux-pm+bounces-36061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC5ABD8DEF
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083283B5FBF
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFC82D3EC1;
	Tue, 14 Oct 2025 11:01:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937621257A
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439696; cv=none; b=HqC7eDWg36YZb2Dwk7j/WegRO0O3MsjWXhvwx+cMy9qDs2QfWKS868UnjYEQ5tEgaPLiVSZVT2cqA4ObM+IDsNyXvrSHcMvRDfLKLX3OQnPsXwvo5LlIVhU4tPYUhOLywFXWMJlo1qNLO8QoQOOTfu/PJym3NFVvGAmPW4UPUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439696; c=relaxed/simple;
	bh=+AcnqcaB5dvvhF6e6thTJGJoAEZ2RyX/M071WD9+cTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAqG/XJuA8LFPKNdHfb2fjMF2P2QrrETez8tSZpMn/ecID6mFchlkYkjmXE9Ir0CFaG0GKvFOm6rwDHvKkDdkHEQpHEe0DhqjYja9rD9z/rTeK/SdKW90WBqWikMAX1rQknqDM49hdIAdm5Mwdn2c3tQrya5GRaLHu8ZoUQfM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D4F1A9A;
	Tue, 14 Oct 2025 04:01:26 -0700 (PDT)
Received: from [10.57.66.74] (unknown [10.57.66.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CBB83F66E;
	Tue, 14 Oct 2025 04:01:33 -0700 (PDT)
Message-ID: <7ee28623-01aa-4615-8f88-aeead4d48747@arm.com>
Date: Tue, 14 Oct 2025 12:01:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: energy_model: Replace kfree() with em_table_free()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, lukasz.luba@arm.com,
 rafael@kernel.org, pavel@kernel.org
Cc: linux-pm@vger.kernel.org
References: <20251013091621.1191919-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251013091621.1191919-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 10:16, Kaushlendra Kumar wrote:
> Replace kfree() with em_table_free() for error path of em_create_pd()
> to ensure proper cleanup of energy model tables. The em_table_free()
> function provides the correct deallocation mechanism for energy model
> table structures, ensuring consistent memory management throughout the
> energy model subsystem.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  kernel/power/energy_model.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 5f17d2e8e954..e8ae1f518b8a 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -441,7 +441,7 @@ static int em_create_pd(struct device *dev, int nr_states,
>  	return 0;
>  
>  free_pd_table:
> -	kfree(em_table);
> +	em_table_free(em_table);
>  free_pd:
>  	kfree(pd);
>  	return -EINVAL;

I guess this could carry the fixes tag as well.

