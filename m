Return-Path: <linux-pm+bounces-39077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE52C9BA00
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F38614E359A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC36315772;
	Tue,  2 Dec 2025 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvJ/O/iy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C530FC39
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682652; cv=none; b=KBvdIZZ5Z4rqlGIW210spZ5qypFpfvmYIWDpo/4OzSecCUxbHl+wq5IeN+bmKEZqvQXeU5FWrNz0XdKgRH0VT01GGp5XDeLxYOJ+9gzhotOP9Bz+iCiDIUM2NKfYZ0VfLhceah2lRF3v1UwskaIkF83HNeWlwhkYBu9vpz1mwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682652; c=relaxed/simple;
	bh=+JM7juOdkDR9m3PEB8eMvh/J6NNMXy7yEZtuYo1Vkh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teMMaz/w0PMFEFWYqLrZSYHOo7Fr8A3feMRhNDj9SvO+Tph9mv/iflpSQLpSFkR0M3D6M3RIx1jt12lJLZYndbLuZLRn/qPRuTQ3FwHOVx2GCHSq1HCOXo60AwiG3j8iyLN6SJWdKUtup1pbBbScUwSHuc46bh9gItg/bCnRgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvJ/O/iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87279C16AAE
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764682651;
	bh=+JM7juOdkDR9m3PEB8eMvh/J6NNMXy7yEZtuYo1Vkh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tvJ/O/iyDS9Lw0hj5nlvYUOGZtk8897R0W58SfRYVM9fE6y0PuF9RZJIQttQNFN++
	 B5VJzYTHw2P95yUlfKT5DOVC7/YaYEMmSzCx25KohPShsvsVhYwNrj+xo+nLczOQv4
	 CAHMDMKYIswl6ZjhK7zwQHtgReppumZjZo9aj+lFuIKnOigYKpTN99cNXblp+AmHZg
	 Z2j87PseAza9zU3ohTbAS0Fu/u8vjRR+XiNBuUACaUhCsk/VALu1ZTnnYOQwMYjxAJ
	 DI/MZM2R42IE+82nP8QC6L4O0vpK92RmeMD/4iaOziATYW2GK2VPYbcD6Ey9CXRC/9
	 B8G4aMTPMK1dw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-656d9230ceaso1017179eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 05:37:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKuY9uwYeWj4iB3GeyRgLAORSXjbxmLSqHZmG5YLGNnSAhSYBAbX3Kl/qf76hTkjGuNDOYLI2Z1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdLjzbVIYlPWILAmH/Ge7S3XdDu0X+bkVztne/Wu2FwEO22kq
	NjeM12fNzZMlydAR9FvZWAZxQ7u70Q/QMj6mYyz1FCmKBK4BXhFRYIe9z8a3C8qa8vEP5qCglPE
	Nl18rMa60OIQWTqYvFfL8nvTl7KzpS50=
X-Google-Smtp-Source: AGHT+IGBxwBb3iJqpVZ/4Ah3PMzgvnzmdDaUns6dI29UOrC6b0HbYoUBvRCJw7fOcaVUOYXlZgdWnAw6qUEjpJP+AUM=
X-Received: by 2002:a05:6808:c28c:b0:44f:e5c8:2902 with SMTP id
 5614622812f47-4511294e6e1mr16757367b6e.9.1764682650837; Tue, 02 Dec 2025
 05:37:30 -0800 (PST)
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
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com> <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
 <09ff685f-a688-4b92-a38f-c58b598b464f@acm.org> <CAJZ5v0jvPJ+2j-J8vx7f2w50bTiAVbwNjuZW-WqsPZg1koZu8Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jvPJ+2j-J8vx7f2w50bTiAVbwNjuZW-WqsPZg1koZu8Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Dec 2025 14:37:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0haFgyoXqapvpESUec0_Pxw-uckTGSpVOWDQPbxWU-=Dg@mail.gmail.com>
X-Gm-Features: AWmQ_blDiExDLdVj0z0LddRfYz8TZqEuMWzZ97GkUjRexWJ6Iy-mqBNbnxv1XmY
Message-ID: <CAJZ5v0haFgyoXqapvpESUec0_Pxw-uckTGSpVOWDQPbxWU-=Dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: Bart Van Assche <bvanassche@acm.org>
Cc: YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 1:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Dec 2, 2025 at 1:41=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
> >
> > On 12/1/25 10:47 AM, Rafael J. Wysocki wrote:
> > > Generally speaking, if blk_queue_enter() or __bio_queue_enter() may
> > > run in parallel with device_suspend_late() for q->dev, the driver of
> > > that device is defective, because it is responsible for preventing
> > > this situation from happening.  The most straightforward way to
> > > achieve that is to provide a .suspend() callback for q->dev that will
> > > runtime-resume it (and, of course, q->dev will need to be prepared fo=
r
> > > system suspend as appropriate after that).
> >
> > Isn't the suspend / hibernation order such that no block I/O is
> > submitted while block devices transition to a lower power state? I'm
> > surprised to read that individual drivers are responsible for preventin=
g
> > that blk_queue_enter() or __bio_queue_enter() run concurrently with
> > device_suspend_late().
>
> To be more precise, they don't need to be prevented from running
> concurrently with device_suspend_late() in general.  The driver needs
> to ensure though that q->dev is not runtime-suspended in
> device_suspend_late() if blk_queue_enter() or __bio_queue_enter() are
> expected to run in parallel with it or later.
>
> > Regarding the UFSHCI driver: if a UFS controller is already runtime
> > suspended, we want it to remain suspended during system suspend.
>
> That can be done, but still the driver is responsible for preparing
> the device for system suspend.
>
> The most popular strategy is to use pm_runtime_force_suspend/resume()
> as driver suspend callbacks for the device, either as
> .suspend()/.resume() or as .suspend_late()/resume_early(),
> respectively.  In both cases, runtime PM will be disabled and runtime
> PM callbacks will be used for stopping the device - or not, if it is
> suspended already - but after that it must not be accessed in any way
> until the resume part runs.

One more thing that needs to be said here: The PM core expects the
decision on whether or not to leave a runtime-suspended device in
suspend across system-wide suspend-resume to be made before
device_suspend_late() is called for that device.  If the device is
suspended at that point, the expectation is that it will be left in
suspend.  Otherwise, the expectation is that it will be taken care of
by the .suspend_late() and .suspend_noirq() callbacks (and this goes
beyond runtime PM, quite obviously).

