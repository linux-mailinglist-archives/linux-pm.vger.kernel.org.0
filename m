Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A859D43C421
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbhJ0HnF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 03:43:05 -0400
Received: from mail-am6eur05on2060.outbound.protection.outlook.com ([40.107.22.60]:11968
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240555AbhJ0HnE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Oct 2021 03:43:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPLj7lNPhtsoqz2ReWEXSL0LO/PdAX3E1ZmqO9XVq6MC+toOjVQM5xUj6pfvcoEBAIOt7Z8l8m9uEsZwp9fMmBCOmBR7l8D1eiTmo9W0WbGkzM7S5Ymwtf59xvvcnWzeZgg2E6UE2Iu5MnlKvHwTIDypvwk3FvA/+Zcj79HFbiwrmuIY1x1IfVa39d6dmprhv6oIGQDQB7qDJEK8KuZT//vX5/VYeerD5TpGRLHObWVhhRkSgYe3oo4zOVT+7bchheus6vB7V4xrH01sZ9S27rnkwOVwwFBW3h56V+jBiqvBXskYlval4xD+zwxsNBBqMY8Z7ECMl4jyy4D0ENCE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2DTi5w0hzbl1TuJ9YEoJd1DqjpImFJLeElb+WzUAdM=;
 b=bY/pmleKp4IdgG08/2ij1reMSziyBisuXpIpxNLHKmBxg7O0UWs8FeWYmuNVWyJdGtVuiIVg7HSB5kfnNk/qzs5mdZvHQOhhtcBFvqMyPcugAQHU26y6bpABn/UVNbcPprHWFclDqroPfL90dNyaH/XxT7XgrEESu6WGvN1a6HZmYJwZ/UUXcUlfgHYWeryuMn/UCF0Hm68yrPwW339iqm+13+N+9+u8l2xdBbtSlXJ/8TpWo37j7LnL9WktJZqmX9OmBVvI3bW/hfpdlJ55Kju4I+dChCUl7rzpRnZ/I2mOHMeH+apwLhmBbc4n9tmgZGOIef6W54YNAJZIFv5Fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mec.at; dmarc=pass action=none header.from=mec.at; dkim=pass
 header.d=mec.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mecat.onmicrosoft.com;
 s=selector2-mecat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2DTi5w0hzbl1TuJ9YEoJd1DqjpImFJLeElb+WzUAdM=;
 b=6lUMCVvfDdv7Gt/wGFUAPxojk5HGN0cWfA5zj1t+8Cgzxk7LYhYM2psM/QBRrqchzeeO4zNKSLftzaxEF37fJqFN+TaRVs6KtoYgfdeLPJaV7DQNxqH3QOBZGVoUYLcFigMNqi3WtAbyremUd7xqHnTpr79Hv59lDbqDLEJDaao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mec.at;
Received: from AS8PR03MB7079.eurprd03.prod.outlook.com (2603:10a6:20b:291::8)
 by AM6PR03MB5751.eurprd03.prod.outlook.com (2603:10a6:20b:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 07:40:36 +0000
Received: from AS8PR03MB7079.eurprd03.prod.outlook.com
 ([fe80::a82b:d993:9c68:f4ce]) by AS8PR03MB7079.eurprd03.prod.outlook.com
 ([fe80::a82b:d993:9c68:f4ce%9]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 07:40:36 +0000
Message-ID: <85c0567a-ec16-1dc7-803e-ee1c2a73748a@mec.at>
Date:   Wed, 27 Oct 2021 09:40:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] PM: Added functionality to the axp20x_battery driver
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20211025144455.16665-1-thomas.marangoni@mec.at>
 <20211025224054.iu4qtvn6kawxhh46@earth.universe>
From:   Thomas Marangoni <thomas.marangoni@mec.at>
Cc:     wens@csie.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211025224054.iu4qtvn6kawxhh46@earth.universe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0134.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::13) To AS8PR03MB7079.eurprd03.prod.outlook.com
 (2603:10a6:20b:291::8)
MIME-Version: 1.0
Received: from [192.168.2.176] (213.185.161.83) by ZR0P278CA0134.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Wed, 27 Oct 2021 07:40:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e7f2ef-43e3-4891-7ac6-08d9991d10aa
X-MS-TrafficTypeDiagnostic: AM6PR03MB5751:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5751E79A3E5F8ED6261B7AD7F6859@AM6PR03MB5751.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6eJTc2Iyu7sUaO2JfCxs0zw+R6Xs8jQdPKZp/qnJ3NJuGYx5/KY0qN6JVq46SVhs+I7zvJM83WcUbasQnvfqgpB6wR2cc2jA1Nb3Z18CenVQ73RgiQJWjAcHZD4a2RjA38wPZeihsjz/6BIAgvij46bEhBhnjhIWxyYT/9/lD5cBI1IT8cUAttpq67c6+A4qUqFYV0YNydmI/gxnFaRbx7lWGKlfpZckmZkBqIGlt+4H/YDroKivLll8actScvR8IOoEht/3KmueoLIGW3kEBNTYQE7G99C3alZZ/9HWgjXaFyju2TjFUJZLi0Pkxtthde7FmCbmp7pLpbMX66dzPQ6ZCpSn2TQ8igvks21keYE4IHx7vz0UayYXqQRS15ja9dcLy+4DAns/V6Jsy9ixoRm7hSXsElNHp7ofZ+aKezvoapaBBvlT0UAIV1YYSYbgVET3CQ1FTOgvEtsm1TYfresU7k2DKuOrtDT5SOQKGQSZMg1jFdFQLHgu6Xpcdg/vTZkx/Yt4tI+588nmy+UNffAMkKcneecYInQNj5zKK969U4OALNgyus29ZzhroxxB9AvqJ2CAtPQLYC8IuVIc69TBagxlWgwG12JWQrB6MlJCSXn/TpBy7p6eHBhiJvurjgnvFQEQxG/OLe4O1mJ7Emy8TIgfUAS7aIPAMLGPAQPN2lGJpr737pZXPAPvjwEHICa1Wq3YK0ljefRo7yNqjLr9Rcl4DZKWofQnWZ2cwsh6JmDnqh6UKdctGrdf4XKROYC3DHyL5bh0edaTioyyjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7079.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(39830400003)(346002)(31696002)(38100700002)(36756003)(31686004)(38350700002)(956004)(8936002)(4326008)(66946007)(66556008)(6916009)(26005)(30864003)(6486002)(186003)(316002)(44832011)(52116002)(508600001)(83380400001)(8676002)(86362001)(2906002)(2616005)(16576012)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEtmVzZtMFVPTWhKVTV0Q3ZSV1dDU2xqU040YUpqL2Jna05rcnlPV3Bib1RR?=
 =?utf-8?B?WkxXSVkrNWpCZHN6aDVabW11c1pGcXNpc0IzZW9HNE9lbjdHeHVLQU1mSzQ3?=
 =?utf-8?B?aWdqMXk4cmlRZDdXR1dQem0rWHdQeVJSNVpRV2dqTllTOGZLdHd1c1pvVFFM?=
 =?utf-8?B?YTZ0OUpjcTRuZ3J3N3RlUFZOenZwSkVYZTBYZ3V4TlNoWjU3d3JGWEY1bUts?=
 =?utf-8?B?Ukp4bi8yTHhQdm00TWhHcGdLd0txNUZjWTUrSU5WL3NKWXpvQU5KZ3NGN3NG?=
 =?utf-8?B?MEs2NFZIOG83OVBpaTBxNEZCaUVFYk5pNUdZeGpocW53QTNNcE5tbEVaNm93?=
 =?utf-8?B?QURmNTdKMFdBUytNdHF1TGc1TDVmQ2tjNjYzTlZueGcramhXQTAwRkZpWHNZ?=
 =?utf-8?B?Wmd4clhLVkZOajZCUDBybWMxeFBhd0VZS2QraUlwcHptUnVlRkRFQlNKYy8r?=
 =?utf-8?B?M0gyQTRsMzR2R3h1VHZNYW4yc2o0REYyN1JtSHhKWit5eXh2dnFra2VaK1dT?=
 =?utf-8?B?ckdCcVBEZDJpanpEWmd6bU5GaVBUUU91cllzNjRoTlhTbG9POUxMOGZEL05O?=
 =?utf-8?B?Ky9xUTBxcFNMYzFaNFpQbmZPdGJDUGkrTDR3V0QwZDBJY0NmWWhMUTZ3dWhS?=
 =?utf-8?B?ZkZKUTJxWWNzcDllb0RHTUVKcUF6WitSWkRwZGdla0NEZm8ydkNBMGlpU2dS?=
 =?utf-8?B?UUpMVU1mNWtDeGxvMWtZcE9jSC9raXU0dnpPWFRkM1lBMktkZ2dJYXZVZFhO?=
 =?utf-8?B?TWtEY0ZJV1Uvb1J4QTBRMytpZ2pOd2xrZWVoTzZhTUdJMFRMRVp3L2JXcDds?=
 =?utf-8?B?UG90clhkbWJST0ViSEFpVVZKRUNHUk1WM2ZMZU9UcFo1UEUxZzVXVHFxQUxi?=
 =?utf-8?B?VEEzd1NpaE0yUEdFanA5aFkrdWI3T3FZVnBBWTVoRTFTaU5XVzVwZG9uZy9q?=
 =?utf-8?B?dlpsaXpQSHcvUGUrUkFzTjdNdHJRd1hQSm8zdTllbVc4VUlIWDFqR0tJWXl3?=
 =?utf-8?B?bUZKTWFqaGtqeHlRYjhvN1lDMFNkT0F2ZU9BZ3lWVEFmYi84NEhXNy9BQ2k1?=
 =?utf-8?B?YTVTYVhJZ1NOeVcvK2hBcFpDU01YU0hNWmRORlVZVGJqYnYwT1NJTG96LzFK?=
 =?utf-8?B?ODRvbVRpUnpSVm96R1pGMTlqbGZqM0Rta2FTU3JRbVVZOVR6bXB0S0NkWFZv?=
 =?utf-8?B?Uk9XdEJHN0J1YldmeWk3QktzQm91MTJNZlkyb1hrWWdVaDRweDYvWWdiZWg1?=
 =?utf-8?B?ZUFSM29PWGZ6UW5zeU01Z3U5LytYQzNXLzQvTlF1QkdCandubVFxSU9lbmh1?=
 =?utf-8?B?ekZsUTRSZ2FsdWhjejZUV1pBdHdwTWN0Tk1tV3EzSDJWR2JEWENoR3R5bWxl?=
 =?utf-8?B?a3pPaDkzcVBFcVYxbWFzZWU3TUxLc3QrbjAwOU5UbndOV1E0YkVDOThFTFVr?=
 =?utf-8?B?eERDejhEdWkzcVovTFBVWWNiYURHQUFmdk1qdUM0MmVtUWtTTDgxaVhZaUR1?=
 =?utf-8?B?elpwZ2Y1UzhKTmE0VGZhazFhZW85eWJlejkvTlRPWDBOYVM0Y3k1dW1MZmVu?=
 =?utf-8?B?S3VQTVA1d0NmQy8rMEdpamFYR3dMTkpSVXZFZW9TZitOZ040ZDY3R0ttYzVm?=
 =?utf-8?B?TmcwRCtrbEF2ZzRJak1RaUYvRU1zS0p2WU82b3MrZUF1Yy9FbFNyN1pqNWRC?=
 =?utf-8?B?cThaakRXQXFIOXFVaENMelAzbnZ6V3lQWXlhU0VsQm1EQU9JWU40S2FSRndP?=
 =?utf-8?B?RURGU1IvQlovL2FLM0Npa1V5ei9aZVpGTG9OcUtzUEsrU2VpM0x4eHNPc0Rz?=
 =?utf-8?B?OHR4ZmZKRWRKdVdXR3VkUlpUZ0ZLR0JiSVRKVGhDQWIvNmRRb3VHMkZWZm9l?=
 =?utf-8?B?L1dmWU5obmh6L0d6NndJUm9YWkRKV2hYNjV5U0VrNE83RGQwMWw0MVVXdlk4?=
 =?utf-8?B?MHZvK0NHb2lWK1Boa1dZM0l4SzZnQ3UvUDVCbVpEUys5V3RNcTNGRGNhQ2hu?=
 =?utf-8?B?NUtsZXU1K3dGcldFTDg0cjhycTVPQ2V6ZDFCdW1ia1VnNmxoRWJKRWJvTzhu?=
 =?utf-8?B?TUxTMHA1bi9DQzBsZXlVSi95NmIycmhuLytRRDFFY3NERnpKbzNIZ1JST3Nz?=
 =?utf-8?B?VDBpSURySFR4TTNlVzF0UnY5VGhDWE1VaDhkUFV2TVc3V3hUZXgyZGZPU3JQ?=
 =?utf-8?Q?4mneP/D8lYTq/0+i7djlbGw=3D?=
X-OriginatorOrg: mec.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e7f2ef-43e3-4891-7ac6-08d9991d10aa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7079.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 07:40:36.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0f47e334-58db-4591-b50f-1937a70d1a07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVjGnlu+UFSRy+tNaF7Wzb+AtKCLcnZey9TllG1DjxKWq9gLkfW6WNN1cEmzH0tcRWoKDwi1ue0HCKabEZPsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5751
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,
> Hi,
>
> On Mon, Oct 25, 2021 at 04:44:55PM +0200, Thomas Marangoni wrote:
>> This patch adds missing features of the axp209 battery
>> functionality to the driver.
> I don't consider "Add missing features" as one logical change, so
> please split this according to Documentation/process/submitting-patches.rst

Thank you for the feedback, I will try to split it correctly.

>> New and present features have been added to the device tree configuration.
>>
>> Following features have been implemented:
>> - Set/Get of OCV curve, this is used to tune the capacity status (setting these
>>   values is only possible with the device tree).
>> - Set/Get of voltage low alert, this will trigger an interrupt if the given
>>   voltage level is reached. Level 1 will print a warning and level 2 will shutdown
>>   the device.
>> - Set/Get of temperature sense current, this is useful if a none default NTC is
>>   used for temperature sensing.
>> - Set/Get of temperature sense rate, this defines how often the ADC is getting
>>   the temperature values.
>> - Set/Get of temperature charging and discharging voltages, this defines the
>>   temperature ranges (as voltage) where the battery can be charged.
>>   (setting these values is only possible with the device tree).
>> - Get of temperature voltage, this returns the voltage that is present on the NTC.
> Why is the temperature not converted to °C allowing to use
> standard properties and being more user friendly?
The problem is, that the NTC that measures the temperature isn't built in. Everyone that is using the axp209 can solder an NTC (10k ohm, 1%) of their choice. The K factor, which is needed to calculate the temperature in °C, can differ with the model used.
>> These custom properties have been added to /sys:
>> - voltage_low_alert_level1 (RW)
>> - voltage_low_alert_level2 (RW)
>> - ocv_curve (RO)
>> - temperature_sense_current (RW)
>> - temperature_sense_rate (RW)
>> - temperature_sense_voltage_now (RO)
>> - temperature_discharge_threshold_voltage_range (RO)
>> - temperature_charge_threshold_voltage_range (RO)
>>
>> These IRQs have been added:
>> - BATT_PLUGIN (generic, useful for udev)
>> - BATT_REMOVAL (generic, useful for udev)
>> - CHARG (generic, useful for udev)
>> - CHARG_DONE (generic, useful for udev)
>> - BATT_TEMP_HIGH (prints warning, axp stops charging/discharging)
>> - BATT_TEMP_LOW (prints warning, axp stops charging/discharging)
>> - LOW_PWR_LVL1 (prints warning)
>> - LOW_PWR_LVL2 (prints warning and initializes a system shutdown)
> Battery temperature and low power events should also be reported
> through the HEALTH property if possible (i.e. if this information
> can be read from a register that keeps the state until the condition
> changes). In that case the IRQ should also trigger
> power_supply_changed().
This will be added into the next patch.
>
>> These properties have been added to be applied from the device tree:
>> - low-voltage-level1-microvolt
>> - low-voltage-level2-microvolt
>> - temperature-sense-current-microamp
>> - temperature-sense-rate-hertz
>> - temperature-discharge-range-microvolt
>> - temperature-charge-range-microvolt
>> - voltage-max-design-microvolt
>> - ocv-capacity-table-0
>>
>> Signed-off-by: Thomas Marangoni <thomas.marangoni@mec.at>
>> ---
>>  drivers/mfd/axp20x.c                  |  13 +
>>  drivers/power/supply/axp20x_battery.c | 938 +++++++++++++++++++++++++-
>>  2 files changed, 945 insertions(+), 6 deletions(-)
> DT ABI changes require updates to the devicetree binding files [0] &
> [1] with the DT maintainers being in Cc.
>
> Custom sysfs properties need to be documented in the userspace ABI
> documentation in a new file [2], or become standard properties and
> be documented in [3].
>
> [0] Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
> [1] Documentation/devicetree/bindings/power/supply/battery.yaml
> [2] Documentation/ABI/testing/sysfs-class-power-axp20x-battery
> [3] Documentation/ABI/testing/sysfs-class-power
>
> For now I will stop reviewing here ;)

Should the devicetree binding file changes bundled into one patch or submitted with the patch adding this feature? Should I  do the same for the ABI documentation?

> Thanks,
>
> -- Sebastian

Thanks

-- Thomas

>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 8161a5dc68e8..05dea452b513 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -191,6 +191,17 @@ static const struct resource axp20x_usb_power_supply_resources[] = {
>>  	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
>>  };
>>  
>> +static const struct resource axp20x_battery_power_supply_resources[] = {
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_PLUGIN, "BATT_PLUGIN"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_REMOVAL, "BATT_REMOVAL"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_CHARG, "CHARG"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_CHARG_DONE, "CHARG_DONE"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_TEMP_HIGH, "BATT_TEMP_HIGH"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_TEMP_LOW, "BATT_TEMP_LOW"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_LOW_PWR_LVL1, "LOW_PWR_LVL1"),
>> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_LOW_PWR_LVL2, "LOW_PWR_LVL2"),
>> +};
>> +
>>  static const struct resource axp22x_usb_power_supply_resources[] = {
>>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
>>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>> @@ -604,6 +615,8 @@ static const struct mfd_cell axp20x_cells[] = {
>>  	}, {
>>  		.name		= "axp20x-battery-power-supply",
>>  		.of_compatible	= "x-powers,axp209-battery-power-supply",
>> +		.num_resources	= ARRAY_SIZE(axp20x_battery_power_supply_resources),
>> +		.resources	= axp20x_battery_power_supply_resources,
>>  	}, {
>>  		.name		= "axp20x-ac-power-supply",
>>  		.of_compatible	= "x-powers,axp202-ac-power-supply",
>> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
>> index 18a9db0df4b1..5997c8192c73 100644
>> --- a/drivers/power/supply/axp20x_battery.c
>> +++ b/drivers/power/supply/axp20x_battery.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/consumer.h>
>>  #include <linux/mfd/axp20x.h>
>> +#include <linux/reboot.h>
>>  
>>  #define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
>>  
>> @@ -56,6 +57,25 @@
>>  
>>  #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
>>  
>> +#define AXP20X_APS_WARN_MASK		GENMASK(7, 0)
>> +
>> +#define AXP20X_TEMP_MASK		GENMASK(7, 0)
>> +
>> +#define AXP20X_ADC_TS_RATE_MASK		GENMASK(7, 6)
>> +#define AXP20X_ADC_TS_RATE_25Hz		(0 << 6)
>> +#define AXP20X_ADC_TS_RATE_50Hz		(1 << 6)
>> +#define AXP20X_ADC_TS_RATE_100Hz	(2 << 6)
>> +#define AXP20X_ADC_TS_RATE_200Hz	(3 << 6)
>> +
>> +#define AXP20X_ADC_TS_CURRENT_MASK	GENMASK(5, 4)
>> +#define AXP20X_ADC_TS_CURRENT_20uA	(0 << 4)
>> +#define AXP20X_ADC_TS_CURRENT_40uA	(1 << 4)
>> +#define AXP20X_ADC_TS_CURRENT_60uA	(2 << 4)
>> +#define AXP20X_ADC_TS_CURRENT_80uA	(3 << 4)
>> +
>> +
>> +#define DRVNAME "axp20x-battery-power-supply"
>> +
>>  struct axp20x_batt_ps;
>>  
>>  struct axp_data {
>> @@ -78,6 +98,79 @@ struct axp20x_batt_ps {
>>  	const struct axp_data	*data;
>>  };
>>  
>> +/*
>> + * OCV curve has fixed values and percentage can be adjusted, this array represents
>> + * the fixed values in uV
>> + */
>> +const int axp20x_ocv_values_uV[AXP20X_OCV_MAX + 1] = {
>> +	3132800,
>> +	3273600,
>> +	3414400,
>> +	3555200,
>> +	3625600,
>> +	3660800,
>> +	3696000,
>> +	3731200,
>> +	3766400,
>> +	3801600,
>> +	3836800,
>> +	3872000,
>> +	3942400,
>> +	4012800,
>> +	4083200,
>> +	4153600,
>> +};
>> +
>> +static irqreturn_t axp20x_battery_power_irq(int irq, void *devid)
>> +{
>> +	struct axp20x_batt_ps *axp20x_batt = devid;
>> +
>> +	power_supply_changed(axp20x_batt->batt);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t axp20x_battery_low_voltage_alert1_irq(int irq, void *devid)
>> +{
>> +	struct axp20x_batt_ps *axp20x_batt = devid;
>> +
>> +	dev_warn(axp20x_batt->dev, "Battery voltage low!");
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +
>> +static irqreturn_t axp20x_battery_low_voltage_alert2_irq(int irq, void *devid)
>> +{
>> +	struct axp20x_batt_ps *axp20x_batt = devid;
>> +
>> +	dev_emerg(axp20x_batt->dev, "Battery voltage very low! Iniatializing shutdown.");
>> +
>> +	orderly_poweroff(true);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t axp20x_battery_temperature_low_irq(int irq, void *devid)
>> +{
>> +	struct axp20x_batt_ps *axp20x_batt = devid;
>> +
>> +	dev_crit(axp20x_batt->dev, "Battery temperature to low!");
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +
>> +static irqreturn_t axp20x_battery_temperature_high_irq(int irq, void *devid)
>> +{
>> +	struct axp20x_batt_ps *axp20x_batt = devid;
>> +
>> +	dev_crit(axp20x_batt->dev, "Battery temperature to high!");
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +
>>  static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>>  					  int *val)
>>  {
>> @@ -181,6 +274,361 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>>  	return 0;
>>  }
>>  
>> +static int axp20x_battery_set_ocv_table(struct axp20x_batt_ps *axp_batt,
>> +					struct power_supply_battery_ocv_table ocv_table[AXP20X_OCV_MAX+1],
>> +					int ocv_table_size)
>> +{
>> +	int ret, i, error = 0;
>> +
>> +	if (ocv_table_size != AXP20X_OCV_MAX+1)
>> +		return 1;
>> +
>> +	for (i = 0; i < ocv_table_size; i++) {
>> +		ret = regmap_update_bits(axp_batt->regmap, AXP20X_OCV(i),
>> +			GENMASK(7, 0), ocv_table[i].capacity);
>> +
>> +		if (ret)
>> +			error = ret;
>> +	}
>> +
>> +	return error;
>> +}
>> +
>> +static int axp20x_battery_set_voltage_low_alert1(struct axp20x_batt_ps *axp_batt,
>> +					 int voltage_alert)
>> +{
>> +	int ret;
>> +	/* converts the warning voltage level in uV to the neeeded reg value */
>> +	int val1 = (voltage_alert - 2867200) / (1400 * 4);
>> +
>> +	if (val1 < 0 || val1 > AXP20X_APS_WARN_MASK)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(axp_batt->regmap, AXP20X_APS_WARN_L1,
>> +				  AXP20X_APS_WARN_MASK, val1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_voltage_low_alert1(struct axp20x_batt_ps *axp_batt,
>> +						 int *voltage_alert)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_APS_WARN_L1, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* converts the reg value to warning voltage level in uV */
>> +	*voltage_alert = 2867200 + (1400 * (reg & AXP20X_APS_WARN_MASK) * 4);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_set_voltage_low_alert2(struct axp20x_batt_ps *axp_batt,
>> +					 int voltage_alert)
>> +{
>> +	int ret;
>> +
>> +	/* converts the warning voltage level in uV to the neeeded reg value */
>> +	int val1 = (voltage_alert - 2867200) / (1400 * 4);
>> +
>> +	if (val1 < 0 || val1 > AXP20X_APS_WARN_MASK)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(axp_batt->regmap, AXP20X_APS_WARN_L2,
>> +				  AXP20X_APS_WARN_MASK, val1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_voltage_low_alert2(struct axp20x_batt_ps *axp_batt,
>> +						 int *voltage_alert)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_APS_WARN_L2, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* converts the reg value to warning voltage level in uV */
>> +	*voltage_alert = 2867200 + (1400 * (reg & AXP20X_APS_WARN_MASK) * 4);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_set_temperature_sense_current(struct axp20x_batt_ps *axp_batt,
>> +							int sense_current)
>> +{
>> +	int ret;
>> +	int reg = -1;
>> +
>> +	switch (sense_current) {
>> +	case 20:
>> +		reg = AXP20X_ADC_TS_CURRENT_20uA;
>> +		break;
>> +	case 40:
>> +		reg = AXP20X_ADC_TS_CURRENT_40uA;
>> +		break;
>> +	case 60:
>> +		reg = AXP20X_ADC_TS_CURRENT_60uA;
>> +		break;
>> +	case 80:
>> +		reg = AXP20X_ADC_TS_CURRENT_80uA;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (reg < 0)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(axp_batt->regmap, AXP20X_ADC_RATE,
>> +				  AXP20X_ADC_TS_CURRENT_MASK, reg);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_temperature_sense_current(struct axp20x_batt_ps *axp_batt,
>> +							int *sense_current)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_ADC_RATE, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reg = reg & AXP20X_ADC_TS_CURRENT_MASK;
>> +
>> +	switch (reg) {
>> +	case AXP20X_ADC_TS_CURRENT_20uA:
>> +		*sense_current = 20;
>> +		break;
>> +	case AXP20X_ADC_TS_CURRENT_40uA:
>> +		*sense_current = 40;
>> +		break;
>> +	case AXP20X_ADC_TS_CURRENT_60uA:
>> +		*sense_current = 60;
>> +		break;
>> +	case AXP20X_ADC_TS_CURRENT_80uA:
>> +		*sense_current = 80;
>> +		break;
>> +	default:
>> +		*sense_current = -1;
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_set_temperature_sense_rate(struct axp20x_batt_ps *axp_batt,
>> +						     int sample_rate)
>> +{
>> +	int ret;
>> +	int reg = -1;
>> +
>> +	switch (sample_rate) {
>> +	case 25:
>> +		reg = AXP20X_ADC_TS_RATE_25Hz;
>> +		break;
>> +	case 50:
>> +		reg = AXP20X_ADC_TS_RATE_50Hz;
>> +		break;
>> +	case 100:
>> +		reg = AXP20X_ADC_TS_RATE_100Hz;
>> +		break;
>> +	case 200:
>> +		reg = AXP20X_ADC_TS_RATE_200Hz;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (reg < 0)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(axp_batt->regmap, AXP20X_ADC_RATE,
>> +				  AXP20X_ADC_TS_RATE_MASK, reg);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_temperature_sense_rate(struct axp20x_batt_ps *axp_batt,
>> +						     int *sample_rate)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_ADC_RATE, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reg = reg & AXP20X_ADC_TS_RATE_MASK;
>> +
>> +	switch (reg) {
>> +	case AXP20X_ADC_TS_RATE_25Hz:
>> +		*sample_rate = 25;
>> +		break;
>> +	case AXP20X_ADC_TS_RATE_50Hz:
>> +		*sample_rate = 50;
>> +		break;
>> +	case AXP20X_ADC_TS_RATE_100Hz:
>> +		*sample_rate = 100;
>> +		break;
>> +	case AXP20X_ADC_TS_RATE_200Hz:
>> +		*sample_rate = 200;
>> +		break;
>> +	default:
>> +		*sample_rate = -1;
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_set_temperature_discharge_voltage_min(struct axp20x_batt_ps *axp_batt,
>> +								int voltage)
>> +{
>> +	int ret;
>> +
>> +	int val1 = voltage / (0x10 * 800);
>> +
>> +	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(axp_batt->regmap, AXP20X_V_LTF_DISCHRG,
>> +				  AXP20X_TEMP_MASK, val1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_temperature_discharge_voltage_min(struct axp20x_batt_ps *axp_batt,
>> +								int *voltage)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_V_LTF_DISCHRG, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*voltage = reg * 0x10 * 800;
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_set_temperature_discharge_voltage_max(struct axp20x_batt_ps *axp_batt,
>> +								int voltage)
>> +{
>> +	int ret;
>> +
>> +	int val1 = voltage / (0x10 * 800);
>> +
>> +	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(axp_batt->regmap, AXP20X_V_HTF_DISCHRG,
>> +				  AXP20X_TEMP_MASK, val1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_temperature_discharge_voltage_max(struct axp20x_batt_ps *axp_batt,
>> +								int *voltage)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_V_HTF_DISCHRG, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*voltage = reg * 0x10 * 800;
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_set_temperature_charge_voltage_min(struct axp20x_batt_ps *axp_batt,
>> +							     int voltage)
>> +{
>> +	int ret;
>> +
>> +	int val1 = voltage / (0x10 * 800);
>> +
>> +	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(axp_batt->regmap, AXP20X_V_LTF_CHRG,
>> +				  AXP20X_TEMP_MASK, val1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_temperature_charge_voltage_min(struct axp20x_batt_ps *axp_batt,
>> +							     int *voltage)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_V_LTF_CHRG, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*voltage = reg * 0x10 * 800;
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_set_temperature_charge_voltage_max(struct axp20x_batt_ps *axp_batt,
>> +							     int voltage)
>> +{
>> +	int ret;
>> +
>> +	int val1 = voltage / (0x10 * 800);
>> +
>> +	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(axp_batt->regmap, AXP20X_V_HTF_CHRG,
>> +				  AXP20X_TEMP_MASK, val1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_temperature_charge_voltage_max(struct axp20x_batt_ps *axp_batt,
>> +							     int *voltage)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_V_HTF_CHRG, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*voltage = reg * 0x10 * 800;
>> +
>> +	return ret;
>> +}
>> +
>> +static int axp20x_battery_get_temp_sense_voltage_now(struct axp20x_batt_ps *axp_batt,
>> +						     int *voltage)
>> +{
>> +	int reg, ret, val1;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_TS_IN_L, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val1 = reg;
>> +
>> +	ret = regmap_read(axp_batt->regmap, AXP20X_TS_IN_H, &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* merging high and low value */
>> +	val1 = (reg << 4) | val1;
>> +
>> +	/* convert register value to real uV */
>> +	*voltage = val1 * 800;
>> +
>> +	return ret;
>> +}
>> +
>>  static int axp20x_battery_get_prop(struct power_supply *psy,
>>  				   enum power_supply_property psp,
>>  				   union power_supply_propval *val)
>> @@ -461,7 +909,8 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
>>  		return axp20x_set_voltage_min_design(axp20x_batt, val->intval);
>>  
>>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>> -		return axp20x_batt->data->set_max_voltage(axp20x_batt, val->intval);
>> +		return axp20x_batt->data->set_max_voltage(axp20x_batt,
>> +							  val->intval);
>>  
>>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>>  		return axp20x_set_constant_charge_current(axp20x_batt,
>> @@ -472,13 +921,16 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
>>  	case POWER_SUPPLY_PROP_STATUS:
>>  		switch (val->intval) {
>>  		case POWER_SUPPLY_STATUS_CHARGING:
>> -			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
>> -				AXP20X_CHRG_CTRL1_ENABLE, AXP20X_CHRG_CTRL1_ENABLE);
>> +			return regmap_update_bits(axp20x_batt->regmap,
>> +						  AXP20X_CHRG_CTRL1,
>> +						  AXP20X_CHRG_CTRL1_ENABLE,
>> +						  AXP20X_CHRG_CTRL1_ENABLE);
>>  
>>  		case POWER_SUPPLY_STATUS_DISCHARGING:
>>  		case POWER_SUPPLY_STATUS_NOT_CHARGING:
>> -			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
>> -				AXP20X_CHRG_CTRL1_ENABLE, 0);
>> +			return regmap_update_bits(axp20x_batt->regmap,
>> +						  AXP20X_CHRG_CTRL1,
>> +						  AXP20X_CHRG_CTRL1_ENABLE, 0);
>>  		}
>>  		fallthrough;
>>  	default:
>> @@ -510,6 +962,275 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
>>  	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
>>  }
>>  
>> +/* -- Custom attributes ----------------------------------------------------- */
>> +
>> +static ssize_t voltage_low_alert_level1_show(struct device *dev,
>> +					     struct device_attribute *attr,
>> +					     char *buf)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	int status;
>> +
>> +	int voltage_alert;
>> +
>> +	axp20x_battery_get_voltage_low_alert1(axp20x_batt, &voltage_alert);
>> +	status = sprintf(buf, "%d\n", voltage_alert);
>> +
>> +	return status;
>> +}
>> +
>> +static ssize_t voltage_low_alert_level1_store(struct device *dev,
>> +					      struct device_attribute *attr,
>> +					      const char *buf, size_t count)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	unsigned long value;
>> +	int status;
>> +
>> +	status = kstrtoul(buf, 0, &value);
>> +	if (status)
>> +		return status;
>> +
>> +	status = axp20x_battery_set_voltage_low_alert1(axp20x_batt, value);
>> +	if (status)
>> +		return status;
>> +
>> +	return count;
>> +}
>> +
>> +DEVICE_ATTR_RW(voltage_low_alert_level1);
>> +
>> +static ssize_t voltage_low_alert_level2_show(struct device *dev,
>> +					     struct device_attribute *attr,
>> +					     char *buf)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	int status;
>> +
>> +	int voltage_alert;
>> +
>> +	axp20x_battery_get_voltage_low_alert2(axp20x_batt, &voltage_alert);
>> +	status = sprintf(buf, "%d\n", voltage_alert);
>> +
>> +	return status;
>> +}
>> +
>> +static ssize_t voltage_low_alert_level2_store(struct device *dev,
>> +					      struct device_attribute *attr,
>> +					      const char *buf, size_t count)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	unsigned long value;
>> +	int status;
>> +
>> +	status = kstrtoul(buf, 0, &value);
>> +	if (status)
>> +		return status;
>> +
>> +	status = axp20x_battery_set_voltage_low_alert2(axp20x_batt, value);
>> +	if (status)
>> +		return status;
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(voltage_low_alert_level2);
>> +
>> +static ssize_t ocv_curve_show(struct device *dev, struct device_attribute *attr,
>> +			      char *buf)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	int status, ret, reg, i;
>> +
>> +	int ocv_curve_size = AXP20X_OCV_MAX+1;
>> +	struct power_supply_battery_ocv_table ocv_curve[AXP20X_OCV_MAX+1];
>> +
>> +
>> +	status = 0;
>> +	for (i = 0; i < ocv_curve_size; i++) {
>> +		ret = regmap_read(axp20x_batt->regmap, AXP20X_OCV(i), &reg);
>> +		if (ret)
>> +			status = ret;
>> +		ocv_curve[i].capacity = reg;
>> +		ocv_curve[i].ocv = axp20x_ocv_values_uV[i];
>> +	}
>> +
>> +	if (status)
>> +		return status;
>> +
>> +	status = 0;
>> +	for (i = 0; i < ocv_curve_size; i++) {
>> +		ret = sprintf(buf, "%sOCV_%d=%d\nCAP_%d=%d\n", buf, i,
>> +			      ocv_curve[i].ocv, i, ocv_curve[i].capacity);
>> +		if (ret)
>> +			status = ret;
>> +	}
>> +
>> +	return status;
>> +}
>> +
>> +static DEVICE_ATTR_RO(ocv_curve);
>> +
>> +static ssize_t temperature_sense_current_show(struct device *dev,
>> +					      struct device_attribute *attr,
>> +					      char *buf)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	int status;
>> +
>> +	int sense_current;
>> +
>> +	axp20x_battery_get_temperature_sense_current(axp20x_batt, &sense_current);
>> +	status = sprintf(buf, "%d\n", sense_current);
>> +
>> +	return status;
>> +}
>> +
>> +static ssize_t temperature_sense_current_store(struct device *dev,
>> +					       struct device_attribute *attr,
>> +					       const char *buf, size_t count)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	unsigned long value;
>> +	int status;
>> +
>> +	status = kstrtoul(buf, 0, &value);
>> +	if (status)
>> +		return status;
>> +
>> +	status = axp20x_battery_set_temperature_sense_current(axp20x_batt, value);
>> +	if (status)
>> +		return status;
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(temperature_sense_current);
>> +
>> +static ssize_t temperature_sense_rate_show(struct device *dev,
>> +					   struct device_attribute *attr,
>> +					   char *buf)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	int status;
>> +
>> +	int sense_rate;
>> +
>> +	axp20x_battery_get_temperature_sense_rate(axp20x_batt, &sense_rate);
>> +	status = sprintf(buf, "%d\n", sense_rate);
>> +
>> +	return status;
>> +}
>> +
>> +static ssize_t temperature_sense_rate_store(struct device *dev,
>> +					    struct device_attribute *attr,
>> +					    const char *buf, size_t count)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	unsigned long value;
>> +	int status;
>> +
>> +	status = kstrtoul(buf, 0, &value);
>> +	if (status)
>> +		return status;
>> +
>> +	status = axp20x_battery_set_temperature_sense_rate(axp20x_batt, value);
>> +	if (status)
>> +		return status;
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(temperature_sense_rate);
>> +
>> +static ssize_t temperature_sense_voltage_now_show(struct device *dev,
>> +						  struct device_attribute *attr,
>> +						  char *buf)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	int status;
>> +
>> +	int voltage;
>> +
>> +	axp20x_battery_get_temp_sense_voltage_now(axp20x_batt, &voltage);
>> +	status = sprintf(buf, "%d\n", voltage);
>> +
>> +	return status;
>> +}
>> +
>> +static DEVICE_ATTR_RO(temperature_sense_voltage_now);
>> +
>> +static ssize_t temperature_discharge_threshold_voltage_range_show(struct device *dev,
>> +								  struct device_attribute *attr,
>> +								  char *buf)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	int status;
>> +
>> +	int min_voltage, max_voltage;
>> +
>> +	axp20x_battery_get_temperature_discharge_voltage_min(axp20x_batt,
>> +							     &min_voltage);
>> +	axp20x_battery_get_temperature_discharge_voltage_max(axp20x_batt,
>> +							     &max_voltage);
>> +
>> +	status = sprintf(buf, "MIN=%d\nMAX=%d\n", min_voltage, max_voltage);
>> +
>> +	return status;
>> +}
>> +
>> +static DEVICE_ATTR_RO(temperature_discharge_threshold_voltage_range);
>> +
>> +static ssize_t temperature_charge_threshold_voltage_range_show(struct device *dev,
>> +							       struct device_attribute *attr,
>> +							       char *buf)
>> +{
>> +	struct power_supply *psy = dev_get_drvdata(dev);
>> +	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
>> +	int status;
>> +
>> +	int min_voltage, max_voltage;
>> +
>> +	axp20x_battery_get_temperature_charge_voltage_min(axp20x_batt,
>> +							  &min_voltage);
>> +	axp20x_battery_get_temperature_charge_voltage_max(axp20x_batt,
>> +							  &max_voltage);
>> +
>> +	status = sprintf(buf, "MIN=%d\nMAX=%d\n", min_voltage, max_voltage);
>> +
>> +	return status;
>> +}
>> +
>> +static DEVICE_ATTR_RO(temperature_charge_threshold_voltage_range);
>> +
>> +static struct attribute *axp20x_batt_attrs[] = {
>> +	&dev_attr_voltage_low_alert_level1.attr,
>> +	&dev_attr_voltage_low_alert_level2.attr,
>> +	&dev_attr_ocv_curve.attr,
>> +	&dev_attr_temperature_sense_current.attr,
>> +	&dev_attr_temperature_sense_rate.attr,
>> +	&dev_attr_temperature_sense_voltage_now.attr,
>> +	&dev_attr_temperature_discharge_threshold_voltage_range.attr,
>> +	&dev_attr_temperature_charge_threshold_voltage_range.attr,
>> +	NULL,
>> +};
>> +
>> +ATTRIBUTE_GROUPS(axp20x_batt);
>> +
>> +/* -- Custom attributes END ------------------------------------------------- */
>> +
>>  static const struct power_supply_desc axp20x_batt_ps_desc = {
>>  	.name = "axp20x-battery",
>>  	.type = POWER_SUPPLY_TYPE_BATTERY,
>> @@ -520,6 +1241,9 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
>>  	.set_property = axp20x_battery_set_prop,
>>  };
>>  
>> +static const char * const irq_names[] = { "BATT_PLUGIN", "BATT_REMOVAL", "CHARG",
>> +					  "CHARG_DONE", NULL };
>> +
>>  static const struct axp_data axp209_data = {
>>  	.ccc_scale = 100000,
>>  	.ccc_offset = 300000,
>> @@ -559,10 +1283,12 @@ MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
>>  
>>  static int axp20x_power_probe(struct platform_device *pdev)
>>  {
>> +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>>  	struct axp20x_batt_ps *axp20x_batt;
>>  	struct power_supply_config psy_cfg = {};
>>  	struct power_supply_battery_info info;
>>  	struct device *dev = &pdev->dev;
>> +	int i, irq, ret = 0;
>>  
>>  	if (!of_device_is_available(pdev->dev.of_node))
>>  		return -ENODEV;
>> @@ -602,6 +1328,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
>>  
>>  	psy_cfg.drv_data = axp20x_batt;
>>  	psy_cfg.of_node = pdev->dev.of_node;
>> +	psy_cfg.attr_grp = axp20x_batt_groups;
>>  
>>  	axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
>>  
>> @@ -615,14 +1342,105 @@ static int axp20x_power_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
>> +		struct device_node *battery_np;
>> +
>>  		int vmin = info.voltage_min_design_uv;
>> +		int vmax = info.voltage_max_design_uv;
>>  		int ccc = info.constant_charge_current_max_ua;
>> +		struct power_supply_battery_ocv_table ocv_table[AXP20X_OCV_MAX+1];
>> +		int ocv_table_size = 0;
>> +		int lvl1 = 0;
>> +		int lvl2 = 0;
>> +		int temp_sense_current = 0;
>> +		int temp_sense_rate = 0;
>> +		int temp_discharge_min = -1;
>> +		int temp_discharge_max = -1;
>> +		int temp_charge_min = -1;
>> +		int temp_charge_max = -1;
>> +
>> +		int i = 0, j = 0;
>> +		bool too_many_ocv_tables = false;
>> +		bool too_many_ocv_values = false;
>> +		bool ocv_values_mismatch = false;
>> +
>> +		battery_np = of_parse_phandle(axp20x_batt->batt->of_node,
>> +					      "monitored-battery", 0);
>> +
>> +		of_property_read_u32(battery_np, "low-voltage-level1-microvolt",
>> +				     &lvl1);
>> +		of_property_read_u32(battery_np, "low-voltage-level2-microvolt",
>> +				     &lvl2);
>> +		of_property_read_u32(battery_np, "temperature-sense-current-microamp",
>> +				     &temp_sense_current);
>> +		of_property_read_u32(battery_np, "temperature-sense-rate-hertz",
>> +				     &temp_sense_rate);
>> +
>> +		of_property_read_u32_index(battery_np, "temperature-discharge-range-microvolt",
>> +					   0, &temp_discharge_min);
>> +		of_property_read_u32_index(battery_np, "temperature-discharge-range-microvolt",
>> +					   1, &temp_discharge_max);
>> +
>> +		of_property_read_u32_index(battery_np, "temperature-charge-range-microvolt",
>> +					   0, &temp_charge_min);
>> +		of_property_read_u32_index(battery_np, "temperature-charge-range-microvolt",
>> +					   1, &temp_charge_max);
>>  
>>  		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
>>  							      vmin))
>>  			dev_err(&pdev->dev,
>>  				"couldn't set voltage_min_design\n");
>>  
>> +		if (vmax > 0 && axp20x_battery_set_max_voltage(axp20x_batt,
>> +							       vmax))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set voltage_max_design\n");
>> +
>> +		if (lvl1 > 0 && axp20x_battery_set_voltage_low_alert1(axp20x_batt,
>> +								      lvl1))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set voltage_low_alert_level1\n");
>> +
>> +		if (lvl2 > 0 && axp20x_battery_set_voltage_low_alert2(axp20x_batt,
>> +								      lvl2))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set voltage_low_alert_level2\n");
>> +
>> +		if (temp_sense_current > 0 &&
>> +		    axp20x_battery_set_temperature_sense_current(axp20x_batt,
>> +								 temp_sense_current))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set temperature_sense_current\n");
>> +
>> +		if (temp_sense_rate > 0 &&
>> +		    axp20x_battery_set_temperature_sense_rate(axp20x_batt,
>> +							      temp_sense_rate))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set temperature_sense_rate\n");
>> +
>> +		if (temp_discharge_min >= 0 &&
>> +		    axp20x_battery_set_temperature_discharge_voltage_min(axp20x_batt,
>> +									 temp_discharge_min))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set temperature_sense_rate\n");
>> +
>> +		if (temp_discharge_max >= 0 &&
>> +		    axp20x_battery_set_temperature_discharge_voltage_max(axp20x_batt,
>> +									 temp_discharge_max))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set temperature_sense_rate\n");
>> +
>> +		if (temp_charge_min >= 0 &&
>> +		    axp20x_battery_set_temperature_charge_voltage_min(axp20x_batt,
>> +								      temp_charge_min))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set temperature_sense_rate\n");
>> +
>> +		if (temp_charge_max >= 0 &&
>> +		    axp20x_battery_set_temperature_charge_voltage_max(axp20x_batt,
>> +								      temp_charge_max))
>> +			dev_err(&pdev->dev,
>> +				"couldn't set temperature_sense_rate\n");
>> +
>>  		/* Set max to unverified value to be able to set CCC */
>>  		axp20x_batt->max_ccc = ccc;
>>  
>> @@ -634,6 +1452,57 @@ static int axp20x_power_probe(struct platform_device *pdev)
>>  			axp20x_batt->max_ccc = ccc;
>>  			axp20x_set_constant_charge_current(axp20x_batt, ccc);
>>  		}
>> +
>> +		too_many_ocv_tables = false;
>> +		too_many_ocv_values = false;
>> +		ocv_values_mismatch = false;
>> +		for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
>> +			if (info.ocv_table_size[i] == -EINVAL ||
>> +			   info.ocv_temp[i] == -EINVAL ||
>> +			   info.ocv_table[i] == NULL)
>> +				continue;
>> +
>> +			if (info.ocv_table_size[i] > (AXP20X_OCV_MAX+1)) {
>> +				too_many_ocv_values = true;
>> +				dev_err(&pdev->dev, "Too many values in ocv table, only %d values are supported",
>> +					AXP20X_OCV_MAX + 1);
>> +				break;
>> +			}
>> +
>> +			if (i > 0) {
>> +				too_many_ocv_tables = true;
>> +				dev_err(&pdev->dev, "Only one ocv table is supported");
>> +				break;
>> +			}
>> +
>> +			for (j = 0; j < info.ocv_table_size[i]; j++) {
>> +				if (info.ocv_table[i][j].ocv != axp20x_ocv_values_uV[j]) {
>> +					ocv_values_mismatch = true;
>> +					break;
>> +				}
>> +			}
>> +
>> +			if (ocv_values_mismatch) {
>> +				dev_err(&pdev->dev, "ocv tables missmatches requirements");
>> +				dev_info(&pdev->dev, "ocv table requires following ocv values in that order:");
>> +				for (j = 0; j < AXP20X_OCV_MAX+1; j++) {
>> +					dev_info(&pdev->dev, "%d uV",
>> +						 axp20x_ocv_values_uV[j]);
>> +				}
>> +				break;
>> +			}
>> +
>> +			ocv_table_size = info.ocv_table_size[i];
>> +			for (j = 0; j < info.ocv_table_size[i]; j++)
>> +				ocv_table[j] = info.ocv_table[i][j];
>> +
>> +		}
>> +
>> +		if (!too_many_ocv_tables && !too_many_ocv_values &&
>> +		    !ocv_values_mismatch)
>> +			axp20x_battery_set_ocv_table(axp20x_batt, ocv_table,
>> +						     ocv_table_size);
>> +
>>  	}
>>  
>>  	/*
>> @@ -643,13 +1512,70 @@ static int axp20x_power_probe(struct platform_device *pdev)
>>  	axp20x_get_constant_charge_current(axp20x_batt,
>>  					   &axp20x_batt->max_ccc);
>>  
>> +	/* Request irqs after registering, as irqs may trigger immediately */
>> +	for (i = 0; irq_names[i]; i++) {
>> +		irq = platform_get_irq_byname(pdev, irq_names[i]);
>> +		if (irq < 0) {
>> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
>> +				 irq_names[i], irq);
>> +			continue;
>> +		}
>> +		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>> +		ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +						   axp20x_battery_power_irq, 0,
>> +						   DRVNAME, axp20x_batt);
>> +		if (ret < 0)
>> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
>> +				 irq_names[i], ret);
>> +	}
>> +
>> +	irq = platform_get_irq_byname(pdev, "LOW_PWR_LVL1");
>> +	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   axp20x_battery_low_voltage_alert1_irq,
>> +					   0, DRVNAME, axp20x_batt);
>> +
>> +	if (ret < 0)
>> +		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_LOW_PWR_LVL1 IRQ: %d\n",
>> +			 ret);
>> +
>> +	irq = platform_get_irq_byname(pdev, "LOW_PWR_LVL2");
>> +	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   axp20x_battery_low_voltage_alert2_irq,
>> +					   0, DRVNAME, axp20x_batt);
>> +
>> +	if (ret < 0)
>> +		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_LOW_PWR_LVL2 IRQ: %d\n",
>> +			 ret);
>> +
>> +	irq = platform_get_irq_byname(pdev, "BATT_TEMP_LOW");
>> +	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   axp20x_battery_temperature_low_irq,
>> +					   0, DRVNAME, axp20x_batt);
>> +
>> +	if (ret < 0)
>> +		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_BATT_TEMP_LOW IRQ: %d\n",
>> +			 ret);
>> +
>> +	irq = platform_get_irq_byname(pdev, "BATT_TEMP_HIGH");
>> +	irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   axp20x_battery_temperature_high_irq,
>> +					   0, DRVNAME, axp20x_batt);
>> +
>> +	if (ret < 0)
>> +		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_BATT_TEMP_HIGH IRQ: %d\n",
>> +			 ret);
>> +
>>  	return 0;
>>  }
>>  
>>  static struct platform_driver axp20x_batt_driver = {
>>  	.probe    = axp20x_power_probe,
>>  	.driver   = {
>> -		.name  = "axp20x-battery-power-supply",
>> +		.name  = DRVNAME,
>>  		.of_match_table = axp20x_battery_ps_id,
>>  	},
>>  };
>> -- 
>> 2.25.1
>>
