Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260D024F64E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgHXI6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 04:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbgHXI6V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 04:58:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29221204FD;
        Mon, 24 Aug 2020 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259500;
        bh=MlJ44rehLSPaJUGChKnzLkZMd/wcW1D2ek38r9QI/p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQoFk1hEPIycH6uvZnb6VQY5N8y5Q4wF2KotBVBfTw4Ld3c4RRAawn3DrFWbwqdYn
         e6RCVfW7DOX61v//zMbh+8Mvel8hvYb1AvKy3bM7s/pVnlxnbF1BjUAXBomGMNiDAz
         f4DQsO2cphJ9wmNYH6WwxaGmlsz/IvbnyqXcZVoM=
Date:   Mon, 24 Aug 2020 10:57:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v8 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200824085715.GB402243@kroah.com>
References: <cover.1597376585.git.huangqiwu@xiaomi.com>
 <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
 <20200814060909.GD1409566@kroah.com>
 <CAPtXDt1e3fi7ymW0-FSknUAYCQ80aL=4btbeA2e4Xre7+e7OtA@mail.gmail.com>
 <20200818060707.GB1742213@kroah.com>
 <CAPtXDt26DdOi6JG7x3mTrR5YwArjkAeXY2TogRnK_xkSabhL2g@mail.gmail.com>
 <20200824074357.GB4133866@kroah.com>
 <CAPtXDt0yW7Kh6a9JGfXaha_wKVjae7U74m6K=631Ofh8_m4uvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPtXDt0yW7Kh6a9JGfXaha_wKVjae7U74m6K=631Ofh8_m4uvg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 04:42:06PM +0800, Qiwu Huang wrote:
> On Mon, Aug 24, 2020 at 3:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 24, 2020 at 08:54:56AM +0800, Qiwu Huang wrote:
> > > On Tue, Aug 18, 2020 at 2:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Aug 18, 2020 at 09:56:28AM +0800, Qiwu Huang wrote:
> > > > > On Fri, Aug 14, 2020 at 2:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Fri, Aug 14, 2020 at 11:46:54AM +0800, Qiwu Huang wrote:
> > > > > > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > > > >
> > > > > > > Reports the kind of quick charge type based on
> > > > > > > different adapter power.
> > > > > > >
> > > > > > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > > > > ---
> > > > > > >  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++
> > > > > > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > > > > > >  drivers/power/supply/qcom_smbb.c            | 51 +++++++++++++++++++++
> > > > > > >  include/linux/power_supply.h                | 14 ++++++
> > > > > > >  4 files changed, 87 insertions(+)
> > > > > >
> > > > > > You should also submit your driver that uses these new attributes at the
> > > > > > same time.  What happened to that request?  Otherwise no one really
> > > > > > knows how these are being used, or if they even are used by anyone.
> > > > > >
> > > > >
> > > > > I don't think I can submit the whole driver because our drivers are
> > > > > divided into three parts, the first part is in ADSP, the second part
> > > > > is in kernel and the third part is in Android Hal.This is the second
> > > > > part.
> > > >
> > > > WHat is "ADSP"?
> > >
> > > ADSP: advanced digital signal processor
> >
> > Ok, then just send the kernel driver.
> >
> > > > Just submit your kernel driver code, that's all we care about here.
> > > > Userspace code is not anything we can do anything with :)
> > >
> > > If we ported the full driver, we would break the existing driver
> > > structure because we would introduce more Qualcomm code. I think
> > > that's an unreasonable change.
> >
> > That doesn't make much sense.  You have a working driver for these apis,
> > just submit it for inclusion, it should never break any existing
> > drivers, otherwise your code wouldn't work either.
> 
> We're an Android device, we're working on a Qualcomm based code, and
> from the current code tree, the current code tree is missing the QTI
> Charger code

I don't know what that means, sorry.  Just submit your driver, and any
needed dependencies as well.  There's no other way to evaluate this api
addition without that, right?

thanks,

greg k-h
