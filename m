Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70977D7DD7
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjJZHyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 03:54:12 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2106.outbound.protection.outlook.com [40.107.22.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E466D19F
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 00:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaMlv1ypiU5yDLEgJY6t6g6kyDL5b1DZSRtlb95vLlUoOrZwv/dltKludjh/eolc6FM4rGPKmGgmhUVh46Spmn36nMiamyKiP3HEwC5kq51AKlxHIo18KC4K+mXnr4ZpD1xfFdL4UvVP1ugOUCk/l3e+p0v0jYVakqL6OrOYqGUxDBdV4ofmHM+U4FNT6bxdBU/fVr2ga6Mv764GSiLTUw54gv4zaP0Ndi2Jtf5gTI2FamLDcDqUIH+QBtU//iETh6ADE5cT9IrRfH+iEoXu3zHQAgy2zPMja/R2nyjfMM5eY2ueSS/zXTwF5Mtpp9Kpx3/VmaW+ZkAFlpd6bM36nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIvLi5DwRltpNSFSJn1mrH/4UUGVFY+fMjxh/AWA3Nc=;
 b=Jyt72yBY+hvenIPNpNxVxDJmR8LOeOLtRpZ5B7jvnw0jbImtnnkfHYSf8QvqKz1JhWVye/5zkhnpjj/1lMn0mUXCHLGZmsUyaTxvgrGWJ+9RHou6443kCrIoB5vD3AyB5Hd5Hfu2P5+64OVbLITzmunsXpcccDybGEr6rn7DIwO09fURKhPKkhrp2HFoX12HqUdyU//bxaoJ1ciNoCw80yfvTv/aF3Ox22KnxGDg6qvB0QaHRJh40ylWnYUugvCtA1GApa38B4UK/vKi4302mtg3KbOWi3BRQc1VH4SWc9jKKnor2PhKzKubTq2A2vxBfENSK+flXMRivLJMb4kR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIvLi5DwRltpNSFSJn1mrH/4UUGVFY+fMjxh/AWA3Nc=;
 b=RfUSwWXSl5z0Sx8hsLWH3bIkAxY/PAirYqarq8g+knXOlsfcNT7fLgB+4bGvXZ+dXz7APBfQ8OIDMzUlnsnYZUYkYbIr24s3/GcddKSqVPw2utTSIMXNn5qeduF9kF623sf5OIqIzxu9sLoeQl40rw4Eb2kVKLshQDaydt+z4X8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
 by PAWPR10MB7790.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:367::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 26 Oct
 2023 07:54:03 +0000
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5133:ebf7:df87:bf89]) by PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5133:ebf7:df87:bf89%2]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 07:54:03 +0000
Date:   Thu, 26 Oct 2023 09:53:56 +0200
From:   Emil Kronborg Andersen <emkan@prevas.dk>
To:     Pengfei Li <pengfei.li_1@nxp.com>
Cc:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linus.walleij@linaro.org, rafael@kernel.org,
        heiko@sntech.de, robh@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: imx: Make imx pgc power domain also set the
 fwnode
Message-ID: <hm4ae2dr234wvrcjqkltmudlxqybkpommqewkfqqdo47s6jffi@swy7wtro7rdy>
References: <20231020185949.537083-1-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020185949.537083-1-pengfei.li_1@nxp.com>
X-ClientProxiedBy: MM0P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::35) To PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:10a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB4576:EE_|PAWPR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 405ba3bf-bff8-4738-a5f7-08dbd5f8b8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAj86bDHojmuw+mNMmmI0gM7abR3wVB3fyAxWaSqj3LdDS2m3rmJx4jlOMRXadHFHG5X/d0IjEn8nkdQbKuclevjHH6VIJGmt3sTSS19f/+Ar4pLts8sMl0ENxmoJvJU15hfrO9ztt6a7GIwiriIWftEdO09Unwd5QJfPx8BfuE/IP+/mZJb4IidsWT2+WkXoMfqf2CbGoHJL+/xmc/yaAVzqcwFu0ScMTZNk5tC6iRo5S4oXfAIhcKD9NNYCmskTL33RKdleTtcOkUpPAkIhCtHQofzJ4XQR7DW0JTjXlriIDz2/zPqUhT6/1dcxnyk2S5KeZ29GhkOnp6U3599zssNKyzK7yDBMeP0ETiLhZRpIHAZ/vgbJyZEzb+RhM9QCFfuDyY2q5kcSi26JhPo+XiJ9YSOfeXH88hWTlNDITYdqbHFNcJ1D5wDeLORd/iTs3uEpQdOycaUO6jBtK/uPdwrLqvgZ1tDeRCwO3Rxzkv7iDXjNr9ocYOXcXZRzRZz7NqVTgc/lzuA6/RND85ufYBKixJLIZHw/GqCf8CrqLBaT4f+fPzD/VHqobEZZTLZCHNg3eWjmLdHlYOp0sxwgYDdgeYfUerwaN7hYoqpD6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39850400004)(366004)(396003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(7416002)(316002)(86362001)(66946007)(8676002)(8936002)(4326008)(38350700005)(41300700001)(5660300002)(33716001)(66556008)(66476007)(6916009)(6506007)(26005)(6512007)(52116002)(53546011)(6666004)(9686003)(966005)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ES5PZ1KBpslke/0WPlOnE0f7oOQtewufEsDQwvo9Al/Ngfi1FFcEaS0T5hgO?=
 =?us-ascii?Q?Ah+x//d7GivEXSAuZiBz2rOxXElR2QaG36XmULyH2CroAVSnYfr5I84Y4vqX?=
 =?us-ascii?Q?tqIneoOF4TbqM9tE8KPS1cb9igixZ8VW3zyKiZjL1y3DJb2CZrYBwAi5tn7e?=
 =?us-ascii?Q?fBSMXy1QXxK9GWTs69cg3cSfGJ780YegwmnyREdwH78EsxM9V5kiV5dhq9II?=
 =?us-ascii?Q?4vRPIeeXe7evqXKJDn5iZ7HF0M+EPuJvyCCjtEMXSWrh28H9MkGeKiMh6ftZ?=
 =?us-ascii?Q?s46Rw4Hh/hODZEu0j2KG2byj4CQQHbrNDdsk0bVSRLEAWKdWNi070qbJpdKf?=
 =?us-ascii?Q?9gs00VdOiUVb5bzLSURJq0GDaFqkkTAj4t3gzotYgMqP1j/tcTfrVXx+tH61?=
 =?us-ascii?Q?GjeqP+tkC0/8U2AbwIzRcgt0R/cRifJWV3yxWMLkKiYXzpyfGOQkCzQOatnc?=
 =?us-ascii?Q?oaVoXIQAOzojG2id4aqcdt+ESh5MDd7KZYB09GiX562aGsqPJHLhvt6z0FCj?=
 =?us-ascii?Q?tFTfOn426wCdxIAkn1bHh7LuWPWKOaIEptyPZ0rk2jg8ckmrBWkQph3LMKXf?=
 =?us-ascii?Q?N7LHpN9IdSNRyNEWR42WSWbn5jzsU97g3Mqwn+wAX7Qr/GNzZTCsdxd8TNG3?=
 =?us-ascii?Q?dU7AcnoWEyUq+dNt9bvodaJNcQ6ixmVy7hqNyrMCX68Bsv7n7/Do6fock284?=
 =?us-ascii?Q?XmuzDPq2nSRPsPsqaQEkUUxbOcPilTihs/UwokFICKs9TJDbgmulhpsF+9FB?=
 =?us-ascii?Q?u2KT6IjnX17sunIJvSgBZgOZ01gfXIghXwqmo/jP9odxitBgeRoIP+UDU1Ue?=
 =?us-ascii?Q?1g+PRbI6w9Csr+GoCy9h4HfDLsR/VbFEwxfBDdh+n2+cnuonPvzG8B0THF9x?=
 =?us-ascii?Q?/eD8xSUSX+qUDaoqk7FmtqjVZks1Km/7nqaZSqVoMOhVPe2R/m1DExA1LnnY?=
 =?us-ascii?Q?FMTu0tdcVy80pSLsjc4wJXU9XkUIOGMozWHQzAmjLpSJOjSnOScylH42/DGW?=
 =?us-ascii?Q?R87iDcNR3haDpFAdj1FbUTso0NvHTicaak6KvEmrNEp9Cx5yWcO5rpjXm0iz?=
 =?us-ascii?Q?qu8IUmbqpllgh2lDKElvjxmxGnya78IachMblpNIxyZStVyMb5z3HIQe96f8?=
 =?us-ascii?Q?nqtuSlR8MwAepfbMdq8WMjG7FFSpUTzh0/SBfFZXHKYCyZMnFy3FxDzwVTvZ?=
 =?us-ascii?Q?/ug2y6qk5VNpTF2w99SBk9i7e8fGBmeLxl+zPy877drpYi3kPtCN4F6ynSHl?=
 =?us-ascii?Q?DPBAi/VV2cPVTa9/2kUy+tMROfgBPQPBd/3iWJq94QdgMZmIZ3a0hzUURcT6?=
 =?us-ascii?Q?JXBR+Tta4KTpXEcwWCEPqPOz7tDe1YRYSYU9LjuOZZhhlpk5/WBaf5rRzM1R?=
 =?us-ascii?Q?8OW7JLdne2YzzbHVaDqrjv0V3L79IivHaaCZ5iMyMJ+U8BNyGLcmRo9hVX5p?=
 =?us-ascii?Q?K9ZuYoo5I3wx/dMQTKMwDMi4sA4tINpSn6sCZ+eUCPNi5mBCbkuK7QQq8jJx?=
 =?us-ascii?Q?WJB1vHX6M6alpXoNkhC+w5OItrcDT5JIoPPt7tML34PSmy2eQM/drY5nvrzK?=
 =?us-ascii?Q?2Ho4QJCoyczm5QGHDgHIY0ERVGe1i4JHbB0Ch7lWVgTwd63SG53LdhOqTggf?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 405ba3bf-bff8-4738-a5f7-08dbd5f8b8ae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:54:03.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXok0Aav25clZImR/YVGxsWv0QX4WqMvNNcM6lcl04G+y3j4/KCSXwbCqPMwkYSN7sxXxnQdE2qUvP+3tuQk1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 21, 2023 at 02:59 +0800, Pengfei Li wrote:
> Currently, The imx pgc power domain doesn't set the fwnode
> pointer, which results in supply regulator device can't get
> consumer imx pgc power domain device from fwnode when creating
> a link.
> 
> This causes the driver core to instead try to create a link
> between the parent gpc device of imx pgc power domain device and
> supply regulator device. However, at this point, the gpc device
> has already been bound, and the link creation will fail. So adding
> the fwnode pointer to the imx pgc power domain device will fix
> this issue.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> ---
>  drivers/pmdomain/imx/gpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 114f44ca07dd..7d81e3171d39 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -497,6 +497,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  
>  			pd_pdev->dev.parent = &pdev->dev;
>  			pd_pdev->dev.of_node = np;
> +			pd_pdev->dev.fwnode = of_fwnode_handle(np);
>  
>  			ret = platform_device_add(pd_pdev);
>  			if (ret) {
> -- 
> 2.34.1

I originally proposed [1] to address errors like the one below:

[    1.039830] imx-gpc 20dc000.gpc: Failed to create device link (0x180) with 20c8000.anatop:regulator-vddpu

I tested this patch on an i.MX 6Quad board, and it also fixes these
errors.

Tested-by: Emil Kronborg <emil.kronborg@protonmail.com>

[1]
https://lore.kernel.org/linux-arm-kernel/20231012132214.257207-1-emkan@prevas.dk/T/

Best regards,
Emil
