Return-Path: <linux-pm+bounces-32911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C1B318E5
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 15:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BAB626B89
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6B2FB613;
	Fri, 22 Aug 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQDm8DY+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5FC2EBDDC;
	Fri, 22 Aug 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867776; cv=none; b=COn3yoQMaOF5QgHxWWe+h/YqpWcnthdJB3w3s2q6/ZM/4RYfplyJRyQ9Ejrfcs5k0Ed0nwpyPP7nNmELz31qCern5R/N5dY6WWuaZNe/bQB57zRQPwCf/KNTDkyqdlL3/n5juxAZbaUQuYLse8vV0r2uDJzaK8oLu1L+/VdAuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867776; c=relaxed/simple;
	bh=XUf06i8e8RoMGL2RRWjVSNqQW46vBv9zyMPjHciLK5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYs55syUAb/lngV185OHW4wBHeIlN478q/dEaoiim9xKO/spb5TtRxnUA3UpGfkQE811mv80Lzj05jpQzTVNUMkLW0yB4I8oLdNnVUZB7FLVUuKcJbCi0iqKWHcjFDwgjYc0tNHUG9aM9Dz3uLRprj10EOO1Os3+08nSdXXi7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQDm8DY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27D8C113CF;
	Fri, 22 Aug 2025 13:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755867775;
	bh=XUf06i8e8RoMGL2RRWjVSNqQW46vBv9zyMPjHciLK5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FQDm8DY+9K3wtjDyJxzji3tWiEkNa+5YRyEXi1KY1HoNwNzSr8Ya1kRkq25J8a5jq
	 MPdpwaa/KCmnEwTh9GjXmauy+844ACYW2WpLxp9abGmFxzYNj7V/0T/tPxs+jlESfo
	 k8/qy8b6p2v82vRRQNML10zft9JuEpbh/DwYkABd0/w+b66+mHamNFX7aJH6HNQ7Hg
	 yLJIaNkRAT/BKzOr9D7wh8/qujXgMFU9asdovWpjfq1Dw+8mC9RkjWws7hal4EYckR
	 XQNauQi3lPra6BH492CBP2QOscuIq+j6/+wFyGBmyViuHQCUeoVRBC9pdkM+tVR4rN
	 MYa+uyWfoHwzQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74381fbc6e3so986547a34.2;
        Fri, 22 Aug 2025 06:02:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxm9Z5FF4Kf7rVECYCV5urMqVPSQdXMMdN+3wiQHUWJkPrxCCstKGW/IVuyMVNEejcTbR1t/Ln11A=@vger.kernel.org, AJvYcCVRjZx2CwxRXu9Udb7NZiysx3fNW6Ca2eOPqI2UTsqjHB63Gtlhcj+eoRc5sBCBGm90V8VbiE4Grnhoc2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64bMVopTk0h7AnIvAxdVO5PADhe+nEyf0nLA9uXbZplATMot+
	ne24++5xo52jI5WZaEgPtqwHNIjex7rBEYeCeXznGfEaEgoVl5RSKAH8N9kGFB429cdKs/qvaye
	/mRG8tpgQqUAxcQr3S9quSZ6w9K9BDRI=
X-Google-Smtp-Source: AGHT+IEa8TntZjcbUwt6F90eNByfKDYM9ExzV95BccIfO+e8B/oc/lPhsOkVc4Gzm9tJX3UTPlhmCj0wyuipuCDMG0w=
X-Received: by 2002:a05:6830:6613:b0:744:f08d:15fc with SMTP id
 46e09a7af769-74500a9d977mr1901547a34.34.1755867775123; Fri, 22 Aug 2025
 06:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com> <20250813185530.635096-6-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250813185530.635096-6-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 15:02:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gZ3w=CWCfaejB+ALrbzeOvDUGynNADQvgvgK-1ENteeQ@mail.gmail.com>
X-Gm-Features: Ac12FXy31mDcO6Avt_CzgMO575K5xSFTO8iUB1g9Ri1dz-KiydTWt1EWI39d20w
Message-ID: <CAJZ5v0gZ3w=CWCfaejB+ALrbzeOvDUGynNADQvgvgK-1ENteeQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] thermal: intel: int340x: Add suspend and resume callbacks
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:55=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> During system suspend callback save slider register and restore during
> resume callback.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

I would combine this with the first patch.

It doesn't add extra functionality, it's mandatory stuff.

> ---
>  .../int340x_thermal/processor_thermal_device.c    | 10 ++++++++++
>  .../int340x_thermal/processor_thermal_device.h    |  2 ++
>  .../processor_thermal_soc_slider.c                | 15 +++++++++++++++
>  3 files changed, 27 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 4aea5c9baae9..a772c187bedb 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -338,10 +338,17 @@ static int tcc_offset_save =3D -1;
>
>  int proc_thermal_suspend(struct device *dev)
>  {
> +       struct proc_thermal_device *proc_dev;
> +
>         tcc_offset_save =3D intel_tcc_get_offset(-1);
>         if (tcc_offset_save < 0)
>                 dev_warn(dev, "failed to save offset (%d)\n", tcc_offset_=
save);
>
> +       proc_dev =3D dev_get_drvdata(dev);
> +
> +       if (proc_dev->mmio_feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_=
SLIDER)
> +               proc_thermal_soc_power_slider_suspend(proc_dev);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(proc_thermal_suspend);
> @@ -357,6 +364,9 @@ int proc_thermal_resume(struct device *dev)
>         if (tcc_offset_save >=3D 0)
>                 intel_tcc_set_offset(-1, tcc_offset_save);
>
> +       if (proc_dev->mmio_feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_=
SLIDER)
> +               proc_thermal_soc_power_slider_resume(proc_dev);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(proc_thermal_resume);
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index ba3f64742f2f..30760475102f 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -130,5 +130,7 @@ int proc_thermal_ptc_add(struct pci_dev *pdev, struct=
 proc_thermal_device *proc_
>  void proc_thermal_ptc_remove(struct pci_dev *pdev);
>
>  int proc_thermal_soc_power_slider_add(struct pci_dev *pdev, struct proc_=
thermal_device *proc_priv);
> +void proc_thermal_soc_power_slider_suspend(struct proc_thermal_device *p=
roc_priv);
> +void proc_thermal_soc_power_slider_resume(struct proc_thermal_device *pr=
oc_priv);
>
>  #endif
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index bd4ff26a488b..268bf9124d95 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -248,6 +248,21 @@ int proc_thermal_soc_power_slider_add(struct pci_dev=
 *pdev, struct proc_thermal_
>  }
>  EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_add, "INT340X_THERMAL=
");
>
> +static u64 soc_slider_save;
> +
> +void proc_thermal_soc_power_slider_suspend(struct proc_thermal_device *p=
roc_priv)
> +{
> +       soc_slider_save =3D readq(proc_priv->mmio_base + SOC_POWER_SLIDER=
_OFFSET);
> +
> +}
> +EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_suspend, "INT340X_THE=
RMAL");
> +
> +void proc_thermal_soc_power_slider_resume(struct proc_thermal_device *pr=
oc_priv)
> +{
> +       writeq(soc_slider_save, proc_priv->mmio_base + SOC_POWER_SLIDER_O=
FFSET);
> +}
> +EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_resume, "INT340X_THER=
MAL");
> +
>  MODULE_IMPORT_NS("INT340X_THERMAL");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Processor Thermal Power Slider Interface");
> --
> 2.43.0
>
>

