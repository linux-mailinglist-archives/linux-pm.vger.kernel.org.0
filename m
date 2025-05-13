Return-Path: <linux-pm+bounces-27066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2565AB4A78
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 06:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765CB467DCE
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 04:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3792D1DFD86;
	Tue, 13 May 2025 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyK0rhsD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C920EB;
	Tue, 13 May 2025 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747110419; cv=none; b=PLBbkq02pjb0zXTa6DsCZlpV7DZcWnFH7gamYso8DlCDXZ85uEX1ibvnWfAZSbEpvvKby5IqSXQvGxmS3f4AVyhAAbDd0zh0TAG7ov2GfSPu+kLv6tSPUQsQjrixSKs6NoNcHLLs7MIqAna8fOK3mXmSxCRE+784tllKa4OPL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747110419; c=relaxed/simple;
	bh=af7Baj+S+DgCiLw0BGGHcWfA+XOAp5qWaTgrQzEL3Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVLZA1Q/G9qjD+WEfGsRObecqXVfz0kRkdIfRAfuto3HfMazeR6Iz2ApIUuEYYiPTJEvhXGfhgWgFz/PSQmFtkd2vS9QlIGv4n6xqXt5y1+LVRbVzYmHh0i8bKD2yFfKkOETBP0hRcxZEf6dDg2dag2TqxwJyejCqlvblt6fEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyK0rhsD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-326c1795b8bso49790251fa.1;
        Mon, 12 May 2025 21:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747110415; x=1747715215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU20Hbb1WKgUlV8DXhGNS93f8Is7l5IDr6gro/J7Sdk=;
        b=SyK0rhsDPXkaEtq1MO/EEkYXmSTOdQsLwRZKucJ7Usu6gD0FECQM1d+Oew5kM6hdT0
         MHhr4WtsQwNE4iGaAvw3n6kBlxNrMIlGEdIHudn7L3jCe6GNwCldVhr8jogqjfekoKDH
         ibB44+MTtbrce8/j29OdBQ4oZ8LmIzkKPHLa3JZ7ybVveX4cdTPUsrCJ3znWJcfKlqXr
         AnxeBCtfp/JQUtW60yKTBINiTyCaE2d22PW9oVSRdk6oJDn8r3OFT8K0QPV0euIBQtmp
         ErfsyXILr0CI5TT/f8MvfSEN4K2T7N8AuxjivA2iTnbjZ6e07ojMQuaGTDca3iA7vgtF
         0Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747110415; x=1747715215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU20Hbb1WKgUlV8DXhGNS93f8Is7l5IDr6gro/J7Sdk=;
        b=a/ZVVaBZ5CusdW0EMFt0QZtazw39Uh6+M2TkLYTwbbGXof404k8UVIa89k4GK8Y1Ov
         xoz0wx3PpLV09KuUcYFufkzbx+5it8Z/G1Ks/3POzvZLO/4QFGkAHh9SLauAIvmPloVk
         tyD/6I6J7Mrd6tNKCPJyaL6T2OdiRjN1Du23Lal8sNnxjZ6s95vKX7hKjdlyzIDdYPhR
         ZqtL8DgPua/1XYRSZL7z3R3ptc9tOWp3Eb6MpJyAW5LDBqoXjXbtCvaDaJiqxnEOnBtv
         49nJNya9xvZjmXejqfvaMtivxmtc6Wt4dJCMdqik2e+KbHFnkp9cJ+shcf54HrDMGCvB
         yLsA==
X-Forwarded-Encrypted: i=1; AJvYcCUIWK3i7oZHad44oxxd07nHGm5poF+qn5u/JEpb4hqSgAUpsuuQccdN7yC9I0MFF/cvGRq085WPbW/wIoQ=@vger.kernel.org, AJvYcCUrL/Db0nKV8oKHQlbJQdX9JNu4z3Ws7ubCkvMab1nG3euXQG/j1LtEQIqFqpxqaIhZ5DuhtnMzig8=@vger.kernel.org, AJvYcCXmyAtqzjRI6X1/RgedgdPTfwRZmOVH7sHu5YISUxTGW6AXfzbeGDTjKaqVa5YbbTRv+87qqZ/JZ0Ph55U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZymm3QVRBqZeO3ZCmALeo1YaGMw2hqBykEJb11HxEXjN0+f0
	pN/j8cOh9yBKEni7cFkkaTJ/KJIJTlG/WZugMxI9UEVNxUuWvSC2/MyWGiEPNoFQc9JKabeVdJS
	WjzIgGWOpRffJXERHyIdsOU6Fyb8=
X-Gm-Gg: ASbGncuMCO6N73zI0q5cOlgT2mL8XZet1G7L/6yqZ69dspW/quRQeVOEI3jMbZgip9a
	9eUiOUO7XMlH+QDTvZXY+q50XPQYG1Wr4FM646uL4QmS542G2fii08el96gtJDqOrbCDTAMlNKl
	4o8r+Y4jikvHci2OBiuYTFEsMyYyY55FSrfHUWyt2WhR3f
X-Google-Smtp-Source: AGHT+IHvB5AnxDgnzbMpmLUg9F0SuXDXuIHXVrVZso/DSN5qTNo2FxOl3dTZi+6I/ot5W4rQi0SJo3IPejNZGA7bNpc=
X-Received: by 2002:a2e:a589:0:b0:30b:9793:c1f6 with SMTP id
 38308e7fff4ca-327e137d694mr6115961fa.17.1747110414921; Mon, 12 May 2025
 21:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com> <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
In-Reply-To: <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 12 May 2025 23:26:41 -0500
X-Gm-Features: AX0GCFsdcu25FDknux4VTkGzA3aWtstvuBGFGtw0cI2YptWpGHP6FrGLDLgOiAo
Message-ID: <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:38=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
>
>
> On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This requires three changes:
> > * A soft dependency on cpufreq-dt as this driver only handles power
> >    management and cpufreq-dt does the real operations
>
> Hmmm .. how is this handled for other drivers using the cpufreq-dt
> driver? I see the imx driver has a dependency on this.

A hard dependency would likely make more sense here. I can update this
in a new revision. When I first set the soft dependency, I wasn't
certain how the driver worked, so I was trying to be less intrusive.

> > * Adding a remove routine to remove the cpufreq-dt device
> > * Adding a exit routine to handle cleaning up the driver
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >   drivers/cpufreq/Kconfig.arm        |  2 +-
> >   drivers/cpufreq/tegra124-cpufreq.c | 36 +++++++++++++++++++++++++++++=
+++----
> >   2 files changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 4f9cb943d945c244eb2b29f543d14df6cac4e5d4..625f6fbdaaf5fd774e3b0bb=
996eb7ce980da41ee 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -238,7 +238,7 @@ config ARM_TEGRA20_CPUFREQ
> >         This adds the CPUFreq driver support for Tegra20/30 SOCs.
> >
> >   config ARM_TEGRA124_CPUFREQ
> > -     bool "Tegra124 CPUFreq support"
> > +     tristate "Tegra124 CPUFreq support"
> >       depends on ARCH_TEGRA || COMPILE_TEST
> >       depends on CPUFREQ_DT
> >       default y
> > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra=
124-cpufreq.c
> > index bc0691e8971f9454def37f489e4a3e244100b9f4..b6059c91f2474c56809c403=
eca94eacf51df734f 100644
> > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > @@ -16,6 +16,8 @@
> >   #include <linux/pm_opp.h>
> >   #include <linux/types.h>
> >
> > +static struct platform_device *platform_device;
>
> Do we need this?
>
> > +
> >   struct tegra124_cpufreq_priv {
> >       struct clk *cpu_clk;
> >       struct clk *pllp_clk;
> > @@ -176,6 +178,21 @@ static int __maybe_unused tegra124_cpufreq_resume(=
struct device *dev)
> >       return err;
> >   }
> >
> > +static void tegra124_cpufreq_remove(struct platform_device *pdev)
> > +{
> > +     struct tegra124_cpufreq_priv *priv =3D dev_get_drvdata(&pdev->dev=
);
> > +
> > +     if (!IS_ERR(priv->cpufreq_dt_pdev)) {
> > +             platform_device_unregister(priv->cpufreq_dt_pdev);
> > +             priv->cpufreq_dt_pdev =3D ERR_PTR(-ENODEV);
> > +     }
> > +
> > +     clk_put(priv->pllp_clk);
> > +     clk_put(priv->pllx_clk);
> > +     clk_put(priv->dfll_clk);
> > +     clk_put(priv->cpu_clk);
> > +}
> > +
> >   static const struct dev_pm_ops tegra124_cpufreq_pm_ops =3D {
> >       SET_SYSTEM_SLEEP_PM_OPS(tegra124_cpufreq_suspend,
> >                               tegra124_cpufreq_resume)
> > @@ -185,12 +202,12 @@ static struct platform_driver tegra124_cpufreq_pl=
atdrv =3D {
> >       .driver.name    =3D "cpufreq-tegra124",
> >       .driver.pm      =3D &tegra124_cpufreq_pm_ops,
> >       .probe          =3D tegra124_cpufreq_probe,
> > +     .remove         =3D tegra124_cpufreq_remove,
> >   };
> >
> >   static int __init tegra_cpufreq_init(void)
> >   {
> >       int ret;
> > -     struct platform_device *pdev;
> >
> >       if (!(of_machine_is_compatible("nvidia,tegra124") ||
> >               of_machine_is_compatible("nvidia,tegra210")))
> > @@ -204,15 +221,26 @@ static int __init tegra_cpufreq_init(void)
> >       if (ret)
> >               return ret;
> >
> > -     pdev =3D platform_device_register_simple("cpufreq-tegra124", -1, =
NULL, 0);
> > -     if (IS_ERR(pdev)) {
> > +     platform_device =3D platform_device_register_simple("cpufreq-tegr=
a124", -1, NULL, 0);
> > +     if (IS_ERR(platform_device)) {
> >               platform_driver_unregister(&tegra124_cpufreq_platdrv);
> > -             return PTR_ERR(pdev);
> > +             return PTR_ERR(platform_device);
> >       }
> >
> >       return 0;
> >   }
> >   module_init(tegra_cpufreq_init);
> >
> > +static void __exit tegra_cpufreq_module_exit(void)
> > +{
> > +     if (platform_device && !IS_ERR(platform_device))
> > +             platform_device_unregister(platform_device);
>
> The device is unregistered in the remove. Why do we need this?

These are separate things, aren't they? What's unregistered in the
remove is the cpufreq-dt device. And what's unregistered here is the
tegra124-cpufreq device. Not the same thing, unless I'm really missing
something.

Sincerely,
Aaron

