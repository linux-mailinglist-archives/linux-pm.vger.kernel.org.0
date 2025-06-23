Return-Path: <linux-pm+bounces-29310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34474AE4093
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D87A81E5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2756E24293F;
	Mon, 23 Jun 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qT3Fyh8f"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013011.outbound.protection.outlook.com [52.101.127.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678AC2BB1D;
	Mon, 23 Jun 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682279; cv=fail; b=hiMXELtTkrKSjdjCt0Dd5E6ndvq1XKmG2jwwqRvsjSrccdfMlwCgRJMHtNKUXEfOaCnpPl9TO+GZz8+Ss06e/Gs+kAcbAoytybIUV7yMT+omw08PBtJOEH9iGZdBjHopbTQkwtonArycVR1wB2W6gJ0Ns2kUI9a5OoZBhXre/2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682279; c=relaxed/simple;
	bh=LOJIsiN8kkgSPG+DkApz/QiPf6srtRDeXuzDeZVZwgg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RtQcGrBTI1vBm4wCPmwNL1KRLCpORrQN810gC44JRyJezE5XjbpENLzqHskXi6o7XSu/w+e9NVWrgsNH6JYfTPYW8d2WWWQYRg+l74xioJd/sHoc1zJQy2V9T1LrFKmP9Z/WdtIjtYCFYwy1yDbx0U8H4gp96zk99Ptjg8AeNSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qT3Fyh8f; arc=fail smtp.client-ip=52.101.127.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYK0oLMtdPyilK1cv5luaJthLoRSsuMYGWFKQB4JyNhLttoxHm5Ev0/R1Km4pQDcVlSDFGiTZoRja1eurNUJWoEBxw039FJWpvvZuRx7Nyc7MbmDrPcfPLm6Ofm+/ly/vLbS4gpvIeuVk7kMs8FCUzJzkKoaCFPMDSlJDv0cI8OW2sKn1W73SDglkTfd/+UlPB9UNAJUPGhd/MAYR9+VXfCahza3bEbuhFGhlVlviJjY5GSzzFYx8IbfSZGDH453+UIUI2Y6r2S6a5kDTfPx0qVka3Akkv1TetkFQ4KjPHhCL1s8DLk4ebIQl0ckDfYE2tH/nwQNaQfjJ3KkcUV7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwfaVNjtYPVSS48geUPzHt0Vys8CeoMwiRwWDUiwVhk=;
 b=MvMi8E7P2E2fCA0ozaNIH6pyJld4kA7R3stfk6PXGyOXklrbI8r1geHaU5i01euMZUXRGVkE3bjo98dyMov31jO45R4qrAqBb27gqrdMFfXmGEBqgqBfAAoWCNEQR93LTXGq2++zgjgqNTO3ZUbybDHlMxckbiixq4JYdVioe7+c7LBVGcfvGY8cO9FrhVV50w3ELzFXhPsnlJL5U++6uycOD1OfdrJRNAnUKGatMUO7EgA1JuRk62t+/WBGVuYFRajgqvTlQPHpGM/UvW3yfl6eErRqpUy130X/FrK+jWyQ4Syu5oPEOD+QoR1En4ywm/5g+GQsmGNC42T6GY9XCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwfaVNjtYPVSS48geUPzHt0Vys8CeoMwiRwWDUiwVhk=;
 b=qT3Fyh8f6wx/ONpqvmxAv9YQeuuqViBIyu5XarWJYDpF/VKBMUm3QRjrFrVxV0zGRHBSAk7CorXjjoezr1CZSBfyCk418e0ikLRhwzsuy/mo1DzISeL0VAl73m2Pqj/Qmdogouf1acatRP6KcPPi1YfkMpgQiUZYEHDKp/V13dc4sr9ZxbWjpu0ZOQP2pns09kNtNKBwmiLdJyO694TgE3oBexL5naxpWpXeTf5moOOmw1D3BsiJ0hy6dC5Z/djeqIX+lwLAkyP0vZyOjVn763rKhCyRoWWcSKHwwvXDfFjZiqRQLLd6USAqlA9IoW9C6vCBq+5QiCt+Ef5agbaoaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:37:54 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:37:54 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 10/24] thermal: intel: int340x: processor_thermal: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:37:40 +0800
Message-Id: <20250623123743.473677-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:405:3::27) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a6db28-bd3f-4210-3083-08ddb252c671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWdwVk84dUVieDAvOEdTbVF6QVpjR3BCelVjL08zSURzcXV2a044UDIvSk1L?=
 =?utf-8?B?d012MlgyTnRsNkk4NnkrdndXT3gyaG1aWDB1cE1TSjMyRlpHRHVzM0Yvd2xY?=
 =?utf-8?B?QnFFbVI2Skw1VmswNUlwUk1ib1RXa2RYVmFNY3NvTlVUS2tGZHhIa3FoNVRL?=
 =?utf-8?B?MG9JKzV0aXdmNEFMZzlkRDJnOG9URmU5REdiZlVhRlhOUGMvTXA5VStTcHNz?=
 =?utf-8?B?WVhUd2pmMFYzTEZCdHVzaWljUEppTXV6U0hDSVRlYmNWbVRleGJjSE5QWDBL?=
 =?utf-8?B?UnhCbXVjTEZYMDJrdmF2MmxOcllLVzFwbnJBQVRrVytxR1JJN2tvRFpBQ1ls?=
 =?utf-8?B?RVg3amZsY2RldU40NDU2MXdLYWpuSkM4ZHo2cXVrK0Rnd013RVFCN2xJN1pE?=
 =?utf-8?B?MjcxT0E0YVA5V2I2TGxSb0taZUJuMG1kdXZOOCs3ZXV4dndRUWxyNzFnV3c1?=
 =?utf-8?B?cHo5ZUtzVmlvMlFhY3ZjQ3laRUo0Z1hSWTF1RkhpSUoyUWVlTTVWcXBNdHhj?=
 =?utf-8?B?cWdEdVNUYzNlbDBZVDRVTnhOaVpJbUtzSzc2cERabERJZ0ZQSVNqdUx6djFZ?=
 =?utf-8?B?QU1aRVdsMEdQYW1RaXpnVXNlOXJlTkZjenBXbWo2VjhsOGtBcmF6b2NONEZ2?=
 =?utf-8?B?ZFM5SENmR25CMGdhRHR2T2Q2OGt6TzI5MzE1NHBZeHRZSkxsTHlhcnhtNE43?=
 =?utf-8?B?cTZZaTFsdzU2SkJtQjY4QUdsMlBadTlwME5wNHljS2dvZ0VZR1lmdkZGaHVH?=
 =?utf-8?B?VDVCeTF4cEZwWEREV3l3SE9FUmpvNGVRWm9ZQnZJYXlNb3BxcU1rcDB4L2lm?=
 =?utf-8?B?VnB4c21mQlpLV1g0ZHRsbTYrQW1WaSs3VTRxZ3JaK1YwdWpjbHBQRndRVnNt?=
 =?utf-8?B?YnFBbWtZSWwxNUY2M0JmSlJHck1tSHc4MzN0YzVyNllVL0VqMTd2ektRZFZT?=
 =?utf-8?B?TmJTOCtCeVdRQlZSTkM1RThucWVLOWZuK1dBYmFBWU5hRWZJdXl0bjZvUTY4?=
 =?utf-8?B?UkhManBDRkRrdDMwRWJVKzNQQ1NQSzFQZXl3TldYaktjQ2IzaUxKRjJvU2wv?=
 =?utf-8?B?aWVnd3BJS2xKYzEyb0UrWC9YTFVBeWI5WitiNnA5VWpZWnBEejRWQUtrbVND?=
 =?utf-8?B?WERMZlNVNGRkRDRIZ3l5ajZtc2hkZUZkYjJtWjlZcTZiNHoyckFXOWdJZ1Bo?=
 =?utf-8?B?cmRiV0s5bDRsbk9ZV2VvdjNGSWplUzlicktmL2pNcXhFOHJ4dmhENStSYlkw?=
 =?utf-8?B?bUdaVFZaSEhrM293V1JabVZoOGUwbDNTWDg4K3pIcVlCTG9zdnY5bFVKd3N6?=
 =?utf-8?B?VzczeEQwVzFIRHlURisxQzFEdWJyK2NOWTVIc2pmRmd2b2U3TS8yeTF1ZXdj?=
 =?utf-8?B?MHBRYkY2Sm9uSlRsSittNzJhZDlyWEJSMUFmSldBRU4yUi83MnlPaXdkSm81?=
 =?utf-8?B?NXpMMWgzN2xPVUFrODZIMlVUcFpDS0toVzlEa2V3b2o5TGgwWWVFekI4dFB4?=
 =?utf-8?B?TEswYUJVcTJrcnRYam9kZ2RzbmF0eHMwWnB3RlB3aFR2bCs5TXZROTJlYlRn?=
 =?utf-8?B?MlhHVHRHNzVLMk4ydCttZTlUam5pTlpYY2pIcDBjUmd6QWFqOGJpSlZwMFZy?=
 =?utf-8?B?QVkyTzJ3dWJYaVFOTk1DR0t2OTYvanM2encwM1ZPZ3dxa0k1RG1obGFqVzRn?=
 =?utf-8?B?WTZyWUgyQ1BlMGpyeDdwVVVHNzBNTDJZRm9KOFFoc2ZJQ3FSUTBJdkF2VlVQ?=
 =?utf-8?B?aktDM3hZbkRHQkUzTmpwUXFuVnU0K1JLS2VZYTJGK0I3b0ZNa2I4K0VzR3Ni?=
 =?utf-8?B?UU9wZWtBRWpHV0FTZ2xFVllWK2krcWc0TGtMc3h5UEM1RCtJSWtnd3VBS2tN?=
 =?utf-8?B?MWdydVQ1OFFzcGJuRTc4cnQvRVRrQlpsYWlsRm4xZDgzOXRNY0ZBU3dJQUJw?=
 =?utf-8?B?N09JSVFZVW4vczNQbUtKbGMwTkJDOXl0SDF3dEt0UVBWSE1Bd0NiZWpEeCsz?=
 =?utf-8?B?RGxIdnlxMTR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2tmMDhROStuUGxXV2k1em4rOU1ORExBN0F2cFc3RU1hRkpyclNHWllJVXAr?=
 =?utf-8?B?cFBXSnB5bVBuMHd6WlFqZDFGRWs2d3VvLzhTSUxCSmlQNjBjMURzcUk3dTFa?=
 =?utf-8?B?ZGtuWlp1bWNKcFloejBjdGtKQ085WFVyUk5na2hJSTg1T0FnZWJHeDVsWnFP?=
 =?utf-8?B?Ym8wSkpDREJZdXhFKythRDdZaUYzdmdlbWRhY1NoZHkzeTFCQURTRUlGODIw?=
 =?utf-8?B?Z2JSM3ZLTDBRYVRkYnZSbTM5VXp3YzVqVUJRM2dONzF3Nitrb1NzcWJDTElx?=
 =?utf-8?B?SnhINzdtc21VWHdqekl2ZjdmTVlzSDFJM2gxTHcvSEx3elJxbVBnb1dxTDlV?=
 =?utf-8?B?RHM1MGZYc1hpdXBlWTEzakxTSWtQS3VHSEF0RnYyamJaSXB1b3FkQVdobCsy?=
 =?utf-8?B?THk5UHpzRDlRQlFtbmx0UkdjT2NHQkdqQzA5b2laVmVLUWs1ZFJWZE1BS1FC?=
 =?utf-8?B?amp6aTZndzNDaVQweDFzSjZTcTJ0R21tYUFmcE9DeXE4K3hxM3RNVFlJMWpN?=
 =?utf-8?B?SU92NXB2Q2g1MFJ6UnFQdnYzT0dSWjEzTmpmelJpNS8wdjRRUVl5SE5JN21R?=
 =?utf-8?B?QkZVblE0eFdDWmRzd3RLS1pqdlNudVFZVjFvVWdFWlZFU2EzRFRpUFhvVVJu?=
 =?utf-8?B?NS9LZEtJM21rQ0FLK21BK1pZOXRyeUE5N2lBblRvalNabFZ4UzMzN1dzSUFj?=
 =?utf-8?B?RHBCeXVGNm94bmJ2UGcwWkVVOWxNUVJVa3lQaWFSK3lmaEk1OEphdkowUWUx?=
 =?utf-8?B?MXIvMjFmbDl4NSt3UnIzNFZ5TVhXRWVxQThhenV1R3FwbUoxbFJycTBKWkZ3?=
 =?utf-8?B?eXpXWkJMS25ZZFNWd3hNa1ZJK3RHQlBMMGJxaG5qckw4N0NBa29lMnpCa0kz?=
 =?utf-8?B?MWVUcG1sVEQ4S3FMaEdNVExRNWNEUUJiWGFhaFJPbUhLMDRQbVc3VWU0dXAv?=
 =?utf-8?B?MUxESEVLb2RoYTVLc2tRSG5peTQyQnZsaHZML1I1S3QrZGN3U3FjNmpCUVMy?=
 =?utf-8?B?MFc5UjdEWmVCd0VXV2k2SWdESzNIa2djRCsxczJDRVo3UGc1TnpGSEpkZ3RW?=
 =?utf-8?B?S08wSGc2aTVrTXE0eFlWcXdQbDJLY1VvSVZWeGE5MngzeGZBUk8rTVBhNDd0?=
 =?utf-8?B?dlkyUXJsbkh0bjRxellpMGk1aGRrVDBpQTRuTVBuMDdORUEwSFVRVlh1d3dZ?=
 =?utf-8?B?YkJEa3ZxRmJ4czRhMWNMU2w3UXVCbTN1ZVNCNThJeGJyTytOYnIyOExDKzE2?=
 =?utf-8?B?NE9TS1F0WElHcTcyKzFKVTB0Z3RtWDZ4eS82Z3RkUXVuL0pPTXpWRW40RzE4?=
 =?utf-8?B?dkhPOFN4S3ZRU29WbGxXOXUvWmNGdTRuanNpOURXZk1HYmJRNW9zSm5xYmNG?=
 =?utf-8?B?dTdMZ0RiZVVnZGM2dEcwQllYUGJjRU5rQ1JadDRxOGZQMnJwSE51Z3gyV200?=
 =?utf-8?B?bzNXMTQ5bW1WSEVNQkcwSWN0WFBJRll0azBlQlU3UjJ3d2N4aXZlNHU4UFQv?=
 =?utf-8?B?UFJOVnpMUStDMDVReFJ2SkpzVmFISjdLVXFIdXk1cEMwMXRnRHlpbnBjQXR6?=
 =?utf-8?B?Qi8zbXc3V0pIQUU0REVYZ1JZbVAwL2cwWWFVcFlUbTBtNitYLzRmazZUa05w?=
 =?utf-8?B?T1BCb0p2TXpaSXk4aEdGei9tWFJSZ3VWaGYxUnhrVFY5NWcrNk0yUFdKc1Ay?=
 =?utf-8?B?ckx4aDh1SUI0cldhQllzdm05L1A1M3hzdTJ5VXNFa1JWZjlJWVNmYVhzTFJF?=
 =?utf-8?B?M0JrR0l4ODdrNGJremhmWit2d0R3UTVLVmJUNVJHeU1HSG1FazFtamZUR2Zj?=
 =?utf-8?B?RnBTd3F2T2FQYjdHQkNiaFVyWW1tN2FEWXJ4STJXMVNvU3loa05wWjVWWTls?=
 =?utf-8?B?Zy9SM3NCS2llZ1ZQL3RVbk5oc3dzRjYyRys3UzUxYng3TG43dWRveGZIc0I4?=
 =?utf-8?B?Z0phTW1ZcUxaNUNCRWgzSmM5MFQ1NDZzVUcyeU44RHI5eEw1UUNEZU12TWtF?=
 =?utf-8?B?eWFuSFV2MG9nZWNlZWJPVkVzb0hCbXZWUjNGVlA2TUZKR0pXVTZrQXI3bkZ6?=
 =?utf-8?B?eUY4UnNpMWVnY2RpdjFqaFZSYXUrZnBGY3dGMDExakZMTmNoTTRQZlJiUS9y?=
 =?utf-8?Q?jjqUAc0Nnsj9Tf0rFHZu/8LFT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a6db28-bd3f-4210-3083-08ddb252c671
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:37:54.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJBaNiIXiCV+7Wyf8fost2qj3vtjA9SvUw4iDT+BjE9doB1PlSaCeNld0J7PvNeKxdztVXp7ZEZ/CXT3VKloZA==
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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 .../processor_thermal_device_pci.c            | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 00160936070a..d3e3a53511c4 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -305,13 +305,13 @@ static int proc_thermal_setup_msi(struct pci_dev *pdev, struct proc_thermal_pci
 	for (i = 0; i < count; i++) {
 		irq =  pci_irq_vector(pdev, i);
 
-		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
-						proc_thermal_irq_thread_handler,
-						0, KBUILD_MODNAME, pci_info);
-		if (ret) {
-			dev_err(&pdev->dev, "Request IRQ %d failed\n", irq);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, irq,
+						      proc_thermal_irq_handler,
+						      proc_thermal_irq_thread_handler,
+						      0, KBUILD_MODNAME,
+						      pci_info, NULL);
+		if (ret)
 			goto err_free_msi_vectors;
-		}
 
 		proc_thermal_msi_map[i] = irq;
 	}
@@ -391,13 +391,13 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		irq_flag = IRQF_SHARED;
 		irq = pdev->irq;
 
-		ret = devm_request_threaded_irq(&pdev->dev, irq, proc_thermal_irq_handler,
-						proc_thermal_irq_thread_handler, irq_flag,
-						KBUILD_MODNAME, pci_info);
-		if (ret) {
-			dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, irq,
+						      proc_thermal_irq_handler,
+						      proc_thermal_irq_thread_handler,
+						      irq_flag, KBUILD_MODNAME,
+						      pci_info, NULL);
+		if (ret)
 			goto err_ret_tzone;
-		}
 	}
 
 	ret = thermal_zone_device_enable(pci_info->tzone);
-- 
2.39.0


