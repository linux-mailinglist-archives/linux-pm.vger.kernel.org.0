Return-Path: <linux-pm+bounces-8801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62258900C56
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 21:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22CC281103
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC014658E;
	Fri,  7 Jun 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI+1PEZA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DB13E8BE;
	Fri,  7 Jun 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787631; cv=none; b=IdJw3kp7loU6S0ecKonF1MCopy3HoamgBDL+E/jX/S+9gyHZWPRUsWt65KY55hv6Rz+/DNVSBFlfOquNmmSd3zXh63FZlHTbOxhCuOzBMM+rOrW/AcWSR73WPtJwmsBw1tAwPO/5PeZG1EHreIia2KZSwn/hbSGVstQJUYaZkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787631; c=relaxed/simple;
	bh=x2ahY+dEvDzy4HX0T+/KAbqwUVPGgL1I0GbISGbHWxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8VMCA4TED+JwVZ8gIDj2gql3eLviH0agm8McreRTTFwFeWW6Nnm7sibuxY9zaGDD9BtpJHwzdamZ7g8Hpr9fEQwsb6/C+QS40Shv7Olcukv8m0i2lzpA6pm+jqhfN2IF8lI4Yuls2tdh6ucz1UzIX1OHvDzmQhrbILkFaE5ZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI+1PEZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217CEC32786;
	Fri,  7 Jun 2024 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717787631;
	bh=x2ahY+dEvDzy4HX0T+/KAbqwUVPGgL1I0GbISGbHWxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CI+1PEZAFYUs+a13vyaW5ladIKnwaUaQhsM04Z5me+nnzgXPVcNRZ4o+6PN14obF3
	 GJnQRkOjch8PeQGLOHOknI1iQK+InJLEQvSFe+6UkNy+KKjJSak+mYxL64MRIJ3KYi
	 8uLirbimhffFrqD3UioNGIR50i8OsDxQX9pKLs/iBEDdWNFnUy4mDWR56ZXrJkF04o
	 edjQ1dsLn9g5jLXKpj4VTCUWMwPmaPjnQaCn+QFSLo87BRmhX9hjBkJGJwK2RckXrn
	 /cQSuA2nqjsRHMbqe4s67X826Mg36rUwRJ3epM+B4RoI5QXIdkBKOoIY7LJcoTI9UT
	 9sHwgf+ESuT9Q==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5bacd54d58bso18894eaf.1;
        Fri, 07 Jun 2024 12:13:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIxw2IOEAqf6sxJVFmZGhirUpZ+rRQ+Ue86JmBt+BmFKkj5FP2QpNPKIdskGrBlSIHiYLbTC96UzBBWxXuAy3ljo6eg2XkOMtnKM8h9wZa0BIMKQ8tqOffvjStACZh+Apa/gudZ1I=
X-Gm-Message-State: AOJu0YyVL6CjEzjj96DaS+V/U4xsrrKODy2dwqRXFNOrSO9cZqTYT8VB
	UiSjazoayw6EEuJ1plohHOtPlw0ld8nXJZv3qevAi+FbiyY4aufVPzyDalUP+XVx9fDav5Qpy2z
	4aCyw0gOtsjDdZvTJ+da0AgeKrnA=
X-Google-Smtp-Source: AGHT+IEJbHNU8DWPnlOJfgLYjv0dwVSwuAAS5eZsRR3KtCLu9uwfJ/a3EIVxxcdh6FBPfgZ9ciUGpkcRPFW7tcRvYBo=
X-Received: by 2002:a05:6820:708:b0:5ba:6669:ba6e with SMTP id
 006d021491bc7-5baaed4f14dmr3172627eaf.1.1717787630415; Fri, 07 Jun 2024
 12:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606182748.2457952-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240606182748.2457952-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 21:13:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+R6JK=T9EjmweRPKmcorw93JmPM4u-Z=pywv6kH7zUA@mail.gmail.com>
Message-ID: <CAJZ5v0g+R6JK=T9EjmweRPKmcorw93JmPM4u-Z=pywv6kH7zUA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Update Arrow Lake EPPs
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 8:27=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Use the same default EPPs as Meteor Lake generation.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 8b0032d6a519..8550fae383b0 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3430,6 +3430,8 @@ static const struct x86_cpu_id intel_epp_default[] =
=3D {
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_=
PERF_EPP(32)),
>         X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_E=
PP_POWERSAVE,
>                                                                     179, =
64, 16)),
> +       X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE, HWP_SET_EPP_VALUES(HWP_EPP_=
POWERSAVE,
> +                                                                179, 64,=
 16)),
>         {}
>  };
>
> --

Rebased on top of the Tony's series:

https://lore.kernel.org/linux-acpi/20240528184720.56259-1-tony.luck@intel.c=
om/

and applied as 6.11 material.

Thanks!

