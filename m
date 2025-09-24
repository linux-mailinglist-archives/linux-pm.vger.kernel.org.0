Return-Path: <linux-pm+bounces-35280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F968B99FAC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944F77A7A65
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042122E339B;
	Wed, 24 Sep 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yw2yw/+O"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A12D738B
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719375; cv=none; b=LEEc8MVaJItuucNOtxE9ysD8oFmgXPMLTGYzhqe8DB41kzIiwdP2WmDR8QBsPcamVYgDTKwbpK5fEdtU/n+pZkPdJrrdpSOR5I/q8ANDV81W645qfVSpoWdDDjrVV1a045GMBDajRUOm+FT6o8wSdM+sOIlca/6uB4zTDy8vKuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719375; c=relaxed/simple;
	bh=gQiuHkCLvJW0ZHl/NnEoKI8Zb+sfwpiNS06+EZjYTbw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfyH+3U1cuTYQhZmfROxi33zh+Tvs80lmH+bMyrEKAddBZMpb+cOlOb/gZVYtTZUKF8Zi2EIDKRycgXAPoqu1KKADShWXVGOlNy4YbccCLHr0wm+w6wGb0EAkkGkNtUt6Mw7LyWkP9SeKX3i5+FyTjNee4tIl2qzHNcsEw3/odQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yw2yw/+O; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58OD9Lme1231160;
	Wed, 24 Sep 2025 08:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758719361;
	bh=hAITvT0uU0FB8rd6O06TMaheiJc3PRUhFziB5R05lRI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=yw2yw/+O/I5WnLeO8w5IdMIb7730f8EitbFTLvor9wWvyVI4sUC0Gfabut7P1IwEY
	 5/uRpy6C1JxND4qBEmfgmEfKKetipVN4KJRMEkNzPoq9Ji1owyZUe00zDezJHMzEXj
	 rGfOiCu26POTgfArQAOcPwj0Y8MBl0SfOnR81GVY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58OD9LMF2775920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 24 Sep 2025 08:09:21 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 08:09:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 08:09:20 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58OD9JYZ2046083;
	Wed, 24 Sep 2025 08:09:20 -0500
Date: Wed, 24 Sep 2025 18:39:19 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
CC: <rafael@kernel.org>, <pavel@kernel.org>, <gregkh@linuxfoundation.org>,
        <dakr@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] PM: Delete timer before removing wakeup source from
 list
Message-ID: <20250924130919.3a44k5jfagivruaa@lcpd911>
References: <20250924113738.1956768-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924113738.1956768-1-kaushlendra.kumar@intel.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 24, 2025 at 17:07:37 +0530, Kaushlendra Kumar wrote:
> Move timer_delete_sync() before list_del_rcu() in wakeup_source_remove()
> to improve the cleanup ordering and code clarity. This change ensures
> that the timer is stopped before removing the wakeup source from the
> events list, providing a more logical cleanup sequence.
> 
> While the current ordering is functionally correct, stopping the timer
> first makes the cleanup flow more intuitive and follows the general
> pattern of disabling active components before removing data structures.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - Reframed as cleanup/improvement rather than fix

Nit: See the git log and fix $subject to be PM: wakeup ...

> 
>  drivers/base/power/wakeup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..ae6ec9f04b61 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -189,12 +189,11 @@ static void wakeup_source_remove(struct wakeup_source *ws)
>  	if (WARN_ON(!ws))
>  		return;
>  
> +	timer_delete_sync(&ws->timer);
>  	raw_spin_lock_irqsave(&events_lock, flags);
>  	list_del_rcu(&ws->entry);
>  	raw_spin_unlock_irqrestore(&events_lock, flags);
>  	synchronize_srcu(&wakeup_srcu);
> -
> -	timer_delete_sync(&ws->timer);
>  	/*
>  	 * Clear timer.function to make wakeup_source_not_registered() treat
>  	 * this wakeup source as not registered.

Also, since we're doing cleanup, can you check if using
timer_shutdown_sync makes more sense and then we can remove
ws->timer.function = NULL; line after this because that's what the
kernel doc for timer_shutdown_sync says it does? 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

