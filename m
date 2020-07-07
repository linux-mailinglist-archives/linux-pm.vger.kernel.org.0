Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91142175E8
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGGSHl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 14:07:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33564 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgGGSHl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 14:07:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 067I7dsp122688;
        Tue, 7 Jul 2020 13:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594145259;
        bh=tcG+3QfvQYtuz+moQPRntRSYLDtYJOO1r/4BMO3+5bI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Zv4ipbsfseRXYHLCKiWPZV5bHcwAJV63dS7QRwA8FLcswu9yTLyci8r5q+NNGzxvp
         SbD2SzbGUjAwDtbxGfHP6ui2CppuNgxlG4BHspx5HmTAC1CeCwKx+gWqRBGpI/XM30
         98AWdn7xdQfH8chUr/J7m/Xg0VhUb/FUwWGAgqrg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 067I7d6J032245
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 13:07:39 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 13:07:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 13:07:39 -0500
Received: from [10.250.43.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067I7cGA011289;
        Tue, 7 Jul 2020 13:07:38 -0500
Subject: Re: [EXTERNAL] Re: [PATCH v15 2/4] dt-bindings: power: Convert
 battery.txt to battery.yaml
To:     Rob Herring <robh@kernel.org>
CC:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Sandeep Patil <sspatil@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200701211044.18590-1-r-rivera-matos@ti.com>
 <20200701211044.18590-3-r-rivera-matos@ti.com>
 <20200702205320.GA1672139@bogus>
 <54914eed-4a65-745b-b61b-9515737023e3@ti.com>
 <CAL_JsqKXC1TFFCq6HBqdbHNeWbA=SnCqHkTx+FQXiPYDLb6sNw@mail.gmail.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <50e85766-08d2-f91e-a6a9-c4b4f8858dc4@ti.com>
Date:   Tue, 7 Jul 2020 13:07:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKXC1TFFCq6HBqdbHNeWbA=SnCqHkTx+FQXiPYDLb6sNw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/7/20 9:40 AM, Rob Herring wrote:
> On Mon, Jul 6, 2020 at 12:45 PM Ricardo Rivera-Matos
> <r-rivera-matos@ti.com> wrote:
>> Rob
>>
>> On 7/2/20 3:53 PM, Rob Herring wrote:
>>> On Wed, 01 Jul 2020 16:10:42 -0500, Ricardo Rivera-Matos wrote:
>>>> From: Dan Murphy <dmurphy@ti.com>
>>>>
>>>> Convert the battery.txt file to yaml and fix up the examples.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>    .../bindings/power/supply/battery.txt         |  86 +---------
>>>>    .../bindings/power/supply/battery.yaml        | 157 ++++++++++++++++++
>>>>    2 files changed, 158 insertions(+), 85 deletions(-)
>>>>    create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
>>>>
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>>
>>> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.6/dist-packages/dtschema/schema/types.yaml'
>>> Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/power/supply/battery.example.dts' failed
>>> make[1]: *** [Documentation/devicetree/bindings/power/supply/battery.example.dts] Error 255
>>> make[1]: *** Waiting for unfinished jobs....
>>> Makefile:1347: recipe for target 'dt_binding_check' failed
>>> make: *** [dt_binding_check] Error 2
>> I think your bot is looking for the types.yaml in the wrong place.
> Really? Yet it works fine on thousands of other patches?
>
>> '/usr/local/lib/python3.6/dist-packages/dtschema/schema/types.yaml'
>> should be
>> '/usr/local/lib/python3.6/dist-packages/dtschema/schemas/types.yaml'. I
>> renamed might 'schemas' directory to 'schema' and my battery.yaml passed
>> the dt_binding_check.
> Maybe fix the 'schema/' path in your schema file which is wrong.
Oh I see. My apologies, Rob.
>
> Rob
