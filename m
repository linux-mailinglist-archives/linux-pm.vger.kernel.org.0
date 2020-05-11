Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7781CDF1B
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgEKPcp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 11:32:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55100 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgEKPcp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 11:32:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04BFWh5a037261;
        Mon, 11 May 2020 10:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589211163;
        bh=b0MUfp5nG5bVQq6N28sCwmBCyU7Qu62G3MroX7jZW1A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pJ1ZqtF/eXM3gSMNqPo+YfoVDW0f8EkRezgtFk9tmCZGwkYeTXa+1wEK2fXzhGOyt
         PyicbZNQ+Qljn/qcLd68U6MsWLLDThwO9TAx3kC+AcePo1UEeNxu4r9uaWPDwVcIMd
         MmpjUpynOo2a80CiFTvNrCEzEyWVmTIqbO9FQl5w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04BFWh3M104455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 10:32:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 May 2020 10:32:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 May 2020 10:32:43 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04BFWg4V035089;
        Mon, 11 May 2020 10:32:43 -0500
Subject: Re: [PATCH v2] dt-bindings: power: Convert bq27xxx dt to yaml
To:     "Andrew F. Davis" <afd@ti.com>, <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20200507183013.27261-1-dmurphy@ti.com>
 <a5eae705-672b-acef-8850-0811a6ea13fb@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <38fffe57-bcc2-b87f-6589-09bb97b5c67a@ti.com>
Date:   Mon, 11 May 2020 10:23:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a5eae705-672b-acef-8850-0811a6ea13fb@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Andrew

On 5/11/20 10:22 AM, Andrew F. Davis wrote:
> On 5/7/20 2:30 PM, Dan Murphy wrote:
>> Convert the bq27xxx.txt to yaml format
>>
>> CC: Pali Rohár <pali@kernel.org>
>> CC: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../bindings/power/supply/bq27xxx.txt         | 56 ------------
>>   .../bindings/power/supply/bq27xxx.yaml        | 86 +++++++++++++++++++
>>   2 files changed, 86 insertions(+), 56 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> deleted file mode 100644
>> index 4fa8e08df2b6..000000000000
>> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> +++ /dev/null
>> @@ -1,56 +0,0 @@
>> -TI BQ27XXX fuel gauge family
>> -
>> -Required properties:
>> -- compatible: contains one of the following:
>> - * "ti,bq27200" - BQ27200
>> - * "ti,bq27210" - BQ27210
>> - * "ti,bq27500" - deprecated, use revision specific property below
>> - * "ti,bq27510" - deprecated, use revision specific property below
>> - * "ti,bq27520" - deprecated, use revision specific property below
>> - * "ti,bq27500-1" - BQ27500/1
>
> This doesn't look right, these are two parts, we should be specific in
> DT, so:
>
> ti,bq27500
> ti,bq27501
>
> should be separate like that.

I agree if they are 2 different parts but the code has

     { .compatible = "ti,bq27500-1" },

But it has no consumers.

So the ti,bq27500-1 compatible should be deprecated and ti,bq27501  
should be added and the ti,bq27500 should be reinstated.

Dan

