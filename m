Return-Path: <linux-pm+bounces-8800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57069900C42
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5661F232E0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516CA143865;
	Fri,  7 Jun 2024 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EItjX2Yb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37B71748;
	Fri,  7 Jun 2024 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787321; cv=none; b=UJGdNQeKwiwUBl0uSoiSvtwzMHupcXkXKlO/EVoE+6l9t+SG5CbiJ2pdxgwGJDqWrhJXMJtrkOh0pf7ojc8LJBVa/prx+MRJEeT6FAM7rZUFRsrJdqpa198WeMJlkpA2WyQBppwvfIyNmG3RPGtDlIvE8s3addaYA+2G5PU/2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787321; c=relaxed/simple;
	bh=CeP1UIR36zWUnd3p+LroQV2EmrDPKicBiL6js7aKA6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFasHOc/7OwkVcXj0/jS0W/n4YKnPbI1RiFUlpCh5ObSzbrFVvwAY7CO7GbgK1PAgJlDHR/F8RxE4AXgIavbvjim3yB9WyPn85KH2PcpsZDCtJaTbyaDAa+88bhn4+uGzKPVio++5ScaYM3ClB8SQ0mNCrO4QDgvVHuYSzzMKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EItjX2Yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00E1C4AF08;
	Fri,  7 Jun 2024 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717787320;
	bh=CeP1UIR36zWUnd3p+LroQV2EmrDPKicBiL6js7aKA6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EItjX2YbNNhqLhlRDnXQzvl8fA33vyauL0C5wJlXg9mKPs38ANaDX3VVCVdZYGlCT
	 R0nMWbxZkewdZ7gOUK8UoMX6DCQ8MzgSzdtbZsl837rsARVe5gKszWob50luwIf/wb
	 0s9Y+58G1VBG/Rwx8ip9wQ+I6l3l/1enGyG1sNwIHzLYqwjmiDHtTAo++9lnO8UcPu
	 LivnXPKsdpGBXVinzYMA2aICgqLVt6AQreqP8gjYhM6jDsRlVR81zsFOk2n3Txqegm
	 JR5HiDiXIfQbv2LlttCdPttt5jsLa+XA8bQLQQZA0k1HwJFGXgIMwMJYkH1J9jT9nt
	 3AKyFgk3G/8DA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d21c5b48f5so11792b6e.0;
        Fri, 07 Jun 2024 12:08:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfqmM9MttgMjMqxgauyleOyQlHUme5jWRnQ9hqQisjEdYuM9q9xGq3qQv0GjM3Xas3c92cWk8ZrIbfanTfN04eeCzp6aA6VmZmsaASAdsuKNhKVmR/GZJmiRpaAsj7Hrv9uxNUhTU=
X-Gm-Message-State: AOJu0YxT6qXhvAG+s+OfioVGiHzkmHAforVzv/qpLaGvaeohmmZddoVK
	ciS5rWRsRptgQAY+QvbzoV0n4f7FVuMLKYxAAzS6hB7/XMVt6LgBbrd7x+Noy8rvzTKm0/iRfBg
	LTjhKSiaA8YGe31uvWNd2ZY4b6yY=
X-Google-Smtp-Source: AGHT+IF8ybYjmaIXw6DneV73XD83XhzbkOzAGyNT0SqQfEbPoRUSkveSljJdCLwX7vlpHQd0mQTsYeYbn453g34aLlI=
X-Received: by 2002:a05:6870:8196:b0:24c:67b8:2cb8 with SMTP id
 586e51a60fabf-25463f32f30mr3719636fac.0.1717787319835; Fri, 07 Jun 2024
 12:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606181214.2456266-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240606181214.2456266-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 21:08:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i8RnWs9OgxxqVOCG4RHhN7X3ELcruPoGrS1iP8hNSGsw@mail.gmail.com>
Message-ID: <CAJZ5v0i8RnWs9OgxxqVOCG4RHhN7X3ELcruPoGrS1iP8hNSGsw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Update Meteor Lake EPPs
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 8:12=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Update the default balance_performance EPP to 64. This gives better
> performance and also perf/watt compared to current value of 115.
>
> For example:
>
> Speedometer 2.1
>         score: +19%
>         Perf/watt: +5.25%
>
> Webxprt 4 score
>         score: +12%
>         Perf/watt: +6.12%
>
> 3DMark Wildlife extreme unlimited score
>         score: +3.2%
>         Perf/watt: +11.5%
>
> Geekbench6 MT
>         score: +2.14%
>         Perf/watt: +0.32%
>
> Also update balance_power EPP default to 179. With this change:
>         Video Playback power is reduced by 52%
>         Team video conference power is reduced by 35%
>
> With Power profile daemon now sets balance_power EPP on DC instead of
> balance_performance, updating balance_power EPP will help to extend
> battery life.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index dbbf299f4219..8b0032d6a519 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3429,7 +3429,7 @@ static const struct x86_cpu_id intel_epp_default[] =
=3D {
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_=
EPP(102)),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_=
PERF_EPP(32)),
>         X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_E=
PP_POWERSAVE,
> -                                                       HWP_EPP_BALANCE_P=
OWERSAVE, 115, 16)),
> +                                                                   179, =
64, 16)),
>         {}
>  };
>
> --

Rebased on top of the Tony's series:

https://lore.kernel.org/linux-acpi/20240528184720.56259-1-tony.luck@intel.c=
om/

and applied as 6.11 material.

Thanks!

