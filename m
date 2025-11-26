Return-Path: <linux-pm+bounces-38736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF04AC8B2D8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3BE3A71F0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43F271464;
	Wed, 26 Nov 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9PnFZ65"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FA26ED39
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177724; cv=none; b=p8KnjGfpTh3CCPHOI5hyBR/wpWu2JVIA9fSRfnzrQs+nBd6wIo5L2lG9Xpltrt3k/xeh9u1zhZZfXqluken7l2bHbFS3q+oYQrvfDYvRbJf80a9E1aZ8Ca1a+RVNPaw/jPKpwHHBRuqB6fWF+mnxdRNZ2umVPvOIpmLWua7Y4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177724; c=relaxed/simple;
	bh=R2yF5gstqSqKlLjKnQdQN3gZ9Hk2ux76iIdAlBEEuhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUCpmQ5VBCdrF2Vr/7b4ZfR0Sz7NOu5QwLJUgTBDaWsJyTC0X+5pgZL7zr2zxnkp+P7z5dvzCimPe45fzepOX7L1hzIoR+9QkepUVcTVH8T1+yES7F9PUQW/uFyrUnyH/lT9PgrEPlEtdxum0bU7Zv3y4alYS9mi3wpBRG7oQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9PnFZ65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231CEC4AF09
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764177724;
	bh=R2yF5gstqSqKlLjKnQdQN3gZ9Hk2ux76iIdAlBEEuhs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q9PnFZ656P4i/DcsTL98nFHWsoJkKHRgBSsjtW4IGAlPMZJmNoccVegF1rqNZqVjW
	 5pXibz2LN5V3wm9SqbQ1qBxhZ0onF1gXIsIa8o/Nr4EpRX8mp0vpQ252Lt54mOt0LY
	 dh2WnskI9KmKBbVP4GLn7KDIzkBjooCP/zrjfYRsKQMQgRjT3TM6p2CaFtv4IF7v/g
	 QmLsIUHn5KrlxqqCyRaAI5ILZx+xyBWPf1tqbBSDOV5tUelqBu7CpXjyUTJblyUoRZ
	 hLbv+SGRHrXwJlQkaoguwnfoYWbKj4jbzf1GD1gglQ7NzHsBTjSoV5mLvUA9OYSUfd
	 4ATel96pL138w==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4510974a8cdso2396398b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 09:22:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4k30l0kWTQcnRC0RwvFmdkl5jefYN6xlZ7LFgdvoyylJhO1xQxk0Y90sP/B0O2oN4QDJFZ98ChQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHoZbfIbjVpOW4Of9uHxQ9YdBPVomuMQFJMMbG8WFyzm9btiKS
	iDIw0LS/jj9HSOSB2ToGvn8QK+bYTUlJVIE1UQk6UixbZVY1bijFlAz5vULlynWXq0DT3OZ8FXu
	JriiviKTLQxrgRS9Ahw8bP/m/xiHsm3o=
X-Google-Smtp-Source: AGHT+IEaqAwm7Am1qpwAEG19Ej9ScCFve6fv9+Cy+INznHe5EXu1pIYmJtEI4M03U9rDcPVGe2Ym2VhUkGHLdPgcXCo=
X-Received: by 2002:a05:6808:1507:b0:450:32d4:3d17 with SMTP id
 5614622812f47-4514e7a23d4mr3081635b6e.44.1764177723504; Wed, 26 Nov 2025
 09:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <CAJZ5v0jsdsyVd3hPWni1Vj+daQS8PdWJCjboJHHHbBjBMeSxzg@mail.gmail.com>
 <94c6680c-1b86-4cee-8e9c-860daf629b59@acm.org> <CAJZ5v0gbmXKrUi6RzW5jHLedCpDcMwCj=+4zZzq0pXwnFMkDEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gbmXKrUi6RzW5jHLedCpDcMwCj=+4zZzq0pXwnFMkDEA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 18:21:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g36Ea-XNBmsMSJxkAKz8zZNzWr_HA7AJOtS2NZOqAfEA@mail.gmail.com>
X-Gm-Features: AWmQ_bl9F0HoUPezUimC6UlUvQSXqnexcofdGFdW4xwOP8HpgFC86m-OuDTNiRA
Message-ID: <CAJZ5v0g36Ea-XNBmsMSJxkAKz8zZNzWr_HA7AJOtS2NZOqAfEA@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: runtime: Fix potential I/O hang
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 5:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Nov 26, 2025 at 4:48=E2=80=AFPM Bart Van Assche <bvanassche@acm.o=
rg> wrote:
> >
> > On 11/26/25 3:31 AM, Rafael J. Wysocki wrote:
> > > Please address the issue differently.
> >
> > It seems unfortunate to me that __pm_runtime_barrier() can cause pm_req=
uest_resume() to hang.
>
> I wouldn't call it a hang.
>
> __pm_runtime_barrier() removes the work item queued by
> pm_request_resume(), but at the time when it is called, which is
> device_suspend_late(), the work item queued by pm_request_resume()
> cannot make progress anyway.  It will only be able to make progress
> when the PM workqueue is unfrozen at the end of the system resume
> transition.
>
> > Would it be safe to remove the
> > cancel_work_sync() call from __pm_runtime_barrier() since
> > pm_runtime_work() calls functions that check disable_depth
> > when processing RPM_REQ_SUSPEND and RPM_REQ_AUTOSUSPEND? Would
> > this be sufficient to fix the reported deadlock?
>
> If you want the resume work item to survive the system suspend/resume
> cycle, __pm_runtime_disable() may be changed to make that happen, but
> this still will not allow the work to make progress until the system
> resume ends.
>
> I'm not sure if this would help to address the issue at hand though.

I actually have a better idea: Why don't we resume all devices that
have runtime resume work items pending at the time when
device_suspend() is called?

Arguably, somebody wanted them to runtime-resume, so they should be
resumed before being prepared for system suspend and that will
eliminate the issue at hand (because devices cannot suspend during
system suspend/resume).

