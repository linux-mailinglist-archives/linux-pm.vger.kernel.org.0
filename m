Return-Path: <linux-pm+bounces-16179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698F89A97A9
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 06:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851091C218C0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 04:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5F481CD;
	Tue, 22 Oct 2024 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIUe4FIE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA1C2907;
	Tue, 22 Oct 2024 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570628; cv=none; b=aOdikLgkjUwWfr5OKPX9YL7pbNHUQ88AuZP3Sh0kL8ebfw46jUjVAopA97CAh1iTbaWdVhZUw+8rBc3kP6U4fcsp0oNTCT5dDUwJec77Fk2iRAiv/uoHu9gYPiVWj8sHQSl8CnBdJCK8jtg66cwQei2Es6LM7gQndFeO13hPJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570628; c=relaxed/simple;
	bh=PHkB0FgC7V2r5+tmMf8UoZh2NWJtTAmqohzY/S31mLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uagyj3Bn569nm1j04xbdkgUabJ5nR90pehh0nt9KNqKOQrKQ0Oe4WtpyM3TiOdNsyF1c0eVTlKjHJLBHws9BcDQgotiPjB6miyz7M3qVrP71OwDPLURR5PhgZTbIS9Yh//65BZoOwUMPAFqHay9/u4SJPMXKSS8NuxwWg/yu9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIUe4FIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4B6C4CEC3;
	Tue, 22 Oct 2024 04:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729570628;
	bh=PHkB0FgC7V2r5+tmMf8UoZh2NWJtTAmqohzY/S31mLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WIUe4FIEIxkc7BXZGxw1/0uf/dqyI6sMBA6p7jbtmmpb9FCbTRhu/UxwSDIGoDnqT
	 vycrkTCCFDQzOt18EpoasR9jYQP+7BhhOgL38ckTY+J+oBFZaAX8M38vRyTBktshWu
	 edM95UtpQ7jcqAu8sttIyPvy8YQvEyivS52efthKhmNVkJ8fx2UnUTjrzV4HOHf63A
	 j8ngduOMAF5g5W8bkNKL1hRJKwsFpI1wvHXWcXS/LiEQ8aV5nvbpF252wBwSoFewgW
	 VfzVum2BxnW/RrpT1hcGsmUhc8PTdshGJeT5gQ2bmK10C5TwBMzKTJrK/fJHip9C3x
	 Qzx8JanajKphQ==
Message-ID: <e4138547-2a48-411b-a710-131e62ad7486@kernel.org>
Date: Tue, 22 Oct 2024 06:16:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add interconnect provider driver
 for SM8750
To: Melody Olvera <quic_molvera@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adam Skladowski <a39.skl@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Sibi Sankar
 <quic_sibis@quicinc.com>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <barnabas.czeman@mainlining.org>, Vladimir Lypak <vladimir.lypak@gmail.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Mike Tipton <quic_mdtipton@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
 Trilok Soni <quic_tsoni@quicinc.com>,
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241021231823.2635534-1-quic_molvera@quicinc.com>
 <20241021231823.2635534-3-quic_molvera@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241021231823.2635534-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2024 01:18, Melody Olvera wrote:
> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> 
> Introduce SM8750 interconnect provider driver using the interconnect
> framework.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>

...

> +
> +static struct qcom_icc_node *cnoc_cfg_nodes[] = {
> +	[MASTER_CNOC_CFG] = &qsm_cfg,
> +	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
> +	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
> +	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
> +	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
> +	[SLAVE_EVA_CFG] = &qhs_eva_cfg,
> +	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
> +	[SLAVE_I2C] = &qhs_i2c,
> +	[SLAVE_I3C_IBI0_CFG] = &qhs_i3c_ibi0_cfg,
> +	[SLAVE_I3C_IBI1_CFG] = &qhs_i3c_ibi1_cfg,
> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
> +	[SLAVE_PCIE_CFG] = &qhs_pcie_cfg,
> +	[SLAVE_PRNG] = &qhs_prng,
> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SLAVE_QSPI_0] = &qhs_qspi,
> +	[SLAVE_QUP_3] = &qhs_qup02,
> +	[SLAVE_QUP_1] = &qhs_qup1,
> +	[SLAVE_QUP_2] = &qhs_qup2,
> +	[SLAVE_SDCC_2] = &qhs_sdc2,
> +	[SLAVE_SDCC_4] = &qhs_sdc4,
> +	[SLAVE_SPSS_CFG] = &qhs_spss_cfg,
> +	[SLAVE_TCSR] = &qhs_tcsr,
> +	[SLAVE_TLMM] = &qhs_tlmm,
> +	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
> +	[SLAVE_USB3_0] = &qhs_usb3_0,
> +	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
> +	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
> +	[SLAVE_CNOC_MNOC_CFG] = &qss_mnoc_cfg,
> +	[SLAVE_PCIE_ANOC_CFG] = &qss_pcie_anoc_cfg,
> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sm8750_cnoc_cfg = {

This is some downstream code. Please use upstream, e.g. sm8550 or
sm8650, as template for new drivers. Otherwise we need to fix or review
exactly the same things which we fixed months ago.

> +	.nodes = cnoc_cfg_nodes,
> +	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
> +	.bcms = cnoc_cfg_bcms,
> +	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
> +};
> +



Best regards,
Krzysztof


