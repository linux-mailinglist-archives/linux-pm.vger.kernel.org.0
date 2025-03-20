Return-Path: <linux-pm+bounces-24332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F0A6A172
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 09:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B15F7A8B29
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EC92063DF;
	Thu, 20 Mar 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WWhVLUcb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wDICQ4YN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D81135A53;
	Thu, 20 Mar 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459704; cv=fail; b=VvbuLyRv31g/uqJ0pOIlGEXkCmzgi26tQnZOT/pbS7gbmGrpOF4jbtXWAmt/lSEO00071xfKlFnBRcybl4WPtFE08xpBm5yWwHXNG47sLcOmQroK+0qWnt/evUvQS3vz4SSh2lCjjqCRl1ISDlUX7CK+ef21XrzaRs9VxrTGt9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459704; c=relaxed/simple;
	bh=koQQtvGJWVjj9QH4cvi79/OOhCW04bmctFZ7UWNBiMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBY9XP9iNsNN8PIRg7J3Q8/sbLWKYGMklBTmLZorK4wZWOLvJSvQyGqyiUHkfwIYO0IUyN8ZWjR2PqxHwUclDPKFs6ZIWM2qdnXRqYt1g8GMrQS7DpSlKk/fXnhm9KlB50u/XFhMzLjXAxykfrnP39hoEuvkBQmmeHKDZ3dHsz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WWhVLUcb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wDICQ4YN; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 342d30b6056611f0aae1fd9735fae912-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=koQQtvGJWVjj9QH4cvi79/OOhCW04bmctFZ7UWNBiMY=;
	b=WWhVLUcbakT5gKl75KCd98m3HA+H2eZPBBcdLlWq5pV6gA7Kqsut0CG/US9Dh6bS5QaJf5Xj01S5Mt9H39+Y4V8kUQBAKkJl8Aq4sGJSruABbpTUeJGsVr2V0zM7X18B8DCZbvyxFAoRQFdmTDxVpnHMKe+ejClZhF+xXqmq2TU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:82bf29b2-dea1-42d8-a430-cb1161fb8214,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:e169594a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 342d30b6056611f0aae1fd9735fae912-20250320
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1262734771; Thu, 20 Mar 2025 16:34:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 16:34:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 16:34:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPOltNjabnd58sh4zVHQztVCgVMlOnoaegBpYChVbQqvx4Rm/OGYdPR4YwskEth8vBATvnG/2Xmhev9+IQ9FMkbmLwHeNoKFnwrhIorwF6icUdtMJLLEbYQPXOUr4GN58zQjR8u1ChUpQnr9iQr4Kf/fMhYqMVPwcAyn4rIQ1EPPf1IAR13kMCH7KNj/ZMRCVm4hspkgKD4DAcYdLOdZleNZacUsJq1mOb3Y5/kbuj7FPefLXhUuN/yZS5o4CycWDwkvwZuTxVUGmlQnqb+Ota1PzTqFy6q09pxLlsIUFShfm6ox6owIsgTss/Ie3QB5U+eN+lHk3OoLshYigJlESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koQQtvGJWVjj9QH4cvi79/OOhCW04bmctFZ7UWNBiMY=;
 b=BmoLAbJXTZP0HsOxHw6KNUXWk5r7teJed5bqiMZoRU/CbIwlVW5Pgl76/+TIAaaFlvwWCp6/4G24esoTytr+ZEU4lPfU/r9VFG+nowPvxqLCPQvl1YWR6g4RK9iSzz9K9EWhTQxFHDkq8g5qwmroF/Cw0/8iQp8D++hE/N3CkovuEFOSBd2oV8qv/1h5ugi9psJI+1TN4nsP4G4RmVNl4legV9vDWKX9rUSeMqiXRr5xiXnK0qrRCxiNfnqh/RPzfYVvCuasJDT7v8HxMlh2EHWN4pOY/KfMPz6Dac13uiwDJ0V29su2F1/d/eLrF9odaFeTmq6ZLQ89KC+z2EiZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koQQtvGJWVjj9QH4cvi79/OOhCW04bmctFZ7UWNBiMY=;
 b=wDICQ4YN0mrp26bDmcdyHi4yVINPN1XrYdeC4Z0Re/Wqcx4TkGpeCKsbtusJch3bdL6YKN1J2DL+KpJjesD8Zwq4ydlTDDW4BitZo+63nkVPz/oprEEYgomrfB6yUrOEHuJetPH7tKp4z3vI19Y1cag1cubYbubfX/wRLT2A4P4=
Received: from KL1PR0302MB5347.apcprd03.prod.outlook.com (2603:1096:820:4a::9)
 by SE2PPF47F0B1A47.apcprd03.prod.outlook.com (2603:1096:108:1::494) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 08:34:52 +0000
Received: from KL1PR0302MB5347.apcprd03.prod.outlook.com
 ([fe80::b331:56a8:9e40:34e5]) by KL1PR0302MB5347.apcprd03.prod.outlook.com
 ([fe80::b331:56a8:9e40:34e5%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:34:51 +0000
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
Subject: Re: [PATCH v3 2/3] cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION
 flag
Thread-Topic: [PATCH v3 2/3] cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION
 flag
Thread-Index: AQHbfrQ44HtFPg9hK0alfB+I0UcESrNOJZ+AgC3C3AA=
Date: Thu, 20 Mar 2025 08:34:51 +0000
Message-ID: <21e1b622c2968a5549b2ff37e4ba329a557968b6.camel@mediatek.com>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
	 <20250214074353.1169864-3-chun-jen.tseng@mediatek.com>
	 <20250219054543.4xt4tixsauwoqpst@vireshk-i7>
In-Reply-To: <20250219054543.4xt4tixsauwoqpst@vireshk-i7>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0302MB5347:EE_|SE2PPF47F0B1A47:EE_
x-ms-office365-filtering-correlation-id: 40dee61e-f91b-40a9-1ac2-08dd678a1553
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cUttUmQ1VnhCK2xMeDk5NnV0N3BlQmZOM2lvTWpyV0VPb21US3NiWWxLZUlB?=
 =?utf-8?B?M09IcUQ4S0VMRVRHWEVFVmU0VGNxN0pYbGYwV1JZOFNSY2MwRHU4QmY1bS9L?=
 =?utf-8?B?TnczR3pxL0RBRW5SZkFIbUwwZHJCM2xETDBOZ0YwVmJSV3R5b3ZiL01YTm9F?=
 =?utf-8?B?cnVBNE8xYTZ1Z2V3R3g5RXIrSkx5cjhQcGJJdEVBV3J4NVNpWGZYSGl6TmVF?=
 =?utf-8?B?U0NxeU4vRGhCNk5nOGFoNXFNKzNkOEJxYmRnWXRPRXhHMmxFOXhSY2dMRFdi?=
 =?utf-8?B?amN1TjVFSVJkbGNvRTZXOE5RSVpIblBGZVlIMzFmZnJ3NnRZTkpxQ3A5SnBo?=
 =?utf-8?B?eGJtOHBXR2FNdVFqamV4UzA1UndGUmpKNmlpdDVoa1dqVk1ya0x1b1hTaUZJ?=
 =?utf-8?B?dWVxNm1IMXdYQlBwYTQySVZJNllETU9CazJaV2VHdmFtWDFnSSszalZpUnc0?=
 =?utf-8?B?L0V3OFBWZnYrV2JtMnNJOCttekhtdENLRWZvZHhUZDhkSzNIenE4d2kxWDBC?=
 =?utf-8?B?cVBQRWdvY05mRDhsTk5FMWZMTTdFdFdLLzI4SjRMWlVsMG9yd2Y0T0JwZmRy?=
 =?utf-8?B?TEdXc0w2bzlQQmZCYk1zN1FtZFVwc3ljY1ExZ0k5UzZzOXQxdEVLWEVPQVlO?=
 =?utf-8?B?Nm4zamlWTmRGcit6ZkVWTGNqZnBVV25NWnBibEFudlN1U3BIamN3b1pOMlN2?=
 =?utf-8?B?Q0dQNzhKQTBtSkYxRVFZbjVpVXJBZWpqdnlHZWl1b09NbnowV29GY00wR2dw?=
 =?utf-8?B?bFBpVWlzcHcwZ3ZUWWZVcnhUeFdjZ2JETFl4QmFaRzNsZTQ2VEY5Ujl6S01P?=
 =?utf-8?B?dEpVb1hXeE5jNW1JRm12QlpiQ3BvYmxPZGM4QzM3czNraTAvM0NPcndTZVR4?=
 =?utf-8?B?aDl3VnVEWUhrZFJYd3U4c3V1T3lOdVp4cnIxMDhseHlrNU40VFp6TnNFM2VN?=
 =?utf-8?B?cCtMWThLR20vMkFXVUluTHI2dGxONHNsekdtQXkxYU5RRzZZMEgrSWNNVnpL?=
 =?utf-8?B?NE94UFpqTGFnN09IcEc1SjJHVG53c3pYTEx6SWdpZ0luNjdEYytPbjNEbVJ4?=
 =?utf-8?B?N1lrcHZJcTZLaW9oV1NyQ1MyVnFNN3dLVmcya0VMTTQ0dXpicU55MXBnd2tR?=
 =?utf-8?B?SVlvVEtTQzNoUUU3UjhhUm0xWkVWYXNLcG9CTlpqNDQ5QVJEZkdiYU12a01L?=
 =?utf-8?B?Q3dnT1JBa200UXRxL1dBU3ozeEpkeGQvN2NORDRUOVFmaXBQbmlnZ1JrOFRF?=
 =?utf-8?B?cVdsTzJIR2FGRno1MUIrM3R3TGx6SDkrSUt1MC9nRHdLSVVzRVBGVHNFSlRC?=
 =?utf-8?B?UHllZUZrZlQxRGlxWUJjK2FrMkxpdHpuQjh5cm9HbkVrc1VmdWFySVhSSjN1?=
 =?utf-8?B?N1VaZ04wRlJxeVJEY1ZaazVObURDVTl0blQzbnJmVVhvMHdHcTRTQ2ZnZmNn?=
 =?utf-8?B?MXJRaElqRWxZbkxHWW41QnVPZWFyQVdxMmpaQ2greUlSN3EzWldpUjA2SEZz?=
 =?utf-8?B?QmEwblg4VXUvaUtOZDB0VXJabjNuSnd4Y0xoSDZ6TkNjMlNIUlhkeUQ1WFIx?=
 =?utf-8?B?RHQ5Z1JVS1ZCTGFDamovRkhDTFkyMnJleUs1R20wL1k3ZnlLZVdrQTRXeXJz?=
 =?utf-8?B?QllSWmlrSzJpbXRKOWxuWjd3MC96VG5WOWd5WnBKZ0JtVjlwc2V1Q3pCKytm?=
 =?utf-8?B?dURaRTJ2aklQWFc2MzRLN0ZGUUJ2cFBSMmY3Zlc5eElHelJxQzhmcmIzQk5K?=
 =?utf-8?B?ZW5pSDBiSWdHNVZaM2RCVSt3RGZwQkpQck9XTm1DUW9JUlVxTGVuM0hBd0Uv?=
 =?utf-8?B?STU5MTFQUndrbzlvZWZGNDN5S3dTYnQvcldMNWsyU2wrQVpIYlhOeVFHMzA5?=
 =?utf-8?B?dUtUWTVieTVtbEJPY200M3g1TjZvZXhwb09Xek5pTnFFR3NSSno3RktiS1l1?=
 =?utf-8?Q?edCBTsQdnJ1ZCqRe1aF7uStW88WgEFN+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0302MB5347.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnpCS2RnUCs4OVlibFk0aWVGSXhDeDZ3TVNFYjBnV1NqUGtlb3JpZHVIcm1G?=
 =?utf-8?B?QXF4WnEvM05pd0ViUW1QeUs1VGhjTmJiS3NvRHV6N0E3Uk92YytzL2QzV2J4?=
 =?utf-8?B?RDE0aVg3dnNUUm1xSGpUMm5CeHFJbmQ3VVloa2w5VWhVOVg1MUJtcGVBM2xM?=
 =?utf-8?B?UmNUdGR1VzIvZ1lCTXlXWmt4OU9vY0ZEK1NvMHpBZkJDcmV4ZFM0WlhHSTR5?=
 =?utf-8?B?L3JNMkNoRFh1MEhlMFdEcHFnNlRWK0ZyS0tFZjdXN1pJSFc3S3BoVC9VczR1?=
 =?utf-8?B?U3dmck9sOGtKWHd3RVdKQStoSGtrd3M3dHhHTTZXMTkwTEo3S21OOFdEZXYz?=
 =?utf-8?B?SFg5K2h0MHROblNMTjl3QncrVXA3WFV1R3ZsNnpOTWNwYi9iTEExUWdCQzFn?=
 =?utf-8?B?T1VvdlkyS21vam0zeW4reWFPMW1zZ05OWitHSlhpU0pDQWY5d0lJMDNiQ1pu?=
 =?utf-8?B?TGVyTGltTXVtemhMaVVYWW94RFdidDBBOUFRR21tQWtRQTdWWlBxd1dWKzZB?=
 =?utf-8?B?TEpUT3VQRjRTWWphOEdGR3IwMzBOZExYQWhuTXVCYUx6YVYvcmp0YjQrRVc5?=
 =?utf-8?B?eUtxNW1OeGkrM1lYc3kwNnJFUXhyNFRTaFBQZk9vbnZVNDVCaEpyT3NNeFJT?=
 =?utf-8?B?dUdrd1FsNGhrL2VnUXZ3RE5Eck82UFp2Y2M1SXhqZ0o0M1ZrR1VOdWorR1VV?=
 =?utf-8?B?TzFPMEFFOE45MzlxSWxvdHh1TXBuR1RzcGtGRWYydWQ1YTRTQ3BNelhicEk4?=
 =?utf-8?B?TEgwam50Q0FYM0FzNmU3ejJqVDdMc2NQajFHMGJVcE5vNlpoRElDZkVuVms2?=
 =?utf-8?B?WWZuTHNDNHdJZzUzY2FMQWRkUS9YRW5kajRNMXdFY1h3QVdPSXd6N3d2bU5r?=
 =?utf-8?B?OXl1RmZpSnV6VGtET0NjYXVadFpqNXk1eU14QzJWbEIwd1QyUCt5ZERmNEtC?=
 =?utf-8?B?Q3FxZVpzUE9BQzdhSmN4eDFMc05ySC9aOGorQkw2U3ZROVZpT2Y0Z3gxRjg0?=
 =?utf-8?B?R2FmQWRPUE04OFVWam9DbC9hOEVsQ2YwcUZUdlcvOE56N1NqVTV2cWJIME9S?=
 =?utf-8?B?Uy91WUp6enNLaGhNbFFVRWtOVjhCeUNXOGRtOHVEUzBMRmtPdk4yempEUWZ6?=
 =?utf-8?B?b0hqUk1rRkhDVUh0SU16SE16UGJnZTY3YzNlM1pCMmN2ZkxFbjJXZ2oyMjB3?=
 =?utf-8?B?STB0SFF0MmF6MEFiNmNEUnM4TjNqK0tYaHBaR3VjVVBoV0RpT1ZBaGt5Wi9M?=
 =?utf-8?B?Y1hvUWE4RzVqdTZpeTVwOFpKU0lxaURibmFmdVk5OE1ES2E4bktVQzhjcGxn?=
 =?utf-8?B?bjhiZEkzYjVTYjY3M0txSWgydUNObjVVSDk4VndObk8rcWJLb29iTmlWVTVS?=
 =?utf-8?B?d3gyVThiOGd0RjllelA5dEpaOG5USW9rTkFzdnN0Wm15bjZBRW8rUlhjWms1?=
 =?utf-8?B?VXV3OTArb0dINkY1NDc4ZC9hTkZGM0FPMDZDRkxRMCtFMHVFZUVMZFlVQ3Y2?=
 =?utf-8?B?UmcrT0FGUXJqd1JNUUhHT0pIcGtaaUZmeFVpSnJTL01GRVhsSzM5N1IrQnNO?=
 =?utf-8?B?RU5pSzN2aEVzd043RjdpR0VNQmdIYTNvVzg5N216cGdpU05pQzZTMElxamwv?=
 =?utf-8?B?OUNqQVFTaHZpZG1hb1ArSWpqMjhuNWlZbE1QMVR5TW9nSXVaUmdxenZtbE02?=
 =?utf-8?B?QWRIQ0FHT2gvd1NuUlRxR3RLWTdOOUpqU2FlUlFUam15M3NYc3hQZHc1TjFJ?=
 =?utf-8?B?YkgyUW1yTlBlZzBGWG5aVVE2aHJ6U2ZaNHF0ZzQ0MG1Vc3p1YnQrWGkwb1Qz?=
 =?utf-8?B?bE9wcWRpQ09oL0VaNENGU2V4QkZVczNjMVdSMWNLeS9hUFZlQUg1YW0rQUdw?=
 =?utf-8?B?UXdzN0cxUmxGV3laYUhoWFdsV2lpZDc3VHZDamNIZk5zVHVnRmtyTVNBV2Mz?=
 =?utf-8?B?djlqcjM3RGVLaFVPeUNGR0dVVXZVY3Q4OUdEcy82RldOSDRsWUtrOFVaNjd2?=
 =?utf-8?B?VjcxT3djeWwvendRcVNkQWE3MmpXWUFNUytjQmF6UGc0YUYxZE8zZVpKNnFp?=
 =?utf-8?B?Y1Z6blROb3BMb09MUE8rMHZMRmVicHlwSFJqcll2TXQzZ1l2NitGYVk2QWhH?=
 =?utf-8?B?bDJETUI0dncyZVQwclh4cjFubnRiTGlteE1Qb0FoRG41UmNrOWM2VFpPd2J4?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E647EBB6193A1E4E97E9678B503EE0F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0302MB5347.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dee61e-f91b-40a9-1ac2-08dd678a1553
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 08:34:51.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mREBPuWFEXx8qQqWtGZJOqmQnQNG4/DlE1LxlLpwBHvPaIt+l+ADYHowLCMlbrzF+JNOHriPcWK09aypQHJzhv92NhaG3hFsYipRb874goQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF47F0B1A47

SGkgdmlyZXNoLA0KDQpGb3IgQ0NJIGFuZCBBUk1QTEwgaW4gZGlmZmVyZW50IGRyaXZlciwgSSBu
ZWVkIHRvIGNoYW5nZSBBUk1QTEwgZmlyc3QNCnRoZW4gdXNlIGNwdWZyZXEgbm90aWZ5IENDSSBk
cml2ZXIuIGl0IGNhbiBhdm9pZCBDQ0kgZHJpdmVyIGdldCB3cm9uZw0KQVJNUExMIGZyZXF1ZW5j
eSBhbmQgY2hvb3NlIFdST05HIGZyZXF1ZW5jeS4NCg0KQlJzLA0KDQpNYXJrIFRzZW5nDQoNCg0K
T24gV2VkLCAyMDI1LTAyLTE5IGF0IDExOjE1ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IE9uIDE0LTAyLTI1LCAxNTo0MywgTWFyayBUc2VuZyB3cm90ZToN
Cj4gPiBBZGQgQ1BVRlJFUV9BU1lOQ19OT1RJRklDQVRJT04gZmxhZ2VzIGZvciBjcHVmcmVxIHBv
bGljeSBiZWNhdXNlDQo+ID4gc29tZSBvZg0KPiA+IHByb2Nlc3Mgd2lsbCBnZXQgQ1BVIGZyZXF1
ZW5jeSBieSBjcHVmcmVxIHN5c2ZzIG5vZGUuIEl0IG1heSBnZXQNCj4gPiB3cm9uZw0KPiA+IGZy
ZXF1ZW5jeSB0aGVuIGNhbGwgY3B1ZnJlcV9vdXRfb2Zfc3luYygpIHRvIGZpeGVkIGZyZXF1ZW5j
eS4NCj4gDQo+IFRoYXQncyBub3Qgd2h5IENQVUZSRVFfQVNZTkNfTk9USUZJQ0FUSU9OIGlzIHVz
ZWQuIEl0IGlzIHVzZWQgb25seQ0KPiBmb3IgdGhlIGNhc2VzDQo+IHdoZXJlIHRoZSB0YXJnZXQo
KS90YXJnZXRfaW5kZXgoKSBjYWxsYmFjayBkZWZlcnMgdGhlIHdvcmsgdG8gc29tZQ0KPiBvdGhl
ciBlbnRpdHkNCj4gKGxpa2UgYSB3b3JrcXVldWUpIGFuZCBpdCBpcyBub3QgZ3VhcmFudGVlZCB0
aGF0IHRoZSBmcmVxdWVuY3kgd2lsbA0KPiBiZSBjaGFuZ2VkDQo+IGJlZm9yZSB0aGVzZSBoZWxw
ZXJzIHJldHVybi4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgeW91ciBwYXRjaCBpcyByZXF1aXJlZC4N
Cj4gDQo+IC0tDQo+IHZpcmVzaA0KDQo=

