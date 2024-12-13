Return-Path: <linux-pm+bounces-19181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC69F07DD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 10:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00071679F6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9701B0F2D;
	Fri, 13 Dec 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jeZbG6Vq"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3221AF0B8
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082026; cv=none; b=XlywOi/wz+HPfIb9/ICZtczNQ4x7BkPglkI7Rn0SzsUEg6nshvq4+HQ+q6qQTd1h5DHesdlHAK/12ruJ54rw19PNUi7GdhuyLemB5JYIQtTBC7Zm9h4DmmiHgIB6ipKkqQpZZNzoI8QYtyGIVCVuWTi9U/zTuzJAP1bFW9AnT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082026; c=relaxed/simple;
	bh=XvosKj3IFTzLuSdfw7pP6pXfr7teaqBw4tj4xSTPj9M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj6QU5aBS5P9z7ysrcj8tDptOqP2AEKFvU3Hxxlr4gVDhuNUUhh6Zo8AtfYSEUAfzbi5q7q6JOlmAL+w2OSAD8k0IdCdW70GD2A8SjemAf4mLwO5L6QgIdCwnEjbxNZuwrg3BQ/0UKJgA5YoDL9qB4USF4m0tD44IPRn5CT/DPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jeZbG6Vq; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BD9Qien3067910
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 03:26:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734082004;
	bh=9e7IUZfvQF7tr0O2VRBJgF6kszA0xH2tU7pG/L43elY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jeZbG6Vq2+wOGPM/0mHFisxJDET+8WhbjZTmE7CeNJdsRMj1vVAVKuzFvVke0vnuc
	 2m96Mf6eTUjuUkv2n18RKglk7gqfiRKU3QWGQA6IkrQLxf1UX7cIh98Q3tTh48kjdf
	 3w6AJELOw5mesEf376FkFmBtiyOb8pUnmQq0wSrk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BD9QiR4020701
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 03:26:44 -0600
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 03:26:44 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Fri, 13 Dec
 2024 03:26:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 03:26:43 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BD9Qh94056229;
	Fri, 13 Dec 2024 03:26:43 -0600
Date: Fri, 13 Dec 2024 14:56:42 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] PM: wakeup: implement devm_device_init_wakeup() helper
Message-ID: <20241213092642.sq44raaty2ub6c7s@lcpd911>
References: <20241213035235.2479642-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241213035235.2479642-1-joe@pf.is.s.u-tokyo.ac.jp>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Dec 13, 2024 at 12:52:35 +0900, Joe Hattori wrote:
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

CC Alexandre who I see is an important part of this thread.

> 
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  include/linux/pm_wakeup.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 222f7530806c..baf4f982858a 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -240,4 +240,31 @@ static inline int device_init_wakeup(struct device *dev, bool enable)
>  	return 0;
>  }
>  
> +static void devm_device_disable_wakeup(void *data)
> +{
> +	struct device *dev = data;
> +
> +	device_wakeup_disable(dev);
> +	device_set_wakeup_capable(dev, false);
> +}
> +
> +/**
> + * devm_device_init_wakeup - Resource managed device wakeup initialization.
> + * @dev: Device to handle.
> + *
> + * This function is the devm managed version of device_init_wakeup(dev, true).
> + */
> +static inline int devm_device_init_wakeup(struct device *dev)
> +{
> +	int err;
> +
> +	device_set_wakeup_capable(dev, true);
> +	err = device_wakeup_enable(dev);
> +	if (err) {
> +		device_set_wakeup_capable(dev, false);
> +		return err;
> +	}
> +	return devm_add_action_or_reset(dev, devm_device_disable_wakeup, dev);

Why not just call in device_init_wakeup which already does all this for
you?


Then the devm_disable will just be device_init_wakeup(dev, false);


See for eg. how runtime pm does it:

	int devm_pm_runtime_enable(struct device *dev)
	{
		pm_runtime_enable(dev);

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

