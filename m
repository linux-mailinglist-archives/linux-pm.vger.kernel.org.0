Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0621CCFD3
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 04:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgEKClb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 22:41:31 -0400
Received: from mail-bn8nam11olkn2024.outbound.protection.outlook.com ([40.92.20.24]:24192
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgEKClb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 May 2020 22:41:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkFpbmOzAcrmVE2pVeazgKAlhzzslPo6tSmqoOHh0MVsLyR0DFhgsNyk2KEaI0n/lydvg/fdvu0nsf001Bp6/h+ncuuP3aSKMRdyCmjTdzWrREjZedN1mXTZovkxOEG0fSpN/LIsUEkytcz1QtDdvN8+qH/z0iryb9WcMEVC+9A2uvn7gWxbmOurWuCuiUxtskBis7j0EoobbLe8Nn1fRw9BzWdoSxqZ75IpfbxZ3shhqKCTHtA57f5ybSQL5KBRz/AlwXXuNQ4Wq17WpzBmQzn6BSlvSuxFjOpgzJbYfPfEFnnPFRX8syRVu7D94LMq5hDhKZSKVtQNwI/A0e/5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HVq+8NKAvqaKsv71Xui8b7ThIO7O0xlXODyWJD3Bm8=;
 b=D/3muWuS7JvdYJrgUwxvMHUlDtCXZUYjiDb1sTd0DOKva+RTxM7JX7hb5Q8P0cfvc7M+slKL8IXExMCArj7HUN34AzNHkYgwUFlaWfJ63t1vcBqnJ/AFsbgXGoZbFw1y3LiEcRZAXNzlMtA4LwVzcnlvr+Htjzq6q/+sOeL5Vuvj7yXlM45Amd/U6dAXURcYnFDE6s+Rz9RoNQaPtW/pSi2+g4AJ1vXN+6E2Fx8Mjotj+x0+l8TZwlfs+JAeQgn1twSPn1i9IkbDH9In1XwISBQlb7dL23GRsGmi8XVtblmb0P1AOfdjLW6BTXgDDhUrdwn8qV/DflvYMewn4RPvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::47) by
 CO1NAM11HT088.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::310)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Mon, 11 May
 2020 02:41:27 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::51) by CO1NAM11FT004.mail.protection.outlook.com
 (2a01:111:e400:3861::345) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Mon, 11 May 2020 02:41:27 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A60277B37A69857AA09DF6BD1815EB0CBE43B645E0807D9BAB85DC2778AEC8A6;UpperCasedChecksum:11ABE59EBCDFB19BA91C6E007C71B2E7FD5A655EB0F1191EB2E7511D457CEEF5;SizeAsReceived:8285;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 02:41:26 +0000
Subject: Re: [PATCH 3/3] power: supply: max17040: Set rcomp value
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20200504221300.3153-1-xc-racer2@live.ca>
 <BN6PR04MB066057B881DEFC0C48208589A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200510200851.zam6m37bkr36s5cr@earth.universe>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BN6PR04MB06603F40894AD514E24E6BF8A3A10@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Sun, 10 May 2020 19:41:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200510200851.zam6m37bkr36s5cr@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:300:ae::14) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <eb476907-c456-3cd3-2dd3-e0da44825b4d@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR14CA0004.namprd14.prod.outlook.com (2603:10b6:300:ae::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Mon, 11 May 2020 02:41:22 +0000
X-Microsoft-Original-Message-ID: <eb476907-c456-3cd3-2dd3-e0da44825b4d@live.ca>
X-TMN:  [znEavWOxicV2w16oTe5S7oQMFi9b8uJZ+IpL1nsuCDaIgUNsjyyiO3EXsBEkL+8H]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6a0ec689-4cb8-4e75-a3d1-08d7f554cb69
X-MS-TrafficTypeDiagnostic: CO1NAM11HT088:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwCMOpyaHTRJUUYEoNxhqunYUFrA5fWrqm7m2UEQA3DBllD/NUsR8frgfuVp/uFyijQsDLtH95wuzHnMoiZ8GHpOwuHN4cWQx4X6xUiNun58A4gcrMI593ZswyQXUtoYC0nEYHDoJ+glU2hFEJc+LQslX4J6wgDlGQ3926Rf6CJvhlCTn3RxL97rdLwBqzsoUqxQO4+D+AemSJcvfFFqOYE70xPXdI513mJw5EwoR2TCLKeIWEtCK4xQfdOmyQx2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: bqwQa1hxP7v4wkJIag6KC5IZpfBAwgNw0nRrKJssfkZ7l0B1Cn0BDrfQdXTz7RXsGTPnmFjg9wyRjBoX4hJKuXAlPZDrkkPs8/nCsBXLkcw4xaZe0qiHNulQ3I5uB/wrn5obD3mEbEiQV0jf+Q3tPcg9r/l+R33rvZ3ciXMzmF6iMU8V4zvfHyJ2XUyO7LkhP+mom0s/3f/AcXJrX3mokg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0ec689-4cb8-4e75-a3d1-08d7f554cb69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 02:41:26.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT088
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 2020-05-10 1:08 p.m., Sebastian Reichel wrote:
> Hi,
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
> 
> Why is this 8 bits? Quote from the datasheet, that you linked:
> 
> »RCOMP is a 16-bit value used to compensate the ModelGauge algorithm«

Well, the driver also supports the max17043 (datasheet at https://datasheets.maximintegrated.com/en/ds/MAX17043-MAX17044.pdf
here the register is named CONFIG), by the maxim,max77836-battery compatible.  The bottom 8 bits are for the alert config,
and I'm presuming it's the same on the max17040 (the vendor kernel for the device I'm testing on only sets the top 8 bits
and leaves the rest at 0).

If there's a better way of doing it (ie maybe explicitly making it a 16 bit value and checking if the bottom 8 bits are
set when the compatible is maxim,max77836-battery), then I'm happy to do it that way.

Thanks,
Jonathan

> 
> -- Sebastian
> 
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
>>
