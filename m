Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839F543E8F3
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhJ1TXl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 15:23:41 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45709 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhJ1TXk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 15:23:40 -0400
Received: by mail-ot1-f46.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so10025126otq.12;
        Thu, 28 Oct 2021 12:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/5ARsGcpEMGbQCnBWecGh+4ZkeC9jJduupFR+ZDYPs=;
        b=ZUhlClo+XgAJl+ApeoJjy4CtokxMCR34WNW39gPq9cHCzERE2RPq/88v9WrMgzXE0O
         A4cxlMNoGQH+p759kRdBFWWu4hpbrdXivspewAmmsfbY180lAS17JplgSOxkc7PjVQdH
         INZRc0a7cY06yfwceBy42J1mb90aANXI1jC7UD2LtklG6DZ6obM7Kr+ACg+8VFws421x
         9n4vOFZKGeDdy0VkKmqaLmNcR7ljWH21V+tB5tqCYdst1x5tkOGb8ARUKIACoYk1o126
         xoGWfUu/GNOxqmwZU7u7fLVVQVhRpU42JPhyD5B8xt+2j4sAijPx1XKxkKgZxL6lkJTz
         JlMg==
X-Gm-Message-State: AOAM531pv3U0c7UGeheyYdkPXeB/wqpP2sSrbMWcQQtiqM9dh12Mmc6D
        i8M+iQKReaYwI8B/8nIgsIRqNSXys09UuJj+skQ=
X-Google-Smtp-Source: ABdhPJz2fj6VBrjgv6h/BbUmkIEVDPaXRxK8NPNdEB0ohJo0nx2OG1FPLtAeBH44F4I1IXR7K3bsic4t17k8ePY51KA=
X-Received: by 2002:a05:6830:90b:: with SMTP id v11mr5047717ott.254.1635448873270;
 Thu, 28 Oct 2021 12:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
 <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
 <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien> <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com>
 <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com>
 <CAJZ5v0gAax-uz+shKv4MNBiSBPKGroQGNKdYyUK4v6sRS15o_w@mail.gmail.com> <alpine.DEB.2.22.394.2110282112060.9518@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110282112060.9518@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Oct 2021 21:21:02 +0200
Message-ID: <CAJZ5v0jmQgg_DwqSdFsoMd5qV_ZH=cHUJtb372mqv=GSWioRgw@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
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

On Thu, Oct 28, 2021 at 9:13 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 28 Oct 2021, Rafael J. Wysocki wrote:
>
> > On Thu, Oct 28, 2021 at 7:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Oct 28, 2021 at 7:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 28, 2021 at 7:10 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > >
> > > > > > Now, for your graph 3, are you saying this pseudo
> > > > > > code of the process is repeatable?:
> > > > > >
> > > > > > Power up the system, booting kernel 5.9
> > > > > > switch to passive/schedutil.
> > > > > > wait X minutes for system to settle
> > > > > > do benchmark, result ~13 seconds
> > > > > > re-boot to kernel 5.15-RC
> > > > > > switch to passive/schedutil.
> > > > > > wait X minutes for system to settle
> > > > > > do benchmark, result ~40 seconds
> > > > > > re-boot to kernel 5.9
> > > > > > switch to passive/schedutil.
> > > > > > wait X minutes for system to settle
> > > > > > do benchmark, result ~28 seconds
> > > > >
> > > > > In the first boot of 5.9, the des (desired?) field of the HWP_REQUEST
> > > > > register is 0 and in the second boot (after booting 5.15 and entering
> > > > > passive mode) it is 10.  I don't know though if this is a bug or a
> > > > > feature...
> > > >
> > > > It looks like a bug.
> > > >
> > > > I think that the desired value is not cleared on driver exit which
> > > > should happen.  Let me see if I can do a quick patch for that.
> > >
> > > Please check the behavior with the attached patch applied.
> >
> > Well, actually, the previous one won't do anything, because the
> > desired perf field is already cleared in this function before writing
> > the MSR, so please try the one attached to this message instead.
> >
>
> Turbostat still shows 10:
>
> cpu0: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> cpu0: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> cpu0: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> cpu1: MSR_PM_ENABLE: 0x00000001 (HWP)
> cpu1: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> cpu1: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> cpu1: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> cpu1: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> cpu2: MSR_PM_ENABLE: 0x00000001 (HWP)
> cpu2: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> cpu2: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> cpu2: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> cpu2: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> cpu3: MSR_PM_ENABLE: 0x00000001 (HWP)
> cpu3: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> cpu3: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> cpu3: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> cpu3: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)

Hmmm.

Is this also the case if you go from "passive" to "active" on 5.15-rc
w/ the patch applied?
