Return-Path: <linux-pm+bounces-8798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B4900C2E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 20:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799D2B2496E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FBB143756;
	Fri,  7 Jun 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOXKifFL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC54204F;
	Fri,  7 Jun 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786710; cv=none; b=XY4xjJvtDilAaDRlI6Bi6l5JcGKOFCZ3al0w9ZxKH4gtQDB0shFPuhsqc2ZbuR3wSbmA7zrIv4a/oL4SaRDL0Ucjzvjlps8Ht/BuPzmI8DGnyaaGfl/nln+2bi5+Zg3fneDC6yaPKKXJlJEFKARrrog3fdT5QdfK0/b0gJ/fKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786710; c=relaxed/simple;
	bh=YVTm9rx3hAIDwiIpXyJ3t35LjCIU0Wrud/PJ+L0hRAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbyAYhGYZNW90z5lJYNnvSq4iDI19wgUEittKupTktBgYv4z+f0EqdehQuqHUlMNfcc92TiOCVhJLrzhdw42APwRkiitO+mAnAOXMQsHfiPQFkgIubKtcu/o26pHq/6ZBe8VLTX0DRlxkNekuqlsJ8LdZikC8SC/n9zbOpPEgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOXKifFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4830C2BBFC;
	Fri,  7 Jun 2024 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717786709;
	bh=YVTm9rx3hAIDwiIpXyJ3t35LjCIU0Wrud/PJ+L0hRAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YOXKifFLgh1ZwqWzgL1zO3O1tqr3aZniW/A8l/E5vc9ZlYhbhB2DrXCw1o+7TZYtF
	 YHmdib2DG5g7XI5I55qAjKl2ft0FLnuxLzfcDy7pnd57tSC0ZtSBjBX6iEonQZc8jy
	 ZZug2odzQSxDzrvJjyidTkV+TBoGj2jixdjwmnegYUCCr11h8amaTJ7KCybpFucGZV
	 L7o/Zxo3N1kAwYHS1/72TIleKAWPFX/5BL83KfoRBoGb+7yM+PmoslBy+X8rdN5t95
	 KdGqLLLZ4JHRAKwfAV9F9OzVwr9cxk9RkgkK6ML7dZaCgtqXY5204pkD2yTu/w3Opv
	 0RPIjjWIt+Low==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d21cb3833cso164b6e.2;
        Fri, 07 Jun 2024 11:58:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXSmD4EfwccQ46kuD5vYSUcOpw9yqBioMfuuBplHQ9PErj89wDoARdYM02zLk1N2flQt+HEf0PvxlwEi2HDDWMXA6RqXj05lW146wXxyH5Pr2BWcA/OjmrSWIeqm8OkUwxWPZtR2k=
X-Gm-Message-State: AOJu0YywVtN71rvu6GQMjKS6+4c+H8YImGIlgbFjBWPbvZrc2abGbFbG
	LgHuRLTt9Slumg5qNNrDwKrD73j6kwVV3QYeMTNlxg+QszlH4aTXy7bH1ZZ7yEv8VWMCpNpOb+J
	Q7AqlB/GyUN2VD1TIRhwjsVxKUeA=
X-Google-Smtp-Source: AGHT+IGw5cRrg2vCKWwrVtK4aJ1gOUjrrLKAIr3heL058J6se6B98dIXlZo0HBZoAj9H51KF/LHUNOw+tW2ziMwSNpU=
X-Received: by 2002:a4a:a788:0:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5baca8a70b5mr1596823eaf.0.1717786709173; Fri, 07 Jun 2024
 11:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605135841.97446-1-thorsten.blum@toblux.com>
In-Reply-To: <20240605135841.97446-1-thorsten.blum@toblux.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 20:58:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQi_7LQWRSXngxAwByKKDcikRx4Vu9Mjj86dMqCTzMCQ@mail.gmail.com>
Message-ID: <CAJZ5v0jQi_7LQWRSXngxAwByKKDcikRx4Vu9Mjj86dMqCTzMCQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: idle_inject: Simplify if condition
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 3:59=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux.=
com> wrote:
>
> The if condition !A || A && B can be simplified to !A || B.
>
> Fixes the following Coccinelle/coccicheck warning reported by
> excluded_middle.cocci:
>
>         WARNING !A || A && B is equivalent to !A || B
>
> Compile-tested only.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  drivers/powercap/idle_inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_injec=
t.c
> index e18a2cc4e46a..bafc59904ed3 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -127,7 +127,7 @@ static enum hrtimer_restart idle_inject_timer_fn(stru=
ct hrtimer *timer)
>         struct idle_inject_device *ii_dev =3D
>                 container_of(timer, struct idle_inject_device, timer);
>
> -       if (!ii_dev->update || (ii_dev->update && ii_dev->update()))
> +       if (!ii_dev->update || ii_dev->update())
>                 idle_inject_wakeup(ii_dev);
>
>         duration_us =3D READ_ONCE(ii_dev->run_duration_us);
> --

Applied as 6.11 material, thanks!

