Return-Path: <linux-pm+bounces-16796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0A49B71F0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 02:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D4B2852DC
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 01:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990347E59A;
	Thu, 31 Oct 2024 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaFxrc0h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A45FB9C;
	Thu, 31 Oct 2024 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338206; cv=none; b=ZdXWlnaxBxu7I+NCapHWtiug34IksjC297AKO11rtcz9hqFj2x0QxdwKw+Gz91lobqJK6rSQjpCqPWc5a0LnKshJr5tNnqPwEVQx8/AwUfD+IFNX1jkTwzp2eQq3qR2bxNSVr2H8wPSmusxIfCaBLJ9ZzAQ/CMUsarUxJyQGgPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338206; c=relaxed/simple;
	bh=F3CW6MgCDGBSbZPQG4EYQBGr36Y639uygD33OcwKI7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1h9yj1DRu5munrQksMsq41CGFkMmYYL9ule+gfRz+rU/ITxjojgBdThkdvfepNCIHyC3IH8slZQLbzZ/heY5VznRbWMRiLLJOId57d0vVY0dyYIi47CPCpixI5Gngw0+ZnBBufEitMnnQZj9g8YelUe0DtjAaM1uUo4SV4/igs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaFxrc0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CA7C4CED2;
	Thu, 31 Oct 2024 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730338206;
	bh=F3CW6MgCDGBSbZPQG4EYQBGr36Y639uygD33OcwKI7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XaFxrc0hQxfxAaTDwz22wAC7xgyqcXbewHasugJkhScj0LGN6soj3hIn70HVRoToJ
	 qR0QJnEjIrlhxUTLJycz6po6DXlLs45ALEfjd0yR+IqoD3KWnexKLR+KfKp2E300G1
	 TczsFcNwBr124tUPxwwYsuyUQH6T1P8v8I2ZcEOh0Q4Cxy8klpl2QbKDcQcVDMzY1V
	 /d3/zNYrtYcWlSyGP2YjuTtXB2uFPy54vZJpm7eK4cXwhAEIbm+8BmSyPAf7Cfa92s
	 ujlUa/iXD81Lya0g5DmeRQr4CvvHqDOeqUwuY5ESmNExPD5efiRw44C+HmOmyBBQlY
	 JSnbJyxxg9qpQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f58c68c5so763339e87.3;
        Wed, 30 Oct 2024 18:30:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvuocDyyeidIJ6PBFegZ1ttv7jiB+Ns197sq9gtFtZTTdDRbPTcbznDFEw07dmD9ybDb2/+IUBQ+ZO3F8=@vger.kernel.org, AJvYcCWkm4rSmNTTljFTcCc+pc05kIvNPg3FYwJ0zlGeAVnsY37pnjdugqDstGWRWJeymCXbOLUsAnR6uQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqG15rJSP+TP5OEp/HjYWpo+PGOYmJM9xNYlE6pZ3JVFMfz4p
	npS5ntKe/Dow+CEvimXebwuUnx1P/dLk2TSKx/KFLqhUUg31if7YFZnT8Wb0oGnUyVQ6jHTf+QQ
	fr7+Gg9blesar1DQKtWTwLUK2czE=
X-Google-Smtp-Source: AGHT+IES1QEWCyXEfu2GgQIWkNKG5wwIdsKbTeplBpmPclxpxRZ8rjzg8Uh1GIdkLH+yO4jm648v1k5qv5FFrNoYWQg=
X-Received: by 2002:a05:6512:3b97:b0:533:71f:3a3d with SMTP id
 2adb3069b0e04-53b348da746mr13964158e87.24.1730338204411; Wed, 30 Oct 2024
 18:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030162930.2111255-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241030162930.2111255-1-andriy.shevchenko@linux.intel.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 31 Oct 2024 09:29:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6bOZLur8Eq2CyFaeQp7R1LwiRqf0ODqnftg6+zAbDoYg@mail.gmail.com>
Message-ID: <CAAhV-H6bOZLur8Eq2CyFaeQp7R1LwiRqf0ODqnftg6+zAbDoYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cpufreq: loongson: Check for error code from
 devm_mutex_init() call
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andy,

On Thu, Oct 31, 2024 at 12:29=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Even if it's not critical, the avoidance of checking the error code
> from devm_mutex_init() call today diminishes the point of using devm
> variant of it. Tomorrow it may even leak something. Add the missed
> check.
>
> Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/cpufreq/loongson3_cpufreq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongs=
on3_cpufreq.c
> index 61ebebf69455..bd34bf0fafa5 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -346,8 +346,11 @@ static int loongson3_cpufreq_probe(struct platform_d=
evice *pdev)
>  {
>         int i, ret;
>
> -       for (i =3D 0; i < MAX_PACKAGES; i++)
> -               devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> +       for (i =3D 0; i < MAX_PACKAGES; i++) {
> +               ret =3D devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> +               if (ret)
Good catch, but I think "if (ret < 0)" is better? Sometimes a positive
return value is legal, even if not in this case.

And it is better to use loongson3 rather than loongson because there
is another loongson2 driver.

Huacai

> +                       return ret;
> +       }
>
>         ret =3D do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
>         if (ret <=3D 0)
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
>

