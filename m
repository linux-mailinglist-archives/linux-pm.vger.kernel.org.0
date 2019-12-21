Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8291128B50
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 20:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLUT7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Dec 2019 14:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfLUT7S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Dec 2019 14:59:18 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E023B206D8;
        Sat, 21 Dec 2019 19:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576958357;
        bh=K8P+SJ21R3JHk498XjXOMP6LxTqhDvmGYqqs/KmRl9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ptKyI3oU5S2lAQzBjV7OqNUgmdsgMd/lJP7vwB+RHm0wESga7ABGi5sXDLHsbsLPJ
         l6SL8sIxH95m/BiYS5zMFaLPaLtMTKR42Zni0uKKtpuIdL59zrHeMKILZqEkyKNTeh
         /UEWSuC0iayUPx/BdIoNLbjCudAnZIiSaqi23Xfc=
Received: by mail-lj1-f181.google.com with SMTP id y6so5561498lji.0;
        Sat, 21 Dec 2019 11:59:16 -0800 (PST)
X-Gm-Message-State: APjAAAVSAzJothqbhXCEDNr0i7qzZBbdSWp+bVaIOwxwGcyVrqs3RUA1
        kk5N/nM415ep7PFCCiXGcp8dpsxCuQFiLcLsXnM=
X-Google-Smtp-Source: APXvYqy4CX77Tuj5gPlFleP9Wx+nBMTeZ13ppF519kqIT7DFPKAJCQrhO/tVn94t00RSUZXOuFms1m8gIzbMJJWNgYY=
X-Received: by 2002:a05:651c:106f:: with SMTP id y15mr13929811ljm.63.1576958355057;
 Sat, 21 Dec 2019 11:59:15 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191220120140eucas1p14ad33c20882f8f48e02337ea16754d91@eucas1p1.samsung.com>
 <20191220115653.6487-1-a.swigon@samsung.com>
In-Reply-To: <20191220115653.6487-1-a.swigon@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sun, 22 Dec 2019 04:58:38 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0a=tFf0GwdeN7Lnp_1aV8iMoB8d+T-s+pF=bNgO9PLAw@mail.gmail.com>
Message-ID: <CAGTfZH0a=tFf0GwdeN7Lnp_1aV8iMoB8d+T-s+pF=bNgO9PLAw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/7] PM / devfreq: Simple QoS for exynos-bus using interconnect
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

I agree this approach. On next version, please update exynos-bus
dt-binding document with example.

On Fri, Dec 20, 2019 at 9:01 PM Artur =C5=9Awigo=C5=84 <a.swigon@samsung.co=
m> wrote:
>
> The following patchset adds interconnect[1][2] framework support to the
> exynos-bus devfreq driver. Extending the devfreq driver with
> interconnect functionality started as a response to the issue referenced
> in [3]. The patches can be subdivided into three groups:
>
> (a) Tweaking the interconnect framework to support the exynos-bus use
> case (patches 01--03/07). Exporting of_icc_get_from_provider() allows to
> avoid hardcoding every single graph edge in the DT or driver source, and
> relaxing the requirement on #interconnect-cells removes the need to
> provide dummy node IDs in the DT. A new field in struct icc_provider is
> used to explicitly allow configuring node pairs from two different
> providers.
>
> (b) Implementing interconnect providers in the exynos-bus devfreq driver
> and adding required DT properties for one selected platform, namely
> Exynos4412 (patches 04--05/07). Due to the fact that this aims to be a
> generic driver for various Exynos SoCs, node IDs are generated
> dynamically (rather than hardcoded).
>
> (c) Implementing a sample interconnect consumer for exynos-mixer
> targeted at solving the issue referenced in [3], again with DT
> properties only for Exynos4412 (patches 06--07/07).
>
> Integration of devfreq and interconnect frameworks is achieved by using
> the dev_pm_qos_*() API. When CONFIG_INTERCONNECT is 'n' (such as in
> exynos_defconfig) all interconnect API functions are no-ops.
>
> This series depends on these three patches (merged into devfreq-next[6]):
> * https://patchwork.kernel.org/patch/11279087/
> * https://patchwork.kernel.org/patch/11279093/
> * https://patchwork.kernel.org/patch/11293765/
> and on this series:
> * https://patchwork.kernel.org/cover/11304545/
> (which does not apply cleanly on next-20191220, adding
> --exclude=3Darch/arm/boot/dts/exynos5422-odroid-core.dtsi to 'git am' is =
a
> quick workaround)
>
> ---
> Changes since v2 [5]:
> * Use icc_std_aggregate().
> * Implement a different modification of apply_constraints() in
>   drivers/interconnect/core.c (patch 03).
> * Use 'exynos,interconnect-parent-node' in the DT instead of
>   'devfreq'/'parent', depending on the bus.
> * Rebase on DT patches that deprecate the 'devfreq' DT property.
> * Improve error handling, including freeing generated IDs on failure.
> * Remove exynos_bus_icc_connect() and add exynos_bus_icc_get_parent().
>
> ---
> Changes since v1 [4]:
> * Rebase on coupled regulators patches.
> * Use dev_pm_qos_*() API instead of overriding frequency in
>   exynos_bus_target().
> * Use IDR for node ID allocation.
> * Reverse order of multiplication and division in
>   mixer_set_memory_bandwidth() (patch 07) to avoid integer overflow.
>
> ---
> Artur =C5=9Awigo=C5=84
> Samsung R&D Institute Poland
> Samsung Electronics
>
> ---
> References:
> [1] Documentation/interconnect/interconnect.rst
> [2] Documentation/devicetree/bindings/interconnect/interconnect.txt
> [3] https://patchwork.kernel.org/patch/10861757/ (original issue)
> [4] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
> [5] https://patchwork.kernel.org/cover/11152595/ (v2 of this RFC)
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log=
/?h=3Ddevfreq-next
>
> Artur =C5=9Awigo=C5=84 (6):
>   interconnect: Export of_icc_get_from_provider()
>   interconnect: Relax requirement in of_icc_get_from_provider()
>   interconnect: Allow inter-provider pairs to be configured
>   arm: dts: exynos: Add interconnect bindings for Exynos4412
>   devfreq: exynos-bus: Add interconnect functionality to exynos-bus
>   arm: dts: exynos: Add interconnects to Exynos4412 mixer
>
> Marek Szyprowski (1):
>   drm: exynos: mixer: Add interconnect support
>
>  .../boot/dts/exynos4412-odroid-common.dtsi    |   5 +
>  arch/arm/boot/dts/exynos4412.dtsi             |   1 +
>  drivers/devfreq/exynos-bus.c                  | 144 ++++++++++++++++++
>  drivers/gpu/drm/exynos/exynos_mixer.c         |  71 ++++++++-
>  drivers/interconnect/core.c                   |  16 +-
>  include/linux/interconnect-provider.h         |   8 +
>  6 files changed, 232 insertions(+), 13 deletions(-)
>
> --
> 2.17.1
>


--=20
Best Regards,
Chanwoo Choi
