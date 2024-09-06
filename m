Return-Path: <linux-pm+bounces-13813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8396FB8E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 20:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BEE28E6C0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56691420D8;
	Fri,  6 Sep 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrzrkcFu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149A82499
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648986; cv=none; b=Y0dHzx6wzSyg/v2JpsnBLWKOGB8Qwlm+3vFhgpCu8r2lW4mAcVOW77q0oYdXLbz/mZhXXDFbnDN468AihqmzJ+mEhZqbw24eil722G5oVsfJE1j3o9nyr0cKrbG/h5aoSosz3yKlFe8IXC4WaCfnawMw0pE8nEibm9PpKmD/o18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648986; c=relaxed/simple;
	bh=1zCebmlkYz3qjKyRHDpACq0ofTCSJl2bSCUy+PjA9mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMc3Ll54x/KsS1vAwxTABAmkXEcwY6JjPWd6O/8fwbRHphE58O6GUzRDY+mh8vQpXFWbAbZDkIWnkj3nFoZ4fm6UchxmHNeGXP0B9K1FGXwQ7wItFZ139Q0iT3wyJ1Ie6VjPMQlaUVVwpy+o2jW6UHJTZPq46mYbm6KRJeAOCC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrzrkcFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6D7C4CEC7
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725648986;
	bh=1zCebmlkYz3qjKyRHDpACq0ofTCSJl2bSCUy+PjA9mg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XrzrkcFu+gBbXMLHz509DcL04U+Vi8hD+RtJ0DfHpVJLUPFE9UnkujiG0+eeq5UMi
	 SQcVGo0cSBAYFsCBgnOeEVaYf1E/2uNLAasXrqT9XXGuX22201KuzUssLxc/K3DPOg
	 O2ka3yG9qBll8p6pkPlXS28A+Kak5Qk/jDnKsc/gvRhx8oPTjRoE4HOfva2LZ8Ct2b
	 elk+Ax6jJVDc1Qx8wFZ6CYJFEi1qHg7H0f8SXTb3yKgS4GNTLLnAEodMKYK9j/2Ifc
	 93JAjubRg8jiRWGm8rYNjlUSS+3NqfowJx2Em9XlVeQ2O6Wsg/jDFNGfMcHBGlYTnl
	 8QSHeb8iGQp2w==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-277c861d9f6so1401872fac.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 11:56:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEWU/0+tmgEzcw49b9EMW0VStvCOEddhfHrA1GjzAQNKK90Z+gHDW1EesjElBwerB7Ll5kfWAADg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxUh0/aLyCR1B7/A13WIPXzxZiPITwmm4YcxZyOqgzCBM2HOc
	0bKOojFuQDDS8a4lJU5WpdjLaX8DBRhc5wMQcdlZR5CucvpNAxFiZBPgcsLlOptnbEg8cFT09FA
	qzGFx0GS1g9gAoa0Qg75gvXKDRms=
X-Google-Smtp-Source: AGHT+IHFOB+HnGDKoOh9GO0fP58+0kGUND0hyKXVAWHlvKafCX7nyQeTFWnGGejSoYewP9KhNUQv7t4GZ0UwLfmkUqw=
X-Received: by 2002:a05:6870:9111:b0:25e:940:e934 with SMTP id
 586e51a60fabf-27b8302d160mr3823961fac.47.1725648985620; Fri, 06 Sep 2024
 11:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906054735.cbsjpwvpelgukppq@vireshk-i7>
In-Reply-To: <20240906054735.cbsjpwvpelgukppq@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Sep 2024 20:56:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i=3UU-m0EGCiShqfoRKFLy2yz_Wva6inkcAnAQ2DE9ag@mail.gmail.com>
Message-ID: <CAJZ5v0i=3UU-m0EGCiShqfoRKFLy2yz_Wva6inkcAnAQ2DE9ag@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.12
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Fri, Sep 6, 2024 at 7:47=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Hi Rafael,
>
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f01=
7b:
>
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.12
>
> for you to fetch changes up to 6b612d1bac67b0f483fde7779a45f6310274d4eb:
>
>   cpufreq: ti-cpufreq: Use socinfo to get revision in AM62 family (2024-0=
9-04 20:43:59 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.12
>
> - Several OF related cleanups in cpufreq drivers (Rob Herring).
>
> - Enable COMPILE_TEST for ARM drivers (Rob Herrring).
>
> - Introduce quirks for syscon failures and use socinfo to get revision
>   for TI cpufreq driver (Dhruva Gole and Nishanth Menon).
>
> - Minor cleanups in amd-pstate driver (Anastasia Belova and Dhananjay
>   Ugwekar).
>
> - Minor cleanups for loongson, cpufreq-dt and powernv cpufreq drivers
>   (Danila Tikhonov, Huacai Chen, and Liu Jing).
>
> ----------------------------------------------------------------
> Anastasia Belova (1):
>       cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
>
> Danila Tikhonov (1):
>       cpufreq: Add SM7325 to cpufreq-dt-platdev blocklist
>
> Dhananjay Ugwekar (1):
>       cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
>
> Dhruva Gole (1):
>       cpufreq: ti-cpufreq: Use socinfo to get revision in AM62 family
>
> Huacai Chen (1):
>       cpufreq: loongson3: Use raw_smp_processor_id() in do_service_reques=
t()
>
> Liu Jing (1):
>       cpufreq: Fix the cacography in powernv-cpufreq.c
>
> Nishanth Menon (1):
>       cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails approp=
riately
>
> Rob Herring (Arm) (8):
>       cpufreq: Use of_property_present()
>       cpufreq: spear: Use of_property_for_each_u32() instead of open codi=
ng
>       cpufreq: qcom: Add explicit io.h include for readl/writel_relaxed
>       cpufreq: omap: Drop asm includes
>       cpufreq: armada-8k: Avoid excessive stack usage
>       cpufreq: Enable COMPILE_TEST on Arm drivers
>       cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers
>       cpufreq: Fix warning on unused of_device_id tables for !CONFIG_OF
>
>  drivers/cpufreq/Kconfig                |  2 --
>  drivers/cpufreq/Kconfig.arm            | 50 ++++++++++++++++++++++++++++=
++--------------------
>  drivers/cpufreq/amd-pstate.c           | 19 ++++++++++++++++---
>  drivers/cpufreq/apple-soc-cpufreq.c    |  2 +-
>  drivers/cpufreq/armada-8k-cpufreq.c    |  2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
>  drivers/cpufreq/cpufreq-dt.c           | 11 +++--------
>  drivers/cpufreq/loongson3_cpufreq.c    |  2 +-
>  drivers/cpufreq/mediatek-cpufreq.c     |  2 +-
>  drivers/cpufreq/omap-cpufreq.c         |  3 ---
>  drivers/cpufreq/pmac64-cpufreq.c       |  2 +-
>  drivers/cpufreq/powernv-cpufreq.c      |  2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c      |  1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   |  2 +-
>  drivers/cpufreq/spear-cpufreq.c        | 18 +++++++-----------
>  drivers/cpufreq/sti-cpufreq.c          |  2 +-
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c |  2 +-
>  drivers/cpufreq/ti-cpufreq.c           | 31 ++++++++++++++++++++++++++++=
---
>  18 files changed, 95 insertions(+), 59 deletions(-)
>
> --

Pulled and added to the linux-next branch in linux-pm.git, thanks!

