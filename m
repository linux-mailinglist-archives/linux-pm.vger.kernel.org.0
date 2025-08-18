Return-Path: <linux-pm+bounces-32521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C904B29E18
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EDF1965851
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FC830E0F4;
	Mon, 18 Aug 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BOH+Wr3C"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974D304BDD;
	Mon, 18 Aug 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509632; cv=fail; b=oeoEqYTWLwpg3+KkT1CLHUK80wsRBLvBQJwAjwE2A40SIxEtf8zMpc1NLde0ZQJTTmHuVdDDsou1noUItyzaMh+ar27KFQvw6UXFxnGHcD0RSMGY5VWRUFirTdA10tVniLN4Jgn6Y6ApMfOnATq3C0bB8a6QBaicrxO3hfP2nzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509632; c=relaxed/simple;
	bh=7wtUIlrgz81OYl3GWUicAJJkB4gpn7oh17tS7CpVPQs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TY0lnvQf/XVtvh1Ki01gqbuGa04ElrZMJWWJWwCCyKjhs0f36Bl6IJAZMG1wVUpq/w2Ac9X2rqVBkVOn6W19OTLMG2JHak7P/ZoCZJR5DzaYiJegcChpKZl//Ml2nKCuIF3v3zmudjZfNbhU7uHJqTSsrK6EnwkuoejyAQxnJHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BOH+Wr3C; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrckQy91/pr6IXwAugT1vHxPtPF4Ms4m+BXCFA1N/CwrED1R5DLTXLdeg64Mrf96q7h1+Bj1EPG0D0N8XpwWxVpZTQe5+EWc951SIZibswJfc8OD2FzUm8YLEfobNQj/3Cz5vy0TT7IPBAsyFdEInyWvPMdXLQvwx3zKL/UXtc1waBJVEP72Tivmb64kEW7yYvIP4h9z65hv1TP2LWaOdk612w5uG6knrxACwxzROlQouGLQXL/onZxnUCiEYj61Xr9sHcTj9N2mkfhUYvWolPh2CCYuNVGC8iPLmBQH2Up7Tsqk0Nq4LoIfNoqoAQDn06Gbqyge2a1QJHIw1qmBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tavNQ3jxr/Awx0Uqg72ou9jfFxjB67Hh4NFdaw68a38=;
 b=jhudMtdX7mQE0Iz9CZUo7HU0BnBKSK3t0bQDjeqzKykQFuMOdAXBElB0CCDtTx+sw+DZfiLM/KIDcZSlu84itooos7sNTalW1xaAnqpSxtqgH1l/pAvlYORAPAo2pLrtZFTUDTbNs/NJ1HjVCBvyCJ7JtJiZ4+KEzjzHM7/M/bBAci9+ratIfDMOJXTZQukO44jAT1oRx0KURXDDNLzumqlytbyzzaaH0dtBgwqZENjtb9X5dkJujj9RKQzKssINS8XrigSwaFrq5BnuPKytpnaHlIgvg3tfL6TMMqtpPGcPDddwyyX53OOfDRG45KpAkGz5z1MfIMK1RiPU6Ok3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tavNQ3jxr/Awx0Uqg72ou9jfFxjB67Hh4NFdaw68a38=;
 b=BOH+Wr3CaV+QuHO3i+jmNtKrO8C+eud5jcL2OnhfXzywoB5k3PTUKUXYgiIuwXvXn7YP9/YohaMCjhMfU4qncABVx8VqRxhBa/wViYrgPKGjOJ/q1YDPtnjIwF+YxbOFew99owCm4Pui6KMqulo0zmWR64J4cEZqKkZ+y/q6pmxpnnwREXQdXWc6Qu6kHMY2ccq7JouBWNdy9TNtQtt4Bx22B+ue2cD46PvMl3vYCX65MMiaUUAn2RGEwLEQGf2Do2jZLdNCWkRDahvr10yi/GRGx+4MHc1vpzYW1+ffyp8L6edAHFY2YWCE3XPCi0cKWno9/FJtqDbeaUoWY2atAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.9; Mon, 18 Aug
 2025 09:33:47 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 09:33:47 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Mon, 18 Aug 2025 17:33:14 +0800
Subject: [PATCH v3 4/4] arm64: dts: imx93: update the tmu compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx93_tmu-v3-4-35f79a86c072@nxp.com>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
In-Reply-To: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509601; l=982;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=7wtUIlrgz81OYl3GWUicAJJkB4gpn7oh17tS7CpVPQs=;
 b=HIWqgb2vPkN5pf618dxu9GS5tHrR+ANp1exqkPclSB8IZRMrSVPiU16qqh2pOrWX1+HKLkesi
 vtJ8fcwFi7uBJoCZWnBjJjdPge9Zy6ixVG+ZjwBjhi7bz8Wfzt6Wtbt
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: 77de4fca-cd10-4db0-cdc2-08ddde3a54db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHNBakd1K29rOUw4QmhVYWtyZ0h3ZGNrWlovdnZFb29QaDRlYWY1VUt1MUN5?=
 =?utf-8?B?dGRSRlcwZ0VtWjgySisxYW8yMDkvaXVISHFlbmY2N3BaRmRhNGpLekNZOWM3?=
 =?utf-8?B?LzhkM2JmN3ZGS3pDYnIveGdmU0g5ZFdsZGtHMVRzSmN5b0NYTkJmM2xiSXJu?=
 =?utf-8?B?U3c3bVVkZDRGNC9FcW9GL1VieUZSZW04ZkxzUlRiNjJ4bmt5QlJHS05zTXdj?=
 =?utf-8?B?TnI3M3IyVHBYL2NHQjIwL3lmNGErdlRtdDltL1RlUncwNmtVVmt2N25NZ0RE?=
 =?utf-8?B?U0paYlpnNVduZUN2cE5pY05aMDNIVlFaamx5Y29keTQ4bXJqc0VzQkFnWWRU?=
 =?utf-8?B?R0syVGVFWlhwRTZHRjUzaWl1WW5pU1ArMmlWVzR1eFFicVhodDE0NCtQMlFL?=
 =?utf-8?B?Q3ZTdDBHSWFUN28reVdldFBvLzErWEdZWiszY2ZUUk5HSEthWkN4T3NMejI2?=
 =?utf-8?B?T0FyUEozalJtMzh6SEZsbVpuUXVrRXJEN3h2d1l6Uno0TWk4dFJTeTNSbFZx?=
 =?utf-8?B?VHBPQTNRRHAwWlpWb1RxRUdjVHJKTm9LQWNWaUpuaS9QQUlJOHpMWi8zT3ln?=
 =?utf-8?B?ZHVoZXp1MzVSaFd0OG5IVXp5ZmRjTURvY01Pd044dlN2K3EwT1JsOUZIL0sx?=
 =?utf-8?B?WnptNDhpTks5alRKQmhJSmZibStVMHRFRUJDeWJia3ZFQXliNmNLQ2VxT0dk?=
 =?utf-8?B?MWxzcFYrVCswazJPbkp2ZklLeDhubWs2MTdEaVFFeDVEOHpWVnlmaERIVWo0?=
 =?utf-8?B?RzBvWUYrSXl1dVRaMlRzdnZYOEI3dXhlQ29Va3FnajB5b2xONEVpVEU5MUtL?=
 =?utf-8?B?RENEWEhMY0duS011bG1LcWE4OUM2dE1RVEhVT0k1T1RwTzRLRDdIdkxreXZq?=
 =?utf-8?B?dXdJSDBKY2ZsZVJPRW9oR3Y5dXcxTlZHNWdiTWhMdWV0aWhnajN5QU1kRDlz?=
 =?utf-8?B?QjFVNTd1bDZFRFp3VmF2dXpGZ0wzWnVIY1JpRUdwQmZGczRveko4UE52VjNP?=
 =?utf-8?B?Rk1jRVhzai9lZE9tS1dPMElqaTViMGxVYzJ1M3NDSDBlVUh4Sll0STQ3dUdh?=
 =?utf-8?B?anRiVCtCanI1SnI3V0JNSUQ4cW1CUlpqajQzaTgzbWJSekt6ZkZnclFxalA2?=
 =?utf-8?B?c052cGZnTXNoMWQ2QWpMV0txZkRUeDlmSk5TQmNNVVpRK0ZFd29WQ01tUW4x?=
 =?utf-8?B?c0tEc1I2dllpNzJZYWhMa0FWYmdlOXMxbHJTUklMWlh6Nzc3N1hJendIWm4v?=
 =?utf-8?B?TG4zUXFTeFhKSHlaSkFnazNUbHdSbk1nQzNnazY1ejJwVzNyRU9DQlVFdisr?=
 =?utf-8?B?WlAxQ1phY3p6c0hGc3lzLzQ0dkVqOWhwRllOVUw4QWF5UTYyTzhTYnN0QkIw?=
 =?utf-8?B?WVE4TVdjK3hobnFwdjYzVHkwcjRsYzZIS2wzWSt4L0MvQjZna2FYT2lHNnRY?=
 =?utf-8?B?NUM3NGo0bS9EbHdNbXBDTVQrcU9XMHR6Z0dJajAyZGYwZVRQRldZOTdZWVph?=
 =?utf-8?B?M21saTdodEF2R3RnWXZqejZoWWdOM3NwM1dORC9qMGMzbkVFaWFyMnhvRWVp?=
 =?utf-8?B?VlgraExzTGZYdkR5Q1d4VTU1c0lXR0ZsenBwZjR3d3hrckprS0dQcXArL0Vv?=
 =?utf-8?B?TGJIbHU5Y1pVdGJjMjRMOVgzUkVKYm5aSDNTY3RFUkcxektLUnluOUlTUm1P?=
 =?utf-8?B?bHNpSVFvaG9UODRDVEEyemhTYW00K3N6MnVSVC9Wd2NxaVhVTEJ4N0xpVDBS?=
 =?utf-8?B?QUs5bndiVkoyd1FQVTIzMEFsbDU0dElEWk5QSlRuWW8xTFpXNUFZVWdhSFRP?=
 =?utf-8?B?RmNlZzJ1QS9BNXRMQklXQjdRZGpUYVp4NDBYa2wxU3BTMllOdUxOM3M4R1Va?=
 =?utf-8?B?a0dqQkgwTlU0bFBKQ2dMN0Y2VzJjeHUvN0xTQTZ5ZWJ5TzRVQ2JqbHpmTFNH?=
 =?utf-8?B?REZhcERJMG4yNlozb2pkam12YmtDMmI3OWo5VHVrSXh2MEI5MWtDZjFQSkNx?=
 =?utf-8?Q?JT73Omz1K9jdf8dJG9/67DC4QCXHoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTUzOVMrZWowMkFZdVpHRzJ6RGo5T1hvenlDdnVkV1liN0NmOTh0VEdZVHBY?=
 =?utf-8?B?NkpEdXVRbUdZMDQySFlLc1U5bDhiL09YYnhLVGY4S0pFclBrME9PeGhjbDFE?=
 =?utf-8?B?RDM5aE84RUdiaThCV2YrS3BrZEhzV0Z0dnFaM2ZTbmdoV0FsRkgvUnZuY295?=
 =?utf-8?B?TEsyYVdtUWVTUHp3MGVOV2dTRmhZWWNtTEljWGRwK2RBcmVZS2k1Q0o5WDU0?=
 =?utf-8?B?a1JCMjE3NVZYS3pQWlJJOWxkTnVaQ0dDNjl1NTBCb2FTemtJV1pSZVkzdkNC?=
 =?utf-8?B?Q0lkRCtTTzRESFRuNkx3Y3BIelpLSEpuYy9FeVoxWjRTaFUyUWNkbFJwM2Fn?=
 =?utf-8?B?R0h1QkJoWUZWNlQxNGpXZjlxTE9SRVBkekZ5L1F2bC81OTkzSzVjT0IyQ2xi?=
 =?utf-8?B?SytFbXE4VUtmcVBmM0hteFVWSERuVGVZV25teGFhOXAvS0x3UTI1K3FHUXFu?=
 =?utf-8?B?NCsyUnpFN0lqaWZyRmlwZXB0dk90WFMwMXd2eERIMVVPTklLZ3ZOQUVyMThG?=
 =?utf-8?B?T1UvdmtmeWEwSllydWVkb1NoMlE0UXJNVHJ3TUk0a3RpbExOeFNySnV6eVhm?=
 =?utf-8?B?c1p4THhwVVprM2JLM1VGcnRuQjNZM3pqMmhBZlhXYUFoNjRoTlJEUTVsZCt0?=
 =?utf-8?B?USt3Vm9ET1hqdmRVUC9mdUFWOUY0SlZrcllEdjU5TGNLU1NCaHBoSG9jdHhr?=
 =?utf-8?B?dVRuTlVEczJGTUVUc3U3bjBWdExlMStXbGcwM2dpSDU0aXRQRW40RlNYajZZ?=
 =?utf-8?B?OWF6YS9XNXNjM2E1N2lUN3ZqejdzKzdUTFpyanR0bW5SK1dlVUQ3K2xRQ0dC?=
 =?utf-8?B?WFN3dUxYUG9qYXFLR2Ftc3VNTmpBYkNJQUJ2NHNEV1NwS29yZ2xkeWFpczRO?=
 =?utf-8?B?U2FiRlU0VjJQU2pDYUE0K3VyQ1NhNm55ODF0N3o5UEp3eVU5OTIxS1h0UEVN?=
 =?utf-8?B?WlM5V0N2Q2tUNFRMNWVzWUpEWHNhTmxaK0xQMTB5dkYwd1hDNFd6bllyUklo?=
 =?utf-8?B?ajRocGl4Uk54NmU1VDZMMFNtdDMyaDZ0aVlrK1lFd2tDQTMvc3VyTFRnY1JD?=
 =?utf-8?B?WjlKR0pIbHF6R0hYMC9KbThyNTFFQnNaeXJXQVRRMFZncXRJYzN4R2VFVVJZ?=
 =?utf-8?B?N2N5cDZValFGZ092UnVwVG1rK1dmZXQyVTlJU2FVV1daUjQ2TEhJWkFVcjVx?=
 =?utf-8?B?RWZTajY1aUlObzdoSjQ0Q0pKQ1NQcTdIeWp6ZzRhWitZOE1FNG1EeXRaS2ZL?=
 =?utf-8?B?a0h5YXVwYWxkT2pjUjlTaVB2ZlBzUGFpZE11NDlOczNYMUkwQVJoZVZPUWxl?=
 =?utf-8?B?LzJZMXhsUlJUMjZSZ0V1cmNGYjdJUFV3eTBkVWxwblR1VHNQOGs5aG14OExF?=
 =?utf-8?B?MWZDek9wUXd4R0E2Tm44UXVMSkxSa2JFSlVTTnNSUFlKMVE5SHRjVzFUVVJR?=
 =?utf-8?B?QmZVcGdYMWtodGs5bkIyQm1IMzZxQ3QxUS9lODZlL3IyUkNJY1FqbFdLdUcy?=
 =?utf-8?B?V1d6SUlpN2YrMElsR3RJUFBkYXhqN1Z4b0tINmE0Tll2bVNQWEFDYVNEaHBa?=
 =?utf-8?B?dWM2NmlVVktQZjJkUE1zREh6RnN3MVZ6SXBBVjRqbjVyNVFZUHlNOFdjYzNI?=
 =?utf-8?B?eU4yYi9ucUtvUnFXK0lZRU82L0ZhclIxTm9BOTNzREJJU0J5b3dlcXdJWkFU?=
 =?utf-8?B?ZTI1dFVVcG42VW1uaktQcTd1MjBoYlFYcGhWckZlc3B3WEhkNEU3ZVZ3Ni9i?=
 =?utf-8?B?ZVp2Y2xrVzZQb29vTUlxaS9ZVFZtcHB1YzZRSGlHZzcyOEx2ZzE4V25YTG1G?=
 =?utf-8?B?cXlEMnh5dHV5OXcrbGN2UWZoM085VzVObHd4TFVvTHpFV3BBWUZaU2pUTGp6?=
 =?utf-8?B?K25sM3cyWWZIZVRhdFd3VFViM2E0VXVlclVsbzZTcWhUUTlLWERBN3A1WGJz?=
 =?utf-8?B?c1BvdzFMSUpMekREQjJPc2pRcTF3OUNVM0hBRmtBaEFWRlEzNytHV0ZkeXJG?=
 =?utf-8?B?bUw3WkcvZ2M1Y0ZjRnZ0dnE2UjJBcTNrSlVaKytweFNJTEh0dThaSXZzUVR3?=
 =?utf-8?B?SU56WkNOTi8wWW1jaFplUndycWJQekR3cmlFTU02ZUczWGplZ1JUY20rZ0tZ?=
 =?utf-8?Q?jF83ayZ7NKjYw792Qivst7Ah1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77de4fca-cd10-4db0-cdc2-08ddde3a54db
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:33:47.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDvX71WxvgwDrlV8MK5sbw/Y4345yYY9M/1uYZyRGW1vJpIt0NkWl5vqz2U307bkvblpoBkdqSwyfmWJ2v1yZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

The i.MX93 TMU node compatible need to be updated to apply the SoC
specific configuration and TMU errata workaround.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
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


