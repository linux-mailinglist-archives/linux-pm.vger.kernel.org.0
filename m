Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48F6A6476
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 01:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCAAwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 19:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCAAwh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 19:52:37 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E62F783;
        Tue, 28 Feb 2023 16:52:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4GzCQYiGuUPJhc9YaM61JBDYU54Uai+vFtRtLayF4JJRKOOzpBEd4jMKUvbkCMV1bMgz/BVZINyvKJ+XVs+JaLXI2FdCeWw9JB2Uk70m/rCikzSlKg8vZ4fpvptyGxyN5R/2VCjk4PRkhCQYgYRTzrdUDWeJLv+yCWwvBAPYCCBYsObDfAbd16Zkl9YeQrZPkLzdW2GcD7bj35CUpF8mWSEsjtdVleLxf0qXJ7CiZQ0X5z29SmRyn86vHHx5UD4eeiNZhrS7eGU+Tc4kvPIXcVnfwoRSnS46gmDbfxN7z0cziHborujIKBWU/w3HoChAnWucvenNEsAyE3g555qFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MBj6e6S0urZsrxnWeu7C0M2khUYGOA7JGmjcRmCcXA=;
 b=VoyIRpIdQ6UNMFpk3IgzgMwDI0DZW4cvrtlMt5wnhKHft9QMUMdUp155fqAFiri5Y67cASg32G+aI5usVfVG3iU1jA0kRnAkeYOKnQX0VqEJSeitz+Ng+QVxhNnvlP1FWLG8Nup/aWUdEL146oX1NXuHK93sR65d4kEsDyb7JTpYLTYGUQ3x2lzrJ1Hyv1eRvv1woYNCvEC6WE14XOj2N6iuETrfGKDxA7hzdSBkZO8W4xJpufq8aBBNrmb9Dnlag8bv8kuU7dpu6agB2BUgW5rKWQGM5P8GJ59X9BmdF4V8il6NMZRoJgowfbdaZOxo/6QByTn5LufdwUaPIR5shQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MBj6e6S0urZsrxnWeu7C0M2khUYGOA7JGmjcRmCcXA=;
 b=Rub78ls3hu4UcqMoWo2BmuY4oTI1T3JOfmj2YeORrDuYPFEJlREmeUFqtMsQAUHwfOn95EwMjAIX5GT2KK6Ka/8tqHpKzk+AnohR+Tdjd95u4v4p4dL0kGS2uUFMTPzb3eRQ+gyOEuNg5P9Hnk8F+SdO3RV90O6dLp1gjlovzGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9673.eurprd04.prod.outlook.com (2603:10a6:10:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 00:52:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 00:52:32 +0000
Message-ID: <435300e5-cfad-83a4-990f-94891a40ddfc@oss.nxp.com>
Date:   Wed, 1 Mar 2023 08:52:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off
 callbacks
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>, Marek Vasut <marex@denx.de>,
        linux-pm@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, Stephen Boyd <swboyd@chromium.org>
References: <20221108013517.749665-1-marex@denx.de>
 <CAPDyKFoUdfUjZMgzU-3SS0gVstj-04FbTSjxihdar2wxu5c97w@mail.gmail.com>
 <52578b45-cf4c-e949-b2b1-a0f251815337@denx.de>
 <CAPDyKFrQ0Uvhsa2AXwTdzOC1xhQ6qjRP=1TzVXC3StLv5FOoBA@mail.gmail.com>
 <cf304d09c26416eb286f03bfe1e292aa8399b349.camel@pengutronix.de>
 <CAPDyKFqONWFj86FbhhGXmxVTMvdwdwWUNLDqEK5gg2-bDitmxg@mail.gmail.com>
 <6d1f2a1a-437e-01b7-cf25-af1a09ce7f3f@oss.nxp.com>
 <CAPDyKFo8ekN3e8kzbtftKuyYY1wv0=gn3L=oz5zBjTebRT84+w@mail.gmail.com>
 <d04c9522-ee19-ec8f-5614-c0a805b8964e@oss.nxp.com>
 <CAPDyKFrzbpF-F2Quxh4QH_HwGc5MbJ=qOcWb-yGQo+WHYNK6PQ@mail.gmail.com>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <CAPDyKFrzbpF-F2Quxh4QH_HwGc5MbJ=qOcWb-yGQo+WHYNK6PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fdc112-0b22-4657-720d-08db19ef3d72
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKKIIWPVCeOyd5fHiKBfwi7FsV6WVqAHVsJSRWKK9xGid3zoh95S36k+F2pn1Y+w/1OSjYz/g88saWrs8ivy+irDyS1SEYL6DHXAr1UmlQb9wuXCwDzjod2c3ONIdCSr2HwEBmryayNZRxPBn7pxg6pEcw9bkKae+8rJ8vWMPjbTZbR0TfeF+31Ctr4KPsNwP1AYLwAEHmuGcE4BvXAlrfoO3SbDA1OBvlcV1T+6GBDG1TSMHYe4re8zJFuIdcvU2c5/MGX0hHylQ6Curoz3KbbOQEWLq3i0j8IsguHX0QbwpDmsHf7qfWFFw+bmJzyFhZdqxOu30U1eUvOuBCwl09ZJXE0edKnpVAKlfOvPWNyMkx4Wfhs5KRlbjhm28PSrHDetuvgFA9CSgfDioPexX3+VOtd3Iq3HHTXkSm9Gl2pWnjdc5iP1R4ZpvUTniU0aMe/R5b0A2pPaklrdR0F1+88XKUspjyaEEWXQ6UUAluGi9D66m8wtJGpPl8orLEx8OPpCFZ2nNxrqCRilYpZ3Bi2whcko1ct98KZlhmv2EOoq9q+7F5Tl7yukC+UrYDFq8k+AyCDqKeipU1gqoxy1S1Kg6HNy13moEyTghApM+QurY13boeW5m3YoO7bcVK3NLUsNoWrT1ibphH15qiEpM/fyP8RCFEjdicYpuPFRn6/xL153QXAoeX/fqoBgPHZaQf7eAUycU5SUf9m0KQepwZAV/Ii9DdKTSPVWGrBWkK/32OA0oU3ZZVvRrIlCx08CwUDSlEDOoj7lUlaNIlnR+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199018)(7416002)(86362001)(31696002)(66946007)(8676002)(5660300002)(8936002)(66476007)(6916009)(44832011)(2906002)(66556008)(41300700001)(38350700002)(4326008)(38100700002)(54906003)(6666004)(31686004)(6486002)(52116002)(478600001)(316002)(2616005)(83380400001)(6512007)(186003)(26005)(6506007)(53546011)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RweTl1S01IOURkQmFUeDZ1V0lJK01CYlpUS2x2SWJsY3ZWYVQxOGlqMUx0?=
 =?utf-8?B?YmJWYURJcmNuRmpCQlM5RnZiK2srTTBHV2dpY3N3VTNTZ3c4Ry9mUndNakxy?=
 =?utf-8?B?dDc5MHY2Uk1CTnV5Y0htM0lXSVhYYng3WHhYWCtsK1JDMEZXM3loL2JyVkhz?=
 =?utf-8?B?NWFXWEtBR2J5bitmSjR5OVFuMFd4a2ExZ0RJb2Y4TFF2QmhLOEtlZkJtcmRK?=
 =?utf-8?B?RGdiOGdWc0NWNjNYMEcwOUR4QmFnc2xML0hKWTV1WHFONWIzMUFKUUN0MHFs?=
 =?utf-8?B?UDlVdEY0Z0pEOHBJYzZ5c2JNWGpEYzVxaDNhckRwZ2NTU2RqTElXT1FhdEFh?=
 =?utf-8?B?eFdmNjZ3bGxHK1Z1MTQyWFhqWE1zdmNveVBDOXVLVjBNTkJQK2NzcjFDRUx3?=
 =?utf-8?B?b256bVNGM0NsVzZTeVJKQ0NIZVRZODVVMHNlUU10Ti9EMDVHOHl3Wkhrc1RR?=
 =?utf-8?B?RUV5ZnhzUWs4WXNvTC96ZTNBZldUYy9lY0h5emNkMkRjcW9iUWx1Qm1jVkJ3?=
 =?utf-8?B?SW5JNkpJNlcxOVh4TDNnd0dMR2ZNSjdZWXNvOVpLSUZzendTR3NQWk92S0RR?=
 =?utf-8?B?endwejlXMXFrbXkyRlQyZ3lQcUJOZ1hDTWU1T3g1Q2hwS0RjbjZsQW5IR1N4?=
 =?utf-8?B?YitlQlZUdjM0VmNjTUNVSDMxUVJaUThNMnB2V2piUy9WU0JxZWliTkJLNnIr?=
 =?utf-8?B?bzdJWSs2NHJBV0dOVGdzdVd2eVhVMkpFMVhzYnFoVEwyOHBOUW5BS2ZoY3Bx?=
 =?utf-8?B?M2M4NUw3UDJwWEEvY2xSWlRTTnFzWGI0UWVLZW41eHpZWU1XZzlrRWxGNFMy?=
 =?utf-8?B?QSsyOElHWlFxZVNvbFFJdlVyOUVYUERGR21SV2ZyRHhQZzdEZGcvUWhKT3ZE?=
 =?utf-8?B?NmJWd21wNmtGb2pCVkxzcHpMbnAzYkVQT3RsN0lPamhmWDZqVDBVc25RU2dB?=
 =?utf-8?B?ZG5GNVpvVTQ4N3NlRTlBTzl0WEJkQnhKYzd2WWU4Rkk4MnFvZzVKV2VWQktY?=
 =?utf-8?B?UGlNREhHekZNRVdSczc5eC8waWV2YjJaOGNLeFQyWENEbmJjN1d4WG42KzlO?=
 =?utf-8?B?Rmp3akJOL0F6MEQ2bVU5ZnFnaEhEY05UYkNsTG1tRmZDdE9ZVWd1ckZXYkRa?=
 =?utf-8?B?bHBTRDFqQzBuMlVWeERwbTgvUW1BeXdSQmtWM3ZZakh4N2FqMTJxUm1CMFFr?=
 =?utf-8?B?b01RTEtnMml6OFkxTUNTOEdCWEZxbWpXa1B3VXFialBhV2d6MHVNK2krQzlL?=
 =?utf-8?B?OHFmaUtieXA3UHJPMEF3Lzdqc1pTWDJoaE5RQXBiU2pUcUlJV3Q1SUdHY3Vz?=
 =?utf-8?B?RXNXK0tQdDI1aDNZRU9oUHZ2Rk1EOEhnOHo4eXFkWUhmSHluN2kvMFE1M01r?=
 =?utf-8?B?eVJVRjZuTktQUnJOeEltekxjaWJIRDNKYTB1YzZZbGFmWGxJbUo1Y21mc0Zv?=
 =?utf-8?B?M2g1OHFIR25ieGJlSHBwenVLV0U4N1EyMWxsNktKVHEyUWhrTmhFOTRRTVQ0?=
 =?utf-8?B?b2Vsd2tRZEdEbUNnc0ZiQUt6L09xMHBvd2RVNW1CUmZTYWYyM0J4VU5DeEdD?=
 =?utf-8?B?TWx2Sm92Qm5QU1UyN0k5WVFHYnZ0M0pPTVRxRGNWNXl0NHBJUzg3YUpPajM2?=
 =?utf-8?B?cWRlMWQ4OHZTVHIySEt0aFdMeGhxWDJVdGJ3aGZ5YXFUckFTOCtnSWV4NzNZ?=
 =?utf-8?B?ajRlK3RDdmNNaTZsci8vUEFmcXRLV2VKOEoxWlhVemt5WEMzdGV3UGdUcFhk?=
 =?utf-8?B?b05TNVgyQVkxQ2d3Z3VjeDZvaXhTREI4cmhGVENyUmNEU1AyTVdSUEd3NW5X?=
 =?utf-8?B?ZUtqUzlsUWQzUEIrRTVXL3VSTmlZbmUwVFhKdlI4am1mWWNzQWxBL2taVXpu?=
 =?utf-8?B?bGdWSGZZSDRtaEJEZjRxNjJJeG83NERIbEtxdkJQRmZXeGh4anJQOVJKUkFw?=
 =?utf-8?B?NkRSczNJMzFDYW40TjJCaUhndDZrYlozTzBYKzVNTGVIWngyWU83ZmQwZzVT?=
 =?utf-8?B?WVd0dEJReGJvek5VOFo0TXJmODcyQThkc0RaT1pNSC9vcmpBeFVNL01QUnd1?=
 =?utf-8?B?SmppdlpEaDdIUGdQVXpaZU1WTGtIdUJUREJqUFMyREsrVkxaTTlRSjJCY01B?=
 =?utf-8?Q?0p4awszHU1QXo+hpV4N8cx5am?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fdc112-0b22-4657-720d-08db19ef3d72
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 00:52:32.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlA9pTaM3wSKFL23xB2uycvU2zhGzudnnQ8ybUaOWCQrdx2gDX2eTtdUKzFN+1ucO6wcn8Or+S+BWiBhWA40pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9673
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/16/2023 6:48 PM, Ulf Hansson wrote:
> On Thu, 16 Feb 2023 at 02:47, Peng Fan <peng.fan@oss.nxp.com> wrote:
>>
>> Hi Ulf,
>>
>> On 1/18/2023 8:55 PM, Ulf Hansson wrote:
>> ...
>>>>
>>>> Honestly I not have idea on how to rework the clk part to avoid holding
>>>> the clk-prepare lock when power on the phy and its power domain.
>>>
>>> I understand. Let me try to prepare a hackish patch that we can use to
>>> run some tests.
>>>
>>> Unfortunately, I can't make any promises for when, but I will do my best.
>>>
>>
>> Have you got time to give a look on this part? Or do you have any
>> suggestions that I could help with?
> 
> I have looked closer at this, but haven't yet got the time to actually
> post a patch. Let me see if I can do some re-prioritization of things
> at my side...
> 
> Anyway, my plan is to post a "hackish" patch that we should use solely
> for testing, to make sure that the approach works. Then, I intend to
> continue to work on the complete solution, which seems to be requiring
> some reworks of locking parts in the clock framework. Although, it's
> too early for me, to say exactly how, so I can't really give you any
> pointers in this regard, sorry.

I overlooked your reply, sorry. Thanks for still working on this.
We have a new SoC has similar design that use blk ctrl which
will need to work as clock controller, while it depends on
power domain. So we will run into same deadlock issue. So I hope
the deadlock issue could be resolved.

Thanks,
Peng.
> 
>>
>> Thanks,
>> Peng.
>>
>>>>
>>>> [1]https://github.com/nxp-imx/linux-imx/commit/c85126180a10439a8c7db1800529b4857d91c609
>>>>
> 
> Kind regards
> Uffe
