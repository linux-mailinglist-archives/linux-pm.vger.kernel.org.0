Return-Path: <linux-pm+bounces-14474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044C97CC94
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789B7B21BF9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08A19F467;
	Thu, 19 Sep 2024 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cLtoFE2p"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F13B1B5;
	Thu, 19 Sep 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764049; cv=none; b=QTi9mDQ46RSR7q0MkietZudIkJQAc5W1QU9fuidSxSRM2YZZ1DKfM/exGogA/QG77YhUtQVwjKSW23yp/K+aFpu9cW7r6cNx5JQ226O7dXFwpWY1yES2Gb/g47iHyMMYYZQNsB0jF64SFHuPyArgsT2qjGUVq4GBkx6hT+IXa5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764049; c=relaxed/simple;
	bh=QNOcv/CMuxfBfiANmjteV3CHtE7KYq+48Wt6xmGDN9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U247baQQbo3dtzpT8NqcD+mLzA3vQRRK62oidW066B+/apMzmuLNZuxaFJVooaiBIws3sC+itvNH96kaNcIja/xKJnS577BOxWk+fmDeK3sxruHHRds5Zmr6EJ7yFVkWXGtH3iflSeSYZYROrpirh04zUGMFOqRLARnaXFJzY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cLtoFE2p; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48JGeW0p059001;
	Thu, 19 Sep 2024 11:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726764033;
	bh=2fpT6wCJWXNUMpwERF139t8BpQOhPzewLaWwBI2uOOU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cLtoFE2pv1DbPD1Ptd7KShdz3OrTzYSczYlhRfWxOaKsuQaLQLi1Ene6ZDnSO5pnC
	 eGdPUf53XiyE4Zq8zydjo9W+SGhpbz5Ptc2XtraKWt1rhLZee9NLZ0BdWY4llckU5U
	 Ay15tsWzENubc9hojFqAyFdlRjqqqK8ocwDYk7N8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48JGeWro038062
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 11:40:32 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 11:40:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 11:40:32 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JGeVt9036216;
	Thu, 19 Sep 2024 11:40:31 -0500
Message-ID: <5a54f481-efaa-4719-ac38-b328a6c67762@ti.com>
Date: Thu, 19 Sep 2024 11:40:31 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/6] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon
To: Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20240919082809.174589-1-d-gole@ti.com>
 <20240919082809.174589-6-d-gole@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240919082809.174589-6-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/19/24 3:28 AM, Dhruva Gole wrote:
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
> **DEPENDS ON:** PATCH 6/6: cpufreq: ti-cpufreq: Update the efuse/rev offsets
> 
> Link to v1: https://lore.kernel.org/all/20240902093222.2828345-2-d-gole@ti.com/
> No changes, just combined it as part of Bryan's AM62A and AM62P series
> and sending it all together.
> 
> ---
>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 7 ++++++-
>   arch/arm64/boot/dts/ti/k3-am625.dtsi       | 2 +-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index e0afafd532a5..b2b65e31c7cf 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -10,7 +10,7 @@
>   &cbass_wakeup {
>   	wkup_conf: syscon@43000000 {
>   		bootph-all;
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "simple-bus";

This can be done in a separate patch after this one. You'll also
want to change the syscon@43000000 to bus@43000000, and drop the
"reg = <>;" line at the same time.

Andrew

>   		reg = <0x00 0x43000000 0x00 0x20000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> @@ -22,6 +22,11 @@ chipid: chipid@14 {
>   			reg = <0x14 0x4>;
>   		};
>   
> +		opp_efuse_table: syscon@18 {
> +			compatible = "ti,am62-opp-efuse-table", "syscon";
> +			reg = <0x18 0x4>;
> +		};
> +
>   		cpsw_mac_syscon: ethernet-mac-syscon@200 {
>   			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
>   			reg = <0x200 0x8>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> index c3d1db47dc9f..c249883a8a8d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
> @@ -108,7 +108,7 @@ cpu3: cpu@3 {
>   	a53_opp_table: opp-table {
>   		compatible = "operating-points-v2-ti-cpu";
>   		opp-shared;
> -		syscon = <&wkup_conf>;
> +		syscon = <&opp_efuse_table>;
>   
>   		opp-200000000 {
>   			opp-hz = /bits/ 64 <200000000>;

