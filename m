Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803361E889A
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 22:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgE2UJY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 16:09:24 -0400
Received: from mail-mw2nam10olkn2051.outbound.protection.outlook.com ([40.92.42.51]:2561
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728129AbgE2UJV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 May 2020 16:09:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+k6F+88SLsJ1XiiC8uezPJAbUiDl7pEK9+f5phe63BsQkL67crGtaMqJoJQ4OMFmVRKhlG9hR0JnEEIGieOFx8xUPG2ndoMCaXbxcHD7auQJnSWN/HvImKaEC1aQgxze8PjPz3SX4rH9GXkxMRoIJYO+mP+ZeSF5e9XLaWWvctHKIy6axuQUkpZeVGwS25XEdHzLwABKzIDusEOg1Rw76OmI6M+XOJs8X8CnDCN4+XIsnqhMExT7t5w4N/T8rC07N8A+R1IjlH+y8yo4vlJvS5dSTVEmNRUlmY4akkjF44cKrk/Pog7EX3hOuterjBUwJHJpCehbggz34n3+rcyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoUEN1Q51FMql/RJqg3AP0EGPRI+p/TiK3KN6QT/5QA=;
 b=L7zDW0fUM5WXh8KeSxFU8blybNIyHMNA7QUdqT8fnH9GW8oLt6/1FmacW/HHgGmyHZ/77PhqC8mHA7/GeUtQP0aj94UvDuhYsljleVmf50lwz7i9Pz/v467dXrGc25Rf2kb3wvfuPUQN9Dyk0qltEEbTSTfmxrCKBgVBUNi2MeHmZ0s3+QzOK9f2R/Gz8UotJtoVjP628dwmQBJqwr3EtbQPgcFome374W538VHqjFQgw8/gJzOiOHxkJibNmZErxkqmBrPNIiR1MKZwSzJC1Lua4IKDN9qx9TeaIu3mWOM29wJEtjhGrGIdYhXtnRZh0ZpbFWLvJjudKUOloIK0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM10FT034.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e87::48) by
 MW2NAM10HT028.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e87::189)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 29 May
 2020 20:09:19 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e87::46) by MW2NAM10FT034.mail.protection.outlook.com
 (2a01:111:e400:7e87::231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 29 May 2020 20:09:19 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F99B700F028E17DB1267AE68D1D09D364DE28EE78191EE13614794A9736C2306;UpperCasedChecksum:5C838F50370674E09656C0FA6359DA35D9CD8CF126345E879CA53DD9B7254A6E;SizeAsReceived:8288;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 20:09:18 +0000
Subject: Re: [PATCH 3/3] power: supply: max17040: Set rcomp value
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20200504221300.3153-1-xc-racer2@live.ca>
 <BN6PR04MB066057B881DEFC0C48208589A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200528170230.62c7jvmyjkhpoykj@earth.universe>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB0660773C4CBAA1CB72D3DB25A38F0@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Fri, 29 May 2020 13:09:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200528170230.62c7jvmyjkhpoykj@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2201CA0038.namprd22.prod.outlook.com
 (2603:10b6:301:16::12) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <15e6ac50-5401-42f0-84aa-92966ba0e452@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR2201CA0038.namprd22.prod.outlook.com (2603:10b6:301:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 20:09:17 +0000
X-Microsoft-Original-Message-ID: <15e6ac50-5401-42f0-84aa-92966ba0e452@live.ca>
X-TMN:  [CZtDKXxy0GeRm2v2TrxY29cCSgpjdJSxhhZE0A9hpyBCno/gFgY45cZbWF9ggbh9]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: df0e2a99-9ed7-46da-fa6a-08d8040c2b14
X-MS-TrafficTypeDiagnostic: MW2NAM10HT028:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrJ7J4EzC4JURgmy1wAgnyyJUeOMKvOa/OGWI1uHpvxRQ0gL6R27rQaLoWSbjkpxfkOc+LaRPPOIlFjHhACm70YXPKXBxXCNJ3PnoamKZNPAWQGQvCLRou+7IPMBKNkPjucKMKv1t1qcgSrOPdbtJPQfunh0k7fF1yi9F7pAVjvMFBRIzPYs1X69Do25rCDULlVYw0342YWWJKbGESQ2SI5jQBWVY2NI18rshWC05dECbLosfN8KGTYPJVFEviyX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: PPmpHMFz+ncIO3mi4BGpqvWOISk4GMPlfc7o9u57n64Vd6E4OWb2rOa3yn7bkVSjEqRlCZFza5GS2hKudYOz3LuP/H8badguiK6ko+jUq7piYaMWYa2TpC+GGGqpHGcfnvP0KgO/WB7fDKcCji/KuqcOn2IulpMZWSzpq7B7WgJ+SsABGQ9ieXwrKbjOLMZGUAB3FNdm66tG6HjHIgT5gw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0e2a99-9ed7-46da-fa6a-08d8040c2b14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 20:09:18.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM10HT028
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

I'm sorry, I messed up my rebase on top of the low battery alert and it somehow
slipped through my pre-submit checklist.

Before resubmitting, do you want the rcomp changed in any manner (where the
datasheet doesn't specify if its the full 16 bits or only 8 bites for max17040
but does for the later max17043/max77836 where its only 8 bits)?

Thanks and sorry for the issues,
Jonathan

On 2020-05-28 10:02 a.m., Sebastian Reichel wrote:
> Hi,
> 
> This patch does not even compile, how did you test it?
> 
> -- Sebastian
> 
> On Mon, May 04, 2020 at 03:13:00PM -0700, Jonathan Bakker wrote:
>> According to the datasheet (1), the rcomp parameter can
>> vary based on the typical operating temperature and the
>> battery chemistry.  If provided, make sure we set it after
>> we reset the chip on boot.
>>
>> 1) https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  drivers/power/supply/max17040_battery.c | 33 +++++++++++++++++++++----
>>  1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
>> index 48aa44665e2f..f66e2fdc0a8a 100644
>> --- a/drivers/power/supply/max17040_battery.c
>> +++ b/drivers/power/supply/max17040_battery.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/init.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/mutex.h>
>> +#include <linux/property.h>
>>  #include <linux/err.h>
>>  #include <linux/i2c.h>
>>  #include <linux/delay.h>
>> @@ -31,6 +32,8 @@
>>  
>>  #define MAX17040_ATHD_MASK		0xFFC0
>>  #define MAX17040_ATHD_DEFAULT_POWER_UP	4
>> +#define MAX17040_RCOMP_MASK		0xFF
>> +#define MAX17040_RCOMP_DEFAULT_POWER_UP	0x97
>>  
>>  struct max17040_chip {
>>  	struct i2c_client		*client;
>> @@ -48,6 +51,8 @@ struct max17040_chip {
>>  	int status;
>>  	/* Low alert threshold from 32% to 1% of the State of Charge */
>>  	u32 low_soc_alert;
>> +	/* Optimization for specific chemistries */
>> +	u8 rcomp_value;
>>  };
>>  
>>  static int max17040_get_property(struct power_supply *psy,
>> @@ -119,6 +124,20 @@ static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
>>  	return ret;
>>  }
>>  
>> +static int max17040_set_rcomp(struct i2c_client *client, u32 val)
>> +{
>> +	int ret;
>> +	u16 data;
>> +
>> +	data = max17040_read_reg(client, MAX17040_RCOMP);
>> +	/* clear the rcomp val and set MSb 8 bits */
>> +	data &= MAX17040_RCOMP_MASK;
>> +	data |= val << 8;
>> +	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
>> +
>> +	return ret;
>> +}
>> +
>>  static void max17040_get_vcell(struct i2c_client *client)
>>  {
>>  	struct max17040_chip *chip = i2c_get_clientdata(client);
>> @@ -190,8 +209,14 @@ static int max17040_get_of_data(struct max17040_chip *chip)
>>  				 "maxim,alert-low-soc-level",
>>  				 &chip->low_soc_alert);
>>  
>> -	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33)
>> +	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33) {
>> +		dev_err(&client->dev,
>> +			"failed: low SOC alert OF data out of bounds\n");
>>  		return -EINVAL;
>> +	}
>> +
>> +	chip->rcomp_value = MAX17040_RCOMP_DEFAULT_POWER_UP;
>> +	device_property_read_u8(dev, "maxim,rcomp-value", &chip->rcomp_value);
>>  
>>  	return 0;
>>  }
>> @@ -289,11 +314,8 @@ static int max17040_probe(struct i2c_client *client,
>>  	chip->client = client;
>>  	chip->pdata = client->dev.platform_data;
>>  	ret = max17040_get_of_data(chip);
>> -	if (ret) {
>> -		dev_err(&client->dev,
>> -			"failed: low SOC alert OF data out of bounds\n");
>> +	if (ret)
>>  		return ret;
>> -	}
>>  
>>  	i2c_set_clientdata(client, chip);
>>  	psy_cfg.drv_data = chip;
>> @@ -307,6 +329,7 @@ static int max17040_probe(struct i2c_client *client,
>>  
>>  	max17040_reset(client);
>>  	max17040_get_version(client);
>> +	max17040_set_rcomp(client, chip->rcomp_value);
>>  
>>  	/* check interrupt */
>>  	if (client->irq && of_device_is_compatible(client->dev.of_node,
>> -- 
>> 2.20.1
