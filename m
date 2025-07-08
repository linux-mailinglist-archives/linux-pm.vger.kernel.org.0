Return-Path: <linux-pm+bounces-30373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834D6AFCDDC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 16:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D772D3B80C4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE292D8DA8;
	Tue,  8 Jul 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFzV81ts"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297A207669;
	Tue,  8 Jul 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985513; cv=none; b=hLIBIkGaZyoiQWsYTI7QAh4roGIHk7wTV4bfDcZ1bpqdOTGxm1BFrgOhxQyGlTvhjFLCjF68+1koIYHnk7ziiU5DI4kVwYTYavWs5W3TDV8mA1coCKq41O9p1WP4hyU5yrktuWkAgp8GyGrPSydvIhO+/3cCVkMsak0q57Jhha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985513; c=relaxed/simple;
	bh=9BWhMjraB4vk+6Le52s2xMvqWl10R7LW8tT5ANBlkQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKBvjfyWqDj3WnQ/xEUapkQZjg8k4cMh8Gmx4B/vb//YsBT16/Kc8JL1e41CYjPKYr7U0UXLX3/ERTNgrJyOit+dmF5rcK/sPSnzeV0jghVXJ6iBQsVm9TYUcgp6OfzfPdEOfOQg4JhWUmu23rhyw64uB0HUKPouAk7hSeRHKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFzV81ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4223AC4CEFA;
	Tue,  8 Jul 2025 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985512;
	bh=9BWhMjraB4vk+6Le52s2xMvqWl10R7LW8tT5ANBlkQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dFzV81tspRIa3CEsSB9Q74gFSuD6T7CP/PneoV/I0EIQgL7yhp2y1GYRS3epqeYgx
	 3ojPEZBj8aHZvbS6h9zEZQhotvVhAVd5sN8clj1xhYUAUzZ9jbJmZWDy68RFT38IWE
	 OtzpDVnvSssdvr7UOkTyWR6giYLgv4tlqh+dO1L0Bq9YstX6dql8ouk9P817s3GrYn
	 1wZhHyucr2ITOVea8LzKo/7bKJy33zbX/IwYOUPE/6oLd8GVgvsB/WX4/ohQTx0dz2
	 7GJjYInQwT8Xj1ca739inKdPucu6/6kyYhjCNcOeftbrFyGdUKEIPItDuD5szOJiBC
	 d7GTOwhjsLCug==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-613a6e39f52so1144428eaf.3;
        Tue, 08 Jul 2025 07:38:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7mLKIXdi1yRp3+TncIcHwMJtS4fL7J3c1Yb/43Ea2pmLx7jC5mun9Fg7weS074XKDUa/S5aNM+gcLP/5G@vger.kernel.org, AJvYcCVrNSvBj1wU+gHluRBmkMJDUkmCIAdpTkc+qijeYEJ87aNKVy41rZThn9JEihH6Q1av4phO3y2t8yU=@vger.kernel.org, AJvYcCXl+Pdjc/oluXodCa9eJVJUVkWCB55aDTrD2aWkRb4WfBNyRJ1qz3sawoFiIKbZRocBpjB6EVq2tKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbG3ZNh0lke3Orl1CMtjYqc9WWFWvN5mjuflVdEF/VBESQNH6
	N8DHQHQrgxkAYfRkG3L88JX+uMNuRr1SboMzOy2AkcztuzYqlD2hVRPwz1T0JeFwzidjK2qUb7L
	zmmv4PdxEUzqDFhsBHJ5BGJ61sTEF+hM=
X-Google-Smtp-Source: AGHT+IFv73u9dDnx+yNNHigzU8NEvuUzjF9dVqQp8XMNcyJXTW9T1kRfBlPhMliEv2SNGkiAznuTib7tkriv9vnN/WI=
X-Received: by 2002:a05:6820:4d0a:b0:613:bfa6:2130 with SMTP id
 006d021491bc7-613bfa62307mr3102626eaf.8.1751985511402; Tue, 08 Jul 2025
 07:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708-pm-async-off-v1-1-1b200cc03d9c@linaro.org>
In-Reply-To: <20250708-pm-async-off-v1-1-1b200cc03d9c@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jul 2025 16:38:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMk+Jt5WBUB=+cvv2YoU+49nRxL4KPRGm9TAdzkUvQhQ@mail.gmail.com>
X-Gm-Features: Ac12FXzC0PRSkm_cnKrA4OLmQUCv8hAsap1llb354LiKb1DhMduIFnSKHO04qpI
Message-ID: <CAJZ5v0gMk+Jt5WBUB=+cvv2YoU+49nRxL4KPRGm9TAdzkUvQhQ@mail.gmail.com>
Subject: Re: [PATCH] PM: add kernel parameter to disable asynchronous suspend/resume
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	peter.griffin@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:28=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> On some platforms, device dependencies are not properly represented by
> device links, which can cause issues when asynchronous power management
> is enabled. While it is possible to disable this via sysfs, doing so
> at runtime can race with the first system suspend event.
>
> This patch introduces a kernel command-line parameter, "pm_async", which
> can be set to "off" to globally disable asynchronous suspend and resume
> operations from early boot. This provides a robust way to fall back to
> synchronous (sequential) operation, which can stabilize platforms with
> problematic dependencies and also serve as a useful debugging tool.
>
> The default behavior remains unchanged (asynchronous enabled). To disable
> it, boot the kernel with the "pm_async=3Doff" parameter.

IIUC, this effectively is a way to change the initial value of the
existing pm_async sysfs knob.

Might be worth mentioning in the changelog.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> Dealing with the pixel6 downstream drivers to cope with the changes from
> https://lore.kernel.org/linux-pm/10629535.nUPlyArG6x@rjwysocki.net/.
>
> Similar to what people already reported it seems pixel6 lacks proper
> device links dependencies downstream causing i2c and spi client drivers
> to fail to suspend. Add kernel param to disable async suspend/resume.
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
>  kernel/power/main.c                             | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..55ba3e747d86c09a0696e105a=
1d9cd99218f0c07 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5000,6 +5000,15 @@
>                         that number, otherwise (e.g., 'pmu_override=3Don'=
), MMCR1
>                         remains 0.
>
> +       pm_async        [PM]
> +                       If set to "off", disables asynchronous suspend an=
d
> +                       resume of devices during system-wide power transi=
tions.
> +                       This can be useful on platforms where device
> +                       dependencies are not well-defined, or for debuggi=
ng
> +                       power management issues. Defaults to "on" (asynch=
ronous
> +                       operations enabled).

And here too because it is now unclear how this relates to the pm_sync
under /sys/power/.

> +
> +
>         pm_debug_messages       [SUSPEND,KNL]
>                         Enable suspend/resume debug messages during boot =
up.
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 3d484630505ae91fea29f7f9b3fbcf7e585955d8..3cf2d7e72567ecbea2cd80acd=
3c7f6da85f5bef4 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/acpi.h>
>  #include <linux/export.h>
> +#include <linux/init.h>
>  #include <linux/kobject.h>
>  #include <linux/string.h>
>  #include <linux/pm-trace.h>
> @@ -112,6 +113,14 @@ int pm_notifier_call_chain(unsigned long val)
>  /* If set, devices may be suspended and resumed asynchronously. */
>  int pm_async_enabled =3D 1;
>
> +static int __init pm_async_setup(char *str)
> +{
> +       if (!strcmp(str, "off"))
> +               pm_async_enabled =3D 0;
> +       return 1;
> +}
> +__setup("pm_async=3D", pm_async_setup);
> +
>  static ssize_t pm_async_show(struct kobject *kobj, struct kobj_attribute=
 *attr,
>                              char *buf)
>  {
>
> ---

