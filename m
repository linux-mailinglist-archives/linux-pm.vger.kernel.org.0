Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6CE4BF08
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 18:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFSQxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 12:53:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39883 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfFSQxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 12:53:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so15451121qta.6
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYMNIKcjL4Im+SennGa+XjMhlJ0DqA4TR37g4bDfY8A=;
        b=X93+RkH1AP4eH9O7+Vc4AFhGsh4IuOn0IqGnH+A+qylAXMGKwTqrC7EGQ4632cMtLw
         G+tZKngtA6wdbzyltB8gZJHYhvgpF/QUAxdbtUwWPXwt55iuLFmAtG9qRw1yQCJRL4G+
         U+cpXFlWNR+KocrrLLc1h39g4vDv7f9+KLVIsv+nV4glGjOP1azibeDv6lw0lEAdSy2q
         s0FO4t7moA0gaL37febugDXyMK0whltPr1icaR7ZAc+y63rrXes5u6gQGcuZE+ABxq81
         DNJC52+LsG6P0e0jIcc+66nUWE/Q3ZBXqQi7INqwYRUAqHNAh1f2aQTTpA0TY0ZiAj49
         Yibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYMNIKcjL4Im+SennGa+XjMhlJ0DqA4TR37g4bDfY8A=;
        b=kyYJnbbQYpsyP58N306xGasm383qFbnoJYXP10A8ZSoJ/LXjCD9Qlvo2WOsquhPDS1
         Nb0FvJUP34RswWZ97brcHEmZZaB0/tOkjp1QfcPibaTU6p9FYfg70fZEQhWsK2ELfYWq
         8TnE7e4WLxQiAihRRe1znu7o/HK3T8FiApDtiGf2yehby3BlcBRcl8LNT90CaSPsAreT
         swCzW+eg/tiYmUdoDPK9vLytHiaC0mDrkDlCF6LxJ8hl3c7e4dNN8UQCoGHlxeAStt/X
         zyLqIpQBlCejOR1yuTXyR1jbNLVTwAm1rRsnyGBXpJMnu51RpyFgkeKPyzur6kUGQiAU
         Q6Gw==
X-Gm-Message-State: APjAAAW+4M/rG/HVTXjMuL7CfsDuaTnVKAhEkMKOQnlEvWSB7Z9+ZY9D
        B31w7f8fSOQOLiyWnETWZQo/ZcjGXqDDEFMZeI5NcA==
X-Google-Smtp-Source: APXvYqyhTixFvouF46KrsRa9YjKjFmQrNlBkAWFjeWNgQwMNGD7h1zG3+pLYWZpkOzE9H0YG7lTlio+jT4hk+jzKpRM=
X-Received: by 2002:a0c:ae5a:: with SMTP id z26mr34511722qvc.65.1560963204268;
 Wed, 19 Jun 2019 09:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com> <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 19 Jun 2019 12:53:12 -0400
Message-ID: <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 4:35 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jun 19, 2019 at 1:52 AM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Tue, Jun 18, 2019 at 7:15 PM Tri Vo <trong@android.com> wrote:
[snip]
> > > > > If no, then we would love to hear suggestions for any changes that need to be
> > > > > made or we simply just move the debugfs entry into somewhere like
> > > > > /sys/power/ ?
> > > >
> > > > No, moving that entire file from debugfs into sysfs is not an option either.
> > > >
> > > > The statistics for the wakeup sources associated with devices are already there
> > > > under /sys/devices/.../power/ , but I guess you want all wakeup sources?
> > > >
> > > > That would require adding a kobject to struct wakeup_source and exposing
> > > > all of the statistics as separate attributes under it.  In which case it would be
> > > > good to replace the existing wakeup statistics under /sys/devices/.../power/
> > > > with symbolic links to the attributes under the wakeup_source kobject.
> > >
> > > Thanks for your input, Rafael! Your suggestion makes sense. I'll work
> > > on a patch for this.
> >
> > Does that entail making each wake up source, a new sysfs node under a
> > particular device, and then adding stats under that new node?
>
> Not under a device, because there are wakeup source objects without
> associated devices.
>
> It is conceivable to have a "wakeup_sources" directory under
> /sys/power/ and sysfs nodes for all wakeup sources in there.

One of the "issues" with this is, now if you have say 100 wake up
sources, with 10 entries each, then we're talking about a 1000 sysfs
files. Each one has to be opened, and read individually. This adds
overhead and it is more convenient to read from a single file. The
problem is this single file is not ABI. So the question I guess is,
how do we solve this in both an ABI friendly way while keeping the
overhead low.

Thanks,

 - Joel
