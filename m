Return-Path: <linux-pm+bounces-20762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9250CA17AF2
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 11:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D37A2413
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809EB1BD9F2;
	Tue, 21 Jan 2025 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOmfQ/Co"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555745979;
	Tue, 21 Jan 2025 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453767; cv=none; b=Gq09bp9uCsVGYSSItyQel16Nw7q7ZMvDQSPX0d3leLJQSbUwK7YX5T9dX2hGvODeEw8ZCnHEWq1GmRZRimBaGm16zzFYK61bZ8CC0yFM1Z5OC2Q9H8hsYQoLMwFQSu4kp+wVAQ5W3UdL1ZSMvcqn7yvjg1D6rt5YV8W2TjzNoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453767; c=relaxed/simple;
	bh=Q6TsjNYIIprFxCUPZ9GtMLBRF/ZSTzZhy68jSq2lqBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktGYCafQLdpeMWnA+nkWH+4i/+T1XT4NVbUVeTacjPBrucpHCqCjT0T2oQtYmGtWj39zv26QxeVfzR2I836dF/C8RwSjvyZ8WC7uTUoxB0+ZbPK4CjMFQ3B3nBH4DMD/d8IuvjswskJ7XamYyKAPne7Fpv35CSMaDnH4ziZDL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOmfQ/Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39776C4CEDF;
	Tue, 21 Jan 2025 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453766;
	bh=Q6TsjNYIIprFxCUPZ9GtMLBRF/ZSTzZhy68jSq2lqBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOmfQ/CouM9psLIfX+6WLjQI1DnfrPm0jwMpQHhAHvTPLdRuZO2mm2jaCD0r57hfR
	 AJuJReUzRS8Q3e/Tmfov8jC2S+HD5vKH9uOcq0WN5FLoV+S4ajQoJGPoGoULgTtQC2
	 hnlkMkEssj8YB+v5oW1sgpDZLw/RL904b+q92ob9X+f4tqJm04bpdSi6Zrbe4lIH7C
	 t8vlUk/mBD/nmvrInq6JkvtIaTH1R6bqJADZmHHB0ta9AVoBz9S7nB2S+NZgcihALA
	 k9OuOfpRxotV/572BpKTpQuJVjcw1k1n04QcKZomBbX2AX0Zti1nEnfucpVOitYBWY
	 j2u9SyrQUxw7w==
Date: Tue, 21 Jan 2025 11:02:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org, 
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC v3 05/18] pmdomain: thead: Add power-domain driver for
 TH1520
Message-ID: <20250121-mature-marigold-ammonite-b379d2@krzk-bin>
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
 <CGME20250120172125eucas1p141540607f423eea4c55b2bd22ff5adf0@eucas1p1.samsung.com>
 <20250120172111.3492708-6-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120172111.3492708-6-m.wilczynski@samsung.com>

On Mon, Jan 20, 2025 at 06:20:58PM +0100, Michal Wilczynski wrote:
> The T-Head TH1520 SoC contains multiple power islands that can be
> programmatically turned on and off using the AON (Always-On) protocol
> and a hardware mailbox [1]. The relevant mailbox driver has already been
> merged into the mainline kernel in commit 5d4d263e1c6b ("mailbox:
> Introduce support for T-head TH1520 Mailbox driver");
> 
> This commit introduces a power-domain driver for the TH1520 SoC, which

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> is using AON firmware protocol to communicate with E902 core through the
> hardware mailbox. This way it can send power on/off commands to the E902
> core.

...

> diff --git a/drivers/pmdomain/thead/Makefile b/drivers/pmdomain/thead/Makefile
> new file mode 100644
> index 000000000000..adfdf5479c68
> --- /dev/null
> +++ b/drivers/pmdomain/thead/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_TH1520_PM_DOMAINS)		+= th1520-pm-domains.o
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
> new file mode 100644
> index 000000000000..d913ad40fb76
> --- /dev/null
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + * Copyright (c) 2024 Samsung Electronics Co., Ltd.
> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
> + */
> +
> +#include <linux/firmware/thead/thead,th1520-aon.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +
> +#include <dt-bindings/firmware/thead,th1520-aon.h>

So here it is used... I don't understand why power domain is under
firmware. Please move it to proper directory and name the file exactly
the same as bindings doc which this belongs to.


> +
> +struct th1520_power_domain {
> +	struct th1520_aon_chan *aon_chan;
> +	struct generic_pm_domain genpd;
> +	u32 rsrc;
> +};
> +
> +struct th1520_power_info {
> +	const char *name;
> +	u32 rsrc;
> +};
> +
> +static const struct th1520_power_info th1520_pd_ranges[] = {
> +	{ "vdec", TH1520_AON_VDEC_PD },

Why TH1520_AON_XXX aren't the indices?

> +	{ "npu", TH1520_AON_NPU_PD },
> +	{ "venc", TH1520_AON_VENC_PD },
> +	{ "gpu", TH1520_AON_GPU_PD },
> +	{ "dsp0", TH1520_AON_DSP0_PD },
> +	{ "dsp1", TH1520_AON_DSP1_PD }
> +};

Best regards,
Krzysztof


