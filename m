Return-Path: <linux-pm+bounces-10540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D369925ED9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 13:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F169F297ACA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCEE170836;
	Wed,  3 Jul 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDtZDFkx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0516F0FB;
	Wed,  3 Jul 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006395; cv=none; b=QfrN4uWXvtBwR80obmTUmJKzbYgmyqxC9jFivJFyXhCgCUSr0fD9CQs6Qt5EgnsM0Oyi35HsrJb1soTRdETWFRWphmB4mFcZ/dptT0lQrMQf/fbBsidht3wLk1Lap4EQyP02atj5faOHgqAmm3lmkl0A1mut2zNDApEOIERR8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006395; c=relaxed/simple;
	bh=Gc9yo+QOB2HbQlWCJcQ7J5N8ryhmmuLbpm/SMDo7jBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmBgf53ERX48pN8YpuKiVNIJGP49JIKid6JUw0xMetI4tCU8TntwBKiJHEAkhqurvulxtBWATeOBMGql8zkbNgE7CrhZ8Fjj2KmKkWE7n6PEJ875wDNnynXVRVplPWPg3swl5yU0NxEJ2TvREmORUYjyt5ID6tEdqO2qQuVo1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDtZDFkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F8C4AF0C;
	Wed,  3 Jul 2024 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720006394;
	bh=Gc9yo+QOB2HbQlWCJcQ7J5N8ryhmmuLbpm/SMDo7jBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cDtZDFkxrfRFrPzouwAqfStjgakXZFTCaoKvUV1P5NLELEx9RlMpV1hiApa640dkE
	 V5+omsuEOKJb/Qs34717BGaGb++42Bj02vH0f+m4wzJr0P+tIXfD9iT2Ymx+1aMfWx
	 uRnZein8x6BWFLLuezWdgxtPUDYVXib+aT47Mok7NLDL4L9Dk/ioaEThFsCp9kddBE
	 /j7J2ujPZRHilMB2DjmM9YShq9vf/R9waa05u92fiPgpUV30+lXK+BLJ5PDX6iAAA7
	 BbY6nUl4kMXKSkVlezYCmveRKlhGoa7M3wsPW/0Aqtw+y3i+2HTBe9meCx9d+VpZD7
	 u5i5RVcCpbtQw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c582673a5so706136fac.2;
        Wed, 03 Jul 2024 04:33:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWywpnx0XyiC5CAGBPukEOCjki7YnGK9xyWn/9Cgeb04t6h1Xerv4dbT6vNBa4t7lbdbKG3RQeKVpAPmkPvKewSbsq/oPWNieb0KnQfPKzubMGA88JvUyfv+yaQTvBYpvlELi9nZ4s=
X-Gm-Message-State: AOJu0YxrRZUFZ82fujFLjD6xBN+dftFuiT8vOYTluu+uZ/zUyCiJg1C0
	IKOpVPR9ZN1HMujla8gRd2V5OnDhqoFlepzRo7AVGFdbTQM121s13qnMUSogCkwN2S2tkhw1IMz
	+icKoD8sJcRt2pU9FTcWOpKsUYME=
X-Google-Smtp-Source: AGHT+IF5FzPy4fwTNbmiEWnBsgiD5fwThxJKbWlk0jsuxIlKgIRe9jkv+WZCm2nQKksldrq0ZGYPWxa1IbZ0sT9F1g0=
X-Received: by 2002:a05:6871:24d5:b0:25d:f237:e108 with SMTP id
 586e51a60fabf-25df237e289mr4249900fac.0.1720006393848; Wed, 03 Jul 2024
 04:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703055445.125362-1-rui.zhang@intel.com>
In-Reply-To: <20240703055445.125362-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2024 13:33:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gVFPNK=_=Tnr0QJ-yBWfSWc+wuJrE079Fz+Ba1P57TmA@mail.gmail.com>
Message-ID: <CAJZ5v0gVFPNK=_=Tnr0QJ-yBWfSWc+wuJrE079Fz+Ba1P57TmA@mail.gmail.com>
Subject: Re: [PATCH] Thermal: intel: hfi: Give HFI instances package scope
To: Zhang Rui <rui.zhang@intel.com>, ricardo.neri-calderon@linux.intel.com
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:55=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wrot=
e:
>
> The Intel Software Developer's Manual defines the scope of HFI (registers
> and memory buffer) as package. Use package scope* in the software

"as a package"

> representation of an HFI instance.
>
> Using die scope in HFI instances has the effect of creating multiple,
> conflicting, instances for the same package: each instance allocates its
> own memory buffer and configures the same package-level registers.
> Specifically, only one of the allocated memory buffers can be set in the
> MSR_IA32_HW_FEEDBACK_PTR register. CPUs get incorrect HFI data from the
> table.
>
> The problem does not affect current HFI-capable platforms because they
> all have single-die processors.
>
> * We used die scope for HFI instances because there have been processors
> in which packages where enumerated as dies. None of those systems support

"were"

> HFI. If such a system emerged we would need to quirk it.
>
> Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Ricardo, any concerns?

> ---
>  drivers/thermal/intel/intel_hfi.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/in=
tel_hfi.c
> index a180a98bb9f1..5b18a46a10b0 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -401,10 +401,10 @@ static void hfi_disable(void)
>   * intel_hfi_online() - Enable HFI on @cpu
>   * @cpu:       CPU in which the HFI will be enabled
>   *
> - * Enable the HFI to be used in @cpu. The HFI is enabled at the die/pack=
age
> - * level. The first CPU in the die/package to come online does the full =
HFI
> + * Enable the HFI to be used in @cpu. The HFI is enabled at the package
> + * level. The first CPU in the package to come online does the full HFI
>   * initialization. Subsequent CPUs will just link themselves to the HFI
> - * instance of their die/package.
> + * instance of their package.
>   *
>   * This function is called before enabling the thermal vector in the loc=
al APIC
>   * in order to ensure that @cpu has an associated HFI instance when it r=
eceives
> @@ -414,31 +414,31 @@ void intel_hfi_online(unsigned int cpu)
>  {
>         struct hfi_instance *hfi_instance;
>         struct hfi_cpu_info *info;
> -       u16 die_id;
> +       u16 pkg_id;
>
>         /* Nothing to do if hfi_instances are missing. */
>         if (!hfi_instances)
>                 return;
>
>         /*
> -        * Link @cpu to the HFI instance of its package/die. It does not
> +        * Link @cpu to the HFI instance of its package. It does not
>          * matter whether the instance has been initialized.
>          */
>         info =3D &per_cpu(hfi_cpu_info, cpu);
> -       die_id =3D topology_logical_die_id(cpu);
> +       pkg_id =3D topology_logical_package_id(cpu);
>         hfi_instance =3D info->hfi_instance;
>         if (!hfi_instance) {
> -               if (die_id >=3D max_hfi_instances)
> +               if (pkg_id >=3D max_hfi_instances)
>                         return;
>
> -               hfi_instance =3D &hfi_instances[die_id];
> +               hfi_instance =3D &hfi_instances[pkg_id];
>                 info->hfi_instance =3D hfi_instance;
>         }
>
>         init_hfi_cpu_index(info);
>
>         /*
> -        * Now check if the HFI instance of the package/die of @cpu has b=
een
> +        * Now check if the HFI instance of the package of @cpu has been
>          * initialized (by checking its header). In such case, all we hav=
e to
>          * do is to add @cpu to this instance's cpumask and enable the in=
stance
>          * if needed.
> @@ -504,7 +504,7 @@ void intel_hfi_online(unsigned int cpu)
>   *
>   * On some processors, hardware remembers previous programming settings =
even
>   * after being reprogrammed. Thus, keep HFI enabled even if all CPUs in =
the
> - * die/package of @cpu are offline. See note in intel_hfi_online().
> + * package of @cpu are offline. See note in intel_hfi_online().
>   */
>  void intel_hfi_offline(unsigned int cpu)
>  {
> @@ -674,9 +674,13 @@ void __init intel_hfi_init(void)
>         if (hfi_parse_features())
>                 return;
>
> -       /* There is one HFI instance per die/package. */
> -       max_hfi_instances =3D topology_max_packages() *
> -                           topology_max_dies_per_package();
> +       /*
> +        * Note: HFI resources are managed at the physical package scope.
> +        * There could be platforms that enumerate packages as Linux dies=
.
> +        * Special handling would be needed if this happens on an HFI-cap=
able
> +        * platform.
> +        */
> +       max_hfi_instances =3D topology_max_packages();
>
>         /*
>          * This allocation may fail. CPU hotplug callbacks must check
> --
> 2.34.1
>
>

