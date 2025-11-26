Return-Path: <linux-pm+bounces-38725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C46C8AB64
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 680D23586F6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91F333A01A;
	Wed, 26 Nov 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtIjMHS4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4025DB0D
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171696; cv=none; b=bHCorp1mkMfhdL6//srYuZoQtfYMmlHPIr6QmefcgRSsa7PN8XFPCDjI1zHlgptbb5bDr4fW/bxJMSr3IOLlQhZuGpV7TROQa1vcpq7qBOpGhVkOmPEvItiKpDHDX1KkHISvyqgdHMvlc/6Tr4gGm/PdFhTZxOqFzFt6jVL1YA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171696; c=relaxed/simple;
	bh=S24uXRYdPei3+GkdbKOxdJvQMqEOHA+fuJO6N9F+wik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTHO4276BVJ8vGzAMbBR1mteAZBU0bfdfo54ffWHp06ACKTkmgIOL/dDMZsg7nDME/APGpFkyPuBcT9BRL5RYbpP+uEFgQVWPaRmj5VwbBtmBft8wmvW9P4UFPFKo9BuAQuYCgDItm7Zs7dv7JQ+mw3+KoZi00xbJgedfX3PuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtIjMHS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFFBC4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764171696;
	bh=S24uXRYdPei3+GkdbKOxdJvQMqEOHA+fuJO6N9F+wik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JtIjMHS4M+leu+qtQcBKHMBUn/A4O/lyCub3Lswue7yrZDJqKuBam8Ni88jABjWX1
	 bs4Zuer6UwfbcVaEIGk2+o1FfqzPxBOaanAafuhIQt5/3zbWk5XRGhlDCZy3foJzWc
	 1kOg3RaBHu6N4QSHD05IYEWPCVOjlKvXa5T48gU6h2HPd+JVITSVBKV0JR/Y2zKro8
	 HYFVsY45nkmrcYJGkk+xhdEva1DBgHRanfELx3rsvRrGHT1U5ig7GpSpkSfmc6xu5l
	 usngvDGVlraQhEVp4w2srHWgs08ILjEvixCi4qPgdR7hjPVlX+sMf+tnDjElo4dvEl
	 UkMKq3n0efNCA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6574de1cda1so2688206eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 07:41:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVVlFsZTehCGsUSOCDPWNV8BAq0g/erNUwypXAW6fEvJGZB8SI9h8MwQtbZqVUnEmZpL13J9zsew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoTZM3fz6ilMX/GY6ZI0dogAMqj/MIdcz0fuwZ6TGG+Qh1rDib
	D2xNh6H7mPtfw/SrOH7qLKxpp0rJg7y0szdDhpJOeTzPT9UFEDvzuIGfanUGuYlwJUmjA7bl0eU
	AzdYvOlf8/HusTBiGWrDCHvbQp/Q5fp0=
X-Google-Smtp-Source: AGHT+IGIVP1StFKaOCVbl2pFJj1bElnpsXdqL10mCG3C1NX2m3Z7f+ieqVbTYCSRFBySBuPo+rK75c2RvYri9y1zat4=
X-Received: by 2002:a05:6820:811b:b0:654:f6f1:dd07 with SMTP id
 006d021491bc7-657bdb68d36mr2463702eaf.4.1764171695725; Wed, 26 Nov 2025
 07:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
 <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com> <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
 <9b6e7d55-6a1f-490e-98c7-3c04f85f7444@acm.org>
In-Reply-To: <9b6e7d55-6a1f-490e-98c7-3c04f85f7444@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 16:41:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hJw0WdHpqgUc5bz5qCSUNNKHg7i5-sNYeZcDYwRj21qw@mail.gmail.com>
X-Gm-Features: AWmQ_bmDOGJHpcrQGXo8ugxWHhlUTb1Js0jsrnsQQz-TNjvaI1DJy7kSFkXYkoM
Message-ID: <CAJZ5v0hJw0WdHpqgUc5bz5qCSUNNKHg7i5-sNYeZcDYwRj21qw@mail.gmail.com>
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

On Wed, Nov 26, 2025 at 4:34=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 11/26/25 4:36 AM, Rafael J. Wysocki wrote:
> > Well, the code as is now schedules an async resume of the device and
> > then waits for it to complete.  It would be more straightforward to
> > resume the device synchronously IMV.
>
> That would increase the depth of the call stack significantly. I'm not
> sure that's safe in this context.

As it stands, you have a basic problem with respect to system
suspend/hibernation.  As I said before, the PM workqueue is frozen
during system suspend/hibernation transitions, so waiting for an async
resume request to complete then is pointless.

