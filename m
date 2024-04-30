Return-Path: <linux-pm+bounces-7345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB448B70C0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 12:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19121F2227F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B112C47A;
	Tue, 30 Apr 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqvwSYSh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8912C46B
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474165; cv=none; b=lTdRlKPMYcImtENzOLk6WX8LEXIa1Wqd1mSxNw2XDhYvYTQRGNTIPesSW/+jIK3U6vDAQVsdTllqAv3Huk3/l694eUYhCVB6LQkQ8ss+VcL78wpP2jZ1aj4VXreXTtKNPb3deG4S3+/wEGaw+BJs3Z9MqeKYUZz6+GPY3V96ThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474165; c=relaxed/simple;
	bh=T8cnkidlg9nghB5xHXJisqPwOibY8DFOHKnCL4ZoXAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLjkLGSpomGITiIj7Q7Op6gdXbjBEniEKQTgJKqbgoKAxhfwgqqEwYDNjYz1EpRqDPG3huqkoRVPIlEW2o1IXGvnvtiRtNvUueBvwPdCZSGS2wKFCufQ45Y1MhJ+spuTQnYbDTQmh0fAvbXuB+27iIlfYgo+YMOYcuBXvWZN1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqvwSYSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ABCC4AF18
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 10:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714474165;
	bh=T8cnkidlg9nghB5xHXJisqPwOibY8DFOHKnCL4ZoXAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gqvwSYShZJX1PQn+mcoEEeKtjilnJxVQZdkBa7LIb8Q3uJzud0ZpbTyPZK1QUliBn
	 GCAko3m2upydGM4mk0GIxi+ButFH5Uzw1MxBnynTuqIU4e+DfNwvN7aSIU6FBeUv+z
	 iRHOBBViEZgkatnSNlYwlM7yBKunHC71TWlvNV+8CFPPVnZK9wf9Zdoe2gys00yxyj
	 4YATAnCopZuvUpzQCUdDAv3ugdUH6CpwpSqSBb/08YEA2ih7FveUnClP1y0aqSsCFV
	 uXPYGhnHw2lGMrEVnG6ZaKviMpF1sw0vNrF9iXeVzwBJiydHr9kxklgPvvckO18R5G
	 Cx3Vyv65BW06g==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c73b33383bso374253b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 03:49:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSUqrXyVGT9SsR9XE0viT00WigPtA/C22N0gJYG/2YVyJGz5Xxg1jUX8kcEC7QM+0Ryin7KZ1Bt8SE2iYChTEVg99c29jMBi0=
X-Gm-Message-State: AOJu0YxZ63UpeOXgaNVWSNJKtnSspyRAJA1tk9nJOD3wAkhIEF/Y6QlD
	8J7FXsdtihWYu/OQjoI6cx2iwcJHtUMY9XUC/P3iV4JgP6pEspxoY4cZZa4SePrm0/6NtQKhCBU
	phA4qrVq3gL3puurR7ps29x37GxM=
X-Google-Smtp-Source: AGHT+IHpknY3v/ER5vp6bS5bWhaIp8v3kh9sPnJr5/+Amtt0Q7w292ehS1zrhZ96TackcV8lSzUwh4H2RWXRdEImRKg=
X-Received: by 2002:a4a:a7cb:0:b0:5a4:7790:61b4 with SMTP id
 n11-20020a4aa7cb000000b005a4779061b4mr15219994oom.0.1714474164831; Tue, 30
 Apr 2024 03:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430102756.fgar4rdd5s42245l@vireshk-i7>
In-Reply-To: <20240430102756.fgar4rdd5s42245l@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 12:49:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gyGWE1RNHaqQom8_hR0mpao44UrrGhmeL_6mdsAFChkQ@mail.gmail.com>
Message-ID: <CAJZ5v0gyGWE1RNHaqQom8_hR0mpao44UrrGhmeL_6mdsAFChkQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.10
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, Apr 30, 2024 at 12:28=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 4cece764965020c22cff7665b18a0120063590=
95:
>
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.10
>
> for you to fetch changes up to fde234239d161f958390e41d26cda2bb166f1994:
>
>   dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles (2024-04-=
26 18:13:41 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.10
>
> - Sun50i: Add support for opp_supported_hw, H616 platform and general
>   cleaups (Andre Przywara, Martin Botka, Brandon Cheo Fusi, Dan
>   Carpenter, and Viresh Kumar).
>
> - cppc: Fix possible null pointer dereference (Aleksandr Mishin).
>
> - Eliminate uses of of_node_put() (Javier Carrasco, and Shivani Gupta).
>
> - brcmstb-avs: ISO C90 forbids mixed declarations (Portia Stephens).
>
> - mediatek: Add support for MT7988A (Sam Shih).
>
> - cpufreq-qcom-hw: Add SM4450 compatibles in DT bindings (Tengfei Fan).
>
> ----------------------------------------------------------------
> Aleksandr Mishin (1):
>       cppc_cpufreq: Fix possible null pointer dereference
>
> Andre Przywara (2):
>       cpufreq: sun50i: Add support for opp_supported_hw
>       arm64: dts: allwinner: h616: enable DVFS for all boards
>
> Brandon Cheo Fusi (1):
>       cpufreq: sun50i: Refactor speed bin decoding
>
> Dan Carpenter (1):
>       cpufreq: sun50i: fix error returns in dt_has_supported_hw()
>
> Javier Carrasco (3):
>       cpupfreq: tegra124: eliminate uses of of_node_put()
>       cpufreq: dt: eliminate uses of of_node_put()
>       cpufreq: dt-platdev: eliminate uses of of_node_put()
>
> Martin Botka (5):
>       firmware: smccc: Export revision soc_id function
>       cpufreq: dt-platdev: Blocklist Allwinner H616/618 SoCs
>       dt-bindings: opp: Describe H616 OPPs and opp-supported-hw
>       cpufreq: sun50i: Add H616 support
>       arm64: dts: allwinner: h616: Add CPU OPPs table
>
> Portia Stephens (1):
>       cpufreq: brcmstb-avs-cpufreq: ISO C90 forbids mixed declarations
>
> Sam Shih (1):
>       cpufreq: mediatek: Add support for MT7988A
>
> Shivani Gupta (1):
>       cpufreq: ti: Implement scope-based cleanup in ti_cpufreq_match_node=
()
>
> Tengfei Fan (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles
>
> Viresh Kumar (1):
>       cpufreq: sun50i: Fix build warning around snprint()
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml          =
        |   2 ++
>  Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-poin=
ts.yaml |  87 ++++++++++++++++++++++++++-------------------------
>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi          =
        |   5 +++
>  arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi                  =
        | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts            =
        |   5 +++
>  arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts                  =
        |   5 +++
>  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi                          =
        |   8 +++++
>  arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi         =
        |   5 +++
>  arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero2w.dts           =
        |   5 +++
>  arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts            =
        |   5 +++
>  arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts         =
        |   5 +++
>  drivers/cpufreq/brcmstb-avs-cpufreq.c                                   =
        |   5 ++-
>  drivers/cpufreq/cppc_cpufreq.c                                          =
        |  14 +++++++--
>  drivers/cpufreq/cpufreq-dt-platdev.c                                    =
        |  10 +++---
>  drivers/cpufreq/cpufreq-dt.c                                            =
        |  21 ++++---------
>  drivers/cpufreq/mediatek-cpufreq.c                                      =
        |  10 ++++++
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c                                  =
        | 209 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++----------------------
>  drivers/cpufreq/tegra124-cpufreq.c                                      =
        |  19 ++++--------
>  drivers/cpufreq/ti-cpufreq.c                                            =
        |   4 +--
>  drivers/firmware/smccc/smccc.c                                          =
        |   1 +
>  20 files changed, 420 insertions(+), 120 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dts=
i
>
> --

Pulled, thanks!

