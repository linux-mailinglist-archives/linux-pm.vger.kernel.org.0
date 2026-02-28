Return-Path: <linux-pm+bounces-43355-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPIzOtFAomlz1QQAu9opvQ
	(envelope-from <linux-pm+bounces-43355-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 02:11:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9631BFA3A
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 02:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A56E3306B2C1
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEDF2D8DBB;
	Sat, 28 Feb 2026 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ho7qDwsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBCE248880;
	Sat, 28 Feb 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241085; cv=fail; b=sQ3yewR7PEFNn9ErQQ90xnJCSt1wBRW3XoNo1aHWUp2jPp79lN2nU3j9yq9G3MrkI5+8lgI2ZJSFoclaVAOEovbIyoog4kvvtd+iYPz2deIeK6PCnVAWD+yg4zxRVjLfdO8RpURsLg7JnL5eFqgKvXYJ452FTXwdtYkyp3KDR5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241085; c=relaxed/simple;
	bh=HM05wGedMz2re3NyMWiZEVz6kTqKiSE6ndpd0QFaSe0=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=GN76wa1hcyvbXeu+ar2x3jg7Qx0rCrMAFYsUq8bWCGE7tow8EL0mwl+2LXb9k9fdLMn5OsyziZW8uBc+wyi3Mjr6OmXe2iF0xKotD7n78gX+wJae4hXQ76pOrlsjr77SPmf80PL8RLKPv1w/wEWuhTJ9tg/7+hmOphJ08dpEDFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ho7qDwsO; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVwtbboaicQTU3E1HJH4nuYUxJZQ3JQQontM+dH5TZ8d3RhRw1Ou2sLjP3gqvkPOhrfulE4qVH49qzwjyrHeI+t2HlanUNQMCn7Li1V5uMTg8X7pyBc+LZxiSMFavQUOox6X3xGI2RZV/SNIFLR0YJr6I7rjcu7fdDiofRCazQK9jTSzM7xtpYFYrNHf0ee+51GmZlsv5fxoDbOIRXSLm5ZsTn+8axSW6twHOmA6IGZuAExkN1GJEurUHhn5cVPtyRG2+mGE2JJyztiCkwssaprnh2FuwFhl/nJYOEZBF4ovBT63FRLDnqrQgNmfpRP/s9skQNoVO0ENe/VRf2un9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2dcCUTTvXFe/Gl/yxTZPhDrwbF1H5VzVzxp+19vuAg=;
 b=G8SPvNa7AdaZkTzoYKX37t6zXOaO8VYdhY53N1sWlCgKjPJ8lx0JfY0tnTN2/Td8exERLbJJn1kgS9QxfFYS8X76Up/+EI0cngd8BE+anah8UP3qytPE/SLgusS14UEY3N8xacq+BnuE+8H6tV07F9upkdMDgX5G5evJh+TXt36Ioy7W+LRpQj3xFkQwtMqhydoIpZ8+qDrp0YOTBW2s+Jz72J3flwaadl6Cmx6YB2L2JzefGY6z3669RhhiIcKmLHWur1d+DUtP1qk3V1Tnr0uXK2FNGqrQRdHtId6SyP0YcdR9pJZYore0mAbEsqV0/Bc7yeinyvva39xw9CkOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2dcCUTTvXFe/Gl/yxTZPhDrwbF1H5VzVzxp+19vuAg=;
 b=ho7qDwsOjDGKxTUzF0ir8xJ8GmdMMBZX5DA4/h8wn/2zuoiN0drNxMvFNIjO6HffreqqU+5WdP6tp//KqhqyTousngYyiFPuICUZ2w38StR5Ivk4VUHabbmJS88YvVBiLNiF7lT32SPUBJpnSx5ginQFlZFHSo4Ok/zo5L3wwbtrQqtXjzbuXt30Gfw9dbiY5zv1SRIgze+/Z2TgwE+EQjlOm6vcNlPBnMsiFYRRaVwSoQ4rzJ4uQN+0CjBZjw6NI62GKLkLrpu4AlcNg6CgcKo/UHaJ9xrOWA9q8IWroP7niuIv/ZGKVnZr7BsuOdeD0EMK1Ij21T0ZJLLtIzc1wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:11:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Sat, 28 Feb 2026
 01:11:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Feb 2026 09:12:45 +0800
Subject: [PATCH v2] pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx8mp-vc8000e-pm-v2-1-fd255a0d5958@nxp.com>
X-B4-Tracking: v=1; b=H4sIAAxBomkC/32NQQ6CMBBFr0Jm7ZhOLdC44h6GhZZRZlFoWtNgS
 O9u5QAu30v++zskjsIJrs0OkbMkWZcK+tSAm+/Li1GmyqCV7hRpi+I36wNmZ5VSjMGj0b3lbjL
 20RqouxD5KdvRvI2VZ0nvNX6Oi0w/+6+WCQk7Rz2Zllx/0cOyhbNbPYyllC8I2holsAAAAA==
X-Change-ID: 20260128-imx8mp-vc8000e-pm-4278e6d48b54
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Jacky Bai <ping.bai@nxp.com>, Frank Li <frank.li@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f226043-d6f8-4a80-4b4c-08de7666477c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	ialZJFeVEV1WH4bkwTjEcfc4v/t635DraI6N1k+ZSeUubVGlogdb1OWCNAGDgaYdGXtdPdBnguUV6VUBLlCJAAISeHMiceap1+j+wQ8TujgzmxKhW+2CFENcOmIvB1SGa88YixEKn2XOsbUQjZkfDKjoCTGnhzdfx6LqddLaz2C6s6W/gNku9urE00lLOsCm4/jzEobz6CwlKzyvzTpeI1w8ol2v9rPT91kV3nV0xBtrdWCtaJfZYomNxSou0RlRvW7HvphdRIDimHk0NZbo9478P29Mq4iZfa1s9US58FgOixf9hY6wikH//4QdVhn83nmALRU3ffrFIOx/vGjdQ2/vFfISmm05kzECfl4afcLH98uaq7wBKuggAhc4WPYoQN3wB9yyvsyKfQEWUjXyK/uDq+VNpHO01s0d8Uk8IlaJ1PmqjaErK3A5DMF3n0pT35AjghPLxa9+/B+KxdC8dhpVK7k9RbgqQDq9ZmDuaAQzSG/P65msIL3hhmDBR98zbs5erfZUDawvKuSIfQcBRqIr45qTGH7Pm3Rr4I8SCpLymYKflva4rDAODJtsL6797j20F/8DPIVif6RnL/4mUCXB3Q6c3grIF/gW3P9iSyrvgaFXOHQt3pVk4M0lBwRxNMkEcnoP+uxCrk8VhAsP/7QewIA3yhrjbj4GKDefaqMD+SZcj784poSaDcWN6yF3zmsRyTxnbSMELDcWOiPAcVUgmVOmbCTMJNNw7CFe5PCXCLjxx3b4k0m5Bm8LU6o1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXo0enJxRlZSOHRTN0Y1WEFtQ0YycWN2TEZqTm1Qc2Q2dG5MOFEzTEgzYnRB?=
 =?utf-8?B?RFhLSnpVTHlOS1hLTmlDNHBQTXoxU2ZJNlNKdGQydWRaSlBtZUFtNytHRU9G?=
 =?utf-8?B?RFVzUk9WWGo2ekcxNGl4WklWYWFPaGtCVU8zYzBzM1hyK0d4d1VZUXpMRTJv?=
 =?utf-8?B?TFVla28vcWtRamN6MzFLOU1McmNBMlNyaG1BdHF5LzVsaFB1V1JqU1NtaEJV?=
 =?utf-8?B?UVRhWnZmdmJzNGRaVDAyaE1ZY2dKQjZFbVh3UjAyb2dCZGJGazE0eXliSllG?=
 =?utf-8?B?QVhWQ1NvdFg2T0ZBODVRSlVjYmRoMmY3QUlFL0U1WHNwRHl3WTlPMGFORmth?=
 =?utf-8?B?TUVNUHYrdnBnU3YxMU9yYXZOTzNwc3R5aEdQL0xqSlV1QmtvZW9WdnBiUTRt?=
 =?utf-8?B?ZHlIdHZEUHlmUHkvbUgvOTZOMU5mKzZ6S2dZZ09qTU9UdVBZTi9aZDJPU05P?=
 =?utf-8?B?bmtXUzgrcmd0NlllZjFORVd3VDZITW5IbkhBT3EzQXpMU1hYT2VvSXg5NGpN?=
 =?utf-8?B?b2UyTE5RNXFmeUovUzBoVTFwaGV3S1p5TzZUYmIvWFNsSzgrMU81SCsyTUZP?=
 =?utf-8?B?UkRIQWtMaVEvdERFTFMwdnNKNTVsWW1qS0ZJeGdpaVN3SCt0WlZmQU01WldB?=
 =?utf-8?B?SkNWdjdGNXMxVnhCb0dVSlpZVTlNQllQQkVwUGVLRnRxNXRlZkd0N1RsVjBM?=
 =?utf-8?B?YlRNbDhxbXNtSFFYU1YzSmJGVG15K3o4ZlNyd0pncHhTRnJLaDlnS3Y5OEM2?=
 =?utf-8?B?c2wzMWhsanZ3SlJKRlMzVCs3dU8xMlR0MnpXQ3FpbzNZbjBlUXdGMzJuUGg4?=
 =?utf-8?B?MWVyNXp6ZWNFVHRYWno4cEdQcXBQSngwQ3RYZ0ZoSzQ3anNnbmlLenpEUEpi?=
 =?utf-8?B?MTcwenNXb0p6Rzc1NG5lQXkxbnEzY2VsOEJweHd3SzFCdnJjRGpGTjFXd0Jq?=
 =?utf-8?B?ZXdUWmtmRFVpS0d3bGI2aS9nYXp3TjhXMyt3czlXRVIvVWQvckhYRTVIaUhP?=
 =?utf-8?B?Yy9pc0huTU5GNkNzYW9RRFE1TjJLTm9nYm9Cdit4Y3VQTU9lVlYrd0FqamE0?=
 =?utf-8?B?WlFUcnN2d1VmRnBRdTIzK29lR3pjVU81L3FDYnB0bGNQckNibDBqL1dQVDY2?=
 =?utf-8?B?WlM0dytkR1FlYnd5U3lWaks0VUhuUmJLS1d2RElIZXB2V2NVUXhCd3QzUW5J?=
 =?utf-8?B?K1AxazlHMWRXUjhvL08wK1pOa056dk5GT0NJZEJKWWtML3FCWjlubWZBRThG?=
 =?utf-8?B?d3NLc0ViZkN0dmtPTUlDdzRuS1Zsa1IwaEsrdWJ6TFArUU5PSnlDV1VjNTdu?=
 =?utf-8?B?R1V5RDhZYWVQUHY5RU5VdmJZdGdOTEVEVXAxZlB4eXhtdkRKOUtPeU9yL0tK?=
 =?utf-8?B?bktFL2ZPYlVlamxFa09TcTlzR05vcnJ4c2p2MXlXZkkwMUljYzhaU1FUZDNu?=
 =?utf-8?B?VjBsQ3krdEVNTTBOUlBVd0FGVmR3WEpUdDVXZnVhVEg4WWs3ODMvR2RIK0pY?=
 =?utf-8?B?R3lRR3FCVU5aTVJCRUV1b0s2Yks2RWIzcGtKZlp3Q0xPekJsc29qdDl3TG5o?=
 =?utf-8?B?WlU0YXpkYWZvMHl3aWVTcGM1SjhTWEJxNi95Q2RxNVY4Z1dOMUZlZ2hwcGZz?=
 =?utf-8?B?OXloQ1ZHbDlWMWVTVTgwYmdpbjVnMkt0K0c1L0Rxc0NRZjNKS25ZLzRvRmtI?=
 =?utf-8?B?OCtrMUZoc1ZnUUZSRXFBeEFuMTEvNmJMd0xtSytBVTVSV3R1dlNCVndrdGMx?=
 =?utf-8?B?eVgvU1BoRDdERjhYUWJLM1I2RW4wSGZJMlVWQUJWYnM1ZjFtamNsa3ZQS2kz?=
 =?utf-8?B?dSsrQUUxYTh1MHNNYmorQXh2dmR2MmkrcDUyZEdFaTB1MDl3ejdSWmdwN2Z0?=
 =?utf-8?B?aTk0cDltWEw1YWR0SG4zZGkzVVdhRkpXTFcxZ2NQZ0FEeUZ5VVZGVlYzeEky?=
 =?utf-8?B?cnhlWW5LcTI2cEs5NFVvQ1pMUDRham9UNFVmcFZwcXI1U3lpTFM5V1pVVjVE?=
 =?utf-8?B?SGM0alZjamltS0VSNVJtKzRMMFhCeTdrU0k5by9TWTY2L2hkV29hYkpxMEVG?=
 =?utf-8?B?bG9yZnNKTmY3azAwNTFmTlVyd1FmV1loSDBhZ2pFZkFtTU5HRzR5cURBOTJo?=
 =?utf-8?B?TXJpZGsvVHR1UXg3WVh0YVNJZUxwZk9LaVBtR2VDazRpZWNIR0RoazZrTXM4?=
 =?utf-8?B?L0hYYWpBNG1tYnlaRTV6SXFOZUM1QVZCMUlibUxhaXlHdEFHdEJ0UzRIK1R6?=
 =?utf-8?B?UnFqWWdYa2U5QWJ3ZGpPajE2MFpmbkRiVExPWXNJKzdHYlF2NDRzYVMweE1B?=
 =?utf-8?B?L1ErMjJjT05WZ1BiUTljK2E4QVFDaEpRWnl0eGFKb3pNRU1zbjJEdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f226043-d6f8-4a80-4b4c-08de7666477c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:11:19.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18mPwb6sys+TayUpCUGFPEL4Mg664IXMFReJ0LVeX7IIrB7hkD1AHxBX8ytqAebmUvfqYxP5mlkwxWlsPcCyPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43355-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,pengutronix.de,gmail.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4B9631BFA3A
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

Per errata[1]:
ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
power up/down cycling.
Description: VC8000E reset de-assertion edge and AXI clock may have a
timing issue.
Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
de-asserted by HW)

Add a bool variable is_errata_err050531 in
'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
is needed. If is_errata_err050531 is true, first clear the clk before
powering up gpc, then enable the clk after powering up gpc.

While at here, using imx8mm_vpu_power_notifier() is wrong, as it ungates
the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
imx8mp_vpu_power_notifier() for i.MX8MP.

[1] https://www.nxp.com/webapp/Download?colCode=IMX8MP_1P33A

Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add errata link in commit message
- Add comment for is_errata_err050531
- Link to v1: https://lore.kernel.org/r/20260128-imx8mp-vc8000e-pm-v1-1-6c171451c732@nxp.com
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 45 +++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 19e992d2ee3b845bc9382bcd494a5d96f9c6ac44..1cd0a22ce3e533358dd7449da9989162b36c5fe6 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -54,6 +54,15 @@ struct imx8m_blk_ctrl_domain_data {
 	 * register.
 	 */
 	u32 mipi_phy_rst_mask;
+
+	/*
+	 * VC8000E reset de-assertion edge and AXI clock may have a timing issue.
+	 * Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
+	 * both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
+	 * VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
+	 * de-asserted by HW)
+	 */
+	bool is_errata_err050531;
 };
 
 #define DOMAIN_MAX_CLKS 4
@@ -108,7 +117,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		dev_err(bc->dev, "failed to enable clocks\n");
 		goto bus_put;
 	}
-	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
+	if (data->is_errata_err050531)
+		regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+	else
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
 
 	/* power up upstream GPC domain */
 	ret = pm_runtime_get_sync(domain->power_dev);
@@ -117,6 +130,9 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	if (data->is_errata_err050531)
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
 	/* wait for reset to propagate */
 	udelay(5);
 
@@ -514,9 +530,34 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
 	},
 };
 
+static int imx8mp_vpu_power_notifier(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action == GENPD_NOTIFY_ON) {
+		/*
+		 * On power up we have no software backchannel to the GPC to
+		 * wait for the ADB handshake to happen, so we just delay for a
+		 * bit. On power down the GPC driver waits for the handshake.
+		 */
+
+		udelay(5);
+
+		/* set "fuse" bits to enable the VPUs */
+		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
+	}
+
+	return NOTIFY_OK;
+}
+
 static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
 	.max_reg = 0x18,
-	.power_notifier_fn = imx8mm_vpu_power_notifier,
+	.power_notifier_fn = imx8mp_vpu_power_notifier,
 	.domains = imx8mp_vpu_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
 };

---
base-commit: 81f98c6c88ebd36df93d903bdfd3c8a10a722eef
change-id: 20260128-imx8mp-vc8000e-pm-4278e6d48b54

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


