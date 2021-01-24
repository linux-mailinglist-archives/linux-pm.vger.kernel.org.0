Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310DE301A75
	for <lists+linux-pm@lfdr.de>; Sun, 24 Jan 2021 09:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbhAXIOm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Jan 2021 03:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbhAXIOa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 24 Jan 2021 03:14:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5055B22582;
        Sun, 24 Jan 2021 08:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611476028;
        bh=+S8i7tXq4gCZUj2yB3Crs9e2kW8EcJXUe2UEBs1rh0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVrZPRK2xV5GHODv5CgpRb40J8rVnGFLtz4LUnIRF3CVwWy3ipT+4QwvEr5hjldJj
         ywBQJi/LFovYP5/1qZSqEhUdG3B8FUlvL50w1sNoYZXDrkAcLlOAv8ktxUI2l10iA0
         SDLfO68IM5s8EWAHu2APGUD0gqAkwhS+M9z+a1Io=
Date:   Sun, 24 Jan 2021 09:13:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Thierry Reding <treding@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org
Subject: Re: Infinite recursion in device_reorder_to_tail() due to circular
 device links
Message-ID: <YA0sOFj6VjQ8LUL2@kroah.com>
References: <X/ycQpu7NIGI969v@gerhold.net>
 <CAJZ5v0gAsZ45O8mv-gz0UvbyxnKA6fQBYvambBYEH6OSk3-m3g@mail.gmail.com>
 <X/3kveeVrb35qsvb@kroah.com>
 <alpine.LSU.2.11.2101231524290.1540@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101231524290.1540@eggly.anvils>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 23, 2021 at 03:37:30PM -0800, Hugh Dickins wrote:
> On Tue, 12 Jan 2021, Greg Kroah-Hartman wrote:
> > On Tue, Jan 12, 2021 at 03:32:04PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Jan 11, 2021 at 7:46 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > > >
> > > > Hi,
> > > >
> > > > since 5.11-rc1 I get kernel crashes with infinite recursion in
> > > > device_reorder_to_tail() in some situations... It's a bit complicated to
> > > > explain so I want to apologize in advance for the long mail. :)
> > > >
> > > >   Kernel panic - not syncing: kernel stack overflow
> > > >   CPU: 1 PID: 33 Comm: kworker/1:1 Not tainted 5.11.0-rc3 #1
> > > >   Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > >   Call trace:
> > > >    ...
> > > >    device_reorder_to_tail+0x4c/0xf0
> > > >    device_reorder_to_tail+0x98/0xf0
> > > >    device_reorder_to_tail+0x60/0xf0
> > > >    device_reorder_to_tail+0x60/0xf0
> > > >    device_reorder_to_tail+0x60/0xf0
> > > >    ...
> > > >
> > > > The crash happens only in 5.11 with commit 5b6164d3465f ("driver core:
> > > > Reorder devices on successful probe"). It stops happening when I revert
> > > > this commit.
> > > 
> > > Thanks for the report!
> > > 
> > > Greg, please revert commit 5b6164d3465f, it clearly is not an
> > > improvement, at least at this point.
> > 
> > Now reverted, thanks.
> > 
> > greg k-h
> 
> I think that there has been a misunderstanding here: although
> 5b6164d3465f ("driver core: Reorder devices on successful probe")
> has been reverted from linux-next (thank you), it has not yet been
> reverted from 5.11-rc, and still causing problems there (in my case,
> not the infinite recursion Stephan reported in this thread, but the
> ThinkPad rmi4 suspend failure that I reported in another thread).

It will be sent to Linus in a few hours, thanks, so should show up in
5.11-rc5.  I had other patches to go along with this to send him at the
same time :)

greg k-h
