Return-Path: <linux-pm+bounces-40154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3159CF0182
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 16:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C8B63015846
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6889730DEC6;
	Sat,  3 Jan 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ2o1Y60"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321AB1C3BF7;
	Sat,  3 Jan 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767453242; cv=none; b=U10Xq4szjqw9/aoYDmDh3+qJRTNCcCLC8Fyow+ob4cH8e21ijaMtCDnwY+Z6os+BypawzaFT7Alg9UM+GU/L0pYHwQ2W/6YsPncxS+DdAVdKwIjm28M2VnuNxL9I8fcbDsxBJXiTmOl/3TyfrdI+j1rgli5CswSwNU5TGjJs7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767453242; c=relaxed/simple;
	bh=Yd4tC3CJrz0W4J4gNCgOxcW+/mpQJ6pNSU0StbZEnX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1xjxx5k3s0ENUlXLZ5x2659XCypeyGIOCEs+JzNnRabhmEXmJvmhaavbL95aP7XKkRQIe+ECMqDT6xt63s8k453DiBgKmwjQXshcFmAf+kIMtNkLHtSLwH9Z9aQQoT99W+IZdQuWnyj4to2TpiRo/EikkpqXORVesEGvBD4rnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ2o1Y60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9897AC113D0;
	Sat,  3 Jan 2026 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767453241;
	bh=Yd4tC3CJrz0W4J4gNCgOxcW+/mpQJ6pNSU0StbZEnX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQ2o1Y60+ULmtW3dt1NpLanU5Ax5wz0P0AZ6CLBOaBXasBOCrxTVHOWCCmBUg+o7t
	 lmktL+sgpWlBbNX8AHJlate8hoJJZ2KmHKMNDEai6S3i7V2o7DlrHOVvnji/IpZOme
	 aHk814YrC+h98E3QUp0knKn3gEB36mSJOUvJnIcwcdAhThSaHin50VRakxaOlFkDsS
	 9Xt/2dSo411kFXb8v6rsJE5NLCqTCWo4sIcQhVWv8ILh7K++0Y3trp6W3wQJqFL86+
	 JVrosmh6QQ2XDk72AoHG1uGi8sZQqhj0+47szob0KC0kCTHZ1GRYeq5vM004uEmvTl
	 +bZ2xeA5PDXEg==
Date: Sat, 3 Jan 2026 09:13:57 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org, amitk@kernel.org, 
	mani@kernel.org, casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 6/8] arm64: dts: qcom: Enable cdsp qmi tmd devices for
 talos
Message-ID: <cnihk2656pi2qpag3gchf7csfkcj6otkwemcnb5cqo62cymtzx@23hjt6pjjhpx>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-7-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223123227.1317244-7-gaurav.kohli@oss.qualcomm.com>

On Tue, Dec 23, 2025 at 06:02:25PM +0530, Gaurav Kohli wrote:
> Enable cdsp cooling devices and thermal zone cooling map bindings
> for cdsp.

This is the first time we're seeing this in a DeviceTree file, so I want
a proper problem description of what it is, why it is. As described in:
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/talos.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
> index 95d26e313622..61faea81c263 100644
> --- a/arch/arm64/boot/dts/qcom/talos.dtsi
> +++ b/arch/arm64/boot/dts/qcom/talos.dtsi
> @@ -18,6 +18,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -3550,6 +3551,14 @@ compute-cb@6 {
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
>  		pmu@90b6300 {
> @@ -4721,12 +4730,26 @@ q6-hvx-thermal {
>  			thermal-sensors = <&tsens0 10>;
>  
>  			trips {
> +				q6_hvx_alert0: trip-point0 {
> +					temperature = <105000>;

Perhaps my coffee hasn't kicked in this morning, but doesn't this say
that we should start throttle at 105C? Isn't that quite a bit above the
point where the OSM/EPSS is starving the apps CPUs? Shouldn't it be the
other way around? What does this cooling device actually do?

Regards,
Bjorn

> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
>  				q6-hvx-critical {
>  					temperature = <115000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&q6_hvx_alert0>;
> +					cooling-device = <&cdsp_sw
> +							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		mdm-core-thermal {
> -- 
> 2.34.1
> 

