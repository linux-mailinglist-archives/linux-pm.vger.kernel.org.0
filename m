Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE62059FC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 19:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbgFWRyn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 13:54:43 -0400
Received: from cmta18.telus.net ([209.171.16.91]:42510 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732913AbgFWRym (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 13:54:42 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id nn7yjynjsVEJfnn7zj4JZr; Tue, 23 Jun 2020 11:54:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1592934881; bh=B4rltPCrYDATZ3jKMgrnW3cKHjW7tbQI6WbcVyYwP8M=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=rBKHO9KSVyembk0vyrn59MfJQAo2WjL9+iOu31FxctTKrrpnmXMu12KSKyvDO80wZ
         YhdjmRp0XX1tfgzTtVZv/Hrr1HId2N1foJPq2ZsZR4xiRaPLFEtVSgp/TKHSnze92J
         E+zjqstk2kT84mnsBMOVuDqWd4qbb7NOA4Apt7GZ7EurcbVyVUDe2VuuIVHV044w1E
         Yx1N4MvR9QXdn09EaXXuKck2Mx4FDIRw2toDyRX4s+b5Hck9TtTvLzOnT08BlaVEBv
         p0c4IdPOJjNeorlrsJXvrcg7yKqoJGVYHTRKHAL65p6tTkSwG3oOYkyyopHCCG3iTa
         OSyCAOG0QBEyQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=KIck82No c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=Y1XEqrXkt80nLp6DE-UA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Quentin Perret'" <qperret@google.com>
Cc:     <arnd@arndb.de>, <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <kernel-team@android.com>,
        <tkjos@google.com>, <adharmap@codeaurora.org>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>, <rjw@rjwysocki.net>
References: <20200623142138.209513-1-qperret@google.com>
In-Reply-To: <20200623142138.209513-1-qperret@google.com>
Subject: RE: [PATCH v2 0/2] cpufreq: Specify the default governor on command line
Date:   Tue, 23 Jun 2020 10:54:33 -0700
Message-ID: <002201d64987$5dc93b90$195bb2b0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZJaaHcP5RdUeGMRwewlXzPV6L8fwAGk87g
Content-Language: en-ca
X-CMAE-Envelope: MS4wfJu2yqI8bRMr3UvgLSZTDIOmbcCsPGfJ6bFMtvxEaoYm2d6MHbeS6knNu9stKr4x3M2WemFcg+T8r+YcHHN7Xm9m2GVRbnx9rrulnY0dOdo50fpRI8bF
 L8C+gFGAN5a+pWPiW+Lf7UlIJ5vgUuvY4Cia10wb5tuYjUhIsibPUqw8CtQDcQqUnRl8B0KfSFDePVIoUmbQ+JP42QAcGEVgYvnmEUq8hjSuq5YyzzLJg+S4
 5Fcz0YvOEMWWgZVKttfvUWNGdLsN4rUHUfHwDGKQKKrmd0MseovLCT5Ct4yz58lEkF5A8wEKz95upfBi7W5Vvz+8xuLTG+OlxGl3Mggol+9Ou87f8VvCTkpp
 MZb6MBTz4VxxT08r+nRm66fKbyVlBuaJGRasoLoU4k7l92Nq+bfvfslIeLAtCpMwrTeoYdOXA4Ja+xgivuKozyPRdJ/nVg9uqnzqpKUe/48c25TFhUM083Vx
 HnGW8Ja+bMyxKQo+djKsm9SU1N8JLmaiNF49RPK0m8E1ynsnyZ+RXk47RWITIM0Ztd76eT17vo0Sm1nbdFM9ZJB+7G93bqcfXyKGMKHh9MCG/CVjyOPLnkaZ
 lTrKtzC6oA/opqTaIoMj3H2FtUtOfU4fnXj1CYWgsW/ZbU+T/7O1jN6STF3HfSYYsuAwbgtAsqsVT08FfG+FGU7Pnm5X23RFcXsQe30uC5oNMjus53Cfzoo8
 iKufS4H/2mc=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.06.23 07:22 Quentin Perret wrote:
>=20
> This series enables users of prebuilt kernels (e.g. distro kernels) to
> specify their CPUfreq governor of choice using the kernel command =
line,
> instead of having to wait for the system to fully boot to userspace to
> switch using the sysfs interface. This is helpful for 2 reasons:
>   1. users get to choose the governor that runs during the actual =
boot;
>   2. it simplifies the userspace boot procedure a bit (one less thing =
to
>      worry about).
>=20
> To enable this, the first patch moves all governor init calls to
> core_initcall, to make sure they are registered by the time the =
drivers
> probe. This should be relatively low impact as registering a governor
> is a simple procedure (it gets added to a llist), and all governors
> already load at core_initcall anyway when they're set as the default
> in Kconfig. This also allows to clean-up the governors' init/exit =
code,
> and reduces boilerplate.
>=20
> The second patch introduces the new command line parameter, inspired =
by
> its cpuidle counterpart. More details can be found in the respective
> patch headers.
>=20
> Changes in v2:
>  - added Viresh's ack to patch 01
>  - moved the assignment of 'default_governor' in patch 02 to the =
governor
>    registration path instead of the driver registration (Viresh)
>=20
> Thanks,
> Quentin
>=20
> Quentin Perret (2):
>   cpufreq: Register governors at core_initcall
>   cpufreq: Specify default governor on command line
>=20
>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>  Documentation/admin-guide/pm/cpufreq.rst      |  6 ++---
>  .../platforms/cell/cpufreq_spudemand.c        | 26 =
++-----------------
>  drivers/cpufreq/cpufreq.c                     | 23 ++++++++++++----
>  drivers/cpufreq/cpufreq_conservative.c        | 22 ++++------------
>  drivers/cpufreq/cpufreq_ondemand.c            | 24 +++++------------
>  drivers/cpufreq/cpufreq_performance.c         | 14 ++--------
>  drivers/cpufreq/cpufreq_powersave.c           | 18 +++----------
>  drivers/cpufreq/cpufreq_userspace.c           | 18 +++----------
>  include/linux/cpufreq.h                       | 14 ++++++++++
>  kernel/sched/cpufreq_schedutil.c              |  6 +----
>  11 files changed, 62 insertions(+), 114 deletions(-)
>=20
> --
> 2.27.0.111.gc72c7da667-goog

Hi Quentin,

Because I am lazy and sometimes do not want to recompile
the distro source, I have a need/desire for this.

Tested these two grub command lines:

GRUB_CMDLINE_LINUX_DEFAULT=3D"ipv6.disable=3D1 consoleblank=3D300 =
intel_pstate=3Ddisable cpufreq.default_governor=3Dschedutil =
cpuidle_sysfs_switch cpuidle.governor=3Dteo"

And

#GRUB_CMDLINE_LINUX_DEFAULT=3D"ipv6.disable=3D1 consoleblank=3D450 =
intel_pstate=3Dpassive cpufreq.default_governor=3Dschedutil =
cpuidle_sysfs_switch cpuidle.governor=3Dteo"

And all worked as expected. I use Ubuntu as my distro, and also had to =
disable a startup script that switches to "ondemand", or similar, after =
1 minute.

As a side note (separate subject, but is one reason I tried it):
My i5-9600K based computer seems to hit a power limit during boot =
approximately 3 seconds after kernel selection on grub.
This had no effect on that issue (even when selecting powersave =
governor).

... Doug


