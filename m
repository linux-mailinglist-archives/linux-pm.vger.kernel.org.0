Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619622F760A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 10:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbhAOJ5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 04:57:50 -0500
Received: from comms.puri.sm ([159.203.221.185]:39662 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbhAOJ5t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 04:57:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D2699E019A;
        Fri, 15 Jan 2021 01:57:09 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cRSiXQdmOZD0; Fri, 15 Jan 2021 01:57:09 -0800 (PST)
Subject: Re: [PATCH v4 4/5] arm64: dts: imx8mq: Add interconnect for lcdif
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
 <20210107121754.3295-5-martin.kepplinger@puri.sm>
 <20210115094738.GL28365@dragon>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Message-ID: <71f61d0b-b09e-84e9-dd6e-77b89b09ba42@puri.sm>
Date:   Fri, 15 Jan 2021 10:57:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210115094738.GL28365@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 15.01.21 10:47, Shawn Guo wrote:
> On Thu, Jan 07, 2021 at 01:17:53PM +0100, Martin Kepplinger wrote:
>> Add interconnect ports for lcdif to set bus capabilities.
>>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> index 89e7de2e7f7a..9300be8c9b53 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> @@ -11,6 +11,7 @@
>>   #include "dt-bindings/input/input.h"
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/thermal/thermal.h>
>> +#include <dt-bindings/interconnect/imx8mq.h>
>>   #include "imx8mq-pinfunc.h"
>>   
>>   / {
>> @@ -522,6 +523,8 @@
>>   						  <&clk IMX8MQ_VIDEO_PLL1>,
>>   						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
>>   				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
>> +				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
>> +				interconnect-names = "dram";
> 
> Hmm, two interconnect phandles but only one name?
> 

Well it's one interconnect path that would more accurately be named 
"lcdif-dram" if that's what you mean. I removed "lcdif-" because it's 
the lcdif node, but maybe we should name it lcdif-dram after all. at 
least that's how others describe it.

                               martin
