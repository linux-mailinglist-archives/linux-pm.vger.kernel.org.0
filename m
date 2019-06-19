Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777ED4BEF6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfFSQv2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 12:51:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43654 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFSQv2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 12:51:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so40488plb.10
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CSjfI0FdDG+opCSifX1YJn6xlbBS3iUU167wnFEoRhM=;
        b=na7Ua03UGckZdukIKV1RvIdd+/eBWPhu2Xv1M5Iz4VOhj/xZXPCeybNKDOwEFHQqaJ
         4Qni8MMipPwexSAx6NTSD4WeH19YYHLHhPr6jeYGXnaX/3yDoaEUBIW7AWW7RUu4hSxr
         JPKJckpitjG72BV7SVUaCiYfbwG7B6m0/FqvJ59UbnfmYAjIQR2uuEKvjnJyUY8vfpvy
         gRg4xK2bg96grfS8/3J8aZa5excfjaXGVvxH9jKnyjfcJjp8UCErPo+RO4Iqo8kUxQTJ
         1mMFIJ/DzMt/JKRmHeOzrPPoDBEIagP8eAzq79opI1jMbjTT7zujH5n4QDsjTuB/VE4/
         oxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CSjfI0FdDG+opCSifX1YJn6xlbBS3iUU167wnFEoRhM=;
        b=hGlBVe1Sc9iyUJNoCiqucpUMucFzne7x854XT/Re61pO6ms2JvIV8uMv4s0oxuwcF/
         T4fpkksuzI9U6AhAA38YS3LnfiSo1hGARDQMx1mmsjCjLhKYqIdprDt2crlqdAifof30
         gVd/AiqTG5F86BVkvEv57xbeJvF7c3xLX4yXacqG86TdBDUTQtvxri1ilrZgGQnYvMlJ
         imQnL2+xSH/wiGdsIt46mvlY4EJH9Fbiq0ikqjPCVFjda67t9ntlidtbdDXqKHy0YHSz
         +4z3H8i7tBrn3/wQ7dSCTf3e9nfi00x9ELr4zOceCvw1tAkU5rjoQ2V+Aq1IiFKQj5aT
         WGrg==
X-Gm-Message-State: APjAAAU27JW/MlzOf6oxm2yEEuumWu9DubblTr4OO8M6mPRXHmr1x8g9
        w92xsVMBTo3m/3DHTp3YC3mMzg==
X-Google-Smtp-Source: APXvYqyJ+dq1/NnuO/k64sEc5k3XnyKIxTdXLg77GYOL/k7t3tSTvPC1sYxudnn8YKgzFOs+CHh89w==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr97652906plk.180.1560963087287;
        Wed, 19 Jun 2019 09:51:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3fed:2d30:9d40:70a3])
        by smtp.gmail.com with ESMTPSA id z4sm18902897pfa.142.2019.06.19.09.51.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 09:51:26 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:51:25 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>, Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
Message-ID: <20190619165125.GG203031@google.com>
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com>
 <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 10:35:17AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2019 at 1:52 AM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Tue, Jun 18, 2019 at 7:15 PM Tri Vo <trong@android.com> wrote:
> > [snip]
> > > > > > >
> > > > > > > Android userspace reading wakeup_sources is not ideal because:
> > > > > > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > > > > > not guaranteed to be backward/forward compatible.
> > > > > > > - This file requires debugfs to be mounted, which itself is
> > > > > > > undesirable for security reasons.
> > > > > > >
> > > > > > > To address these problems, we want to contribute a way to expose these
> > > > > > > statistics that doesn't depend on debugfs.
> > > > > > >
> > > > > > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > > > > > Or maybe implement eBPF-based solution? What do you think?
> > > > >
> > > > > We are going through Android's out-of-tree kernel dependencies along with
> > > > > userspace APIs that are not necessarily considered "stable and forever
> > > > > supported" upstream. The debugfs dependencies showed up on our radar as a
> > > > > result and so we are wondering if we should worry about changes in debugfs
> > > > > interface and hence the question(s) below.
> > > > >
> > > > > So, can we rely on /d/wakeup_sources to be considered a userspace API and
> > > > > hence maintained stable as we do for other /proc and /sys entries?
> > > > >
> > > > > If yes, then we will go ahead and add tests for this in LTP or
> > > > > somewhere else suitable.
> > > >
> > > > No, debugfs is not ABI.
> > > >
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


This is what I understood from your initial reply and I think it makes sense.
Thanks again, Rafael.

- ssp

> 
> Then, instead of exposing wakeup statistics directly under
> /sys/devices/.../power/, there can be symbolic links from there to the
> new wakeup source nodes under "wakeup_sources" (so as to avoid
> exposing the same data in two different places in sysfs, which may be
> confusing).
> 
> Cheers!
