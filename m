Return-Path: <linux-pm+bounces-38429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15AC7F31B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 08:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E57E3A4C48
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 07:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F322E718F;
	Mon, 24 Nov 2025 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IUtg7TG7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ft+X2Lzz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC62D97B7;
	Mon, 24 Nov 2025 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969757; cv=fail; b=THLn8k5tfc8F0+xaeWTYnmzkLcLbEDZIlvLtoyw1sRmD8NzoUUL+b7fhONvcsfYKn/IyoywPKC9GoSzaXcpYK6jYAkrv4fR0Xwl80F2ihvZhoqmYHnIsdgNWgjj31tF03z0ShewjHYVIvZ/fCWtGfBjnEBsvm3dMoaE1+g+D8nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969757; c=relaxed/simple;
	bh=mq6V3b2H0EZ7eQdB3wI7VnhtIxC/D0WoHXh9ooaZKbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rBEyy151aAvwKfFKpD+Xe3QPoS0tIdGofUdWAdUrJCSlIsHyvM58qRsiEfXLI7iCelUUyxWkQXRmmlLsiBGlPSokBDj2lQw4Eh4K3U0upklZATKOZfiOWJHMiE68rNQD1kHYzAqgVfeCJV5rnqi+Cc/YqLwH7aK2NE4ks/G48Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IUtg7TG7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ft+X2Lzz; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ed9d87ec90811f0b33aeb1e7f16c2b6-20251124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mq6V3b2H0EZ7eQdB3wI7VnhtIxC/D0WoHXh9ooaZKbM=;
	b=IUtg7TG7dham2OYKLt1IkaYX2NFhvdcXISFvztkgzPnjqg5SQ9sh4uQd2g6HXKf80a2JUetwKmg7NA+TwlYLPCjEgu50bhVXJNGHTCIEtRNMmbjtuVi28Lz1nSLOWtkZoFNp5n4F+CoVTqxuReMJjc8MHNWAnC3RZGCwJv5l78k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:fafa75cd-9157-4a40-9a42-deba3b0f1de9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:7bfacee0-f48b-4fea-bcf0-ae56d774aa1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ed9d87ec90811f0b33aeb1e7f16c2b6-20251124
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1221853068; Mon, 24 Nov 2025 15:35:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 24 Nov 2025 15:35:41 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 24 Nov 2025 15:35:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Td9Sdn3wYi6CxpAd33licOqeEJj++TXf2DvhaZzgHH4AHqZLwzR6xioSKbfbbnFPIW6YVAwqfS/6/ZtgTvCQ4lR4fGyCN9QRgs+1cDQQZKC/g6RqC0ZUVuIAkhnyHGHJlsemX5DyAmLFLIKYB4q6iNCfLtgpw7/hieyEVmvZ0OVpnV2Eg9AyzKRMs6uKDFM4cjL8Ps9OmRWP6kKVjbyBa0dYRy7yN5gkB6X5iMJryvfTVWmsOx7jhrXH1LuFa48KRUAlF5II+UK4H8vVFDotKKJe0XYwVEHRwnP6wMwMDHQyLrs4QyNTr0GqG+9PT3+8DuYoIkGZBEOk9AA+vKN/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq6V3b2H0EZ7eQdB3wI7VnhtIxC/D0WoHXh9ooaZKbM=;
 b=huFR0BLHbPeSoCMKgnRhu3J72f4arm73sTwiU0kd65V5W6Txzv70V/RcWdwI1pGC1lrQW8IDhDJXJd+UGFEjZpSqD9xrs5qotb3mvfEaen0r2EqEYu/cbLYT0LcycCWiEv4jH6juC5torF0b1FAsICQ457Fo/+c75ww664HEZpjF5bxuTb4hanqeux1WdsOTsMQ4v17PSCf3urKhY/pNghrZUNXVLS1A15GoRWQZMsywblcvPYXFxmPpu9ZL7+Ye+gAkZgcIiDda6ETew+q2kJZHmfVg/4GTEpXzz/22jBQMgcD37L/sE+bwW8ILIlPOrHa1GamuFH9mwRUyHp9d1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq6V3b2H0EZ7eQdB3wI7VnhtIxC/D0WoHXh9ooaZKbM=;
 b=ft+X2LzzYSRNRTFAYRHNB6D+NnGG4TEkWb0CAg73uT3pJdhgAxU3/vuT2MtDu8lGA+W1HjBbidjIxAyFBSYBotwYU4QqIEH/One+c2s/Pm8IdAC2dKlYF2aIhstYWGqQVw5f5cHnvpi69W4kUGIjfq/eH+TjdXY4P8DJL4MtAHA=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by JH0PR03MB7421.apcprd03.prod.outlook.com (2603:1096:990:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 07:35:38 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 07:35:38 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	=?utf-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SXJ2aW5nLUNIIExpbiAo5p6X5bu65byYKQ==?=
	<Irving-CH.Lin@mediatek.com>, Ethan Hsieh <ethan.hsieh@canonical.com>,
	"robh@kernel.org" <robh@kernel.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "conor@kernel.org" <conor@kernel.org>,
	Nicolas Prado <nfraprado@collabora.com>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"krzk@kernel.org" <krzk@kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Jian Hui Lee
	<jianhui.lee@canonical.com>
Subject: Re: [PATCH - URGENT] pmdomains: mtk-pm-domains: Fix spinlock
 recursion in probe
Thread-Topic: [PATCH - URGENT] pmdomains: mtk-pm-domains: Fix spinlock
 recursion in probe
Thread-Index: AQHcWuXK+IXPz1SGEES5W19HEf8ijLT9IbCAgARSXoA=
Date: Mon, 24 Nov 2025 07:35:38 +0000
Message-ID: <dbe7446fd5a72d7ec4c9809e5ce2f0ce1c264a41.camel@mediatek.com>
References: <20251121125212.43093-1-angelogioacchino.delregno@collabora.com>
	 <07011558548dfc88fb237b7d21d43a6bc25dd0fd.camel@collabora.com>
In-Reply-To: <07011558548dfc88fb237b7d21d43a6bc25dd0fd.camel@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|JH0PR03MB7421:EE_
x-ms-office365-filtering-correlation-id: 03fbdaf9-9ef3-4a12-bb48-08de2b2c105a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QnZMTjZKUnJPUzJZcWNaRTdYREZJWmxpK0dWNkdBR2FuZ3p3VWQ0ejVGQ3VQ?=
 =?utf-8?B?aW00RDE4bFBQb2hqN2lkN2lncXIyNEI3b1dPNUsvQ2NqaER1dmJha3poOVpJ?=
 =?utf-8?B?Umx3eE5pU1o0bU9yYkNRektFNVRKa0MwTS90dEdVOUhzRWIrQ0FJT1JqWWh6?=
 =?utf-8?B?M0Z1R2hWZjgveGVEb05TeWNUZnJPSitOUWdSL3FuZDdYYjJ2OWZmRllGZVQr?=
 =?utf-8?B?MlgvNXVLRS9sRmo0QXBwTFZ4SkJ0bm05M0NiWm5LajkrMnY2T0VGZ3gxWDZp?=
 =?utf-8?B?eHlUZjRsN0JKZzdWSWVZUHUvNU5ua3hWaGNPdGlPcjNCb0h2c3lxMGxvRHJy?=
 =?utf-8?B?Qmt1bjBLK2ZZMVlLVG9sRHVETjV1TFhSanZOS1R2KzdxWW55M3lOamFydzEv?=
 =?utf-8?B?UWdLSlRmaWhmT1p5NksyNnhxcVlORzcyM1l1QkRXdk45NmtkaG1KNU1qaXJW?=
 =?utf-8?B?aFVGRUg4Ky9abTc0ME5VRG94elM1djBaMndJblRTQk55ZHpZcU4vbGpnZzUw?=
 =?utf-8?B?QmV1U2tkVWJmeXpycnZTNnFpZFdacTU2TXE2aUttQXJGTGZRLzFkcTk0OThV?=
 =?utf-8?B?bmFYSU9oZmNKV1FwTlRUdytYVnhnenVvMkhxa1NuTUE4bmZUVVVQVFRkc25y?=
 =?utf-8?B?Ykp0bUphMWhlcGpvSG1oV1N2b3ZxWGFDbCtXZHI4aSttZGZGUXBpdFlFYTRs?=
 =?utf-8?B?YXdpMEt6RUt0RWx5S3F4cmVqeVd5aUx3d1NHTDdWNVdEakVXMkhEejA0ZXZQ?=
 =?utf-8?B?Wmt0TkxRd2RwWFlGc1g4TkFiRWJLZmNmZ1lrQ1BadS8zSnhFejNEcXUxVHlO?=
 =?utf-8?B?RUJQUFlHKzVoTHJzYVpBRjF1N3pNaEtLV3dCQ3ZQYmgwaWJxa0xhQk9RSWcz?=
 =?utf-8?B?NHBTZjdOQkJIVGpPR2xDeFdiU3FTRndjVndvMHNLY0RXRzQyYTliWFlUM2ZT?=
 =?utf-8?B?b3VheE5sdlQzVERSdVd3VjBEem1HQVVyRUlMRXN4c0grUUJCTmNSWExyQ2sx?=
 =?utf-8?B?T3FVS3Y5a0RobUJLU2VaU05PSFFLenFKUU9RNVpqVjFWWW53SzVERTYxa0s0?=
 =?utf-8?B?dkkvZ0tYNUVpNEtxTy9YVFFZbnZyVlp5TFpFTGV2VGpOZ2hYR0w1NzI3Y05T?=
 =?utf-8?B?ZmhnMUhhWHcrdEpVeWJqcU02WWtTL1ZDbVdxSzdUOWJDeVBDRVJFaEtzTlUw?=
 =?utf-8?B?d2xyV2tadTI4VHJnQ1lwQnRNV2o3YjNhc0x1cUhnWTVOa0M2WDlyWCtMSlMy?=
 =?utf-8?B?aEVnamdRSnNvMjFrdjVncVdodnNGeUlIaXBjK3hmeDJiZHZnOHJUNlFZY1ZF?=
 =?utf-8?B?RTdmZjdEa2R2aW44NUlvRzlsOTNJMVVIeDk5Zzk0dmluU25zeFZicGJuMTRG?=
 =?utf-8?B?MjN5bUtMQUJ6c1lVc2Zab0RIMjQ2a0pHaTl2MEh2TVMvSFJZeXhZWVFOQkdE?=
 =?utf-8?B?QmV5ZU14bHJScGd6VGpsY0t4NVh4Y05xY0hPNE4xdmc1aGJhQzhyc0N2bHJy?=
 =?utf-8?B?c0d3UGZ1R29UWWRPMm5NOWFZaDBwSzFkYThyTVFKdjNGV3NOWXVJUG1VQUhC?=
 =?utf-8?B?WjBiN2MxcE1FU3lNYWNhMTdYOU53YndJc0dwTnAwVTN5bVFWWWZwTmR1MmdI?=
 =?utf-8?B?dTZSdmhvSDFPaW8wcU5KM3M5c2lqUXd4aG9iVFNxV0FJTERBUnJoNlBSKy95?=
 =?utf-8?B?K05uVTNqNjdMYXArQlNsVm5sTmpzaVVqQmhicWsva21Id1ZWVjhYWWYxakVM?=
 =?utf-8?B?eUVXU3Q4L096VjEvNE9xeWpMbzRmcDc5clYreE9TRndOdDI5KzlBSjYyRGF2?=
 =?utf-8?B?U290ZUZFWXJBQUUvV0Fid1ZqdlUzOE0xSm5jVWVXYWlYeEk4SEI4VjNoTDF0?=
 =?utf-8?B?Ly9sa25FRjhtRExJc0NHcG82QlNWWUV6TG0wajBiRXJqWjBoL2JiTTA5MWpu?=
 =?utf-8?B?Z2dwUC9zcE5UZFpOalFKck14S2RXR3VjUmc0QUxPaDh1ZkxrcGhzakxtbm5I?=
 =?utf-8?B?dzJXQXFSU09Hcm9nM1pxS3MvUzRaanVLcU0zYy85VDBuTUNuRTJtL1Z2SWp3?=
 =?utf-8?Q?O7uQE9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0Z4ZFI0QWZBUWZYTDhXRHBEb010TlVaWHBaNlB3eG5ObU10ZVA2VXRFU3pK?=
 =?utf-8?B?L1FnTWdabHZVZ3JQMEVvdG92c080OWRyd2UzYnhJWXIyZ3kwU0w1RFJXWEdO?=
 =?utf-8?B?OWdmQm5vSGppT0Fxblh6elRXeUNzdEtkZ2tBU1k1aVBYMjlSOWFFNUh4cHVq?=
 =?utf-8?B?bjZrNWh1Kzlpb1BTN29RT2lacDFMSHlXaEUxendVR1dQZ2hFWVF2VXh0am9B?=
 =?utf-8?B?SjNOTXAxN0h1bysrNDNONWFvWjFZRXV5UEdqeFVNRktUR05BZmRXb0hYOUs1?=
 =?utf-8?B?c3ZWM1J1L2ZHamYzMnBQR1RRYlJaMU94T3pQM1Ryd3lTTW5mb3FWc3VkNXNu?=
 =?utf-8?B?K3RmbnhSZHZDMkRFZzVJTURmcUN0WmdsSWgwdVZEY3FGQ2pGNDRKdGYzNDB6?=
 =?utf-8?B?MXlRT1hMZ2RxdThRaGs3b09WcVdraHFqbzc5SGEyR3ZaRmlNUXN2REFxaC92?=
 =?utf-8?B?LzdsNVNuYzdIbVY3RE9iUzFxdkc1K0IyTzQ0ZUdGQ3pWZ1B1VFhYeHZzSDN3?=
 =?utf-8?B?UkJNWkY4SUdRSEVlZEVmS3R2Y3gzdmRvcUNTbzNubjNEMmx3dEpHZTNnRDRL?=
 =?utf-8?B?U1lBQTU4bWpPT2V4MXZ1Sk8zSDQ4OTRhbkhaQ05aaDJrQmZ0dFZwZEttM2FB?=
 =?utf-8?B?a3VZdG9NOVU0bkhvVlBMUzZ5UmJMOWZzMEM0enIvRDVIRlQzVDU3dm9MQVI2?=
 =?utf-8?B?ZmlWWFlnK0czaVBOSlovMGRFaUVOUkV1REdZUDVIWGRYQlBzbXk5c2l1Rkw5?=
 =?utf-8?B?dFVLY3VCV21MMit0Rkg2dnVuUnhYQ0NXMzNoVkNuZDF6cDZQNU5ocWdNSk5W?=
 =?utf-8?B?T04yRXBHRDFjNmhGMXQ3WGtTU1MvcUtVNUs5cTEvYWdRSkg0QkRLcjdvWSty?=
 =?utf-8?B?NnYyOW1WSUUyRng2SXJLU3RTSGVnWktma3ErRG1oQzhaOUQ2dnJLUWRtdDFZ?=
 =?utf-8?B?Y3JRbTZvMHlvUE52QjNnalhFNnJrTCtrK29nTmRkanpBWnVvUlNYY2MxQVpE?=
 =?utf-8?B?c3FlNG5LeEh5WDB1c0lxb3FuU013Nko3MG0yN09URzJyRXBOWS9wU05vRnZH?=
 =?utf-8?B?NjQ1Zm1vcEpOSTdiRVRSM0Nia2hwYjhjbnVvbmh3Ym5ickkzeUdZbktEYXlu?=
 =?utf-8?B?SDVxMnk5R1A1TlRPb3Y0eUJyMjlLWHAvK0UrUUpaamNXY1ZHSDFVS21uakFx?=
 =?utf-8?B?UC9xZmhlcy9xMWY2eitveFYxR0YwWkQwRE1LaW9nbjJPSi9KaWo1Nmd0dlVM?=
 =?utf-8?B?akRqQ3E1MlFmRFByNFJ6Z0JBdnVhR3ZUQUhueG4rRS9zTHg3V1J0bEEyUDdI?=
 =?utf-8?B?WkJ0czNVVTBzT2FUdDU5TDVQNGd2V0ZWTnRPWlN4QXZiT2ZRbktUWUt1RlVO?=
 =?utf-8?B?RWpsTDlabFVVRkNvNTFqa2Q1NExnc2tRNy9vOGl4WnNSZGw2TnRlbzdyUTdD?=
 =?utf-8?B?cUhhekV5SDhrbVRNbmFlbGY1Y1J0cXpHQ200S3hjb3hOOG9rVDJMeFF1Njl5?=
 =?utf-8?B?dkFwcUJhTncrOU5uNzFraE96NnRaODZRSTFvN2daK3ZrY3FHdW4yU0E5bHBz?=
 =?utf-8?B?dFZwUW5XejUxd2pMRDA4bGFLN2c3Smtqbnp2dXA1MFBoenZ2eUw4TXdoQjNl?=
 =?utf-8?B?UUpETjY2bjFQVVdGTGZJQnQxQ1ZBVTNhUzU2VXZybTRGNHNVK0w5WnArSFJW?=
 =?utf-8?B?eHVRdGlwZm5nUFo0emlqTWtZcm9hYnBVTEdiTlVFVDFNS2ZOR2VrWWZnTXht?=
 =?utf-8?B?NmFFWFZNNkptdVk2NUNaYVYwRFZuWktxRU5IQ2lDM0ludi9ieWhTM2MrZ0NK?=
 =?utf-8?B?MlF4aWxGRXRpVlViVElEU2xNM3E2a0x1cUVKaFEzM00yRHd0cXphY0JLcnVi?=
 =?utf-8?B?NGpMdE5KeXZseldRSGxHN2J0V2xJY3lhMUliZDU0Tzc2ZXBtMkZ6T0FQUVpS?=
 =?utf-8?B?ejJzbXlISkZ4K1ZQcG4zRjl6S2NjVGZuVEpmVjVKM0U2ZUFTeFRFWkhWOVNr?=
 =?utf-8?B?MkRacjVQbzc2OVUxY3k2Z0gxaHQ0MjFmM1hBM1pEN0pqb0NXZm91a3JpSE9v?=
 =?utf-8?B?VEhPdDR5OUkrWS9leTgxbjVzUzA2bGpaNTFDMnFuTUNwUWxxTytqZUFjMGtI?=
 =?utf-8?B?L1BhVENEcGlwUisvbzhNbVZBTTh4V1dLc2lyWVpUenZSeS9haENLN2poOU9i?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28FCFF5549C5C9449E41B51ED1A08881@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fbdaf9-9ef3-4a12-bb48-08de2b2c105a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 07:35:38.5847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: acIkQzDsE1Yws8uUWBmZIUFy7FcSKOCwfjiDmij12DVq+NaR0pVN7H3OaUqQStAkhgeA6F7Lx4vlZWgJcbjlplbFsGr/cJwKZCPbIhhN5iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7421

T24gRnJpLCAyMDI1LTExLTIxIGF0IDE0OjM1ICswMTAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBIaSBBbmdlbG8sDQo+IA0KPiBPbiBGcmksIDIwMjUt
MTEtMjEgYXQgMTM6NTIgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0K
PiA+IEZvciBzb21lIHJlYXNvbiwgb2ZfZmluZF9ub2RlX3dpdGhfcHJvcGVydHkoKSBpcyBjcmVh
dGluZyBhDQo+ID4gc3BpbmxvY2sNCj4gPiByZWN1cnNpb24gaXNzdWUgYWxvbmcgd2l0aCBmd25v
ZGVfY291bnRfcGFyZW50cygpLCBhbmQgdGhpcyBpc3N1ZQ0KPiA+IGlzIG1ha2luZyBhbGwgTWVk
aWFUZWsgYm9hcmRzIHVuYm9vdGFibGUuDQo+ID4gDQo+ID4gQXMgb2Yga2VybmVsIHY2LjE4LXJj
NiwgdGhlcmUgYXJlIG9ubHkgdGhyZWUgdXNlcnMgb2YgdGhpcw0KPiA+IGZ1bmN0aW9uLA0KPiA+
IG9uZSBvZiB3aGljaCBpcyB0aGlzIGRyaXZlci4NCj4gPiANCj4gPiBNaWdyYXRlIGF3YXkgZnJv
bSBvZl9maW5kX25vZGVfd2l0aF9wcm9wZXJ0eSgpIGJ5IGFkZGluZyBhIGxvY2FsDQo+ID4gc2Nw
c3lzX2dldF9sZWdhY3lfcmVnbWFwX25vZGUoKSBmdW5jdGlvbiwgd2hpY2ggYWN0cyBzaW1pbGFy
bHkgdG8NCj4gPiBvZl9maW5kX25vZGVfd2l0aF9wcm9wZXJ0eSgpLCBhbmQgY2FsbGluZyB0aGUg
Zm9ybWVyIGluIHBsYWNlIG9mDQo+ID4gdGhlIGxhdHRlci4NCj4gPiANCj4gPiBUaGlzIHJlc29s
dmVzIHRoZSBmb2xsb3dpbmcgc3BpbmxvY2sgcmVjdXJzaW9uIGlzc3VlOg0KPiA+IA0KPiA+IFvC
oMKgwqAgMS43NzM5NzldIEJVRzogc3BpbmxvY2sgcmVjdXJzaW9uIG9uIENQVSMyLCBrd29ya2Vy
L3UyNDoxLzYwDQo+ID4gW8KgwqDCoCAxLjc5MDQ4NV3CoCBsb2NrOiBkZXZ0cmVlX2xvY2srMHgw
LzB4NDAsIC5tYWdpYzogZGVhZDRlYWQsDQo+ID4gLm93bmVyOiBrd29ya2VyL3UyNDoxLzYwLCAu
b3duZXJfY3B1OiAyDQo+ID4gW8KgwqDCoCAxLjc5MTY0NF0gQ1BVOiAyIFVJRDogMCBQSUQ6IDYw
IENvbW06IGt3b3JrZXIvdTI0OjEgVGFpbnRlZDoNCj4gPiBHwqDCoMKgwqDCoMKgwqAgV8KgwqDC
oMKgwqDCoMKgwqDCoMKgIDYuMTguMC1yYzYgIzMgUFJFRU1QVA0KPiA+IFvCoMKgwqAgMS43OTE2
NDldIFRhaW50ZWQ6IFtXXT1XQVJODQo+ID4gW8KgwqDCoCAxLjc5MTY1MF0gSGFyZHdhcmUgbmFt
ZTogTWVkaWFUZWsgR2VuaW8tNTEwIEVWSyAoRFQpDQo+ID4gW8KgwqDCoCAxLjc5MTY1M10gV29y
a3F1ZXVlOiBldmVudHNfdW5ib3VuZCBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMNCj4gPiBbwqDC
oMKgIDEuNzkxNjU4XSBDYWxsIHRyYWNlOg0KPiA+IFvCoMKgwqAgMS43OTE2NTldwqAgc2hvd19z
dGFjaysweDE4LzB4MzAgKEMpDQo+ID4gW8KgwqDCoCAxLjc5MTY2NF3CoCBkdW1wX3N0YWNrX2x2
bCsweDY4LzB4OTQNCj4gPiBbwqDCoMKgIDEuNzkxNjY4XcKgIGR1bXBfc3RhY2srMHgxOC8weDI0
DQo+ID4gW8KgwqDCoCAxLjc5MTY3Ml3CoCBzcGluX2R1bXArMHg3OC8weDg4DQo+ID4gW8KgwqDC
oCAxLjc5MTY3OF3CoCBkb19yYXdfc3Bpbl9sb2NrKzB4MTEwLzB4MTQwDQo+ID4gW8KgwqDCoCAx
Ljc5MTY4NF3CoCBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4NTgvMHg2Yw0KPiA+IFvCoMKgwqAg
MS43OTE2OTBdwqAgb2ZfZ2V0X3BhcmVudCsweDI4LzB4NzQNCj4gPiBbwqDCoMKgIDEuNzkxNjk0
XcKgIG9mX2Z3bm9kZV9nZXRfcGFyZW50KzB4MzgvMHg3Yw0KPiA+IFvCoMKgwqAgMS43OTE3MDBd
wqAgZndub2RlX2NvdW50X3BhcmVudHMrMHgzNC8weGYwDQo+ID4gW8KgwqDCoCAxLjc5MTcwNV3C
oCBmd25vZGVfZnVsbF9uYW1lX3N0cmluZysweDI4LzB4MTIwDQo+ID4gW8KgwqDCoCAxLjc5MTcx
MF3CoCBkZXZpY2Vfbm9kZV9zdHJpbmcrMHgzZTQvMHg1MGMNCj4gPiBbwqDCoMKgIDEuNzkxNzE1
XcKgIHBvaW50ZXIrMHgyOTQvMHg0MzANCj4gPiBbwqDCoMKgIDEuNzkxNzE4XcKgIHZzbnByaW50
ZisweDIxYy8weDViYw0KPiA+IFvCoMKgwqAgMS43OTE3MjJdwqAgdnByaW50a19zdG9yZSsweDEw
OC8weDQ3Yw0KPiA+IFvCoMKgwqAgMS43OTE3MjhdwqAgdnByaW50a19lbWl0KzB4YzQvMHgzNTAN
Cj4gPiBbwqDCoMKgIDEuNzkxNzMyXcKgIHZwcmludGtfZGVmYXVsdCsweDM0LzB4NDANCj4gPiBb
wqDCoMKgIDEuNzkxNzM2XcKgIHZwcmludGsrMHgyNC8weDMwDQo+ID4gW8KgwqDCoCAxLjc5MTc0
MF3CoCBfcHJpbnRrKzB4NjAvMHg4Yw0KPiA+IFvCoMKgwqAgMS43OTE3NDRdwqAgb2Zfbm9kZV9y
ZWxlYXNlKzB4MTU0LzB4MTk0DQo+ID4gW8KgwqDCoCAxLjc5MTc0OV3CoCBrb2JqZWN0X3B1dCsw
eGEwLzB4MTIwDQo+ID4gW8KgwqDCoCAxLjc5MTc1M13CoCBvZl9ub2RlX3B1dCsweDE4LzB4MjgN
Cj4gPiBbwqDCoMKgIDEuNzkxNzU2XcKgIG9mX2ZpbmRfbm9kZV93aXRoX3Byb3BlcnR5KzB4NzQv
MHgxMDANCj4gPiBbwqDCoMKgIDEuNzkxNzYxXcKgIHNjcHN5c19wcm9iZSsweDMzOC8weDVlMA0K
PiA+IFvCoMKgwqAgMS43OTE3NjVdwqAgcGxhdGZvcm1fcHJvYmUrMHg1Yy8weGE0DQo+ID4gW8Kg
wqDCoCAxLjc5MTc3MF3CoCByZWFsbHlfcHJvYmUrMHhiYy8weDJhYw0KPiA+IFvCoMKgwqAgMS43
OTE3NzRdwqAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4NzgvMHgxMTgNCj4gPiBbwqDCoMKgIDEu
NzkxNzc5XcKgIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgzYy8weDE3MA0KPiA+IFvCoMKgwqAgMS43
OTE3ODNdwqAgX19kZXZpY2VfYXR0YWNoX2RyaXZlcisweGI4LzB4MTUwDQo+ID4gW8KgwqDCoCAx
Ljc5MTc4OF3CoCBidXNfZm9yX2VhY2hfZHJ2KzB4ODgvMHhlOA0KPiA+IFvCoMKgwqAgMS43OTE3
OTJdwqAgX19kZXZpY2VfYXR0YWNoKzB4OWMvMHgxYTANCj4gPiBbwqDCoMKgIDEuNzkxNzk2XcKg
IGRldmljZV9pbml0aWFsX3Byb2JlKzB4MTQvMHgyMA0KPiA+IFvCoMKgwqAgMS43OTE4MDFdwqAg
YnVzX3Byb2JlX2RldmljZSsweGEwLzB4YTQNCj4gPiBbwqDCoMKgIDEuNzkxODA1XcKgIGRlZmVy
cmVkX3Byb2JlX3dvcmtfZnVuYysweDg4LzB4ZDANCj4gPiBbwqDCoMKgIDEuNzkxODA5XcKgIHBy
b2Nlc3Nfb25lX3dvcmsrMHgxZTgvMHg0NDgNCj4gPiBbwqDCoMKgIDEuNzkxODEzXcKgIHdvcmtl
cl90aHJlYWQrMHgxYWMvMHgzNDANCj4gPiBbwqDCoMKgIDEuNzkxODE2XcKgIGt0aHJlYWQrMHgx
MzgvMHgyMjANCj4gPiBbwqDCoMKgIDEuNzkxODIxXcKgIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIw
DQo+ID4gDQo+ID4gRml4ZXM6IGMyOTM0NWZhNWY2NiAoInBtZG9tYWluOiBtZWRpYXRlazogUmVm
YWN0b3IgYnVzIHByb3RlY3Rpb24NCj4gPiByZWdtYXBzIHJldHJpZXZhbCIpDQo+ID4gU2lnbmVk
LW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiA8YW5nZWxvZ2lvYWNjaGlu
by5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IFRoaXMgbWlnaHQg
bm90IGJlIHRoZSBiZXN0IGZpeCB0byBwZXJmb3JtLCBhbmQgSSBoYXZlIENjJ2VkIFJvYiBhbmQN
Cj4gPiBLcnp5c3p0b2YgZm9yIHRoZW0gdG8gaGF2ZSBhIGxvb2sgYXQgdGhlIHNwaW5sb2NrIHJl
Y3Vyc2lvbiBpc3N1ZSwNCj4gPiBhcyBJIHRoaW5rIGl0IGVpdGhlciBoYXMgdG8gYmUgZml4ZWQs
IG9yIHRoZSBhZmZlY3RlZCBmdW5jdGlvbiBoYXMNCj4gPiB0byBiZSByZW1vdmVkIChvciBib3Ro
LCBhY3R1YWxseSAtIGluIGFueSBjYXNlLCBpZiBub3QgZml4ZWQsIHRoaXMNCj4gPiBjb3VsZCBi
YWNrZmlyZSwgYW5kIEknbSBub3Qgc3VyZSB0aGF0IHRoZSBvbmx5IGZ1bmN0aW9uIHRoYXQgc2hv
d3MNCj4gPiB0aGlzIGlzc3VlIGlzIGp1c3Qgb25seSBvZl9maW5kX25vZGVfd2l0aF9wcm9wZXJ0
eSgpIG9yIGlmIG90aGVycw0KPiA+IGFsc28gZG87IGF0IGxlYXN0LCBub3RoaW5nIGVsc2Ugb24g
TWVkaWFUZWsgbWFjaGluZXMgYXMgb2Ygbm93KS4NCj4gPiANCj4gPiBDb3VudGluZyB0aGF0IHRo
aXMgbWFrZXMgKmFsbCogTWVkaWFUZWsgbWFjaGluZXMgdG8gYmUgdW5ib290YWJsZSwNCj4gPiBJ
J2QgcHJlZmVyIHRoaXMgZml4IHRvIGdldCBtZXJnZWQgaW1tZWRpYXRlbHkgLSBzbyB0aGF0IGl0
IGxhbmRzDQo+ID4gaW4gdjYuMTggKHdoaWNoIGlzIGF0IHJjNiBhdCB0aGUgdGltZSBvZiB3cml0
aW5nKS4NCj4gPiANCj4gPiBUaGF0IC0gYmVjYXVzZSBJIHRoaW5rIHRoYXQgcmVzb2x2aW5nIHRo
ZSBzb3VyY2Ugb2YgdGhpcyBpc3N1ZSB3aWxsDQo+ID4gdGFrZSBhIGJpdCBvZiB0aW1lIGFuZCBy
ZXNlYXJjaCAtIGFuZCBJIHJlYWxseSBkb24ndCB3YW50IHRoZSBMVFMNCj4gPiBrZXJuZWwgdG8g
YmUgYnJva2VuIG9uIGFsbCBNZWRpYVRlayBkZXZpY2VzLg0KPiA+IA0KPiA+IE5vdGU6IFdoZW4g
SSBpbml0aWFsbHkgdGVzdGVkIHRoZSBjb21taXQgcG9pbnRlZCBvdXQgaW4gdGhlIEZpeGVzDQo+
ID4gdGFnLCBpdCB3YXMgd29ya2luZyB3aXRoIG5vIHNwaW5sb2NrIHJlY3Vyc2lvbiAtIEkgZG9u
J3QgY2xlYXJseQ0KPiA+IHJlbWVtYmVyIHdoYXQga2VybmVsIHZlcnNpb24gd2FzIHRoYXQsIGJ1
dCBJIHRoaW5rIGl0IHdhcyBzb21lDQo+ID4gbGludXgtbmV4dCBhcm91bmQgdjYuMTYgb3IgdjYu
MTcuDQo+ID4gDQo+ID4gwqBkcml2ZXJzL3BtZG9tYWluL21lZGlhdGVrL210ay1wbS1kb21haW5z
LmMgfCAxOCArKysrKysrKysrKysrKystLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BtZG9tYWluL21lZGlhdGVrL210ay1wbS1kb21haW5zLmMNCj4gPiBiL2RyaXZlcnMvcG1kb21h
aW4vbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuYw0KPiA+IGluZGV4IDQwN2I0YTdhYmExMC4uNzIx
MjI0Yzg5ODY1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcG1kb21haW4vbWVkaWF0ZWsvbXRr
LXBtLWRvbWFpbnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcG1kb21haW4vbWVkaWF0ZWsvbXRrLXBt
LWRvbWFpbnMuYw0KPiA+IEBAIC0xMDA2LDYgKzEwMDYsMTggQEAgc3RhdGljIHZvaWQgc2Nwc3lz
X2RvbWFpbl9jbGVhbnVwKHN0cnVjdA0KPiA+IHNjcHN5cyAqc2Nwc3lzKQ0KPiA+IMKgwqDCoMKg
wqAgfQ0KPiA+IMKgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgc3RydWN0IGRldmljZV9ub2RlICpzY3Bz
eXNfZ2V0X2xlZ2FjeV9yZWdtYXAoc3RydWN0DQo+ID4gZGV2aWNlX25vZGUgKm5wLCBjb25zdCBj
aGFyICpwbikNCj4gPiArew0KPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlX25vZGUgKmxvY2Fs
X25vZGU7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCBmb3JfZWFjaF9jaGlsZF9vZl9ub2RlKG5wLCBs
b2NhbF9ub2RlKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAob2ZfcHJvcGVy
dHlfcHJlc2VudChsb2NhbF9ub2RlLCBwbikpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGxvY2FsX25vZGU7DQo+ID4gK8KgwqDCoMKgIH0NCj4g
PiArDQo+ID4gK8KgwqDCoMKgIHJldHVybiBOVUxMOw0KPiA+ICt9DQo+ID4gKw0KPiA+IMKgc3Rh
dGljIGludCBzY3BzeXNfZ2V0X2J1c19wcm90ZWN0aW9uX2xlZ2FjeShzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+ID4gc3RydWN0IHNjcHN5cyAqc2Nwc3lzKQ0KPiA+IMKgew0KPiA+IMKgwqDCoMKgwqAg
Y29uc3QgdTggYnBfYmxvY2tzWzNdID0gew0KPiA+IEBAIC0xMDI3LDcgKzEwMzksNyBAQCBzdGF0
aWMgaW50DQo+ID4gc2Nwc3lzX2dldF9idXNfcHJvdGVjdGlvbl9sZWdhY3koc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3Qgc2Nwc3lzDQo+ID4gKnMNCj4gPiDCoMKgwqDCoMKgwqAgKiB0aGlzIG1h
a2VzIGl0IHRoZW4gcG9zc2libGUgdG8gYWxsb2NhdGUgdGhlIGFycmF5IG9mDQo+ID4gYnVzX3By
b3QNCj4gPiDCoMKgwqDCoMKgwqAgKiByZWdtYXBzIGFuZCBjb252ZXJ0IGFsbCB0byB0aGUgbmV3
IHN0eWxlIGhhbmRsaW5nLg0KPiA+IMKgwqDCoMKgwqDCoCAqLw0KPiA+IC3CoMKgwqDCoCBub2Rl
ID0gb2ZfZmluZF9ub2RlX3dpdGhfcHJvcGVydHkobnAsICJtZWRpYXRlayxpbmZyYWNmZyIpOw0K
PiA+ICvCoMKgwqDCoCBub2RlID0gc2Nwc3lzX2dldF9sZWdhY3lfcmVnbWFwKG5wLCAibWVkaWF0
ZWssaW5mcmFjZmciKTsNCj4gPiDCoMKgwqDCoMKgIGlmIChub2RlKSB7DQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmVnbWFwWzBdID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhh
bmRsZShub2RlLA0KPiA+ICJtZWRpYXRlayxpbmZyYWNmZyIpOw0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG9mX25vZGVfcHV0KG5vZGUpOw0KPiA+IEBAIC0xMDQwLDcgKzEwNTIsNyBA
QCBzdGF0aWMgaW50DQo+ID4gc2Nwc3lzX2dldF9idXNfcHJvdGVjdGlvbl9sZWdhY3koc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2Nwc3lzDQo+ID4gKnMNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZWdtYXBbMF0gPSBOVUxMOw0KPiA+IMKgwqDCoMKgwqAgfQ0KPiA+IA0KPiA+
IC3CoMKgwqDCoCBub2RlID0gb2ZfZmluZF9ub2RlX3dpdGhfcHJvcGVydHkobnAsICJtZWRpYXRl
ayxzbWkiKTsNCj4gPiArwqDCoMKgwqAgbm9kZSA9IHNjcHN5c19nZXRfbGVnYWN5X3JlZ21hcChu
cCwgIm1lZGlhdGVrLHNtaSIpOw0KPiA+IMKgwqDCoMKgwqAgaWYgKG5vZGUpIHsNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbWlfbnAgPSBvZl9wYXJzZV9waGFuZGxlKG5vZGUsICJt
ZWRpYXRlayxzbWkiLCAwKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZl9ub2Rl
X3B1dChub2RlKTsNCj4gPiBAQCAtMTA1OCw3ICsxMDcwLDcgQEAgc3RhdGljIGludA0KPiA+IHNj
cHN5c19nZXRfYnVzX3Byb3RlY3Rpb25fbGVnYWN5KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IHNjcHN5cw0KPiA+ICpzDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnbWFwWzFd
ID0gTlVMTDsNCj4gPiDCoMKgwqDCoMKgIH0NCj4gPiANCj4gPiAtwqDCoMKgwqAgbm9kZSA9IG9m
X2ZpbmRfbm9kZV93aXRoX3Byb3BlcnR5KG5wLCAibWVkaWF0ZWssaW5mcmFjZmctDQo+ID4gbmFv
Iik7DQo+ID4gK8KgwqDCoMKgIG5vZGUgPSBzY3BzeXNfZ2V0X2xlZ2FjeV9yZWdtYXAobnAsICJt
ZWRpYXRlayxpbmZyYWNmZy0NCj4gPiBuYW8iKTsNCj4gPiDCoMKgwqDCoMKgIGlmIChub2RlKSB7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnbWFwWzJdID0gc3lzY29uX3JlZ21h
cF9sb29rdXBfYnlfcGhhbmRsZShub2RlLA0KPiA+ICJtZWRpYXRlayxpbmZyYWNmZy1uYW8iKTsN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fcmVnbWFwcysrOw0KPiBJJ3ZlIHRl
c3RlZCB5b3VyIHBhdGNoIG9uIHRvcCBvZiBhIHY2LjE4LXJjNiBrZXJuZWwgd2l0aCBhIGRlZmF1
bHQNCj4gY29uZmlnLiBNeSBNZWRpYXRlayBHZW5pbyAzNTAtRVZLIChNVDgzNjUpLCA1MTAtRVZL
IChNVDgzNzApIGFuZA0KPiAxMjAwLQ0KPiBFVksgKE1UODM5NSkgYm9hcmRzIGFyZSBhbGwgbm93
IGJvb3Rpbmcgd2l0aG91dCBpc3N1ZS4NCj4gDQo+IFRlc3RlZC1ieTogTG91aXMtQWxleGlzIEV5
cmF1ZCA8bG91aXNhbGV4aXMuZXlyYXVkQGNvbGxhYm9yYS5jb20+DQo+IA0KPiBSZWdhcmRzLA0K
PiBMb3Vpcy1BbGV4aXMNCj4gDQoNCkkndmUgdGVzdGVkIGl0IG9uIEdlbmlvIDEyMDAtRVZLIChN
VDgzOTUpIGFuZCA3MDAtRVZLIChNVDgzOTApIHdpdGgNCmxpbnV4LW5leHQ6DQp0YWc6IDYuMTgu
MC1yYzYtbmV4dC0yMDI1MTEyMQ0KSGFzaDogOTJjMDQ0Nzc5MzEzOTc3MjVmMGYwMjJiNTUwMjEy
MWFkZjRiOGFiZA0KDQpUaGFua3MgZm9yIGRpZ2dpbmcgb3V0IHRoZSB3aGVyZSB0aGUgcHJvYmxl
bSBpcy4NCkl0J3MgcXVpdGUgbm90IGVhc3kgdG8gc3VzcGVjdCBvZl8qIEFQSSB3b3VsZCBhZmZl
Y3Qgc3BpbmxvY2sgaXNzdWUNCmhlcmUuIEknbGwgdHJ5IHRvIGZvcndhcmQgaXQgdG8gc29tZSBy
ZWxhdGVkIGNvbGxlYWd1ZXMgaG93ZXZlciBJJ20gbm90DQpzdXJlIGlmIEkgY291bGQgZmluZCBh
bnlvbmUgaGFkIGRlYWwgdGhpcyBpc3N1ZSBiZWZvcmUuDQoNClRlc3RlZC1ieTogTWFjcGF1bCBM
aW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8
bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpNYWNwYXVsIExpbg0K

