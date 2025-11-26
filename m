Return-Path: <linux-pm+bounces-38694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A2C8986E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 12:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BD7A342F09
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF6322C7F;
	Wed, 26 Nov 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHRFsgzo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE345322C66
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156641; cv=none; b=H0VbUzGTDD4F/Y0aB3kx3WEtkqTJFI0Cl2EtDTr1JZk0P6P/1jnUxttFYZ2ACwy6U50L5qt0ijr6Je7/9lIZG6z3eQUEDu0Uaj3T2vxXGsb5T7bQvZMQtv7HDrtUC+J5dc7WYuoeSBGjYLgWISKgDu0s0hMhzU+Yuut4fnQDIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156641; c=relaxed/simple;
	bh=YlHXYC6LfJ/ry7GrBuAN0glshz1B+/T6723f0KetEBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2v85bLomGt5JwCFquIHrEpbDK8P2OcGS1tk4TQwMKT1MkzwY0DaeGY2m3FlbFF+XhJRPsKZs3fBo8JBWLMhlDBFI9aEstmvt/nVfBs1mpqmGLCkds1dX0fstxps/pEK/Bj7BI7Moir2IGGaOziHmz8EntMQttOj6ru6rpPDxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHRFsgzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD99C19425
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764156640;
	bh=YlHXYC6LfJ/ry7GrBuAN0glshz1B+/T6723f0KetEBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vHRFsgzo2kulXWnuwVDhQ4nMYkVVrYsaVkiLwujyVk5Frle2fKp9Psd/DanLUJR0q
	 yeeCdQDhzslxTM9QaHO8gjzdPEiYKejAjDYY8xrgOIPlaFVDnsQSZfs2l5z/LEx0Q5
	 oWE0a8Fbn1V18066KHJOwaJT9pgMTGzAkoHsGJsXm9Yc8gIv+lkvGobqQLxdEKc59D
	 rO1aQy8zDdwmTCFsGAU4Jw9D+0zjZLKO4LD0jH+hIw5NF/AqlNEz5UGdL6hV4YEevD
	 MU1Fhzqeuvp4tjERsbVnPbVyFCJfYhQL/VRIF6E2FCUA90UvU0h/gtOzUBWxYxnMX2
	 wRK+HzDy38YiQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-450f7f91845so1114686b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 03:30:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXo+8YR0hVanRlow8AlXQQAjRNPGZFv8Y8u76eYRbf4NMgR/Sj372Zpggn49WW+nETimCM/142e8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhC+hVSxNFIo3DhrobEHpfpqGXYTmicBpxJaM+A4S5Z8/O3w3K
	MLE5WlqVKStsdBdca2CEtenCG3+301i0z1plLbOohIV6YywHyEmyabLJsnB9W+D6FUKq3yU6sQg
	4zPQGeTBcsRGR/5mPZqXdZmnMYIWJA64=
X-Google-Smtp-Source: AGHT+IEF1TZKMUnsR9oNvymAECHY//8wFXOR3I1Sl7VA/ljiIXWBpHVIUvkOiBPq2J11Cpsg/LyZ9Gorn+CByUZ0Ht8=
X-Received: by 2002:a05:6808:2223:b0:450:d5cf:2f49 with SMTP id
 5614622812f47-4511585e787mr7796823b6e.17.1764156639811; Wed, 26 Nov 2025
 03:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <20251126101636.205505-2-yang.yang@vivo.com>
In-Reply-To: <20251126101636.205505-2-yang.yang@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 12:30:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
X-Gm-Features: AWmQ_blIypH8FZGJ5t5wdWLfBeMA5iXhZrD2pRpYMNCq-N4-fkTvsGfZYLj3cyk
Message-ID: <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:17=E2=80=AFAM Yang Yang <yang.yang@vivo.com> wro=
te:
>
> We observed the following hung task during our test:
>
> [ 3987.095999] INFO: task "kworker/u32:7":239 blocked for more than 188 s=
econds.
> [ 3987.096017] task:kworker/u32:7   state:D stack:0     pid:239   tgid:23=
9   ppid:2      flags:0x00000408
> [ 3987.096042] Workqueue: writeback wb_workfn (flush-254:59)
> [ 3987.096069] Call trace:
> [ 3987.096073]  __switch_to+0x1a0/0x318
> [ 3987.096089]  __schedule+0xa38/0xf9c
> [ 3987.096104]  schedule+0x74/0x10c
> [ 3987.096118]  __bio_queue_enter+0xb8/0x178
> [ 3987.096132]  blk_mq_submit_bio+0x104/0x728
> [ 3987.096145]  __submit_bio+0xa0/0x23c
> [ 3987.096159]  submit_bio_noacct_nocheck+0x164/0x330
> [ 3987.096173]  submit_bio_noacct+0x348/0x468
> [ 3987.096186]  submit_bio+0x17c/0x198
> [ 3987.096199]  f2fs_submit_write_bio+0x44/0xe8
> [ 3987.096211]  __submit_merged_bio+0x40/0x11c
> [ 3987.096222]  __submit_merged_write_cond+0xcc/0x1f8
> [ 3987.096233]  f2fs_write_data_pages+0xbb8/0xd0c
> [ 3987.096246]  do_writepages+0xe0/0x2f4
> [ 3987.096255]  __writeback_single_inode+0x44/0x4ac
> [ 3987.096272]  writeback_sb_inodes+0x30c/0x538
> [ 3987.096289]  __writeback_inodes_wb+0x9c/0xec
> [ 3987.096305]  wb_writeback+0x158/0x440
> [ 3987.096321]  wb_workfn+0x388/0x5d4
> [ 3987.096335]  process_scheduled_works+0x1c4/0x45c
> [ 3987.096346]  worker_thread+0x32c/0x3e8
> [ 3987.096356]  kthread+0x11c/0x1b0
> [ 3987.096372]  ret_from_fork+0x10/0x20
>
>  T1:                                   T2:
>  blk_queue_enter
>  blk_pm_resume_queue
>  pm_request_resume

Shouldn't this be pm_runtime_resume() rather?

>  __pm_runtime_resume(dev, RPM_ASYNC)
>  rpm_resume                            __pm_runtime_disable
>  dev->power.request_pending =3D true     dev->power.disable_depth++
>  queue_work(pm_wq, &dev->power.work)   __pm_runtime_barrier
>  wait_event                            cancel_work_sync(&dev->power.work)
>
> T1 queues the work item, which is then cancelled by T2 before it starts
> execution. As a result, q->dev cannot be resumed, and T1 waits here for
> a long time.
>
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>  drivers/base/power/runtime.c | 3 ++-
>  include/linux/pm.h           | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 1b11a3cd4acc..fc9bf3fb3bb7 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1533,7 +1533,8 @@ void __pm_runtime_disable(struct device *dev, bool =
check_resume)
>          * means there probably is some I/O to process and disabling runt=
ime PM
>          * shouldn't prevent the device from processing the I/O.
>          */
> -       if (check_resume && dev->power.request_pending &&
> +       if ((check_resume || dev->power.force_check_resume) &&
> +           dev->power.request_pending &&
>             dev->power.request =3D=3D RPM_REQ_RESUME) {
>                 /*
>                  * Prevent suspends and idle notifications from being car=
ried

There are only two cases in which false is passed to
__pm_runtime_disable(), one is in device_suspend_late() and I don't
think that's relevant here, and the other is in pm_runtime_remove()
and that's get called when the device is going away.

So apparently, blk_pm_resume_queue() races with the device going away.
Is this expected to happen even?

If so, wouldn't it be better to modify pm_runtime_remove() to pass
true to __pm_runtime_disable() instead of making these ad hoc changes?

> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index cc7b2dc28574..4eb20569cdbc 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -708,6 +708,7 @@ struct dev_pm_info {
>         bool                    use_autosuspend:1;
>         bool                    timer_autosuspends:1;
>         bool                    memalloc_noio:1;
> +       bool                    force_check_resume:1;
>         unsigned int            links_count;
>         enum rpm_request        request;
>         enum rpm_status         runtime_status;
> --

