Return-Path: <linux-pm+bounces-32910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D287B318E0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 15:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B7462529E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA872FE575;
	Fri, 22 Aug 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3kc2hcd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC32FDC29;
	Fri, 22 Aug 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867649; cv=none; b=ZupihbgtX8Hvv16yzE2Bgdw85VLNLF7mLB6X0jLkRXDIuuhiw9yqioTvcMnZtkHwKbT3BwDQrIVjaSGriFJ66bAXaJv2Dfhamt7cVUom3HvEa/xO884oz9gUCI+pUIEaPw3YdGHrcKDeo50cn783lrb+b2lhovi2gwaDVa/EgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867649; c=relaxed/simple;
	bh=ats1+jsJnYa0rxWrINmyziV8D1Yb5nkkrfpinjF6M5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPt6lurMfYSNTqaTKz4ujnc3/J8VB78d/uTowQ8/KMgL1LDO18uO8nS4Jyuz+gt9KIeYt19DXIksDYNatVp7fGaYWpDjHvsMUUVjJzz15FxRN7+yeQ96mpK+EorEc81pXoInm9VVTBzlGi1ksmUX9/fywJgxKNaiHiZVptczHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3kc2hcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C072C116B1;
	Fri, 22 Aug 2025 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755867649;
	bh=ats1+jsJnYa0rxWrINmyziV8D1Yb5nkkrfpinjF6M5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T3kc2hcd8gnj7MvDTqiVvko2q4INNi7oQPFn2DM0V0upjiy3lU6h8xjpmAfmVqFCh
	 m7a6mkXGqmDC2MOhVN+ucl+jkcPEzBc5cAEO7tB91l/1BI8TomUzJCsq9+fhinKbfH
	 hNXWiT1YG9a/ielIBbER/npC6I57+CezJk7VCbXMIJKFuxTRso/5WUKskDqwF5VV11
	 SEQc/Ne0ir/00IDAExktYTOKHESSSasL4bo1BD8SEPdgWrCD1N3X7X3w3R9tv6i8Cm
	 Om/HoxvGa8DzAbNlIFpvxalDj3W1TX/eO8qL6+prY5WO1MFMfBkMmeIGopn+FPkphh
	 6xmOHJElz4deg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so1053526eaf.0;
        Fri, 22 Aug 2025 06:00:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhsOF8ITBZUfMEwNVw58Pf3AIRaCrwXP941zKzwZshEWsKczRqDtP9fJ4UWAzdPBWwXiseDZZeYdnoFS8=@vger.kernel.org, AJvYcCXPLc5mcjk3KKxRoaZgLN8pd2s+zp9lzRbuDsgNSmJx8ZmDiM37SgAgb4zCdyXgM5WHk+jKZkDzikw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTHzdjOpopqyclUwZtK8hgR8bThNbbXz1wRDWhC1CGXI58OxWb
	AWGeyKGuyjHM4RtpAd0mCSgaj+TGOLCZ0ycoD6eo3ilmVbYy73NPeytzQqp2x+w+8kNt/wrwmkT
	JzbJ6+Ttc5KHRTT/fCKa+0WWlAEXNTKc=
X-Google-Smtp-Source: AGHT+IFAMYFFJYEzNXirerl2h0xgcYM7YrFPAtEXbwXil6NG/7dYXXfAS8ecp4/JmcZ7KgwwFMp8XE0Bn5ibNlqtYF4=
X-Received: by 2002:a05:6870:d113:b0:301:a704:ef1c with SMTP id
 586e51a60fabf-314dce132d9mr1347844fac.25.1755867648402; Fri, 22 Aug 2025
 06:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com> <20250813185530.635096-5-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250813185530.635096-5-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 15:00:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i-HN15f+8GaH9Rh-Siu_hMU38byRoWZ8oLW8r88o6ZOg@mail.gmail.com>
X-Gm-Features: Ac12FXy0_a54K2CKy5xUOkf5CuHsc838UYAATXA-ngDu0kC5BifS148-jsrMB-A
Message-ID: <CAJZ5v0i-HN15f+8GaH9Rh-Siu_hMU38byRoWZ8oLW8r88o6ZOg@mail.gmail.com>
Subject: Re: [PATCH 4/5] thermal: intel: int340x: Add module parameter to
 change slider offset
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:55=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The slider offset value allows the SoC to automatically switch slider
> positions in range [SOC_SLIDER =E2=80=A6 (SOC_SLIDER + slider offset)] ba=
sed on
> internal algorithms to improve power efficiency.

So SOC_SLIDER is the value set by the user (or the default value if
the user has not set it) and the "slider offset" allows the SoC to
adjust the slider value by setting it above SOC_SLIDER up to and
including SOC_SLIDER + slider offset?

If so, I would add a comment to this effect next to the slider_offset
module param definition.

> By default, the SoC slider offset is set to 0. This means that SoC is not
> allowed to switch slider position.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../processor_thermal_soc_slider.c            | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index ffc538c9b9e3..bd4ff26a488b 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -87,6 +87,40 @@ static const struct kernel_param_ops slider_def_balanc=
e_ops =3D {
>  module_param_cb(slider_balance, &slider_def_balance_ops, NULL, 0644);
>  MODULE_PARM_DESC(slider_balance, "Set slider default value for balance."=
);
>
> +static u8 slider_offset;
> +
> +static int slider_def_offset_set(const char *arg, const struct kernel_pa=
ram *kp)
> +{
> +       u8 offset;
> +       int ret;
> +
> +       guard(mutex)(&slider_param_lock);
> +
> +       ret =3D kstrtou8(arg, 16, &offset);
> +       if (!ret) {
> +               if (offset > SOC_SLIDER_VALUE_MAXIMUM)
> +                       return -EINVAL;
> +
> +               slider_offset =3D offset;
> +       }
> +
> +       return ret;
> +}
> +
> +static int slider_def_offset_get(char *buf, const struct kernel_param *k=
p)
> +{
> +       guard(mutex)(&slider_param_lock);
> +       return sysfs_emit(buf, "%02x\n", slider_offset);
> +}
> +
> +static const struct kernel_param_ops slider_offset_ops =3D {
> +       .set =3D slider_def_offset_set,
> +       .get =3D slider_def_offset_get,
> +};
> +
> +module_param_cb(slider_offset, &slider_offset_ops, NULL, 0644);
> +MODULE_PARM_DESC(slider_offset, "Set slider offset.");

The _DESC is a bit short IMO.  I would say something like "Maximum
offset by which the slider can be increased automatically above the
prescribed value".

> +
>  /* Convert from platform power profile option to SoC slider value */
>  static int convert_profile_to_power_slider(enum platform_profile_option =
profile)
>  {
> @@ -120,6 +154,8 @@ static int convert_power_slider_to_profile(u8 slider)
>  #define SLIDER_MASK            GENMASK_ULL(2, 0)
>  #define SLIDER_ENABLE_BIT      7
>
> +#define SLIDER_OFFSET_MASK     GENMASK_ULL(6, 4)
> +
>  static void set_soc_power_profile(struct proc_thermal_device *proc_priv,=
 int slider)
>  {
>         u64 val;
> @@ -128,6 +164,11 @@ static void set_soc_power_profile(struct proc_therma=
l_device *proc_priv, int sli
>         val &=3D ~SLIDER_MASK;
>         val |=3D FIELD_PREP(SLIDER_MASK, slider);
>         val |=3D BIT(SLIDER_ENABLE_BIT);
> +
> +       /* Set the slider offset from module params */
> +       val &=3D ~SLIDER_OFFSET_MASK;
> +       val |=3D FIELD_PREP(SLIDER_OFFSET_MASK, slider_offset);
> +
>         writeq(val, proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
>  }
>
> --

