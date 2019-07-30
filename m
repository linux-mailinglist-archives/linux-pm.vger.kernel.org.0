Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A17B29E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfG3StL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 14:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387746AbfG3StK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jul 2019 14:49:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79A020693;
        Tue, 30 Jul 2019 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564512549;
        bh=zrZwl+oAJ26k/mkZR+vY6j+SizAcayvNiJdsXrJsITs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJ++MjBb3KqdiDuI1APz1Pfm+/fO1U3eLC9vBgr5rnHGkl5Y6YA0+C2/Lo3Z7tbuJ
         Srn/hSIZh5RCui7qxcZaVYBnTbJq2M2bT9Wmj0eG3ouGdk65UwIlUoIpBez2BCFQ3g
         IapYWA6dej/9wjOle1UxwWcLlR4BGPxR00Q+0l9I=
Date:   Tue, 30 Jul 2019 20:49:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190730184906.GA4011@kroah.com>
References: <20190730024309.233728-1-trong@android.com>
 <CAJZ5v0jJn=vHdYExbzwRAMsk=Ad5bhvOAvHEXe-FHOj2R4Gwig@mail.gmail.com>
 <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 11:39:34AM -0700, Tri Vo wrote:
> On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> > >
> > > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > > blocking wakeup sources over device's boot cycle. This information can
> > > then be used (1) for power-specific bug reporting and (2) towards
> > > attributing battery consumption to specific processes over a period of
> > > time.
> > >
> > > However, debugfs doesn't have stable ABI. For this reason, create a
> > > 'struct device' to expose wakeup sources statistics in sysfs under
> > > /sys/class/wakeup/wakeup<ID>/*.
> > >
> > > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Co-developed-by: Stephen Boyd <swboyd@chromium.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > Signed-off-by: Tri Vo <trong@android.com>
> > > Tested-by: Tri Vo <trong@android.com>
> > > Tested-by: Kalesh Singh <kaleshsingh@google.com>
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-wakeup |  76 +++++++++
> > >  drivers/acpi/device_pm.c                     |   3 +-
> > >  drivers/base/power/Makefile                  |   2 +-
> > >  drivers/base/power/wakeup.c                  |  21 ++-
> > >  drivers/base/power/wakeup_stats.c            | 171 +++++++++++++++++++
> > >  fs/eventpoll.c                               |   4 +-
> > >  include/linux/pm_wakeup.h                    |  15 +-
> > >  kernel/power/autosleep.c                     |   2 +-
> > >  kernel/power/wakelock.c                      |  10 ++
> > >  kernel/time/alarmtimer.c                     |   2 +-
> > >  10 files changed, 294 insertions(+), 12 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-wakeup
> > >  create mode 100644 drivers/base/power/wakeup_stats.c
> > >
> > > v2:
> > > - Updated Documentation/ABI/, as per Greg.
> > > - Removed locks in attribute functions, as per Greg.
> > > - Lifetimes of struct wakelock and struck wakeup_source are now different due to
> > >   the latter embedding a refcounted kobject. Changed it so that struct wakelock
> > >   only has a pointer to struct wakeup_source, instead of embedding it.
> > > - Added CONFIG_PM_SLEEP_STATS that enables/disables wakeup source statistics in
> > >   sysfs.
> > >
> > > v3:
> > > Changes by Greg:
> > > - Reworked code to use 'struct device' instead of raw kobjects.
> > > - Updated documentation file.
> > > - Only link wakeup_stats.o when CONFIG_PM_SLEEP_STATS is enabled.
> > > Changes by Tri:
> > > - Reverted changes to kernel/power/wakelock.c. 'struct device' hides kobject
> > >   operations. So no need to handle lifetimes in wakelock.c
> > >
> > > v4:
> > > - Added 'Co-developed-by:' and 'Tested-by:' fields to commit message.
> > > - Moved new documentation to a separate file
> > >   Documentation/ABI/testing/sysfs-class-wakeup, as per Greg.
> > > - Fixed copyright header in drivers/base/power/wakeup_stats.c, as per Greg.
> > >
> > > v5:
> > > - Removed CONFIG_PM_SLEEP_STATS
> > > - Used PTR_ERR_OR_ZERO instead of if(IS_ERR(...)) + PTR_ERR, reported by
> > >   kbuild test robot <lkp@intel.com>
> > > - Stephen reported that a call to device_init_wakeup() and writing 'enabled' to
> > >   that device's power/wakeup file results in multiple wakeup source being
> > >   allocated for that device.  Changed device_wakeup_enable() to check if device
> > >   wakeup was previously enabled.
> > > Changes by Stephen:
> > > - Changed stats location from /sys/class/wakeup/<name>/* to
> > >   /sys/class/wakeup/wakeup<ID>/*, where ID is an IDA-allocated integer. This
> > >   avoids name collisions in /sys/class/wakeup/ directory.
> > > - Added a "name" attribute to wakeup sources, and updated documentation.
> > > - Device registering the wakeup source is now the parent of the wakeup source.
> > >   Updated wakeup_source_register()'s signature and its callers accordingly.
> >
> > And I really don't like these changes.  Especially having "wakeup"
> > twice in the path.
> 
> I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?

Yes.

> About the other change, I think making the registering device the
> parent of the wakeup source is a worthwhile change, since that way one
> can associate a wakeup source sysfs entry with the device that created
> it.

that's fine with me.

> > Couldn't you find a simpler way to avoid the name collisions?
> 
> I could also simply log an error in case of a name collision instead
> of failing hard. That way I can keep the old path with the wakeup
> source name in it. Other than that, I can't think of a way to resolve
> the directory name collisions without making that directory name
> unique, i.e. generating IDs is probably the simplest way. I'm still
> learning about the kernel, and I might be wrong though. What do you
> think?

Uniqe ids for the class should be fine, that's all you need to have.

thanks,

greg k-h
