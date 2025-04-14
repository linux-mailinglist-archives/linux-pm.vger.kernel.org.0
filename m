Return-Path: <linux-pm+bounces-25356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20BA87AA4
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 10:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69818188CCBE
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DE625A2BB;
	Mon, 14 Apr 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K/xBOnU0";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UHa1xhVm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E425A34F;
	Mon, 14 Apr 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620157; cv=fail; b=enjQW9uGp7oOMeS0U17GKw+V1rphPAxz9zI3n52Idzrko30B/MICdWX14s74kNe74Fuvzjqnrbjz5uoQintIqiPRqf0Q6SfUQEvYDMNuaREBkz2+USI/jmDNYAIiieA3U6RoTPJga0K8SF4dKDWTF2E9T1plCZXgPfCW+zqUFmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620157; c=relaxed/simple;
	bh=nZMwd7uZWgLGy/domUcI3mPimVYEvLWMYAIsEWrEXxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lYBuJ3sJjaA8zKrw31x0lO3z08yWvhVQMApDkNdOHsROiCy/MDW46FLvS8FgztORjckCTy/YTXtU4JRqFsQQ7t0qgrr3QJ16Pl80SuoOVXYlrUm7h350U/LYQMH657sJGVFGzOGWthVehMxgnjthIyclVUYjIZa9lYrCtGor6+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=K/xBOnU0; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=UHa1xhVm; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 652a08b0190c11f0aae1fd9735fae912-20250414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nZMwd7uZWgLGy/domUcI3mPimVYEvLWMYAIsEWrEXxA=;
	b=K/xBOnU0glqwQYdwXFRo9IY531ohMWMIadr3cKjLu3NONjAVarsfAbMB8oeNNbI5QNFt+DH3MY87HdF5yIp0jS/n1OtnPdS9x8BfFZY+BVqx2xV2MB/cQrDMk8lrPy0z7miPlQdGhDI0v6GetZSCA0SXA2PB6YiblfnJdhEU2n8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:5f6173ea-cc43-467a-a86a-c37a579d6e72,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:4c90388b-0afe-4897-949e-8174746b1932,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 652a08b0190c11f0aae1fd9735fae912-20250414
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 980573865; Mon, 14 Apr 2025 16:42:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 14 Apr 2025 16:42:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 14 Apr 2025 16:42:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhLWjPaYnJ5Um6Q+oWNlY2lf1KIlgYF6GtSOeG2PaMwPuUzfVTZfcYSDgFar9R2OQ8Kl5ym/jGiHwHli4oqx51xqpnFMkai0LpIh2V2yfuGM88yqk87mLaqGYR/Y4Lw/w9pkRnIGj+GUj+XrU/r+q/q2TSP59i985JncNqpGoomsq69Pi1mY1byzk/OQSad88o4x6lvdGHgdRv/R2VhzcOcsjPWhi5X9wKEph6yfYhe4h1ulwSghdnd1OGoPw8fZ7MXAeBU9fm1k4AiEwqxHgnirSTTg1LsGlsM529qGNV7+taW4hJGMqyiPBOuRtlNwVtGmXzfc1ivsc0xxRpRFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZMwd7uZWgLGy/domUcI3mPimVYEvLWMYAIsEWrEXxA=;
 b=DIPKvrckjpYcw6Z6Tj5/WnMy7vJrgeCl87VWbaAsx7wjtAsMj2iUmacGPb5Mw2PzAFrPqKX8mF9lBlROlpvAj3VjxGrBJk2F5y7bRtBXCWokHMkuD/e/h1cjbfCqNlGbauOAPS/NRUERrRMTWtgdu7NQ2H5G3w1bv3b9J977Jn4y7c5K9g1wlxEBXvJX77iz5VfsjICRkkFHhTAbOBzOakQnXv8OTYJRuDsHmVZbJte7LAuzFj92tZSyjzDuil1b4tJexI1xav6Zj4C+B/GQOOphnD8aDmDKWWyIH/u6J3vUesQgxfTA4K+h9ZlMimYTdfq8ZYZf7TFpwJ0bFr0wxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZMwd7uZWgLGy/domUcI3mPimVYEvLWMYAIsEWrEXxA=;
 b=UHa1xhVmPRLs3rDz+6+Vc82INOZjO3hj0tNHYts0fftZlgQcgza9Ro0D4YsT+OgC37guH5vBJiBvyf3HMskUP4g2wlKVWXQu1IKc7SMHURiOT1+nfQGaYElc85TggLgYMH9qnWd7M+QbdN4ZS9qNtGZi3a18rRMV9+1O5GaUXp8=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by SEZPR03MB6444.apcprd03.prod.outlook.com (2603:1096:101:48::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Mon, 14 Apr
 2025 08:42:23 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::c9d6:2574:8710:24fd]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::c9d6:2574:8710:24fd%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 08:42:22 +0000
From: =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?=
	<Chun-Jen.Tseng@mediatek.com>
To: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "rafael@kernel.org"
	<rafael@kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "myungjoo.ham@samsung.com"
	<myungjoo.ham@samsung.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kyungmin.park@samsung.com"
	<kyungmin.park@samsung.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Thread-Topic: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Thread-Index: AQHbfrQ2e/+qwhbOe0mntrlJoHcSLbNOJJ+AgC3AXICAAVjNAIAACfiAgAAITgCABIoWAIAAJ8+AgCEy6oA=
Date: Mon, 14 Apr 2025 08:42:22 +0000
Message-ID: <06356a55cdb3c34dfc716349d1967f95655b0ab2.camel@mediatek.com>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
	 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
	 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
	 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
	 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
	 <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
	 <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
	 <e1c2c12bace22d1803d16ecbfb32129518d87157.camel@mediatek.com>
	 <20250324054333.sgwwksawnybx3lp4@vireshk-i7>
In-Reply-To: <20250324054333.sgwwksawnybx3lp4@vireshk-i7>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|SEZPR03MB6444:EE_
x-ms-office365-filtering-correlation-id: de63c491-d0e5-4ce0-ca80-08dd7b304674
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NmZYRTIxU2pxZXlLWnhWQzBSVGY4Q0FiQ3lCMVM4MEcxY094MWlLUUFBZ0pR?=
 =?utf-8?B?bjlqNVVtS1JmVTJZUE1SM3p6MXl2YXFJV1JGVkdhcDJnZTlteFFRbURmbW44?=
 =?utf-8?B?MThHSklZbTd3NmtBQ0dvdTNtamlaRVdneDFjQjRSTm9lVHhScXlsM2k5dHNI?=
 =?utf-8?B?OW5JLzlydGhxSC8zSWNWbTgyc1Jzc25FaWl0TzMzM0dNUGNsL0FNYmdpV2wv?=
 =?utf-8?B?NUtkU290NGNLRDNjRE0rRkovMW9ST08zRlJHQzNpa0hXSGMwMnpqVWIvNUcv?=
 =?utf-8?B?OHREQ3BDL0ViNkpxYWJnQ3U3SzNwUXBjZUlkT3Y4czgwYmJWT21rdlBOQUlG?=
 =?utf-8?B?b1M0bnc2a3VvVmZQOGlFZlZsSFd0VTBTSFE1bGFBR1duYTBwRjlNdU02aXdZ?=
 =?utf-8?B?Zmd6YzE4dEJGTVdrOThITUw0KzhiY2RKWktUdGpSQnJrZE92dnJ5TmZJMkIv?=
 =?utf-8?B?ZmdXOEFVVW1pZldESEJjdThveDVMMnpxRVNTQURmVFFZYlNiZWFVUVZ3OFVK?=
 =?utf-8?B?aUgvS1A0OWJyVHczSzd4SVFwVmhpeHJ6WkUydzl5SklFY2JITm5tUXBvbEpR?=
 =?utf-8?B?OTZMckNlTEFRa3lkRkVnNEt1S0VDamtHR1k0Q3BGTy8xWWxJLzMvVUxHVDRZ?=
 =?utf-8?B?bHdoL2tpdmRITmZJejg4RHBteFJOcFJOcGMvb21jekZ2dEJHTDg1VVN3N3pH?=
 =?utf-8?B?RUk5SEc5NWxkL3JVN0hCRGhnb1Y2ZTg1VitZU01RZjNMdVV6THMyaWE4UDJr?=
 =?utf-8?B?Ylh4akQ0d21QUnNJMkROYllxMnMxZ1B3VCtneWZZcnVyV1kyMUNaK3paZ2ox?=
 =?utf-8?B?QjVFUkUybERkNGtZVDhIY3ptald4YUFoWU1CM3ZvaE9SbjhPSjR6WVg4UjVU?=
 =?utf-8?B?V29DQ25tenZNRWs3dmRCQit1ZkhtQkhKdlpCSE5vNlQxM0NWMnVWdm15UzMv?=
 =?utf-8?B?UnJJcjRMaXBwSHJWSVAxOE5ZYzloVjlPYkxkMTVJaXNkZ29SdFVGWlJSOSs3?=
 =?utf-8?B?MEp0U29vcVo5aTJMT3U0cVZQWW51K3lmVFRML0pGdFNVM0cxeG1ML1Y5WTVG?=
 =?utf-8?B?bjZLSUREdU5ZZXNuekx6VGI1a3hyNGlyUnBQTThHRVYxbTEzZXpPTTg3ZWNq?=
 =?utf-8?B?bDdUMXBkNmFRbjR4NzVOSzVTMy9PTFAwejFSTVhaY0ZrWjljTlV0V2hpbmdr?=
 =?utf-8?B?bm12TTBLS0VGYko3Nm92TXl3Nm8rYW10VVBoT0hrRGczOHhVTnJiRVFTQXpO?=
 =?utf-8?B?MlAvYzhvMjQrNVZCTW5PbjdqdUNqL2VRNFNhYlJOK0pQempzQmk0OUpsZ1RK?=
 =?utf-8?B?YitzNkt5RjVDNkJuclRaRmd4NndsLzVIU3ljTjhpdzRiWDNueEU2cTBRNVps?=
 =?utf-8?B?a3ZnVlVOMDRkSkNTNzBXZlR0SncwVnRBTk10cU83UXJWQmt5QzNwUzZnM3Jh?=
 =?utf-8?B?djU1Q3plWUN5RjE0NlExZDU0NjRnQ0x1eFlDRmJxeXVVVjNnUk5ZRFBURlFK?=
 =?utf-8?B?eERlelA0NEU1blI5dk14ZmkvYkZDTENrdGc3L2x4bVF0MEI2UTZjTEpYUjRh?=
 =?utf-8?B?REphVzJ5WXRSZURob1gzRDVWa0U4RzJWQVBKZldQQ21GaXR5TXQ3dzRSQTB5?=
 =?utf-8?B?WFA3UzA0cDJGYThuQXFmYWQzZlBtRlBFNXp1YVJiS3NrUU5iM0hBR1piSjBa?=
 =?utf-8?B?aFY1U3NYZDVCbGNHY09uWGk2RnVFR3lIT0YyMmRGbm44NDU1bEV2WVkxVmJl?=
 =?utf-8?B?U05oMnJPMkVOSmhRQXI5UE1MMXNKYXFwaStGTUl1NmdmbVY1dy9oUGkvQVhk?=
 =?utf-8?B?RUFEWHFjQUdnNVpLMFd5djdJaEw0V2RIOWlTWGkzUmt5OFlYRm1JZ0Y1UVNl?=
 =?utf-8?B?UUxnTmJJa2ttZzNsb0p1cEtrUDFWcDE0VUUrZmVwclVJbjhqeDRCZnRtNnFW?=
 =?utf-8?B?UjUweVZCOFRRMVJrcVJzb0hoSHcxMkpPM25SZzI2cEhoczBRbmIvNkJjSCsz?=
 =?utf-8?B?MDVxb21oNlVnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFQ3U0JXT2xsS3BUM3VBZUhVeEgrTTRpaGQ0RmlVUHZUOGJHNjJ5Z1JIVlJI?=
 =?utf-8?B?L3N6K3lHMGZ0TnhVeUNkbDBvT0FkREV4bEZzTXNibU9ZcFBQNjUyUjBqL1pZ?=
 =?utf-8?B?MWxTSjNGZFV0N3JQbW4rU09oOCt6WS9zdk1FZE9XWVBqQnI2RFZLYmM4WE1n?=
 =?utf-8?B?MzNEQTU3dHN4VVR3S3JHT1hBN2QxYXdkaWVJQ2pWcXlFaFkrWDBTYUE4OFRT?=
 =?utf-8?B?dXcrSjRpM1cyVC90SDdtcTJYVzQzTnB5cFd5d0JlcWVwZEM1WlorVUlUY1E1?=
 =?utf-8?B?QzN0aHJncmVPUk9scHg4V0R0ZjBUTHhkbXhmUFplL0xvN3A4RlhKWGozWm9P?=
 =?utf-8?B?Y2E4ODdjSFhPVWhCQ0xpMWtTZHdkckpuRStHUVQrSnF4NHd2YTlQUXY1djBh?=
 =?utf-8?B?QmpURmwvM3RLdlM2ZFoyRFRtL1FzeWJieVBxM3dvWk9BQXFIbDZtZldKVVFO?=
 =?utf-8?B?MzB0NS9pdzNnMmhhQVB5c0dhaDVUT2tDVEIyQkFQRmt3UHZoV1ExdERTcGZI?=
 =?utf-8?B?bGJvMVF4QkhjOXpjTDNpUjk2clNJWktpWkVqUFFxQ203dkZIU1hBNEt5UkxF?=
 =?utf-8?B?QkU0ZUtzWE9Wb0xJeFdDMDgvRzl2Z2Rjb0tudFJMckNTYVAyc3EzRkFjTnZQ?=
 =?utf-8?B?bjA5bVA4cExYcFhOdFRGSHdmdFVab3AyLzBaWjJHV1l3eDVqZktxdWhRc2VC?=
 =?utf-8?B?OURoNmRxc0JzTWxCRUxaM1JRWU9zWTlwVWY0RDA0dm1CaXp5ZjQvVmZKSk1r?=
 =?utf-8?B?REI5YnVyUTV2ckNKQlpDRFBaYm5hdU9salZhV0p1MXZnV2JnM3ZFSGNLRmpY?=
 =?utf-8?B?dkpodEpkRDB1VWFYc3BqMjVsUmh6Q3FKVmZmVWQrMHlremZXclk3bnRhaWJl?=
 =?utf-8?B?VHZ5RFNiSnMwUXlYeC85SFRxT1gxdFZkUmVIODJiVUdIZ3lidnpXMk11TlBY?=
 =?utf-8?B?ZjdVZ3VkK3l2UTlnT003Ri9SMCttQmtyN0Fkb2I4OEdNckpkNERGUERxcmR0?=
 =?utf-8?B?VGtyQm9MbXFlanFJRExOd0tCQjNRU0s3clhoL0ZrRjBKa3ZmRDVjS0w5NGtQ?=
 =?utf-8?B?WHZsUGpjVkU5MEx5angxSjhOOVBybGJoZkNPREN6R2pocEVRVFFQU0dtNGpU?=
 =?utf-8?B?KzhiRno3K0xvVVE0VXFITStEUlhmN2NhRzZ0YTZKMXVDYTVFQXh6ZWd1TUhz?=
 =?utf-8?B?K1Y5OVQ5bTh5WTZ2c3g3WGFnNGFIZGF2dHEzS2t3UzVCR1h6NW02VGlmNDI3?=
 =?utf-8?B?UDVqTjIvRjRuRXFtb1JNSXhEZWtJZ2tGUkgvM012dE1lNkxpWWxEbWxTMkpS?=
 =?utf-8?B?OHdaOHMyMTV6Z1RVTWtJc1NTVHV4SVRZenF4bUJlZXBVeGFMOGczRjVXMUdV?=
 =?utf-8?B?Z0lxOGNuakxNMmQrdUV2Wmx6YWJRdXB1VzVYczFKU1luZVR5TUdIYzZKYWFo?=
 =?utf-8?B?a1dqci91b3d2cFNVbjlYZzN0eStvaXVhMDRsTXpnZjlXSmVnTmtUMzdKL3No?=
 =?utf-8?B?UGV2L3paZ2o3YW5YZDkxeStZOVZoR2taN1hXZWNLWXg5SHBKdDdPNGl5QnpF?=
 =?utf-8?B?SXM3YTd5MzJ5Zm55VHBEZDhzaWJ0YTdRdkg3Vmp6MHdqalhMclJyWTkwbC80?=
 =?utf-8?B?U0hXazlRUUIzZmdrSW16eUw5NTZlYzllRnd5a0EyQmVoem1GOXVHak42dDN3?=
 =?utf-8?B?dEoyN0Fxa2NuRDhzTUdUNXk4SHZ0aGpQa09UOHZYSStDN0VsTDNLWWtLcC81?=
 =?utf-8?B?UDY0K2NDSFVaQis3Z0M0aUFSdkkvbVVSc3N5UVNEWjRhMU5lRnhibjFtcldM?=
 =?utf-8?B?NENYZjczZVRENkxXeHZlTE5QWW5LVFE4ZDhNRmtxOVhDaW81VWxIVjJMMnZK?=
 =?utf-8?B?VlFiVWRxSFJjSksvUkRxRjQ4QnA3c3ROckxMZXFmdktlbjZNMXhuRFFlUXYr?=
 =?utf-8?B?cG8wc3hsQ2ZYVU1GanMzZzVYeTc5ZFlvZXRXcExyb0E1eG5PU29ubXB5L244?=
 =?utf-8?B?cFVYeGJSenBEdTM3MVF1bklCL2syb1ByZFVNQldOQzF6WXVkZVRGdjY0Q1BJ?=
 =?utf-8?B?Mzk1SjBPQlp2UC9PM0ZYR3UrK3kxc3ViRDhmdjdUWkFXc0dVYlVsS3dPLzNM?=
 =?utf-8?B?MktIN3pqOE5VV1k2cUtCeE1LT2RQWmVYRk8xOXlZTzlrYWlGMnNnM29ZakNw?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7F3036CC88628478B595CD16A709375@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de63c491-d0e5-4ce0-ca80-08dd7b304674
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 08:42:22.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrtJ53sNsgxfTq+2ydeT0gQ2PLmREl8tX8K5g5pKXSdGbLoWrgpqe1QC9sCf5UsTsgQ5WN6nfwTR83PQjhwjmm/ktL1b1rfwi/iCq/9I158=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6444

SGkgVmlyZXNoLA0KDQpUaGUgQ0NJIGxldmVsIGNob29zZSBieSBNYXhfTGV2ZWwoTENQVSAmIEJD
UFUgZnJlcXVlbmN5KSBpbiBkZXZmcmVxDQpkcml2ZXIuDQp3aXRob3V0IGdsb2JhbCBsb2NrLCBJ
dCBtYXkgY2hvb3NlIHdyb25nIENDSSBsZXZlbCBhbmQgY2F1c2Ugc3lzdGVtDQpzdGFsbC4NCg0K
SSBob3BlIHRoaXMgZmxvdyBpcyBzZXJpYWwgc2V0dGluZyBsaWtlLCBCQ1BVIC8gTENQVSBzZXQg
ZnJlcXVlbmN5IC0+DQpzZXQgQ0NJIGxldmVsIC0+IEJDUFUgLyBMQ1BVIHNldCBmcmVxdWVuY3kg
LT4gc2V0IENDSSBsZXZlbCAtPiAuLi4uLi4NCg0Kd2l0aG91dCBnbG9iYWwgbG9jaywgaXQgY291
bGQgYmUgTENQVSAvIEJDUFUgc2V0IGZyZXF1ZW5jeSAtPiBzZXQgQ0NJDQpsZXZlbChkdXJpbmcg
dGhpcyB0aW1lLCBpdCBtYXkgY2hhbmdlIEJDUFUgLyBMQ1BVIGZyZXF1ZW5jeSBhbmQgY2F1c2UN
CnN5c3RlbSBzdGFsbC4NCg0KSSBhbHNvIGNhbiBvbmx5IGRvIGdsb2JhbCBsb2NrIG9uIGNjaWZy
ZXFfc3VwcG9ydCBTb0MuDQoNCkJScywNCg0KTWFyayBUc2VuZw0KDQpPbiBNb24sIDIwMjUtMDMt
MjQgYXQgMTE6MTMgKzA1MzAsIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gDQo+IEV4dGVybmFsIGVt
YWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGls
DQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiAN
Cj4gSGksDQo+IA0KPiBUaGFua3MgZm9yIHNoYXJpbmcgdGhlIGRldGFpbHMgdGhpcyB0aW1lLCBp
dCBtYWtlcyBpdCBtdWNoIGNsZWFyZXINCj4gbm93Lg0KPiANCj4gT24gMjQtMDMtMjUsIDAzOjIx
LCBDaHVuLUplbiBUc2VuZyAo5pu+5L+K5LuBKSB3cm90ZToNCj4gPiBJIHRoaW5rIHRoZSBiZXN0
IGNvbmZpZ3VyYXRpb24gc2VxdWVuY2UgaXMgYXMgZm9sbG93czoNCj4gPiDCoCBjcHVmcmVxIHBv
bGljeSAtPiBzZXQgZnJlcXVlbmN5IC0+IENDSSBnb3Zlcm5vciBnZXQNCj4gPiBDUFVGUkVRX1BP
U1RDSEFOR0UgTkIgLT4gY2hvb3NlIENDSSBmcmVxdWVuY3kgLT4gc2V0IENDSSBmcmVxdWVuY3kN
Cj4gPiANCj4gPiBIb3dldmVyLCBpbiBkcml2ZXJzL2RldmZyZXEvZ292ZXJub3JfcGFzc2l2ZS5j
I0w3NywNCj4gPiBnZXRfdGFyZ2V0X2ZyZXFfd2l0aF9jcHVmcmVxKCkgcmV0cmlldmVzIHRoZSBj
dXJyZW50IGZyZXF1ZW5jeSBvZg0KPiA+IGVhY2gNCj4gPiBwb2xpY3ksDQo+ID4gYW5kIGl0IGRl
dGVybWluZXMgdGhlIENDSSBmcmVxdWVuY3kgYmFzZWQgb24gdGhlIGZyZXF1ZW5jeSBvZiBlYWNo
DQo+ID4gcG9saWN5Lg0KPiA+IA0KPiA+IEJ1dCBpZiBwb2xpY3ktMCBhbmQgcG9saWN5LTYgZW50
ZXIgc2ltdWx0YW5lb3VzbHksIHRoZSBDQ0kgZ292ZXJub3INCj4gPiBtaWdodCBnZXQgYW4gaW5j
b3JyZWN0IGZyZXF1ZW5jeS4NCj4gDQo+IFllcyBpdCBtYXkgZmV0Y2ggdGhlIGN1cnJlbnQgZnJl
cXVlbmN5IChvciBsYXN0IGtub3duIG9uZSksIGJ1dCB0aGF0DQo+IHNob3VsZG4ndCBiZSBhIHBy
b2JsZW0gYXMgdGhlIHBvc3RjaGFuZ2Ugbm90aWZpY2F0aW9uIGZvciBwb2xpY3ktNg0KPiBzaG91
bGQgZ2V0IGNhbGxlZCByaWdodCBhZnRlciBhbmQgc2hvdWxkIGZpeCB0aGUgaXNzdWUuIFJpZ2h0
ID8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIHJhY2UgYW5kIGlmIHRoaXMgcmVxdWly
ZXMgZml4aW5nLiBjbGtfZ2V0KCkNCj4gZm9yIGFueSBkZXZpY2UsIHdpbGwgYWx3YXlzIHJldHVy
biB0aGUgbGFzdCBjb25maWd1cmVkIHZhbHVlLCB3aGlsZQ0KPiB0aGUgY2xvY2sgbWlnaHQgYmUg
Y2hhbmdpbmcgYXQgdGhlIHNhbWUgdGltZS4NCj4gDQo+IFdoYXQncyBpbXBvcnRhbnQgaXMgdGhh
dCB5b3UgZG9uJ3QgZ2V0IGFuIGluY29ycmVjdCBmcmVxdWVuY3kgKGFzIGluDQo+IGJhc2VkIG9u
IGludGVybWVkaWF0ZSB2YWx1ZXMgb2YgcmVnaXN0ZXJzLCBldGMpLiBOb3RlIHRoYXQgdGhlIGxh
c3QNCj4gY29uZmlndXJlZCBmcmVxdWVuY3kgaXNuJ3QgYW4gaW5jb3JyZWN0IGZyZXF1ZW5jeS4N
Cj4gDQo+ID4gY3B1ZnJlcSBwb2xpY3ktMCAtPiBzZXQgZnJlcXVlbmN5IC0+IENDSSBnb3Zlcm5v
ciBnZXQNCj4gPiBDUFVGUkVRX1BPU1RDSEFOR0UgTkIgLT4gY2hvb3NlIENDSSBmcmVxdWVuY3kg
LT4gc2V0IENDSSBmcmVxdWVuY3kNCj4gPiA9PiBkdXJpbmcgdGhpcyB0aW1lLCB0aGUgQ0NJIGdv
dmVybm9yIGdldHMgcG9saWN5LTAgYW5kIHBvbGljeS02LA0KPiA+IEJVVA0KPiA+IHBvbGljeS02
IG1heSBjaGFuZ2UgZnJlcXVlbmN5IGJ5IGNwdWZyZXEgZHJpdmVyIGF0IHRoZSBzYW1lIHRpbWUu
DQo+IA0KPiBTdXJlLCBhbmQgSSBkb24ndCBzZWUgYSBwcm9ibGVtIHdpdGggdGhhdC4gVGhlIGlz
c3VlIGlzIHRoZXJlIG9ubHkgaWYNCj4gd2UgY2FuIHJlYWNoIGEgc3RhdGUgd2hlcmUgQ0NJIGlz
IGxlZnQgY29uZmlndXJlZCBpbiB0aGUgd3Jvbmcgc3RhdGUuDQo+IFdoaWNoIEkgZG9uJ3QgdGhp
bmsgd291bGQgaGFwcGVuIGhlcmUgYXMgdGhlIHBvc3RjaGFuZ2Ugbm90aWZpZXIgd2lsbA0KPiBn
ZXQgY2FsbGVkIGFnYWluLCBmb3JjaW5nIGEgc3dpdGNoIG9mIGZyZXF1ZW5jeSBhZ2Fpbi4NCj4g
DQo+IC0tDQo+IHZpcmVzaA0KDQo=

