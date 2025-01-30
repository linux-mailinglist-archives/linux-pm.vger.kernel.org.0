Return-Path: <linux-pm+bounces-21113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6657AA228C3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 07:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31D11885500
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 06:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214D1714A5;
	Thu, 30 Jan 2025 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g7fZzUTL"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15153143888;
	Thu, 30 Jan 2025 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217039; cv=none; b=H3pgP9lqUG0rAzQtoye/JKPK9hVTLHDYpv6ETbL4eLyuPH7SwLP0Av3SEalXgkVHcLkEjOlTocX7H82oNaA72jbmAFN4aP9MLT2grjLCCi7ihSIa0/7yMx98BcIogNhgwHfgCRrpVRHIOMv37cw3WK8XD4Gl5Soj5XBMYpABW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217039; c=relaxed/simple;
	bh=s1zUvTHRkaek8Npas98ir8k9p9BDNafnifvrQq/9uVI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6Zh+yHGLHaDbPsSx3DGGW4yMy9yR5C0Z0Qp9p374UhZ9BVNQF72qU1Xo9o6Dp2FFNJDbLA+x9mrNSw2ehf1EBm+qV5uM2YlRQlV+oF5mXwYm54ZUNSObslH7vHa6pM6+WVlEubB3jFbRsXFIIar1ayeMN74AJHlnSpyrHdbLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g7fZzUTL; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50U63jCP1439196
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 00:03:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738217026;
	bh=P5qPXySFcHqEAbBezikrxMrr4mwdZc+B2wFlGFVpSeY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=g7fZzUTLVzv6FGoxPxIR+yg8kotEXm0oNplgrgfqzVvE5t3Cuig7hSd0irnr6lh9C
	 lIts5NEDoh1svOSHEzDqzcBG8CUGl3s7ThyqqFUoluu0FSrCTVTO2SvzzxMKGXa68A
	 pAdE12VyfVuLxY0rxTlqVDHharWHUsa0EUpJBH90=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50U63jIQ100483
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jan 2025 00:03:45 -0600
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Jan 2025 00:03:45 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Thu, 30 Jan
 2025 00:03:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Jan 2025 00:03:45 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50U63iEw037602;
	Thu, 30 Jan 2025 00:03:45 -0600
Date: Thu, 30 Jan 2025 11:33:44 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Markus
 Schneider-Pargmann" <msp@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: Re: [RFC PATCH] PM: wakeup: set device_set_wakeup_capable to false
 in case of error
Message-ID: <20250130060344.phyq2toikbjcwciq@lcpd911>
References: <20250129112056.3051949-1-d-gole@ti.com>
 <CAJZ5v0iEoTapZP1-QHxe8UDc1oq3y12Tph0-mU=1NhPjNpYLQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iEoTapZP1-QHxe8UDc1oq3y12Tph0-mU=1NhPjNpYLQw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Rafael,

On Jan 29, 2025 at 17:18:24 +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 29, 2025 at 12:21 PM Dhruva Gole <d-gole@ti.com> wrote:
> >
> > In device_init_wakeup enable, we first set device_set_wakeup_capable to
> > true. However in case the device_wakeup_enable fails for whatever reason,
> > there was no error handling being done.
> > Consequenty, there was no cleanup being done to device_set_wakeup_capable.
> 
> s/Consequenty/Consequently/

My bad. I will fix it if we decide to revise this patch.

> 
> > If a certain API is enabling something, it should take care of disabling it
> > in error scenarios. In this case device_init_wakeup should on it's own
> > check for errors and clean up accordingly.
> 
> Why do you think that failing device_wakeup_enable() will always mean
> that the device is not in fact wakeup capable?

Well, I was looking at it more from a mirror image perspective.
By definition,
@enable: Whether or not to enable @dev as a wakeup device.

If this is false, then in that path we are marking device "not wakeup
capable".
Then why not apply the same logic if something goes bad while trying to
"enable" the device as wakeup?

Why must a device claim to be wakeup capable if device_wakeup_enable
went bad?

Or, then the other way round, why must we device_set_wakeup_capable
false in the case where we just want to disable the device wakeup?
It's not like we're taking away the capability itself right? Just
disabling it for that moment?

I am just trying to make sense of the definiton both ways, enable / disable.

> 
> > Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >
> > This patch was briefly proposed in a related thread [1], where this discussion
> > was taking place.
> > That probably got missed due to some confusion around the device_init_wakeup
> > return value.
> >
> > There is infact error returning being done in drivers/base/power/wakeup.c, and
> > ideally we should be using that info as done in this patch.
> >
> > If this patch get accepted, it might even bring forth few hidden bugs
> > due to missing error handling, and it will also change the patch for
> > devm_device_init_wakeup() helper slightly[2].
> >
> > [1] https://lore.kernel.org/linux-pm/20241218064335.c72gmw56ogtp36a2@lcpd911/
> > [2] https://lore.kernel.org/linux-pm/20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp/
> >
> > ---
> >  include/linux/pm_wakeup.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> > index d501c09c60cd..ed62a7055a54 100644
> > --- a/include/linux/pm_wakeup.h
> > +++ b/include/linux/pm_wakeup.h
> > @@ -231,9 +231,13 @@ static inline void pm_wakeup_hard_event(struct device *dev)
> >   */
> >  static inline int device_init_wakeup(struct device *dev, bool enable)
> >  {
> > +       int err;
> >         if (enable) {
> >                 device_set_wakeup_capable(dev, true);
> > -               return device_wakeup_enable(dev);
> > +               err = device_wakeup_enable(dev);
> > +               if (err)
> > +                       device_set_wakeup_capable(dev, false);
> > +               return err;
> >         }
> >         device_wakeup_disable(dev);
> >         device_set_wakeup_capable(dev, false);
> > --
> > 2.34.1
> >

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

