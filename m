Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15FF40B711
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhINSmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhINSmh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Sep 2021 14:42:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6E2C061574
        for <linux-pm@vger.kernel.org>; Tue, 14 Sep 2021 11:41:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s3so349857ljp.11
        for <linux-pm@vger.kernel.org>; Tue, 14 Sep 2021 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5VMpWRXt0jQuCEr+r0BM8kFoy1D29x31MLf3bnRKZqo=;
        b=b11SCPjz52oi1yBAOvY57UeyiD8/Ms3ExnET43X/lvFkWoqblZlZUbvHg0+wdNXdFN
         CtUHC+3qh+hX78zPevGjyIuPDcLVquMk4uXzdJJaQHd+HiaK71IWmxnnp0vIYzGq1JMX
         AtyJpWb0WCFKDqWlXiWidZUM93Gm0wERsRan+CRsWEpPTJ9gVdeJHf48KYpe8fuEB2uf
         es8EK1+mpdeMIsqsv4hT+cxjb5HUEsmqU3MV9yeFjEO/Yl4q0xv0YMtOugxPPSgOpVHw
         Gg1nTijVelp3vnDjGo4pu03Hx1GOjxaum78pSG6eY99ouhpbcGSjX0tb3jl/DYEgF1Gn
         lV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5VMpWRXt0jQuCEr+r0BM8kFoy1D29x31MLf3bnRKZqo=;
        b=SZNmsfYKYsqSvax8e0WuMzKwIgp+LDJmNuY9whY66j03W7qrnOWylRc+vytj8y/S/b
         kFGK7VcazM0a+uZSoOirYvE9lkL/zIM/3KvL1iZrx6qM006AhcBd6lfqANnHqjt6M2qU
         xYdwt4UphcqzNUb9R1lUeyMNbe15EQxjYnJRXi68BJilM+4iEV11vSjvMMqKT1b+GTIT
         /HjDY3kLtWNAz+FA+EboDxsEJGoXeKRy7rN67gD9i8V1BDJcS8d39jIvk/XPiWJB+Jdn
         wyJiKzlji5AFerA/XhsLpqI6gUGyc8vwEvUA3Aqu936xu4DM+RAXaf4fXUMK/H1qxeRn
         0MKg==
X-Gm-Message-State: AOAM532mm+IsoXyU6ROMH+fmvaztjw4HZl2WwlF3c8a0fj6EA4RNL/Mh
        LK0GhX2FH637xp+lA+GjHc5ZsYg/JPy1EIiS4UkvTw==
X-Google-Smtp-Source: ABdhPJyJFg7U0SySGwcX4hh4wxl9aHZdQMr5YsM70bRBO1qYAVvBNFSlNsuAYAWsKhw+uCtIo3ojWd6+04ZNE3bd/P4=
X-Received: by 2002:a2e:8504:: with SMTP id j4mr16617853lji.352.1631644877772;
 Tue, 14 Sep 2021 11:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
 <20210513132051.31465-1-ggherdovich@suse.cz> <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
 <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz> <CAAYoRsX0xJf1mm1a_YUCzDy86r8q4QE98iVtS1AMLaUx+KTgQQ@mail.gmail.com>
 <CAAYoRsXK79PspEUh9pqgj2OGQnxQONkEeK-7af3=5frBzAqULQ@mail.gmail.com>
 <2a1b000cd101737400f6320ef18c0143d3a5145b.camel@linux.intel.com>
 <CAAYoRsVeMCivVBp-q_9N23BDOVvkc8ZLS3mubnz+4TREZ9Cz_A@mail.gmail.com>
 <7abae13c235d74f4789cd93c6c6b0cbf69df243d.camel@linux.intel.com> <CAAYoRsVd4uU7sofcvYWd__evKJTf7HE5mi2ZVDjAYNYWXS3mzQ@mail.gmail.com>
In-Reply-To: <CAAYoRsVd4uU7sofcvYWd__evKJTf7HE5mi2ZVDjAYNYWXS3mzQ@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 14 Sep 2021 11:41:07 -0700
Message-ID: <CAAYoRsUnuNL+orjeXpxEE4fyknGGk3Kngk6Gt+hoCHxLYg9D6A@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in
 no-HWP mode
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 7, 2021 at 8:43 PM Doug Smythies <dsmythies@telus.net> wrote:
> On Tue, Sep 7, 2021 at 7:04 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Tue, 2021-09-07 at 13:16 -0700, Doug Smythies wrote:
> > > On Tue, Sep 7, 2021 at 9:01 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > On Tue, 2021-09-07 at 08:45 -0700, Doug Smythies wrote:
> > > > >
> > > > > Recent ASUS BIOS updates have changed the default system
> > > > > response for this old thread, rendering "intel_pstate=3Dno_hwp"
> > > > > useless.
> > > > >
> > > > > It also raises a question: If BIOS has forced HWP, then how do we
> > > > > prevent the acpi-cpufreq driver from being used? Read on.
> > > >
> > > > Does BIOS has option to enable Intel speed shift with no legacy
> > > > support?
> > > > Then this option will not populate ACPI _PSS table.
> > >
> > > The option is there no matter what.
> > > I have tried every variation of legacy or no legacy that
> > > I can find. Currently:
> > > Current boot mode:   UEFI Firmware mode
> > > SecureBoot:          disabled
> > >
> > > >
> > > > >
> > > > > On Fri, May 14, 2021 at 3:12 PM Doug Smythies <
> > > > > dsmythies@telus.net>
> > > > > wrote:
> > > > > >
> > > > > > On Fri, May 14, 2021 at 1:33 PM Giovanni Gherdovich <
> > > > > > ggherdovich@suse.cz> wrote:
> > > > > > > On Fri, 2021-05-14 at 08:31 -0700, Doug Smythies wrote:
> > > > > ...
> > > > > > >
> > > ...
> > > > > Previous correspondence was with BIOS version 1003. There have
> > > > > been 3 BIOS
> > > > > releases since then (at least that I know of), 2103, 2201, 2301,
> > > > > and all of them have changed the behaviour
> > > > > of the "Auto" setting for Intel Speed Shift
> > > > > Technology BIOS setting, forcing it on upon transfer of control
> > > > > to the OS.
> > > > >
> > > > > Where with "intel_pstate=3Dno_hwp" one used to get 0 for
> > > > > MSR_PM_ENABLE
> > > > > (0x770) they now get 1.
> > > >
> > > > So they are forcing Out of band OOB mode.
> > > > Does bit 8 or 18 in MSR 0x1aa is set?
> > >
> > > No.
> >
> > So there is no legacy path. I think you are working with their support.
>
> Yes, for almost a month now, with very little to show for it.
> We'll see what happens. I did get a message this afternoon:
>
> "Our GTSD is debugging the issue,.
> When they have the result, they will directly update you."
>
> > In HWP mode does setting scaling min/max frequency has any impact?
>
> No. I wouldn't have expected it to, as the system is confused as to who
> is in charge. The acpi-cpufreq driver thinks it is in charge, but HWP
> thinks it is.
>
> The intel_pstate driver works fine.

Hi Srinivas,

I heard back from ASUS, and they now confirm that they
did change the behaviour of the "Auto" setting in BIOS
version 2103. They say they did it to fix an issue with
ITB3.0, which I assume means Intel Turbo Boost 3.0.
I'll copy and paste the relevant portion of the email
below:

" I am in direct contact with the engineers.
Here is the result from their test:

In BIOS 2103,the =E2=80=9CAuto=E2=80=9D setting transfers control to
the OS with HWP available and enabled.

This is side effect to fix ITBM3.0 not work after HWP enabled.
We can remove this patch, but ITBM3.0 will not work when HWP enabled"

Are you familiar with this issue?

I want the original behaviour of the "Auto" setting, as it is
the only way for control to go to the OS with HWP
available but disabled.

... Doug
