Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A634600E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 14:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCWNrd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 09:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhCWNrS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 09:47:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD45F6198C;
        Tue, 23 Mar 2021 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616507238;
        bh=wD/B/xKbW2tuyo74fJsKiZyXFeGvnaD7QOI+wgfl9pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nq9tvCpDgQ1sai5Z6lh8JLchXCQR5/7LdyGK+Z0NlN+t7lyzXiti6RLKxUpNBGev4
         1Sj6D82hf6TZLBWvEI/l2rsGOF+IyOGZy2+G8wr0n8NI+KHuOrKmLZIOh5CEsg3Azz
         u6m9dl56vFSMK/tAMkZS+4cc4Ep8gMCZpRBXrRps=
Date:   Tue, 23 Mar 2021 14:47:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     Sebastian Reichel <sre@kernel.org>, naresh.kamboju@linaro.org,
        Kyle Tso <kyletso@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: [PATCH] usb: dwc3: fix build error when POWER_SUPPLY is not
 enabled
Message-ID: <YFnxY7AW9QGQApKQ@kroah.com>
References: <20210308133146.3168995-1-raychi@google.com>
 <20210309185807.ka4iljasq5cmpmil@earth.universe>
 <CAPBYUsCJ3ftC4ur412rFZGeeM_kDHrCh=BVci3=8SE2eFdPcQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBYUsCJ3ftC4ur412rFZGeeM_kDHrCh=BVci3=8SE2eFdPcQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 09:57:56PM +0800, Ray Chi wrote:
> Hi Sebastian,
> 
> Sorry for the late reply.
> 
> On Wed, Mar 10, 2021 at 2:58 AM Sebastian Reichel <sre@kernel.org> wrote:
> >
> > Hi,
> >
> > On Mon, Mar 08, 2021 at 09:31:46PM +0800, Ray Chi wrote:
> > > Fix build error when CONFIG_POWER_SUPPLY is not enabled.
> > >
> > > The build error occurs in mips (cavium_octeon_defconfig).
> > >
> > > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_remove':
> > > drivers/usb/dwc3/core.c:1657: undefined reference to `power_supply_put'
> > > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_get_properties':
> > > drivers/usb/dwc3/core.c:1270: undefined reference to `power_supply_get_by_name'
> > > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_probe':
> > > drivers/usb/dwc3/core.c:1632: undefined reference to `power_supply_put'
> > >
> > > Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > Signed-off-by: Ray Chi <raychi@google.com>
> > > ---
> >
> > While I'm fine with merging this after fixing up the subject, the
> > original patch for dwc3 [0] looks completly incorrect to me.
> >
> > First of all it uses wrong scale (power-supply uses uA, not mA),
> > so you are charging 1000x slower than expected. Then the patchset
> > introduces a new DT property to get the power-supply device, but
> > does not update the DT binding documentation and does not Cc the
> > DT binding maintainer.
> 
> Yes, it should use uA and send this information, and I will update a
> patch to fix it and add the DT binding documentation.

So should I revert what we currently have in my usb-next tree, or do
you have a fix for this?

thanks,

greg k-h
