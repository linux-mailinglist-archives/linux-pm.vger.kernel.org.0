Return-Path: <linux-pm+bounces-39452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D28B1CB8299
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 08:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C63B30084BC
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 07:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97004283FFB;
	Fri, 12 Dec 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nzWNRJuh"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700E255F52;
	Fri, 12 Dec 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525903; cv=fail; b=CLHbpewScso5tlA0KpIFOpoBG7HQ+WOe+MOYXsFpUuYktUlPH/Ut4W5KPx26iBpxyGn9c5G2taP64ddw5ws6O9Shp1HseuR3zkE+q/0qxGDyDeAfljqNqAGn5GGTCVafIpl7OWUjJ+FYbdgyU1BMYVK1gdAm7z0NLokoEvdgoXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525903; c=relaxed/simple;
	bh=V69xUWYApOv2Oodi2gXjxSr69oQTLHrWxu34BKKWmBw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ldr+sKwP1PnP4ZQXUqsiyPjF1vVZ5B/qlmg56TLdlvp7qZaI6tnGvVH+Ce7GMU7RXZfYInlQxy8gPBVJ7kOp4yfOGGvc88b1U2CdB1XfnI2lkFMfvAtIiHDD3hRms/TZ3upCBgVzaqN/ZSUfXPjEmlorg7z2bkh1Vd+NPRz7cYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nzWNRJuh; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIRwlP1PFn6AdtRTsAzaokwGR0ybwrRWlwMoZt5qLK4WO0Pf+AR7yWDH7S9l/n0NJkXSeJSH2k8Tx9jV/wU2mdMNrAVhztd312ezpyqlnLnqD0ttZ++TIv335bOuy2KhCLsg1RzfOMw6U64MHA/khLtE2dQt1h7XAlesGpbKTv8nkpvggpDnFKPGFnXMfGE4za3MDLZCbnlAlk6twKcztnEEux4ZNqaBFZJ/39LrMAlTPdC7BjeZblZ9RFN4cAXB9C4QFCMfULVZTFBt8kvQsjfR43t1EwLyCUm67ZU4ddRK/Gx9/hcKpzGiQ2yCfFV92+eHSqBtjITOFyAKJzMxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jefO/tfeZ40dNvcx8jtQzwalR2nqhV6bjkpIm/dKL6U=;
 b=D2nuLElbPbzYvKHa8KEQfp2JbyVleseU8hVGEw2++GaK40yk3qdAp30i2Zi4LXemnf9b/5AlZKYPXr2t4GxuMdS2wPdIbSlh3Co5druLz+khqJLNpRLcYURYDJnRTlKKO4qew558uEEQvinoL/uiwpSpEnYBq+034fxyj971UHfsKteMSeBHzHmRQoIGocLyHgJ/JM14h8dPcHyUOgpHSptcu8xvyqEb+oRB9DnA79QjIxUs5mvTTq6aLgt5Dg9sX9pKIvnNBXTDYgtDbFaaIpw0LVE14cU6CLmHjzhmPpdi+4j2ZfC5WcgTBNCQ+y/AGhLLsSwNQT0xMFCiY4pShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jefO/tfeZ40dNvcx8jtQzwalR2nqhV6bjkpIm/dKL6U=;
 b=nzWNRJuh4TepAIPJLe+X6sbd/Q9HhPQ9sxVIodeAQzuUl6S2PrMEBEvvo8YpU8cLRnkcKIlN7DmOJ9ZBK1QzsG6E2YMJg3OdkIFRxO92pimrkAuChAM8V7vrzKAKyAx1Z0r38dByRo2W181LVZCti8yaAwFja61l48XXVum+hNJtaVO5p2RZfFx75mSbLYLeuZ89v/OdGnWxZj8QmoGgbz/JqMNdntQKy7nneI0LvjfhsSAlfPe+gFDcspXsSCBtBsP+i6kRLEwIuLYwJkxW3hYDqqGTzdvbKY4MlwGDccnOvWFCuhoYPvbv00NQv3RkEH1OlxVqIiMEDQHOLsTbng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10608.eurprd04.prod.outlook.com (2603:10a6:150:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 07:51:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Fri, 12 Dec 2025
 07:51:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] thermal/drivers/imx91: minor updates
Date: Fri, 12 Dec 2025 15:51:13 +0800
Message-Id: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHJO2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0ND3czcCktD3ZKM1KLcxBzdRIMUQwtTUwtzYxNLJaCegqLUtMwKsHn
 RsbW1AOXuFKtfAAAA
X-Change-ID: 20251211-imx91-thermal-a0d185587349
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10608:EE_
X-MS-Office365-Filtering-Correlation-Id: f13254a9-d9e1-4112-6b06-08de3953469c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0VMd0lMZFd1OUZmMSswa2o4dnY2UTNpSU5aSjh5ZmhWbmI4dy9nZ1FONHpq?=
 =?utf-8?B?a3haOFE5RHVCSUxPU05ZZ2Z4Ly9ZRE0rb01wVFh6UlF3dXlpVC93MjVFZ1dR?=
 =?utf-8?B?dHZsNjRnK09XSldWbVZBMTRZRHdEREtsOVNTR0xCRmVsbTJaUS9FK2J6d0dJ?=
 =?utf-8?B?WmVtd001aWxuaWdySVd3eHd5dXNra0dZZUpWd3VDZVRzMVZyZURLdmVGbXNK?=
 =?utf-8?B?UHlhZ0tWNEE0Qm9FcXF6ZWErMWIwL2V5R3lSbXNKMzNXWGFDZkZ3b2NHOUNT?=
 =?utf-8?B?OU9TQnBLODJBUVpQNFdBNzRZNjJQbFRuZDlZQ21NQURRdzUzT0p0bkU4ZEc3?=
 =?utf-8?B?Mng2Tm8zOW0zakNMd2UwWlZqclYrMDUzL2s4cjRCVHJKb0JqcHd1Tkc1OWIw?=
 =?utf-8?B?dllFbER6SVl2dWUzRFBTMytRSlhldktGazZMdU5BVm9wcjlWdnZMbU1VcWEz?=
 =?utf-8?B?VVNINmtTdUhoQ2tGMFdGYkw5RjFjZVNBQlZoTDFxNWFxWXNwaGwwTEd1eGlI?=
 =?utf-8?B?TFFoM1lmV3BjUGl5bVpDNFlPSjVqeCtVN1gxZ240YklqRUwvQUlCUCttc1cw?=
 =?utf-8?B?Uy9kNG1pYnVPUllPaDkrZHBGaVZUdkVPL2pTdGpaSnpJMmNlRytBMlU1T0F5?=
 =?utf-8?B?UnB1WmEzSkdMWTFqanlLRGZiVmF2VUlPTW9TV2VpdlFKSXY0RGgrY3VpZ29I?=
 =?utf-8?B?QmRFTXJvbkNseVF6RFpTTHUvRUQ3d0dnVDcwbDBDMEIxSkhVeWlRZlpQNGxQ?=
 =?utf-8?B?VUNYWnRlWGZEZlBRSTlFeWhtNHRTdElxY25ROHdkNlc4Z2V2Rm1kMU1uaVZ4?=
 =?utf-8?B?dG1aY1V2VFpPRDJ1ZXNuNlp1eFZodlJOVHNxRi9QVTNEUW1DOVQzWTJHUVov?=
 =?utf-8?B?U3BYVzFXMktaUkQ5L0tZY2Y3ZjErYWVtZTBaeXhIaVJMMXF5UzNNa25xL0V4?=
 =?utf-8?B?WnRvZGltbUpBNkc3ZWVSS1VaMmZzVm90RnFyVFY1dnd6b25QUzRvSStIRDBi?=
 =?utf-8?B?VFFmRXR6b2lKcEJzaEF2STJ6bmUvYTV5OFYxTEZJRnVzWFBpZ3ZYOFRSb1U3?=
 =?utf-8?B?eXU2aXRwR1NTV0VZK1J4Zk5WTklteGVvTUQzeFpNWXBac0g2c3lqc3ZXNVla?=
 =?utf-8?B?WkJOaW9zQTI0cHpMbGxTdHdHQlV6WEdFbTdxY1Q4N05vSysrUE14d3JFTVhj?=
 =?utf-8?B?NlZLdEROaGdOcVpMbysyUFk2alZXd0dBNTdkbk50Tnl5NW5mR2FSTTI0MU1S?=
 =?utf-8?B?Q1BlQzNrTjIrNUI1TjI2ZlNmd0xxWWlmTm5nZHBmYXoyMzVYd1hvSUJlcTJ5?=
 =?utf-8?B?UUUrTDlJbFFZV1dDNXZzeGtkNEdoRGp0enBKUlBXbDhrLy9yNVA0Sm54VzVN?=
 =?utf-8?B?eHZKNDRFVU1QVlBkLzFBZDM5S2lySWorM1A3TjA4dk1qZU9GeG51bHNPenNv?=
 =?utf-8?B?ZWkrbEtIU0dRMWlDWXZxTUM4RG03bG92S0ovNUZoVmsxaVVVTFhBNHdMZE5v?=
 =?utf-8?B?ZlloNlpTdG84dERuSDY4SWhSb1YrRlIwNkVqYTJwSUhRS1NKTHJDbjZoSWJI?=
 =?utf-8?B?NWdjK1EwQm9IMzMwNkpJRTN0TW9LYkczUDZKSmNhZG9PZlRoODIwbGFSZnVN?=
 =?utf-8?B?cHZiSGRPSkd0bGF6VTR4UjlpWldmSDlDZVFpRGl3dVBVdnpIaTVNMUJDeHNu?=
 =?utf-8?B?UUIrMjNJWERSVzREb09nOUVyTXZBdU9KUmtBT1A2RVA5ZDh0UkF1aW9KMkdS?=
 =?utf-8?B?MDNwbGFZZWNkeU5JbEo4d2RMZmZpd1ViSzkyRjdLN0dwZ2VaaURLUURoNGRx?=
 =?utf-8?B?OHA0S1NtWVp5Zm5FTS95SXlWRFBlWE5IWDkyTy9SOWtJa3V3dXUzT1hqVFFH?=
 =?utf-8?B?cDRIUHdSVDl4MmlrRU9pdS9RWjk2UmFNSDN2WUYxOFBzeUxIYnZtSDJPUmJP?=
 =?utf-8?B?T3B4eTA0ZFV4NExwTFNhWmlTY0FabS9FTFN0dUVMalprL2hGc2t1ZHJ4c0NQ?=
 =?utf-8?B?bmljNDVTdmI2ZkgwbFhjZis1Z0t3ZnZPQkNGYnhTUUpmaGUrWThpbVIzaHpB?=
 =?utf-8?Q?c99pnT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2NXM0tqT0JhK3cycWdJVmg1dFhGUUFIc0twbjNXNVZ3eEhlWXdMRUZmZUZE?=
 =?utf-8?B?Nkxld3VhdUtKU0lLNmkwWGlsOVJwTU9YMWcyUUx0TDd6TnErODlRQlBUdGll?=
 =?utf-8?B?SjlIUlVYTmhpSGx4ekNDd3NCT0F4cTBtemFzNGpMalN5Z0lZTllKWk9BS1pj?=
 =?utf-8?B?N1ErRUJyRTJuVm4yQUswRWxXUXhYR2M1QjJDSnVtQVJ2MFJXQnI3aDVOM0Qv?=
 =?utf-8?B?S2VHRjQ2aEh4UnlmdHFGWXlzbmNqaDYxaTQ1aDNrQnhOYTI4WkhzT1d2QUZz?=
 =?utf-8?B?SytxMW1PVnRSUk8vNWZ2NWZkdGFHajdab3QxRERteklNZFZIT2hLVG5aelJ3?=
 =?utf-8?B?Y29GUHZSdWo1bWlhQU9UdFVYb0Z1a1k1MzdMVTVVcnFUVytRdXZPOGZDaGNt?=
 =?utf-8?B?ZTQ0TUR1V2dqckFuNkZ0eGZ6bG5wNGMyRFNVOXZHQ1FmemxZWkNmTzFRLy83?=
 =?utf-8?B?UG85czJNVDVVQTRSa1JSTm5ZZGdZWldRS2pLQlI2ODRlWXQrSGlubk02Qisr?=
 =?utf-8?B?Y0UxWm96WUdFNERpVEhxMTVxeDFqUUs1ZEJwZlQvUFdkMGNlWm5CUXpPNjMz?=
 =?utf-8?B?MXRvRUdrOHFDK0hsTEJiRStDQ2pTT282bTAzbGlQazRlOTZIWG1BWEZVSFlT?=
 =?utf-8?B?TkZwSVkrMjVqTGVRZTVzTVFCbkJrak9HbFV3QTVWUElSRUpSM1lxMWpsYnI2?=
 =?utf-8?B?cG8zNy81azRMWUE1dUlXNEpFaGhnQTVYVzV6eUlQYm5WbUI2RDdMNUI0ZUc2?=
 =?utf-8?B?NEREZWlGV1h6emF5cDA3Q3A5c29xUGt5dlRSWVk0Ti9Cb3lKdTJnL21YakVk?=
 =?utf-8?B?djBFUjNaMVcwZTdCUnBGVksvejN6YjA5Z0NvaXRKUFZQTUR5VUxSaFVtem1x?=
 =?utf-8?B?aTVNOUEzUkFOaUh3ekIzdDV1aE0vOXh2OVZLN1VrMlU0TGZHT2VocU1TTUZJ?=
 =?utf-8?B?TnZEdHdWN1Fpd2t3SkFvVUsxNUJnVnlEb2hBOHdCcUI1L1B4Yyt6SkdiUEF1?=
 =?utf-8?B?UWJQaVBGcEVvTVcxQTl6RXZrclBWNXRlbit6aS8yeTlaeWhOV2xmd3M5RE5N?=
 =?utf-8?B?ZGNaa3FWbW9qQ3RIYWVvRTdtbG5Hd25MbkxzRDVrdUZPZEIraXhiRkpDWjJO?=
 =?utf-8?B?S0tNVlg5SUV4NlFUenFMT2FxM0ttU2M1c3BQOHZBNXREQkV5WkNVWW9Vb1Ni?=
 =?utf-8?B?UlhCZmI5U29nc1BhWkR5ZWZzb0VrUC9ZN1VNY0l1ZHljQzlic29NWC9obmtq?=
 =?utf-8?B?bDZBK3FJSWViOVFzZGxVeG96STZ2VEhZaFExakpSQjNMZnRsREdidXNyS1Vo?=
 =?utf-8?B?cGhnYWQrUlNuLzNGTVJ5VUZSWUlscU1NZTFrK1k1MTRrZTZlSWZDYkJoUXNU?=
 =?utf-8?B?S2Jab1A3T2hCUUsxd2FUNDFNMGI5WDRmVlFaWGhLbTV6dGZxWWFFRXNzWVRC?=
 =?utf-8?B?YTdWQ2VLTTJNakFqYkRVY004TXkyeXY4Rm5xUjlpelJiejdTNTdyZEU5Mm1T?=
 =?utf-8?B?SmhjOWhVdXpWQVFDZ1NkOVQxSXp4Z3FkTmxEZEdRbVBRRXprNWQ4eHRqQ0hu?=
 =?utf-8?B?RlpyY1RZT2xNQkg0QlF3TnZPSGliZ1R4K2U0NkV6dVdRQ1lWU25uZ0VVUzdB?=
 =?utf-8?B?dUk5cmFWUEk2QmVqSnQ0WTlCcjl3cG8zaWI3ZXBrNDJtTDY4alpERGh0d2Fs?=
 =?utf-8?B?eGM2RWUxWHZlY2JxdW5WU0xLQ3h2UzdqSWpXNFBWYzVZeHJwYXZSWWk4RFk5?=
 =?utf-8?B?WHU2NjlLQXh4ZUFTc0pkUkZvRldhZ2RaRVF1Z094RW00eld5Lzdmbm9IOXJJ?=
 =?utf-8?B?WDlCeDJoM2RxS1IrMWtSMDFiNnp6dGNEOXJvdU9MbHBzNGRINWVDS1RjbDNO?=
 =?utf-8?B?cHd4alBia3dRcmRjNUpXZGVINVZKSHVUdkFuUnk1M01vanlVUm1nVURxZmlH?=
 =?utf-8?B?cXdGejd1ODJ4L2VRUHI3KzkzczNqdVc3S1BkSFM3R1lVMml2ODhaRWgyZFdZ?=
 =?utf-8?B?dHk0RmRLbWdWOVJ5MEZvSElGOGNhajlUTEZqbHZORWx4VUVMekcveXVBU2Jr?=
 =?utf-8?B?MmhFalVFaFhSM1lMMzhKNEtRWkJ4REdsdVFEaUxwb1JxYVR3dWRyK0FrZjly?=
 =?utf-8?Q?FYIYW2fDdq6xdptieooEkizKj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13254a9-d9e1-4112-6b06-08de3953469c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:51:36.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b35ZJy8sbnY/CaL1YSc7eM5M653BqEDHHsnyNcozpSyipqrmyh0JwWofQt91OC3vDkkq5PwGAwIW06T9f/W+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10608

patch 1: wait status ready before reading data
patch 2 and 3: minor cleanup

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      thermal/drivers/imx91: Check status before reading data
      thermal/drivers/imx91: Drop extra spaces
      thermal/drivers/imx91: Drop macro for continues mode

 drivers/thermal/imx91_thermal.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)
---
base-commit: 008d3547aae5bc86fac3eda317489169c3fda112
change-id: 20251211-imx91-thermal-a0d185587349

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


