Return-Path: <linux-pm+bounces-10888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EB92BF0B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 18:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A5D28442C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87338192B6F;
	Tue,  9 Jul 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2y2Q8ij"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B14A02
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541074; cv=none; b=JUweQsPgz7GpfV1qEwe+DQFYPycIdZ+5TfYcn5uUmf8a16FbuQyt/UiVdtiVYr0AWJE6KDLSX1FYYq5cAmhBoKzI8u0FQ/rAQrbgJdobjXD7AIb1jfBDNFJwyZY9SPXBH+MVhWXsnBto8RXCZx55Asf2IlQQBlKsnm/qJ8L3NiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541074; c=relaxed/simple;
	bh=hz8rKy7Lhj7i+v5o2V7dgxw/eWkWPwzwU+QxDBTJOlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YelGSqYAIOVPNA+biH03sRszMexo/oeuhw5R4HRL25qNxUPzvmtr1BaJWcS3mONFxdfpoZnjsnfHgrmiJjnyz+GOs1XhWtRtb+vt13NNYOjmA6cWJ2ce85jTWlxMvAeCR3wR1AyLZI00sKOfujEF1CLLAKacvYE0ybm5AhgqDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2y2Q8ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF3C32782
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541074;
	bh=hz8rKy7Lhj7i+v5o2V7dgxw/eWkWPwzwU+QxDBTJOlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p2y2Q8ij/6MroRMZd66aOc9Ao2lYpJDqCXF0nDq91bvRSxHAZVtHnWjjS3n2dvhPU
	 /LS9rg2ObOZR0RI8Q1ySTscQ+6o3Wn3ekG59FrpQuH8TjTNommWAb2CrNRZb7KTU2M
	 dpDL6d7jU8NDdZGCTB4zcS2Z6Zin+J5h9lSDBsg8lls9DjrpJuSD1x4MQfrYWuCHRg
	 Ba6T+Ni7cJZVWvlsZPQE6Yq6ndU7RKq/rhKyVbDUyqnfpok/izFc4HXuZytgM/UeJl
	 ybcHMxSdbm+bY0OmldfroozFKEQ97l8gvM229LLp6GmYwryX7AVgOOgREi8hLDqvDu
	 Y+UOHnbzNHhRQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25e6e60a879so106283fac.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 09:04:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnLPA4Bs/x7O2l07ZOFE5xkgJrbFNmN7W4jLrO5w2DYmo2PN2+0APJpHCJyaZBz6jQG+TK5n7GturT2DdARo27RSALdVZwKBY=
X-Gm-Message-State: AOJu0YzjZ3Pd3iNIgkNm10H/U95aNbsJ1X848i2n/Wh5geHUYuqWw4gS
	Dum+CEfZ+OGkHxI2Kdb3g6hmc7sq6xRDmvJfOXoOYN2QwpIWUqXgSigPWZ5WaRoDJmggO1dRMuJ
	/VN+Eg3F0y55E5lORuxs4vg3Vh5Q=
X-Google-Smtp-Source: AGHT+IHvhJW8N9T88sV8q0TNhDEHGKwvZdK+ihGq+UZixFGyKC+jWmTp29TRuJK5x1mFxMJ/rgfJEPlPLOidUdFd13c=
X-Received: by 2002:a05:6871:24d5:b0:254:ecbd:1815 with SMTP id
 586e51a60fabf-25eaece08f4mr2593658fac.5.1720541073467; Tue, 09 Jul 2024
 09:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709065146.okez4bvizmf5bxtx@vireshk-i7>
In-Reply-To: <20240709065146.okez4bvizmf5bxtx@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jul 2024 18:04:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMuJAT8dPOO7gJ54wW3p0YEjCJcQrrYK4yxAqRJit+aQ@mail.gmail.com>
Message-ID: <CAJZ5v0iMuJAT8dPOO7gJ54wW3p0YEjCJcQrrYK4yxAqRJit+aQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.11
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, Jul 9, 2024 at 8:51=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Hi Rafael,
>
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.11
>
> for you to fetch changes up to d992f881764cc89444aa5a9752ff508a1baeb61e:
>
>   cpufreq: sti: fix build warning (2024-07-09 08:45:43 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.11
>
> - cpufreq: Add Loongson-3 CPUFreq driver support (Huacai Chen).
> - Make exit() callback return void (Lizhe and Viresh Kumar).
> - Minor cleanups and fixes in several drivers (Bryan Brattlof,
>   Javier Carrasco, Jagadeesh Kona, Jeff Johnson, N=C3=ADcolas F. R. A. Pr=
ado,
>   Primoz Fiser, Raphael Gallais-Pou, and Riwen Lu).
>
> ----------------------------------------------------------------
> Bryan Brattlof (2):
>       cpufreq: ti: update OPP table for AM62Ax SoCs
>       cpufreq: ti: update OPP table for AM62Px SoCs
>
> Huacai Chen (1):
>       cpufreq: Add Loongson-3 CPUFreq driver support
>
> Jagadeesh Kona (1):
>       cpufreq: scmi: Avoid overflow of target_freq in fast switch
>
> Javier Carrasco (4):
>       cpufreq: sun50i: fix memory leak in dt_has_supported_hw()
>       cpufreq: sun50i: replace of_node_put() with automatic cleanup handl=
er
>       cpufreq: qcom-nvmem: fix memory leaks in probe error paths
>       cpufreq: qcom-nvmem: eliminate uses of of_node_put()
>
> Jeff Johnson (1):
>       cpufreq: dt-platdev: add missing MODULE_DESCRIPTION() macro
>
> Lizhe (1):
>       cpufreq: Make cpufreq_driver->exit() return void
>
> N=C3=ADcolas F. R. A. Prado (1):
>       cpufreq: mediatek: Use dev_err_probe in every error path in probe
>
> Primoz Fiser (2):
>       cpufreq: ti-cpufreq: Handle deferred probe with dev_err_probe()
>       OPP: ti: Fix ti_opp_supply_probe wrong return values
>
> Raphael Gallais-Pou (2):
>       cpufreq: sti: add missing MODULE_DEVICE_TABLE entry for stih418
>       cpufreq: sti: fix build warning
>
> Riwen Lu (1):
>       cpufreq/cppc: Don't compare desired_perf in target()
>
> Ryan Walklin (1):
>       cpufreq: sun50i: add Allwinner H700 speed bin
>
> Viresh Kumar (3):
>       cpufreq: nforce2: Remove empty exit() callback
>       cpufreq: loongson2: Remove empty exit() callback
>       cpufreq: pcc: Remove empty exit() callback
>
> Yang Li (1):
>       cpufreq: longhaul: Fix kernel-doc param for longhaul_setstate
>
>  MAINTAINERS                            |   1 +
>  drivers/cpufreq/Kconfig                |  12 +++++
>  drivers/cpufreq/Makefile               |   1 +
>  drivers/cpufreq/acpi-cpufreq.c         |   4 +-
>  drivers/cpufreq/amd-pstate.c           |   7 +--
>  drivers/cpufreq/apple-soc-cpufreq.c    |   4 +-
>  drivers/cpufreq/bmips-cpufreq.c        |   4 +-
>  drivers/cpufreq/cppc_cpufreq.c         |  12 ++---
>  drivers/cpufreq/cpufreq-dt-platdev.c   |   1 +
>  drivers/cpufreq/cpufreq-dt.c           |   3 +-
>  drivers/cpufreq/cpufreq-nforce2.c      |   6 ---
>  drivers/cpufreq/e_powersaver.c         |   3 +-
>  drivers/cpufreq/intel_pstate.c         |   8 ++--
>  drivers/cpufreq/longhaul.c             |   5 ++-
>  drivers/cpufreq/loongson2_cpufreq.c    |   6 ---
>  drivers/cpufreq/loongson3_cpufreq.c    | 395 +++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/mediatek-cpufreq-hw.c  |   4 +-
>  drivers/cpufreq/mediatek-cpufreq.c     |  76 +++++++++++++++------------=
-----
>  drivers/cpufreq/omap-cpufreq.c         |   3 +-
>  drivers/cpufreq/pasemi-cpufreq.c       |   6 +--
>  drivers/cpufreq/pcc-cpufreq.c          |   6 ---
>  drivers/cpufreq/powernow-k6.c          |   5 +--
>  drivers/cpufreq/powernow-k7.c          |   3 +-
>  drivers/cpufreq/powernow-k8.c          |   6 +--
>  drivers/cpufreq/powernv-cpufreq.c      |   4 +-
>  drivers/cpufreq/ppc_cbe_cpufreq.c      |   3 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c      |   4 +-
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   |  12 ++---
>  drivers/cpufreq/qoriq-cpufreq.c        |   4 +-
>  drivers/cpufreq/scmi-cpufreq.c         |   8 ++--
>  drivers/cpufreq/scpi-cpufreq.c         |   4 +-
>  drivers/cpufreq/sh-cpufreq.c           |   4 +-
>  drivers/cpufreq/sparc-us2e-cpufreq.c   |   3 +-
>  drivers/cpufreq/sparc-us3-cpufreq.c    |   3 +-
>  drivers/cpufreq/speedstep-centrino.c   |  10 ++---
>  drivers/cpufreq/sti-cpufreq.c          |   3 +-
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c |  30 +++++--------
>  drivers/cpufreq/tegra194-cpufreq.c     |   4 +-
>  drivers/cpufreq/ti-cpufreq.c           |  96 +++++++++++++++++++++++++++=
+++++++++++--
>  drivers/cpufreq/vexpress-spc-cpufreq.c |   5 +--
>  drivers/opp/ti-opp-supply.c            |   6 ++-
>  include/linux/cpufreq.h                |   2 +-
>  42 files changed, 603 insertions(+), 183 deletions(-)
>  create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

