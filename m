Return-Path: <linux-pm+bounces-34017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8616BB462F7
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5ACB616CA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94798315D53;
	Fri,  5 Sep 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej9bT+AH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873B315D50;
	Fri,  5 Sep 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098724; cv=none; b=mj+/x/vIWmL1lisCqPftOXdvP/w129ClEo56apNKd9/KbSp89PN6mVhCajB0yl5OIjqiaYUa7tH3qY1Ba7olWbK4PEmmOXIl64lGJoKkrqqilDMoptDiK+l0YjKEHaYbmLvR+B0RNuKYEIEaKV4bwmq0cWDxB5IHDF//mF3Iy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098724; c=relaxed/simple;
	bh=rU8H7yVzYunD4DNT9+hMVGaDzLXU5ASEdQBXlxFPCos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVtAn/KB60f4qg/RR4na8JLKi1vLBIrTTE2f3ayMEFXRmy87FN0OIeh1rVLC15o4U0l3ZqnNl1VFqDbTHMth6q1cYup5LUA6s4vnYsFbvqxs/nIDGjbLVn3kd+RypeiY7eRkHm/BmhveRRcuVx8r/V5QQkNAf4Ny92ch1J8uuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej9bT+AH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4839C4CEF8;
	Fri,  5 Sep 2025 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098723;
	bh=rU8H7yVzYunD4DNT9+hMVGaDzLXU5ASEdQBXlxFPCos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ej9bT+AHaViilxZtpDyZHbQ8gop9t4alea0N9e8r5ufJYtbsaoMBBti2/Y0u2G63X
	 WzggPxIawGlanVyEI+RdHIGI3g2r91s4uH1HM7Wo9LVEAka9HI5taNmXLor14cAbHT
	 HfGQiiRz+j6gnotpyQ9tPn7KQa+cEisfmnHU1Ym/WmzJY8X6UPBOFWhptFXBsUZegW
	 W7lV1zrouxNVyo0P7wzDFuMSgY6hWbXzdWYK1bAT6cCEbfQmerscnI9AGQDnGxyti9
	 7ysZ4/r8AGBykIJf0CbnOFdFfQ4m4giIRXb5B0dQr++jYY/RL3LlVoy39ElJIe/v7g
	 4zdQQXNG4qU4A==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61f60e50f74so499611eaf.2;
        Fri, 05 Sep 2025 11:58:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxEI8lqLpJvnPy88e8twhuAOyIA5vLGA79pcxUJELx5avy8Qq/CsniZ8XQO6tZMYFTU1O0MbocmRM=@vger.kernel.org, AJvYcCWDnhEiZOaG1fS5uVqxkKlY3zOR+Sbc4/GPi8+KrORih0XJsFKyC5geTmCtPVvAywA6lRVHNqUP1AfBNuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaw1RwVlfsQDuJr4ItZPhbsuE7ECIHhhlwIlXnrppZkndFH/nM
	nvne1gk3irxrQvKVf8yn3FY6u3aenJE/s5XxQ5OcM3B8Ni9vdNfcbdCCvfYKBQzHX4g2wq3IHgy
	1sHEReu2HjTRFCzrQgJVlOsXEFYUjGao=
X-Google-Smtp-Source: AGHT+IFMSDOOQD8LeOtfW8lG4VvNmodsWThkPD8e8eHfEMXjWk9YZcSuwKltimR8bqgLLyz3/Zd49QfPbkUFeUuVb1g=
X-Received: by 2002:a05:6820:1620:b0:61e:76d7:f1ea with SMTP id
 006d021491bc7-61e76d7f81emr4739925eaf.3.1757098723249; Fri, 05 Sep 2025
 11:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 20:58:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gRkQyZxfsoFOYmvHX3NQz1mwer0gK1NB9gKfwO2TKgGQ@mail.gmail.com>
X-Gm-Features: Ac12FXx8t7CXiL1Lb6ThcDqHZP8IcWR_AgIJc_BTgvHG7NL_xTYxabKE6KZfIxM
Message-ID: <CAJZ5v0gRkQyZxfsoFOYmvHX3NQz1mwer0gK1NB9gKfwO2TKgGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: intel_pstate: Remove EPB related changes
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:06=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The intel_pstate driver does not enable HWP mode when CPUID.06H:EAX[10]
> is not set, indicating that EPP (Energy Performance Preference) is not
> supported by the hardware.
>
> When EPP is unavailable, the system falls back to using EPB (Energy
> Performance Bias) if the feature is supported. However, since the
> intel_pstate driver will not enable HWP in this scenario, any EPB-related
> code becomes unreachable and irrelevant. Remove the EPB handling code
> paths simplifying the driver logic and reducing code size.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 49 +++-------------------------------
>  1 file changed, 4 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index f366d35c5840..c28454b16723 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -620,24 +620,9 @@ static int min_perf_pct_min(void)
>                 (cpu->pstate.min_pstate * 100 / turbo_pstate) : 0;
>  }
>
> -static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
> -{
> -       u64 epb;
> -       int ret;
> -
> -       if (!boot_cpu_has(X86_FEATURE_EPB))
> -               return -ENXIO;
> -
> -       ret =3D rdmsrq_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &=
epb);
> -       if (ret)
> -               return (s16)ret;
> -
> -       return (s16)(epb & 0x0f);
> -}
> -
>  static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_da=
ta)
>  {
> -       s16 epp;
> +       s16 epp =3D -EOPNOTSUPP;
>
>         if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>                 /*
> @@ -651,34 +636,13 @@ static s16 intel_pstate_get_epp(struct cpudata *cpu=
_data, u64 hwp_req_data)
>                                 return epp;
>                 }
>                 epp =3D (hwp_req_data >> 24) & 0xff;
> -       } else {
> -               /* When there is no EPP present, HWP uses EPB settings */
> -               epp =3D intel_pstate_get_epb(cpu_data);
>         }
>
>         return epp;
>  }
>
> -static int intel_pstate_set_epb(int cpu, s16 pref)
> -{
> -       u64 epb;
> -       int ret;
> -
> -       if (!boot_cpu_has(X86_FEATURE_EPB))
> -               return -ENXIO;
> -
> -       ret =3D rdmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> -       if (ret)
> -               return ret;
> -
> -       epb =3D (epb & ~0x0f) | pref;
> -       wrmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, epb);
> -
> -       return 0;
> -}
> -
>  /*
> - * EPP/EPB display strings corresponding to EPP index in the
> + * EPP display strings corresponding to EPP index in the
>   * energy_perf_strings[]
>   *     index           String
>   *-------------------------------------
> @@ -782,7 +746,7 @@ static int intel_pstate_set_energy_pref_index(struct =
cpudata *cpu_data,
>                                               u32 raw_epp)
>  {
>         int epp =3D -EINVAL;
> -       int ret;
> +       int ret =3D -EOPNOTSUPP;
>
>         if (!pref_index)
>                 epp =3D cpu_data->epp_default;
> @@ -802,10 +766,6 @@ static int intel_pstate_set_energy_pref_index(struct=
 cpudata *cpu_data,
>                         return -EBUSY;
>
>                 ret =3D intel_pstate_set_epp(cpu_data, epp);
> -       } else {
> -               if (epp =3D=3D -EINVAL)
> -                       epp =3D (pref_index - 1) << 2;
> -               ret =3D intel_pstate_set_epb(cpu_data->cpu, epp);
>         }
>
>         return ret;
> @@ -1337,9 +1297,8 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>         if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
>                 value &=3D ~GENMASK_ULL(31, 24);
>                 value |=3D (u64)epp << 24;
> -       } else {
> -               intel_pstate_set_epb(cpu, epp);
>         }
> +
>  skip_epp:
>         WRITE_ONCE(cpu_data->hwp_req_cached, value);
>         wrmsrq_on_cpu(cpu, MSR_HWP_REQUEST, value);
> --

Applied as 6.18 material, thanks!

