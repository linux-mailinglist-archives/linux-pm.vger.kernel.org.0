Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF277481F4C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 19:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhL3SoK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Dec 2021 13:44:10 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44597
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236872AbhL3SoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 13:44:08 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ACTKBwanrlscDmfQ37sGAWDDo5gyvJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzxWzWJKUGvXOPeJajH3e9kiPI22pEsOvJOHyNVgTAtl+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x/RGQ6YnSHuClUbS?=
 =?us-ascii?q?fYngqLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTckQGWL/fO2BiiFIGBu780l4b/HV0i/lgXBYfQR4/ZzGhnc11ydwLsZWvQ?=
 =?us-ascii?q?AMtFqzKguUUFRdCe817FfQcp+aYeCbXXcu7iheun2HX6+9nAkg7OaUb9/xxDGU?=
 =?us-ascii?q?I8uYXQBgJZw+Kg+ae0rO+QPNlwMUlNsjieo0F0llr0CvDCvQrW53Ra7/L/tJFx?=
 =?us-ascii?q?HE2i9wmNe3EZswYdzN0KgzJZRFVJ0keBJsWmOaum2m5cjtEpVbTrq0yi0DXwQp?=
 =?us-ascii?q?7+LvgKtzYfpqNX8o9tliZvG/d/yL6HxQTLvSbyDyM6HXqgfXA9Qv/WYQPBPig8?=
 =?us-ascii?q?9Z0j1CJgG8eEhsbUR28u/bRokq/Xc9Pbk8Z4CwjqYAs+0GxCNrwRRu1pDiDpBF?=
 =?us-ascii?q?0c99RFeI9wBuAxqrd/0CSAW1sZiZMdNE8puc3QzIw31OElt+vAiZg2JWXVGics?=
 =?us-ascii?q?LOZqTezETIYIW8LeWkPSg5ty8fipoo+iA6JQctiDLKykvXxGDf52TfMqzIx74j?=
 =?us-ascii?q?/J+ZjO76TpA+cxWv2/96XHkhlu0PNU3zj9Q1jIoioe+SVBZHgxa4oBO6kopOp5?=
 =?us-ascii?q?RDoQ/Sj0d0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AOi9/EKz3LiCC6aq/X1E1KrPwK71zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfq+V98jzuSWftN9VYhAdcLO7Scy9qBHnlaKdiLN5VYtKHjOW21?=
 =?us-ascii?q?dAR7sN0WKN+VHd8mHFh4xg/JYlQuxFBNr8AUMSt6vHyQOzeuxO/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,248,1635199200"; 
   d="scan'208";a="1271716"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 19:44:08 +0100
Date:   Thu, 30 Dec 2021 19:44:06 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Francisco Jerez <currojerez@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112301942360.15550@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien> <878rwitdu3.fsf@riseup.net> <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net> <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien> <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com> <alpine.DEB.2.22.394.2112281845180.24929@hadrien>
 <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com> <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com> <alpine.DEB.2.22.394.2112301840360.15550@hadrien>
 <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com> <alpine.DEB.2.22.394.2112301919240.15550@hadrien> <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1184462933-1640889847=:15550"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1184462933-1640889847=:15550
Content-Type: text/plain; charset=US-ASCII



On Thu, 30 Dec 2021, Rafael J. Wysocki wrote:

> On Thu, Dec 30, 2021 at 7:21 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Thu, 30 Dec 2021, Rafael J. Wysocki wrote:
> >
> > > On Thu, Dec 30, 2021 at 6:54 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > > > > The effect is the same.  But that approach is indeed simpler than patching
> > > > > > the kernel.
> > > > >
> > > > > It is also applicable when intel_pstate runs in the active mode.
> > > > >
> > > > > As for the results that you have reported, it looks like the package
> > > > > power on these systems is dominated by package voltage and going from
> > > > > P-state 20 to P-state 21 causes that voltage to increase significantly
> > > > > (the observed RAM energy usage pattern is consistent with that).  This
> > > > > means that running at P-states above 20 is only really justified if
> > > > > there is a strict performance requirement that can't be met otherwise.
> > > > >
> > > > > Can you please check what value is there in the base_frequency sysfs
> > > > > attribute under cpuX/cpufreq/?
> > > >
> > > > 2100000, which should be pstate 21
> > > >
> > > > >
> > > > > I'm guessing that the package voltage level for P-states 10 and 20 is
> > > > > the same, so the power difference between them is not significant
> > > > > relative to the difference between P-state 20 and 21 and if increasing
> > > > > the P-state causes some extra idle time to appear in the workload
> > > > > (even though there is not enough of it to prevent to overall
> > > > > utilization from increasing), then the overall power draw when running
> > > > > at P-state 10 may be greater that for P-state 20.
> > > >
> > > > My impression is that the package voltage level for P-states 10 to 20 is
> > > > high enough that increasing the frequency has little impact.  But the code
> > > > runs twice as fast, which reduces the execution time a lot, saving energy.
> > > >
> > > > My first experiment had only one running thread.  I also tried running 32
> > > > spinning threads for 10 seconds, ie using up one package and leaving the
> > > > other idle.  In this case, instead of staying around 600J for pstates
> > > > 10-20, the pstate rises from 743 to 946.  But there is still a gap between
> > > > 20 and 21, with 21 being 1392J.
> > > >
> > > > > You can check if there is any C-state residency difference between
> > > > > these two cases by running the workload under turbostat in each of
> > > > > them.
> > > >
> > > > The C1 and C6 cases (CPU%c1 and CPU%c6) are about the same between 20 and
> > > > 21, whether with 1 thread or with 32 thread.
> > >
> > > I meant to compare P-state 10 and P-state 20.
> > >
> > > 20 and 21 are really close as far as the performance is concerned, so
> > > I wouldn't expect to see any significant C-state residency difference
> > > between them.
> >
> > There's also no difference between 10 and 20.  This seems normal, because
> > the same cores are either fully used or fully idle in both cases.  The
> > idle ones are almost always in C6.
>
> The turbostat output sent by you previously shows that the CPUs doing
> the work are only about 15-or-less percent busy, though, and you get
> quite a bit of C-state residency on them.  I'm assuming that this is
> for 1 running thread.
>
> Can you please run the 32 spinning threads workload (ie. on one
> package) and with P-state locked to 10 and then to 20 under turbostat
> and send me the turbostat output for both runs?

Attached.

Pstate 10: spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo
Pstate 20: spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo

julia
--8323329-1184462933-1640889847=:15550
Content-Type: text/plain; charset=US-ASCII; name=spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.22.394.2112301944060.15550@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo

MTAuMDQxMjkwIHNlYw0KUGFja2FnZQlDb3JlCUNQVQlBdmdfTUh6CUJ1c3kl
CUJ6eV9NSHoJVFNDX01IeglJUlEJU01JCVBPTEwJQzEJQzFFCUM2CVBPTEwl
CUMxJQlDMUUlCUM2JQlDUFUlYzEJQ1BVJWM2CUNvcmVUbXAJUGtnVG1wCVBr
ZyVwYzIJUGtnJXBjNglQa2dfSglSQU1fSglQS0dfJQlSQU1fJQ0KLQktCS0J
MTYJMS41NwkxMDAwCTIxMDEJNDk3MQkwCTEJMjEJMjI3CTI1MTIJMC4wMAkw
LjAwCTAuMDIJOTguNjkJMS44Ngk5Ni41NgkzNgkzNgk0OS4xNQkwLjI1CTU4
MC4wOAkzMTguOTEJMC4wMAkwLjAwDQowCTAJMAkyCTAuMTgJMTAwMAkyMDk1
CTEwNQkwCTAJMAkwCTM1NQkwLjAwCTAuMDAJMC4wMAk5OS44NAkxLjkwCTk3
LjkyCTMyCTM2CTAuMjkJMC4yNQkzMDAuMTcJMTUzLjA3CTAuMDAJMC4wMA0K
MAkwCTMyCTAJMC4wMgkxMDAxCTIwOTUJMjIJMAkwCTAJMQkyNwkwLjAwCTAu
MDAJMC4wMQk5OS45OAkyLjA2DQowCTEJNAkwCTAuMDEJMTAwMAkyMDk1CTIy
CTAJMAkwCTIJMjUJMC4wMAkwLjAwCTAuMDEJOTkuOTgJMC4xMgk5OS44Nwkz
NA0KMAkxCTM2CTAJMC4wMQkxMDAwCTIwOTUJMjMJMAkwCTAJMQkyNQkwLjAw
CTAuMDAJMC4wMQk5OS45OAkwLjEyDQowCTIJOAkwCTAuMDIJMTAwMAkyMDk1
CTQ3CTAJMAkwCTIJNDgJMC4wMAkwLjAwCTAuMDEJOTkuOTcJMC4yNQk5OS43
MwkzNA0KMAkyCTQwCTAJMC4wMQkxMDAwCTIwOTUJMjcJMAkwCTAJMQkyMwkw
LjAwCTAuMDAJMC4wMQk5OS45OQkwLjI2DQowCTMJMTIJMAkwLjAxCTEwMDAJ
MjA5NQkyNAkwCTAJMAkxCTI1CTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTMJ
OTkuODYJMzMNCjAJMwk0NAkwCTAuMDEJMTAwMAkyMDk1CTIxCTAJMAkwCTEJ
MjEJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xMw0KMAk0CTE0CTAJMC4wMQkx
MDAwCTIwOTUJMjMJMAkwCTAJMAkyNgkwLjAwCTAuMDAJMC4wMAk5OS45OQkw
LjEzCTk5Ljg1CTM1DQowCTQJNDYJMAkwLjAxCTEwMDAJMjA5NQkyMQkwCTAJ
MAkwCTIyCTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTQNCjAJNQkxMAk5OTEJ
OTkuMzEJMTAwMAkyMDk1CTI1MjMJMAkwCTAJMQkxOAkwLjAwCTAuMDAJMC4w
MQkwLjY5CTAuMDgJMC42MQkzNA0KMAk1CTQyCTAJMC4wMQkxMDAwCTIwOTUJ
MjAJMAkwCTAJMAkyMQkwLjAwCTAuMDAJMC4wMAk5OS45OQk5OS4zOA0KMAk2
CTYJMAkwLjAxCTEwMDAJMjA5NQkzMgkwCTAJMAkwCTMyCTAuMDAJMC4wMAkw
LjAwCTk5Ljk5CTAuMTgJOTkuODEJMzMNCjAJNgkzOAkwCTAuMDEJMTAwMAky
MDk1CTMyCTAJMAkwCTAJMzIJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xNw0K
MAk3CTIJMAkwLjAxCTEwMDAJMjA5NQkyNwkwCTAJMAkwCTI3CTAuMDAJMC4w
MAkwLjAwCTk5Ljk5CTAuMTQJOTkuODUJMzYNCjAJNwkzNAkwCTAuMDEJMTAw
MAkyMDk1CTI3CTAJMAkwCTAJMjYJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4x
NA0KMAk4CTE2CTAJMC4wMQkxMDAwCTIwOTUJMjQJMAkwCTAJMAkyNQkwLjAw
CTAuMDAJMC4wMAk5OS45OQkwLjEzCTk5Ljg2CTM0DQowCTgJNDgJMAkwLjAx
CTEwMDAJMjA5NQkyMwkwCTAJMAkwCTIzCTAuMDAJMC4wMAkwLjAwCTk5Ljk5
CTAuMTMNCjAJOQkyMAkxCTAuMTMJMTAwMAkyMDk1CTU2MQkwCTEJMQkyMDAJ
MzYyCTAuMDAJMC4wMAkwLjkxCTk4Ljk4CTIuNDgJOTcuMzkJMzMNCjAJOQk1
MgkwCTAuMDIJMTAwMQkyMDk1CTM2CTAJMAkwCTAJMzYJMC4wMAkwLjAwCTAu
MDAJOTkuOTkJMi41OA0KMAkxMAkyNAkwCTAuMDEJMTAwMAkyMDk1CTIzCTAJ
MAkwCTEJMjMJMC4wMAkwLjAwCTAuMDEJOTkuOTgJMC4xMwk5OS44NgkzNA0K
MAkxMAk1NgkwCTAuMDEJMTAwMAkyMDk1CTIyCTAJMAkwCTEJMjMJMC4wMAkw
LjAwCTAuMDAJOTkuOTkJMC4xMw0KMAkxMQkyOAkwCTAuMDEJMTAwMAkyMDk1
CTIzCTAJMAkwCTEJMjMJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xNAk5OS44
NQkzNA0KMAkxMQk2MAkwCTAuMDEJMTAwMAkyMDk1CTI1CTAJMAkwCTAJMjUJ
MC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xNA0KMAkxMgkzMAkwCTAuMDEJMTAw
MAkyMDk1CTI2CTAJMAkwCTAJMjcJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4x
Mwk5OS44NQkzNQ0KMAkxMgk2MgkwCTAuMDEJMTAwMAkyMDk1CTE5CTAJMAkw
CTAJMTkJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xNA0KMAkxMwkyNgkwCTAu
MDEJMTAwMAkyMDk1CTIwCTAJMAkwCTAJMjIJMC4wMAkwLjAwCTAuMDAJOTku
OTkJMC4xMwk5OS44NQkzNA0KMAkxMwk1OAkwCTAuMDEJMTAwMAkyMDk1CTIz
CTAJMAkwCTAJMjQJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xMw0KMAkxNAky
MgkwCTAuMDIJMTAwMAkyMDk1CTI3CTAJMAkwCTAJMjgJMC4wMAkwLjAwCTAu
MDAJOTkuOTkJMC4xNQk5OS44NAkzMw0KMAkxNAk1NAkwCTAuMDEJMTAwMAky
MDk1CTI3CTAJMAkwCTAJMjYJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xNQ0K
MAkxNQkxOAkwCTAuMDEJMTAwMAkyMDk1CTIxCTAJMAkwCTAJMjIJMC4wMAkw
LjAwCTAuMDAJOTkuOTkJMC4xMgk5OS44NwkzNQ0KMAkxNQk1MAkwCTAuMDEJ
MTAwMAkyMDk1CTIyCTAJMAkwCTAJMjEJMC4wMAkwLjAwCTAuMDAJOTkuOTkJ
MC4xMg0KMQkwCTEJMAkwLjAyCTEwMDAJMjA5NQkyMgkwCTAJMjAJMAkyNQkw
LjAwCTAuMDkJMC4wMAk5OS45MAkwLjIyCTk5Ljc2CTI4CTMwCTk3Ljk4CTAu
MjUJMjc5LjkxCTE2NS44NQkwLjAwCTAuMDANCjEJMAkzMwkwCTAuMDEJMTAw
MAkyMDk1CTI4CTAJMAkwCTAJMjgJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4y
Mg0KMQkxCTUJMAkwLjAyCTEwMDAJMjA5NQk0MgkwCTAJMAkwCTQxCTAuMDAJ
MC4wMAkwLjAwCTk5Ljk4CTAuMTcJOTkuODAJMjkNCjEJMQkzNwkwCTAuMDEJ
MTAwMAkyMDk1CTIyCTAJMAkwCTAJMjIJMC4wMAkwLjAwCTAuMDAJOTkuOTkJ
MC4xOQ0KMQkyCTkJMAkwLjAyCTEwMDAJMjA5NQkzOAkwCTAJMAkxCTM4CTAu
MDAJMC4wMAkwLjAxCTk5Ljk4CTAuMjMJOTkuNzUJMjgNCjEJMgk0MQkwCTAu
MDIJMTAwMAkyMDk1CTM4CTAJMAkwCTEJMzYJMC4wMAkwLjAwCTAuMDAJOTku
OTkJMC4yNA0KMQkzCTEzCTEJMC4wOAkxMDAwCTIwOTUJMTM0CTAJMAkwCTIJ
MTMzCTAuMDAJMC4wMAkwLjAwCTk5LjkzCTAuNDkJOTkuNDMJMjgNCjEJMwk0
NQkwCTAuMDIJMTAwMQkyMDk1CTI3CTAJMAkwCTAJMjgJMC4wMAkwLjAwCTAu
MDAJOTkuOTkJMC41NQ0KMQk0CTE1CTAJMC4wMQkxMDAwCTIwOTUJMzAJMAkw
CTAJMAkzMgkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjE1CTk5Ljg0CTI5DQox
CTQJNDcJMAkwLjAxCTEwMDAJMjA5NQkxOQkwCTAJMAkwCTE5CTAuMDAJMC4w
MAkwLjAwCTk5Ljk5CTAuMTUNCjEJNQkxMQkwCTAuMDIJMTAwMAkyMDk1CTMy
CTAJMAkwCTAJMzYJMC4wMAkwLjAwCTAuMDAJOTkuOTgJMC4yNgk5OS43Mgky
Nw0KMQk1CTQzCTAJMC4wMgkxMDAwCTIwOTUJNTYJMAkwCTAJMgk1NAkwLjAw
CTAuMDAJMC4wMAk5OS45OAkwLjI2DQoxCTYJNwkwCTAuMDEJMTAwMAkyMDk1
CTIyCTAJMAkwCTAJMjAJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xMAk5OS44
OQkyOQ0KMQk2CTM5CTAJMC4wMQkxMDAwCTIwOTUJMjIJMAkwCTAJMAkyMQkw
LjAwCTAuMDAJMC4wMAk5OS45OQkwLjEwDQoxCTcJMwkwCTAuMDEJMTAwMAky
MDk1CTIzCTAJMAkwCTAJMjIJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xNwk5
OS44MgkzMA0KMQk3CTM1CTAJMC4wMwkxMDAwCTIwOTUJMjkJMAkwCTAJMAkz
MQkwLjAwCTAuMDAJMC4wMAk5OS45OAkwLjE1DQoxCTgJMTcJMAkwLjAyCTEw
MDAJMjA5NQkyMQkwCTAJMAkwCTI3CTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAu
MTMJOTkuODUJMjgNCjEJOAk0OQkwCTAuMDEJMTAwMAkyMDk1CTE2CTAJMAkw
CTAJMTYJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xNA0KMQk5CTIxCTAJMC4w
MQkxMDAwCTIwOTUJMTgJMAkwCTAJMQkxNwkwLjAwCTAuMDAJMC4wMQk5OS45
OAkwLjIxCTk5Ljc4CTI3DQoxCTkJNTMJMQkwLjA2CTEwMDAJMjA5NQkzMgkw
CTAJMAkyCTMxCTAuMDAJMC4wMAkwLjAxCTk5LjkzCTAuMTYNCjEJMTAJMjUJ
MAkwLjAxCTEwMDAJMjA5NQkyMAkwCTAJMAkxCTIxCTAuMDAJMC4wMAkwLjAw
CTk5Ljk5CTAuMzEJOTkuNjgJMjkNCjEJMTAJNTcJMQkwLjA4CTEwMDAJMjA5
NQk1MAkwCTAJMAkyCTU2CTAuMDAJMC4wMAkwLjAwCTk5LjkyCTAuMjQNCjEJ
MTEJMjkJMAkwLjAxCTEwMDAJMjA5NQkxOQkwCTAJMAkwCTE3CTAuMDAJMC4w
MAkwLjAwCTk5Ljk5CTAuMTcJOTkuODIJMjgNCjEJMTEJNjEJMAkwLjAyCTEw
MDAJMjA5NQkzNwkwCTAJMAkwCTM3CTAuMDAJMC4wMAkwLjAwCTk5Ljk4CTAu
MTYNCjEJMTIJMzEJMAkwLjAxCTEwMDAJMjA5NQkxNwkwCTAJMAkwCTE5CTAu
MDAJMC4wMAkwLjAwCTk5Ljk5CTAuMjMJOTkuNzYJMjgNCjEJMTIJNjMJMAkw
LjA0CTEwMDAJMjA5NQk0NgkwCTAJMAkwCTQ5CTAuMDAJMC4wMAkwLjAwCTk5
Ljk3CTAuMjANCjEJMTMJMjcJMAkwLjAxCTEwMDAJMjA5NQkxNgkwCTAJMAkw
CTE1CTAuMDAJMC4wMAkwLjAwCTk5LjY4CTAuNTIJOTkuNDcJMjkNCjEJMTMJ
NTkJMAkwLjA0CTEwMDAJMjA5NQk0NQkwCTAJMAkxCTQwCTAuMDAJMC4wMAkw
LjAxCTk5Ljk1CTAuMTgNCjEJMTQJMjMJMAkwLjAxCTEwMDAJMjA5NQkzMQkw
CTAJMAkwCTE4CTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMjAJOTkuNzkJMjgN
CjEJMTQJNTUJMAkwLjAzCTEwMDAJMjA5NQk0OAkwCTAJMAkxCTQyCTAuMDAJ
MC4wMAkwLjAwCTk5Ljk3CTAuMTgNCjEJMTUJMTkJMAkwLjAxCTEwMDAJMjA5
NQkzMQkwCTAJMAkwCTIyCTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTkJOTku
ODAJMjkNCjEJMTUJNTEJMQkwLjA3CTEwMDAJMjA5NQkyMgkwCTAJMAkwCTE3
CTAuMDAJMC4wMAkwLjAwCTk5Ljk0CTAuMTMNCg==

--8323329-1184462933-1640889847=:15550
Content-Type: text/plain; charset=US-ASCII; name=spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.22.394.2112301944061.15550@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo

MTAuMDQxNDkxIHNlYw0KUGFja2FnZQlDb3JlCUNQVQlBdmdfTUh6CUJ1c3kl
CUJ6eV9NSHoJVFNDX01IeglJUlEJU01JCVBPTEwJQzEJQzFFCUM2CVBPTEwl
CUMxJQlDMUUlCUM2JQlDUFUlYzEJQ1BVJWM2CUNvcmVUbXAJUGtnVG1wCVBr
ZyVwYzIJUGtnJXBjNglQa2dfSglSQU1fSglQS0dfJQlSQU1fJQ0KLQktCS0J
MTYJMS41NwkxMDAwCTIwOTcJNDI3NAkwCTEJMjAJMTkJMTg2MwkwLjAwCTAu
MDEJMC4wMAk5OC40OQkxLjgwCTk2LjYzCTM4CTM4CTQ5LjE0CTAuMDcJNTc5
Ljk2CTMyMC43NgkwLjAwCTAuMDANCjAJMAkwCTIJMC4xOAkxMDAwCTIwOTUJ
OTcJMAkwCTAJMAkzMzIJMC4wMAkwLjAwCTAuMDAJOTkuODQJMS44MAk5OC4w
MgkzNAkzOAkwLjM3CTAuMTMJMzAwLjI2CTE1NC43NAkwLjAwCTAuMDANCjAJ
MAkzMgkwCTAuMDIJMTAwMQkyMDk1CTE3CTAJMAkwCTAJMTkJMC4wMAkwLjAw
CTAuMDAJOTkuOTkJMS45Ng0KMAkxCTQJMAkwLjAyCTEwMDAJMjA5NQkzOQkw
CTAJMAkwCTM5CTAuMDAJMC4wMAkwLjAwCTk5Ljk4CTAuMjAJOTkuNzgJMzYN
CjAJMQkzNgkwCTAuMDEJMTAwMAkyMDk1CTIwCTAJMAkwCTAJMTkJMC4wMAkw
LjAwCTAuMDAJOTkuOTkJMC4yMQ0KMAkyCTgJMAkwLjAyCTEwMDAJMjA5NQkz
MgkwCTAJMAkwCTM2CTAuMDAJMC4wMAkwLjAwCTk5Ljk4CTAuMjMJOTkuNzQJ
MzUNCjAJMgk0MAkwCTAuMDEJMTAwMAkyMDk1CTI3CTAJMAkwCTAJMjcJMC4w
MAkwLjAwCTAuMDAJOTkuOTkJMC4yNA0KMAkzCTEyCTAJMC4wMQkxMDAwCTIw
OTUJMjIJMAkwCTAJMAkyNAkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjE2CTk5
LjgzCTM0DQowCTMJNDQJMAkwLjAxCTEwMDAJMjA5NQkxOAkwCTAJMAkwCTE4
CTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTYNCjAJNAkxNAkwCTAuMDEJMTAw
MAkyMDk1CTIzCTAJMAkwCTAJMjQJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4x
Mwk5OS44NgkzNg0KMAk0CTQ2CTAJMC4wMQkxMDAwCTIwOTUJMjQJMAkwCTAJ
MAkyMwkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjEzDQowCTUJMTAJOTkxCTk5
LjM1CTEwMDAJMjA5NQkyNTIyCTAJMAkwCTEJMTcJMC4wMAkwLjAwCTAuMDEJ
MC42NAkwLjA4CTAuNTcJMzUNCjAJNQk0MgkwCTAuMDEJMTAwMAkyMDk1CTE4
CTAJMAkwCTAJMTgJMC4wMAkwLjAwCTAuMDAJMTAwLjAwCTk5LjQyDQowCTYJ
NgkwCTAuMDEJMTAwMAkyMDk1CTM2CTAJMAkyCTEJMzMJMC4wMAkwLjA4CTAu
MDAJOTkuOTEJMC4yNgk5OS43MwkzNA0KMAk2CTM4CTAJMC4wMQkxMDAwCTIw
OTUJMTgJMAkwCTAJMQkxOAkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjI2DQow
CTcJMgkwCTAuMDEJMTAwMAkyMDk1CTIxCTAJMAkwCTAJMjAJMC4wMAkwLjAw
CTAuMDAJOTkuOTkJMC4xMgk5OS44NwkzOA0KMAk3CTM0CTAJMC4wMQkxMDAw
CTIwOTUJMjEJMAkwCTAJMAkyMQkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjEy
DQowCTgJMTYJMAkwLjAxCTEwMDAJMjA5NQkxOAkwCTAJMAkwCTIwCTAuMDAJ
MC4wMAkwLjAwCTk5Ljk5CTAuMTAJOTkuODkJMzUNCjAJOAk0OAkwCTAuMDEJ
MTAwMAkyMDk1CTE4CTAJMAkwCTAJMTgJMC4wMAkwLjAwCTAuMDAJOTkuOTkJ
MC4xMA0KMAk5CTIwCTAJMC4wMQkxMDAwCTIwOTUJMjYJMAkwCTAJMAkxOQkw
LjAwCTAuMDAJMC4wMAk5OS43MgkwLjQ0CTk5LjU1CTM1DQowCTkJNTIJMAkw
LjAxCTEwMDAJMjA5NQkyOQkwCTAJMAkwCTI5CTAuMDAJMC4wMAkwLjAwCTk5
Ljk5CTAuMTcNCjAJMTAJMjQJMAkwLjAxCTEwMDAJMjA5NQkyMQkwCTAJMAkw
CTIxCTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTMJOTkuODYJMzUNCjAJMTAJ
NTYJMAkwLjAxCTEwMDAJMjA5NQkyMQkwCTAJMAkwCTIxCTAuMDAJMC4wMAkw
LjAwCTk5Ljk5CTAuMTMNCjAJMTEJMjgJMAkwLjAxCTEwMDAJMjA5NQkyMwkw
CTAJMAkwCTI0CTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTQJOTkuODUJMzUN
CjAJMTEJNjAJMAkwLjAxCTEwMDAJMjA5NQkyNwkwCTAJMAkwCTIyCTAuMDAJ
MC4wMAkwLjAwCTk5Ljk5CTAuMTQNCjAJMTIJMzAJMAkwLjAxCTEwMDAJMjA5
NQkyMAkwCTAJMAkwCTIxCTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTIJOTku
ODcJMzYNCjAJMTIJNjIJMAkwLjAxCTEwMDAJMjA5NQkyMwkwCTAJMAkwCTIw
CTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTINCjAJMTMJMjYJMAkwLjAxCTEw
MDAJMjA5NQkyMAkwCTAJMAkwCTIwCTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAu
MTcJOTkuODIJMzUNCjAJMTMJNTgJMAkwLjAxCTEwMDAJMjA5NQkyMAkwCTAJ
MAkwCTIwCTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTcNCjAJMTQJMjIJMAkw
LjAxCTEwMDAJMjA5NQkyNQkwCTAJMAkwCTIzCTAuMDAJMC4wMAkwLjAwCTk5
Ljk5CTAuMTcJOTkuODIJMzUNCjAJMTQJNTQJMAkwLjAxCTEwMDEJMjA5NQkx
OAkwCTAJMAkwCTE4CTAuMDAJMC4wMAkwLjAwCTk5Ljk5CTAuMTcNCjAJMTUJ
MTgJMAkwLjAxCTEwMDAJMjA5NQkxMgkwCTAJMAkxCTEwCTAuMDAJMC4wMAkw
LjAxCTk5Ljk5CTAuMDYJOTkuOTMJMzcNCjAJMTUJNTAJMAkwLjAxCTEwMDAJ
MjA5NQk4CTAJMAkwCTEJOAkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjA2DQox
CTAJMQkwCTAuMDEJMTAwMAkyMDk1CTI3CTAJMQk0CTAJOQkwLjAwCTAuMDgJ
MC4wMAk5OS45MQkwLjEzCTk5Ljg2CTI4CTMxCTk3Ljk4CTAuMDAJMjc5Ljcx
CTE2Ni4wMgkwLjAwCTAuMDANCjEJMAkzMwkwCTAuMDEJMTAwMAkyMDk1CTEw
CTAJMAkwCTAJOQkwLjAwCTAuMDAJMC4wMAkxMDAuMDAJMC4xNA0KMQkxCTUJ
MAkwLjAyCTEwMDAJMjA5NQkyOAkwCTAJMAkwCTMwCTAuMDAJMC4wMAkwLjAw
CTk5Ljk4CTAuMjUJOTkuNzMJMjkNCjEJMQkzNwkwCTAuMDMJMTAwMAkyMDk1
CTM3CTAJMAkwCTAJMzYJMC4wMAkwLjAwCTAuMDAJOTkuOTcJMC4yNA0KMQky
CTkJMAkwLjAxCTEwMDAJMjA5NQkyMwkwCTAJMAkwCTIzCTAuMDAJMC4wMAkw
LjAwCTk5Ljk5CTAuMTEJOTkuODgJMjgNCjEJMgk0MQkwCTAuMDEJMTAwMAky
MDk1CTI1CTAJMAkwCTAJMjQJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4xMQ0K
MQkzCTEzCTEJMC4wNwkxMDAwCTIwOTUJMTI2CTAJMAkwCTAJMTIxCTAuMDAJ
MC4wMAkwLjAwCTk5Ljk0CTAuNDMJOTkuNTAJMjgNCjEJMwk0NQkwCTAuMDEJ
MTAwMQkyMDk1CTE5CTAJMAkwCTAJMTgJMC4wMAkwLjAwCTAuMDAJOTkuOTkJ
MC40OQ0KMQk0CTE1CTAJMC4wMQkxMDAwCTIwOTUJMTQJMAkwCTAJMAkxMgkw
LjAwCTAuMDAJMC4wMAk5OS45OQkwLjEwCTk5Ljg5CTI5DQoxCTQJNDcJMAkw
LjAxCTEwMDAJMjA5NQkyNwkwCTAJMAkwCTE5CTAuMDAJMC4wMAkwLjAwCTk5
Ljk5CTAuMTANCjEJNQkxMQkwCTAuMDEJMTAwMAkyMDk1CTI5CTAJMAkwCTAJ
MjcJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC40Nwk5OS41MQkyNw0KMQk1CTQz
CTAJMC4wMQkxMDAwCTIwOTUJMzkJMAkwCTgJMQkzMQkwLjAwCTAuMjgJMC4w
NAk5OS42NwkwLjQ3DQoxCTYJNwkwCTAuMDEJMTAwMAkyMDk1CTIzCTAJMAkw
CTEJMjEJMC4wMAkwLjAwCTAuMDEJOTkuOTgJMC4xMQk5OS44OQkyOQ0KMQk2
CTM5CTAJMC4wMQkxMDAwCTIwOTUJMjQJMAkwCTAJMQkyMQkwLjAwCTAuMDAJ
MC4wMQk5OS45OQkwLjExDQoxCTcJMwkwCTAuMDQJMTAwMAkyMDk1CTQxCTAJ
MAkwCTMJMzAJMC4wMAkwLjAwCTAuMDEJOTkuOTUJMC4xNAk5OS44MgkzMA0K
MQk3CTM1CTAJMC4wMQkxMDAwCTIwOTUJNwkwCTAJMAkxCTcJMC4wMAkwLjAw
CTAuMDAJOTkuOTkJMC4xNw0KMQk4CTE3CTAJMC4wMwkxMDAwCTIwOTUJNDMJ
MAkwCTMJMQk0MwkwLjAwCTAuMTIJMC4wMAk5OS44NQkwLjMxCTk5LjY2CTI5
DQoxCTgJNDkJMAkwLjAxCTEwMDAJMjA5NQkyNQkwCTAJMAkwCTE4CTAuMDAJ
MC4wMAkwLjAwCTk5Ljk5CTAuMzMNCjEJOQkyMQkwCTAuMDEJMTAwMAkyMDk1
CTEzCTAJMAkwCTAJMTMJMC4wMAkwLjAwCTAuMDAJOTkuOTkJMC4yOQk5OS43
MQkyOA0KMQk5CTUzCTEJMC4wNwkxMDAwCTIwOTUJNDYJMAkwCTAJMgk0Ngkw
LjAwCTAuMDAJMC4wMgk5OS45MgkwLjIzDQoxCTEwCTI1CTAJMC4wMQkxMDAw
CTIwOTUJMjMJMAkwCTAJMAkyMQkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjEx
CTk5Ljg4CTI5DQoxCTEwCTU3CTAJMC4wMgkxMDAwCTIwOTUJMjEJMAkwCTAJ
MAkyMAkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjEwDQoxCTExCTI5CTAJMC4w
MgkxMDAwCTIwOTUJNDIJMAkwCTAJMAk0MAkwLjAwCTAuMDAJMC4wMAk5OS45
OAkwLjM0CTk5LjY0CTI4DQoxCTExCTYxCTEJMC4wNwkxMDAwCTIwOTUJNDMJ
MAkwCTAJMAk0OQkwLjAwCTAuMDAJMC4wMAk5OS45NAkwLjI5DQoxCTEyCTMx
CTAJMC4wMQkxMDAwCTIwOTUJMTUJMAkwCTAJMAkxMQkwLjAwCTAuMDAJMC4w
MAk5OS45OQkwLjE5CTk5LjgwCTI4DQoxCTEyCTYzCTAJMC4wMwkxMDAwCTIw
OTUJNDYJMAkwCTAJMgkzOAkwLjAwCTAuMDAJMC4wMQk5OS45NwkwLjE3DQox
CTEzCTI3CTAJMC4wMQkxMDAwCTIwOTUJMTgJMAkwCTAJMAkxMQkwLjAwCTAu
MDAJMC4wMAk5OS45OQkwLjE3CTk5LjgyCTI5DQoxCTEzCTU5CTAJMC4wMwkx
MDAwCTIwOTUJNDMJMAkwCTAJMAkzMwkwLjAwCTAuMDAJMC4wMAk5OS45Nwkw
LjE1DQoxCTE0CTIzCTAJMC4wMQkxMDAwCTIwOTUJMTkJMAkwCTAJMAkxMwkw
LjAwCTAuMDAJMC4wMAk5OS45OQkwLjE4CTk5LjgxCTI4DQoxCTE0CTU1CTAJ
MC4wMwkxMDAwCTIwOTUJNDcJMAkwCTIJMQkzNQkwLjAwCTAuMDAJMC4wMQk5
OS45NwkwLjE3DQoxCTE1CTE5CTAJMC4wMQkxMDAwCTIwOTUJMjAJMAkwCTEJ
MQkxMAkwLjAwCTAuMDAJMC4wMAk5OS45OQkwLjE3CTk5LjgyCTI5DQoxCTE1
CTUxCTEJMC4wNwkxMDAwCTIwOTUJMjcJMAkwCTAJMAkyMgkwLjAwCTAuMDAJ
MC4wMAk5OS45NAkwLjExDQo=

--8323329-1184462933-1640889847=:15550--
