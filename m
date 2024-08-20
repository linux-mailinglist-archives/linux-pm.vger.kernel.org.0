Return-Path: <linux-pm+bounces-12559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC749958491
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05851F2792D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCDC18D63E;
	Tue, 20 Aug 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d246HLg6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824818CC10;
	Tue, 20 Aug 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149901; cv=none; b=SDJfLf0nmivtweixodCJECyb6XbOTKJ43ZrMwCxuKJAujZBs/jHv4XA4rKEaSa5psq/P/iGndDsqRaUeUvu1XLDyXjbvKfADqojYTAsE3xfF1YatNQeuChKOPCYeeptKoMQvynsWK783MVqkuvhZ8wnbhhTPfAd5yk+/Q7k6l4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149901; c=relaxed/simple;
	bh=sJg2jrIRdzfU5ReseLLRt+fX0mWkpd3DRQr9famwnac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkCDpw73pRAq/gd+uSInGTGv3EXHD0OpURF2DJCX3O+/k1W4a2qj8sGWCHGOHyoB6b2kAUwz4lFtobua0wFFvnB5h1QTmBlbeZi+DylUFAvesxnjAwcpVk+GVDmpJRiOA9JMcLvu/xSzZukMmoaZps99plG8ct76riOg65y9iwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d246HLg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA74C4AF11;
	Tue, 20 Aug 2024 10:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724149901;
	bh=sJg2jrIRdzfU5ReseLLRt+fX0mWkpd3DRQr9famwnac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d246HLg6uJSkavWPD6GW2i+EaG+eseJ6UXnlfJ5zmoNQH5WO/UEC+is4dKKXU/dVu
	 OnPj0HbfDNKAeDjw511ps753M6IKSbBfGB/Jkf51Uu0gQsSs2Bj9L5jN2UAH4iP+rq
	 K+HbeLwspfoYF3gY/jVBkMFYUVVAlg/BOz4ANe2xXU2JO2JL+NRaXh2h3F8gtqiyIT
	 mUMqISWyQXTgFYhCWxg1sUQLrUDtJMoEBJ9DlEbWknK8y4eN5n+JWIbNbaC38zOg9Y
	 GbshA7kwG3EqEgVfGhlsk28afWbni0rd/qezl2AsIVn/lXEcO08yPwGmtJ6Luaonk6
	 /+VBQHE4BhQRA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-26456710cfdso717181fac.0;
        Tue, 20 Aug 2024 03:31:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2G8jGGGOiaEDZ8sRScaEMz1+b/aotvnDqM5ZMtD+Iq1dtMdC5NqB8dQuthQ0AML2ITo8LYCv0CW6VWmY=@vger.kernel.org, AJvYcCWeqal8FEBBCgVzd0WGLC1N1hHwZnoghqZOngB1VR4habGaqHUwEXVzHYM0Fn3m+sRgJ6fMHYx6Okk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLzqb6V+mltyJe7oMJks2RpFo0fRyOJz2Umpuu57ho8XXnrKm
	Iii+Lga89CfUBJk4K4gI72CVQivZMGs0C26bLXZzHHuwDg/BMgGrK0QG5C8IAG0TBN2nzNwG3wM
	rQHBgsA2/dpxjLNPoy42Zp5T6E/g=
X-Google-Smtp-Source: AGHT+IH410LBce520Bj3qdO77LgvUxf1TwFNaa/kJ+Loveib+N92f7mFOvTLaT+uKVHwvb4FotpzFoMHDRr7D93YkBU=
X-Received: by 2002:a05:6870:7b4b:b0:25e:14d9:da27 with SMTP id
 586e51a60fabf-2701c0a0273mr7714116fac.0.1724149900394; Tue, 20 Aug 2024
 03:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820041128.102452-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240820041128.102452-1-kai.heng.feng@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Aug 2024 12:31:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDTLv7N6SZn7u13G05xrgAe4eHgykqwGSu8igyMd-xrA@mail.gmail.com>
Message-ID: <CAJZ5v0iDTLv7N6SZn7u13G05xrgAe4eHgykqwGSu8igyMd-xrA@mail.gmail.com>
Subject: Re: [PATCH v2] intel_idle: Disable C1E on Jasper Lake and Elkhart Lake
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jacob.jun.pan@linux.intel.com, lenb@kernel.org, 
	artem.bityutskiy@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 6:20=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> PCIe ethernet throughut is sub-optimal on Jasper Lake and Elkhart Lake.
>
> The CPU can take long time to exit to C0 to handle IRQ and perform DMA
> when C1E is enabled.
>
> So adjust intel_idle to use _CST when state_table is absent, and disable
> C1E on those two platforms.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219023
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Allow the driver to use _CST when state_table is absent.
>
>  drivers/idle/intel_idle.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 9aab7abc2ae9..ac1c6f4f9c7f 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1475,6 +1475,10 @@ static const struct idle_cpu idle_cpu_dnv __initco=
nst =3D {
>         .use_acpi =3D true,
>  };
>
> +static const struct idle_cpu idle_cpu_tmt __initconst =3D {
> +       .disable_promotion_to_c1e =3D true,
> +};
> +
>  static const struct idle_cpu idle_cpu_snr __initconst =3D {
>         .state_table =3D snr_cstates,
>         .disable_promotion_to_c1e =3D true,
> @@ -1538,6 +1542,8 @@ static const struct x86_cpu_id intel_idle_ids[] __i=
nitconst =3D {
>         X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,      &idle_cpu_bxt),
>         X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS, &idle_cpu_bxt),
>         X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,    &idle_cpu_dnv),
> +       X86_MATCH_VFM(INTEL_ATOM_TREMONT,       &idle_cpu_tmt),
> +       X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,     &idle_cpu_tmt),
>         X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,     &idle_cpu_snr),
>         X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,     &idle_cpu_grr),
>         X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,   &idle_cpu_srf),
> @@ -2075,7 +2081,7 @@ static void __init intel_idle_cpuidle_driver_init(s=
truct cpuidle_driver *drv)
>
>         drv->state_count =3D 1;
>
> -       if (icpu)
> +       if (icpu && icpu->state_table)
>                 intel_idle_init_cstates_icpu(drv);
>         else
>                 intel_idle_init_cstates_acpi(drv);
> @@ -2209,7 +2215,11 @@ static int __init intel_idle_init(void)
>
>         icpu =3D (const struct idle_cpu *)id->driver_data;
>         if (icpu) {
> -               cpuidle_state_table =3D icpu->state_table;
> +               if (icpu->state_table)
> +                       cpuidle_state_table =3D icpu->state_table;
> +               else if (!intel_idle_acpi_cst_extract())
> +                       return -ENODEV;
> +
>                 auto_demotion_disable_flags =3D icpu->auto_demotion_disab=
le_flags;
>                 if (icpu->disable_promotion_to_c1e)
>                         c1e_promotion =3D C1E_PROMOTION_DISABLE;
> --

That's exactly what I wanted to do, thanks for taking care of this!

I'll queue it up for 6.12 later today.

