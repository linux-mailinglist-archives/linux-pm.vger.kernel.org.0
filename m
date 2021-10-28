Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D149043E8F8
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 21:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhJ1T2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 15:28:17 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:11069
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230251AbhJ1T2R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 15:28:17 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZpLRIqCbFLKGwonlHemr55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9HfbyqynDpp4mPFrP6Qr5O0tQ/OxoWpPhfZq0z/cc3WBSB8bAYOCMgg?=
 =?us-ascii?q?WVxe9ZgbcKjweQeRHWx6ptkZ1tdKVzE7TLYGRSh8yS2maFL+o=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397679687"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 21:25:48 +0200
Date:   Thu, 28 Oct 2021 21:25:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem in changing from active to passive mode
In-Reply-To: <CAJZ5v0jmQgg_DwqSdFsoMd5qV_ZH=cHUJtb372mqv=GSWioRgw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110282124201.9518@hadrien>
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien> <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com> <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien> <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com> <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com> <CAJZ5v0gAax-uz+shKv4MNBiSBPKGroQGNKdYyUK4v6sRS15o_w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110282112060.9518@hadrien> <CAJZ5v0jmQgg_DwqSdFsoMd5qV_ZH=cHUJtb372mqv=GSWioRgw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Thu, 28 Oct 2021, Rafael J. Wysocki wrote:

> On Thu, Oct 28, 2021 at 9:13 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Thu, 28 Oct 2021, Rafael J. Wysocki wrote:
> >
> > > On Thu, Oct 28, 2021 at 7:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 28, 2021 at 7:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 28, 2021 at 7:10 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > > >
> > > > > > > Now, for your graph 3, are you saying this pseudo
> > > > > > > code of the process is repeatable?:
> > > > > > >
> > > > > > > Power up the system, booting kernel 5.9
> > > > > > > switch to passive/schedutil.
> > > > > > > wait X minutes for system to settle
> > > > > > > do benchmark, result ~13 seconds
> > > > > > > re-boot to kernel 5.15-RC
> > > > > > > switch to passive/schedutil.
> > > > > > > wait X minutes for system to settle
> > > > > > > do benchmark, result ~40 seconds
> > > > > > > re-boot to kernel 5.9
> > > > > > > switch to passive/schedutil.
> > > > > > > wait X minutes for system to settle
> > > > > > > do benchmark, result ~28 seconds
> > > > > >
> > > > > > In the first boot of 5.9, the des (desired?) field of the HWP_REQUEST
> > > > > > register is 0 and in the second boot (after booting 5.15 and entering
> > > > > > passive mode) it is 10.  I don't know though if this is a bug or a
> > > > > > feature...
> > > > >
> > > > > It looks like a bug.
> > > > >
> > > > > I think that the desired value is not cleared on driver exit which
> > > > > should happen.  Let me see if I can do a quick patch for that.
> > > >
> > > > Please check the behavior with the attached patch applied.
> > >
> > > Well, actually, the previous one won't do anything, because the
> > > desired perf field is already cleared in this function before writing
> > > the MSR, so please try the one attached to this message instead.
> > >
> >
> > Turbostat still shows 10:
> >
> > cpu0: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> > cpu0: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> > cpu0: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> > cpu0: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> > cpu1: MSR_PM_ENABLE: 0x00000001 (HWP)
> > cpu1: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> > cpu1: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> > cpu1: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> > cpu1: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> > cpu2: MSR_PM_ENABLE: 0x00000001 (HWP)
> > cpu2: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> > cpu2: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> > cpu2: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> > cpu2: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
> > cpu3: MSR_PM_ENABLE: 0x00000001 (HWP)
> > cpu3: MSR_HWP_CAPABILITIES: 0x070a1525 (high 37 guar 21 eff 10 low 7)
> > cpu3: MSR_HWP_REQUEST: 0x000a2525 (min 37 max 37 des 10 epp 0x0 window 0x0 pkg 0x0)
> > cpu3: MSR_HWP_REQUEST_PKG: 0x8000ff00 (min 0 max 255 des 0 epp 0x80 window 0x0)
> > cpu3: MSR_HWP_STATUS: 0x00000004 (No-Guaranteed_Perf_Change, No-Excursion_Min)
>
> Hmmm.
>
> Is this also the case if you go from "passive" to "active" on 5.15-rc
> w/ the patch applied?

Sorry, I was wrong.  If I am in 5.15 and go from passive to active, the
des field indeed returns to 0.  If I use kexec to reboot from 5.15
passive into 5.9, then the des field remains 10.

julia
