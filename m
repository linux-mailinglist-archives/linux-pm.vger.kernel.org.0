Return-Path: <linux-pm+bounces-19404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5C9F5E57
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 06:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A09316B761
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 05:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10183153808;
	Wed, 18 Dec 2024 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DzY2xKjU"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52935956
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500522; cv=none; b=jfdQmmYwwGtuqrJdnVsJ3yq1BVq0/RZ8/36Gmf4b817ZXrY/DkJyiggUC7DVcsFQaii/QU6MmIZ28wkQIigclskVlRw1W25r6xtFcNyAVmNfsexrcir9PWdAN8gLleALtupSCkrQzLptv1S4O1wY5o4LlInBtnj3f0jIYp4b6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500522; c=relaxed/simple;
	bh=ZIGTra4dp5GueNEsxOFnW9w2mLrMtOxbLYliE6xTHmE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qojPHGRxt4ZyiKchmDW7V0HEI8VL4JUpRgFXlJzdRrQEP0Uf2iieQrhJmvPQ6VeRCX5mdMTmHSky2kXDloQy7obCn/asYuBaCNJSf7DoOWaSgkqeIVsJLuY3Jey0Y+vX3vy+6mMNSzz3qwKtPaXry1IioQmDASm++bKQD1klZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DzY2xKjU; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BI5fpA8065782;
	Tue, 17 Dec 2024 23:41:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734500511;
	bh=uyT5WEtjuzlbql5YUfbXGtCgTW6L7QubMCfvqNeigW0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DzY2xKjUFVP1gIe9m5JXzbWqCZuj4s+HnrqaywgQjd1GA7sjAlWJO7mtgwxTdCTlc
	 BFou/kEznYfI7i0TtxGUtEp8LwlotvB4t6s8/Sx7Kgvy9w6rxMHqEfifegDb8vVcYa
	 t86e/SI2+Fx5pMIyeDQu8mLG7b1/5pN3wvlLo7OA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI5fpEO056841;
	Tue, 17 Dec 2024 23:41:51 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 23:41:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 23:41:51 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI5fod8112547;
	Tue, 17 Dec 2024 23:41:50 -0600
Date: Wed, 18 Dec 2024 11:11:50 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] PM: wakeup: implement devm_device_init_wakeup() helper
Message-ID: <20241218054150.h5aqbuaspyfivka5@lcpd911>
References: <20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241216080159.ahpzlioy7l5etn3y@lcpd911>
 <a114e49b-b7e6-462a-a91c-4e1b85db7b30@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a114e49b-b7e6-462a-a91c-4e1b85db7b30@pf.is.s.u-tokyo.ac.jp>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Joe,

On Dec 18, 2024 at 13:10:01 +0900, Joe Hattori wrote:
> Thank you for your review.
> 
> On 12/16/24 17:01, Dhruva Gole wrote:
> > On Dec 14, 2024 at 11:16:52 +0900, Joe Hattori wrote:
> > > Some drivers that enable device wakeup fail to properly disable it
> > > during their cleanup, which results in a memory leak.
> > > 
> > > To address this, introduce devm_device_init_wakeup(), a managed variant
> > > of device_init_wakeup(dev, true). With this managed helper, wakeup
> > > functionality will be automatically disabled when the device is
> > > released, ensuring a more reliable cleanup process.
> > > 
> > > This need for this addition arose during a previous discussion [1].
> > > 
> > > [1]:
> > > https://lore.kernel.org/linux-rtc/20241212100403.3799667-1-joe@pf.is.s.u-tokyo.ac.jp/
> > > 
> > > Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> > > ---
> > > Changes in V2:
> > > - Utilize the device_init_wakeup() function.
[...]
> > > +/**
> > > + * devm_device_init_wakeup - Resource managed device wakeup initialization.
> > > + * @dev: Device to handle.
> > > + *
> > > + * This function is the devm managed version of device_init_wakeup(dev, true).
> > > + */
> > > +static inline int devm_device_init_wakeup(struct device *dev)
> > 
> > Rafael, Should I submit a patch series to convert the regular device_init_wakeup from int to void?
> > This anyway doesn't return anything but 0 today and I can already see
> > some drivers using if(device_init_wakeup) which would essentially be
> > just dead code. I can try and patch that up as well.
> > The fact that this is a return type `int` is quite misleading to it's
> > users I guess?

Kindly disregard this, I was looking at the #else part of PM_SLEEP config.
There is infact error handling being done in drivers/base/power/wakeup.c

> > 
> > > +{
> > > +	int err;
> > > +
> > > +	err = device_init_wakeup(dev, true);
> > > +	if (err) {
> > > +		device_set_wakeup_capable(dev, false);
> > 
> > I don't see any point to this check. I am not sure if there's any case
> > where device_init_wakeup returns anything but 0. Even if it did, setting
> > wakeup_capable false should be handled within init_wakeup and not here.
> 
> Makes sense. Addressed in the v3 patch.

Apologies for the confusion, I think the v2 patch itself is correct.
I overlooked the drivers/base/power/wakeup.c implementation.

You can add my R-by to the v2 version of this patch,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

