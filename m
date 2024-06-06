Return-Path: <linux-pm+bounces-8676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FE28FDCF0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 04:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B90284BBD
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 02:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D71AAA5;
	Thu,  6 Jun 2024 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWkYIyJ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC99139D;
	Thu,  6 Jun 2024 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641913; cv=none; b=JCrWuoCl87dwROwwqM9WnHmlSZK+GO3d6QQpEfDwUiuidQzc9NmHLzuhWKRnDeOj6EK/94xcTe/2feHnbBjvktazvvdgMaN0f12lfSf+RKOWnnSkANSA64HHz4EbUQq/kXHwAlJbhJalaKwhAJbFn6IaNLuEo0FmNscA5PzwdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641913; c=relaxed/simple;
	bh=kqZXOw6/7fHVotZrhoYLfwmugTpQ1YtwPdviJzdW0+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIvizPTFJPmgyJe+6dHVnf0x9KBPufcOA2CLkm/SkJrMLisR8ojqftC+wOsimpnQXtUW6JX23+frtVDzbIusFmKqU3VsrxGfo1W84qOJEPf5dZIQoSHqSWCNI+au5D/OQmgMlE43Tr7iwgMJ1R1z7yrbXapb78dVjAWX4RROEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWkYIyJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C237C3277B;
	Thu,  6 Jun 2024 02:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717641912;
	bh=kqZXOw6/7fHVotZrhoYLfwmugTpQ1YtwPdviJzdW0+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWkYIyJ+1dxrhSzvsScrKWoIf686vpiivDHrZ60obyScX+RZTlB4L73jx1g3VHv/E
	 Fnu9a+ed/d4pxyRWjTqxOHoO01QJvqaCXMJnG8X5FnfnVsKPgLsq3MopaALeU5Zb8v
	 jycPT0lytwdjNyhSUe2X8/Lgzyx5gectp2ph6LYg+CtKsD3LpSfhpaGEEz09hb4t6d
	 2bHycbOIYC3d++1AMK2iGjjF6+2UL3aDRrBNS3FIR8UqEoFjhemBzhgOvipuV43taA
	 F3EHgPX1qpbssYHSvyKknBi3Mq+TZy/4L2FXuLyApjDvsZxrEb9iiPEJJxY5aAlVCK
	 B/cWW6KBVyIBA==
Date: Wed, 5 Jun 2024 21:45:09 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: konrad.dybcio@linaro.org, djakov@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org, 
	dmitry.baryshkov@linaro.org, abel.vesa@linaro.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: x1e80100: Add fastrpc nodes
Message-ID: <wnvet65zg3s6lqnnn5xd4zzx4jwdclbfh3ywy4ut3cal2wmoto@3z3burliivyo>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-5-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604011157.2358019-5-quic_sibis@quicinc.com>

On Tue, Jun 04, 2024 at 06:41:57AM GMT, Sibi Sankar wrote:
> Add fastrpc nodes for ADSP and CDSP on X1E80100 SoC.
> 

This looks pretty unrelated to bwmon, could it not have been sent alone?

Regards,
Bjorn

> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 156 +++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index d86c4d3be126..4edabe0ff592 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -5567,6 +5567,55 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  				label = "lpass";
>  				qcom,remote-pid = <2>;
>  
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "adsp";
> +					qcom,non-secure-domain;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x1003 0x80>,
> +							 <&apps_smmu 0x1063 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +						iommus = <&apps_smmu 0x1004 0x80>,
> +							 <&apps_smmu 0x1064 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;
> +						iommus = <&apps_smmu 0x1005 0x80>,
> +							 <&apps_smmu 0x1065 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@6 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <6>;
> +						iommus = <&apps_smmu 0x1006 0x80>,
> +							 <&apps_smmu 0x1066 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@7 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <7>;
> +						iommus = <&apps_smmu 0x1007 0x80>,
> +							 <&apps_smmu 0x1067 0x0>;
> +						dma-coherent;
> +					};
> +				};
> +
>  				gpr {
>  					compatible = "qcom,gpr";
>  					qcom,glink-channels = "adsp_apps";
> @@ -5656,6 +5705,113 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  
>  				label = "cdsp";
>  				qcom,remote-pid = <5>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "cdsp";
> +					qcom,non-secure-domain;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@1 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <1>;
> +						iommus = <&apps_smmu 0x0c01 0x20>,
> +							 <&apps_smmu 0x0c21 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@2 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <2>;
> +						iommus = <&apps_smmu 0x0c02 0x20>,
> +							 <&apps_smmu 0x0c22 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x0c03 0x20>,
> +							 <&apps_smmu 0x0c23 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +						iommus = <&apps_smmu 0x0c04 0x20>,
> +							 <&apps_smmu 0x0c24 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;
> +						iommus = <&apps_smmu 0x0c05 0x20>,
> +							 <&apps_smmu 0x0c25 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@6 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <6>;
> +						iommus = <&apps_smmu 0x0c06 0x20>,
> +							 <&apps_smmu 0x0c26 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@7 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <7>;
> +						iommus = <&apps_smmu 0x0c07 0x20>,
> +							 <&apps_smmu 0x0c27 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@8 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <8>;
> +						iommus = <&apps_smmu 0x0c08 0x20>,
> +							 <&apps_smmu 0x0c28 0x20>;
> +						dma-coherent;
> +					};
> +
> +					/* note: compute-cb@9 is secure */
> +
> +					compute-cb@10 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <10>;
> +						iommus = <&apps_smmu 0x0c0c 0x20>,
> +							 <&apps_smmu 0x0c2c 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@11 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <11>;
> +						iommus = <&apps_smmu 0x0c0d 0x20>,
> +							 <&apps_smmu 0x0c2d 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@12 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <12>;
> +						iommus = <&apps_smmu 0x0c0e 0x20>,
> +							 <&apps_smmu 0x0c2e 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@13 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <13>;
> +						iommus = <&apps_smmu 0x0c0f 0x20>,
> +							 <&apps_smmu 0x0c2f 0x20>;
> +						dma-coherent;
> +					};
> +				};
>  			};
>  		};
>  	};
> -- 
> 2.34.1
> 

