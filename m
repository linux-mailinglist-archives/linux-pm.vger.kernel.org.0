Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127DF4AB87
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfFRURS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 16:17:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37409 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbfFRURR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 16:17:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id n65so3824200pga.4
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WnfM1fJuGpeShE3wWQrmckJgD7TPf/8hfeFmLxyhLwk=;
        b=hhwx3Gbfku4etrIAgCb090jSq6O7gA0BpezqpGrLllt+yC2IVMt/zEj4547TCNDiIm
         3qETuWJAMlL5cPT555NtO80Wy5un2MFr8MSZSQAwtH8tu0MrpwKpGWWLdq2TK4qoYPMI
         26p1mfXQxlw9Sw8aOjzV2MIa4Egc8ZYANDIMsY9xg29AyiKzbGtd0J0zqkFZ1v8L5pIG
         fMRGjlCvsw58ou+Mniq1BaJH4audKFVEycZ8Tg3hFWOnV+OI9hDrBS7o0JanEFlu1Md/
         J4cO2MtQgTmKbfM3TGk8qEkCtRr7LwygMPTE0I86YgObucKPomAl7OL3wwoFjpMEFnzI
         ZODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WnfM1fJuGpeShE3wWQrmckJgD7TPf/8hfeFmLxyhLwk=;
        b=B8+Gqck3jkH0S5sjtdFuOM21G5q0nL+WFN0+H1oErjjUQn8iP1GWauEwJGeqKV0+5j
         TnCeiKyJNsZ0bLK7WbuiPp9roJKFdUAoI5neI7aAloAx8hxsk3f1+6NWhjvnc6pEQGcA
         fKKEf3qJ9ep9FDbjqcarwm8CpHn3jLT8uzyUu8eh6SB/NyypGNB0/WB2zqGEmzgLSV8N
         UMThlFA8dhr+DouZJYgymbYPwEXUb8S7ReG1QxcWT/2g0nA+PsSnMnPurKAcGZEJJeno
         q/B4vx9JlNP0SbreYxORJWz0Wp9ClqOd+Qr9PYMfuuNfakBXmLCnASNxnhpJLlNPZ4T8
         HbYg==
X-Gm-Message-State: APjAAAXwj2VdFiLqeeSgTJe0NUX/jC/GeV7uivkLadxHhabiHy2Mjyqb
        cILVoAYcrodJOmIUTIHX3lHtGg==
X-Google-Smtp-Source: APXvYqzIseOic7/RXuYx5+aDCZBge4s6AjkKNrDDli14aIu9dSfUjA+F/zECHvkMmX/WJCEngjs2Cw==
X-Received: by 2002:a17:90a:db08:: with SMTP id g8mr6812828pjv.39.1560889037270;
        Tue, 18 Jun 2019 13:17:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3fed:2d30:9d40:70a3])
        by smtp.gmail.com with ESMTPSA id j23sm15478266pff.90.2019.06.18.13.17.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 13:17:16 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:17:16 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     Tri Vo <trong@android.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        Hridya Valsaraju <hridya@google.com>, linux-pm@vger.kernel.org,
        kernel-team@android.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
Message-ID: <20190618182502.GC203031@google.com>
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael, Viresh etc.

On Tue, Jun 11, 2019 at 10:31:16AM -0700, Tri Vo wrote:
> On Tue, Jun 4, 2019 at 5:23 PM Tri Vo <trong@android.com> wrote:
> >
> > Hello Rafael,
> >
> > Currently, Android reads wakeup sources statistics from
> > /sys/kernel/debug/wakeup_sources in production environment. This
> > information is used, for example, to report which wake lock prevents
> > the device from suspending.

Android's usage of the 'wakeup_sources' from debugfs can is linked at[1].
Basically, android's battery stats implementation to plot history for suspend
blocking wakeup sources over device's boot cycle. This is used both for power
specific bug reporting but also is one of the stats that will be used towards
attributing the battery consumption to specific processes over the period of
time.

Android depended on the out-of-tree /proc/wakelocks before and now relies on
wakeup_sources debugfs entry heavily for the aforementioned use cases.

> >
> > Android userspace reading wakeup_sources is not ideal because:
> > - Debugfs API is not stable, i.e. Android tools built on top of it are
> > not guaranteed to be backward/forward compatible.
> > - This file requires debugfs to be mounted, which itself is
> > undesirable for security reasons.
> >
> > To address these problems, we want to contribute a way to expose these
> > statistics that doesn't depend on debugfs.
> >
> > Some initial thoughts/questions: Should we expose the stats in sysfs?
> > Or maybe implement eBPF-based solution? What do you think?

We are going through Android's out-of-tree kernel dependencies along with
userspace APIs that are not necessarily considered "stable and forever
supported" upstream. The debugfs dependencies showed up on our radar as a
result and so we are wondering if we should worry about changes in debugfs
interface and hence the question(s) below.

So, can we rely on /d/wakeup_sources to be considered a userspace API and
hence maintained stable as we do for other /proc and /sys entries?

If yes, then we will go ahead and add tests for this in LTP or
somewhere else suitable.

If no, then we would love to hear suggestions for any changes that need to be
made or we simply just move the debugfs entry into somewhere like
/sys/power/ ?

As a side effect, if the entry moves out of debugfs, Android can run without
mounting debugfs in production that I assume is a good thing.

- ssp

1. https://android.googlesource.com/platform/frameworks/base/+/refs/heads/master/core/java/com/android/internal/os/KernelWakelockReader.java#127
