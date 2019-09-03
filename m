Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2304A6B8A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfICObw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 10:31:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60724 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729169AbfICObw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 10:31:52 -0400
Received: (qmail 2951 invoked by uid 2102); 3 Sep 2019 10:31:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Sep 2019 10:31:51 -0400
Date:   Tue, 3 Sep 2019 10:31:51 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Akinobu Mita <akinobu.mita@gmail.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-leds@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM-runtime: allow userspace to monitor runtime_status
 changes
In-Reply-To: <CAC5umyhBkvWFaRpzJ=xtdnf_fLHe2OeJJ01sve8F6HA0=MuLMQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1909031017130.1859-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Sep 2019, Akinobu Mita wrote:

> 2019年9月3日(火) 6:47 Rafael J. Wysocki <rafael@kernel.org>:
> >
> > On Sun, Sep 1, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
> > >
> > > This enables the /sys/devices/.../power/runtime_status attribute to
> > > allow the user space to get notifications via poll/select when the device
> > > runtime PM status is changed.
> > >
> > > An example use case is to avoid unnecessary accesses for device statistics
> > > (e.g. diskstats for block devices) while the device is in runtime suspend
> > > by user space LED device actitity trigger.
> > >
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

> > There are concerns about this.
> >
> > First off, it adds overhead for devices that change the PM-runtime
> > status relatively often.  I'm not sure if that's sufficiently
> > justified.
> >
> > Second, it is called for status changes from "active" to "suspending"
> > and from "suspending" to "suspended" (and analogously for resume)
> > which may not be particularly useful.  At least, user space may not
> > have enough time to act on such notifications.
> >
> > Finally, it is racy, because at the time user space does something on
> > a device PM-runtime status change, it very well may have changed the
> > other way around already.
> 
> I withdraw this patch now.  I hope I'll retry with a real use case example
> program.

You might want to take a look at commit 7794f486ed0b ("usbfs: Add
ioctls for runtime power management") in the usb-next branch of Greg
KH's usb.git tree.  It adds a mechanism for user programs to wait until
a device has done a runtime resume, without races.

But it is not general purpose (it applies only to USB devices), it
doesn't use poll(), and it doesn't check for other kinds of runtime PM
status changes.

Alan Stern

