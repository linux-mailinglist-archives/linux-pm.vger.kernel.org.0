Return-Path: <linux-pm+bounces-9522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63390E056
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 02:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6EB1F230FA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 00:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93424181;
	Wed, 19 Jun 2024 00:02:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288337B
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755346; cv=none; b=lRXl/Kma1rL4HF0Pow4oLTBXlj8xSIprXdM3wMocNZvk/nl6XoZ98aiG+VK0wVv/iLAldGs/8JXHLaz0tN3C7ygbLzbb90dqeWj3SphHTZCWncoBjABjE3hVB7yVauciVutIASJZCZ8Vl6QxXcF8dzgNvecgGMM34xcAHdPI9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755346; c=relaxed/simple;
	bh=R+6FaQSR6Nnrm2BWGpVhIViug0n83gw/N5/k6HFesZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMZlTczWSR+7r2PMwGFEsajbHMO4KCJFhk1O9Oyg5stmfsSyNAME/4MlPSK6OAsyNERW9WU+vhVhkNiA2tagwVL0itgtvQTdl/rKbOjsJadS9qCMd7/Khz86HSWtkuuv2GvQq0P+4PRzyb5JY/9xmy/YZmJvinnW4vfgp7LuJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C3C1DA7;
	Tue, 18 Jun 2024 17:02:49 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD543F64C;
	Tue, 18 Jun 2024 17:02:22 -0700 (PDT)
Date: Wed, 19 Jun 2024 01:00:51 +0100
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
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: rg35xx: Enable DVFS CPU
 frequency scaling
Message-ID: <20240619010051.1bd9f00f@minigeek.lan>
In-Reply-To: <20240607092140.33112-4-ryan@testtoast.com>
References: <20240607092140.33112-1-ryan@testtoast.com>
	<20240607092140.33112-4-ryan@testtoast.com>
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

On Fri,  7 Jun 2024 21:20:35 +1200
Ryan Walklin <ryan@testtoast.com> wrote:

> The Anbernic RG35XX device variants (-2024, -H, -Plus and -SP) are the
> only currently known devices to have an Allwinner H700 SoC. The closely
> related RG28XX also has the H700 but a mainline DT for this device has
> not yet been submitted.
> 
> Include the H616 CPU OPP table in the base device DTS, and increase the
> DCDC1 regulator (vdd-cpu) upper voltage range to 1.16V, allowing the
> CPU to reach 1.5GHz.
> 
> Signed-off-by: Ryan Walklin <ryan@testtoast.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> index ee30584b6ad70..afb49e65859f9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
> @@ -6,7 +6,7 @@
>  /dts-v1/;
>  
>  #include "sun50i-h616.dtsi"
> -
> +#include "sun50i-h616-cpu-opp.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -221,7 +221,7 @@ regulators {
>  			reg_dcdc1: dcdc1 {
>  				regulator-always-on;
>  				regulator-min-microvolt = <900000>;
> -				regulator-max-microvolt = <1100000>;
> +				regulator-max-microvolt = <1160000>;
>  				regulator-name = "vdd-cpu";
>  			};
>  


