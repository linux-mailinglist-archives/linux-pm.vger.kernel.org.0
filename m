Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64643B6EF5
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhF2HvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 03:51:01 -0400
Received: from mail-eopbgr150092.outbound.protection.outlook.com ([40.107.15.92]:9226
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232327AbhF2HvA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Jun 2021 03:51:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTSgAMADNGor+ccVnw0b5dBYDC1N83DfjvvT86V2YtBpiDRgSVifEHdEmUMrffpeiy664jnJLtqMA0HmlumZ3HDDwgXD1tBotP1s45w5kYLYt382XsOCtT0c7AKxexaXWp3MMe2n4n+BsLzT4f1Zk6YFOvQopKofncHpS6242Sm7M88jyED+czcalgID3ta710nfKkMhKt9Sxuo3HTQnMRX682Sypq1+nWgu2PPHPOcvsf9vyQHuIIhWVSTgPjHZSMzqEzW6moGd0XAMxuRdwJEZkpOTq4aOjM4VvlMcBgNwtXIote8HSTf5sH2zKqILPE3Y2bsKNpQ9DVMfb7isaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEYKhrb/qdLzdPtHWiHSEQsJyxWtcal6B/8TLappXTo=;
 b=Gs8mEgsRkk2bTvDsTfm09BI3rit6OxYxXI1PHV0/OSNiKWSTE6347ELetNg9gmnsQK7l2Oth++CYTN91v7asFxrzyNSHm7IIJqGwrS/CJBsGZvvdetxc4EEtCuixJuYWRz1GrGHOriCr37E8M8ZLw9Um7h1DfFmv8ZXHy3FLdahwqyn5gnDKAdVwa5cINHBlHlTp/KnzApK4GeFSFSSVRZwKtDLNWb6pXOJ9F9xi14EfgH3pBI2KQAoglnUxXZImSKhtRaO7U3LB/D1bAakxdSbBk8RKiQF0Mvib4kJHHVZ4GqyQAEldJZXRsa+/vMyvBIHccE6A1slFEb6fmqIFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEYKhrb/qdLzdPtHWiHSEQsJyxWtcal6B/8TLappXTo=;
 b=iEVV3JFG9+nAumU2amu5NvymfBLmXzFklBdxGciyKS47tuFQqmJ3E29XxcNmmc06Cw/wln+G5zhLP5iA3GCenasHhaS9VdcFzcb/6Q39t9xgJERiTezFIxeJ7OZCzDmjZZltyPF4qnCHdbw1mFdxdcs7tMHIJlnTbu6k/9bS1qs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 07:48:32 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:48:32 +0000
Subject: Re: [PATCH 1/4] arm64: dts: imx8mm-venice-gw700x: override thermal
 cfg for industrial temp
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jacky Bai <ping.bai@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20210601174917.1979-1-tharvey@gateworks.com>
 <b63300e8-3739-fcc6-6d37-952f93cfd17b@kontron.de>
 <CAJ+vNU0mBQJ_ZLsKOiY0k7+drYvmw+bsHfeX4+Mg=s4_fxSUYA@mail.gmail.com>
 <5eba4438-239c-71d1-56ec-4edd70e87ec3@kontron.de>
 <DBBPR04MB79303661E07409B4B65F3EF487389@DBBPR04MB7930.eurprd04.prod.outlook.com>
 <273e2859-7874-e273-9599-139274891023@kontron.de>
 <DBBPR04MB7930943628D1E80C17237D8187389@DBBPR04MB7930.eurprd04.prod.outlook.com>
 <717608d8-685a-0435-aaa2-3bd4f82f3b97@kontron.de>
 <CAJ+vNU1bj6VtVSo45tG4nP8Pv9rx4oDyxNKZB2zAX85Y2c7=pg@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <7e148de0-a23d-a433-372f-861946416859@kontron.de>
Date:   Tue, 29 Jun 2021 09:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CAJ+vNU1bj6VtVSo45tG4nP8Pv9rx4oDyxNKZB2zAX85Y2c7=pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [46.142.64.5]
X-ClientProxiedBy: PR0P264CA0143.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::35) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.32] (46.142.64.5) by PR0P264CA0143.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Tue, 29 Jun 2021 07:48:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a05a732a-7e3d-439a-fe7d-08d93ad24ab6
X-MS-TrafficTypeDiagnostic: AM8PR10MB4626:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4626C26DBBA011B509B537FEE9029@AM8PR10MB4626.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHe7Q082hEIft0uWsFGxYo5fn5RYs6s0xNgIC5spHWTJnvTglf/9XUmwkSZaMGwD5rDQC2sedM/m3iDJjOeKnYNrZNysmz0HP1CUPv6WVvendKM1ujH/1rY7eCkdztDOwxSARN0cTPW6cnwVFLTgAZOV8fFwrcYX3l8a5OwUYOZQGQFXUXDz3fsoK0ZdVaIpIF0rr2KTL60/TknKm5uNwCV7ZBY+yBukYMU8kGpMxk2z/cl7xqFJL+r1DmPCd+eBAR1xb3sRA3rD5DfzQj3z1/S8XrU9Fy0rOFq4K8SUV8X3ygcC1svbV5ru+WYWwdrTatvm51BhLgBOBToohfx6f3u+tsaFDCoRjhKbgI4AlAvwbEsjDqKO1xt568rSxupJSQmaIKpZN/3LzQ6fIq5TPUYDJDvEliu5817ncXUPvaUrPeyw4BJDjqBoDQfAB9qmAXkWFNxvJZaxdCKpuH+gn6JiYFCtA2Rahqjlo2m4cPu5spG0/wsiF2rzy0wKfDBIKEuA7EDQ4x4TtNNd5k6yizW0MIouXm4PK4Kabhdgj1iROdSsAtWWabCLgJC7iwVhStuxRxA4YDFs/0WujLXXPSBB7yUmr3AO0ZVd22eXa/qOMuxv95Jw8m1M56RUF+7RiPy1dSMAFzl8PdYezJsxVCGY8GxxPEhlvVFd8wH9+vtC42pV5sd2hTTLkyRfFvdb9css1VvKp3goT8qkplhsVsGQQZetqSivZ43L8zfsp6aOnfjzIlHxzIjkAOfCwx1Pexft8f/F119brA6Y1B/IBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39850400004)(16526019)(53546011)(186003)(7416002)(54906003)(36756003)(66946007)(16576012)(26005)(44832011)(6916009)(316002)(38100700002)(8936002)(6486002)(86362001)(83380400001)(2906002)(31686004)(2616005)(8676002)(5660300002)(956004)(478600001)(4326008)(31696002)(66476007)(66556008)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEhQd1JGNXhEeHN3VkFMMHdlMUhONnRXWlFrSlY4Z1VtK2RvSm9XcC9paW9n?=
 =?utf-8?B?WUdEVGpqMUJ5OWNpTnVxTHNuYXNGT0xBcit1YnJqeTBWUzRjUzNBT2xocnR2?=
 =?utf-8?B?KzFtaUcxdC9mZllQQXh0a0tuU0NrYmdPTnZkaEFhNHp3UHVpakh4K3pFZFJL?=
 =?utf-8?B?ZGxlMGcybWMvME1yYkErb09tR1I3K1BjK0tiSVNkQnR0V3F4UHNuVXlZS281?=
 =?utf-8?B?QUpqLzZkZW03OGloSHBxV2Z1ckRUMURIQVR1ZVJjeFI5dmpoc3JaekVXRnh1?=
 =?utf-8?B?dWtkMHRsRUlMN1g3ajlQQjdTK2wwRGhFamdGOFYwdzRyTlBjS2VjMnNVZmFQ?=
 =?utf-8?B?R0sxcHowZnAxTzlpUWRIaXV2dmF0VjNtNGRieHhVb2gxbFJJSXo5dkdJSzZS?=
 =?utf-8?B?cjV3eTJUT3A5SnVRa3gzeGtrclpQT2FZMHZWWWdrb3AxWEJ1Rmo0ZVJnUUVF?=
 =?utf-8?B?a3ZvUkVlOXJRZ1dudFF6cFNCZHlodzlpaFoyR1B5QlZBMlF5Nld2S3J0YzVY?=
 =?utf-8?B?ck5zbDFOaGNWSnU5ZkV3OG5WOUpMOWZqQlViTi9rRzQ0dmdxOWpiczVicm04?=
 =?utf-8?B?Y2xudmZ3TXZVWE5lVkhFK2lPZC9CTUYxQ3EzWnp5NGhlOFk1UjdoY0hLR2VO?=
 =?utf-8?B?NWdDT0JiM3NKakEvckF2elNraTRyYm9wL1kzdkpBOHFqUTVXdWFlZmM4bXlH?=
 =?utf-8?B?TVVWMzJyWEpZcE5wWEs4Sk5hRjdHMSt3aksvNUM0VFZPelE1bkYrZ28xSGpN?=
 =?utf-8?B?NjREb2cwSk1DTEN0VU1oeVlITklZTEN6UkRHVjk3MHRBSVhpTjlDS3ROelAv?=
 =?utf-8?B?Z2RRR0xJdFVOWFkxVGlzVjdhSjRsbXpqcUQrN01CcnhmTWRXY1k5NGRJMExt?=
 =?utf-8?B?emk2K0NNS0RONS9jNUQxcXpMK1RpWVdLNWwwVGxEVEsycXpQRFQvck51bklk?=
 =?utf-8?B?cmJaK1pCUnV0YllORWxGbnY0a1R4Nm05TzRUVGtoNkFQWlpwclRhb2hVVDJ3?=
 =?utf-8?B?c3VqN0dpdkJBYjZQZS9zMDFvTi9yUkwxMFU0VUd3blN6QUxhb25ieGRrL1lx?=
 =?utf-8?B?S2g4VzhxOTI0ZnZWT01FUU9RN1RieUYzd1Q5U3BHUlpWZFcwNzFQekVQT3Fh?=
 =?utf-8?B?Z2poTEQ3TmdIWXh6VlplNnZIcXhIb3VXMzRIMHhEQXp4OEwvWURsQWYyZFpm?=
 =?utf-8?B?MmdSa1psSHp3SGZmdUJIWURVU1ZyVVRqVWRDK0ZwY3Z5R1ZXNDExeTN1b1Fr?=
 =?utf-8?B?aG1UM0FySmF5OHp5NUZSdlpZa1dpVnBMbForTktKdWhFTkZKemM3MC9UUEZB?=
 =?utf-8?B?dDBmTnRUT0RydjlNOFVNR0NoM1BvOG9OYzh0YkgwM0RMVnVDbzZrTFlNWm1h?=
 =?utf-8?B?OTVPdGpPcVdnSDNoS3VQK1ZxckVkeTRBcm03cDhBM09CNzJmakRpK2M4NkE0?=
 =?utf-8?B?Y1g5Qk9DM29Sck1QeXdxQkl5REZxbitRZHRIWTU2N3YwNEQyaTVrNXdkY1pt?=
 =?utf-8?B?eGliblVBRW5oeHpCeW15bDN3bW1EVU5zZHpqM0N3SnNoc2dRQ0FmODFyNUxP?=
 =?utf-8?B?NU9VRGFtM0UwejhCWmJlUGJSNDhlRkcrVEFJcCtLRUhVNnpKaTV3dmEwNmt3?=
 =?utf-8?B?YzN5VTZ5TUxzU09tSTFQMllSSmxESWd4TlcranRwTVZtWVJMdVdBVXJrdXM2?=
 =?utf-8?B?NnBiMXpxbHlWaVM3VTFUS0xqZmNEMHpQeThzWmFiWHltZmUvZlMwUE5kbWJ3?=
 =?utf-8?Q?4iDMAebDz3DQJQHl4ug6tW+UtT5hNixXyU8D51q?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a05a732a-7e3d-439a-fe7d-08d93ad24ab6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 07:48:32.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGW6S9fFnq8A0/TSYu5pYJB7ghoXxf0X7gyTJmfa6ZDwpalIB9v7i21aLphSFVBthyBe8ZtnCvyYwBf7+LUCwsSqx3XpUEkXmpqZAf2qCbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4626
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tim,

On 11.06.21 20:55, Tim Harvey wrote:
> On Mon, Jun 7, 2021 at 1:34 AM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>>
>> On 07.06.21 10:00, Jacky Bai wrote:
>>>> Subject: Re: [PATCH 1/4] arm64: dts: imx8mm-venice-gw700x: override
>>>> thermal cfg for industrial temp
>>>>
>>>> On 07.06.21 09:30, Jacky Bai wrote:
>>>>>> Subject: Re: [PATCH 1/4] arm64: dts: imx8mm-venice-gw700x: override
>>>>>> thermal cfg for industrial temp
>>>>>>
>>>>>> On 04.06.21 17:42, Tim Harvey wrote:
>>>>>>> On Wed, Jun 2, 2021 at 12:11 AM Frieder Schrempf
>>>>>>> <frieder.schrempf@kontron.de> wrote:
>>>>>>>>
>>>>>>>> On 01.06.21 19:49, Tim Harvey wrote:
>>>>>>>>> Override the default temperature alert/crit for Industrial temp
>>>>>>>>> IMX8M Mini.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>>>>>>>> ---
>>>>>>>>>  .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi     | 12
>>>>>> ++++++++++++
>>>>>>>>>  1 file changed, 12 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git
>>>>>>>>> a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>>>>>>>>> b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>>>>>>>>> index c769fadbd008..512b76cd7c3b 100644
>>>>>>>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>>>>>>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>>>>>>>>> @@ -493,3 +493,15 @@
>>>>>>>>>               >;
>>>>>>>>>       };
>>>>>>>>>  };
>>>>>>>>> +
>>>>>>>>> +&cpu_alert0 {
>>>>>>>>> +     temperature = <95000>;
>>>>>>>>> +     hysteresis = <2000>;
>>>>>>>>> +     type = "passive";
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +&cpu_crit0 {
>>>>>>>>> +     temperature = <105000>;
>>>>>>>>> +     hysteresis = <2000>;
>>>>>>>>> +     type = "critical";
>>>>>>>>> +};
>>>>>>>>
>>>>>>>> As this is not really board-specific, I think the proper way to
>>>>>>>> handle this for
>>>>>> all boards is to let the thermal driver read the temperature grading
>>>>>> from the OTP fuses and set the trip-points accordingly, similar to
>>>>>> what is done on i.MX6 [1].
>>>>>>>>
>>>>> ...
>>>>>>>
>>>>>>> Frieder,
>>>>>>>
>>>>>>> Yes, I thought about adding that kind of support to imx8mm_thermal.c
>>>>>>> but the difference is that imx8mm has alerts defined by dt and imx6
>>>>>>> does not so is it right to override dt alerts on imx8m? What if
>>>>>>> someone designs a board that they specifically want a lower alert
>>>>>>> than the cpu grade they are using based on something else on the board?
>>>>>>>
>>>>>>> My approach to this was to eventually actually adjust the imx8m dt
>>>>>>> alerts in boot firmware based on some boot firmware setting or
>>>>>>> specific board support and leave the kernel alone.
>>>>>>
>>>>>> Allowing board-specific trip points sounds like a valid request, but
>>>>>> I still think we need a way to handle the temperature grading in the
>>>>>> driver if no board-specific trip-points are given.
>>>>>>
>>>>>> What if we just set the temperature property in the trip nodes in
>>>>>> imx8mm.dtsi to zero? The thermal driver would detect this and setup
>>>>>> the correct values according to the grading. If the dt already
>>>>>> provides non-zero temperature values (through the board dts) the
>>>>>> driver will just leave the values and disregard the grading.
>>>>>>
>>>>>> I think this solution would be covering all needs.
>>>>>
>>>>> I thought to add the grading check in the imx8mm_thermal.c to
>>>>> dynamically set the trip points temp, but it seems hard to do it due
>>>>> to the fact of_thermal is used, as no helper API is exported by of_thermal,
>>>> no better way to override the trip point temp.
>>>>>
>>>>> glad to see any good suggestions.
>>>>
>>>> Right, the driver doesn't handle the trip-points directly. This is all hidden in the
>>>> framework. So this might not be so easy to implement.
>>>>
>>>> What about this other approach: Adding all the possible trip-points for the
>>>> different gradings to the SoC-devicetree and then let the thermal driver
>>>> remove the trip nodes from the dt that are not valid for the detected grading,
>>>> just before the driver registers the sensor/zone.
>>>
>>> It is more reasonable for the firmware/bootloader to handle this by checking the grading.
>>
>> If possible, I would rather like to avoid creating another dependency on bootloader/firmware. I think the kernel should be able to detect the grading by itself and adjust its behavior accordingly. We also do this for the speed grading in cpufreq.
> 
> Frieder and Jacky,
> 
> I'm ok with dropping this dt patch and instead implementing something
> in boot firmware that automatically detects and adjusts there. I'm not
> given the time to work through a more complicated or more elegant
> solution kernel-only approach for this and handling it in the boot
> firmware will not break anything or create a dependence from where we
> currently stand. We already have things in boot firmware that populate
> mac addresses, mtd partition ids, etc in dt during runtime.

From my point of view you can also keep this patch until this is solved properly. Still, in the long run I think we need a solution that automatically handles the different SoC temperature gradings even if of_thermal is used and there is only a single devicetree to describe the SoC variants. It's similar to the case of the CPU's frequency/voltage setpoints in cpufreq.

I'm Cc-ing people from the thermal subsystem. Maybe they have some suggestion or this case has already been discussed elsewhere. 

Best regards
Frieder
