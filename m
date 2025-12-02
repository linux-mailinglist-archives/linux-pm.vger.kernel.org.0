Return-Path: <linux-pm+bounces-39067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41894C9B731
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 13:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A381334807C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9A311979;
	Tue,  2 Dec 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhqRk4Tk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F533101CE
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677904; cv=none; b=Oeye5qUIMEREGSkjp87mutgDw4ricmYnjhNBjMIqL3dlYLWxFc4YOzW95TJSWEHRNfoQHBMp9IZuVgpVGNTYcaEiy/CGtK6HDcyMtYfb2B9mygsHjMf8S0qdpEvGapeQr9Vtl27ntoZJyyYYYLUg8K0PZlV3vmuKYjSjRVLitcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677904; c=relaxed/simple;
	bh=I6pUC5LRsxm6s8xiwuG+GdGv8TLKQFJgFi+OVUIreRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSy4YneJisRQvkhaq5ehwlq3E+hHdlpHvGr81GBnFvWKN13KHn0B4t6YS4u+L5rT7rjfgyRkVEQPOSWVg/YItZ37qAN/aUrse6HcaoGVv7FNF26m3K2QEyDVrLF5rELSALcObvetC4aloxbDkSyxHOQnPIx5qNEC4X0ZhBjO0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhqRk4Tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDD5C4AF0B
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764677904;
	bh=I6pUC5LRsxm6s8xiwuG+GdGv8TLKQFJgFi+OVUIreRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QhqRk4TkyeKiU78h3JvWxRbOHf9aJatbCL8ex6WRjXDmsxOeWzoD/1FsyGmn4HkNs
	 emzBxGcjVbavJRQb5GfvTEQ9Cp7MTUGDnHS4Fv+tCcB8L1EkoN7VlIJKuGHg1fU3G6
	 lF/8jeSSj9Uhog4Qqsd/oSnTL7Koufp+PMkgyn4TDPVXuZpsG5RRne+mvjBLLvBHaP
	 XdyzaHNCmKda8C1aqSr+lg5VpOJ6AodRJ7vtqPd93kSve8PSWFz+9/oPe9QFZEs3t1
	 tfzkwYBFG8KVUJtSo91u7VA5jh3fpcENpUSgQ40Plqp1qJfPJ1EyyiefarLOXAeKMh
	 nLu3eiez9wHtA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-657464a9010so1025300eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 04:18:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZHyaoo1VqST5bbOgf397og9/oE4vWW3VBEAi8Ac1eQWD5TWBY0HScMeeeGClsXvR8fGoh2HbEuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiMclV3TrEOXgjnBVbPxppPV81uX+WvPFkiEHI7+EMYeoeBS6M
	OJSLkZNNtZefoW9lcrmwGB7Oi24E8CM6xYWSKyGuv5v3Kytstp+uSh6Z1KGl44P4i9qOiQFlD1t
	loA3i/6tQ+7dhM9ggF9h9M2d7JKRhrL8=
X-Google-Smtp-Source: AGHT+IFqoYIxo7iNoQ3w8zoWp/wQ8YvazCz/vk9wXT8quYJQ5HY65pQpjBffJq2sJ2dUVgYMXzwbXDKQCJZ9cvPtvzg=
X-Received: by 2002:a05:6820:81d4:b0:657:6678:1b48 with SMTP id
 006d021491bc7-65790b69644mr15295208eaf.3.1764677903426; Tue, 02 Dec 2025
 04:18:23 -0800 (PST)
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
 <CAJZ5v0i+BhxX54wyogVR4_fmTJHVFfozNrP5LN4pGDPnnL=EDQ@mail.gmail.com> <5bef0b09-710b-40a7-bdbc-7428301aee7a@vivo.com>
In-Reply-To: <5bef0b09-710b-40a7-bdbc-7428301aee7a@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Dec 2025 13:18:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=GCLggsj_BGQbZzjDj3+JdKn7UfSMcjyZipteqiAG6A@mail.gmail.com>
X-Gm-Features: AWmQ_bnqDXpbNbHaHeBror23H-nJOZjcJxiVWmgC13VBd1UIrS_Swy4GZKDAcaw
Message-ID: <CAJZ5v0h=GCLggsj_BGQbZzjDj3+JdKn7UfSMcjyZipteqiAG6A@mail.gmail.com>
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

On Tue, Dec 2, 2025 at 11:33=E2=80=AFAM YangYang <yang.yang@vivo.com> wrote=
:
>
> On 2025/12/2 2:55, Rafael J. Wysocki wrote:
> > On Mon, Dec 1, 2025 at 1:56=E2=80=AFPM YangYang <yang.yang@vivo.com> wr=
ote:
> >>
> >> On 2025/12/1 17:46, YangYang wrote:
> >>> On 2025/11/27 20:34, Rafael J. Wysocki wrote:
> >>>> On Wed, Nov 26, 2025 at 11:47=E2=80=AFPM Bart Van Assche <bvanassche=
@acm.org> wrote:
> >>>>>
> >>>>> On 11/26/25 1:30 PM, Rafael J. Wysocki wrote:
> >>>>>> On Wed, Nov 26, 2025 at 10:11=E2=80=AFPM Bart Van Assche <bvanassc=
he@acm.org> wrote:
> >>>>>>>
> >>>>>>> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
> >>>>>>>> --- a/block/blk-core.c
> >>>>>>>> +++ b/block/blk-core.c
> >>>>>>>> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
> >>>>>>>>                  if (flags & BLK_MQ_REQ_NOWAIT)
> >>>>>>>>                          return -EAGAIN;
> >>>>>>>>
> >>>>>>>> +             /* if necessary, resume .dev (assume success). */
> >>>>>>>> +             blk_pm_resume_queue(pm, q);
> >>>>>>>>                  /*
> >>>>>>>>                   * read pair of barrier in blk_freeze_queue_sta=
rt(), we need to
> >>>>>>>>                   * order reading __PERCPU_REF_DEAD flag of .q_u=
sage_counter and
> >>>>>>>
> >>>>>>> blk_queue_enter() may be called from the suspend path so I don't =
think
> >>>>>>> that the above change will work.
> >>>>>>
> >>>>>> Why would the existing code work then?
> >>>>>
> >>>>> The existing code works reliably on a very large number of devices.
> >>>>
> >>>> Well, except that it doesn't work during system suspend and
> >>>> hibernation when the PM workqueue is frozen.  I think that we agree
> >>>> here.
> >>>>
> >>>> This needs to be addressed because it may very well cause system
> >>>> suspend to deadlock.
> >>>>
> >>>> There are two possible ways to address it I can think of:
> >>>>
> >>>> 1. Changing blk_pm_resume_queue() and its users to carry out a
> >>>> synchronous resume of q->dev instead of calling pm_request_resume()
> >>>> and (effectively) waiting for the queued-up runtime resume of q->dev
> >>>> to take effect.
> >>>>
> >>>> This would be my preferred option, but at this point I'm not sure if
> >>>> it's viable.
> >>>>
> >>>
> >>> After __pm_runtime_disable() is called from device_suspend_late(), de=
v->power.disable_depth is set, preventing
> >>> rpm_resume() from making progress until the system resume completes, =
regardless of whether rpm_resume() is invoked
> >>> synchronously or asynchronously.
> >>> Performing a synchronous resume of q->dev seems to have a similar eff=
ect to removing the following code block from
> >>> __pm_runtime_barrier(), which is invoked by __pm_runtime_disable():
> >>>
> >>> 1428     if (dev->power.request_pending) {
> >>> 1429         dev->power.request =3D RPM_REQ_NONE;
> >>> 1430         spin_unlock_irq(&dev->power.lock);
> >>> 1431
> >>> 1432         cancel_work_sync(&dev->power.work);
> >>> 1433
> >>> 1434         spin_lock_irq(&dev->power.lock);
> >>> 1435         dev->power.request_pending =3D false;
> >>> 1436     }
> >>>
> >>
> >> Since both synchronous and asynchronous resumes face similar issues,
> >
> > No, they don't.
> >
> >> it may be sufficient to keep using the asynchronous resume path as lon=
g as
> >> pending work items are not canceled while the PM workqueue is frozen.
> >
> > Except for two things:
> >
> > 1. If blk_queue_enter() or __bio_queue_enter() is allowed to race with
> > disabling runtime PM, queuing up the resume work item may fail in the
> > first place.
> >
>
> Perhaps my understanding is incorrect, but during the execution of
> device_suspend_late(), the PM workqueue should already be frozen.
> In that case, queuing a resume work item would not fail; it would
> simply not be executed until the workqueue is unfrozen, as long as
> it is not canceled.

rpm_resume() returns an error if runtime PM is disabled for the given
device and the device status is RPM_SUSPENDED even if it is called
with RPM_ASYNC or RPM_NOWAIT in the flags.

