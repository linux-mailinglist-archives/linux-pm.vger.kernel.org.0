Return-Path: <linux-pm+bounces-39231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7ECCA5DF5
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 03:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7CFB31A69A3
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6D28A701;
	Fri,  5 Dec 2025 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iTsR+Uez"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74C22773F9;
	Fri,  5 Dec 2025 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899756; cv=fail; b=fqU11OZREhXnN8jKvm1hQ8xCPoHDCzd9TX1Am5+b9fzAZyue+h/IBevLAFCEunDbBtf/gH4J9wg/+WfFprU8CQll5JcxZDBIjZ6kFggraJ9AUuRnQYNYJcbAU6X9cb88GJP3/PIXio3K1hg18CDkEOpKkLtFPf9eh6Yi6Vrh1OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899756; c=relaxed/simple;
	bh=oQ4zEDb53uEg6ZpoFog6tqkFgQ36F9z3+0ntmscOyn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4zlM4B9FZa/OzbBLNAdu5/m+trYCNiX+6iqpLuwHvlP0RGMHKdzsBES5XlzJpXsXQg6nT0C+pvVNpi5sdBVlvxCOMgqq6blkojIMk+xlefnwy2i5KA7IdQ14n9oFStX6ABfwqNhbdB2bXqRBwpuaL7EtPf9zDY6g863QapD1m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iTsR+Uez; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MutUvGzOhymBTJbIhxCywFOrqoOX6RJZdeKk2/4jQwGmscDcHLIc4h/8U5ijp2EPG6F/t2zTgcsblRTwSQKel5rNTWjSdgJhAfWvbHaTys4Twgkyaej2yygzd54lk1VgDyGux+4O9W0wknDcbYkbyRcj/5G6p1h6wt7E1LNAHdz5/knXsU+xUBh6dqcx30nrGV0RHBKSEL6i905ruvTUUcvQTGH/HT37ARds3E/TG480rLi4Qr74q+KPEYqlLxuuQo1uJ7TLypDMmWH53KkORRNzsRJw7jhMUpu72hwhWzLfCALV+sk9oipF35hhF/r4YXc4Ng9NEnlj0NeZLqApxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk3ZRJxSvylYgKRgqlduR4j6SacDbpN9tBZ/iIUl6G4=;
 b=x/7TqCzW4cenfPvU71lPWp42+HBrrosLeiNP5AI+Rcdy4Rf59qz2e3cE6Qkwvxk/W0gkGPecvE1m6jInR2aQEGI6ihbiVV8qogXhOV3xTHhsxqjiMlReekmQ32KKzVPZn1Oy53Mdllfvz44YbVUjd2+yIDptajQsrztCyLoF89WdjsUDID2LSuV2oKi02sEZp6pZqhyw4INv7Wud9d8J3Z3O/9kW+qV7CzkWCq9ZNHeYglJNlcak3mYkjzPQmn0mFBXhk3IY7ZtmzcFoODQNJ+o6ABiyqRETzZo5+PmUMRmNQCkqGlsZPDinXPPVSg/yU9lu7FNwjsBTdVP6t27jCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk3ZRJxSvylYgKRgqlduR4j6SacDbpN9tBZ/iIUl6G4=;
 b=iTsR+UezkhOlMsTr2pIghLnQSIkor/pS37SB5tCSGchiom0mXMDeZmFOEa006SXvzdWKhlu7tIos1km+22hEmHs1rU4d9i8Sgze/Bzj8YsT+qUghRDgnsKc+7AbSyB0YkyyoOGnKq7e77MpJQoRZiijmwmuWR4tTwbosdNAQOjzppHYepBLXxnIoyvXwBbL1dCKOxbOwws+eFJVGD0XB1LXqsDnXNKt6hXTq2XAtL7F158BXR3coar4kHmBul/V3h9g/oeC0TLJKXmhnnBJbbs6nN6HxMCABBPHYE7AFp46SbQkYLKp/NzSFLDJCd8QPufDtKJk/lQEY+YMC99m1kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 01:55:38 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 01:55:38 +0000
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
Subject: [PATCH v4 3/3] media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC
Date: Fri,  5 Dec 2025 09:54:26 +0800
Message-ID: <20251205015428.643-4-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20251205015428.643-1-ming.qian@oss.nxp.com>
References: <20251205015428.643-1-ming.qian@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DB9PR04MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 57004add-6f89-4c47-b908-08de33a16354
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PGgRJSNmvl345OlOcg22iBKLYyGgHMvIQ/kk6mNjqhw5NJ5S7ogbSsbSEH2q?=
 =?us-ascii?Q?Skx7QoKOeUhgMI2AxSExU0ugl/rtvIdMwcfuzyBMXgCqPksNxLy2/GNQrJ+d?=
 =?us-ascii?Q?vzxBjGCBMVhUTt5GpdpNWqVC4cdBx+68SdV2JVgKHrQC2lCyTFzm4M58Y4a+?=
 =?us-ascii?Q?Z5U01sN+SUIOi/8lOORpvKyGYZhVroiYWHj5WRWuvzRlOP4j9L26xx+aBRGk?=
 =?us-ascii?Q?AVtcd5y4yY0ei9UagIHAtzm56WQH2q+vw6IlLFgczLZHT3gz3njJYFj5ZnS5?=
 =?us-ascii?Q?suZ9XtvuAgo9jwvorsb00xOPrVoP6WDhDdPNvEpnaZz8gGKaeIBr7r2HMzDE?=
 =?us-ascii?Q?wn60rpPzSxoCIj3FUtujlEUGn16YBqvdG6kx9tVFfyx22d+9VbtqKniRG3KQ?=
 =?us-ascii?Q?OaVW0/1J1jdgw14xniDtrjADBoZZb4SnMN3uXV5bObdzlBMUgqlhG3KilzDa?=
 =?us-ascii?Q?RSAxD+pIyZp65E6DO4Yt2POCM8hsITFoVbpaXqWDCQ8/Zbr7i7uDH2QCMYJI?=
 =?us-ascii?Q?mP0ZKkWgcMe6BJ8hVBm3BSKCJtF1S7x4bcJTZomZs0k4hSHHPVAx2XBF01qf?=
 =?us-ascii?Q?H3+xBUZNRZzJDxQBBgVOeIwwzBlI+eDz9rzMHfpmnVAcFgEOzeOfFaCFrsEW?=
 =?us-ascii?Q?CQzmxWepHJloORysy/+iRd/nrX8ySz+WHG7b0LUTZHWscCQmBFPnx/LeLAXI?=
 =?us-ascii?Q?qOl8CQYJ98hpK20k82x8eJZpYLLQve2A//ofwv3YEXX8/1P8qDrUC9212TNq?=
 =?us-ascii?Q?WT7bM02jY1GYhLXZKmbIpQtolOJBP7XiiCXH1zxYWBCWx3rPCfHUPBf6gqqw?=
 =?us-ascii?Q?4DXsBTnYKbt/Z172e5YhtNkc51AsvLcsv7xLkKR2VgKIvoUFzasDWYhT4AxQ?=
 =?us-ascii?Q?o3CcgfjUpT5QgVHP3YkK6Ao2ju6CmraWtxTcnT+zcutzbSj51deKKikb9vwz?=
 =?us-ascii?Q?eZxSMnl58Um5Ns124gX1G1DrzO/O+EVGAAYMqQYkECy+JRKLeB1SWM2zO28k?=
 =?us-ascii?Q?KhmPGI7olOJrwQDEt5+3pqFVafpf06kemVAhMhBMcMsci/Lnu/RBMbuPiy8u?=
 =?us-ascii?Q?F3EaZ8hEhkIEGPd15X3TSi7XVPKgcTNlBvC9pCtjr46GOo0dyFebofDC6Laa?=
 =?us-ascii?Q?69IQFqvtGsrh68vmJMQ6Sx26uRPcfx5xcqKfFK1AZuWi3eO0YeEghgV2R58y?=
 =?us-ascii?Q?dclARIrKdeu9hZbqO9ng40WLD8/0uMdr0iFxMIqrwlxJbySYRuuLoFYDvr9p?=
 =?us-ascii?Q?vaZ5RaP8VcgoPGzcQlExjPjjxIojQnDuywBMoqGIs1uIQFePu/h0jvE0qT7R?=
 =?us-ascii?Q?UlZUgEBw31Qx8z+xm4O/hHUpmxpUD23lGfSx3YpFQj5IdldaqqHOWjS32o9K?=
 =?us-ascii?Q?1xOKOzqf1ktkzIrdky3MWPmM8NjP8o+IvdK4yl84k6LndhLj8YEW8mIL7gNt?=
 =?us-ascii?Q?Z2Gnx2R8PVqC/EQ4bxvd9rSgeFEB5wPvJ0TWLxF0/1nbtq8FwdRfW4y7L4qW?=
 =?us-ascii?Q?g/6UkL6IMiF8Xthx2wThoKGR/XLTV5DrsCcN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?unaZlxaWxboWkpGZWTgzZMoYXwvvcGK0KDZ37JUKheqz71AUeuzF3fiIlj84?=
 =?us-ascii?Q?M4YDzXaW4/Wi3aV+V34nyFa96zEfMiKNWvNtgQoLn8yv3/VBBHEZOPgNrlx0?=
 =?us-ascii?Q?S3Aq6QElVDI3+0nojY7pcQbaVS20QB7LxM0h4hqxLnC0n2gUECCVMPCiX4P1?=
 =?us-ascii?Q?TO3Dw6/wUTDFa1yqUXsJTHQ/l7kBq+Ftz3Wvwn6XHONp9ZW/vY7Ujs/0rcdy?=
 =?us-ascii?Q?rviNluuevS6wkUX4RHZauDbmESLdgxGsrYmSRCaTuVudeipawPP2WBG8N3w4?=
 =?us-ascii?Q?PBZemwy/8QzaCJAfilf1pq3rLdrG/upW7KIwU/aGPeR9FsCxEZ3hy7UOijVS?=
 =?us-ascii?Q?xHCSvbX7bGOOO0QcYq/j4bNKAR/lZ4HAX8JfKSA459hzl0t+mwOttfho2X8Z?=
 =?us-ascii?Q?rs8JdFWXtBCm2aWiTlUOkGxkwnY/xaZKi+fIn9kFw/O2ztrqrupJ8hd5TSTu?=
 =?us-ascii?Q?Qmv/ARN28wnmucdHL2IC0dhCRXC0sAompp1XkIjyFC4daZwE3lNbQmUL2RpI?=
 =?us-ascii?Q?101F8JwwWynujtxCBaJ09YaitUnZAGwjqcdNJgRVnMLxjPfXpuOXb+lhwv9R?=
 =?us-ascii?Q?1AfrIXP4Pj2cvwbAKxrY9foRUmL5hjJm36SZ4RMcdvArB11fJigrzdMA03ZJ?=
 =?us-ascii?Q?AwR0wnBK32tNV5/SjZH0Fe715QEiCeqWFCawn0DPh/ul1FBQs1Fm5igIcUce?=
 =?us-ascii?Q?v03WAxsFzfsTpXKRwFjMS8FyEoA1l8BOiR0uSecQ8wdgM4OMDcwUB9RgEESm?=
 =?us-ascii?Q?4fZBidSkSaQeeYrih1VdKQ/HtQnfZmSBL8t2q8L/vjw3AbWDBA35IclYkUFF?=
 =?us-ascii?Q?+VAT3HSe2D3oVxVDmhjTu+SLrFX3djR6nPD9tqQwka7dW8sDjZLTcWe8zhgf?=
 =?us-ascii?Q?LiD4Jw0S6+vIAyZCoYy4M9A8fHUlXWPAzB+bMuJoUGiRK1JXIG6VuUOaXpIC?=
 =?us-ascii?Q?2vEkuQTy0WYyrhg1bYNgcIZ3YYOqQPJ1BJsI4spv+a4JN5MEdfxo3grWg/wS?=
 =?us-ascii?Q?J29v7gPlSWR94ZUTEjNrai2q6RU6ykHpjuhxD/Kp6zy7Bayg0v2yCMzu8C1g?=
 =?us-ascii?Q?0p3cPeiJG4DyBqLKF/s1mAkiIq1iUspKGPvkMbIvhBnfPxb3vtLBtvqhBODc?=
 =?us-ascii?Q?4UbOdl8auOx9OQ12dyzTI8zr7ZNeTneE63lYmKbEFdmWdPtBPKcp2OOS5GVE?=
 =?us-ascii?Q?9ONHqUtnEmgdWyCiDW98yKj7PQO/23QN4iCW7/NtT8gr07tPMQYnSAhmxkyW?=
 =?us-ascii?Q?r3Pi7fCrInQKs1J/20uKe6YRLNU9fvf0wACi36fOeuc611qKU8mxOrArjkm7?=
 =?us-ascii?Q?YnKYUKjESahsQCvwA7VPIE3xHl4V+QwIR5jB8dtlLmnm+12b7xiiq0ID6qvx?=
 =?us-ascii?Q?8Xe/O65lGdBjziFjBl3w5Q4IMkHYSP4vUMcrXRrINNafLtXkGEfjAen2eNpz?=
 =?us-ascii?Q?LAG8EBAL7/yOmLrLBtZtYNeOuVk7rdbJm1ep+pQd9udJa5ealLr8+SkR1czE?=
 =?us-ascii?Q?bMCGNKDzLBCZ0Y/x1lpOCdhT2IKDzLARd7nqCPrwXpy5sANYoLl3hWk4zxNg?=
 =?us-ascii?Q?RQ5DBErn2ivJBgxsN1IEDG/WEkOlMdf/Tpyr/cM9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57004add-6f89-4c47-b908-08de33a16354
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 01:55:38.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzTVSkpN5f1A3Jw3fFlS3iWRAJqY0o+4wdavTxNqY6xiNk0SsNR3pYhVsS2vZrPlvmK4BEhADP6KZ8OaFpjawA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313

From: Ming Qian <ming.qian@oss.nxp.com>

For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
error and produce corrupted pictures, even potentially lead to system hang.

[  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
[  110.583517] hantro-vpu 38310000.video-codec: bus error detected.

Therefore, it is necessary to ensure that g1 and g2 operate alternately.
This allows for successful multi-instance decoding of H.264 and HEVC.

To achieve this, g1 and g2 share the same v4l2_m2m_dev, and then the
v4l2_m2m_dev can handle the scheduling.

Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
Co-developed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
v4
- Avoid double put device node in for_each_matching_node
v3
- Add some comments
v2
- Update commit message

 drivers/media/platform/verisilicon/hantro.h   |  2 +
 .../media/platform/verisilicon/hantro_drv.c   | 42 +++++++++++++++++--
 .../media/platform/verisilicon/imx8m_vpu_hw.c |  8 ++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index e0fdc4535b2d..0353de154a1e 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -77,6 +77,7 @@ struct hantro_irq {
  * @double_buffer:		core needs double buffering
  * @legacy_regs:		core uses legacy register set
  * @late_postproc:		postproc must be set up at the end of the job
+ * @shared_devices:		an array of device ids that cannot run concurrently
  */
 struct hantro_variant {
 	unsigned int enc_offset;
@@ -101,6 +102,7 @@ struct hantro_variant {
 	unsigned int double_buffer : 1;
 	unsigned int legacy_regs : 1;
 	unsigned int late_postproc : 1;
+	const struct of_device_id *shared_devices;
 };
 
 /**
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 60b95b5d8565..94f58f4e4a4e 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -1035,6 +1036,41 @@ static int hantro_disable_multicore(struct hantro_dev *vpu)
 	return 0;
 }
 
+static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
+{
+	struct device_node *node;
+	struct hantro_dev *shared_vpu;
+
+	if (!vpu->variant || !vpu->variant->shared_devices)
+		goto init_new_m2m_dev;
+
+	for_each_matching_node(node, vpu->variant->shared_devices) {
+		struct platform_device *pdev;
+		struct v4l2_m2m_dev *m2m_dev;
+
+		pdev = of_find_device_by_node(node);
+		if (!pdev)
+			continue;
+
+		shared_vpu = platform_get_drvdata(pdev);
+		if (IS_ERR_OR_NULL(shared_vpu) || shared_vpu == vpu) {
+			platform_device_put(pdev);
+			continue;
+		}
+
+		v4l2_m2m_get(shared_vpu->m2m_dev);
+		m2m_dev = shared_vpu->m2m_dev;
+		platform_device_put(pdev);
+
+		of_node_put(node);
+
+		return m2m_dev;
+	}
+
+init_new_m2m_dev:
+	return v4l2_m2m_init(&vpu_m2m_ops);
+}
+
 static int hantro_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -1186,7 +1222,7 @@ static int hantro_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, vpu);
 
-	vpu->m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
+	vpu->m2m_dev = hantro_get_v4l2_m2m_dev(vpu);
 	if (IS_ERR(vpu->m2m_dev)) {
 		v4l2_err(&vpu->v4l2_dev, "Failed to init mem2mem device\n");
 		ret = PTR_ERR(vpu->m2m_dev);
@@ -1225,7 +1261,7 @@ static int hantro_probe(struct platform_device *pdev)
 	hantro_remove_enc_func(vpu);
 err_m2m_rel:
 	media_device_cleanup(&vpu->mdev);
-	v4l2_m2m_release(vpu->m2m_dev);
+	v4l2_m2m_put(vpu->m2m_dev);
 err_v4l2_unreg:
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_clk_unprepare:
@@ -1248,7 +1284,7 @@ static void hantro_remove(struct platform_device *pdev)
 	hantro_remove_dec_func(vpu);
 	hantro_remove_enc_func(vpu);
 	media_device_cleanup(&vpu->mdev);
-	v4l2_m2m_release(vpu->m2m_dev);
+	v4l2_m2m_put(vpu->m2m_dev);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
 	reset_control_assert(vpu->resets);
diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
index 5be0e2e76882..6f8e43b7f157 100644
--- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
@@ -343,6 +343,12 @@ const struct hantro_variant imx8mq_vpu_variant = {
 	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
 };
 
+static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
+	{ .compatible = "nxp,imx8mq-vpu-g1", },
+	{ .compatible = "nxp,imx8mq-vpu-g2", },
+	{ /* sentinel */ }
+};
+
 const struct hantro_variant imx8mq_vpu_g1_variant = {
 	.dec_fmts = imx8m_vpu_dec_fmts,
 	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
@@ -356,6 +362,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant = {
 	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
 	.clk_names = imx8mq_g1_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
+	.shared_devices = imx8mq_vpu_shared_resources,
 };
 
 const struct hantro_variant imx8mq_vpu_g2_variant = {
@@ -371,6 +378,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
 	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
 	.clk_names = imx8mq_g2_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
+	.shared_devices = imx8mq_vpu_shared_resources,
 };
 
 const struct hantro_variant imx8mm_vpu_g1_variant = {
-- 
2.52.0


