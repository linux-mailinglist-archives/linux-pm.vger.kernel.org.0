Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774F243E890
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhJ1Spm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 14:45:42 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:45972 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJ1Spl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 14:45:41 -0400
Received: by mail-oo1-f43.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so2446840oop.12;
        Thu, 28 Oct 2021 11:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zUy3F64VyvAN1yH0C1i8i1qWi6nPUFUYymxm3Q8UCc=;
        b=muN891ivavTsyZeO6+V66+b2PprDXhJonxSDrsnSgpoUJ5O2fXyXf8kq2L/AmjIdH7
         MU8dIvZbWpz/5XD18cR+3XH6Ob4kI+2AIsWvyATPT/06zL6Auopq0h5eQJvhUSnLb/Yf
         JNYDb/DS4fKcDKVYCfi+Izp1wz8Y+Vb1YrP6OrqS0jJPkfaq0LNUJlv+8e4Z9nw0GXyR
         Zdt1PAOA+E3yP577+6sgAPQ1EQUXieJyq6KrfZma5MaxYKYv8E+M1Tp+qcbs8Rnr0akw
         RzmgETyN0lZMGuJk7ei2l3eL3olBMuLgzQO7A7QJyTviO7j0ZEkmBbZiNmIzfZ0eFkZ/
         HCjw==
X-Gm-Message-State: AOAM530s/LOD18PTtU9oL6oPDWwhwE7Or+pIcxeY0x5pTqdiVJTYP/CP
        1+657TbJ8vWHbTno/YfA4J+IzQwA/+0aj5kIDNU=
X-Google-Smtp-Source: ABdhPJwOVLLK18lzyI/KFXPP9qppGjsyzBQaISyEPLyrxWkaDHfIK/N5R3P9gBNiuPuI1udI94Iabv5PfzDbeJj+22Y=
X-Received: by 2002:a05:6820:54e:: with SMTP id n14mr4336952ooj.89.1635446594349;
 Thu, 28 Oct 2021 11:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
 <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
 <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien> <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com>
 <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com> <CAJZ5v0gAax-uz+shKv4MNBiSBPKGroQGNKdYyUK4v6sRS15o_w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gAax-uz+shKv4MNBiSBPKGroQGNKdYyUK4v6sRS15o_w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Oct 2021 20:43:03 +0200
Message-ID: <CAJZ5v0iM2=VAymcmBXKVL0SVt-P6iswoYqXAzuzBuQpUhKnZjA@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 28, 2021 at 8:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 28, 2021 at 7:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 28, 2021 at 7:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Oct 28, 2021 at 7:10 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > > > Now, for your graph 3, are you saying this pseudo
> > > > > code of the process is repeatable?:
> > > > >
> > > > > Power up the system, booting kernel 5.9
> > > > > switch to passive/schedutil.
> > > > > wait X minutes for system to settle
> > > > > do benchmark, result ~13 seconds
> > > > > re-boot to kernel 5.15-RC
> > > > > switch to passive/schedutil.
> > > > > wait X minutes for system to settle
> > > > > do benchmark, result ~40 seconds
> > > > > re-boot to kernel 5.9
> > > > > switch to passive/schedutil.
> > > > > wait X minutes for system to settle
> > > > > do benchmark, result ~28 seconds
> > > >
> > > > In the first boot of 5.9, the des (desired?) field of the HWP_REQUEST
> > > > register is 0 and in the second boot (after booting 5.15 and entering
> > > > passive mode) it is 10.  I don't know though if this is a bug or a
> > > > feature...

I think I didn't understand you correctly, sorry about that.

In 5.15-rc (starting in 5.11-rc) the desired perf field in HWP_REQUEST
is used in the passive mode, so that is expected.

However, it may not be reset to 0 when going back from the passive to
the active mode.

> > > It looks like a bug.
> > >
> > > I think that the desired value is not cleared on driver exit which
> > > should happen.  Let me see if I can do a quick patch for that.
> >
> > Please check the behavior with the attached patch applied.
>
> Well, actually, the previous one won't do anything, because the
> desired perf field is already cleared in this function before writing
> the MSR, so please try the one attached to this message instead.

So with the last patch applied, can you please check if you get
desired=0 with 5.15-rc when switching driver modes from passive to
active?  FWIW, this works for me here.

In any case, the desired perf value in HWP_REQUEST is expected to be
reset to 0 on system restart.
