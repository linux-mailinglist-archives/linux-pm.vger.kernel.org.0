Return-Path: <linux-pm+bounces-7642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B18BFCC1
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A30B2173D
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227A82D68;
	Wed,  8 May 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY9FAj5O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BF7D405;
	Wed,  8 May 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169548; cv=none; b=gyMyunG32vXpGy29xSUID3xMc9JORnxR46EHBbwqs3uOtmt3foxKrQGKW/Kd72x5jHNz+Erq2fbRD/jbqLSSk+lfsKe9iJCyqgeOvv/OLb69fWZsGK6Dq7wRJIk1RrfIvC04kCN6Lq0TR/dKFFh5SkjTFbUPSpOFFb1k0Ozh7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169548; c=relaxed/simple;
	bh=T2T1c8P9LRlCkGtHutSW1xZfS0Ui+J7aHG0ayh6G03M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plDHC3psxgQtjgu6nU3xqNdVGoXdZbQo05XgIevHrXSZDvt1hpfIPUOVsIus54gD7oc4VpQG0Je7B9/o1fTrl9IQP/xqZboPAaNNVlOd5/T7wKeEjbqfWiFP2BL1hv8ictiSepBnCtKYGGLuT7rRqETeJbSTgBAELjeWTcmQGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY9FAj5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB465C3277B;
	Wed,  8 May 2024 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169547;
	bh=T2T1c8P9LRlCkGtHutSW1xZfS0Ui+J7aHG0ayh6G03M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RY9FAj5OA1K4QOc1q0QtUajpwyO5O5RK/eCTyskaCKB3O8cAUqoIB7coFkpbZytda
	 skOZ2cvjAGEmOTnknibL2reyTQ871KbI7dKy43c6X+b+FcrEC0VdBTA0hyNboHGpIg
	 tvBZA0ufLS0ICDlGgEqHFQNqX6Mm3tPTukSo0m0DyEHLh/W2/Ds3+hoQdc9AEg1FIN
	 GJQRpvDbY7Ntwe/GsAXGDMQkhki902P4hAJy3D/+7+qzPrDNuxSpynJYHzQlVjC+7j
	 Vlb3ehCzf4c/5CHw4sTuEGHCsUwcKniqJf+tC+KN1ymAD6pIqiHZcuR47iYHDuUylW
	 8mnIOEskWvzqg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ad288442bdso483390eaf.3;
        Wed, 08 May 2024 04:59:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9zH4vIcTe+gWqo9n+Oq57btcLBq9ieXDHxIyeP3KBDBTkpQPOpzNC1usQwRG1ZIbu/mgWQiC/9Z1HvIyoMVn140isd9MZvHcHYfaPxw35JNDYW7zVHOX5Pc4ialxiu3T0a9nlmJs=
X-Gm-Message-State: AOJu0Yyi63v4oJ9Mpv1OLQI8kgEwGnUdmg7oQfgyu+nipqmibwsd7A7t
	kDRqb0KfvsBKV3OB06Xpy7InqdNIiHG2stmD1k2qQaaKnDLG0CmmvEUQbZYU/3cfrr5Gb/89oSF
	T78DWowkeuJPwi0x31ICFR2/1d4A=
X-Google-Smtp-Source: AGHT+IFS3EDJbe8ENnYkyF9SduMaIcC7krDDlJSk69HKvAxmJ6Hl/d5/kgfQO7zi5w4pc+3hWp607ekKxkcjY+4bLD4=
X-Received: by 2002:a05:6820:b05:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5b24d47d89fmr2171435eaf.1.1715169547045; Wed, 08 May 2024
 04:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508054703.3728337-1-perry.yuan@amd.com>
In-Reply-To: <20240508054703.3728337-1-perry.yuan@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 May 2024 13:58:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iqEj0bx72Rqn--srv8Y+ievjZx6W8_kJksPzPVTLLqxQ@mail.gmail.com>
Message-ID: <CAJZ5v0iqEj0bx72Rqn--srv8Y+ievjZx6W8_kJksPzPVTLLqxQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: fix the highest frequency issue
 which limit performance
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com, 
	Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, 
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 7:47=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wrot=
e:
>
> To address the performance drop issue, an optimization has been
> implemented. The incorrect highest performance value previously set by th=
e
> low-level power firmware for AMD CPUs with Family ID 0x19 and Model ID
> ranging from 0x70 to 0x7F series has been identified as the cause.
>
> To resolve this, a check has been implemented to accurately determine the
> CPU family and model ID. The correct highest performance value is now set
> and the performance drop caused by the incorrect highest performance valu=
e
> are eliminated.
>
> Before the fix, the highest frequency was set to 4200MHz, now it is set
> to 4971MHz which is correct.
>
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>   0    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
>   1    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
>   2    0      0    1 1:1:1:0          yes 4971.0000 400.0000 4865.8140
>   3    0      0    1 1:1:1:0          yes 4971.0000 400.0000  400.0000
>
> v1->v2:
>  * add test by flag from Gaha Bana

This should go into the section below the tags.

And if you send a v2 of a patch, please indicate that this is a v2 in
the subject.

> Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred co=
re support")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218759
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Gaha Bana <gahabana@gmail.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2db095867d03..6a342b0c0140 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,7 +50,8 @@
>
>  #define AMD_PSTATE_TRANSITION_LATENCY  20000
>  #define AMD_PSTATE_TRANSITION_DELAY    1000
> -#define AMD_PSTATE_PREFCORE_THRESHOLD  166
> +#define CPPC_HIGHEST_PERF_PERFORMANCE  196
> +#define CPPC_HIGHEST_PERF_DEFAULT      166
>
>  /*
>   * TODO: We need more time to fine tune processors with shared memory so=
lution
> @@ -326,6 +327,21 @@ static inline int amd_pstate_enable(bool enable)
>         return static_call(amd_pstate_enable)(enable);
>  }
>
> +static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
> +{
> +       struct cpuinfo_x86 *c =3D &cpu_data(0);
> +
> +       /*
> +        * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7=
f,
> +        * the highest performance level is set to 196.
> +        * https://bugzilla.kernel.org/show_bug.cgi?id=3D218759
> +        */
> +       if (c->x86 =3D=3D 0x19 && (c->x86_model >=3D 0x70 && c->x86_model=
 <=3D 0x7f))
> +               return CPPC_HIGHEST_PERF_PERFORMANCE;
> +
> +       return CPPC_HIGHEST_PERF_DEFAULT;
> +}
> +
>  static int pstate_init_perf(struct amd_cpudata *cpudata)
>  {
>         u64 cap1;
> @@ -342,7 +358,7 @@ static int pstate_init_perf(struct amd_cpudata *cpuda=
ta)
>          * the default max perf.
>          */
>         if (cpudata->hw_prefcore)
> -               highest_perf =3D AMD_PSTATE_PREFCORE_THRESHOLD;
> +               highest_perf =3D amd_pstate_highest_perf_set(cpudata);
>         else
>                 highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
>
> @@ -366,7 +382,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata=
)
>                 return ret;
>
>         if (cpudata->hw_prefcore)
> -               highest_perf =3D AMD_PSTATE_PREFCORE_THRESHOLD;
> +               highest_perf =3D amd_pstate_highest_perf_set(cpudata);
>         else
>                 highest_perf =3D cppc_perf.highest_perf;
>
> --

Applied as 6.10 material, thanks!

