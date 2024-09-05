Return-Path: <linux-pm+bounces-13685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D7296D71B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5B51F24184
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39672199E94;
	Thu,  5 Sep 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7GKr78v"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC827199E88;
	Thu,  5 Sep 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535861; cv=none; b=P3iGQPd6weBtBghUi3vOJRrsovJaddphKTdrq6R+AibnbMafsA82ojtyQ+GBKPQUDjDzHYDyM0Gv3uph/sbIbi3g3Kq5SK5ZRE8hg5HGKZfE/Dj0bQKFbDVzsSCBfwwya6CviSF+Xg/LJs2rskaCCVxd8cZENfqiczMAegNYAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535861; c=relaxed/simple;
	bh=aTcY6lnCeCXuN+hBR/lTjApexCcG5nl9Skw7Ca45bF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxM+GTcKCpfZZQRk46TPSy+x5CAnSQyk9C+mGLA7QzJQ1tmWAKVSDQEwah3IvS176UztJZ2qG2k29bCn6NpIBSaoz3KpAPpZz53vrLGyw/wL4QKkbWXsPOIpHVTW8Umm+FZDlfizfY8bDvAjqyLC+OgqbuG1qyzaGue6FJJYL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7GKr78v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E207C4CEC3;
	Thu,  5 Sep 2024 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535860;
	bh=aTcY6lnCeCXuN+hBR/lTjApexCcG5nl9Skw7Ca45bF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X7GKr78v0KZSNjtPief4MGOvOX4Z7dQlMmWRBIpTU1p13LSzit5Su1pTaielep1O7
	 nFVcp3oxh6jjpSMAIINYxPiRmE+AKjLiCo1KluI7uRmpH8IM8bjm+5uOgWvRRrW34Q
	 SEIl6tqmJE+99KgmZZBjoJXm5YYjbvB9/+xlkE6SVOSYibxY33HZlmGVFMhg/ePM25
	 AqHzGdkKE2cumqW4AGDK7UMY1dK/zM/1MfbPQGBPXFfTi/LMxxRJ22WQ+u97zxcsUS
	 PT/P9fsSxWW9VT8MvPSPcrSawtpyg+Eaqh7U5bZdYSpr5RcoMaiZaDa94gU6n0rCC2
	 J4BIvJw8awzOQ==
Message-ID: <d5e338fe-bd38-49f7-b69f-fc27f9f87495@kernel.org>
Date: Thu, 5 Sep 2024 13:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] dt-bindings: power: rpmpd: Add QCS8300 power
 domains
To: Jingyi Wang <quic_jingyw@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Shazad Hussain <quic_shazhuss@quicinc.com>,
 Tingguo Cheng <quic_tingguoc@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-6-d0ea9afdc007@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240904-qcs8300_initial_dtsi-v1-6-d0ea9afdc007@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4.09.2024 10:33 AM, Jingyi Wang wrote:
> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> 
> Add compatible and constants for the power domains exposed by the RPMH
> in the Qualcomm QCS8300 platform.
> 
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h                | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index 929b7ef9c1bc..be1a9cb71a9b 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -32,6 +32,7 @@ properties:
>            - qcom,msm8998-rpmpd
>            - qcom,qcm2290-rpmpd
>            - qcom,qcs404-rpmpd
> +          - qcom,qcs8300-rpmhpd
>            - qcom,qdu1000-rpmhpd
>            - qcom,qm215-rpmpd
>            - qcom,sa8155p-rpmhpd
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 608087fb9a3d..7dd7b9ebc480 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -4,6 +4,25 @@
>  #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
>  #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
>  
> +/* QCS8300 Power Domain Indexes */
> +#define QCS8300_CX	0
> +#define QCS8300_CX_AO	1
> +#define QCS8300_DDR	2
> +#define QCS8300_EBI	3
> +#define QCS8300_GFX	4
> +#define QCS8300_LCX	5
> +#define QCS8300_LMX	6
> +#define QCS8300_MMCX	7
> +#define QCS8300_MMCX_AO	8
> +#define QCS8300_MSS	9
> +#define QCS8300_MX	10
> +#define QCS8300_MX_AO	11
> +#define QCS8300_MXC	12
> +#define QCS8300_MXC_AO	13
> +#define QCS8300_NSP0	14
> +#define QCS8300_NSP1	15
> +#define QCS8300_XO	16

Some time ago we moved RPM*h*pd to common defines.. we should
definitely do the same here. Please reuse the RPMPD_xxx definitions
from [1] and credit Rohit in the commit message, as he did some
processing on that to make sure they're ordered based on usage

Konrad

[1] https://lore.kernel.org/all/1688647793-20950-2-git-send-email-quic_rohiagar@quicinc.com/

