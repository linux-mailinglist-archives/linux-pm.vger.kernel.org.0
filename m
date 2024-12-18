Return-Path: <linux-pm+bounces-19405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E279F5ED9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 07:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F10F16E145
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 06:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C1154457;
	Wed, 18 Dec 2024 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wCmdlz+O"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30410153820
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504641; cv=none; b=I/EQV3vNPVkK5XhUvdOjQFeaIrchm8qgem545KS4kQ7s1Fy2j9MGwv5ZajHiiN8i/V4r4glomS9g9WbbuHnTM11l2H+mmYW7mJa5T5MzAtsyiXXkcm2o2nvjuoEzk6bbUs+6lc/Nbk6J0jPQUSTuwpiyc8Y/WeITpNmVTo/YQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504641; c=relaxed/simple;
	bh=OswvoKCCQGwroK3IhUr27ME1LHkJ4YqvIQtZawdfk38=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlAcN/eLa8pTJiF412RD56B2t5ktW+wPQ8af/NdPhVg2suW8gdY9OrvmCDn9jjj4e6O/nOxGAfeA5PJ7m0YZT5ih4snXvWcnS4ErwqfTmYIeHIHnV6JbNE0Mel11q8o3louSkuDAHPrL2qWAib3cZEkZvVYSWBV6BYj2Sa2Yx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wCmdlz+O; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BI6hbD7023182;
	Wed, 18 Dec 2024 00:43:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734504217;
	bh=cMEeMpB7nbMA2f2CS/en+ziqPkCLThoLVr9dMvEr7Po=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wCmdlz+OpFyootgf23Ncc+ZgWOgznp5qS4YTSWqq4qxhisjqU7e+dLrCFGfYDRd/g
	 2+LUWRqzEvI7qGGqDi9JrRB4v4l70tg4A/wphUcQa3SFUeLh1/Hi+y7+AmjmtlUCYf
	 AVYwIsm3oEybsdJeuwE8ZlgizMeLtiOzWZtRoBpg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI6hbV7096960;
	Wed, 18 Dec 2024 00:43:37 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 00:43:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 00:43:36 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI6haoP126594;
	Wed, 18 Dec 2024 00:43:36 -0600
Date: Wed, 18 Dec 2024 12:13:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
CC: <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] PM: wakeup: implement devm_device_init_wakeup() helper
Message-ID: <20241218064335.c72gmw56ogtp36a2@lcpd911>
References: <20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241216080159.ahpzlioy7l5etn3y@lcpd911>
 <a114e49b-b7e6-462a-a91c-4e1b85db7b30@pf.is.s.u-tokyo.ac.jp>
 <20241218054150.h5aqbuaspyfivka5@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241218054150.h5aqbuaspyfivka5@lcpd911>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Rafael,

On Dec 18, 2024 at 11:11:50 +0530, Dhruva Gole wrote:
> Joe,
> 
> On Dec 18, 2024 at 13:10:01 +0900, Joe Hattori wrote:
> > Thank you for your review.
> > 
> > On 12/16/24 17:01, Dhruva Gole wrote:
> > > On Dec 14, 2024 at 11:16:52 +0900, Joe Hattori wrote:
> > > > Some drivers that enable device wakeup fail to properly disable it
> > > > during their cleanup, which results in a memory leak.
> > > > 
> > > > To address this, introduce devm_device_init_wakeup(), a managed variant
> > > > of device_init_wakeup(dev, true). With this managed helper, wakeup
> > > > functionality will be automatically disabled when the device is
> > > > released, ensuring a more reliable cleanup process.
> > > > 
> > > > This need for this addition arose during a previous discussion [1].
> > > > 
> > > > [1]:
> > > > https://lore.kernel.org/linux-rtc/20241212100403.3799667-1-joe@pf.is.s.u-tokyo.ac.jp/
> > > > 
> > > > Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> > > > ---
> > > > Changes in V2:
> > > > - Utilize the device_init_wakeup() function.
> [...]
> > > > +/**
> > > > + * devm_device_init_wakeup - Resource managed device wakeup initialization.
> > > > + * @dev: Device to handle.
> > > > + *
> > > > + * This function is the devm managed version of device_init_wakeup(dev, true).
> > > > + */
> > > > +static inline int devm_device_init_wakeup(struct device *dev)
> > > 
> > > Rafael, Should I submit a patch series to convert the regular device_init_wakeup from int to void?
> > > This anyway doesn't return anything but 0 today and I can already see
> > > some drivers using if(device_init_wakeup) which would essentially be
> > > just dead code. I can try and patch that up as well.
> > > The fact that this is a return type `int` is quite misleading to it's
> > > users I guess?
> 
> Kindly disregard this, I was looking at the #else part of PM_SLEEP config.
> There is infact error handling being done in drivers/base/power/wakeup.c
> 
> > > 
> > > > +{
> > > > +	int err;
> > > > +
> > > > +	err = device_init_wakeup(dev, true);
> > > > +	if (err) {
> > > > +		device_set_wakeup_capable(dev, false);
> > > 
> > > I don't see any point to this check. I am not sure if there's any case
> > > where device_init_wakeup returns anything but 0. Even if it did, setting
> > > wakeup_capable false should be handled within init_wakeup and not here.
> > 
> > Makes sense. Addressed in the v3 patch.
> 
> Apologies for the confusion, I think the v2 patch itself is correct.
> I overlooked the drivers/base/power/wakeup.c implementation.

As I review this code further, I am forming the opinion that device_init_wakeup
itself needs to be patched up here, because if a certain API is enabling
something, it should take care of disabling it in error scenarios. What
I am essentially suggesting is something like this:

8<----------------------------------------------------------------------------
                device_set_wakeup_capable(dev, true);
-               return device_wakeup_enable(dev);
+               err = device_wakeup_enable(dev);
+               if (err)
+                       device_set_wakeup_capable(dev, false);
----------------------------------------------------------------------------->8

Joe, would you be able to patch up the device_init_wakeup if Rafael is
onboard with this idea? You would need to update this patch accordingly
as well.


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

