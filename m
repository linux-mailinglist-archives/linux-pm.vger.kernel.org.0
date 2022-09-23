Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D725E7284
	for <lists+linux-pm@lfdr.de>; Fri, 23 Sep 2022 05:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIWDl4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 23:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIWDly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 23:41:54 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20081.outbound.protection.outlook.com [40.107.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4B11176E3
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 20:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbNZzQoCI1hrMvyvR3OpH0OgoNmgvznXD8wcMsNq7DLJrSxKpCfUCEX/rcVjdm7Ad3Glt7myQyopeGUZBkQt9Xf+ohRH6QPM3KBLWzT6xCNmJzp+Ed8VmbaRtBbTkcKmJc9sjwBHguoPOe63DZeoTsB3+udvUHhgPEeSKlVaAhJdM3ZtaaPomUTiQHejB1cslJu1nmZF80rsl+ywgTzDQyfkXPiH0bWhzmC8xZUCQEntbnAXwGaMp94lBhDJ2tlbsTrVPlYmcyh5j6UFoxNNbg5jtG3EaOjYnt24KrTfbnB0lUPNPohkkuq3e5lRIVXH7ZsqTBdAUNoL9aL43lGx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyHLwULDvb2CBFAnnTAFN9zJpNjxI46bca4UhxnwmqA=;
 b=DLEiGJsQDNP81aNr/KS00XZqk+ANg4lIJyzZ9MoKQwppGkT+tqkqEqzuDDdLrkCKQ8L4KwSJ+b2BatuohQbmO70/cHFuwjB6PNTybPEjkhPpCBt0/4aoSs+KmPUIEZrEr4rAiR2YWRY+HeB/XgscI5u3ErfhcJRpa6juzR7ZaRYtHMS39RJ2a5A7cdKOk68myp0jiIerm4d8uvqxPg9cmif7NGnmxs74ZURWtBFKuTjKl/tiGGAgAcI/V6yXsL7xOSfg/MHfuhqrfKZEmKBxFQunrpx3CF2D/siHtYWVOgLPqmrI8kgxA22ouB4j7FHdV9gAjBFWvMpNLARddxSMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyHLwULDvb2CBFAnnTAFN9zJpNjxI46bca4UhxnwmqA=;
 b=VzXjQUSUQbyWBgV0K+49UABSdnahJ6CQ9jb4vpf1RFctp22iabtBzcHDXviTtq/hugKbvGwpbBQtCVnjEBhLWa0SxwdQvumh3NTPER0nZIqcOPF25tAx45Ko/dhfxsAkfeP09hn17E3Wo7QKClQRXA5dauT2xXLc9Wbh4ZZcYYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 03:41:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 03:41:48 +0000
Message-ID: <d23cacb6-4914-7eba-ed6e-c8490b9b771a@oss.nxp.com>
Date:   Fri, 23 Sep 2022 11:41:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
Subject: Help: i.MX8MP AUDIOMIX BLK-CTRL CLK driver support
To:     abelvesa@kernel.org, Marek Vasut <marex@denx.de>,
        Lucas Stach <l.stach@pengutronix.de>, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, peng.fan@oss.nxp.com, kernel@pengutronix.de,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        festevam@gmail.com, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea43518-c9df-4235-6762-08da9d158b0f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ciwRWvmmR/m3Uwqd5slACHIYcL87n/INb/Cz+wbW9vR3nI2CNnoDIpHvx/WvloeEC/cpW1vuHap+rHBxrMccJ00yH38ONNzosZwCaumnAPyXCBNcBhJT4BsL/feU21rck2O5UUIle1n+PQTp3FCi31XdS02lTJrYcu+cIuE/VrNW+PL0lPw7aKAgihM2xAsaoNloCNDNt+q/XCFS0jD14MjWAOaGXPWZYiG6FUtj5idtSZHQGLeBq4tE7cdLVgS89T5+WfqiILGgXxK3P+OOKk08q3B45HQxvaU0zETCJ3ulHk8PaMN7KLSj6trY4npUoWFJodIT8bPgLw4xUIqCoZE7nlQIAOP36tqA9S6sC4x5HDOeYeivTRa+gmhXkE3mtktYVGN7Vd+SZooz0byNZHC8G+If/Kdj7PguwkQqR/z0dwNQra6B0LpJ28jUinWqpgwmSHP+QvbSLog5BBplBHjLjXmn7Bp8dJK5Y9jMW7zmQdYw5hS6qNLOVoXs5NkN6YdFqnVgxDb5tcP00lw/G1bkjjHvqWUxV7R5NqPlnffX63wDPSlR4s2b9SZy2ZYsuBd4tCUquQVSlF1qiGDwQRavmo6I/v6u8Ne3Te9KxuAzbcIr2hPC7FJhFFUy4eWcOLkbXdFhwfi6pfraS7VzeTvz0Yoogvlsv4LMJiwG4UKeKgvP8LuR7h1bA0Dl9dT399e51tMUhg9WprOusr6O0Wm/wk3VoByBcD5vIVe9AEZ2/OMOZf4vzM2DIuMewGch1SKz/7r/aigb9LBnBv43ZIdMj5a0fcla/earP1duFXY3dFm0gN/WIn6OS/f/EG5JQdSDswJR+rdjODzJqcl97K6SXhjrZThvWpkmeMqbgBptzBPH5LujIJkZkDR4Kn2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(44832011)(2906002)(8676002)(66476007)(66556008)(66946007)(8936002)(5660300002)(41300700001)(7416002)(966005)(6486002)(478600001)(186003)(921005)(6506007)(2616005)(6666004)(316002)(110136005)(6512007)(52116002)(26005)(83380400001)(31696002)(31686004)(38100700002)(86362001)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGwyWXpPZUsvQ29ZTldhbVZVUFoyYjh5cm1LdDZDZFBFaEJoTUJ0U1NibndH?=
 =?utf-8?B?UkhKQ0NOWURQQ2ZDL2RseTFIYlNTTFVCTk1RM2s5dGxWaEdwUXIrazNEdDdC?=
 =?utf-8?B?aWZpNUZqc2I2ZmxSNEk5a0JqcUwzaE9xemxYbzMybnlqcnE5R2s0eDJJS3BR?=
 =?utf-8?B?aXR2bXlNNStZN3VBbndSckVQZk5wQWh6bjZaWU5Gdyszb0NyeTJSZHpwZlE1?=
 =?utf-8?B?clNTdWZua21RbzYwamxnM1pGZ0FqYnBqWldXWS93K01scTVMSEh3OEI4d3pX?=
 =?utf-8?B?aFFGYnpmY2VUVnhsSGN5R1hDR1lBTEdQQjZ3bjFGVXFBQzlETGdWam5EZG04?=
 =?utf-8?B?ejNVcyttMWMwakovYmYzdS9sMHp2T2NtRmFraXlBS2drcDVEWjd5T1lwczBs?=
 =?utf-8?B?eXV3R29vek1nZkY3aXRvcXUxanIwRmhEMjhabzVmODc3T0crOXk5NlVKbEZD?=
 =?utf-8?B?UHplRmZOYUkyMXJkNXI3dlBEbzFnNTV1NUlHbUNjMCtkN0tjV3cxVXZ4TkF6?=
 =?utf-8?B?UHBwNnBGRUwvYnBrRTBjTm9CbjdrV1B5STQ2cFVBalRvK0w4TTE2dmRIck1D?=
 =?utf-8?B?NENjQmVSck1leVVTTmVBNzBUbXkvajlsd2dwd25Vc21nVGZ1YXJjTzNONThQ?=
 =?utf-8?B?a3ZyOCt0SFY1Vk42U2JlT3RIcGpYQkpVWnJmS1k5SXFTb3lpWkdnQlNCeWQr?=
 =?utf-8?B?ZnArZmEwQmJacE1yemwzdy9mdmhobUQ4ckI4aVFtTkhOai9SVkVpVzUydlZy?=
 =?utf-8?B?RUJFcTZtVFJ4MERjT29JTTVJSXdacDU4R3pFalJaL1hlNWs4RUdaY25YYVg0?=
 =?utf-8?B?Q2xNbnRVT0lrQWtvYzhUcEJxbWIvQTh4QUNSRTByL3JzY2FSMEZ1RGpqMDlx?=
 =?utf-8?B?d2VTR3Y0K3RZdlJQMFBiYnlncmdBa3B3aFhkTW1YNCtHZE4zSnEraU1mbTYw?=
 =?utf-8?B?dGtjNGt0QlM2RW5KMlhwcjZ5SGdzNGhzbjJ2NmNpb1lVckY4UjY0dXNyeHZa?=
 =?utf-8?B?RW0yendGYWhNQ295SUJobkw4K1pnYlJhOWFoamRaa1hJbjNYSWY5bk5Lcjcr?=
 =?utf-8?B?VlVVcCtCTjRiSlN3Z09xalZIWGdkK3RReTczZnpDT0sxTlV2RkhCZE5VU09P?=
 =?utf-8?B?ZzlzcmZJRTlsNzJEamQ1RVBQSkRlSXl2d21RcU1nS090MmdodGVWT1pHMTBQ?=
 =?utf-8?B?TDVlUnJGeFFodnQrZ1B4bDJaakpDb09WcitWL2FYNzM5UURnZFAvc3ErWCto?=
 =?utf-8?B?QVUzSnlUTGVuYVdjTm51a0hENU1sTlBzbWRhN0JhWDF1NlhCaW15NFpXSFdX?=
 =?utf-8?B?Z2Vuc2xmdEl0cTVaYlJ0RHhITjZsRUhaenkzcGtLWHlhWk9CMERWNncrSlJQ?=
 =?utf-8?B?ZEtPNWVNbDM4emVNTkVVbG4wRUZFc2piYTIxczNOWmhBdnRPRzNiaTVpdmk4?=
 =?utf-8?B?d0hFVGhUeG95REpvUjVzWWxwN2tYemozZW1mbE83c2k4YklDV1k0S1hCT2Fq?=
 =?utf-8?B?eEU3WHY0VUlkM055Y3hvQlpzc3plcmtIc3gwSkY0WmMrQ0J5bzRHcHI4RlZY?=
 =?utf-8?B?RTRSR2Q2Wi9CTElHRjRSNG54aS8xMDdpVVZoc2srQlJteHB4d3pLUitkUVBW?=
 =?utf-8?B?eHExeXFIL0Rkc3JuVkhMREJYeStSMnhMa2JqTmJxNDJxUVdWclUwMjJncHdM?=
 =?utf-8?B?aUNCS1Flc3p5T2sxelZEYTZ4UHRRYVFkVmFSWFdpNUR5MmZSUlRUdk02bXNk?=
 =?utf-8?B?RDZYbTJJZU96UnNCY3MzbDVxUnhOZ3FWWmxDSDJzT1M2L2JzS2RPT0J2aXdR?=
 =?utf-8?B?U25GbWh3bGkyV3BsQmlnVzF5RExSWVRiWWpBbW1PSmoxSGM3cUI1V0llVDY2?=
 =?utf-8?B?SGNhSlpOdk5SM1lhY3YyTG5SNmhrZ2lhUXFTLy85VUdaT0ZVOHlwNlZUZ0lX?=
 =?utf-8?B?elhwV0FFTmhPUmJMRjErNFJTMndJaXhDVUpJazZjV1dIaDZvRS9YS1RJY3hD?=
 =?utf-8?B?dWs3NDllMTJEdmJKc21BMzYveTNwMVBKdDRieVZtN1psRUJhRms0SU9TNkhz?=
 =?utf-8?B?bndmb0tCN1FyNCsrY2t3RDY5N28wQk1BamVrVUZJZEpLSU95WDU4TEk4em1a?=
 =?utf-8?Q?YvL9GEjJ/S28v2JsBz7jbbj5n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea43518-c9df-4235-6762-08da9d158b0f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 03:41:48.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edCO2UaiLU8hlRxMAUPb6umdS20Ohn1cQafYj20UnMWDPr4JamHBchZa9O0N46wKZfh0UWWauPoMuRAAUKLpxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

I would start a discussion about the A/B B/A lock issue when make 
audiomix blk ctrl function as clk provider.

I not have good idea on this, hope you have any suggestions.

major issue is: the blk ctrl clk has a power domain supplier
The power domain supplier also use clk API to prepare_enable clks.
The blk ctrl clk driver has runtime pm enabled.

The NXP downstream:
The dts:
https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/arch/arm64/boot/dts/freescale/imx8mp.dtsi#L1872

The driver:
https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/clk/imx/clk-imx8mp.c
https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/clk/imx/clk-blk-ctrl.c

Note: The following log was reproduced with NXP downstream. For upstream
I think we have similar issue if we still take audiomix blk ctrl as clk
driver. Because the gpcv2 also use clk prepare enable API.
1. deadlock 1:
Callchain after enable some lock debug:
clk_ignore_unused will use lock seq: take prepare lock, take blk-ctrl 
parent power domain genpd lock
genpd_power_off_work_fun will use lock seq: take the power domain genpd 
lock, take prepare lock.

clk_disable_unused:
[   11.667711][  T108] -> #1 (&genpd->mlock){+.+.}-{3:3}:
[   11.675041][  T108]        __lock_acquire+0xae4/0xef8
[   11.680093][  T108]        lock_acquire+0xfc/0x2f8
[   11.684888][  T108]        __mutex_lock+0x90/0x870
[   11.689685][  T108]        mutex_lock_nested+0x44/0x50
[   11.694826][  T108]        genpd_lock_mtx+0x18/0x24
[   11.699706][  T108]        genpd_runtime_resume+0x90/0x214 (hold 
genpd->mlock)
[   11.705194][  T108]        __rpm_callback+0x80/0x2c0
[   11.710160][  T108]        rpm_resume+0x468/0x650
[   11.714866][  T108]        __pm_runtime_resume+0x60/0x88
[   11.720180][  T108]        clk_pm_runtime_get+0x28/0x9c
[   11.725410][  T108]        clk_disable_unused_subtree+0x8c/0x144
[   11.731420][  T108]        clk_disable_unused_subtree+0x124/0x144
[   11.737518][  T108]        clk_disable_unused+0xa4/0x11c (hold 
prepare_lock)
[   11.742833][  T108]        do_one_initcall+0x98/0x178
[   11.747888][  T108]        do_initcall_level+0x9c/0xb8
[   11.753028][  T108]        do_initcalls+0x54/0x94
[   11.757736][  T108]        do_basic_setup+0x24/0x30
[   11.762614][  T108]        kernel_init_freeable+0x70/0xa4
[   11.768014][  T108]        kernel_init+0x14/0x18c
[   11.772722][  T108]        ret_from_fork+0x10/0x18
[   11.777512][  T108] -> #0 (prepare_lock){+.+.}-{3:3}:
[   11.784749][  T108]        check_noncircular+0x134/0x13c
[   11.790064][  T108]        validate_chain+0x590/0x2a04
[   11.795204][  T108]        __lock_acquire+0xae4/0xef8
[   11.800258][  T108]        lock_acquire+0xfc/0x2f8
[   11.805050][  T108]        __mutex_lock+0x90/0x870
[   11.809841][  T108]        mutex_lock_nested+0x44/0x50
[   11.814983][  T108]        clk_unprepare+0x5c/0x100 ((hold prepare_lock))
[   11.819864][  T108]        imx8m_pd_power_off+0xac/0x110
[   11.825179][  T108]        genpd_power_off+0x1b4/0x2dc
[   11.830318][  T108]        genpd_power_off_work_fn+0x38/0x58 (hold 
genpd->mlock)
[   11.835981][  T108]        process_one_work+0x270/0x444
[   11.841208][  T108]        worker_thread+0x280/0x4e4
[   11.846176][  T108]        kthread+0x13c/0x14c
[   11.850621][  T108]        ret_from_fork+0x10/0x18


2:
another mutex dead lock between deferred_probe_work_func/ 
genpd_power_off_work_fn

The sequency in deferred_probe_work_func is lock the clk firstly, than 
hold pd secondly.


[   11.351159][   T46] the existing dependency chain (in reverse order) is:
[   11.351162][   T46]
[   11.351162][   T46] -> #1 (&genpd->mlock){+.+.}-{3:3}:
[   11.351176][   T46]        __lock_acquire+0xae4/0xef8
[   11.351180][   T46]        lock_acquire+0xfc/0x2f8
[   11.351185][   T46]        __mutex_lock+0x90/0x870
[   11.351188][   T46]        mutex_lock_nested+0x44/0x50
[   11.351192][   T46]        genpd_lock_mtx+0x18/0x24
[   11.351196][   T46]        genpd_runtime_suspend+0x1dc/0x224 (hold pd 
lock)
[   11.351201][   T46]        __rpm_callback+0x80/0x2c0
[   11.351205][   T46]        rpm_suspend+0x2a4/0x62c
[   11.351208][   T46]        rpm_idle+0x158/0x228
[   11.351212][   T46]        __pm_runtime_idle+0x64/0xac
[   11.351217][   T46]        clk_change_rate+0x400/0x494 
(clk_pm_runtime_put()
[   11.351220][   T46]        clk_change_rate+0x438/0x494
[   11.351224][   T46]        clk_core_set_rate_nolock+0x22c/0x2d8
[   11.351228][   T46]        clk_set_rate+0x94/0x134 (hold prepared lock)
[   11.351232][   T46]        of_clk_set_defaults+0x27c/0x364
[   11.351236][   T46]        platform_drv_probe+0x28/0xbc
[   11.351241][   T46]        really_probe+0x1dc/0x4c0
[   11.351245][   T46]        driver_probe_device+0x7c/0xb8
[   11.351249][   T46]        __device_attach_driver+0x118/0x13c
[   11.351253][   T46]        bus_for_each_drv+0x80/0xcc
[   11.351257][   T46]        __device_attach+0xd0/0x174
[   11.351261][   T46]        device_initial_probe+0x14/0x20
[   11.351265][   T46]        bus_probe_device+0x34/0x9c
[   11.351269][   T46]        deferred_probe_work_func+0x64/0xc4
[   11.351274][   T46]        process_one_work+0x270/0x444
[   11.351278][   T46]        worker_thread+0x280/0x4e4
[   11.351288][   T46]        kthread+0x13c/0x14c
[   11.529876][   T46]        ret_from_fork+0x10/0x18


Thanks,
Peng.
