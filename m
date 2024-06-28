Return-Path: <linux-pm+bounces-10179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01F91BB83
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89674B2193D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC35B15253B;
	Fri, 28 Jun 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWqw/d7m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BA14B97E;
	Fri, 28 Jun 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567142; cv=none; b=CzDTffc4X6lCe8D7UYDceIjDPbSoq4RlkVqfPIknKjkHGr7I63EJdf8Uj2lxW4G22wMOvShW3fYxelPWihYz/FP0mu6Ac1LayaFGcNVCZrNR4rtJ1FndNivFJOsesVRw2HJsPqta8AHKNxQZbGGrzU0pJfryHpRyl27MHVTaoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567142; c=relaxed/simple;
	bh=tZ4mnqBxiyX3UIhp44aHn7n1X6SzClOpCAotFkByDYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNrGvDdbbjCn12uvL/fbOyj1/pmkZVYt4xDEd3pN1q4D1JKTG7AJeSgf0I3zXi6v3tr2aYsRP1jwgAt2eUS6JBYJxZXUGD4PS748Gr7dB0kYbQNNT1v6FOvq1yU93wu5pNSwl7yjkQcGbkW3AppPSLCED+aseTuHEB+3D21IMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWqw/d7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E96AC32781;
	Fri, 28 Jun 2024 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719567142;
	bh=tZ4mnqBxiyX3UIhp44aHn7n1X6SzClOpCAotFkByDYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MWqw/d7mONr2rdDnz+55RluFb39+8ksf6cbjudE5jfKJOtZf4P+aMeY8kCeDl/3Yq
	 XqwFmC4pqL2TSfBLEPG0GXJiL+Guakcb9wN0U59RX7pKpmMiW8LAQtm124j/ltpgXe
	 tinmMKlOzd8E9vci/XzDGumcZo7DjK0BsyNL3Ae8phoojPdS9bD28TXcXIRQlv4TuB
	 ysccbjc9tUuNYxHn/FLaa2J3YgIoftEvmNJ0HmAhjM7c5blhm5hT9TXeNLlQdd+XAz
	 z4MNTUrFRxtcBvhIzouXoCyb7/dCQFiSSoffJStc3Wgna1OKHNproz6Tfh2Jrq1xfo
	 3p9mdYB6le9WA==
Message-ID: <88588f06-66e1-47a9-b5ab-7849b1c53fb0@kernel.org>
Date: Fri, 28 Jun 2024 12:32:17 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add MSM8953 driver
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Vladimir Lypak <vladimir.lypak@gmail.com>
References: <20240627-msm8953-interconnect-v2-0-b4940a8eab69@mainlining.org>
 <20240627-msm8953-interconnect-v2-2-b4940a8eab69@mainlining.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240627-msm8953-interconnect-v2-2-b4940a8eab69@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.06.24 18:08, Barnabás Czémán wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add driver for interconnect busses found in MSM8953 based platforms.
> The topology consists of four NoCs that are partially controlled by a
> RPM processor.
> 
> Note that one of NoCs (System NoC) has a counterpart (System NoC MM)
> that is modelled as child device to avoid resource conflicts, since it
> uses same MMIO space for configuration.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>   drivers/interconnect/qcom/Kconfig   |    9 +
>   drivers/interconnect/qcom/Makefile  |    2 +
>   drivers/interconnect/qcom/msm8953.c | 1325 +++++++++++++++++++++++++++++++++++
>   3 files changed, 1336 insertions(+)
> 
[..]
> +
> +static struct qcom_icc_node * const msm8953_pcnoc_nodes[] = {
> +	[MAS_SPDM] = &mas_spdm,
> +	[MAS_BLSP_1] = &mas_blsp_1,
> +	[MAS_BLSP_2] = &mas_blsp_2,
> +	[MAS_USB3] = &mas_usb3,
> +	[MAS_CRYPTO] = &mas_crypto,
> +	[MAS_SDCC_1] = &mas_sdcc_1,
> +	[MAS_SDCC_2] = &mas_sdcc_2,
> +	[MAS_SNOC_PCNOC] = &mas_snoc_pcnoc,
> +	[PCNOC_M_0] = &pcnoc_m_0,
> +	[PCNOC_M_1] = &pcnoc_m_1,
> +	[PCNOC_INT_1] = &pcnoc_int_1,
> +	[PCNOC_INT_2] = &pcnoc_int_2,
> +	[PCNOC_S_0] = &pcnoc_s_0,
> +	[PCNOC_S_1] = &pcnoc_s_1,
> +	[PCNOC_S_2] = &pcnoc_s_2,
> +	[PCNOC_S_3] = &pcnoc_s_3,
> +	[PCNOC_S_4] = &pcnoc_s_4,
> +	[PCNOC_S_6] = &pcnoc_s_6,
> +	[PCNOC_S_7] = &pcnoc_s_7,
> +	[PCNOC_S_8] = &pcnoc_s_8,
> +	[PCNOC_S_9] = &pcnoc_s_9,
> +	[SLV_SPDM] = &slv_spdm,
> +	[SLV_PDM] = &slv_pdm,
> +	[SLV_TCSR] = &slv_tcsr,
> +	[SLV_SNOC_CFG] = &slv_snoc_cfg,
> +	[SLV_TLMM] = &slv_tlmm,
> +	[SLV_MESSAGE_RAM] = &slv_message_ram,
> +	[SLV_BLSP_1] = &slv_blsp_1,
> +	[SLV_BLSP_2] = &slv_blsp_2,
> +	[SLV_PRNG] = &slv_prng,
> +	[SLV_CAMERA_SS_CFG] = &slv_camera_ss_cfg,
> +	[SLV_DISP_SS_CFG] = &slv_disp_ss_cfg,
> +	[SLV_VENUS_CFG] = &slv_venus_cfg,
> +	[SLV_GPU_CFG] = &slv_gpu_cfg,
> +	[SLV_SDCC_1] = &slv_sdcc_1,
> +	[SLV_SDCC_2] = &slv_sdcc_2,
> +	[SLV_CRYPTO_0_CFG] = &slv_crypto_0_cfg,
> +	[SLV_PMIC_ARB] = &slv_pmic_arb,
> +	[SLV_USB3] = &slv_usb3,
> +	[SLV_IPA_CFG] = &slv_ipa_cfg,
> +	[SLV_TCU] = &slv_tcu,
> +	[SLV_PCNOC_SNOC] = &slv_pcnoc_snoc,
> +};
> +
> +static const char * const msm8953_pcnoc_bus_clocks[] = {
> +	"bus", "bus_a"
> +};

This seems to be unused?

BR,
Georgi

> +
> +static const char * const msm8953_pcnoc_intf_clocks[] = {
> +	"pcnoc_usb3_axi"
> +};
> +
> +static const struct regmap_config msm8953_pcnoc_regmap_config = {
> +	.fast_io = true,
> +	.max_register = 0x12080,
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +};
> +
> +static const struct qcom_icc_desc msm8953_pcnoc = {
> +	.type = QCOM_ICC_NOC,
> +	.bus_clk_desc = &bus_0_clk,
> +	.intf_clocks = msm8953_pcnoc_intf_clocks,
> +	.num_intf_clocks = ARRAY_SIZE(msm8953_pcnoc_intf_clocks),
> +	.nodes = msm8953_pcnoc_nodes,
> +	.num_nodes = ARRAY_SIZE(msm8953_pcnoc_nodes),
> +	.qos_offset = 0x7000,
> +	.regmap_cfg = &msm8953_pcnoc_regmap_config,
> +};


