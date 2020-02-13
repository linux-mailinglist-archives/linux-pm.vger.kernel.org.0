Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABCD15BD64
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 12:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgBMLKL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 06:10:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54294 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMLKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 06:10:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01DBA1Bc096628;
        Thu, 13 Feb 2020 05:10:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581592201;
        bh=a0YM8nWmHENhFyW+m7rbVJdEC+tUi+4yZir+iRtz1DI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aWl6b8LPDijCV7/S4YmUWyLvdOjp3mbFvawG6llddtboFv0SmmncLLU3fgzhwlhV+
         rQNdpu5EWIhVdVoZm3KpqQkJN+wwWCqjVWiQeDiwx7RJwb2qaR9LRGfUhdW51dn/Qv
         Fq4uyL5fsQbLOEdhAeaTvFrDli9yB2x8dvsVIREU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01DBA0b9047012;
        Thu, 13 Feb 2020 05:10:00 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 13
 Feb 2020 05:10:00 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 13 Feb 2020 05:10:00 -0600
Received: from [10.24.69.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01DB9uUm069657;
        Thu, 13 Feb 2020 05:09:57 -0600
Subject: Re: [PATCH 3/4] arm64: dts: ti: am654: Add thermal zones
To:     Lokesh Vutla <lokeshvutla@ti.com>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <amit.kucheria@verdurent.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200213102440.20539-1-j-keerthy@ti.com>
 <20200213102440.20539-4-j-keerthy@ti.com>
 <0d0a5c81-3b85-afbd-7fd6-8c2a6432ec86@ti.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <2c8bc161-8a2a-f8ef-3b7b-99ced7f90478@ti.com>
Date:   Thu, 13 Feb 2020 16:40:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0d0a5c81-3b85-afbd-7fd6-8c2a6432ec86@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 13/02/20 4:31 pm, Lokesh Vutla wrote:
> 
> 
> On 13/02/20 3:54 PM, Keerthy wrote:
>> The am654 SoC has three thermal zones namely MPU0, MPU1 and MCU
>> zones
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   .../boot/dts/ti/am654-industrial-thermal.dtsi | 45 +++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi
>> new file mode 100644
>> index 000000000000..cdc3d40c3f60
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi
> 
> Can you rename file to k3-am654-industrial-thermal.dtsi. This will be consistent
> with other k3-am654 dt files.

yes. I will rename this to k3-* in v2.

Thanks,
Keerthy

> 
> Thanks and regards,
> Lokesh
> 
