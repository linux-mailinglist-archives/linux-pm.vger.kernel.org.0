Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C34440412
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 22:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJ2Ub5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 16:31:57 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:8962 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhJ2Ub4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 16:31:56 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyjgT4qNwVuGiTMBcTkSjsMiBIKoaSvp037B8?=
 =?us-ascii?q?7TEVdfUzSL3sqynOpoVo6faaskd2ZJgfo6H1BEDtexzhHXAc2/huAV+NNDOWyF?=
 =?us-ascii?q?dABrsSkbcL+lXbalzDHgQ079YST0EGMqyOMbEYt7ef3ODHKadG/DDdytHLuQ62?=
 =?us-ascii?q?9R4EJmsGB52M9z0JczpzPXcGMzWubqBJb6Z0iPAom9JgEU5nFPiTNz0pd8qrnb?=
 =?us-ascii?q?z2vaOjTBIMBxYhgTPvsRqYrJP3GBiR2VMmWzlMybkvmFK18DAQac2YwoyG4w6Z?=
 =?us-ascii?q?2mPZ75xQ3NP508BEG8CA4/JlUgnRtg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397787168"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 22:29:25 +0200
Date:   Fri, 29 Oct 2021 22:29:25 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem in changing from active to passive mode
In-Reply-To: <CAJZ5v0ijM9V2UmgqM4FzckXA8SQy6pHpBTFm8LLv1Lp_L8JiLw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110292227540.3011@hadrien>
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien> <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com> <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien> <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com> <CAJZ5v0ij105B05xPGgfauwFv1KhXRnwh5p28R1y11qKWjxUOhg@mail.gmail.com> <CAJZ5v0gAax-uz+shKv4MNBiSBPKGroQGNKdYyUK4v6sRS15o_w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110282112060.9518@hadrien> <CAJZ5v0jmQgg_DwqSdFsoMd5qV_ZH=cHUJtb372mqv=GSWioRgw@mail.gmail.com> <alpine.DEB.2.22.394.2110282124201.9518@hadrien> <CAJZ5v0j9fJi+Fa1404uH3V2XJUrVB5crEjcZ9tsnBtQWgCCu4w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110282217390.9518@hadrien> <CAJZ5v0ijM9V2UmgqM4FzckXA8SQy6pHpBTFm8LLv1Lp_L8JiLw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Fri, 29 Oct 2021, Rafael J. Wysocki wrote:

> On Thu, Oct 28, 2021 at 10:18 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Thu, 28 Oct 2021, Rafael J. Wysocki wrote:
> >
> > > On Thu, Oct 28, 2021 at 9:25 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> [cut]
>
> > > Attached is a patch to do that, but please note that the 5.9 will need
> > > to be patched too to address this issue.
> >
> > I'm not completely clear on what the new patch is doing and how I should
> > test it.  If I stay in 5.15, the original patch worked for clearing des
> > when going from passive to active.
>
> Sorry for the confusion.
>
> If applied to 5.15-rc alone, the last patch would cause des to be
> cleared when switching from passive to active and if applied to both
> 5.15-rc and 5.9, it would fix the kexec issue as well.
>
> Never mind, though.
>
> The patch attached to this message should cause des to be cleared when
> switching from passive to active (because it is based on the previous
> patch doing that) and it should prevent nonzero des from being leaked
> via the HWP_REQUEST MSR to the new kernel started via kexec.  With
> this patch applied to 5.15-rc des should be 0 when switching from
> passive to active and it should also be 0 after starting another
> kernel via kexec while intel_pstate is running in the passive mode.
>
> Can you please verify that it works as expected?

I booted 5.15 rc6 in active then changed to passive making the des field
non zero, and then changed back to active, making it 0 again.  I them
changed again to passive and kexeced 5.9.  The des field was again 0.

So it looks fine.

thanks,
julia
