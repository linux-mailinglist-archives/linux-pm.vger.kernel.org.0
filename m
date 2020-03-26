Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80D193ED1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgCZM1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 08:27:50 -0400
Received: from foss.arm.com ([217.140.110.172]:59878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgCZM1u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 08:27:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6623C30E;
        Thu, 26 Mar 2020 05:27:49 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B55D3F71F;
        Thu, 26 Mar 2020 05:27:48 -0700 (PDT)
Date:   Thu, 26 Mar 2020 12:27:45 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200326122744.kbtlmev2ravn3wey@e107158-lin>
References: <20200325150017.xhabucfo3v6i234o@e107158-lin>
 <Pine.LNX.4.44L0.2003251631360.1724-100000@netrider.rowland.org>
 <CAJZ5v0gqNnoT41=Vm7AtbH8PMW+qPGighK7Up3q2rS+B0jBKFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gqNnoT41=Vm7AtbH8PMW+qPGighK7Up3q2rS+B0jBKFg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/25/20 22:28, Rafael J. Wysocki wrote:
> On Wed, Mar 25, 2020 at 9:49 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, 25 Mar 2020, Qais Yousef wrote:
> >
> > > Thanks for all the hints Alan.
> > >
> > > I think I figured it out, the below patch seems to fix it for me. Looking
> > > at other drivers resume functions it seems we're missing the
> > > pm_runtime_disable()->set_active()->enable() dance. Doing that fixes the
> > > warning and the dev_err() in driver/base/power.
> >
> > Ah, yes.  This should have been added years ago; guess I forgot.  :-(
> >
> > > I don't see xhci-plat.c doing that, I wonder if it needs it too.
> > >
> > > I'm not well versed about the details and the rules here. So my fix could be
> > > a hack, though it does seem the right thing to do.
> > >
> > > I wonder why the power core doesn't handle this transparently..
> >
> > Initially, we didn't want the PM core to do this automatically because
> > we thought some devices might want to remain runtime-suspended
> > following a system resume, and only the device driver would know what
> > to do.
> >
> > Raphael, now that we have the direct_complete mechanism, can we revisit
> > this?  Should the PM core automatically call pm_runtime_set_active() if
> > dev->power.direct_complete isn't set?  Perhaps in device_resume_early()
> > prior to the pm_runtime_enable() call?
> >
> > It's possible we discussed this and decided against it at the time when
> > direct_complete was added, but if so I don't remember what was said.
> 
> Me neither. :-)
> 
> That said complexity has grown since then and there are the
> DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED flags that can be
> used to control that behavior to some extent.
> 
> Setting DPM_FLAG_SMART_SUSPEND alone, in particular, causes
> pm_runtime_set_active() to be called at the noirq stage of device
> resume either by the core or by bus types (e.g. PCI) etc.
> 
> It looks like ohci-platform might use DPM_FLAG_SMART_SUSPEND, but I
> need to take a closer look at that (possibly later this week).

Okay I take it this was root caused correctly and now it's a question of which
is a better fix.

Thanks!

--
Qais Yousef
