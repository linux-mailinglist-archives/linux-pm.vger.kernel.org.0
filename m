Return-Path: <linux-pm+bounces-24746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F21A79DA9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E37A202F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCE1A23B8;
	Thu,  3 Apr 2025 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nddxr9Em"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF01804A;
	Thu,  3 Apr 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743667705; cv=none; b=ZPj2umYyoqtOnVfQxxCGI0pdE+HgA2Tx1DmchygENUU/qm6HFrr/4l18wK37+8rfL0Xcbd/B9iKP9cUK3Haxqs/35yR9+SSelISO4OkUCwc97G7W8xluP+HtpTKNvf/MU3PInZp8Fyqy+YJX/t23Wb05Ki01jcKi9cFRBaQICaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743667705; c=relaxed/simple;
	bh=KYQEXrtoliEOkO6v66wPT78X6fxUUDWGyRAYSxGfz1s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK5dx9AAJNCdNFOnIUBhjnYH/VVTa8/cXjF2tsszaSmU2KMYZctqq2zOdjHq0vWmVjEIqtFzQ2mgB8pYmsmAn7GIkeHvFns3MqQoy2hcfV7c0KyaJa2ptG7x/0azMsF4G5QJGZX2xMQWlEgMYLGl1XajDnTB4FWTvo1ba7fE5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Nddxr9Em; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53388HUl3643485
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Apr 2025 03:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743667697;
	bh=fWvO+78VAxjgQgIr3ZVahoSUSFMGJLmUIHRMvwyH8gs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Nddxr9EmmQwhRueoouymrUOk9b9ipC1PxiXGOXXZT9EX3xjFoQ4azdrCtwuPo4N+e
	 N6nCCYCNPy6scmQrhAY+/boodmgzfi2Eu5VgfWczY0icfWAbLZkjvIan3GEqeOgAzY
	 eQCJfhDU2nsFBbWkhDPTJ4Oey4yUjj9kW2FornMs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53388HkV007541
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Apr 2025 03:08:17 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 03:08:16 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Thu, 3 Apr
 2025 03:08:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 03:08:16 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53388GeN050233;
	Thu, 3 Apr 2025 03:08:16 -0500
Date: Thu, 3 Apr 2025 13:38:15 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmdomain: core: Reset genpd->states to avoid freeing
 invalid data
Message-ID: <20250403080815.jsdoydcczkeuvmy6@lcpd911>
References: <20250402120613.1116711-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250402120613.1116711-1-ulf.hansson@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Apr 02, 2025 at 14:06:13 +0200, Ulf Hansson wrote:
> If genpd_alloc_data() allocates data for the default power-states for the
> genpd, let's make sure to also reset the pointer in the error path. This
> makes sure a genpd provider driver doesn't end up trying to free the data
> again, but using an invalid pointer.

I maybe missing something but if kfree works similar to [1]GNU free() won't
it make the genpd->states NULL anyway? Have you actually seen scenarios
where the genpd->states is remaining non-NULL even after kfree?

[1]
https://www.gnu.org/software/libc/manual/html_node/Freeing-after-Malloc.html#:~:text=The%20free%20function%20deallocates%20the%20block%20of%20memory%20pointed%20at%20by%20ptr%20.&text=Occasionally%2C%20free%20can%20actually%20return,malloc%20to%20reuse%20the%20space.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 9b2f28b34bb5..c179464047fe 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2229,8 +2229,10 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
>  	return 0;
>  put:
>  	put_device(&genpd->dev);
> -	if (genpd->free_states == genpd_free_default_power_state)
> +	if (genpd->free_states == genpd_free_default_power_state) {
>  		kfree(genpd->states);
> +		genpd->states = NULL;

Also the coding convention for kfree in other places in pmdomains
doesn't seem to follow this practise either...

$> rg -A1 kfree drivers/pmdomain

Is this something we're planning to start following in pmdomains from
now on?

> +	}
>  free:
>  	if (genpd_is_cpu_domain(genpd))
>  		free_cpumask_var(genpd->cpus);
> -- 
> 2.43.0
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

