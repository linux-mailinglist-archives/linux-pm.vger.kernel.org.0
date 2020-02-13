Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3DA15BD45
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 12:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgBMLCX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 06:02:23 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41128 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgBMLCW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 06:02:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01DB2EFf111932;
        Thu, 13 Feb 2020 05:02:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581591734;
        bh=28ZV+G9aiHL8+0UPcgwBKCixdQrHOAJ3kWPdgROidOE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hWw+rIQmsQW7yzhJKnbXQSX2a5PodRgs4kzltZJABZ9Ene1GCbCFpIO/cFW02aCgT
         Gcqqm0xfUJvajrap++QLGZH9CjCaNT8uEwzDIjSZlFMHuh1w7hvNnMitXiVcv/O6Xl
         ofM1IbfVq4FR0vuTe5KJv+L2EPbIYQl1IWStMj2w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01DB2DjF000944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Feb 2020 05:02:13 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 13
 Feb 2020 05:02:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 13 Feb 2020 05:02:13 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01DB29Mp077470;
        Thu, 13 Feb 2020 05:02:10 -0600
Subject: Re: [PATCH 3/4] arm64: dts: ti: am654: Add thermal zones
To:     Keerthy <j-keerthy@ti.com>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <amit.kucheria@verdurent.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200213102440.20539-1-j-keerthy@ti.com>
 <20200213102440.20539-4-j-keerthy@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <0d0a5c81-3b85-afbd-7fd6-8c2a6432ec86@ti.com>
Date:   Thu, 13 Feb 2020 16:31:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200213102440.20539-4-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 13/02/20 3:54 PM, Keerthy wrote:
> The am654 SoC has three thermal zones namely MPU0, MPU1 and MCU
> zones
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../boot/dts/ti/am654-industrial-thermal.dtsi | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi
> new file mode 100644
> index 000000000000..cdc3d40c3f60
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi

Can you rename file to k3-am654-industrial-thermal.dtsi. This will be consistent
with other k3-am654 dt files.

Thanks and regards,
Lokesh

