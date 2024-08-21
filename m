Return-Path: <linux-pm+bounces-12630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FAA959A59
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F541F22F7E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DEB1C3307;
	Wed, 21 Aug 2024 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyLYUkKw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB901B1D61;
	Wed, 21 Aug 2024 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238677; cv=none; b=GKDHfsHqLqGRAVS48Ge80u9OD/t88NIFS+8ePHnSkAx85MFzMdA0JiXSxPdPeEY43SG5pRmgfcqn9e34ezdqKzBFTvoTCBlfh0TRUGF+TPJVPwtGKMHIa2a9408AIQ4gjZzhhx689pXWZADYIMqLkmZeLPwi30x5+5LYhVdGhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238677; c=relaxed/simple;
	bh=NP2vT5XV0h7oRJk4j4u7B5zSDwT0M9sYHrdts5GFKCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fwpz4r6c8mDyDYGvFAhSN3aIK9sqPE3RzWbcyxFsMMNjyzwSPi9OmPxIUo8J6HjqfFjomOIpFcUDkTF+sZYi4Me5X9cDbBkHGkuylA/6UMQ3RzmNrNuVWAjo7xBZ6azO3TkoZ797jT88kXwGNLLwuRug52wjnTVHAi4wOg1PEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyLYUkKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1845AC4AF09;
	Wed, 21 Aug 2024 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724238677;
	bh=NP2vT5XV0h7oRJk4j4u7B5zSDwT0M9sYHrdts5GFKCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PyLYUkKwrm0Zss1jyDFZumT0v4dq5VaSIwPQ24LDfKxqmpvjcgFYOLffxAKdTevd6
	 zRviQ7qGlntPKjFWVQ4URzW2Mm0o6iUmzgK8J7DdMKYcuEcHeLilgsVn2mAB1KI1XD
	 2X36KgMkch+r+z1XhBesUxksl+0U3ILwebfMgMfYvbUwpFd21PiIhn0VjKEzH/8su1
	 XrM9zvbiZ/x4ldW6APvMtZBAaTqIXzH8b0Gbj+15uDGpggiWeALsuRxg6vEGoQJHto
	 zpw47XcpfqWxBVNzev3Rtv7GoHGrMUAoWZS8nkkqH0u0xmP52kIWNKBb4KA7y/WeFF
	 pMjenISyFlNWw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27032e6dbf2so2426942fac.1;
        Wed, 21 Aug 2024 04:11:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMvHZZkZYUgwKVctcRwxJPTvBzH6I5sHj5fbvC3aGFU2zhojmABWz4ydgZRQHaKrEDw3CE7tVBvcwbIi4=@vger.kernel.org, AJvYcCWUVHhpucx8Et/NOAu0PgJwtpC2/kwhaoX7Ih7OWZZNY7C1/tmkxXoO9R2h6p0jr7M0lg80LD69H/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjqjcuq8UZa03jFY4NSD59G5DaH56lajcgf4jQNmL9VVK36wIQ
	7NJ4PNFEL2zouqDLvwoSMd7iiminvhogeuWhS4YvadAL6sndD4Q3ItC5wPhy8NZm+JjC2sN8GEL
	aoZV2IZyvFyJfDmUKL2qbBMphkOk=
X-Google-Smtp-Source: AGHT+IHTmYRIBJiKwg+iQ4yRJlRdPKZl8el3PfalFXSkxxA2kOksoEND2zF0c5bTykdRb0/+jUBusQO/xky7rlj3CI4=
X-Received: by 2002:a05:6870:b289:b0:25d:ff1b:3793 with SMTP id
 586e51a60fabf-2738be316damr1918813fac.35.1724238676438; Wed, 21 Aug 2024
 04:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <10527734.nUPlyArG6x@rjwysocki.net>
 <c01ed2d7-964d-4b75-9a8e-8325d4cc9269@linaro.org>
In-Reply-To: <c01ed2d7-964d-4b75-9a8e-8325d4cc9269@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 13:11:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQvSouUcEH7CtxZptKHbRyy4=Nes_SjqAW0S7jOJXHqA@mail.gmail.com>
Message-ID: <CAJZ5v0gQvSouUcEH7CtxZptKHbRyy4=Nes_SjqAW0S7jOJXHqA@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] thermal: core: Drop redundant thermal instance checks
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:01=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/08/2024 17:52, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because the trip and cdev pointers are sufficient to identify a thermal
> > instance holding them unambiguously, drop the additional thermal zone
> > checks from two loops walking the list of thermal instances in a
> > thermal zone.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> I'm wondering if the thermal_instance 'tz' field could be removed too ?

It is used in a debug printk in __thermal_cdev_update().  If that
message can be dropped, then yes, but that would be a separate patch
anyway.

