Return-Path: <linux-pm+bounces-32908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0360B31856
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 14:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE97BE0F4
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 12:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B42F6196;
	Fri, 22 Aug 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1yxazY5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3B2ECE8F;
	Fri, 22 Aug 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867062; cv=none; b=AoPWuMwDjo22BkeX1sk5Rxw1L7BUGllWb4JXGiFk2IWvcWjUoI++JT5fWXaHyV/IELSffyBdFIUdQuZuz+BuVS1ie8kyxhykUYaPzZkHIGSMY/iU1EuTFkg9k77xko+oNMm2iKRDOqk2Pz3DJOyrvD4w4PtPbvKBzHdD1yYM7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867062; c=relaxed/simple;
	bh=62L/Xc8PMFF3fvmTu93PaFJyJD9WQMobEpBD9EWjLB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSTGzgEuxj+YdGXrdwVQFgowwi62PAlytInzfjXmPf4Fz0PNK0FkBBu6KLQTwyg1aKc9h5p1C+dVGdJWgOPqCstz4p4hOaMLzrxQkoavBRdSFCniJba2uHMWPfQGKZCO8nWXdyL1W9cXLmX3+aRPY3XxNNEIH1EYQs/htKI+9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1yxazY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9DFC4CEED;
	Fri, 22 Aug 2025 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755867062;
	bh=62L/Xc8PMFF3fvmTu93PaFJyJD9WQMobEpBD9EWjLB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O1yxazY5MJCsReRUfP6WNlfY2rRh9qlmd2JeN9rQA7zlyIfReweAVTlOQl6steOJu
	 Nt+780GihMEo+H03Drdd3r37zBMA4+tZPO8B5GOhvLauj1M+3GiJ8dQqqYlH4dTz0K
	 kKkiA7NwrKGBGv20FujnsUST/HSsHOrxjkC4/VhJXJzuJpqGyU3LkNNeeZDMBcxcks
	 sLKKmhXJdZ52SBn0WSr4c+qDEKtmlmsBf3Nlhima4XEiijThYajYM8UQORUzZUT+Cm
	 39auTfd5YuuAeW1tFbh5ex1VXltsUGGAY31iVyMxWeDbru0jkdFLcDdllg5HIO5oPv
	 odjYLRonNfrtw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce5cb708so1438623fac.0;
        Fri, 22 Aug 2025 05:51:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6PAw9CNHsIB9kSrvRfamcoFyDaArtbAkDB2BJRPq8c/r4igNceQhcz/PcOta3KfUORBlyk9fXz6k=@vger.kernel.org, AJvYcCWDCkBKu0Nl0ckCBIfXv2El0htbpiZRSp8U5UN5PBW0gNfLKkLd6At+zGYSZk+f9Kzh/eSi4fVRQ+dkV20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFWCEVN8s+CSJza7sDIE3hYu3zfdSJryqdufDbUWd+rrloBzR/
	tEIKUCC0o9k+sRfdMGhbq9pVVlB7TrOppYS734PjGlhCf/UhkbyNe6tDTdHc30wfB6iWQbCu7ak
	4JaEW1OLCKT9+en5amw9q1qgyNrahXgU=
X-Google-Smtp-Source: AGHT+IFL9dntZ4Kq7JegAnYSa68sNCLfWKru9JguUim257NjBCxrSj6SmH2KH26Sk8rcYUY0laYzDCzO0yMX4+y3WmM=
X-Received: by 2002:a05:6870:e242:b0:2ff:8bc7:44a9 with SMTP id
 586e51a60fabf-314dcc311c7mr1315348fac.21.1755867061407; Fri, 22 Aug 2025
 05:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com> <20250813185530.635096-4-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250813185530.635096-4-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 14:50:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ht1Z0dDxW1hfDUBoQOWXRBD+XHTph0juRhRCAvy=Z61Q@mail.gmail.com>
X-Gm-Features: Ac12FXwuQ-mTXPcre9cCSCDFWmzBm1aGuMluKtr_dmcwOAT1o7Gs6jf2FxOMeqE
Message-ID: <CAJZ5v0ht1Z0dDxW1hfDUBoQOWXRBD+XHTph0juRhRCAvy=Z61Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] thermal: intel: int340x: Add module parameter for
 balanced Slider
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:55=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> By default, the SoC slider value for the "balanced" platform profile is
> set to 3. A new module parameter is introduced to allow users to change
> this default value. After modifying the module parameter, users must call
> an update to the "profile" sysfs attribute for the change to take effect.

This last bit is slightly confusing.  What exactly do they need to do
for this purpose?

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../processor_thermal_soc_slider.c            | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index c492ee937dc7..ffc538c9b9e3 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -50,6 +50,43 @@ static u8 slider_values[] =3D {
>         [SOC_POWER_SLIDER_POWERSAVE] =3D SOC_SLIDER_VALUE_MAXIMUM,
>  };
>
> +/* Lock to protect module param updates */
> +static DEFINE_MUTEX(slider_param_lock);
> +
> +static int slider_balanced_param =3D SOC_SLIDER_VALUE_BALANCE;
> +
> +static int slider_def_balance_set(const char *arg, const struct kernel_p=
aram *kp)
> +{
> +       u8 slider_val;
> +       int ret;
> +
> +       guard(mutex)(&slider_param_lock);
> +
> +       ret =3D kstrtou8(arg, 16, &slider_val);
> +       if (!ret) {
> +               if (slider_val > SOC_SLIDER_VALUE_MAXIMUM)
> +                       return -EINVAL;
> +
> +               slider_balanced_param =3D slider_val;
> +       }
> +
> +       return ret;
> +}
> +
> +static int slider_def_balance_get(char *buf, const struct kernel_param *=
kp)
> +{
> +       guard(mutex)(&slider_param_lock);
> +       return sysfs_emit(buf, "%02x\n", slider_values[SOC_POWER_SLIDER_B=
ALANCE]);
> +}
> +
> +static const struct kernel_param_ops slider_def_balance_ops =3D {
> +       .set =3D slider_def_balance_set,
> +       .get =3D slider_def_balance_get,
> +};
> +
> +module_param_cb(slider_balance, &slider_def_balance_ops, NULL, 0644);
> +MODULE_PARM_DESC(slider_balance, "Set slider default value for balance."=
);
> +
>  /* Convert from platform power profile option to SoC slider value */
>  static int convert_profile_to_power_slider(enum platform_profile_option =
profile)
>  {
> @@ -106,6 +143,10 @@ static int power_slider_platform_profile_set(struct =
device *dev,
>         if (!proc_priv)
>                 return -EOPNOTSUPP;
>
> +       guard(mutex)(&slider_param_lock);
> +
> +       slider_values[SOC_POWER_SLIDER_BALANCE] =3D slider_balanced_param=
;
> +
>         slider =3D convert_profile_to_power_slider(profile);
>         if (slider < 0)
>                 return slider;
> --
> 2.43.0
>

