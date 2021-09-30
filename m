Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC141DC2D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351840AbhI3OY0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 10:24:26 -0400
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:4738
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348645AbhI3OYZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Sep 2021 10:24:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHU9XHfmHezJk/O3Ke5BqmyGrMsQtgGfhWX9DWrEBZLldOGluwRUEUUxEkE/ml4nezdalz+UvDTsg9zIUnDGjquff5+CgrQLHFCZ6zwnXDbKGjzVje8K6vDBOfNABRphr5/j1y7UgVk8NavaB/j126yVDzLEfPvaCxOgbPyZogBew8pu+dgpv1NnsvVUb3XoX6LB4Ki/OqA/jEis6/CsOw2l3KT0sYMxhKtXkuS/Q6cjh9gVqKHxZKGykMbYD+XvBJK8w/i7wkGhQWpYLgtp5xIDCPVvLGH7fBCrhHPKqSJKbkC6+Vh+FTwlKxS0dgEMD+XqJbb6cfU9f6HzQ504oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WLfV6IDzRExPmwxmyJBEgcwZbbN/eD91Ds0aLXShQA4=;
 b=SF1F+r8xDhawxfXrNRiOfJ5vjqc1vLtb+mexZTElJ5xB68Q+A/gk9vFMJ3bBX2GxwK3nwb9B5mX0KCRu5FEPI9/uHyX21Gj5T4Ayt28GsWryZ9AmvGz0zVRpLTsDhG8Tnrmo8LDhET+GFSrFZS09rOvxo9e3+EtFnA1sHdnLc3A6gb0d5FVeCOzuQ4+U2aJwMxAKK4o5bp49/TPIU5TqKQOniN7ZpJK5SNiYxGsm9sQ+MR7IsR9w42w8IJEVqHJZCaAAGHsyWs3SU5eTkoVYH3ZovKZDlMuY94AZx5vd6GLspeB75a+yhaFyC2roE40wrh1ySVAMhwxK8aCt5ovz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLfV6IDzRExPmwxmyJBEgcwZbbN/eD91Ds0aLXShQA4=;
 b=QmUzNml4YseABvig3fqEzZBkIIEjxD1YFqQfTJdCM0TcBcYxCIkY/bxFVz7KmyV2eYuDN/64e2mpq1Cq1WjcDLNY3rAy2NEa2m77FvymNAI0IVD/xzQFtkZyIdGA+Y3wC0XZMg7kuQARXKXI+qaDdFIanBV/aiaCHO0fsYn5/Qc=
Authentication-Results: puri.sm; dkim=none (message not signed)
 header.d=none;puri.sm; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR04MB6784.eurprd04.prod.outlook.com (2603:10a6:803:13e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 14:22:40 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb%10]) with mapi id 15.20.4544.022; Thu, 30 Sep
 2021 14:22:40 +0000
Date:   Thu, 30 Sep 2021 17:22:36 +0300
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
Message-ID: <YVXILIGHwUSoybxq@ryzen>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
 <20210924102026.2679952-1-martin.kepplinger@puri.sm>
 <YVRRomS8ut6NjYlV@ryzen>
 <a01be64e31fbeb910b237ce8b8031fe20f245c7e.camel@puri.sm>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a01be64e31fbeb910b237ce8b8031fe20f245c7e.camel@puri.sm>
X-ClientProxiedBy: VI1PR0302CA0017.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::27) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
Received: from ryzen (86.121.85.242) by VI1PR0302CA0017.eurprd03.prod.outlook.com (2603:10a6:800:e9::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 14:22:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d920f20-c55d-4f55-da4a-08d9841dc23e
X-MS-TrafficTypeDiagnostic: VI1PR04MB6784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6784A1F33D7D2228E12E39B8F6AA9@VI1PR04MB6784.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+SqsDo72tRdH3BcB4OXHL5QECtRZOHwtgSnwpE3IE/TPq76iF73qj+WfjQvzWFmHoD1ddFp+MRERjDLRdE0qmxD3urIRQzEyYOL+FqmSpqwxvxNCs32qiTOhe1V8gSp21J4plKauR9lauw6LqMYR5rjF/RF+EolsMC1qoa3RuOpQjNGxUtekTcq9wfdPlBuUMnIuM8ukIVouSHOoUjBNvpP/eeQ636Oj/Dj2OClsmvB8q5Ht53NEQp9YH5J/nnE6N9jqdSlDSBLqBWC8rpCf3ISDnZNUe0Xg7XCpw7G8D9h74cMItmjAIZ25agYTxLMqLWXKR+I88HwxHiF8MYdR+zdcBCN26bAUa9cMLMxHJG3cSOY4qUWoFc/tcISMLhL/aOQxM1sa91M3m2bj5+0lx3ggDVg1jlZ4/B3X/kueV78ZBoOxK/xFVnia9DNaXlIU3MfqrjZNBngezcZCtXovEwZEBpZgHa/Iuqk0mt6nwLtpIIxYnSvZVVB29NPXtcoLUpFwPCnWT5moB7I8sSOgSCjNfOjQqUTUChhQMan73bw4Z6IUCcz/PaNtEcPY8zpCKifulM/K2rCYK7mTGH9yV3FIkBOk/KV493i2paHpPhIqWtVakVLuf2EE1J6/ryO2WRdheL0KwmRhLHJRPJOVj2YChd37lm4tam12XIiLALEO1dT8RZ/HgVijxcGClTOyx7aYyEzRo1DqmePb5IEhBmdHRn9Y71AeW2IAupJAF1/9N558nNitaxvxnmP9b9XYWwp6JHttInXCmAOGS/XEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(9576002)(4326008)(66476007)(66556008)(26005)(7416002)(38100700002)(38350700002)(2906002)(8676002)(83380400001)(52116002)(8936002)(6496006)(86362001)(66946007)(5660300002)(55016002)(508600001)(33716001)(316002)(45080400002)(44832011)(53546011)(9686003)(966005)(956004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?foqRo3O+Vs6vmA2CVN68o12PjIQ7Ytun+aQXbDA8VvXF1QA3stnYsMJ1BK?=
 =?iso-8859-1?Q?Fm9xaIM+uevPtbwTraYS7Nb3/jKEpZnTvEER5gNNK7IDN+kQBfSi6p8HUV?=
 =?iso-8859-1?Q?yD7fEKw4bANGUk82A3yRc13YmvGccP+rpAS5nc6xbaYs+9qjtVdhHih1WH?=
 =?iso-8859-1?Q?+okMKyUhLIXZ92MWWAJSeEKkYSK3LKc+LSV0CBMgRHrAOKzIyxMNyuqs7E?=
 =?iso-8859-1?Q?RYcvEw50+BmjMHnjszo8CgZFegvjiaLM8i0lkOvEuxjb5ss9U+LKM0WN+y?=
 =?iso-8859-1?Q?HuNib3jwSB6K+/lHGmE9vj71RR5q/VevyT1ucSR5E9XI+lrWdtAOuTatH1?=
 =?iso-8859-1?Q?wiy0q8HFrjX/m/eKHap5CK/+DCSGfkcv3kZIXI7w67HwWvQFjuzme+UKzS?=
 =?iso-8859-1?Q?UxwkRT/TmHnUAfAYPPgnkqMc9tdNCkZqANMbbtGVBTNkQODXC8Lm2dnfs/?=
 =?iso-8859-1?Q?IPjvNecfNmsdzl5lNmYiwDtyM4HjSOVhm/rRU1jedseeZl8oquZg7jW3JZ?=
 =?iso-8859-1?Q?JTgVsBFhRCFKniVeOsc01iA+XdrDlGNIyrEy2NjeA4EFrLPd0ovRFvuWuz?=
 =?iso-8859-1?Q?06WmyscaFh6/pXznaTBaEEbPN254IkvpSJ44lS0INEWN1zZxdxnQrLuRid?=
 =?iso-8859-1?Q?3zNTqsu+Y504+uuljJJOK5saFH19V9kO0Fdpu7ttRyFjHn5hOvHjfuSoB0?=
 =?iso-8859-1?Q?iZYQWvCBj1mDLAmXo0pOc2BeVsKwGBhNxMCkjbYKjp9sUyov6d2Vf3D3Mq?=
 =?iso-8859-1?Q?5q6+C2kgwhiWI45OpQAuW8FKOoqWeqfU4KOXp6qEC2iOhGKEC9WfywUFv7?=
 =?iso-8859-1?Q?EaP73akuRyJNAlxrEw8IJgs6Ic8IcT4HBB9fSrkc92hl1/9jMkx+oJrxes?=
 =?iso-8859-1?Q?1XBlCk6fgLPs7ZMOywHUi+Gb4Ko94ZxFrza8hEZcUp7EXqn1RccvwVxUpG?=
 =?iso-8859-1?Q?RqhAH6JmdX/GJYozBMN1ld6dhZVgZ+WeRkkljbPaqW1y8Y0mtTBQZw1Aka?=
 =?iso-8859-1?Q?XL37kvJPIRBGBUs1DLmyZ7PlxZgCl1Z08ObVrHsQaYZHuDolBHEDg8wgDj?=
 =?iso-8859-1?Q?62jYjHIiQ9l6S/E4mvAJI89k3K8qgsju0+Am26ZTU0vV2Ra4PyJziWmOJh?=
 =?iso-8859-1?Q?GBK6Y8EYoxMib3daNtDATE4el2iUboqa/qNRsxB/fD/9ScZ5esYYMzqFHo?=
 =?iso-8859-1?Q?mJcdUp9qP/O7WqSehrG1aIcXC9SDym0iwn3AjvA6HJRnmeVUtun2s2DPqg?=
 =?iso-8859-1?Q?x5YkD92eMkrnw3gtXiiP1Iorugmti6BLdVNVy0yctekXre/xgXOqtstUAH?=
 =?iso-8859-1?Q?5z9uJw+35VR9U5xA6RCyMc8/EIqbXNW13TzmZz5FuA+uCs9dDukvv1svZj?=
 =?iso-8859-1?Q?+Qon45VvIx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d920f20-c55d-4f55-da4a-08d9841dc23e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 14:22:39.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptkX2E/PuUTxXouM6ArX+wDuB1y1FcKmWrNsFQ4FHi2mhAV3WaQjNwIKPYL93nEU1r1Y+q/T19jg40ojQgpfGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6784
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-09-30 10:03:46, Martin Kepplinger wrote:
> Am Mittwoch, dem 29.09.2021 um 14:44 +0300 schrieb Abel Vesa:
> > On 21-09-24 12:20:26, Martin Kepplinger wrote:
> > > hi Abel,
> > > 
> > > thank you for the update (this is actually v2 of this RFC right?)!
> > > 
> > > all in all this runs fine on the imx8mq (Librem 5 and devkit) I
> > > use. For all
> > > the pl301 nodes I'm not yet sure what I can actually test / switch
> > > frequencies.
> > > 
> > 
> > You can start by looking into each of the following:
> > 
> >  $ ls -1d /sys/devices/platform/soc@0/*/devfreq/*/trans_stat
> > 
> > and look if the transitions happen when a specific driver that is a
> > icc user suspends.
> > 
> > You can also look at:
> > 
> >  /sys/kernel/debug/interconnect/interconnect_summary 
> > 
> > and:
> > 
> >  /sys/kernel/debug/interconnect/interconnect_graph
> > 
> > > But I still have one problem: lcdif/mxfb already has the
> > > interconnect dram
> > > DT property and I use the following call to request bandwidth:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.puri.sm%2Fmartin.kepplinger%2Flinux-next%2F-%2Fcommit%2Fd690e4c021293f938eb2253607f92f5a64f15688&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C7fab8aca3a5f43d56f5608d983e8da67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637685858400552603%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=%2FzyEQdOLU8jQuUpqJ74GTWyfrDvavz%2BxZAgv1tcIu9Y%3D&amp;reserved=0
> > > (mainlining this is on our todo list).
> > > 
> > > With your patchset, I get:
> > > 
> > > [    0.792960] genirq: Flags mismatch irq 30. 00000004 (mxsfb-drm)
> > > vs. 00000004 (mxsfb-drm)
> > > [    0.801143] mxsfb 30320000.lcd-controller: Failed to install IRQ
> > > handler
> > > [    0.808058] mxsfb: probe of 30320000.lcd-controller failed with
> > > error -16
> > > 
> > > so the main devfreq user (mxsfb) is not there :) why?
> > > 
> > 
> > OK, I admit, this patchset doesn't provide support for all the icc
> > consumer drivers.
> > But that should come at a later stage. I only provided example like
> > fec and usdhc, to show
> > how it all fits together.
> > 
> > > and when I remove the interconnect property from the lcdif DT node,
> > > mxsfb
> > > probes again, but of course it doesn't lower dram freq as needed.
> > > 
> > > Do I do the icc calls wrong in mxsfb despite it working without
> > > your
> > > patchset, or may there be something wrong on your side that breaks
> > > the mxsfb IRQ?
> > > 
> > 
> > Do you have the following changes into your tree?
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi               
> > index 00dd8e39a595..c43a84622af5
> > 100644                                                               
> >            
> > ---
> > a/arch/arm64/boot/dts/freescale/imx8mq.dtsi                          
> >                                         
> > +++
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi                          
> >                                         
> > @@ -524,7 +524,7 @@ lcdif: lcd-controller@30320000
> > {                                                             
> >                                                   <&clk
> > IMX8MQ_VIDEO_PLL1>,                                      
> >                                                   <&clk
> > IMX8MQ_VIDEO_PLL1_OUT>;                                  
> >                                 assigned-clock-rates = <0>, <0>, <0>,
> > <594000000>;                               
> > -                               interconnects = <&noc
> > IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;                    
> > +                               interconnects = <&icc
> > IMX8MQ_ICM_LCDIF &icc IMX8MQ_ICS_DRAM>;                    
> >                                 interconnect-names =
> > "dram";                                                     
> >                                 status =
> > "disabled";                                                          
> >    
> >                                                                      
> >                                             
> > @@ -1117,7 +1117,7 @@ mipi_csi1: csi@30a70000
> > {                                                                  
> >                                          <&src
> > IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET>,                            
> >                                          <&src
> > IMX8MQ_RESET_MIPI_CSI1_ESC_RESET>;                                
> >                                 fsl,mipi-phy-gpr = <&iomuxc_gpr
> > 0x88>;                                           
> > -                               interconnects = <&noc IMX8MQ_ICM_CSI1
> > &noc IMX8MQ_ICS_DRAM>;                     
> > +                               interconnects = <&icc IMX8MQ_ICM_CSI1
> > &icc IMX8MQ_ICS_DRAM>;                     
> >                                 interconnect-names =
> > "dram";                                                     
> >                                 status =
> > "disabled";                                                          
> >    
> >                                                                      
> >                                             
> > @@ -1169,7 +1169,7 @@ mipi_csi2: csi@30b60000
> > {                                                                  
> >                                          <&src
> > IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET>,                            
> >                                          <&src
> > IMX8MQ_RESET_MIPI_CSI2_ESC_RESET>;                                
> >                                 fsl,mipi-phy-gpr = <&iomuxc_gpr
> > 0xa4>;                                           
> > -                               interconnects = <&noc IMX8MQ_ICM_CSI2
> > &noc IMX8MQ_ICS_DRAM>;                     
> > +                               interconnects = <&icc IMX8MQ_ICM_CSI2
> > &icc IMX8MQ_ICS_DRAM>;                     
> >                                 interconnect-names =
> > "dram";                                                     
> >                                 status =
> > "disabled";                                                          
> >    
> > 
> > I forgot to update these in the current version of the patchset. Will
> > do in the next version.
> > 
> > Also, would help a lot if you could give me a link to a tree you're
> > testing with.
> > That way I can look exactly at what's going on.
> > 
> > 
> 
> 
> thanks Abel, with the above fix of existing interconnects properties my
> system runs as expected and here's the output of
> 
> for each in `ls -1d /sys/devices/platform/soc@0/*/devfreq/*`; do echo
> $each; cat $each/trans_stat; done
> 
> for mxsfb requesting (max) bandwith (display on):
> 
> /sys/devices/platform/soc@0/32700000.noc/devfreq/32700000.noc
>      From  :   To
>            : 133333333 400000000 800000000   time(ms)
>   133333333:         0         1         0       624
>   400000000:         0         0         1        28
> * 800000000:         1         0         0     30624
> Total transition : 3
> /sys/devices/platform/soc@0/3d400000.memory-
> controller/devfreq/3d400000.memory-controller
>      From  :   To
>            :  25000000 100000000 800000000   time(ms)
>    25000000:         0         0         1       620
>   100000000:         0         0         0         0
> * 800000000:         1         0         0     30652
> Total transition : 2
> /sys/devices/platform/soc@0/soc@0:pl301@0/devfreq/soc@0:pl301@0
>      From  :   To
>            :  25000000 133333333 333333333   time(ms)
>    25000000:         0         0         1       616
>   133333333:         0         0         0         0
> * 333333333:         1         0         0     30668
> Total transition : 2
> /sys/devices/platform/soc@0/soc@0:pl301@1/devfreq/soc@0:pl301@1
>      From  :   To
>            :  25000000 266666666   time(ms)
> *  25000000:         0         0     31284
>   266666666:         0         0         0
> Total transition : 0
> /sys/devices/platform/soc@0/soc@0:pl301@2/devfreq/soc@0:pl301@2
>      From  :   To
>            :  25000000 800000000   time(ms)
> *  25000000:         0         0     31288
>   800000000:         1         0         0
> Total transition : 1
> /sys/devices/platform/soc@0/soc@0:pl301@3/devfreq/soc@0:pl301@3
>      From  :   To
>            :  25000000 800000000   time(ms)
> *  25000000:         0         0     31292
>   800000000:         1         0         0
> Total transition : 1
> /sys/devices/platform/soc@0/soc@0:pl301@4/devfreq/soc@0:pl301@4
>      From  :   To
>            :  25000000 333333333   time(ms)
>    25000000:         0         1       648
> * 333333333:         0         0     30652
> Total transition : 1
> /sys/devices/platform/soc@0/soc@0:pl301@5/devfreq/soc@0:pl301@5
>      From  :   To
>            :  25000000 500000000   time(ms)
> *  25000000:         0         0     31304
>   500000000:         1         0         0
> Total transition : 1
> /sys/devices/platform/soc@0/soc@0:pl301@6/devfreq/soc@0:pl301@6
>      From  :   To
>            :  25000000 500000000   time(ms)
> *  25000000:         0         0     31308
>   500000000:         0         0         0
> Total transition : 0
> /sys/devices/platform/soc@0/soc@0:pl301@7/devfreq/soc@0:pl301@7
>      From  :   To
>            :  25000000 128000000 500000000   time(ms)
> *  25000000:         0         0         0     31312
>   128000000:         0         0         0         0
>   500000000:         1         0         0         0
> Total transition : 1
> /sys/devices/platform/soc@0/soc@0:pl301@8/devfreq/soc@0:pl301@8
>      From  :   To
>            :  25000000 133333333   time(ms)
> *  25000000:         0         0     31316
>   133333333:         0         0         0
> Total transition : 0
> /sys/devices/platform/soc@0/soc@0:pl301@9/devfreq/soc@0:pl301@9
>      From  :   To
>            :  25000000 133333333 266666666   time(ms)
>    25000000:         0         0         5      1052
>   133333333:         0         0         0         0
> * 266666666:         5         0         0     30268
> Total transition : 10
> 
> 
> but with display off (mxsfb not requesting anything), I get the same
> fast freqs for noc and memory-controller. They should use the lowest
> freqs. Only pl301@4 switches to 25mhz in that case. That's odd.
> 

Well, have a look at: 

/sys/devices/platform/soc@0/soc@0:pl301@9/devfreq/soc@0:pl301@9

even in the output you gave here, you can see that there are 5
transisions between 25MHz and 266MHz. BTW, that is the USDHC pl301.

I'm assuming you're booting with rootfs from usdhc not through nfs,
right? Anyway, the noc and dram clocks rate only drop when there is
no user enabling its own icc path to the dram.

Keep in mind that the benefit of this approach is not only to drop the
dram clock rate, but also to drop the rates of all the bus clocks on
whenever possible. 

Yes, the perfect scenario would be, from power consumption point of view at least,
have dram clock rate as low as possible and as long as possible, which
implicitly means there is no one requesting the higher rate.

If you want to observe the transitions number change for the dram
devfreq node as well, you can run a simple sync from userspace and that will 
trigger a "high rate" request for the usdhc. Note, this will only happen
if there are no other users asking for the higher rate.

> said (still) out-of-tree mxsfb request is
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.puri.sm%2Fmartin.kepplinger%2Flinux-next%2F-%2Fcommit%2Fee7b1453295932da1e292b734afa7a03651ad9ba&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C7fab8aca3a5f43d56f5608d983e8da67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637685858400552603%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=tY9IN8nAgYrPRD0BRLW%2FZbWEps9DTVIQi8G5jY5aw3Q%3D&amp;reserved=0
> 
> and the exact tree I'm running for the above is
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.puri.sm%2Fmartin.kepplinger%2Flinux-next%2F-%2Fcommits%2F5.15-rc3%2Flibrem5__integration_byzantium_test_new_devfreq_interconnect&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C7fab8aca3a5f43d56f5608d983e8da67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637685858400552603%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Kpo7sVLdgzwMv8MPX7X%2FNUxoLcvWjFVIuerlh7Cr2D4%3D&amp;reserved=0
> 
> thanks,
> 
>                               martin
> 
