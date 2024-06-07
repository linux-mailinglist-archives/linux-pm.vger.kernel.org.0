Return-Path: <linux-pm+bounces-8802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA098900C67
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 21:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925961F21A9A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C63149DED;
	Fri,  7 Jun 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwfGeeKY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE3D2EE;
	Fri,  7 Jun 2024 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788020; cv=none; b=V0BmmAWcyKP1YnE/gKdcR6irdyaFaQCC/G2Ps7Op3GraFSXtZqZzXKYZWgEWpFwP8iFn8y5HkvHxa+4ZfFJAs/zB5ZXzU4Rk3m4+oprSDRbty/C4VmZQjfw6efQAQZJtnZJwIXso+cdzcNXZH9ewz+kOOX61Wc6IBOHAB/ftyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788020; c=relaxed/simple;
	bh=OL0/L9WY08c0iKLw+OMR1jbr3mgWXPWBsC+s5SBorg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSjqeynomJPFeUF5Gzoc+Ew8p5gKbrxpVu/yvtEuH49Juo2voFnV9lQberIvUL4SQ5Fz3eswPVjW85tv14n2Zv+Hsu0JnptD4+yMLhQINLSEH8yP0YeQ28MwfRlgo4TuzRL80q7xNorV9+YhAiGjiRDQoFqNwRV43gvAhta5EUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwfGeeKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4908C2BBFC;
	Fri,  7 Jun 2024 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717788019;
	bh=OL0/L9WY08c0iKLw+OMR1jbr3mgWXPWBsC+s5SBorg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AwfGeeKYUGsCBWvtlmPlTonNo9xgVJFrH7kQzwnmRuxj0wLhNOvNiKabfkWGkWkxA
	 YJStbblDPwBn9RPZOQxqFYoa+Pg8YTsH+yQwdJppvePXpDjq2EcH1JfyaN1zPzhXmL
	 T1NPmDgqvmU4ZonaVf+Dzh2q/MMdaQFvd4ysmzBS2y9i0nCW8BxYnF74XybBzY9MMZ
	 m8ZuLbfFDnPNy6V1Xh8sot0B/GZceDUQ/+pGXjKswqriEg2eMLYz5btWNx/+m3m8co
	 Rc+9360Jj+HMN0AdAd/9laQrdeEmzbtvrncG2L8yCQmYZxrLKMhQb0FMbAs9VigZV2
	 YbFMd8mMbKV1w==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ba68c30395so274630eaf.1;
        Fri, 07 Jun 2024 12:20:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQsTeoQANl0Jb/hPgZZxlN0Wi3R4kZUzH9z+YinSt/7jPrGtlzhu/UfOLFYrkAB8JzXkatYkJKT2n6NAgHu0MJPtwe5R66NvA0HhvJc+O8KjK5x8JgndutARg8zATZnRoC3X9dKc4=
X-Gm-Message-State: AOJu0YzpVGuzhZiMVWXbiXlCM99WVWFmCe95ei+COplKRH0ASeX81hn2
	9A5J5LM5sDdxCLr3dSzYpwd/eswN7FRgYADLNzYEkJNNsUMF9DPS4O9JTzTNcPoXmjsxN6D+6/n
	+KW2z8GePo8Bgvt44bu9yzuFmsWE=
X-Google-Smtp-Source: AGHT+IEtAayEu1dMu4S/alfVbVYyGb7fa7+NmlvDSSUY2JG4KpYGjyAWp7GGSiMtfBwEXKBdOnExzNQIwedWI7ML7kw=
X-Received: by 2002:a4a:ac08:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5baae73b688mr3326747eaf.1.1717788019071; Fri, 07 Jun 2024
 12:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530055330.1279381-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240530055330.1279381-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 21:20:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hugkS3ZtAoqs1OiaxdDvKo3XrmPyHAAoOscQdNUiqHSA@mail.gmail.com>
Message-ID: <CAJZ5v0hugkS3ZtAoqs1OiaxdDvKo3XrmPyHAAoOscQdNUiqHSA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Support Emerald Rapids OOB mode
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 7:53=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Prevent intel_pstate to load when OOB (Out Of Band) P-states mode is
> enabled in Emerald Rapids. The OOB identifying bits are same as the
> prior generation CPUs like Sapphire Rapids servers. So, also add Emerald
> Rapids to intel_pstate_cpu_oob_ids list.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 4b986c044741..6b6d47d3ec02 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2404,6 +2404,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob=
_ids[] __initconst =3D {
>         X86_MATCH(SKYLAKE_X,            core_funcs),
>         X86_MATCH(ICELAKE_X,            core_funcs),
>         X86_MATCH(SAPPHIRERAPIDS_X,     core_funcs),
> +       X86_MATCH(EMERALDRAPIDS_X,      core_funcs),
>         {}
>  };
>  #endif
> --

Rebased on top of the Tony's series:

https://lore.kernel.org/linux-acpi/20240528184720.56259-1-tony.luck@intel.c=
om/

and applied as 6.11 material.

Thanks!

