Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06CADF61D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 21:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfJUThW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 15:37:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52456 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbfJUThW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 15:37:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9LJbIVl071354;
        Mon, 21 Oct 2019 14:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571686638;
        bh=i9LJ27pFEl9eAdyUHDNy3hfMcfXRi+oOQMoXFA0UpIQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I6TerTOvqXDfwlDExbAWCSDSQr3gWeaF/6cRAUpS0s+ORb7/u/XsjudhX1KfGXAjX
         JdUrOyiOeswalCle1womPZyT+JWP4nAex7zPopiuDn2c1C8n/htvGy1o2r6pxiblKH
         J/B6t+GZAit06ZmCACCZH2dGBuVpqRTBB+zkaGAs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9LJb368052287
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Oct 2019 14:37:03 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 21
 Oct 2019 14:36:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 21 Oct 2019 14:36:53 -0500
Received: from [10.250.35.43] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9LJb2t3027583;
        Mon, 21 Oct 2019 14:37:02 -0500
Subject: Re: [PATCH 2/3] dt: power: Add the bq2515x family dt bindings
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190930143137.21624-1-dmurphy@ti.com>
 <20190930143137.21624-2-dmurphy@ti.com>
 <20191020123014.trvn5auxbv6ftngj@earth.universe>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1fcb9257-464f-060d-c8bb-085fe72fdf35@ti.com>
Date:   Mon, 21 Oct 2019 14:36:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020123014.trvn5auxbv6ftngj@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 10/20/19 7:30 AM, Sebastian Reichel wrote:
> Hi Dan,
>
> On Mon, Sep 30, 2019 at 09:31:36AM -0500, Dan Murphy wrote:
>> Add the bindings for the bq25150 and bq25155 500mA
>>   charging IC from Texas Instruments.
>>
>> Datasheet:
>> http://www.ti.com/lit/ds/symlink/bq25150.pdf
>> http://www.ti.com/lit/ds/symlink/bq25155.pdf
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../bindings/power/supply/bq2515x.txt         | 48 +++++++++++++++++++
> This should use the new YAML binding style.


Ack


>
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.txt b/Documentation/devicetree/bindings/power/supply/bq2515x.txt
>> new file mode 100644
>> index 000000000000..98203ab53d44
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/bq2515x.txt
>> @@ -0,0 +1,48 @@
>> +Binding for TI bq25150 500-mA Linear charger
>> +
>> +The BQ25150 is a highly integrated battery charge management IC that integrates
>> +the most common functions for wearable devices, namely a charger, an
>> +output voltage rail, ADC for battery and system monitoring, and
>> +push-button controller.
>> +
>> +Required Properties:
>> +	- compatible: Should contain one of the following:
>> +		"ti,bq25150"
>> +		"ti,bq25155"
>> +	- reg: int I2c address 0x6b
>> +	- #address-cells: 1;
>> +	- #size-cells: = 0;
>> +
>> +Optional Properties:
>> +	- ti,battery-regulation-voltage: integer, maximum charging voltage in mV.
>> +		Values range from 3600->4600mV
>> +	- ti,charge-current: integer, maximum charging current in mA.
>> +		Values range from 50->600mA
> Those values should be in uV and uA. Also the values basically
> describe the dumb battery, so please use this binding:
>
> Documentation/devicetree/bindings/power/supply/battery.txt

Ack


>
>> +	- reset-gpios: GPIO used for Master reset
>> +	- low-power-gpios: GPIO used for low power mode of IC.
>> +	- charge-enable-gpios: GPIO used to turn on and off charging.
>> +	- pg-gpios: GPIO used for connecting the bq2515x device PG (Power Good)
>> +		pin.  This pin should be used if possible as this is the
>> +		recommended way to obtain the charger's input PG state.
>> +		If this pin is not specified a software-based approach for PG
>> +		detection is used.
>> +
>> +Example
>> +bq25150@6b {
> charger@6b

Ack

Dan

