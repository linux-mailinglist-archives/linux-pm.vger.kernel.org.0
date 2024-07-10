Return-Path: <linux-pm+bounces-10938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C90392D574
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 17:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9CD1F235FB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290E194AE3;
	Wed, 10 Jul 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSlj/Xo/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C104194135;
	Wed, 10 Jul 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626980; cv=none; b=OacsVdpJPEMxkhsEi53rMkb65GKdvFk74Ehp+7iQG9eYgHkGpcSvkdn37E6wnk/6OWhnh4x2V9u01dOrS+R3IRCyHdvrHa9tHVsYyPMmHI38vicAfhhFgANI91yzE/8cJbqCMVXm3hL/3iilGYhFkyvHK13kttcyg9M69Doyvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626980; c=relaxed/simple;
	bh=XjBzCjwIpp8SXuUwXq2uIFVgVjUPOVR8FS4xVOZVhoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHn5dZZbZi4pk8UjWMdN9nHjKmRjdZ+QqiPsVsxQ3wyzgfSWC4tuk1mxAJdFSndW5QByQjXF9r2BQUvYIk0qrcy+9ClI/SpvPavAPAU1p08el2YpL2bxxD4M1E2j88hI+RQNnybLwJFswdYKAUtJGLWR4WPp4vP2X45AasSUYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSlj/Xo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D16C32786;
	Wed, 10 Jul 2024 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720626980;
	bh=XjBzCjwIpp8SXuUwXq2uIFVgVjUPOVR8FS4xVOZVhoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSlj/Xo/BcOIel08H62BzJavL5R76fyw07sAGq7g/JewbdHnTVeAd0WmSMGer/UO/
	 RvXhAhSma9UZ5Fc7Cj1ry0BnWdSYB69DDHmYcO1TM7+G2lH4p5qlSXpJwn34jofpRW
	 ZAXZK51vVr11AlyGNFBu5yItuYNgD+1ErGxl2dZTSUaXC9LxXVLDAYINUkTAugDSpl
	 dwE1JJmvjYWJpNn4imAAmgxxoCEUb6U2YwTTvn9Mn3yiiYbCJ+hlgQCcSmhI6q8NQY
	 QHKGvZtLde1eVeEgzuPalReXXqwgEdPM2TEjrpUjRmuCU2q3cmkBfpvLoqoqxjC5Sm
	 QITqwtuNb9nqA==
Date: Wed, 10 Jul 2024 09:56:03 -0600
From: Rob Herring <robh@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v3 3/9] dt-bindings: interconnect: qcom: Add Qualcomm
 MSM8937 NoC
Message-ID: <20240710155603.GB3133981-robh@kernel.org>
References: <20240709102728.15349-1-a39.skl@gmail.com>
 <20240709102728.15349-4-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709102728.15349-4-a39.skl@gmail.com>

On Tue, Jul 09, 2024 at 12:22:48PM +0200, Adam Skladowski wrote:
> Add bindings for Qualcomm MSM8937 Network-On-Chip interconnect devices.

That is obvious. What would be useful is detailing how 8937 is similar 
to the existing devices.

> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/interconnect/qcom,msm8939.yaml   |  8 +-
>  .../dt-bindings/interconnect/qcom,msm8937.h   | 93 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
> index 0641a3c992a5..d19e20247df8 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
> @@ -4,13 +4,13 @@
>  $id: http://devicetree.org/schemas/interconnect/qcom,msm8939.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm MSM8939/MSM8976 Network-On-Chip interconnect
> +title: Qualcomm MSM8937/MSM8939/MSM8976 Network-On-Chip interconnect
>  
>  maintainers:
>    - Konrad Dybcio <konradybcio@kernel.org>
>  
>  description:
> -  The Qualcomm MSM8939/MSM8976 interconnect providers support
> +  The Qualcomm MSM8937/MSM8939/MSM8976 interconnect providers support
>    adjusting the bandwidth requirements between the various NoC fabrics.
>  
>  allOf:
> @@ -19,6 +19,9 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - qcom,msm8937-bimc
> +      - qcom,msm8937-pcnoc
> +      - qcom,msm8937-snoc
>        - qcom,msm8939-bimc
>        - qcom,msm8939-pcnoc
>        - qcom,msm8939-snoc
> @@ -43,6 +46,7 @@ patternProperties:
>      properties:
>        compatible:
>          enum:
> +          - qcom,msm8937-snoc-mm
>            - qcom,msm8939-snoc-mm
>            - qcom,msm8976-snoc-mm
>  
> diff --git a/include/dt-bindings/interconnect/qcom,msm8937.h b/include/dt-bindings/interconnect/qcom,msm8937.h
> new file mode 100644
> index 000000000000..98b8a4637aab
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,msm8937.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Qualcomm MSM8937 interconnect IDs
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8937_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8937_H
> +
> +/* BIMC fabric */
> +#define MAS_APPS_PROC		0
> +#define MAS_OXILI		1
> +#define MAS_SNOC_BIMC_0		2
> +#define MAS_SNOC_BIMC_2		3
> +#define MAS_SNOC_BIMC_1		4
> +#define MAS_TCU_0		5
> +#define SLV_EBI			6
> +#define SLV_BIMC_SNOC		7
> +
> +/* PCNOC fabric */
> +#define MAS_SPDM		0
> +#define MAS_BLSP_1		1
> +#define MAS_BLSP_2		2
> +#define MAS_USB_HS1		3
> +#define MAS_XI_USB_HS1		4
> +#define MAS_CRYPTO		5
> +#define MAS_SDCC_1		6
> +#define MAS_SDCC_2		7
> +#define MAS_SNOC_PCNOC		8
> +#define PCNOC_M_0		9
> +#define PCNOC_M_1		10
> +#define PCNOC_INT_0		11
> +#define PCNOC_INT_1		12
> +#define PCNOC_INT_2		13
> +#define PCNOC_INT_3		14
> +#define PCNOC_S_0		15
> +#define PCNOC_S_1		16
> +#define PCNOC_S_2		17
> +#define PCNOC_S_3		18
> +#define PCNOC_S_4		19
> +#define PCNOC_S_6		20
> +#define PCNOC_S_7		21
> +#define PCNOC_S_8		22
> +#define SLV_SDCC_2		23
> +#define SLV_SPDM		24
> +#define SLV_PDM			25
> +#define SLV_PRNG		26
> +#define SLV_TCSR		27
> +#define SLV_SNOC_CFG		28
> +#define SLV_MESSAGE_RAM		29
> +#define SLV_CAMERA_SS_CFG	30
> +#define SLV_DISP_SS_CFG		31
> +#define SLV_VENUS_CFG		32
> +#define SLV_GPU_CFG		33
> +#define SLV_TLMM		34
> +#define SLV_BLSP_1		35
> +#define SLV_BLSP_2		36
> +#define SLV_PMIC_ARB		37
> +#define SLV_SDCC_1		38
> +#define SLV_CRYPTO_0_CFG	39
> +#define SLV_USB_HS		40
> +#define SLV_TCU			41
> +#define SLV_PCNOC_SNOC		42
> +
> +/* SNOC fabric */
> +#define MAS_QDSS_BAM		0
> +#define MAS_BIMC_SNOC		1
> +#define MAS_PCNOC_SNOC		2
> +#define MAS_QDSS_ETR		3
> +#define QDSS_INT		4
> +#define SNOC_INT_0		5
> +#define SNOC_INT_1		6
> +#define SNOC_INT_2		7
> +#define SLV_KPSS_AHB		8
> +#define SLV_WCSS		9
> +#define SLV_SNOC_BIMC_1		10
> +#define SLV_IMEM		11
> +#define SLV_SNOC_PCNOC		12
> +#define SLV_QDSS_STM		13
> +#define SLV_CATS_1		14
> +#define SLV_LPASS		15
> +
> +/* SNOC-MM fabric */
> +#define MAS_JPEG		0
> +#define MAS_MDP			1
> +#define MAS_VENUS		2
> +#define MAS_VFE0		3
> +#define MAS_VFE1		4
> +#define MAS_CPP			5
> +#define SLV_SNOC_BIMC_0		6
> +#define SLV_SNOC_BIMC_2		7
> +#define SLV_CATS_0		8
> +
> +#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_MSM8937_H */
> -- 
> 2.45.2
> 

