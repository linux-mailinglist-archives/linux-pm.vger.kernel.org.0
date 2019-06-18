Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C64AD40
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 23:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfFRVXF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 17:23:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41810 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfFRVXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 17:23:04 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id fbe5a615d4df22c3; Tue, 18 Jun 2019 23:23:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sandeep Patil <sspatil@android.com>
Cc:     Tri Vo <trong@android.com>, viresh.kumar@linaro.org,
        Hridya Valsaraju <hridya@google.com>, linux-pm@vger.kernel.org,
        kernel-team@android.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
Date:   Tue, 18 Jun 2019 23:23:00 +0200
Message-ID: <4587569.x9DSL43cXO@kreacher>
In-Reply-To: <20190618182502.GC203031@google.com>
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com> <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com> <20190618182502.GC203031@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, June 18, 2019 10:17:16 PM CEST Sandeep Patil wrote:
> 
> Hi Rafael, Viresh etc.
> 
> On Tue, Jun 11, 2019 at 10:31:16AM -0700, Tri Vo wrote:
> > On Tue, Jun 4, 2019 at 5:23 PM Tri Vo <trong@android.com> wrote:
> > >
> > > Hello Rafael,
> > >
> > > Currently, Android reads wakeup sources statistics from
> > > /sys/kernel/debug/wakeup_sources in production environment. This
> > > information is used, for example, to report which wake lock prevents
> > > the device from suspending.
> 
> Android's usage of the 'wakeup_sources' from debugfs can is linked at[1].
> Basically, android's battery stats implementation to plot history for suspend
> blocking wakeup sources over device's boot cycle. This is used both for power
> specific bug reporting but also is one of the stats that will be used towards
> attributing the battery consumption to specific processes over the period of
> time.
> 
> Android depended on the out-of-tree /proc/wakelocks before and now relies on
> wakeup_sources debugfs entry heavily for the aforementioned use cases.
> 
> > >
> > > Android userspace reading wakeup_sources is not ideal because:
> > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > not guaranteed to be backward/forward compatible.
> > > - This file requires debugfs to be mounted, which itself is
> > > undesirable for security reasons.
> > >
> > > To address these problems, we want to contribute a way to expose these
> > > statistics that doesn't depend on debugfs.
> > >
> > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > Or maybe implement eBPF-based solution? What do you think?
> 
> We are going through Android's out-of-tree kernel dependencies along with
> userspace APIs that are not necessarily considered "stable and forever
> supported" upstream. The debugfs dependencies showed up on our radar as a
> result and so we are wondering if we should worry about changes in debugfs
> interface and hence the question(s) below.
> 
> So, can we rely on /d/wakeup_sources to be considered a userspace API and
> hence maintained stable as we do for other /proc and /sys entries?
> 
> If yes, then we will go ahead and add tests for this in LTP or
> somewhere else suitable.

No, debugfs is not ABI.

> If no, then we would love to hear suggestions for any changes that need to be
> made or we simply just move the debugfs entry into somewhere like
> /sys/power/ ?

No, moving that entire file from debugfs into sysfs is not an option either.

The statistics for the wakeup sources associated with devices are already there
under /sys/devices/.../power/ , but I guess you want all wakeup sources?

That would require adding a kobject to struct wakeup_source and exposing
all of the statistics as separate attributes under it.  In which case it would be
good to replace the existing wakeup statistics under /sys/devices/.../power/
with symbolic links to the attributes under the wakeup_source kobject.

> As a side effect, if the entry moves out of debugfs, Android can run without
> mounting debugfs in production that I assume is a good thing.

And really Android developers might have thought about this a bit earlier.

Thanks!



