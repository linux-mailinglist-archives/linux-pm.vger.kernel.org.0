Return-Path: <linux-pm+bounces-39455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B8CB82B1
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 08:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C846730852D7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3430EF63;
	Fri, 12 Dec 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RNgDjNlo"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6130F536;
	Fri, 12 Dec 2025 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525915; cv=fail; b=dIU7zVeubiAVSBwt2PkYSmTHYB25gpIn+lRFRWZss31uMVzN2mYi5RERai0MBPC7GAWNvYziTjOe0lg/em2fQKiyqyOZq7+9fGxxsNVUNRLIFjy1T9Bnj1Wf3kweERTvznC9gjXQbKBt3Oc8hRub0u+2Mw7cjn5tmJYOSXE4GiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525915; c=relaxed/simple;
	bh=+htAiCTWeCd2wbf0417ox7vbWhmDlqyJmbLm13awSmA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nfSTJ4wzpChzF7Dqjo51RPmPeVpaKz2d2mbuVwyVYGzySFfijNVfZYgHsvCK96QGVwUn9XLv2TiScrvHM2iXVlVZFs2udlw1J7Z6ejIE1oMv6kMDWziGgLfMWzyKBbkrrFR/7pcyyrgwzxTDflJSiCHFUOtgbZiKAzUwEsx9KYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RNgDjNlo; arc=fail smtp.client-ip=52.101.83.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyylLJGad54Cd0gF7JXRXhtoeGz0GmraSbEztFtpda2hfhr3WRdIoMO5tYPy4yEsNatG8Qrnzy/wIhccM+/6T+iGr1xcPSgQDrkeRTk4eG8oeMmVzYOushMnBWfP5X9nG/Rd/fhBYvVcPB0BJdTcSIBN11LxnlOOTw3XPzrLFxWVVFj0IsL7hG8w8tqvSVyD2dECO7o/vDzQkdt4GREZsfo7gDZgEBal9592AQz4jb3cK28A/sqROr1NawU68ryZIDVSNyhqDpxYZPtkHkJPjaxw+jjv6lcFboqV4woyfRHCsnzHucJdjZ0Y13LB091iRbDXriMQm+2KQJAJ6lhncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpXHO/ajrgH9baIIQoI5AZpPTHMdJH/+n/xG2aCWfdw=;
 b=LjPDSgPV0nbHOh6UCCfsWiO15SjuQfurkirx5eC4Ek+xezGYRKH59kW2gL/yZwcEUlUk4UoeN+5m2Y1Cz6y0aKX5hYobYhQSEWWF3azvBWw4YUMc313EmclWv+pAA300dkRkGQgsko6e2K4qlOzSHd5/2F1eWSKLMjoSOzHlHts7aUH0y7NRm180A4c78ASzLDy0cEYyF00ucerYSKyCBt60q/U4TsLfLJYJLQL+v9DUyNpHGE6PFyIBLrBrPHTQyiDDVEbAyNZ/MjJl64IKhkQ4T9L8I4/KM+4DAW1rSCEtL3sLvC2jBwyTZZW3Eb7YeE1F1lQZPSPu5x44WMoiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpXHO/ajrgH9baIIQoI5AZpPTHMdJH/+n/xG2aCWfdw=;
 b=RNgDjNlofgyWLQnC/jTUK3RosPAvRibFXTtNW6QIu39GMbPtwS9GaOnkqu22SFrGv5y4b9nvtGx7BEw/wMWkdjnsKfSzQsAJVbCNkTzhBKNE0egoFm/x+RtqDTQaHnpwKyahUzdgPfyEOTbk5nVq9mAFpxt/M1OspSGTfoueZhZR6+koK3FO/LmfpcudxR7r8oA6bL6wIq0jUQG2Y5an9bi0SCV9AHQhjkkLjLiWfnkBeSTX3/65SCBkvSU59dIZGuKFlAyaA8WfCbHMpUPM7hmPCZMNU8eNOBkEwL2GYkTs6dwMHA43VI23MWBuZiYX+X+RCG5cVqGa+nIIQym9yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10608.eurprd04.prod.outlook.com (2603:10a6:150:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 07:51:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Fri, 12 Dec 2025
 07:51:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Dec 2025 15:51:16 +0800
Subject: [PATCH 3/3] thermal/drivers/imx91: Drop macro for continues mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-imx91-thermal-v1-3-c208545b44cb@nxp.com>
References: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
In-Reply-To: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cb10d9e8-8ced-4131-ec38-08de39534e50
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3BOT1MzRStQcWpKMXNnNGVrbEF6cEtFaG9ORTNaS2pZMVJJdHQrVklFRzFp?=
 =?utf-8?B?NkxEa1M3NHZxVFpoTTVjNVRRSXFJNjBrTjM2VmE2Ujl2ZXZJVGxhRVlMNEZF?=
 =?utf-8?B?SEtBUmJLRHl0Nmk3azE4bVp3c3ZaVWxTOERpZTRSbXFkMnpVMWhieHNUQmJl?=
 =?utf-8?B?MU1oT3BrRkluSUtmeTBpQkM2ZXlwd2FONDhFd3h6a2hFZ0dnU2hVakQwa3VV?=
 =?utf-8?B?ZFhQditjTGw1empOdGxPanpvRHE3VGNQSjFvS05VdGFnS2RlRUFsRDA2elFW?=
 =?utf-8?B?MEcva29ubW1scms0aXpML3BYcGYvS1Ftdi9VVTNlUW83My9mNmp3Wk5JT2NS?=
 =?utf-8?B?U0tKL3dqalVkZnFQTWcxNEZOc1BNRVBBT3ZySHpNZXdKbDZndUoyb0w4ajVX?=
 =?utf-8?B?cU1aK2EvbXNnUFd6UjhaYmNkbzNQZmw4WFdnTlk5MWcvMnRLRHExVDRYSGJ5?=
 =?utf-8?B?Y3lQelZKQXo1Uktnb2I1amdUL3VyZ2tZUjd0ZStYdHNndFdCK3V5cDcrRXNq?=
 =?utf-8?B?UDR0UXdQbXJyMmoySDBXYlU1MXRmWnBTeWJkZUE0cENKa3R3RjI5MkJzc3Ur?=
 =?utf-8?B?Ry9QV29zdUNVYkQvdkFCQkhUcUhWclZ4VUxkTVdKUTQ0SnNSb1FrR0dkWVJJ?=
 =?utf-8?B?MllVMW5XTXRTcnlTNHBodk1iY3hBbm1KRE1rL25GOWUvT0RKM1QwSEpIRUEx?=
 =?utf-8?B?SU5nT2hhMmpwMGJYcW56Umw2bWJJN2lFdTZma3BvRTB3bW5uUk1hQy9vUXRC?=
 =?utf-8?B?TTAraEhkVjN0elVmbHJDOGJrZHVialBJM0NtVTBhMkZqc1BTRzg3bFpMbGp1?=
 =?utf-8?B?aXFsY3o0QUppWkdDVDZpellvc1J4bmFMS3BhQWlVNEZmRlZzMUNIa3ZtdUhy?=
 =?utf-8?B?c0NwZXNqaG5OK2pOeVZ6enhTakRNU0RIZUh4ZjRpVHRmbkVKelgxT3JhRmMx?=
 =?utf-8?B?NDNzbWdoVU0ycTM4L00yT0prZzF4ZXQyd1VrZ2VXN09GVUkxbWU2UWNMaFNm?=
 =?utf-8?B?QVZOeWJnUHFHT1RaeWs5Szlzdi9GVXg2SFhKOXF6RHFSZnExV1J1VjlQaWYw?=
 =?utf-8?B?eGJDRnlTZVFaRjhqTFVtMW84K29ubGJQMTY5NW9tZkIxbDFKenpQZXYxY1N1?=
 =?utf-8?B?Qlk2ZHppQ3BKN1pvZFlvd2tmNThFYzNTYndhL0p1UnVWaytNajBicXByV2tq?=
 =?utf-8?B?d2oyNCtWMlhaTDNtKzdSL2VzRzNHZlNsS0ZDTDhaS0hXNDJNL01JWFgrRE00?=
 =?utf-8?B?czQ3S0Z6Y0xtY0g4QWFJVG1MVHhadTd1UFFoNmJnUXRDQ2FNVTNLVEhaSlo3?=
 =?utf-8?B?TllDRVI3L2QxOWVHbHhrUzZacG5VS0JtcUI5Skh1MlA5KzVoNmJPblc2TWlm?=
 =?utf-8?B?d2VtbStSbHFsUC9RVHcyS2RtWDJjVWZ4eDdlOWwzZTBsZVhvd0ZDaG9SQXRU?=
 =?utf-8?B?OVB4TVkwbFFNejJoZWwyclBwWjBrMVFVUFhONkpTRkRHdEFIdVlmb2FqYWpZ?=
 =?utf-8?B?L05xUXN3MXE4cU4wZ1djeGpIanVuVEFtTGVBRlhLajlleEZUOXBqTEpYQTlh?=
 =?utf-8?B?SXd2TjNXR0RYY0tKQitDY25zOTFjRWV6ZTcydDBHK1pPR2Uzb3VrVVZ0NlBD?=
 =?utf-8?B?ZTdxbXQzVkdka3pPNDBWY0ZGMjRyYmszZk5PZzUxeDUyQmFCd1V4bXVyV0Vm?=
 =?utf-8?B?L2VwcDlCd2JjNDN6dE50MFJxY1ZZNFNCVnJmNWdpY2dTRmZ5L0xkM2s4K05k?=
 =?utf-8?B?M1o3S3hNSkhBTjhrZXhUOE15VkRUeHlEUG1pM2JHZWQ0eWQ2bVY2ZXROcFhW?=
 =?utf-8?B?VjJSQm80WDluMGhXNktLcWU5Y0ZoZnVBdTRqcXQ1SS9yV0FCeER6Mi8xU2JU?=
 =?utf-8?B?VUg1aEJRcHRPYjRZbXpiUHFzaTM4VEtZZFpuajFaMTgyUndoYmdMekpvS0Mx?=
 =?utf-8?B?TDJsVVorNFFVdy9XUW14UGxSTW5QbzBYQ1Rmc0wxUFRUTHB3Q254cysrVTln?=
 =?utf-8?B?NjRyODNuc3NvSnpsZWF6RksyL0FZN2hlZU9jWkFnaWkzcG5XOXNKS0J1QXlI?=
 =?utf-8?Q?d3LtyP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTU2c0p4bUFUeVdleFpEdUlGbGIvQU5seTExK2tYb2tUNTFBdnYvcDErMUNO?=
 =?utf-8?B?ZTdtREZmM0wvdUR0SW1kRjZxTytSNDZxaFdGaFU4MGZzYlNnc0VxUTdKV2Mx?=
 =?utf-8?B?T2xJdEdsTDJDV1lJWk5mYXg3NUl3bm44ZlRFMVp5cHV1SU1PRFZ4L3dxMHM0?=
 =?utf-8?B?QzVOcEZ6aDJ5OHJQMHpTTVdRMnJlMkllZEJiSHZrOXI0Q1REUVh3RmxSa2k4?=
 =?utf-8?B?MnRnUThNWnJjQThtaW9jUkFLVVlpTDI1ZmpUUDF0Nm5NVGdNM3lkbGpvaU1k?=
 =?utf-8?B?cytNcVBnWEVmK0xObThiQkpMRzlCVW9JSkRvaGdqTTNHamo1cGFNTGZ2Yy9T?=
 =?utf-8?B?SlFJUHJVTmRvbnRPeFM2RWNGSTBwZU40YzVkWHBVL0tEa3Zpd1R6SVJkRUFB?=
 =?utf-8?B?d2lxbUV6d1BzcFZ5aEFTVzBlV3VwM3BGWTNJSHdFYXNzRU1lS0ljQ1JPa05w?=
 =?utf-8?B?dnZyT2RKYlYzRnYyUUE3eExqMDhVTEZkaDdqdTg3RURyV2NYMHpiajBVeTM3?=
 =?utf-8?B?RDRHU2NIcmFqM0NrdHY2ekYrQzhBRllSTXF2cVRKV2xxSnkwTy93QjJackFE?=
 =?utf-8?B?ZXNHRmpJak9TVENlVkhYTGk1OUlDVjB0Q0h3VlROaUhxQTkzY2haaUdGYnc3?=
 =?utf-8?B?OFFHdW5MOS9HSU92OCticUp1K01mWUJNeVV4dGs5Q1hvU0VjcysvSWIraFZy?=
 =?utf-8?B?ampjTi9jRTVvMFluYVJrRnkyOWpwYU5TK0k4cWVQbTRlOUxqbXU4NWhqSFFU?=
 =?utf-8?B?bFJnQTV6MGI0aHh4VjlYQ2NGRHRCeTRXcm14RW5GOEdLYWpQQ1BQdGhPN2ZC?=
 =?utf-8?B?ZUlTR0hnblNhZFp5OE5JYXdYOGV6VkcvbkdVZU90SXZZd0xhd1NOQnBCdVhj?=
 =?utf-8?B?N3BKck5mRkdweU9jMFlWMW1yQU00N0p2Uk5tRFVnUmszUEg3dnNLZHBxNlZk?=
 =?utf-8?B?aG5RLzV6a2JxSE1Yb1dGcGlUN2g3RGZHcEJuY053emdHLytMcS8wSzFOVnpP?=
 =?utf-8?B?TkRxL3p1YndsYk82MlRlaitBVDRwcFpncE1ZUTdFbi9xVmlNaGFQTGZGcEht?=
 =?utf-8?B?aXYxaTBBUE1CL1F1dnhleXYrSEhvdTFtNW56TkNVNWlWR1hlbVU4bHJsRzR6?=
 =?utf-8?B?Nm44NU1NdXRITllMTWN3QjEvbnZRbUtGNVdlbjNZK0ErWHlXa3hBakV2N21q?=
 =?utf-8?B?RG1tTWZkT1M3UHpKVUZGWjZVclladnBkS0JsdWNlMXhoQUJIdjhEY3ZNS2hT?=
 =?utf-8?B?UlQ3R212bXVFMHhVQWUyN0gwcGFicXN0a05oOC95U2tYcm9QZlNGYkpKSUdY?=
 =?utf-8?B?a2t1NHRpd2NMM2wrZVNtcXR2WE9IMTQ4SjN3YUJuMGJtbGpLZnNVSzRPOHVX?=
 =?utf-8?B?Mi9QNktYU1FGaU8yRzdRWFR6NGFDQ2FTQmR0WmdndUZ4djFMSjV2eUh1VytX?=
 =?utf-8?B?REFWQytGOFlNYjhHem5IalhSWGgrQ0MwMUtzUXQ3SzcvUlN3emdEMzBSLyt5?=
 =?utf-8?B?UmRxUlFuT21oQ0lTcVZtUUlENjVDdC96dWVaVk1jM3FXZ09oU1VQWFk1cXdh?=
 =?utf-8?B?d3gycVNiYUlzd2p4WG9mU1BMSm9wNE5XSXdielVpc0Ywa25zOXBjT0FxMHdL?=
 =?utf-8?B?clJNOUNLOXBMWlM3bmN0UitjNWVwbitMU1RlY3Q4dEE3QUQ3ZCtZMXduT09P?=
 =?utf-8?B?TUk1MzVqdHNDRHFJREFWL0ZySG9GSDl0YXNPVTM5ZEhjSC9nQnJ2WFpSVUd0?=
 =?utf-8?B?dUxaUWRDWHoxaEFGaklBNG9sUEp4RmVQOExkenJTSHpBMGV2Yklmc1BXNGJP?=
 =?utf-8?B?cTRRZXFhL2xva2NEYTdlc015RXRnRWJOUXlHYVhpaEVaODVmYkJYSnp0VjdB?=
 =?utf-8?B?b0hrNnZ3QnpHaDF6UFVEZnAzaW9KdkpuQjQ1b2E2MXI3YnZUNTAzOFR4UXg4?=
 =?utf-8?B?MmtZSHdFcHJNT2xlOEJ6RU9lSHFyUVRHaDAyd2hsV3RhYWVENzd2eUR4YmdS?=
 =?utf-8?B?aGdkYk5ZS3NERCswQkkwdzU3eFJSSlEwTW9oVG9IVVpkelp3eklvYVByQjlr?=
 =?utf-8?B?aEtEWGZ3T1NmdkVMeUsrb2hoSUVia1U4cjhEMFRTN1ljZ1l5bFFGNkdreXdt?=
 =?utf-8?Q?lfsqXdutuAYSKAK+PJln+Qpmv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb10d9e8-8ced-4131-ec38-08de39534e50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:51:49.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr/BMnfSYL/tcdSVzDRx7zB7MRdYnJI/sMDf9fQvOcf7HFpZi66fcNzXXdzJRY/yaA5UcvbnZ5qCv7vHntjbHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10608

From: Peng Fan <peng.fan@nxp.com>

i.MX91 TMU measure mode register definition as below:
00b Single One-Shot Measurement
01b Reserved
10b Periodic One-Shot Measurement
11b Reserved

Drop the definition of continues mode which does not exists.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/imx91_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
index 768c5acc384eca1c2203098bd4749628d9ffb8e6..aa45eb83f9c7b58badd596d2d433592a9ee9e041 100644
--- a/drivers/thermal/imx91_thermal.c
+++ b/drivers/thermal/imx91_thermal.c
@@ -43,7 +43,6 @@
 #define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
 #define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
 #define IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
-#define IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
 #define IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
 
 #define IMX91_TMU_THR_CTRL01			0x30

-- 
2.37.1


