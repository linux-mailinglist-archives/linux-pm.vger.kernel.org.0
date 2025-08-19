Return-Path: <linux-pm+bounces-32649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9EB2C82C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B55C188A919
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1612797B5;
	Tue, 19 Aug 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kPYlxDI1"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748527E074;
	Tue, 19 Aug 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616249; cv=fail; b=Pz1WFLZHCWUKe66GeTgUqlAfi+li3sUqJo3PsIwrx2u8X3GRwRDSeGb8Z2U8N9yV/1+yG2PWSnGWbM/SZYfizuhQego25utT6QPD1K5sQ/VxrqO7TXcIHjqCVfnrUyPphtlKJ0S5VyB0+k2114rfYVQR43TIJeDHU3mENmZYT3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616249; c=relaxed/simple;
	bh=vDHbzgTeY7ir11uxiACvRgdesrOhksBXjHqrAhapGGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NGc80ZHjlwKp7ujdjM/mbspu6dhT0H9otQ+HB55IYNpWNNAkLGCqNvr+U9sNW6xh92RbffpX5+9P2+2J/M+Nx9QBTbtn7mcw1P7QdmpYQK7Q9jrkk+5/xG2NQdvrrRArP2uiJCYHY0y/kdH6IopBWcNkSFMckR2LVmich1VT/x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kPYlxDI1; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKgMAe9Y25sojeNDUqHmtJ7rIQX4G8dusI31ZnR2dEcVvXsTg/KkoAR0Tgvr6dBSxwEEymjAuqzd/0XCUDIdmcp2hW1VJG9BEXPii0X93L/0oMY2sxgqLiUW+EzGuNtwyg2gkSRhy+buKSfVGJxw7OnPtrMzTHc147uHpOLmADswzq5sfw2KD1QUsTkQD9Izv/0fk7WTA65HcQya2HCp8wi9OrP4rti3/qeLBZ8obRbbKX+q4RgwbvSyGCrGnC0s94bFgCGAA9TXMBp7HSp/83HUE4H7TzEHKSjJnnxyD03TCYPDyp3L/eLcqTYoc3ZU2la+A0KTAL9PBajxepPv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DWzGELDm7HvUm9Ig0Kdx7q95mGb0NTyT4FofnD0iLI=;
 b=XXhUF1PEW1D9z4Se0GrCHnAG/NKJ+Fr8hSOAHQRxbXlDqg4+O7pOa2PD0W4JWI1yNgP1Uvt+1jZpm0nps8xeNV1tINILdNkNdk4rDQnFRuGBIqdv1fUfeaOuoqM0fGB427de1zzCM309MJzv1HZDTRDdAVLTsn8gaaAxgY/4x9LZMAQc5f9clOJ7Sg87jqXKkKU7lulex7mGAh/0vabcRfcpdsqwIwNrfNPWuBF8wdI5NzaAOVskc4agG27whptJBNbS7D2tgxm9AnNMya0Qkv7zbmi9lFvScwo7zrMywZEetAHZFQARNMlwVdsSNtKhoY2fo62yRlKhFRJ+JFrnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DWzGELDm7HvUm9Ig0Kdx7q95mGb0NTyT4FofnD0iLI=;
 b=kPYlxDI1xNEhQlHcyGCebZeQZ5WX82e4ZxmP8HPVIDS2LxPqtFo3NoksEsFxTt42iXQU8ERhYJ+5NUAcPpfEjbB+Mfe2KY6OKOkrlfaUJ5I1kHwu+KCsWayONT1UBFCIUID0kSF6bQ0mk9pjxFPfNO6XXcshm6NBN9EQVuk5MgngXmpQEnS8tkYlJ4xLuHucAWz/Ioa7ZZppHBDUd8loT66F+/3c8ZXkcqpQZbuULXWngMNpoVMNFJph/D5ygZo/OvDIvDYo9FH7X5UnJ17XNa3kr2ZQrjaIgjOW94T/DHt+qGhzVZcAU0ARyVrEt51VMD4TTnrCaspux1O/F0k9MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7154.eurprd04.prod.outlook.com (2603:10a6:208:19f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 15:10:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 15:10:40 +0000
Date: Wed, 20 Aug 2025 00:21:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, jun.li@nxp.com,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, imx@lists.linux.dev,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] usb: chipidea: ci_hdrc_imx: Set out of band
 wakeup for i.MX95
Message-ID: <20250819162133.GA18601@nxa18884-linux.ap.freescale.net>
References: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
 <20250801-pm-v2-2-97c8fb2a433c@nxp.com>
 <zdzpddjjdj2ezkkfh5jjnnjvkvu4gb6vqmhkdlnnc2ioamvcuk@ftmezbyxrhfb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zdzpddjjdj2ezkkfh5jjnnjvkvu4gb6vqmhkdlnnc2ioamvcuk@ftmezbyxrhfb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: c542f1a8-d7ab-408b-0901-08dddf328f56
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rNZGVwpy5Mrx5VofjAQOHRzs31kJmoCwyq6RRHt8120NgbqxWNJpVb0awysf?=
 =?us-ascii?Q?BTgFLxD048Dx0aqnM6kUO2kPY53EcMJAYyHhW1/4/4JTd0GPr+eBS3IxW/qX?=
 =?us-ascii?Q?raQsAgq+eKBJWdZCc2rYvwLIHoxmy9HzOVV0c30nD4FSGukbt0z7cALB6Q/G?=
 =?us-ascii?Q?S/mGU4FeSbBaKWtjbnw63cKKKFiMQdeSjdSpIzEI/TdpI11uzqp498zGL3DM?=
 =?us-ascii?Q?SaZSs1+w/2SLm2Chb1ZQFPnqMaL8C62b99//GDkdM0IX62XT21kUUaqNqE21?=
 =?us-ascii?Q?2ZAtc62Si2ZuLt9iwZHoF188ym0jLuerosrT589GNx9wjzmgPHze3+S5p10/?=
 =?us-ascii?Q?wBdEyGRZEe+Xl7+97JWomxfr6GGo+k+xVZzZa1yOzHitKJAVy/+npb4KM6YV?=
 =?us-ascii?Q?xKQ0VNxEgf8miYh28QH++GSjBE6dkneM0KDu1NMN1l8uOUZ1y784cFV8sQJy?=
 =?us-ascii?Q?Q1q+SS2gr+IaUcvNTOErb3vSBn49WImSZ3qzoVqAZfWod67Ue9CSK8fdZpbW?=
 =?us-ascii?Q?ksy7nPIDE4MpYN5PpfyQE8s6JMw3UlT08mRZA+AjFhv5slyp+g94dQkKicjE?=
 =?us-ascii?Q?PMNf/y/LiJmIz/e6P6/MqAFHDhFLC6BJhBAeVRyQWZZV6imNK/9AojnaJA2j?=
 =?us-ascii?Q?HiSpSX7PQbiHsmE6fcmb2hEw784NJ97NUV5yLK3htW5k0RmzWnoUIr5i5bEh?=
 =?us-ascii?Q?id55sVvGmz1e1L7NmZ1IvNXkwk3RhpYCgsyi1pBrDPvrO/cQKwl/xy9jpXtP?=
 =?us-ascii?Q?xlvofCkeXuNnZ1zezUEWQriIvICBPhmIHb2EGgCP9gCSFS+1EtoFyu87+280?=
 =?us-ascii?Q?eWElPv9aOS1XBPVN5w69rmrDINWrp2aZSEKNFW3mIz3g40rgHv0PyQKRWYdT?=
 =?us-ascii?Q?brNcFhVctul9db/t2KDeMhfLZi4HyRqVWLvTzfGNf9Ckhl2DuUo3RwsMWhGn?=
 =?us-ascii?Q?TYMyOJNMnZKZkIt7T7n/Pz2UqU3GHLeX1lCmAMVeVvAFU6fkPiTOMZB5j2Mc?=
 =?us-ascii?Q?OlLCL49+dHzR3mvzmYRqmBnHdnTyxlc3/oKyytd0VsEilM2b/s4ygD3kOx6S?=
 =?us-ascii?Q?SNoMNHBJ0XOi8RAEboJPVrBXcER/P56P9Cw1iVbH7hEXxn9mMvTaQudFHehh?=
 =?us-ascii?Q?e9/5I2AzNnQ0It/B4aaGsAF0ueQmmWnwP2kZvxcr6yNsxcp6IOn5+D8fbyZX?=
 =?us-ascii?Q?b2Af64MhNs+R9IORO5NpGtrDLxwtYoM22x8C/KVeFGrud8jtueijH76nq0im?=
 =?us-ascii?Q?bDwSmiN/K/SLOUJz8N03+BIxyyVMvS8N4dVrIxdvBZLNTUz3dr+X4aVRLZHo?=
 =?us-ascii?Q?PUCx3Y8liXOWlNKaHJWkZy2PTKfHaCulU//DInvX7AhtaCBwQ98UycCNiHMz?=
 =?us-ascii?Q?MHeBEVPOUFPM7M5Lh3VFYwMFZ61NgPZTzsrnMmtHaXumU5HqE4Jtfd5ne+rz?=
 =?us-ascii?Q?ZxAs3IRlIVQ55gkbpPa17HGGn27aZfWmB7sl0tZVur1cdd3Hdg3bgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l9NGuaC0/rueOmdk/dQasoJGq4tsGP3drofFAdGo6A7wgJboRcEjdfMwoDZU?=
 =?us-ascii?Q?0ZLjwKxvFQTtJGXEp/1gzs4H06zFIiutXYZyTkWYbefyRNUkTyWYsEJa7hlV?=
 =?us-ascii?Q?gLo1x5nZ+H8ayfNMR4ClqEz1XvildtJaTrosmRdX3HU4THBMFVFPMYtFGSCs?=
 =?us-ascii?Q?/HTFsAhlhlRlMoh0viHoWbf8cstw7pyujXAGF0oxHqsILIHgjo1vAjyGV71e?=
 =?us-ascii?Q?B4VJ78nRrVNsDbxL1H7nNbKZ81TJd+YT5ZE2ppBt6YLrNjGG42nUdd0nnOoD?=
 =?us-ascii?Q?tRf4hvVaucdz+FAEkXVefimftzU92ly04c1Ezdr1crehXUbB2+xMhImzNTwI?=
 =?us-ascii?Q?6btZwTC/6RSY1pnmRlbkbyzLzcIeT0Bl6gyXbr69RM9oaAm8d2FTyAMVCoEb?=
 =?us-ascii?Q?KbwppApaMT7g6gmHduEuCWOFLiNBx277EV2TKaWOWEan1gyQe063CEMTHX0R?=
 =?us-ascii?Q?E3i/DnaeALXwrgskTsIfM3griShz0gnEs1S0Qx555XqF0jbzroxLtcbP6yg2?=
 =?us-ascii?Q?/9Xn/r4hEUykmnPQwNjvz/xgrCwcgn5+yKaSmF8uglzXkPMJEIPlk2kS4MYf?=
 =?us-ascii?Q?m/ihEGTwjQMK7EqsJjdxeYWgCj8z2oWYhxw9RjzZniJpPJ/yQYZw6LUGMngR?=
 =?us-ascii?Q?VHPLr2mb1/g5CGsjbFSn59eX9HyO3OO6ZzizHjIoG1bS0BrZghSQxzDolYXY?=
 =?us-ascii?Q?eTc8M7SBgJBsj2Q5JwftsuKEq7EHAnhXFF6xu1WTmGsIciDzNIZJXThYJtNH?=
 =?us-ascii?Q?kAF12upwWdLS8GDDHpAxDIECBJOEJXg/ek2pNktW6YHfv5DZBIaZbVXzCt7y?=
 =?us-ascii?Q?vXFs9/+vCfS5L9X5zU0A4lvHry4fwXShBth8kiog8DoALO6eXXAp3kYbOLiT?=
 =?us-ascii?Q?YuZMz+qZAfD74kkf2gOlWiJ6w9ikBz/fyOka6kqTjiJHXnYyu9cJ+guKusPe?=
 =?us-ascii?Q?lpBpOQqlHsQFS2J1/qR9aIsWMDjPmgVfmLlpvZH9pKz67PgBXmWcmxcFM3a3?=
 =?us-ascii?Q?IPJLKW9SucZUXLWo5IW8jB+IOvXTm6jwiw0CYEw7O0yhidzt0h5vOwksX9vq?=
 =?us-ascii?Q?9nCocO1noSc3j5pMWfqBZMQVNsagqFHhxNNLeXt1ko4CTjjLGQAcRo6owrA8?=
 =?us-ascii?Q?pc2V1zMbpufm1S+ML2ToRbPRabXw8BNxAT6oKqKpzmTUbhWTSYgkexEghUzt?=
 =?us-ascii?Q?jd/ubejRiWMnMUa7KHK+eLn2dHglt16qhse8e94IbkNMxZp+QOqG0nmzhvCm?=
 =?us-ascii?Q?CyFymyNPJCxqzKwC8RSxKz0maqrexXyUFDqhWc0WuheC0ZA6jwIk8dg59O/x?=
 =?us-ascii?Q?GVy4wiVFU0O3ylxZzWQwU7vpsXdEr7UxyUAbjKt8rRBJ6Cr7JKpucQa2BcGD?=
 =?us-ascii?Q?iJt3jQPkcSpCMOVcjzChq6n6ZJ8E+e/rhTkvFhhHsccc++UTlQvm46B4DmF2?=
 =?us-ascii?Q?OaqDcJBnW+QYn4VzRwaKjKxiSD2exqZyGxdLA6cHdTB1Abyp7LIQPcoxLnld?=
 =?us-ascii?Q?GIxXjL7LT+Gm6BN5/KXq6dLlr1efFt8MUFaW4G/j1iSbAy8iYWYjfQPlg+Oh?=
 =?us-ascii?Q?50fpOPRoh1FlE3kjQHTmP8Br6wJmteimHuDAxV+M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c542f1a8-d7ab-408b-0901-08dddf328f56
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:10:40.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBmMAzu5hthG3ETeUzuTLcDVanhUgoGLb2MfKYx1cwIVUflhxW2lNIMrfgr63Vw2Ay6kYCvYqKBfvkYIUWND3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7154

On Wed, Aug 06, 2025 at 05:28:08PM +0800, Xu Yang wrote:
>Hi Peng,
>
>On Fri, Aug 01, 2025 at 12:34:23PM +0800, Peng Fan wrote:
>> i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
>> power domain(Digital logic) is off. There is still always on logic
>> have the wakeup capability which is out band wakeup capbility.
>> 
>> So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
>> wakeup system even if HSIOMIX power domain is in off state.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/usb/chipidea/ci_hdrc_imx.c | 8 ++++++++
>>  include/linux/usb/chipidea.h       | 1 +
>>  2 files changed, 9 insertions(+)
>> 
>> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
>> index e1ec9b38f5b9ba0568101b51fbf16b99461b6ee2..7a3360d8a0fd065394393de829108a12c27c85b9 100644
>> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
>> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
>> @@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
>>  		CI_HDRC_HAS_PORTSC_PEC_MISSED,
>>  };
>>  
>> +static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
>> +	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
>> +};
>> +
>>  static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
>>  	.flags = CI_HDRC_DISABLE_HOST_STREAMING,
>>  };
>> @@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
>>  	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
>>  	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
>>  	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
>> +	{ .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
>>  	{ .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
>>  	{ /* sentinel */ }
>>  };
>> @@ -569,6 +574,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>>  
>>  	device_set_wakeup_capable(dev, true);
>>  
>> +	if (pdata.flags & CI_HDRC_OUT_BAND_WAKEUP)
>> +		device_set_out_band_wakeup(dev, true);
>> +
>
>In current design, ci_hdrc_imx_probe() will create another platform
>device B which will be a child of current device A. Furthermore, device
>A and device B will attached to a same power domain. In this case, some
>conflict setting may happen. For example, if the user wants to enable
>wakeup for this USB port, they may echo "enabled" to wakeup file for
>both device A and device B as before. As a result, device A is out
>band wakeup so it doesn't depend on power domain on, but device B has
>also enabled wakeup so the power domain will keep on finally. Actually,
>the power domain needs to be off for imx95.
>
>So I think only letting the parent device A itself attach to power domain
>should be enough. If it's the right way, then below change needs to be
>included to avoid potential misbehavior.

Thanks for looking into this.
Just detaching the power domain may break others. I think the better one
should be:

if (device_get_out_band_wakeup(dev))
	device_set_out_band_wakeup(&pdev->dev);

Regards,
Peng
>
>diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
>index 694b4a8e4e1d..c2ca81fe5e09 100644
>--- a/drivers/usb/chipidea/core.c
>+++ b/drivers/usb/chipidea/core.c
>@@ -915,6 +915,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
>        if (ret)
>                goto err;
>
>+       dev_pm_domain_detach(&pdev->dev, false);

I think the 

>+
>        return pdev;
>
>Thanks,
>Xu Yang
>
>>  	return 0;
>>  
>>  disable_device:
>> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
>> index e17ebeee24e3ecc4b1c2d153d9ea9b656b5a3d35..c6451191d2de68607a9380482701d11f949d0ff7 100644
>> --- a/include/linux/usb/chipidea.h
>> +++ b/include/linux/usb/chipidea.h
>> @@ -66,6 +66,7 @@ struct ci_hdrc_platform_data {
>>  #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
>>  #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
>>  #define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
>> +#define	CI_HDRC_OUT_BAND_WAKEUP		BIT(20)
>>  	enum usb_dr_mode	dr_mode;
>>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
>>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
>> 
>> -- 
>> 2.37.1
>> 

