Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46A50AA8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfFXM1e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 08:27:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37985 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfFXM1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 08:27:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so2960663qtl.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pxgU2+2zAe7XjIsxn6dDw49AVrZSbjiR8p9fg9h61c=;
        b=izv8/ISAHD8c9UNVkM0cWQvNgJp3wRoXCluQG17yMRfV2pDdp1/uWG9IXPpDE/XYKH
         CQELaE70QgG60CSIem6+F6R2WvEQaZnzaFC1s3chbLxM9lxC2EBLHJWA9yMJ1J5AHz3P
         7Zpy0MkZGWg/jnMkdoP+RjTjqsNzWfhxRh/xufz46CJ8Bi0bpWfwAGQ9z4+84AQcvFFV
         7NSNuj1D+TU3msKRtqeLsf8HA47QG7I/FJcR/P/ZoG073n9/Vgaj78HN3O0I2bM28Q3P
         qcnLqv41V8hfaMJFwessbe/ky89XOtoWX4bZ9dD7wVAZ6zUgQjHis6jvi1iyT9uLt35P
         zlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pxgU2+2zAe7XjIsxn6dDw49AVrZSbjiR8p9fg9h61c=;
        b=tH7AbfxvrbXOFUnBQSO0TfUCNzMZshgdD5C0P1vxXeFn2y+7A/W0w/5kfNiRvrSPYw
         z73herjtSmKWwPLAo/W5judhnJPnAPHwXM+kPJdyHqAbmWe9gnAIvm0+A2PIkvbq30LM
         o0gnijJ2wyO7QS+BfMFpqrPYUi9AhMBEUdU1hR3pZFjxnJaP9Dt3GAO9xlYjY6tMsnB2
         re1ebx1v+FBAkY2nAkATN+T5YNcHnKOvolLoV8h3HnqjPgsrnlRFzHNR5ffJrwwdCybt
         Tj3LV9odby02iATuyAw1P2v/VwIoA1NvSvhYqDSYMY4xsW5gNJ74OGarAen5GVGHa7le
         1gcg==
X-Gm-Message-State: APjAAAX8TGfgSRopH0JJXBJmMX7If425hrGJ+8H9caPYz+Y4F+OBJthG
        xVPlzZKxYOf17a+zlrtxNwFVGY7ZB7+ncjCLSY3hxw==
X-Google-Smtp-Source: APXvYqyM38rDzwG+qvoXoDo5ZWVVUOEgmwuEYbjLvKWiYs9mNZH/qiES9AHddHYSmG8/Wpvavwglr3tx6kusJaGPdL0=
X-Received: by 2002:aed:21f0:: with SMTP id m45mr114648286qtc.391.1561379252759;
 Mon, 24 Jun 2019 05:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CANA+-vCBW=P=dpJGfcKTt7SoNKzWcpP5pwZHSDMU6MkwBKoC9A@mail.gmail.com> <20190624073659.GA13957@kroah.com>
In-Reply-To: <20190624073659.GA13957@kroah.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 24 Jun 2019 08:27:21 -0400
Message-ID: <CAJWu+orGgYwnC+ya13+KtdNrH7ZjvmKL8625m=msVZd0==dq9A@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tri Vo <trong@android.com>,
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

On Mon, Jun 24, 2019 at 3:37 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 23, 2019 at 06:48:43PM -0700, Tri Vo wrote:
> > On Wed, Jun 19, 2019 at 1:35 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Wed, Jun 19, 2019 at 1:52 AM Joel Fernandes <joelaf@google.com> wrote:
> > > >
> > > > On Tue, Jun 18, 2019 at 7:15 PM Tri Vo <trong@android.com> wrote:
> > > > [snip]
> > > > > > > > >
> > > > > > > > > Android userspace reading wakeup_sources is not ideal because:
> > > > > > > > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > > > > > > > not guaranteed to be backward/forward compatible.
> > > > > > > > > - This file requires debugfs to be mounted, which itself is
> > > > > > > > > undesirable for security reasons.
> > > > > > > > >
> > > > > > > > > To address these problems, we want to contribute a way to expose these
> > > > > > > > > statistics that doesn't depend on debugfs.
> > > > > > > > >
> > > > > > > > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > > > > > > > Or maybe implement eBPF-based solution? What do you think?
> > > > > > >
> > > > > > > We are going through Android's out-of-tree kernel dependencies along with
> > > > > > > userspace APIs that are not necessarily considered "stable and forever
> > > > > > > supported" upstream. The debugfs dependencies showed up on our radar as a
> > > > > > > result and so we are wondering if we should worry about changes in debugfs
> > > > > > > interface and hence the question(s) below.
> > > > > > >
> > > > > > > So, can we rely on /d/wakeup_sources to be considered a userspace API and
> > > > > > > hence maintained stable as we do for other /proc and /sys entries?
> > > > > > >
> > > > > > > If yes, then we will go ahead and add tests for this in LTP or
> > > > > > > somewhere else suitable.
> > > > > >
> > > > > > No, debugfs is not ABI.
> > > > > >
> > > > > > > If no, then we would love to hear suggestions for any changes that need to be
> > > > > > > made or we simply just move the debugfs entry into somewhere like
> > > > > > > /sys/power/ ?
> > > > > >
> > > > > > No, moving that entire file from debugfs into sysfs is not an option either.
> > > > > >
> > > > > > The statistics for the wakeup sources associated with devices are already there
> > > > > > under /sys/devices/.../power/ , but I guess you want all wakeup sources?
> > > > > >
> > > > > > That would require adding a kobject to struct wakeup_source and exposing
> > > > > > all of the statistics as separate attributes under it.  In which case it would be
> > > > > > good to replace the existing wakeup statistics under /sys/devices/.../power/
> > > > > > with symbolic links to the attributes under the wakeup_source kobject.
> > > > >
> > > > > Thanks for your input, Rafael! Your suggestion makes sense. I'll work
> > > > > on a patch for this.
> > > >
> > > > Does that entail making each wake up source, a new sysfs node under a
> > > > particular device, and then adding stats under that new node?
> > >
> > > Not under a device, because there are wakeup source objects without
> > > associated devices.
> > >
> > > It is conceivable to have a "wakeup_sources" directory under
> > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> > >
> > > Then, instead of exposing wakeup statistics directly under
> > > /sys/devices/.../power/, there can be symbolic links from there to the
> > > new wakeup source nodes under "wakeup_sources" (so as to avoid
> > > exposing the same data in two different places in sysfs, which may be
> > > confusing).
> >
> > This may be a dumb question. Is it appropriate to make symbolic links
> > in sysfs from one attribute to another attribute? For example,
> > /sys/devices/.../power/wakeup_count ->
> > /sys/power/wakeup_sources/.../wakeup_count.
>
> Why? would you want that?

This sounds like what Rafael suggested (quoted above), right?
