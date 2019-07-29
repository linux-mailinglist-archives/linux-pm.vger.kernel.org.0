Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82CDF787FE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfG2JHB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 05:07:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58648 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG2JHB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 05:07:01 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id a3ba5d91a3f87a99; Mon, 29 Jul 2019 11:06:58 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH] PM / wakeup: Avoid dev_name collisions in wakeup class
Date:   Mon, 29 Jul 2019 11:06:58 +0200
Message-ID: <1771170.ZfA44AmTq3@kreacher>
In-Reply-To: <CANA+-vDNkSG39SLd0_B_L8gkDkfQ2uJLcuvCaRgHkU8DiBzMTw@mail.gmail.com>
References: <20190727011040.89582-1-swboyd@chromium.org> <CAJZ5v0hroRuGQ5N42Z8=yFVXiJPdid3wJrHoKqr2BZVx=sfnBQ@mail.gmail.com> <CANA+-vDNkSG39SLd0_B_L8gkDkfQ2uJLcuvCaRgHkU8DiBzMTw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, July 27, 2019 7:37:07 PM CEST Tri Vo wrote:
> On Sat, Jul 27, 2019 at 6:10 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sat, Jul 27, 2019 at 3:11 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > If a device is wakeup capable and the driver calls device_wakeup_init()
> > > on it during probe and then userspace writes 'enabled' to that device's
> > > power/wakeup file in sysfs we'll try to create the same named wakeup
> > > device in sysfs. The kernel will complain about duplicate file names.
> 
> Thanks for reporting the issue, Stephen!
> > >
> > > sysfs: cannot create duplicate filename '/devices/virtual/wakeup/1-1.1'
> > > kobject_add_internal failed for 1-1.1 with -EEXIST, don't try to register things with the same name in the same directory.
> > >
> > > It may be advantageous to not write 'enabled' to the wakeup file (see
> > > wakeup_store()) from userspace for these devices because we allocate
> > > devices and register them and then throw them all away later on if the
> > > device driver has already initialized the wakeup attribute. The
> > > implementation currently tries to avoid taking locks here so it seems
> > > best to optimize that path in a separate patch.
> > >
> > > Let's rename the wakeup class devices as 'wakeupN' with an IDA that's
> > > simple enough to just return some sort of number. In addition, let's
> > > make the device registering the wakeup the parent and include a 'name'
> > > attribute in case userspace wants to figure out the type of wakeup it is
> > > (in the case of virtual wakeups) or the device associated with the
> > > wakeup. This makes it easier for userspace to go from /sys/class/wakeup
> > > to a place in the device hierarchy where the wakeup is generated from
> > > like an input device.
> > >
> > > Cc: Tri Vo <trong@android.com>
> > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >
> > I'd rather change the commit that introduced this issue which is only
> > in linux-next for now.
> 
> Raphael, could you roll back my patch? I'll work with Stephen to fix it.

I'll drop it, thanks!



