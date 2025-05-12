Return-Path: <linux-pm+bounces-27043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BCCAB37E4
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 14:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC931889540
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3B9292933;
	Mon, 12 May 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqIE9/2t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2628DB66;
	Mon, 12 May 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054451; cv=none; b=lc7SD+kakStMj1G6mbAROpOhA6H22DXPDWQITX81O512KPQrY9xcbrOPk0K4phCYGymcq/Ho5GsZg4Dr0nXmZYCDcMJ12jG2g5NAtW+NQb1wzi3j3sBgNclopDG/2yYpntcOwiAvEJXRDTrTzazuvjCyPzrBgtstDRmpK8bSSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054451; c=relaxed/simple;
	bh=ZqGKVkSFrWRuJdG0uaII6V61n/FpNvyAipHC6cKaOzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+XeYx4syTaMl8muPjtUVNcxTmLOAG2tW+7RufTxebmuey+cUBCMvn07Jnwrpzx08/I1yPRw5uUaGbOVyhuEOvVLa8G/QGcbdZ4NUzlzsmlVEYpe+xbCNHtzAry7pfYFfMJuhnp2IsjYLhCmtVnd9c3nwPUO9bQ4aIJx+04QanQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqIE9/2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474A8C4CEF5;
	Mon, 12 May 2025 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747054451;
	bh=ZqGKVkSFrWRuJdG0uaII6V61n/FpNvyAipHC6cKaOzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uqIE9/2tKY9F+LG/P/ftN+rWI6j6Z+1ZgOHdjKpdYEg0k3sbu2ehZ3miJ/xhZ5p5K
	 AIh1WTpXJN1cGy3g3lcjpldDfeOiqBYNhToBXPZsh1XV2EbmyfaP0CjYql8t8YfnF4
	 92/A10L80uevjWSKWEsgmXMrdwo5cQyay+a1ofXeCKTmEgpbLocCRVuN8jwgb2jpBf
	 M+lgKzhNwLw5Cedrp6eMis26xMnT9KhJjAlZ+2N+Qxmuvkp8WanBs5ZYqM4CnmrPxn
	 pZ4+v0q2rh4LjM/Rf93k0Hv/FfziC5vr0X7V08NMkTUWxEbDVC9WRT1AG3I1Ws7qt2
	 AEYld8HUxRJGQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7311a8bb581so3376829a34.0;
        Mon, 12 May 2025 05:54:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGwycbK5jS7PCyG6gVO0jFzhmZp1UO8jGTSjyQvyEeTNt4Jkq/GbjjchK9uOcZC2tQG559Ka9YUZaf0kY=@vger.kernel.org, AJvYcCXx69mNAuGz5sazK8QTOfaeG82cSeVBobg38w6oGM+Nwhc75HJCuQmqKt3rKXgYyPBFRMm4mn/cQCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMpEfqoXy9/GefS/EQDjUS2KYHK0eiwXH6rU74kStXTXheN7u9
	oKZZkT+axJMulRecc85Q1t+YSgYq71FFD00a7sUAm24oyZbwaaoqy08Go2ZLiQkA6zXwL7mxWp0
	o09T8tD2nEFuAQCAynoq5pyKrgCA=
X-Google-Smtp-Source: AGHT+IG9BKY0mh+/izljc+xxJwtYV0Fzg2sQva1WqJcdGn+3JOQuo+bTdKDq8hgK1DKy7XLDpBRWElG4URn/IDv4sSk=
X-Received: by 2002:a05:6871:339d:b0:2c1:44a9:fc16 with SMTP id
 586e51a60fabf-2dba4575051mr7283236fac.38.1747054450522; Mon, 12 May 2025
 05:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2999205.e9J7NaK4W3@rjwysocki.net> <CGME20250509234915eucas1p2846ecef88f268d78ab2e96d4a67002b0@eucas1p2.samsung.com>
 <2317800.iZASKD2KPV@rjwysocki.net> <1bf3df62-0641-459f-99fc-fd511e564b84@samsung.com>
 <CAJZ5v0j_fFk=EX0Z9_w1twQH-FpntHJvr4d0WSMBM6PevfEqNg@mail.gmail.com> <c00ec721-1193-4cfb-87ec-fd98f215720e@samsung.com>
In-Reply-To: <c00ec721-1193-4cfb-87ec-fd98f215720e@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 May 2025 14:53:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLr3JZ49gX9XbkjPNr_wRDMyAtMZDZ6Aoxz1KgQZ_moA@mail.gmail.com>
X-Gm-Features: AX0GCFtbeKmSklXPgM_iJnoIIbhcO7WpjF87Nk9XGjsgQKQ2r82ff0v80JuGA8s
Message-ID: <CAJZ5v0iLr3JZ49gX9XbkjPNr_wRDMyAtMZDZ6Aoxz1KgQZ_moA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 8:48=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 10.05.2025 13:31, Rafael J. Wysocki wrote:
> > On Sat, May 10, 2025 at 1:49=E2=80=AFAM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 06.05.2025 22:37, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Doing cpufreq-specific EAS checks that require accessing policy
> >>> internals directly from sched_is_eas_possible() is a bit unfortunate,
> >>> so introduce cpufreq_ready_for_eas() in cpufreq, move those checks
> >>> into that new function and make sched_is_eas_possible() call it.
> >>>
> >>> While at it, address a possible race between the EAS governor check
> >>> and governor change by doing the former under the policy rwsem.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> >>> Tested-by: Christian Loehle <christian.loehle@arm.com>
> >>> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> In my tests I've noticed that this patch, merged as commit 4854649b1fb=
4
> >> ("cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq"), causes=
 a
> >> regression on ARM64 Amlogic Meson SoC based OdroidN2 board. The board
> >> finally lockups. Reverting $subject on top of next-20250509 fixes this
> >> issue. Here is the lockdep warning observed before the lockup:
> > Thanks for the report!
> >
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >> WARNING: possible circular locking dependency detected
> >> 6.15.0-rc5-next-20250509-dirty #10335 Tainted: G         C
> >> cpufreq: cpufreq_policy_online: CPU2: Running at unlisted initial
> >> frequency: 999999 kHz, changing to: 1000000 kHz
> >> ------------------------------------------------------
> >> kworker/3:1/79 is trying to acquire lock:
> >> ffff00000494b380 (&policy->rwsem){++++}-{4:4}, at:
> >> cpufreq_ready_for_eas+0x60/0xbc
> >>
> >> but task is already holding lock:
> >> ffff8000832887a0 (sched_domains_mutex){+.+.}-{4:4}, at:
> >> partition_sched_domains+0x54/0x938
> >>
> >> which lock already depends on the new lock.
> >>
> >> the existing dependency chain (in reverse order) is:
> >>
> >> -> #2 (sched_domains_mutex){+.+.}-{4:4}:
> >>          __mutex_lock+0xa8/0x598
> >>          mutex_lock_nested+0x24/0x30
> >>          partition_sched_domains+0x54/0x938
> >>          rebuild_sched_domains_locked+0x2d4/0x900
> >>          rebuild_sched_domains+0x2c/0x48
> >>          rebuild_sched_domains_energy+0x3c/0x58
> >>          rebuild_sd_workfn+0x10/0x1c
> >>          process_one_work+0x208/0x604
> >>          worker_thread+0x244/0x388
> >>          kthread+0x150/0x228
> >>          ret_from_fork+0x10/0x20
> >>
> >> -> #1 (cpuset_mutex){+.+.}-{4:4}:
> >>          __mutex_lock+0xa8/0x598
> >>          mutex_lock_nested+0x24/0x30
> >>          cpuset_lock+0x1c/0x28
> >>          __sched_setscheduler+0x31c/0x830
> >>          sched_setattr_nocheck+0x18/0x24
> >>          sugov_init+0x1b4/0x388
> >>          cpufreq_init_governor.part.0+0x58/0xd4
> >>          cpufreq_set_policy+0x2c8/0x3ec
> >>          cpufreq_online+0x520/0xb20
> >>          cpufreq_add_dev+0x80/0x98
> >>          subsys_interface_register+0xfc/0x118
> >>          cpufreq_register_driver+0x150/0x238
> >>          dt_cpufreq_probe+0x148/0x488
> >>          platform_probe+0x68/0xdc
> >>          really_probe+0xbc/0x298
> >>          __driver_probe_device+0x78/0x12c
> >>          driver_probe_device+0xdc/0x164
> >>          __device_attach_driver+0xb8/0x138
> >>          bus_for_each_drv+0x80/0xdc
> >>          __device_attach+0xa8/0x1b0
> >>          device_initial_probe+0x14/0x20
> >>          bus_probe_device+0xb0/0xb4
> >>          deferred_probe_work_func+0x8c/0xc8
> >>          process_one_work+0x208/0x604
> >>          worker_thread+0x244/0x388
> >>          kthread+0x150/0x228
> >>          ret_from_fork+0x10/0x20
> >>
> >> -> #0 (&policy->rwsem){++++}-{4:4}:
> >>          __lock_acquire+0x1408/0x2254
> >>          lock_acquire+0x1c8/0x354
> >>          down_read+0x60/0x180
> >>          cpufreq_ready_for_eas+0x60/0xbc
> >>          sched_is_eas_possible+0x144/0x170
> >>          partition_sched_domains+0x504/0x938
> >>          rebuild_sched_domains_locked+0x2d4/0x900
> >>          rebuild_sched_domains+0x2c/0x48
> >>          rebuild_sched_domains_energy+0x3c/0x58
> >>          rebuild_sd_workfn+0x10/0x1c
> >>          process_one_work+0x208/0x604
> >>          worker_thread+0x244/0x388
> >>          kthread+0x150/0x228
> >>          ret_from_fork+0x10/0x20
> >>
> >> other info that might help us debug this:
> >>
> >> Chain exists of:
> >>     &policy->rwsem --> cpuset_mutex --> sched_domains_mutex
> >>
> >>    Possible unsafe locking scenario:
> >>
> >>          CPU0                    CPU1
> >>          ----                    ----
> >>     lock(sched_domains_mutex);
> >>                                  lock(cpuset_mutex);
> >>                                  lock(sched_domains_mutex);
> >>     rlock(&policy->rwsem);
> >>
> >>    *** DEADLOCK ***
> > Well, it turns out that trying to acquire policy->rwsem under
> > sched_domains_mutex is a bad idea.  It was added to
> > cpufreq_policy_is_good_for_eas() to address a theoretical race, so it
> > can be dropped safely.  A theoretical race is better than a real
> > deadlock.
> >
> > Please test the attached patch.
>
> This fixed the observed issue. Thanks!
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for the confirmation!

