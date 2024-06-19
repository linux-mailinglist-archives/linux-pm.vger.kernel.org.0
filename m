Return-Path: <linux-pm+bounces-9521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D380590E055
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 02:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D189D1C212F6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 00:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C5191;
	Wed, 19 Jun 2024 00:02:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E74368
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755332; cv=none; b=aP+1NTuMwCfi6b2bUhc2GmA/Fdu96lF/7z2TGyPntHwLn90dicko3hwndKLShVIOhixUobB68Bh+IwcOv2PVlfrBHBOVvXX3Pt7VOQt5Lkl2GLd7ZAeRF2KXUlwCyVkJd4sNN/+vpw8pyypMJGANnadiAOKFjJfZ3Pz0imsi7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755332; c=relaxed/simple;
	bh=6YKY3m19PlLAmaWZ0MeAFrWFPzXada0HTVkzCKkS3sM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mum1JFVRTgl0Tl6OnOBylK5H8WAT7knHgtOWzhsPnCQrkLpZOoRJC9Y7iOUhKBjFkVSEs0FhLHgfvHm2kAIFoxpbaPkuIKpRJKmvVcxb6VZMXOeOYD2eZQBG9kY9Ed8QKw62r0/55cEdsYr/hbROvjwT8roGK3P2qV7RnOr/otE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D545CDA7;
	Tue, 18 Jun 2024 17:02:33 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FD333F64C;
	Tue, 18 Jun 2024 17:02:06 -0700 (PDT)
Date: Wed, 19 Jun 2024 01:00:35 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Ryan Walklin <ryan@testtoast.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Chris
 Morgan <macroalpha82@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: allwinner: h616: add additional CPU
 OPPs for the H700
Message-ID: <20240619010035.7aa1bd04@minigeek.lan>
In-Reply-To: <20240607092140.33112-3-ryan@testtoast.com>
References: <20240607092140.33112-1-ryan@testtoast.com>
	<20240607092140.33112-3-ryan@testtoast.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 21:20:34 +1200
Ryan Walklin <ryan@testtoast.com> wrote:

Hi,

> The H700 now shows stable operation with the 1.008, 1.032 and 1.512 GHz
> DVFS operating points. The 1.5GHz OPP requires a VDD-CPU of 1.16V,
> obtained from the vendor BSP. This voltage is slightly above the
> recommended operating voltage for the H616 (H700 datasheet not publicly
> available) but well within the absolute maximum of 1.3V.
> 
> Add the additional 1.032 GHz operating point to the H616 CPU-OPP table,
> and enable the 1.008 and 1.512 points for the H700.

This matches the values I had in the previous version of this patch:
 
> Signed-off-by: Ryan Walklin <ryan@testtoast.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 25 +++++++++++++------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> index aca22a7f0191c..dd10aaf472b66 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> @@ -11,7 +11,7 @@ opp-480000000 {
>  			opp-hz = /bits/ 64 <480000000>;
>  			opp-microvolt = <900000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
> -			opp-supported-hw = <0x1f>;
> +			opp-supported-hw = <0x3f>;
>  		};
>  
>  		opp-600000000 {
> @@ -25,7 +25,7 @@ opp-720000000 {
>  			opp-hz = /bits/ 64 <720000000>;
>  			opp-microvolt = <900000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
> -			opp-supported-hw = <0x0d>;
> +			opp-supported-hw = <0x2d>;
>  		};
>  
>  		opp-792000000 {
> @@ -50,8 +50,16 @@ opp-1008000000 {
>  			opp-microvolt-speed2 = <950000>;
>  			opp-microvolt-speed3 = <950000>;
>  			opp-microvolt-speed4 = <1020000>;
> +			opp-microvolt-speed5 = <900000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
> -			opp-supported-hw = <0x1f>;
> +			opp-supported-hw = <0x3f>;
> +		};
> +
> +		opp-1032000000 {
> +			opp-hz = /bits/ 64 <1032000000>;
> +			opp-microvolt = <900000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-supported-hw = <0x20>;
>  		};
>  
>  		opp-1104000000 {
> @@ -59,8 +67,9 @@ opp-1104000000 {
>  			opp-microvolt-speed0 = <1000000>;
>  			opp-microvolt-speed2 = <1000000>;
>  			opp-microvolt-speed3 = <1000000>;
> +			opp-microvolt-speed5 = <950000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
> -			opp-supported-hw = <0x0d>;
> +			opp-supported-hw = <0x2d>;
>  		};
>  
>  		opp-1200000000 {
> @@ -70,8 +79,9 @@ opp-1200000000 {
>  			opp-microvolt-speed2 = <1050000>;
>  			opp-microvolt-speed3 = <1050000>;
>  			opp-microvolt-speed4 = <1100000>;
> +			opp-microvolt-speed5 = <1020000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
> -			opp-supported-hw = <0x1f>;
> +			opp-supported-hw = <0x3f>;
>  		};
>  
>  		opp-1320000000 {
> @@ -85,15 +95,16 @@ opp-1416000000 {
>  			opp-hz = /bits/ 64 <1416000000>;
>  			opp-microvolt = <1100000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
> -			opp-supported-hw = <0x0d>;
> +			opp-supported-hw = <0x2d>;
>  		};
>  
>  		opp-1512000000 {
>  			opp-hz = /bits/ 64 <1512000000>;
>  			opp-microvolt-speed1 = <1100000>;
>  			opp-microvolt-speed3 = <1100000>;
> +			opp-microvolt-speed5 = <1160000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
> -			opp-supported-hw = <0x0a>;
> +			opp-supported-hw = <0x2a>;
>  		};
>  	};
>  };


