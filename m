Return-Path: <linux-pm+bounces-32771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10129B2EE45
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546DF3B2919
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD77126A0A7;
	Thu, 21 Aug 2025 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N7o7JX11"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEC194124;
	Thu, 21 Aug 2025 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757962; cv=none; b=Qus/0DmMZR2Ec5liu4mHAOdDIzwlT6OAmi5zap1r1cOm7vdSeUUGWaM4/H5HN7AOKsTEqdLa7l4J+/8WjclCUy10ENpsem2H5q0rNbT231C2I73ja01jdttbuFbQytzF3B9swo/8bNpbGBdRB7nR+ColVTuVoo2xCF8kYffOuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757962; c=relaxed/simple;
	bh=g5ZZTG++YtW+Mx/htBTVim2O8aJiGeY60cQo4YYNiEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ot5NRcmBmNPVGREjGhf6MKNuo3819R6yC67a9apkpVcSbvB/IVpgxviP46WpW0vTLaSzPNYoEhRYfLT+XPBfC7ccmh5U62Uzk110XNTGYW3nyBkik4wQV68O8Ak6fkffvvpFpgQBJJ7466rs0TKBn8T6ak2DhnAabzWvfewoop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N7o7JX11; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57L6WWkr425991;
	Thu, 21 Aug 2025 01:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755757952;
	bh=PTodzFFWSiXr7fBk1+3Kf+pzQra2IVvODX2WGFM/XDI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=N7o7JX11vIMBLtNwYPs4jBx8cZiyNZ3jGggWH+qCtNf7sji9AJWa8QKE4UHnQ68Dq
	 VfQVS5uAyj+p7sKuAIdgUhT4hHCnSNkOlbLO1p26jCXVPAa/M2ezCrAs+87M6IPs/b
	 LGOmF9/3Ce9Jbjr/BQyMFQP5LIRenNjbAu3pCxZQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57L6WWnZ2336994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 01:32:32 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 01:32:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 01:32:31 -0500
Received: from [172.24.22.46] (lt5cg1457vgj.dhcp.ti.com [172.24.22.46])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57L6WQp01726836;
	Thu, 21 Aug 2025 01:32:26 -0500
Message-ID: <77ed674f-8667-4c51-a2f5-0f8545bdc610@ti.com>
Date: Thu, 21 Aug 2025 12:02:25 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 0/4] Add cpufreq and USB support for AM62D2
To: Paresh Bhagat <p-bhagat@ti.com>, <nm@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
References: <20250820083331.3412378-1-p-bhagat@ti.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250820083331.3412378-1-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 8/20/2025 2:03 PM, Paresh Bhagat wrote:
> This patch series introduces following changes:
> 
> * Patch 1 fixes the register length in main_pmx/padconfig for AM62D
>  and AM62A.
> 
> * Patch 2 enables USB support for AM62D2-EVM by adding pinmux and device
>  tree nodes.
> 
> * Patch 3 adds AM62D2 SoC to cpufreq-dt-platdev blacklist so that
>  cpufreq is handled by the ti-cpufreq driver instead of the
>  generic cpufreq-dt driver.
> 
> * Patch 4 extends ti-cpufreq to register AM62D2 SoC support by
>  reusing the am62a7_soc_data.

Please don't randomly mix patches into single series. Here patches 1/4
and 2/4 have no bearing on cpufreq driver changes in 3/4 and 4/4. They
even go through different trees.

> 
> Boot Logs-
> https://gist.github.com/paresh-bhagat12/e29d33c3fd92ff17580edf1441ece9f9
> 
> Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
> Schematics Link-https://www.ti.com/lit/zip/sprcal5
> 
> Paresh Bhagat (3):
>   arm64: dts: ti: k3-am62d2-evm: Enable USB support
>   cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
>   cpufreq: ti: Add support for AM62D2
> 
> Vibhore Vardhan (1):
>   arm64: dts: ti: k3-am62a-main: Fix pinctrl properties
> 
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  2 +-
>  arch/arm64/boot/dts/ti/k3-am62d2-evm.dts  | 21 +++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c      |  1 +
>  drivers/cpufreq/ti-cpufreq.c              |  2 ++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 


