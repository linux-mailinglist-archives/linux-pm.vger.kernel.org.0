Return-Path: <linux-pm+bounces-37897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1BC55A2C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 05:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF16B3B0E26
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 04:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F32BEC2E;
	Thu, 13 Nov 2025 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jEPGpU7g"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58278224B14;
	Thu, 13 Nov 2025 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007624; cv=fail; b=SPhUar3ERnhiBothx2zWAWBanxphsbZo4xjYOzPOASY4tg53Fgb21wBlAQ/mKQ0zsuOybRMm1q6tm6gEbB57gsvFS8mcmg3VyZEaj5yWMHktkx6jbWOQ43qIbTQ+iPFx0yDqwygxTE0buQ8xPp98xDGnpWyqqBV8ubwVcG+KVPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007624; c=relaxed/simple;
	bh=BZi0nDzyNODPwO1DkFg3G3MHJ2GtlOeZZaPSnl9IKWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jfDEdDQS34ln+YY2kuN6r2ueuVaDhLIIXtfzfMsjzGbLmapSCrtiV7DZfKt2NW3lVVjGky4f13TN8DaLxsWWwnSio+DFUu4rM/vtFoTNrnrowmb++KEG8PgF8zRcC4ROskNSB/VMAE2WskYcBwfBHgu3Q1i55Wp9Nybyz5oW9Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jEPGpU7g; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjuuRUHsJfbdRaoysINjSdSn/1yp8kWl4IKKkSd8j+gynirAsQ0bQ0CujodocyA6EV6L3RPJxXU+RSHg6FaO8yeSV5LIq4zMOmJ+F6FGlpIB4VQbxdID/aecHPfAV8zjsInJzjPXoGrExix0gHpyQp1sWRmfrCzXHyR4uJz9wdPqGgxi75WciA7qPkrGMjmdSmpm6Fp0b2cOPJmJueXQs25YPcclpNdKn+Gfr2PnpgtyqTbMrFnnJm5hZYjh+lLweQ2OJMgpUxhkXmpXK1jXNxLB5E5PD7hUbAes6GjsazX//zIOk9GS1Iq5L/huRmPQFt0FAnzNdxrnHak4xDQVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY9oL7kSKD5S+Bxl569iBA55YkIQlaXwPyXQAmezgk8=;
 b=ViKI/ZH1EF/r4ajbBSCBdKJDQ3OsnNvzW9VGniSeDwOwDNJAqXRULe87DJByIOyPd9CSHIy21dD7zOHC/R4/v4+1Qm2uRos+vKzp9z0JziI6qRn3mS0hv+7WXa/6SAm0dV5c54jyFiB2IUuBt/ZsXEaFDQU1Ot3+NJmHvRS3Y2gTsluPTzcluzRuV5Z0zw4pwGND74KfyAkhpplTLGPTn8+HMRsASSjpC6fvmm5OHHWAXMOmdVlvPtU7i9GIsVJ2GLZWR80YulCrcXqPjIAfPlSf6Xu1N29AIAOPVEUJ7mM4C6WbRwE6G6oS2VIuPg7basylx+sfhCPiIhVXKIo/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY9oL7kSKD5S+Bxl569iBA55YkIQlaXwPyXQAmezgk8=;
 b=jEPGpU7gAQqL1cvtcvloJVNJNMcNgqfXXLdiEIlIIm5KEHgwXRvtRQbTvbvU4Raj5K3L2NyCvZUslb5JzLfm4OBl9mb7SyT/boWWyQIOQSbqziZtteT18jASi0/DgG21b3BHI9iNysBmOvmgWpa+qpxXIWljOFhyXCAJQAir41K4fPPL/xnHOc0YPmUwunlatRWVPhUg46kIhF1HLoae7Oq7IyE6EweTVPGcI2R89Vdr9R5fx8L/lzjHKMA3YHyWLjpX+Gko25Lw/Dpvn3yQy04K1DarAyZXmJb9nJ4k8FUQke/W4gDPvNvIITDIhRQZBck5ow5OxwU0/AroxUj99Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 04:20:19 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 04:20:19 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 01/11] devfreq: tegra30-devfreq: add support for Tegra114
Date: Thu, 13 Nov 2025 13:20:06 +0900
Message-ID: <15510199.O9o76ZdvQC@senjougahara>
In-Reply-To:
 <CAPVz0n3qXBLEVDKDDc6DRrN+WFiAdeL1wDaA94DkdST7NoRXyQ@mail.gmail.com>
References:
 <20250915080157.28195-1-clamor95@gmail.com> <3455911.aeNJFYEL58@senjougahara>
 <CAPVz0n3qXBLEVDKDDc6DRrN+WFiAdeL1wDaA94DkdST7NoRXyQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ac44bf-2df3-4384-d065-08de226bf442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGZ3TUZzS0IwNU9hN1dDTDIrdVFFVzZ4U2ZYbjUzVitBSk1sZE9GazdHdXQv?=
 =?utf-8?B?MXhFWlJTS3pVMmhkdHIrSWtJVzdXWDNUNi9hU3BzYklBZ2tCcFc4dG5jZUxp?=
 =?utf-8?B?aDUyMEh2SXZwMlZjNkczMHFySkdGaU5LemRKMS9CYzBtRDEvbnFlbFd0MXNx?=
 =?utf-8?B?QkRpWWV5NUkzangwc0E2a1NVVlhjODd2WnpQWlVRWktiOTdPM1NwejJibzJp?=
 =?utf-8?B?cVB5SGNiSTI0RE9Ca3gxK2c1d0JueEJTb3g4WXFqWkpnYk1hdnl2b1dHMlcw?=
 =?utf-8?B?SE1yWFc4NGd6ZENVQWtxcVVIQTJ6RXVxMFY3THpmckdjNHRYakNEa0dUNFor?=
 =?utf-8?B?L2FOU3VDSXpNMHVYQ2lpNVpkaVNUL0tLc21uWFBaa0Y4d2VySG5rdEJoU1Zr?=
 =?utf-8?B?VjhleWhnZ0lTSlBWclFVRktLZnJiMWJzaFg1MHovQ0g4NVFHSkY4QjJDRW1s?=
 =?utf-8?B?TUJhMEZIZHJidUZRR3hYQzNBYzM1T2dIQWh4WnV2ZGdYbGppc0JHVEFsQkQv?=
 =?utf-8?B?UkJhSnZkR1VKWlQvb0xMV1hOWkI2V0xhMXR0Rm9FaHpBdXlFSW9FNWkxQnZv?=
 =?utf-8?B?MnBpRFUzQ2VCN1hteEhsVldyNEFBUHdWWkZaRU5iUEREVTlFVnVKbkc4SDY2?=
 =?utf-8?B?djY1RVpkTGlwNG42TkFIdUhZbGxOeU5RNWVHQnZlaHcxOC9XMG1tUS90UnUy?=
 =?utf-8?B?SFZ4YUJBanFvUllCbTAzL1cxWWZ3UmV6dnl3SThPbFZmTGxxRHR2OXdZamJO?=
 =?utf-8?B?MkREU0w4SmorZElNL0l4N1lmekhKVFh3cU5uaHQ5UTFCeVIrZ1dXcXVjU2xK?=
 =?utf-8?B?SlFESnhXa1cvOHRBWnY3UElQTmI3cXFlT0tMazZTSTFsWFRGM3hzbTM4V0p2?=
 =?utf-8?B?WHRqWmVDaHV3YWdleWNDVzR6b1dMa1U1T3k4THNXNUkrMWpBeWN0VysyTEN4?=
 =?utf-8?B?WGZsOVpzNC9hcnlvaEZtK3JpdFdQVW5sOUl2M0kzMktUMmhzd0c0S3RnaWFq?=
 =?utf-8?B?SGRmOTk1dXdXNDlBZnErM2MvZ2U1T054ZkluT2UyaGxmZGpuTGlKUTUrbnJ1?=
 =?utf-8?B?VG1zellXL2taeWtwSVlQV2dSV09TS3dkSGRFQldjUUE2cURpQ2RMTWs5NVV2?=
 =?utf-8?B?ajVka1Q4MThwNlR3OGU5RFF1bU8wOHVCTXB1N3phVHRzV2RMVkN1Wk5OOHh3?=
 =?utf-8?B?K0R4Z29QUW1lRFNPY0kzQWg0WFg2Q2ZKd2o1em44TWQ4UUZla252QWZkVXNh?=
 =?utf-8?B?TktlMjhoVG04UGQ1WEN2MTg3SVVRcWprTnpjOERJR0FRbDRpYlNDSkpBQldI?=
 =?utf-8?B?RTY4SmF1amVhNi9SckdWVCs5dFVrODZjNTZzU1pRSEYxRU9JaWhoL2ZWQVVs?=
 =?utf-8?B?TlVrVkduTmUwRSthcVJ0TjhzU3hHS0xucFZYSTRSNkRzTi92dTFZWkNIcmtu?=
 =?utf-8?B?dllKblNLOVJtQW1CcVM4VjRiSDl3YlMrTWFETlFPRjdJcGVTUlJkbUp3R3Fq?=
 =?utf-8?B?akhLVFVqR2RacHdTSnlrQkJ1RWxxSUhiMUNSd1FQMGRQTDAzSlVTc0wvZDBi?=
 =?utf-8?B?eGRtQ0k2dk1KRzZQUjUrbVNESERWaDdyT0hOTC9QSnErZWVYMmt3RWZxTVY3?=
 =?utf-8?B?SWxidHRaSG80SGxrT2NkYXNiV0xkc1czaGZ2dTFHSUZSOWtEVXdBTm5nTUpa?=
 =?utf-8?B?WGtpZzNSWVU5azV2VmVBRXMwdUovNzE4dHhWdWZ5QmwvVXdwSUZlckRnelRH?=
 =?utf-8?B?TXhiSkRMV0o5L2hpRDVnR1VvZlBkNEdpdngrL29iTCtLSDAzNUFYdGxLTE5q?=
 =?utf-8?B?RzJUWUlVV2dONnplNkhFcTQ2UC83QkhPMDVwaUJ2THNnWlBCWTN5UTN0TDFN?=
 =?utf-8?B?QU9jL2FKd3VrOVJLU2lXcUFkR25NSUZoTmcrZUhDaVhOaXFBb1ZhL0FCd3Nv?=
 =?utf-8?Q?mgd8n33cY9r47xnRSzJesShHHPsy26d0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU5lOGE2dll5R3JYbFI0c3RnWk1aWUdHcm55cVJNeVd6Q25wNzViTEFrSlhL?=
 =?utf-8?B?dWNaY3JpaHk3aVVYT3ZNQ09yZkt2VUdZajFjTUpFTmVhMG1JR0lvSkg4L2Rp?=
 =?utf-8?B?K3YzTXlWVk9ZN0o4TWZJcmhVS1MzUDlzYzZTRHdGbnZIcGtMeHBjeWpVbXo0?=
 =?utf-8?B?VjVSRkt0alVPdnRFTjdZenpoRk0rdWlkOVp5a3dDMXZUVnZiS2pNSGtRQjZX?=
 =?utf-8?B?eHNtRGNhdjNCdU5sV3VLRzRtcVZBZGZiTUxaZmlJSHRCRFJLVittdVRvVktz?=
 =?utf-8?B?SHhJSDlCalRFeEd5Mk5wTDFrclMvYkpicHMwbm8yVHNqNlNzWFg1OEpiTmJ4?=
 =?utf-8?B?SWdINTl0TTd2S3d3dlpscWlHK0oxaHk0WUgwTHYvYWdlSlE3RFd1b3ByNFNG?=
 =?utf-8?B?YzdZZUtuQ0RqcVdRVU9mNnNxY2lETUZ4amVORGJ2NUpTS25iM2lDR3c5Qzly?=
 =?utf-8?B?d2FyeEFUamxyWFRkSXZvcERkWlE5cmJFV3RydmcxdEUybEFLTElndkVMd0tB?=
 =?utf-8?B?RWxPWlNMNEpqbzUwSUNLMjNYZlJKakhzZXBsdllYZnVHMnI4VXFoeWtPVGhu?=
 =?utf-8?B?bkViQkZSZWp0UkVpTXd6QTJUVGJoRGFlb1NDVUdyV3p0N3FEcHhSUmRIMWpY?=
 =?utf-8?B?aGdGZ29KOXpnS2kxSW95Qm1SbExRRSs5cXVqSGx4ZHdubWRTZHM4Mjc3eHFH?=
 =?utf-8?B?WmlMelEwc0UraFRQVXdob2pZUkhSM2JWeWtadWNacmdwalIxY3JlTFdtTUxv?=
 =?utf-8?B?U1JhUkp3UzV2V1R4TkpuR1g4aFJVcVBpZHBab2NOVWNuNTFuSTZsa0RwOHZn?=
 =?utf-8?B?RjI0MnpUNEt2TkpNV21jK1dzRWtPYnZPV0cvOXI4bkV3LzU5b3JQUFI1MEt3?=
 =?utf-8?B?cm1mcnovZkxkVzRDT29wckZrbG4xNG03Rkhaa0k4TFdRZS9JZEFocU5abGFT?=
 =?utf-8?B?SzA0LzAzS0xwdG9PNks0ejByL3RNTUpJWmlwVWYzVDhUZHd1MmhxemtRQWhK?=
 =?utf-8?B?NEFqYmxxQWhuS05WMVBZd1hzTU1aWFdYeTVrQjlKSStlbUFTdWlna2ZhWGRV?=
 =?utf-8?B?ZTBVV1dJYUQzTE42WFJtMndNNW1MUE1jSTJGZ3hVYWd6NGMvK3V6R1VUWDhT?=
 =?utf-8?B?ODJsT2JGT1JiWmtPalIxZ0hEL2JLNHowNEk0VVVCL3RFV0cyUDA1dHRLeWFh?=
 =?utf-8?B?Z2RFdWxRbHFxNEtOL2ZWaFd0YkM5VTlJUDUzOUN0QXJJeDRUOFNsK0kxRGpG?=
 =?utf-8?B?b3JDTkdRK2g4UnpvQncwODVUN0V4cHNKRmd4QlhhSXJ2Mm4yQWJNd010NVJn?=
 =?utf-8?B?bnB0RzdWUE5oNk15bHdRUXJPZkVVUkoyNW5xRGpyYXZ5NnE0V2I4MXpUQ3l4?=
 =?utf-8?B?dmlqaWZ1SGd5VVlRVExhWjdHNVJObDlKbTJ4eTVVdWJ3ZUMzdTdDdldzL1Bk?=
 =?utf-8?B?K3lpZENOcEFESEVSM05rQ0FFYTBxcGJqVWpWRmJ3S3NGWHhoWWgraUdSUDQ3?=
 =?utf-8?B?VGJoUU03YlJFc2Q4VStsTHVNZ2Q3Q2ZEZ1ozNUpqQVhpeGRCQWd6WWFuZGNU?=
 =?utf-8?B?VE1XM3FvOTN5TTNYVklrZU1UcUtGTU92S2NDR2NqbFVxVmpVbTltWVdCRGlH?=
 =?utf-8?B?Q29JQ0FkcEpKb3QwWTZONHBVZ1Y1MUVlN1hTdzR6N2laUUh2bVMydXg5Y3NV?=
 =?utf-8?B?MFBwL21uMjN4ZjhXQXVsdW9JU1ZPcXRET2ZTdFpicDAyeWdKbW9ZTjBxWGR6?=
 =?utf-8?B?TS9wbmNCaUxHUkNMREF1RG9XWjU1ajVuU0NnZTJXU3lDckEraEdZaVNQNTdI?=
 =?utf-8?B?S3hINjBxM2xCYWR3Skw4cFFzanR5Nnlhb04wSDd5a2MxSjJuYTFCRXFvV0pW?=
 =?utf-8?B?enpvRTJoTXovWVB2VXdTOVZlRXY5bjZlVUhTbFkyWXR3QzRZdnZmeGF2c3c2?=
 =?utf-8?B?cm1COHppM2FsNnlONTNxVmNJUFBKUjF0ckMwVC81dndGZ1V3Yk9wNlhjV3Vs?=
 =?utf-8?B?aHpuanIxUFovYU5rcE1yS005OEl5WHl2OHlySDhWNUt2V0R3NmNRZnNnOTM5?=
 =?utf-8?B?UDlPelJ5bnd2bFhnR0h3aWdqdXJ0cnpOWURBUnZOME9JMGhSRWxKK21SSDN4?=
 =?utf-8?B?L1ZhOU1vS2VZSzhGcFQyNEFjdU9OamhXSHpoMlphSGoyV2UyS3hSL3padVZ3?=
 =?utf-8?B?Mk5LUkl4RDhsaC9QZWw5aStvOXFUM3BNMUNPdmlzSTcyODRwWmhRUW5TcG9Z?=
 =?utf-8?B?Y1pJaG8wR0ZxZ0hURHRhYTRMa1l3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ac44bf-2df3-4384-d065-08de226bf442
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 04:20:19.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87hr3rfFNQLmW8LBmG7QiS5571vhxSkoyTacPaWRD1jK/GF1lpuYACs+oKu86X/gjjtK0vDQHwVgvNaPFjWrrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

On Tuesday, November 11, 2025 10:34=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 11 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 10=
:55 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Lets add Tegra114 support to activity monitor device as a preparation=
 to
> > > upcoming EMC controller support.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/devfreq/tegra30-devfreq.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegr=
a30-devfreq.c
> > > index 8ea5b482bfb3..d976077d4757 100644
> > > --- a/drivers/devfreq/tegra30-devfreq.c
> > > +++ b/drivers/devfreq/tegra30-devfreq.c
> > > @@ -980,6 +980,7 @@ static const struct tegra_devfreq_soc_data tegra3=
0_soc =3D {
> > >
> > >  static const struct of_device_id tegra_devfreq_of_match[] =3D {
> > >       { .compatible =3D "nvidia,tegra30-actmon",  .data =3D &tegra30_=
soc, },
> > > +     { .compatible =3D "nvidia,tegra114-actmon", .data =3D &tegra124=
_soc, },
> > >       { .compatible =3D "nvidia,tegra124-actmon", .data =3D &tegra124=
_soc, },
> > >       { },
> > >  };
> > >
> >
> > Looking at my copy of L4T r21, the EMC count_weight should be 256 on Te=
gra114, while it is 4*256 on Tegra124, so different SoC data should be used=
. (I haven't checked if anything else is different)
> >
>=20
> You are correct, tegra114 seems to use 1 EMC clock per transaction. I
> will move and expand comment from tegra124 entry regarding
> count_weight to include info about all 3 supported entries if you
> don't mind.
>=20
> I have a question regarding tegra_devfreq_device_config to be used
> with tegra114. From tegratab kernel I have, existing
> tegra124_device_configs configuration seems to fit tegra114, may you
> confirm this? Or, if L4T r21 you use, uses different values, may you
> provide those to fill up tegra_devfreq_device_config for tegra114.

Can confirm the offset and irq mask are the same. The coefficients are a bi=
t different in the L4T tree but they don't match the upstream tegra124 valu=
es either so I guess that's fine.

Here's the exact values:

static struct actmon_dev actmon_dev_emc =3D {
        .reg    =3D 0x1c0,
        .glb_status_irq_mask =3D (0x1 << 26),
        .dev_id =3D "tegra_actmon",
        .con_id =3D "emc",

        /* EMC suspend floor to guarantee suspend entry on PLLM */
        .suspend_freq           =3D EMC_PLLP_FREQ_MAX + 2000,

        .boost_freq_step        =3D 16000,
        .boost_up_coef          =3D 200,
        .boost_down_coef        =3D 50,
#if (defined(CONFIG_ARCH_TEGRA_14x_SOC) || \
         defined(CONFIG_ARCH_TEGRA_12x_SOC) || \
         defined(CONFIG_ARCH_TEGRA_13x_SOC))
        .boost_up_threshold     =3D 70,
        .boost_down_threshold   =3D 50,
#else
        .boost_up_threshold     =3D 60,
        .boost_down_threshold   =3D 40,
#endif

        .up_wmark_window        =3D 1,
        .down_wmark_window      =3D 3,
        .avg_window_log2        =3D ACTMON_DEFAULT_AVG_WINDOW_LOG2,
#if defined(CONFIG_ARCH_TEGRA_3x_SOC) || defined(CONFIG_ARCH_TEGRA_14x_SOC)
        .count_weight           =3D 0x200,
#elif defined(CONFIG_ARCH_TEGRA_12x_SOC) || defined(CONFIG_ARCH_TEGRA_13x_S=
OC)
        .count_weight           =3D 0x400,
#else
        .count_weight           =3D 0x100,
#endif

        .type                   =3D ACTMON_FREQ_SAMPLER,
        .state                  =3D ACTMON_UNINITIALIZED,

        .rate_change_nb =3D {
                .notifier_call =3D actmon_rate_notify_cb,
        },
};



#if defined(CONFIG_ARCH_TEGRA_12x_SOC) || defined(CONFIG_ARCH_TEGRA_13x_SOC=
)
#define CPU_AVG_ACT_THRESHOLD 2000
#else
#define CPU_AVG_ACT_THRESHOLD 50000
#endif
/* EMC-cpu activity monitor: frequency sampling device:
 * activity counter is incremented every 256 memory transactions, and
 * each transaction takes 2 EMC clocks; count_weight =3D 512 on Tegra3.
 * On Tegra11 there is only 1 clock per transaction, hence weight =3D 256.
 */
static struct actmon_dev actmon_dev_cpu_emc =3D {
        .reg =3D 0x200,
        .glb_status_irq_mask =3D (0x1 << 25),
        .dev_id =3D "tegra_mon",
        .con_id =3D "cpu_emc",

        .boost_freq_step        =3D 16000,
        .boost_up_coef          =3D 800,
        .boost_down_coef        =3D 90,
        .boost_up_threshold     =3D 27,
        .boost_down_threshold   =3D 10,
        .avg_dependency_threshold       =3D CPU_AVG_ACT_THRESHOLD,

        .up_wmark_window        =3D 1,
        .down_wmark_window      =3D 3,
        .avg_window_log2        =3D ACTMON_DEFAULT_AVG_WINDOW_LOG2,
#if defined(CONFIG_ARCH_TEGRA_3x_SOC) || defined(CONFIG_ARCH_TEGRA_14x_SOC)
        .count_weight           =3D 0x200,
#elif defined(CONFIG_ARCH_TEGRA_12x_SOC) || defined(CONFIG_ARCH_TEGRA_13x_S=
OC)
        .count_weight           =3D 0x400,
#else
        .count_weight           =3D 0x100,
#endif

        .type                   =3D ACTMON_FREQ_SAMPLER,
        .state                  =3D ACTMON_UNINITIALIZED,

        .rate_change_nb =3D {
                .notifier_call =3D actmon_rate_notify_cb,
        },
};


>=20
> > Cheers,
> > Mikko
> >
> >





