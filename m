Return-Path: <linux-pm+bounces-27144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877ADAB7168
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC718858BE
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C811C701A;
	Wed, 14 May 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/1wIB5q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81617B425;
	Wed, 14 May 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240275; cv=none; b=oYs5CZbHrk35GQOlcty9DJ3ALmzBuvxCK3hsHbD3ibST5itXavzGEqAwfsA6Und9xFA0KuMWuY9yzx4xaquIkt4lxnQmsWOga+NrvBtNQZOvza8Y0FjH5HpiM4vMYnEjb7oZSPiIY6Q7FWgSG/OPIYuL/JgtpQtpHhYtq79ZvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240275; c=relaxed/simple;
	bh=hMG5Hp4DrK9f+Zt1PU2mXZ8zjXEdBSx3vlr7E9/HJHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZKoe58k3+5cvjleWn1Ab2g0BycqAG4u8xbQ3mgQLqKMyjvk1Z0KgxYtelh6xx0Rkb5wbmxL9xuJooiX+zWv04+doox/hbeX9GQPra7EohVWe8lmYfaj/4eTN3r8enKRiEWciwW0m5rVzHPcndKh+OP29WZ78Av0FwAeaHl3egQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/1wIB5q; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-326c1795b8bso13397371fa.1;
        Wed, 14 May 2025 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747240271; x=1747845071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl3sZuw1JpFTPNUyXtF/TiniOiQd8y65SQ3qOplFDgE=;
        b=f/1wIB5qY0x9wE4vuekUTdIvWxi3DAR5ECw4OaoaDh/Tiq3Fv70y+Q4cI8TcYZeimY
         PO9LjKT5mJl09UwS061RYRJatqDoMKdJ7zSHVff3UJtoaCMlgm36Js+X3U/hLR4vHbUX
         AU0gD7uXQKkqPE/Uzoylo3+pDIVa8pRGax2tP+sRcBiAnWvbO2ZUncZQTwIFVbuZhqAm
         nu+iydzCfUmKojVO6rIYBF6hblv/tfzShj7oRFYuT/wyyWexdLj6pC2OO85e81z4alA/
         OQ4NcehM2FlYlaWjsPHkTvXIpEFs39qzhyl+zyDFR3FmIMGtpWqSN93yX3Wu6fCaB2jq
         OKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240271; x=1747845071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl3sZuw1JpFTPNUyXtF/TiniOiQd8y65SQ3qOplFDgE=;
        b=gaKAj9L7QuIpPnoDI5E5IU2R1ONBvGMXqLkL7krB1XB2BfbKOnjrb5b/wlZvZjxVgd
         mZILNoQxjaAUkDFY0PjWaJqzl005qwrBEjv2S1mFIswTc1pucQMmfMLtuCIKpwP1RkXy
         JJpNRZINn7VS3yYVtd3pQQ1vDPnokqtcLM5pifts3AUgOb6g091crpy4u3d6VZlW+WUo
         0puI7voOVu4d5kKxYBdxiW1CEo4W9WMrHYRVD1tp88Z3iPu2N0GVy89CYppWB+qskdkR
         +HF7C66gJhFiGoD3jifKApBOpA1Sh9k7AhROsKPAA3X4lKYjqK/hw7h/MlPuaILX2etZ
         /2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLhOPFIBIOvsSRLb7Us4ZfTqTLsWKGqgHJdVkkkxgnfiLqgPl1nGtlzdJjJAWErwhdWyJ+tMsp7lUZ3KU=@vger.kernel.org, AJvYcCWgRJx/vGwj1KZF0iJFNNSMOcDPLKlOFw+5F9vjB7Y/eG9ff3g91Zvzwfr0XfjT5XAs86lp1rBXBNlMk/E=@vger.kernel.org, AJvYcCXBWhZlxoGz5Qo4WgQ+aTxlio3I+0e3KgX08xeaKUxCT88GzYBA7iBPexT07sPfgfD37alENuKkN6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJM6LWtqm7ztfxzhMlF/7OieIjoVltlPnOPF13r5fjilXRXf04
	Uf95G9FxNP1YY2gZWvNgmKOaCPehOub4FkdyiaPtbFgjM8KYeAqc5yFSvXZHaGPLXjg+9hTIDrO
	P11fOV+eyLI3m4wxAlW3cPDvvNDU=
X-Gm-Gg: ASbGncsUd2z5Pj8pYHMgjHJKR2YlxoSZBQ8ztuQXlbeo4H6a3CAOSsRtKlUkmUm84KS
	tmwEvOenWfvyEKPFFsVw10pYxWiSOGinOCd6sQzZ+lx8QuHtpDQy1/NNPAnqVg5XRnO0pA+aVGz
	MeWvrnQd0sM/o7mGPPdkgT1Hsv487ZI5CfuQ==
X-Google-Smtp-Source: AGHT+IEBixW/UnlsdMV+KcAwpESPlSRZwPO2hjoXVUOHsdw5UOEX0JmzjViwlmGtZphdTMfVYwah+r3pzhyPDgtTI3Q=
X-Received: by 2002:a05:651c:b12:b0:326:cf84:63c4 with SMTP id
 38308e7fff4ca-327f843efc2mr1150781fa.1.1747240271035; Wed, 14 May 2025
 09:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com> <da080e61-4e54-4334-a239-1619bf8fea0c@nvidia.com>
In-Reply-To: <da080e61-4e54-4334-a239-1619bf8fea0c@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 14 May 2025 11:30:58 -0500
X-Gm-Features: AX0GCFtHpKPKPsDOnGvKMQdAIPreQAx29TyN97-A_3yl0xx21IqwVU2UXtPudyg
Message-ID: <CALHNRZ9DKf_p5y3K4yVF8wDm4S0jRB-NSF8aZB5CsYxk7GmyNQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 5:32=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This requires three changes:
> > * A soft dependency on cpufreq-dt as this driver only handles power
> >    management and cpufreq-dt does the real operations
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
>
>
> If we use devm_clk_get() in probe, then we should be able to avoid this.

I can do that. There's a lot of other cleanup like this that the
driver could use based on newer kernel apis, but that's out of scope
of this series.

Sincerely,
Aaron

