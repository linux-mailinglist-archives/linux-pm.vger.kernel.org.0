Return-Path: <linux-pm+bounces-38999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7705C98C1C
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 19:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFC33A41DE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C4F219E8C;
	Mon,  1 Dec 2025 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqdu7SH8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2C36D513
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614884; cv=none; b=gU9JWy1YUXCVhRmGK8oYYos7IGIEvT1H95cD58KIEgtaU4niA/4uFPOYfNowEAMw4hpanoT4PkCyailerA0yRf2eNe1GG6Elk06rh+bSyTAX2i95ofNUZxK90MPFvGGjbOVcgEBycbI54Wk0o6wB/bDXRaE3oUkWuucPvp3D2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614884; c=relaxed/simple;
	bh=GtekXgyVkRQVKiX9FU5xuoL0HS0SWD27fHOlSLcAkEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmcqehcJN3jrXuPxNFAqGkGuUPEzzLeWGIKFWDBHAHFc1SqBMJv8V0c26VuTwG/k7jSJPLuvT5egAGOtA8duZXi7a1PdQHCeM3NF9la1tUIQU/RWCT3kK83B4ooNlfl9Qqb0GTigiBl/fsg2WF261xQ4DsWv68+AP9IYVElZ6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqdu7SH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69E9C116C6
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764614883;
	bh=GtekXgyVkRQVKiX9FU5xuoL0HS0SWD27fHOlSLcAkEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qqdu7SH8rUSj4g/qmjClVnouYz+a6qcVRAd+sk1TRGHAfUt7x0BhkCHCqvNrnKzUf
	 JmDm0m8ccom+h56ePoeBYGyWwyxTNgVZpWH0iz7m9BZpR+DY1wZ8zcOZJS0+XqWS+o
	 P3lqlapYXemEu9521xie2QSAt290fZoGJfw1nt7G0CR3teA+hdkH50jNMuM32G3rP5
	 74HxyNj0hsAiXIv5hA0clCydwjrpLbpWdc2f1VVmncrtAuCeLHMWKtnphWOHsqeqzK
	 evlFdCB68TEtfBKnKwwd7vdUsAF51jrrJTJB07fMbfVQnR00n7GwM4aT1bMYXdcgGw
	 uBIeG0GpG7RTg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-659400dab14so1280298eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 10:48:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5hvXgrt2yMnVBMtzc1DzMHDfJazl8tnrFx5N1bC3jqkoEfYaTNHlwxg589auW01kuSG0BxsbMzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1PCNqamxW5AwVCFQTiD+heAeOrLsF7C+UPxRdjuU6Fi3rn3A
	DEkf6jT2LkgadHLOCY/YpVtCliccqsimN8H5GqQWgKzWB4lShWRZUyA3/wQbgvt1KZYfcazV3gN
	gXe8GUuMYHHep/v0+LxePrmlKfGw/Ceo=
X-Google-Smtp-Source: AGHT+IEjsUP3OIzWihX4NOSIXGAlH2GB/zYHuCbY1sv9E891L0zukEHk5CutVBekJjoRaG2DS/+VfnXsHpTtYQDCc84=
X-Received: by 2002:a05:6820:f004:b0:654:faee:1065 with SMTP id
 006d021491bc7-657bdcc0443mr8588538eaf.5.1764614883066; Mon, 01 Dec 2025
 10:48:03 -0800 (PST)
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
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
In-Reply-To: <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Dec 2025 19:47:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
X-Gm-Features: AWmQ_bkUuLnF5SqCNy4SMPMHpT5QEYxSpSqRfK7vrlKhFJV4OUqVt2G5AFWh_I8
Message-ID: <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
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

On Mon, Dec 1, 2025 at 10:46=E2=80=AFAM YangYang <yang.yang@vivo.com> wrote=
:
>
> On 2025/11/27 20:34, Rafael J. Wysocki wrote:
> > On Wed, Nov 26, 2025 at 11:47=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
> >>
> >> On 11/26/25 1:30 PM, Rafael J. Wysocki wrote:
> >>> On Wed, Nov 26, 2025 at 10:11=E2=80=AFPM Bart Van Assche <bvanassche@=
acm.org> wrote:
> >>>>
> >>>> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
> >>>>> --- a/block/blk-core.c
> >>>>> +++ b/block/blk-core.c
> >>>>> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
> >>>>>                 if (flags & BLK_MQ_REQ_NOWAIT)
> >>>>>                         return -EAGAIN;
> >>>>>
> >>>>> +             /* if necessary, resume .dev (assume success). */
> >>>>> +             blk_pm_resume_queue(pm, q);
> >>>>>                 /*
> >>>>>                  * read pair of barrier in blk_freeze_queue_start()=
, we need to
> >>>>>                  * order reading __PERCPU_REF_DEAD flag of .q_usage=
_counter and
> >>>>
> >>>> blk_queue_enter() may be called from the suspend path so I don't thi=
nk
> >>>> that the above change will work.
> >>>
> >>> Why would the existing code work then?
> >>
> >> The existing code works reliably on a very large number of devices.
> >
> > Well, except that it doesn't work during system suspend and
> > hibernation when the PM workqueue is frozen.  I think that we agree
> > here.
> >
> > This needs to be addressed because it may very well cause system
> > suspend to deadlock.
> >
> > There are two possible ways to address it I can think of:
> >
> > 1. Changing blk_pm_resume_queue() and its users to carry out a
> > synchronous resume of q->dev instead of calling pm_request_resume()
> > and (effectively) waiting for the queued-up runtime resume of q->dev
> > to take effect.
> >
> > This would be my preferred option, but at this point I'm not sure if
> > it's viable.
> >
>
> After __pm_runtime_disable() is called from device_suspend_late(),
> dev->power.disable_depth is set, preventing rpm_resume() from making
> progress until the system resume completes, regardless of whether
> rpm_resume() is invoked synchronously or asynchronously.

This isn't factually correct.  rpm_resume() will make progress when
runtime PM is disabled, but it will not resume the target device.
That's what disabling runtime PM means.

Of course, when runtime PM is disabled for the given device,
rpm_resume() will return an error code that can be checked.  However,
if pm_request_resume() is called before disabling runtime PM for the
device and runtime PM is disabled for it before the work item queued
by pm_request_resume() runs, the failure will be silent from the
caller's perspective.

> Performing a synchronous resume of q->dev seems to have a similar
> effect to removing the following code block from
> __pm_runtime_barrier(), which is invoked by __pm_runtime_disable():
>
> 1428     if (dev->power.request_pending) {
> 1429         dev->power.request =3D RPM_REQ_NONE;
> 1430         spin_unlock_irq(&dev->power.lock);
> 1431
> 1432         cancel_work_sync(&dev->power.work);
> 1433
> 1434         spin_lock_irq(&dev->power.lock);
> 1435         dev->power.request_pending =3D false;
> 1436     }

It is different.

First of all, synchronous runtime resume is not affected by the
freezing of the runtime PM workqueue.  Next, see the remark above
regarding returning an error code.  Finally, so long as
__pm_runtime_resume() acquires power.lock before
__pm_runtime_disable(), the synchronous resume will be waited for by
the latter.

Generally speaking, if blk_queue_enter() or __bio_queue_enter() may
run in parallel with device_suspend_late() for q->dev, the driver of
that device is defective, because it is responsible for preventing
this situation from happening.  The most straightforward way to
achieve that is to provide a .suspend() callback for q->dev that will
runtime-resume it (and, of course, q->dev will need to be prepared for
system suspend as appropriate after that).

If blk_queue_enter() or __bio_queue_enter() is allowed to race with
disabling runtime PM for q->dev, failure to resume q->dev is alway
possible and there are no changes that can be made to
pm_runtime_disable() to prevent that from happening.  If
__pm_runtime_disable() wins the race, it will increment
power.disable_depth and rpm_resume() will bail out when it sees that
no matter what.

You should not conflate "runtime PM doesn't work when it is disabled"
with "asynchronous runtime PM doesn't work after freezing the PM
workqueue".  They are both true, but they are not the same.

