Return-Path: <linux-pm+bounces-38049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE4C5E987
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D9083E0C16
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC332E69F;
	Fri, 14 Nov 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed7Qw6R6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C632E694
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136688; cv=none; b=q0frNh1rGHIady2RC4bhStmybhE8/45RCvsAR4VHVS5epXxsMOUcnETxDXH/YTAPnx4jryqT81ZmiqHWNZQphFxyBiXlCALaonpXMirEWWZT6IZHHkKNnO3AsVrGwOkixbgV9f39Uf/NieDL08f/FJfswF8u/Elk8WvPC/5GCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136688; c=relaxed/simple;
	bh=UF5bCjNDENBmgs2z4GMRiZcWwPYNZxMzi9mBqeh/7VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXIk+QN8SYWbMQCzyJSmZg0UhM396tpk5KVSL2tNkj7tbgUTWoDKDLpJ+vOxQPexsfyYNdYlr32NCXhTUDyzlhJ7C9I3IPfofx9RucZTKzo/Imae013fSecEQxWUoX23zAhUo+E5oYe2zxQBM726kVU0Ro7huYn4r/cg48KdXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed7Qw6R6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A210C4CEF1
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763136688;
	bh=UF5bCjNDENBmgs2z4GMRiZcWwPYNZxMzi9mBqeh/7VU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ed7Qw6R6nLnwTNEDpQq9zi6nPwdhBGmnf8wYG+CYrNAH3qiuvBuPXejXW9Mttn50X
	 oGqOzkU4qVAUf7ix217dfa//p2Kspt+3Rj0Bi1AEFdhXD6nEOjAIwx/9LyuVv3u9u1
	 dNdTXRhiLXzvRuqlTWz32RoQOTQP9bPOr83gZ89l3vjjDcX30E5dy+Du5SYPDCaSyd
	 83Uq2NxWs6P1mvLBwbTBmrVw3b8lribPf56yAFkZqnw1NMIPNtU92QX78RVg3bm2SZ
	 FrgPOB0uThMjtguOdyyll6qypx1odbGH3VkU23DRIfP/vKNNy/Si6zrU5NFURIECud
	 5u+M5k2dwNdjg==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c284d4867eso682570a34.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 08:11:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOR1BitJBvq3qswVbp6uqQPu4zsdTkM5mG1RnTRvD9p7SBbTUYl3+zecOdbOkctNHO1eT7XbhquQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSK4Sv9BIhWUzPU0W4961L7hvbUBsu0JdoxdUOIuJlnrcEckx3
	yWTFphTTqQ8uecQnwDAo7QnkIaBwgNQSGbi0Z5ayoymYdIz/xg+dRimUA/XeGiTjqPchhXK+ROE
	F7dXfyNt/auPe8CZiCNN78WUvag+I2Ko=
X-Google-Smtp-Source: AGHT+IGC3vRVh1NEB42EzeB0SqeJdvJvRJfnCJCmVrFluGylCsR+WxU/CRu3lDJUZplFmMqQXvTzqJZfMtqLTeslsaY=
X-Received: by 2002:a05:6808:10d3:b0:443:a155:d833 with SMTP id
 5614622812f47-4509757ae19mr1481653b6e.42.1763136687658; Fri, 14 Nov 2025
 08:11:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113012638.1362013-1-luriwen@kylinos.cn>
In-Reply-To: <20251113012638.1362013-1-luriwen@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 17:11:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hwhVO6J2nS2-byU0+Lm8QbzdBzv4-X4eLNNUpTg+41Kg@mail.gmail.com>
X-Gm-Features: AWmQ_bm7tMPOJfTDde1--fL7RH1HAnLn5OWTI3oBkP55X0JQvuowwM9CLpRgMWE
Message-ID: <CAJZ5v0hwhVO6J2nS2-byU0+Lm8QbzdBzv4-X4eLNNUpTg+41Kg@mail.gmail.com>
Subject: Re: [PATCH v3] PM: suspend: Make pm_test delay interruptible by
 wakeup events
To: Riwen Lu <luriwen@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiongxin <xiongxin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:26=E2=80=AFAM Riwen Lu <luriwen@kylinos.cn> wrote=
:
>
> Modify the suspend_test() function to make the test delay can be
> interrupted by wakeup events.
>
> This improves the responsiveness of the system during suspend testing
> when wakeup events occur, allowing the suspend process to proceed
> without waiting for the full test delay to complete when wakeup events
> are detected.
>
> Additionally, using msleep() instead of mdelay() avoids potential soft
> lockup "CPU stuck" issues when long test delays are configured.
>
> Co-developed-by: xiongxin <xiongxin@kylinos.cn>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>  kernel/power/suspend.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index b4ca17c2fecf..1c2f777da367 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -344,10 +344,14 @@ MODULE_PARM_DESC(pm_test_delay,
>  static int suspend_test(int level)
>  {
>  #ifdef CONFIG_PM_DEBUG
> +       int i;
> +
>         if (pm_test_level =3D=3D level) {
>                 pr_info("suspend debug: Waiting for %d second(s).\n",
>                                 pm_test_delay);
> -               mdelay(pm_test_delay * 1000);
> +               for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending(); =
i++)
> +                       msleep(1000);
> +
>                 return 1;
>         }
>  #endif /* !CONFIG_PM_DEBUG */
> --

Applied as 6.19 material, thanks!

