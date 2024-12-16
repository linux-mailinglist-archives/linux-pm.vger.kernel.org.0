Return-Path: <linux-pm+bounces-19339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B2D9F39D7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 20:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED861886628
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE342080EF;
	Mon, 16 Dec 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ncJqLqOk"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52609148314;
	Mon, 16 Dec 2024 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377136; cv=fail; b=dyHXJBnBRYAmlcHbEMcxGErX0se46YYXWhYd0TfpWfYU2/Fx3nFMw57DwKJ1v5oL3HvHWhz/jmsR97pdYQWX8J7+KwLGsv1SFMIbVU/e/0LZ5JrT0wGgYMijqmByIvcvSwNT29JFgw8Qhp7917MBjoyhVgteeJmZGBY6R7YqItg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377136; c=relaxed/simple;
	bh=FA+mp8d3/xe+zk7h71tFobS5nz+9+ZDZ5ujGykeh7mc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Y5l25gWgSeCHhsX3G3yALeupwmFhn+id8TsRfRjsJTaTX5WLkQA/ZbV68hqLBDuD7kF/La9xJu4PKTYdVuSPzTUvIyN+dZVGTo9qSZQa7kXUN22xGST9aBbUt6y4z+JC7F8EDeuowqHkAgZh0U7n5YCj5FnaHqANUAlyV7aCiow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ncJqLqOk; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0LT+dBWDw9FfHk0ptOlqhF6tjaoGrhPNhxyPoQNDlcuyBs4CgyqjPXtcOTRZqlIzuXsDhgBlaVHgLwZkyQBwxXbzWaaS7CIb3CqpPt3qwSc+lYTkPSYTNNxBh1GdSqffAlMhJfrb8pleF0KdF+tpaPLnvKX2aAQxXUu6AXJFZKcUY7sPzZY4OHJOhgfZmORX0LPjtiZNgvWrtwBWbo7xl/s5EqFh86UCp+zsjHvl5Eopqh7IymSrZP5VmUQgvF2fH+J/ov3GBQjRt57NZv88Ih7B8N7FQ8GQHKmGtRCznqjyQ6fwo9VTLzq+glqzvfiAwma4djPLNfXKLQLuCLWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6BmlKCvfUrx+AdoMQ6GKe39EWkpAVfP7iqLOt1CuUY=;
 b=VoPkmsK7tG43Jf9VEqpfnHuwyb1eqUaYGyU62cc9k51rw+XfJPnRdGV9+YfaOvQUZQEQhQFyJyaNUf6u18lvusTamQW0sINOa+LT/IDs6bCGLeCsIwRA8LnbMw8bl1XvHg/DBXH9SYiNOaGzcnRVKyy6mEkBS0v5MU2bKmQPwxVVQr4xsJK1ttuuyzYOIg4wMByTFXgjA6HLcnmIa8fmbYcxa7fj0I1XfSqauhrHMqI29OhBO2TJgmKns+DYq3Bg6x2dNYG49onNhZl7ieHBh7FZHLuqtQ+/n1hm/dLrXJJqWxoRshzjKTNA8YqtgSSWGSjZTsrbb5StsWpEdcsFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6BmlKCvfUrx+AdoMQ6GKe39EWkpAVfP7iqLOt1CuUY=;
 b=ncJqLqOktQYl4EmH0pKloU0tNsyq+CIDUIAefeHZY3OUpuqtzl7uoMGuv04iOW43OcxEjcbX/nI3tT3Cj7pCm3L6Pi8X4FULUITk2Sf7EKEZTpfLQFrLRL0Suczh8bn2r0UQrXws+aWfa0yU5wDlvodk66gy5BLITdsqlINFI/zLhyWa8ggj0T3thu42Qo0EmjF/eVEjskCQkvz5vm5ydD0Uxahmo95eTQcCWIWsMSJzF6pz9JGedrYYN/nKcDgFK9G1LEBplgUfXIYqnqrSg/Bb5H5XShKkiq9gQo54GXNEGkiTHJ1p4WbYS165IStCAwOyDp3p+DMz8W+9qLI7xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10249.eurprd04.prod.outlook.com (2603:10a6:150:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 19:25:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 19:25:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Date: Mon, 16 Dec 2024 14:25:13 -0500
Message-Id: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJl+YGcC/23MTQ7CIBCG4as0rMXAAAKuvIdxgUCVRX8CldQ0v
 bu0GzFx+U3meReUfAw+oXOzoOhzSGHoy+CHBtmn6R8eB1c2AgKcAtE4dLOmU/fCpgUjLeHglEP
 lfYy+DfOeut7KfoY0DfG9lzPdrn8imWKCpRLaCqZky+iln8ejHTq0JTJUjJKKQWGCMDDGcaeU/
 2WsZlAxVpgSXorTHTRn8svWdf0AHfTHxQwBAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734377121; l=2165;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FA+mp8d3/xe+zk7h71tFobS5nz+9+ZDZ5ujGykeh7mc=;
 b=ZtNPgZOKpVXo9fXOZXr8tG05LToU9BOI9z+5zt/2lRyRFUqig5cIMtY/2uOP3cSTqpccYek8r
 cw1gN1AbyKTA+EpPTzP22qNdt1QhQXfT3QfzKmisvjmmSvxYN46ijZG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10249:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bdb845-e9b0-4f2b-c6ea-08dd1e076513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1VjRkFERTV5ZDY1VHU4cklkMzBRbTh5KzMxVWJBbDJlMWpjL042RWNIU3R5?=
 =?utf-8?B?eWdtNVFsY0M3aFRsN1dySGpEZ05FT3dvUDlQQmxicTVvU2plOVhkRU5yL0dk?=
 =?utf-8?B?Q2JtWHJROVdNa0lGQ3RSbmZ4MHNtQjVZQTdtcFI3M0I0Y3lac0pnbkdCbURz?=
 =?utf-8?B?RmdVYXZrSU9QTFgrY0lGb3kxNTBPR0czRnc2V0hxc0N5d2syZkNaemFpUjVG?=
 =?utf-8?B?V0ZqMlNJVG1qcG1WemFoTStTZTBrRmE3elpHZ1BqbG1KV2owNXR4c25YNDlS?=
 =?utf-8?B?Vzd4SEhaWHBBVmtUMVhrdDJhMTJ5OUk3cWczQnI2RmRMOUFIMTZyNnR1Mm00?=
 =?utf-8?B?UFgrRjBINDJEeTRPOEMxUGdqYmk1dW5EUDVlZ1BuOHZpZUhuaHRhUXNka1By?=
 =?utf-8?B?VHM3akVZdDRFQnQ1RXBSeDlNOGlJU2RzUUd0MFA5RWl4U3o2T0JZaXVQTXNn?=
 =?utf-8?B?bEp1REhSMVpSMnI2SjRSZndlQUVQbFp6cXdHS21ocERucDN5eGtCZGdtWEVs?=
 =?utf-8?B?UkdYcE44S0lNcUpQQ3NZdXlpc0QvbjhSOERPaXVVTkhIZEtuSmprSGVjOEZG?=
 =?utf-8?B?dlVzQnh5Z3ljdk5IRmdNRzJIOXluMWxMZGNCSGRybVVXVUF2MTlRVXRYQjNH?=
 =?utf-8?B?anlPMytYdDVIUjU3SzVVMVFwR215L0JEWDFlM1ZlelFKdEhJeExUcGxQSnNl?=
 =?utf-8?B?TTVqNXRON1Q3TTVWckIrTmFCSldOWHc0RitGYWhiUUFmMURGR0tHTVR1clg5?=
 =?utf-8?B?OXh0ZHBuTlBlM05SblJNMjJkYk1GcnpmVFpUd3V2YnRwZ1BnRjdTT1hiaHU0?=
 =?utf-8?B?U3lLLzkzc1Jqd3UvLy9jR0JaVjdteXc5RlZ1SHNXb0lZQTRwVnVJT201ZEd3?=
 =?utf-8?B?TEhaUmZ5UWdCY1phL3ord01aN3U2OUhuRzEvWmd2RFJtVU1oam00bTlYSzQ4?=
 =?utf-8?B?L1FrdXVKWjZ0TUd5NkpQRFB3aW9YeFV2VnJMTzJOb1N2N3lsc29oMWtTQzNa?=
 =?utf-8?B?dllOSTlTeUFTaW9tcEdWbXEvNzNadmZYc0JoN3dJN1UwYlo4OUxRUW85THo4?=
 =?utf-8?B?bGNBdm1pMnpkRzRDb2ZoUFVjdU0zT040bHYwUXEwNnBqN2laT0VTSHZHSlVC?=
 =?utf-8?B?MnJ4QU9RMnRRMU5YZGIxUk43cFIzMjdoRW8wY3I0VWczcmpwUnFKRm1XelNl?=
 =?utf-8?B?ZTAxQkh2S2paa1VDWGNmRmpkM2lmSGtQQ1hwYVlsakgwakRoRFpiSFp2azhP?=
 =?utf-8?B?T0EzNW5ValhqUDZGSlkxNHprc0JWVm8vdzhJVkVCemVSV1VSMjYyWkZxZndS?=
 =?utf-8?B?S0g4OXE0QmNtdUd1d2tXbmhrWVI4QkNLQWhTb05obDlKMUtTL0ZDUy8yWkVp?=
 =?utf-8?B?elhNVjNXTTlYelFmRDdidUJoSWhodHRRdGtnSXk1amc1N2orNCtMSUMyai9T?=
 =?utf-8?B?WjRkbjAvc3ZZaURYUURNdnU5UFdIQkJDSHJRMVRRc0pZWFpRdnRmTnNNZE5X?=
 =?utf-8?B?UEVYTHlVTDllZmJwMVg1czBOUXFvUjErM1dYcFFaQzFNK3JGeFRodldabjRz?=
 =?utf-8?B?QXJTcTB6WXByWk5hWFg2b2lCZzZzRjJyK0JLamRwUk95L29OM2ZHUHJ6MzdU?=
 =?utf-8?B?YTQvZ25vdDkyRmZVdEloSTdXcDBaQlpLWFVKdWJUWFA5dTIwZXJvVEdLNXU0?=
 =?utf-8?B?aUJTU203dVhNejFaUng2bWRwTFJwOWoycEN0VkFEWG1DV1FBTFZEejdDYW85?=
 =?utf-8?B?alFLRlRtQ2E1a29MZjUzMFBNa3RTRTYyRFpvamZuazdCSTZ3aW1kbjZYem5l?=
 =?utf-8?B?bTI5WXk2SVBwZGhwdzdWdTVKdDZNQVVUVnBQVU5MQUd1NFUyME04bnRyZmwz?=
 =?utf-8?B?aVd6RjFtcmZTWFhFUDZmU2kvK1JkRFZHYTZnMExiRThDc2pydE1uZCtHNWpX?=
 =?utf-8?B?NFh6eFBMMTJrR05XTm9KQTAxYVZobVdyMktaTlpvbFhXZkpPajd6MGNSVWtl?=
 =?utf-8?B?cVY5VG85c1NnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhGcUF4NFRYRDJmbXJQUUhFYkFLb3JIeVRvazFJQjBhTmoyeXhHNjhidk50?=
 =?utf-8?B?LzhNWEV1dERxRjBISVdFbzlPbVVZUzhidGRaRTdtckV4M3ZYNEkzZk1sUGsr?=
 =?utf-8?B?cGdVQVdockdnRzBxaWVIbC9JS1MvUEh5RlNGK0pnczFMb3BFOGNlZzc2dFY1?=
 =?utf-8?B?WjlBa21XOGlSbTR1M3owQjg2NThITmY5Snd6VXVrTmRDRGNZRVVQY0hlOWJB?=
 =?utf-8?B?QkJDV3BadldHTHg5T1k0dGF6dU05a08rTjFtcTJEdmExNnpNdHNQb2w5WHpY?=
 =?utf-8?B?MGc1RTJ6bjczaVRvNUtnUHRmL29OVXNQdU1WYmVqNmtsZTZwUTBnNk56Y01Z?=
 =?utf-8?B?ZXBoU25FajFTSmp1K3pNK0ZydVEyaDJBU1NjUWhJTlFSdnhwNW5zMmwyaHFL?=
 =?utf-8?B?MmFCUUczSndSTGhXNVZNcEtORkJtY0hpKzRmVlVML0psbnpSRlFjaWc2KzRT?=
 =?utf-8?B?bXA4TisxZUptcjl4OWxHL0xlTDFWYUJtZVd6QldRMWlRM3BsVEtwQzJLMmh0?=
 =?utf-8?B?NytFQkxDd2l0alMwU1JDUGJITTlSNGUyR2JPTkxLeHpKTUQ3MXB3azhob0pp?=
 =?utf-8?B?ZE1mVDV1MUxtM0drdE9KME9jazhnVEo3Y2M2azlReDRNWi93L2pIY090dWNY?=
 =?utf-8?B?RnJUMnU1WHAyOGdNYlVSaWxtbFhCZlhaQ1JiQ2FQTzliYTVhTEVzUGRKWmpF?=
 =?utf-8?B?ZnFmb1JXRWNJZTZOL252cUlzVDM2Ujc5UEFad0JWQXE5VW45c29mSmoyY1hB?=
 =?utf-8?B?Y1V4QjdCUTZML0FTNTVGRTdOTWdsMkJxZ3NWY1M4RFF2OTR6Nmw1T3QyRjEr?=
 =?utf-8?B?eGxhRERuQmhpbmNuQ25YNTRFREhRd0cwbFRUNHluSFRZdC9XNU5wbEh3MzA5?=
 =?utf-8?B?STY1TS8wUU1VeFdFWm4vQ2JOQkM5M3U1aDlNMEVxMWpxcXBGT2xkRWdtcVNY?=
 =?utf-8?B?ZkRJWWRaS3phMmwxS0ZWQVZITjIvYXg5aXNYSzFZR054NWVMU05lZkUrWXJN?=
 =?utf-8?B?U1F3OWpKT1l1ZjlyZWpOaitnLzRsaVd2ckRROTZUdklpMXppaWlzdmFudVRY?=
 =?utf-8?B?Vm1MLzdsNzNGZzU0NW5oUitZRHNVMGJ3eUIyMy84dUx0dk4vTW1SYVJyQ0dr?=
 =?utf-8?B?d1F3QzFsdzBCUTFBK0w5SDdwRUt1czVMa29xUlM5WjdFaVl6TlZ0eVMrcm5j?=
 =?utf-8?B?TDlJUzFvMXJPYVZBa2kwY2pUZ2FnREF6NTBweXYzNlVCR2lncDB3K0JtT3oz?=
 =?utf-8?B?N2VKNGFuZDFvNTYyZGYxQnVnaXNHK2N3bnJrMnZCZzZHbG9UTGo2R1FWZkxk?=
 =?utf-8?B?c0ZrdWxBWmdIbmdjZzRtMFcvQW5menlZZ25icDZ3eCtjc1NtbjlBVTdtV002?=
 =?utf-8?B?RjZtQ0lQeFhUZTlTVmlCZUxnbXlkZFZvVkNtSUxkemxmZEtkV3pRdkhWM0lo?=
 =?utf-8?B?Zis2QVNueHkyNmVxcjIwMHNQUG9Gb3VzNlB4a2UwNVBtZndVUEVJSVBYYUts?=
 =?utf-8?B?dklweTJyK1oxS2tZc1pPTEx3T2Zpc2dReDR6VHI0Qk9XdUdYZ01mVHlXL043?=
 =?utf-8?B?U3hQOXdBaUpJZ29lVnJFTmxjUjVwZXYwVWgrY3d4RjQ1Zy9oRlVia2lDUXc2?=
 =?utf-8?B?eVg0N1k4QXBvUEYvbTY0YVllSTNuT1VGNEN1dHRqNGhKOVc3eU9IZTAyZDh1?=
 =?utf-8?B?Wk5ZUHFwY0syQzJPbG1jK3dzcCtzczJzbFVxSjZVVXMvOVoxRzdLbzRQZTEz?=
 =?utf-8?B?ZVFaelBzMDMvVmxJM09LcVM4OEpxYStYVU1yZStIMDZzM0RUZkU3Znp4dnJB?=
 =?utf-8?B?aGpSZkNCYzNoTnZMdUNVZC9rRkV2dG9jTENhTytlQkVkNjh1U0RNd3lDd2hh?=
 =?utf-8?B?NjBwZ3FaYnN4YnVYVlIycnNzeVduRlBwaWdReVRCd1p5TTB1dExleXh3M09N?=
 =?utf-8?B?RHBzUzlDVUdBei9ZdUtUTC9lcFA3YmE1Z0tKTFFaRUtuU2VrYlB3L2RvZVh5?=
 =?utf-8?B?cmJ4T3BmMEgzSmhURG5yYnhSUVU1bGhuTFBqb0xrald4QlZlRmMrRzlZT1JT?=
 =?utf-8?B?OGZqZUkvWGl0KzBrLytHQWcxTm9rYms5KzdWQmovZFFrUzZoOXBId1EyREtC?=
 =?utf-8?Q?todVf9S1bP1ClIaHWJNUROkeh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bdb845-e9b0-4f2b-c6ea-08dd1e076513
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:25:26.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yt9vVRBIRGd/hNEv+Mlcw/I4r2C7o2IN+SYcB+c7s5wST/8AHKOa4xq+t4smrME0jC33qlFvXRN5xyzsbza4Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10249

- Add binding doc
- Add imx91 thermal driver
- dts part wait for https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
merged, so not in this serial.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Add Kryz's review tag for binding
- Add Marco's review tag for driver
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()
- Link to v3: https://lore.kernel.org/r/20241212-imx91tmu-v3-0-85e756b29437@nxp.com

Changes in v3:
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties

- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
  uboot may change and enable tmu.

- Link to v2: https://lore.kernel.org/r/20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com

Changes in v2:
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
- Link to v1: https://lore.kernel.org/r/20241209-imx91tmu-v1-0-7859c5387f31@nxp.com

---
Pengfei Li (2):
      dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 thermal module
      thermal: imx91: Add support for i.MX91 thermal monitoring unit

 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  67 ++++++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx91_thermal.c                    | 263 +++++++++++++++++++++
 4 files changed, 341 insertions(+)
---
base-commit: d07c576946b2bc440d6d2073998023e8a0bd7568
change-id: 20241209-imx91tmu-af2a7c042d8d

Best regards,
---
Frank Li <Frank.Li@nxp.com>


