Return-Path: <linux-pm+bounces-40577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF97AD0C38C
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 21:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89DC03024113
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B132D47E3;
	Fri,  9 Jan 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKGgJQmQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE142BE655
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992192; cv=none; b=FAWlGbR9jRvQ4vV3geoY/LqXhSR3BYFuv0PDaeAUNdk1rAzMLaF8qwtQ067e5icvt9VbC/zb1gagajxngUz7Fo3ClDnEuxcTFdFNORlPSBm4N0qlHRtTrHD1q9yJIUANOoazM3EOWQW7r9pAOjcPYaB2acIyV3lMTBU64ituKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992192; c=relaxed/simple;
	bh=SLAhFhByg5iEFdQjgvkk5Ppm+8oz9a74DZ2gxNyVg54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krtHWT4QJBqkrGGgg3KDvgdhiYvwm5PtmxruGQq46LQTVs+YqsdeVYzbNeuOnWs1FiwWD45fPzxsaP2I8oVVWq1DGfXmhGf0vjuXUUeEMq6+eaYS7zli+fwG4GvId2060QvWd48HuSdfuRTggLsJwfk4+dW8Yefv/an5rcbH+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKGgJQmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D8C19423
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767992192;
	bh=SLAhFhByg5iEFdQjgvkk5Ppm+8oz9a74DZ2gxNyVg54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JKGgJQmQ2m73kHaqC/0WGXjwtoQW9MYFNFbkdHbdoqkogBsc3cCs+mNJ43SxI/L/L
	 KStZHwCS8mILh9qJZb4yrNnchLruDQ7cwzEKUmy5PTpA4iPFCsMEETWqH0Nc7Q5l19
	 0M40rc0PRU3LQ5aI7FuwoI9hfQ1HU9vt8cBJtf00TWXZMeKqb1oJhmRpQni0gQS1nV
	 AylwBAiDuaW9VidnPTnADPq3wm2R96ldR+SQRvbwY9ZZ/GTu3m/+CfipRZ3jGaQEgi
	 yYeBtcAuVFzDszt0wUJ0iQfqBq7e3Kt05C9Su9kYfz9m1Zrou/Pnbu46BZF7flsn8Q
	 xpW1A4PFBdVSw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6598413b604so2907738eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 12:56:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+dTYMKsx8ogudahw+6mosPhKk4XWi2VMFdtGhNqlcVN4MktOzt+foUvVrKZSkCy4Kt4TRnsrSFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNx0VKgvVY3nGQ4cVZsrWS9v1KubaQ49P2KmT6EF0V+0VamgOH
	lxGBgZ7eLA2nlfzA66pnXrnWPsRHpqt1Oo/Al2NI4Xr+uuwEzFvTDCRF7wNgROlrxtMKHB2zmZ0
	+DQWSC7N27HSNZa07G8cBmzVxz1haxDw=
X-Google-Smtp-Source: AGHT+IHfp00jpCrZg4kIgLQb8tvneq3ssBxjruCcQfk/MOrqA8hYG2CMMT6YC/9JUITkpI0f1T8BfOsWXODahB9jthg=
X-Received: by 2002:a05:6820:658a:b0:65f:1296:7690 with SMTP id
 006d021491bc7-65f5508802dmr4657451eaf.83.1767992191542; Fri, 09 Jan 2026
 12:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71f63cb7-2d9b-49a3-9b04-a47e2edef5e0@arm.com>
In-Reply-To: <71f63cb7-2d9b-49a3-9b04-a47e2edef5e0@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 21:56:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gojPS-vb_5yAKjvAQwy6+WCpG-S3MU0RJogpzZ759XMQ@mail.gmail.com>
X-Gm-Features: AQt7F2rP5J7Fj95B6JapBS8wZ0zr03L8ZeP8bnfi1uG8XQzi2OAWpy2UQa13WiQ
Message-ID: <CAJZ5v0gojPS-vb_5yAKjvAQwy6+WCpG-S3MU0RJogpzZ759XMQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as cpuidle reviewer
To: Christian Loehle <christian.loehle@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:37=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> I've been reviewing cpuidle changes, for governors in particular, for
> the last couple of years and will continue to do so.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 765ad2daa218..ea1d4c85b865 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6554,6 +6554,7 @@ F:        rust/kernel/cpu.rs
>  CPU IDLE TIME MANAGEMENT FRAMEWORK
>  M:     "Rafael J. Wysocki" <rafael@kernel.org>
>  M:     Daniel Lezcano <daniel.lezcano@linaro.org>
> +R:     Christian Loehle <christian.loehle@arm.com>
>  L:     linux-pm@vger.kernel.org
>  S:     Maintained
>  B:     https://bugzilla.kernel.org
> --

Applied, thanks!

