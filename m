Return-Path: <linux-pm+bounces-18062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E815D9D887C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90175B466EE
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D9C1ABECD;
	Mon, 25 Nov 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwsEuwDq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7B1AB53A;
	Mon, 25 Nov 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542277; cv=none; b=lGwK+AsrOZyQSM0EHnD545L+qbIkZiHOIQRN0z6UMQhkd9yNQK3eJUmCLJcu3ezEEkb/cUkjgKnwkbYkXamw28LzUpEHR37kCGk3uv+SDqtnnii4XRb+uvtQrYCyPV8i1EZHK6p9BmxOnEP1Jqr48TMGohi4+gi+iXZhv79Vtps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542277; c=relaxed/simple;
	bh=WxZb7bzHyn5BL5PvZwUN38W1zcGYJVt4hS7srdO+xis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZAZFF0yKRIWuWdFrMKkFr+EMkl3IO6iUED8ykiEwHrYLDMOejjVyv8479NtD//AWSYbnQMixG6UoYvuVqfWYjaK7Eafv0y8Rh+gdeWObqGxlNqueE+IEU+dLQiCW+1RXzAdTTbCEYbqJtgLY7CRp6V9/jpLYJTYjrUeCG6kGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwsEuwDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987A9C4CECF;
	Mon, 25 Nov 2024 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732542276;
	bh=WxZb7bzHyn5BL5PvZwUN38W1zcGYJVt4hS7srdO+xis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VwsEuwDqSv13duRJaWIBjfL1LezPDEvDnM72jezEqMEgCN887lVy1aVisf877Ce+X
	 e6PcwGhqantYD4OavUuesKdqljiI43mMPRqivCXCs3raBC232wKOEige567t3kXQ1C
	 XijzFoYnpWvf71h6aX529cWky6t+3bvQp6D4uIpP/xSzY1jrnMrRTGVJOy1/7cfgJg
	 Syd63oNReqntZDb0m1SLxrqj1VbW/Zp2ReOZeD343Is1vZUqE7GQQSJsSdAtfZ1nvt
	 /VBrHtKNpsMZ6dGUQFAKgDiX2LLuFFg0aUCCQViGSjzSqKW0z4ci2G1fIeD0kKTaTe
	 FnuLeBXtAOq1A==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2973b53ec02so1251624fac.1;
        Mon, 25 Nov 2024 05:44:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3GDsQSw9S3ZBBF57w29P5QPpBJQAPL9h2RpT142RcEXnjnWJzLxxYNIDRuxi/nciu2Wq/XtQ2ejM=@vger.kernel.org, AJvYcCW8CEDHCMuz8NROauPclfsd/YkmmPK6hLyEKixJJ1VNT7y9zCKRdEJrjsDnNrwtuMWCa+rXG0gwJBPyh7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjznXB4RN7p/qcCyP46n4KSK0brCJ0S7HJMHj7jjRHQeCFNjx7
	8hgWV2yAW72YFoI07zKA9SmBH8WW6LTGnh6R6mLhWSisrcVZ28qHJ+jZhR8A7k01kf3x1YFOnSE
	qnlRVJmIbGyPoFA5PUrG/YhZ0QhI=
X-Google-Smtp-Source: AGHT+IFUisDNK1VkF+qagXo5/oPDCGGozp/W3tOrooEEaeaI9019UTsiKwzyfv9hFnG+Q8XjQMwHiBpPxpTVbXXKABY=
X-Received: by 2002:a05:6871:3a0d:b0:296:56d5:26c with SMTP id
 586e51a60fabf-29720c41d0dmr9110725fac.24.1732542275989; Mon, 25 Nov 2024
 05:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com> <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 14:44:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gpSCWMLxekbe2LWmfAxoJ3AzqLuJ7SAFp8+F1n1wUCtQ@mail.gmail.com>
Message-ID: <CAJZ5v0gpSCWMLxekbe2LWmfAxoJ3AzqLuJ7SAFp8+F1n1wUCtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/8] intel_idle: Provide enter_dead() handler for SRF
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:21=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
>     C6S  (hint 0x22)
>     C6SP (hint 0x23)
>
> Hints 0x20 and 0x21 are skipped entirely, causing the generic
> implementation in mwait_play_dead() to compute the wrong hint, when
> looking for the deepest cstate. As a result, package with an offlined
> CPU can never reach PC6.

Is this still the case with the latest firmware?

If so, this could be the second patch in the series if [1-3/7] are dropped.

Otherwise, I don't think it is needed any more.

> Define the enter_dead() handler for SRF.
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ac4d8faa3886..c2ca01e74add 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -56,6 +56,7 @@
>  #include <asm/mwait.h>
>  #include <asm/spec-ctrl.h>
>  #include <asm/fpu/api.h>
> +#include <asm/smp.h>
>
>  #define INTEL_IDLE_VERSION "0.5.1"
>
> @@ -227,6 +228,16 @@ static __cpuidle int intel_idle_s2idle(struct cpuidl=
e_device *dev,
>         return 0;
>  }
>
> +static __cpuidle void intel_idle_enter_dead(struct cpuidle_device *dev,
> +                                           int index)
> +{
> +       struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> +       struct cpuidle_state *state =3D &drv->states[index];
> +       unsigned long eax =3D flg2MWAIT(state->flags);
> +
> +       mwait_play_dead_with_hint(eax);
> +}
> +
>  /*
>   * States are indexed by the cstate number,
>   * which is also the index into the MWAIT hint array.
> @@ -1391,6 +1402,7 @@ static struct cpuidle_state srf_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 1,
>                 .target_residency =3D 1,
>                 .enter =3D &intel_idle,
> +               .enter_dead =3D &intel_idle_enter_dead,
>                 .enter_s2idle =3D intel_idle_s2idle, },
>         {
>                 .name =3D "C1E",
> @@ -1399,6 +1411,7 @@ static struct cpuidle_state srf_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 2,
>                 .target_residency =3D 10,
>                 .enter =3D &intel_idle,
> +               .enter_dead =3D &intel_idle_enter_dead,
>                 .enter_s2idle =3D intel_idle_s2idle, },
>         {
>                 .name =3D "C6S",
> @@ -1408,6 +1421,7 @@ static struct cpuidle_state srf_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 270,
>                 .target_residency =3D 700,
>                 .enter =3D &intel_idle,
> +               .enter_dead =3D &intel_idle_enter_dead,
>                 .enter_s2idle =3D intel_idle_s2idle, },
>         {
>                 .name =3D "C6SP",
> @@ -1417,6 +1431,7 @@ static struct cpuidle_state srf_cstates[] __initdat=
a =3D {
>                 .exit_latency =3D 310,
>                 .target_residency =3D 900,
>                 .enter =3D &intel_idle,
> +               .enter_dead =3D &intel_idle_enter_dead,
>                 .enter_s2idle =3D intel_idle_s2idle, },
>         {
>                 .enter =3D NULL }
> --
> 2.47.0
>
>

