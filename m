Return-Path: <linux-pm+bounces-39000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E6C98C7F
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24B264E1F21
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E2D22D7B6;
	Mon,  1 Dec 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTaJJnjQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48925227E95
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615344; cv=none; b=dRerV5hiHKY8ihW31BeThRUvSQCQcWytKfhalqpapAF7llwRIZ+I2IwpvvuVraaluAkuqfKxvJakUxMvc5G47KPaSDMvOzXupVkbMxKebPnYqAYi0oCc6e2+PAPjausjSrTjSwh08UQ0EWMOQR7UD9Xof7QddXga4kRtqcQ3tTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615344; c=relaxed/simple;
	bh=BJ2QAtb/JngB4ZVpKmkoLTPpIpJvhEqR8k+Jbd4rlQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqrIWoeA+eXedPTLn1T3j/nH3yM7aPLESXzVRo8k2FQ2HeA293hIzptLMgbsj9xUUumCds/2InNTHp4fnmXHMwuyaOs/xY8nMztMmu0MVdHG9SoxDSepnX4O01eXBfPEayDnBOG8H20lc0K9J6L9TwvStx17lt4dijQbfbEHAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTaJJnjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6FFC116C6
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764615344;
	bh=BJ2QAtb/JngB4ZVpKmkoLTPpIpJvhEqR8k+Jbd4rlQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BTaJJnjQ5qlFKV8oUxGJMAGCK7uQdE2BlnVKzBYwTk4sUdMB4ZUpc88AaHzVSgGaC
	 KcHkoaVQHMR4uVuWojmZWZpAlJ/HAOqioVVrbFqwfBzH1I0Wtf+4VG+PqCFjyDfEaj
	 e3969POd9TKHd1iBbILy0Jo1ag6cQNOCGKH1MYI0s/Mf4Q4KhOkT+dnA0C5VkEVzs9
	 H8t/7fOYG2zmUwcNLU5FXGim3RiwLK9Mj7bbNSgLEPS7vSDbw1mvKrPSgVfGsVmJXp
	 weaI7cSHlNpDRYEtCJ7rUy+LXipNxoZy1l4bpXYkBBrwCCyPy+qdcK5e1OU6LGz2CJ
	 n7nvpnNn8TmLw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce892b7dso2241816fac.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 10:55:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9aHkXRAyCOT6NgvluLV0j5DpSaHXl2BpJuCX4h8aCIBdd9rXxL7CKybHW4y7D1R4Wy7WMbtmrDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIiBzI3AtczrZBYmOUg9po6PaxNGcnQB2oDvbriMvVML9o7pC
	rzA0MzrJ2WzY7HBlVQrHMdaQbwJQK4vgyna6qYjus6JFqiD4yOlxqwssMUmZN8chG8Wj/U9PlWX
	gqE2xdNnjVkIjfV4siMXTHSXCv8VZ2Kc=
X-Google-Smtp-Source: AGHT+IEaUC/6POahoQxGNijkuOF2uREv010/iuql4oUBg5ecE+gke9+TivoRfWOgpkOivd6EkfciT1qA1PsN2Rb6Efg=
X-Received: by 2002:a05:6808:1891:b0:44f:e61d:189f with SMTP id
 5614622812f47-45115865582mr15784991b6e.13.1764615343277; Mon, 01 Dec 2025
 10:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
 <4697314.LvFx2qVVIh@rafael.j.wysocki> <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
 <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
 <1e7583e8-9ae9-4641-8ec2-7c62a637c9fc@acm.org> <CAJZ5v0hKe+2orwKP352dBe_PB1pZqMehMo8tSDv5G+cdaJ=OsQ@mail.gmail.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com> <8fa4023f-50f2-4e25-9f9b-4e5236015e27@vivo.com>
In-Reply-To: <8fa4023f-50f2-4e25-9f9b-4e5236015e27@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Dec 2025 19:55:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i+BhxX54wyogVR4_fmTJHVFfozNrP5LN4pGDPnnL=EDQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmnSQKJ36X5vY0ihxlgWqyQr-ftkYt6rNfH4EJ2Nj6tgHt7-ETI4VPKYjk
Message-ID: <CAJZ5v0i+BhxX54wyogVR4_fmTJHVFfozNrP5LN4pGDPnnL=EDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: YangYang <yang.yang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 1:56=E2=80=AFPM YangYang <yang.yang@vivo.com> wrote:
>
> On 2025/12/1 17:46, YangYang wrote:
> > On 2025/11/27 20:34, Rafael J. Wysocki wrote:
> >> On Wed, Nov 26, 2025 at 11:47=E2=80=AFPM Bart Van Assche <bvanassche@a=
cm.org> wrote:
> >>>
> >>> On 11/26/25 1:30 PM, Rafael J. Wysocki wrote:
> >>>> On Wed, Nov 26, 2025 at 10:11=E2=80=AFPM Bart Van Assche <bvanassche=
@acm.org> wrote:
> >>>>>
> >>>>> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
> >>>>>> --- a/block/blk-core.c
> >>>>>> +++ b/block/blk-core.c
> >>>>>> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
> >>>>>>                 if (flags & BLK_MQ_REQ_NOWAIT)
> >>>>>>                         return -EAGAIN;
> >>>>>>
> >>>>>> +             /* if necessary, resume .dev (assume success). */
> >>>>>> +             blk_pm_resume_queue(pm, q);
> >>>>>>                 /*
> >>>>>>                  * read pair of barrier in blk_freeze_queue_start(=
), we need to
> >>>>>>                  * order reading __PERCPU_REF_DEAD flag of .q_usag=
e_counter and
> >>>>>
> >>>>> blk_queue_enter() may be called from the suspend path so I don't th=
ink
> >>>>> that the above change will work.
> >>>>
> >>>> Why would the existing code work then?
> >>>
> >>> The existing code works reliably on a very large number of devices.
> >>
> >> Well, except that it doesn't work during system suspend and
> >> hibernation when the PM workqueue is frozen.  I think that we agree
> >> here.
> >>
> >> This needs to be addressed because it may very well cause system
> >> suspend to deadlock.
> >>
> >> There are two possible ways to address it I can think of:
> >>
> >> 1. Changing blk_pm_resume_queue() and its users to carry out a
> >> synchronous resume of q->dev instead of calling pm_request_resume()
> >> and (effectively) waiting for the queued-up runtime resume of q->dev
> >> to take effect.
> >>
> >> This would be my preferred option, but at this point I'm not sure if
> >> it's viable.
> >>
> >
> > After __pm_runtime_disable() is called from device_suspend_late(), dev-=
>power.disable_depth is set, preventing
> > rpm_resume() from making progress until the system resume completes, re=
gardless of whether rpm_resume() is invoked
> > synchronously or asynchronously.
> > Performing a synchronous resume of q->dev seems to have a similar effec=
t to removing the following code block from
> > __pm_runtime_barrier(), which is invoked by __pm_runtime_disable():
> >
> > 1428     if (dev->power.request_pending) {
> > 1429         dev->power.request =3D RPM_REQ_NONE;
> > 1430         spin_unlock_irq(&dev->power.lock);
> > 1431
> > 1432         cancel_work_sync(&dev->power.work);
> > 1433
> > 1434         spin_lock_irq(&dev->power.lock);
> > 1435         dev->power.request_pending =3D false;
> > 1436     }
> >
>
> Since both synchronous and asynchronous resumes face similar issues,

No, they don't.

> it may be sufficient to keep using the asynchronous resume path as long a=
s
> pending work items are not canceled while the PM workqueue is frozen.

Except for two things:

1. If blk_queue_enter() or __bio_queue_enter() is allowed to race with
disabling runtime PM, queuing up the resume work item may fail in the
first place.

2. If a device runtime resume work item is queued up before the whole
system is suspended, it may not make sense to run that work item after
resuming the whole system because the state of the system as a whole
is generally different at that point.

> This allows the pending work to proceed normally once the PM workqueue
> is unfrozen.

Not really.

