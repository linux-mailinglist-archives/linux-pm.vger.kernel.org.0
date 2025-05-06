Return-Path: <linux-pm+bounces-26746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED7AACE84
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C61BC05F9
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94327481B6;
	Tue,  6 May 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q0M2fJwz"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAD182D0;
	Tue,  6 May 2025 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561740; cv=none; b=tFbZgznhpbgS1G2v/1oUdFCTyFCpeOylcoS32Oxfhc1svzanzbd5QlaNsxPzsxoBxO+9hiIiozk91lgfMkaIeXRQA9bWMxTC+1Dj0hpyYjsL5J7XuS9pFhIKzXDCdagWAn8wbA4Jyjd9EJ05ODjA1Rgqaj3WvIIOLfWdiKRCyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561740; c=relaxed/simple;
	bh=VFpsjQswqN7WRkOQQiXqntDWdIecEJS9KiXG5Wv2OtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tOBYqu+peP9OdbsrHomgdwr6m1UouGFTLCqCLpoBfr//3xp4jeI+776dBBTTjav8DOtc8ZBUkb/xNy7CpHEbnWk9jMJdpRoqzGTSlolDbRJSsaNFZaVzXSg2DXXO184xuQi90ynQJGB+whawV6+MOJkfitOdqbCoQnG/gaSwM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q0M2fJwz; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546K1g5v609667
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 15:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746561702;
	bh=W42cyLUdol+oUsgXG96Kh1xhxA3DvcRncFoVbahX4AI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Q0M2fJwzd5R5U8NnigZDb+vyIv7sTySh9pvRo9zOOPOrY+RD2VCW+uYI7OhS/cLfN
	 mgonkL2aoWgrOu14yE5+uitN7t+6zFK1TrMJy01vLJgCSLngNSuSgJkfUQIeQ2TjbI
	 7NdvDzYzQw+bvbmE7FZP8yLrToeByKM9ZT30el2o=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546K1gpr110583
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 May 2025 15:01:42 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 15:01:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 15:01:41 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546K1fPh040642;
	Tue, 6 May 2025 15:01:41 -0500
Message-ID: <4e014361-65ec-4b6e-839d-bfeb995262c6@ti.com>
Date: Tue, 6 May 2025 15:01:41 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] PM: TI: AM335x: PM STANDBY fixes
To: Sukrut Bellary <sbellary@baylibre.com>,
        Kevin Hilman
	<khilman@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade
	<andreas@kemnade.info>,
        Roger Quadros <rogerq@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Bajjuri
 Praneeth <praneeth@ti.com>,
        Raghavendra Vignesh <vigneshr@ti.com>, Bin Liu
	<b-liu@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Russell King
	<linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>, Tony Lindgren
	<tony@atomide.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20250318230042.3138542-1-sbellary@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250318230042.3138542-1-sbellary@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Sukrut, Keven, Ulf,

On 3/18/25 6:00 PM, Sukrut Bellary wrote:
> This patch series fixes the Power management issues on TI's am335x soc.
> 
> on AM335x, the wakeup doesn't work in the case of STANDBY.
> 
> 1. Since CM3 PM FW [1](ti-v4.1.y) doesn't enable l4ls clockdomain upon
> wakeup, it fails to wakeup the MPU.
> To fix this, don't turn off the l4ls clk domain in the STANDBY transition
> in MPU.
> 
> 2. Also Per AM335x TRM [2](section 8.1.4.3 Power mode), in case of STANDBY,
> PER domain should be ON. So fix PER power domain handling for
> standby. l4ls is a part of the PER domain.
> 
> Since we are not turning off the l4ls clockdomain on STANDBY in MPU,
> PER power domain would remain ON. But still, explicitly handle this
> to be in sync with the STANDBY requirement.
> 
> 3. On am335x evm[1], UART0 - (UART1-HW) has a wakeup capability.
> Set the wakeup-source property in DT for AM335x.
> 
> 4. Enable PM configs for AM335x.
> 
> [1] https://git.ti.com/cgit/processor-firmware/ti-amx3-cm3-pm-firmware/
> [2] https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
> [3] https://www.ti.com/tool/TMDXEVM3358
> 
> Test log:
> https://gist.github.com/sukrutb/bdbfd1220fe8578a9decf87d0bac6796
> 

Thanks for the patches, Sukrut.

I was able to test this series on am335x EVM, baseline being rc5 next
branch: https://gist.github.com/jmenti/cda1675b5fc5844b6f065376e98026f5

Tested-by: Judith Mendez <jm@ti.com>

regards,
~ Judith

