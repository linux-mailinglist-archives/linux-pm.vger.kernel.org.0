Return-Path: <linux-pm+bounces-32770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A9B2EE2A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4317A7214F4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A32276038;
	Thu, 21 Aug 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NeUI6UWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15469272E46;
	Thu, 21 Aug 2025 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757469; cv=fail; b=KaOG4Uhng8Q2N6b8svjbGMkm9q4ttUvWpcN66FOQcZc9oGdETAu1rXIDFVFlsTMKyVKy9HLl1PeXhF4fBb3xItmP19ko8G1KnPKJodH1XWMsobuqnQp8eW9agps7bN3Jhu0Mn51Ml8Eo5lD7exdPF4LAD9SX3lVKT7k2Ymk1FIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757469; c=relaxed/simple;
	bh=2795Zyls3A4GhqojqhONv9tY6tgebZb3oIjpfi38MGo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jzVNDDkbPsu3iPv9KUil1ZPGYTLWb1QixgbwUR1rA0jL9bO6iiHwtklcyIh9JQXJ5Bts2F5/N3YS1nCbV1R6rPl9unOnO3LuNj11hZeUtAWi0KQEGSHfo5YBNHoav8KZ6XWW7s0+KG7cB2juhP0+bGni7KNp+YOS2uwDsWdBHz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NeUI6UWM; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBsrRQFDK07dfE/QSYT7PO6UrFgtIv4laLC96ZunAh3nf5HBSCbYB6LxM/o2PO+2aw9bXzbAMvPGpKsA2p39h3JYxkVzaF1FZyRa1neRlz10PGiZ1ZzpSvZaXRew8vxqn7Rwmsjy1G+nRNk+PjQunkIpuOdlSsPpgrVzdplEx0QNSlmZ9QnVlsD2UGaM7zwC6OUhtET8ucieuO9IxwC+InnitrtiaumCQ9XEM4ogCmZsoybi96Q/xabLQbGIPf0RMO5TKrQHe0ctc9vWtFT9EDsYlioBA/LN0j8qnp0tWOiDF1jTstMQbsME3fF23sqyZohELWu2YLhcq2eECVmljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K87VwlB/yD6dY3espVQEPWhwlEC7yGaxLPYXeTkomAU=;
 b=Qxn/JCQ50wm21XDiyQoqCkeYnOfnLx5LznUEzQSFGSikW71CXvG6mP74x04/Zg6qhDqjMDh3rMYAhCRp/EZU1n77u14kkLcsT26f6oO9n6CECQjrpwo4XXJ9pCxWEePQ4Q3K4ZoVsT6EFjewqy+kKtZpErBABPQ4ab+8Eymf7qu9a9cV3jTlcYkP9zwFZSdFgkqso9ELpvJGO7jbmlMWzb+yMdgcXR1D2OeLKN33Jvq0hjVZn9AqGZdqklLmNAEKqEE6gLgHxdV2OGoraLnNQuJToUQFLtGDYtfmEl55wulH1N/bveFfG7cnCWKsynE7VjHYU6AJuVrPkQQWDl5kaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K87VwlB/yD6dY3espVQEPWhwlEC7yGaxLPYXeTkomAU=;
 b=NeUI6UWMCHMfIQFHkn3bBsCk96n/OCmsTAfeGNvhVOLpWilDnT73lYJnGcxc8FnQOEYiPjz0lM4RINFS9Ta0NmxRH7ToLEVNBw9JLh/HvmNNX2rAPLu7tYj0jv72xbjKTlLsa7KBG4e6/f8iIzpdYBrKYKT3qn2DD3TU4p+3TpNtavYqjAvZ6yvbn5/gwQq00ziIgJmjYd/ZvM4NhLdb67m5qW0m4VitLgTyPVXt+fRVWQRpKl26yQJfgGKX50AsEuEUQaN+lhPLBvU8vQs2ra0qClZcr3v9LboBD7CAPhxH1vD1v30j8MYeuCRfdToe+uvh5kdSdd+LKafwuMhNyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 06:24:25 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:24:25 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Thu, 21 Aug 2025 14:23:52 +0800
Subject: [PATCH v4 4/4] arm64: dts: imx93: update the tmu compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx93_tmu-v4-4-6cf5688bf016@nxp.com>
References: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
In-Reply-To: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755757438; l=1050;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=2795Zyls3A4GhqojqhONv9tY6tgebZb3oIjpfi38MGo=;
 b=zk3j427JKtHMLOkm6mjoKT0I647E4nBtz1Xh60azKg8i7saJNpQGUvn0aficqNYl5OByruGqO
 Nnxym5XSIteBJmTyWkai+AVaJFQ/1N1KHc7uIQLH1UTS3+s5y+FHhdE
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d01010-4c8d-4f9a-2f46-08dde07b5f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU5tOG56eFZPRWNIZXhjM1BHYXhiVEdUWjVHNkI0UlVSZUl0VkVIVXVORExq?=
 =?utf-8?B?WkM1Mks5ZWI1RENQWGw1OHExR1Z2WmFram9HT1lTbnV2RXpPREV3QWlzR2dt?=
 =?utf-8?B?RXpCQlEyWG9naXdPWS93c3o2NWRpTGd4NTkvWFNINnVlM0w3SDRVanB1WEFS?=
 =?utf-8?B?SVVkRTZWWE5FM0lqR2dBS0x3SGpuYnRub2kyRGdmMGxMbmpCaDJZSFdiRTNT?=
 =?utf-8?B?Z2loMzBRMW41QjRKS2JnZGRJdDc3eXg4cW5vUDBmaWZiMHJLQ1dTUDdTNEMw?=
 =?utf-8?B?STVyK21UTmdYMTNJQW4yRUNCUGRhMlJpemFzK3pyUU4rb0pqS2FDc29LUFMz?=
 =?utf-8?B?Tk9iSkxnRkwyNVhQem45MytXYVhSN3pCVkxRK1c3UzI0MEViQi82TFZsMDZV?=
 =?utf-8?B?R2NMNFZ6U3F2Rk9rMEJMQ3I0RW03amhXRFRHNUwvUnFwWlBocXBKTlA4d2d4?=
 =?utf-8?B?Vyt4Y2JCdnhXb21tUlowTzhhMCtzSWhkdEdhZjc0c3FBdzQydnJkL3dJQVZW?=
 =?utf-8?B?SzYzSFhJTkZmMllpd2NVcy9JQno3T1kzaGZjMWlUSmhuaVpKM2RZNlBjVkxo?=
 =?utf-8?B?Q3oyUzl4eFUvODVnYUt0SlpzRVZKZUJ6Y24xVkM4Vzh5L1J2TVhWNWlJbXln?=
 =?utf-8?B?Y2lRMTdUUndrNm9VUi9wSU9FdjlpNFgyY1hjT1NhRjBRdk4yMGdVNDVuOHFS?=
 =?utf-8?B?b2NHa1ExdDJ4TFI4MHNuUEJGOWs5STJmQUx3Y1FQSmlTK3RDWWhER2ZIZzlM?=
 =?utf-8?B?dEJrb1BGbWpCeHU1NmIrbTRwTkIxaUx5MitwazhHb2xWRk02Mnd2TkRrdWZz?=
 =?utf-8?B?MzBIQUhSbjE1a1U2N00vaGtwUW9FSjJmT3hXRmt3cHBCQjQrR0dZUzJ2Z0p4?=
 =?utf-8?B?dHdndENjMit6NUpXTkQvZXo4MVhBR2NLVDluQVMwdHZzM2JUb0F5RkNmM3lp?=
 =?utf-8?B?aTlNTTErY3A1d1A3ZGFCOGhSMXVncjh2ZVNqUWJtaDVnL2lEeHFxOXRjenF1?=
 =?utf-8?B?NWc3RTAvMitWSVZuQTFnU1phZ0VLUlF4a1RzdHIrRTF1bTZxSnRIMUVJVW5C?=
 =?utf-8?B?YUg2QXltVkRzWmN4TlBrbE0zUERpQUI0bWFEZXZGUFI2ejN5eVd6T1FyWlh5?=
 =?utf-8?B?bDNPeTJRcjVMeWNNc2pOeVFMRmhtS2FJb0U0MDRzOVA3cGF1UUthNDJRc2R6?=
 =?utf-8?B?eE10VVF6dTk1Q2FtNTlSL2RxY3dZRGJEc3pPUlZaTTV0SDhXdzlvZDFPRVpN?=
 =?utf-8?B?NlkzRllldlRDekpxR1cyKzdBOHlKdW5WYkVkMkxyb0hmNUZtYzN3Qnk0K2Jk?=
 =?utf-8?B?UTRkbVh0NjBLYTYrK2NpSitON3J4NmRRTmdCQmJkUElxeXVYSnFOUExiMkFW?=
 =?utf-8?B?U201ZW1mWG5ueGZKRFNBbHBpMWhOTjdVOGlpaWNJcjZ2K2t3QWo4eW5CK1BX?=
 =?utf-8?B?OVFVMUprUFJEcXRhYzlCNzBLREsvRk84QlE1NjVhbHczVExzUEVUdTJBZVky?=
 =?utf-8?B?bFkyMVJMRnMrR2hFdjNQYmNTZXhqQklXWXZUaDZIY1lVSWExVDlWWWVrVzI3?=
 =?utf-8?B?VGRoQVRSMWFJZmF2TjhVTXZiOTZTN3lnbGdqd3VvcWdGU01ORHl2dlNLMnBF?=
 =?utf-8?B?Ui94eC9TMDN6T2lzS1gxd2d5bkN2QmZwZmVVeGlYTWhMUzFyaXNOZ0FHck4w?=
 =?utf-8?B?K2doYzRnaGxzYkw0UTNPck55Mk5kcVFsMHA5T1QxdC84TUMxNU4zOGxXcXA1?=
 =?utf-8?B?c3FSVmtrdHFxUlFra3hPWXd1WkZrR0JIUGJDNllFaUx5QlNnUDh5a1k3WGtG?=
 =?utf-8?B?MGJkRm90ZEFkSng2dHR5eXp6VVdZMjJiL1VrL1lvYXpkMEV5bkpscElIYnJM?=
 =?utf-8?B?UGFzOVJPRGwyR2lvMkNSV01FcXZjWU8xSFVTcTUyT1FDWS9ZZzFJZTA0YWJ5?=
 =?utf-8?B?bUx6SkM0SUxXT0RWN1JvbFExLysrRGhKZWlaTTZNZllaQTRFSnR2cTFBcldq?=
 =?utf-8?Q?h5PtPW55twlbjurXY+RxFzQsFz25CA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW9sY3lBMHFmc1VhY3NiU25JT0RxZXorVW15UGlWakc3V0lDa3YwczgvL082?=
 =?utf-8?B?cW5GbFBSdmFKM3dVeStUTUtTYjV6eWlUUXhkV2tLV0xOR3NWaTJwa2RodU1S?=
 =?utf-8?B?QlJTZHVLOG1IRjJYNXRCWjFrL282YjRzZlo4am8vK3JmMVBHdnE3clVjZlha?=
 =?utf-8?B?aFFmOTFSMXhBWElXVXFNOTRQc2tNN202UHB6VytBdmkxM05UbXNXUnN5Z21N?=
 =?utf-8?B?dFhCV2RlOEVWU2JEL0VHcTVwOU53M05jd0hETDV2SEs5czBLNUo0ZWw2Ukw4?=
 =?utf-8?B?cEh4VnBFM2MvMGtHN1BDWlZnSjYvVldEcElmTGpaTE9MNUJnUVI5b0RnLzNy?=
 =?utf-8?B?VERJRHplaE1SRG0vWVlFYS9lbnhYYmdaVm4xdzlzWkZEV0kraFR6RmtaRE9l?=
 =?utf-8?B?d1dLWnkvbVFIM1VnNDFXR2lTMjc2emdHcW1qTXYyWG9rQ3lvSGd5NkJnTGNq?=
 =?utf-8?B?aUxNUnduQkZ6OFRoQTZHUGh5MFE0Sk44NHpHblppbVY4V3R2ZjJ3OUtSd3VX?=
 =?utf-8?B?REpUOGdPSURVeVJqaExvV0lheEh2NG5ucVBCdk5qQ3ZuaHN3UWxPZ1BOYXh6?=
 =?utf-8?B?SVFEaGRMeldDVUdIdCs0SnQxandiZlFCSTJhUmYyMWtGb0Nuam5nUCtZblRj?=
 =?utf-8?B?SWNjbVJBdDdySDVDQTFSd2hOKzZZN3J2bThsaTRqNkxNanVkY3lIYW9rQTFB?=
 =?utf-8?B?Rk5jaG5ieDVGR01iRld2V1RiTGU2SmNlOUY3QU5iUldPWGtoYzE3ODRHMUYz?=
 =?utf-8?B?a3BrMjlDeDhtNnZzRkl1THYyVUhFd0ZKbWVPNVFJbm8wN2RUbkZzOU1OMnpq?=
 =?utf-8?B?TDhmVWxpaHAvY2RpbzlhZ1JKU0ZoZVdLZkhENnljWG0xVkJrYVFJdSs1dTM1?=
 =?utf-8?B?M2Y1UGs5UCtuWERuN3RpSldrc29wV1J3cDBzTUNsQlY1akx5UytyUU9XY292?=
 =?utf-8?B?ZTAyQzNtcC8wd0lSY2Z4YkhTSmpmR0VBaStMQTRFaExGbFZEZWdBTERXbmVV?=
 =?utf-8?B?WE1saWV3Ty9oL1J4eUJmNitadHJHMFJQTWt4STc1Y0dELzdCemwzejZSK3Nu?=
 =?utf-8?B?Zzl2NU9HVVRYNXVpQjg0U3VPWjhCanEyQzBlTUFuRW1PZ3NwSk9jb0FONEo0?=
 =?utf-8?B?QlFOaUJJSTRVc2lUMEtaYXNBK2dZTG9kd3V0d0gwWVhQaGRLbmZYUDRwWkhn?=
 =?utf-8?B?SVV0aEVWbkpManNvK2RBa0xPMDZkQjM3MkdoazBMVCtXSlFpVVNOaWZFU3Jh?=
 =?utf-8?B?ZWF5elo0Z08vbzJ2QkFHdDRudWpMQXliSXJlWGczbTVVeHNYTmtuSXE5cXla?=
 =?utf-8?B?NWplMENRbG9HZmhQbWpVUjZXZElxaEJDSEl0V2F6K0kxeVgya2x2S1dWL2xC?=
 =?utf-8?B?NExBZFl4YUNGSlRZWTA2all3MVFJZkRQQ2dmb04xNHQ0b2FMS1BsWlhrVDlu?=
 =?utf-8?B?T05xazFWRk4yaVptS1hGazdjWUhxUUNqRG1XU1VzaUpxbThNL1RvYjVIaFZ5?=
 =?utf-8?B?Z1BXMWVXaktpOWRBL2E4NUdRWXh1UEpDOXAzNktoOERTdk1senFDNUsxdmRO?=
 =?utf-8?B?bHl5ZlV2aEEyTnAra1M2T2tPMnNDWDEvS3owbklSMFBWekx1eU9HTUZMdXRp?=
 =?utf-8?B?NGdaVFBpWEVFNlV1RmxYL1ZDbUQwamhWMUVpOG9oL0tOT08yb0V5M3EyOElC?=
 =?utf-8?B?SHBvSXpmdzQwZUUxZTM5RjdIanZpQ0lRanh3d3RYM2RHbXI2Tm5EVENyK2VB?=
 =?utf-8?B?MzdpemtEaHAwTFRuaGtveUJuU0lZQlZCSk5JOVYyeUI4YUxXanFjaHRhTzM5?=
 =?utf-8?B?b25jaFdCcHVkUXBMb09mRXNCL2Mrc1dybXNtRGIyQzJlaFdqV3FuYjhPOHYz?=
 =?utf-8?B?c2t0UHpRS3RwS205blE4cS82ZWsxalI4a21Xcm9QSUl5c2lZeW1neGpQaHBZ?=
 =?utf-8?B?MWxEa2lPVVAvblc5MzJZZUFvZklua0htZS8rb1ZwWHRBQmZDM01TVTVPL0hw?=
 =?utf-8?B?M3gyZnpFRHA2Sk84Qi96RmdjK2lLV3JGWE5EOEFYNXNyV2x5UitIYmEwZldD?=
 =?utf-8?B?RSt5andCMFVWb3JiT3lXUkJTQ0k3Rm10U2s1aENBbDdDejJzTHM4RHlCT0cr?=
 =?utf-8?Q?abDVOhvy8MEpi15dB+UkxdFfu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d01010-4c8d-4f9a-2f46-08dde07b5f46
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:24:25.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biFBTCJ2X+VYCbmWyKsnGJisBf5BBzX8bbl9LosYrqzh6+a8rIaA/ENrTa/HqPWAw1NEBzADmjHU+eK0f19VTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

The i.MX93 TMU node compatible need to be updated to apply the SoC
specific configuration and TMU errata workaround.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v4 changes:
  - no

 - v3 changes:
  - drop the qoriq compatible

 - v2 changes:
  - no
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8a7f1cd76c766ab558acf5176022a4c42e648548..8ae9a81678bd37f394b437f1dd6ebe67cd1ce439 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -544,7 +544,7 @@ clock-controller@44480000 {
 			};
 
 			tmu: tmu@44482000 {
-				compatible = "fsl,qoriq-tmu";
+				compatible = "fsl,imx93-tmu";
 				reg = <0x44482000 0x1000>;
 				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_TMC_GATE>;

-- 
2.34.1


