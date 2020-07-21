Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9C0227D1C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgGUKce (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 06:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUKcd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 06:32:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A430F20714;
        Tue, 21 Jul 2020 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595327553;
        bh=cxxwkqmECry30G57dJfjbrdgXLTLNOm11+JAi8PcStY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKZjg+PFoyxwyMHNsCZgBRR1twDK3EjuiNqHsHgeLDzNV7CVW7pntD9R/9AKKg6q0
         kYJqFCUE6yac809FGnMqyOB6JNYSZfOe7+vSum1nRyPdQWFfMxkTichzH69C7/Dpfw
         B9+UX2XRQR6bh7oi42qqYFkAfhFFVJNzChr/oCsI=
Date:   Tue, 21 Jul 2020 12:32:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ivan <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v5 3/4] power: supply: core: add wireless signal strength
 property
Message-ID: <20200721103241.GA1675802@kroah.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
 <b383d79629d0afca00838fcbaad4458e383d7262.1595301250.git.huangqiwu@xiaomi.com>
 <20200721082000.GD1655283@kroah.com>
 <CAPtXDt2CXYJNoqnu3r7+vV2BZzT3fMR_G1yOyu1v0dgS8EkjNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPtXDt2CXYJNoqnu3r7+vV2BZzT3fMR_G1yOyu1v0dgS8EkjNg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 06:21:20PM +0800, ivan wrote:
> On Tue, Jul 21, 2020 at 4:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 21, 2020 at 01:59:36PM +0800, Qiwu Huang wrote:
> > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > >
> > > reports wireless signal strength.
> > > The value show degree of coupling between tx and rx.
> > >
> > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
> > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > >  include/linux/power_supply.h                |  1 +
> > >  3 files changed, 12 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > > index 03ab449fae8a..75ec7de2fe78 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > @@ -757,3 +757,13 @@ Description:
> > >                       13: ADAPTER_VOICE_BOX,
> > >                       14: ADAPTER_PRIVATE_PD_50W.
> > >
> > > +What:                /sys/class/power_supply/<supply_name>/signal_strength
> > > +Date:                Jul 2020
> > > +Contact:     Fei Jiang <jiangfei1@xiaomi.com>
> > > +Description:
> > > +             In PING phase, RX transmits a signal strength packet as the first
> >
> > What does "PING phase" mean?
> 
> The Qi Wireless Power Transfer System is published by the Wireless
> Power Consortium.
> The ping phase is the necessary stage for matching transmitter and
> receiver. In this phase,
> the Power Transmitter executes a Digital Ping, and listens for a
> response. If the
> Power Transmitter discovers a Power Receiver, the Power Transmitter
> may extend the Digital Ping,
> i.e. maintain the Power Signal at the level of the Digital Ping. This
> causes the system to proceed to the
> identification & configuration phase. If the Power Transmitter does
> not extend the Digital Ping, the
> system shall revert to the selection phase.

Thanks for the description, so perhaps turning this response into the
text in the description would be good?

thanks,

greg k-h
