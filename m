Return-Path: <linux-pm+bounces-13564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A596BC91
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FB8B23BA1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E311D9D62;
	Wed,  4 Sep 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiqVLHbS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37F1D935D;
	Wed,  4 Sep 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453544; cv=none; b=FS+zmWZhNYpr1zHVhVxW+dSXQmr33A9x9w0dNsh25vz0RAcMTWRGsiCRdXNynJ3W8nWMYEw1S0jQUi/FHt+OZvt510iOhvwJVDwk+tkK0Y73rLq+3VlBICgBjpSEgvJMG9/Kzi7V3ezKYcYIudBiEHmZA0Q86eLVyw0FM0Lv6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453544; c=relaxed/simple;
	bh=+Jr9s9B+xtckA4J4nfQj1cPdaXghEqXj3TPABoG+KGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9HN9ZeddgS56O7eq1kj7xMRBZTvbO08gKQ+oLkvmrGrcJMoq2P+CH4cSpc0v7LGmG/qylQkWqD2mymUUJCJXltjoEq+2Dgsuc7KFB4LnWCq0V+Bxj3CgeDKjM61Z+tSwV4cB0yH7tp9X549TUBvrPPItwrBhmn3+AYoIKeD6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiqVLHbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEE2C4CEC2;
	Wed,  4 Sep 2024 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725453544;
	bh=+Jr9s9B+xtckA4J4nfQj1cPdaXghEqXj3TPABoG+KGg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NiqVLHbSMD2MIzszchmpc6rhR2fhp0GLyZTFuXmvUSiAKM7Y9UTO8nYHqsAHkMtY+
	 nmdmxE2VQkAtJdXshmptwYH7tNf43gSzyrhhYS3JqHyRrmdiZJDbfpzfgibTiLV85S
	 FX7qimyGCGi0Hiy4KbVnvNq/4Tv4aHFtLMqufeKMigOG+lsiN6t5WVqfXx+jt7K2Sv
	 vn5CwPPU9iittVau1chuGCYgkEuQ6Az5uWA4s2ETruTak0Q84CzZok6klzrhHqnnGs
	 ZiyriaUFtETWR4xhwhWICIY1S87EDnPtaHVCjJMzRBwciTNTQGINg18dsVrs7AqspD
	 dA7iLa9McJIWA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-277f19ee2a2so1719469fac.1;
        Wed, 04 Sep 2024 05:39:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU31ZocLCtiCbv2FMln2IKtVmeEK+UDPDnLDGobDFf60lijVopn78X7b2KXfGTKtkvm70SiXr4BjHRNZTw=@vger.kernel.org, AJvYcCXC6AclNTycXOlvcDSZ/NYhljqa8ieWo8RxcW6sKEemgNfb5zMVV3+PMp6LYupawq0pDahj/BIQYD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8HIj6sKmwxrg5KdRwnwxYg6e/jlRs7PeBr2jLwa0AtHwoRY8
	2bgDg8ZLOeNk44vLBWx1F6qTwNSTsofp1FxIhX/w87vkspMljNWVNMWYLbKlBegrTq3n/e1SQ4N
	wO6TwH+LO7+rxjAIv/qObbkCijcc=
X-Google-Smtp-Source: AGHT+IFhGBnFxPcLvPZtSBwEOsfLlzoe0vk52Or7lW5q35KGkeYf6Lg9D+a9umxvopAzEQM12b7t7F8cT6gNu4/ro+U=
X-Received: by 2002:a05:6871:8c15:b0:277:eb79:b4fb with SMTP id
 586e51a60fabf-277eb79b8aamr8429970fac.1.1725453543333; Wed, 04 Sep 2024
 05:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903172520.3568731-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240903172520.3568731-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 14:38:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h20btyh41vHsXgMDhDrhPGL-CJJNUjzLhgj7Szj3y6Qg@mail.gmail.com>
Message-ID: <CAJZ5v0h20btyh41vHsXgMDhDrhPGL-CJJNUjzLhgj7Szj3y6Qg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: PM: Discourage use of deprecated macros
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 7:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The Documentation refers to some deprecated macros.
> Update those parts accordingly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/power/pci.rst        | 11 +++++------
>  Documentation/power/runtime_pm.rst |  4 ++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index e2c1fb8a569a..9ebecb7b00b2 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -979,18 +979,17 @@ subsections can be defined as a separate function, =
it often is convenient to
>  point two or more members of struct dev_pm_ops to the same routine.  The=
re are
>  a few convenience macros that can be used for this purpose.
>
> -The SIMPLE_DEV_PM_OPS macro declares a struct dev_pm_ops object with one
> +The DEFINE_SIMPLE_DEV_PM_OPS() declares a struct dev_pm_ops object with =
one
>  suspend routine pointed to by the .suspend(), .freeze(), and .poweroff()
>  members and one resume routine pointed to by the .resume(), .thaw(), and
>  .restore() members.  The other function pointers in this struct dev_pm_o=
ps are
>  unset.
>
> -The UNIVERSAL_DEV_PM_OPS macro is similar to SIMPLE_DEV_PM_OPS, but it
> -additionally sets the .runtime_resume() pointer to the same value as
> -.resume() (and .thaw(), and .restore()) and the .runtime_suspend() point=
er to
> -the same value as .suspend() (and .freeze() and .poweroff()).
> +The DEFINE_RUNTIME_DEV_PM_OPS() is similar to DEFINE_SIMPLE_DEV_PM_OPS()=
, but it
> +additionally sets the .runtime_resume() pointer to pm_runtime_force_resu=
me()
> +and the .runtime_suspend() pointer to pm_runtime_force_suspend().
>
> -The SET_SYSTEM_SLEEP_PM_OPS can be used inside of a declaration of struc=
t
> +The SYSTEM_SLEEP_PM_OPS() can be used inside of a declaration of struct
>  dev_pm_ops to indicate that one suspend routine is to be pointed to by t=
he
>  .suspend(), .freeze(), and .poweroff() members and one resume routine is=
 to
>  be pointed to by the .resume(), .thaw(), and .restore() members.
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 5c4e730f38d0..53d1996460ab 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -811,8 +811,8 @@ subsystem-level dev_pm_ops structure.
>
>  Device drivers that wish to use the same function as a system suspend, f=
reeze,
>  poweroff and runtime suspend callback, and similarly for system resume, =
thaw,
> -restore, and runtime resume, can achieve this with the help of the
> -UNIVERSAL_DEV_PM_OPS macro defined in include/linux/pm.h (possibly setti=
ng its
> +restore, and runtime resume, can achieve similar behaviour with the help=
 of the
> +DEFINE_RUNTIME_DEV_PM_OPS() defined in include/linux/pm_runtime.h (possi=
bly setting its
>  last argument to NULL).
>
>  8. "No-Callback" Devices
> --

Applied as 6.12 material, thanks!

