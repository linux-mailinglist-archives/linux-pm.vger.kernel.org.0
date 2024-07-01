Return-Path: <linux-pm+bounces-10291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A188691E593
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 18:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDA81C21A9B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE316DC23;
	Mon,  1 Jul 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIwTfQmQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAFC16D9D4;
	Mon,  1 Jul 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852171; cv=none; b=Z0JgSoyAXAU+u/QgI6LC5P1Y7HbuIdJym/y/37Rwrys9yspu4lAIRVjPoOr9zJcCS9FnIp44DPrlUIzBSGRgBcQQl/lmF4/9NUSKV9VZ6xTlcma9UCLYq6+IgLKKyymfk9k3VlIwo9Xaev/KDvLWnK7bB/4EszXiO5swNCN+RX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852171; c=relaxed/simple;
	bh=crpOrx+AhVJ633iBSGG9K4u7w7lUT/UKN4loqWQu8oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf838AKWwNifjd90NLkEYhZvif2AfQ1nLGkRtFCgGJ60Xf52ReSbC51cKCUJ0LMM6Pu1C1HU2URT8k1N2Osy1Ev+jV3ujoZrDmtxXrfsP1OBacwDlI+bzJS3EffzZkHyaKS8mpJ3tgEs7Ne8fH6+o1zV0FFMnNFTGu3/HeIDqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIwTfQmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26282C116B1;
	Mon,  1 Jul 2024 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852171;
	bh=crpOrx+AhVJ633iBSGG9K4u7w7lUT/UKN4loqWQu8oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIwTfQmQ3Dy1kZ7C0RJbKjk5gpGUQ7Oro35XTe+MG8UtO3w4LOjUdRHOGylUlurf3
	 snB8hsul40DK5L6oTJTwlI5N6Qgl2oaE3tutntKZURfrT5ZplfJsOQxw+M+mK/UODk
	 a9dQTWc34hGQlGShyjV2G+6Jbp1C836UjdHh27jbXG96l9+dKiZ4IHU+Fs5hrFwAed
	 GlODUEAXL2qMn5nAGBWKOhk5/IE3kjZ1Geh4EH9ZfpVJclAeni4/lVzekcuQe882wb
	 VWOwnkSXi0xGiI2zFZjcTP6/jnWBdwMF4PPCIQ/HsvZqDGp8joMT6FFl7JZyTPlTe4
	 rZF019YP9aK1w==
Date: Mon, 1 Jul 2024 11:42:48 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	quic_rlaggysh@quicinc.com, quic_mdtipton@quicinc.com
Subject: Re: [PATCH v5 2/4] interconnect: qcom: sc7280: enable QoS
 configuration
Message-ID: <ciji6nlxn752ina4tmh6kwvek52nxpnguomqek6plwvwgvoqef@yrtexkpmn5br>
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-3-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607173927.26321-3-quic_okukatla@quicinc.com>

On Fri, Jun 07, 2024 at 11:09:25PM GMT, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined values
> for priority and urgency forawrding.
> 

This patch causes QCS6490 RB3Gen2 to hit a bus timeout and crash during
boot, unless the associated DeviceTree change (adding clocks) is
present.

The two patches are reaching linux-next, and hence mainline, through
different code paths we now have periods where rb3gen2 is not bootable.
But more importantly, devices with current .dtbs installed can not boot
the new kernel.


It is not acceptable to introduce non-backwards compatible changes in
drivers (unless there's extraordinary reasons to do so).

Regards,
Bjorn

> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  drivers/interconnect/qcom/sc7280.c | 274 +++++++++++++++++++++++++++++
>  1 file changed, 274 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
> index 7d33694368e8..759c609a20bf 100644
> --- a/drivers/interconnect/qcom/sc7280.c
> +++ b/drivers/interconnect/qcom/sc7280.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   *
>   */
>  
> @@ -21,6 +22,12 @@ static struct qcom_icc_node qhm_qspi = {
>  	.id = SC7280_MASTER_QSPI_0,
>  	.channels = 1,
>  	.buswidth = 4,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x7000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };
> @@ -30,6 +37,12 @@ static struct qcom_icc_node qhm_qup0 = {
>  	.id = SC7280_MASTER_QUP_0,
>  	.channels = 1,
>  	.buswidth = 4,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x11000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };
> @@ -39,6 +52,12 @@ static struct qcom_icc_node qhm_qup1 = {
>  	.id = SC7280_MASTER_QUP_1,
>  	.channels = 1,
>  	.buswidth = 4,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x8000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };
> @@ -57,6 +76,12 @@ static struct qcom_icc_node xm_sdc1 = {
>  	.id = SC7280_MASTER_SDCC_1,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xc000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };
> @@ -66,6 +91,12 @@ static struct qcom_icc_node xm_sdc2 = {
>  	.id = SC7280_MASTER_SDCC_2,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xe000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };
> @@ -75,6 +106,12 @@ static struct qcom_icc_node xm_sdc4 = {
>  	.id = SC7280_MASTER_SDCC_4,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x9000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };
> @@ -84,6 +121,12 @@ static struct qcom_icc_node xm_ufs_mem = {
>  	.id = SC7280_MASTER_UFS_MEM,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xa000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };
> @@ -102,6 +145,12 @@ static struct qcom_icc_node xm_usb3_0 = {
>  	.id = SC7280_MASTER_USB3_0,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xb000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };
> @@ -111,6 +160,12 @@ static struct qcom_icc_node qhm_qdss_bam = {
>  	.id = SC7280_MASTER_QDSS_BAM,
>  	.channels = 1,
>  	.buswidth = 4,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x18000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A2NOC_SNOC },
>  };
> @@ -129,6 +184,12 @@ static struct qcom_icc_node qnm_cnoc_datapath = {
>  	.id = SC7280_MASTER_CNOC_A2NOC,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x1c000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A2NOC_SNOC },
>  };
> @@ -138,6 +199,12 @@ static struct qcom_icc_node qxm_crypto = {
>  	.id = SC7280_MASTER_CRYPTO,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x1d000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A2NOC_SNOC },
>  };
> @@ -147,6 +214,12 @@ static struct qcom_icc_node qxm_ipa = {
>  	.id = SC7280_MASTER_IPA,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x10000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A2NOC_SNOC },
>  };
> @@ -173,6 +246,12 @@ static struct qcom_icc_node xm_qdss_etr = {
>  	.id = SC7280_MASTER_QDSS_ETR,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x15000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A2NOC_SNOC },
>  };
> @@ -305,6 +384,12 @@ static struct qcom_icc_node alm_gpu_tcu = {
>  	.id = SC7280_MASTER_GPU_TCU,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xd7000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 2,
>  	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
>  };
> @@ -314,6 +399,12 @@ static struct qcom_icc_node alm_sys_tcu = {
>  	.id = SC7280_MASTER_SYS_TCU,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xd6000 },
> +		.prio = 6,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 2,
>  	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
>  };
> @@ -333,6 +424,12 @@ static struct qcom_icc_node qnm_cmpnoc = {
>  	.id = SC7280_MASTER_COMPUTE_NOC,
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x21000, 0x61000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 2,
>  	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
>  };
> @@ -353,6 +450,12 @@ static struct qcom_icc_node qnm_gpu = {
>  	.id = SC7280_MASTER_GFX3D,
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x22000, 0x62000 },
> +		.prio = 0,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 2,
>  	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
>  };
> @@ -362,6 +465,12 @@ static struct qcom_icc_node qnm_mnoc_hf = {
>  	.id = SC7280_MASTER_MNOC_HF_MEM_NOC,
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x23000, 0x63000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_LLCC },
>  };
> @@ -371,6 +480,12 @@ static struct qcom_icc_node qnm_mnoc_sf = {
>  	.id = SC7280_MASTER_MNOC_SF_MEM_NOC,
>  	.channels = 1,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xcf000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 2,
>  	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
>  };
> @@ -389,6 +504,12 @@ static struct qcom_icc_node qnm_snoc_gc = {
>  	.id = SC7280_MASTER_SNOC_GC_MEM_NOC,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xd3000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_LLCC },
>  };
> @@ -398,6 +519,12 @@ static struct qcom_icc_node qnm_snoc_sf = {
>  	.id = SC7280_MASTER_SNOC_SF_MEM_NOC,
>  	.channels = 1,
>  	.buswidth = 16,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xd4000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 3,
>  	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC,
>  		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
> @@ -437,6 +564,12 @@ static struct qcom_icc_node qnm_video0 = {
>  	.id = SC7280_MASTER_VIDEO_P0,
>  	.channels = 1,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x14000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
>  };
> @@ -446,6 +579,12 @@ static struct qcom_icc_node qnm_video_cpu = {
>  	.id = SC7280_MASTER_VIDEO_PROC,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x15000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
>  };
> @@ -455,6 +594,12 @@ static struct qcom_icc_node qxm_camnoc_hf = {
>  	.id = SC7280_MASTER_CAMNOC_HF,
>  	.channels = 2,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 2,
> +		.port_offsets = { 0x10000, 0x10180 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
>  };
> @@ -464,6 +609,12 @@ static struct qcom_icc_node qxm_camnoc_icp = {
>  	.id = SC7280_MASTER_CAMNOC_ICP,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x11000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
>  };
> @@ -473,6 +624,12 @@ static struct qcom_icc_node qxm_camnoc_sf = {
>  	.id = SC7280_MASTER_CAMNOC_SF,
>  	.channels = 1,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x12000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
>  };
> @@ -482,6 +639,12 @@ static struct qcom_icc_node qxm_mdp0 = {
>  	.id = SC7280_MASTER_MDP0,
>  	.channels = 1,
>  	.buswidth = 32,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x16000 },
> +		.prio = 0,
> +		.urg_fwd = 1,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
>  };
> @@ -536,6 +699,12 @@ static struct qcom_icc_node qxm_pimem = {
>  	.id = SC7280_MASTER_PIMEM,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0x8000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
>  };
> @@ -545,6 +714,12 @@ static struct qcom_icc_node xm_gic = {
>  	.id = SC7280_MASTER_GIC,
>  	.channels = 1,
>  	.buswidth = 8,
> +	.qosbox = &(const struct qcom_icc_qosbox) {
> +		.num_ports = 1,
> +		.port_offsets = { 0xa000 },
> +		.prio = 2,
> +		.urg_fwd = 0,
> +	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
>  };
> @@ -1502,7 +1677,16 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
>  	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
>  };
>  
> +static const struct regmap_config sc7280_aggre1_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x1c080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_aggre1_noc = {
> +	.config = &sc7280_aggre1_noc_regmap_config,
>  	.nodes = aggre1_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
>  	.bcms = aggre1_noc_bcms,
> @@ -1513,6 +1697,14 @@ static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
>  	&bcm_ce0,
>  };
>  
> +static const struct regmap_config sc7280_aggre2_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x2b080,
> +	.fast_io = true,
> +};
> +
>  static struct qcom_icc_node * const aggre2_noc_nodes[] = {
>  	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
>  	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
> @@ -1525,6 +1717,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
>  };
>  
>  static const struct qcom_icc_desc sc7280_aggre2_noc = {
> +	.config = &sc7280_aggre2_noc_regmap_config,
>  	.nodes = aggre2_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
>  	.bcms = aggre2_noc_bcms,
> @@ -1605,7 +1798,16 @@ static struct qcom_icc_node * const cnoc2_nodes[] = {
>  	[SLAVE_SNOC_CFG] = &qns_snoc_cfg,
>  };
>  
> +static const struct regmap_config sc7280_cnoc2_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x1000,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_cnoc2 = {
> +	.config = &sc7280_cnoc2_regmap_config,
>  	.nodes = cnoc2_nodes,
>  	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
>  	.bcms = cnoc2_bcms,
> @@ -1637,7 +1839,16 @@ static struct qcom_icc_node * const cnoc3_nodes[] = {
>  	[SLAVE_TCU] = &xs_sys_tcu_cfg,
>  };
>  
> +static const struct regmap_config sc7280_cnoc3_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x1000,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_cnoc3 = {
> +	.config = &sc7280_cnoc3_regmap_config,
>  	.nodes = cnoc3_nodes,
>  	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
>  	.bcms = cnoc3_bcms,
> @@ -1653,7 +1864,16 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
>  	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
>  };
>  
> +static const struct regmap_config sc7280_dc_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x5080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_dc_noc = {
> +	.config = &sc7280_dc_noc_regmap_config,
>  	.nodes = dc_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
>  	.bcms = dc_noc_bcms,
> @@ -1689,7 +1909,16 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
>  	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
>  };
>  
> +static const struct regmap_config sc7280_gem_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0xe2200,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_gem_noc = {
> +	.config = &sc7280_gem_noc_regmap_config,
>  	.nodes = gem_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
>  	.bcms = gem_noc_bcms,
> @@ -1709,7 +1938,16 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
>  	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
>  };
>  
> +static const struct regmap_config sc7280_lpass_ag_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0xf080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
> +	.config = &sc7280_lpass_ag_noc_regmap_config,
>  	.nodes = lpass_ag_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
>  	.bcms = lpass_ag_noc_bcms,
> @@ -1726,7 +1964,16 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
>  	[SLAVE_EBI1] = &ebi,
>  };
>  
> +static const struct regmap_config sc7280_mc_virt_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x4,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_mc_virt = {
> +	.config = &sc7280_mc_virt_regmap_config,
>  	.nodes = mc_virt_nodes,
>  	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
>  	.bcms = mc_virt_bcms,
> @@ -1753,7 +2000,16 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
>  	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
>  };
>  
> +static const struct regmap_config sc7280_mmss_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x1e080,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_mmss_noc = {
> +	.config = &sc7280_mmss_noc_regmap_config,
>  	.nodes = mmss_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
>  	.bcms = mmss_noc_bcms,
> @@ -1772,7 +2028,16 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
>  	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
>  };
>  
> +static const struct regmap_config sc7280_nsp_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x10000,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_nsp_noc = {
> +	.config = &sc7280_nsp_noc_regmap_config,
>  	.nodes = nsp_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
>  	.bcms = nsp_noc_bcms,
> @@ -1797,7 +2062,16 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
>  	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
>  };
>  
> +static const struct regmap_config sc7280_system_noc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0x15480,
> +	.fast_io = true,
> +};
> +
>  static const struct qcom_icc_desc sc7280_system_noc = {
> +	.config = &sc7280_system_noc_regmap_config,
>  	.nodes = system_noc_nodes,
>  	.num_nodes = ARRAY_SIZE(system_noc_nodes),
>  	.bcms = system_noc_bcms,
> -- 
> 2.17.1
> 

