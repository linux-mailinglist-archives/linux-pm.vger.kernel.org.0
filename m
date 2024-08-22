Return-Path: <linux-pm+bounces-12765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A1395BEA8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108D52854B6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70B13D50E;
	Thu, 22 Aug 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isMdo474"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55776025;
	Thu, 22 Aug 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353598; cv=none; b=NcLENd4J5r4VGaIOveHN7u/zx0CJaQxMsYhWLyHvQ4XY4PrRoN9FrLxfeXHqlxGq9LXsA9ilbZVfvvurXeS0rSjUsB1Ixbbjjcn/XrBVyINsrjZGFDRE53SfiT9fY9uoOgur2upSG1IpUAiZazTzabXryDJk6f7oW8luala/0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353598; c=relaxed/simple;
	bh=feTkFSqWfs3CXLcx29p18Jk6iFxe6j57z99XalVaVIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTZ2UdcUaXFjq58E9uHPxMrDlvMNHqGfwUuJ825t8JllgYSb9O9gROZPt2DKuu/wgoy3RjOCTLe+Vp4WXLs6njBFBW/B020ZLPQXT2+/m8G5BUVnB5oqsX662fsN7X4tucGwAp2S+MRYFbQqZdq1D8PDAn7SoSlmoLpqnxc0/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isMdo474; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C90BC4AF0C;
	Thu, 22 Aug 2024 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724353597;
	bh=feTkFSqWfs3CXLcx29p18Jk6iFxe6j57z99XalVaVIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=isMdo474FbCVmd2bM0bcZQ3jV0IK7Z/wpryNyMmGmAiFxfcdJfQaK8zv6N3Vk7Jdl
	 7n7U7UuohC4wHe9V5dlMSEFgNHga64Idwdm3VG2IR9ENa1d3A0CFkB7M9J26Zlo401
	 QGl7EZQLNpNh/yP3o+azpdccTGkiCyw+q+1EHb1u52PcZBwHyvM7cyMehp87G5qvwr
	 Fgbl3M2fWjx582j5w82lYdfZ+F4iCqokNcAMlzTzb41uTkLJ3W7aqWRl90pYSDi3zo
	 Dcn7+0lwpVxVBJ8V6wR0A0Aqb/7ouezccorHBdUHhRIh65k0GVsv2eCpDP8Xj0u7nc
	 6AhuzOJVp1XsQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-260e6298635so1073561fac.1;
        Thu, 22 Aug 2024 12:06:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlUKrVesGHegF4Enx62HZWb3yIpiJsXfM7yGHZCxn5vaz7Mei5u5trcUR4DNN5iRnz4fU27JzcW38=@vger.kernel.org, AJvYcCWHo7XYNaKfpm1sqnynVDTphzaY6rIWO71Q705Fn1Q/zX7/2F+L1LqNKyalTPxkSbnqpqhb+3yWdUgTnTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4CFygU3VfcQzRjo78wjt0yvVN5x41gUBOOpNsndubB2A74X9
	IMyc6mZEXkyJwWuzkdBKpeLjlrQ34OXi/YL4AjR9c0ajWsF8eJghnVVUDUSwe2lcxFSQYuZgiIv
	B8ad99rvsh92PpkgL/RGgxWWzaXw=
X-Google-Smtp-Source: AGHT+IH/HKBN5igbPFNU99AA1KJRnfZNzj0StZ8X7J8FV6NzPUxoxR4vOuL//DmDrXwS8vi7uNKxvV6Gah1QATspB4g=
X-Received: by 2002:a05:6870:46ac:b0:260:26f4:58b3 with SMTP id
 586e51a60fabf-273e45526b8mr11202fac.6.1724353596669; Thu, 22 Aug 2024
 12:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821114250.1416421-1-d-gole@ti.com>
In-Reply-To: <20240821114250.1416421-1-d-gole@ti.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 21:06:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gVE=05+Yp9rVg55oFQdPQoooKYOeJmr5_-u238x0b8jg@mail.gmail.com>
Message-ID: <CAJZ5v0gVE=05+Yp9rVg55oFQdPQoooKYOeJmr5_-u238x0b8jg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: remove dead code in cpuidle_enter_state
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:43=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> Checking for index < 0 is useless because the find_deepest_state
> function never really returns a negative value. Since this code hasn't
> been reported in over 9 years it's dead code. Hence, remove it.
>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>
> Discussions on the original series that added this code:
> https://lore.kernel.org/linux-pm/20240821095105.xuf2a5xe3yxqqewj@lcpd911/=
T/#u
>
>  drivers/cpuidle/cpuidle.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 02e40fd7d948..9e418aec1755 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -228,10 +228,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_devic=
e *dev,
>         if (broadcast && tick_broadcast_enter()) {
>                 index =3D find_deepest_state(drv, dev, target_state->exit=
_latency_ns,
>                                            CPUIDLE_FLAG_TIMER_STOP, false=
);
> -               if (index < 0) {
> -                       default_idle_call();
> -                       return -EBUSY;
> -               }
> +
>                 target_state =3D &drv->states[index];
>                 broadcast =3D false;
>         }
>

Applied as 6.12 material, thanks!

