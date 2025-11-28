Return-Path: <linux-pm+bounces-38858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CCAC90A93
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C88614E1AE3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1684028469F;
	Fri, 28 Nov 2025 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GNhSTmSb"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3227F18F;
	Fri, 28 Nov 2025 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298455; cv=fail; b=aBTuxzuS5/yvW991DFa6iv0soF37GQ1FEkBIu1io731Bw/0XI2KBMbD8dLhOPQ/8ouqGnkK72X4O3CPTzQIHmNEg9DIR/Fg9WQy+tR59RlrveFYgpkmo/iELTLtah9GV1SXn7CLL5CeneX5e2xvNp1nF2zzvZz1NxAoggpkvD6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298455; c=relaxed/simple;
	bh=q6suDOjf08IlGKFfvEXbN8hTugpmCehY8SVjF80YATM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TyUt6nAmH9UKD1bHNZ1z2YQEtRfZGJFCrzlwR4i56pU7IjHoLYUqGL3PTGt63wtTaxU4B/fRg+acDha2KnnLgDILH5LrYal9rjQkwWKbtrnNKxYtCtMSvgSioz2o3VIucJ8H4Z5FcnpeGKuB8MBL2p4CK+GFOuzzUKNqLS2nc28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GNhSTmSb; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyFEDMnw2CYmV7De/GfJyqKWC6mp4clUDHah4h0oM6TTpgiUNUGxOiWVNqpfGywa7CaiMoI1ONd3RHRtUul2PR9KDZhpSz7gOPlEX+aQA7fMDeU6p4JVo8wpKPm60h2foKbOq+8uQPETrnVUK6cYHQDKpvu1yA4W0XjevWT/rOPbRz0ws04uLwOSmBLLAHs/UEQGT/jq2+RNw6uR3YxQN9vhFXLxhMJ4exIX66HHg4wjtvD2u24jmA1GpkmAJlMy9wGm0BKyNjoSgbSy5kIa6GP/YqZbxh8Iy2GeCrrV9jYTOzeF9BCjftDsrb9aEk2NJU5/g+T0ImEjE1At1APYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRMhtvr3ym3zk5C08Yw3h61XdaA6pvOrgbtMJIWcQCs=;
 b=iPJs4nvu46o0i7sq5NEZ3+ahtDQyAjGSCTr6ZYpTI5dBa+fY+N3hAyRSG6yLgenJJC2PVOgxvLVCdBFI1CzDejtwdYOmVvsnuJzvniI1VlnT02JZnn60Qc+DLwRb+LGL7eLfRCZr0wwFDdecU9YfgF9aiifxf0gyrSVJA6CyQ88gUs2dWhxs1jXuo06NdYEA0xuDCcLMskslYfPPVgP7TZ+b3ieaKa1XzJ3Dr/Ns4ftPiAdzMCxLlnX9cj3+DWruuQPB5rYzpmWAlut7paR2zAUYKs31sUdpIRaPT8FE1uJ+Hbe9D4l4FIqa3G26hOU65D9FLQm50aL2HQf+ChxGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRMhtvr3ym3zk5C08Yw3h61XdaA6pvOrgbtMJIWcQCs=;
 b=GNhSTmSbVcmztTKtCshj7/mmbTn4wjU9BXE/28G8QejnGcCKK2pvxGAny0qIty89xlNxOGcJ389hZ5mGICBxB0bTH1V4TgrGYSB8OqjwldSz9vWpns0lWriJbnLFV2UY+SHRt/UP3bTarMUXpAjNcSg2GAvvmiajNiiQUDy9SHRQskhCatl7FywYpgytaZ1CK/D1vlyICAbpCgV1x0RCjDapk4S59W3YSvaSfYaOXwKWonm0wnG+iuoERN1w/pEpRlLqvgtoBU5j8STOfdn1NM1jIeWKowAO7AV9I2qzqkQZ248mvpkASsh0vQMUKeWlQwvUL3YaLxIQZ63xQ/N/+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AM9PR04MB8762.eurprd04.prod.outlook.com (2603:10a6:20b:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 02:54:08 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:54:08 +0000
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
Subject: [PATCH v2 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu
Date: Fri, 28 Nov 2025 10:51:14 +0800
Message-ID: <20251128025117.535-1-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
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
X-MS-Office365-Filtering-Correlation-Id: 1d17f477-a267-4b27-0a3c-08de2e296641
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4zOLIkeK1JQTRxTqvrAYleq7aFnnBdFGxCn92xuhClXehp3OySLxX5O4izGM?=
 =?us-ascii?Q?OLZ8Lde91UCy01K3enPOvJIvhe6FOZXSsDmXysQm0ENhr1PRcQk0zsIcupp8?=
 =?us-ascii?Q?BUle9eMntN8GjTKvoHP8wu2CCJCHgz+1hsW2QEnZlC6uT4/C/K5CHC1McNQg?=
 =?us-ascii?Q?bOl6ZGmekYFKtkUT5Z4b7ThJqRCwn9QHH+QaJrw1t8iAtf6yU2RZxvDnZxWG?=
 =?us-ascii?Q?QRunKRn15Bg69rT4JOOg/IP57iTgzW1IOdXyYDZS8rNhnvhUAmBh75+7fghf?=
 =?us-ascii?Q?vsslhmyh5tjrjmBt3wMzeoNpuviNO8F9V5G5r0ijJe+v7fQU9Kzv+5Q748wW?=
 =?us-ascii?Q?Bjir0yQgPWNbMXHotnXlBoYSov/UxMYE2Eegk0rJO3VR1dbCanhDzUqfxx/i?=
 =?us-ascii?Q?Mi8lMSLBypjxEEnwgVVAT5oLMju4qkPWU9K4VO/TwDfHfLNJ3UDgBlbkaZKh?=
 =?us-ascii?Q?2HbZyiwzlP1TXutqRJCMM64gmi4V7wqfSUnXd/oilQst1NkJX7i8g1wQDAfr?=
 =?us-ascii?Q?18CcNX86+fWdhgNR7IFbT+ckwlZ6D/qFV1c3YY5jHoDQ+0BigOG1aKKlbD8z?=
 =?us-ascii?Q?yJE8XkYk0RR1AYD2tUopgG7aZbNYcALeiljhTIAgLF+zU2nMw+6WL3C/uBP5?=
 =?us-ascii?Q?R7Aa3yAfP35j6BUMVusTUAJB1Slb8eiGJ/jT6a+19cK0NEWcCcnF3LSUFo3f?=
 =?us-ascii?Q?teTHlo2pkqtfHlaeKb8fGpMfChgIg/O3lMlHd70J9wqLjGSMprKox+NREiJ4?=
 =?us-ascii?Q?Cc2xGga6yRpSvMoXGOeCAi9Vc758jws2T3RmjUt8hMdj5Cu7zLn8AeMSBhgG?=
 =?us-ascii?Q?XGuodnJDh3ZTFmByXEfJsFMByD7tWZfRAUaEUsIEOhTlFSZI730YmrHqcBMP?=
 =?us-ascii?Q?HKT0wZsm8E/SWcr/NEkh+sZcw3YTiqmOX4jKLVEnwUM0gYz9/hjgjv6KMOKA?=
 =?us-ascii?Q?WPvuJVDM+RG/Mz5p8gT47O1a0TOlbQmGsQKybOcOix0YdVubIRnVKuoU4gdB?=
 =?us-ascii?Q?h36mWw4Y7aUH9qntu5GAebnOlQY9AwG8mo8FLGZcQuL99FP8/2rPPYTbY3ZA?=
 =?us-ascii?Q?aShL4MUNLQcHChfk4lnrB9OfHli3a9M5bk7npF6hBPBrE3dZqxQcRYUF4yHe?=
 =?us-ascii?Q?A/SByR4d8H6N8yIKYjWeSkr1IkG4cJDhnP2W6DMq2Ew7lwUgEzU4HwNjEdVr?=
 =?us-ascii?Q?LQc4G09uWZDIzcifMZpny+i8dYGfRK6yvPjnqTLhhcgLoAoLeuzRBhUH/S1Y?=
 =?us-ascii?Q?ewHpE4IU3morpkrf0GTPPF1asFk/mYB9YI7p2kfJfy/UgrmbDjYrjmvPv3gJ?=
 =?us-ascii?Q?qi7C4J6kcKtOA3S2ScscDT4tUYrRtxxzb9S+p+el+Vi3jXapfvl4RJK/ZQvx?=
 =?us-ascii?Q?+FDZvQfXODkaAYsb+iibUooxy2ptuvrqAer1LDFW94N8aPN8Mu1HHT+GxPVq?=
 =?us-ascii?Q?2sB+jpVwoJw0Pfaxe8L88WbiaHF+9xcccSzoRtikcbooFJtjP6m9ZUmFfIai?=
 =?us-ascii?Q?xgjUobrHi1itESvtSOxyftk0va4zYTM+r67d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ex7PKVJKGPe1Gz4KiiJ/9G2LjhUm2JuHNhxKhu8vn3WAzXLfQVQfw57z4OTm?=
 =?us-ascii?Q?okHOFiPPLqHuAqXb65NT5+5TOgb4HOddr8Fm6SjUVVBJF9Qx5LWOZ5SsCqgN?=
 =?us-ascii?Q?t85aN7Xxllse+dOlmo6HHCkCkI1saskow/KWOMFq04nsNT4RL/EHLM1Shu3x?=
 =?us-ascii?Q?hPNy6/RERS7v/PAKOncruOV+DDTwL+z5VXwVaA6LuCCq1lSHe/qd1lS3bNuK?=
 =?us-ascii?Q?1JRHSe8M+yw863G53aYxhKBSd6cWEeQCiT1hWj6v4a/qcFZLPpk3gcWiaucR?=
 =?us-ascii?Q?H8n9YQCe4vqB45tfdJbgFQqyxA84yh2scYcuI7DYBI7nmNsgyLpP/hEv072Z?=
 =?us-ascii?Q?dDcDeZQ6roSGre3bTfvTyR5tMnm6SxcBP/vF/f3UywlRNz3rJJcJHAm2cwkZ?=
 =?us-ascii?Q?toN440K0ti56woGsOXYkoiU+M1gSIYHyEHSSzKmUQa/sH9StwOibBblrMm7o?=
 =?us-ascii?Q?J5rhpLgg0M4taifNKREXZMXeHQO0VBBe1HajZALrPraKnDB9AtBzAUTWhSIP?=
 =?us-ascii?Q?KJ68bAOPqxGi4LFm8dx/7yG9DANDqafnTI2E7oPUYZWArpEtyOkH9NcDVdrK?=
 =?us-ascii?Q?I+o2q3WEh9p8H1r4UVmygNOtzGdh+rbnBO1yHbTbSnapYwuoUKxooAgpYkhX?=
 =?us-ascii?Q?XuEPpHd5s+tPg5pbK5n5C53HJAc7ml7KnU4SxkFnPOtW5iXvIy5vIUv0cxC1?=
 =?us-ascii?Q?azK+OTmx0AHSXEk3Az7zQj7eAfFG+YxZCis4maW/75WoBt73z9RtNagUeXeO?=
 =?us-ascii?Q?6Txb+slfEo2ovH9m8NGQBUSfAfBwBCUHo/A4HZ66+4XrfO8K+Inl+VMsxTc2?=
 =?us-ascii?Q?xEQX+emKaqIn/fFNdZS/lGgVHWAfTEw1c8kaT1bbCWdD7hfz2PZxSXHbgdRx?=
 =?us-ascii?Q?5wM86ywoakrbWeZzoy0AWUpH+/Zr2+/BnmyDdyAVcazRbVz5A7P9NS5Q3WXd?=
 =?us-ascii?Q?hj0GJekGoldplc+dDMMmQtYVNAsjrZHXVkXpvsWsd8fzBcnanogvjDZCbkLb?=
 =?us-ascii?Q?BsyCkFDm09/6Yq3DyI8EZUKSVTG3Llszihd3H59oX2x7Yll2Xis6AY1185Gw?=
 =?us-ascii?Q?cGRIcpsS4uPR9ziAszbrK/RVUxrTllYCDY21UEf2tpbiUdVGbrYyXr7K7KZg?=
 =?us-ascii?Q?sookVVllfh55dtE/lxBlnnzj2/nhi2XakpheU7NM+JUG2v9zOdRCeqfw323d?=
 =?us-ascii?Q?lQceZopV/RNcau0xm9slg83IlKWeePQSopBSIvF+/t5lx97CsM16wgDs3FJb?=
 =?us-ascii?Q?uIaFx4zkPAXWhXSkpruZ9nvW/JIzUYN0hwN2JG+TQx1A9yHYWL6gslLdzMD5?=
 =?us-ascii?Q?rWk+QMr2PnMmGXCPmn6mqfADFLgjhDjG38p8EDAGN+tjhnovEfZ7o2+9qr31?=
 =?us-ascii?Q?juKv8vaBuGK7SPW1F/E34c33VAQp8QEDzyUkz7ZjBcGcmRdk8ThE4017qmNZ?=
 =?us-ascii?Q?i+BvcynfL476qV6coQCF0rFuwkBMqRYyeGkBcJJgPsRLXv2T5dIN2PBsRDT7?=
 =?us-ascii?Q?cbmcOf4mzJK62jVh0Jppw8WmruiWUK6hkYlEluRLMXGTcBCgrLJgZ2MOW3ft?=
 =?us-ascii?Q?A7uvgyxnTN5WhbUkO9InTDXVVUv2Oml9Qf6o7Lpa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d17f477-a267-4b27-0a3c-08de2e296641
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:54:08.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrE7M4dXJnq4ZhhSA1PeTRqUZpIOWkXaY5cHq4A0APGhskDh0PkcUGPQj7q1EBS+Ti7VcbYEEW7qrl0bWTpaSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8762

From: Ming Qian <ming.qian@oss.nxp.com>

For i.MX8MQ platform, the ADB in the VPUMIX domain has no separate reset
and clock enable bits, but is ungated and reset together with the VPUs.
So we can't reset G1 or G2 separately, it may led to the system hang.
Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
Let imx8mq_vpu_power_notifier() do really vpu reset.

Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
v2
- Update commit message

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 5c83e5599f1e..1f07ff041295 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -852,16 +852,12 @@ static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[]
 		.clk_names = (const char *[]){ "g1", },
 		.num_clks = 1,
 		.gpc_name = "g1",
-		.rst_mask = BIT(1),
-		.clk_mask = BIT(1),
 	},
 	[IMX8MQ_VPUBLK_PD_G2] = {
 		.name = "vpublk-g2",
 		.clk_names = (const char *[]){ "g2", },
 		.num_clks = 1,
 		.gpc_name = "g2",
-		.rst_mask = BIT(0),
-		.clk_mask = BIT(0),
 	},
 };
 
-- 
2.52.0


