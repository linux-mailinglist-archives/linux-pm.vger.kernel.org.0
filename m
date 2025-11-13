Return-Path: <linux-pm+bounces-37899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB9C55B00
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 05:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16C53A8103
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 04:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8C287516;
	Thu, 13 Nov 2025 04:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nb/WDusp"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360C35CBC9;
	Thu, 13 Nov 2025 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009250; cv=fail; b=Nr6VB2SE4RJJvemBhcsbJF01jypE8wRigx7cIzNIXtuBCtYWyOGw1n06SuEhiv3Yr94Dcqsqu6HymlCo9YLltdl02DTEe9xDbhFOmwdxHjnavuOb48t1anelvjvCaT/S4bDOh+NraFsQOoQ4ISkY5qIGy+vXWfEqyV1ylQsFtp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009250; c=relaxed/simple;
	bh=FhO4gCZMhRVZKxtQ0oVrDFZ4d0af4unCUR9Z3mKhlZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YYuWXTDLC9coB/WwGAdfsDxZIJvAP1vd0ns1pAx/DA2d9PZB3rSEsWzhWPa7T7QKdR6S3hEaaryX621CZGHjmB0BfdOLWx2OmQRg4ZG+gd3VzQhnVUWfkOpZ65siivj4kAuxeyrMyBP53hm/qcMcPMmGjN7Cq8fQ9o+HaMwhIGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nb/WDusp; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqYNUt6yEkTDU2eNXFh49benSPAMWmVjC3OjNSNQopJGCGZkL+9U/NODNh7TgjoFhaA17NEQuRP4wDS3XPFPLDWq0m+1aV2fzlQt8HiyiK1oPgE4wzu9QpP0Bq11xFiLm9r6fzB4ivCGHiZyHPvBIrvnKNpMh7ZVLtjqTkDCEepo5o/C4IC5DwmTDeBu2RnfRJllZ+RNNq8fDoD3wfi+xv9Lef6d+Q57DuochXYvMVuNr4iYYxBbWuia6keybtI6Yzew4EQeBDAUg9wt7AJ7SuVFu3OgT/OEsyUhSZjVsHQayRRVLN1nw9rkFNXD6lEOPNVZQDjsJNRlxFIHvcoU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HciNUiRcADEfB3tvZBXkJzh25DoesemHYl1t97qtskM=;
 b=J0xtgxj5f5VRU0bM3cJnmkIaAIS6/vzc7f4grIWDeWeh9U07y+5msDdGY5bz66cmr/N0wFzVBMlRAvx0RvFHpIWgszdybztJf34Qk7KNqmsnQw6ssnuUVQ+jszOJxUsyuQiZh+C7hz84oUzUCfTY9xINkyY+MiLnZA2j4trGiDBA3DdVktohPm5G6A3b0X2GDerK9gOAz7E8Q1p626yxa/0a2GYrlKFdX8UE4lZ/cFA+jmwplwPzQG+hOiLHUYaEPyTxc1VZCKNK7e4mRj6Fuy4ncJZj48ZRbrMT/yP4i406+IO6HddVelK8lmgqkkIoNpM69UO50dU0masYzNP64w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HciNUiRcADEfB3tvZBXkJzh25DoesemHYl1t97qtskM=;
 b=Nb/WDuspsmlSMxwk5PWTQU9aODvdvsGg9snpGP2SS3vto85QrVTYaQCjzPo4E9dS4rudFPnfa25DRQDPfi2faYaQx8vhZYCs78zpAVoYc68JRmgy/MSWrtJpMaL+goqTR0MKBgi4YEy4iydliwMU/iOxYtMQ+EhIHRWh/jmrlczM9Yq3Unzcc8aFHMMkSHZsHcic6Xpef8sk8OdQ3IH1rvCqrNvNhci5u1bc0e/IGEJbl3qeZxu4QvtMh+o7ufILAq7ixcg+L4MLzGyxq6kmb8lDH/YH36XjCR+VLSFgP5Bl/7NdVqiZHXwbFqBMvpYNMZ23XCZAd/nmdroVfPmhww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 SJ5PPF28EF61683.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 04:47:22 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 04:47:22 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 05/11] dt-bindings: memory: Add Tegra114 memory client IDs
Date: Thu, 13 Nov 2025 13:47:18 +0900
Message-ID: <7423636.LvFx2qVVIh@senjougahara>
In-Reply-To: <20250915080157.28195-6-clamor95@gmail.com>
References:
 <20250915080157.28195-1-clamor95@gmail.com>
 <20250915080157.28195-6-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::9) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 23679df1-853c-49c8-8b5a-08de226fbbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFFUaWl0VkVrV2ZXWDQxbEhXanljbi82Yno0eG9oRDNUQ05vYUFqWWR3VDlk?=
 =?utf-8?B?N3FUbysvRHNSa0FsSFRndVFVdXVJWTdFcUh3RkFraCtyd25iK0hnMWhweDAy?=
 =?utf-8?B?TmMxc3N6S0ZNWmZWUmkrQ1dzbE9SVDcxbk9yWWtIcm05SjlORWN6b0MvbXJ6?=
 =?utf-8?B?cXlUVmxpOWZaei9DNE1Vc1lTTjBOeWViUmNtbFQ5NXpIWkU3TElLU3o5azBi?=
 =?utf-8?B?ajRIZ0lKTmZIa1pPREhLODdIRjBIRXJHSFlUc1NSQUtpRVp6YjdUY2Nwb05y?=
 =?utf-8?B?SDBST3piOHZQcVVQRStsVkswNmNJR2M5L2tSVktSbi96Uzd3MElVUXdocHVr?=
 =?utf-8?B?YXJLQXplemtmU1pDODZVUElEeHB3NDIzaEI2SWlaMkpoeUtyNlZKY0MrQURZ?=
 =?utf-8?B?K0xmSklFTXFoTUtHMGpvSWVYRkpWMmhYRFE2LzdXMkd0Mlo0M0M2dWFvNDJX?=
 =?utf-8?B?bC8wakFBcE9SMTYxWnFLS2l0YUFITFdTL3ZSSG9EMnJ4aS95OStKdEhTTC9K?=
 =?utf-8?B?UEtGb2F2WXBTT0I5cTF6UE9KRWZRaXUvR3NsSERzTERQdGhyN1lpcTNyemdm?=
 =?utf-8?B?RHZXclZOVTlVV2F3ZmtRQ3MrUmlxKzVwQTcvQzVFV2lEMDJBY3lUcDdIZ3FM?=
 =?utf-8?B?cXpabUFSZjFKT1JkdTdaV0NKb1NvbzhuaVhHeVRFMUJ4a3lzNWZUTDZSa1Vl?=
 =?utf-8?B?OTJkaDBsOHJBR2VFVmY1SmRJekN6UTMwcTloaFMvZ09Fck5lNFAzTWJUZWpH?=
 =?utf-8?B?QzYxTER4VndCMEhiNy9TSi9PR0NjQ3RFek1jK2x1ZFkrM0VBNkVmMFY3ZEZW?=
 =?utf-8?B?cXM0UXZxM3BkWEx2Vk1hWkM4WlNIdHpsTDNrb1kxWXRQRWcwNlltMU9rU3Jp?=
 =?utf-8?B?TnVaZE9BM01XRnNaWGtWRlM4NnlhN1JXSTM3MGZEQ05LN3VaVFVwSWFuTW5Y?=
 =?utf-8?B?TWpqdGZEM1pISExpQkFaQmRUakFRYUxZMjNRR05TSlFRMzR3NmpkN1ZOTXZz?=
 =?utf-8?B?K2g5TGlLS2dZbG16M0xSaDIrTUNhdjhUeEtkQTlDUUlMbzVYRWFQWTk4NUdi?=
 =?utf-8?B?NG95emVKK0VOcVo5Z09ucG5uT01mdjZWZkMxelgxK0VQRnE1c1hiOWVubnN2?=
 =?utf-8?B?OU1pTDNoYmVJNmtEMnVyQ20reE5oSFBYeTRDdFBpY0huQWRHNGhaZGEvQ2Ux?=
 =?utf-8?B?S3JPNEhYMHVCakpqYWpocFpOcjZnNVhYNDBxalBxQmVGMEF5cnFBY0pYeE8y?=
 =?utf-8?B?N0hTcFB1VjlsWEpsaXdtL0xhS040a1BvN1YzZDNZOHgvUnRjcDNMdTFqWXRS?=
 =?utf-8?B?N2I4OW1nUDBNcmlPTGtITFk1V3d3Y213TE81aE9vODV6ZVVoM3ZzK0VlaFZN?=
 =?utf-8?B?TjRMcUYrUlVmZlBTeGtZQzJOMTFIMGswTnVhQVZIdVFrc091V1dDaUlEcC9z?=
 =?utf-8?B?ZUt4VGoyTkhnQUZSTXRSY3RwdlV6QldEMEdVMzhKV3gyYnRPdHR0ZjlocEpX?=
 =?utf-8?B?YVM5Qkx3eEpKc0RTZWM2bFN4b0JoeG5jRGljc2plNjFmVXprN3RrMHloRnF1?=
 =?utf-8?B?KzVDSDhCbkdjNzN6TGNPUEI3eVlYZW5vWFhyUEF6em5uL0dLS01FaDc4VGdR?=
 =?utf-8?B?dkE2c1FRQmRZNTU2OTJpSHYzR0pvc05Cd1pXVkVSNUkxQlY5UGhodU0wMUVG?=
 =?utf-8?B?Nmd2SURTNzVNbkZWTHlYV1lYeFZCcmJqVU1IUFczc0Q2Y1hib25mM0UwZTF6?=
 =?utf-8?B?anRVOThCNDdIRE5LUVBHTE8vZHVOMVB6akZ1cUhTaFE1bExCekl4c1BHNnBE?=
 =?utf-8?B?KzlNc2F5TEFGd25UTUwzNUZwelZaQTlCMkFNUnVHVFREZTVqTHdDRTFaU1Nk?=
 =?utf-8?B?aXRvdEhOUTRGL0ZlRkF1RXA1enNkR0R5T0FPUmZPbHVwOEpvYkFSczdwTkxD?=
 =?utf-8?B?Q05hZ3g5ZGZ6ektIM0dwUGdtM0NYN3dPQlFUTDQ1MUVhdkhQd0NUMW8rcHFl?=
 =?utf-8?Q?IqzQI2xMiWXJbbMR/7Ap3r2giv+0T4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFFGVDVhRU9OYXdrYkxKM2ppSEdrMXBCLytCWlYvWHdZbUhjaHVIWDVKRlUx?=
 =?utf-8?B?bFNFcnRIcDUxNFFzczh6OHk5eEdGZ1QvOWMzT2MvcW5VVWxObnF5dU53emZS?=
 =?utf-8?B?b1RTSmRnRG82MWxqSHRVbmVsNnNHQllqNHpoOUpwU1pVMnR3ZWN3VWJycGR3?=
 =?utf-8?B?c1h2ajdLMVlUWXB5OXM4cVN2eTN3TWZpVGRmRWZZb1BzMWJKVVZ3a0RydC8x?=
 =?utf-8?B?K1JaMVczVjRCMDdMTDJ3N08zaFQ3Sk11ekh0b2MzOE00MGgxazcvYytiYmox?=
 =?utf-8?B?R3VJN2FnZUlOZjAvUkQ1VVI2alRqenhOSjF6ZWRlam1pR21IeFQ0SGxPSXMy?=
 =?utf-8?B?cFIxUHYrM0JXRnVHSmJ1ejEzT21GY2QyUU1RL05hd0FnMVJrUjZJTlg2ZUFz?=
 =?utf-8?B?RUN0d3RzSDYweE1zaG90TnduWVlSajdOZ29Cd3FXc1NLNDFMRzBodFNCZ1lD?=
 =?utf-8?B?ekkxS284ZGpjY2ZOTGhTVDVLM0p3RENkOGYwR3hxQkVlUXI5c2hkSGU2aFhF?=
 =?utf-8?B?QmU4NTJaRVBSQjhUK2c3VU1YSTlnL3EvM3R4RWNWSHhDb1ZVc3lVZ3A2YkVC?=
 =?utf-8?B?Sno1WWFNSXlhN01QTG8wNHJ5WkFuWjdISGZ1dzlSZnZwSTI2UGhNT3FwNFpX?=
 =?utf-8?B?eHpTZXUzeFpsMkFwUEN2aGp3eHF2amJYaXBDeVJ2YnpQNlNhUm5abEtTYnF5?=
 =?utf-8?B?eDc1Z1lCcGZyTmNBWmd6VGdTK0MxelZNbnFnRk53QWlMc0V5ZFhUdVRKMnUy?=
 =?utf-8?B?NUk0aWNTQXhlZW1zaFAvY3B5UUhsMnNtajZqTkZVYm9wdm0veC9KdDBHWlVI?=
 =?utf-8?B?dVAvWVo5T1BLRURiVnAydEtybU52K1FTVmc4N1RMRmF3NGQxelUvWWJrTkdV?=
 =?utf-8?B?RzBjYmw1R1dNSFFFTFZrK3N4VnpYM0hnZEVMeE9lcGtmMDNjOWpYajNodVNK?=
 =?utf-8?B?OFJkM2oveHo5SUc1dUpHT1QzMkdET1BnOFdVTDRqZzgwbDdrMGJJMWo5NjNw?=
 =?utf-8?B?a0MydXBuNnFMSTNEZndlWjd2eHpIOWg3SXAzSnNtbmpGZDFXQjdwR09HSUZS?=
 =?utf-8?B?Zk9LcHUyMHV6c2FaRkk5WXNKT01qTjhyRU40TVBEN1NyZUllcXBkOVh4SS8x?=
 =?utf-8?B?UnB1NXNIOU9jd2FFMjVrTlJrTDJiZ2JCMjZqeXpqTFZyb21QRDFndW9ZbEhl?=
 =?utf-8?B?ZGtCK1I0d0d5ZW5kL2dkVTczQ3JEdDB6d0xaaS9WdXI1ZmFaVWY0VDl6cEo2?=
 =?utf-8?B?MW54T2RGRU5ia2hYNXBnUUl0WTZPUkVrWUMxZFpmREhEUVpFNGp4UjFyelhW?=
 =?utf-8?B?N0tnbkk5VCtXTXVHVUpESlRpaG9uaWpCWEM2UUIzamhTeXJFNFEydHpUK2FS?=
 =?utf-8?B?Q2NhTysyd09XTm5EcWlFYVRWQjRYQ3Y4UVFkbFdpZUhoSU8xMkNjRGFydEFV?=
 =?utf-8?B?bnNBQUh3SndQeG5tSm5nL25RWFh4VzN4WTA5TWhzSmptdUI1NzNBc3Q3aXJO?=
 =?utf-8?B?SGdvS2JGVDMvVkdXd3FvUnZGWnhEYyt1eS82V3VEalBNeHdGK3RXQTd2cndk?=
 =?utf-8?B?dnQ4UUFZVVdOSlQzUUxidFc0QjJZcCsyUGV0bitBTnNya1FwQ2NyU1VRdU1U?=
 =?utf-8?B?WHFMdlZITEJBNkR5cXJNdkpWZXlWM08yR1FtRFNjanY4b0VyRVB4TVdqQUhQ?=
 =?utf-8?B?WkJoanFVWFhUMjk2VnJYTkNsZU1DYU8yaW0zYTd3Tm03NVRpMG8zbndsVkdh?=
 =?utf-8?B?dWd0QjhnbkJlUGcrU092bGZucjIyODViZ2lQSUU1ZTdUK25ZUDNBNWRURDgy?=
 =?utf-8?B?WWZmck9FUlhYbjJSR2VveElWUnRCaFpxV3psQkxWMUNFN3NmTDlTVVMwSXFu?=
 =?utf-8?B?M3oycWU4bWtobjd5UG9aeHBEMkJPTGEzRFYvY2pzM3dLb2pKSDlrTldIRGc4?=
 =?utf-8?B?UnBtRzdteldPYUt6dzNJK00vOEY1VGlOVWZybFdGM1p6a2JWZkQ0YU5zOVNu?=
 =?utf-8?B?VGhmVHRVbzZXUXlRVkNpM0tSYmNZRjN5SmdVbDBEQlZpWXRyNWdLdnBZR3lm?=
 =?utf-8?B?amtZUUhxS0ZJWGF0c2pBKzBqUWRoS2hTQ3ZDV2Z3RkFqQjJLMm53MUtKOWps?=
 =?utf-8?B?ODlKZlg1cE9LSlR3VEpGNk40endSRjVzUDNTZmd6TU9aakFIOUtUK3pqOHQ4?=
 =?utf-8?B?eUI3Y09aWndpRGtyYmRvUjNhZjBxamNSRSt3UWhxbkVHQktKQytRWlNEeXRn?=
 =?utf-8?B?cFE1Z1hWdCsvYzlQREZGS2pISTR3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23679df1-853c-49c8-8b5a-08de226fbbbc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 04:47:22.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0aSjo0xiyHIK4e7YfdtLeNyT40JgcUC8q1SpBpER/p84i+Qt0fUoWRLtmek52l2Mw/kKBKC/M2Ul6UNZ0Q4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683

On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrote:
> Each memory client has unique hardware ID, add these IDs.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  include/dt-bindings/memory/tegra114-mc.h | 67 ++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>=20
> diff --git a/include/dt-bindings/memory/tegra114-mc.h b/include/dt-bindin=
gs/memory/tegra114-mc.h
> index dfe99c8a5ba5..5e0d6a1b91f2 100644
> --- a/include/dt-bindings/memory/tegra114-mc.h
> +++ b/include/dt-bindings/memory/tegra114-mc.h
> @@ -40,4 +40,71 @@
>  #define TEGRA114_MC_RESET_VDE		14
>  #define TEGRA114_MC_RESET_VI		15
> =20
> +#define TEGRA114_MC_PTCR		0
> +#define TEGRA114_MC_DISPLAY0A		1
> +#define TEGRA114_MC_DISPLAY0AB		2
> +#define TEGRA114_MC_DISPLAY0B		3
> +#define TEGRA114_MC_DISPLAY0BB		4
> +#define TEGRA114_MC_DISPLAY0C		5
> +#define TEGRA114_MC_DISPLAY0CB		6
> +#define TEGRA114_MC_DISPLAY1B		7
> +#define TEGRA114_MC_DISPLAY1BB		8
> +#define TEGRA114_MC_EPPUP		9
> +#define TEGRA114_MC_G2PR		10
> +#define TEGRA114_MC_G2SR		11
> +#define TEGRA114_MC_MPEUNIFBR		12
> +#define TEGRA114_MC_VIRUV		13
> +#define TEGRA114_MC_AFIR		14
> +#define TEGRA114_MC_AVPCARM7R		15
> +#define TEGRA114_MC_DISPLAYHC		16
> +#define TEGRA114_MC_DISPLAYHCB		17
> +#define TEGRA114_MC_FDCDRD		18
> +#define TEGRA114_MC_FDCDRD2		19
> +#define TEGRA114_MC_G2DR		20
> +#define TEGRA114_MC_HDAR		21
> +#define TEGRA114_MC_HOST1XDMAR		22
> +#define TEGRA114_MC_HOST1XR		23
> +#define TEGRA114_MC_IDXSRD		24
> +#define TEGRA114_MC_IDXSRD2		25
> +#define TEGRA114_MC_MPE_IPRED		26
> +#define TEGRA114_MC_MPEAMEMRD		27
> +#define TEGRA114_MC_MPECSRD		28
> +#define TEGRA114_MC_PPCSAHBDMAR		29
> +#define TEGRA114_MC_PPCSAHBSLVR		30
> +#define TEGRA114_MC_SATAR		31
> +#define TEGRA114_MC_TEXSRD		32
> +#define TEGRA114_MC_TEXSRD2		33
> +#define TEGRA114_MC_VDEBSEVR		34
> +#define TEGRA114_MC_VDEMBER		35
> +#define TEGRA114_MC_VDEMCER		36
> +#define TEGRA114_MC_VDETPER		37
> +#define TEGRA114_MC_MPCORELPR		38
> +#define TEGRA114_MC_MPCORER		39
> +#define TEGRA114_MC_EPPU		40
> +#define TEGRA114_MC_EPPV		41
> +#define TEGRA114_MC_EPPY		42
> +#define TEGRA114_MC_MPEUNIFBW		43
> +#define TEGRA114_MC_VIWSB		44
> +#define TEGRA114_MC_VIWU		45
> +#define TEGRA114_MC_VIWV		46
> +#define TEGRA114_MC_VIWY		47
> +#define TEGRA114_MC_G2DW		48
> +#define TEGRA114_MC_AFIW		49
> +#define TEGRA114_MC_AVPCARM7W		50
> +#define TEGRA114_MC_FDCDWR		51
> +#define TEGRA114_MC_FDCDWR2		52
> +#define TEGRA114_MC_HDAW		53
> +#define TEGRA114_MC_HOST1XW		54
> +#define TEGRA114_MC_ISPW		55
> +#define TEGRA114_MC_MPCORELPW		56
> +#define TEGRA114_MC_MPCOREW		57
> +#define TEGRA114_MC_MPECSWR		58
> +#define TEGRA114_MC_PPCSAHBDMAW		59
> +#define TEGRA114_MC_PPCSAHBSLVW		60
> +#define TEGRA114_MC_SATAW		61
> +#define TEGRA114_MC_VDEBSEVW		62
> +#define TEGRA114_MC_VDEDBGW		63
> +#define TEGRA114_MC_VDEMBEW		64
> +#define TEGRA114_MC_VDETPMW		65
> +
>  #endif
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




