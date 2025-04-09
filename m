Return-Path: <linux-pm+bounces-25029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18082A82E24
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EFA1B64F35
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D41DAC81;
	Wed,  9 Apr 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTAls09I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58421D5CFB;
	Wed,  9 Apr 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221825; cv=none; b=J0F98GmhT50kZmLGFjnYzTQgtN5BiEgGT7kOXvDfVakvkTD1b6ISqmvCTtx1WQFF585yTCWmJrbKMrgdsDfRsDcLzkEbBrbvE1zce55E2afFCZ9S0p1NuIz8Oub1vmQ7mQDKCBJXDpTsUqVtGd0ZEGjyzgLnmIkkG7rBeYQRQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221825; c=relaxed/simple;
	bh=beF43QTtLBcEXHFOSPsDPsG0F3tobprg5LXysQZBxUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfihTQYXa3CvghLVZBAkNKy3tHvra24xRxh004Ba6FuNRCKN4W3hv/NZICikc4jpTC+F9VJeHLgdk1d7h8d7izXXvmK0GsuFWlHC40VPh1h4Plp4gFlPxIlv9KyN0XsOslUBq3Y+nI/EZnoNTijGA3X9mVia+5A6KWYEL4pAebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTAls09I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF8DC4CEEA;
	Wed,  9 Apr 2025 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744221825;
	bh=beF43QTtLBcEXHFOSPsDPsG0F3tobprg5LXysQZBxUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nTAls09IDlS6wtRhmIxh5iQsjSOBxMV1MxOIbOT4l5gP7pTPy1CIFgpfAFX992slS
	 R5gaz0i88jjmUMNWbazzyAPJfpc4/90KRRDf9fykSJ5yASEDejA84SDjvQiixwAobs
	 hYYwnoCbywyLSN19E9i9xb/l0iyDaLIduIzuekY3qU/GIPTiK6i8oI7Gm7Ac0TC/5q
	 jyMGBhpezUxDbPvWYsFpuLObqLKv+Opb/0w86E6cQwBbz+I0mpGbATbJG5jfhi2WEt
	 77bOmws2x85cU7oiJcfGksRw+mDQOpETPi0w+YzXjlTWHi4Mjrq67BQfdT9ebQWqAP
	 7jejj3e61TBmw==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72c7332128eso3416296a34.0;
        Wed, 09 Apr 2025 11:03:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVraTWCMegCPvoT6sohlnPQCuxIttvoKN674nqXLtWsK9L3V/ynTBMZ66XDHeUiPxd7d1nzQI2D2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1gnIezaUMiA+7fejDcuDUCuKBcQOEEDQb+STHD3oyvQouByN
	/itd6uIASwBjXR8TZV/iAI8DHNNfFkT9Fz4GYqqjQHW0YHoblhyP7lM1AHTqwLIdgYh4XRUITqC
	s5H4d9JSqjf0Vg6QZ3R957c58vWk=
X-Google-Smtp-Source: AGHT+IGLSKRhqcySvr9QbJxmOMam7vhMihukLj3wyv5cBCj3WQDVHK8WYihqAWexdFMptO5fCgfY2exP6tJLnEUYnHE=
X-Received: by 2002:a05:6830:6e8f:b0:72b:8000:d487 with SMTP id
 46e09a7af769-72e7097e4c0mr2736110a34.3.1744221824431; Wed, 09 Apr 2025
 11:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com> <20250317-plat2faux_dev-v1-1-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-1-5fe67c085ad5@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 20:03:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcRDJFJtnPY+sszkUEYsdqxfm194Y7=namkD0qYnokHg@mail.gmail.com>
X-Gm-Features: ATxdqUH16sk76q1TprR5rmD7OXOk9OZ_3eVvur3LH6RENjBtxS15NFQO1G9ITzs
Message-ID: <CAJZ5v0gcRDJFJtnPY+sszkUEYsdqxfm194Y7=namkD0qYnokHg@mail.gmail.com>
Subject: Re: [PATCH 1/9] cpuidle: psci: Transition to the faux device interface
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:13=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com=
> wrote:
>
> The PSCI cpuidle driver does not require the creation of a platform
> device. Originally, this approach was chosen for simplicity when the
> driver was first implemented.
>
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Do you want me to pick up this one?

> ---
>  drivers/cpuidle/cpuidle-psci.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psc=
i.c
> index 2562dc001fc1de69732ef28f383d2809262a3d96..3e38f712dab3785d5caa8d103=
fd0146156005921 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -16,7 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>  #include <linux/psci.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -404,14 +404,14 @@ static int psci_idle_init_cpu(struct device *dev, i=
nt cpu)
>   * to register cpuidle driver then rollback to cancel all CPUs
>   * registration.
>   */
> -static int psci_cpuidle_probe(struct platform_device *pdev)
> +static int psci_cpuidle_probe(struct faux_device *fdev)
>  {
>         int cpu, ret;
>         struct cpuidle_driver *drv;
>         struct cpuidle_device *dev;
>
>         for_each_possible_cpu(cpu) {
> -               ret =3D psci_idle_init_cpu(&pdev->dev, cpu);
> +               ret =3D psci_idle_init_cpu(&fdev->dev, cpu);
>                 if (ret)
>                         goto out_fail;
>         }
> @@ -431,26 +431,18 @@ static int psci_cpuidle_probe(struct platform_devic=
e *pdev)
>         return ret;
>  }
>
> -static struct platform_driver psci_cpuidle_driver =3D {
> +static struct faux_device_ops psci_cpuidle_ops =3D {
>         .probe =3D psci_cpuidle_probe,
> -       .driver =3D {
> -               .name =3D "psci-cpuidle",
> -       },
>  };
>
>  static int __init psci_idle_init(void)
>  {
> -       struct platform_device *pdev;
> -       int ret;
> +       struct faux_device *fdev;
>
> -       ret =3D platform_driver_register(&psci_cpuidle_driver);
> -       if (ret)
> -               return ret;
> -
> -       pdev =3D platform_device_register_simple("psci-cpuidle", -1, NULL=
, 0);
> -       if (IS_ERR(pdev)) {
> -               platform_driver_unregister(&psci_cpuidle_driver);
> -               return PTR_ERR(pdev);
> +       fdev =3D faux_device_create("psci-cpuidle", NULL, &psci_cpuidle_o=
ps);
> +       if (!fdev) {
> +               pr_err("Failed to create psci-cpuidle device\n");
> +               return -ENODEV;
>         }
>
>         return 0;
>
> --
> 2.34.1
>

