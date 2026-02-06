Return-Path: <linux-pm+bounces-42237-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AofJAjQYhmktJwQAu9opvQ
	(envelope-from <linux-pm+bounces-42237-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 17:35:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF25100581
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 17:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2075303D662
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EFC32D0CD;
	Fri,  6 Feb 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LfdeAfuP"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490432BF47;
	Fri,  6 Feb 2026 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395662; cv=fail; b=e12g2l4vHyTg7jScWtWsaaZExe8ku6RoJagr1HNx2e/y7G/26gEo8bc31hUX/uUMT78Znmbl3wfQKhfOMRW23+M9tMpjuySnv03bbtjN6dapFqWGTEjLuU500ld3sePpEv5jgF1MGiPQSzO14+Lcf5ypHrwiDRP6FKHso8fawgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395662; c=relaxed/simple;
	bh=xJnfJCof7LANIok3NSmf3+a7GWmASoNhIKM9FM9w6EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HDzOM3d+C40X4W8Nmq+P5P9jgLwMduh6YDNSVTicvSv0JZ8A+v7ZTzzDTrkLtz0ijuDoP1MDxDIGd66eJuwYzQQtijibrP8QRzSqVjiYqlLntKgLk/PbYhisYJJ44x0j75BTRpqfDdTAQj6bbGnjJLDTsvze4t1FSG172gmmFmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LfdeAfuP; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCHOX+p/rrXQGcYnfdUAPkDiLKz0tzlTUWW2+hCm7K1SB9RFw1h562KdscCriwekg0R46ga8uXYlapeYHT87TzEf/xJSBnf9Tr8WNnJtDoS3RI1ZSKKPpm0UZCSpBiwBykPYSMuy0rD4VP1Ix17j/I3t1o/zn7Pd43OcORuSEdzYmUcFAu89eCj5bnz6I1sNX60QediyEHmv50MuYfd783/DBLUYxzz56bxHe28vdgUJJrwWe3ILikNQKi/fI8yusYqRFLMAmQgre8J4yQfZfCAyTalRfD29I4JYSq2O587coEf/05miAzMWpGToaCdu0Vys2I96fNAnpj3JKtRgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTgvuOkIy6ymLFgLRwQxygmW2PM1rQ6i5cDUAhs33Yg=;
 b=B8jH01ezs8oWT/rYSSoMbJ1knRaVLdzq+m0DM8ZXU8xV9UKA0LxZMzGEt3PBZKispspQX1e99qS/feM5TXcM+8SrHXrWzO7aipkeZePiCXZIFpHef5D8eo1GixWwiCkBVkNPglx5v30hIRwQW5YFpCxwM2IjNNNJv/3i/1yY0R04Pg8Sp2WcAWECta3A1m0fYt9xCnO+Om0S+5/kLmRmn9zKtYt6q6P2cWRPaSUbEx0jV1xHvqQXWLOd0Rw+DjhCQMrbu87fh3pRW710MW/K9tzSARn1KifPW/CA9rMSUDsjQVRalCKS3lFG7HTWg7KLDpH3zd7QCpI6+Forvrn57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTgvuOkIy6ymLFgLRwQxygmW2PM1rQ6i5cDUAhs33Yg=;
 b=LfdeAfuPGukMxNH3OpyP+DVWSnyx9H1RxH69B6i5BoqCA2pyhIeONLycT/dJ1pbGM3DAnP9ZIrTZ8W0YDBK++/QQcQyB7C576B07SbH21vkWiH9ucuezC9HgKiwc3HcKvSzcXsZc1eQyfIDBNdAn6f/Tj6T8eu/x+vQX1UNEGTKQS7GyTFJRTgLZSuHkiJCAUG3ybCAK7kMllL09wNbBl9FHqj2DiRIjbF4ralweVH/APABPPWaQHpj4ROtGcYQrxa7PRJ93rapov6QDbSrCHfyeFtl0E0pZmQj7shQnQckf0t6DRWWX8gLHZZUeQAbYvRV0X6HPso2zGfbCePXTwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11343.eurprd04.prod.outlook.com (2603:10a6:e10:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 16:34:17 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 16:34:17 +0000
Date: Fri, 6 Feb 2026 11:34:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
Message-ID: <aYYX_pZFcuWKS8Jm@lizhi-Precision-Tower-5810>
References: <20260206-imx8mm_gpu_power_domain-v4-1-52fb603da502@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206-imx8mm_gpu_power_domain-v4-1-52fb603da502@nxp.com>
X-ClientProxiedBy: BYAPR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::15) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: fac92005-3152-4e92-f3b7-08de659d924e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZKekQ5bWpjeWZEdUVUdFJjbzdMUDV1TnZ5K3VicHpDVVFMaVpuZExpdHN2?=
 =?utf-8?B?K0xuMVViY0liU2gra3ZraDlxdXhMRUx5L1I4TC9lOFNJN25wRkIyMXlQem5n?=
 =?utf-8?B?ZmxPeUZJRlZiS0x6c3JlNmxvak5WTGZMbDhWb3Q0R082VTBuTHRhbXNjK1du?=
 =?utf-8?B?QkM4bUtXbk9ldmo3N0phVkp3UXM0WXR4aEQ3WXYvcXJyL2JwNXZ4UE5rYmVh?=
 =?utf-8?B?cEY5NGUvSEkyb2RCQ05PakU5RFdmQUZOc2NDOHBQR0pPclkxSDVyaE1RUXla?=
 =?utf-8?B?QloxeVEvUDJ0aENzMkdRKzhhQWlhdmlFM2NDaGJVcmlSQkVWa1JBVWpoMGx5?=
 =?utf-8?B?SmdBbWgwV3VKVEZWTnltWVpJTmJkbkluTnNKTzNWcEdWSVN2KzIxVGNDYjZL?=
 =?utf-8?B?RlZCSERXbTNNdE5vVnJ5VUQ4TFNWbmt3K3FiTllXRzRuZEt3S0ZMb1lCaFpR?=
 =?utf-8?B?ekpESy9DMXd1NzBzaDcyOXlYU29LRWdYUmxuckRQc1ZJdHJBN3VOaVV5empw?=
 =?utf-8?B?WUxTdytpbDM1THV6NzhOclNNT0xmZ1Vock5ubThFNktsTkZxbGM1ZVZyOTZx?=
 =?utf-8?B?U3Jpd2JTS0daK1luVkNKRHlWcjl6MUlXWE95YmpPNHRtRXl0V1JBMTZOaVVx?=
 =?utf-8?B?elQ0UGxMTEZTWnoya05pUDlySXN4SkJpSE1kTk5MQnZnVzR5eHhMSDhHTnZH?=
 =?utf-8?B?RlIrT2Frd3FPWHFBMlZOV3ArRmhCTE1qMVU5SVJ2LzZQUmxoSXRjUVBFUloy?=
 =?utf-8?B?MS83Qi8wZXF5R21FWlc0dWhOaHlBM1lkYjFBQkdJTFpUSHdVQkU5VlNoSHZL?=
 =?utf-8?B?dmVkMFBvYW1qbk0raTNlSXBXNnpZTFpycTFvZy94QjRxQmptK0RLT1I0MEVv?=
 =?utf-8?B?TUhQSUJzVER1ZG5xcU1NSVdOT093TjRaUS9jSHJTTUZTZkZoS2F1OWtjWHFT?=
 =?utf-8?B?alBYS21hVWd0Vjc4cUtnQTg4aG9RNVJBNnZkTE1YZWtodDBFMU94RHcxcVVV?=
 =?utf-8?B?MWl4T2NuUjNJVUxBTjIySG1VNUpJazlJcDNCb2lTOXZLZEdYVkpHVnprNFZv?=
 =?utf-8?B?MmI0M0RnOEZ4azQ5Vk0zZ2ZKT3NTQzVLVmV0dG9mb2hWdXNsOGt0TkQzK2RL?=
 =?utf-8?B?VWlNcXBEWENyOWY1b3lOU1ZWYlgzMmIvTzF0OVVRZFBFS2pBWm9ybFZpMjRZ?=
 =?utf-8?B?UFQ2YThEL0lNUUtJZXVyM3FFZEtJUzE3WWRWaDRIMWNmMTNPMVV1THdDZFJl?=
 =?utf-8?B?dFE3eHlabGUvZDEwcHhQWnhicWI3NEtRNFR5bGx6Um1tUE45Vy9FOHhvUWN0?=
 =?utf-8?B?clJ0MkJqbGJMVUM3UTFpWXdWVEZaemhmSk42VTFqdzZtRGlSck5oYlc2ZW15?=
 =?utf-8?B?eTloV1dKWENva0V6QmJ0YmdDRVNIbkc4QUkveWsrdG4zdm1sNzl4RkZVS1Vh?=
 =?utf-8?B?QWRMbzVnRUZkam5md3JiMWJOcXhJVXExVXhDNXduYm4vU1MvYVZwSUlMWVBr?=
 =?utf-8?B?UmprVTJhaFo2S1g0QmIzNDdJUTF5K0hFN1dDTHNLM2VpTlBYTWNZU3JOVlNo?=
 =?utf-8?B?TFNqVXFqUGVoVWZMWm1WQ0FHaE9VV0V4STZockFGbVEvaFV6MzFXZ2dzTmxF?=
 =?utf-8?B?M2wrZVhIT0w0TEF1OU0wRFU0RVFWVFpoUzFnNlp0UG1RSDByUDlxU25UbDF4?=
 =?utf-8?B?a29QUWkxRjVuY25FRlB0dStYMWlHR0c2MG1UZ3RQMWx1Y1UwdnRBNTFTck5Z?=
 =?utf-8?B?cU95aWxkejc1aDBzdjZEV3FHWTNTUEg4ZmtvWEFDWStLZjczWEF4OFo4Y0Zq?=
 =?utf-8?B?OWpjcTB0WXNveVlqd0hUbU5XVS9FUmllMUxiZEFpVzJCTElucHVuemZRM3pz?=
 =?utf-8?B?eStCcURwTlBzRGJPa1ZiVFNIT205RHJvTHhTelZmVlZmWDVZdEJNVGcrRnNz?=
 =?utf-8?B?N21sbUpKclowZ2FCV2IzQTlyRTBWZ1hzaC9HeFI0MUJkSSt1UU9iMzlIU1Vj?=
 =?utf-8?B?VDdpTXdEQjFSYkF3TE10TUFCZTlSWm5rWTdMSTJkSFRmWGdqU09NbXhNd3RL?=
 =?utf-8?B?Y25lTE4yNDJGWFdrQjIxZ0MzTTJGSUx2K29icURnVXVJWEpUcjg4dHNXSVhY?=
 =?utf-8?B?V2xvYytxQzV1d2IzNk9jU0YvRXBpWm05MUpDSkJqeDFUMU9hZCtiamUrNmZ4?=
 =?utf-8?Q?QJMht+FmIf1hUC4LODKJULc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnhoZnF3Z0srV2VKOHo4NVY4d0FxMWhKREdTMEgvZzVSVWh5dmZzK0NHUzdt?=
 =?utf-8?B?UFpYZksvR3BrS0dzMmp1ZDJ0UG1NL3kzRUpJSzFwNktObGh2OFV1WnRqSlFG?=
 =?utf-8?B?YmhmbFNsUk1tNlpKUk9FVjEwZjB5MmxGTmhuNlQyY0NrQnNDSS9VYllvWTZX?=
 =?utf-8?B?RHpXbXY2NXdaamtMVFJiOGxGb2Exei9FRlg1Slp0Nldpck1KR3RlSXpWOGo0?=
 =?utf-8?B?bk5ySlI5U3ZCL0VFa1pEVFJoRXVWU01SS0d2blhtc3BTZkJTY2JCZWUyTC9h?=
 =?utf-8?B?VDA1UjNhMDZ5TTZPSGt5amZDcUp0S1lPcklnKy9pODh2UmRJOGZubXdtcFdX?=
 =?utf-8?B?L3hHTWdneTJyN0V1L0ZzTzl5bmJvRXk4TnlYUkJNOUltbVZxYkZoelV1TXMw?=
 =?utf-8?B?RVdjV1hWcU1hUWo2OURFRWtDSGdmVE9BTE9zMWt1V2pBTUlpdW9iakk4OU1L?=
 =?utf-8?B?NkN0MUdiZThRTWt5OVZyY0NlbjdCRkVOMTA4cGRWTlc5VHVsaks2Z1JSOEQ4?=
 =?utf-8?B?S3pDenIveUxXMnJsOHBzNmNNY1lFQ1JwRzVwQlhlVXVzZTlobXdYWUpXbm9n?=
 =?utf-8?B?Rmo4akkydk81OExSZUJVMzBKSWlUMkZDaUtBMzIwR2ZaZGZpQVFETHlYZkEy?=
 =?utf-8?B?dkFlN2VnZWlzMkFxMzFDMVJDUVN2RUFwRWtja1hRSVlJWnpVaWp6SG9oWlZC?=
 =?utf-8?B?UE1xUmRqVHFvTGgxM05EQzBOYWZkay9KTDRIdk9EZStDaG0yQktkUTFRMXBS?=
 =?utf-8?B?YmNQRGlBK2NaWllBTW8xQW5vVjV4UzlteVBFSW9PSVJDL2pNaUk4cUIwUVZo?=
 =?utf-8?B?WWVFWWYwb2QwbDBkOWdtYWp3bEd6K3I1c0ZWNWY1R0o2R3dVVFRQcTB3RTF1?=
 =?utf-8?B?YlhZRmg5TG02cmp4N2lRZ3p5ZmlsRWlQZlNVeTlGd2RBRzNFQVRjSWFFcTRh?=
 =?utf-8?B?OFU1aWZjc1gyTTE5WWJ6N3pNK3hVNU9ob0EzQ2JURFBncDM1Z3NiYkkzYm1m?=
 =?utf-8?B?VFRIQzFuMVZKWnlkRnZMM0tKZ0hLZXNnUGtuV3lvRHZ1ZEIxWmx3QVJ4SENX?=
 =?utf-8?B?MXZoL0R4VkJCTHUrRXFLTC9PV21aa29XbjV5SmcvM1VydVNhYTM5eXVPMnhr?=
 =?utf-8?B?dEViRDVyakxBOUZ1bE94VTZoV3JSaFVOTWdRNVI1S1dlNnZQaHViT3Z5SlNJ?=
 =?utf-8?B?ZVZVSzVWd3BwRVVCWmFWMTB4ejM3WWs5NnRmNCtocEZMSjVHbWhaZGNueXN0?=
 =?utf-8?B?NmFBV2ZDNHRBZE5tWXFiTmVuYkE1TUJKWEFkYWxCWUd6Y3JQckUrOGVhNVZO?=
 =?utf-8?B?enZWb0MvcERhakpVZmR0SFlXZjA4a2s1NkljSWtVaDI1Zm4rbzdhQ0d2WktN?=
 =?utf-8?B?TWM2a2ZJK2x3SCt0aTBFQ3FBZFY4TmNPSkNTY2ZEUUJadFhWWmNLQjJka20w?=
 =?utf-8?B?NkdkSm44Z1pETTZ6NEJuUWJIYkc4bHNtNkhJejViWU5hWlRDYS83aHZhYTV4?=
 =?utf-8?B?Wm1lelhMcWVkWFE1R2hzTHRlMkwvaDRxNjh3eUg0cmgreGxIek44ZUVUS1ZY?=
 =?utf-8?B?ME42eG9HSHppWVZhckVHZWhGL01kZk5wd05HcTFTSmF1TlhVYThwby9HZzhQ?=
 =?utf-8?B?V0lOdmZXSC9DVGpNaENjUHpaQmNUcVQvNlYwVENqUTJFekRzcEVna296MUhL?=
 =?utf-8?B?WnNXWS9XYzM0Sy92WjhEc0dUdjNOQk5TLzlPcUdCdUQzQ05PWElkN1RhTW1Y?=
 =?utf-8?B?U015d1UzVldGQjNiUzZTa1FueDRNSzRhMU9VemYwbG1jVHNXZ3d3OHBJN3pw?=
 =?utf-8?B?OTZyQ01nclk4T2ZoSHhTUWdnNFJvWlhmdmxFeXBqOVZYdDJlYTY0QjlyOUpI?=
 =?utf-8?B?cVdNRENGaVlEaUpNcHl2bm9BYTdJNWJQTjhYclBrK011UDZPc3gzb0RpMTlj?=
 =?utf-8?B?bmwvYllnc2dXcnFPWmF4SG50TEphdzhTV3NHL0h6NjJRcytoRDdSQ2VwZFNE?=
 =?utf-8?B?azU1N2w5bm40NmZpZ1I0WU9VQXA4cXR0MExaZTdKVXRNbis4ZG01THBpc0xE?=
 =?utf-8?B?TUd2eGFrekZSTkZIUGF0SXJxWFQrVmdPcWorYmw3ZENqZUJNWDhPVzM0RnU0?=
 =?utf-8?B?RU5SSzQ5eE5PR0VkVVYrSGlPRUhRbFJXUTR4VEhzMndPdERtQ1lkS1pZOUJv?=
 =?utf-8?B?bHg1Y3F3VU9iRWN0YW9yTnVFOXBhMjhxei9DVzZCZDUxN1ZTODRYZHJ6VEN0?=
 =?utf-8?B?OENqaFc0Qy9CNjFHVkJBdG5KTVUxYVMydy9uN3JzaTMrT1JsUVEvSXJhcUVL?=
 =?utf-8?Q?fvV60K9Rpa3FF82tS7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac92005-3152-4e92-f3b7-08de659d924e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 16:34:17.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrJTMYGIFn86QVk7LDV5hJcCWAC7JGOJrS+MWMvnMcU/vEb3JfadHIz8hOg9UDevJNacR2wjNfrgo0OYzee33A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11343
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42237-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,linuxfoundation.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 7DF25100581
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 10:44:17PM +0800, Jacky Bai wrote:
> On i.MX8MM, the GPUMIX, GPU2D, and GPU3D blocks share a common reset
> domain. Due to this hardware limitation, powering off/on GPU2D or GPU3D
> also triggers a reset of the GPUMIX domain, including its ADB400 port.
> However, the ADB400 interface must always be placed into power‑down mode
> before being reset.
>
> Currently the GPUMIX and GPU2D/3D power domains rely on runtime PM to
> handle dependency ordering. In some corner cases, the GPUMIX power off
> sequence is skipped, leaving the ADB400 port active when GPU2D/3D reset.
> This causes the GPUMIX ADB400 port to be reset while still active,
> leading to unpredictable bus behavior and GPU hangs.
>
> To avoid this, refine the power‑domain control logic so that the GPUMIX
> ADB400 port is explicitly powered down and powered up as part of the GPU
> power domain on/off sequence. This ensures proper ordering and prevents
> incorrect ADB400 reset.
>
> Fixes: 055467378bf1 ("driver core: Enable fw_devlink=rpm by default")
> Cc: stable@vger.kernel.org
> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Changes in v4:
> - Add the Fixes tag
> - Link to v3: https://lore.kernel.org/r/20260123-imx8mm_gpu_power_domain-v3-1-3752618050c9@nxp.com
>
> Changes in v3:
> - Fix the Suggested-by tag typo
> - Link to v2: https://lore.kernel.org/r/20260120-imx8mm_gpu_power_domain-v2-1-be10fd018108@nxp.com
>
> Changes in v2:
> - add prefix to patch subject as suggested by Krzysztof
> - refine the patch to move the GPUMIX ADB400 into GPU power domain
> - Link to v1: https://lore.kernel.org/r/20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com
> ---
>  drivers/pmdomain/imx/gpcv2.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index b7cea89140ee8923f32486eab953c0e1a36bf06d..a829f8da5be70d0392276bd135fb7fc1bbf10496 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -165,13 +165,11 @@
>  #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
>  #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
>
> -#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
> -#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
> +#define IMX8MM_GPU_HSK_PWRDNACKN		GENMASK(29, 27)
>  #define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
>  #define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
>  #define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
> -#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
> -#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
> +#define IMX8MM_GPU_HSK_PWRDNREQN		GENMASK(11, 9)
>  #define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
>  #define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
>  #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
> @@ -794,8 +792,6 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
>  		.bits  = {
>  			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
>  			.map = IMX8MM_GPUMIX_A53_DOMAIN,
> -			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
> -			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
>  		},
>  		.pgc   = BIT(IMX8MM_PGC_GPUMIX),
>  		.keep_clocks = true,
>
> ---
> base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
> change-id: 20260113-imx8mm_gpu_power_domain-56c22ce012a1
>
> Best regards,
> --
> Jacky Bai <ping.bai@nxp.com>
>

