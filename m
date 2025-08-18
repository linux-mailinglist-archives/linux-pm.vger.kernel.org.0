Return-Path: <linux-pm+bounces-32520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F825B29E17
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2591965741
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172630DED8;
	Mon, 18 Aug 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="itRUtELz"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857D2D0C67;
	Mon, 18 Aug 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509628; cv=fail; b=sqKj5ldG6pCII/4ac1PFxgJUNxlrLryFSLPcUpTl0eCzxi1fg5tE+esr8n1MnSi0JJx5v010mTdjT7B/Bl9Q5aNnoFlpuF09Wi6bLYjBgP14X5wp/X1QtGnnNOrRwoZoZHWw3vM7YZ3x96va5S9iiQy4bRSnDO2/CLvu4YRN04k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509628; c=relaxed/simple;
	bh=TFYK/I1X+MjaKMu8FsEFbVrIdVXKiQQWSTHi2fz03aw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jIcJ+annzatapqnOoHq606FEe8LPVbUHJZePg+kYGspVsm8oZ5h0M+ikvfxGm/A1UYxp3yC0kWcNLFiLsdesl0wdHOjFF0dAZ7/T2842AbCEQ+N070vcs7CpnaPtIfW6b2w1Fa8qK9HOeyDzgMXZbwDgmmdrwGnlvgMRKqVYyN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=itRUtELz; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcSrIHSLReVje83uJkg2zvs+JCQMpF31qh8N4WfpG6OUAw/WvYjHFtaY8XEIb3rzYgJCSSGlpevPzgZIhWSgZrXSPRaJZLGDxAczKZTwqgAgyiYuNMSQlQ2Rx8DI+hocZQOoud+XPaAj9z+yuhjtWG6voKKOKQuEkdvEG9nIp9aHl9EKiioC8aKbtZ/o1+PSZ4PV6x87xXXdXKz4CO9itUIMOnvmk7etxn2xcxyDeylUtfG8ESRKaT0jWJd8QTBqpcio5Zh+wyOlJC5UXoJ6jK25uvBHfoKPSNRm/zXq9Vfveqn2GbIOFAI57ZgRhIGoJ8DEqk/ubnZ8TxKLW79KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/N3ypx/D0WwwuWvtUW+aECaom/IY2VlYrUqNHoAirU=;
 b=mxd5PqX84VqtEPjpR3poiVMSPc1kpY19dJyQRjUEAG9wig14PRrl25V9uCgbs0EeP07KD+c/Ph7zTQ3BHQhXmbFz7r8DcDsut8ecAQHOHRR2lMZ1CdxVFZqGk7qOwgNcy2crHGiU6y1HqtfFSZzgYSqe1CscoUM/devWgy28BovgaBmwCT4bmkx0720Em5Gd5+7+a35YAGYPnYgBedcl/+0CXM3ZcTehs1Gp5WxykJcWmfTDhpokyJewEME8sYVL8ATOphOawpnkokgPydL9rM78aMnaYoZFIb8/J8NOwgUFU4Am5uctyQBrvrOOv9COAt+xuORhVMsj7T2PwjW6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/N3ypx/D0WwwuWvtUW+aECaom/IY2VlYrUqNHoAirU=;
 b=itRUtELzm/lrtd5pj9lbPqD4pwonaIumZRlYaIE/pRyrkKKNxkyQoYbMAGd/szPl/5EaRFmx+Py7iPsFrScj0hN/61wBsUKmmD60+krUy8tJd5JIH/kfBYPwNsUbp2z1z1SYyBIYsr9gdAICrcnBLmKw1dCHxyKtc2p6U7pYm+TQJ+0qZ/y7c9+39/h2PXuwQQvUAFVG7ekYNQbVFLZ9XX8uNMNJJANrz6vO9pbXt1rIdxPEvcLFq6Y9QDm70UIBiuwvKmgsJi81oLKfVHqUpmcc52HA7FTImjRVuM19nHoWxgo9vysx6OhvvKHgjRRH3Hg3kgy8NqBThmp3wzdnag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.9; Mon, 18 Aug
 2025 09:33:42 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 09:33:42 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Mon, 18 Aug 2025 17:33:13 +0800
Subject: [PATCH v3 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx93_tmu-v3-3-35f79a86c072@nxp.com>
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
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509601; l=4895;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=TFYK/I1X+MjaKMu8FsEFbVrIdVXKiQQWSTHi2fz03aw=;
 b=BhojgpbwrlSizgbnjjXYPUei7w+FIN2sf3pVznj77HO1H3FxarsWUjww7tfhNPo+XfrKKGvAF
 mozP+WJm4LGDrnzy5UZ3SI15cRvALCNujYlDNG5hhGQK9wxwn6RfUtv
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
X-MS-Office365-Filtering-Correlation-Id: f7c499b5-fb23-427e-c70e-08ddde3a520c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RURNOWVVaVZDUUhYeWlOZ1ZXNmRyYXhoOTl4bFNSRUtKZm1YZTZPd1liUXpi?=
 =?utf-8?B?OWYwbUtNOE5SbTVQOFIwWGptR3RuOWxwWEhLOGRFR3JLc0RBb0tmWFB1czJt?=
 =?utf-8?B?Sy9VOWk4UzNiMUc0ZGY3QWdQemFxajR2WXhldlJwSXZyS1VrSFlMYmtyRnMy?=
 =?utf-8?B?a2lqSjdoQnpiVVYzT2oyTkIwandwY3VnZXpuUjVHazBwM3dkN2dOZ1lZbU8y?=
 =?utf-8?B?Umw2bzEvSGlsdTBGV05KdkVSdlBxWFlhQWZoQ1dEZHJ6RS9Xc3Jidlg5QStS?=
 =?utf-8?B?Q0RsaWw2QzdESHV5TjV6SzU5c1Q4ZThjMDJCRnppSWMySHlxTFNJQWgwcVFz?=
 =?utf-8?B?cFdsNkJubm1Dcmw2WmJTTnREQk1SNVRrQ0FBRng4Z29qbTJ3cDJnQnpxdG1k?=
 =?utf-8?B?eEE1OUFzZkpGekNKbU1RbVNBQjRlVHpTeStra3RCWmxXWTlobkFWVVdyakc4?=
 =?utf-8?B?QVJFZHpxeEJIUURTZVd3ZDFSQ2JXazY5YTB1d0JCdUhIVHJ2bmNwZytZUGMv?=
 =?utf-8?B?WUFFSkYyd3g1eUJ0dTRTbVE5YWpLOFJxVExScHlENXNmVlV3RWh1NVlic1dk?=
 =?utf-8?B?WE5PYnBsSmhNb29UdmFTbzI5WnNqdHJ1dU5tVWhZVlZhRDR0Z1RNSk9VU1lL?=
 =?utf-8?B?ZGRQZGYrR0JBRUdIdE8rMW52VEVzRTNKblgwT285U2k2YWpFRm16bThWSklX?=
 =?utf-8?B?c05QRjBHWUJNK3BQTDZSaTVLVnA4dnJZakhab2FuL09FRkNXWFNDTXBuVmJM?=
 =?utf-8?B?Rjh3TjQ0ZzhOdndMazNDTkVLQ0dydXN5VkIwNUUzU1BSMEJFS1NQOFFhckk0?=
 =?utf-8?B?WklhOXR2akFDWXlxQi9wSTZFUzhLRVZpZnVmWE9ITloxL2xYVGk3YWN4ZWND?=
 =?utf-8?B?N0I5eEdNN01MRWtQeDJ6M08yQkJuai91Z1cwNjV4Y0ozUGQydVRTNjdhODlB?=
 =?utf-8?B?RWFXb1R3aDU3YjJQN1I3bURrZVJyT1VtYkdGY2JIV00wczVzNlhKOWhLRS9n?=
 =?utf-8?B?VDk5c2ZzY3NjTnI2V3plYUREV0pCOXJ0eDBvRnVweEpyY0tXRzIzZTRTVXFP?=
 =?utf-8?B?U251eGwwZzkwQXFNd0lSM0E4Rm5GdURzeDdaUWVSY1lacGZPZmR2MncvQ2hl?=
 =?utf-8?B?T1Q0MU5TOHFNNUxwUzJFMDRrdGR5aDdDWGY3NjdKWGY4dUpUK21iYnJrd2Vx?=
 =?utf-8?B?Mk9OYzdBM29uRUV0ajNGM3FJU0lDMWdkSjJyWENydi9pVnZNNmovbjRYTkd5?=
 =?utf-8?B?a2VpYW5KTlpWU1hYaW9TK29UbGRsZXNIUFB2RS9VODl0SFFPcGpPQ0NVQ0J6?=
 =?utf-8?B?R1JNN1N6alBzSUFPWGpTOHBxbFJvZTBCRjY5czg4NjRPVTN0SmNId0thU09s?=
 =?utf-8?B?L1VpeWVGeUNabkZwbWttQlJ4QWNzTDZ2dVNBcXpoZlVoTEQ0MTVZcEtPNjg5?=
 =?utf-8?B?enRySEdMb1dNUGFHY1NHYmJ6OEpMZDJpNnN1NWdqZ3ZTSUpjZVpRNldNcGFm?=
 =?utf-8?B?dzhsNGVEVWpkU2FVZnoraFZWcXJ3WExUUjZVRGYvQWdJSFRBYlBOTEcrNFB6?=
 =?utf-8?B?eEFidDlYbzBxNEFLU0ZZVy9heW5zREtmbnhiS3NjZFR4MkJUSHIxQ3pQQzZh?=
 =?utf-8?B?cVhwcTg4cWd0ckRFMVMvRjdnR2tBOW1zMjdlM1paQ2VOOExFVnJSTDdNY3hH?=
 =?utf-8?B?cU1SQnJIWXU4YnVrNFZKLzBUK2V2U0UxSDVTUFhObEUxR1M1b3JNdkhWMVFV?=
 =?utf-8?B?a0h3dXBvZVg1YnNQUlpFckxqck9HSGlEZlVmajlsa0lyWC9EUUFJUkhCdE1W?=
 =?utf-8?B?aDlVUlRnVVJLYkhLcWxBdEN1ajlWYlJmTUZNUHFHSDlFRm92dUlwbmRrUzFv?=
 =?utf-8?B?Q0htcHpGZmlmTVZuRzNNV0pReDBReVo2b3JiRGpHQXpTbENkcnZta3E1b2I5?=
 =?utf-8?B?citBekdicUlpWS9JWFJnWnZuUDlXZ21uQmlkMHVsRzQ3NmZOWmtMVUt4OVc0?=
 =?utf-8?B?NVFYUjBHOFFGbnNiSkdzTFRBVHZUVTQ5Q2dFMzdVNm5JQ1NNL2xFWEt0QlZ6?=
 =?utf-8?Q?lztE26?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlpQYWs3MzdtcVJpTnpJSjMwamdOWWNQU2JYR0RTYjNVbE5lSUg2bnFzblNV?=
 =?utf-8?B?ODBTVXNKb1BOd0xBckp6U0NmR0Q0cDBLS0dTTkNXYXBEclY3eHlla0ZKcXF1?=
 =?utf-8?B?ODJreXd3RWhVdVJkSTJvdkdReVNySnZNbm1ucTZ3bDh5TGpQc1I5VUFyaW93?=
 =?utf-8?B?OXpsQzJrK1g3Q2N0ci9nR0JmU3JQSWxkaWxaWVBVdFlzZllYckR3WlFQWnM2?=
 =?utf-8?B?c2RObmFiWVFFZDhrYkpkcFFQY0dzZG5rS3lRdDRRZGRRMlFyRVVzVUJaWEtw?=
 =?utf-8?B?SUZTb3BHYlFHY2J2Nk4zOXBHNVlTSWtxc2w2R0JqSkl4UkJZZlFXczlCc0Nu?=
 =?utf-8?B?TExXaUl6NThNR3FFT3BXZkVlUUozU2NKUzR5VDVXekcvR2RzZVBHd2ZPZnNm?=
 =?utf-8?B?VmZ2cDJxNnkyTTZLdlpxdmFMWjlLaVNYdXVWYit6ZWlrWm5vd2cvV0NhYk1w?=
 =?utf-8?B?dUhZRWp2Tko2VG42MnVDUENzZjRUTlZrbGlYc2h3RXk3OUI4MllHRTVMaHJp?=
 =?utf-8?B?c1A1NWZSVXRXZDFRTzFXVHlmcGZMRzErVDBoU0FobUV3S3RjQXdENlVvQU1U?=
 =?utf-8?B?Qk9xUkFXWmhtR1MzNnc4MHI2OXlpZXlCNmEyNVZvVG42QXRwUVBVSUtBOTJv?=
 =?utf-8?B?ZU51S3VEd0JWdk8xRmRkbndaNDROcCtTQU1Dc3p5T1hSS1c3NXpudHB3b0VM?=
 =?utf-8?B?YmlFazdobkVhcUw0K3ZBaVZvSll6QXdSNWM5d2orcVkxUUhIaHFRK21XL1BQ?=
 =?utf-8?B?YjkxNDNUMzFBdVpQaS9KUXJXdVlUL0RwV0FwV0xiU2RoT21TbzJxK3dpcXlH?=
 =?utf-8?B?dmdSVWx1dkFiTVZ3RXJ0cjBZME5MWVQ0elZHdU5vZFRJUmNUT0pCVEhDdVp6?=
 =?utf-8?B?VnhaV1N6dHpIdXZHN0N6Rjd6OHpjQ2lIL0Y4NmtIcDhJckh0V0srL2dSWmJO?=
 =?utf-8?B?UmxoN3RBbU5IUXFIWEd4bkpGczV0VkhYMWNZQWdJeUVHVW5BTkM0VmJIenZ6?=
 =?utf-8?B?eGdDZ2wydUZtWjVzTStBNWF5K1VMeHJYTmZKQWJDNldIQWFVR0VjUWpvei9v?=
 =?utf-8?B?V0dEMUNsR0p1clpRcERiNDh2S2czNXpQS0R5cVR4Yko1RVVtUDAvUlZDWXZZ?=
 =?utf-8?B?RWxJWWJQNldTL2lJNUIzczNoWDA5U1JVa2lJZkxhVXNIdEZ2c3hNR2NLemVW?=
 =?utf-8?B?Q0dpdjkzU1RTNElQb0d1VlRDKzkrNmd0RWVkK0t2aCtVZnRMUVY0UnNiWjNm?=
 =?utf-8?B?MW5rcDVkaG9SNjU3Z3RDZjB4RXhabHloZnlmcWhyQjFCUXh3WmdUNFp1S3F5?=
 =?utf-8?B?Y1loSkFiRkVRV2JzeSswa09vK05md0dhWUV4bUNQak9sVzFyemF3RitOd0V1?=
 =?utf-8?B?SVIzallYWDRVTTY0L05wQU9hNHE2U25SNjNRemxzcnpJWnBXSGxzR2RKcjBP?=
 =?utf-8?B?SGl4dW9zekdneVhZWlNCMkJhaElPN1V2RDZpN1NBTnpmb2RpeHB0TlhzN0hx?=
 =?utf-8?B?b25KQm9rSnpia0gwd3RYeXNYeDd1Nm9kdkpwWjBDb3NIM0hkRGJsS0l2TXRU?=
 =?utf-8?B?elZYMVNQcHlyZ294Q2tySHgxSEVsS3Ira0ZUcHh0RUgxYXowSm9nWEdBZVpK?=
 =?utf-8?B?TUpBbUxQVFoybURNYytJUis2djFtRXhQR3UwTGs0U1g0OFFtRnBEbmJkajlH?=
 =?utf-8?B?YmFXWGJ1cnJlclIzclZsZHV4MHVmdFRJRHlSSThadWdxc2wxc1JRT1QrZTUv?=
 =?utf-8?B?VmRCWGJNeGlLZ0ozMkp4a0dPMkd2dU84RTBWeEZkT0xsK0FvaWdISzhoWWVa?=
 =?utf-8?B?TXNMQlNtNGRmUGwvTldJUnZWU1FkQXZzcTVxRDJtYk54c2Z1ay9aUmYwRVRG?=
 =?utf-8?B?K0JwLzExSkY4MDNtUS9sZTJHSTlEME42c0haNWNPNUNJZWRJb0x1U0lrM1Rk?=
 =?utf-8?B?dWM4N3BxVE1HaWR0bk1rN2JwSU1XZ1ZKWUhPNmE2c2JDMVk2VTJuWmg3ZXRY?=
 =?utf-8?B?MTBrL3psUGc2K0xyUW1ZTGZLSXhBSTkrdS9XRktZZ2kxN3o3aytrUjZPMThp?=
 =?utf-8?B?WHBHcmlVbnRNMm92V0ROYmQwYmtReUQ2RXZWRmlFdG96ZVpsUHdXQk9rZUdk?=
 =?utf-8?Q?AjXVuJVksjzCFXr2rSKH6DjBf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c499b5-fb23-427e-c70e-08ddde3a520c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:33:42.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qa5dx4RgaGOFJxxawGiIgSXBuGW7n4gyI7eCGB3xmuq32wxbMj0HXMpWXHBfTsvfoqNRtzdbvK8BnGqCAkR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

Invalid temperature measurements may be observed across the temperature
range specified in the device data sheet. The invalid temperature can be
read from any remote site and from any capture or report registers. The
invalid change in temperature can be positive or negative and the resulting
temperature can be outside the calibrated range, in which case the TSR[ORL]
or TSR[ORH] bit will be set.

Workaround:
Use the raising/falling edge threshold to filter out the invalid temp.
Check the TIDR register to make sure no jump happens When reading the temp.

i.MX93 ERR052243:
(https://www.nxp.com/webapp/Download?colCode=IMX93_2P87F&appType=license)

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v3 changes:
  - refine the code with FIELD_PREP macro
  - add errata doc url link and refine the commit log

 - v2 changes:
  - no
---
 drivers/thermal/qoriq_thermal.c | 42 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index b2e634547271dcf512c714907baa162921d2d527..134a63abb482d44b5cc78e672e6312fbdce5ba31 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -30,6 +30,9 @@
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
+/* errata ID info define */
+#define TMU_ERR052243	BIT(0)
+
 #define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
@@ -45,6 +48,13 @@
 #define REGS_TIER	0x020	/* Interrupt Enable Register */
 #define TIER_DISABLE	0x0
 
+#define REGS_TIDR	0x24
+#define TMRTRCTR	0x70
+#define TMRTRCTR_EN	BIT(31)
+#define TMRTRCTR_TEMP_MASK	GENMASK(7, 0)
+#define TMFTRCTR	0x74
+#define TMFTRCTR_EN	BIT(31)
+#define TMFTRCTR_TEMP_MASK	GENMASK(7, 0)
 
 #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
 #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
@@ -69,6 +79,7 @@
 #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
 
 #define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
+#define CHECK_ERRATA_FLAG(drvdata, flag) (drvdata ? drvdata->tmu_errata & (flag) : 0)
 
 /*
  * Thermal zone data
@@ -79,6 +90,7 @@ struct qoriq_sensor {
 
 struct tmu_drvdata {
 	u32 teumr0;
+	u32 tmu_errata;
 };
 
 struct qoriq_tmu_data {
@@ -99,7 +111,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
-	u32 val;
+	u32 val, tidr;
 	/*
 	 * REGS_TRITSR(id) has the following layout:
 	 *
@@ -124,6 +136,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (!(val & TMR_ME))
 		return -EAGAIN;
 
+	/* ERR052243: If a raising or falling edge happens, try later */
+	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & GENMASK(25, 24)) {
+			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
+			return -EAGAIN;
+		}
+	}
+
 	if (regmap_read_poll_timeout(qdata->regmap,
 				     REGS_TRITSR(qsensor->id),
 				     val,
@@ -132,6 +153,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
+	/*ERR052243: If a raising or falling edge happens, try later */
+	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & GENMASK(25, 24)) {
+			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
+			return -EAGAIN;
+		}
+	}
+
 	if (qdata->ver == TMU_VER1) {
 		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
 	} else {
@@ -238,7 +268,6 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
 	/* Set update_interval */
-
 	if (data->ver == TMU_VER1) {
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 	} else {
@@ -246,6 +275,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), GET_TEUMR0(data->drvdata));
 	}
 
+	/* ERR052243: Set the raising & falling edge monitor */
+	if (CHECK_ERRATA_FLAG(data->drvdata, TMU_ERR052243)) {
+		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
+			     FIELD_PREP(TMRTRCTR_TEMP_MASK, 0x7));
+		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
+			     FIELD_PREP(TMFTRCTR_TEMP_MASK, 0x7));
+
+	}
 	/* Disable monitoring */
 	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
@@ -389,6 +426,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 
 static const struct tmu_drvdata imx93_data = {
 	.teumr0 = TEUMR0_V21,
+	.tmu_errata = TMU_ERR052243,
 };
 
 static const struct of_device_id qoriq_tmu_match[] = {

-- 
2.34.1


