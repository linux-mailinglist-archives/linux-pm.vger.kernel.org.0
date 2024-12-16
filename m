Return-Path: <linux-pm+bounces-19283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8599F2B73
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 09:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE9E188ADA6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14461FF615;
	Mon, 16 Dec 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FDLKNRaz"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE01FF61B
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336142; cv=none; b=s+8MxEHSgRq6JhccPiV/eRh7A0k3UH3bKPTYXArxPiGV2KeMNjPrEqmnWQd6z9a61mheXjzBGhbtt8Q/RbhFPYphb169H/SsstZBTZyz+Vnw+O6yuC3YBz44DJAXAM50H3CT82DSnII3lwbZT8MhIEnNu62RhNLKI7a1DbiYqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336142; c=relaxed/simple;
	bh=0aVkJxjmvGMyuPP7VC0DUHXa8E2ISBqZJr0QkCbtzrk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsOkLpIDWMGZDm/kqoy0xIlkqIpkzB3G56QAKYADLwoOpbUBy7MXMBJkw+ra1eBogRme/ZYChHiXPoZju9JB505EX7HvA7Mpnk5FDGDFxq9VvKdwzCPs+XxxHl22YcPbfPRdv4uxqHLsfN1YqeKHiw2SUG+zZKKOA1m0EXJGUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FDLKNRaz; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BG820qf3444736
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Dec 2024 02:02:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734336120;
	bh=K6JchWvei+vNFGCiINIK4BQf9fgm8xFq2iHLLhDkCvQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FDLKNRazI6dyvFBtvyAi7migSs+XRClx9YEJX8qBd9ak6/fzKDlybjCgOFhholJwb
	 uP6jeHpo0DL/7pSmJtto/auLQ+v4Zw9YysEaar82LVKdNJnghkScIUPQ+BTTt4DOod
	 NvfBgDqYpZ5dMqI/OXIyJ+3N8M5B/ImfkStxlUvY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BG820VJ019688;
	Mon, 16 Dec 2024 02:02:00 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Dec 2024 02:02:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Dec 2024 02:02:00 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BG81xa5004712;
	Mon, 16 Dec 2024 02:02:00 -0600
Date: Mon, 16 Dec 2024 13:31:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] PM: wakeup: implement devm_device_init_wakeup() helper
Message-ID: <20241216080159.ahpzlioy7l5etn3y@lcpd911>
References: <20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Dec 14, 2024 at 11:16:52 +0900, Joe Hattori wrote:
> Some drivers that enable device wakeup fail to properly disable it
> during their cleanup, which results in a memory leak.
> 
> To address this, introduce devm_device_init_wakeup(), a managed variant
> of device_init_wakeup(dev, true). With this managed helper, wakeup
> functionality will be automatically disabled when the device is
> released, ensuring a more reliable cleanup process.
> 
> This need for this addition arose during a previous discussion [1].
> 
> [1]:
> https://lore.kernel.org/linux-rtc/20241212100403.3799667-1-joe@pf.is.s.u-tokyo.ac.jp/
> 
> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes in V2:
> - Utilize the device_init_wakeup() function.

You took my suggestion, but forgot to put me in CC I guess :)

[...]
> +/**
> + * devm_device_init_wakeup - Resource managed device wakeup initialization.
> + * @dev: Device to handle.
> + *
> + * This function is the devm managed version of device_init_wakeup(dev, true).
> + */
> +static inline int devm_device_init_wakeup(struct device *dev)

Rafael, Should I submit a patch series to convert the regular device_init_wakeup from int to void?
This anyway doesn't return anything but 0 today and I can already see
some drivers using if(device_init_wakeup) which would essentially be
just dead code. I can try and patch that up as well.
The fact that this is a return type `int` is quite misleading to it's
users I guess?

> +{
> +	int err;
> +
> +	err = device_init_wakeup(dev, true);
> +	if (err) {
> +		device_set_wakeup_capable(dev, false);

I don't see any point to this check. I am not sure if there's any case
where device_init_wakeup returns anything but 0. Even if it did, setting
wakeup_capable false should be handled within init_wakeup and not here.

> +		return err;

With above taken into consideration, you don't need to return err.

> +	}
> +	return devm_add_action_or_reset(dev, device_disable_wakeup, dev);

This much maybe enough, in that case let's keep the devm_ version as
return type int just for this.


Also, please CC all involved folks in future revisions. People have
filters setup which may prevent them from looking at all emails that
come on a list. Best way to grab their attention is by CC-ing them on
each patch/ series.

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

