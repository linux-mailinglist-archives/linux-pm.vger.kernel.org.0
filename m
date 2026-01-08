Return-Path: <linux-pm+bounces-40421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D68D01289
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 06:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0543E3000909
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 05:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B75329370;
	Thu,  8 Jan 2026 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HMvx4zGM"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72813016FA;
	Thu,  8 Jan 2026 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767851088; cv=none; b=n6eRJ8RSZGPh5Ml92Z/HzfHHJqNcdiJ57D8TxbGes8wMiQAQvdBJjSntmap72y7YW3Y9zPYcyBo2B5AAxjLLaTsTWmkamkOU2DgCyXGBSOXZaJK1zI04Lsip9soX7zXnaYDBdCe3qU5bcGlAiLGfj7+H16EkCDQRDKd7mvin4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767851088; c=relaxed/simple;
	bh=5iUhT103Yqyw/0ok0cFShc9ShKvLyW8JuCs19NsLOBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeycpeuMn+PVP+6yHnevXckka2tjmLVtRo4MoJTAZBff7ZaZItt/+oWExqRNyvXMUs/wLGUrosBxFBumQP+RkkmOxKUPSjZ8g3H2Ez0aCDmvz3JYMKY3eoFhbkf7UBikf0ufALE1PA6ZOh9ubT2pB4U/lifIH68JTpL68yGri50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HMvx4zGM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=syWwTtfHKmsDo9vdD6frHNqM+xfe8N776jazZVnjg0Q=; b=HMvx4zGMOF02dvqrqwy5O67IKs
	re8c16qtvocMNuDEA1bPK/BThPIXbTKVyqrqkHd65i5cCU/wbZPgsWLPZzYyZG56jDFVredoikawE
	iCSQtZBwO8X+006XDmVZqNCJzKIxYSlK2zNWO/Dlsd3q1/8flvIq0rUOwyrkk5hujk5MZ20C20M5h
	BuDBeKcjA5zBlY8S/IYct8YmK3Qe4xfDRvUHxMrFoJUn2nQyEhlGQ4dl2Qt3vdN9U/5qAtVpM6/V4
	oAYPKmmNh6naZPGjy4Ne27j0vhTM+Kjq4lOXXdOHvDgbCYTLcBGygguoT80QP065/DpJeI9OV+180
	T+YpivqQ==;
Received: from [58.29.143.236] (helo=[192.168.1.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vdip9-002qNy-IQ; Thu, 08 Jan 2026 06:44:43 +0100
Message-ID: <28e46f37-54be-4c28-a7a8-2b3e80a8cd30@igalia.com>
Date: Thu, 8 Jan 2026 14:44:38 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: Fix memory leak in em_create_pd() error path
To: Malaya Kumar Rout <mrout@redhat.com>, linux-kernel@vger.kernel.org
Cc: malayarout91@gmail.com, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
References: <20260105103730.65626-1-mrout@redhat.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20260105103730.65626-1-mrout@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks, Malaya, for the bug fix. This makes sense to me.

Reviewed-by:  Changwoo Min <changwoo@igalia.com>

On 1/5/26 7:37 PM, Malaya Kumar Rout wrote:
> When ida_alloc() fails in em_create_pd(), the function returns without
> freeing the previously allocated 'pd' structure, leading to a memory leak.
> The 'pd' pointer is allocated either at line 436 (for CPU devices with
> cpumask) or line 442 (for other devices) using kzalloc().
> 
> Additionally, the function incorrectly returns -ENOMEM when ida_alloc()
> fails, ignoring the actual error code returned by ida_alloc(), which can
> fail for reasons other than memory exhaustion.
> 
> Fix both issues by:
> 1. Freeing the 'pd' structure with kfree() when ida_alloc() fails
> 2. Returning the actual error code from ida_alloc() instead of -ENOMEM
> 
> This ensures proper cleanup on the error path and accurate error reporting.
> 
> Fixes: cbe5aeedecc7 ("PM: EM: Assign a unique ID when creating a performance domain")
> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> ---
>   kernel/power/energy_model.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 11af9f64aa82..5b055cbe5341 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -449,8 +449,10 @@ static int em_create_pd(struct device *dev, int nr_states,
>   	INIT_LIST_HEAD(&pd->node);
>   
>   	id = ida_alloc(&em_pd_ida, GFP_KERNEL);
> -	if (id < 0)
> -		return -ENOMEM;
> +	if (id < 0) {
> +		kfree(pd);
> +		return id;
> +	}
>   	pd->id = id;
>   
>   	em_table = em_table_alloc(pd);


