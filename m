Return-Path: <linux-pm+bounces-40155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2500CF018B
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 16:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6263130102AC
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1A30DEC4;
	Sat,  3 Jan 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaZDZ9ni"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E691C3BF7;
	Sat,  3 Jan 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767453291; cv=none; b=uFKsU00EI8QMwc6VRftk+R0+0SNI1DaeuWeas+RPCEcspJ8H/wNIlfRaswLDfa4/oz21Q5JzeQG+Qi1+a6QDqBjFYac3pUOFOte/n112M00bibtBiAtvv6VaYDUzdGM7EQ8vpMGWwjhC172FUy9CV2yVYOP0JlJhH/LHZYUTBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767453291; c=relaxed/simple;
	bh=0Se9Wms268gipgdn5T3DT8CBayB8NdHclzCAX+jZPcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/8/B/GKpYcqOPYurkzI5d/tMcFlzDI3DvsPuWIjL6b9EnzRUGh+A4dgPUgMRKZbT5EiR6vCTvbA3Az9tTKLMeyCrAcoWgbVvSeqb/8Ss9X4Pk9B+demAgQXsHfPL8OyaPrCRY08GgzazF0NCy/2kdqU3shCoHFjlElvz4iXCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaZDZ9ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8150BC113D0;
	Sat,  3 Jan 2026 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767453291;
	bh=0Se9Wms268gipgdn5T3DT8CBayB8NdHclzCAX+jZPcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaZDZ9niZfTQV8g77HZkAZc782jbORvMPCuxiK3+9PzXmFKp3F+UzER+9rjbGP58/
	 GB3sc4Kx0eSQuqZF91eDXHHlV1hW3et3Gge+vHTV3PxcByhnJrbVAhst09LJsNN8XC
	 uDuPr/pDWK6X4jFxNz91Ri+xJzfiPxbA62T9e9NPGcB23pR6nmKDbPfpZSjhw6Cah/
	 pFwwC1+/cWNwVlJBnn+Rwi5ymNtadJPWKu+ybCiglL7IPFWKxblaw7bQ8UaqOh1DLZ
	 Gx6l53Nbt3MLsXLEaZyrhhq0rtEcDJAjQOZG0cxDUwM7R7DurBsSajcsnXhbyek5JM
	 hhXer382RDEqA==
Date: Sat, 3 Jan 2026 09:14:47 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org, amitk@kernel.org, 
	mani@kernel.org, casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 7/8] arm64: dts: qcom: Enable cdsp qmi tmd devices for
 kodiak
Message-ID: <qi6godspytwc3ubusbggsliguwejs4jpa5oaqvmyo3dpzedayy@nf74ffmv267h>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-8-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223123227.1317244-8-gaurav.kohli@oss.qualcomm.com>

On Tue, Dec 23, 2025 at 06:02:26PM +0530, Gaurav Kohli wrote:
> Enable cdsp cooling devices and cooling map bindings
> for cdsp.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index c2ccbb67f800..03c1cef910a9 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -4780,6 +4780,14 @@ compute-cb@14 {
>  					};
>  				};
>  			};
> +
> +			cooling {
> +				compatible = "qcom,qmi-cooling-cdsp";
> +					cdsp_sw: cdsp_sw {
> +						label = "cdsp_sw";
> +						#cooling-cells = <2>;
> +					};
> +			};
>  		};
>  
>  		usb_1: usb@a600000 {
> @@ -7587,12 +7595,26 @@ nspss0_alert0: trip-point0 {
>  					type = "hot";
>  				};
>  
> +				nspss0_alert1: trip-point1 {
> +					temperature = <100000>;

As with the previous patch, I want this number to be motivated in the
commit message.

Regards,
Bjorn

> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
>  				nspss0_crit: nspss0-crit {
>  					temperature = <110000>;
>  					hysteresis = <0>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&nspss0_alert1>;
> +					cooling-device = <&cdsp_sw
> +							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		nspss1-thermal {
> @@ -7605,12 +7627,26 @@ nspss1_alert0: trip-point0 {
>  					type = "hot";
>  				};
>  
> +				nspss1_alert1: trip-point1 {
> +					temperature = <100000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
>  				nspss1_crit: nspss1-crit {
>  					temperature = <110000>;
>  					hysteresis = <0>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&nspss1_alert1>;
> +					cooling-device = <&cdsp_sw
> +							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		video-thermal {
> -- 
> 2.34.1
> 

