Return-Path: <linux-pm+bounces-38859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7166C90A9F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63F3334A274
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614B28468B;
	Fri, 28 Nov 2025 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kKJ+kHQi"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402A283142;
	Fri, 28 Nov 2025 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298463; cv=fail; b=aP85M5w2TjPsxKzAm6Kqp9XJzpKI4EexgPkcrJDTfdwf481W3B4h5dFn7/Tg1idaRVjr5wnhbQdnaa2S3I9c1+v2qSHQvkCpFzi5D/6a6iPTYG/uPCBRTExI8C8Zrw2Jtu1UIe6jS2+FsELXh7FNZdIS5FGzw4CwcjMK4ENUgGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298463; c=relaxed/simple;
	bh=bG0YkCpYVu6h2wg7LE2Ft5GPTp1Ixe1tDaa73/0NyMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0EIdR6VUeRFPyo37dBX7cf0N931TpAruuJRJ4EW39lAv9E/L++Wot9lNNboXLLDTTyKv5F7ZfU2k0qAUbyEyrr8VtBC12OUx+D3mXTzAZjfZEkPa0cSg42tTaFc/KEal2/V5wwQLEldVIyE2aNSA9LUyhFFazV/EyY8Y3h88vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kKJ+kHQi; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E23xl2dl6NxiFUaX4vgJZ5OVpj5pti4x8GIPqRcRYR67lRs2s5rUG6aRhcq9jvtM15bb0S0fgU5ALHMTPsX7BZSe6JKSucVzmFEfCifipvGdJTcdeKoYfQmWYHk/sLQET3EddCupD/LojxLPn+hp15BL6woB2e21aAZ402mWRc2lm8/RappE/VFihmZIZCgmxqOaoDPb1eVnJAy+Ryba6Kd3E9UVGYiFmktuNnPgnuh1XArQ80ox5gYmdau4O211BlwdW7Uly5/FAVKVsr7htZ8YOvWonE2py8bUl5/j1rir9uCRYzcOIYVz5truhnElnRyvwnt3meSwB3DNhidpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2EzWiLlZD2j1N6WmEnp1s+55kEPLDrLAWIfMeHzjeU=;
 b=M1Ne2rYPiP4jgEatLm2lyxg36KBV+l2MtPA1cri+HO5g2hVrrFqysPCxKGGVu+cUhhwEtbQPGySwR53WBjaHC5+L/+ej/VMcqS+hH2SfxFij6ymXZZfOrdefeNBBYFhYTsra0xZBjZ4P1xfrHHTo1WzccwD00EB3Dv5JbS/x6FYUbu4Ymlf7vzMVe1tBO02nFdZ3yFhsaoFYBz/t9SVie69LW4kABhUVSpt6pfMwoDwlJ0sfKUek2SAt+lpau1KoB3QQpMAsdQ3ENIWf0uni2gwSviyPDb0jlYRBLVa3v08/35Ks/yHjpQmv54nFpYxP5bXwphukbMtk0D2k5RlGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2EzWiLlZD2j1N6WmEnp1s+55kEPLDrLAWIfMeHzjeU=;
 b=kKJ+kHQidS9tds+J9HV47BCIqVkohcleqpWF2qugU0Z96iv8hrUa7eMpMzFdBg1JLcQ7IlmDhX0czumkN6QuA47gTULxxGOmWZ/42I6eF4zS11fyeTnnUum1JEDil79/SugjvgK15aeC9471WvyS8ZNXo0iM0GijinkBDzP+RmpowspgtSvZFV7wL/BctWsnnvx+PvwITlH716WaoLB+wPutrrsJbjZH0fDwURaRSQy9SAH/aGLY3JNSaUNlvuFyEwEMNBAWDP1Wd1zyGfbnVxbMyyaoV24Wr241qAy2nUzoEbMoodLRRNinNDyyu/LqoDCUd8OC9Ssr+M9o2R9LpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AM9PR04MB8762.eurprd04.prod.outlook.com (2603:10a6:20b:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 02:54:14 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:54:14 +0000
From: ming.qian@oss.nxp.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com,
	shawnguo@kernel.org,
	ulf.hansson@linaro.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	l.stach@pengutronix.de,
	Frank.li@nxp.com,
	peng.fan@nxp.com,
	eagle.zhou@nxp.com,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC
Date: Fri, 28 Nov 2025 10:51:15 +0800
Message-ID: <20251128025117.535-2-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20251128025117.535-1-ming.qian@oss.nxp.com>
References: <20251128025117.535-1-ming.qian@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AM9PR04MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 023eeef3-0e2c-4158-4dde-08de2e296a27
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TqTM+KOhDCOGQ7jjAt86qXhynAEmle92eS6E0gvGaMn2Yi+1HRhMelMC8lrM?=
 =?us-ascii?Q?1DdLwCrmrNd7FWgVf5KADxrHgZTPnmtUQw6ZghIXaFxM2V94qT289ExKbdDL?=
 =?us-ascii?Q?+X3m+f3LBPA+0XnPLkhX2t6w/ZGb1mKWicZ53KOPQ3oZdzVfKLhNakFi3rwp?=
 =?us-ascii?Q?T+Rvu9VIwYR5cKl73A3aD/7SXBF9AyA8vn4a1IKW15BZqap/NMpMvim4JAzz?=
 =?us-ascii?Q?Wq6orAYYo5cpszkNeIIHhh0geLjnalM/R+EutsuLleLJe1vmy2CtFjcrD1fT?=
 =?us-ascii?Q?g7Hb0G8fU5PbSiDaYBEzR+cdq6kEeGI0ZYgBtWp+W7PlYOC61PFQTqQXqFR2?=
 =?us-ascii?Q?EhGu2Qw6gghoj5OqhpDjtyWTY9QGsZGmeUawYtkWcEtVVE+j1UvGFzHNDCmi?=
 =?us-ascii?Q?WcIR9ZpQBeNOMRwfGuoB+KdrHDZCEdEJx1kIZEKHdpspmNSOA4XPMAGKDOJP?=
 =?us-ascii?Q?NGmstesjCN6sndrgboIE+EJeRKMDkiC63sxxFKBP1AqUvYILJoy8KXVUWE+F?=
 =?us-ascii?Q?nj0a9Sw/4B3Kzia3blh7CZG8+6YoPCCXAnyuEdWhDk5HkRGfgeDY2QValsTg?=
 =?us-ascii?Q?bmI2azxIRtKqtgseGhuYgcKC/C/ouPQTklTkXnPlc1LpXOUhoRaWymL0fFDz?=
 =?us-ascii?Q?QW+nW4YmYL6vd3LFt+2M0ujO/PHxMW1ACA9HGH9jzOOshl+085OeMs5R6jFx?=
 =?us-ascii?Q?WCthYh7TxSxff5vQglz82kzMI3SR0MvBeK3BP2hRGbrMmDcPyiPneKG1YOYN?=
 =?us-ascii?Q?Kx/js7Jz0Vz7R4OCukFdLvAKuKVZ6QGmd5T4/xcfpUnRyMBD59B1te9s4Vkh?=
 =?us-ascii?Q?ATn1HNNSm3gZPG1OH0TscYmDWMre8/roxuH/RmYLRw3ifUidBWXi0nSAfJIh?=
 =?us-ascii?Q?Ml3MNnx5cNYd//VGWOuBa9G79PiexjH9l1ufgVDbPJS6JYP3AEpuzfOqPsnL?=
 =?us-ascii?Q?40rX6slwcsn34PXVSG8SlV2M7NEwasRzYj8Zefvcy86sl2ofxq4tlZ4faAdi?=
 =?us-ascii?Q?RhZb6Swk9g0zfoNAo/xytCI7E0n6cgJ0FOQqv7bTGt3ZmArrwthYLnEgjWgk?=
 =?us-ascii?Q?AP/e37MSGaT6INTyHXYFThmNis/lQdQVe95omrfSVkSkTncvKeqxDZuqw+xY?=
 =?us-ascii?Q?1zpGBYeDcGfgvGvt62t8Mau4GRpb9pZfwskEBRz5G48Qnq/B0lspjmIyB9Vv?=
 =?us-ascii?Q?0peeQVtJOqwa7xMR5fla+zvRmuAP/NnANFz4Tqqy2faZ8utlXSE0OPMKgTXv?=
 =?us-ascii?Q?Sf4qnXqek+Tzx/LNGj4x/MT6/kWdwOvg41IeNqshoKfS0ebQkIAg0FsCW4Hr?=
 =?us-ascii?Q?mlUNm9pMLNu0zteDArLFw9GFMyjEXkvFbFZQ+ZMEeC1OCLNvaf3Qtd3zFOVd?=
 =?us-ascii?Q?0ghigbYc1fjA6Vjjhv00jqJXfTsBnXLBOmkHTARi/HG4d6yt1AMaZzvDVvM9?=
 =?us-ascii?Q?B5OoMuP+qrvHxQ24NeqysRXovakjzJSqQ0wenkE0QodAzdVWoaKbyc88/oF9?=
 =?us-ascii?Q?Rs4HhBkqh+dXfEV9XSuieHKmtdQo6B4SqntV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vda9JlKelFgCYHbp3AO482Arp2bfdu0IXv2exISxSNJxbfVAo8epf38OFubE?=
 =?us-ascii?Q?xiO9clR0/wyPYfiaUNHxc5RPMyX2XYaG0MmJh5JNpR4h44F5Ew8qSjHFABAv?=
 =?us-ascii?Q?yPGgel8UT+Koc1GMho4pcr4MryuY3r48s2i/Jeh3mfKUI1NzkzSO9BnR1RvC?=
 =?us-ascii?Q?7cpFPvXBb9UnNcrtxi7MxoOgGwk4mmo/dug3PfmzR33o4mgac8TBQrmr9lOn?=
 =?us-ascii?Q?5WobH6iOVFfwP1+bbe04+uHBvkIhURWO1k8rF9DhCqUV8l63GUaiDn25FoWq?=
 =?us-ascii?Q?VF0GxMfCC2qSYiSejirtZiISPYGY/QDD9ChcX4ytBXxtSQTk8qur22aewNt6?=
 =?us-ascii?Q?sFtxKz4sagSe1rLFtXhrooSFdvW/ySHGRFYSMVHlJ0xU2SdXzuHkUIrAjkeD?=
 =?us-ascii?Q?s4ubfufVLQoQjRI+epG3URj5zTzZrGC3kjO20uCFbq8HKeQHRjfZPqWJYUBg?=
 =?us-ascii?Q?rAWaLWB+ndq0pRpB1f4DKNUDRvrt2+xSy9cDLPDkE3BGf2tL69mrEWa25wLD?=
 =?us-ascii?Q?XojoSm4ks08DA6EXOaPdyI/iQVm0vRuf7OKFTTD3nBK5wVexaixgKXVJSUtk?=
 =?us-ascii?Q?GW75qfQo+1NUldMtxj/0PyuZ5ExahFZKtqJ3hZK2f6eoaHUwYwmKbsnkmLmm?=
 =?us-ascii?Q?RtnvVtsUPz74PfU2IEGDfvTq7NCaUaqgfRks3YLe+ybUtABpKwxchn0YMAJY?=
 =?us-ascii?Q?7lkpJ54EjoTGfxcgqKvzkPLv+ghPwSkglM8FH0jY9sMAcMdRPHFiImzitjJA?=
 =?us-ascii?Q?mOnQXdoO1f1ADMifnjBUPv5Ld9WB9/0hzPlBdHClKkpszMjI8UHcTVJXYDLZ?=
 =?us-ascii?Q?TmkiLKlLpaWIeH3Cl5KNKveMI4A8brsnQW/C9yH6t6X/DZvy2+luN0zT4RhY?=
 =?us-ascii?Q?BdHmz3mts2YkQ0xtjHxQNGGxIzQitgXNNGCdduo3UAOyP8/nX39/aGMlHd6D?=
 =?us-ascii?Q?EnJdsQwSoY8RHtYmdrfXLWnxckPdVZ5WcFXR3fnozcg+PdXwvwiQx3WROP7Q?=
 =?us-ascii?Q?J+XYtNLCvzXDAvuvZAFb04yefFp5SKIsk3caRK0oRNddvdP1BnWSI/ptnWjQ?=
 =?us-ascii?Q?wRtxRf52rhkt02ONEuwHduqB/30StVZMQBot+0QvnVycTLmHaFakssc3sFld?=
 =?us-ascii?Q?7BRcB9jkczyEmjhg4sIkQpwQg/SsZX6PsQhDfg79oRz3+UX2ZYGkmXZM2Pcu?=
 =?us-ascii?Q?KqPPbG4EOr6BYokeWPDkRPZ65SPagj33zVqgXaEn+QY7pYRptd+c5G5fKwU6?=
 =?us-ascii?Q?fSFxcpfBBdkhe17cKsRGvvF/+Vah9ICuDg6WDvd5/tLNiwVH+5cYEhVnKftQ?=
 =?us-ascii?Q?g/fLvpnUFv3NdGu4skbFPhXPsPdwVkPJsUfEXreJUGQY6VPZStkgwDW7GCwp?=
 =?us-ascii?Q?rgmzTRfFb9DemToimETl3oA7o0tL/2whavOZq6IQG9+ncjHBdoE6Qw90GDnk?=
 =?us-ascii?Q?ymmcGVzWxt18Ru2qfX2iq3uPUVGL879e+S+uhtSkSvv4FiYCyJ5IwU1gdUCB?=
 =?us-ascii?Q?v99vvMbtM7C6w+wguhUUwvjFkEamCOpaeaZm1ONqfoFqLEGSqI1p2AAeX0n5?=
 =?us-ascii?Q?7bNNzzW18/Jf41nmVFAC7xPLeUoIZlwkIRzgvGCj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023eeef3-0e2c-4158-4dde-08de2e296a27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:54:14.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Il9YtRno+SLIOfKQJB5ipAuHESRREq6SS4CLoJNxjehysMprSDBzGL7S7qHr8Bt0wXr6eV+AvxWkez0NgQ+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8762

From: Ming Qian <ming.qian@oss.nxp.com>

For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
error and produce corrupted pictures, even led to system hang.

[  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
[  110.583517] hantro-vpu 38310000.video-codec: bus error detected.

Therefore, it is necessary to ensure that g1 and g2 operate alternately.
Then this allows for successful multi-instance decoding of H.264 and HEVC.

To achieve this, we can have g1 and g2 share the same v4l2_m2m_dev, and
then the v4l2_m2m_dev can handle the scheduling.

Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
v2
- Abandon the waiting approach.
- Switch to a shared v4l2_m2m_dev solution.

 drivers/media/platform/verisilicon/hantro.h   |  2 +
 .../media/platform/verisilicon/hantro_drv.c   | 41 +++++++++++++++++--
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index e0fdc4535b2d..8a0583f95417 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -77,6 +77,7 @@ struct hantro_irq {
  * @double_buffer:		core needs double buffering
  * @legacy_regs:		core uses legacy register set
  * @late_postproc:		postproc must be set up at the end of the job
+ * @shared_resource:		flag of shared resource
  */
 struct hantro_variant {
 	unsigned int enc_offset;
@@ -101,6 +102,7 @@ struct hantro_variant {
 	unsigned int double_buffer : 1;
 	unsigned int legacy_regs : 1;
 	unsigned int late_postproc : 1;
+	unsigned int shared_resource : 1;
 };
 
 /**
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 60b95b5d8565..f42b2df86806 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -35,6 +35,10 @@ module_param_named(debug, hantro_debug, int, 0644);
 MODULE_PARM_DESC(debug,
 		 "Debug level - higher value produces more verbose messages");
 
+static DEFINE_MUTEX(shared_dev_lock);
+static atomic_t shared_dev_ref_cnt = ATOMIC_INIT(0);
+static struct v4l2_m2m_dev *shared_m2m_dev;
+
 void *hantro_get_ctrl(struct hantro_ctx *ctx, u32 id)
 {
 	struct v4l2_ctrl *ctrl;
@@ -1035,6 +1039,37 @@ static int hantro_disable_multicore(struct hantro_dev *vpu)
 	return 0;
 }
 
+static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
+{
+	if (!vpu->variant || !vpu->variant->shared_resource)
+		return v4l2_m2m_init(&vpu_m2m_ops);
+
+	scoped_guard(mutex, &shared_dev_lock) {
+		if (atomic_inc_return(&shared_dev_ref_cnt) == 1) {
+			shared_m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
+			if (IS_ERR(shared_m2m_dev))
+				atomic_dec(&shared_dev_ref_cnt);
+		}
+	}
+
+	return shared_m2m_dev;
+}
+
+static void hantro_put_v4l2_m2m_dev(struct hantro_dev *vpu)
+{
+	if (!vpu->variant || !vpu->variant->shared_resource)
+		v4l2_m2m_release(vpu->m2m_dev);
+
+	scoped_guard(mutex, &shared_dev_lock) {
+		if (!atomic_dec_return(&shared_dev_ref_cnt)) {
+			if (!IS_ERR(shared_m2m_dev)) {
+				v4l2_m2m_release(shared_m2m_dev);
+				shared_m2m_dev = NULL;
+			}
+		}
+	}
+}
+
 static int hantro_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -1186,7 +1221,7 @@ static int hantro_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, vpu);
 
-	vpu->m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
+	vpu->m2m_dev = hantro_get_v4l2_m2m_dev(vpu);
 	if (IS_ERR(vpu->m2m_dev)) {
 		v4l2_err(&vpu->v4l2_dev, "Failed to init mem2mem device\n");
 		ret = PTR_ERR(vpu->m2m_dev);
@@ -1225,7 +1260,7 @@ static int hantro_probe(struct platform_device *pdev)
 	hantro_remove_enc_func(vpu);
 err_m2m_rel:
 	media_device_cleanup(&vpu->mdev);
-	v4l2_m2m_release(vpu->m2m_dev);
+	hantro_put_v4l2_m2m_dev(vpu);
 err_v4l2_unreg:
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_clk_unprepare:
@@ -1248,7 +1283,7 @@ static void hantro_remove(struct platform_device *pdev)
 	hantro_remove_dec_func(vpu);
 	hantro_remove_enc_func(vpu);
 	media_device_cleanup(&vpu->mdev);
-	v4l2_m2m_release(vpu->m2m_dev);
+	hantro_put_v4l2_m2m_dev(vpu);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
 	reset_control_assert(vpu->resets);
diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index 5be0e2e76882..5111ce5c36f3 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -356,6 +356,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant = {
 	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
 	.clk_names = imx8mq_g1_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
+	.shared_resource = 1,
 };
 
 const struct hantro_variant imx8mq_vpu_g2_variant = {
@@ -371,6 +372,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
 	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
 	.clk_names = imx8mq_g2_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
+	.shared_resource = 1,
 };
 
 const struct hantro_variant imx8mm_vpu_g1_variant = {
-- 
2.52.0


