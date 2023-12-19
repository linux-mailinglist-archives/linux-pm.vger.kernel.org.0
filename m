Return-Path: <linux-pm+bounces-1375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C26B818F1E
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 19:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C448B21564
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B012E3E3;
	Tue, 19 Dec 2023 17:59:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0D3D0D2
	for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5909156aea9so802808eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 09:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008779; x=1703613579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYWus7B1187lySowqzSlrbzkyUAeNdjylrCpaloJzmI=;
        b=PV6yDOk7mog9bX7Lo98MiMCLbLjEZp+jM7sYW1Xgp7fOvh1FXsCiu2aI37PfRltAoo
         GU5ITpkEWEHSa7nIo/tEm12kPNEtBTb+JKk+wKw2fQvNrbl23Iuoev0yNL/scqyV61B8
         JmVKlKqrIQKXqc+kKMCycw6KeBLC1Bho8wiWc9JeJiRat1aWGu0xiyXH36wBC+w74lUi
         GrMAtojU8YN3367JPY4XVXOlC5XZWet3EqbmaFPyPwur77AwhF3V/spMCYc12Pblrgvw
         svLrgegwl4c5IrLZKWWrYSAeMyTK+f+QwWZ3Zl+UI5lHrWjzQoTUlgpx4WxNA8URV0zU
         8EIQ==
X-Gm-Message-State: AOJu0YzLxfC+4QJRMkdBkIZ7YBiXDMJcdRUEllBEmha+1kk/bSVOPKsr
	qAnao/9h4bkIUiFwmkX1RrfKbzQMWetjxNIC7sFLOiMR
X-Google-Smtp-Source: AGHT+IEGT/lUrdmwKFkJ6vBT8fLYvIeXxEd8fOZbY8Gx4xxhpOI74ElJE5FdjPdxqcgTgJSy3jFpgRH+Ihcu37oOtaw=
X-Received: by 2002:a05:6820:2c91:b0:593:e60a:493e with SMTP id
 dx17-20020a0568202c9100b00593e60a493emr2216753oob.0.1703008779418; Tue, 19
 Dec 2023 09:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214165622.100428-1-dedekind1@gmail.com>
In-Reply-To: <20231214165622.100428-1-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 18:59:28 +0100
Message-ID: <CAJZ5v0hcL1KLauQOODr7Lm_wrzMw=mdkkPP0+vEcETAQPdgnsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] intel_idle: add Grand Ridge SoC support
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 5:56=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Add Intel Grand Ridge SoC C-states, which are C1, C1E, and C6S.
>
> The Grand Ridge SoC is built with modules, each module includes 4 cores
> (Crestmont microarchitecture). There is one L2 cache per module, shared b=
etween
> the 4 cores.
>
> There is no core C6 state, but there is C6S state, which has module scope=
:
> when all 4 cores request C6S, the entire module (4 cores + L2 cache) ente=
rs the
> low power state.
>
> Package C6 is not supported by Grand Ridge SoC.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index cfd0b24fd7f1..3b846d4f8707 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1271,6 +1271,35 @@ static struct cpuidle_state snr_cstates[] __initda=
ta =3D {
>                 .enter =3D NULL }
>  };
>
> +static struct cpuidle_state grr_cstates[] __initdata =3D {
> +       {
> +               .name =3D "C1",
> +               .desc =3D "MWAIT 0x00",
> +               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_ALWAYS_ENABLE,
> +               .exit_latency =3D 1,
> +               .target_residency =3D 1,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .name =3D "C1E",
> +               .desc =3D "MWAIT 0x01",
> +               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
> +               .exit_latency =3D 2,
> +               .target_residency =3D 10,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .name =3D "C6S",
> +               .desc =3D "MWAIT 0x22",
> +               .flags =3D MWAIT2flg(0x22) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency =3D 140,
> +               .target_residency =3D 500,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .enter =3D NULL }
> +};
> +
>  static const struct idle_cpu idle_cpu_nehalem __initconst =3D {
>         .state_table =3D nehalem_cstates,
>         .auto_demotion_disable_flags =3D NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO=
_DEMOTE,
> @@ -1420,6 +1449,12 @@ static const struct idle_cpu idle_cpu_snr __initco=
nst =3D {
>         .use_acpi =3D true,
>  };
>
> +static const struct idle_cpu idle_cpu_grr __initconst =3D {
> +       .state_table =3D grr_cstates,
> +       .disable_promotion_to_c1e =3D true,
> +       .use_acpi =3D true,
> +};
> +
>  static const struct x86_cpu_id intel_idle_ids[] __initconst =3D {
>         X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,          &idle_cpu_nhx),
>         X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,             &idle_cpu_nehalem=
),
> @@ -1466,6 +1501,7 @@ static const struct x86_cpu_id intel_idle_ids[] __i=
nitconst =3D {
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,  &idle_cpu_bxt),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,     &idle_cpu_dnv),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,      &idle_cpu_snr),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,      &idle_cpu_grr),
>         {}
>  };
>
>
> base-commit: ee96d5c15517fbdf136aeff1919646e843fbb6f3
> --

Applied as 6.8 material along with the [2/2], thanks!

