Return-Path: <linux-pm+bounces-41073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A7D3A233
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 09:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B34E309719E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B7350A2E;
	Mon, 19 Jan 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gi0El7Wz"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57834FF59;
	Mon, 19 Jan 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812854; cv=fail; b=Q+44mVrMRjl8FVaHfrIYfS0butGkQ+OmwUxLszUvUn8ZUcoPwkRJclo72w53Jb+yrGQxWtYcUYemunLhCzLDAyQzddyj649syFz7uYx5zG01N5vo8EzK/bMaT//sW0RAOXLHfhAzlLmFAudn+tDulle61HekufChFRRKS74lzi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812854; c=relaxed/simple;
	bh=yrvwCGbYDvHjYxtNSvVr0fKix1NxJ2eoxC64C+M2mAY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oeR+Wu9+EWpqmylcjBYFda1ZhJvAp0qZBsZimPA+iEnEch7HNSdOZuoSIDH638F+38IEtz2xBG0idsduRkiURi42D5MWxv/mmZCMrD8z60Mf1vuwEElaIs8hbMhonYcesp/4BjDWbbufiKwThC5FdVg07dcps+4PczT5s2SfUQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gi0El7Wz; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgWQ2YEwXamd8N8xqKWwCtvfp/sf9dUuL/x1bUFAjG3I2XI/jl/AM6OmH6QDbe6xGqIGHwCJLEkC5sA1+3PU9GKOtXgt9GRlUzwKA9cDc2zMBdiN3alNR8nys4I0oi+PQOnO8oMLvEuFRGpGlXr114WrDW2mrP1Ib7lMFbjtS0lVH8SJodIYcI6nePDYwaT4Q3vzFbFHc4S1vkbhF/FrOlvQZUoa9lL7U41apq37B+0AGghVt+f1ZnXHwBMcStjkTREqlgTdWSH86axk9kEoG8C+rUgy07c4Q9o2a/UTKe0NJc/vHmgl0b7XYDAI4Y0OdHrhCTKUd8BXKPQAmI+/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0s9ahEnoBEDM/vdrGjuK+Ixdi64+k7ZoiPHi+pLCic=;
 b=iN4eHaJ8p2DL8O8O9Hx0m4ggsPNL03DMgLVrprCdwiPjcYPvs9/BWpT9K6IB9ktlKfxAII6DLTkPPvIwpHN3Y5FFDJBawVRXJS4EO9Q8exWH+6s1Odbv0DuUglT4oE6FniPxK21nYMYYvs0v1jCmnwVDFbwpe4R2DRofWKeu7ECr0RbaMSsOHmtG/+/I1Jm2GGYgKesXeqaHMooCxuXtirjmO+aHtZ1bFQN0uLnK5ua8GdH8+eWuYl1ogkuMCI8Vqj/qvIOii8a+38j65lFJhB04K3t+k83MBGmf6H133bYjPv3laEOt1EokqKFNXF9EQy8IORu20/ExeBIBgUZsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0s9ahEnoBEDM/vdrGjuK+Ixdi64+k7ZoiPHi+pLCic=;
 b=Gi0El7WznpnKo5hGT619fPVkhwLe/YxPHekq9mNQz22frMY0hDHRkrKAfHs9pPIrlC9Jo0Q9KjS7F9pPnHO8v24vbpnUKq7UbTZM0nCPv0nmPWz1NB0oKDcsqhmLoEKNmzGaNXKDtPvnaHNdXTLz7AOSTB0xuREA/YKEyuyGo4JEdjjhu8jOcQYpam0P5PfS/cRGDEzu/XJSSzcdNHw65wTSLsJz1hlcHXDkCANpeR6tnL0SdLqrD9lTJh6Veb0jjnYFtYU20b4IgdN23xMLmfSLTIvhcH+rzlcVsI4w21Gz6M39ewP+NXYZ6pWJbfVyxhinGsrhT7wPbWydumtqgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by DU4PR04MB10743.eurprd04.prod.outlook.com (2603:10a6:10:588::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:54:01 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d%7]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 08:54:01 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Mon, 19 Jan 2026 16:53:42 +0800
Subject: [PATCH 2/2] Remove the gpumix power domain node on imx8mm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-imx8mm_gpu_power_domain-v1-2-34d81c766916@nxp.com>
References: <20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com>
In-Reply-To: <20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768812829; l=2443;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=yrvwCGbYDvHjYxtNSvVr0fKix1NxJ2eoxC64C+M2mAY=;
 b=18eVvIgsQ6b7ePYnMkrUeTxfxKxJyBw4BwlDB/1zZeuUaJBiA1Di/s1T5CeYPwEWPQdutad9q
 VBIQ3MYahfPCHxSO8Fe3Ggc7glVTggaSay0IY2W6kJQBJe0sjsXJmzl
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To VE1PR04MB7213.eurprd04.prod.outlook.com
 (2603:10a6:800:1b3::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7213:EE_|DU4PR04MB10743:EE_
X-MS-Office365-Filtering-Correlation-Id: 641ce30c-61c8-453b-9f55-08de57384a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWcxUFcxM1czdWtRSk04YldpSkFha0pQNEFZL0wyc3h6bklKUHA5SnpwWE5Q?=
 =?utf-8?B?T1NRdW94UHhGN0FaVUlTZDU4MElYall6VTV5MWpGYlNtb2pReFhVWkZ2bTZM?=
 =?utf-8?B?NHRldjY4MUh6ejdWNWVhQVZZL3VVeVd2aE84RlpwY1dudXpNSzYzeHJld093?=
 =?utf-8?B?RlNYbStaZTJGR1Y2Y3A5SjFJOTZXb05vRklHbVBDOFRrcnlYK0lMQ2Mvbm9J?=
 =?utf-8?B?aHRTMnhSS3JRQTBBbEx2alFjSnFDbm9qVitCQTYrT1Nib0pDcGJzeVFCdW1p?=
 =?utf-8?B?dTAzSlJUZm5pUTMvUTcrZXF0VDF0MThvdzQ0WVAyWENuNENiOWhyblJRb1Iw?=
 =?utf-8?B?Y2dRalorRUY0eDhuVFJyMnRvV0hYelRYM21vZkdQdk1RMUJ6aG9HWnF3UG1u?=
 =?utf-8?B?NXZneTZJU3YwMklHS1ZFQ0NHOG5UNTNKU3BGc09ZSEh2dmo4OU8rYkJnc2tL?=
 =?utf-8?B?alRrLy9ETlIzTnM3dENxaC9EcjRHUE5BMGc0MXorYmIwUVBuayt4YnZIbzFm?=
 =?utf-8?B?b1I5YngrZ3NxcnFUYzVzMm5JeHZ5ckhISGF6dGpiSEFwQlpzWEwvMWZpWjl3?=
 =?utf-8?B?U3hYKzcrSG1CYVAybDQxc3RWcXJ0YzF6VnVBa1p1SUNIRE5yNkVaMWV6bUdy?=
 =?utf-8?B?TFk2ZnlFaXJqZVRkcWtCS3FNNEFSL3B1ZHBESzcvWGN3ZW5IeVNreUloRzcy?=
 =?utf-8?B?bmhEU1kweTZNWVBWa2JWQlFzK2N0RGw4ZE5hUXROV0U2bytsYjlURzJUMEl3?=
 =?utf-8?B?d2dta1RZU2graFJ5ZVpoN3FwcGxJc1dDU1NMS1h2aHVuZlQ5MTdQZG45R0R3?=
 =?utf-8?B?eGtRNUY5YTAzMG5pcmI1ekd2eU15TUJNOStiREFtanA0amxFTEZqZWZTSGdn?=
 =?utf-8?B?aGlqcUphVUlVTFRUallHeVNWbkhrVGFta0tWdm9LdWpaL0J3Z3kxTU9pNFY3?=
 =?utf-8?B?Mjl2TTlFZ1MvcC9BVmN1cUl5SE1ieTZSNTlZYk5WblptUTNDZk9ONUlLa1ZF?=
 =?utf-8?B?RGhZWURTRHd1ZGdjb1B1cmVYSjFmS21lUUJaSlB5RC85cXNvSWhrUEJtdTA2?=
 =?utf-8?B?d1Btb25PMlRMN01XKzMvMElBem9oWExFanRBb0FMaGMrd3pwK0N1dlIxUmQ5?=
 =?utf-8?B?TjFjd0dqZmtJSkhMMDNTT2ZDRWE2YnMzeXRRQW1hcFoxcE8xMHNEVFlBcmRW?=
 =?utf-8?B?bklxbkh0bStDcXBTRTZ0MTBlODYrVFVFcGtoS3hWaWR6OGhNVWgxT1ArZDFD?=
 =?utf-8?B?TEFHa0d1eVoxWnNOdzVGYWJQdDRsanVzRkJPakpzL3g3N0xBbzFpaXlkbUtF?=
 =?utf-8?B?NzNjWDEwQWZDaU5OYTI1Zmk1T0VlL2NyajNHWURTeTltK2V1N21zVnZ3Z1Rl?=
 =?utf-8?B?cDlpcU5pSEowa0dnQTBvKzl2Y3ZGeXBOa1c0bXJUVGZ4ZXJTUXBVMG9WdEU2?=
 =?utf-8?B?K3l1cEQ1WEtYdGVLNzZLclNhWUV1MmM2ZVcxMVl0QU4zQlhQOVJyeTdqTFhX?=
 =?utf-8?B?b0J1Y0c2NisvM3hBVDNZa0plVWZYSi9vcmRDQ1JsVnExb05OT1FaQUtKdlJY?=
 =?utf-8?B?aW9kTjVYR3RVSmpvU0pOd0VaUmYyMHdLUW9uWjJzMzZDVjExRXYvTW1JRFAw?=
 =?utf-8?B?ZW5ZeEprd2FyYXRUendIdm9PNElGSS9LYlpRdDR6MWRVaDY1b1hNQUt6bm52?=
 =?utf-8?B?dzdDOHdxMFBlTlZNQXNqTmYzcS9tMmEybUVpaUFEOUhIK2V0d3VvcVFYQTRo?=
 =?utf-8?B?TUtjOXppTDcvNGVlejBvQ0lEVURWS3dWemFqbElEQVVHWDBSbmorZHF0bzNz?=
 =?utf-8?B?elpJSkRGWHdOSkV5MDZkc3RCOGZnc3BONnh4Z0lQNkFmdEduVDA0cFBHY1RG?=
 =?utf-8?B?QjVITXh2ayt2YkFSL2V6YXAyckR5VTF4enhHaUxwczk0WUV6RjZZUEpSUnFC?=
 =?utf-8?B?aGdPRGVQUUs4TGkzcGt1MU9MZGVQTWJ4dWE0T0dIRHMvYTVvcHdHb3c4dmFm?=
 =?utf-8?B?VDFSZXJnaGJQNTRWTUhYUEhwSHprR1htaDJOOGFnOGFhTUE5RWsraWtQOE5u?=
 =?utf-8?B?a3g2UWM4dFdMUDV6d2x3SENydjNzc3daSDFtRENXblV6cFppczlydGIrWldF?=
 =?utf-8?B?bkRLNWhkZDVHcStxSHUvS09kVFN0Qmd0U09waTF5NjVEM1RueVpGdDNEVjVw?=
 =?utf-8?Q?XPFN5AiW/qJbtcayDHmOf5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjNFM0VMa1hhM2xtVStnY3NoaFV1UVZPMFA0b3NDUWxsZU1Db0w3bFdpK3Fa?=
 =?utf-8?B?Y0VPeXZDMkpzOTJmVXRGVWJ6Nml1c1ZDMGswWTV1Mkk2cWJKSlFid2g4MEo2?=
 =?utf-8?B?eVpwd29RR25BT0Vqd3Y3c3ZHN2gwcHpHOUF6NGtZMGFQMmNyeUw2REFidUdG?=
 =?utf-8?B?T3dZZmFwR2ZyZmtPZVQxb29XNU9TYzFPMTFESXI2SEkwVUpMUXBwc2diZFc2?=
 =?utf-8?B?VXpycTIxQnRiNkpDUjdUL3JGaUNiQkVUVjBIV0dndDV1Q0hoYzNqYk9KTWty?=
 =?utf-8?B?Q3BmaE0rbDVQMytkM3VrQUY5ZlRXRXhUQTZsWXcvQ3B6ZTdQR0NmcCtaMTNw?=
 =?utf-8?B?ZkYrWEhQck1EdUI0ZWQvSzYyU1JPUTRndTdtY3huajJ2TWsrU05kZW9GUjZp?=
 =?utf-8?B?QjR0ZytSWUs1M2J5N1pRU2xrWVFGNmh1OWhNbUUyMnJtdG5pOCt3TzlLV0dN?=
 =?utf-8?B?dFpRSmdtL0htU2tKYlhSaVFFWFI1dHJLSVp4TGY0WFJEbzA5aEdwWHY4OFZP?=
 =?utf-8?B?U3d3QVlGQTZFVHpMRDUvSnh2YmVRaUViRUtGYWMyVUdTRDl2Wk9lMURtcFdY?=
 =?utf-8?B?VHJNblZpam9uYXVmK2d6WjNoNzI5L3RBSEliNUljUWpyZDBJVTVEOWd3QW15?=
 =?utf-8?B?ZmFiS1lua3FSdnR6TWpRZW5QSFdWTHFHREkwaGFqV1JFbWZFRk91dUhXb2Jq?=
 =?utf-8?B?bDEvdzVtdEVvSnE3WnNqYXUzbVVUSXFheWFFZ2IraE5GcmpKcDhnanVJSWhS?=
 =?utf-8?B?M243T2dKY0g1SnkweXVocHQ0bys0SHdBek4zeWYwM1VabzdxN21NdGdGemMv?=
 =?utf-8?B?MUZKTXlsNHluNTZlSjFMY0xHMnlWNmJ4alJIcFJZemJTNktmS3pGams3a0x0?=
 =?utf-8?B?Q0ZQcmN5UmcrUm8wampidDFQK3UrTFp6YUdERmNvWUtjYThZU2c5UHkyZU9J?=
 =?utf-8?B?YTBzeXdVVFhLMFBGdkV1QWhoMmZDM1U1dDhIODRIWU02RUlucXkvR1BoYVli?=
 =?utf-8?B?OTJBWDN6V1lVb3BpcHlQY24xWDRzaXVqTU53MDIrYTFEVXljZko0V01uTU1Q?=
 =?utf-8?B?Rm5vTGRVcGk2Qzd1ZkFnTnJXeWs3WHdIa3lkNU43YkZwNGVkWlB1WU96dmR2?=
 =?utf-8?B?WWdoZWgxY0xoaEpFdHdoYWh6YmVieDF5OTZ5L1d4bndET2FnejZqbFlFNWNL?=
 =?utf-8?B?L2VZamtJUWg4dVYzL2txbUpweU1xRk5XQkNVMGRDVVpmOEZPbGJLbWN5Ymhp?=
 =?utf-8?B?MnlzSGdCVjg2VlBXbjlFMld1d0FLeWZ2UmVESTlBTkdGZ0hRR3RkdXg0ZzBN?=
 =?utf-8?B?ZXU1SmV5LzcvYnpTOVRFaWM5ekVUaFg5R2g5VmRPcGZyd29KYVorOG1pMkNl?=
 =?utf-8?B?ZlFEdUVRSktXZ2ZIRjdJaG9MYUhzQUw1azE3ZU04dWt0OEI0QVdUS3g5T256?=
 =?utf-8?B?K1NGL1R5cGdTVE96bWdldXQzK1d1UVVyUjRyZlFIYW5Pa1U2VC9hdXVuR3dk?=
 =?utf-8?B?dUZ0N0x6SWJQWVJRRXIzSDBiSzJ5Rk8xaE5PWDQ1STQxWENFY1VXdVhyZExD?=
 =?utf-8?B?N1hVQ3hHY0dMQ1EvMW5HZHVFajJPK3NjVDNTcjA2Mm1DWnVCMmhaWktRUEwy?=
 =?utf-8?B?RFFpT2haUlI4VDhkcndrUjhXcDI0TUJQeVpWbnNQSGtPTlhtRkxFTVI2Y0pp?=
 =?utf-8?B?bmlsek5rOVFiaVZCS3ZiN2tQTTI5YmNUWWc1bnIyRElvSzVMZzEzNjVOTVVj?=
 =?utf-8?B?aE0vSDRLeElndHhTdkVCUjdLdCtIQ2kyeXp3U3lQSmtDWThMNXBjZm5URStv?=
 =?utf-8?B?MGQrY3lBbTdkY1pkM3ZIMitLbHo3N1ZTTGsrTVR3YVJpZlZoWjdSdzVMMjZO?=
 =?utf-8?B?M1JPUlplRjdCQnNaZnRlb2VOSTkydlgzdXN3STVLL3NzY3hYNUdjOUN5YXpa?=
 =?utf-8?B?aGhqR09mUHhQUFRPWm5VZlFzRFh1QU5SSnhBTm5oRHE4bjlmMnNoaERhbjFv?=
 =?utf-8?B?UTFncW44OERSQWRBTDh4S20xWHc0cWxXb08zOGJXMG9uV0VmZ0NidnZnTGlX?=
 =?utf-8?B?bjdpajlmY2xaYW5tcG1ITVJXMUFHZE5oNi9iSWdBd0VuTGpSRzlmL1hubi9P?=
 =?utf-8?B?aFZwamVDUVJ0TXYzeHVmWHRDNFllTmdXTmszMTZ5YnhMbnoyeEZhcnNpVWpW?=
 =?utf-8?B?QVg3TTMwQWZkTk9PK3FjSjA3NEljNm8vL3YrTEpab05lMzk3Y2NrVXM0Y3dL?=
 =?utf-8?B?M0kxRWFiT3JCY1FqTUFXa2QxUDA3ZW9CeTBteENSdE5qVU9lNlYzeVduSFA0?=
 =?utf-8?B?aFhNczdka0lONENRdnJxelBLZFByMzZyL1NCOGloVnZBUGxjbFhxdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641ce30c-61c8-453b-9f55-08de57384a7b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:54:01.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9CNyxvCUWU5QXknMUN0Sbfrax+nasdJMb8HVRnGa4ReL7G2O6bXcxxCe7YMwrnUzF6cL9INjqaOcoKcbs5tSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10743

The gpumix node is not necessary for now as the gpumix is
directly handled in the gpu2d/3d power domain, so remove
this redundant node.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts |  4 ----
 arch/arm64/boot/dts/freescale/imx8mm.dtsi              | 18 +++++-------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 272c2b223d167d76b1b3db881644c6c3b115fa4b..393e606f242d2dba253a836c159b9db2f73634ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -741,10 +741,6 @@ &pgc_gpu {
 	status = "disabled";
 };
 
-&pgc_gpumix {
-	status = "disabled";
-};
-
 &pgc_mipi {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 9f49c0b386d31051da9638b566c5e5ee5d2c54b2..3358a751ab3b624270324a4b056b80200482326c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -701,18 +701,6 @@ pgc_otg2: power-domain@3 {
 						reg = <IMX8MM_POWER_DOMAIN_OTG2>;
 					};
 
-					pgc_gpumix: power-domain@4 {
-						#power-domain-cells = <0>;
-						reg = <IMX8MM_POWER_DOMAIN_GPUMIX>;
-						clocks = <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
-							 <&clk IMX8MM_CLK_GPU_AHB>;
-						assigned-clocks = <&clk IMX8MM_CLK_GPU_AXI>,
-								  <&clk IMX8MM_CLK_GPU_AHB>;
-						assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>,
-									 <&clk IMX8MM_SYS_PLL1_800M>;
-						assigned-clock-rates = <800000000>, <400000000>;
-					};
-
 					pgc_gpu: power-domain@5 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MM_POWER_DOMAIN_GPU>;
@@ -720,8 +708,12 @@ pgc_gpu: power-domain@5 {
 							 <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
 							 <&clk IMX8MM_CLK_GPU2D_ROOT>,
 							 <&clk IMX8MM_CLK_GPU3D_ROOT>;
+						assigned-clocks = <&clk IMX8MM_CLK_GPU_AXI>,
+								  <&clk IMX8MM_CLK_GPU_AHB>;
+						assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>,
+									 <&clk IMX8MM_SYS_PLL1_800M>;
+						assigned-clock-rates = <800000000>, <400000000>;
 						resets = <&src IMX8MQ_RESET_GPU_RESET>;
-						power-domains = <&pgc_gpumix>;
 					};
 
 					pgc_vpumix: power-domain@6 {

-- 
2.34.1


