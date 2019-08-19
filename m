Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C4A9206A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfHSJdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 05:33:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41410 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSJdW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 05:33:22 -0400
Received: from 79.184.254.79.ipv4.supernova.orange.pl (79.184.254.79) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 9d45e80d828adeac; Mon, 19 Aug 2019 11:33:19 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>, Tony Lindgren <tony@atomide.com>,
        Qian Cai <cai@lca.pw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
Date:   Mon, 19 Aug 2019 11:33:19 +0200
Message-ID: <1682360.syUnOcd5pY@kreacher>
In-Reply-To: <5d56bb77.1c69fb81.58e9d.1f86@mx.google.com>
References: <1565731976.8572.16.camel@lca.pw> <CAJZ5v0hY8=0j=heXuAS-5cBafDSE8ZakLDW4NGCjAbxUAt3j4Q@mail.gmail.com> <5d56bb77.1c69fb81.58e9d.1f86@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, August 16, 2019 4:19:35 PM CEST Stephen Boyd wrote:
> Quoting Rafael J. Wysocki (2019-08-16 05:17:23)
> > On Wed, Aug 14, 2019 at 8:37 PM Tri Vo <trong@android.com> wrote:
> > >
> > > On Wed, Aug 14, 2019 at 1:40 AM Tony Lindgren <tony@atomide.com> wrote:
> > > >
> > > > * Stephen Boyd <swboyd@chromium.org> [691231 23:00]:
> > > > > I also notice that device_set_wakeup_capable() has a check to see if the
> > > > > device is registered yet and it skips creating sysfs entries for the
> > > > > device if it isn't created in sysfs yet. Why? Just so it can be called
> > > > > before the device is created? I guess the same logic is handled by
> > > > > dpm_sysfs_add() if the device is registered after calling
> > > > > device_set_wakeup_*().
> > > >
> > > > Hmm just guessing.. It's maybe because drivers can enable and disable
> > > > the wakeup capability at any point for example like driver/net drivers
> > > > do based on WOL etc?
> > > >
> > > > > There's two approaches I see:
> > > > >
> > > > >       1) Do a similar check for device_set_wakeup_enable() and skip
> > > > >       adding the wakeup class until dpm_sysfs_add().
> > > > >
> > > > >       2) Find each case where this happens and only call wakeup APIs
> > > > >       on the device after the device is added.
> > > > >
> > > > > I guess it's better to let devices have wakeup modified on them before
> > > > > they're registered with the device core?
> > > >
> > > > I think we should at least initially handle case #1 above as multiple
> > > > places otherwise seem to break. Then maybe we could add a warning to
> > > > help fix all the #2 cases if needed?
> > >
> > > Makes sense. For case#1, we could also just register the wakeup source
> > > without specifying the parent device if the latter hasn't been
> > > registered yet. Userspace won't be able to associate a wakeup source
> > > to the parent device. But I think it's a reasonable fix, assuming we
> > > want to fix devices not being added before calling wakeup APIs #2.
> > 
> > Well, OK
> > 
> > I'm going to drop the entire series from linux-next at this point and
> > let's start over.
> 
> I was going to send the first patch I floated as a more formal patch to
> be applied to the PM tree. I was waiting to see if the semantics of
> device_set_wakeup_*() could be clarified because I don't understand if
> they're allowed to be called before device_add().
> 
> > 
> > Also note that all of this is not an issue until we start to add
> > children under the device passed to device_set_wakeup_enable() and
> > friends so maybe that is not a good idea after all?
> 
> My primary goal is to know what wakeup is associated with a device. If
> we delay creation of the sysfs node to the time that device_add() is
> called then it will allow device_set_wakeup_enable() to be called before
> the device is published to userspace. Is anything wrong with that? This
> seems to be the intention of the API based on the way
> device_set_wakeup_capable() is written. Furthermore, if we make this
> change then we don't need to fix various drivers to reorder calls to
> device_set_wakeup_enable() and device_add(), so it looks like the right
> approach.

Sounds reasonable.



