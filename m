Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC93503AD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfFXHhP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 03:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFXHhP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jun 2019 03:37:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3AE2089F;
        Mon, 24 Jun 2019 07:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561361834;
        bh=x3aCy3cw4nqUw/E68KNlHb4J1hBjM6xKiEFbJNmuLeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VH4pN3Hg6X32GIipweiPjWQNXUNkTYG4LTH0myZFrICQznUQrnUJ9AMyi/6/KegHw
         P3YrhHNxl6k6p/c1XwHdQ95ue6PqTYEsp6sNJDhoQzC7XD7Qdw/fh4IH/CkF03d+ql
         pjsiCmcyZVPhNivMoWtKR/+VH/uzTJiuhwMydzEk=
Date:   Mon, 24 Jun 2019 15:36:59 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
Message-ID: <20190624073659.GA13957@kroah.com>
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com>
 <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CANA+-vCBW=P=dpJGfcKTt7SoNKzWcpP5pwZHSDMU6MkwBKoC9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANA+-vCBW=P=dpJGfcKTt7SoNKzWcpP5pwZHSDMU6MkwBKoC9A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 23, 2019 at 06:48:43PM -0700, Tri Vo wrote:
> On Wed, Jun 19, 2019 at 1:35 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Jun 19, 2019 at 1:52 AM Joel Fernandes <joelaf@google.com> wrote:
> > >
> > > On Tue, Jun 18, 2019 at 7:15 PM Tri Vo <trong@android.com> wrote:
> > > [snip]
> > > > > > > >
> > > > > > > > Android userspace reading wakeup_sources is not ideal because:
> > > > > > > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > > > > > > not guaranteed to be backward/forward compatible.
> > > > > > > > - This file requires debugfs to be mounted, which itself is
> > > > > > > > undesirable for security reasons.
> > > > > > > >
> > > > > > > > To address these problems, we want to contribute a way to expose these
> > > > > > > > statistics that doesn't depend on debugfs.
> > > > > > > >
> > > > > > > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > > > > > > Or maybe implement eBPF-based solution? What do you think?
> > > > > >
> > > > > > We are going through Android's out-of-tree kernel dependencies along with
> > > > > > userspace APIs that are not necessarily considered "stable and forever
> > > > > > supported" upstream. The debugfs dependencies showed up on our radar as a
> > > > > > result and so we are wondering if we should worry about changes in debugfs
> > > > > > interface and hence the question(s) below.
> > > > > >
> > > > > > So, can we rely on /d/wakeup_sources to be considered a userspace API and
> > > > > > hence maintained stable as we do for other /proc and /sys entries?
> > > > > >
> > > > > > If yes, then we will go ahead and add tests for this in LTP or
> > > > > > somewhere else suitable.
> > > > >
> > > > > No, debugfs is not ABI.
> > > > >
> > > > > > If no, then we would love to hear suggestions for any changes that need to be
> > > > > > made or we simply just move the debugfs entry into somewhere like
> > > > > > /sys/power/ ?
> > > > >
> > > > > No, moving that entire file from debugfs into sysfs is not an option either.
> > > > >
> > > > > The statistics for the wakeup sources associated with devices are already there
> > > > > under /sys/devices/.../power/ , but I guess you want all wakeup sources?
> > > > >
> > > > > That would require adding a kobject to struct wakeup_source and exposing
> > > > > all of the statistics as separate attributes under it.  In which case it would be
> > > > > good to replace the existing wakeup statistics under /sys/devices/.../power/
> > > > > with symbolic links to the attributes under the wakeup_source kobject.
> > > >
> > > > Thanks for your input, Rafael! Your suggestion makes sense. I'll work
> > > > on a patch for this.
> > >
> > > Does that entail making each wake up source, a new sysfs node under a
> > > particular device, and then adding stats under that new node?
> >
> > Not under a device, because there are wakeup source objects without
> > associated devices.
> >
> > It is conceivable to have a "wakeup_sources" directory under
> > /sys/power/ and sysfs nodes for all wakeup sources in there.
> >
> > Then, instead of exposing wakeup statistics directly under
> > /sys/devices/.../power/, there can be symbolic links from there to the
> > new wakeup source nodes under "wakeup_sources" (so as to avoid
> > exposing the same data in two different places in sysfs, which may be
> > confusing).
> 
> This may be a dumb question. Is it appropriate to make symbolic links
> in sysfs from one attribute to another attribute? For example,
> /sys/devices/.../power/wakeup_count ->
> /sys/power/wakeup_sources/.../wakeup_count.

Why? would you want that?

> I only see kobject to kobject symlinks around. And I don't think we
> can make /sys/devices/.../power/ directory a symlink to where our new
> wakeup stats will be, since the former contains attributes other than
> wakeup ones.

No, don't link attributes, they refer to the kobject that created them.
I really doubt that this is the same kobject in both places :)

thanks,

greg k-h
