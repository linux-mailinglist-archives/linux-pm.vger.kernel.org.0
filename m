Return-Path: <linux-pm+bounces-38743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD185C8B96E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 20:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923AC4E23CD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 19:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DEB31282C;
	Wed, 26 Nov 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJxJntV6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413F27A907
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185706; cv=none; b=Y7ZNiBoF23Zpqj5wjRxuAEjemDK3fYDGQJImK7kLDbUImtzRURwJPjgoznw1f41Lp/sJ3b3B8wiC1bONULcUaW8+6Tmd2DTaS9SJnG3gvFtgvwnWQVxmCZDKsh/AE1UbMzRsLidkIoKMA7DP0fFZSrOhBUmjryAl8lnCEbaXvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185706; c=relaxed/simple;
	bh=XQDQ9I7hk2Oat6KJybAbEt8Bx/NXcvpgi+5MDvmYkFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li+iHinywX+ehzXKj5Mf/4263PGzkujlCnmS5NZBk1DrMoDh0tuNdXye+RpTrd1llGEbLeg20BCzCmdR8o6lvzC3cAFYhfAWGCL+onW6bAMZ9v6DNoEtcLSuaak2ODevVuKEzr+mg9bUtLOjvZyN2NxT5Y1PCeZ0k/08nV3J3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJxJntV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BFAC4AF0B
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764185706;
	bh=XQDQ9I7hk2Oat6KJybAbEt8Bx/NXcvpgi+5MDvmYkFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IJxJntV640F7xxCLSM3VgdmiOoYAv1Dtsn/XKAfZ9Iy95kqhWqMy9KTVRagGqaNTF
	 Vl1Ev79NdEzSI5tdtcpeTFNFcWXbh4MNUvgAYLWH264ipiTurJ3LY/CJ28Qm1rPKnS
	 bPRmMo5fDrIhBVp2o5NnUFjD0OYkhcnvIPNzRX2RNfjguXEJX4d4vVvmhYPfGk1/wy
	 42UAbyJfUAUrAJpa89Pj8sUV/f9aXPhMkXjmkzg7kjmd6sIid8ox6Hz7NNp/zjoHvG
	 HSXvMlejVfW9C+l5ElnwcwuszwuY+R+amNL0jjm3Q1ed64Dec3uurj8Md4as0hTNbB
	 WHGcZe0ttBE3w==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-657509d761dso74884eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 11:35:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2e0wQAvWLgj9OZdEmjYSSTWwiZhNK2noUo0we7dX2itphWkboQGNBtToGt22vJawdvsj4zJvHTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYPScI+wnVunPNJ27xPcE3SqZqz5sXYSLASWGUsp7QL9aSTf2
	jo5sl4CkLbvTnju7PewH/LyZcrV4DSm5GFxYXKi1rBAPRaO2HdKX6932JOrOc32xh6YWsKaUBJU
	InAFfvkEkepbbnDDKGrsmFdqQS4d0hB4=
X-Google-Smtp-Source: AGHT+IF7fUsRU7OOam9RhNN9w5REOVZQGfyD80NYqwZUC1JLb92IFndNaXVG+1qP3owOIfqIWp5hclB3p1vm1Fxt6rQ=
X-Received: by 2002:a05:6820:4b89:b0:656:9e05:31d4 with SMTP id
 006d021491bc7-65792064ea6mr6567127eaf.2.1764185705300; Wed, 26 Nov 2025
 11:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
 <6373a999-f19a-450c-9e83-7448fb70a772@acm.org> <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 20:34:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmmOe5_D8143eItUwIExwL_x-0XgMRjAczSeOz-acWxstShS-Sq1_ai_LE
Message-ID: <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 8:16=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Nov 26, 2025 at 7:06=E2=80=AFPM Bart Van Assche <bvanassche@acm.o=
rg> wrote:
> >
> > On 11/26/25 3:30 AM, Rafael J. Wysocki wrote:
> > > On Wed, Nov 26, 2025 at 11:17=E2=80=AFAM Yang Yang <yang.yang@vivo.co=
m> wrote:
> > >>   T1:                                   T2:
> > >>   blk_queue_enter
> > >>   blk_pm_resume_queue
> > >>   pm_request_resume
> > >
> > > Shouldn't this be pm_runtime_resume() rather?
> >
> > I tried to make that change on an Android device. As a result, the
> > kernel complaint shown below appeared. My understanding is that sleepin=
g
> > in atomic context can trigger a deadlock and hence is not allowed.
> >
> > [   13.728890][    T1] WARNING: CPU: 6 PID: 1 at
> > kernel/sched/core.c:9714 __might_sleep+0x78/0x84
> > [   13.758800][    T1] Call trace:
> > [   13.759027][    T1]  __might_sleep+0x78/0x84
> > [   13.759340][    T1]  __pm_runtime_resume+0x40/0xb8
> > [   13.759781][    T1]  __bio_queue_enter+0xc0/0x1cc
> > [   13.760153][    T1]  blk_mq_submit_bio+0x884/0xadc
> > [   13.760548][    T1]  __submit_bio+0x2c8/0x49c
> > [   13.760879][    T1]  __submit_bio_noacct_mq+0x38/0x88
> > [   13.761242][    T1]  submit_bio_noacct_nocheck+0x4fc/0x7b8
> > [   13.761631][    T1]  submit_bio+0x214/0x4c0
> > [   13.761941][    T1]  mpage_readahead+0x1b8/0x1fc
> > [   13.762284][    T1]  blkdev_readahead+0x18/0x28
> > [   13.762660][    T1]  page_cache_ra_unbounded+0x310/0x4d8
> > [   13.763072][    T1]  page_cache_ra_order+0xc0/0x5b0
> > [   13.763434][    T1]  page_cache_sync_ra+0x17c/0x268
> > [   13.763782][    T1]  filemap_read+0x4c4/0x12f4
> > [   13.764125][    T1]  blkdev_read_iter+0x100/0x164
> > [   13.764475][    T1]  vfs_read+0x188/0x348
> > [   13.764789][    T1]  __se_sys_pread64+0x84/0xc8
> > [   13.765180][    T1]  __arm64_sys_pread64+0x1c/0x2c
> > [   13.765556][    T1]  invoke_syscall+0x58/0xf0
> > [   13.765876][    T1]  do_el0_svc+0x8c/0xe0
> > [   13.766172][    T1]  el0_svc+0x50/0xd4
> > [   13.766583][    T1]  el0t_64_sync_handler+0x20/0xf4
> > [   13.766932][    T1]  el0t_64_sync+0x1bc/0x1c0
> > [   13.767294][    T1] irq event stamp: 2589614
> > [   13.767592][    T1] hardirqs last  enabled at (2589613):
> > [<ffffffc0800eaf24>] finish_lock_switch+0x70/0x108
> > [   13.768283][    T1] hardirqs last disabled at (2589614):
> > [<ffffffc0814b66f4>] el1_dbg+0x24/0x80
> > [   13.768875][    T1] softirqs last  enabled at (2589370):
> > [<ffffffc080082a7c>] ____do_softirq+0x10/0x20
> > [   13.769529][    T1] softirqs last disabled at (2589349):
> > [<ffffffc080082a7c>] ____do_softirq+0x10/0x20
> >
> > I think that the filemap_invalidate_lock_shared() call in
> > page_cache_ra_unbounded() forbids sleeping in submit_bio().
>
> The wait_event() macro in __bio_queue_enter() calls might_sleep() at
> the very beginning, so why would it not complain?
>
> IIUC, this is the WARN_ONCE() in __might_sleep() about the task state
> being different from TASK_RUNNING, which triggers because
> prepare_to_wait_event() changes the task state to
> TASK_UNINTERRUPTIBLE.
>
> This means that calling pm_runtime_resume() cannot be part of the
> wait_event() condition, so blk_pm_resume_queue() and the wait_event()
> macros involving it would need some rewriting.

Interestingly enough, the pm_request_resume() call in
blk_pm_resume_queue() is not even necessary in the __bio_queue_enter()
case because pm is false there and it doesn't even check
q->rpm_status.

So in fact the resume is only necessary in blk_queue_enter() if pm is nonze=
ro.

