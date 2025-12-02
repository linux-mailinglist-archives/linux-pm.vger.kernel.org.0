Return-Path: <linux-pm+bounces-39049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC3C9A9A7
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 09:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588633A4869
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB6305E1B;
	Tue,  2 Dec 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WrsP5to+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="X5KJbDHw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B8292B2E;
	Tue,  2 Dec 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662609; cv=fail; b=kEGeKYiEnpjO2Wz0yezN8fbkVJOz29m5lry6xpO9vjNRJOEAjNukZrzT6QI7SY5m+kZ3aGZDdPyciV4M3wSV4ruchjFUZ5uLzTDnLJbnJj+IK9+zFNaUFsFnvItsV6/SVNAVMGUAL5Yug+ami4zp2H6EAdnXSB6GZgMtvF+X36Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662609; c=relaxed/simple;
	bh=U4akiJbId3JRVKIbW7dnPhLU8nTgNsEYnpAdUT7upGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HrUxrXXvAbThanE/7CmYju10kBINxGURh1Vw5cEeNeEg1E27GpnO1EmuMMMpXlrnEhIH9lW0v99x1vPlqTzf76MWS5sMRINwd1dC+ugeYhDfgpv4mDC8i4rey0F4zuFVSEf0JKoGRVGEO7Aiq8GlchC3LLd/bZLNly1Y76ckAEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WrsP5to+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=X5KJbDHw; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5e38e3c8cf5511f0b2bf0b349165d6e0-20251202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=U4akiJbId3JRVKIbW7dnPhLU8nTgNsEYnpAdUT7upGY=;
	b=WrsP5to+oV99hs5uZTz/TtN2oeLdD9x4lgTJR093ZOYVYRKbsj55LfuRrd13BNFiRMRDDHShHcn3VNlKa9c4ZFle37FXQ0h+pCg7FCgFDlVIdsXOtBULkpZFu5P/sU+IzXCoAs7N6mE/Ar0pJAvzG+FFZt2I4T/DeoKtNXcGcx0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8b2f9e96-a25b-4503-99fe-70cab40973f5,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:310bf0a7-1697-4a34-a2ba-2404d254a770,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5e38e3c8cf5511f0b2bf0b349165d6e0-20251202
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <hanchien.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1866605677; Tue, 02 Dec 2025 16:03:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 2 Dec 2025 16:03:19 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 2 Dec 2025 16:03:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9HjVf2juC0rTz8siSw4QhvuJgKoabQYY3snRS2wtcY/kPCVu6+Zr7gXKuShl534QhkkbS4O8jWXlbAatr3fHcDMVvDKgtK4kADjGWkVaiF0kGAhWFpRzzVlVt4IuhXl4EtjF2DFXVNKElvejbLcsp8PXQtA3TRjLjaLy72l7v+VkpVL0FJVEFUYqjMbbYviEDLevEnAh+K8Q2vzWH0WcdJzsnouBs37UB5C7d16VYYrbC1oy0AK1p3f6RjN9Ts+xcnb5G/TNudpBFDyrM2r4PsDEVmLneaQuiJzA/BO4AOFxQqJWuU1Ma16E5Uj0gJgrUNHJiDeQgGFcGitsGoEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4akiJbId3JRVKIbW7dnPhLU8nTgNsEYnpAdUT7upGY=;
 b=Squ7Ydi832XCM2pFhzkjRPM2VTP2GMd/nT0MNUBR6/w3hMQ0icqhNZ5BL1iUz6PI8TWVsxoVqzHqc983Mfus7RWrpYc0r/AWq4j34sNnm+lheYK7WS9mTXeDdyZwk559CYtL0Hx3isvCdhYuGi+zPdKhlxRCidNiDIkLIY4OmH1BMa00DrW3JRUgixVX8IuZt/DxlBzZNlBvqB3KHzkglaB9p4mZgacbKCamqQrQtzmUEESeHEJtHxhYIVp6glYMSsEmURWbL38wevQ5UwEyb+TgT5f84cR4wR+ffMgjS+z5boJYfnjsXtlZvViaUs0BN8Y/mvspPowf2coWHKnk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4akiJbId3JRVKIbW7dnPhLU8nTgNsEYnpAdUT7upGY=;
 b=X5KJbDHwT8ApcbKGx+xFbrBqAJidbFp+T3ePZVHm0MIIIWTwydre9HqQPe07taCYYqaX9iU6JoH9yxyfc47r2b4XLMgupBzuqsQeSRlE6AzmQwT0qQthrb7i+/Z62dYbv5eWeHiUtmoKJqDAzLMjTwltnzQ3zzg+6TprOOXv3Ac=
Received: from TY2PPF3CC6FBD4C.apcprd03.prod.outlook.com (2603:1096:408::9cc)
 by SEZPR03MB8274.apcprd03.prod.outlook.com (2603:1096:101:18d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 08:03:14 +0000
Received: from TY2PPF3CC6FBD4C.apcprd03.prod.outlook.com
 ([fe80::f951:8433:7cd7:5159]) by TY2PPF3CC6FBD4C.apcprd03.prod.outlook.com
 ([fe80::f951:8433:7cd7:5159%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 08:03:14 +0000
From: =?utf-8?B?SGFuY2hpZW4gTGluICjmnpfnv7DorJkp?= <Hanchien.Lin@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Balsam CHIHI <bchihi@baylibre.com>
CC: =?utf-8?B?SXJ2aW5nLUNIIExpbiAo5p6X5bu65byYKQ==?=
	<Irving-CH.Lin@mediatek.com>, =?utf-8?B?SmggSHN1ICjoqLHluIzlrZwp?=
	<Jh.Hsu@mediatek.com>, =?utf-8?B?V0ggV3UgKOWQs+aWh+Wujyk=?=
	<vincent.wu@mediatek.com>, =?utf-8?B?UmF5bW9uZCBTdW4gKOWtq+S/iuaWjCk=?=
	<Raymond.Sun@mediatek.com>, =?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?=
	<Sirius.Wang@mediatek.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: RE: [PATCH v2 1/2] arm64: dts: mediatek: mt8189: Add thermal
 controller node
Thread-Topic: [PATCH v2 1/2] arm64: dts: mediatek: mt8189: Add thermal
 controller node
Thread-Index: AQHcYqpP/uQt0tQ2sUykq05Ho3Gb27UMj+KAgAFu90A=
Date: Tue, 2 Dec 2025 08:03:13 +0000
Message-ID: <TY2PPF3CC6FBD4CC72C1EDEF5130C36D83BE0D8A@TY2PPF3CC6FBD4C.apcprd03.prod.outlook.com>
References: <20251201100620.1557608-1-hanchien.lin@mediatek.com>
 <20251201100620.1557608-2-hanchien.lin@mediatek.com>
 <ea8e4201-f1c2-41cc-83ff-b509fd22bca2@kernel.org>
In-Reply-To: <ea8e4201-f1c2-41cc-83ff-b509fd22bca2@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF3CC6FBD4C:EE_|SEZPR03MB8274:EE_
x-ms-office365-filtering-correlation-id: 8b75add3-47c8-4512-3058-08de31793e5b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?a2JhWmhJcnlVcmVuUTMyV2tjcjczREU4NEtqczhIOElBWVd5UlhwQ3dpeW1N?=
 =?utf-8?B?QjI4dkxvZlBKQkxzdFNkVnhscDJiUmRvRGE1aEt1YWVSdi9YcTFQdlBweHRI?=
 =?utf-8?B?U2pKalpPMnd6Wm1jL0NVZGgzSU9VZUl6Y3dndkN0di9yK1JHOW1vRlVRNmhQ?=
 =?utf-8?B?eExjYlN0U1Z0YTlaZXhlUzViNDB5UllCVHdXS2Rza3RhWElwSGpHTU8vTWpi?=
 =?utf-8?B?b0JXemk5eHVuM1NJUEVsL1lKVGZ3RXJQTy82dnRHZ09SWWtBYUpiMi9RbzVH?=
 =?utf-8?B?NkpqMHlVSHlNeHNRQkc3d0NDMDJhSk9SRXNhaDJtUHRDZkR6MHV4RGlmYy9N?=
 =?utf-8?B?b09pKzF5MGVSc1FRN1RsNGVXdFNSS1UwVzVkYzNBSmE0SUZzUGJ3N0g1M0Nm?=
 =?utf-8?B?NSs0S2FLYjkzSEpoSHVuaEc2YXhVbW1VMk9wa0U1VS8vaDBIK0ZDSjJsTkl3?=
 =?utf-8?B?NEYraXF4V1ZIbUZCZm84d0l4WDR2RUlZZXFMNkZJc1d0aGtIRHRLbjBGTnlX?=
 =?utf-8?B?RERNaUx1cEkvK3JUaFRwVGNDTjRsTnljM082SjgrM1BOK2dHTXp3SEtwSnRU?=
 =?utf-8?B?MmErMmY0WW0wemhrd3pGVEhITTJGeStGS1doaUk3Q2hmVEMvN0c3blBLOFdX?=
 =?utf-8?B?MkNPV3hhWWx4UUNwalhQWXIzQWcvVHM2dExXaG5YdzVEakV6ODNwdy9YM1Z6?=
 =?utf-8?B?TU55SjFSQzJsZlNzZkJ4elBMdkFTU3ZGSkZQUWxnK3JCZ3FWUGEzWW5wN3dD?=
 =?utf-8?B?WkdvZWF1RURPcHNpS29ibENLNFVaU2FXMlhOT3cvdHVuVEpPUmFWVWFyYWdj?=
 =?utf-8?B?NDVuejdmN01kdk9uRHE1emc2dG9hZ1hBNjlvalFoY1N0VHJjbXVJWmRtS0dv?=
 =?utf-8?B?Nmg2WGo5VGZuQm9VOENlQjREbHo4MHd5cy9OaVJMRmF2a0xYM1g2VkpCdmh1?=
 =?utf-8?B?Q05BekxvSmtNbk5GMTZucXFlMUtibVUvS3RCcGxtdks0UFl4aDJlK2FZblJV?=
 =?utf-8?B?aUZWUndMbmlnUGNSMENIM0lkNWFvY2h1eTQ0b29hNmV0Y0NZM3JITS9NMFln?=
 =?utf-8?B?bzExVGRvNm5HWjdtM0JzOHV3V2hYb0xOclR6NUdlblJzVVdsOFVFMGdUSlNC?=
 =?utf-8?B?RHRqSDJQdEphc2huY3RDSmRsYzJBZkxkbUx3TXQrcEFFMjMvMFY1VFlSZ21V?=
 =?utf-8?B?d2VTRDdjSXlLWXNuTmNKL01wUHNMVEZ3bStpWXM3d25ZcER4ektvNU1lTmN2?=
 =?utf-8?B?ZkN6VWVvTDZsRGVYNVIvUXE2dStSMWJuZVkwajNHS2NPUnFNSGUrRmdtUTZp?=
 =?utf-8?B?NmlzdXFWcUdBMyswcy84T0t6WDlPTXF1OGllcElyczJhZTRoMWk0dTUzNzNq?=
 =?utf-8?B?V0sxV2Q2c0haNWVHUVExVTlHRkJ4NGRUQjkvaDNENVpTN3F6OXJIOTdWN243?=
 =?utf-8?B?UGFtcXdtRndrY1VGZ1h2L1hhZUlnMUtEOFM5Y3NNTHNSSHZKZGhlaGN1Q29r?=
 =?utf-8?B?bnlFQm9HbFk5bE8rNnlvQ0NQVXBBK1hmbVpVVlIxcDVJUUwxTldpWlVSU1l0?=
 =?utf-8?B?eHR5cFI3N1JGcHRaWW9FRklzYysrSXA3Y3Q0aU5oSUtuWGZ0ZWFiRVJuc2hz?=
 =?utf-8?B?VndGV2hWYzgrbk55R3dBYUoyNUtNS0Zsbm1wdnlHUlc5dnpzSnUzZGFOck40?=
 =?utf-8?B?WlhDcngrQW5KKzZuUC9FR1BqTWR0T0wrVkU2a21idSsrcHgxTGhYSEliRnVl?=
 =?utf-8?B?YmVDQnZjRi9FZlpSbndSb3lMbEpXRGRmc09WWUhqNVorTzBZTi9CQjN3RkVj?=
 =?utf-8?B?bUVTUmtwcFNBckdvN3RIaC95ejIwK0lhdXQ4MzVJK05qTVBXNW9YaXZlRFZw?=
 =?utf-8?B?R3ErbzlKSUxVVW1UdWNwOWlzRU9qY1oxRzJCc1R4dE5HRFZZYTdjUXVFYnhV?=
 =?utf-8?B?TTdmSnBDcjRaaVl0cEFoRlE4d2M5dFRlbmxGcmJWU3NOMFE1ZStsY01rM0lp?=
 =?utf-8?B?bkIwWE5WODg3Nzk2cXFyZFJOUGczWHNzMWxGVzYvbDBDN1NxZmM3RTE1TWFv?=
 =?utf-8?B?dzdqTnhIZ3QxQURRaW5MdXN1emFyQ0ZSMGYrUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF3CC6FBD4C.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmxxcUE4SnNCKzdWdUh1NXZFRVduOXl5ZDFmRG1NdHp4c2hRUkUzZVBKM0xE?=
 =?utf-8?B?OTBPNTd3eTNSd1U4ZGlZaWl3b0dzTWN1dWVJQmk3TW9JYzFqQndmU0p4NlQ2?=
 =?utf-8?B?bXJJMVVIMGt6WkdXdzlJVUlXNDNMS3NMWXpXY2FXQ1kyVThub1hhYUhHcC9a?=
 =?utf-8?B?a3ZOcFZyUGQ0M2Y0U0xWWk80NnAxbXhqb01raEF6djkrWU9iZUhFbmNsZ04v?=
 =?utf-8?B?NVZYVmdmdDlJM2JTdmt1TGd6bjJNQ3JLaDBaMC9hUTgwSkQrbFdtMzh4V0NF?=
 =?utf-8?B?R0k1NXNhRkozbUJNK09QOTZXbm82SFN5WGJkV1Q0WEYxQlpvb2drRjE0b1hH?=
 =?utf-8?B?M2Z3YkU5dGI2VWVTLzNDYzkyQW9pYlZWNHBrbEFWcGVRSXEzY3lsWVYrSHZD?=
 =?utf-8?B?OXNHTkxzU2ZwUnJaRjI5U21BS1J3TEErZXNzTXFBVDZRbTNwREp3L0xNV2FV?=
 =?utf-8?B?VFl1OEhFSm01MFJZQkMrT3owK0l6QVlFMk5BVGwvVFMxMURJQXR3U1FaM0NU?=
 =?utf-8?B?ZXJUcVB1VnhWbnJCRkdiRmFpQkxudDhRZmtQRnpuaGpzb3FtVUNRWXZLL3BK?=
 =?utf-8?B?SS9CSXNlemplOXJUYTVkZ0w1VTNuYkJXUVNZdUU2TFl6NXpTS1B2b2RtQjFV?=
 =?utf-8?B?SFU2OUxrem45a2Q4OWE1OGVXdFRsU3JTY1YvM3lZSWpESysrNkxucG1mNGRj?=
 =?utf-8?B?WVU1WEQ2K0YzV1BlaWVMNCtCenVJUzd4KzdsR3hNd0R2bEVNSWNOY0lDaTdq?=
 =?utf-8?B?bWVieXVOQ3c0V0NBVXBwYnowOGZXcjhHYVpIVVVxbForVHBmR2txU0xWSU8r?=
 =?utf-8?B?VDhERlBCWk1OUUFyZ3BwdGkzQ3k3RHo5dDJySnVzZURVcUR2Q3JVTXkwREpi?=
 =?utf-8?B?ell4ZG5IYlB5N210M0hkbDhTUGVNdzQ4QUdIeTdnTzNmR0pBcnNZc3FZQjU1?=
 =?utf-8?B?bm90UTFDdnBKZkMrSFdmWE56UmtkbmlkNHBoNmFVaGg4TzhnYm45cGRTREha?=
 =?utf-8?B?b2F3M1Z6b3lXeFF2SXc5bnNnL0FTNUcrSTVFbmNEWU5ROUxReTI2a1R4dmF3?=
 =?utf-8?B?dnhadU5naEY2Mm1aUGhNNk1pOVFGcmRQWlBUd2pmZVNvWWJKeXBvZUg0Yzlr?=
 =?utf-8?B?ZWhTSDVRdzNGWFI5em9XcnFjdVpmWXhWOHhSVElobmtqWEZsbzZHams2OCtZ?=
 =?utf-8?B?aytrb09xZWNaRm5RMWI5NGtwNHltRlc3b3RBVko0RDhHb3dDN1BZUlBpNmsv?=
 =?utf-8?B?WFZTaU8vRUpoQVZ3UUJ2b21xU3NjTlFBYUkyaXhSYUM5TzdkcmpmRG1admZu?=
 =?utf-8?B?aGptTzRnMGh5ZUJnUGU3a05NV2lUWXhkVVVDeG8yU3Q2MGNqeU55RW1OUXF0?=
 =?utf-8?B?VzRnYzNlR3JlV01LbCt2L2JFU1A2TXM5THBaclZHb1drQmFvbHlYY01mRWN4?=
 =?utf-8?B?K0ZZcURJZmwwTXdvK3B2RFF4WlJJVmdUcG9jZkFLL2gvR2tRRytZejVoS1Ex?=
 =?utf-8?B?UWNGZmxFTVZ1V2pCNUNhSWwwTjZLTndyR1Q4OWZ0b0ovZkdDeGpCMmtPa0hR?=
 =?utf-8?B?TjBuaXc3RnFmb3lrbzVjbTBCaEZLMER6cnZReDhwaGlCazVWUEF5WGxUeGdi?=
 =?utf-8?B?V3RXZmM0ZE9HQWtIS2V0dk9wOE5yYXUzUVhYYUhvQnNwbVBCeGdsWDcrNmlQ?=
 =?utf-8?B?Mmg0WlJYSGMzYlRpUENhU2ZOVGliQnFWS21oZWYyK09jNjhSa25XanFKeFhu?=
 =?utf-8?B?ZGtYZFFRQ3ZwQzhORFV5cU44YXFzSmZvekVlcjZiVTdrTnJnTTlaRlNka25x?=
 =?utf-8?B?SVZZeW9JdDlxS3E2eVhST3dWejB3U3R5Z2V5S2JSMXdsa0pkeDNONWtNblBQ?=
 =?utf-8?B?Z3NoMVJYN2l5VFVzckg1SUNwUUF5d1lMYWpiTWlEWFA0bWlrd3BrVDByNklD?=
 =?utf-8?B?ejV1dnpQTWVZeXlxV05TMVZhZWVZUmQ2S1FIRGh4cCtOYS8wZDV5MkQrVUVI?=
 =?utf-8?B?K3lCeThyT2VTUi8xenViSUhNdktLT0hkMkhxYzFRRVZKeGMxVVJFNmtoTlo5?=
 =?utf-8?B?cWtXZnRyWEdOMldzTUpFQldvSDJWSTRnNkIrdDVSV2I4UkRKblNoR3dLRUtm?=
 =?utf-8?Q?j9oIw15ZyiUwx1JPQx3q6Ek9u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF3CC6FBD4C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b75add3-47c8-4512-3058-08de31793e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 08:03:13.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhW+bvRd8wZYrAq9KyGrpkoxQ/z8FsMthWfZPZGt97JVhw2VHNycPB/LUnKk7ErfYbzyCdVb/4xwYNsRvl/GTTIZgqcq2v+adCsRPISJr04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8274

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2ssIGFuZCBJIGFwb2xv
Z2l6ZSBmb3IgbWlzc2luZyB5b3VyIHByZXZpb3VzIGNvbW1lbnRzLiBJIHdpbGwgY2FyZWZ1bGx5
IHJldmlldyBhbGwgdGhlIGZlZWRiYWNrIGFuZCBtYWtlIHRoZSBuZWNlc3NhcnkgY2hhbmdlcyBp
biB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4NCg0KU29ycnkgZm9yIHRoZSBpbmNvbnZl
bmllbmNlIGNhdXNlZC4NCg0KQmVzdCByZWdhcmRzLA0KSGFuY2hpZW4gTGluLg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJu
ZWwub3JnPiANClNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMSwgMjAyNSA2OjEwIFBNDQpUbzogSGFu
Y2hpZW4gTGluICjmnpfnv7DorJkpIDxIYW5jaGllbi5MaW5AbWVkaWF0ZWsuY29tPjsgUmFmYWVs
IEogLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IERhbmllbCBMZXpjYW5vIDxkYW5pZWwu
bGV6Y2Fub0BsaW5hcm8ub3JnPjsgWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPjsgTHVr
YXN6IEx1YmEgPGx1a2Fzei5sdWJhQGFybS5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9v
bGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRy
b25peC5kZT47IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+OyBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJv
cmEuY29tPjsgQmFsc2FtIENISUhJIDxiY2hpaGlAYmF5bGlicmUuY29tPg0KQ2M6IElydmluZy1D
SCBMaW4gKOael+W7uuW8mCkgPElydmluZy1DSC5MaW5AbWVkaWF0ZWsuY29tPjsgSmggSHN1ICjo
qLHluIzlrZwpIDxKaC5Ic3VAbWVkaWF0ZWsuY29tPjsgV0ggV3UgKOWQs+aWh+WujykgPHZpbmNl
bnQud3VAbWVkaWF0ZWsuY29tPjsgUmF5bW9uZCBTdW4gKOWtq+S/iuaWjCkgPFJheW1vbmQuU3Vu
QG1lZGlhdGVrLmNvbT47IFNpcml1cyBXYW5nICjnjovnmpPmmLEpIDxTaXJpdXMuV2FuZ0BtZWRp
YXRlay5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IFBy
b2plY3RfR2xvYmFsX0Nocm9tZV9VcHN0cmVhbV9Hcm91cCA8UHJvamVjdF9HbG9iYWxfQ2hyb21l
X1Vwc3RyZWFtX0dyb3VwQG1lZGlhdGVrLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8y
XSBhcm02NDogZHRzOiBtZWRpYXRlazogbXQ4MTg5OiBBZGQgdGhlcm1hbCBjb250cm9sbGVyIG5v
ZGUNCg0KDQpFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KDQoNCk9uIDAxLzEyLzIwMjUgMTE6MDYsIEhhbmNoaWVuIExpbiB3cm90ZToNCj4g
QWRkIGRldmljZSB0cmVlIG5vZGUgZm9yIHRoZSB0aGVybWFsIGNvbnRyb2xsZXIgb24gTWVkaWFU
ZWsgTVQ4MTg5IFNvQy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSGFuY2hpZW4gTGluIDxoYW5jaGll
bi5saW5AbWVkaWF0ZWsuY29tPg0KDQoNCk5vdGhpbmcgaW1wcm92ZWQuIFlvdSBqdXN0IGNvbXBs
ZXRlbHkgaWdub3JlZCBmZWVkYmFjayBleHBlY3RpbmcgcmV2aWV3ZXJzIHRvIHJlcGVhdCB0aGVt
c2VsZi4NCg0KTkFLDQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0K

