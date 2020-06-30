Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55920F433
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 14:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgF3MMZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 08:12:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38242 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387472AbgF3MMZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 08:12:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05UCCMf3089585;
        Tue, 30 Jun 2020 07:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593519142;
        bh=et4T6iPMsRHLVyKKx++mxCxWhvL5/2hFNsxqiU7F2xQ=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=BCSt1Dp5wlonHM8cJwAHBUR9RYY2yDDS9Y7kUxaclNxWrBOyN3rhWS1GzgkOaFB5z
         Z5LqUAaje6TwN/WvFhed+l6Bdmxt7/mfHtWY5khX9x81XHSTkZjboNSAeb5dlnhBnk
         DRM5UM2RXjjihDLigRNTFtYJJI7s6I+KOxUpL+TQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05UCCMZW089782
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 07:12:22 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 30
 Jun 2020 07:12:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 30 Jun 2020 07:12:22 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05UCCLe9022272;
        Tue, 30 Jun 2020 07:12:21 -0500
From:   Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v13 2/4] dt-bindings: power: Convert battery.txt to
 battery.yaml
To:     Rob Herring <robh@kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
CC:     <sre@kernel.org>, <pali@kernel.org>, <afd@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>
References: <20200622191837.9326-1-r-rivera-matos@ti.com>
 <20200622191837.9326-3-r-rivera-matos@ti.com>
 <20200629225630.GA3114703@bogus>
Message-ID: <371c96ae-09b1-4d1b-14b0-f9628b922ce5@ti.com>
Date:   Tue, 30 Jun 2020 07:12:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629225630.GA3114703@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rob

On 6/29/20 5:56 PM, Rob Herring wrote:
> On Mon, Jun 22, 2020 at 02:18:35PM -0500, Ricardo Rivera-Matos wrote:
>> From: Dan Murphy<dmurphy@ti.com>
>>
>> Convert the battery.txt file to yaml and fix up the examples.
>>
>> Signed-off-by: Dan Murphy<dmurphy@ti.com>
>> ---
>>   .../bindings/power/supply/battery.txt         |  83 +----------
>>   .../bindings/power/supply/battery.yaml        | 139 ++++++++++++++++++
>>   2 files changed, 141 insertions(+), 81 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 5e29595edd74..4c5216fcb760 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -1,87 +1,8 @@
>> -Battery Characteristics
>> -
>> -The devicetree battery node provides static battery characteristics.
>> -In smart batteries, these are typically stored in non-volatile memory
>> -on a fuel gauge chip. The battery node should be used where there is
>> -no appropriate non-volatile memory, or it is unprogrammed/incorrect.
>> -
>> -Upstream dts files should not include battery nodes, unless the battery
>> -represented cannot easily be replaced in the system by one of a
>> -different type. This prevents unpredictable, potentially harmful,
>> -behavior should a replacement that changes the battery type occur
>> -without a corresponding update to the dtb.
>> +The contents of this file has been moved to battery.yaml
>>   
>>   Please note that not all charger drivers respect all of the properties.
>>   
>> -Required Properties:
>> - - compatible: Must be "simple-battery"
>> -
>> -Optional Properties:
>>    - over-voltage-threshold-microvolt: battery over-voltage limit
>>    - re-charge-voltage-microvolt: limit to automatically start charging again
> Why are some things not moved?

These were applied recently to the text file on May 8th.  They just 
showed up in the 5.8 kernel.

Not sure if there are any more pending changes for the battery.txt but 
they should be on hold until the yaml is applied.

We will update the yaml

Dan

