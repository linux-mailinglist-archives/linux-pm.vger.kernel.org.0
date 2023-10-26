Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9FE7D7FEE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Oct 2023 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjJZJrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Oct 2023 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJq7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2023 05:46:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2095.outbound.protection.outlook.com [40.107.7.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D9192
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 02:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1e1lSzMyDb6gmhb9utWkKqIheu2rMDYwBSaJydnmuZcu0ICoHizAvF+0g3qx+qJgn+jBAKykThSdrlQGfhGl4tI5M7jgCZhv5URTcvOx3tLRyDQxgU7g7NVHzALoYXm8Zx6eiixvcoHVK45XGVSk/PajLWuOMzzO0Y/EFr58FBrraCYeFr407XkfRkgV3dG3g7wH2Zuf/OFrA6jj78v63EDlGTTfnWpLZEut+FUPYCbfdToG4HCQJ4lQ16fD7RNgC8agn0Q4qpcAxgQacfK3xQf4hgWdsri35WiGO4mhhma6n1R9eWQB1pj+7SH3R0FnsE9wFc4nFLrZuvJh0e56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBnhdhUDqF+A2KIQK2/Vm6sLr8xOI9TrXlzsB9tiVMM=;
 b=KxfGcpnrmijqY/Dc19kqcj5S0ibm/fyZ6gYy04EKKrGAl2ZdzEWS3kqKhJVSFyzeCU6dYXruXJXLbtewuQk8OnMW1tg/zoBSDRWzvuGRQ3YO8QMMAvplISUmQK+GVFPx1nkrMwM5wyLJD6SoEnfwgdsMSSUwrqQdNxqy8Deh3tnnHKc57RPpSYMFS/WbzxRKQAJ/FeLqX6KGAZgEO14D0DveTMmPSwXGyY37PqorjgxxMbt6LGFVu441IpY9r4EWFMQ0JkNeWtznowrya1LPKZo8TzrHC298PL3XmlO57QL2qw0exHSxzSj83IYUNC9PhcoVfWMB6vsr2eMW/f7S9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBnhdhUDqF+A2KIQK2/Vm6sLr8xOI9TrXlzsB9tiVMM=;
 b=gwe1zeccXOXPLPLsdx/pVMuR0cs8v1sFyMbEh25tVXKgYGwmhSPc2rBWfg/UfeoDJTNLVAbzOOcWj7DnQGYC/68fl0vGowehtV8uxuYXc3iRA8WQFND1azcDuzroOvuzJz+QgQ+KYi7hqwkcpO8s0xv5wdM8Q5ylmSuQoZ4M2v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::24)
 by PA4PR10MB5561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:272::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 09:46:51 +0000
Received: from PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5133:ebf7:df87:bf89]) by PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5133:ebf7:df87:bf89%2]) with mapi id 15.20.6907.030; Thu, 26 Oct 2023
 09:46:51 +0000
Date:   Thu, 26 Oct 2023 11:46:38 +0200
From:   Emil Kronborg Andersen <emkan@prevas.dk>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     festevam@gmail.com, Pengfei Li <pengfei.li_1@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
Message-ID: <swizshtqxa73l7whxqn4zcx6clatkkibuo57ne5qvi4m3gn5rz@d5bz34twjbys>
References: <20231012132214.257207-1-emkan@prevas.dk>
 <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
 <CAPDyKFrjtZH-yHu9od7bAA69=AdUHmsFr-amhhW70JLCKZGH5g@mail.gmail.com>
 <hhx2tqxmgrjbhz2wnhozffpcq63spuli4mrensvbnmilrvbh2d@6qo444ddawc2>
 <CAPDyKFrSzepC0c7-XGeGcHSsfpEGpF0a9ATGpemxvcc8mtL86g@mail.gmail.com>
 <CAPDyKFotwRPBLpOe6q86b7JhS8t36wP2wvn2hid5uZ-57J9Ytw@mail.gmail.com>
 <3jw4nompbmwfigjetvob6pxxac56tbavifzvf3kbvsubtvxwvk@oskzm5ihpc74>
 <CAPDyKFo+sa7xutrpLs0avceV3Ybd6koUkEhBXV6FTAhpPG7A_g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo+sa7xutrpLs0avceV3Ybd6koUkEhBXV6FTAhpPG7A_g@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:10a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB4576:EE_|PA4PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: c015155b-7842-4b8e-3b7c-08dbd6087acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5wESFyAItdwaJHLJDc0npvKiufkZFg1L5c0k8i4juIIkEW/7mWSvxIXAuPJ7b6LyZEDcCALhSf05YRCcs4ff8xP3rNt9TsdEIVWLjwvYfpXE2iHeEviBTvlxTYoFYtLPDz5WApio51fxIOp90WSI1VOycrvqfCxwAOm6mCHlDsX2BwYlrteDtLfABnmr8MHSLQnFZeMdAiSsRKrb/0THdbz6Hl7mFVAMq2lFegR78LJnQEM7sTlqkSSeDzk3d4DHCfSr2lpvdCnQSz7F0CWE9cGHKoZ+YAZoqeXZaPMr7H1NqJZydI6fyWOaQUSc5TbHWJBgfV06f+i2k29EeCiGsrzTt/QnA3SVixWQJB9tAOemlbSbijOOAEf49fiKruADuv3H+NQ7ZHXCvViG6hjDhxhMzgazMsazsb4MhrxG3c4gghQvz/4UG4WP2Tcx4Ac5eruoxuQ3o5qtVTXUQQme9gYVDUaArBaQbsdeLJJGLr4zGhBClUabi+SlBmDCjOx9bkCmDp1RYn2KB64MQO+Srb64X9kJJopDnr4HHf0AHpFRGtUbGBGwUoxiUwPQg5/bDJNQAEPnmEVfvP1aDPwwPcmJSLpmKZlvr0S9BhbLrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39850400004)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(52116002)(53546011)(6666004)(6506007)(38350700005)(38100700002)(33716001)(86362001)(83380400001)(6512007)(9686003)(26005)(7416002)(66946007)(54906003)(66476007)(66556008)(6916009)(316002)(41300700001)(5660300002)(6486002)(966005)(2906002)(478600001)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8vRrdcFf6GoF8GsrCebJKkLQbRN8HOOyuCBaWEfd5gpIZYvP3w4Z/UvfTZQ?=
 =?us-ascii?Q?yaMJ8U3ouRJQsUnlL1f4rNwAcjXtrBj3qtUdVonVKoAJVNTpxf/P714zWWIU?=
 =?us-ascii?Q?CXbtIZckPrU5VJqTig1shE8N7hVY8rSVwXGAbgRPICOcILT3YpOcaIsQtLL/?=
 =?us-ascii?Q?/M7zeIwMdzt5YZ7AKmnN5zIsvGyz/JBMknMdgGtooQ9x6/R3AApt3rzblYHa?=
 =?us-ascii?Q?W/CpaDueLrbotyRpKcaNRZ4+fWmh2piD3k6vvFCRCPM1WeXvMY9GmDD6RqCW?=
 =?us-ascii?Q?943eiBx/NqiWqqfvIrPZhJPly+LicsSMTRu2mpCCpQHXbxtEBsZbz6m3jM6u?=
 =?us-ascii?Q?ZiUQyVc9QgYuT+YyiqMsLKls+WulZz4QazvZfZQ4ppaj2ELZRtnLO1Cl/qWp?=
 =?us-ascii?Q?LVHNodmrWMOEfO1tS3oqu+tu5mCeHC/YWPLIK6Mc7cSApPdAL2KHAghFf19z?=
 =?us-ascii?Q?1mmuDKN+35vmVQHeUrY0f3D+5gkQxN/4fJn0roUwUgtw3Jcbl8iOUS14IgY9?=
 =?us-ascii?Q?qdIh7UBexi9LCt585KPBCjCCXYuqdNk+H7jPJIR4otJpyCb9mO8B+c2UAecW?=
 =?us-ascii?Q?1UXaXpHjHwP3ghIjBeTBFkZ7YguqtUJ6nSiT/CpLMMS2NjWhdASuaruD6ed5?=
 =?us-ascii?Q?uBQykRtVhxyRjNKhyDKA5wha1gSkA0smg7OTrCnxvmYkPyuE+i9YBWLX2x3u?=
 =?us-ascii?Q?USPG9bdayWTOpVYQxXW3pqBYfVPabSZLhgpt11qAXH5pPZQnCHBcXuB7d1Q1?=
 =?us-ascii?Q?pucOjTfcHuvZCVIqn3Lg6VoTGIXYkRaWbRNeJWOoRyHBBi8eiNh6D2J6Vxtd?=
 =?us-ascii?Q?uxRBcMAlEsGF+X/pK68Dy5GBl2JJvf/ZuK9q45T9Q80jppMYfkGaWSMuwY6b?=
 =?us-ascii?Q?WvaXCeqFKGRqWVLtYoAsx9ek0LRkbIueyZA+BThjuvd6LKcdi0L8GKxZzWcn?=
 =?us-ascii?Q?XjhFO407frhr8WCA3Q3yhWl0JyGSfT8UQU/qDhTjZiSdRbg3SqcEgxERzRdx?=
 =?us-ascii?Q?ow2jK0ML7WMkHeKTO2ztgCqda8ID14Lxv9UPj11z4+FGP4LoOXrCEa41DotI?=
 =?us-ascii?Q?VGM2+EmCU4IInEKXLwEe8AlfnPSRxkBrKQ84g/1tHiSrhX9f3Nehd7DojZhs?=
 =?us-ascii?Q?M4arx4AhuV2pAZGpprMRplqa5pFgXk2g0MdHsq1YDHnq0RVRaEbhk1B4CazI?=
 =?us-ascii?Q?AlJZRAwfK710k7sqr3e4NKbhhLHp6W5wswqGCdxPL7OMTQtxR2inm2DojaRq?=
 =?us-ascii?Q?t8t91rm/hO28c+hwtOzQPCagYwMWfF1i8zPE/kVMcqKQhLN+lTwzNWko7DTQ?=
 =?us-ascii?Q?alxXEJM1ubE+hBDjFjxc8kvQ3zvy52NHkPgGP5606LZNrUQ5ubOmPIEHiPxN?=
 =?us-ascii?Q?LP76wf91dsHp/MfXtABc0YIOrxegvlNZByklW6DT7u/ZHAhs1dR3W/jnH1Iy?=
 =?us-ascii?Q?TEn9Jy9T4gpmZ83qsIvk93GNwYJ4TSxZFjVChVNBbfaXuLzIVY5nLdBQ3vpe?=
 =?us-ascii?Q?WZZaVHCPBdK5/iLqjZD0ByyaA7qXJhMpQ3YMzkNpb5bXGRYO/oj/6FojgqYq?=
 =?us-ascii?Q?U16MXpz73k7qYA7z9EWcAFyNXU8YF+EsmMiacJiUMEV9ccSLNDEbbFIEo+ak?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c015155b-7842-4b8e-3b7c-08dbd6087acf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB4576.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:46:51.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD/2jc2MFHV1PZb8kXFEeR/972TxIfzUc90mozqtTcCyfCF06Poigyx41HwyoZHI53/pnI6ql/hHMwkatt3lzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5561
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 25, 2023 at 17:35 +0200, Ulf Hansson wrote:
> On Wed, 25 Oct 2023 at 12:12, Emil Kronborg Andersen <emkan@prevas.dk> wrote:
> >
> > On Tue, Oct 24, 2023 at 14:42 +0200, Ulf Hansson wrote:
> > > I had a bit closer look at this. If I understand things correctly,
> > > this problem is because the imx_gpc_driver's ->probe() (imx_gpc_probe)
> > > is allocating/adding a new platform device, per child-of-node to
> > > represent a power-domain.
> > >
> > > I suspect in most other cases where a platform device is being
> > > allocated per child node, is when the child node has a
> > > compatible-string and the parent driver is calling
> > > of_platform_populate(), or similar. In those cases, the "dev.fwnode"
> > > would be set accordingly, but not in the imx_gpc_driver case as it
> > > needs to be set explicitly.
> > >
> > > That said, it looks like we should move forward with the $subject
> > > patch. However, it looks like the patch [1] from Pengfei Li is more
> > > correct than the $subject patch.
> > >
> > > Kind regards
> > > Uffe
> > >
> > > [1]
> > > https://lore.kernel.org/all/20231020185949.537083-1-pengfei.li_1@nxp.com/
> >
> > That is also how I understand it works.
> >
> > I was unsure if the patch from Pengfei Li [1] solves the same issue as
> > this patch, since there are no errors included in the commit message.
> > However, after testing the patch in [1], I can confirm that it fixes:
> >
> > [    1.039830] imx-gpc 20dc000.gpc: Failed to create device link (0x180) with 20c8000.anatop:regulator-vddpu
> >
> > I based my solution on other patches, where device_set_node() is used.
> > For example, a26cc2934331 ("drm/mipi-dsi: Set the fwnode for
> > mipi_dsi_device") and 6dbe6c07f94f ("gpio: Propagate firmware node from
> > a parent"). I am curious: Why is the approach in [1] considered more
> > correct? It seems logical to set the fwnode as early as possible from
> > the parent its device.
> 
> Why do we want to use the parent's node? The devices (platform-device)
> that we allocate belongs to the corresponding parsed child node,
> doesn't it?
> 
> Kind regards
> Uffe
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

I think you are right about that.

In [1], dev.fwnode is set directly, but I think it is more correct to
use device_set_node() instead, to ensure that dev.of_node is also set
correctly like so:

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 90a8b2c0676f..22d5c29da79e 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -497,7 +497,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
                        domain->ipg_rate_mhz = ipg_rate_mhz;

                        pd_pdev->dev.parent = &pdev->dev;
-                       pd_pdev->dev.of_node = np;
+                       device_set_node(&pd_pdev->dev, of_fwnode_handle(np));

                        ret = platform_device_add(pd_pdev);
                        if (ret) {

[1]
https://lore.kernel.org/all/20231020185949.537083-1-pengfei.li_1@nxp.com/

Best regards,
Emil
