Return-Path: <linux-pm+bounces-16139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250B59A9016
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E761C21636
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA741C9B80;
	Mon, 21 Oct 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6ogwl+x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DD1C3F0E
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540051; cv=none; b=gqD/uQB+/nupBwp5obvF8WG+XmPxarjzb3T3mntxZRpJWmJPxTYTfs6vRb3HIcwkSyyViV8dBpJUJ2Vr5I5HLpXw9401lwZpc/vVDqw/qttZAWp2hWblk60grRyvbYAQPWxJR6NjnfeZltTlYjVwmh34/nL5SDVMX/efd4N4EYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540051; c=relaxed/simple;
	bh=MrHjfxFC8iRiytBrad+AZ/AVqo2KWcEgojWhywGV3R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyjfqg4Wc2QdimI4ZLtDpkkFVB8E2xkg0COPITrui/pyFsSJBy3wXA1c+cl0LbKOuH9tH/dOtvabqHC5aWVN73KmHYl4fvlTkPINtOl4Eckn8fUGiX2BujfzhPhf69UyhXGxjL9g3zrkpMzRe14uddHnMoBLVr+jn/AsY69i92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6ogwl+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16B6C4CEE5
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729540051;
	bh=MrHjfxFC8iRiytBrad+AZ/AVqo2KWcEgojWhywGV3R4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D6ogwl+xX8MTQ9YopDnkeHiP/nW4HFLEM6pJmrTZd/iTfU5kzwoZdq7IpEN0PQm1O
	 6+UEB1C6eO4YquaQZf7eY5DNb+wrFZ+riAsu0Dj9HjevUkJcavIqIMrlbZnNYM51Fd
	 EfEs0+oZ1+sDLnMWH+/m2bGQIxtygsKsKd1RQ+OWw61MDpwWzLs7JAJOeqi2o5rKeq
	 G66AoXc5tD7g8ocR/cyi/68b/VQXkIiIIWywbftJuewQAYdxPQ8zea9Fg7K5fVYfIT
	 eS5FEhBi8f0rnh+/0xLrrr3iVVDQyjY+CkI1FBUudCdrAqcQxPMiMLA4dR7WP+Fh/2
	 gun2GT884N4Mw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5f86e59f1so2217405b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 12:47:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr8injhm9Psu/g7F2VF6t+rx9AkV3Y5Yzjm77rNZASHENUNi3PVt2Ri+C1q2Slyk13PU5Wu4jy1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyBbvh3RTulfVKJYk+9LzYVTmHoG9aeMQblr5em4hOADoQM9E
	vEUIjiR0odv01EA2dEc6j82tk16yvXK+qSj9IqW/gHabouY7vplas4ldG6SEjn3M2A32VEILp0f
	0WG5GYGHsOLQSTip1V2gdZZx++Xk=
X-Google-Smtp-Source: AGHT+IHIGRzC2VX59u2ACcZ4XsubI2yDauK67InBzROjO274Wa898z3BFUbRPSMsKRl1/fhVUuWkTKN4fXN/TpIEu/Y=
X-Received: by 2002:a05:6870:209:b0:267:df02:f7c0 with SMTP id
 586e51a60fabf-28cb00febf7mr207939fac.33.1729540050219; Mon, 21 Oct 2024
 12:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-2-daniel.lezcano@linaro.org> <41b2ca3d-523d-40e3-81d3-5959942d9eb8@arm.com>
In-Reply-To: <41b2ca3d-523d-40e3-81d3-5959942d9eb8@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 21:47:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iqNhMfOiWQN=xTD71DDM4NoLLwGKmEJEbZ+fML3aHr9w@mail.gmail.com>
Message-ID: <CAJZ5v0iqNhMfOiWQN=xTD71DDM4NoLLwGKmEJEbZ+fML3aHr9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	quic_manafm@quicinc.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:41=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Daniel,
>
> On 10/14/24 10:43, Daniel Lezcano wrote:
> > The thresholds exist but there is no notification neither action code
> > related to them yet.
> >
> > These changes implement the netlink for the notifications when the
> > thresholds are crossed, added, deleted or flushed as well as the
> > commands which allows to get the list of the thresholds, flush them,
> > add and delete.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >   drivers/thermal/thermal_netlink.c    | 236 ++++++++++++++++++++++++++=
-
> >   drivers/thermal/thermal_netlink.h    |  34 ++++
> >   drivers/thermal/thermal_thresholds.c |  36 ++--
> >   drivers/thermal/thermal_thresholds.h |   2 +-
> >   include/uapi/linux/thermal.h         |  27 ++-
> >   5 files changed, 307 insertions(+), 28 deletions(-)
> >
>
> Since Rafael asked to wait a bit for the other
> changes to go first, I will skip the detailed review
> of that patch. I will do that after you add that
> new locking scheme.

Well, this is almost orthogonal to my locking changes and can be
easily rebased on top of them, so I don't see a need to respin it.

Please review.

> In general the code looks good.

OK

