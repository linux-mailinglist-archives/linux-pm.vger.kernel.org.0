Return-Path: <linux-pm+bounces-37879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC64C546B2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 21:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E5F3A7C69
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 20:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881BA2C21E2;
	Wed, 12 Nov 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRsbEJHX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D272C17B4
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978827; cv=none; b=rULcAcLDn7m/gnJr9nNOeUfG8vOA8XcWXZ7yxeADtmptK9VQojlRUsiivZraXaAOcG/P1bhtOOr1Ob9lnGqKe7rQ4a9asRWatUoev47RGh/5bzln0qG5nMVYzgpC0undgvGltEHG1enL/9qiF7d9Byk6Cwr2IjEru0uFYx5k2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978827; c=relaxed/simple;
	bh=Qeo9aHn3CQrAoVrazqXz8CGRHXh8hkmtGDI+H25IESI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hd1m+QLTbsDoy60BE7TX1Xmnw6G1yW3g+gjfW1V5fcsA/+jFMjINJbjOf/A71ad4A1Yav88Q8/3rRI4zmFGYwAK6jq2B0SeXCMtmHtjuOEoSq9i9mXYQp/HYhrio9MaJU2F/whlKPCg4Sdsxgra0t35uKeRdo0RL3+nd7JFFmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRsbEJHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01605C113D0
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762978827;
	bh=Qeo9aHn3CQrAoVrazqXz8CGRHXh8hkmtGDI+H25IESI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qRsbEJHXf4QulqlxR8dmZA5KoKsY4wsTFBoI9Jx8Z0f4PT0qNbrvqSpUfGMBRnTI1
	 Ha7CZHAEQZzpRE7L4fZediyDulYW8uoaJiQ7i+74z7+eLXPwwulqh6zIZHdiXk2sA/
	 Rdn7qNb7c3P1t7qtJdu0v39KkQHIhJmC5SyM4bUV0HYOqReJxRFnLIJREIZehduI8Y
	 DWIQY6lQVlMBbFZY6dTp9raMsmr7xS/fBBmek87ScaFWFcfVLw2Yoora8dg930pKde
	 EGm3s+4nPGlXSh3Mi866SQEr51sYbDchdFz9N7XozKkL6piKXJAq43LSb4nNOTbeJ9
	 eHiDjaiucFzZA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4505ade79c2so16868b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 12:20:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXirnWUGLGYnecEft182q/4KIrcyCWZvWjQR5RoKkpLU2CKvWPYr2SHTjQCgxCCo4UxqsGQoXOXZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJY4J2x2uzbh8EdrAenN7EME9yhwJrv3OG/XYaTjeFuf0U9XYW
	lYGBDalP2IcNKzcmB/A6IEgP3RqQj7ecjEMvm8hOt6Dt4kVqtBJtIzznvECyrHAhGzkh6BXwvab
	cvahm1kIemCxyUCal3FhnleTWSGO/sTE=
X-Google-Smtp-Source: AGHT+IGLAbCGoAJqBEIJCopoA5S9ObG1EhGOks1U7N4nzFZ5JFU7tcvXYcmonUdu9hjgKAe8nPCDOXdFQtMcvhu8zqs=
X-Received: by 2002:a05:6808:218e:b0:44d:aa6b:a578 with SMTP id
 5614622812f47-450745ccfbdmr2271145b6e.66.1762978826269; Wed, 12 Nov 2025
 12:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106011909.2189279-1-luriwen@kylinos.cn>
In-Reply-To: <20251106011909.2189279-1-luriwen@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 21:20:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-FtZ3gOmP8yVFAbWFzNijRY0MHUxUnqtqBT+rvpwjOQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkJzo0PSrW171LCOutPyZ9KH-EcJS1xmXxaO3-QkO2F--p2kKyf2aoMBsQ
Message-ID: <CAJZ5v0h-FtZ3gOmP8yVFAbWFzNijRY0MHUxUnqtqBT+rvpwjOQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: suspend: Make pm_test delay interruptible by
 wakeup events
To: Riwen Lu <luriwen@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiongxin <xiongxin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:19=E2=80=AFAM Riwen Lu <luriwen@kylinos.cn> wrote:
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
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>

This is confusing.

If you send somebody else's patch, there needs to be a From: header
pointing to them in addition to the S-o-b tag.

If you collaborated with somebody else on this patch, there needs to
be a Co-developed-by: tag pointing to them in addition to the S-o-b
tag.

If none of the above is the case, the additional S-o-b tag should not
be present.

Thanks!

> ---
>  kernel/power/suspend.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 4bb4686c1c08..a8e80ba8ac2c 100644
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
> 2.25.1
>

