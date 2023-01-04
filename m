Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40C65CE71
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jan 2023 09:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjADIie (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Jan 2023 03:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjADIiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 03:38:13 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD088300;
        Wed,  4 Jan 2023 00:38:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjbkyom82TdvsiIZHznJgns+HJ6nOCSCSitNvhqBuYsxw3Cu6ruiMSwWCY7OEHRZ1+LvnYH7yeLWDCbrjngwxPNakCfArcgYtDKdDwleLroucV9LiGs6MNCGH9xcHXGUUo6PIbYVrXdWGy7znMjOZr9LDG0mv+ZuTqrhbWUQG9/L9FHOC6jQU9DnQpYCr7YxehfA6P3sIYtWqlEz2Wn727ghZeuoPstO9zZxQgCAbsXtVWXrUVdF4R3FMouKhdWPePn6cV6mUI1woprpVrWzq7oY+a0yWGHM49F7B8w+q+Qkb00AH7dNoZdYuADmS9zilwn7+HhBA9HId7vRcHAdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnSsEU55gzbWzGK97YkfwlGLUIB4rOH0f/ro+vYAR5A=;
 b=M22sCMAi11FENp4TdlTqJoYTcMgBydj54i0y4/ifILc/aVm9j2h2LkAJiv4E1tPCyJjDhzsDdlAme4jd52Xip/lrJon/3u5i57Kshxlk8DwXYvbjVVG0UXt+iNtUUy83LZ1r/xGyaFIvJJnZNaOmi6IP5Msvr9ZKyDRjCvA+3+x9mB33ua//rbJ/pucBaJdnXmxiAzJfKrpUJTWsPBZ8W7LNlZ9VSTYGW4yB2qQHBFolaqGcqZpbXJHWMHD4j1dZBYTA+FD9U/4uwMeiOYYH5RGDB3b1Z2iZ5G8aBk8QWVGmxTZmPmisDrYkpHLDSbKl69xk/L6lwaWjr7dhAVcHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnSsEU55gzbWzGK97YkfwlGLUIB4rOH0f/ro+vYAR5A=;
 b=Z08jMXGv00lUiu5e51/lBKrQYFebvV7mteDGSseMT/fCGJ53+v6Lsa5aGT5QnVI1HSnhaSD3+w9l2RNyfrxOsqW0CIhGxP+UCYqtWG4dmpnymxl7NPykJA6xfP5A3nsQAm8dH57l0YN9Gm7F6iz/XEreH9Gyywq7suwykFWjMt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:38:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 08:38:08 +0000
Message-ID: <6d1f2a1a-437e-01b7-cf25-af1a09ce7f3f@oss.nxp.com>
Date:   Wed, 4 Jan 2023 16:37:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off
 callbacks
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org,
        Adam Ford <aford173@gmail.com>,
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
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <CAPDyKFqONWFj86FbhhGXmxVTMvdwdwWUNLDqEK5gg2-bDitmxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f486b2a-db7b-4803-c4cb-08daee2f00d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dijnN6jL1DvWtnM0clrHF4gAEJ4o89Dk58rDQHlRYHaiwmmNoiIACdy8ze1q+jZBKeb6eS92Wo/V0X6Lxokv2tvHqw3+JwS78w2ckhbLnBOmZBRfbpYeDzTHuGPyhYX2VLcLPVGl47Vf+FOzlM7RcnE/8U/J7wsXSgc8u/LOSVKV8LdcQdUkzzfAKRFYvIH5/5RUflbsmyYTTtDZMqMJLHVjUMtYPjfrm6zg1LlqZLUFX96qGMkm5W9t14c7k5L8lgw6oWEePtP5Li0Imu1MdoF2Hn5afwI0LPUctaFP/WwToOJZAKBepy79wEKbo5YJbXfSGWnB0aigadfV4WH/EsUqzgqD85geoPPo0miVQV8NVEy0UjWz/kSffMb20kqbp5WetE6ky9sjDJADK5XeQ7vDB+lfJFxPaXPxbTgLMVnisA2MV9tt+bbwoZiyW79ywBHGQ0DYcUqGHIxOAHjK6eqe+afJNhNIQULw08jC7kZXp2LHZxAqqBu+C3KImMwjF2ckh3RL0/9Y3bNAIdeh5Q1NEC7TNWT7QGVcZPrHJD2cteKYS5XKm1I8mgLqb61HBigcUZFRL8IUOTyjG7Rh39oXtj5R2y3LLUtHntkRrsFbF0IG/YlqH2RkHvYE7AVnZhs1WE2GzC4/ivw+xo2PTL8QsaoLc3yQyzbf09od7TfyvMKhzv/FDF3a2isHOwaWLszv6gXPX1aHRev+C13Ljxu/yTPxuR8z4qczZiJTcOY6MQTMiHfCG4wi3SkP5fwZe6nDgQBqOSXu7DfFS6euCweZOyqeeSFPJbDRPIwglT9DOGJcBe3DWkS8A/A1XCr3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199015)(316002)(41300700001)(66476007)(8676002)(4326008)(66556008)(66946007)(7416002)(5660300002)(44832011)(54906003)(2906002)(110136005)(6666004)(38350700002)(6506007)(53546011)(31696002)(83380400001)(86362001)(6486002)(966005)(478600001)(31686004)(8936002)(186003)(6512007)(26005)(2616005)(38100700002)(52116002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VS9jejZVSWZQckVMZDE2eUJpWjVOUDU2MEpSVHNiVGZrV2xEbTQ2VmxLVTFu?=
 =?utf-8?B?S1dTbFd5WVB4N0FsMjVjYzhaM0lPTU9OSUwrM0k1aDF1VlVndWNGVXhXeW1Y?=
 =?utf-8?B?dGZ0MkkyenhaVEFUMnN4dHloRDUrS0ZFdFl5dTRiakJpVHl5YUcxcmpMbHRv?=
 =?utf-8?B?T1kzVGVMd21hRzlueUs3dU8vTS9HRWU3bFlPS2M0T2o5akd4SmFQZktGdE1v?=
 =?utf-8?B?QndZK2daK3hCbmZoTDdVRjBacEhEbngzeVB4U0VoSlNUYjhMb203SCt2azZ0?=
 =?utf-8?B?Y09wVHRKRHhDWDNqYTJTZ3hOMkUyNnJLU1N5M2RkQWEvWURudTN3NCtqOG5T?=
 =?utf-8?B?RFNJVWRQUGxZTjlnMVpHWjN3OXA2TkJWdi9wVitqTzF3aHRpSVNzTHF6aTN3?=
 =?utf-8?B?Z0F4MzloRU02N0hrcVBXZW5TR0pMNUhJUzFrbGpEMjdPOUVBb3U2V0dxZDZU?=
 =?utf-8?B?Uk9NQ1pmRHRHbmtkMjdlR0VXWWhvNHMwNFRwbUdIbUs0dHFMU3pFQXVhRU05?=
 =?utf-8?B?ajFDVGlFL2lCd1RXZnBtZVlXSVVFWXN5S1JhMWdVSzVQbHV4bUk3V1ZBWjJV?=
 =?utf-8?B?OG93NEswcnFhUEd1bm94MmtRdWV3bDM2NTlmOUh6WDUrQjR6ZEFLWk43WURJ?=
 =?utf-8?B?R0hHNWxzajdKQUQySjB5cElJcTNKQkN5S2RNYlJoTUgvZFVqZ09FdUZhRHlF?=
 =?utf-8?B?MW1IdG51aDd5MThJc3VrdDJaMzNIVytBK2tvV2FHMHRDTkt3cEZmVjNQaWpv?=
 =?utf-8?B?VnFhTmp4S1kwNmNhdlMxb1ZoYXRLK2xaSW5YbFRKZi83b3Z5bVFUKzhTZ2R2?=
 =?utf-8?B?WExYektHRExTbnRWNHBhUUpCb1lad0Q1ZGNnbjRlTG5yZmdBTE5TWE8zZjVk?=
 =?utf-8?B?bVZWbnFkZU5FOVZBU05SbElYSUJ4VmRWeDV4elRINTluVlJleC83dVFaK1V6?=
 =?utf-8?B?cVEyaW5vRjROUUVRR3JXUVhIMEdWc2dBVENYa0VNTHFyS0ljRlh0Z1hMVmor?=
 =?utf-8?B?dlYwMEFjQnFmUGZOSmxDWjVyU3YwbUUzdnlQcURQT3dMeml4anJUVkNzUDdR?=
 =?utf-8?B?MDZSS3ZKZUJ6YXcxR3FMN0dMNDhVa1paNGNYTWE2VDRjV0hHQ202VW1BeGxq?=
 =?utf-8?B?SFl4ZkcrKzhxN3pOdHB1ZTNXYkh5QmJLU1lYSGFtc01tK28ybERPWXZ1Njdv?=
 =?utf-8?B?U0c1OHZxT3JiR1FBbWpvVUxWQ0lNdlhscnhxSWdlTzlwWU0wcjhrdm9tM1o2?=
 =?utf-8?B?d1dhK0pSMkZiZ2RTSWhOcVBibmdEUndvV1g4RVQ1c0JTVW1jTzZ0ajduWkdN?=
 =?utf-8?B?WE01R3VxM2tnc3B2ZkdtcFdack1CMkM2cWZBMEtRUTA0OHJUWnNVVjA0Ullx?=
 =?utf-8?B?NzVITEpYK0dGeWFMN2dNUkIyckhsbVJXdFVzQVZLVHh6SUNZbVZnajRTUjhz?=
 =?utf-8?B?QmFVNU15MGVBS1B2ejVlMCtxY2tGcWgyZ0lZRXhHK0lZU3BNd3pZa1laOHNG?=
 =?utf-8?B?R1hjdUtlSFBCS0Vzb2RBTmNBUjVlcVZIVGRUR2JIRkNBdFVUYnpUQjE4V1V0?=
 =?utf-8?B?TSs0YjBLVXozY2Z0Z1RZWURHbTczcktGZVJJYVRaeEJvODFWbGd6eGxxZ3Iw?=
 =?utf-8?B?N0xNTTlkbUtuTTdGRW55VTd4NkxBRSt1cm90UUdBQzJ0SURrbDhEMDZ2RFFn?=
 =?utf-8?B?MXR4bUdtOEE1anVrNWxhR1A3bms5cmlYNnhqYkZ3ZXU1Zy9EOHc5emUvQk9J?=
 =?utf-8?B?cWRDQ1cwSk5CSXNESVBBbVRxVG5vV29nYzdadHhVUW96Mk1lb1VIYjZHODNi?=
 =?utf-8?B?aFlRVkhpMGZMaGZQYnNsSnErRlRCZWJOS3BIcmwrNW9KM3dualBxaWVFUHc1?=
 =?utf-8?B?aktmSDhXb3B1cGRWK1lXT05DMXN5TTExLzBqY3hiMGx0VThsSTBZV2JxS1Ry?=
 =?utf-8?B?RVpNSnBSajNzc1BuaHNHOTlWenR0UFFwNFZNU2tZNkpzeXEzNDNSYllXMGwv?=
 =?utf-8?B?aUs2NFd4ZjZnLzBDSXJkWnd3U0NNcDlrbmVSRFlXeHBKSUNzSWM3MDNaYkJP?=
 =?utf-8?B?YWRKMTBlVUZMTHVvMDhiWlFBS0FJSUlkN2hYUTArSVJHUU5aVmdVYk1BNHgw?=
 =?utf-8?Q?sxYxh7HVMMY1rnrHxGltHCzuI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f486b2a-db7b-4803-c4cb-08daee2f00d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:38:07.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsZaCKGLisBUDx9b0WDgA0qhggb2pPxXDWHnSOiXdCDGDS0B+mmcYfCVhUQW3LjPoRZcJ69snEH1LHam0zrB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On 11/17/2022 12:30 AM, Ulf Hansson wrote:
> On Wed, 16 Nov 2022 at 14:25, Lucas Stach <l.stach@pengutronix.de> wrote:
>>
>> Hi Ulf,
>>
>> Am Mittwoch, dem 16.11.2022 um 13:41 +0100 schrieb Ulf Hansson:
>>> + Stephen Boyd
>>>
>>> On Mon, 14 Nov 2022 at 21:32, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 11/14/22 20:40, Ulf Hansson wrote:
>>>>> On Tue, 8 Nov 2022 at 02:35, Marek Vasut <marex@denx.de> wrote:
>>>>>>
>>>>>> Currently it is possible that a power domain power on or off would claim
>>>>>> the genpd lock first and clock core prepare_lock second, while another
>>>>>> thread could do the reverse, and this would trigger lockdep warning.
>>>>>
>>>>> I am not quite sure I fully understand. In this case is the lockdep
>>>>> warning relevant or just something that we want to silence?
>>>>
>>>> This is a valid problem, see patches 2/3 and 3/3 for details too.
>>>>
>>>>>> Introduce new callbacks, .power_pre/post_on() and .power_off_pre/post(), which
>>>>>> are triggered before the genpd_lock() and after genpd_unlock() respectively in
>>>>>> case the domain is powered on and off. Those are meant to let drivers claim
>>>>>> clock core prepare_lock via clk_*prepare() call and release the lock via
>>>>>> clk_*unprepare() call to always assure that the clock and genpd lock ordering
>>>>>> is correct.
>>>>>
>>>>> To me, this sounds like a problem that may be better fixed by trying
>>>>> to model the parent/child-domains in a more strict way, through genpd.
>>>>>
>>>>> There is a comment in the code in imx8mp_blk_ctrl_probe() that seems
>>>>> to be pointing in this direction too.
>>>>>
>>>>> "* We use runtime PM to trigger power on/off of the upstream GPC
>>>>>     * domain, as a strict hierarchical parent/child power domain
>>>>>     * setup doesn't allow us to meet the sequencing requirements......"
>>>>>
>>>>> I am wondering about what those "sequencing requirements" are - and
>>>>> whether it could make better sense to fix these issues instead?
>>>>
>>>> Here is the lockdep splat:
>>>>
>>>> https://lore.kernel.org/all/Y1cs++TV2GCuh4tS@pendragon.ideasonboard.com/
>>>
>>> Yes, that certainly helped!
>>>
>>>>
>>>> It really is a problem between the clock and genpd subsystem locks, they
>>>> can be claimed in arbitrary order, see patch 2/3 and 3/3.
>>>>
>>>> I think that might clarify what I am attempting to solve here.
>>>
>>> Let me try to put some more words behind this, to make sure I have
>>> understood correctly, but also to easier allow more people to chim in.
>>>
>>> Note that, in your commit messages in patch2 and patch3, you are
>>> mentioning clk_disable_unused(), but that's not what the lockdep splat
>>> above is pointing at. Although, it seems the clk_disable_unused()
>>> thingy, would trigger a similar problem for this configuration for the
>>> imx8mp platform.
>>>
>>> Case #1:
>>> Triggered from the workqueue, the genpd_power_off_work_fn() ends up
>>> calling clk_bulk_unprepare(), from a genpd's ->power_off() callback(),
>>> which has been assigned to imx8mp_blk_ctrl_power_off(). Before genpd's
>>> ->power_off() is called, the genpd-lock(s) have been acquired, thus we
>>> are trying to acquire the global clk-prepare lock via
>>> clk_bulk_unprepare() while holding the genpd-lock(s).
>>>
>>> Case #0:
>>> The "drm driver" calls clk_set_rate(), thus we start by acquiring the
>>> global clk-prepare lock. Internally in the clock frameworks, the
>>> clk_set_rate() path continues to call clk_pm_runtime_get(). In this
>>> case, the corresponding clock provider's struct *device, seems to be
>>> attached to a genpd too. This means the call to clk_pm_runtime_get()
>>> ends up in genpd_runtime_resume(), which needs to acquire the
>>> genpd-lock(s) before it continues to call genpd_power_on() to power-on
>>> the PM domain. In other words, we try to acquire genpd-lock(s) while
>>> holding the global clk-prepare lock.
>>>
>>> The solution to fix these problems that you suggest in the $subject
>>> patch, isn't the direction I want this to take. The new callbacks are
>>> prone to be abused and it would also require genpd provider specific
>>> code to fix the problems. Of course, we need things to work, but let's
>>> look at a couple of options first. See below.
>>>
>>> 1)
>>> In a way, it looks like we have a circular description in DT of the
>>> hierarchy of the clock- and genpd providers, which is a bit awkward in
>>> my opinion. I was browsing the imx8mp DTS files to find this, but I
>>> couldn't. Can you perhaps point me to the DTS file(s) you are using? I
>>> can try to have a look so see if this could be arranged differently.
>>
>> The dependency chain isn't circular, it just happens to converge in the
>> clock framework and its single big hammer lock. The chain looks some
>> thing like this:
>>
>> 1. DRM driver request pixel clock (clk_prepare_enable ->
>> clk_prepare_mutex)
>> 2. Pixel clock is supplied from the PHY, which is in a power domain, so
>> in order to supply the clock it needs to runtime resume
>> 3. genpd powers up the PHY blk-ctrl domain, which again is inside a
>> GPCv2 power domain
>> 4. genpd powers up GPCv2 domain, which needs a specific clock to be
>> running in order to power up the domain, so it does a
>> clk_prepare_enable, which now happens to hit the clk_prepare_mutex
>> taken in step 1.
>>
>> As the runtime resume/suspend for the PHY may go through a workqueue we
>> have two different contexts trying to take the clk_prepare_mutex, which
>> is what lockdep complains about.
> 
> I see. Thanks for bringing some more clarity in this.
> 
> So the above is described in some of the in-kernel DTS(i) files too?
> 
>>
>>>
>>> 2)
>>> What we have seen from other use cases [1], is that calling
>>> pm_runtime_get|put*(), while holding subsystem specific locks (like
>>> the genpd-lock(s) and clk-prepare lock), isn't working very well. So,
>>> I am thinking that we could have a look at the runtime PM deployment
>>> in the clock framework, to see if we can avoid holding the global
>>> clk-prepare lock, while calling into runtime PM. I believe that should
>>> fix these problems too.
>>
>> I don't see any straight forward way to avoid the clock framework calls
>> in the chain laid out above. I would be happy if anyone has some good
>> suggestions.
> 
> I think you misunderstood what I proposed above. What I was suggesting
> is that we could re-work the runtime PM deployment in the clock
> framework.
> 
> In this way, we would not be holding the global clk-prepare lock while
> trying to power-on the phy and its PM domain. Wouldn't that work?


Do you have time to give a look at NXP downstream patch to address the 
lock issue in genpd side [1]?

Honestly I not have idea on how to rework the clk part to avoid holding
the clk-prepare lock when power on the phy and its power domain.

[1]https://github.com/nxp-imx/linux-imx/commit/c85126180a10439a8c7db1800529b4857d91c609

Thanks,
Peng.
> 
> Kind regards
> Uffe
