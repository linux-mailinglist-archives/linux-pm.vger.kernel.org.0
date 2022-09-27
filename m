Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820745EBEC3
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 11:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiI0Jgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 05:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiI0Jga (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 05:36:30 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41598A9C3C
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 02:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDEef5hWhfvCtI5XmFujogMGfXneTO9so3ARBOKPWDBgefYIpUwkznjdX0+v4raNSOsfbe/vBB4Hd2XX7HzOWHu1RJdB29/qOupsVyosTKMOYXKozK8NCoCYyofkt1QFjX2vc5i6XrmMiFy+mxN/9FOhZprJYx4S9Q+jMEf2m7cnhbuwj/akMn0eP4ZkLWqJVRJrTlg55P9+Vj7Zmfz4VsXT4IU45FsRbKlltEE9cpgDe+VSIrAzHXrLfPrWQzi87bKTTCO8vKmdaUbaql8hf22FIQvW+Q+w0C040KmcN1q4q07e3DIcaet+YUsbQ53iW7kqSAVj9lBgJ0DI8sLJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIc0SXLuOP/WFxZWLlfiZ/aUX1Y0fHNBDvGSzcsucOs=;
 b=bbQnajAm/hyt18nDk3uRQEKNdzs9xFXiHZ76x0IvnPLruAYh3NW/ZVR83B3bxd8yExZ1XryisWBRjIHVsMR2V7mOaY2fDouEuRaFFpAje31PThHIGrvL9soSmv4UxPtlpufUwA3I3rx15u7Lbpn2jZRYofYX2iOZoiyRihnMpu1t4sp+VA844gN19V7ZvJmX1XC9FiqQlPhmI+Kcs4RtPbmE6K1X7mTO7zAONbLfmMN/PckxEouZUKiOCynL0D2g8mDgSRx/NTaP2yOoWajpQ49dfht8v8iqv/q9n3js5kYlj0JF6YYmzKP6AftmgULDxhe3Oob1iUYqmuZtwEfbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIc0SXLuOP/WFxZWLlfiZ/aUX1Y0fHNBDvGSzcsucOs=;
 b=FRdTnoet53tA5ALZrgKt3+NrY+05xmtK2AwlOYLN8cewb9GItuXW7exZUOPUs4iachb4ouyLTOsYHrVMgZH4Z3IDddFBV0udWLzOB2choQ+wy/MO63ujJq3Tph2ppTVe0j/P2BaYzpbMZA41v9AlLyoBdp0LS1LF3jmFQcDcE4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8038.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:36:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 09:36:21 +0000
Message-ID: <27a024d9-c15f-26e3-a81a-f3fa1ef34554@oss.nxp.com>
Date:   Tue, 27 Sep 2022 17:36:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: Help: i.MX8MP AUDIOMIX BLK-CTRL CLK driver support
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>, abelvesa@kernel.org,
        Marek Vasut <marex@denx.de>, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, kernel@pengutronix.de,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        festevam@gmail.com, Stephen Boyd <sboyd@kernel.org>
References: <d23cacb6-4914-7eba-ed6e-c8490b9b771a@oss.nxp.com>
 <e8828c9c94146127ded316b7ad8b6042cf9f6919.camel@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <e8828c9c94146127ded316b7ad8b6042cf9f6919.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 00008e4e-3d8e-4a65-9500-08daa06bbc6e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ks/n7uphXyYov2NgR8/3pWhdVfSJABbDCAUSM5YKyDh4w17BNDYyiw7SjFMtAp3j3vPC9mu9EYOqoNpGZuIRkv6oT4NEw4kx2Dj6aef0f5nhMN8Ra+Py3PbieU2kBjJm9xgTd7yDMyI5TkD2TsrSA3eApIulqLmckWtSOtpU3FaPrKoL+BucU7ii7UrrAoal5uc/FISFw8LKhbIQWraDSODIHJ6g34QehWjcjeJpK7C6cTQjDBx+oHtIVN1upZ3ViKqVCKkcwXGsntG1JUBe2BTnhxrbaLjmO3FdsmOVjgo5VTUoYTgGGax23Z9fe9K4yTtsmgxoXn/N6q5ZmKhIohkprR3rBOhn5cGQpowZDmCRgTDbZj99le+gCks6CXRAoYSw0tbgUbJMMm6udQCEBck5DJkyh2CSdNnLLnpKh/1avxx9AaVJpm5g7IuLFJ8BfVIJf9qwuVlyLKDa+dO1SIOjZezmbu7azvzF+b3qSOpk/ble4eHRREKUj9gvsCA2IDkNChzUNypAkK8NKNgfWhYn5MfWmHa5T3/KxL9gGVopSoQEBeUejuw7gRdLDvVKzW7wyr9sZqH6sEdYphdq57+AK/wI8CHFP/s+zMI+DglfrVmg6yov8bCZjpHRNvVpr/7bKDYLHfEFSTbDPdNIga74sCtb2UTEuAh6JHD7KBesCy/zBx45N8FTx/clpDdE2dRIbc7roqXP44Ou6xHYjAr8jhPe716uiG58XilKPAU5WcvrJSWCMK0+8GYQI2zDkUA/MJGmrX57eRMIW7gBrA+9H8/cmk6XlGHjrCOQ2Q7NDEW1RFYPyxJncVz8aZLIwl2B/KyGsvZ1xvL6WX8KI5m3/ii7i3GwmY/rGo+zrgYkX5X2xg1nEXuj6rsT4G6b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(316002)(38100700002)(38350700002)(921005)(110136005)(5660300002)(44832011)(86362001)(31696002)(8936002)(66556008)(66476007)(66946007)(7416002)(8676002)(6512007)(2906002)(2616005)(966005)(83380400001)(6666004)(186003)(478600001)(41300700001)(53546011)(52116002)(26005)(6506007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REtmNGRCVXlvOGk0SmIydDFqNGkyeG9oM29vZ3ZseTZUNjUrNG1KQ0VJZ0Ns?=
 =?utf-8?B?RFgyWnhKUGRTeEptMzBPcTkrNnIvTWhSUWtnYjEvMkIxT0E5MXNJY0x2OU96?=
 =?utf-8?B?bXo1N3kvMGFoVlNHM3ZHNlkreTdUazVGMzE3dXVLVHF3aHFmanl0MzVrRFZj?=
 =?utf-8?B?dDh2Vk12QkJvK0FXM0lOZEYyNkVMcVFhcFgrR1FGQWhaa2tsK2NSR05pOUps?=
 =?utf-8?B?RDFhcVByNWVQN3dZVHhwVGtHNEVRcEVFbW8xUUV2OVJEZ1RqeC9DQWd2ZTRH?=
 =?utf-8?B?VzVRcjUzUWdzdVllQnByWkhJZ2RIMnA0SXJoNWl5OUpwMzZObk5ETndYL2hH?=
 =?utf-8?B?aDd1K2hFQUhhbEp5TnBsTnN6TzFSU1NLZ3NZSS9LeW1pSkxXUEcweHM4bHUz?=
 =?utf-8?B?Y1c3QWNVdGErTzRRNEFpb21oR04wSGhBRWg2UW9CeHYxTXRKODg2RmVXU3Iw?=
 =?utf-8?B?ZnYyaDlkNlk1dElacmx0YzBXV3cwYzM1OXF4MldldWU5eFoyUDExRnowazFC?=
 =?utf-8?B?aGoxdUlrQzliRFh2VnBvT1UweVJFME9xcTdrSnpiVG1yZmtoaGVMM25NQVVU?=
 =?utf-8?B?T1VVWmVNOVlhQzVoV3daTS9FTVdRMWpBcGdvU1NtRlczc1FRYnd3Sk00L200?=
 =?utf-8?B?RmRJYloxeXYvOFZBUVpPcDhQVzFYampkUTNhZEgzeG13MEhMTTdNOEdpUWJZ?=
 =?utf-8?B?Z0lxSUNmaHJsTlEzVXNid1huYTNpalcvVXVuSGl1WjhzU2lnWGcwWndFYnVB?=
 =?utf-8?B?ZFpJZElETkdTZ0Q4RTVIVlc2ekxobGVVTVR6Tzh4d092L2M4dStYSjZqZ1dY?=
 =?utf-8?B?SDZjUi8xNm43MG5mS3lwTnNhM0RxdzZPcW9MQWtZL0dkT0Z4aisxaDk4dDF6?=
 =?utf-8?B?OXJvdXBTUnRvUHZpKzA5VDhzQzMzUWNjamUzN09hNWYwZ0tDbTRwMWVBYW1Y?=
 =?utf-8?B?dmFCYTNZVlpUWGFhZkk5Lzg5WjR3NHpiLyttUm9qWjBSd2VvYkRYdXkxQWw5?=
 =?utf-8?B?T2RWR0hVMGhFeE41QklmSlhla3lCOFdVWE1LN1JFOUU1RlprMEZ2UjkwSkJV?=
 =?utf-8?B?VTM1b0RHcGZaSzJiNUxDRHp4c3JVaWxiUEJlQUg4WXo0azNCb3g3N29wTGJJ?=
 =?utf-8?B?dzJDM2ZJYVV6VU16Z1NndXlCczVSMVF0V29XODZNajdhODVqUzk0ZWRmdzhT?=
 =?utf-8?B?cmdXSjdFRTI3T256SEkvRkVxSHJqZStzQWF6cmoyaEkvYVF0MmtXMmNramJ4?=
 =?utf-8?B?NXhCek9vTVZQYk1DbW11YWwvTFV4cyt1c1ZhOGl3SXpacnZuQzV0V3k2TkhR?=
 =?utf-8?B?a3Q2Y2plaU5hNDZBNGVjN2wxRDBTcDFqRUhnU0RVTThVcmIrL0FFUjFVU1FV?=
 =?utf-8?B?aGY4ZVJGcTIvS3lyYnBRRDVEK01pL0Z4d1RtNzdMR3djYncrM0ljZ0hQL1g5?=
 =?utf-8?B?UStMSytOa3daVk8reXZEK1czU3RKUjVZd1c4dHowdERsZmExVjZFTkIvMFpM?=
 =?utf-8?B?Nk5kdkRBbXhSUUpqZWc4TjdqcVdmeE9Xc05rUC9ML1pzZUtVTFRvaXg0aHJi?=
 =?utf-8?B?aGlvOVI1SnVEMnk1clJURHVEejZGSEFDM2huNkFpSmxBdzd6TU1QUGlkN0ZD?=
 =?utf-8?B?THFibnY5UDNJempJN1hMc3V4aU1IczU3T25WMWhXRnA5djkxY0NNQXM5Mytl?=
 =?utf-8?B?NmhFU3VPUUtwZGNLQ0FyMVJ1eTVVazNDTW01aWRvOEltc1Jma3JwQTdvYzVV?=
 =?utf-8?B?dGV3K2w2QlZNZjhTbkFabENuUHRESzQ4eExyQlpGOUs1aEFmMWJTRDlBNVd1?=
 =?utf-8?B?SHcwQXZNVWFYaXJVN3oza0t0d2NIZ2ROTWlIay9IS0tlOHNLSEVKSHZ5RkE1?=
 =?utf-8?B?MVYxclR6TUxPTUxWY2ExWk5udG0rUG1STzZIUkNIazBMSTRlS3NVNW1hdHNL?=
 =?utf-8?B?N0lSak9oR000dk51WHpOWTQvb1FiaTdqa3VCOWlSWG1iK2ltZ3FqZS9CUnFv?=
 =?utf-8?B?VlpEWnZxWWFjRXlETEd6V2VuMWlOV2dKbUw4UVB1Z0JCcU4vTHJYUWFZN2M0?=
 =?utf-8?B?aGhkZ1p4UFBxWWp1MmtvcENCSmw5bmVMSktzQ0k1Z2Z6WllkelFtbTFvbVBC?=
 =?utf-8?Q?e11bWWcpc4DDhnT6IrAiKJ8Bu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00008e4e-3d8e-4a65-9500-08daa06bbc6e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 09:36:21.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIgvzLYhMnFxse0xvFba3hdOhGE2Bb58X+lMp2UsUPwOA8CsEJdmEiUOjsCtz9a9yKmQyJvyDdotgWWbazyJTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8038
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lucas,

On 9/23/2022 4:18 PM, Lucas Stach wrote:
> Hi Peng,
> 
> Am Freitag, dem 23.09.2022 um 11:41 +0800 schrieb Peng Fan:
>> Hi All,
>>
>> I would start a discussion about the A/B B/A lock issue when make
>> audiomix blk ctrl function as clk provider.
>>
>> I not have good idea on this, hope you have any suggestions.
>>
>> major issue is: the blk ctrl clk has a power domain supplier
>> The power domain supplier also use clk API to prepare_enable clks.
>> The blk ctrl clk driver has runtime pm enabled.
>>
>> The NXP downstream:
>> The dts:
>> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/arch/arm64/boot/dts/freescale/imx8mp.dtsi#L1872
>>
>> The driver:
>> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/clk/imx/clk-imx8mp.c
>> https://github.com/nxp-imx/linux-imx/blob/lf-5.15.y/drivers/clk/imx/clk-blk-ctrl.c
>>
>> Note: The following log was reproduced with NXP downstream. For upstream
>> I think we have similar issue if we still take audiomix blk ctrl as clk
>> driver. Because the gpcv2 also use clk prepare enable API.
>> 1. deadlock 1:
>> Callchain after enable some lock debug:
>> clk_ignore_unused will use lock seq: take prepare lock, take blk-ctrl
>> parent power domain genpd lock
>> genpd_power_off_work_fun will use lock seq: take the power domain genpd
>> lock, take prepare lock.
>>
>> clk_disable_unused:
>> [   11.667711][  T108] -> #1 (&genpd->mlock){+.+.}-{3:3}:
>> [   11.675041][  T108]        __lock_acquire+0xae4/0xef8
>> [   11.680093][  T108]        lock_acquire+0xfc/0x2f8
>> [   11.684888][  T108]        __mutex_lock+0x90/0x870
>> [   11.689685][  T108]        mutex_lock_nested+0x44/0x50
>> [   11.694826][  T108]        genpd_lock_mtx+0x18/0x24
>> [   11.699706][  T108]        genpd_runtime_resume+0x90/0x214 (hold
>> genpd->mlock)
>> [   11.705194][  T108]        __rpm_callback+0x80/0x2c0
>> [   11.710160][  T108]        rpm_resume+0x468/0x650
>> [   11.714866][  T108]        __pm_runtime_resume+0x60/0x88
>> [   11.720180][  T108]        clk_pm_runtime_get+0x28/0x9c
>> [   11.725410][  T108]        clk_disable_unused_subtree+0x8c/0x144
>> [   11.731420][  T108]        clk_disable_unused_subtree+0x124/0x144
>> [   11.737518][  T108]        clk_disable_unused+0xa4/0x11c (hold
>> prepare_lock)
>> [   11.742833][  T108]        do_one_initcall+0x98/0x178
>> [   11.747888][  T108]        do_initcall_level+0x9c/0xb8
>> [   11.753028][  T108]        do_initcalls+0x54/0x94
>> [   11.757736][  T108]        do_basic_setup+0x24/0x30
>> [   11.762614][  T108]        kernel_init_freeable+0x70/0xa4
>> [   11.768014][  T108]        kernel_init+0x14/0x18c
>> [   11.772722][  T108]        ret_from_fork+0x10/0x18
>> [   11.777512][  T108] -> #0 (prepare_lock){+.+.}-{3:3}:
>> [   11.784749][  T108]        check_noncircular+0x134/0x13c
>> [   11.790064][  T108]        validate_chain+0x590/0x2a04
>> [   11.795204][  T108]        __lock_acquire+0xae4/0xef8
>> [   11.800258][  T108]        lock_acquire+0xfc/0x2f8
>> [   11.805050][  T108]        __mutex_lock+0x90/0x870
>> [   11.809841][  T108]        mutex_lock_nested+0x44/0x50
>> [   11.814983][  T108]        clk_unprepare+0x5c/0x100 ((hold prepare_lock))
>> [   11.819864][  T108]        imx8m_pd_power_off+0xac/0x110
>> [   11.825179][  T108]        genpd_power_off+0x1b4/0x2dc
>> [   11.830318][  T108]        genpd_power_off_work_fn+0x38/0x58 (hold
>> genpd->mlock)
>> [   11.835981][  T108]        process_one_work+0x270/0x444
>> [   11.841208][  T108]        worker_thread+0x280/0x4e4
>> [   11.846176][  T108]        kthread+0x13c/0x14c
>> [   11.850621][  T108]        ret_from_fork+0x10/0x18
>>
>>
>> 2:
>> another mutex dead lock between deferred_probe_work_func/
>> genpd_power_off_work_fn
>>
>> The sequency in deferred_probe_work_func is lock the clk firstly, than
>> hold pd secondly.
>>
>>
>> [   11.351159][   T46] the existing dependency chain (in reverse order) is:
>> [   11.351162][   T46]
>> [   11.351162][   T46] -> #1 (&genpd->mlock){+.+.}-{3:3}:
>> [   11.351176][   T46]        __lock_acquire+0xae4/0xef8
>> [   11.351180][   T46]        lock_acquire+0xfc/0x2f8
>> [   11.351185][   T46]        __mutex_lock+0x90/0x870
>> [   11.351188][   T46]        mutex_lock_nested+0x44/0x50
>> [   11.351192][   T46]        genpd_lock_mtx+0x18/0x24
>> [   11.351196][   T46]        genpd_runtime_suspend+0x1dc/0x224 (hold pd
>> lock)
>> [   11.351201][   T46]        __rpm_callback+0x80/0x2c0
>> [   11.351205][   T46]        rpm_suspend+0x2a4/0x62c
>> [   11.351208][   T46]        rpm_idle+0x158/0x228
>> [   11.351212][   T46]        __pm_runtime_idle+0x64/0xac
>> [   11.351217][   T46]        clk_change_rate+0x400/0x494
>> (clk_pm_runtime_put()
>> [   11.351220][   T46]        clk_change_rate+0x438/0x494
>> [   11.351224][   T46]        clk_core_set_rate_nolock+0x22c/0x2d8
>> [   11.351228][   T46]        clk_set_rate+0x94/0x134 (hold prepared lock)
>> [   11.351232][   T46]        of_clk_set_defaults+0x27c/0x364
>> [   11.351236][   T46]        platform_drv_probe+0x28/0xbc
>> [   11.351241][   T46]        really_probe+0x1dc/0x4c0
>> [   11.351245][   T46]        driver_probe_device+0x7c/0xb8
>> [   11.351249][   T46]        __device_attach_driver+0x118/0x13c
>> [   11.351253][   T46]        bus_for_each_drv+0x80/0xcc
>> [   11.351257][   T46]        __device_attach+0xd0/0x174
>> [   11.351261][   T46]        device_initial_probe+0x14/0x20
>> [   11.351265][   T46]        bus_probe_device+0x34/0x9c
>> [   11.351269][   T46]        deferred_probe_work_func+0x64/0xc4
>> [   11.351274][   T46]        process_one_work+0x270/0x444
>> [   11.351278][   T46]        worker_thread+0x280/0x4e4
>> [   11.351288][   T46]        kthread+0x13c/0x14c
>> [   11.529876][   T46]        ret_from_fork+0x10/0x18
>>
> 
> There are two possible solutions here:
> 
> 1. Make it a contract between the blk-ctrl and the devices put into
> blk-ctrl power domains that they first need to RPM resume then call the
> clock functions, never call clock clock functions when the device is
> suspended. This way the GPC domain is already up when any clock
> manipulation is done, so the GPC will not need to take any clock
> mutexes. Downside to this is that drivers then need to adhere to this
> contract when they are in a blk-ctrl domain, which deviates from the
> usual rules, so might take some driver writers by surprise if they
> aren't aware of this.
> 
> 2. Move the bus/reset clocks from the GPC domain to the blk-ctrl. In
> the current design blk-ctrl has full control over the sequencing of the
> GPC power up, so it would be possible to enable the bus/reset clocks
> from the blk-ctrl driver, then power up the GPC domain. As the task
> doing the the bus/reset clk enable would then be the same that already
> has the clk_prepare mutex there will be no deadlock, as the clk
> framework alows this kind of recursive locking.

Thanks for sharing thoughts.

option 2 seems good to me, option 1 requires more changes in consumer 
drivers side.

Marek,

  Do you also have time to give a look?

Thanks,
Peng.

> 
> Regards,
> Lucas
> 
