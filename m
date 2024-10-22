Return-Path: <linux-pm+bounces-16205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C489A9F50
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97891C2529A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E5A1991CC;
	Tue, 22 Oct 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUdeeDj4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0E155330;
	Tue, 22 Oct 2024 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590989; cv=none; b=VtF/KucmSWP2zjqxzcnKC0IctQLSSo5d/Wlo3rJgGnFyyIr7lXyWRakyUlFTkRqNPnxI4+fO88SD1qfWYPwE79UziNkVtmn9/vW2WKQ/BaJG+qsAhqgiYiC2VQm4YQoVlQfKyePt5OAhAjXDcpN5oTwsmGXIl36ztIUKCIikG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590989; c=relaxed/simple;
	bh=ICvx67HfupNV7X8ez0ig1ke+d2T0Pj/8g4aUrNDFUY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re1xhmndDNZuS9lboXq/N0m5KkhhUOj0Wv2NaWIT7i2Mbyyxp5f0r4eDwFUDBbGMsy84EYD7YcVkUu03YxFcFFkGBS3T3apI5hHasioxhP1dZvk7lgDBjYoHPW2wh6Lpx/nXcBTwOue2ztoXlb+iTqDZLuIciW2nINx/hCE5sKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUdeeDj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11A8C4CEE7;
	Tue, 22 Oct 2024 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729590988;
	bh=ICvx67HfupNV7X8ez0ig1ke+d2T0Pj/8g4aUrNDFUY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aUdeeDj4MlL2pvldvpH6pwJSfyJLF7Sd2Fc2V8dTHSDFWmUqf339UphKAjWSQVlgc
	 LNyjNcsGT1E6jZ+ttQculDHCoVXp8Rw4px2rpchmx8QFN15J5i6aCfrx5aunj4hfHK
	 oOrTE3gAGsvbqBsJiGGab18lciLVxr8FJJYSD1RsRu1PYr12zjEZp04YQVFxjv2KQP
	 /PQvZ1WMQbopa6h3VsZ4NzhsMZS2Q4nqiF1NyhLrOeo8Zxqc13yC9KGANklSOTS7Ow
	 cos2GRIJNpFMbBR1rXKEUj3vWQKjqoTmyR4WcBwCwpTYiQXwd83ng4pCJonu0B5Y9e
	 imowkwNUS6Fgg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7181eb9ad46so2170149a34.1;
        Tue, 22 Oct 2024 02:56:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsoX9kngFvY3zL/UzAq2UYWbcD819EAhUipE5F7lzQk7Sk0BHGINZxZoJvyLliwV8aCjBdNbCziSw=@vger.kernel.org, AJvYcCW4kFPmqkVGKfcxHOSc6GYxO7aylH9crogceoYR27NL6Gi4wGU/k9Uop2WsHzxKb8tYLLRIhyTV0iweAk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qfQKsi47wDSgjUTCHGqk1yHkgjZ/M5SGROI5Nh0N+gFmR2yK
	EvHRPvhsQh8TmCXnQ5CUi0no16nbemc5a6nfsodbPp/xJ5bhhQHNPwxoSH3Kr43n2VfnXncExzT
	+5pMwD3KR5qjswH01t0GUVARBRbI=
X-Google-Smtp-Source: AGHT+IEOOET6wayelTMNOqOUVlcPkSPvAVtkLnZ7XVyFHiatKVn2buuJSdTUziR7DtaK5ZWpUyUjWkTG5gDaem6WXcs=
X-Received: by 2002:a05:6870:e3ce:b0:270:c1e:41ad with SMTP id
 586e51a60fabf-2892c49ea37mr11588730fac.35.1729590987984; Tue, 22 Oct 2024
 02:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2215082.irdbgypaU6@rjwysocki.net> <CAJZ5v0jYzw7hXaX+5AvO407d8vo725_-wHLQW6Q1fqXXJGSb6g@mail.gmail.com>
 <CAJZ5v0gEgr7Q49JSQQ37_2VbdXBTDPZmoYHuCSACJW_3gdmuwQ@mail.gmail.com> <e77b2e7d-771e-40dc-8953-8f2cded7cb7f@arm.com>
In-Reply-To: <e77b2e7d-771e-40dc-8953-8f2cded7cb7f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Oct 2024 11:56:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtiwAic2DL62=-JE8wT4ed+p5Wen9rZnhH4PBicRqo9A@mail.gmail.com>
Message-ID: <CAJZ5v0gtiwAic2DL62=-JE8wT4ed+p5Wen9rZnhH4PBicRqo9A@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] thermal: core: Fixes and cleanups, mostly
 related to thermal zone init and exit
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Oct 22, 2024 at 12:44=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Rafael,
>
> On 10/21/24 12:05, Rafael J. Wysocki wrote:
> > On Fri, Oct 11, 2024 at 8:50=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> On Fri, Oct 4, 2024 at 10:11=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysoc=
ki.net> wrote:
> >>>
> >>> Hi Everyone,
> >>>
> >>> After posting the two series of thermal core patches for 6.13:
> >>>
> >>> https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/
> >>>
> >>> and
> >>>
> >>> https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
> >>>
> >>> before the 6.12 merge window, I have decided to reorder the changes i=
ncluded in
> >>> these series, so that fixes and more significant cleanups (for exampl=
e, changing
> >>> they layout of data structures) go first, followed by the changes rel=
ated to
> >>> using guards for locking, and the optimization involving sorted lists=
 becomes
> >>> the last piece.
> >>>
> >>> This series is the first part and the majority of patches in it come =
from the
> >>> second (RFC) series mentioned above.  Of course, they needed to be re=
based to
> >>> be applied in the new order.  It is on top of 6.12-rc1 with
> >>>
> >>> https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/
> >>>
> >>> applied and it will be added to my thermal-core-testing branch.  It i=
s in v2
> >>> to start with because all of the patches in it have already been post=
ed in
> >>> some form.
> >>>
> >>> The first 10 patches fix some potential issues related to thermal zon=
e
> >>> initialization and exit (for example, user space may start to interac=
t with
> >>> a thermal zone during its initialization before it's ready and system=
 suspend
> >>> taking place at a wrong time may skip a new thermal zone so it is not=
 suspended)
> >>> and do some cleanups related to that.  This concludes with the remova=
l of the
> >>> need_update field from struct thermal_zone_device.
> >>>
> >>> The last two patches move lists of thermal instances from thermal zon=
es to
> >>> trip point descriptors and clean up some code on top of that.
> >>>
> >>> Please refer to the individual patch changelogs for details.
> >>
> >> This material is now present in the thermal-core-testing and
> >> thermal-core-experimental branches in linux-pm.git.
> >
> > I gather that it is not controversial and it has been around for quite
> > a while, and it was discussed during the PM+TC session at the LPC, so
> > I've just applied it for 6.13.
>
> I hope it wasn't too late. The patch set looks good and I have
> added my reviewed tags.

No, it wasn't, thank you!

