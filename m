Return-Path: <linux-pm+bounces-23834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B13A5BE42
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883DF1896172
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C412505D4;
	Tue, 11 Mar 2025 10:53:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CBB24EF8E;
	Tue, 11 Mar 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690390; cv=none; b=MTPASQFGkQPuKCsPraQZDZB/f0Hwc9A9n/ku5BLCQHc/kLyfzYXkA7EDXPFzuBFmC9PUrUtj1wjQte2NHJpVjXoj0oMGrgW6Slv2oC7TTFAFv4OJk8q6OHij2ojhuyS1HMclNTei0FJYnSnEkG8HasV5lSs46JjHZVT2D8ZoPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690390; c=relaxed/simple;
	bh=RUjAfsKxlpnDn5k+IQNu6N7Ia574OxtzAeRXK9rEGak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y96QaL+h8wts4kC2aNP/hug5WC76zLP7XyXA3BsrDsmOu6K5XuEHO6Pwr7RHRAsVfsbCsHawU4+yJYHpDlEQSkJ3iAm06gH2cWW2vBL2cbp/nfzzzCV2CIT4E1Hj7Exwp8cWKT3Zxsk7YHUJMxf/WP46kYLTqevUFku3ElgsZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D4061762;
	Tue, 11 Mar 2025 03:53:19 -0700 (PDT)
Received: from [10.57.67.14] (unknown [10.57.67.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2F743F673;
	Tue, 11 Mar 2025 03:53:04 -0700 (PDT)
Message-ID: <9b44d0ff-b28f-4d79-ad7b-b452db1db87a@arm.com>
Date: Tue, 11 Mar 2025 10:53:02 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] arm64: dts: renesas: r9a09g047: Add thermal
 hotplug trip point
To: John Madieu <john.madieu.xa@bp.renesas.com>, geert+renesas@glider.be,
 niklas.soderlund+renesas@ragnatech.se, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com, claudiu.beznea.uj@bp.renesas.com,
 devicetree@vger.kernel.org, john.madieu@gmail.com, rui.zhang@intel.com,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 biju.das.jz@bp.renesas.com, linux-pm@vger.kernel.org
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
 <20250309121324.29633-4-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250309121324.29633-4-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/9/25 12:13, John Madieu wrote:
> Add CPU hotplug trip point to shutdown CPU1 and CPU2 when exceeding 110°C.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> index 93b57d7ad7b9..06bd394582e2 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> @@ -533,6 +533,13 @@ map0 {
>  							 <&cpu2 0 3>, <&cpu3 0 3>;
>  					contribution = <1024>;
>  				};
> +
> +				map1 {
> +					trip = <&trip_emergency>;
> +					cooling-device = <&cpu1 0 1>, <&cpu2 0 1>;
> +					contribution = <1024>;
> +				};
> +
>  			};
>  
>  			trips {
> @@ -542,6 +549,12 @@ target: trip-point {
>  					type = "passive";
>  				};
>  
> +				trip_emergency: emergency {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "plug";
> +				};
> +
>  				sensor_crit: sensor-crit {
>  					temperature = <120000>;
>  					hysteresis = <1000>;


Are there no other cooling methods?
How does it compare to idle inject?

Furthermore, couldn't the offlining of some CPUs lead to the rest being
operated at much higher OPPs therefore the overall power increase, too?
(Without having looked at if this is a possibility for this particular
SoC.)
Some numbers would be helpful IMO.

