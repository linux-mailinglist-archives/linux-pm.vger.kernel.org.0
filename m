Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4805F1BEE73
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 05:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgD3DAW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 23:00:22 -0400
Received: from mx.socionext.com ([202.248.49.38]:41969 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3DAV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 23:00:21 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Apr 2020 12:00:19 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id F3D2D60057;
        Thu, 30 Apr 2020 12:00:19 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 30 Apr 2020 12:00:19 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id CE2EF40362;
        Thu, 30 Apr 2020 12:00:19 +0900 (JST)
Received: from [10.212.23.30] (unknown [10.212.23.30])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 50E9F120498;
        Thu, 30 Apr 2020 12:00:19 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: thermal: Convert UniPhier thermal monitor to
 json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1587013935-21760-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20200428162055.GA27628@bogus>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <077715ad-f327-a39f-3702-d06d4010d20b@socionext.com>
Date:   Thu, 30 Apr 2020 12:00:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428162055.GA27628@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 2020/04/29 1:20, Rob Herring wrote:
> On Thu, Apr 16, 2020 at 02:12:15PM +0900, Kunihiko Hayashi wrote:
>> Convert the UniPhier thermal monitor binding to DT schema format.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../thermal/socionext,uniphier-thermal.yaml        | 57 +++++++++++++++++++
>>   .../bindings/thermal/uniphier-thermal.txt          | 65 ----------------------
>>   2 files changed, 57 insertions(+), 65 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
>> new file mode 100644
>> index 0000000..bdddc5b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/socionext,uniphier-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier thermal monitor
>> +
>> +description: |
>> +  This describes the devicetree bindings for thermal monitor supported by
>> +  PVT(Process, Voltage and Temperature) monitoring unit implemented on
>> +  Socionext UniPhier SoCs.
>> +
>> +maintainers:
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - socionext,uniphier-pxs2-thermal
>> +      - socionext,uniphier-ld20-thermal
>> +      - socionext,uniphier-pxs3-thermal
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  "#thermal-sensor-cells":
>> +    const: 0
>> +
>> +  socionext,tmod-calibration:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      A pair of calibrated values referred from PVT, in case that the values
>> +      aren't set on SoC, like a reference board.
> 
> So?:
> 
> maxItems: 2
Okay, I'll add that in v2.

Thank you,

---
Best Regards
Kunihiko Hayashi
