Return-Path: <linux-pm+bounces-9948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FA5916920
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92BC1F2A7AD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0424C163AA7;
	Tue, 25 Jun 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLWPwpj3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C699415F3FF;
	Tue, 25 Jun 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322668; cv=none; b=YnMzUlZmWFGSOoaUca5TDdTl9hGjTb2xqWTBs1VQypy/ae5YqT86EAv2Sxftxm3K8gPdMGGNEVph0YTQUJcrlV3p+EB5mo+Np59gieZJWQtLMlTj5fZ14n8L6thOZXuqWx78SZh45fSMy+3bbF9hk7shXfbbhP9k6odhHt1ukbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322668; c=relaxed/simple;
	bh=Fi8mYtRnhR/Ud4l97BJTFhMif+IBWlqAwv9EXERNImI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z52arMVYOzjcCt0jwokrnhJl5ttjPpe5fJ2tPotX+X/D1FtVoEnw2DvFyJ0BK5gUYJ/ToxQ2wt178Qn2vJIy5MVVaXBG+weXLK7VApPbtQFERpKiT3TZvLCinI4qu0IlPZq8tpAIv4xgxm8nmQXWPa6wQaIJ19jh4jUVzU5b5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLWPwpj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1794DC32781;
	Tue, 25 Jun 2024 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719322668;
	bh=Fi8mYtRnhR/Ud4l97BJTFhMif+IBWlqAwv9EXERNImI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sLWPwpj3ED5nvvgdTel1Wy/40yCx6Vv7QvwYBmOuZV/IbJ+vP9ngA9d9ullCfbFXV
	 Lt8QYVPGUsZU3mFwJmhzKFhazWROyLd5DPrtbaBPhqcR/s/3UUV5GSFzACI/AvVrsp
	 WB3I0Ke+UCvQWVmcvXjvj2BjHcL1IJevJosy4tS7IX4Pm61FhzcW3cG8dODkQCdAqF
	 J84l4jatihTK17qvLcN4DX/AmkfNUTMuF7FqlwxreGjHDs0/RoRnAiaOqsTyBW4BuK
	 RGetmWu65kZ5xaXCEXvbNKz8+dCb2uSXUhWL23sIdN9vVC4vH0FBCFRbxbLmgFX7de
	 dxtUwFxXG5DFw==
Message-ID: <83ea0718-362a-47e1-a311-58c8b3ef39dc@kernel.org>
Date: Tue, 25 Jun 2024 16:37:42 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: sc7280: Add clocks for QOS
 configuration
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-5-quic_okukatla@quicinc.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240607173927.26321-5-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7.06.24 20:39, Odelu Kukatla wrote:
> Add clocks which need to be enbaled for configuring
> QoS on sc7280.
> 

Nit: s/enbaled/enabled/

> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>

In any case:
Acked-by: Georgi Djakov <djakov@kernel.org>

Bjorn, the dt-binding change is available in my icc-rpmh-qos branch
in case you want to make the dtbs checker happy when you apply this.

BR,
Georgi

> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index ba43fba2c551..a3c640d394e9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2130,6 +2130,8 @@
>   			reg = <0 0x016e0000 0 0x1c080>;
>   			#interconnect-cells = <2>;
>   			qcom,bcm-voters = <&apps_bcm_voter>;
> +			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
>   		};
>   
>   		aggre2_noc: interconnect@1700000 {
> @@ -2137,6 +2139,7 @@
>   			compatible = "qcom,sc7280-aggre2-noc";
>   			#interconnect-cells = <2>;
>   			qcom,bcm-voters = <&apps_bcm_voter>;
> +			clocks = <&rpmhcc RPMH_IPA_CLK>;
>   		};
>   
>   		mmss_noc: interconnect@1740000 {


