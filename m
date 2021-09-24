Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB04B417545
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbhIXNSm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 09:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346419AbhIXNRW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Sep 2021 09:17:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4470E60F41;
        Fri, 24 Sep 2021 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632489347;
        bh=RjzByDl9fC9SxZ+FQlbjPaVMD8Xb572rgQ8e10D6pnY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KZd6BoD429XnDZyRawZO5c+1LvXTLWesHncj19tyYDDNIua+e/uPOiF0T5j3SD25f
         9bRMiRiUOnBZmONIn5Ez8MjwPaJDyKjFdhcmWPxWy6vDoQPxEX8GyYMdX1o2wZXpXV
         Bgjtno78tGTijMQz4Jpd2bLTx4tl4oguSV4A7B4CQXfWFgqe0MVbhwWDITELKoRJLC
         XMvPYktKVlRNOkXAAvWiZeWXms3yH22KW94OiP71mduk9wEIGzPW56ehgDfI7Umaz0
         NaRmrtYtmsAx03W6B+b+tyQmqfqCurRXl1eo6/mOvOFJLPqVicqssy3txYmZnvBJRK
         /DaPkTSdAh3nQ==
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm630: Add missing a2noc qos
 clocks
To:     Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210824043435.23190-1-shawn.guo@linaro.org>
 <20210824043435.23190-4-shawn.guo@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <bccddf49-7e89-e26e-03c1-c21ed8e42e7d@kernel.org>
Date:   Fri, 24 Sep 2021 16:15:43 +0300
MIME-Version: 1.0
In-Reply-To: <20210824043435.23190-4-shawn.guo@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24.08.21 7:34, Shawn Guo wrote:
> It adds the missing a2noc clocks required for QoS registers programming
> per downstream kernel[1].
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
>   arch/arm64/boot/dts/qcom/sdm630.dtsi | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 9153e6616ba4..9c7f87e42fcc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -654,9 +654,20 @@
>   			compatible = "qcom,sdm660-a2noc";
>   			reg = <0x01704000 0xc100>;
>   			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> +			clock-names = "bus",
> +				      "bus_a",
> +				      "ipa",
> +				      "ufs_axi",
> +				      "aggre2_ufs_axi",
> +				      "aggre2_usb3_axi",
> +				      "cfg_noc_usb2_axi";
>   			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
> -				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
> +				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
> +				 <&rpmcc RPM_SMD_IPA_CLK>,
> +				 <&gcc GCC_UFS_AXI_CLK>,
> +				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
> +				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
> +				 <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
>   		};
>   
>   		mnoc: interconnect@1745000 {
> 

