Return-Path: <linux-pm+bounces-41744-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKnOBpI9fGkxLgIAu9opvQ
	(envelope-from <linux-pm+bounces-41744-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 06:11:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231DB7381
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 06:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12D8C3004436
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 05:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7760931355C;
	Fri, 30 Jan 2026 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RFsWa0oH"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D35331A52;
	Fri, 30 Jan 2026 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749901; cv=fail; b=sclrXDlGH4y4gA5f5lBYQ7umtJR6bIcaHtX7coKgylAjLxVjJ8HulbxSmAJ9qeW47G0/Uou9hNEg4jbAo34mjB0inxj4iW2/cV9we0xqxZ4y5NYk6+APDNQ7dTX6u/QCVSLg0PUGk7k1pJ5gZ+SMa+kh+JDRCHPU0azpHVlY5HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749901; c=relaxed/simple;
	bh=LvIwEt9m4PZX5YS6s6bai7V/uoYy8UV+VJWPaYEteWs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V/sJmQCRtoFDjU+pANTdgOyClgZ8BcwCM2qplqTFjBWYG0FdPqWLyuGCEjucj5f/JKx5tQzGaorwThHWmzBfSOHZt/uosUxjizIlh6xJllnjDpYCbyKCqcsHBfhUC9qDnOqRouHzBLaVc7D2qWMUBmPt7i8HdODqS4q75cBODYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RFsWa0oH; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq5BfWweYICz5aj7KLeBQcc9flMzNSuJ9yJvC5PhDCQXlS8NwifzgCJyEpXShYPMdgG0Jcz4UDxAJki+czpJZOXivuPel5JqLdbf+T4nA7RMpVujRk0xP2dQ5ceTtMMWg7NVhLDkoi6WC/iIzbtFKQxkMvnomJY4eG54//ig1knhZV3WGigiro8c4h9V0z1hKR4m2GY3Xq7d0LZHTmg1wMf2t9PvQ+uHlRMssHZrq/PMM1SZ48ZjYL8pK4MeTWx+NmkBfbFc8CUmPkckLMKHrnlsVnXzY+iW9Zp2eBhIRW19dCd8Y5Xffb7BeQb2uMqvhV4PhVSgI50tkGRDQpCoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0gmJECjFFUTy9jMnypCJ5tQRc4+x0jra3k6HfkoTL8=;
 b=mf8MI5xTKDZMktM4qrFhY5qTxhprW3rf9E61K6aHYZUHkfZv7MOUPEzncsAIlFOnXIpq8cPG5Hs1Ir2x7OQpTg3z7KzpCwtZRTn7I21z1ZCGy7MwwTlyMcFRbyr+nQOFeQHRX41PDpkpDQ/MynCkgpTvb8j5Vc1wUEV78fimigL+CF6HXLj56R4RksrmtXa90SFkxZB7tYgffjDYTQKq2oF7d30z2z4tVAgYmuG7S5RYhjIc05nfamKMddX0PcYM4/nYuySSv/kGIoxdYW0ag0nGFA67eSwKQeybHesAQK283CVG3jXCwDfE2k1g5TRu5Iguj+PdgabTiJunrK9xig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0gmJECjFFUTy9jMnypCJ5tQRc4+x0jra3k6HfkoTL8=;
 b=RFsWa0oHjJX9NoqNKxKlFYNXGSgHDUFSmA9n6YUFyJe7BOfujskMZXe2p9tm/kJWRXXg7MW/+lzhVA4eUyTqygOtbmUokT2PcVtJnzay94Qn6m/+fn1RHR0RvZeAbW57HCkhS95Yf1Wm630HRx5j3eAKdxPNaA1LaWD56niq6RhoOwmU9RCS0K9B4DTv/P0Tt2jylxwpUFtesOXcmbDryj0YnGXZuRkIVuSt1SbwjaV5uwKiQeXj2aVvOUW21iKZeHopSdBG7rN87QkZ8YtlK8vWwTMuI71wF38qaa9LWyCqPDQhAKj+7Nweva0WWjRPtaUO+ZXyqySNfLINLupQvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by AS8PR04MB7496.eurprd04.prod.outlook.com (2603:10a6:20b:29d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 05:11:35 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5%5]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 05:11:35 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: ulf.hansson@linaro.org,
	s.hauer@pengutronix.de,
	Frank.Li@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	khalasa@piap.pl,
	benjamin.gaignard@collabora.com,
	frieder.schrempf@kontron.de,
	p.zabel@pengutronix.de,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: imx8m-blk-ctrl: fix out-of-range access of bc->domains
Date: Fri, 30 Jan 2026 13:11:07 +0800
Message-Id: <20260130051107.2130200-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|AS8PR04MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f19862-70b1-4aac-0030-08de5fbe09c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JfC8pjGZn/RQRnwLHYZwu9f5ZYs4Siaa1awIHxQ3OTh9Gv1HMdleZcOXyRQv?=
 =?us-ascii?Q?ceABkn1JewcK5sVuCddClttaj4HVC5OdW9VFyVUnDQ0+U+ChR+aECffLtcLf?=
 =?us-ascii?Q?+2pkcdraNYju3tgVzc5GO5o1cNMApPRNZI830aVr4gXcffPJ5WRpES5Wuhi/?=
 =?us-ascii?Q?QgDtVj/kYm9NRxjQZQNePCIxYsFcsGOW8Ez4A5K6qEZF8bv79lbV+ltAORWK?=
 =?us-ascii?Q?OD8/qKuWbEzWTqFgxsEOKuvBqJ22RDIhZXPTTgSY7KA0h7j+h0d3WyHlD/TY?=
 =?us-ascii?Q?hgXU/9iiyCEJM9iPszn17A8C0qwyWdzFcWFgnQExmSR/RNcOapz2o0ac4mjc?=
 =?us-ascii?Q?ghinmhzsE6uS5rkTOyOCG8rue3e2pZnjPE5W0F1yedYJ6ysULgjnplsRe94+?=
 =?us-ascii?Q?evYjoMq8PKG7MNzCqS7R8eUfNcl/ES4HdEjH9q5xmyDOPaQWRP9YwoAGMVvG?=
 =?us-ascii?Q?WONdY1yeoDYw+dKcsaVFt8NSomnFkKkJObbKgvWtWa1ghifaQk4dXqaZEi6S?=
 =?us-ascii?Q?m7cyjdRIip7t4kLEQBXQkoVZyzhNg35Vd6m1VZUn4nUHXwwOtLDhjCIM/4F0?=
 =?us-ascii?Q?Xwu8O01u+tHuaLeRQWyem0a+Y+uxfic4zG2G1iIQs5ofLjwcMCZwuL2p+G+z?=
 =?us-ascii?Q?hgHRd2NJKdzgF+DPOL7a497Q3cMqs2Nbj9zlNjW/ZVyC5cH5NkNAAzunfoYB?=
 =?us-ascii?Q?INrYYnIscCjOKTIrq1L25hnMfos8JTNjZYXvcq09CzZ0U2FoGCkXqQC65+tV?=
 =?us-ascii?Q?e3OGPNAdlNzuJ+fXflA37nwd9uboH81MjgP88K9+T/C58tU2fcLdiLmsM6Xc?=
 =?us-ascii?Q?4UdMR4wgX2ewMukXu9Iw/C4WeSxtd35C7aS6cqZtkHE/T/rXehvE2Fn8BfWK?=
 =?us-ascii?Q?slUnIgoK1eLcqeyqTA5zNKXq/kwtvpIq/v2MTvl5nxTFvOTjj8GUowBkivJA?=
 =?us-ascii?Q?OwdT1QxFpYzbJNb7r751070X7R90IhD9QDqiR4TzlTAnqRQArAdnj9GLRNms?=
 =?us-ascii?Q?MHEJiYGK6pSmmn2m4vMmhiViRotH0ndX3B704VkYe1SMDzvEvFmTvZZoe1oZ?=
 =?us-ascii?Q?n62TTjctvm9gQr9X/BzxNL2iS4YCi1HxorJxTCF4EodjX0i7O+0S+tZnf4Su?=
 =?us-ascii?Q?21bNDCQ2wADpn4KueCSidHb31OvrAV4ULH4vMRXHSHx00qyNL8HlSyN/LbQK?=
 =?us-ascii?Q?sLrAIqc3BHaN1fZ0fKyQLWrf47FSjeVGDz2ltDBN2P5jnd0xp6WmE4VrFhA3?=
 =?us-ascii?Q?JteR4RoFbg8IIOXjgKP8RM0jwkF1n1eXhF3pvgu8q+xJ2NkH9/2kNKCFih8H?=
 =?us-ascii?Q?wAc9Hz+8g7DVgL4x/7T0U3rw05wWcsTiEDut7C8ZzwbAuRX6Ud3ZeOVKKvA3?=
 =?us-ascii?Q?aoZp7wMb6EruKXxsKXpjmzwc2Z+Dd2PSKSJ8u+eBgB0QGgSj7u8cKw26HKVO?=
 =?us-ascii?Q?z0R0beNj45rQ1OUGC3qRSzNBQsyJnRVJhbjY3/vWtXjLz9kkAWvOnXjEudXV?=
 =?us-ascii?Q?e4oZ5WBadbrcQJjHWr3VjtPYvpJaA9wjo9+q8CMzGH9vU67HxHCRvVFGd5ZQ?=
 =?us-ascii?Q?zr9uvRjYvczidAB7snIlk7hkeRaqEe5ALRAqOOzfzT5d+AyGEsJCJqBtk4dk?=
 =?us-ascii?Q?bG64MoRwfCy2OKRmB1fOyPeHGkuJ8lf2NqzrCoIwJeux?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hkqHfqVFRGhyWI2+G3OIoVk7HI4bBi0/hr6NmMEt3EHakGDZMLYfPM+obQA/?=
 =?us-ascii?Q?muzQGb7WmaS8oDZQgGJ1kwGBpKDmmo8yRyL0+NDTyfAfN+O3JZpyiGmjCRDL?=
 =?us-ascii?Q?DT5lNijmZQGv4B0mf8DuKtVpIKxSAyKSw4wZGb2wyG1q72YDrd8BKLKAVIqk?=
 =?us-ascii?Q?wLmQUhE6ZbpBqMXJSDoNR4dIEHBBttUNsz3cRlRDci9HML2owoNWvdGdAi8Q?=
 =?us-ascii?Q?hOWea0hUAl5QzVHXMe1B2d9/cZ3nWA1HbqFYafOjp1LiVZVsuiZ6ZJ37K1Fb?=
 =?us-ascii?Q?IexCJ38/NaFazF6ZfGIaSMoxPvpXSziNZU7rRhVCosoXDi8sju0qY+0iIz3g?=
 =?us-ascii?Q?tQ6QhJLqCmeFt/RYnKlJXNPAAMnpZGOsSYpLJxXfmze9plzbJhm+iKc0pItE?=
 =?us-ascii?Q?gUINY151BQenGToiKIjSg+WNd0CbzITNXj3xPU58jLSk6o9PydO+HwsPeRpp?=
 =?us-ascii?Q?fs2KuedRTLbOwR5GbPrTTeZ8ZJKxTQZ94tWniWAaULENC5Rz1F9XWLQD2Pln?=
 =?us-ascii?Q?ppSh+4MWzm0OSGCOSCbglVbrycfGQaeixGuZrKF+iFv7KP1SKz5wNMMpyHrq?=
 =?us-ascii?Q?63CwJJzQpWSw+NYnOrlkDRGHkitun89GYAqwE/82dqK/Wo9CR701zChm8b9/?=
 =?us-ascii?Q?EVYPG7V/erPVO7E6sxqWPsrUddDPN/luEjBcSp4qDMoN3Tq8l8FecGHGtmh0?=
 =?us-ascii?Q?DUW8VNp7AJnZMVrludKX2QhZWQXWhto4xBrGeNkd3pKigtJiP2VFIpQGS4SE?=
 =?us-ascii?Q?+0JC9jWz+4ewYe0hBJIz+0I2f5jjv+75Bm61Efh0mnulftCttzONS2GkCdX1?=
 =?us-ascii?Q?YOYDPaER12Ct/PIoD55xzLuX9h6AwPvQ87PvfDCYqcRyistN6Z1BTgJwrIDC?=
 =?us-ascii?Q?Mmh+B2Q2pZjnl07CVSpCEqq3zSxtWN1f2GDqFP8jaSlXQFnC+77QiQvvjAnJ?=
 =?us-ascii?Q?MMJAx5AZy42gtsROCeAQc4F82BKkMFZxPOVyZ71cp1VIibxC0iQ9mfXFM4c6?=
 =?us-ascii?Q?bKExvevwGl4LJYDO7DJQvQ8w5C3uzICE5XODOMUPgcf4rWkHdFAcLpwza1pR?=
 =?us-ascii?Q?AQkHwoBP39O1fik6wTOIz2owfOvUj/x2LVyFFNDNu3Z8s3u8eEQMEgg2Y9bi?=
 =?us-ascii?Q?jp9KeRTqgpJVXbodhLuAq+U4sRQw6jWQPV8fYfTJi1aiy1Hk7f2GfTKngCYt?=
 =?us-ascii?Q?DHz8XYG+lVujYk6BhjvbBeWdDQTIKgQ06UvzOBZjzZlJ/or47nMDL5qIMoLX?=
 =?us-ascii?Q?mRZMcRIR1IiORK0IOTuO6zz6tnvsAzbG5nas5+GlSdWY9BUrPdkNErNQnm7Q?=
 =?us-ascii?Q?eLFHTYxF++tqnrsNdiJW7vpP5P5Hm9PfG+OIyfTacx8JTTQUjIGFSesvxFA8?=
 =?us-ascii?Q?wR+V3isuN3swfn7VKKqR5gNZc9uTc5PmrPo/ZXbIQWd5ajtBkGhBY/3Gh/G1?=
 =?us-ascii?Q?W/5YxOm9A8WNGp4UGat8ZqVkpidrPeD5+rY5rperLWfz2rf7K3eJ8+UKs80E?=
 =?us-ascii?Q?QiVyNUTWdKMf3kMusIcMCiRI2gQ8PjhZ5ZHJgaHCviCbqPWIkOBAVIr2Nghv?=
 =?us-ascii?Q?ofiWPsk1c/WLwgng+CChGfEM6t0BlPNsBlGKxLFQ0Q78nWjgYDPpM63lTCYr?=
 =?us-ascii?Q?dtJUC3M7pzoJSMOYHOLMEQa/QnE27am6mzQcvF+VDfvtcFwFi8fR1lSfZMHK?=
 =?us-ascii?Q?dEJ59WDHmMnwNFz2LIqDE7z0OKK5nf72CihyhYhv6ha6pDFdjON/KyqB/SeH?=
 =?us-ascii?Q?UGRaijPRvQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f19862-70b1-4aac-0030-08de5fbe09c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:11:35.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiZrKTitPp28vKtGlJbB4Y8yJNOR+aHvZSwHbLIY0QbU3CHrFai07hDp7Tfzjw424PGYJrbmj0Yi6At1wIphAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7496
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,pengutronix.de,nxp.com,gmail.com,piap.pl,collabora.com,kontron.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-41744-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6231DB7381
X-Rspamd-Action: no action

Fix out-of-range access of bc->domains in imx8m_blk_ctrl_remove().

Fixes: 2684ac05a8c4 ("soc: imx: add i.MX8M blk-ctrl driver")
Cc: stable@kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 74bf4936991d..19e992d2ee3b 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -340,7 +340,7 @@ static void imx8m_blk_ctrl_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(pdev->dev.of_node);
 
-	for (i = 0; bc->onecell_data.num_domains; i++) {
+	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
-- 
2.34.1


