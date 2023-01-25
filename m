Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4944B67BE05
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 22:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjAYVTC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 16:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbjAYVSj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 16:18:39 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12985233D4;
        Wed, 25 Jan 2023 13:18:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8DBDpYLgfqF/GCYD/B/SRrXgnGDhS7K9LFZfgiDzE8JoRtbgC7w7KewgQpbrjCdLQC8MAKTXo3C6oe4b1Z6jzyg7aTVzqFUhVcKfQsmMv9ijyBPZyFrPEYQYowFbnQ8E/Tc/+sLyzwWX6vxmuE2Dmd5E4m0apR6+sBmJptRUG8JI8oWXCOYkca9KLT+7K+ZRwQuZtHV4nS0q2NWC0oXpqdyFIDlsCJDP0/3FydwW62go4IsigwRzzahpyZ4JiHoXBastFBJ3J6I6O5scbRaT3Nl4CJI24luwuhz2nM3YTAHBXr6Q4suHi0hGxEksbdR37KJE4cAEZkkU6KZuqJtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmbUlzHKAh3Uqad6ludZbhbf/Bg+8osp/ey5kCFB4xQ=;
 b=IzVUZpEp9mTfuxI9Xr35e8iFULfjql/+U5szQU2+BRzg+kKsT5l6hI8JkPwAh+75u7iZwPMeK7an+ieHg6lbnk7YWtsybMTteyUXy9J3HwXJcEIRzI/D5sN19n+H17uLvVPUvig2+bDDkVzFP26MDq6RUTxDglMDtLwDufgVGKS3gRgq9CIuiHlOomShRRm35t6eNfqfrFV7MMw1Elt535iSv7zykYetRlRVYgWxHft3f53iszSe8Sy+74YW23mTFnIY0cF5QZUDJtacOl+ghUg8Pymz/4veaCthllaWwn1KWwZMhfpduLdMoh2rI7MkxissjfkYtfaACaCZLi1O6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmbUlzHKAh3Uqad6ludZbhbf/Bg+8osp/ey5kCFB4xQ=;
 b=r2BcdXpKJQfZe2r0VDzUyvgMfJGZ3v7Ci1+HcJf0nAK4Jk9IDTgS1CLbYRYC5JtrBjOnkhnZ8po+Bio+cfdZkc/6yT4+i+pkRK4AAmc7BnBKt0OgxcggvF41Qd+WN9AYlMl2Vi5WEAQ3F3fqPspPXODxE4hl1rAwLQoesiuLWhL/3huNqg8izOqa+FlkZkg+SlgjqU1f5tE8q1Y7Ktpw+N3qJ+zB1I1cZg29pTsyaIrN3XbgwQ6bJD+vYYkAelOI6abHfyoHFNfNzwsdhhTwb4LlGUQyVDO/EeXeOpm3wkyq4LF8HbqF6AgwdZ8/Yr3lVErBHcJ82BAxz6T10y5vtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 21:18:16 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%4]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 21:18:16 +0000
Message-ID: <a7236fc5-4081-0ffa-ba4c-c25bb35854e3@nvidia.com>
Date:   Wed, 25 Jan 2023 21:18:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Add Tegra234 BPMP thermal zones
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
References: <20230124115119.21451-1-jonathanh@nvidia.com>
 <20230125202645.GA2849386-robh@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230125202645.GA2849386-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0350.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 601676c6-a7e0-4458-731a-08daff19ac44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGQ0yGBDCJEo/mm6tSZ0jgXriXYl0PUWMP2nqHFArrx9W/kg6fcnbPUsn1vo9WwDnXumFKtDuKg8c2QfyyGsgq5xGyg0/RoDxTEmT5Yz/B4XdOCotCMtAu62vv80DdMEwuEyU1n9qith7wtNgqqHm4iiWZzstkBznr3yETJGWXLLyM3Oe/DD4nR7zLT3XOo/dpa9TauENoUXxeP+kLJd++4KSmaAR/Aywq3EuVX0P6kYglVZi9m+BimYdYlz7ko8FJMLYXKp5Mb4eQENBIoLfiLV6Gnw0eHcQDz/S73QzjPCbGMGLoeiusOLYkdYbml2QcQHADNl4PKTmrEjupCBwyJrgmMaqTXjvKx/WQF05rzD3No+Rfab70ZRzPAd4ZtJZP5umLYQSdkhu/6siiQL7ZkyQf/1lvXr0WxQZlsgQ1/lwjqL8gvMWIcj35uC+LntrxdfVWjxd6Bz9ya+ga420kCjNe0Ow2bxQJR6RD4R3P/hDIqBaAGn6ZQ5PKVZ1Gp1c49ptyonusHuJmlcGcI7DGXzDyRk22u8ek5GZYDZyqt4MGP2giHF0IBn7vCcHqbrvhRVl1xegIkoFjkz1cFNf6cV3ThL/Rq9HtH0hnFp00RT8ffC86XwWSS7B/RWqQPIkPyVWu0So21P/Lh1vFIkZ/QcLq7HOENSb6mwx27eCE2vhX4Af4MU+EaXgShgMxzZIWzLSAFiCBbCHjnZieBiUpHyh1O0xHYP/joQ9O56H+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(31696002)(4326008)(66946007)(66476007)(316002)(86362001)(36756003)(6916009)(5660300002)(31686004)(2906002)(2616005)(41300700001)(38100700002)(8936002)(53546011)(6506007)(6666004)(8676002)(6512007)(186003)(107886003)(66556008)(54906003)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEFtaFVVNUhUWTc0dXlubnN2SVZ5WjhUS2NDWFRCQm9FNTFxa0E0SXNWcS8y?=
 =?utf-8?B?N24xZE9reHVyWjBkMVF1aklQbUZlZnAyMjJXOVVHY0cyTUg4djFYT1JGeWFC?=
 =?utf-8?B?bXZNc0hENEJTcCtoMlk4NXRuNjhXREc1aXR4cjI3S1BFeFlBTnJiekxuTm5U?=
 =?utf-8?B?akpRaFBDNDQ0YWJjd0xzc2pOZTFOUmpuVjR4WmR1UnU0OEJFTlZyQklKWFNF?=
 =?utf-8?B?NktSUXJ0aEUzbVFvNVdhdU9nTklVeGlBUmlaQXFkcS9HYzU3WXJuUGc2bml0?=
 =?utf-8?B?QUZLd282RTJEQ1Q4RXNLMlJxRDJLUEYzYmNVVzQ2YzI3ZGhXYjNrRHZDUUJa?=
 =?utf-8?B?dHpsR21MdDNhRnJobHpLQ1ZmOVI5UFV0cXdXNTQ2cC9OL2pnclJGUnVXSDc0?=
 =?utf-8?B?RTY3ajVuQkdkZ0FRclFMQ3BPV0ZmUVVKV3lTRFRNbHlyZ0xucEJ4WnNwdUZS?=
 =?utf-8?B?YzdIVDd3ek94c25MajVRdS82aytZSFFINEgvN2lWZzBNNmNkbzR1K1NyZWNs?=
 =?utf-8?B?UllUY3Z3Z0RoYWgrTXZWckpOdnJvK0hIeHdsL1VvM2kxUjJPYkhMMjJVK0ZO?=
 =?utf-8?B?NVMrV09jV0Vhb1FCWitjd05DazNhdEwrQnpadml3R3ZhNE5XMWdScFV1UGpP?=
 =?utf-8?B?ZHZpSTJPY3JKZCtKZUFoQm0rUkVkMmllS092RE1kMEc2U0tRRStxdnprMFZB?=
 =?utf-8?B?R09PSFBGeVlZME1QOUw4K1RmdTVJcG1ZV2drOENHTCtybWFXMnFnMlRmNEhh?=
 =?utf-8?B?bUs1T20vSlNlS0R2MWZidFVlTDNyWGo2TDRadGJwT1V4cVNSSlBORHVWR0Fl?=
 =?utf-8?B?eHJmY1hlaVB1QXd2YllSZVFJUzQvOVNGK01hWWxRZ0FOdHRzU05GdDFHcXJN?=
 =?utf-8?B?MjI2eGxWdUYvZktjZ0dEMDhIZFd2ZldWMFpvSHRYamdUTkZvMGdsUjV5WW5j?=
 =?utf-8?B?NTZjdFZjTGhDUWhmbnlELzBSS3p4NXdFWm1mY1l0Qkk5VDBOOWkwb3lnQTlQ?=
 =?utf-8?B?WDdaNDNKU1d1UlhoSTJKSk5kYmVqOWJsYmgvVFJGYkpYVWpiRURZSWYyTDZ1?=
 =?utf-8?B?eXI2Sm1EYzBORVdQeE9WRXpxMjFJdURreGl3Y0lUaWxDWmtUQUtwQVBVMi9L?=
 =?utf-8?B?LzN3RVZTRzFtU1RPVEhPbnVvaWRKNkx1MWtvTytwdVJlcUJGR2YwcFRscklE?=
 =?utf-8?B?aVo0YTRSN2JOTnpaYWFKWVdsSVFZRlBzV2gyTjJIWHhycU5NRWZVUGRLUFlF?=
 =?utf-8?B?a1U2RHkrRVJrcU9Rc2pOZXhtV0ViMXVseFU5UERWMVJtRXdZamJlRTdiTThn?=
 =?utf-8?B?L0J4MjZRUzREQzBjekJoaU1CeFlLa24yemtwM05tc0pxem5lOERmTitMc3g2?=
 =?utf-8?B?Z2JXR3FqYWluK1Buc3NLRTFaMHBFMG5MQ1BoUWlkK3N0eTRMYkMzU0F4YUR5?=
 =?utf-8?B?TXc0UnAyeGhxY0phUkpYWGJBWTM2QmJoNnNmRUIvRFlxbE0xS2xXMmxBcXBN?=
 =?utf-8?B?N3lwZVptZ0ZmMmFVS3RtNzNSZTdQOFFJTmdRZTdnWWUxOGRNRXFnOHU1UlJh?=
 =?utf-8?B?bDlTMFpMbSs2Mk84ZVQ3L3hFQmpjRm9Ca3M2RkdrRm9XWlN6WDBPOUFEZXNR?=
 =?utf-8?B?aGNGaXB1NXZpcGZ2N25EWTBXR1lBeEtwUjNFRmJvMGlMZjlQMG5JYVY3dEYz?=
 =?utf-8?B?M0ErMW1LWlE5RElmRWhUZGtKODNHM3VlejAwRjFqZlp5VCtWbGViME5STEpH?=
 =?utf-8?B?aktVWWZxci80T1NoZEVGSkYyODFlWGc1Z0JiampoNkdBUnh3YzJjL3JSV2NB?=
 =?utf-8?B?bmFJVldLMDAwVVJzTi9yWTRQbmNpV3BrejdPekRlMEdnN1RkZUw1a0Q2VUho?=
 =?utf-8?B?RDRVaUR1QjJmeGdWV2lZbUU1Y0Z5U0JUcXpjMHFqZWZiR2xrVFRBOHZSUXdR?=
 =?utf-8?B?NFQydHh2Z0ZzRkc1YkozQ3ArbGUxdHJmWjU3RWVLZWViUEltazdKd0Y2Z2lZ?=
 =?utf-8?B?R2tnOG5BTjQzd0NnZSs0ZUlLYzNvbGhtdnRnQTRzMGNXRmE3Zkxncjg1OFZL?=
 =?utf-8?B?Z1U4YWtBa1kyV2FqMHlHdDNYTXRUT2xRMXlmVG4xT3U4bTNrSlhoNkNzYnMr?=
 =?utf-8?B?NnRValZoYlhNWjB5V05RNG4zdmR2dVNUaEJmdlhiOUhwZG9mSmNWVW1UQUJ6?=
 =?utf-8?B?K3g1U005UWViODVWNnRRbHkrUWhIb01zT3ptbVYzR1dyWFIvWENMZWdubk5F?=
 =?utf-8?B?OTF0Tm93dTFiRXVCMGJhSFdvRFJ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601676c6-a7e0-4458-731a-08daff19ac44
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 21:18:15.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2Z2TWz7fv6rTCV2AG+Jga+Sn6S95EsEOXqFgkMzHKV2JgWhwEiM8I8HbqAv0h27wzVBPXj105nGHTE46NDklg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 25/01/2023 20:26, Rob Herring wrote:
> On Tue, Jan 24, 2023 at 11:51:18AM +0000, Jon Hunter wrote:
>> From: Yi-Wei Wang <yiweiw@nvidia.com>
>>
>> Add BPMP thermal zone definitions for Tegra234.
>>
>> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>   .../thermal/tegra234-bpmp-thermal.h           | 19 +++++++++++++++++++
> 
> Match the compatible name please.

OK, but to be clear, the compatible string is 
'nvidia,tegra186-bpmp-thermal'. So should 'tegra186-bpmp-thermal.h', 
'tegra194-bpmp- thermal.h' and this file be combined into a single filed 
called 'nvidia,tegra186-bpmp-thermal.h'?

> 
>>   1 file changed, 19 insertions(+)
>>   create mode 100644 include/dt-bindings/thermal/tegra234-bpmp-thermal.h
>>
>> diff --git a/include/dt-bindings/thermal/tegra234-bpmp-thermal.h b/include/dt-bindings/thermal/tegra234-bpmp-thermal.h
>> new file mode 100644
>> index 000000000000..41a5efebcc7a
>> --- /dev/null
>> +++ b/include/dt-bindings/thermal/tegra234-bpmp-thermal.h
>> @@ -0,0 +1,19 @@
> 
> License? Dual please.

Yes will fix this.

Thanks
Jon

-- 
nvpublic
