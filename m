Return-Path: <linux-pm+bounces-31187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C437BB0C14B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFA418C1875
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B828D8D6;
	Mon, 21 Jul 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC2dRdfu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599142882C0
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094230; cv=none; b=DT8JNwpdss9uA7iCXahWBNat4TTeJlPgu/i3jmSVmH8oyUes3xTYPRvd8ZKZkZ+TiNqVrHpxD47ALCMadW19nYYTDx836xfaalam1sY7OvsgFwZtGwMpzwBBcDZF0z1qcAJ8W+w9/HTOfyX1KY62LfaWmxO78SQ/zmjsO3zkpVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094230; c=relaxed/simple;
	bh=KFJ3wGh8HQRCOZbU4L7nlR5zP4WG1AMzg49X1NQHE4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Knq69ifFlwfg14Pt1hVmxoWbW6TMf9CkwaUFAYcN4tT/Dfza/kHdXoDL+EjmINcvLmCx47UoOLljZTIBGDvXopu0UaLFPoZllT35gQ8Hqv3ESx5pXLIHSKz45V4EPg59azNYaDTdw/X3mn1/MU+v5HGKDirYDsYtP5mJvyHfJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC2dRdfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB2FC4CEF5
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753094229;
	bh=KFJ3wGh8HQRCOZbU4L7nlR5zP4WG1AMzg49X1NQHE4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hC2dRdfudLmWoer1GlUjOZ13YSZYKTuS0YUwYq4TFGC144VLCUm9rYucThjcNwkyk
	 1TvtQ8lsIGzFRqx4X4GK9cBHENrgQCfWgJYt/XuwrO9IHPGNXtKdl9v6f9tBXWSaT/
	 4EJ/tUAo5L26lulrfGjii9r10gwTTkRJjiOMaK4SJ5Hwj+aXFeEDe696qAr81zYPYm
	 9YhOzvPGZprRQ2dyOUt28+7KM6SNOWM0UWv8bOWvNLZb+yvFNdX64ACTFdMdPkt5UQ
	 pKdPLGReKuPL9Krfs9RjBXacn3kSJQAFl1yL/IAwCDSp/qn2qshRItXEkVGF6hGua1
	 1FpaYBqTYndJA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-610cbca60cdso2228623eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 03:37:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCRvTfnsNCdMsKVGxndJ+UrsOebSfo0xKnW7ke8fbMuGF1yvu6B1qP3yZmkGDKXNvRdgnRGcRMAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8RERStRZIgB+Lh5R2IOxWkDumSisbp/VGHYmgvYpdR4gRuRy
	X0xxEvSI5zt8T952yIG+cjjOmgzcj77+taZ4dV4nkTmb04hvpj/NVfolxQ+JLGdv/eOiAKewU8/
	R59XIPA67+C8sdcF6vaUQwFk0E7Io83U=
X-Google-Smtp-Source: AGHT+IGyY9ooYCYwrI+OZvP0y5AEZpIbJRY2n6rk/WLMrMsPgjPF1iQX2DvlEihYYY7QAtoJgxwvvVH4CFDI6JBv1Jw=
X-Received: by 2002:a05:6820:6ac4:b0:615:d742:6672 with SMTP id
 006d021491bc7-615d74272bbmr4543031eaf.8.1753094228971; Mon, 21 Jul 2025
 03:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721074938.dzkmyi2yxvdsctbq@vireshk-i7>
In-Reply-To: <20250721074938.dzkmyi2yxvdsctbq@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 12:36:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iO8ytFh27TmN5+ceCDxX3x9dvcube-RmKRoET5CMGbXw@mail.gmail.com>
X-Gm-Features: Ac12FXxWRJURG0ePKo-lvRMbDm8agiGVPgpB8mUSOliakeV37vL4q0dNXF9WuWU
Message-ID: <CAJZ5v0iO8ytFh27TmN5+ceCDxX3x9dvcube-RmKRoET5CMGbXw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.17
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Jul 21, 2025 at 9:49=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e326=
7e:
>
>   Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.17
>
> for you to fetch changes up to a7ce9ca1aaf93d55e32e915700d0ef9f69a781c9:
>
>   drivers: cpufreq: add Tegra114 support (2025-07-15 08:37:35 +0530)
>
> ----------------------------------------------------------------
> CPUFreq updates for 6.17
>
> - tegra124: Allow building as a module (Aaron Kling).
>
> - Minor cleanups for Rust cpufreq and cpumask APIs and fix MAINTAINERS
> entry for cpu.rs (Abhinav Ananthu, Ritvik Gupta, and Lukas Bulwahn).
>
> - Minor cleanups for miscellaneous cpufreq drivers (Arnd Bergmann, Dan
>   Carpenter, Krzysztof Kozlowski, Sven Peter, and Svyatoslav Ryhel).
>
> ----------------------------------------------------------------
> Aaron Kling (3):
>       cpufreq: Export disable_cpufreq()
>       cpufreq: dt: Add register helper
>       cpufreq: tegra124: Allow building as a module
>
> Abhinav Ananthu (2):
>       rust: cpufreq: Ensure C ABI compatibility in all unsafe
>       rust: cpufreq: use c_ types from kernel prelude
>
> Arnd Bergmann (1):
>       cpufreq: armada-8k: make both cpu masks static
>
> Dan Carpenter (1):
>       cpufreq: armada-8k: Fix off by one in armada_8k_cpufreq_free_table(=
)
>
> Krzysztof Kozlowski (1):
>       cpufreq: brcmstb-avs: Fully open-code compatible for grepping
>
> Lukas Bulwahn (1):
>       MAINTAINERS: adjust file entry in CPU HOTPLUG
>
> Ritvik Gupta (1):
>       rust: cpumask: Replace `MaybeUninit` and `mem::zeroed` with `Opaque=
` APIs
>
> Sven Peter (1):
>       cpufreq: apple: drop default ARCH_APPLE in Kconfig
>
> Svyatoslav Ryhel (1):
>       drivers: cpufreq: add Tegra114 support
>
>  MAINTAINERS                           |  2 +-
>  drivers/cpufreq/Kconfig.arm           |  3 +--
>  drivers/cpufreq/armada-8k-cpufreq.c   |  5 ++---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c |  2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c  |  1 +
>  drivers/cpufreq/cpufreq-dt.c          | 11 +++++++++++
>  drivers/cpufreq/cpufreq-dt.h          |  2 ++
>  drivers/cpufreq/cpufreq.c             |  2 ++
>  drivers/cpufreq/tegra124-cpufreq.c    | 49 +++++++++++++++++++++++++++++=
++++++++------------
>  rust/kernel/cpufreq.rs                | 60 ++++++++++++++++++++++++++---=
-------------------------------
>  rust/kernel/cpumask.rs                | 13 ++-----------
>  11 files changed, 86 insertions(+), 64 deletions(-)
>
> --

Pulled, thanks!

