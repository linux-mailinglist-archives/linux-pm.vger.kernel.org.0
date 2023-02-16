Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C56698A3A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Feb 2023 02:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBPBr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Feb 2023 20:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBPBrz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Feb 2023 20:47:55 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC4815563;
        Wed, 15 Feb 2023 17:47:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EalP5pqOlmbfSsu2XpAuXnjfMTri9A6KnX1pLiBeIoEHpVX5B0nl/p+n4+vOA5ap6Da4rZW1PqpFbaVL5xtQAPURqaBqJhyIQJ2wenK9WA4ilaKI4uhokFPdJau93zDZ8RQblF9kSRJIEBSr0Hu7XQQz9plbejwvENTm+7gsM12UoW6G5L8Ox7vneEUVC+TmO3ZjMRnCciFgVpOpHx8SRvKrSyQSxxn5A89sISq1LCZMriu5WTC7rxa6XsLW3Rmd5zP0E+tdGfsotizacgmf3su4jje/G8usEc2ZFSG1Pld8dz3YsMeFo4/UX97IBC96boQXLnR0D+PlMOs3diDRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFnVm03DSvePv6PLEtDPJQ6Wnqga1oNpC4WY/nURcGI=;
 b=l+k0teKHy65c7wum+E/5Wr4Em4e4AvcnTf9Dzq0Zx1rMplqvokoe1pROGeKmcDJxRkXPTpq1mrIeiH1OcQakQy0aRZVtB3d+sQA3BksH9u8PNsVTnr4u8E8f6KobbWYFvEMgMbDEZQp85oC8HPj/61SvleHuJfU1WuQ/dY8Eo5Dv2VSSfUh1+6Cb+Vjqg/lf8qz+ljJVIgRMwEfzsj/mKB4JTq7kFydXF+KxfT0zeGIDTd0bttjdi3g+Tvkm1pqwmFY56sstyasiJbX4fP2a3ZLLSTNw0SwA8063PrS03GDWI3wH9WCQ6SjQIwtue1NDRwNI0NfsaGk/UFj08QkM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFnVm03DSvePv6PLEtDPJQ6Wnqga1oNpC4WY/nURcGI=;
 b=F/BzkTBQIF+2Cqn/qgFmII4j6D8HxspK0Vo05T4ixQ0i8/9A/DbyzN4eAlyXvzWBPwcvY+0gEhCuzOySY/3eyv12UrJeoFppQdRbz++Mw8u1OW6yP+jxDPPjOoBH6xyM+VaJQWv51xgD1GIGlI32iI/M3sCTyurNAZ21CrddpJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 01:47:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6086.022; Thu, 16 Feb 2023
 01:47:49 +0000
Message-ID: <d04c9522-ee19-ec8f-5614-c0a805b8964e@oss.nxp.com>
Date:   Thu, 16 Feb 2023 09:47:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off
 callbacks
Content-Language: en-US
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
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <CAPDyKFo8ekN3e8kzbtftKuyYY1wv0=gn3L=oz5zBjTebRT84+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 4954655f-eeab-446c-a1a7-08db0fbfcf30
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKSlqewa4qpQ3u1kYn/7PbCwQM5C++CI5P9/YitEmkL9m2Bksag446mib+hZL5Bc7kM9HxoNQC52V+OtoJODSOHGorJiw4HL9KcQFgkLkzoVbaSqrR2W6r8foQ7meVU12U6ZF/luDlRhvkzd04VN2gQlTz9AxF/L5vdQ3Cjf59zqu2WHVDCfzM8IZ1rFHZsfu8XeHGibFvn8OAOnxEcfXKSFoB5ZC6N2KBk4URaIVeyGgQWb9XLb8cZG1JAOKE0jiY8kClHB9wGSCE7aA/csLTxiiGIhxMfJWkUb7HC14FPBdj3/33yJTm7nWpHrVg8cMETAyYRoIMxqNl0gcS1K+3iw8FUrha8dDjcpYkn7A7Z/88yiBQAsuzo6fTJxeWIn/+kvoFgvLsKcvjsUhDlNuicTaJS02GiR08+0xzQYnvztVsKkRvRsHb831LQFYNoyHYQZH9CDNacQY1PlcALOemDrsqEQBUV4g4ExoV0Tn0+WCPxvbGHV6GU4Yhx5UnWZe++Fo2Z5mHjnIM27CkZJh4i4+m7nrF3+Z1oqt4dscK1LwNq/KWU56uFFV/kV81yWd3VdcuEwaO5y5hjlpeF64G/PQPzu1iJpdhDR2BpNAMKtImYi8kbWOBtpZ+xInurxbOig8DTM5GMbq2V/8eOQWANAq+zA1YVfvd2EUmEmB0pgKFhg4ggjQN1mlMetP1cboOUZ+tbOjnWDnde8dbHYWYX9KiggHbTIRdrTbXoDZD7LsaCEOPuc+9TRM+Ml9yGZ4hGMhRCo/+WqFLlj3zcs0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(31686004)(66476007)(4326008)(8676002)(6486002)(316002)(54906003)(8936002)(7416002)(66556008)(66946007)(44832011)(41300700001)(5660300002)(6916009)(31696002)(86362001)(52116002)(478600001)(6666004)(6506007)(53546011)(186003)(6512007)(26005)(2616005)(4744005)(2906002)(38100700002)(38350700002)(83380400001)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdiUnEwQ3pZTGtVR0l1RXdkSVduNjU5ZkpXWFlxL0RLTVRqekhCT0JYTEZX?=
 =?utf-8?B?Y0NJMTZHTHZFMUhnWkFyWk1NS29XY2Y0T09mWUM4QjFKQ3BvWVFNRFd1MVhv?=
 =?utf-8?B?ZzNJNGtyY1NsYlRDR0wxN0liU0c0YWlQRHhJWVJqdU9lUDlaRC9abWlVRGxL?=
 =?utf-8?B?bm0vSXJlODBvWk96Snlqcy9pOUp1VHo1b3ZaM2N4cTdBYlQxb1dsZU5LN2Q1?=
 =?utf-8?B?REhlY05PN21KTCt1L09jQjhNdk9wc2dFNTloN1JvVDNRL0ZMMHBNYXdaZmJs?=
 =?utf-8?B?cWJEeTF4REJYTTFsaUVwZzVvandzVWhEQmlZZVp3bG84WDQvQUdib2RGZmVy?=
 =?utf-8?B?NEwzYUQrMms4dEc5dS9IMVhXY0N4TEkxWHh5NnBWUFJ4dmFHSGRwMVovT2Nn?=
 =?utf-8?B?QTdKZ0xiZDVoZm53bU1xZTQvTE1FOGU5Q2xpRmplQWV0SmFQZ2x5N0JuZWYv?=
 =?utf-8?B?Zk9rc01CMHRmbmlla0xBZmZFZGxGZGJ1VFlUZWxLNk1WOW5xaVIvSUZXaXpr?=
 =?utf-8?B?MTRtRTBrbGpuaGczZWJlbHdIbmw1YzUxUGgzcmE0eHpreXgvekJla2FHUHpq?=
 =?utf-8?B?cFJkNTBsMWNpUmFsM2E3b0xDTGhqNExPeVkrSm9IS253NDI1dGd5Znl2ZStx?=
 =?utf-8?B?U3JrY1J5eXRmNWdaUVU2d0dVQUV4U1FwUngwelBvUGdzQUNib1RKUm1Uc1A1?=
 =?utf-8?B?clJaZGVJR1hCT0IwMElFQXhSaVpFcjRndzZ0Vmw1MHBjMDduMS9oVVRITFRD?=
 =?utf-8?B?T0RsdEJvRU53bHFVQ25NTHNaNzJveXAwTUpVTjZCdjBrVkxDR2VBazdDQ3ZY?=
 =?utf-8?B?b1VxRGY2bDl2T3NoOC9vZnk2M2Z6S3NLb0JYWmhJOC8vckN1WTh4SzZwV0ZQ?=
 =?utf-8?B?WUZyb2EvUEtKcnZML0VQNUNKSGRTSzZSUXorWFJxcG1YdzZ3Mjk4RGRWanUx?=
 =?utf-8?B?Y3EwVyt5SUZVVkdwUnpuM3ZIcFM0b0YyUzg0SkkxdUJFS1JOSUtPSzhOUXps?=
 =?utf-8?B?aHNsT0RaSzR5KzA1VTBIWWpEdFp3dUhtVjlWT1pSeGYrblRBUW5xeHFEOTJy?=
 =?utf-8?B?cysxVDJtUyttVUdTSlZYZEl1TktSalJTTUVMellUempkQ2lYOGt2SFZqcHkr?=
 =?utf-8?B?SmtHNE5tcnRPQ2h5Y3NDaHVnWHAxVDdPaGliejd1RHVML2RYZ2JmVnlpbWx0?=
 =?utf-8?B?Rk1CMHc2QTBMTCtTbEdKMmFuSCsxcjNBMG55TTJVVEhZYjhSTG8rSVFvZXYx?=
 =?utf-8?B?VGo1MU1tQzJDR1Y2NzA1RytMc2VKdlJ4S3lURWl6UW02YVVrYnZ0dnI0djdR?=
 =?utf-8?B?Y21rN3BGUFVhR3A4cGFLZEpNSkM0OXlUZlBzRTNDNGtIN1lNL0tHMFpreFph?=
 =?utf-8?B?NXpaa3N0aWE2SlBPQlFZUWpWc3YyWnNzaGtHRVowbHZOeEZYdmpiZjVYRUwz?=
 =?utf-8?B?SzZWZ05ZWmVEc3ZIRTlsaVltaUllWnRHR1JUK3FFN2JzeG5aMXIwWGdMYnZY?=
 =?utf-8?B?YUJPU1Y5NmJNKytiM3h1Mk1HQ2hWTXdLRkxXTXhzYTVNazl5c3p0OTk4OWxW?=
 =?utf-8?B?WVlGTnAwNzkybzFFTERLYWZFdnVja2RLVDQ2ajROdkFyYkpyRmFXM0dmcC9B?=
 =?utf-8?B?azhBdTI3YjRGc05mU2FDTmYyenJ6Ky8zZ0RSNHp5YXRvamlUd3JDclh5YlFM?=
 =?utf-8?B?dzg0bDIyUzZ5TnhWVjlQcDlKc2xRRW93bDEyUVRDM25ISWI5UTBEcWJJcWFL?=
 =?utf-8?B?cDZPeVNtWm01aVhnaE16VllPSVR4UmVHamJ2TVRpWnNIVlBrSDVrUzRBeERi?=
 =?utf-8?B?R3l6dGc0UHJ1NHFQUDczWVAvdFJpOG1CbHpqZFVtSU5Held3UTZBMmhkeTc5?=
 =?utf-8?B?QnZVaFA5bm9MUEdYbmVyRzBOVE9xazk3SXgvY2dnbXhidzlkeERZSWkvajll?=
 =?utf-8?B?WFhqQkJPZmJLbjRwVXEvbjhxbTkweXJPb1NEcTBjYTJTTjNNQng1N1lrNzRI?=
 =?utf-8?B?LzlwYmU3ZkZNcktZTTAxYjh2aHJjSTFpaloyYjNiOFRoQXoyUjVUemxVZ0tv?=
 =?utf-8?B?c2VaS0dQNzJqUS8xN0FwSXZmRHlDV3FGSTRidTFiZDVlbnphUllOQzNoVkdV?=
 =?utf-8?Q?n5XR0El1JfdmAfrCghVZ450ma?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4954655f-eeab-446c-a1a7-08db0fbfcf30
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 01:47:49.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReMYpWWYayA7SgL1gBxKhtuIMdwPfYCbK3ghw7bSbtHwwGiETKFsZKOIVpl/lsGBx945iYGpRudtWnmhSuVBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On 1/18/2023 8:55 PM, Ulf Hansson wrote:
...
>>
>> Honestly I not have idea on how to rework the clk part to avoid holding
>> the clk-prepare lock when power on the phy and its power domain.
> 
> I understand. Let me try to prepare a hackish patch that we can use to
> run some tests.
> 
> Unfortunately, I can't make any promises for when, but I will do my best.
> 

Have you got time to give a look on this part? Or do you have any 
suggestions that I could help with?

Thanks,
Peng.

>>
>> [1]https://github.com/nxp-imx/linux-imx/commit/c85126180a10439a8c7db1800529b4857d91c609
>>
>> Thanks,
>> Peng.
>>>
>>> Kind regards
>>> Uffe
> 
> Kind regards
> Uffe
