Return-Path: <linux-pm+bounces-24425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423B3A6CA75
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBB83B5EB6
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E361FF7A5;
	Sat, 22 Mar 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5wLHk96"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8591D86FF
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742652471; cv=none; b=ajlx9BV4vouWizPmty2JGaTIoqCHCYXeQYU+X2x4f2DsK+qTTi7KQYGzw/B5aEOnc/zG42clbWyKcU+/LsgC77mbv7SNUon+G/jRGbJa1BiwYl91IKEPWMPbrX6YPD1AS8EZv0si/MiFY7Ln8Z0IGvfWNOWeTCP79WiLqSRAm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742652471; c=relaxed/simple;
	bh=xzTLjhsEkheVXuZFfo2qbOiJOw/KwAJfaeq7oggnRaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5OxZn91r80UJeKNwQeCn72Vqcdu54NIg8Bj/wzwd2Rek9e9o2ySFn2nkxBoD6b+mG7MPqEl/7xi46sFqVe3VwdwUXOJU7WvsaDnfcUv288n33rdpk7ypoPciwb2HfnlXtH/JsFa+zCqnegP4ee0LxFWNuVzPtaIDSlh3DZsQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5wLHk96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCCEC4CEDD
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2025 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742652471;
	bh=xzTLjhsEkheVXuZFfo2qbOiJOw/KwAJfaeq7oggnRaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m5wLHk96caflCIKRxuTpGz8nBlbzX22oR8D3RSg2K5bxxGv4HZotn/wb1AysdMp+c
	 s7R+Pg+hB/a8vrf70urR1mqf2qK7mQs2zVwrJI7nHW+/3iVOf9v51EknbuW0JLEbQU
	 V4nl6JGXX1f6+ejh34rCt2Qcl19DCeTtDRBpPDOt6do8BZA2OObrj8igwBzn1/+U0+
	 cWJZh7aVVFitxKp1maFJ60Dfy0w3kgwWI7QXGIu98bjwiMCBJ2WexmJmUACvS+xEiK
	 tGZUOHJeeu3IPDV/n5CISPTj2yIxGC/UMnSB2dvpajPUlPmJ2iQgbjTwMp4CP6QvGz
	 3sWWZAWng73Tw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso1013887fac.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2025 07:07:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjBoAJ3eResjZrnCJkETHWlczORGWVb29RNK4Mk6z8UW8ChQT6hq2/4++NHlcByUBNRVGh+jl0pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfW2Bls/b44QIKLmqflQHs+1127I/K+j+fAl8R4eRssDsmQdU
	NY54VDCY1iYrHcpt8Y4u27eQATJ6I8t9mrE7QXRqeHD9TyP/WPpC3f5p3eNhGnwAlBM5b29+RWz
	NE/VUrPVxStjkH248fULMQCf0bSQ=
X-Google-Smtp-Source: AGHT+IGqxUYPjDHdNnH691nNhB80ubnB6qzJXl8RAPC5dnbAw/PoYkjXTdUmYJqc+F0dHTJpYRSexKeKgO9o4HiBCWk=
X-Received: by 2002:a05:6870:3b8e:b0:2c2:4e19:1cd4 with SMTP id
 586e51a60fabf-2c78026e8bemr4273724fac.1.1742652470213; Sat, 22 Mar 2025
 07:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317063809.756syl6yuazp5shb@vireshk-i7>
In-Reply-To: <20250317063809.756syl6yuazp5shb@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 22 Mar 2025 15:07:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jdxykZ37oi8WK+=oLkEAf76UQoxHWn1yV1KNFxhUnp0A@mail.gmail.com>
X-Gm-Features: AQ5f1JoTMwlNKXS4kyb_oURBCsJHil0ZSZ1tWOTq83brXrDkRRrRfEvmZKZnemk
Message-ID: <CAJZ5v0jdxykZ37oi8WK+=oLkEAf76UQoxHWn1yV1KNFxhUnp0A@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.15
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:38=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The following changes since commit 0813fd2e14ca6ecd4e6ba005a9766f08e26020=
d7:
>
>   cpufreq: prevent NULL dereference in cpufreq_online() (2025-02-05 21:02=
:39 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.15
>
> for you to fetch changes up to 169b9b1db893eca4f008b665d304eee372b6a627:
>
>   dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on SDX75, SA87=
75p and SM8650 (2025-03-17 11:35:24 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.15
>
> - manage sysfs attributes and boost frequencies efficiently from cpufreq
>   core to reduce boilerplate code from drivers (Viresh Kumar).
>
> - Minor cleanups to cpufreq drivers (Aaron Kling, Benjamin Schneider,
>   Dhananjay Ugwekar, Imran Shaik, and zuoqian).
>
> - Migrate to using for_each_present_cpu (Jacky Bai).
>
> - cpufreq-qcom-hw DT binding fixes (Krzysztof Kozlowski).
>
> - Use str_enable_disable() helper (Lifeng Zheng).
>
> ----------------------------------------------------------------
> Aaron Kling (2):
>       cpufreq: tegra194: Allow building for Tegra234
>       cpufreq: tegra186: Share policy per cluster
>
> Benjamin Schneider (1):
>       cpufreq: enable 1200Mhz clock speed for armada-37xx
>
> Dhananjay Ugwekar (1):
>       cpufreq: amd-pstate: Remove unnecessary driver_lock in set_boost
>
> Imran Shaik (1):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS8300 compatible
>
> Jacky Bai (1):
>       cpufreq: Init cpufreq only for present CPUs
>
> Krzysztof Kozlowski (3):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing constraint for i=
nterrupt-names
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Drop redundant minItems:1
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on SDX75, =
SA8775p and SM8650
>
> Lifeng Zheng (1):
>       cpufreq: Use str_enable_disable() helper
>
> Viresh Kumar (48):
>       cpufreq: Always create freq-table related sysfs file
>       cpufreq: dt: Stop setting cpufreq_driver->attr field
>       cpufreq: acpi: Stop setting common freq attributes
>       cpufreq: apple: Stop setting cpufreq_driver->attr field
>       cpufreq: bmips: Stop setting cpufreq_driver->attr field
>       cpufreq: brcmstb: Stop setting common freq attributes
>       cpufreq: davinci: Stop setting cpufreq_driver->attr field
>       cpufreq: e_powersaver: Stop setting cpufreq_driver->attr field
>       cpufreq: elanfreq: Stop setting cpufreq_driver->attr field
>       cpufreq: imx6q: Stop setting cpufreq_driver->attr field
>       cpufreq: kirkwood: Stop setting cpufreq_driver->attr field
>       cpufreq: longhaul: Stop setting cpufreq_driver->attr field
>       cpufreq: loongson: Stop setting cpufreq_driver->attr field
>       cpufreq: mediatek: Stop setting cpufreq_driver->attr field
>       cpufreq: omap: Stop setting cpufreq_driver->attr field
>       cpufreq: p4: Stop setting cpufreq_driver->attr field
>       cpufreq: pasemi: Stop setting cpufreq_driver->attr field
>       cpufreq: pmac: Stop setting cpufreq_driver->attr field
>       cpufreq: powernow: Stop setting cpufreq_driver->attr field
>       cpufreq: powernv: Stop setting common freq attributes
>       cpufreq: qcom: Stop setting cpufreq_driver->attr field
>       cpufreq: qoriq: Stop setting cpufreq_driver->attr field
>       cpufreq: sc520_freq: Stop setting cpufreq_driver->attr field
>       cpufreq: scmi: Stop setting cpufreq_driver->attr field
>       cpufreq: scpi: Stop setting cpufreq_driver->attr field
>       cpufreq: sh: Stop setting cpufreq_driver->attr field
>       cpufreq: spear: Stop setting cpufreq_driver->attr field
>       cpufreq: speedstep: Stop setting cpufreq_driver->attr field
>       cpufreq: tegra: Stop setting cpufreq_driver->attr field
>       cpufreq: vexpress: Stop setting cpufreq_driver->attr field
>       cpufreq: virtual: Stop setting cpufreq_driver->attr field
>       cpufreq: Remove cpufreq_generic_attrs
>       cpufreq: Stop checking for duplicate available/boost freq attribute=
s
>       cpufreq: staticize cpufreq_boost_trigger_state()
>       cpufreq: Export cpufreq_boost_set_sw()
>       cpufreq: Introduce policy->boost_supported flag
>       cpufreq: acpi: Set policy->boost_supported
>       cpufreq: amd: Set policy->boost_supported
>       cpufreq: cppc: Set policy->boost_supported
>       cpufreq: Restrict enabling boost on policies with no boost frequenc=
ies
>       cpufreq: apple: Set .set_boost directly
>       cpufreq: loongson: Set .set_boost directly
>       cpufreq: powernv: Set .set_boost directly
>       cpufreq: scmi: Set .set_boost directly
>       cpufreq: dt: Set .set_boost directly
>       cpufreq: qcom: Set .set_boost directly
>       cpufreq: staticize policy_has_boost_freq()
>       cpufreq: Remove cpufreq_enable_boost_support()
>
> zuoqian (1):
>       cpufreq: scpi: compare kHz instead of Hz
>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 35 ++++=
+++++++++++++++++++++++++++----
>  drivers/cpufreq/Kconfig.arm                                    |  2 +-
>  drivers/cpufreq/acpi-cpufreq.c                                 |  4 +++-
>  drivers/cpufreq/amd-pstate.c                                   |  5 ++--=
-
>  drivers/cpufreq/apple-soc-cpufreq.c                            | 18 +---=
--------------
>  drivers/cpufreq/armada-37xx-cpufreq.c                          |  6 +---=
--
>  drivers/cpufreq/armada-8k-cpufreq.c                            |  2 +-
>  drivers/cpufreq/bmips-cpufreq.c                                |  1 -
>  drivers/cpufreq/brcmstb-avs-cpufreq.c                          |  1 -
>  drivers/cpufreq/cppc_cpufreq.c                                 |  9 +---=
-----
>  drivers/cpufreq/cpufreq-dt.c                                   | 24 ++--=
--------------------
>  drivers/cpufreq/cpufreq.c                                      | 46 ++++=
+++++++++++++++++++++++-------------------
>  drivers/cpufreq/davinci-cpufreq.c                              |  1 -
>  drivers/cpufreq/e_powersaver.c                                 |  1 -
>  drivers/cpufreq/elanfreq.c                                     |  1 -
>  drivers/cpufreq/freq_table.c                                   | 15 ++++=
+----------
>  drivers/cpufreq/imx6q-cpufreq.c                                |  1 -
>  drivers/cpufreq/kirkwood-cpufreq.c                             |  1 -
>  drivers/cpufreq/longhaul.c                                     |  1 -
>  drivers/cpufreq/loongson2_cpufreq.c                            |  1 -
>  drivers/cpufreq/loongson3_cpufreq.c                            | 11 +---=
-------
>  drivers/cpufreq/mediatek-cpufreq-hw.c                          |  3 +--
>  drivers/cpufreq/mediatek-cpufreq.c                             |  3 +--
>  drivers/cpufreq/mvebu-cpufreq.c                                |  2 +-
>  drivers/cpufreq/omap-cpufreq.c                                 |  1 -
>  drivers/cpufreq/p4-clockmod.c                                  |  1 -
>  drivers/cpufreq/pasemi-cpufreq.c                               |  1 -
>  drivers/cpufreq/pmac32-cpufreq.c                               |  1 -
>  drivers/cpufreq/pmac64-cpufreq.c                               |  1 -
>  drivers/cpufreq/powernow-k6.c                                  |  1 -
>  drivers/cpufreq/powernow-k7.c                                  |  1 -
>  drivers/cpufreq/powernow-k8.c                                  |  1 -
>  drivers/cpufreq/powernv-cpufreq.c                              | 11 +---=
-------
>  drivers/cpufreq/qcom-cpufreq-hw.c                              | 16 ++--=
------------
>  drivers/cpufreq/qcom-cpufreq-nvmem.c                           |  8 ++++=
----
>  drivers/cpufreq/qoriq-cpufreq.c                                |  1 -
>  drivers/cpufreq/sc520_freq.c                                   |  1 -
>  drivers/cpufreq/scmi-cpufreq.c                                 | 21 ++--=
-----------------
>  drivers/cpufreq/scpi-cpufreq.c                                 |  8 ++++=
----
>  drivers/cpufreq/sh-cpufreq.c                                   |  1 -
>  drivers/cpufreq/spear-cpufreq.c                                |  1 -
>  drivers/cpufreq/speedstep-centrino.c                           |  1 -
>  drivers/cpufreq/speedstep-ich.c                                |  1 -
>  drivers/cpufreq/speedstep-smi.c                                |  1 -
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c                         |  6 +++-=
--
>  drivers/cpufreq/tegra186-cpufreq.c                             |  8 ++++=
+++-
>  drivers/cpufreq/tegra194-cpufreq.c                             |  1 -
>  drivers/cpufreq/vexpress-spc-cpufreq.c                         |  1 -
>  drivers/cpufreq/virtual-cpufreq.c                              |  3 +--
>  include/linux/cpufreq.h                                        | 21 ++++=
++---------------
>  50 files changed, 109 insertions(+), 204 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

