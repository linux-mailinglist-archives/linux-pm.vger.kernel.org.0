Return-Path: <linux-pm+bounces-17793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700179D2FC8
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 21:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B654CB28FD7
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 20:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1D1D2F55;
	Tue, 19 Nov 2024 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2RGG9Ej"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5F1D2B21
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049484; cv=none; b=r0LrdrYh48AEnJFijTR8dMFlBkY7PyN3zmYq6ueGU22raBk/8Toa1pfA+gk66OYURD49ftQ5Q2SsNtuRSXerHdkADtzC/NHgn4b3uFgJ9xKPOFJOeks1+XrUcJIYvtuDlt5AKKQAIyhDn7rH/sdf/3xNuph4TDwH2TybuaumB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049484; c=relaxed/simple;
	bh=AMEiKK/tJO0cUKChM6A/6AmSgAwf8WUwVKOA+P/yK9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9b+JopzhoCrbnhk5c4XHCN+N1DxXHuaDQGSbXQesnWjGYyKhKGoqgkH0ra/XWKMBaB7oqWFVSxalyj2dbwJKpNKiWc8izz+wbT9+U5MEDSJzJ7qXDWWzH7iO9fbNXv2hzANlrWNpWzw4AWrCK1NPG/LndedNrfNLjvZPw16DU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2RGG9Ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787FEC4CECF
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732049483;
	bh=AMEiKK/tJO0cUKChM6A/6AmSgAwf8WUwVKOA+P/yK9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C2RGG9Ej+M+Y5Kz4ptF9P0H37U7fT75etSpVQIBXG7Zo8WOCw0qbCLndUgRH8TxfC
	 0fC/b87Lps3fLLcu8XzLuJ2rqasURIfkWFq8FsB9oI/V6JlvGGWYeCT7UqYT1uXroq
	 7S+Y1xGqgXrf2S99xioKPQUANM/UsmDwEq6/dxDQMo/SvzQfikQ46ZRyBPKvSqrd2G
	 6MD/Bd9MGLke23wBdfXSUW/xMndC7Es/vD15EZpdUDWLMh1uqONtj8Z2o6hcZwsHJI
	 hsYYYSlxP61PHBec3EcxKY/SX58119pbC7yLjLV1q2L2NUnO2FP/AyFMphkOabcxaI
	 gwOtvCLR8afTA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27d0e994ae3so1676887fac.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 12:51:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsWV/o4UCGdhs+uqSs92PwYslF8rPlqwLRaLQlbN32ZmmB+i5IEyixzzvVJryCvXe38hwlUDx3dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAAUxDOapsm0w2bxE+zV8DSmaQYk96mGyVk2dYoawZNRJ8bfd
	CTC2D4y5XQdIzjguupmXHIK2nC0a5jdRtAxkAMEdrVc40zbkwG6mFmBHa/Xw/Ihnvbjemgtikle
	/MBS4aM1SatjxgLXTgnG/62GOGcc=
X-Google-Smtp-Source: AGHT+IFHCFWFmM9aeZ88fRk0ebJ3vzwkfl1x5VQi5xHBTqorarp13ozut6oPWWtI1/j2y6PBJMJbFiw5KyP8rnOayxA=
X-Received: by 2002:a05:6870:1d4:b0:254:affe:5a05 with SMTP id
 586e51a60fabf-296d9bcf194mr306239fac.21.1732049482825; Tue, 19 Nov 2024
 12:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118043001.ahyxauzetqrfufzq@vireshk-i7>
In-Reply-To: <20241118043001.ahyxauzetqrfufzq@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 21:51:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjHJUQNA2odsGHtyaqHam4DjQcrooeK142UoazAvp7LA@mail.gmail.com>
Message-ID: <CAJZ5v0jjHJUQNA2odsGHtyaqHam4DjQcrooeK142UoazAvp7LA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.13
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Nov 18, 2024 at 5:30=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758e=
dc:
>
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.13
>
> for you to fetch changes up to 5df30684415d5a902f23862ab5bbed2a2df7fbf1:
>
>   arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw =
(2024-11-18 09:55:39 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.13
>
> - Add virtual cpufreq driver for guest kernels (David Dai).
>
> - Minor cleanup to various cpufreq drivers (Andy Shevchenko, Dhruva
>   Gole, Jie Zhan, Jinjie Ruan, Shuosheng Huang, Sibi Sankar, and Yuan
>   Can).
>
> - Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial command check"
>   (Colin Ian King).
>
> - Improve DT bindings for qcom-hw driver (Dmitry Baryshkov, Konrad
>   Dybcio, and Nikunj Kela).
>
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>       cpufreq: loongson3: Check for error code from devm_mutex_init() cal=
l
>
> Colin Ian King (1):
>       Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial command check"
>
> David Dai (2):
>       dt-bindings: cpufreq: add virtual cpufreq device
>       cpufreq: add virtual-cpufreq driver
>
> Dhruva Gole (2):
>       cpufreq: ti-cpufreq: Allow backward compatibility for efuse syscon
>       cpufreq: ti-cpufreq: Remove revision offsets in AM62 family
>
> Dmitry Baryshkov (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add SAR2130P compatible
>
> Jie Zhan (2):
>       cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged
>       cppc_cpufreq: Remove HiSilicon CPPC workaround
>
> Jinjie Ruan (5):
>       cpufreq: CPPC: Fix possible null-ptr-deref for cpufreq_cpu_get_raw(=
)
>       cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()
>       cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_cost()
>       cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_power()
>       cpufreq: mediatek-hw: Fix wrong return value in mtk_cpufreq_get_cpu=
_power()
>
> Konrad Dybcio (2):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add SC8180X compatible
>       arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq=
-hw
>
> Nikunj Kela (1):
>       dt-bindings: cpufreq: qcom-hw: document support for SA8255p
>
> Shuosheng Huang (1):
>       cpufreq: sun50i: add a100 cpufreq support
>
> Sibi Sankar (1):
>       cpufreq: scmi: Fix cleanup path when boost enablement fails
>
> Yuan Can (1):
>       cpufreq: loongson2: Unregister platform_driver on failure
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml      |   =
6 +++
>  Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml |  4=
8 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi                               |   =
2 +-
>  drivers/cpufreq/Kconfig                                             |  1=
4 +++++
>  drivers/cpufreq/Makefile                                            |   =
1 +
>  drivers/cpufreq/brcmstb-avs-cpufreq.c                               |   =
4 +-
>  drivers/cpufreq/cppc_cpufreq.c                                      | 13=
6 ++++++++++++++++++-----------------------------
>  drivers/cpufreq/cpufreq-dt-platdev.c                                |   =
1 +
>  drivers/cpufreq/loongson2_cpufreq.c                                 |   =
4 +-
>  drivers/cpufreq/loongson3_cpufreq.c                                 |   =
7 ++-
>  drivers/cpufreq/mediatek-cpufreq-hw.c                               |   =
2 +-
>  drivers/cpufreq/scmi-cpufreq.c                                      |   =
4 +-
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c                              |  2=
8 ++++++++++
>  drivers/cpufreq/ti-cpufreq.c                                        |  1=
0 ++--
>  drivers/cpufreq/virtual-cpufreq.c                                   | 33=
3 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++
>  include/linux/arch_topology.h                                       |   =
1 +
>  16 files changed, 507 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virtua=
l-cpufreq.yaml
>  create mode 100644 drivers/cpufreq/virtual-cpufreq.c
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

