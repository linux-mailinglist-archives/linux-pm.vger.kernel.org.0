Return-Path: <linux-pm+bounces-38746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F0C8BCA5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9BE74E16E9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE132E14A;
	Wed, 26 Nov 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4NDjMPk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007002FF149;
	Wed, 26 Nov 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188277; cv=none; b=WHzy9UsinfHBG2RjqIlY9b5N4YVpyom2RHqEEkasOOTljOdNFpov0En7WrwiEXv6JQiDbp7nkLZKrrWsyFhJyLRk2iAIZGDBIzA0SVuJvzyYTSXseBFvBHL8ljRjT9G8F3pKJaNyWGGd2LLxIkY3bGSNbjH/SCGTnJoyePjzxPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188277; c=relaxed/simple;
	bh=duNoWfaNjp+xMfmno0sK8fdjO/rXoov+O/Yk6pDvpo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fV++oZqhhb66RLpkDc9DMiSETm37tQphyDxjO1ybyslEm3piYSxglm1Xr0tCH216tF85GitC7DvOTJ3i1dBiw6aMsPxpONs9c51pMEUmSHws+yTNrbZYtqwjDXaiUpPmADLKkR2U8OArZEe2ZxJpEMxdED39nDZ+qkJC9q2cEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4NDjMPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D8BC4CEF7;
	Wed, 26 Nov 2025 20:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764188276;
	bh=duNoWfaNjp+xMfmno0sK8fdjO/rXoov+O/Yk6pDvpo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4NDjMPkNJ79kZ77/zCOqtgcNtV9TTINVUJH/iatSHjosoWOUNkK1p50x5rXDhni0
	 T8lWJv8bgoNtrCZ/ZqBKFN2Qfn9gSjW3SL64YIcyqJL41Au/IXWLKLX2Ax9UDNBBhy
	 e8gPsDwmK9Z5USZru7Ldv+9d0RCDZf28P9k+xXf7m1vbniCblouhn70e4E8XrU/Ha6
	 VhlhY8j6M/4bGNZr3vnHaF5cNENlNPytLnFlcjGyXUicNffTl5ugtSgskno3oDFjY+
	 oMRenckvKaytL05hFmUalpIXVIiX/6t5Z4HX3E4laZ47pXPO5UBqlAztDIZRB0MCQo
	 orpoW1oX48xaQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume and
 runtime disable
Date: Wed, 26 Nov 2025 21:17:51 +0100
Message-ID: <4697314.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
References:
 <20251126101636.205505-1-yang.yang@vivo.com>
 <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, November 26, 2025 8:34:54 PM CET Rafael J. Wysocki wrote:
> On Wed, Nov 26, 2025 at 8:16=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Nov 26, 2025 at 7:06=E2=80=AFPM Bart Van Assche <bvanassche@acm=
=2Eorg> wrote:
> > >
> > > On 11/26/25 3:30 AM, Rafael J. Wysocki wrote:
> > > > On Wed, Nov 26, 2025 at 11:17=E2=80=AFAM Yang Yang <yang.yang@vivo.=
com> wrote:
> > > >>   T1:                                   T2:
> > > >>   blk_queue_enter
> > > >>   blk_pm_resume_queue
> > > >>   pm_request_resume
> > > >
> > > > Shouldn't this be pm_runtime_resume() rather?
> > >
> > > I tried to make that change on an Android device. As a result, the
> > > kernel complaint shown below appeared. My understanding is that sleep=
ing
> > > in atomic context can trigger a deadlock and hence is not allowed.
> > >
> > > [   13.728890][    T1] WARNING: CPU: 6 PID: 1 at
> > > kernel/sched/core.c:9714 __might_sleep+0x78/0x84
> > > [   13.758800][    T1] Call trace:
> > > [   13.759027][    T1]  __might_sleep+0x78/0x84
> > > [   13.759340][    T1]  __pm_runtime_resume+0x40/0xb8
> > > [   13.759781][    T1]  __bio_queue_enter+0xc0/0x1cc
> > > [   13.760153][    T1]  blk_mq_submit_bio+0x884/0xadc
> > > [   13.760548][    T1]  __submit_bio+0x2c8/0x49c
> > > [   13.760879][    T1]  __submit_bio_noacct_mq+0x38/0x88
> > > [   13.761242][    T1]  submit_bio_noacct_nocheck+0x4fc/0x7b8
> > > [   13.761631][    T1]  submit_bio+0x214/0x4c0
> > > [   13.761941][    T1]  mpage_readahead+0x1b8/0x1fc
> > > [   13.762284][    T1]  blkdev_readahead+0x18/0x28
> > > [   13.762660][    T1]  page_cache_ra_unbounded+0x310/0x4d8
> > > [   13.763072][    T1]  page_cache_ra_order+0xc0/0x5b0
> > > [   13.763434][    T1]  page_cache_sync_ra+0x17c/0x268
> > > [   13.763782][    T1]  filemap_read+0x4c4/0x12f4
> > > [   13.764125][    T1]  blkdev_read_iter+0x100/0x164
> > > [   13.764475][    T1]  vfs_read+0x188/0x348
> > > [   13.764789][    T1]  __se_sys_pread64+0x84/0xc8
> > > [   13.765180][    T1]  __arm64_sys_pread64+0x1c/0x2c
> > > [   13.765556][    T1]  invoke_syscall+0x58/0xf0
> > > [   13.765876][    T1]  do_el0_svc+0x8c/0xe0
> > > [   13.766172][    T1]  el0_svc+0x50/0xd4
> > > [   13.766583][    T1]  el0t_64_sync_handler+0x20/0xf4
> > > [   13.766932][    T1]  el0t_64_sync+0x1bc/0x1c0
> > > [   13.767294][    T1] irq event stamp: 2589614
> > > [   13.767592][    T1] hardirqs last  enabled at (2589613):
> > > [<ffffffc0800eaf24>] finish_lock_switch+0x70/0x108
> > > [   13.768283][    T1] hardirqs last disabled at (2589614):
> > > [<ffffffc0814b66f4>] el1_dbg+0x24/0x80
> > > [   13.768875][    T1] softirqs last  enabled at (2589370):
> > > [<ffffffc080082a7c>] ____do_softirq+0x10/0x20
> > > [   13.769529][    T1] softirqs last disabled at (2589349):
> > > [<ffffffc080082a7c>] ____do_softirq+0x10/0x20
> > >
> > > I think that the filemap_invalidate_lock_shared() call in
> > > page_cache_ra_unbounded() forbids sleeping in submit_bio().
> >
> > The wait_event() macro in __bio_queue_enter() calls might_sleep() at
> > the very beginning, so why would it not complain?
> >
> > IIUC, this is the WARN_ONCE() in __might_sleep() about the task state
> > being different from TASK_RUNNING, which triggers because
> > prepare_to_wait_event() changes the task state to
> > TASK_UNINTERRUPTIBLE.
> >
> > This means that calling pm_runtime_resume() cannot be part of the
> > wait_event() condition, so blk_pm_resume_queue() and the wait_event()
> > macros involving it would need some rewriting.
>=20
> Interestingly enough, the pm_request_resume() call in
> blk_pm_resume_queue() is not even necessary in the __bio_queue_enter()
> case because pm is false there and it doesn't even check
> q->rpm_status.
>=20
> So in fact the resume is only necessary in blk_queue_enter() if pm is non=
zero.

If I'm not completely in the weeds, something like the patch below should be
doable.

Also, I'd consider using pm_runtime_get_noresume() and pm_runtime_put_noidl=
e()
in blk_queue_enter() and blk_queue_exit(), respectively, in the "pm !=3D 0"=
 case
to prevent the device from suspending while the .q_usage_counter ref is hel=
d.

=2D--
 block/blk-core.c |    6 +++---
 block/blk-pm.h   |    7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

=2D-- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EAGAIN;
=20
+		/* if necessary, resume .dev (assume success). */
+		blk_pm_resume_queue(pm, q);
 		/*
 		 * read pair of barrier in blk_freeze_queue_start(), we need to
 		 * order reading __PERCPU_REF_DEAD flag of .q_usage_counter and
@@ -318,9 +320,7 @@ int blk_queue_enter(struct request_queue
 		 */
 		smp_rmb();
 		wait_event(q->mq_freeze_wq,
=2D			   (!q->mq_freeze_depth &&
=2D			    blk_pm_resume_queue(pm, q)) ||
=2D			   blk_queue_dying(q));
+			   !q->mq_freeze_depth || blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
 	}
=2D-- a/block/blk-pm.h
+++ b/block/blk-pm.h
@@ -10,9 +10,10 @@ static inline int blk_pm_resume_queue(co
 {
 	if (!q->dev || !blk_queue_pm_only(q))
 		return 1;	/* Nothing to do */
=2D	if (pm && q->rpm_status !=3D RPM_SUSPENDED)
=2D		return 1;	/* Request allowed */
=2D	pm_request_resume(q->dev);
+
+	if (pm)
+		pm_runtime_resume(q->dev);
+
 	return 0;
 }
=20




