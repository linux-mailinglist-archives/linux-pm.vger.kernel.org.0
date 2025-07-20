Return-Path: <linux-pm+bounces-31108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03CB0B35E
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 05:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D84F3C0E3D
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857E19049B;
	Sun, 20 Jul 2025 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUW4yjVK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8617BA5;
	Sun, 20 Jul 2025 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752982656; cv=none; b=sSkI9j/KfPAOQYA69PnKHl+stuZiDWxA+ypLnEda6iIviNED5Uz5OVlx8tqa3Oc/yeYpzzPOJafJ1Grgj65ixRaH86I1OCc133BaBbHTx9ED/F2FEUsOhyEaOkxUqMIuJjvy5GBswV8k2GGpyv/PWeRtAIZ5HBRo/4cISO7iEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752982656; c=relaxed/simple;
	bh=nWHAJnZ/9n5OkhKq8kjuGkijCr2cH4E8GTWk/xLpZWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBrHwiIYSQAhH8g6rafck9uVq9nBm30uljn6bd/7Pulx25HnSSC5zFMo8LtVA4okk7Q6aYekG2H5xm4SXOSKUrOai9vYKIW8d5kzBa1wEqkxEXLUGcOc7WHcSUVnkoITkA9tQd9MypKMaNkNOtfDNM7aZZjbZHSIQUpiHNkf6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUW4yjVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07825C4CEF4;
	Sun, 20 Jul 2025 03:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752982655;
	bh=nWHAJnZ/9n5OkhKq8kjuGkijCr2cH4E8GTWk/xLpZWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUW4yjVK/nHwj97j+zwKP3Ud4OqQl2TQngzR0+N0rSKaz7zVohz/zO3X/3U1eeuyH
	 52M/86WWrv1eUgG5hJb7hVOIMy+lFlo3HxswEL+dO0tUfavGJdPvAhrTljQbXiR2lh
	 WJvnnzh6DCYM2Wrwx73SOi+FPu1z9NVXV0TABskbYc3diS27d5Pmrik+ANfxVmKSqU
	 L1TP110I1+LwxGpU9R/bX5V8+LbzvVkHPnYMXPoSL+D3eAbNnDvmRXBT9ELiMeoWyL
	 Ru/mu//nof5fLHy7tONcmRVPQsCkylzXemlnxCJ2lXgZ0OLU57l1c8B3knrDJS15QX
	 2IJzKgyOV2aRg==
Date: Sat, 19 Jul 2025 22:37:33 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/8] ARM: dts: qcom: dts: switch to RPMPD_* indices
Message-ID: <oa4ojqjkoxtunwtlbqefdbf6u2nmwybolyuzqdzgxojrao4dr5@yjykyivlck3o>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
 <20250718-rework-rpmhpd-rpmpd-v1-6-eedca108e540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-6-eedca108e540@oss.qualcomm.com>

On Fri, Jul 18, 2025 at 07:13:44PM +0300, Dmitry Baryshkov wrote:
> Use generic RPMPD_* defines for power domain instead of using
> platform-specific defines.
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
> index 51a7a3fb36d88eeb8dbccefbab672aceb1e46428..bcf14a3b13a1b4b3455ef4069df2f3d9c5c7f9ff 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
> @@ -959,7 +959,7 @@ modem: remoteproc@fc880000 {
>  			resets = <&gcc GCC_MSS_RESTART>;
>  			reset-names = "mss_restart";
>  
> -			power-domains = <&rpmpd MSM8226_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  			power-domain-names = "cx";
>  
>  			qcom,ext-bhs-reg = <&tcsr_regs_1 0x194>;
> @@ -1372,7 +1372,7 @@ adsp: remoteproc@fe200000 {
>  					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>  			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
>  
> -			power-domains = <&rpmpd MSM8226_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  			power-domain-names = "cx";
>  
>  			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
> 
> -- 
> 2.39.5
> 

