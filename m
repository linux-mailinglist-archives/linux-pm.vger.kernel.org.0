Return-Path: <linux-pm+bounces-36031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BEFBD772E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F51C4E8E44
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7B2749CB;
	Tue, 14 Oct 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YP4UjDll"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB7273D77;
	Tue, 14 Oct 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420190; cv=none; b=BYaJ21MRhfnTwDONQKosrbCqd3pXJ6pCDgUgztVaOvsBTpSA8sLoEp5sProOsUhU9Ce2wQcHqnUUUNowd2gDFwP/QJ9L9HpRyWPmUW2W9kUDP6dwTam9CTPp6914oBV5YhFG+nKbaamRKKQuGBmxFY3t94pYIp7TOGmZMi6jOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420190; c=relaxed/simple;
	bh=dZyO5AYkdCnAgw3zHe29BHULyuRscIXqSL4WQ9OiMqE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snzYK3UDtFOF9CUrOG+pahzPVLYxcSdogsgEC6LE11Z9FIMU0JDxLvP77FA1tF+Zb4S0Gn2ccAIV8AY0S9BPraBwjX/zLEv2KF9sA723SYo5xp1UXQAldAYj9jvwDJj2+Z9WShl4qbhqRp1+mmn7BNbRjBhR8kQcZmBS4mq1whs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YP4UjDll; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E5aAnm1427772;
	Tue, 14 Oct 2025 00:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760420170;
	bh=+BnS+zjoHibuRNFFkUP4V+Q1q9TD2gqlW/L3pZgLjBc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YP4UjDlltxFOMRTzX7smUSH82BtShjxkb+SnjZL6rvOjWoPV5NZKiwN0uyVaiXM81
	 8eEpIfA5x3JbwBOvdWSOpVzMb0j4ROW1hCS5j+3Gw+8svx+nTGJymcg96QL0gfO6jb
	 WcFhWLtPraMEq0bgDHAueE0FmGFg/GioJIXWnUZg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E5a9Sv3569395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 14 Oct 2025 00:36:10 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 14
 Oct 2025 00:36:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 00:36:09 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E5a83T3047771;
	Tue, 14 Oct 2025 00:36:09 -0500
Date: Tue, 14 Oct 2025 11:06:08 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Malaya Kumar Rout <mrout@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <lyude@redhat.com>,
        <malayarout91@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown
	<lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM: console: Fix memory allocation error handling in
 pm_vt_switch_required()
Message-ID: <20251014053608.pwlnexeh7mwjrvsc@lcpd911>
References: <20251013193028.89570-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251013193028.89570-1-mrout@redhat.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 14, 2025 at 01:00:27 +0530, Malaya Kumar Rout wrote:
>   The pm_vt_switch_required() function fails silently when memory
>   allocation fails, offering no indication to callers that the operation
>   was unsuccessful. This behavior prevents drivers from handling allocation
>   errors correctly or implementing retry mechanisms. By ensuring that
>   failures are reported back to the caller, drivers can make informed
>   decisions, improve robustness, and avoid unexpected behavior during
>   critical power management operations.
> 
>   Change the function signature to return an integer error code and modify
>   the implementation to return -ENOMEM when kmalloc() fails. Update both
>   the function declaration and the inline stub in include/linux/pm.h to
>   maintain consistency across CONFIG_VT_CONSOLE_SLEEP configurations.
> 
>   The function now returns:
>   - 0 on success (including when updating existing entries)
>   - -ENOMEM when memory allocation fails
> 
>   This change improves error reporting without breaking existing callers,
>   as the current callers in drivers/video/fbdev/core/fbmem.c already
>   ignore the return value, making this a backward-compatible improvement.

Not sure why this commit message has been indented, but it's not
a big deal.

> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>

Btw you can't include a R-by tag in the very first revision of the
patch. This needs to come from Lyude on a public mailing list and only
then can it be picked up.

> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> ---
>  include/linux/pm.h     | 5 +++--
>  kernel/power/console.c | 8 ++++++--
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index cc7b2dc28574..a72e42eec130 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -25,11 +25,12 @@ extern void (*pm_power_off)(void);
>  
>  struct device; /* we have a circular dep with device.h */
>  #ifdef CONFIG_VT_CONSOLE_SLEEP
> -extern void pm_vt_switch_required(struct device *dev, bool required);
> +extern int pm_vt_switch_required(struct device *dev, bool required);
>  extern void pm_vt_switch_unregister(struct device *dev);
>  #else
> -static inline void pm_vt_switch_required(struct device *dev, bool required)
> +static inline int pm_vt_switch_required(struct device *dev, bool required)
>  {
> +	return 0;
>  }
>  static inline void pm_vt_switch_unregister(struct device *dev)
>  {
> diff --git a/kernel/power/console.c b/kernel/power/console.c
> index 19c48aa5355d..a906a0ac0f9b 100644
> --- a/kernel/power/console.c
> +++ b/kernel/power/console.c
> @@ -44,9 +44,10 @@ static LIST_HEAD(pm_vt_switch_list);
>   * no_console_suspend argument has been passed on the command line, VT
>   * switches will occur.
>   */
> -void pm_vt_switch_required(struct device *dev, bool required)
> +int pm_vt_switch_required(struct device *dev, bool required)
>  {
>  	struct pm_vt_switch *entry, *tmp;
> +	int ret = 0;
>  
>  	mutex_lock(&vt_switch_mutex);
>  	list_for_each_entry(tmp, &pm_vt_switch_list, head) {
> @@ -58,8 +59,10 @@ void pm_vt_switch_required(struct device *dev, bool required)
>  	}
>  
>  	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> -	if (!entry)
> +	if (!entry) {
> +		ret = -ENOMEM;
>  		goto out;
> +		}
>  
>  	entry->required = required;
>  	entry->dev = dev;
> @@ -67,6 +70,7 @@ void pm_vt_switch_required(struct device *dev, bool required)
>  	list_add(&entry->head, &pm_vt_switch_list);
>  out:
>  	mutex_unlock(&vt_switch_mutex);
> +	return ret;

I am fine with the overall improved error handling,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

