Return-Path: <linux-pm+bounces-39189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E18CA2F11
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 10:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A37803033C87
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0651338935;
	Thu,  4 Dec 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k+pEwS2G"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDC33891F;
	Thu,  4 Dec 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839451; cv=fail; b=uuOLSS/E4ZYoY+ifQc4w3aSu9AUK1Awh5N41LCQ8sRiZEiagjVXwGOTP+GGRcpz4RCLmzrWZro2iNW+zZwy8VxpQgQUaaVUXGqc3ThLy3/GEiZ86z7klxv5dy6yvCS6MC4d2Y3Ay8K9IgsHlCHAaM7/E0BwwfABQoRtiuz1xDH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839451; c=relaxed/simple;
	bh=xHpQB/M7CCX7QQTHuV4kUjoUyNfp0/V+YB0Opvv73gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apZ4bTGRAPCETICWDe1SyHHIGFxp/Qcr4iAYzoKsFnErwbLtxVk6aPNWs3UJQtj2TZkv+mtZ+AYju+Pisvb7DlWx25JHIyNUQ7g5oBEYSikiD3PeVGDyZkedm34rUUdqveBax9EA0ZKTd4iAElDEuZUYUdS2i/loB1f69saynPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=k+pEwS2G; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDBwGZA/HBuq1b+Mg/AA8c1wHdWftmQqZLatV26NFBRZo2yEdkk0U69KxxUWejTW4O1nUuQfMLJiQhkrxMeZPi/tl1ULhN+T/UGS2/2uTV2vMgNlxjxkkKOkjH/V6MGqEAOPB6r/YDk8LaJ3zV0fzGnfHq8Tgf3VORRWhJXbkBPccyKCuSKP0KtN2Vn5jHZgyze8YF7fm6CfA7kvaOppi6lG0IobyeJke/cx7tYHTJ48MtAgvPZJ7ZFV40zdl/os8EAaw1R3wU7R1LPBybk0OwoNjtw05Ou3dU2r9GMZDNUMGdoHrvDMTEg50kBsfF5kkHEkwuRf8lX+ynRNMQrfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp11zDXR81VcwnplsSx4qPEQG0VatIOdgp3EJSneuz4=;
 b=Q/EuaGWxAtzLc6TOcrI4+hNAKZQqLEWAJshKBr2mT7J9W5guKbWsracL2X+MoJr8wZcCs26LSrDg+iBsKKZ88KlUYc8rL/C6wH4qxQbkKGSYQJOKLFy2ma6bVtRmF+V+XskDozcQCak1PTlt9gyreKoS6dXL4OBIUmecj2zjmif71JyW2P4TqZG9zHLbIdnupBJwMWjgc8SKYTSuXiZZ+thsJmxPmTSvAF7s/PxLEsklOp9pMdSns+AtIX7GD85ltqGbSKGAzWb3EcgpStczBkGuN/E6NVmkU5RC3K2Zacl88uzuc8VNhfybrIDEh+Ov0g4vYDKaCyfV7YCakbFdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp11zDXR81VcwnplsSx4qPEQG0VatIOdgp3EJSneuz4=;
 b=k+pEwS2GmHfdUVmn1Zf9qJSbWc330wB0jfFnvlA3UpSd5LD4o2KJdFZ5nTwrsOw5kSqzQobjwdbhHIB7T8CDaYcb90ZRLVDgBydJFf5NAthcP8QU9KVIcbnMbEABJM4ivaFNSCug+GoW2E/Mmy8/bsE98qgQRXvQuWG8Z5FvmEL3K8F1wAfu3yQi2VOU612nXff8Qj8+zjDVOc7frC4Kq25KQ5QVUeI8SN5UYpTGRqRgeencr2SMyC/DxYtixrbgxFjnV6vP66n0NQs6z8q9Om1JhRS7DyrPGUq/nzB8+SsDz18ZQSLvsDmkjHC1jHJPQlV3EozScozBwT3hkDGplg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 09:10:43 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 09:10:43 +0000
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
Subject: [PATCH v3 3/3] media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC
Date: Thu,  4 Dec 2025 17:08:11 +0800
Message-ID: <20251204090813.595-3-ming.qian@oss.nxp.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20251204090813.595-1-ming.qian@oss.nxp.com>
References: <20251204090813.595-1-ming.qian@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0dd6b2-4cca-48cc-5a43-08de3315007d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l34oGcBGKxiRr8cVMNIWQCJTZNXoWJiu4i2mAL3j8aB2T/5Jp1KNLs9CtpCr?=
 =?us-ascii?Q?8gxxqY4QQgs/OEHfp+bl6LBZdQw8ueKeLpL4VsYxEMOC+ezhe9GAVSwFxYLk?=
 =?us-ascii?Q?KpWVL6TbDNMXE1XDqMdscmKx5WQ7agJ3C9ob4gtv5Wp4TLIeT4ZqJSlym/KA?=
 =?us-ascii?Q?kvIHVS10OXrWHx6NUBqHfM+avfYUep8ZG4ySCNqjeLWvXRbS7d8iADNzYVmd?=
 =?us-ascii?Q?PxWvdpOkPoKEaYlnZgmsI9IQcJlndCH0qnTJ3ePUxlA8ljS6qKJa0gsBMevm?=
 =?us-ascii?Q?mUDbtBnJb6XepXK/5QLIjfR+Xd9ppypLl5oQDxH9hZGu3xMb3E64mMRJWaUn?=
 =?us-ascii?Q?foclEALVcchStgSowkfe1gAlaCU3Q1zsV41ecupK0uyq2Nc18NyAfmF9tIvD?=
 =?us-ascii?Q?wtsuGA3m1gIFII2PFhZGJ6rvKa4wym3idJPRx7IPWGbrrSmregQmO5inz/mr?=
 =?us-ascii?Q?Nm6Md3q431sAq8HBjKEAk08aZlo0y/PcGazR/RCI2voXwvnUxzl6PhvBt+XZ?=
 =?us-ascii?Q?UiOGbXV1pGCPIg9juWs9AQI8ogTnqseH8p1emmiboUmgtvAJ+1XPyIKn94Ps?=
 =?us-ascii?Q?FqGM3xPDsqwZSSE3mG5pMc1HmcVF0GrAZK/9G/Clpce4sNzX1tVTRxSwJvmO?=
 =?us-ascii?Q?9Ulazi7g/ourfYB9CrwIRKQGh7OiJz6M3w7e8jIS2smohu1VLJ8JcI3Be687?=
 =?us-ascii?Q?aM92oFknvYlrpdX6bxTDCRGYqky22cLhyX2QTc/1eMjaNPVF2e6QovzEzLci?=
 =?us-ascii?Q?JY9fjN+/6V2Sryuie1TYq8Dy/HfYq3jLqVCd1bmtUTXz+uM/dtcWSWrClps4?=
 =?us-ascii?Q?RtSI2rQxIEj4fvggizLp/3OmCSqvd+YUuH8Oc6IEiNkCqXn4pG7KJ5qau5Mt?=
 =?us-ascii?Q?1lAizZolNkw6yeHIwdGy309I+KUnEWUUq5Q14DDaevMuS+d0Amysx4YhAvK8?=
 =?us-ascii?Q?Wf0otW4agIJqaCR0DmJkxOyxRc7pTk9Ox4fB92SlZyFvZZ5gYt69oVGTtH8F?=
 =?us-ascii?Q?fZMAZDISei9wIaF6BkBP06wKAHG1dDrkoyUzNj62qGbjPBkqQHL5LLDRUIQF?=
 =?us-ascii?Q?/7gfG62g0zPhfje9/KPUISsND4ES06/B17wpI5k15j68eVYuLNS2+CCBPOXm?=
 =?us-ascii?Q?j1ScUv5l59Jbl+j9vmSsuiHpx2mCCPRKxu2W4guGCq4OEUlVbFvv0T9whr8j?=
 =?us-ascii?Q?V/aqx6kLcmVZyJGW7p+wJmt7ZQ1MScy2NZf9OrhrNBnW3O83Kgr8eGB4wVUG?=
 =?us-ascii?Q?4GzsamkZpCIVgWuDE4FL4i2VwlKcvPBUKBcGLIHuKXs9d8+PWU7PyhwnHUv8?=
 =?us-ascii?Q?U2gBXp0DjqaeCIl9ZSpp6L9VNpkcarND7nFur/d0d2ee8HlN1JJ+O94D5ubG?=
 =?us-ascii?Q?JTL1UpAS5SqY9YwrzGbWktO7IXLQDcbolk6jYUPkaV7neQdnrDlPTyBhCVag?=
 =?us-ascii?Q?HSCmR4SqR9MDuqeTJ7xkxadzn3EUjQ/fHd0OsI2W2FMFp0LFJJ08KScODvd3?=
 =?us-ascii?Q?QwO1DmToeDkyGRnHdr8xxmoMSRNf3LzVBfA7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g0ufTr7hzxoR2oEObk4Brt3c3jlsJrQdMPVFQL5Yp9xtUo2sYmO5cyU4/ch6?=
 =?us-ascii?Q?npydCIE6VOxd8dY9JMM6gdjjseXmplehchA5TUTwvn2rKJz4cKwje4TWGsQH?=
 =?us-ascii?Q?/U9tjaEbxqMLhv20w87ZGx6CUa2fXFv6Xb+MKHeEpWOYZqnX9TMQ5/dBW7F4?=
 =?us-ascii?Q?qJjykuFMaGlcohb0leheLQtgapdyA0DM253jVv2ka7K5cRbP35dtWlqUZ17y?=
 =?us-ascii?Q?0wpjcGVYCKltvc6kOZkgJtddBQzWe0COJm2EclZsrw91OZMKsu6NrjUXjvDN?=
 =?us-ascii?Q?hp0JikN5Ss/W5rpxEWvPZXgSzaUEMbCouVxwrTmvMkoRVdgpsKGBJY5VLxQH?=
 =?us-ascii?Q?1qJQCCXZMRzojwqasMGGMmbvR0Ke+FDQm8wroQ48QWevdiL0EEcYUlpK6qWX?=
 =?us-ascii?Q?IO3MgDqzghTImLcVz3G23pb41WJE61zgr4aKwmyU/8TMoPa/YzktsCRiGke9?=
 =?us-ascii?Q?3u1acl/0m00goYtiOprivCE1ryupbu+5HmL1MgBtYXZvPKUERbTx6vmUqy6z?=
 =?us-ascii?Q?//gQMet89unjGjnZ7PO1lYdU9PzicIiQ5sBSoNlPz64Zpb5N8zwuPnRKimhB?=
 =?us-ascii?Q?EGcvIe1vZ9n4XrO70vgZegjlHEhiY4YnhP8LBLsNnnywtACoNove+gNhZMBt?=
 =?us-ascii?Q?2j8z2qgIV1rWIe9/YgdsKPesid6zMp1gKiv139TW2PlK8qiEp+2XjNcIMX8H?=
 =?us-ascii?Q?dEQBpPEur5GBt7ckSeOeFy0qzG2dUrJnlSXLSVdu7uOQ0ewObGDVdaoceQeF?=
 =?us-ascii?Q?n82CatOh3X58JDJTeZRoYCSb4cIc7pHz3wt/QjTXcr1CbrQsYsipnWjqud+/?=
 =?us-ascii?Q?ls6SLWKR/mLUkS6hIZvBHDQzAdmYCFQVe8MCkxEUut6QNJ3ydwLLoH3YRrf1?=
 =?us-ascii?Q?hLNoV4hoQambyrOruk7UF5/F4FLY/AbpKH1mHtoVa2JjYlnf9GIEWWVueUF+?=
 =?us-ascii?Q?mJqpIOJfjGYH8zMFCagcYqKFr2e0u7JqKnHiS2dnfutvvNhbms7aTjA6rDC5?=
 =?us-ascii?Q?BZ8gnreJpwOqyWJULwO6kJUaJlahntbdtlDbhVUlmiTWEwPkL0vBfXiqH83H?=
 =?us-ascii?Q?5FxQy8toprf3VlxWtKX2bHX884YBgWlev8qDerfFhqa/jmHXFJuXlGMP9clP?=
 =?us-ascii?Q?fab85NL9/tPwO3kgsoYclMjraikV/yLO/KjCNDh210Of28bRmrbmWZU6Aabg?=
 =?us-ascii?Q?idQZ5XogqyhJE/Ww0VY+/v/Q3wS4XMYvjKWVgj/fwW/UZNIUx4znNuFIzhI9?=
 =?us-ascii?Q?vXU1msyumYgrCwNvoLYoA3F6fyrlYdSLZEArBYIANHKx7x0iRZIAIQDHSjte?=
 =?us-ascii?Q?rINDBtWM3Fqkw0DJclJoxDzCjyRlSIH4ro1fHtY61oPFh13lmlXAdS+cvWSF?=
 =?us-ascii?Q?HhijPoiBaesCGBjLJTKoxAMJTIWz4YKoALMjXWh/8MW8+QBnxAL08i6RRAbg?=
 =?us-ascii?Q?S21UGT6iRNeWwLaMxf9JNI/ewPrH0cmy7kb52zcX31XwFda+ttVHsnkNyVba?=
 =?us-ascii?Q?LYajxaTqRyEm/xdzHyNWpTEjycO4kyCp5v6tUYRCQJbjPUaCi3vuFW0i7lkK?=
 =?us-ascii?Q?SBz9WnC3/w5PiQral6C9W/yfWMJ//duRQ9aTVbhq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0dd6b2-4cca-48cc-5a43-08de3315007d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 09:10:43.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHo0FMbPY+Pe3ZN8m1wGMjDn2qoVIOqkj9WJJ3XsZJhnQh5qysrNdPySj7I3TgkyNaimziMau9eaGTf/SwNYig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558

From: Ming Qian <ming.qian@oss.nxp.com>

For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
error and produce corrupted pictures, even potentially lead to system hang.

[  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
[  110.583517] hantro-vpu 38310000.video-codec: bus error detected.

Therefore, it is necessary to ensure that g1 and g2 operate alternately.
This allows for successful multi-instance decoding of H.264 and HEVC.

To achieve this, we can have g1 and g2 share the same v4l2_m2m_dev, and
then the v4l2_m2m_dev can handle the scheduling.

Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
Co-developed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
---
v3
- Apply Nicolas's approach that use an array list to define the shared
  devices

v2
- Abandon the waiting approach.
- Switch to a shared v4l2_m2m_dev solution.

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
index 60b95b5d8565..70160eaf3d15 100644
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
+		of_node_put(node);
+
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


