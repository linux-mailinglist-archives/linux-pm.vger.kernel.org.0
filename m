Return-Path: <linux-pm+bounces-33597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40DB3F2BB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 05:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB5A485241
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 03:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4F2DFF18;
	Tue,  2 Sep 2025 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WABtZNXc"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D92E1758;
	Tue,  2 Sep 2025 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784015; cv=fail; b=BV1xVzD3LOI97Qw4VZgDnCYK6Ub8f6NmxPFYEX9qrXP4FUnVN7k72XQ2w2Dm9RB0nsCrvgRVo2n1mTqQG/zlgfdcMvy0QF3ZQaXRwUC+TgmUtJgE+z6AmRFj68IXiIvBLJR7JzyRxofMlAlheV0IIwhiXysOV6xPNTIBzxGMNRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784015; c=relaxed/simple;
	bh=okj0mEziYH2FTGEw1lWPIeuHNkfG5yomThrT7tuLhUA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GKn72S9U8fB7WgGxAcI8lt2PzuUayQzGdUye5cHEDGX36AJ6DsBgpZElV9TMkgBnYtRwTpxy+iQ+GyrU9p9v07xGW4nHBX6kY1SDNglamaaWG13mmjDBh7aGyZix/MCNTMsWkcsTpDCOe3OTv1EBuxhCA8HJRSbHubrjoBq6s4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WABtZNXc; arc=fail smtp.client-ip=52.101.70.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6ZyfpyILYDr1p2NQHUvJdL5kPu7cjf1vxPfXRPZJTOeMWz8se+9ggVhn5M/Ly8dUs2UG7/OReejOsqTGh4SY37jYUkCoZycxXhUq7Ttc1mc9yG3mnoQMkEHiLV/RAcqQ97gZ8GdJbuEcCeWZHsl+ktzSB6ByRsw7uF3Nfu5r8B2tHePDvyt0nWydWyIo9IgOuotpi9Jqz7FshBvIsPg6O1AAQY3qYrmiOYUUW6KzK3DyeTiVJxAftL5cJ+aeg3TWK1sR3TdKQY4O7N+x6wNXzbyiSGRH/RGfmsV9lt/F5Ag6k+E9wE5Y3jvhbaiWpqGcNVTRNAiHUVMGLO6ziEepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWcr9ewbedFtpRneYEeuUPmXSTb5fEpaISK+8j7hUiQ=;
 b=jaRrHw4SST10ROYnzj9ZIdUX1oejUlUIoP5VU9MIuKe0kzcEbWBcdARfURAgZZR3KYUR7ckXCK/vHkM2jq6vj9dL3gyFuvFFKiKtKbRgt4UUxFU1wJcL0UkUDn9SOJDm7nkH4tTOx4ZaXT0li4BJXlEVnfMBNU5lFpHa/I8wuee3/CdBvRagW8arXzJcw5ZcoHuQu93MSXHdsj0AYD5kgIDrcn5Cfa9jz7eoMlXiKiB/kF2nV1o8wqEmtGfa0QHhjiE9gmQ96xMj+9wsDTpaKv4EdkwDFt/cUms5a3bNbbpeuZjaxj2+HC33zdBh9VHpO9Blhh7tvH6NwfIeY56znQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWcr9ewbedFtpRneYEeuUPmXSTb5fEpaISK+8j7hUiQ=;
 b=WABtZNXcO+ARt2QEwK/YUMslos0S2hIBifWkNg5/0lqV1t40lPn6g3h/A3rMTJpkyATM1J90eLC2n2mmq3LyXq/2nPmIjfICLaukS2Rbm5LwjNofL/+fGVLN3v66202dA6zodDpnWDF65zHz+qr+BxJxQDyGd8fDks+HiT/uymfLHG0EU6RHEQGRZ8zh67ZA3uD8bUBfohKXSljgqHpijKHiNU7Orh2t0u0DNv96YtzxWp2AljSCEM9hPBP5+pDldXc6YsOnatRny8uyRoREFkW1SALySlHZz/I0VgitRB4UsUNRN2P5LZIWIQhvFSlmcxX3HNcjf6ojnrDyt3n6Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:33:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 03:33:30 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 02 Sep 2025 11:33:01 +0800
Subject: [PATCH v3 2/4] usb: chipidea: core: detach power domain for
 ci_hdrc platform device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pm-v3-2-ffadbb454cdc@nxp.com>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756783991; l=1686;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yl8wn5p+ak/YuenxeCVv7TmfGI2531Vx2LzzqSbhRuA=;
 b=nmeyS2RPUjW08me235BTXSQ1Oz8QjaOUdq4Lu0jzNV3zoo1ox7xzDhVcXCBY/eUlUJBXIqEGt
 TQF1U7HtBamAr6ld8NSbJEVcdqSF+1cSSIV6IdsWpKjEWBykM7+KZm6
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 80564a2a-9462-4133-5c57-08dde9d17c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWUwbDdMZmRrcjdkMmNXNUNXRk1ueGdTMmhNVEw3M2l2Z3dWV1NVOEdmTkVz?=
 =?utf-8?B?NCtML0FpNnYxVExNc0pTdnFqcnNETjVBb0dKK1cxZWp3ZnFMWXM5YmIxcG1s?=
 =?utf-8?B?SVVXOEFISUpaTVRXMmRxRWxCeDdoZElYb3VrYmtJNDltVkl6SlpmVDNDemVu?=
 =?utf-8?B?YlJVYTBBSlIyejI3ODBqb1NLUTZUQW0xL2ZCaGU5YjBYMUNES0NJZ2p0SWo3?=
 =?utf-8?B?b3luTmw3cHZsMmxDeVZRczg1dlJOdXptdHpMWDNxNlZrZkJkdXNTQW5ac3Jl?=
 =?utf-8?B?ZGNXbnNKQkVGOTNFMXY1TVNsOTRJN1ZNZEs1TmthNmY0OG1mdHo4aks0ZXh2?=
 =?utf-8?B?NUlZSzVxWFFLbThneEIwQjJLK0N3bVlXTUNaTEZKZWhoSGg4RnRhSzdVODNX?=
 =?utf-8?B?UjJYWnRRR1RLcXIrbzV4M0p1MkNvbjgwcStXVHovK2xHVnBKZ21uUzNodW9G?=
 =?utf-8?B?aU1KS1k2MEkvQzJZc3pCOTFKSlphTkl6QkpzNHJEODJ4eXFmMnRGN1FDYlFw?=
 =?utf-8?B?dnRmZXVzWVZQbFN0eWMxMy9obFJGQUlZRkJ0akNzMkx6MFFDRzk1WjQ2Skp2?=
 =?utf-8?B?UStTUExPYjRYOXY5dWFEbjRLL254SWxmM1VxY045NmR6MThDVlV3bWZCZW1r?=
 =?utf-8?B?LzBJQWtCUjlFRFFCakZ2VjBaRENzckJXbHpIdlhMNmt5R3RUa2xMR1gzM2Er?=
 =?utf-8?B?Z1l2c1hJenVLd2FRYTY3VFlyL0J5ZWN0eUd0YzJ2R0NHZ1FKYW9qUG1hWU51?=
 =?utf-8?B?S2NuVVM2K0xNMm04YXV3MXRHdDRNbnFNeVlnQWN1bXNQOGsvWHZOL25PdHdT?=
 =?utf-8?B?WVBUaWlvN3RTTmozNXZzUFZLSjBOYTlqVWs5Zkc2bUhkVFZuL0duUUlYTXBI?=
 =?utf-8?B?V1RzRGtGZW5xcmNKdkFVZFc4RnFtbUNENGVXbm9WRDBwVFFJNW42dzFhNEEv?=
 =?utf-8?B?a2YvLzRIOEpLVDdVUlNHcDBnWmpHT1ZQRDRRT0x1RitnNUNBRlovcE5hYlY5?=
 =?utf-8?B?UVZ3NXA0WlUxdWJ5L1VsV09YRmpkdWVnUDFoNWsyd3ZOTXhuUlZYRDEzZ0Fx?=
 =?utf-8?B?dlQvTDZPTjl0R3hpTnlzUXZ5a3gwOTVuMEtLZk0yODdWMTBsaTEyNGlDUlZx?=
 =?utf-8?B?ZHkxWUY3a3hrOG1PQ3ljQzJOa0V1dDJyUlFsaXpEeGVySE1ReXhBUlN3SzJz?=
 =?utf-8?B?SnFJRkI0dVp4WGxzWlhweEJsdzdoU3JWOUNjYWJuRWdBOVJremY2c2xaT0xy?=
 =?utf-8?B?bjJ2WmlyMTRQUEo1OUNMZ0lKVDVXVDNHdUVUSk8vVHhLNVlDcWh6YjI5MUNK?=
 =?utf-8?B?T2txbDAyS201enNXeWVxY0N3MDJ5Q1FEV2RZc1VhRE8xMmltd3NXeGJtNWVM?=
 =?utf-8?B?Q3RoYUlWTGNUS1pwQ1g4eEROV0JIbHdUQmlReGhDSlNNS1BVREp4T0QvWlBZ?=
 =?utf-8?B?VWcxeGovYVFrWEdBbUFaQWlNSXNEOU1tUTllbmRGeVRQTVdRRkk4WDhJMVFo?=
 =?utf-8?B?akRiNGNDNXBJcUtHQWxVbU9IaVl2Wk1qWFQzQWVBWThsMGRSQkRDQ2NLSEZR?=
 =?utf-8?B?eFBUdzZycXVhOTcrMnl4d1gvUWp0OVlXa3p1cGlyaXMzMVpqdDhURHRORHl1?=
 =?utf-8?B?VFRuM2c0Sko5eVZWMFY4ZFA2L2pGRElieERRdUMvZkNhUUJNazRvVm9pSExV?=
 =?utf-8?B?YVI4Wk5WKzcxOUZjelNycHdydDZodlhsRnN5dVdlTWUxR2VIWkxzVkoxcEIw?=
 =?utf-8?B?M3B0TytnNWdJaUsycFFXSlVxd20zYUh5eVZKZWxUalNiZ3dkZ3VhZGxXYjg0?=
 =?utf-8?B?L2s3WjlGbW1YanhCVFpFQjRqL2xqbEd3U3duMDFiVlZ3RHVIbkNwc3RBYTN2?=
 =?utf-8?B?UDR4ZXdOR3Y3QWI1aitOQ3dObzRKNk5ZczZhb2tqR2JzTUM2NU1QVXdBeTZm?=
 =?utf-8?B?dERhdUZmOTVYNGMrSlByMWFPeGh4UUpUZGovbGxIYmM0RmdhTDExTU92QWRZ?=
 =?utf-8?Q?3WPRl3q5Cm/RhuSaEve/i5M2BIDGG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGs3QUJhSzRsbjVtVDFzSmN5MFZkcitxSGo4QllYLzUrQ3MxYmMvbFV5dGhW?=
 =?utf-8?B?M05pRkRaL0Z2cHFEVEx4R08vU2lQU3BsaVJOZHVPcW1WRTYrLzVHeDZhVjJH?=
 =?utf-8?B?L3h3UWNPaExLdGNsd3l3dms2S1NGS3Z4YUdUNjR0V2taNE5LakJZSFdEcUY3?=
 =?utf-8?B?OWpmcEo5RW9MK3FkamNXTVVDNVZZNysvRmE3UDZVOTdNc25ZNWVKSlI4QmRr?=
 =?utf-8?B?eFhPU1V1L0RrY0tVMm91WnhDc01MVTl5bnhoNzUrNHpMMGxlNVNRZVRVV1Qy?=
 =?utf-8?B?SWtGTkk1bVhFWlBHNFBaV0k1RGl0UUR4T1ZObVZUc0ZyNmVQRWZpaFBrZll6?=
 =?utf-8?B?c0N1MU82eTZpM1Y5QjNNKzJScnJOUU40Vk1ENXpSL2c1TzVNVFg4ZHNqT1A0?=
 =?utf-8?B?U3c2YTRwZGpBTVZUVzVGZDRaSy91REVEckJldXQzKys1WXNrZ3JaWERjM2Zj?=
 =?utf-8?B?UHVOdk9ldUd0UzJUaUdHTXNNWXF1MTNRQXlISjBCUUYvRzFXdkxTeDZwOGg2?=
 =?utf-8?B?VEFOKzIyak5GVlg2OXo0TE5GbGJ3Z0Z2azNGb1dMK3RxMndvRFBabVI5YVdY?=
 =?utf-8?B?eVBuc2dYNStCT1Zzdm1VREhUZ2R3YzMya25mL1RZOVErL1Z3UzhKYkdJelhU?=
 =?utf-8?B?VUVnaGloK3NoV0dBWnFtdEZBQW5Ya1hQdkR6ZkJnSTR6VkNnL200bmt0d2RH?=
 =?utf-8?B?VTM2M0s0QUVBZTMvR2ZQUFhZQWRiaXBXdGxBR1Z3MVdFb1NsZlpSeTZLc1Ji?=
 =?utf-8?B?cy90NHp4RmRyKzdVd0crWlR5Z0JLNzk3RzlwbWZpZEtSQ2NVanNaRWZSSElM?=
 =?utf-8?B?SVdxRVFldGJiTFVPSDk4cmdtT3lGdVRleTZYM0pGMVRTeGo4UFBTZTBlTHFn?=
 =?utf-8?B?aUl3QXdtN3Z3K1BTTlhTc3E0Tkw2SHhob2habFZHRStlSUxSSFlKQ28zaFds?=
 =?utf-8?B?czRkSXh0dmtBU0VndWNYNU1yVFRRenJRNUNIa1JnTVBZME5oK1A5QkwzSlpM?=
 =?utf-8?B?QWl3dmVIRnBBL2xpM0IyRzdYY1JaMUx6SE1KN0pBQlg1cTFKck9zeldPaDRF?=
 =?utf-8?B?dTZKb25uWEM0T01XZ3c5T0U3MVV3dHpFcEJqbHBaZzNOR2hMdlJEaGkxMCtK?=
 =?utf-8?B?b2IxcXcvRVUyL2R0aUlGL2RZbHlGTWkxYjREY1I0b2ZMM3pSc083azZkK2t6?=
 =?utf-8?B?cGZDVXh2Zk44RENEZExpb2lKalE1aFJSSTI5dE1sT1QrSDhSbG1kNEFJYVZD?=
 =?utf-8?B?S0ViVHpScURVaHQvRDY2Y0FnT3dxUnk0SDJDSTk3aFRMWkYzaEhGaktkZVlF?=
 =?utf-8?B?ZUhFRmIvV1JpUjVUQWp4QmJqSEovZkQ3TDBUM28xVUJYdUtpMnhSVTFoWHgy?=
 =?utf-8?B?KzF4ejA4QWRybjlsNDlpTWsxNnh0SG55MHl0dEJzRkJBb3k3MDV1bndlUlNx?=
 =?utf-8?B?SU5WbnI1QnhGQ2NsMTVEZElIKzlwTjNwenJFQ2RheStwdTVrd2VsRnZaNHJ6?=
 =?utf-8?B?Q0JFS2VtaGpDSUg2elh1aHRZTUgxUEFVczVzMG5hZWZKVWZYOEZqQnhLcysr?=
 =?utf-8?B?ZHVxQjhxK0Fmc3VRc09iOVA4TFVrZGpKTXZBSnRTMFJVZVlqK05Vd1pNNElv?=
 =?utf-8?B?MEVjTTVreTZaNkk1MVoyQ2grSGZ5Q0MzTFk2cXVBcXJEdDE5MmV3ZVdUTHQz?=
 =?utf-8?B?MWNMMVQ3M1BNa01oZzN5UEFiSWJERFNTWVdXUXhHem10VEpycEU4dHg4c0JJ?=
 =?utf-8?B?Tyt0WEMxeVVFcnd0cGNYNS91dTFWMVFEdk4yU0czVjZ3c1JHMXRUTDczcWJS?=
 =?utf-8?B?R0g5c1dRSmZLdzBDcmxKMHM4V01JTFBKZWxlendYblFjOFNnNDQ1ZmtVdWdE?=
 =?utf-8?B?SlE5VFNVVm1vUXY3WUQ4SW1HQmdxUmx4b3E0L29CVzRMNEpiMDViamFKbVFm?=
 =?utf-8?B?UEJpUHFJcXRGVEZPcTNsU0lkUjM0SmdSSjkvdFJnQjlhR0l1NktGbVdudERO?=
 =?utf-8?B?M0haNCt0L0k4R2NaazJ3QkFZTERVVmJmcUJ3UkVtZk5vRUVhekJsZHlzWWxJ?=
 =?utf-8?B?dEJULzJSZDA2WlBSaUFSWTJvLzJXekxSVU9nbTRodm53MjlHcExaNm5xSzU3?=
 =?utf-8?Q?v9a+zfTzqdfJC1NtN8Z3XWUid?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80564a2a-9462-4133-5c57-08dde9d17c44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:33:30.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cAqHvGbkWLd7e3DQ2UFOm8KgWjTZGoYtDKinrpsbIPYC44Za3tAif0kO0CgZX4DMBLfEfAE4dy6dHLTvW+u4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583

From: Xu Yang <xu.yang_2@nxp.com>

When add a platform device by calling ci_hdrc_add_device(), this device
will reuse OF node of its parent device. If power-domains property is
provided in the OF node, both two platform devices will be attached to
the same power domain. This should be unnecessary and may bring other
inconsistent behavior. For example, to support wakeup capability, these
two platform device need different power domain state. The parent device
need NOT power domain on for out-band interrupt, but the ci_hdrc device
need power domain on for in-band interrupt. The i.MX95 Soc support
out-band wakeup interrupt, the user need to enable wakeup for the parent
device, but if the user also enable wakeup for ci_hdrc device, the power
domain will keep at on state finally. To exclude such inconsistent
behavior and simplify the power management, detach power domain for ci_hdrc
platform device.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/chipidea/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 694b4a8e4e1d8583dcbf4a42f8c2dfd785d5745c..70597f40b9997a9766934c67bbbed38e96c210f8 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -915,6 +916,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	if (ret)
 		goto err;
 
+	dev_pm_domain_detach(&pdev->dev, false);
+
 	return pdev;
 
 err:

-- 
2.37.1


