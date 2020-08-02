Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E14523595E
	for <lists+linux-pm@lfdr.de>; Sun,  2 Aug 2020 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHBQ56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 12:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgHBQ55 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Aug 2020 12:57:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699C2206E7;
        Sun,  2 Aug 2020 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596387477;
        bh=4kEI4l0aRvt5/h9g0xWJYrGj07HsmDRlUAaOJ6inO8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4kBPwEDJbjOZEMc2uLF1D0tsUTpknH0xW29TRuBcLEgXiLx4yHZIn2WnfIrkRR4C
         4Yd3SnOSonYPM+9KKcRRRIQT7Lq6mcM0UJ4+wrbuU3aMnIXr7IoJAbsNBq/F8ax6iE
         TimPI9pa+I4T1t74FfpoSVs6hrOK2uVf4dFxjufk=
Date:   Sun, 2 Aug 2020 18:57:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Qiwu Huang <yanziily@gmail.com>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangfei1@xiaomi.com, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v4 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200802165738.GA293244@kroah.com>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
 <20200802120015.GA1289@bug>
 <20200802123742.GA257810@kroah.com>
 <20200802142825.GA20261@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802142825.GA20261@amd>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 02, 2020 at 04:28:25PM +0200, Pavel Machek wrote:
> On Sun 2020-08-02 14:37:42, Greg KH wrote:
> > On Sun, Aug 02, 2020 at 02:00:15PM +0200, Pavel Machek wrote:
> > > On Mon 2020-07-20 13:47:14, Qiwu Huang wrote:
> > > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > 
> > > > Reports the kind of quick charge type based on
> > > > different adapter power.
> > > > 
> > > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++++++++++++++
> > > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > > >  include/linux/power_supply.h                | 10 ++++++++++
> > > >  3 files changed, 32 insertions(+)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > > > index 216d61a22f1e..dd3773dcf16a 100644
> > > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > > @@ -708,3 +708,24 @@ Description:
> > > >  
> > > >  		Access: Read
> > > >  		Valid values: 1-31
> > > > +
> > > > +What:		/sys/class/power_supply/<supply_name>/quick_charge_type
> > > > +Date:		Jul 2020
> > > > +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> > > > +		Description:
> > > > +		Reports the kind of quick charge type based on different adapter power.
> > > > +		Different quick charge type represent different charging power.
> > > > +		QUICK_CHARGE_NORMAL : Charging Power <= 10W
> > > > +		QUICK_CHARGE_FAST : 10W < Charging Power <= 20W
> > > > +		QUICK_CHARGE_FLASH : 20W < Charging Power <= 30W
> > > > +		QUICK_CHARGE_TURBE : 30W < Charging Power <= 50W
> > > > +		QUICK_CHARGE_SUPER : Charging Power > 50W
> > > > +
> > > > +		Access: Read-Only
> > > > +		Valid values:
> > > > +			0: QUICK_CHARGE_NORMAL,
> > > > +			1: QUICK_CHARGE_FAST,
> > > > +			2: QUICK_CHARGE_FLASH,
> > > > +			3: QUICK_CHARGE_TURBE,
> > > > +			4: QUICK_CHARGE_SUPER.
> > > 
> > > NAK.
> > > 
> > > Just expose value in watts or something... People are talking about > 100W charging, no
> > > need to go with fast/turbe/super/hyper/nonsense.
> > > 
> > > BTW fast charge is already "well defined", and what you call Normal is usually fast charge.
> > 
> > I think these names come from the Qi charging spec, right?  So lets use
> > what is given to us.
> 
> There are other standards, and this should better be generic.

What standard?  Why not go with this one, it's documented and out there
and being used.

> Simply expose value in watts.

What if you do not know the watts, you just know these ranges.

thanks,

greg k-h
