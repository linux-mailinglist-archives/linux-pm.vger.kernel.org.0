Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC105EB8C9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiI0DaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 23:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiI0D3T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 23:29:19 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10068.outbound.protection.outlook.com [40.107.1.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997EDF8FA6
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 20:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsqoJnzYjK+XwWfKuxtb5JtWjLv12SPXOzPAoz1ZPdSi1u8QGl1vI452xF1vamhjXeEkjNUbUn8OlykYI/VE/BCPKWxWLYOXA3W4yQtn3pxZCIpu4qC3WUGsK5vDXhOoFf/dFwxJ8h8Hg30pB4jVIknT7dXMRxLnHuykkAqVHODPd/zeSKqLo1P6HtVxAezlikdJxA0Z/9dzZViJb8gE4kLMo4LDgqoM7AEfu9hHZO9tlvTiaIutEWLwPpj5kF/m1g2hGRJuupp9OPI+ftL2GWD5JByQZx2tS/nLqG50q5XhX27D8GgmxfYayd89aG7RCE7JRIPbMwZ3ZMp3Aa/Hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7AlyJffvMCSQHSEy3wLFFhn8em6npQVNx4izTypNMI=;
 b=jDWSnOGodmRzz7H1XSUTpMLMFLggcVC/k0OEIeS6rLiHkakUzY4i7efoDYw3ls1Z3Edop4yjZWcSGjL1d+nzbVAMfD0OUJjqfBo0bzWf1xYOFtgKazMvbCjzqky0x+Yc6bJnk16EXMd7bA0cGn22YQ9WZ433dKFj0IwJjc3qs/I+JzkeBWqLl9kUO2Ynd1YLNT8wL89zs+Mi1kULWc+4lYmaL+L2FjpPW+WasmgDe5jyGJboOpLItejgeqYs0RJyvnE8aHY0aLUaa2vfkWHEkLPc6KlsNh7v+PlS/tohlQvo6iXpBlQDNtp7NLqGa5gJyDWMalNltGAn22RJt4IBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7AlyJffvMCSQHSEy3wLFFhn8em6npQVNx4izTypNMI=;
 b=G4sv4RX0aZdlPH8S4CrmR1c4MBYyrC3flHCe8B7KEzAAoWtCHQ2POiIQHBYwWbksfDYOWJ9+QzL3iMJ3/O7HRtwoa0RhkxwHOIjM5x5BCL9rl7ukN8m6yKWvRkHX9FRwdZRcLz3BxGYcFe8yq7dMdwwuyJLJJpudDgNymUlmSIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9632.eurprd04.prod.outlook.com (2603:10a6:20b:477::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 03:27:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 03:27:02 +0000
Message-ID: <f00f97e1-5779-0700-f325-965a65ae1425@oss.nxp.com>
Date:   Tue, 27 Sep 2022 11:26:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: Help: i.MX8MP AUDIOMIX BLK-CTRL CLK driver support
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, abelvesa@kernel.org,
        Lucas Stach <l.stach@pengutronix.de>, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        aisheng.dong@nxp.com, kernel@pengutronix.de,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        festevam@gmail.com, Stephen Boyd <sboyd@kernel.org>
References: <d23cacb6-4914-7eba-ed6e-c8490b9b771a@oss.nxp.com>
 <09bb716b-1f6b-c422-8469-fd2a0ac9f946@denx.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <09bb716b-1f6b-c422-8469-fd2a0ac9f946@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab4acb9-a3a4-43ec-1fe1-08daa03824a7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+/V/y9t6aqCABLogDA76oPvsIHP+IfH1qivKuWKZoPOV8phD1mVOEXcD/BgFXIo0h+l+q1DwfRV4bGn7uhKlujXOuOx9gr35EvWYVQl2U1RlRcQNZte5g2U0hSOfouvqqw528fK65O0OARDw7Mr5ZeWrYXIayi6KS4QTLmSnDf17hYrp3Ow9NB8IWH1IeG3ZL+tJZ4iBy19ea+i0Yb1IpUf014YCXJYLd7bbnnRJ9PavIfp8WQtWY+bBbhq2J8nvcCY5FprYKltYms1ruZh5IEIw6Z12qam4nR0a1RIjvxZH4o+VJ2f6lG7Y5sIARp751nL9RXK9C5Oj5US3FxNERMUNe9dFN0PAc8+hiIHxhRltwtKpNw4dhXI4xxs/QrdUDuouHchF0YlLVfpuHzIjSEddf/lsnSFlPnG+mhdsJCczuxYxo6nat29apu162zocK/zzBwzj+/Yz2nsCPLFSr19Qv3LeQfGWLB2ztFwoz7KOb3c2CO8apvDmS3QErK5WbvjQfc/Z+Cn95rN1YD5Ees0XC+AY5i/dJcHVIYMogbnTYg2PMOI6fRQ9CzpTip72G07HIMnlnQE5PxmtK5F4BQ3HhzUpipFdu+O6conq3+bAnacSLNyx7c8l/+/i5nOQYXi9KJyZkM6jPIJd6p4Lv9Ve0Yw6EY/GJ21I22F26tt5+02I/mGXePS78piRiww1plWwens0pNJxZWy6CwlJs8z3p+OxIvuH/HORyWy4MRoSBS+fzey0Vpmq2+zKVKVsGEofY07a8HOgHQc59AfCZttCWqf2ocUsSHq+fF8NdwYtbnjqWnQMULe1iKhigjCL+59dBG7jI1n2BoASiT6njE8aOJAod4xI0c9qDTEDRC+D82IRiUEmYhzLhD/z8VL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199015)(6486002)(966005)(478600001)(31686004)(66476007)(66556008)(186003)(8676002)(53546011)(52116002)(66946007)(6512007)(2906002)(7416002)(921005)(5660300002)(6506007)(26005)(316002)(110136005)(6666004)(8936002)(83380400001)(86362001)(44832011)(2616005)(31696002)(38350700002)(41300700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpxOHpuU3FwcmV1R2QxMEVZSXZPazRtRjhXRndlSlBHYkRwYWZTRWVzejdO?=
 =?utf-8?B?L3R1dFFHZWx2UlhUNHdUNllBMmZMQnRvV2xucWYwR2h4emF4YjVlak1GUk5q?=
 =?utf-8?B?K2dHTjFhZG5TTVpVc2ptbUxSajd6aU80QmRnajJuWU4wMDFMZGlOc0lzTkIx?=
 =?utf-8?B?dmtyWnJpdEJ1WG14SjRRV3NLZzM2czZYN2ZNMXdRNDMrQXlGeDI5eXExK3By?=
 =?utf-8?B?MytGT0Fpa3UrUmNyaHM0d092VGdRWEs3TGhzSXhBSmNrYlFQaWlFZEZ3TmlH?=
 =?utf-8?B?ZS95N1NBUmFvdG8xSlhXdFRwc3FuVFRYOVRBODlmQ3AyeDQ2WURrSWdwcGJT?=
 =?utf-8?B?am8xbFEvSHdiNGt6bDdOemtsemRQdkxuNEt0STYxOUNwQU41ajNjUUhRZGM1?=
 =?utf-8?B?czhpRGk3eDRJRWtUZVNMQkVlK2ZUSnM3R2d0UnZlRktWaFZiaitUUis3YjlV?=
 =?utf-8?B?VmFodCtPM1FialRCY0Q1R0dQWlhOYitCZEY3TFpNT0VHc0NyQWRIbVBWYlFz?=
 =?utf-8?B?UXBuaWhkZGFMcnA0TGNLNW83bGpXa1Q3WnRCNWw5Y0xrdUxjRzJrNVZIbkh3?=
 =?utf-8?B?TTFuMFJBN2djNk9zQ1oxNm9iK0Q3aExoT1lyK09OMTVLalpLQjdSQVU5VjNv?=
 =?utf-8?B?YzZhMjB3eE5WSG16QnduNkprdTlwL3VmU1RncDZNL2YxSUt5cENqSzZObkxU?=
 =?utf-8?B?akhUK2hmRTBUQjRSckh4WDVKTUtIbm4yUlBCYVBVSWl1MDI1d3E4Skl0cERV?=
 =?utf-8?B?NjYrQ2ZzcjAyWW1JamJtSU0rUUg0ZnpMK2V4WUk3TEZwbk1Dc1dxL05IS0kw?=
 =?utf-8?B?ZVNQQlFPdDdiREI2TEVCZEtoMGdIcmlDMW04eVhNYnQzZkdRcUdJdXZ2K0JJ?=
 =?utf-8?B?ZWwxVFcydGdqZVVnTEpCL01FSGZ5VHJHSFpEb2s0UjMvRk5iRUJlU0UwZTho?=
 =?utf-8?B?eWJjN1dtUVpaSGd0RzlMRlVFRnR2aDN6U3lQdkRySStCRlpkb0VuWWlWWGZ4?=
 =?utf-8?B?d2cybTMrMzUxYktYU285SUxnQWVHSUFxdzFzeWVxSkFtOWl5elh6VTJCUjNI?=
 =?utf-8?B?SDUrK1FYUGZQMlJZMEpjanUxbHVFVEFtWjY5dWxHSjlWbUdIMk5YakdENENL?=
 =?utf-8?B?YnpGZjlqM25QeXJ4Rllxb1dRYUJwbkdHTFYxbytFWkFSZEdya0FFUldSOE1T?=
 =?utf-8?B?aEJ6bFdSU2llekJLWnF0alRPZDNrcm50VzhWTzVIRjBTUTBJeDVFMzNBUHpS?=
 =?utf-8?B?ZTNkZ0FkZFZRQjJxQW1kT0Q1b3dkMXZ0L0JPNkVDSTUvVnkrMHo5d1dIbktR?=
 =?utf-8?B?K1EvZWxwOHV3eC9RTDVRZjlKcTVmaGhXZGI3RkVpUlh3Nkd4dktYOWxJSkVj?=
 =?utf-8?B?ZXc2N0Y1YUlxYjhBdU9CL3E4azh2OWNVcThsdWtKUXAxOGQxMnQ2SGJDWHZJ?=
 =?utf-8?B?SlQvcm5xb1BnQ0IwY2RQVWcwWGljWW5yODNCYUJYYURsZytCMU5tZklzdWNI?=
 =?utf-8?B?Rmo2Y1Q3VFE1V3VOR1JpL2Fnb0ZQWFZJenc5TURXMzlTK1J2blMyWlBBSkxw?=
 =?utf-8?B?c2JLNExWZGl2ZU03YUlOL3U4NEc5V0hNRFBJUXZ1WjBtaGwxQUgvamJlR2F3?=
 =?utf-8?B?QStqVS8yV0lpOFE0T3NSaSt5d252bjM3aFkyREJnMkwvS0pNZHdIN2Uwc2Qy?=
 =?utf-8?B?ZjlCOVM2SisvazJmekwyYzRDYVZyOHNyTzk0RlUwNU5SdXNLUVI5cVgyeHBy?=
 =?utf-8?B?bmxnY3JjbXhzZVFJWmUvdHpJZnJkZXp0RDdyRXgwK1ZVWkRJNlRhbFNuWnNX?=
 =?utf-8?B?d3J6UVN5RHJsNjlJL2dFM25hM3EyNjN1ZDNBSTNKQUFBK3lkV2pYYmpRTTNz?=
 =?utf-8?B?dk0vc2xyYmxyZzdPdHZXc295ZWFQdDZYMlczWEtJZGFxTHFERWNoZ0s0Z3Z3?=
 =?utf-8?B?RVFWWWUrcUhuNUtVTE9DUkliOEhBSWo0ZE00WmNJOTM2NCt5MmRSVEYzampj?=
 =?utf-8?B?TFJDUEtpZmQrOGFlU0V2SUJWbnd5OGFnNHhYaFB5ZGJ4Z0FWWGVSc1RIVTk4?=
 =?utf-8?B?NTBUcEIrNFZXYjJRaERHMDJZYkN5dlRadGlIanBNeFNkbWZUeFdLd1FuMXB3?=
 =?utf-8?Q?KLW7h5JM63OssXthjp4ywgZzP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab4acb9-a3a4-43ec-1fe1-08daa03824a7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 03:27:02.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLrshCmSeJESD3JB/uBLXsEQORtep58LoE/+GSEWFNXGlLcQnAnY3asWmaS6ZuOx5vM9bcLjkgwWFqwhiXVx4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9632
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 9/26/2022 8:04 AM, Marek Vasut wrote:
> On 9/23/22 05:41, Peng Fan wrote:
>> Hi All,
> 
> Hi,
> 
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
>> genpd_power_off_work_fun will use lock seq: take the power domain 
>> genpd lock, take prepare lock.
> 
> There is also this driver which does not suffer from the problem, at 
> least I didn't trigger it while using it for months:
> 
> https://patchwork.kernel.org/project/linux-clk/patch/20220625013235.710346-3-marex@denx.de/

yes, I see that, I thought Abel picked up, but seems still not land in.
I'll use your patches and need apply to nxp 5.15 tree for some test.

Thanks,
Peng.
