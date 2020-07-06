Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC51215EF4
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgGFSp2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 14:45:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52122 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgGFSp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 14:45:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 066IjQru127801;
        Mon, 6 Jul 2020 13:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594061126;
        bh=PcCdHop+GwSCzLkx0JmARyDO1A24Eate1XRLBtTMA40=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M6qDT0k4TEgef3OaQkqIPgZk8BwC+8sw6byBrzGey0J/gK3+jLg+vmu8tr48+Za1J
         h5DtyjJFk1Og1jMpX+LRW7d/8Fc64GYEt6a5/VIxOW8EslwlTXby7lccCDyBunmx0+
         zMoxFaelMm9FgyrsqF900mUzaptanDFC3srgeTYo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 066IjQoG102161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jul 2020 13:45:26 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 6 Jul
 2020 13:45:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 6 Jul 2020 13:45:26 -0500
Received: from [10.250.43.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 066IjOjF081156;
        Mon, 6 Jul 2020 13:45:24 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v15 2/4] dt-bindings: power: Convert
 battery.txt to battery.yaml
To:     Rob Herring <robh@kernel.org>
CC:     <pali@kernel.org>, <linux-pm@vger.kernel.org>,
        <sspatil@android.com>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>, <dmurphy@ti.com>, <sre@kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200701211044.18590-1-r-rivera-matos@ti.com>
 <20200701211044.18590-3-r-rivera-matos@ti.com>
 <20200702205320.GA1672139@bogus>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <54914eed-4a65-745b-b61b-9515737023e3@ti.com>
Date:   Mon, 6 Jul 2020 13:45:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702205320.GA1672139@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rob

On 7/2/20 3:53 PM, Rob Herring wrote:
> On Wed, 01 Jul 2020 16:10:42 -0500, Ricardo Rivera-Matos wrote:
>> From: Dan Murphy <dmurphy@ti.com>
>>
>> Convert the battery.txt file to yaml and fix up the examples.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../bindings/power/supply/battery.txt         |  86 +---------
>>   .../bindings/power/supply/battery.yaml        | 157 ++++++++++++++++++
>>   2 files changed, 158 insertions(+), 85 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
>>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.6/dist-packages/dtschema/schema/types.yaml'
> Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/power/supply/battery.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/power/supply/battery.example.dts] Error 255
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1347: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
I think your bot is looking for the types.yaml in the wrong place. 
'/usr/local/lib/python3.6/dist-packages/dtschema/schema/types.yaml' 
should be 
'/usr/local/lib/python3.6/dist-packages/dtschema/schemas/types.yaml'. I 
renamed might 'schemas' directory to 'schema' and my battery.yaml passed 
the dt_binding_check.
>
>
> See https://patchwork.ozlabs.org/patch/1320813
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
Confirmed on latest dt-schema
>
> Please check and re-submit.

     Thanks,

         Ricardo

>
