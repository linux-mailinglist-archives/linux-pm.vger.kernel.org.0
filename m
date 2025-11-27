Return-Path: <linux-pm+bounces-38798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0EC8E4CC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 13:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 321023509FE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC143328E2;
	Thu, 27 Nov 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky0EFEpR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0F330327
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247503; cv=none; b=dEI7g4ELIaHHgI/7j6NhJosB28mZoGiHkXf+9XSn2EixqOmPF50fyOvKkK3Po08KF8lmwoXJp3xKaeSiaQw/qmXg4JOFvGDae5hZhh8+2In4Cb76ieIVj+Dz55jzv9+LYiU4bWyQynpItvFtlPv81lRs6EKqTocn1L7MmcOAVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247503; c=relaxed/simple;
	bh=UmEyj20xRLVmt5GFDfc4qtLDXtjrThgNXN3x1vPoxPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xei8rMN/59QRpEvs/juhhSSJ6z9P9CT7+kdFQ3XW+L73WUk/yXAqFCh0oedgQ1aHiQKgjGLoBwhDEi+dwgLqpHpeqNbJhq2/xjO3ok1X+yRQk29mCs5r+vw2uE9/a3YAdHthZ6ffvq4LLgbFEjsb3ftYz/JEzqDXH3/B8c0QC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky0EFEpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D19C19424
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764247503;
	bh=UmEyj20xRLVmt5GFDfc4qtLDXtjrThgNXN3x1vPoxPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ky0EFEpRryYFqcF6l8QTObjIPB7qMKQYU3qjx/eQoPhgmUPfSOO3e/KUYbAkDHL15
	 XVvuxERfEkuUQQ5fa38OaaKooF25EKZwQ047xQKqaS1VCmvdqZkx4dWkPLU0sLmWCE
	 ettHR5zW47ZxdsiiY7di+oIFjJOs7M0Y4veznsgInBMkPo/R5hIYemIV4b0F4vle17
	 G1kqRWcrWC/tWsGH/SS93CHsCKIZqzLWumeoolW2piJTFw0AEEOpQfX/L0JSX8iwI9
	 Ubh/SxWc0s+4fEYoHLueRv5o7fMrrb8cSTAFdo6c9O365gMHBNSF84jXzyzXghmKE6
	 orbrdVk2XeGww==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4505b05e7b5so198281b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 04:45:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxpw4TF2MUcZOlFO4aN2tNhgzA1NU6nlr1VUB1yE0utSjt/SBoRD6Rz897aUattPjwSJmUBWUOgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhUyNmRgboB3AfP3ioq/MTwyM1W+jA3B8MRtNyuoYs24dIWPc
	BBxc349XhYQ65CbTDDHhp0bBF156wyHBC/juCWJrreZFAQ8mm8uRngOxXZQToeCwDZLFtxfrHbo
	Aa4Yf4h0EZmUYUz7T9lxkzS4IwRqa894=
X-Google-Smtp-Source: AGHT+IFS8zf3lTPdfoa7G34difdkbh/Xc8Cr68UupqC3MamitfngxI+RTvRlIvuHl4lOZDQLpFPYHrU0HAU0AVsinM8=
X-Received: by 2002:a05:6808:14cf:b0:450:b3a:539e with SMTP id
 5614622812f47-45112aaceb2mr7791329b6e.28.1764247502552; Thu, 27 Nov 2025
 04:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
 <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com> <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
 <9b6e7d55-6a1f-490e-98c7-3c04f85f7444@acm.org> <CAJZ5v0hJw0WdHpqgUc5bz5qCSUNNKHg7i5-sNYeZcDYwRj21qw@mail.gmail.com>
 <6df79ec0-f5b3-4d75-95b1-03e488d45e7f@acm.org> <4f4dea0a-21b1-438c-94ae-9a785ad42569@vivo.com>
In-Reply-To: <4f4dea0a-21b1-438c-94ae-9a785ad42569@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 13:44:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-Dsi=Z2cRye39PVxgw3fyNdfsZynvzo2QaYrT-nNnow@mail.gmail.com>
X-Gm-Features: AWmQ_bmXnr6-TorKSnnk9cUKPrKUNLl2X1lvYYugJWwAfabw666A0jkoIT-urhg
Message-ID: <CAJZ5v0h-Dsi=Z2cRye39PVxgw3fyNdfsZynvzo2QaYrT-nNnow@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: YangYang <yang.yang@vivo.com>
Cc: Bart Van Assche <bvanassche@acm.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 12:29=E2=80=AFPM YangYang <yang.yang@vivo.com> wrot=
e:
>
> On 2025/11/27 2:40, Bart Van Assche wrote:
> > On 11/26/25 7:41 AM, Rafael J. Wysocki wrote:
> >> As it stands, you have a basic problem with respect to system
> >> suspend/hibernation.  As I said before, the PM workqueue is frozen
> >> during system suspend/hibernation transitions, so waiting for an async
> >> resume request to complete then is pointless.
> >
> > Agreed. I noticed that any attempt to call request_firmware() from
> > driver system resume callback functions causes a deadlock if these
> > calls happen before the block device has been resumed.
> >
> > Thanks,
> >
> > Bart.
>
> Does this patch look reasonable to you? It hasn't been fully tested
> yet, but the resume is now performed synchronously.
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 66fb2071d..041d29ba4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -323,12 +323,15 @@ int blk_queue_enter(struct request_queue *q,
> blk_mq_req_flags_t flags)
>                   * reordered.
>                   */
>                  smp_rmb();
> -               wait_event(q->mq_freeze_wq,
> -                          (!q->mq_freeze_depth &&
> -                           blk_pm_resume_queue(pm, q)) ||
> -                          blk_queue_dying(q));
> +check:
> +               wait_event(q->mq_freeze_wq, !q->mq_freeze_depth);

I think that you still need to check blk_queue_dying(q) under
wait_even() or you may not stop waiting when this happens.

> +
>                  if (blk_queue_dying(q))
>                          return -ENODEV;
> +               if (!blk_pm_resume_queue(pm, q)) {
> +                       pm_runtime_resume(q->dev);
> +                       goto check;
> +               }
>          }
>
>          rwsem_acquire_read(&q->q_lockdep_map, 0, 0, _RET_IP_);
> @@ -356,12 +359,15 @@ int __bio_queue_enter(struct request_queue *q,
> struct bio *bio)
>                   * reordered.
>                   */
>                  smp_rmb();
> -               wait_event(q->mq_freeze_wq,
> -                          (!q->mq_freeze_depth &&
> -                           blk_pm_resume_queue(false, q)) ||
> -                          test_bit(GD_DEAD, &disk->state));
> +check:
> +               wait_event(q->mq_freeze_wq, !q->mq_freeze_depth);

Analogously here, you may not stop waiting when test_bit(GD_DEAD,
&disk->state) is true.

> +
>                  if (test_bit(GD_DEAD, &disk->state))
>                          goto dead;
> +               if (!blk_pm_resume_queue(false, q)) {
> +                       pm_runtime_resume(q->dev);
> +                       goto check;
> +               }
>          }
>
>          rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> diff --git a/block/blk-pm.h b/block/blk-pm.h
> index 8a5a0d4b3..c28fad105 100644
> --- a/block/blk-pm.h
> +++ b/block/blk-pm.h
> @@ -12,7 +12,6 @@ static inline int blk_pm_resume_queue(const bool pm,
> struct request_queue *q)
>                  return 1;       /* Nothing to do */
>          if (pm && q->rpm_status !=3D RPM_SUSPENDED)
>                  return 1;       /* Request allowed */
> -       pm_request_resume(q->dev);
>          return 0;
>   }

And I would rename blk_pm_resume_queue() to something like
blk_pm_queue_active() because it is a bit confusing as it stands.

Apart from the above remarks this makes sense to me FWIW.

