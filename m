Return-Path: <linux-pm+bounces-12829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40695CDC1
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 15:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27489281D97
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C218661A;
	Fri, 23 Aug 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS32JMbN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB5186601;
	Fri, 23 Aug 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419685; cv=none; b=lK8va/fZ+QUWn/k7VssDoDXUefV28XRdFDxmGPzRh+GHt+u1+nhTrcRU0ZRpGz5EcsL4TvxY6WsgxV838bK63UsGcY4d1eIuZvrQqyymXqTwmgg51xC+OAYgnou5xfegak6mtq3WhshFMooGESI/D8BesX0OeMirD9DiL9DisS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419685; c=relaxed/simple;
	bh=DNlR9IfmHdpksq7A8/Fhgkr8Dh+iHoATiUQp29Ay9Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjvpXR5CohxAbJeaMaeVWNgpvEF+tHeK44KbjYUufLAJovm3M5arvHQmy/e5j8oQLUDwLLH8uJo3Rd+UxmrxJNqpNS5isnDsgA5cTOhloyzkCVtyBtrjpfaIJjflqgEW7GHZXz0RqNAibTWviRlGsBheBqQuEIYVl4LhiREJndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS32JMbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAE5C4AF09;
	Fri, 23 Aug 2024 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724419685;
	bh=DNlR9IfmHdpksq7A8/Fhgkr8Dh+iHoATiUQp29Ay9Ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JS32JMbNlVZdL2ke6W76ZOFYihkqV44p3oAPSqGoFyyIOdnkTYwZd3XX3nIDVZJU4
	 izBMZzsJsN7QXWKE3QbmadQb4hmJMU4ffLZ/4Ta3f5QVEERL0Zo84/4RwBgACFrNLr
	 Sr5B2EK86gTYU74lsaQiZ3gzZJFvfRCZErWI/+/RqyjARw5n4cYVm2WuhcpOJ53Y+4
	 57DCdEYa+Aa8iwnO7TDACxlvsiV8abxfT+0at/8wXBresMsgo++9GO6jR/EgGzlW+s
	 suHedI6VI57dOfsX7k9HmO8wJ1i61SeUKq5IdvDLfHI9hG7DL9VZyTeajv6LnnpfPw
	 3CgDjJoGeDTRQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-268eec6c7c1so1360896fac.3;
        Fri, 23 Aug 2024 06:28:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU8JGkmkSs4XBoQiBbHZikveSEu6svurTMu5nJWrcs2DZirSoL04qFU/m9HFLqXa2KOx9H1H2cutI=@vger.kernel.org, AJvYcCXKjDp498tn/5tXLRy5cBqTBSg0xxQhbQ06Ky8JDgrqqvz+EQ/ArejysncRBuBXDt4eZmIoHxMylqRMjMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgy1KkvjcO1soPcx7QbW1hH3+LcKiVDunGv2gBFFT2SYrVh+J
	AL14AlMgFM+j4ZXFCXHvuBg8guad+NggyeTxCNHFSK2S0B/J9wiF3d8TLmbISpZ8uFDnbbjfxDE
	PRZ2A2F8c2ZSk/wqe+wfZECQp9ag=
X-Google-Smtp-Source: AGHT+IGIRNoKP4JL5Gq1gJYcxZT+ZARdtAf+zcnKNPiWj9LhaEWGtYnyVS2U+bMY5dmYBScdsFE5Nd2NRT+TSQCUNFA=
X-Received: by 2002:a05:6871:706:b0:268:a074:39cf with SMTP id
 586e51a60fabf-273e641fa92mr2404461fac.8.1724419684502; Fri, 23 Aug 2024
 06:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823071555.3331632-1-ruanjinjie@huawei.com>
In-Reply-To: <20240823071555.3331632-1-ruanjinjie@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Aug 2024 15:27:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iw7uXE_cfU5VXOjFDg9GM8Hu0+hKxqfzU3v0OM5KK9oQ@mail.gmail.com>
Message-ID: <CAJZ5v0iw7uXE_cfU5VXOjFDg9GM8Hu0+hKxqfzU3v0OM5KK9oQ@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/of: Fix duplicate of_node_put()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:08=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> In for_each_child_of_node(), if continue, of_node_put(prev) will be
> called by __of_get_next_child(), so remove the duplicate
> of_node_put(child).
>
> Fixes: 0f0a1b4ba3e4 ("thermal/of: Use the .should_bind() thermal zone cal=
lback")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/thermal/thermal_of.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index dc43f50db890..85e7e3c43c7e 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -319,10 +319,8 @@ static bool thermal_of_should_bind(struct thermal_zo=
ne_device *tz,
>                 int count, i;
>
>                 tr_np =3D of_parse_phandle(child, "trip", 0);
> -               if (tr_np !=3D trip->priv) {
> -                       of_node_put(child);
> +               if (tr_np !=3D trip->priv)
>                         continue;
> -               }
>
>                 /* The trip has been found, look up the cdev. */
>                 count =3D of_count_phandle_with_args(child, "cooling-devi=
ce", "#cooling-cells");
> --

Good catch, thank you!

I'll fix the original patch and reapply it.

