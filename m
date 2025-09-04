Return-Path: <linux-pm+bounces-33879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30965B445A8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 20:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1C13B2B03
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B530E84D;
	Thu,  4 Sep 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgkWpGay"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E391EE7B9
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011308; cv=none; b=u6I5v1Yxz0eUwIE/MNYc0Fzs0vDGiLitCgcNWuiWmthWHcTn5+aNefhvsMvq/axO9KS1fzWTN+ds5XJbwmdKs98VIGKijVkEXF1tIZqu0NqhaQqDYSUjbVU47xg9xq8tXWgAU3vHWo91IWnYWE7VpVlwGdWlyQEascQTYCXVCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011308; c=relaxed/simple;
	bh=O3UlEwYag8ujc6DBAbhbM7prvWasV5uk/Lj18tOqoqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxeH6dXagSFpY8ki6Eyb7A37xHVLVZZlEiKS+ZLUW+fcWYInlKrxs/BLvK51+iUG0TfCzf9Vik235QeBWNO5V5rFGJs0LMqoaHSmYXvAdOpkkVJm6ok5pVHoE87heXy+jhvEsxUGC2D/UvluAFtVVGPmHyqG7jg7xaK/H27A0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgkWpGay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D71BC4CEF0
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 18:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757011308;
	bh=O3UlEwYag8ujc6DBAbhbM7prvWasV5uk/Lj18tOqoqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dgkWpGaycZQIG15vJ/NvI+UO/kRRij5HlNhYALL5l2ACC9PIl1Cqq/073YAK5dUhp
	 rTnffVzZrQ4G9pinlKac/HKt2wSoBloaattQAxqBKZr+pQW90UQQp//9u5Kl+/HUo8
	 igkp5lQ/k8lSso8LTsi4SXxx/PzAWAk9gSKTXeoRrXBoe70eDrOqnvJ94MsiJFHOok
	 jCnjIFHTpABU87a+Us0LTz2ogYb0s86zdio/dwhxkQjgTc342F5bA0DEqTkXlv0eKN
	 puLcNRlUX1uTHivtCS8h/P24YfB018MkV8cdPG5gqZG7jv0XoUPa1CPrv5GLx5BfL/
	 uqDpPERjkByQw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61e6d96adcdso833045eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 11:41:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlPk7HTMBBezD2Pio+K46M2Dp3oJ6VogSzoyx4zAP6M61vnj9kdrnuSO6517Llo+ui9usVTZKSqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjQMapoviNyTqnVmFYGMOXLOToFWR/A4hCKj8g4+XIdyJhWUS
	yOZyUTlusi7x5QyCnus5Ib4qHeLrx7pvdxRKS01O/RsmcAf+DsBza3FreDMZMqXvL+BK3aVN3wW
	qr9IP2PTkr2UZCC/Jtm1Y1mgszfmAj4A=
X-Google-Smtp-Source: AGHT+IHDOmfF9ISU+A0c+lgqnS/gLnhJTjlzbOutNtps/Q4zH1DsAKF8OzUrXAYNWSTRcuame4nQQkQlYg2+GCwt+S8=
X-Received: by 2002:a05:6808:4fe5:b0:438:384b:be4e with SMTP id
 5614622812f47-438384bc7d3mr3119233b6e.43.1757011307505; Thu, 04 Sep 2025
 11:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904060659.3sdrvfnhscq6wp6d@vireshk-i7>
In-Reply-To: <20250904060659.3sdrvfnhscq6wp6d@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 20:41:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ji5Oz9fgAqf9y1T7wJUWBizf5ygnuA8aurVvD3Ca4AsQ@mail.gmail.com>
X-Gm-Features: Ac12FXx3721ULQSrG86EEXdDMUzJcygs-EaZ_9vJ1BshJ11uNqyaig2tIqyoMbc
Message-ID: <CAJZ5v0ji5Oz9fgAqf9y1T7wJUWBizf5ygnuA8aurVvD3Ca4AsQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.18
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Thu, Sep 4, 2025 at 8:07=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Hi Rafael,
>
> I will out of office until end of September and so the early pull
> request.
>
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.18
>
> for you to fetch changes up to 3e681899cc6e6c77eca55dd8c7cc57b27868e8a2:
>
>   cpufreq: mediatek: avoid redundant conditions (2025-09-04 10:20:44 +053=
0)
>
> ----------------------------------------------------------------
> CPUFreq updates for 6.18
>
> - Minor improvements to Rust Cpumask APIs (Alice Ryhl, Baptiste Lepers,
>   and Shankari Anand).
>
> - Minor cleanups and optimizations to various cpufreq drivers (Akhilesh
>   Patil, BowenYu, Dennis Beier, Liao Yuanhong, Zihuan Zhang, Florian
>   Fainelli, Taniya Das, Md Sadre Alam, and Christian Marangi).
>
> - Enhancements for TI cpufreq driver (Judith Mendez, and Paresh Bhagat).
>
> - Enhancements for mediatek cpufreq driver (Nicolas Frattaroli).
>
> - Remove outdated cpufreq-dt.txt (Frank Li).
>
> - Update MAINTAINERS for virtual-cpufreq maintainer (Saravana Kannan).
>
> ----------------------------------------------------------------
> Akhilesh Patil (1):
>       cpufreq: armada-37xx: use max() to calculate target_vm
>
> Alice Ryhl (1):
>       rust: cpumask: rename CpumaskVar::as[_mut]_ref to from_raw[_mut]
>
> Baptiste Lepers (1):
>       rust: cpumask: Mark CpumaskVar as transparent
>
> BowenYu (1):
>       cpufreq: Remove unused parameter in cppc_perf_from_fbctrs()
>
> Christian Marangi (1):
>       cpufreq: airoha: Add support for AN7583 SoC
>
> Dennis Beier (1):
>       cpufreq/longhaul: handle NULL policy in longhaul_exit
>
> Florian Fainelli (1):
>       cpufreq: scmi: Account for malformed DT in scmi_dev_used_by_cpus()
>
> Frank Li (1):
>       dt-bindings: Remove outdated cpufreq-dt.txt
>
> Judith Mendez (3):
>       cpufreq: ti: Support more speed grades on AM62Px SoC
>       cpufreq: ti: Allow all silicon revisions to support OPPs
>       arm64: dts: ti: k3-am62p: Fix supported hardware for 1GHz OPP
>
> Liao Yuanhong (1):
>       cpufreq: mediatek: avoid redundant conditions
>
> Md Sadre Alam (1):
>       cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
>
> Nicolas Frattaroli (5):
>       dt-bindings: cpufreq: Add mediatek,mt8196-cpufreq-hw binding
>       cpufreq: mediatek-hw: Refactor match data into struct
>       cpufreq: mediatek-hw: Separate per-domain and per-instance data
>       cpufreq: mediatek-hw: Add support for MT8196
>       cpufreq: mediatek-hw: don't use error path on NULL fdvfs
>
> Paresh Bhagat (2):
>       cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
>       cpufreq: ti: Add support for AM62D2
>
> Saravana Kannan (1):
>       MAINTAINERS: Add myself as virtual-cpufreq maintainer
>
> Shankari Anand (1):
>       rust: opp: update ARef and AlwaysRefCounted imports from sync::aref
>
> Taniya Das (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS615 compatible
>
> Zihuan Zhang (5):
>       cpufreq: brcmstb-avs: Use scope-based cleanup helper
>       cpufreq: CPPC: Use scope-based cleanup helper
>       cpufreq: s5pv210: Use scope-based cleanup helper
>       cpufreq: mediatek: Use scope-based cleanup helper
>       cpufreq: tegra186: Use scope-based cleanup helper
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt                =
  |  61 -----------------------------------------
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml          =
  |   2 ++
>  Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yam=
l |  82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                                             =
  |   6 +++++
>  arch/arm64/boot/dts/ti/k3-am62p5.dtsi                                   =
  |   2 +-
>  drivers/cpufreq/airoha-cpufreq.c                                        =
  |   1 +
>  drivers/cpufreq/armada-37xx-cpufreq.c                                   =
  |   4 +--
>  drivers/cpufreq/brcmstb-avs-cpufreq.c                                   =
  |   4 +--
>  drivers/cpufreq/cppc_cpufreq.c                                          =
  |  16 ++++-------
>  drivers/cpufreq/cpufreq-dt-platdev.c                                    =
  |   3 +++
>  drivers/cpufreq/longhaul.c                                              =
  |   3 +++
>  drivers/cpufreq/mediatek-cpufreq-hw.c                                   =
  | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-----------------
>  drivers/cpufreq/mediatek-cpufreq.c                                      =
  |  11 ++++----
>  drivers/cpufreq/qcom-cpufreq-nvmem.c                                    =
  |   5 ++++
>  drivers/cpufreq/s5pv210-cpufreq.c                                       =
  |   4 +--
>  drivers/cpufreq/scmi-cpufreq.c                                          =
  |  10 +++++++
>  drivers/cpufreq/tegra186-cpufreq.c                                      =
  |   4 +--
>  drivers/cpufreq/ti-cpufreq.c                                            =
  |  12 ++++++---
>  rust/kernel/cpufreq.rs                                                  =
  |   2 +-
>  rust/kernel/cpumask.rs                                                  =
  |   5 ++--
>  rust/kernel/opp.rs                                                      =
  |  13 ++++-----
>  21 files changed, 258 insertions(+), 126 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-dt.=
txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/mediatek,mt=
8196-cpufreq-hw.yaml
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

