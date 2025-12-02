Return-Path: <linux-pm+bounces-39066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77C2C9B70F
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 13:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BF3A5C36
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F363126C5;
	Tue,  2 Dec 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0vxKe2M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA930F92B
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677660; cv=none; b=FhRQd01BSS7ZhascR8QVE7AAyp0T//tP39H6vFmLsN/shqFO7WN8yhbw/+Ci/ja0syGmu9IiqcJqOikpQSMlyxWq/Y7yc5esYWl7ijzFBzq/P+E93vzqouieYM1xoo0oJK0Dtxv3aQMrT0/RBNqmHCYDe3qTWrEoAjm/3vtcnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677660; c=relaxed/simple;
	bh=8Vz3IecSk4bnuzwv8lV8H9kO7HqjIaGEdiK+J+TwjQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca3iNTHEw4ZM4V69D2Vl28BitLDYLhgr5TS7CGK42C8dLIAKiLz1lNm9UvIij4TEU19xsIB3ndmT/G/Vrx4oQegE/TtUvFHQmlZhyBzbD8hiVzn3Cxu7Hz+fNTtL4R5X9DVHRYn63UPjHhiPoqA8ehamvjj1aMha60k4CWvN+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0vxKe2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9E1C19422
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764677660;
	bh=8Vz3IecSk4bnuzwv8lV8H9kO7HqjIaGEdiK+J+TwjQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L0vxKe2MNxm69/2EDe61oUJLfQlGvLxqDjlCyzpT07lL4tAThZd6hSUStdGCH0pz4
	 44FEOTm1v++NyXYPwb/qMgZyiseBYL3b8fvTJJlh4hNDy4npfDicUn/ETgAluxC9Ia
	 i+lCkk/fwlSUw6jRQ4cmIOVCjz0VQbtm2+/Ko3Y5UMQCz16zjgDxKpt09C5g/Ji66v
	 bnxPfsnc3AiCeslUQ1XQ1wRntl9CtBM8dTfoMwZb1XrqSVty89DZX980yW2zXguNJ+
	 7rK+O/BWNNln4pLXwZUGA9eGqdYuCz1BZVwX3oSId4ph70uzOx1ui3bjm/SXEJCofX
	 UZU9xVLTZ1Qyw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c6e815310aso3259288a34.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 04:14:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8kxTMakt2EPfW2i4nhhFoaZwLRGo+FRj/7LbtJMeMp6wYiQzZUJuX5r//pR69K6IDU+b7yCoj1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YztxXU5jLjxXNKAH9WdXbFzrYZmv01EIyTb5xVZrpa0EpqGU03o
	wD8FVkQirMAfOPE5vaEa8dcYfpd9Ak+O69ucXYWnFMEwKasvLNsmswaGhsOW33siwMV+05QTmHS
	tBtT8smINtMY7ifN6Ef/TwrTFcQ0t3S4=
X-Google-Smtp-Source: AGHT+IHbYE/aPLMnhJED6LYiGPtgargKn1QSmcDoAF/OUkiEv5yCNsFxJX+BRsSUsbm1Vqa0XKKFRr/1FdcVTkFeo30=
X-Received: by 2002:a05:6830:2695:b0:7c7:5ad8:2e47 with SMTP id
 46e09a7af769-7c798db2929mr21718528a34.19.1764677659443; Tue, 02 Dec 2025
 04:14:19 -0800 (PST)
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
 <09ff685f-a688-4b92-a38f-c58b598b464f@acm.org>
In-Reply-To: <09ff685f-a688-4b92-a38f-c58b598b464f@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Dec 2025 13:14:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jvPJ+2j-J8vx7f2w50bTiAVbwNjuZW-WqsPZg1koZu8Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnZZ8higrZ7dh-gokaKfPBz_DqvcafB7qGsxj1XiH0slCGI12PBjjt1mfY
Message-ID: <CAJZ5v0jvPJ+2j-J8vx7f2w50bTiAVbwNjuZW-WqsPZg1koZu8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 1:41=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 12/1/25 10:47 AM, Rafael J. Wysocki wrote:
> > Generally speaking, if blk_queue_enter() or __bio_queue_enter() may
> > run in parallel with device_suspend_late() for q->dev, the driver of
> > that device is defective, because it is responsible for preventing
> > this situation from happening.  The most straightforward way to
> > achieve that is to provide a .suspend() callback for q->dev that will
> > runtime-resume it (and, of course, q->dev will need to be prepared for
> > system suspend as appropriate after that).
>
> Isn't the suspend / hibernation order such that no block I/O is
> submitted while block devices transition to a lower power state? I'm
> surprised to read that individual drivers are responsible for preventing
> that blk_queue_enter() or __bio_queue_enter() run concurrently with
> device_suspend_late().

To be more precise, they don't need to be prevented from running
concurrently with device_suspend_late() in general.  The driver needs
to ensure though that q->dev is not runtime-suspended in
device_suspend_late() if blk_queue_enter() or __bio_queue_enter() are
expected to run in parallel with it or later.

> Regarding the UFSHCI driver: if a UFS controller is already runtime
> suspended, we want it to remain suspended during system suspend.

That can be done, but still the driver is responsible for preparing
the device for system suspend.

The most popular strategy is to use pm_runtime_force_suspend/resume()
as driver suspend callbacks for the device, either as
.suspend()/.resume() or as .suspend_late()/resume_early(),
respectively.  In both cases, runtime PM will be disabled and runtime
PM callbacks will be used for stopping the device - or not, if it is
suspended already - but after that it must not be accessed in any way
until the resume part runs.

