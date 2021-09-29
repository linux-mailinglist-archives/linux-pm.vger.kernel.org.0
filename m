Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00F41C3A3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245741AbhI2LqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 07:46:23 -0400
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:43650
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhI2LqV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Sep 2021 07:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhSppG7gymRfKZExZu7XePHIClaWLTDa9gpbKNlBRmKmCe0ZaU9Pyw5HansCWUo3KBebHzScjYqOGzsAgt+UEEqAslkGi6vphs5JEIn1tUtsCQLmLzRY0fXttESvM6stPWrbDlrD0HSFxNXlEzkyOzrhhiSjl/i4z8O7GN12cq6mCt7x+rKnOuwxAEcK/fdDE1F/WaGPcibWShwHLLPT8UjC8LEXDQcKD1lpOfru5CNG4VaYqaXi9r54qAJ/lzRi9EjP7S243/XxoijXaPhJkW6GpcEgwUsmONNpzg3/Pkhj0hyQFQmqMOw/kFAeYmSAMAZj1stnbNX/nHDoy7bkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zBM0S24NoewjkE9YXOHiT21vjZ1v/h1aSr5grt3rH/k=;
 b=eR2/gyqlMvczyyz6Egtcn9ZujbRdCz47GjQCjj12Hwajj3dZQb746CO4y3o4s+78sL661o9L8x75a826ZScsV4U+MhthwosFO81dGO/Rs9prSFUVISN7kozquL/Be9+VL6b6REWvdAbFaXI7MT/gKVSfShpfOg7u+3vUzKe0RBxyl2xqKkMBkuVCbuBIFneHl38+20xhJ/FUyAnBeW+gpZJ0Vsp6ubMs6/p1plXueFAkNVZ/2q08+DXosjQ1krdIRSSh0fFoxw1P13iu1rz99pKhqhQEVhMl9jIGyf6a87W9p2ID0oCDf8rGOy3vA1+J9dE/FnSNgbn6ruaaRJqfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBM0S24NoewjkE9YXOHiT21vjZ1v/h1aSr5grt3rH/k=;
 b=VxgAPTQy4xFD2rnf5WW0uBgR4Yf+evIBJ9zV9xg1GqRCI8R8M9qp0HH+qJUC7e553E6TqdJxMoW1Lk0BmFkAAKoDat4gY0qd1CIORU7HuXkrWUVq7NB3BZ4nlu2DJ2ftIxlepO0aLB/8FOg97R5cVaVsE07Vd1N2HbtnpJxAAz8=
Authentication-Results: puri.sm; dkim=none (message not signed)
 header.d=none;puri.sm; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR04MB5263.eurprd04.prod.outlook.com (2603:10a6:803:5f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Wed, 29 Sep
 2021 11:44:37 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb%10]) with mapi id 15.20.4544.022; Wed, 29 Sep
 2021 11:44:37 +0000
Date:   Wed, 29 Sep 2021 14:44:34 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     a.fatoum@pengutronix.de, adrian.hunter@intel.com,
        aisheng.dong@nxp.com, catalin.marinas@arm.com,
        cw00.choi@samsung.com, devicetree@vger.kernel.org,
        djakov@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        myungjoo.ham@samsung.com, robh@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, ulf.hansson@linaro.org, will.deacon@arm.com
Subject: Re: [RFC 00/19] Add interconnect and devfreq support for i.MX8MQ
Message-ID: <YVRRomS8ut6NjYlV@ryzen>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
 <20210924102026.2679952-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924102026.2679952-1-martin.kepplinger@puri.sm>
X-ClientProxiedBy: VI1PR08CA0221.eurprd08.prod.outlook.com
 (2603:10a6:802:15::30) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
Received: from ryzen (86.121.85.242) by VI1PR08CA0221.eurprd08.prod.outlook.com (2603:10a6:802:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 29 Sep 2021 11:44:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7361a64d-33fe-43af-a933-08d9833e836a
X-MS-TrafficTypeDiagnostic: VI1PR04MB5263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5263CFFBC39A33249936ED18F6A99@VI1PR04MB5263.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+51PLwIs2YbURH5nVMngIoT5ZdXzbyO1sFggUIFjwZtEQwdGPptt1cnCq1a+4Gm09E+ichoIB+oQe+0XlA1mzYERP8HQNIsE9W2MXUtLQ9rTjEv4KfLdvyVvb8QmclsEmNF8LeUNIHueTbtXzR1nvmFwdo/mknaTQ2zlwHw93rszwINdMK0EvMQ6/yHeji3e55aEJ8EprJdxK8dJ3x/Y2+dJvfJk9dYsmS1WzWoK/kSC4FY4w0878A8ZYxzrRQ4Eo0HBrdrYmPGCVfgiuU3hLtkmPAqy0ygt+/oRah+7l1dx8vb1WdwgmPvtJv2UCJOPZVRlKHDofKE4JnA3OjtpZKyN1fdHfJ4eBq+iXPoZtaVvVMh6f8iFJF47XWXJvNWJ9mpEgiTlEa7uyREKRbdzmj16vQ8Tns2MNj/0xSjjQvqBav2w8v9Dm3L9LcPLOoJj287iP8LiGllOSK5ZMpUs/2W0D0xFAPmUKLSqRgsexErNY2CEqGcU3ktTcqA2ZCyDtqi7ssvQWzWsvyR4kUwVZp5pIuZ7wGp/l0QgQV0kPRDy/TbLOpxQ6XIsbjNvk2FuMoCoPGn2P9X4EjZj17Kk4Fli2FNRgYvVpEYm/YYfG1L5En1YY9F7TC7Vwp1ASOpmU0gXCcOxHWjs9EcXvdaaliCDKd03It4KH817+OdBKTayo6zY+mBXvxsQYSEGu44uYw3bmV8w0+N2XHc49NVN1SnkYGxTWfNwHALXg7No/BNz284vtajlgvZasFoQpZ4ZLu8mxsYn6CeSvD6i6bNnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6496006)(55016002)(6916009)(38350700002)(5660300002)(186003)(38100700002)(9686003)(316002)(52116002)(9576002)(26005)(86362001)(53546011)(7416002)(4326008)(2906002)(508600001)(44832011)(966005)(83380400001)(66556008)(66946007)(66476007)(956004)(33716001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RAda+RRIROAS4jSLcA9vdIkml1Zk/Csu+xBn5FITbebiQLsrscT22VW4z1iI?=
 =?us-ascii?Q?9N5bW7tYJfVsOeZk2bRAqUTNkmWGqk4jTaqhiBBWXtfZCaHh+MZykSPI5tWd?=
 =?us-ascii?Q?x8rK6yEr6NpEQNidTClSNvLMTLgwMtQaLihHImDjUN/UXkEh9Buqa2zGDFq4?=
 =?us-ascii?Q?EgLtdln/EdTVtH1Y28zdse6OOmbo+ApM4I9TEMZBYLtdbGcVYnN5DCaQVqAJ?=
 =?us-ascii?Q?cpqImSX1maGP2i6gsDau+ACZpqyeYGcSXAi4o/KZG3ptoSrf0g0DLUoI2FI/?=
 =?us-ascii?Q?ED0SEgSxOuKBBHiTbMDc2G5E+DJuXsDk/Wsp7BK18XYvnxOjZ4zv+aBuSLAz?=
 =?us-ascii?Q?gWBI/XUSl/JBmv2qpxUSSmccIF5zrBi8KHa1awEagYCVngjv1ynAN9z84uo7?=
 =?us-ascii?Q?u4ObDUaWuY8IxcIe9FoF1sq9yal5teqWPtxYtSY5LpmmCCnWOzEnq3/bvxa/?=
 =?us-ascii?Q?i46uAPNAWBY65NiN+aXt6jnPrRPlge0ptlj93oeomU62dP/IaBje6PvZ8T2M?=
 =?us-ascii?Q?uqZFZRd6CkwP5VX9OsozF8sYT2BC/Gu5LUJ1AM/8hfm5wOWjAr0h+2B3gyGk?=
 =?us-ascii?Q?RQw0uq8aFtuuCBoajpqUgae6KSiRpQww1tvyQEXTQ5Wn6PrCsq97yUGIBvv4?=
 =?us-ascii?Q?ytxNhnBCEQz5/ujAiflhYvpmrMNQXSR3AQvdOhOt4GzkVBuHPssnXox044OG?=
 =?us-ascii?Q?4FVZUAKASNHB1nIuofgstdgo8n/8FyrL1+oBJgFqTJv1wDv23nYK+YqmO/Bk?=
 =?us-ascii?Q?2355rWuxTsla+PdKzM0M1dW2Hv9rv2YqTXMZtm33fbaIQSjWfRq3Nw6jdc1b?=
 =?us-ascii?Q?tZsJBkrs3rS9Jbcfw0VBVufVJ6vDW5Mv5guJ3vlvaU6DTs3QmT+OIFST4a3N?=
 =?us-ascii?Q?ct6e4m5/uZjBwD7m9DClGQc9pE7XSEsn4mOcnas23XjbG4UyddBymhBELnSC?=
 =?us-ascii?Q?1eAeEpeZZniuxBQQCZSSwYJTke0bUQRVHjCyds2L76xLBDwVfpA1Qw6p8zVK?=
 =?us-ascii?Q?+beeLCgvHSARatDlMquqM4AK/2A+B2+GG0jubz24wTJSIcukbrsfhpzTTIkx?=
 =?us-ascii?Q?Ng4rjCz9dW4RRJ/hnm3g3bQ/5d+IlOmsLhtbI/yLt/9byZeUtYN+oVieTv3R?=
 =?us-ascii?Q?Z+e1nqVoBzd73xfjwnYF/QwpfKmFmatie1TSsnlB0wxDxKcdGMwyOp+gVY/O?=
 =?us-ascii?Q?lj6o9NY2VZ8LeJ4SJiTg9CrH+EbRyuGcv8ry6kUYkJ3DCs8y33FUjLIQdENp?=
 =?us-ascii?Q?lrD6Wevepdxwaq3qDCfKXJIJpgBZYsCuummgiy2noPXgMFKEovV0v5+0Beb0?=
 =?us-ascii?Q?ETNJDx7hUQrn/LHAIu1xeg/c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7361a64d-33fe-43af-a933-08d9833e836a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 11:44:36.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaPN9rKY/gywWKk1YiSYxp2+QCYyAS1TJxglF24cB0n11F7Sevn/8Yjk1sc54UMusUmVK7t4tQjg2q4uqgFacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5263
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-09-24 12:20:26, Martin Kepplinger wrote:
> hi Abel,
> 
> thank you for the update (this is actually v2 of this RFC right?)!
> 
> all in all this runs fine on the imx8mq (Librem 5 and devkit) I use. For all
> the pl301 nodes I'm not yet sure what I can actually test / switch frequencies.
> 

You can start by looking into each of the following:

 $ ls -1d /sys/devices/platform/soc@0/*/devfreq/*/trans_stat

and look if the transitions happen when a specific driver that is a icc user suspends.

You can also look at:

 /sys/kernel/debug/interconnect/interconnect_summary 

and:

 /sys/kernel/debug/interconnect/interconnect_graph

> But I still have one problem: lcdif/mxfb already has the interconnect dram
> DT property and I use the following call to request bandwidth:
> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/d690e4c021293f938eb2253607f92f5a64f15688
> (mainlining this is on our todo list).
> 
> With your patchset, I get:
> 
> [    0.792960] genirq: Flags mismatch irq 30. 00000004 (mxsfb-drm) vs. 00000004 (mxsfb-drm)
> [    0.801143] mxsfb 30320000.lcd-controller: Failed to install IRQ handler
> [    0.808058] mxsfb: probe of 30320000.lcd-controller failed with error -16
> 
> so the main devfreq user (mxsfb) is not there :) why?
> 

OK, I admit, this patchset doesn't provide support for all the icc consumer drivers.
But that should come at a later stage. I only provided example like fec and usdhc, to show
how it all fits together.

> and when I remove the interconnect property from the lcdif DT node, mxsfb
> probes again, but of course it doesn't lower dram freq as needed.
> 
> Do I do the icc calls wrong in mxsfb despite it working without your
> patchset, or may there be something wrong on your side that breaks
> the mxsfb IRQ?
> 

Do you have the following changes into your tree?

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi               
index 00dd8e39a595..c43a84622af5 100644                                                                          
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi                                                                  
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi                                                                  
@@ -524,7 +524,7 @@ lcdif: lcd-controller@30320000 {                                                             
                                                  <&clk IMX8MQ_VIDEO_PLL1>,                                      
                                                  <&clk IMX8MQ_VIDEO_PLL1_OUT>;                                  
                                assigned-clock-rates = <0>, <0>, <0>, <594000000>;                               
-                               interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;                    
+                               interconnects = <&icc IMX8MQ_ICM_LCDIF &icc IMX8MQ_ICS_DRAM>;                    
                                interconnect-names = "dram";                                                     
                                status = "disabled";                                                             
                                                                                                                 
@@ -1117,7 +1117,7 @@ mipi_csi1: csi@30a70000 {                                                                  
                                         <&src IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET>,                            
                                         <&src IMX8MQ_RESET_MIPI_CSI1_ESC_RESET>;                                
                                fsl,mipi-phy-gpr = <&iomuxc_gpr 0x88>;                                           
-                               interconnects = <&noc IMX8MQ_ICM_CSI1 &noc IMX8MQ_ICS_DRAM>;                     
+                               interconnects = <&icc IMX8MQ_ICM_CSI1 &icc IMX8MQ_ICS_DRAM>;                     
                                interconnect-names = "dram";                                                     
                                status = "disabled";                                                             
                                                                                                                 
@@ -1169,7 +1169,7 @@ mipi_csi2: csi@30b60000 {                                                                  
                                         <&src IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET>,                            
                                         <&src IMX8MQ_RESET_MIPI_CSI2_ESC_RESET>;                                
                                fsl,mipi-phy-gpr = <&iomuxc_gpr 0xa4>;                                           
-                               interconnects = <&noc IMX8MQ_ICM_CSI2 &noc IMX8MQ_ICS_DRAM>;                     
+                               interconnects = <&icc IMX8MQ_ICM_CSI2 &icc IMX8MQ_ICS_DRAM>;                     
                                interconnect-names = "dram";                                                     
                                status = "disabled";                                                             

I forgot to update these in the current version of the patchset. Will do in the next version.

Also, would help a lot if you could give me a link to a tree you're testing with.
That way I can look exactly at what's going on.

> again thanks a lot for working on this! I'm always happy to test.
> 
>                           martin
> 
> 
> 
> ---
>  .../boot/dts/freescale/imx8mq-librem5.dtsi    | 20 -------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index 6fac6676f412..8496a90f23bf 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -381,26 +381,6 @@ &A53_3 {
>  	cpu-supply = <&buck2_reg>;
>  };
>  
> -&ddrc {
> -	operating-points-v2 = <&ddrc_opp_table>;
> -
> -	ddrc_opp_table: ddrc-opp-table {
> -		compatible = "operating-points-v2";
> -
> -		opp-25M {
> -			opp-hz = /bits/ 64 <25000000>;
> -		};
> -
> -		opp-100M {
> -			opp-hz = /bits/ 64 <100000000>;
> -		};
> -
> -		opp-800M {
> -			opp-hz = /bits/ 64 <800000000>;
> -		};
> -	};
> -};
> -
>  &dphy {
>  	status = "okay";
>  };
> -- 
> 2.30.2
> 
