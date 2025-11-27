Return-Path: <linux-pm+bounces-38797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4606AC8E466
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 13:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 414E934EAC0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101A331A50;
	Thu, 27 Nov 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbyYe46k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35B331A47
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246911; cv=none; b=Hv0oaXMgGwxddHSxyS6M9OiFerwLeM/3x9v62tXbObkjrm6SHkBoScwHpyVt+q6Jgp+gCpHFv9fT1ZIZt0bJGwZYgOnq0BXwiESJdwkB0h+0dVkVeb3ty8zC44riAn2bejz6HLjPpcQGze75uVuzyEwEvpUdFOLNetQ5DVCvqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246911; c=relaxed/simple;
	bh=38o+aKnwWGkZV94H8YOkXOB3niRitKp/oTqwDbx7dFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lqhu0DWH5Dx8+K42Nt+A/IwTmE+LDXKpMVR3Cl5Dj9gEHYkgUSMgSPkLXW0IgaBq25RhYx4uJKFacYhK9fR7vz9ANIXVfD3N7Vw1LHF3HPUWLe7lPPwv7lxGgsNaF0C5dT0LVPU+5w9UQU9h6o0oPP450gRK3ZYgoKYsmfcBC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbyYe46k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF3BC19425
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 12:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764246910;
	bh=38o+aKnwWGkZV94H8YOkXOB3niRitKp/oTqwDbx7dFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KbyYe46kBhyPtoM2HmPsa4f0PvM+KoAOTYQebLW08gDAaBzOQnef9vrQZtMuYvYE+
	 pIjXnT2RXuFA4QE46WLv91PtcECaSdCRTWT0FyOzytG/vV5h2qPvyeDp78NY6Le0bW
	 +Ex9KNgDboWIVO+f6SaDsWuxpDTwYLQnhK7jKG/xFgRRM9D3ysH163I3gkuPRnhPjp
	 a9OatURZQe3s58bN+JeajD7IJtP+X6o1uV0kECH+0ukgNd9RUTNxZRn3T5ILYrN9De
	 FuHV/OZ9IJwyuX1JugaIa5J00krfSnwWN+VDrjLNI8PRaH3WmmAnUfUZvt4mLiE8hg
	 +jucCMhh+oNEQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4503ee5c160so340585b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 04:35:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUDXCw6YnLLstXpI+B/UKjVomJujfh1QG8lWwTtPWzob5iQyYLpcWWZdLxjGkgKty3HGGhsh9Gew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUC4bvCIn66Dt1DfUtr8ydXSkO7Dr4Ml8p4ccnJ5lSkbDCadWL
	rc3KT7dKX3rp1OjG+rqygdMRfcfgJbW4LLOUWw75ztHAwaonObzX3EKtWgkcP4/qEBVNrVdFuHI
	ZxRTa/OKt4K2ujlLTM3QVn5yy3TigkRc=
X-Google-Smtp-Source: AGHT+IFBvGiLcEIAKGIMrlhiK1IQZRTVc67MdrfUoKJKOxVgs8dVxej2bKtYhDbItZ3rPBk8pJuvemGWusFretHtb/8=
X-Received: by 2002:a05:6808:4fe4:b0:44f:e61d:1893 with SMTP id
 5614622812f47-45112d1413fmr10338107b6e.63.1764246909872; Thu, 27 Nov 2025
 04:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
 <4697314.LvFx2qVVIh@rafael.j.wysocki> <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
 <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com> <1e7583e8-9ae9-4641-8ec2-7c62a637c9fc@acm.org>
In-Reply-To: <1e7583e8-9ae9-4641-8ec2-7c62a637c9fc@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 13:34:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKe+2orwKP352dBe_PB1pZqMehMo8tSDv5G+cdaJ=OsQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkt9mG60jVuxI4lwBTST-Mscx9Qwj_4SrHgtFPxrI6ytLKeT-UdIWXPyrg
Message-ID: <CAJZ5v0hKe+2orwKP352dBe_PB1pZqMehMo8tSDv5G+cdaJ=OsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:47=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 11/26/25 1:30 PM, Rafael J. Wysocki wrote:
> > On Wed, Nov 26, 2025 at 10:11=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
> >>
> >> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
> >>> --- a/block/blk-core.c
> >>> +++ b/block/blk-core.c
> >>> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
> >>>                if (flags & BLK_MQ_REQ_NOWAIT)
> >>>                        return -EAGAIN;
> >>>
> >>> +             /* if necessary, resume .dev (assume success). */
> >>> +             blk_pm_resume_queue(pm, q);
> >>>                /*
> >>>                 * read pair of barrier in blk_freeze_queue_start(), w=
e need to
> >>>                 * order reading __PERCPU_REF_DEAD flag of .q_usage_co=
unter and
> >>
> >> blk_queue_enter() may be called from the suspend path so I don't think
> >> that the above change will work.
> >
> > Why would the existing code work then?
>
> The existing code works reliably on a very large number of devices.

Well, except that it doesn't work during system suspend and
hibernation when the PM workqueue is frozen.  I think that we agree
here.

This needs to be addressed because it may very well cause system
suspend to deadlock.

There are two possible ways to address it I can think of:

1. Changing blk_pm_resume_queue() and its users to carry out a
synchronous resume of q->dev instead of calling pm_request_resume()
and (effectively) waiting for the queued-up runtime resume of q->dev
to take effect.

This would be my preferred option, but at this point I'm not sure if
it's viable.

2. Stop freezing the PM workqueue before system suspend/hibernation
and adapt device_suspend_late() to that.

This should be doable, even though it is a bit risky because it may
uncover some latent bugs (the freezing of the PM workqueue has been
there forever), but it wouldn't address the problem entirely because
device_suspend_late() would still need to disable runtime PM for the
device (and for some devices it is disabled earlier), so
pm_request_resume() would just start to fail at that point and if
blk_queue_enter() were called after that point for a device supporting
runtime PM, it might deadlock.

> Maybe there is a misunderstanding? RQF_PM / BLK_MQ_REQ_PM are set for
> requests that should be processed even if the power status is changing
> (RPM_SUSPENDING or RPM_RESUMING). The meaning of the 'pm' variable is
> as follows: process this request even if a power state change is
> ongoing.

I see.

The behavior depends on whether or not q->pm_only is set.  If it is
not set, both blk_queue_enter() and __bio_queue_enter() will allow the
request to be processed.

If q->pm_only is set, __bio_queue_enter() will wait until it gets
cleared and in that case pm_request_resume(q->dev) is called to make
that happen (did I get it right?).  This is a bit fragile because what
if the async resume of q->dev fails for some reason?  You deadlock
instead of failing the request.

Unlike __bio_queue_enter(), blk_queue_enter() additionally checks the
runtime PM status of the queue if q->pm_only is set and it will allow
the request to be processed in that case so long as q->rpm_status is
not RPM_SUSPENDED.  However, if the queue status is RPM_SUSPENDED,
pm_request_resume(q->dev) will be called like in the
__bio_queue_enter() case.

I'm not sure why pm_request_resume(q->dev) needs to be called from
within blk_pm_resume_queue().  Arguably, it should be sufficient to
call it once before using the wait_event() macro, if the conditions
checked by blk_pm_resume_queue() are not met.

> > Are you suggesting that q->rpm_status should still be checked before
> > calling pm_runtime_resume() or do you mean something else?
> The purpose of the code changes from a previous email is not entirely
> clear to me so I'm not sure what the code should look like. But to
> answer your question, calling blk_pm_resume_queue() if the runtime
> status is RPM_SUSPENDED should be safe.
> >> As an example, the UFS driver submits a
> >> SCSI START STOP UNIT command from its runtime suspend callback. The ca=
ll
> >> chain is as follows:
> >>
> >>     ufshcd_wl_runtime_suspend()
> >>       __ufshcd_wl_suspend()
> >>         ufshcd_set_dev_pwr_mode()
> >>           ufshcd_execute_start_stop()
> >>             scsi_execute_cmd()
> >>               scsi_alloc_request()
> >>                 blk_queue_enter()
> >>               blk_execute_rq()
> >>               blk_mq_free_request()
> >>                 blk_queue_exit()
> >
> > In any case, calling pm_request_resume() from blk_pm_resume_queue() in
> > the !pm case is a mistake.
>   Hmm ... we may disagree about this. Does what I wrote above make clear
> why blk_pm_resume_queue() is called if pm =3D=3D false?

Yes, it does, thanks!

