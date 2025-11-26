Return-Path: <linux-pm+bounces-38701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A8C89CC1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867093A55DA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED05328618;
	Wed, 26 Nov 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh8Bo7Ep"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4131E0FA
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160600; cv=none; b=qqknr6NrKBHj3WUusMjOQERp+AQO7Q3OHmqZY2JgafaT46ymQoIv6Lpiqwne5Ot0bnpTEOhBJLeJ7DUu7YMU/7xYQLVKTCamhjGUM+QmXxHWLIRTpDQ2bkKHD0uLhLfdDofGHPF6pP2f3v/nYYGJRwKE2JhkRlFISGihBvIO1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160600; c=relaxed/simple;
	bh=VQ5W/IivQX6ySVdR6+HU6YxREt8RSQR+q3L/k25ce4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8g6IRdYhiXXSfD1P4CZKTeQMLnj5+teafG2XENYGNEhdNlixz8BcwtT/XBaJbEVJyUYjbAIW5INf7gnUlc7Gf0eXhr7YPe88+HmClDDz+croLLlJmsNxx4F3RkYdZezEAfE54lvmeYm29f4hHXTxWuANopwyuoIEECUIOf1pR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh8Bo7Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B11EC19422
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764160600;
	bh=VQ5W/IivQX6ySVdR6+HU6YxREt8RSQR+q3L/k25ce4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eh8Bo7EpY5GL9k4DvHYoipLZADtw9PynJ/kmJLXyqBchrUYuu/juII0/OJpF6/Soi
	 rFZL8xjBHZ2hXCW1ddODnFQ1bPaZvTC/X6FVzEKm6waZx9SemQh7Z/RtcRX4VJ+IBq
	 Z7xFU+FfhWQ9Gg3zp8MiGM5hd5ovIv9eiOCk36DVtSxNuXsYIK+B4Sp7LlkiETI0GN
	 JYtg9rqcCS/oJRemSXm5PJspG9jUnloc7oJpxE/cgz7+CO3DeYA3EFYAgFsDkRjiaM
	 QnYLs2oitIq4GZJFjbHtS5gPjcze4v6EZBkYAb5qHzl/bfK/onrcVScSXT07e/JKsO
	 GxP2eaZ0IEBbA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-657a6028fbbso1581288eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 04:36:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVp8+oOqhTLtL9zU0EopZZ+7ePG9ZMzsfI6PvNAbz0p35eO0nA+AQIF4oSx9YixYXV/6CkxCpb1lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxazC3gDMiN1UInBM0NKO/Qq73gW7weOv5eQLBk9xszbCr4VO2t
	+8/fqrTXLs+Ccz8zabK38o3hwqUy6yRohzVLFWZ1Ik2xD1nnv5nAiuL3+Vki7IF38WdY/nxA0LI
	HaWNq2yn26wLIdi3n0m2dg2rC/UWIaU0=
X-Google-Smtp-Source: AGHT+IGRhII15BLODu2RdGGrhNcoEQzXNo2xzbeqp/C1TrF8HVVvEragjCdCH6HQ7bq+XqgQqG7pDHkOhpFdOS8w9fQ=
X-Received: by 2002:a05:6820:6ae1:b0:656:9202:58ca with SMTP id
 006d021491bc7-657bdb961c7mr2268306eaf.3.1764160599562; Wed, 26 Nov 2025
 04:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com> <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com>
In-Reply-To: <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 13:36:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkQ071GAbhsiapueetSI1vC1HOk8W4hrSvgPJMMZr3hIOzqI4-BHY_pk_M
Message-ID: <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: YangYang <yang.yang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 12:59=E2=80=AFPM YangYang <yang.yang@vivo.com> wrot=
e:
>
> On 2025/11/26 19:30, Rafael J. Wysocki wrote:
> > On Wed, Nov 26, 2025 at 11:17=E2=80=AFAM Yang Yang <yang.yang@vivo.com>=
 wrote:
> >>
> >> We observed the following hung task during our test:
> >>
> >> [ 3987.095999] INFO: task "kworker/u32:7":239 blocked for more than 18=
8 seconds.
> >> [ 3987.096017] task:kworker/u32:7   state:D stack:0     pid:239   tgid=
:239   ppid:2      flags:0x00000408
> >> [ 3987.096042] Workqueue: writeback wb_workfn (flush-254:59)
> >> [ 3987.096069] Call trace:
> >> [ 3987.096073]  __switch_to+0x1a0/0x318
> >> [ 3987.096089]  __schedule+0xa38/0xf9c
> >> [ 3987.096104]  schedule+0x74/0x10c
> >> [ 3987.096118]  __bio_queue_enter+0xb8/0x178
> >> [ 3987.096132]  blk_mq_submit_bio+0x104/0x728
> >> [ 3987.096145]  __submit_bio+0xa0/0x23c
> >> [ 3987.096159]  submit_bio_noacct_nocheck+0x164/0x330
> >> [ 3987.096173]  submit_bio_noacct+0x348/0x468
> >> [ 3987.096186]  submit_bio+0x17c/0x198
> >> [ 3987.096199]  f2fs_submit_write_bio+0x44/0xe8
> >> [ 3987.096211]  __submit_merged_bio+0x40/0x11c
> >> [ 3987.096222]  __submit_merged_write_cond+0xcc/0x1f8
> >> [ 3987.096233]  f2fs_write_data_pages+0xbb8/0xd0c
> >> [ 3987.096246]  do_writepages+0xe0/0x2f4
> >> [ 3987.096255]  __writeback_single_inode+0x44/0x4ac
> >> [ 3987.096272]  writeback_sb_inodes+0x30c/0x538
> >> [ 3987.096289]  __writeback_inodes_wb+0x9c/0xec
> >> [ 3987.096305]  wb_writeback+0x158/0x440
> >> [ 3987.096321]  wb_workfn+0x388/0x5d4
> >> [ 3987.096335]  process_scheduled_works+0x1c4/0x45c
> >> [ 3987.096346]  worker_thread+0x32c/0x3e8
> >> [ 3987.096356]  kthread+0x11c/0x1b0
> >> [ 3987.096372]  ret_from_fork+0x10/0x20
> >>
> >>   T1:                                   T2:
> >>   blk_queue_enter
> >>   blk_pm_resume_queue
> >>   pm_request_resume
> >
> > Shouldn't this be pm_runtime_resume() rather?
>
> I'm not sure about that, I'll check if pm_runtime_resume() should be
> used here instead.

Well, the code as is now schedules an async resume of the device and
then waits for it to complete.  It would be more straightforward to
resume the device synchronously IMV.

> >
> >>   __pm_runtime_resume(dev, RPM_ASYNC)
> >>   rpm_resume                            __pm_runtime_disable
> >>   dev->power.request_pending =3D true     dev->power.disable_depth++
> >>   queue_work(pm_wq, &dev->power.work)   __pm_runtime_barrier
> >>   wait_event                            cancel_work_sync(&dev->power.w=
ork)
> >>
> >> T1 queues the work item, which is then cancelled by T2 before it start=
s
> >> execution. As a result, q->dev cannot be resumed, and T1 waits here fo=
r
> >> a long time.
> >>
> >> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> >> ---
> >>   drivers/base/power/runtime.c | 3 ++-
> >>   include/linux/pm.h           | 1 +
> >>   2 files changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime=
.c
> >> index 1b11a3cd4acc..fc9bf3fb3bb7 100644
> >> --- a/drivers/base/power/runtime.c
> >> +++ b/drivers/base/power/runtime.c
> >> @@ -1533,7 +1533,8 @@ void __pm_runtime_disable(struct device *dev, bo=
ol check_resume)
> >>           * means there probably is some I/O to process and disabling =
runtime PM
> >>           * shouldn't prevent the device from processing the I/O.
> >>           */
> >> -       if (check_resume && dev->power.request_pending &&
> >> +       if ((check_resume || dev->power.force_check_resume) &&
> >> +           dev->power.request_pending &&
> >>              dev->power.request =3D=3D RPM_REQ_RESUME) {
> >>                  /*
> >>                   * Prevent suspends and idle notifications from being=
 carried
> >
> > There are only two cases in which false is passed to
> > __pm_runtime_disable(), one is in device_suspend_late() and I don't
> > think that's relevant here, and the other is in pm_runtime_remove()
> > and that's get called when the device is going away.
> >
> > So apparently, blk_pm_resume_queue() races with the device going away.
> > Is this expected to happen even?
> >
> > If so, wouldn't it be better to modify pm_runtime_remove() to pass
> > true to __pm_runtime_disable() instead of making these ad hoc changes?
> >
>
> Sorry, I didn't make it clear in my previous message.
> I can confirm that __pm_runtime_disable() is called from
> device_suspend_late(), and this issue occurs during system suspend.

Interesting because the runtime PM workqueue is frozen at this point,
so waiting for a work item in it to complete is pointless.

What the patch does is to declare that the device can be
runtime-resumed in device_suspend_late(), but this is kind of a hack
IMV as it potentially affects the device's parent etc.

If the device cannot stay in runtime suspend across the entire system
suspend transition, it should be resumed (synchronously) earlier, in
device_suspend() or in device_prepare() even.

