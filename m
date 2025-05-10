Return-Path: <linux-pm+bounces-26981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D4AAB2397
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E564A7D3F
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35845213237;
	Sat, 10 May 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MULkQk3y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D329A0;
	Sat, 10 May 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746876701; cv=none; b=n0tyS759U7E79NtcfIzvAkQ2gyEWxB2v8a+o+fABPEVu52tj1mXjeypETHasucnEyiQVidyz6PnH1bMVNmWRtUa0yIcLca5iFt/kItJUg2YRBbxnDHt0BDPIxwwChn8OXc1ZzUCrPZX+3+Zr0dKrdtA28pfd55VYdceFJQMK73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746876701; c=relaxed/simple;
	bh=7RJKALqp7l8DYsbt2qHWOm4Y7mwWTnmG9zpcU0ipbyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0ODHyffNJjvldMcJjLnV7PLuTEzGdTFu3TS/fU7Iz9j6aEMWQLu31OIhZtVXRh4i0xU5daCHpeaY7gFtAwtYZYnOzsBU/s2k4ATConDUSFzYdghQWp6aOZ0tp1SDqJyJNh0jLFJsogLyPFlC13PBnV4WSlaCgAVAPqLhUNg4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MULkQk3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EDBC4CEE2;
	Sat, 10 May 2025 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746876700;
	bh=7RJKALqp7l8DYsbt2qHWOm4Y7mwWTnmG9zpcU0ipbyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MULkQk3ybLbw4boEqCuSyffrUBDP90NYv94Ub92ddE/9EV44qBN9vqlanyjeuMMO0
	 hT0BeWiTgsWcaRxiGHp/14D4YblerZrkxlI/pcNtwkW1Zkdl+Po4LDM9nNe/zqOn9G
	 TRp01SWwqMBurwZBs31e7Gt+6I3QvPhwM6iKbH1Idifp+cx1tzChr4RCgU8/rEULYE
	 VoSALRmCs8xrk5HqmD4i1g+hlQICs2IRB8Gkv5iiSo0LRWRCUGujzVKiZ3OIfFYwqj
	 u3k9PdbzosxQiK76LEFPqpflxAmpm4UnPSZ6unNEyr0OUKAG9dg8RSHE84ZCqWTw4p
	 aJNUlmk7aR5DQ==
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4811fca8658so41692381cf.3;
        Sat, 10 May 2025 04:31:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULfhVDHgEAG+oVMokMwQISwcgFjVkM12zAQOV1+Wsq7tcqBhQgTu0jbC6hEP5jcruSw4z5J78Yd0U=@vger.kernel.org, AJvYcCWtCtIOnO3VvLfeMowFQetgwHTzZIj2YnLrY69ojFJMQrHbWCYZwph3axA/TgKkXP1vz0FM6HDPac4Zhus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wemrdg/MgjHpIHQ9tuwtIwnrtgsLjJxVVem6+JH0BsHT3TZJ
	AxWdsorEyAabsVfsACdSyJfKtHK4utKCp4MxO+DVP7kJaqru+G9HOz+kCXWOp+UE3G8lhz3H/51
	DOYRfKaqEz9n7IpnBxUhe5PNIHyk=
X-Google-Smtp-Source: AGHT+IEUnSobNKixJGhxvxynnvZab7zKBWcvD4jcDikIyFtJr8Y/w2t+Atgh0RIQvXSVfNViHHrUyzmXBklsD/jJ5V4=
X-Received: by 2002:a05:6820:1f07:b0:606:361b:52a6 with SMTP id
 006d021491bc7-6084b64a3b4mr4004348eaf.4.1746876687554; Sat, 10 May 2025
 04:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2999205.e9J7NaK4W3@rjwysocki.net> <CGME20250509234915eucas1p2846ecef88f268d78ab2e96d4a67002b0@eucas1p2.samsung.com>
 <2317800.iZASKD2KPV@rjwysocki.net> <1bf3df62-0641-459f-99fc-fd511e564b84@samsung.com>
In-Reply-To: <1bf3df62-0641-459f-99fc-fd511e564b84@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 10 May 2025 13:31:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j_fFk=EX0Z9_w1twQH-FpntHJvr4d0WSMBM6PevfEqNg@mail.gmail.com>
X-Gm-Features: AX0GCFs0PO4tUN7v3aivtRSGkesNarVFWJdlkry5b0QVdFIy2-h4vBnIptHjnCU
Message-ID: <CAJZ5v0j_fFk=EX0Z9_w1twQH-FpntHJvr4d0WSMBM6PevfEqNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: multipart/mixed; boundary="0000000000006db9d60634c66caf"

--0000000000006db9d60634c66caf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 1:49=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 06.05.2025 22:37, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Doing cpufreq-specific EAS checks that require accessing policy
> > internals directly from sched_is_eas_possible() is a bit unfortunate,
> > so introduce cpufreq_ready_for_eas() in cpufreq, move those checks
> > into that new function and make sched_is_eas_possible() call it.
> >
> > While at it, address a possible race between the EAS governor check
> > and governor change by doing the former under the policy rwsem.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> In my tests I've noticed that this patch, merged as commit 4854649b1fb4
> ("cpufreq/sched: Move cpufreq-specific EAS checks to cpufreq"), causes a
> regression on ARM64 Amlogic Meson SoC based OdroidN2 board. The board
> finally lockups. Reverting $subject on top of next-20250509 fixes this
> issue. Here is the lockdep warning observed before the lockup:

Thanks for the report!

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.15.0-rc5-next-20250509-dirty #10335 Tainted: G         C
> cpufreq: cpufreq_policy_online: CPU2: Running at unlisted initial
> frequency: 999999 kHz, changing to: 1000000 kHz
> ------------------------------------------------------
> kworker/3:1/79 is trying to acquire lock:
> ffff00000494b380 (&policy->rwsem){++++}-{4:4}, at:
> cpufreq_ready_for_eas+0x60/0xbc
>
> but task is already holding lock:
> ffff8000832887a0 (sched_domains_mutex){+.+.}-{4:4}, at:
> partition_sched_domains+0x54/0x938
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (sched_domains_mutex){+.+.}-{4:4}:
>         __mutex_lock+0xa8/0x598
>         mutex_lock_nested+0x24/0x30
>         partition_sched_domains+0x54/0x938
>         rebuild_sched_domains_locked+0x2d4/0x900
>         rebuild_sched_domains+0x2c/0x48
>         rebuild_sched_domains_energy+0x3c/0x58
>         rebuild_sd_workfn+0x10/0x1c
>         process_one_work+0x208/0x604
>         worker_thread+0x244/0x388
>         kthread+0x150/0x228
>         ret_from_fork+0x10/0x20
>
> -> #1 (cpuset_mutex){+.+.}-{4:4}:
>         __mutex_lock+0xa8/0x598
>         mutex_lock_nested+0x24/0x30
>         cpuset_lock+0x1c/0x28
>         __sched_setscheduler+0x31c/0x830
>         sched_setattr_nocheck+0x18/0x24
>         sugov_init+0x1b4/0x388
>         cpufreq_init_governor.part.0+0x58/0xd4
>         cpufreq_set_policy+0x2c8/0x3ec
>         cpufreq_online+0x520/0xb20
>         cpufreq_add_dev+0x80/0x98
>         subsys_interface_register+0xfc/0x118
>         cpufreq_register_driver+0x150/0x238
>         dt_cpufreq_probe+0x148/0x488
>         platform_probe+0x68/0xdc
>         really_probe+0xbc/0x298
>         __driver_probe_device+0x78/0x12c
>         driver_probe_device+0xdc/0x164
>         __device_attach_driver+0xb8/0x138
>         bus_for_each_drv+0x80/0xdc
>         __device_attach+0xa8/0x1b0
>         device_initial_probe+0x14/0x20
>         bus_probe_device+0xb0/0xb4
>         deferred_probe_work_func+0x8c/0xc8
>         process_one_work+0x208/0x604
>         worker_thread+0x244/0x388
>         kthread+0x150/0x228
>         ret_from_fork+0x10/0x20
>
> -> #0 (&policy->rwsem){++++}-{4:4}:
>         __lock_acquire+0x1408/0x2254
>         lock_acquire+0x1c8/0x354
>         down_read+0x60/0x180
>         cpufreq_ready_for_eas+0x60/0xbc
>         sched_is_eas_possible+0x144/0x170
>         partition_sched_domains+0x504/0x938
>         rebuild_sched_domains_locked+0x2d4/0x900
>         rebuild_sched_domains+0x2c/0x48
>         rebuild_sched_domains_energy+0x3c/0x58
>         rebuild_sd_workfn+0x10/0x1c
>         process_one_work+0x208/0x604
>         worker_thread+0x244/0x388
>         kthread+0x150/0x228
>         ret_from_fork+0x10/0x20
>
> other info that might help us debug this:
>
> Chain exists of:
>    &policy->rwsem --> cpuset_mutex --> sched_domains_mutex
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(sched_domains_mutex);
>                                 lock(cpuset_mutex);
>                                 lock(sched_domains_mutex);
>    rlock(&policy->rwsem);
>
>   *** DEADLOCK ***

Well, it turns out that trying to acquire policy->rwsem under
sched_domains_mutex is a bad idea.  It was added to
cpufreq_policy_is_good_for_eas() to address a theoretical race, so it
can be dropped safely.  A theoretical race is better than a real
deadlock.

Please test the attached patch.

--0000000000006db9d60634c66caf
Content-Type: text/x-patch; charset="US-ASCII"; name="cpufreq-eas-policy-locking.patch"
Content-Disposition: attachment; filename="cpufreq-eas-policy-locking.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mai57qwn0>
X-Attachment-Id: f_mai57qwn0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jIHwgICAgMiAtLQogMSBmaWxlIGNoYW5nZWQs
IDIgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jCisrKyBiL2Ry
aXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMKQEAgLTMwNjcsOCArMzA2Nyw2IEBACiAJCXJldHVybiBm
YWxzZTsKIAl9CiAKLQlndWFyZChjcHVmcmVxX3BvbGljeV9yZWFkKShwb2xpY3kpOwotCiAJcmV0
dXJuIHN1Z292X2lzX2dvdmVybm9yKHBvbGljeSk7CiB9CiAK
--0000000000006db9d60634c66caf--

