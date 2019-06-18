Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62044AEA0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 01:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfFRXP0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 19:15:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46496 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRXP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 19:15:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so17243872ote.13
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIsSf2GXvyDDqSHsag5yZpphi9br2QVejLk/bHmvVOU=;
        b=RFEpZtInek3Io86FQLQYPSGxY5DbPdOrWHexhniqE/836Q7GoKyLBn5C/t/u+NyiOm
         k91tU09m/SUR6H+dxUwX47Mx4GxGk1hO2WU7XCGEQgxBh6DQSwf6heoiugn9iNCP6o5F
         z0oWkzGRcr+eDW8VjYY3lDtJld2zAiNrHmEkRMTX8rm2qA96nYlH41u3teob2jmMXlYF
         t5acmoJ55ZKaiOWycmMm5ZqMgAzS36wBkDzLqNjJ6qe7bdv0/tAUs+OZeZdiAEyKUSx+
         IoTYLES+7UrlT3ovI04C3hEM6/FCT+4dMoRFCP6QvEZZjdDVg+h4Mmak/08Vnz1J24dL
         PuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIsSf2GXvyDDqSHsag5yZpphi9br2QVejLk/bHmvVOU=;
        b=Cy/Ked3VGMnXTG9P5bqlaoDoSIDySLz3RdkRoQSJ6oKOobsZwao0U02ItQVt5ceqU+
         Ywooud88Nf674e3XQyQ6AxekRT4A4yMAhiT+Il6OxG2/GHh1i3OJTAdWTBmpuxB6G0m6
         bZKqgzIvGCsifKBaKZNijsQWyTvkFK4/QJQOnH+YqMTB/9Pi9JQjXUTK7EVKrL5VG5Mf
         S6ias/GSSRvaToEJVAL73cokO4V7hW1oxNwBj+rsmDpJZ+yk3BzDmyJG8YPsJxAcn39D
         0aJk5XUonayL4Cx89AK4OK9bwi7CKbgw9kBPUNCEEK0VNdL9DPp7CSYUQmAs4S6hURej
         deeg==
X-Gm-Message-State: APjAAAW/DCIuAnssWIKi2IKjCcp3DMsvqwZMmyKc5dLhjXlnzgo9I3PE
        nrbr2hke18WHv92aYGD71ajSAzeNckuzg/rEjT7ytQ==
X-Google-Smtp-Source: APXvYqwNQLjWPtV+R8pF+k88qhC8khbqFVOtcNqlqN3daCyPXfL1Az/KXqmwaSLH86Onsw0+GoRPuR0JCs8tLaQzTqk=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr17885454oth.159.1560899725814;
 Tue, 18 Jun 2019 16:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
In-Reply-To: <4587569.x9DSL43cXO@kreacher>
From:   Tri Vo <trong@android.com>
Date:   Tue, 18 Jun 2019 16:15:14 -0700
Message-ID: <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>, linux-pm@vger.kernel.org,
        kernel-team@android.com, gregkh@linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 18, 2019 at 2:23 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, June 18, 2019 10:17:16 PM CEST Sandeep Patil wrote:
> >
> > Hi Rafael, Viresh etc.
> >
> > On Tue, Jun 11, 2019 at 10:31:16AM -0700, Tri Vo wrote:
> > > On Tue, Jun 4, 2019 at 5:23 PM Tri Vo <trong@android.com> wrote:
> > > >
> > > > Hello Rafael,
> > > >
> > > > Currently, Android reads wakeup sources statistics from
> > > > /sys/kernel/debug/wakeup_sources in production environment. This
> > > > information is used, for example, to report which wake lock prevents
> > > > the device from suspending.
> >
> > Android's usage of the 'wakeup_sources' from debugfs can is linked at[1].
> > Basically, android's battery stats implementation to plot history for suspend
> > blocking wakeup sources over device's boot cycle. This is used both for power
> > specific bug reporting but also is one of the stats that will be used towards
> > attributing the battery consumption to specific processes over the period of
> > time.
> >
> > Android depended on the out-of-tree /proc/wakelocks before and now relies on
> > wakeup_sources debugfs entry heavily for the aforementioned use cases.
> >
> > > >
> > > > Android userspace reading wakeup_sources is not ideal because:
> > > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > > not guaranteed to be backward/forward compatible.
> > > > - This file requires debugfs to be mounted, which itself is
> > > > undesirable for security reasons.
> > > >
> > > > To address these problems, we want to contribute a way to expose these
> > > > statistics that doesn't depend on debugfs.
> > > >
> > > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > > Or maybe implement eBPF-based solution? What do you think?
> >
> > We are going through Android's out-of-tree kernel dependencies along with
> > userspace APIs that are not necessarily considered "stable and forever
> > supported" upstream. The debugfs dependencies showed up on our radar as a
> > result and so we are wondering if we should worry about changes in debugfs
> > interface and hence the question(s) below.
> >
> > So, can we rely on /d/wakeup_sources to be considered a userspace API and
> > hence maintained stable as we do for other /proc and /sys entries?
> >
> > If yes, then we will go ahead and add tests for this in LTP or
> > somewhere else suitable.
>
> No, debugfs is not ABI.
>
> > If no, then we would love to hear suggestions for any changes that need to be
> > made or we simply just move the debugfs entry into somewhere like
> > /sys/power/ ?
>
> No, moving that entire file from debugfs into sysfs is not an option either.
>
> The statistics for the wakeup sources associated with devices are already there
> under /sys/devices/.../power/ , but I guess you want all wakeup sources?
>
> That would require adding a kobject to struct wakeup_source and exposing
> all of the statistics as separate attributes under it.  In which case it would be
> good to replace the existing wakeup statistics under /sys/devices/.../power/
> with symbolic links to the attributes under the wakeup_source kobject.

Thanks for your input, Rafael! Your suggestion makes sense. I'll work
on a patch for this.
>
> > As a side effect, if the entry moves out of debugfs, Android can run without
> > mounting debugfs in production that I assume is a good thing.
>
> And really Android developers might have thought about this a bit earlier.

I'm still learning about kernel development. And Android has made
missteps before. So I figured it's a good idea to ask first :)

Thanks!
