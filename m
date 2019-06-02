Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959493258C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 00:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFBW01 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jun 2019 18:26:27 -0400
Received: from gateway30.websitewelcome.com ([192.185.146.7]:11330 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfFBW01 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jun 2019 18:26:27 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id BBDBE548E
        for <linux-pm@vger.kernel.org>; Sun,  2 Jun 2019 17:26:25 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id XYvphDGpo90onXYvphFUDA; Sun, 02 Jun 2019 17:26:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fezTM9m3wc+a13i+Crf4N2vBAfcXMkeA56RD9iSpWiQ=; b=HasRlNXPjNW9sHRjqiFcAxboAz
        zfO+LOoyh4RPxHdLb3Y0A1t7aX3OSdlym+OvIHXwINInvyX2cbltSDcZM2Pf04hNIFf+32iguueKl
        jgn3zCEG4EyQLghdJg6IKKUl+/3OZWKM5w9IES0h9kNBW711l+G7ISNUfn4UWoI729iXAm2zSU9IZ
        nSBhrbipqri2uMIWd4jtmGQGZ90GtwTcD2GXrsdMaSCuYll5imZjeaeWyAJaeYVRypX4lDBWCI2wc
        7J+Txf6M26VAiBFcLk7L+OdsBpwGl8VR7g/mQuJFEYuqSemdglm96NdiilPoQ65dRhxYmpr1ExrsQ
        jUeu2pEA==;
Received: from [177.34.20.96] (port=55390 helo=[192.168.0.28])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hXYvp-003efM-5g; Sun, 02 Jun 2019 19:26:25 -0300
Subject: Re: [PATCH v3 3/5] power: supply: max17040: Config alert SOC low
 level threshold from FDT
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br>
 <20190527022258.32748-4-matheus@castello.eng.br>
 <CAJKOXPd2F6iy0ZqYf+X2k=eQ=tY1zG4gVbrr68XqE9+w4HK6dw@mail.gmail.com>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <69a4f003-4413-1316-6145-f8bef2171e86@castello.eng.br>
Date:   Sun, 2 Jun 2019 19:26:20 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPd2F6iy0ZqYf+X2k=eQ=tY1zG4gVbrr68XqE9+w4HK6dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.34.20.96
X-Source-L: No
X-Exim-ID: 1hXYvp-003efM-5g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.28]) [177.34.20.96]:55390
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 8
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/29/19 11:46 AM, Krzysztof Kozlowski wrote:
> On Mon, 27 May 2019 at 04:46, Matheus Castello <matheus@castello.eng.br> wrote:
>>
>> For configuration of fuel gauge alert for a low level state of charge
>> interrupt we add a function to config level threshold and a device tree
>> binding property to set it in flatned device tree node.
>>
>> Now we can use "maxim,alert-low-soc-level" property with the values from
>> 1% up to 32% to configure alert interrupt threshold.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   drivers/power/supply/max17040_battery.c | 52 +++++++++++++++++++++++--
>>   1 file changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
>> index b7433e9ca7c2..2f4851608cfe 100644
>> --- a/drivers/power/supply/max17040_battery.c
>> +++ b/drivers/power/supply/max17040_battery.c
>> @@ -29,6 +29,9 @@
>>   #define MAX17040_DELAY         1000
>>   #define MAX17040_BATTERY_FULL  95
>>
>> +#define MAX17040_ATHD_MASK             0xFFC0
>> +#define MAX17040_ATHD_DEFAULT_POWER_UP 4
>> +
>>   struct max17040_chip {
>>          struct i2c_client               *client;
>>          struct delayed_work             work;
>> @@ -43,6 +46,8 @@ struct max17040_chip {
>>          int soc;
>>          /* State Of Charge */
>>          int status;
>> +       /* Low alert threshold from 32% to 1% of the State of Charge */
>> +       u32 low_soc_alert_threshold;
>>   };
>>
>>   static int max17040_get_property(struct power_supply *psy,
>> @@ -99,6 +104,28 @@ static void max17040_reset(struct i2c_client *client)
>>          max17040_write_reg(client, MAX17040_CMD, 0x0054);
>>   }
>>
>> +static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
>> +       u32 level)
>> +{
>> +       int ret;
>> +       u16 data;
>> +
>> +       /* check if level is between 1% and 32% */
>> +       if (level > 0 && level < 33) {
>> +               level = 32 - level;
>> +               data = max17040_read_reg(client, MAX17040_RCOMP);
>> +               /* clear the alrt bit and set LSb 5 bits */
>> +               data &= MAX17040_ATHD_MASK;
>> +               data |= level;
>> +               max17040_write_reg(client, MAX17040_RCOMP, data);
>> +               ret = 0;

I will put the return of max17040_write_reg on ret, instead of ret = 0.

>> +       } else {
>> +               ret = -EINVAL;
>> +       }
> 
> This is unusual way of handling error... when you parse DTS, you
> accept any value for "level" (even incorrect one). You validate the
> value later when setting it and show an error... however you ignore
> the error of max17040_write_reg() here... This is correct but looks
> unusual.
> 

Ok, so would it be better to check the level value in 
"max17040_get_of_data" and return an error there if the input is wrong?

Best Regards,
Matheus Castello

> Best regards,
> Krzysztof
> 
