Return-Path: <linux-pm+bounces-12433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA73956C67
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8014280D98
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2CC1662E8;
	Mon, 19 Aug 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFVRNV2w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FE1DFEF
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075204; cv=none; b=Wa8Fx71xfjrq9r/afaXL7vPpDP+4vleMu3VL9vNIiCC1ienXd616Xkw8g8Yof1o+shde70+CPmsd6/lsm4G4cHl9nQh/9Vx8skHGlnX0mwYzznN/ecmzhpiLVKQKD58UQVMy7lDyS68S0TXPSnGI62JZrSOsYxXTekhgqig3nrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075204; c=relaxed/simple;
	bh=RPFX6jE1SiyICtHSpM5y/EC+DcnHRBGmo328BHBt6W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTa+ovRyYO0oEeDEemjeK+wDVcXT1HCCwzsTog/kuq9REeHGFW8T67mAnON72+QfRtzCa+owWdc6lg75TtjTqw+85tTcE3VmPhjwLC/HOHg0qZv2gPbqnfrasZKe3xcHVje1we16SFJ0TFGors4ujFsnKDw/EHdXDUNVqgiLxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFVRNV2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320DC4AF10
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724075204;
	bh=RPFX6jE1SiyICtHSpM5y/EC+DcnHRBGmo328BHBt6W8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oFVRNV2wK7WtFxJhFjoAci4WAmxw9+JXKF7DmbyL0nuLjMyCMNYKHQNYNdLKH4jDh
	 F/H31DyX7Cyl6tymfPOnXUsgrh2P3JybjQueVfI8ZcvH6iAUQbtMPxUAcfZMp/Un8Z
	 r+ExjjnF/7LkRHNZUmx9JgW8zNXc+FtXAwUHYocwMuzMocuoaAGIy8wPDFKWtmhykI
	 zj3/pu12L/5kB0jxFUUBlw2XulPQ75s2GKoM7+cifIH+JPMGPxmNDOwnbdkTOgj4nr
	 r/DizDQWjKIEdoc+lvolXRWGUCTBeGs51AAPEJSzbJWFDdMjdI+vVPQngX2U0X4Bw3
	 8Ex50+m1v922g==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-268d0979e90so492989fac.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 06:46:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyYsV1aaYEjYV6dvxTQYfGqjB+PUetDl211RdZ3+CKKXpP8EAd6hsweSxfKAvxmk8D+7iZaHEKXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXst+HpnzpIlRwd7zti00iXAKeaY5gO2VbMbt3iahH2jArwTYL
	8gW+hCUYaRq6rruapCP0NwLjLw8GQtS9m6E8Id+zvsJMfdeX8qP3DOBsViBeHr6HmC66IEy7L1R
	5eXsMGxC4KRDERkfyU6CDchbzjkI=
X-Google-Smtp-Source: AGHT+IFbKz8nhyxMMzbk4aJHbUFHOKbNw+zkzZmgMiZX75m05EpiSkq1WebgNpVIgcDf9Larur/vwl+LI6r1co0i6UE=
X-Received: by 2002:a05:6870:4414:b0:26c:78ce:b0cc with SMTP id
 586e51a60fabf-2701c5680f8mr5397619fac.8.1724075203635; Mon, 19 Aug 2024
 06:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806160310.3719205-1-artem.bityutskiy@linux.intel.com>
In-Reply-To: <20240806160310.3719205-1-artem.bityutskiy@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 15:46:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h5zVamKa16ShtgbsC6+TK3U5LNu51pX7ZTG8Qb1sQ0hQ@mail.gmail.com>
Message-ID: <CAJZ5v0h5zVamKa16ShtgbsC6+TK3U5LNu51pX7ZTG8Qb1sQ0hQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: add Granite Rapids Xeon support
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>, 
	Artem Bityutskiy <dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:03=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> Add Granite Rapids Xeon C-states, which are C1, C1E, C6, and C6P.
>
> Comparing to previous Xeon Generations (e.g., Emerald Rapids), C6 request=
s end
> up only in core C6 state, and no package C-state happens (even if all cor=
es are
> in core C6). C6P requests also end up in core C6, but if all cores are id=
le,
> the SoC enters the package C6 state.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>
> Used 'wult' tool for measuring 'exit_latency', and 'pbe' tool for measuri=
ng
> 'target_residency', both tools are part of the the 'wult' project:
> https://github.com/intel/wult
>
>  drivers/idle/intel_idle.c | 46 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 9aab7abc2ae9..e20f57ac307e 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1022,6 +1022,45 @@ static struct cpuidle_state spr_cstates[] __initda=
ta =3D {
>                 .enter =3D NULL }
>  };
>
> +static struct cpuidle_state gnr_cstates[] __initdata =3D {
> +       {
> +               .name =3D "C1",
> +               .desc =3D "MWAIT 0x00",
> +               .flags =3D MWAIT2flg(0x00),
> +               .exit_latency =3D 1,
> +               .target_residency =3D 1,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .name =3D "C1E",
> +               .desc =3D "MWAIT 0x01",
> +               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
> +               .exit_latency =3D 4,
> +               .target_residency =3D 4,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .name =3D "C6",
> +               .desc =3D "MWAIT 0x20",
> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED |
> +                                          CPUIDLE_FLAG_INIT_XSTATE,
> +               .exit_latency =3D 170,
> +               .target_residency =3D 650,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .name =3D "C6P",
> +               .desc =3D "MWAIT 0x21",
> +               .flags =3D MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED |
> +                                          CPUIDLE_FLAG_INIT_XSTATE,
> +               .exit_latency =3D 210,
> +               .target_residency =3D 1000,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .enter =3D NULL }
> +};
> +
>  static struct cpuidle_state atom_cstates[] __initdata =3D {
>         {
>                 .name =3D "C1E",
> @@ -1453,6 +1492,12 @@ static const struct idle_cpu idle_cpu_spr __initco=
nst =3D {
>         .use_acpi =3D true,
>  };
>
> +static const struct idle_cpu idle_cpu_gnr __initconst =3D {
> +       .state_table =3D gnr_cstates,
> +       .disable_promotion_to_c1e =3D true,
> +       .use_acpi =3D true,
> +};
> +
>  static const struct idle_cpu idle_cpu_avn __initconst =3D {
>         .state_table =3D avn_cstates,
>         .disable_promotion_to_c1e =3D true,
> @@ -1533,6 +1578,7 @@ static const struct x86_cpu_id intel_idle_ids[] __i=
nitconst =3D {
>         X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,     &idle_cpu_gmt),
>         X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,   &idle_cpu_spr),
>         X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,    &idle_cpu_spr),
> +       X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,    &idle_cpu_gnr),
>         X86_MATCH_VFM(INTEL_XEON_PHI_KNL,       &idle_cpu_knl),
>         X86_MATCH_VFM(INTEL_XEON_PHI_KNM,       &idle_cpu_knl),
>         X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,      &idle_cpu_bxt),
> --

Applied as 6.12 material with some edits in the changelog (please
check), thanks!

