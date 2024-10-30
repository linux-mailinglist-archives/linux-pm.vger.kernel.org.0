Return-Path: <linux-pm+bounces-16693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2399F9B5B74
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD58F282948
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 05:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2D1CF7DE;
	Wed, 30 Oct 2024 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OIOBXc8o"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4062C95;
	Wed, 30 Oct 2024 05:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267254; cv=none; b=BxqvNcULGYuL03LC4pDGCGKrBHzggBUHz0FHKrt6dIL23KPnN8VN0BgFINdEmTKqoO3OY5CfIOTEOhF73Lod4f+UvGpNuDEraR5B83c131N0d6L0pC0zs9HkrK6MvYSzVG6xygmCqAIkCBUgAEfyGaqUP6dUPjnEqusVlnH2j94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267254; c=relaxed/simple;
	bh=xXoJv673ldiAszf2rv18SoHscyJGnO6yAY6w5laLGnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aZnKhRe6AjyY4/d8simy99VDMHLGEH4bPQwUMdreE4pAAquADNq46OdY7h4X4I0iLu0tfwbiI7rw9Xm1NxiGF5mHokBFBJJCfe5GyTPZSAHbJ3PQ1xwpt2f0m87B+HF3neWPQwKNFFug+elQZfDf5d+wSsGmdQZMaqiyw3mZTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OIOBXc8o; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U5lKYb057168;
	Wed, 30 Oct 2024 00:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730267240;
	bh=UOJjWaLcmM4lSFeH+CtGHWFIWQwi5J9hsnjD3Fvku4o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OIOBXc8oHom8M8sadW03tMl1UQU/NwFLaDuBPlJGOMIaQDieLYYBvsrL4o5UY9TD5
	 RR/1jEmkJ22IrECYyrHPOBqepZK+u4U2eHXTwsmFHVVURuFzLTFLWeSlI66hb3m5gI
	 GmUQb2EBaav98pCyTpBMwZCWwgBwAbnBapBBE3lA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U5lKSW124517;
	Wed, 30 Oct 2024 00:47:20 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Oct 2024 00:47:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Oct 2024 00:47:19 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U5lGpb008304;
	Wed, 30 Oct 2024 00:47:17 -0500
Message-ID: <e3c4f895-71a1-481f-86d4-dfab1b61715c@ti.com>
Date: Wed, 30 Oct 2024 11:17:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon
To: Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, Bryan
 Brattlof <bb@ti.com>,
        Wadim Egorov <w.egorov@phytec.de>
References: <20241030044553.3225383-1-d-gole@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20241030044553.3225383-1-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi

On 30/10/24 10:15, Dhruva Gole wrote:
> Add another entry in the wkup_conf for the syscon node, and then use
> that for the syscon in opp-table.
> 
> Marking entire wkup_conf as "syscon", "simple-mfd" is wrong and needs to
> be addressed similar to how other child-nodes in wkup_conf are implemented
> in the same file.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Since the driver fixes for ti-cpufreq.c have made it in -next [1],
> The DT fixes for SK-AM62x can be supported with support for legacy
> style DT as well. This has been tested on SK-AM62x [2]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/cpufreq/ti-cpufreq.c?id=1724ae88efcbcd0daeb203ffeb4a2c0e59f2ddf7
> [2] https://gist.github.com/DhruvaG2000/40b80cc04a9ac90c86445d6e67ece4cb
> 
> Changelog:
> 
> Changes in v2:
> - Deleted PATCH to Make the AM625 efuse_offset 0, because with [1] we no
>   longer break backward compatibility and hence need to preserve the old
>   offset.
> - Link to v1:
>   https://lore.kernel.org/linux-arm-kernel/20240902093222.2828345-3-d-gole@ti.com/
> 
> ---
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 7 ++++++-
>  arch/arm64/boot/dts/ti/k3-am625.dtsi       | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index e0afafd532a5..b2b65e31c7cf 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -10,7 +10,7 @@
>  &cbass_wakeup {
>  	wkup_conf: syscon@43000000 {

Now that the compatible is updated, this needs to be bus@addr
dtbs_check should catch such errors.

>  		bootph-all;
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "simple-bus";

Did you also check U-Boot and make sure no regression/update needed?

>  		reg = <0x00 0x43000000 0x00 0x20000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -22,6 +22,11 @@ chipid: chipid@14 {
>  			reg = <0x14 0x4>;
>  		};
>  
> +		opp_efuse_table: syscon@18 {
> +			compatible = "ti,am62-opp-efuse-table", "syscon";
> +			reg = <0x18 0x4>;
> +		};
> +
>  		cpsw_mac_syscon: ethernet-mac-syscon@200 {
>  			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>  			reg = <0x200 0x8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> index c3d1db47dc9f..c249883a8a8d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> @@ -108,7 +108,7 @@ cpu3: cpu@3 {
>  	a53_opp_table: opp-table {
>  		compatible = "operating-points-v2-ti-cpu";
>  		opp-shared;
> -		syscon = <&wkup_conf>;
> +		syscon = <&opp_efuse_table>;
>  
>  		opp-200000000 {
>  			opp-hz = /bits/ 64 <200000000>;
> 
> base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d

-- 
Regards
Vignesh

