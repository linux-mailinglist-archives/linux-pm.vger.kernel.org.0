Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D584B423
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 10:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfFSIfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 04:35:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37014 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfFSIfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 04:35:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so18459269otp.4;
        Wed, 19 Jun 2019 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+aGgdCq18WEu7EQPUxRISqQBQ1QUiTsnK0wg2Fi8nU=;
        b=AZeWNQC1MMLPIbILx9t/S0XkvKEQxXoS8SKx/GQTaxWYq9yXFYJXKwPmYSlda158Ql
         EPWu0P4Whdd72zAufciBzlwIydT7HLJ57c5kpCG46SCw7LiF4YfqoUFoqGvVuEJ+s4ki
         +umc7JOasatoxYt6H1o9jAYv3wu1gZtdP9XbsPhrbfrgExUBp7vQReYr5njYUDAD6fVy
         JNXcqFZJp1G7TUSpCoOeFxTYjdliFD7Y6XV4bshlIH0GDq4Gpe3Tn5+It8RCrhqwmCva
         wtmB1H5BM1H0IPenIHV3F9K6oZndFAT+EUJtI20aewZXsugOt0ERaDR+/Nu7aupl1fU6
         xQlw==
X-Gm-Message-State: APjAAAVnAm3c90YInB1qsYMapQzpcV3QZH5fZRVmvIOyxwU6PSVPlx20
        vum60zpFaHt5dIfsC3As2gkoUcdV97ZY2ijLJhs=
X-Google-Smtp-Source: APXvYqyN4AtDJW6N60l0QS5TUvuJdK74OUuvpF3lXn5+gy2GELjZ0UJfDiusOR1H1yQpaIqFIeM41kJBgNQMTYaVjAI=
X-Received: by 2002:a9d:5d15:: with SMTP id b21mr911689oti.262.1560933329596;
 Wed, 19 Jun 2019 01:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com> <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com> <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
In-Reply-To: <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 10:35:17 +0200
Message-ID: <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     Joel Fernandes <joelaf@google.com>
Cc:     Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 1:52 AM Joel Fernandes <joelaf@google.com> wrote:
>
> On Tue, Jun 18, 2019 at 7:15 PM Tri Vo <trong@android.com> wrote:
> [snip]
> > > > > >
> > > > > > Android userspace reading wakeup_sources is not ideal because:
> > > > > > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > > > > > not guaranteed to be backward/forward compatible.
> > > > > > - This file requires debugfs to be mounted, which itself is
> > > > > > undesirable for security reasons.
> > > > > >
> > > > > > To address these problems, we want to contribute a way to expose these
> > > > > > statistics that doesn't depend on debugfs.
> > > > > >
> > > > > > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > > > > > Or maybe implement eBPF-based solution? What do you think?
> > > >
> > > > We are going through Android's out-of-tree kernel dependencies along with
> > > > userspace APIs that are not necessarily considered "stable and forever
> > > > supported" upstream. The debugfs dependencies showed up on our radar as a
> > > > result and so we are wondering if we should worry about changes in debugfs
> > > > interface and hence the question(s) below.
> > > >
> > > > So, can we rely on /d/wakeup_sources to be considered a userspace API and
> > > > hence maintained stable as we do for other /proc and /sys entries?
> > > >
> > > > If yes, then we will go ahead and add tests for this in LTP or
> > > > somewhere else suitable.
> > >
> > > No, debugfs is not ABI.
> > >
> > > > If no, then we would love to hear suggestions for any changes that need to be
> > > > made or we simply just move the debugfs entry into somewhere like
> > > > /sys/power/ ?
> > >
> > > No, moving that entire file from debugfs into sysfs is not an option either.
> > >
> > > The statistics for the wakeup sources associated with devices are already there
> > > under /sys/devices/.../power/ , but I guess you want all wakeup sources?
> > >
> > > That would require adding a kobject to struct wakeup_source and exposing
> > > all of the statistics as separate attributes under it.  In which case it would be
> > > good to replace the existing wakeup statistics under /sys/devices/.../power/
> > > with symbolic links to the attributes under the wakeup_source kobject.
> >
> > Thanks for your input, Rafael! Your suggestion makes sense. I'll work
> > on a patch for this.
>
> Does that entail making each wake up source, a new sysfs node under a
> particular device, and then adding stats under that new node?

Not under a device, because there are wakeup source objects without
associated devices.

It is conceivable to have a "wakeup_sources" directory under
/sys/power/ and sysfs nodes for all wakeup sources in there.

Then, instead of exposing wakeup statistics directly under
/sys/devices/.../power/, there can be symbolic links from there to the
new wakeup source nodes under "wakeup_sources" (so as to avoid
exposing the same data in two different places in sysfs, which may be
confusing).

Cheers!
