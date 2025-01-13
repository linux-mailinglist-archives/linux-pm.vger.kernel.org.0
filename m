Return-Path: <linux-pm+bounces-20381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C809EA0C226
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210953A4FF2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA131CF5EC;
	Mon, 13 Jan 2025 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/o5rf+O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481201CCEE2
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797976; cv=none; b=Zc1XNxzXhkQ0SSvPwzirVIoxGnbhTkI5eTS423UmVh58p/FUVM2FOVR7OpRFL01+YY2RqZSZzlzs0mzhfv41MYg0WUp8AkvmwN4ucSUVlpArNnpFkKPJjGtu3YhhkyMVTZ2DVgxmUQpNHG1ptTKXDxfpGTmLRRVBHMPT8szd+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797976; c=relaxed/simple;
	bh=VhiaEgmtkEPIT9tBGd0VtJTeBVJFTy92tnpz8dUwl28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtnG0F6S2cXKF9U2gqMjxQg9UhlGU5yf601xniVIaub07Jw0P+rbO30Oz/kuzgwRUj1rV6oFqOnouuevnD4JIo5y+8wqvIrTHnNLIpUgXa8/zGI+CPUx413d3YyQK+EM+WwffEirJoc3peOAn9ZCC79pzcJm4X8NIcpGjJXC7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/o5rf+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4B8C4CEE1
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736797975;
	bh=VhiaEgmtkEPIT9tBGd0VtJTeBVJFTy92tnpz8dUwl28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J/o5rf+OhpZI8VnDHBxtRvJV7CarcmkERxSBLrZs1RWcrzN05a15PDbPJYYPsrl2j
	 D9nltODWlBnzvY3iPGlFY5RMzONnjrVgK1xzSi0lRXp1YT7gCpuKU/q324lhYGZpzI
	 sugzyZ8biPBjltMOEX8iwq2SbvPxxfz5p6bQG4Nh0UWssn9lxTlPHpi1w7MV3Gf8ga
	 M3GMweZiVBPWBkaGq0MJIFdl4xRRuDM3m0JH9rwb3S9SujPVu69hmNUGRSlmC0HSVU
	 GV7+5HNaPPRLk2Oo8u1G78nP3GUs9n8bIE3gJgtLjidT7XelcQiIhinIqtqPEGI6vI
	 tLTB8W0H1JieQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb790888c6so1247581b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:52:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCu+QRuVFHsunTlxApnB7sjVRBoKf7QA/fjY/cvprDAu3+OmqyhbSJ7O88ADMePHGfdrS7T0LneA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyub19moRT+8Vx2QVI3137v579tGJUpLwdgUECvkTM+7jpCztlE
	gM8V+ohhMvkXzhgv1S/4ULTFhM1aSu9qG8C10WaWp+xj68qA6lHFI4TqJv108OWJg+mZaG3ribl
	0VGOXGmLi2qGNU0MrRSz9xfhiHrk=
X-Google-Smtp-Source: AGHT+IEA629BqCaljnCfNj7FmiUyCU16GOfyorxU4G2cIRnQhkpw2tp0b2FAfuqPpFHenZGfAaAmZ+o3SUIUPhzp540=
X-Received: by 2002:a05:6808:181e:b0:3ea:519e:cc71 with SMTP id
 5614622812f47-3ef2ee43a7dmr15786654b6e.39.1736797975161; Mon, 13 Jan 2025
 11:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d9ae7d64-19b1-443b-b3c1-e8187bab11e1@kernel.org>
In-Reply-To: <d9ae7d64-19b1-443b-b3c1-e8187bab11e1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Jan 2025 20:52:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j4jsrkbVvCkH-XGZiVcNz2zKsVv1R4TkKhX-7Z7KhFyg@mail.gmail.com>
X-Gm-Features: AbW1kvbT2Ho_wk2qMWkPjMAGcCQo12TpYHgdj7R2HARTeB86JKcL1uyvst4u3N4
Message-ID: <CAJZ5v0j4jsrkbVvCkH-XGZiVcNz2zKsVv1R4TkKhX-7Z7KhFyg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.14
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo,

On Sat, Jan 11, 2025 at 1:11=E2=80=AFPM Chanwoo Choi <chanwoo@kernel.org> w=
rote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.14. I add detailed description o=
f
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b=
37:
>
>   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/de=
vfreq-next-for-6.14
>
> for you to fetch changes up to f3253b23535fda2436b2d5a3172260a75ca64091:
>
>   PM / devfreq: exynos: remove unused function parameter (2025-01-11 21:0=
3:07 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.14
>
> Detailed description for this pull request:
> - Call of_node_put() only once in devfreq_event_get_edev_by_phandle() on =
devfreq-event.c
> - Remove unused function parameter of exynos_bus_parse_of() on exynos-bus=
.c
>
> ----------------------------------------------------------------
> Jeongjun Park (1):
>       PM / devfreq: exynos: remove unused function parameter
>
> Markus Elfring (1):
>       PM / devfreq: event: Call of_node_put() only once in devfreq_event_=
get_edev_by_phandle()
>
>  drivers/devfreq/devfreq-event.c | 8 ++------
>  drivers/devfreq/exynos-bus.c    | 5 ++---
>  2 files changed, 4 insertions(+), 9 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!

