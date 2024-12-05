Return-Path: <linux-pm+bounces-18620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329549E54A9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FC3165C97
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC732144B8;
	Thu,  5 Dec 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anj5zIvK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324482144A9;
	Thu,  5 Dec 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399722; cv=none; b=q3JO4H669lOJ4LxYFBErKrUIDMbHc82J8OaLaGcIgIEolqh3P/mjm7zO2ii/xjmu9W4DfTtQQ9NEXILdl53v5d7KOXxRHlqQ8ffOV7Gz6omlpMRhXGlrg0yJ9ZIErAl56JYxSzf0ESqObBVDEfjsMjnNkPElv9u2GbIndoV9YEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399722; c=relaxed/simple;
	bh=nH8fWMK/VZGDFlBMqiqx0/8P7fZRUuO9WBFNE47C5qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ncci2P5GA6WssAYJcA0QzgCh0ztsA5s9FOHEDbM/uwGkC2+kkQQyhF456JmoLI+8KamduC59emczCXeD6WlVbNiCWNMJCWhCGsPRanWdtzMS3w6koFjJNNvLZWR41BKDOTqsCDmQr42DLigZMcRcj7O0AUa6b9crKbMlGSdl2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anj5zIvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB323C4AF09;
	Thu,  5 Dec 2024 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733399721;
	bh=nH8fWMK/VZGDFlBMqiqx0/8P7fZRUuO9WBFNE47C5qI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=anj5zIvKlf0vHMIkia5KoWq5OzN7O2+cF51eEu5DeEF2uKrTk+u2Q6f2R2z2OW8ND
	 3AxbRW4JpuKbagxAiPoZxjMBXGVwZC5ivWQ+5kXVakMPDeJDbrLTXdm1ZS5VpOEMSN
	 cJzEHm5cJKbqcadNOtZf0ziokFyB/XmISgRneoJepbJDan07C/hVB3Dw+U6BhffEVg
	 xj6gPZjBcaFsQIzvwIp5MNe8tRGvpYnXvVW4DTJm3qzvZ8gdp2+YYgy09chInkBpTr
	 hI50UM/aVuGrZ/CmbL3jklGkqUn+XOa/w6DyjgJp0DBspti75nVY35m1exCPG60bGw
	 VwG7XSW/o8tBg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29e806faa88so444257fac.3;
        Thu, 05 Dec 2024 03:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU85cZe05le5BFTMU2uRJrDXX7XfxJ+MlzeDi2rilQNY7nEPYMAC16DRGQcA3pzk8nkB55rM53SV5V6+qE=@vger.kernel.org, AJvYcCX3pPKzaRd2SmhDv621Y2K8hNclvQqE0CUlqoTBY4BT+yNo8QRSRW0YtQVoj1CWcDmtbyRqwY9JAwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDagWd5Oy9+eqfKQVoalgimoWJZWM2yiaw+X03Kcvfj8vAGSfT
	6WqlD3gHEIiH5tHOKtgsrkYdhEUKDBJ1n/8ZcI9avIzYb/+eEAr1dSRXpa1dPFuh6WGfpPMhPWD
	y2GWPiJ3mcdfixc8We+mH/NZeiaQ=
X-Google-Smtp-Source: AGHT+IEqZRrzYgPPQ8nocKRT+iIYaHatFl4Q+kymLwND83PToVpJ78Z6l8jQBUSINcPRCBkE7wqUty8KCSga2TsoK1Y=
X-Received: by 2002:a05:6870:5687:b0:29e:6394:fd4a with SMTP id
 586e51a60fabf-29e9b0931e9mr4893961fac.2.1733399721051; Thu, 05 Dec 2024
 03:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
In-Reply-To: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Dec 2024 12:55:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>
Message-ID: <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Expanded CC list.

On Thu, Nov 14, 2024 at 4:23=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> Drivers commonly return non-zero values from their suspend
> callbacks due to transient errors, not realizing that doing so
> aborts system-wide suspend.
>
> Log, but do not abort system suspend on non-zero return values
> from driver's .suspend/.suspend_noirq/.suspend_late callbacks.
>
> Both before and after this patch, the correct method for a
> device driver to abort system-wide suspend is to invoke
> pm_system_wakeup() during the suspend flow.
>
> Legacy behaviour can be restored by adding this line to your .config:
> CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=3Dy
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  Documentation/power/driver_api.rst | 25 +++++++++++++++++++++++++
>  Documentation/power/index.rst      |  1 +
>  drivers/base/power/main.c          | 25 ++++++++++++++++++-------
>  kernel/power/Kconfig               | 17 +++++++++++++++++
>  4 files changed, 61 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/power/driver_api.rst
>
> diff --git a/Documentation/power/driver_api.rst b/Documentation/power/dri=
ver_api.rst
> new file mode 100644
> index 000000000000..b9a46a17f39b
> --- /dev/null
> +++ b/Documentation/power/driver_api.rst
> @@ -0,0 +1,25 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Driver Suspend API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +1. How Can A driver abort system suspend?
> +-----------------------------------------
> +
> +Any driver can abort system-wide  by invoking pm_system_wakeup()
> +during the suspend flow.
> +
> +ie. from the drivers suspend callbacks:
> + .suspend()
> + .suspend_noirq()
> + .suspend_late()
> +
> +Alternatively, if CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=3Dy is present i=
n .config,
> +then any non-zero return value from any device drivers callback:
> + .suspend()
> + .suspend_noirq()
> + .suspend_late()
> +will abort the system-wide suspend flow.
> +Note that CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=3Dn, by default.
> diff --git a/Documentation/power/index.rst b/Documentation/power/index.rs=
t
> index a0f5244fb427..f655662a9c15 100644
> --- a/Documentation/power/index.rst
> +++ b/Documentation/power/index.rst
> @@ -7,6 +7,7 @@ Power Management
>  .. toctree::
>      :maxdepth: 1
>
> +    driver_api
>      apm-acpi
>      basic-pm-debugging
>      charger-manager
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 4a67e83300e1..1b4ab73112e4 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1244,7 +1244,6 @@ static int device_suspend_noirq(struct device *dev,=
 pm_message_t state, bool asy
>  Run:
>         error =3D dpm_run_callback(callback, dev, state, info);
>         if (error) {
> -               async_error =3D error;
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async noirq" : " noirq",=
 error);
>                 goto Complete;
> @@ -1270,7 +1269,12 @@ static int device_suspend_noirq(struct device *dev=
, pm_message_t state, bool asy
>  Complete:
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
> -       return error;
> +
> +       if (IS_ENABLED(CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT)) {
> +               async_error =3D error;
> +               return error;
> +       }
> +       return 0;
>  }
>
>  static void async_suspend_noirq(void *data, async_cookie_t cookie)
> @@ -1424,7 +1428,6 @@ static int device_suspend_late(struct device *dev, =
pm_message_t state, bool asyn
>  Run:
>         error =3D dpm_run_callback(callback, dev, state, info);
>         if (error) {
> -               async_error =3D error;
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async late" : " late", e=
rror);
>                 goto Complete;
> @@ -1437,7 +1440,12 @@ static int device_suspend_late(struct device *dev,=
 pm_message_t state, bool asyn
>  Complete:
>         TRACE_SUSPEND(error);
>         complete_all(&dev->power.completion);
> -       return error;
> +
> +       if (IS_ENABLED(CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT)) {
> +               async_error =3D error;
> +               return error;
> +       }
> +       return 0;
>  }
>
>  static void async_suspend_late(void *data, async_cookie_t cookie)
> @@ -1681,7 +1689,7 @@ static int device_suspend(struct device *dev, pm_me=
ssage_t state, bool async)
>         error =3D dpm_run_callback(callback, dev, state, info);
>
>   End:
> -       if (!error) {
> +       if (!error || !IS_ENABLED(CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT))=
 {
>                 dev->power.is_suspended =3D true;
>                 if (device_may_wakeup(dev))
>                         dev->power.wakeup_path =3D true;
> @@ -1695,14 +1703,17 @@ static int device_suspend(struct device *dev, pm_=
message_t state, bool async)
>
>   Complete:
>         if (error) {
> -               async_error =3D error;
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
>         }
>
>         complete_all(&dev->power.completion);
>         TRACE_SUSPEND(error);
> -       return error;
> +       if (IS_ENABLED(CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT)) {
> +               async_error =3D error;
> +               return error;
> +       }
> +       return 0;
>  }
>
>  static void async_suspend(void *data, async_cookie_t cookie)
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index afce8130d8b9..db120bba0826 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -141,6 +141,23 @@ config PM_SLEEP
>         depends on SUSPEND || HIBERNATE_CALLBACKS
>         select PM
>
> +config PM_SLEEP_LEGACY_CALLBACK_ABORT
> +       bool "Enable legacy callback abort via return value"
> +       depends on PM_SLEEP
> +       help
> +       This option enables the legacy API for device .suspend() callback=
s.
> +       That API empowered any driver to abort system-wide suspend
> +       by returning any non-zero value from its suspend calbacks:
> +       (.suspend/.suspend_noirq/.suspend_late)
> +       In practice, these aborts are almost always spurious and unwanted=
.
> +
> +       Disabling this option (default) ignores .suspend() callback retur=
n values,
> +       though they are still traced and logged.
> +
> +       The proper way for a device driver to abort system-wide suspend i=
s to
> +       invoke pm_system_wakeup() during the suspend flow.  This method i=
s
> +       valid, independent of this config option.
> +
>  config PM_SLEEP_SMP
>         def_bool y
>         depends on SMP
> --

I'm wondering if there are any opinions on this.

IMV, drivers returning errors from their suspend callbacks without a
sufficiently serious reason are kind of a problem.

