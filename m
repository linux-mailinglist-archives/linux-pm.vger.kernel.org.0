Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54B71374
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 09:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbfGWH51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 03:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388605AbfGWH51 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 03:57:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2467A2239E;
        Tue, 23 Jul 2019 07:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563868646;
        bh=raesEJUrKUUjIY47oo0d7Am8Mms/YmjXGF8ELt5JU0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yyalUf2YIUgBilePpnS3sBf6REYxD18aL8zOEZSw0XNEaG7ucE/Q3ipoUm4T3nHA4
         h4qLkxVTZEjh8PRY+nO8KIIouncngiAOJ5A+XW0K5GBpzwxwyeRXUdU4yyJMU7wWHU
         wnTpEzTHqjs6fl/nVs+XxIK4QhpblnNaHCznZ+bY=
Date:   Tue, 23 Jul 2019 09:57:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] driver core: Remove device link creation limitation
Message-ID: <20190723075724.GB27243@kroah.com>
References: <2305283.AStDPdUUnE@kreacher>
 <CAJZ5v0h-nWr1vie61U6BzDxns+qmj_3EOFztE_X-CGgtzkz=ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h-nWr1vie61U6BzDxns+qmj_3EOFztE_X-CGgtzkz=ZA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 09:34:54AM +0200, Rafael J. Wysocki wrote:
> Hi Greg,
> 
> On Tue, Jul 16, 2019 at 5:21 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] driver core: Remove device link creation limitation
> >
> > If device_link_add() is called for a consumer/supplier pair with an
> > existing device link between them and the existing link's type is
> > not in agreement with the flags passed to that function by its
> > caller, NULL will be returned.  That is seriously inconvenient,
> > because it forces the callers of device_link_add() to worry about
> > what others may or may not do even if that is not relevant to them
> > for any other reasons.
> >
> > It turns out, however, that this limitation can be made go away
> > relatively easily.
> >
> > The underlying observation is that if DL_FLAG_STATELESS has been
> > passed to device_link_add() in flags for the given consumer/supplier
> > pair at least once, calling either device_link_del() or
> > device_link_remove() to release the link returned by it should work,
> > but there are no other requirements associated with that flag.  In
> > turn, if at least one of the callers of device_link_add() for the
> > given consumer/supplier pair has not passed DL_FLAG_STATELESS to it
> > in flags, the driver core should track the status of the link and act
> > on it as appropriate (ie. the link should be treated as "managed").
> > This means that DL_FLAG_STATELESS needs to be set for managed device
> > links and it should be valid to call device_link_del() or
> > device_link_remove() to drop references to them in certain
> > sutiations.
> >
> > To allow that to happen, introduce a new (internal) device link flag
> > called DL_FLAG_MANAGED and make device_link_add() set it automatically
> > whenever DL_FLAG_STATELESS is not passed to it.  Also make it take
> > additional references to existing device links that were previously
> > stateless (that is, with DL_FLAG_STATELESS set and DL_FLAG_MANAGED
> > unset) and will need to be managed going forward and initialize
> > their status (which has been DL_STATE_NONE so far).
> >
> > Accordingly, when a managed device link is dropped automatically
> > by the driver core, make it clear DL_FLAG_MANAGED, reset the link's
> > status back to DL_STATE_NONE and drop the reference to it associated
> > with DL_FLAG_MANAGED instead of just deleting it right away (to
> > allow it to stay around in case it still needs to be released
> > explicitly by someone).
> >
> > With that, since setting DL_FLAG_STATELESS doesn't mean that the
> > device link in question is not managed any more, replace all of the
> > status-tracking checks against DL_FLAG_STATELESS with analogous
> > checks against DL_FLAG_MANAGED and update the documentation to
> > reflect these changes.
> >
> > While at it, make device_link_add() reject flags that it does not
> > recognize, including DL_FLAG_MANAGED.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Do I need to resend this?
> 
> I know that posting new things during a merge window is not most
> convenient, sorry about that.

No, it's in my queue, give me a few days to dig out from my huge pending
patch list, no need to resend it.

thanks,

greg k-h
