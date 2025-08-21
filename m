Return-Path: <linux-pm+bounces-32772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB4B2EE4A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2C27A6733
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8EC274671;
	Thu, 21 Aug 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AKiexg6G"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3460225D7;
	Thu, 21 Aug 2025 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758130; cv=none; b=ZzmRuisaR6XRIuQDne8xU3RwcV97l2FGm3fe0InMGmMaumOMzrJGGziAdPLZ8vHrhscg378gsUjcEVyTzGe1LEn7etf5wwhWNYe61KpBE2l0TH3ouAWyWg0lcnoKyofv8MrKPwXDb8axjDf2eku4bkfoeO8SxgCxapBGoel7jfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758130; c=relaxed/simple;
	bh=yg6iM/k2tZyqmputv5R0ux+fBNZNIhYMWub4ssDcX98=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jzv5CbBzy7m03e3KoyoF2LCGV47zM2Sw7MRmE+hhLl1RJZk6x+vr49k4cDOh+aYYmjOHzCC9vozQTReybRiVHV/bPjR/12g/N01LrtE4EurWDdHYWM/fd8xQMTeQ0Jgjxal2K0Rk+4DPPAZVmq4ArT3OhB6vPD4aJvD/YCLQYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AKiexg6G; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57L6ZKhs424954;
	Thu, 21 Aug 2025 01:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755758120;
	bh=6jW0I3Wbl8wn0bXM4aIILiaO/4XtSs7hgp8Mh4FtNMw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AKiexg6G2j9oHg5OJBrd6S/WlePzkF8jrBG8qLeipV91odbZSahg2wDCNHleJgGI2
	 kF/zPDpH96iSPFZXWwUZt5wYKB98EepNXCRAhlXLrfEsVE8pUq7e2hgnos7PXW+8sf
	 YqzPEDblXOR7u7T3i14IX8YelPZ6r+2Ck7gOYeqg=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57L6ZK8k2338138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 01:35:20 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 01:35:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 01:35:19 -0500
Received: from [172.24.22.46] (lt5cg1457vgj.dhcp.ti.com [172.24.22.46])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57L6ZEA71729977;
	Thu, 21 Aug 2025 01:35:15 -0500
Message-ID: <24d4c528-57c9-45ee-aac4-dec3cc4cbae6@ti.com>
Date: Thu, 21 Aug 2025 12:05:14 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-am62a-main: Fix pinctrl properties
To: Paresh Bhagat <p-bhagat@ti.com>, <nm@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
References: <20250820083331.3412378-1-p-bhagat@ti.com>
 <20250820083331.3412378-2-p-bhagat@ti.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250820083331.3412378-2-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 8/20/2025 2:03 PM, Paresh Bhagat wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
> Correct reg length to match end address - start address for main
> PADCFG registers.
> 

Needs a Fixes tag and Cc stable tag. Read [1]

Please add a link to the documentation to support your claim.

> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index 9cad79d7bbc1..260279702c01 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -267,7 +267,7 @@ secure_proxy_sa3: mailbox@43600000 {
>  
>  	main_pmx0: pinctrl@f4000 {
>  		compatible = "pinctrl-single";
> -		reg = <0x00 0xf4000 0x00 0x2ac>;
> +		reg = <0x00 0xf4000 0x00 0x25c>;
>  		#pinctrl-cells = <1>;
>  		pinctrl-single,register-width = <32>;
>  		pinctrl-single,function-mask = <0xffffffff>;


[1] https://docs.kernel.org/process/submitting-patches.html

