Return-Path: <linux-pm+bounces-18307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC629DF522
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 10:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B382811B2
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2024 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D337E575;
	Sun,  1 Dec 2024 09:44:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021078.outbound.protection.outlook.com [40.107.57.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657F2CA8;
	Sun,  1 Dec 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733046295; cv=fail; b=ncI6KN/saxF0NQ4OJHvyrYip2m4FnQiMk6HO0uMkK6dDvLL8FndGO3YArAzXxkzncRs+MGGvqbCzzlOEhjyrlx4HeMW6/gYSLoL+ZZc/sgWQ5AAuqzjpDnxDJQTU/xoBM+FGEF7JOKRUR/tKaDL4oSrpfBmUvZlKDcHo8dDN8KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733046295; c=relaxed/simple;
	bh=nyz3nYGI5PtLOUcBqUNTFaYokIWVJTm6JHa39amTZWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VetovWvncMF5FjrpeWMdT6brP1fNZTOy96/vWbs0Q/SmwfgEKEpQrhzEvLYQ/wv2HNHlbFHElSx5dREAeJWrEXbAPrw2XgyDg6OJS3eY4GOp5/bKzVdX2imkMofzcVhcBJDK1XHWN+jOm8n7/9IOrescwA8AOg0NLvggxanvAQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=none smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=siliconsignals.io
Received: from PN2P287MB1343.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ae::5)
 by MA0P287MB0804.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 04:11:30 +0000
Received: from MA0P287MB0434.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c9::13)
 by PN2P287MB1343.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 17:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRm8TcbPlDh23YiFoOQ5HDhOC0SiEFtf8ZVgxTlnZOAy2tGdAZVzw7lfv5q6JLr2cBEbNUWVnHxr4UqkhaA473Y211hKrb35tUhwSmkBTAbfBK+eo7WTerANMuwVbPV/vlPmJO6G9jYG2LJhLDx640H+kfTpQsTf8w8bm4BVtfyeTbBNcQ9biEMzNcu2wtvw3AzHnmUR5+8F6GCJIPtd0zsr8S/Viq5uIhJwwqw3Qdj2IgKydz1LSgHrdxiRFJUJAPgG5ezG5rJOp8RKWBel4r+OAc/E7LfSGTGfQQc/U0bBdUTHPmfdpIt+mIY8zYhBdBCIBghcJHkHY3s3M9W27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j21XdZkrxh56/a8llZbVs/bd/4+QXqgUSoSOqWSCwxY=;
 b=O3l/lWhlLJ17+AaT33kAc7dLRz5uBd92H7FrWixejKyA9wdTbltJUutAQ2NHen1QMErkQlcVeAoqLrnb6mdojE6QptPvjwVahUy2yvXSEUNXlUPb5PRc918AZMUHwpcWAlZgmXfh1InV4rNwQhmxmTFL4nRmjUcLbRDOlu9HTSDgir8cMEi6ugQuLT6bEY3ifLmRgF74E5tIkj2h6x0yWYCt2Z15is3GxQd0NYL6Uau3PvJyKSDvnl6qGU6VmVeCW+Cl5EZons2S+sLPOT++RngJVxHitUgbmmZAt7ESkrB5K/QWqTyHQI1kP8t5oXXebXuQ9QikU+h75XHlzbfKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 MA0P287MB0434.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.16; Sat, 30 Nov 2024 09:46:19 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 09:46:19 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: krzk+dt@kernel.org,
	sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Sat, 30 Nov 2024 15:14:19 +0530
Message-ID: <20241130094531.14885-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241130094531.14885-1-bhavin.sharma@siliconsignals.io>
References: <20241130094531.14885-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:fc::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	MA0P287MB1178:EE_|MA0P287MB0434:EE_|PN2P287MB1343:EE_|MA0P287MB0804:EE_
X-MS-Office365-Filtering-Correlation-Id: 6273f21b-6ba2-4806-5909-08dd1123d768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?RiEl6b6gXaWr3LFMDMNB4dD/D86Y9gbPG4uy1XxD/ihPu/ZP3Lg6JPei2UpD?=
 =?us-ascii?Q?vLIrfnqAAneAiF0/GmsryfYSDU55U5n0f1gSYWq8oYVCUhWw7kwSePNY0PXj?=
 =?us-ascii?Q?adPPO/82XPSzq30shkX4+OoWz/f08eYxdNXbRfZ+QNU8w5ptcXjxXIm9gks7?=
 =?us-ascii?Q?3B0ChYy8yTLGrkGTCg8V5dJFLH0nKogGTd08QRKgSe5g/xtY1fNtViXcuhtR?=
 =?us-ascii?Q?DSlzhJ2aGt6tnbw4uu2Ss+YDKQUkrr1P28M2q8pOB2z9sGn6b/TMUx4FVTAV?=
 =?us-ascii?Q?kGzG2iP5q5nDyYUMcJPcaZ0gu4ZOHkF/HYFUueuV/WP7sScRQfIwZbdSnf7U?=
 =?us-ascii?Q?LLv1Wxib58b2uHGLlGlNWo/9+wW96foDy2i1Ae+2ofp24mFwz1UAgKfgGHBe?=
 =?us-ascii?Q?bxiG52nuUFc/m6b7H3VZ3xr4WGI1OHPRACqWXCN8V3v00PE1bLLK8ihmtLUd?=
 =?us-ascii?Q?lh2vheBZMu37xDP0BkC+JoTt8fwGaB4m31kPkue+zm++G8YFW5K76pg12CGj?=
 =?us-ascii?Q?NSqGRifM3GWOlQ5oJE/t0onk2dAqp5pjidQBYa3a51rKgWJc/hHEhfibFj+j?=
 =?us-ascii?Q?i40gvq11IcndM4eFlJL7ID/F1PHJWjWi//Nu74nLUhdMIJw9Ipzzg++tRo+u?=
 =?us-ascii?Q?CN0Q13LPHuUWIY9pacrRYL1qwNYazGl35N/Sqb3+0pSrMh7b2Hyj92uUIgR2?=
 =?us-ascii?Q?YnR9LC/hxw/O+lIfz2Sifpx7t4/yQ12vcaWSVArjocIQsQQXWVESTw7FnhdY?=
 =?us-ascii?Q?3VQQ2OtR4gxZMWyP+IpoG9Cbi8NAD6ixP5qt3dJko2l/IigU3SccI2POZg2D?=
 =?us-ascii?Q?9YsWvc0VTYubaSfPkW62BEFs+8Vv/CjfdmurgjfxQLQqmObpVrE0sbxSQma2?=
 =?us-ascii?Q?f7AyzubDR8ETg0kmgKUvsroHIxYWRL0yGUA5e5x668EkqG1CAEcjvsdTN8/w?=
 =?us-ascii?Q?XeByvIo3oi/CBRV+7Q6DtuZN01wtcvynlPriBD7M+rAYYJ53C1pdH0mZzEcn?=
 =?us-ascii?Q?BVbFDuF2zcXp64g7LN9hpCrZbCoVWl/tQK5t7zDCd4WUQ7snJzOCI9a6o8yx?=
 =?us-ascii?Q?QTabgw8OeCYNm5ItbUHDZ2c6wZdQFYo5j7FeLNVim2sUHG0Cu7HlgZggSGvP?=
 =?us-ascii?Q?VI3/3JXdYmaCj1hRwOBgKblP7hDdf/6qSUZV212pzCWSTZf5idHCC0eoCT9O?=
 =?us-ascii?Q?pxU3nvf6n9B9qFp2jfMgeg0PgPFm/5GgX+6+Ek0l9rcztQC0IpqSzGL1TGdp?=
 =?us-ascii?Q?e2KD2qu1RnGEFmYPhRS5stlN/H+YYZ78soxh38s7fvfkDsopWiKeX2f4zBO+?=
 =?us-ascii?Q?lKdwdSBReLbwTDQqjkNIQ/3RgpM96t4i1XAYgIP6st+pYyumxjqBprJlwhPn?=
 =?us-ascii?Q?CkLisZXrGQTZy6fGOtsEuM9T9ns05ZoH53Bbgf36GxQ9d/rS1Q=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?XgmwvmYkthfmnY6s1RC2aQqfbGllHiBEEgmTaMIj3iDZkcfOOxVETGWltLrV?=
 =?us-ascii?Q?gP6JwGafFSyPqsiNNjEPMQSURj0OYgdtKdleo7jlGWPrwcvmWySxyxx8oxNJ?=
 =?us-ascii?Q?HwuJCIw3b28GiuCd5y8pu/GotYTySWdH5A7qi7g0wL8vLuyyqcNijH38XABz?=
 =?us-ascii?Q?tVzfdnviAKgRJJuV8IA3VoawONdRcbDZZwYwGkZxamvf+UIGCcRSagLZwIDy?=
 =?us-ascii?Q?9rz4DFAIxqZ3TLfKk3l3z80OFtaY3OF2ZDjjVu5VU3pAK1lFTlOQVMZDv2nf?=
 =?us-ascii?Q?Yw4+3lP0+re9uMqQ97izN2vEKG7USzO25NzU0zj32KksUllXnOwjbU4puLwR?=
 =?us-ascii?Q?Nl/RzQM3+Xki6RNvpEHLvKWfSYxPbsbXeam7pTDWkfonNI6JxF7248nBrswA?=
 =?us-ascii?Q?Aq/V3872K+q0fY1VWVXw6BP1S7cVmQLMM1HCbRmYRI4EVMfeyMNtRv2T/n4d?=
 =?us-ascii?Q?a+vkN1Tr+uwwjoT9lFy2336g3BK5OH6V1BcfCrs9tceTu+bSefmfF1jwWA0o?=
 =?us-ascii?Q?vblfZyRvSJvb/GZC2WXB+bByae4JJH0gORKN9k2ln2mDplM17S+TNgr1vyDZ?=
 =?us-ascii?Q?ZJJYwhqyNm0OBeNZVOWrmqW3sYjaMdqnh9C7wE8OBeQZ65KrR0Sd4gtX0BuL?=
 =?us-ascii?Q?/Ges88dPCM0bmDlryaFdAFUIugn/ZYOAwXG3oWb8u8SnS/9DOF2/sFxeam49?=
 =?us-ascii?Q?g9adwZMHOp1wuiB+sQZYmIKnUjWYyy9StkBhBCkV9CUdn2t6PMLrB3Jx3NqT?=
 =?us-ascii?Q?OuQkiH8DbO0Oi7fh19GktlKaAyGMvtQYnCKGJ8Y4VwLdkZhJNoxFWTTUuq+u?=
 =?us-ascii?Q?xnIoU83COUZqYMDFOVoywNyXYX5qkrH06izu8SgEPZaz9ctN2tCd5LahfAPs?=
 =?us-ascii?Q?O3N1YhjPcOC43ZwcrD+iE8oTTmMZENdt9Rk/SCg5Xthdwm/bpOXVXte0oe2w?=
 =?us-ascii?Q?Ykp/aoh4hKmSzoYUrjkatHXlcEUtStXuw+oZAReMe+PWmP9DE0NZ7kvtzGC9?=
 =?us-ascii?Q?WQPPLZSKCiLBLYlqnjpGj01YfUWT+68yJAlpSj9PFW3DmyXoos/XH0PV70h5?=
 =?us-ascii?Q?7+GB3L4e122r4zJfrhIebulIQuyHMj4RfUxCw3wGPiU+N+WZ8mnpNd+QZZTh?=
 =?us-ascii?Q?JjXCNhTiz+IYrcsQBw+ySj1j+ANREmPK2FtGuVfBInytqDqzM7om/AYjmeeW?=
 =?us-ascii?Q?AwiXKdn7MI/hKhZ7DShdwBZijsbnkQCGrG3kRgFD2qSKNT1gs2/XjMHS7JQZ?=
 =?us-ascii?Q?XFq+rw83InZesopuLm3VZ9xoMJSz7/esEejED0V+p7TVej9e2aK06XZWt+dV?=
 =?us-ascii?Q?pdEExWxpO4YlagvUw/bSzOci2Ax82QrFJaVWg3j6ugEiUinewtwx5Qa+SKVt?=
 =?us-ascii?Q?OEGzWua9CDGNg18VnKTZxznEbD+zgZrX02qaj99MvXPPDNMBcI26c3/r0GDC?=
 =?us-ascii?Q?Lk8vg17emPnyaT9L6gPsawfeFiJ3lq8FcaifyfTU/pSmD8fUz55m0z0OXCg2?=
 =?us-ascii?Q?4yK5tLIfGdTBZvBf4394PiR2sEcWouuUOSJ4N5o0zHKOZZCQJKhQBQ0rjBm7?=
 =?us-ascii?Q?vDi4iDK5bl7fzkSp8etp3K/136wu0L1yAQKsKPfmaUsqGi7wFNsfe0Am1rvH?=
 =?us-ascii?Q?uRtuCkz3bghbit4tZsIamrg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6273f21b-6ba2-4806-5909-08dd1123d768
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 09:46:19.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8USEiGdJTYcxSbR97O+dN24UaxDcMeg0O3Tj1/5mKFuxz6+CkBAPPtf1vBb7juvBO31xuIIsYEUkvheUsMHZC+lAnaLB5eWNNUd9Y+m28I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0434
X-OriginatorOrg: siliconsignals.io

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 659 ++++++++++++++++++++++
 4 files changed, 675 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c1fcc56bf2fb..10ead03660d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22125,6 +22125,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 F:	drivers/media/i2c/st-mipid02.c
 
+ST STC3117 FUEL GAUGE DRIVER
+M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
+F:	drivers/power/supply/stc3117_fuel_gauge.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef6787f7..8d14c81c7824 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+	tristate "STMicroelectronics STC3117 fuel gauge driver"
+	depends on I2C
+	help
+	  Say Y here to enable support for fuel gauge with STC3117
+	  chip.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 59c4a9f40d28..b55cc48a4c86 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..6dd5e7fb6336
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
+ *              Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ */
+
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/crc8.h>
+
+#define STC3117_ADDR_MODE                       0x00
+#define STC3117_ADDR_CTRL                       0x01
+#define STC3117_ADDR_SOC_L                      0x02
+#define STC3117_ADDR_SOC_H                      0x03
+#define STC3117_ADDR_COUNTER_L                  0x04
+#define STC3117_ADDR_COUNTER_H                  0x05
+#define STC3117_ADDR_CURRENT_L                  0x06
+#define STC3117_ADDR_CURRENT_H                  0x07
+#define STC3117_ADDR_VOLTAGE_L                  0x08
+#define STC3117_ADDR_VOLTAGE_H                  0x09
+#define STC3117_ADDR_TEMPERATURE                0x0A
+#define STC3117_ADDR_AVG_CURRENT_L              0X0B
+#define STC3117_ADDR_AVG_CURRENT_H              0X0C
+#define STC3117_ADDR_OCV_L                      0X0D
+#define STC3117_ADDR_OCV_H                      0X0E
+#define STC3117_ADDR_CC_CNF_L                   0X0F
+#define STC3117_ADDR_CC_CNF_H                   0X10
+#define STC3117_ADDR_VM_CNF_L                   0X11
+#define STC3117_ADDR_VM_CNF_H                   0X12
+#define STC3117_ADDR_ALARM_soc                  0X13
+#define STC3117_ADDR_ALARM_VOLTAGE              0X14
+#define STC3117_ADDR_ID                         0X18
+#define STC3117_ADDR_CC_ADJ_L			0X1B
+#define STC3117_ADDR_CC_ADJ_H			0X1C
+#define STC3117_ADDR_VM_ADJ_L			0X1D
+#define STC3117_ADDR_VM_ADJ_H			0X1E
+#define STC3117_ADDR_RAM			0x20
+#define STC3117_ADDR_OCV_TABLE			0x30
+#define STC3117_ADDR_SOC_TABLE			0x30
+
+/* Bit mask definition */
+#define STC3117_ID			        0x16
+#define STC3117_MIXED_MODE			0x00
+#define STC3117_VMODE				BIT(0)
+#define STC3117_GG_RUN				BIT(4)
+#define STC3117_CC_MODE				BIT(5)
+#define STC3117_BATFAIL				BIT(3)
+#define STC3117_PORDET				BIT(4)
+#define STC3117_RAM_SIZE			16
+#define STC3117_OCV_TABLE_SIZE			16
+#define STC3117_RAM_TESTWORD			0x53A9
+#define STC3117_SOFT_RESET                      0x11
+#define STC3117_NOMINAL_CAPACITY		2600
+
+#define VOLTAGE_LSB_VALUE			9011
+#define CURRENT_LSB_VALUE			24084
+#define APP_CUTOFF_VOLTAGE			2500
+#define MAX_HRSOC				51200
+#define MAX_SOC					1000
+#define CHG_MIN_CURRENT				200
+#define CHG_END_CURRENT				20
+#define APP_MIN_CURRENT				(-5)
+#define BATTERY_FULL				95
+#define CRC8_POLYNOMIAL				0x07
+#define CRC8_INIT				0x00
+
+DECLARE_CRC8_TABLE(stc3117_crc_table);
+
+enum stc3117_state {
+	STC3117_INIT,
+	STC3117_RUNNING,
+	STC3117_POWERDN,
+};
+
+enum stc3117_status {
+	BATT_LOWBATT = -2,
+	BATT_DISCHARG,
+	BATT_IDLE,
+	BATT_FULCHARG,
+	BATT_ENDCHARG,
+	BATT_CHARGING,
+};
+
+/* Default ocv curve Li-ion battery */
+static const int ocv_value[16] = {
+	3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+	3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
+};
+
+static union stc3117_internal_ram {
+	u8 ram_bytes[STC3117_RAM_SIZE];
+	struct {
+	u16 testword;   /* 0-1    Bytes */
+	u16 hrsoc;      /* 2-3    Bytes */
+	u16 cc_cnf;     /* 4-5    Bytes */
+	u16 vm_cnf;     /* 6-7    Bytes */
+	u8 soc;         /* 8      Byte  */
+	u8 state;       /* 9      Byte  */
+	u8 unused[5];   /* 10-14  Bytes */
+	u8 crc;         /* 15     Byte  */
+	} reg;
+} ram_data;
+
+struct stc3117_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct delayed_work update_work;
+	struct power_supply *battery;
+
+	u8 soc_tab[16];
+	int cc_cnf;
+	int vm_cnf;
+	int cc_adj;
+	int vm_adj;
+	int avg_current;
+	int avg_voltage;
+	int batt_current;
+	int voltage;
+	int temp;
+	int soc;
+	int ocv;
+	int hrsoc;
+	int presence;
+	int battery_state;
+};
+
+struct stc3117_battery_info {
+	int voltage_min;
+	int voltage_max;
+	int battery_capacity;
+	int sense_resistor;
+} battery_info;
+
+static int stc3117_convert(int value, int factor)
+{
+	value = (value * factor) / 4096;
+	return value;
+}
+
+static int stc3117_get_battery_data(struct stc3117_data *data)
+{
+	u8 reg_list[16];
+	u8 data_adjust[4];
+	int value, mode;
+
+	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,
+			 reg_list, sizeof(reg_list));
+
+	/* soc */
+	value = (reg_list[3] << 8) + reg_list[2];
+	data->hrsoc = value;
+	data->soc = (value * 10 + 256) / 512;
+
+	/* cureent in mA*/
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->batt_current = stc3117_convert(value,
+			     CURRENT_LSB_VALUE / battery_info.sense_resistor);
+
+	/* voltage in mV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp */
+	data->temp = reg_list[10];
+
+	/* Avg batt_current in mA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = stc3117_convert(value, CURRENT_LSB_VALUE / 10);
+		value = value / 4;
+	} else {
+		value = stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+	value = (value + 2) / 4;
+	data->ocv = value;
+
+	/* CC & VM adjustment counters */
+	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,
+			 data_adjust, sizeof(data_adjust));
+	value = (data_adjust[1] << 8) + data_adjust[0];
+	data->cc_adj = value;
+
+	value = (data_adjust[3] << 8) + data_adjust[2];
+	data->vm_adj = value;
+
+	return 0;
+}
+
+static int stc3117_update_battery_status(struct stc3117_data *data)
+{
+	switch (data->battery_state) {
+	case BATT_CHARGING:
+		if (data->avg_current < CHG_MIN_CURRENT)
+			data->battery_state = BATT_ENDCHARG;
+		break;
+
+	case BATT_ENDCHARG:
+		if (data->batt_current > CHG_MIN_CURRENT)
+			data->battery_state = BATT_CHARGING;
+		else if (data->avg_current < CHG_END_CURRENT)
+			data->battery_state = BATT_IDLE;
+		else if ((data->batt_current > CHG_END_CURRENT) &&
+			 (data->voltage > battery_info.voltage_max))
+			data->battery_state = BATT_FULCHARG;
+		break;
+
+	case BATT_FULCHARG:
+		if (data->batt_current > CHG_MIN_CURRENT) {
+			data->battery_state = BATT_CHARGING;
+		} else if (data->avg_current < CHG_END_CURRENT) {
+			if (data->avg_voltage > battery_info.voltage_max) {
+				regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					     (MAX_HRSOC >> 8 & 0xFF));
+				regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					     (MAX_HRSOC & 0xFF));
+				data->soc = MAX_SOC;
+			}
+			data->battery_state = BATT_IDLE;
+		}
+		break;
+
+	case BATT_IDLE:
+		if (data->batt_current > CHG_END_CURRENT)
+			data->battery_state = BATT_CHARGING;
+		else if (data->batt_current < APP_MIN_CURRENT)
+			data->battery_state = BATT_DISCHARG;
+		break;
+
+	case BATT_DISCHARG:
+		if (data->batt_current > APP_MIN_CURRENT)
+			data->battery_state = BATT_IDLE;
+		else if (data->avg_voltage < battery_info.voltage_min)
+			data->battery_state = BATT_LOWBATT;
+		break;
+
+	case BATT_LOWBATT:
+		if (data->avg_voltage > (battery_info.voltage_min + 50))
+			data->battery_state = BATT_IDLE;
+		break;
+
+	default:
+		data->battery_state = BATT_IDLE;
+	}
+
+	return 0;
+}
+
+static int ram_write(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_write(data->regmap, STC3117_ADDR_RAM,
+				ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int ram_read(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, STC3117_ADDR_RAM,
+			       ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_set_para(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
+
+	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
+		regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
+			     ocv_value[i] * 100 / 55);
+	if (data->soc_tab[1] != 0)
+		regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
+				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
+					(ram_data.reg.cc_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
+					ram_data.reg.cc_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
+					(ram_data.reg.vm_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
+					ram_data.reg.vm_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE,
+					STC3117_MIXED_MODE | STC3117_GG_RUN);
+
+	return ret;
+};
+
+static int stc3117_init(struct stc3117_data *data)
+{
+	int ID, ret;
+	int ctrl;
+	int ocv_m, ocv_l;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &ID);
+	if (ID != STC3117_ID)
+		return -EINVAL;
+
+	data->cc_cnf = (battery_info.battery_capacity *
+				battery_info.sense_resistor * 250 + 6194) / 12389;
+	data->vm_cnf = (battery_info.battery_capacity * 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+	data->presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT)) != 0) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+		ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+		ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+		ret |= stc3117_set_para(data);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
+		if ((ctrl & STC3117_BATFAIL) != 0  ||
+		    (ctrl & STC3117_PORDET) != 0) {
+			ret = regmap_read(data->regmap,
+						STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap,
+						STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		} else {
+			ret = stc3117_set_para(data);
+			if (ret)
+				return ret;
+			regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (ram_data.reg.hrsoc >> 8 & 0xFF));
+			regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (ram_data.reg.hrsoc & 0xFF));
+		}
+	}
+
+	ram_data.reg.state = STC3117_INIT;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+
+	data->battery_state = BATT_IDLE;
+
+	return 0;
+};
+
+static int stc3117_task(struct stc3117_data *data)
+{
+	int ID, mode, ret;
+	int count_l, count_m;
+	int ocv_l, ocv_m;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &ID);
+	if (ID != STC3117_ID) {
+		data->presence = 0;
+		return -EINVAL;
+	}
+
+	stc3117_get_battery_data(data);
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT) != 0)) {
+		ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		ram_data.reg.cc_cnf = data->cc_cnf;
+		ram_data.reg.vm_cnf = data->vm_cnf;
+		ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	/* check battery presence status */
+	ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
+	if ((mode & STC3117_BATFAIL) != 0) {
+		data->presence = 0;
+		ram_data.reg.testword = 0;
+		ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		if (ret)
+			return ret;
+		regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+	}
+
+	data->presence = 1;
+
+	ret = regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if ((mode & STC3117_GG_RUN) == 0) {
+		if (ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+			if (ret)
+				return ret;
+
+			regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					(ram_data.reg.hrsoc >> 8 & 0xFF));
+			regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					(ram_data.reg.hrsoc & 0xFF));
+		} else {
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		}
+		ram_data.reg.state = STC3117_INIT;
+	}
+
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
+
+	count_m = (count_m << 8) + count_l;
+
+	/* INIT state, wait for batt_current & temperature value available: */
+	if (ram_data.reg.state == STC3117_INIT && count_m > 4) {
+		data->avg_voltage = data->voltage;
+		data->avg_current = data->batt_current;
+		ram_data.reg.state = STC3117_RUNNING;
+	}
+
+	if (ram_data.reg.state != STC3117_RUNNING) {
+		data->batt_current = 0;
+		data->temp = 250;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = 0;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = 0;
+			data->batt_current = 0;
+		} else {
+			stc3117_update_battery_status(data);
+		}
+	}
+
+	ram_data.reg.hrsoc = data->hrsoc;
+	ram_data.reg.soc = (data->soc + 5) / 10;
+	ram_data.reg.crc = crc8(stc3117_crc_table, ram_data.ram_bytes,
+				STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+	return 0;
+};
+
+static void fuel_gauge_update_work(struct work_struct *work)
+{
+	struct stc3117_data *data = container_of(to_delayed_work(work),
+					struct stc3117_data, update_work);
+	stc3117_task(data);
+
+	/* Schedule the work to run again in 2 seconds */
+	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->soc > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		if (data->batt_current < 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->batt_current > 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->voltage;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->batt_current;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->soc;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->temp;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = data->presence;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static const struct regmap_config stc3117_regmap_config = {
+	.reg_bits       = 8,
+	.val_bits       = 8,
+};
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct stc3117_data *data;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_battery_info *info;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	i2c_set_clientdata(client, data);
+	psy_cfg.drv_data = data;
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	data->battery = devm_power_supply_register(&client->dev,
+					&stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+					"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
+				       &battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get sense-register\n");
+	battery_info.sense_resistor = battery_info.sense_resistor / 1000;
+
+	ret = power_supply_get_battery_info(data->battery, &info);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get battery information\n");
+
+	battery_info.battery_capacity = info->charge_full_design_uah / 1000;
+	battery_info.voltage_min = info->voltage_min_design_uv / 1000;
+	battery_info.voltage_max = info->voltage_min_design_uv / 1000;
+
+	ret = stc3117_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to initialization of stc3117\n");
+
+	INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_work);
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{"stc3117", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.43.0

