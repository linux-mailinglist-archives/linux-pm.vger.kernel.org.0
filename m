Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3302651D74
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 23:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfFXVze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 17:55:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38020 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFXVze (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 17:55:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so15151547oth.5;
        Mon, 24 Jun 2019 14:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXXOeQr1nr3EJjM+4QD/VWYIWuMniD/p0glIK58q2lw=;
        b=iLduze51oJSQC3mBlxRVCefqeKdDry2HKzymKu7DNq8H4uxyLj7ja8zpDhFn+u1/0z
         SCY0H0xVegN45hW7HN0EJrcAxjgXVwHoWsj59JKb8YPjnyrMDMmVefBMQUE5ySUa4YZC
         CrCCkN198lwGldFeebUDjpsV46e774353lEEEcUWsk2EYt6xi418jlhk2nvD8adH1VQ6
         qMX8Gew8ZosEv08k5U6+k5sR3X0j0nq6IvVbKmFLKamarn5EVUkIQzlm15h2qJio/RKG
         lVtYns5yf0Krj7qUF3vSXUUgDdofx1FN9K+nm7JHqwnOQTWsUr2mmEdUukdzbERypi1K
         YkSQ==
X-Gm-Message-State: APjAAAW6L867WqZo1w1HCkj8Su8WqxbpPQUGZ/gadkgahs+u9KQ9AU3e
        18OK4pHCUmm6qB1B35YdQS6528AEusg30hhtdyI=
X-Google-Smtp-Source: APXvYqxCIMnyIAm/Gne6dT6ugsoyr5ed6v2aWDRBi4esuv9pa5hFlWjlNphmOgrvGiS9NWQiyxoCmcL1ZDid2/BHWuk=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr66359894oto.118.1561413332973;
 Mon, 24 Jun 2019 14:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CANA+-vCBW=P=dpJGfcKTt7SoNKzWcpP5pwZHSDMU6MkwBKoC9A@mail.gmail.com>
 <20190624073659.GA13957@kroah.com> <CAJWu+orGgYwnC+ya13+KtdNrH7ZjvmKL8625m=msVZd0==dq9A@mail.gmail.com>
In-Reply-To: <CAJWu+orGgYwnC+ya13+KtdNrH7ZjvmKL8625m=msVZd0==dq9A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Jun 2019 23:55:21 +0200
Message-ID: <CAJZ5v0jeYRx=9stkGbJZgvyQz=Wp2CBkyTwOkJ2Y61AEE6sMdg@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Joel Fernandes <joelaf@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 24, 2019 at 2:27 PM Joel Fernandes <joelaf@google.com> wrote:
>
> On Mon, Jun 24, 2019 at 3:37 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 23, 2019 at 06:48:43PM -0700, Tri Vo wrote:
> > > On Wed, Jun 19, 2019 at 1:35 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 19, 2019 at 1:52 AM Joel Fernandes <joelaf@google.com> wrote:
> > > > >
> > > > > On Tue, Jun 18, 2019 at 7:15 PM Tri Vo <trong@android.com> wrote:
> > > > > [snip]
> > > > > > > > > >
> > > > > > > > > > Android userspace reading wakeup_sources is not ideal because:
> > > > > > > > > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > > > > > > > > not guaranteed to be backward/forward compatible.
> > > > > > > > > > - This file requires debugfs to be mounted, which itself is
> > > > > > > > > > undesirable for security reasons.
> > > > > > > > > >
> > > > > > > > > > To address these problems, we want to contribute a way to expose these
> > > > > > > > > > statistics that doesn't depend on debugfs.
> > > > > > > > > >
> > > > > > > > > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > > > > > > > > Or maybe implement eBPF-based solution? What do you think?
> > > > > > > >
> > > > > > > > We are going through Android's out-of-tree kernel dependencies along with
> > > > > > > > userspace APIs that are not necessarily considered "stable and forever
> > > > > > > > supported" upstream. The debugfs dependencies showed up on our radar as a
> > > > > > > > result and so we are wondering if we should worry about changes in debugfs
> > > > > > > > interface and hence the question(s) below.
> > > > > > > >
> > > > > > > > So, can we rely on /d/wakeup_sources to be considered a userspace API and
> > > > > > > > hence maintained stable as we do for other /proc and /sys entries?
> > > > > > > >
> > > > > > > > If yes, then we will go ahead and add tests for this in LTP or
> > > > > > > > somewhere else suitable.
> > > > > > >
> > > > > > > No, debugfs is not ABI.
> > > > > > >
> > > > > > > > If no, then we would love to hear suggestions for any changes that need to be
> > > > > > > > made or we simply just move the debugfs entry into somewhere like
> > > > > > > > /sys/power/ ?
> > > > > > >
> > > > > > > No, moving that entire file from debugfs into sysfs is not an option either.
> > > > > > >
> > > > > > > The statistics for the wakeup sources associated with devices are already there
> > > > > > > under /sys/devices/.../power/ , but I guess you want all wakeup sources?
> > > > > > >
> > > > > > > That would require adding a kobject to struct wakeup_source and exposing
> > > > > > > all of the statistics as separate attributes under it.  In which case it would be
> > > > > > > good to replace the existing wakeup statistics under /sys/devices/.../power/
> > > > > > > with symbolic links to the attributes under the wakeup_source kobject.
> > > > > >
> > > > > > Thanks for your input, Rafael! Your suggestion makes sense. I'll work
> > > > > > on a patch for this.
> > > > >
> > > > > Does that entail making each wake up source, a new sysfs node under a
> > > > > particular device, and then adding stats under that new node?
> > > >
> > > > Not under a device, because there are wakeup source objects without
> > > > associated devices.
> > > >
> > > > It is conceivable to have a "wakeup_sources" directory under
> > > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> > > >
> > > > Then, instead of exposing wakeup statistics directly under
> > > > /sys/devices/.../power/, there can be symbolic links from there to the
> > > > new wakeup source nodes under "wakeup_sources" (so as to avoid
> > > > exposing the same data in two different places in sysfs, which may be
> > > > confusing).
> > >
> > > This may be a dumb question. Is it appropriate to make symbolic links
> > > in sysfs from one attribute to another attribute? For example,
> > > /sys/devices/.../power/wakeup_count ->
> > > /sys/power/wakeup_sources/.../wakeup_count.
> >
> > Why? would you want that?
>
> This sounds like what Rafael suggested (quoted above), right?

I did, basically to avoid exposing the same information in two places
via different code paths.

I tend to forget about this limitation, sorry for the confusion.

That's not a big deal, though, the attributes under
/sys/devices/.../power/ just need to stay the way they are (for
backwards compatibility).
