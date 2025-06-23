Return-Path: <linux-pm+bounces-29308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09696AE40AA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E011718892B5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B121C9F5;
	Mon, 23 Jun 2025 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ee4OXkf9"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012043.outbound.protection.outlook.com [40.107.75.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2613C9D4;
	Mon, 23 Jun 2025 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682234; cv=fail; b=HYlYC+FVu8DfXImn2GSIVRyNX1nAp2S0MRRU78oIMSHsOwJrIgq0R4N7/bzSlKJl/nLkaRaSCZbvjOar8d7R52sqoSEZTM0SMfmup6DMPBaRcKCcUFBMlJ0O6qNsTOD7cfO4Pwe/gKxu90ZjDE/QkR972fQlt6ceWUPXkqTarVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682234; c=relaxed/simple;
	bh=wU4yGuHecdRil7Go1Kci+NaFPbtnYjHgVKucw0O2nC8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AKMhBniKGw3cV9cQlgxofm1aShvtrHRRJMB0VJ2SHOF8APCV7sphZzEu7Wlh4dSV/RVg0Rx7goIxhWx2ndRqHC7zNzuaVvcyMYv1JPXA6StWtZEq95R9T3r8O3O1l590YqOoK68PiLm0ffzxwB3rNUgqyhLBNALaAv8Oklalbg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ee4OXkf9; arc=fail smtp.client-ip=40.107.75.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qD0aaEvO666D0goqxSQsI/7xyWTuMxtL2AFDjH+D7Xzus8XpsYgtWBP4MoXm13+ye033hc41A1FyaB1BvaQF497bWB6xBhwlxekU0tt0jggQQ6ZW0Ymk5C52F8JbTccTUOvfbB4zsAO5q9QNEkMT0OgjzVoqvmvOOrDwX4H5MONOLLzAtiKKcYezzVybrZ2lisvBkmUTfCPbvaSevtCosplKct+4Y+aoBaRrCHajteY7QoiGrq48ogbdh+BxCNGMdsOc06irdoA4+QV6gO1zkCRWd01ecOXrN/DmQap/RXGn8HWjy1CJWKADWBaIOGIqPgHl7S/0MpcF/jDUB32bOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btLHxzjwkqaJdTaAPpeWOJKLa/Oe6y4ZXomp35AzxCk=;
 b=hMSCc4wpaxG6gO3m0Wx+7eIs8SltFuxFrBH4p4Q9W4GC4A4iSECuIwfhQqXaaX5JaIeAEgo1yp0JWG3F0LGSiZf2R5cJNVLhnp9G6vvAVqZNtsmfC3NJPHA14ghB4Lw6Xqdz4DVGOho3+I3NNu+CF0MWMCth2IVX5SSVNsMQMS71A6Oi8mQI0XVNKpPzHp6jLN4y/hQ2CTrORpFz4w3xVkU+Dt+wm+M+B5d+D5JoAPsAQsZrbHKIIwgb8f/XvRhpVzngYmPszdBMlKo6gnrAkD6/S2WQNuc30Q2uWvsZh4CTdIwau33HSRjhRWxn6naRs7SdXANmgFOLnknVExOdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btLHxzjwkqaJdTaAPpeWOJKLa/Oe6y4ZXomp35AzxCk=;
 b=ee4OXkf9t1D3nnOs8RwDXs0MAFMFrAQl5XA12vP5ZQUfxktEoWHXJHjZrhO7W5IIw3gC5kdhn3aNbSXUcfniYMHTey3ATdZ0Sfz2QNbLITMBFaeMAyNo2SRNpuakxVfDR3UM4EiZwDWEk+C7wHLKWeFdz1KZ2ayfIpcGZpJDamKCwsHhPsIg6bA4+FXz9q3S4qh9vIsSlxGyHlHZEXA3iuFIWork1JHsClNYVSgIpHFt/XmZGgG8wCGuwa7ytdStYCpsEkDTJGKe1QaRX2xWoaSvbxNpKQKeu4xvcZG5sb0JjjN+7yMF+frSvj8o081siO+ErwCCa4uTaKY2mf5azg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:37:09 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:37:09 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 08/24] thermal/drivers/renesas/rcar: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:36:27 +0800
Message-Id: <20250623123627.473612-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: bec5c918-876b-4988-5c5c-08ddb252abb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3Qwem56NGFCSEttZDVwTHF6eHc5Q0Z0NWdjMXAxNC9CdGkweGp4aUxiQlBz?=
 =?utf-8?B?S1JkZWFTcGlORlZpN0JFbVgzZUhMM014dkRPOHMzV0svL1R6WWdod2pRdDRw?=
 =?utf-8?B?L1FmbDdQN3k3M1ROblEzL0ptcEYvRFBUbC9PM2VnVmd6akpmZnNsWjFrZmtU?=
 =?utf-8?B?bkpaeW1KNEdpdTh5UkJTcERaYktSb2pnVjg4RktUZERDbjlBV0UxeStzQUdt?=
 =?utf-8?B?Sm5IK0JjR3FBSUtZK0F1R2NIaVdNd25nU1BYTExQZjJsSndmL2NQcXBJcXJM?=
 =?utf-8?B?c2Y2dHpDb08xZEZQb2FSQjJjcGpLV2wwMWdRV21PaFBUa294aXNEU2d0cGUw?=
 =?utf-8?B?US9KcWx3Y1VSbnFjZXBRUXJYNUxMZjJBbCtOc09ub1lCR2g1UGtDZ21xcjFQ?=
 =?utf-8?B?OHhVUTJWbmp0YnRUcm12a1g1TDNIQVhqTmFmUjlHRGlNbVRXNjdIenZ6OG5n?=
 =?utf-8?B?KzZGVVFpZDYzeEU4VUI3M2htYk8xblVpeTVTWlZMeHQ0anNnTEtuR1FzT1Aw?=
 =?utf-8?B?TWhEZW9oSzM2NEpad2V1dE1MLzh2RnFrV1pERlJncTl2VEd1Tk5pSmxNR1Iz?=
 =?utf-8?B?UXR2VHhPdVhDQmFGa01URzNSdGE1WW9xMm9LODN2L2NDZVFTa1Rndzk3MDZW?=
 =?utf-8?B?M3NwdFNiWnJGR3Y1b3BOUmZlZlJELzh4bFhxMGNNQU9aOVRLUmZnb3paZmdL?=
 =?utf-8?B?M0cyQ3UwK01DSW5HRXJIaHVHdUdLc3VQS1lMdTlBeVVTdlliWnVKUXdyOHBE?=
 =?utf-8?B?TzdXUFF5WmJqMkJmWCtQbFB0VjdGR1VlMkVhNnRNMWUwRXkrOEZHM3lSQzB2?=
 =?utf-8?B?QjdWdGxTVFo1SjBKWnVlTWg5SVJHbTdHMnk3ZlpHU2M3MmY0VW1XOTJNcGpL?=
 =?utf-8?B?Z293UFNUcWJIbGE2Q1pVTmVmaHdGSmhRdm5hdDZkU1lFcXpoYzJCR0xQMkJu?=
 =?utf-8?B?NFE2UEJSek1qS04vWmMvS2dzQmFldTV5bmUyMmw4ek9CNzh5b1VFWFVNN3JY?=
 =?utf-8?B?cTl2WmNSMlJCczkycW9hVjVSeEtVWVRHQWJ4aTZ5dFJnbGVIUnVxcERIWUR4?=
 =?utf-8?B?emQ1SmFja0lEVzFZZEZkWkUwa3E1SUpHaCtaVENwem5mR2FOZU5oY1FqN09M?=
 =?utf-8?B?QS9Yc3RxdXM2Y0xydGJTUklOL1NweTFyUlg3WDNNY2dCZVg2Z1hDRDk5Y2g5?=
 =?utf-8?B?VXk2dWd0aU91dWIxRzZ1K0NhbitnTldIbGxCWU1EbnVrc2lIcVpzVUhBanhN?=
 =?utf-8?B?amw4NVhFTFlwZTh5NGtlWVZjaEpPTkdhMlNjTk9uM0hTbi8rQ0Z0dDJRSTQ2?=
 =?utf-8?B?elFHcy9veW9XZXh4K2tkYnUrMmJialAwUUFVaTdGaEZFN0p0ZVVuZ0gyZFBZ?=
 =?utf-8?B?T2k5ZGx6NllNaUhHWkFBUjNDYUI2ZlBXMEZKdCtneSt0cDBSWGRUd1IrMXZG?=
 =?utf-8?B?WURxczNxaGJCTnlGSlJMZk9OZFFobWFlVlV3aHA4ZFhZcGpVZVoyVDE2VVJU?=
 =?utf-8?B?RllNekZMT1IwQzlBNnU4aHhKNjJEak5xYm9IWVRGMkh5aEJJbTdjZFcvZmJL?=
 =?utf-8?B?MWtXR0pIMkF3N3ZwaUdxcklvYjVDajlETlRZZVpKOUpKMjlEQXZWNkUxUDJC?=
 =?utf-8?B?dS8yM1dlbXg0Z1RKVWpZMXl3QmcwUitYblJReFUzcVdLUExqOEU4TXpJcnF5?=
 =?utf-8?B?ODhQemFrNklFb3JQOWdkRE5BZ0FXYWYzcnpZTlROZWpSS2dCdm9ad2x3cUFT?=
 =?utf-8?B?LzZCWXlGK3FZK25LNktJN0xIYmdZeCtJRzdSbkZ2eXdzMWM5TG1SUDk2ZDA1?=
 =?utf-8?B?SElFMHA1NStKWEZ2cGJ2Yk1tcFVUUVdwY0xLUjZlbUpwODdnTFVKSDdRM1I5?=
 =?utf-8?B?TVlPU0tGY3dKYmtLYWVpRWZQa0pLWEhBRVpJdGpoTW1reVU5enM5SVpjcmph?=
 =?utf-8?B?SllIYmJhTU02Q3dBcXVwM3VEY2NBcjl3UzNmTURXaHVZV0RObzhuTFNTYkE1?=
 =?utf-8?Q?1w+amFRVG+qUjWasQWnR3fy8zrY4T0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTRWZmcvVmwwZjFwcnl2NnJPekMxN0ZIU3haeG8rUEZSbTh6UHE5RFpZYkVo?=
 =?utf-8?B?ZktlUUZrcnBiM2t3U1ZXZmFLaXFKbkIvYmFmR1VPNFZLc2pXKy9Da1JpcTlw?=
 =?utf-8?B?MHEvSGRFNVdIODkvMklGM3hyODVKZnIvTUJnZm1TVVUxMVRkdHdhRjYxM1J0?=
 =?utf-8?B?RGpGLzdNM1V5WU4rc0RIV3RCOTR4WDhNOVYxNWhhY2FZUWNBeVFqZHplcXM1?=
 =?utf-8?B?WUxvejJKWWt0cEpmclIrV2MxUDd6RGFyU0V5SElGTGZwZjR5Y3dBYXRMbXk0?=
 =?utf-8?B?bEQ3eno3UkVoYWxLL0RUa2txWWZPZ0FDVFdac2RjVjlRUHFHQWg5MnNLaVpN?=
 =?utf-8?B?dnFiL3Z1cVBCQWtzdWd4clNneW53RVhsUnA3aXdIdkJuUzN0aUVFeHEzMGxO?=
 =?utf-8?B?RWo2MExhRGMxTi9jWXNpNjZ5NjJxdmpFVG5ZYkxaamE5Qk5kdFNONU9IcU8r?=
 =?utf-8?B?MkhYM1NvVUE2ZGdlYUZNMmhiVThoUGszbVREZ25iYlQybGNraXBiZUNQRVha?=
 =?utf-8?B?a3h2SEo2eEFjTTNTdDZubnp1QnBNaFpMS2NBTy9xMDlpK29LdVZNZ3MrSXZK?=
 =?utf-8?B?VXlZbENZMnk4QVoyTjFGRHVzZGdhaWF2Q2c2b0g5UENyRlNDSjZEdDZIa1lQ?=
 =?utf-8?B?Y3VNbjlZTzVZR3hadittYmozNmU0N0xObFFpelpFVUJERWQxNHJ0MklLVXZH?=
 =?utf-8?B?eWFXQld3OS9iTEV1RDdXRGthaW1ETkFoNkZPWTVCemdwWWtlbERkOTBEb2lB?=
 =?utf-8?B?VHhGbUswa3FVbkdid2N1ZU1IamM1Ull6Z0lLSTJQcTFUalg2Ylh1elZ3a0sv?=
 =?utf-8?B?U09HN1pYUVRqK3hKRUxDTS9JWXZlbE5QUUpZVVVNNzlDYUhFMDYvWElRN0Zp?=
 =?utf-8?B?VzQxWUY1azBBN3pJejQvd1VCbmphQjl4OUk3RUlkbTJGR0VWS3dFOHVmOEtZ?=
 =?utf-8?B?bHlLWmUrZS93RW1kVmE2ZGpPMDNsOGp6aGRaUDNIWFpoWjljRksrZmZIQlI2?=
 =?utf-8?B?Yk1rU2ZuWUQ1V3hJb3E5aVRINTNkV1p5YkxIeXE1azVzM0x0VWk5Qzd2RVo2?=
 =?utf-8?B?aEM4UEhiNXJ1UEpXdlB5Wnc2VUZaQUtQZjZlUExzSDEyWEZSTnhBamdWeU0z?=
 =?utf-8?B?dWtKMHUwOXdTYkwvNmF1WndWWDNSYTE2WTRVU0ZDZ1BoTEh0cXNVRjN6UnVi?=
 =?utf-8?B?Q3JmZW52TFJDS2tNQUMwM3VoQnpvSjM1alExWTl4SW9wdEsvM3hldEtSd3Zo?=
 =?utf-8?B?MVpPSHFRNUhneU5xc3VNUVBnUzNvTXZFZUFCY1JDNEtqbzBEbTVQK2ZyLzFK?=
 =?utf-8?B?YjNTc1VuYW1UdEp3YktRL3lPUENocGdtNElBbWlPM3U3OUlSbmNHdEU2SUg3?=
 =?utf-8?B?cUJ5enZzeUNzY2FWdTl6a1JRM3lMUC9SUlFVUEIvZUdQWU45SW5ERi9NMGV4?=
 =?utf-8?B?U1ZkTm0vU2Z5YlQ1QzFCR3JSVzFEZW1nODVwUVVIdHZTL3J3Vi9COW1zL2Ns?=
 =?utf-8?B?aDBKTEFiMm1mK3FSdlV5Mi83aEJXL0dGVE9adnFSd1ozdzlseStiYXcxSExT?=
 =?utf-8?B?RnpnN1pVMUdtNy8wbk5JSzNPWFNDdlkxQkx5WUhSZnZ5eTN0VDNuM04zQnps?=
 =?utf-8?B?dmNUTys3VDJhVnM1ampzeWRNeXFBSUhEam5ENGF6OWNKZXZneUY4TDRKNXhO?=
 =?utf-8?B?QUpHOTJaQmJ6NHdTN3ZzelBGcWhseWM4R1F1aThoZE0ybHJ4b1ZyN05ZWDdH?=
 =?utf-8?B?WXBLQmFMSHViQzRWVEF3eDVwcUlaSFI3Rk5GVFhvTzdtbzRoWTd1aUtDTmZh?=
 =?utf-8?B?U0N6S3d6eVpVekFkemRmMzdZbitLYWRKbEZiamF6RDhhWThhOGs1Vm5DWGh0?=
 =?utf-8?B?Tnkwb2NZemc3Q1lyaDh0UXNuQTNDVm95ZVYrQlIvU3hHdFdXRVNkZnUwUnQy?=
 =?utf-8?B?SXpFNkw2Tk1EN0JRclVwbzBaVEptTjhrYzhQOFRaM3kvdS81djh4SlMvM0x0?=
 =?utf-8?B?NXNESnMwemhoMUprZDFUWTM0T2JWdW9IZTV6STE2MXRDNEZzY3I2NTRJdFZY?=
 =?utf-8?B?NnR6MS8vU1hCMnlYK2tRUWwxTmhUc2tYa3hjdm4vK2FQcTFCT2ZIV2xPVHcz?=
 =?utf-8?Q?MfKgNSe/uuSjvHffl66ioWHQK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec5c918-876b-4988-5c5c-08ddb252abb5
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:37:09.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coxkRM5NMUP0QgIzrY7yGnAefbhexWpCIHLyTJV/F3BTScXvqwuqgP2ZJTn9Eb5i0sDWE5Hu6WP00KtqY3Yrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6196

From: Yangtao Li <frank.li@vivo.com>

The new devm_request_*irq_probe API prints an error message by default
when the request fails, and consumers can provide custom error messages.

Converting drivers to use this API has the following benefits:

  1.More than 2,000 lines of code can be saved by removing redundant error
  messages in drivers.

  2.Upper-layer functions can directly return error codes without missing
  debugging information.

  3.Having proper and consistent information about why the device cannot
  be used is useful.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/renesas/rcar_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index 00a66ee0a5b0..30cfac39fc4d 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -444,12 +444,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			idle = 0; /* polling delay is not needed */
 		}
 
-		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
-				       IRQF_SHARED, dev_name(dev), common);
-		if (ret) {
-			dev_err(dev, "irq request failed\n");
+		ret = devm_request_irq_probe(dev, irq, rcar_thermal_irq,
+					     IRQF_SHARED, dev_name(dev),
+					     common, NULL);
+		if (ret)
 			goto error_unregister;
-		}
 
 		/* update ENR bits */
 		if (chip->irq_per_ch)
-- 
2.39.0


