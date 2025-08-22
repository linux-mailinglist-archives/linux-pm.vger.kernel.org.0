Return-Path: <linux-pm+bounces-32884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05730B30EC2
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 08:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A117D1CE4E1D
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 06:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD32E3B1A;
	Fri, 22 Aug 2025 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dUou/LpX"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280427AC32;
	Fri, 22 Aug 2025 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843729; cv=none; b=Jzcfk8jsUxE+edTDEMCFFXO3pBpM7r+Kch9kiweAhE8d8/Yh1pZS7fWRu2M0Itzq1l/mh3rtGTgUfFhxZfL5pTM+XeONSXeRiVxcSJkb6Vrb3IsB+Mh98RmYDjBd4gUCYlE72I1CC/ExlqXluFuMP/ETZgqBICQxD5r021/8OgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843729; c=relaxed/simple;
	bh=ayqQLuz2t+cV2/mN6Vv7S5ueWn5bRegzJbzeM4HF7pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BUAmNswKO+ZP4LcxCo2Kh2gLK/w/lh5ok6AEMi0FDDoEg9OSgXKw87twccMmky2Ro7WKEjSMLGa72LdgZUsHOs4xZ0LedcEI7ZVnPYHfvrVJU6/3hi0j8Rk9Wcw8j2LO7c6Z6mi0I4N5sADlGrcwhhuNiSSU9bbyhuFHhSWsTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dUou/LpX; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57M6LvPp186577;
	Fri, 22 Aug 2025 01:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755843717;
	bh=9tHPqKKnRlf/2yoYaU51ff9krR9hR2OUkjvBjZR7nbs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dUou/LpX8uNa3HvO0F+Tq/zAfHL4I1JJB3OnLNEzOvy3pP0vqtk3b/PUCshyEVRUr
	 0mlBM704WiDbJ9EgwcbQgn5NCh1oiDVuY+V8xH/I5pCqK2f0SBeo3HVAaUcRxXRZQD
	 dLtKH13IqLeVzdR6B7L/zjmwxk8pVpudZnyWJRsE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57M6Lvxf2699211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 01:21:57 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 01:21:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 01:21:57 -0500
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57M6LpGm3090508;
	Fri, 22 Aug 2025 01:21:52 -0500
Message-ID: <eaf4c015-a9e2-486b-a5ca-f98ce2146866@ti.com>
Date: Fri, 22 Aug 2025 11:51:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add cpufreq and USB support for AM62D2
To: Nishanth Menon <nm@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>
CC: <praneeth@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <s-vadapalli@ti.com>
References: <20250820083331.3412378-1-p-bhagat@ti.com>
 <20250821122741.eqrwystfey7nwvym@outfit>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <20250821122741.eqrwystfey7nwvym@outfit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nishanth and Vignesh,

On 21/08/25 17:57, Nishanth Menon wrote:
> On 14:03-20250820, Paresh Bhagat wrote:
>> This patch series introduces following changes:
>>
>> * Patch 1 fixes the register length in main_pmx/padconfig for AM62D
>>   and AM62A.
>>
>> * Patch 2 enables USB support for AM62D2-EVM by adding pinmux and device
>>   tree nodes.
>>
>> * Patch 3 adds AM62D2 SoC to cpufreq-dt-platdev blacklist so that
>>   cpufreq is handled by the ti-cpufreq driver instead of the
>>   generic cpufreq-dt driver.
>>
>> * Patch 4 extends ti-cpufreq to register AM62D2 SoC support by
>>   reusing the am62a7_soc_data.
>>
>> Boot Logs-
>> https://gist.github.com/paresh-bhagat12/e29d33c3fd92ff17580edf1441ece9f9
>>
>> Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
>> Schematics Link-https://www.ti.com/lit/zip/sprcal5
>>
>> Paresh Bhagat (3):
>>    arm64: dts: ti: k3-am62d2-evm: Enable USB support
>>    cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
>>    cpufreq: ti: Add support for AM62D2
>>
>> Vibhore Vardhan (1):
>>    arm64: dts: ti: k3-am62a-main: Fix pinctrl properties
> Please do not mix things up to maintainers. Please post patches #1,2
> separately to DT maintainers - these do not have any relationship with
> the rest of the driver patches.


Thanks for the review. I will keep patches in separate series for 
further set of patches.

>
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  2 +-
>>   arch/arm64/boot/dts/ti/k3-am62d2-evm.dts  | 21 +++++++++++++++++++++
>>   drivers/cpufreq/cpufreq-dt-platdev.c      |  1 +
>>   drivers/cpufreq/ti-cpufreq.c              |  2 ++
>>   4 files changed, 25 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.34.1
>>

