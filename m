Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC762553F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Nov 2022 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiKKI2Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Nov 2022 03:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiKKI2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2022 03:28:09 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083147C8D9;
        Fri, 11 Nov 2022 00:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJi2+jhTyrQEyKwJoidXCMyM2+XdQdjVw3n3VW7OHUU/W8aim3wV7eCAPDqOXvKDDkpZBe8bcWZYlwtL+ysEG50pxk0OZ74YvdveM/RtSwKnVF3LwohVnM2XpbagmbT7I3FyG9P9gCWbxJfIY8Pj4e+jMDEad5lKUAgMCyDrPHeroGuUIHyCneg/1FOy2OVlR4kp2new9L+slgRqDqri40s1Cu5Bt1gJ+osFue/9FwQ9GQ4AUr8xe0hw8DsICbgTJ9DMVuHy37nh5VY+QuvlDlkkSeY0tcZ80I0t0alcXsONFjEl1yCMnCxgGAv94hTtQFtwCW1/Xp61hCq1CahWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c0+y+1qArDJPwbWKHhbSPFhNFHoPGkTjXUswtAJZ3Q=;
 b=E+q433jztZkAYKOd72LUFGFpJlcmRIIy0csA+g8MxQZ6Ej4SZb5cO5lG2eoB7xbOvBoiKEI/0ZKUUcm74pgOmnI2UzUdPNp2q3wTV5NsA3yv5u/9wIkIbztgEY3sRrMm5U7bPuplU4Caaptug8D76XXQOTYRR5m3yH3t/2yPk/4Yp+SrTdgjVB9v38azgFp9T8GBb8B01O96RsYMmaBSe4hVvm5w4TPIFtnZeFQbi0/ptslexLAglbVXfmuidmSOK1RvhFF548QP7KAgrIe7bgu/fmai1Aw+a8lKqTC5K/Ls69hPNdH4HHyE7ZmKwPYwBYRay15kPkmsKgrW3Gaypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c0+y+1qArDJPwbWKHhbSPFhNFHoPGkTjXUswtAJZ3Q=;
 b=fVQVEd3hE171cUHoXaUnlrDP0wabWyawCH696ZEtrwbtMcNlip4zyn/qjfMLC7ya9TYhfB1tOWHvovOv2x7kbCmvdxcVyEolAb+t9ba2RVaONP6WObV9KC/RWAbnw7DiOpSejKGduxVK+o4I9RFpoKOq+IdBr3KyiSMCqermdl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 08:27:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 08:27:58 +0000
Message-ID: <b27e4649-e914-2269-f33d-e0c4370f5ff2@oss.nxp.com>
Date:   Fri, 11 Nov 2022 16:27:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 2/3] [RFC] soc: imx: gpcv2: Split clock prepare from clock
 enable in the domain
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, linux-imx@nxp.com
References: <20221108013517.749665-1-marex@denx.de>
 <20221108013517.749665-2-marex@denx.de>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221108013517.749665-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: e28157fc-caef-4969-2f38-08dac3bea339
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msNSCUUHOjs52Ypl/wRdZgXkiXhEfEocwn3qUy38Y7Dh1+VrTqWnqlf+4DS+vVjgXVlr38pIuDeocpYsuma24Bp5GVa8kOTMOwyGfHTlDfi3G5Cbm2j2jtmgMF9WpbSnc5ucaRXLfBVciY6D2QfUKKsngOF5pBtFDZrl5yKjt7ykPYtZqb443GjB4ZdQ5TngMHy+zDMdsmP0VgBiGVXWeNUQv3G4v7odvyOz61hmjh1E3KM1NNBFJd8bPJx1HRoRdEAlJHYjz59vo52JLnXRD9gjC8yN2FId8Prs0QPTF+cw4C1Lncxrli+BW76r8dmxaS9ZYMVev7UPXz8g0jWetyoFAMtCsSc+ZGKZjRvjCzRi3bGLLwIO6Vvvk+FcORta/IxT3HQqrN0yz9xFTbFl6GdCzFEPc7dX0ePk15pDbdnqBwwU0oB7Ed0pBYQXpBBYO0wpC3nu/WTfG7+NvlaXhVB1TOUCj7cDFGhtFc594+Q7g6UHr/0R876a9BjSKRTQ/AzUIWbDpoEgt0KwOFOazxLWJSvt8Ts50mk5bjohFHLSz88Gh3pTMSVz6c4iEoUd/z28GQVtcnrA4erHUw2i+zfYUiDVkkwM+OSnIgefjEIiYJlosr2z/e8SC2NxAtmmPRUnDKWFHV2pHJcoMI7Z4MT/wspAY7OY36coiVSHeldL2wQL6NUDgAXKLGQp5NszghdKirhHpFVaTPhyOk7o3WBx3U6UFKqtGgF2XAwJ682D7P8MStOF9H5KC6Wke8ehzTKvuvujxK/8LQaEACInT7Bq0LDALP6Ef7uunla5xWHqdnAQiA59fO3lPdQ0tvO96jTG1j3zoV4V0CIKSK8k+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(53546011)(26005)(6512007)(83380400001)(2616005)(52116002)(186003)(31696002)(44832011)(6506007)(38350700002)(2906002)(5660300002)(7416002)(38100700002)(8936002)(54906003)(4326008)(66476007)(8676002)(6666004)(31686004)(41300700001)(66556008)(478600001)(66946007)(6486002)(316002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1lib1dyYjJUZ2hSYmtuVEFyNk5mN0IwTlN3bldvNnc2c25rc21DYkFPdXJl?=
 =?utf-8?B?TUJrVXFucCt0QVF3TmpNUU5WcjRFSWQ5OER0V2dZbDNLTmlLTTc1ZDdLUkhw?=
 =?utf-8?B?eFRZYS91VnpOOFJ0aGxyRWdLd3dkck5JNHhPSHRNZlk4elBXZDNQVmdzckV5?=
 =?utf-8?B?TFJrWTdWWGZ3eGRRajYrQzN3M0ZXZVQyWlE0emNGSlVkSHFZbUcwTExkQmZm?=
 =?utf-8?B?U1FHbE5NZDNMbGVYdHFCczkyR2R6QjdpY2o4OU0yY2VnMFdaWW94WW9nNEVQ?=
 =?utf-8?B?WDZPbUsrRzBPSkZyYmQxTmp4SGpzTE11ajU3cGZXRy91VGNUZHlrSnFUVFJ2?=
 =?utf-8?B?Z1VZeTBkMmpSaTRGYk5QUFJGVDhGbHJJRVd3bjlxSE9kOWNzbUU4TnJlaUxC?=
 =?utf-8?B?MUt0NDEzTmcyOUhtSEZhRFArNnlIbXNLcmRjS2E0SjFQRWJURmp1bWtVbTBL?=
 =?utf-8?B?emN1WkRObUMxcnFJY3RwZ25jNU05UkRldEZFUGRaZHdQM0FMNTRrVVRkL2NL?=
 =?utf-8?B?dFdFTThLdkhVbGluY0ptR0JPaloxempFcWtXNFlzdXJVKzA2NnNRMkxoL2Fh?=
 =?utf-8?B?T29FcnRjeFZLSWlxN29iK2VlKzl0SnRHYk1rS1pxbGxYUjNscytLYVRqZHhW?=
 =?utf-8?B?MURIdjFtUUZjTVl3UTBSYk9mWXBoRDh3V1RoWGFNQWxCZWtDRm44bUdVWDYz?=
 =?utf-8?B?aTFDcXp2MEJKNkVDWHZxNWhDeEVHY0ZxWUVjNjNiZWNXWlFYY292L3ljb01O?=
 =?utf-8?B?NTRYSklPQzI2Ry8vOEVQOVY2bzNtSTcrMnVzRTBtNmpvWUxtNWZvMVl3aTNE?=
 =?utf-8?B?cWw3cmx3MVVJRUdYUUxsc0JPRE5KYkliT0lhUDVEZVJSZ2V1UnlCVDFJcmFH?=
 =?utf-8?B?ak5Fc1cxbkhlZnZUMzdCMFRRUC9NRGVNQ0NkQWtITVZ1dFhkYUVaQXBXV25X?=
 =?utf-8?B?c1hVbDZoSVFzRFBsdjM0Y2pZblQwQkhLODRGTHpxR01uanRGQi83Mlk0aFY0?=
 =?utf-8?B?S1d6RzdmYUtCRVVwdVV3Y08vc085dGRmRllKdStpWFFhaW5IcVRJL0k3azRl?=
 =?utf-8?B?STA5T1QvSHFFU3luR2VobnZnTmZva2hjdEVIYXlQODBEdlllT0Q3L0xwdWo1?=
 =?utf-8?B?WFdqelhRL3RIQi9sai9jWEEyNEhOVkRZZjNuQTZjZWpnY3BDc0lLWXIxYWdI?=
 =?utf-8?B?bjk3d3pYVHRXODFkalZTZ0V6eGdvSWxMRUp6dnR5VEtWNjZleGdjdWkzMlJj?=
 =?utf-8?B?c1czQy9EUlZlazlRWUxFbmduVGE1K21sQ1VScTZsUjA0TW1pUFVKZjllVVp2?=
 =?utf-8?B?SzNFUnpML0hiU1N4TTg2YS9ndEZoNmV3RVRsb2FNRC9vTlUyRjdNQnVyeU0y?=
 =?utf-8?B?UnpiWXFRN3JjY3E2OHk5dG94T1JJUkZLQndZOVFBQkt3bGxyRFVBdDcxNTAw?=
 =?utf-8?B?NDF0T2lmamw4dm1XTlkwdHRvYmxRa0cvQWFuckRxWm1QdElJVVBxMlpLenFN?=
 =?utf-8?B?R0NqZytuVXptenZIdGpBWFFwZkdkWE5CdFk2TUk1eTBMVWxkYVU4M2djTlF2?=
 =?utf-8?B?QjBrdlB2WXpzVGtwTEpFalJNVTdNNElSdFBzM3RSR3FCN2piQ2JYUHlHa3o3?=
 =?utf-8?B?ZnFCSEEwZ2k1cm10OCtKVkFCNjNzVWFjclQ4U3l0WmpqRmh1S3owQ0gzLzNq?=
 =?utf-8?B?NnVTUDQyN3pZZTMwS3FzNmJ6QnJPeHBvbDZkY3VuUzE4SGNlQVRQYWpYdDZS?=
 =?utf-8?B?ay9OYkh5Z3ZEYkNkK0d4VG9sMWt2aHZycUViZU5pV0VPb3lDQW0rc0RsNDlp?=
 =?utf-8?B?ZHZLckNKVUVvR08vQVZLT2ZndlZRNUkzUHBtWGRyTmFsTmE3b3dUMUovSFVV?=
 =?utf-8?B?UmthY0o1eTFvNi92N00yOUlCbEFUYmJlYjhhc0ZIeFZjZEtVK0RXKzNmUTQw?=
 =?utf-8?B?R2YvMTVpOC9Yc2lBdHVvb0taM2xqai9WTnp0K1BzTzRjZ0NUd1V2N2ZpOWtY?=
 =?utf-8?B?ZE5KcVcvSVVIaitUNnRUUFFOaXNZcVdKbTdacVJIcDJyZDdrQUpUdmNLYmpS?=
 =?utf-8?B?TEVXYmMvT082UTZ1ZEk0NW4vRjFHTWpSeFh3ZnIvNHdtRmNRUVJodXJIUWRj?=
 =?utf-8?Q?dPF3uguYaEcwiVvdZEHLS//FK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28157fc-caef-4969-2f38-08dac3bea339
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 08:27:58.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDctyg9pa1+pKA7fwbSbV4aNwJvliyn/H/vlqsKamfnm9C+LXd59Fmdi9VMQ9+t+YMQmngi1MKhYjUq+DsvyXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7910
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,


On 11/8/2022 9:35 AM, Marek Vasut wrote:
> It is possible for clk_disable_unused() to trigger lockdep warning
> regarding lock ordering in this driver. This happens in case of the
> following conditions:
> 
> A) clock core clk_disable_unused() triggers the following sequence in a
>     driver which also uses GPCv2 domain:
>     - clk_prepare_lock() -> obtains clock core prepare_lock
>     - pm_runtime_get*() -> obtains &blk_ctrl_genpd_lock_class
> 
> B) driver powers up a power domain and triggers the following sequence
>     in GPCv2:
>     - pm_runtime_get_sync() -> obtains &blk_ctrl_genpd_lock_class
>     - clk_bulk_prepare_enable() -> obtains clock core prepare_lock
> 
> This can lead to a deadlock in case A and B runs on separate CPUs.
> 
> To avoid the deadlock, split clk_*prepare() from clk_*enable() and call
> the former in power_pre_on() callback, before pm_runtime_get_sync(). The
> reverse is implemented in the power_off_post() callback in the same way.
> This way, the GPCv2 driver always claims the prepare_lock before
> blk_ctrl_genpd_lock_class and the deadlock is avoided.


How about using notifier such as, GENPD_NOTIFY_PRE_ON?

Regards,

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jacky Bai <ping.bai@nxp.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Martin Kepplinger <martink@posteo.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/soc/imx/gpcv2.c | 74 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 66 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 7a47d14fde445..8d27a227ba02d 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -298,6 +298,8 @@ struct imx_pgc_domain {
>   
>   	unsigned int pgc_sw_pup_reg;
>   	unsigned int pgc_sw_pdn_reg;
> +
> +	int enabled;
>   };
>   
>   struct imx_pgc_domain_data {
> @@ -313,6 +315,52 @@ to_imx_pgc_domain(struct generic_pm_domain *genpd)
>   	return container_of(genpd, struct imx_pgc_domain, genpd);
>   }
>   
> +static int imx_pgc_power_pre_up(struct generic_pm_domain *genpd)
> +{
> +	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> +	int ret;
> +
> +	ret = clk_bulk_prepare(domain->num_clks, domain->clks);
> +	if (ret)
> +		dev_err(domain->dev, "failed to prepare reset clocks\n");
> +
> +	return ret;
> +}
> +
> +static int imx_pgc_power_post_up(struct generic_pm_domain *genpd)
> +{
> +	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> +
> +	if (!domain->keep_clocks && domain->enabled)
> +		clk_bulk_unprepare(domain->num_clks, domain->clks);
> +
> +	return 0;
> +}
> +
> +static int imx_pgc_power_down_pre(struct generic_pm_domain *genpd)
> +{
> +	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> +	int ret;
> +
> +	if (!domain->keep_clocks || !domain->enabled) {
> +		ret = clk_bulk_prepare(domain->num_clks, domain->clks);
> +		if (ret)
> +			dev_err(domain->dev, "failed to prepare reset clocks\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx_pgc_power_down_post(struct generic_pm_domain *genpd)
> +{
> +	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> +
> +	if (!domain->keep_clocks || !domain->enabled)
> +		clk_bulk_unprepare(domain->num_clks, domain->clks);
> +
> +	return 0;
> +}
> +
>   static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>   {
>   	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> @@ -338,7 +386,7 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>   	reset_control_assert(domain->reset);
>   
>   	/* Enable reset clocks for all devices in the domain */
> -	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> +	ret = clk_bulk_enable(domain->num_clks, domain->clks);
>   	if (ret) {
>   		dev_err(domain->dev, "failed to enable reset clocks\n");
>   		goto out_regulator_disable;
> @@ -397,12 +445,14 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>   
>   	/* Disable reset clocks for all devices in the domain */
>   	if (!domain->keep_clocks)
> -		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +		clk_bulk_disable(domain->num_clks, domain->clks);
> +
> +	domain->enabled++;
>   
>   	return 0;
>   
>   out_clk_disable:
> -	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +	clk_bulk_disable(domain->num_clks, domain->clks);
>   out_regulator_disable:
>   	if (!IS_ERR(domain->regulator))
>   		regulator_disable(domain->regulator);
> @@ -420,7 +470,7 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
>   
>   	/* Enable reset clocks for all devices in the domain */
>   	if (!domain->keep_clocks) {
> -		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> +		ret = clk_bulk_enable(domain->num_clks, domain->clks);
>   		if (ret) {
>   			dev_err(domain->dev, "failed to enable reset clocks\n");
>   			return ret;
> @@ -467,7 +517,7 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
>   	}
>   
>   	/* Disable reset clocks for all devices in the domain */
> -	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +	clk_bulk_disable(domain->num_clks, domain->clks);
>   
>   	if (!IS_ERR(domain->regulator)) {
>   		ret = regulator_disable(domain->regulator);
> @@ -479,13 +529,17 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
>   		}
>   	}
>   
> +	domain->enabled--;
> +
>   	pm_runtime_put_sync_suspend(domain->dev);
>   
>   	return 0;
>   
>   out_clk_disable:
>   	if (!domain->keep_clocks)
> -		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +		clk_bulk_disable(domain->num_clks, domain->clks);
> +
> +	domain->enabled--;
>   
>   	return ret;
>   }
> @@ -1514,8 +1568,12 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>   		domain->regmap = regmap;
>   		domain->regs = domain_data->pgc_regs;
>   
> -		domain->genpd.power_on  = imx_pgc_power_up;
> -		domain->genpd.power_off = imx_pgc_power_down;
> +		domain->genpd.power_pre_on	= imx_pgc_power_pre_up;
> +		domain->genpd.power_on		= imx_pgc_power_up;
> +		domain->genpd.power_post_on	= imx_pgc_power_post_up;
> +		domain->genpd.power_off_pre	= imx_pgc_power_down_pre;
> +		domain->genpd.power_off		= imx_pgc_power_down;
> +		domain->genpd.power_off_post	= imx_pgc_power_down_post;
>   
>   		pd_pdev->dev.parent = dev;
>   		pd_pdev->dev.of_node = np;
