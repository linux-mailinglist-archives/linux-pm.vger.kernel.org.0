Return-Path: <linux-pm+bounces-37006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874BFC18390
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 05:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980691AA1682
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 04:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7032F3619;
	Wed, 29 Oct 2025 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RGyif6iY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bQ+apkJj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315C2EC560;
	Wed, 29 Oct 2025 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761711116; cv=fail; b=UMNL+bTmoiQp4nd1gQmHxwO9qWJdV9XiE8TpmYmpNoPMJ90dF6IPfKIiDlQGtGea3Jf3oF6p1/K5N9xpOSplviNQOmIhMwbfz7iMFW88+58olGZPn8X7zVwcqRcuWBVz2hmikvyjn5eHJ564IBieGkyWYupkRA6OQTB+DyTitck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761711116; c=relaxed/simple;
	bh=i7K9YRg/rDWGlXbyfHLjDz+9r958Y23ceYIn/KtOcO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=INxX7me1f60wT/jRSrHC/SZS4fIi0rK4zKG+fZijhY5h2s8fhhueJkmbVQCfr5M3v5ArXwjyrDARuuzlbhc4M4NNlLrkonCmYwqganllVKrLzkuoHRhDj+9YhaCH1RgDCjd4kX5N6wjXhiuf0xomn1Sv70gXPVXsfeKvx5fB2JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RGyif6iY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bQ+apkJj; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 62aaa330b47d11f0b33aeb1e7f16c2b6-20251029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=i7K9YRg/rDWGlXbyfHLjDz+9r958Y23ceYIn/KtOcO0=;
	b=RGyif6iYVU2c5iFqfeDDxdfakWPC3Sq3qHdAH18WrCMylu1EEsT6kLsq9tAl79inzS3MMH2T12CreDl/GO+mfE2iKqhxeaO84la8KjGZxefUrgFssZ4OjK9ExZyuOju5PZceu0m9sx/vGWPLeSS9jyIx3HSwN3HKvJbXe05rsBA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:0dea1782-f292-418e-b683-a424e7eaeadf,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:72ebef3a-b16f-49fc-bb37-560773c432f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 62aaa330b47d11f0b33aeb1e7f16c2b6-20251029
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 812997450; Wed, 29 Oct 2025 12:11:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 29 Oct 2025 12:11:44 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 29 Oct 2025 12:11:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFYa7SCgkEZBAyKaHT3GMuatYEZ20oh/3bwEfTT2xSwzCNgwlckVDKLOt9vvF0Efts3ed1V6UC99iTjv29KjpY52dVD90Rb5p1yRpjsQxt7kVN+cGhYJkb/e+rNzffp570WwKk40yWl9vNWWAqZWQHGVSWbbxUUfZ0AWgIY2NBqGIh52Ecyns6wawlN5YLzHrd9+VSGBxOGtES/fnCuu/GK9sUypr1wkBBh0Bhl/ZJofHWswuEnLaDvoSfenolQ+55XCe1wdbhTSVw6wlPFCY0yakhnT0Go89nG8LrIFnisb5Mr+nHRThdaTKovCHhNFBo69t8yVAtPiqPYClFWgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7K9YRg/rDWGlXbyfHLjDz+9r958Y23ceYIn/KtOcO0=;
 b=rg821Z6zDCHmsK/AoKYwDKGY1aMw+vt6hsECX278wBfbPbPIx4kG2EbQXrYc1ZJWKWBSyI81VMf238WCU4Y0nhmvQeWrTK/Q6PJvVpUCTBkSPxbaZZ9zuomaEnvhL6Ghn266dZnkxgs3I54vi6D8+ELUUILm3WDR2AJ+tLZ5LSBIO7ifEizgIWKyisbYLOzu+kDUWKUyX58uBGmI6jHK2Pff6uHoP31HbnORikXUBYVfj/SpsI8oWJ4ThFu6RVfcvWEBdp+OomWZf21nExpGpKWLQB6ETVNVQjsnp+JdiZ+FpPUXe3cFZeO3XPuW/or5WjdB8Xhcez3CPIryJhuDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7K9YRg/rDWGlXbyfHLjDz+9r958Y23ceYIn/KtOcO0=;
 b=bQ+apkJjT0+fOtlwttM06uYj6yu9UMkcg3ZkVmBZczT+1SG8ZQ51kKPfGwNfAPSgDbfS7QW6F0WK7i2ci2kVoFkSegfieMLayStvV6Xit1kHNDEfltH0Ilt02VY9OcY+6TvwngNtjnhpS46Tn8BJmTPnQEok4Kp5yU83nM3apmQ=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KU2PPFDC32F4B50.apcprd03.prod.outlook.com (2603:1096:d18::429) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 04:11:41 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 04:11:41 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Sjoerd
 Simons" <sjoerd@collabora.com>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	"lihongbo22@huawei.com" <lihongbo22@huawei.com>, "robh@kernel.org"
	<robh@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	=?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"mbrugger@suse.com" <mbrugger@suse.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	Nicolas Prado <nfraprado@collabora.com>, "macpaul@gmail.com"
	<macpaul@gmail.com>, =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?=
	<Macpaul.Lin@mediatek.com>, "wenst@chromium.org" <wenst@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "y.oudjana@protonmail.com"
	<y.oudjana@protonmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?=
	<MandyJH.Liu@mediatek.com>
Subject: Re: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
Thread-Topic: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
Thread-Index: AQHcBd2MjPcMwIChxES6TVgTt4RGv7TAgoSAgAFUIYCAFzHgAA==
Date: Wed, 29 Oct 2025 04:11:41 +0000
Message-ID: <0d8da30aaec2a5dc4bda6d67b640081dcc320f37.camel@mediatek.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
	 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
	 <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
	 <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
In-Reply-To: <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KU2PPFDC32F4B50:EE_
x-ms-office365-filtering-correlation-id: e3b3208b-aec8-4f94-0d3e-08de16a143a9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UUpGZzJHakRjWGV1eU1PS004dHVUaTFxaFR1YnQybzRsb3BJTm85VUxSZFhx?=
 =?utf-8?B?ZTdnM2xWdTQzQmZpN202TlAvMnBIVk95RjNUL1NWVnZ2TnE4ZmtzaklxWVRU?=
 =?utf-8?B?NTZnWUt0Y3dzNmJxQVRjTHQyaytJVDJLeDd4RDRVYkx3OVdSTHRIaUpDeVVa?=
 =?utf-8?B?UEpEcTcrTDY2UUkwOHVkV21iSXg1UnAyZXdkQzJUZXhWendSN1M3bko0aFR3?=
 =?utf-8?B?dDhRKzVoY05vSUtpLzRQNlNWdGNnMmcwSnFMZEVzcnVWRHJQdXp0WW9xek1T?=
 =?utf-8?B?YnZOSXJlaTdQaWxFTS83MDNqRlVxRXhDYUpqVS8yZUlHOVltdkdYNWZKR2k1?=
 =?utf-8?B?VXFmR1dPVG10V1l6ODBiY0hjMVVkKzMwMGJnOUJ2Sng1Z1luZUpiT3hWVWNU?=
 =?utf-8?B?QzZiT0s5RWVkb2FRWUxONFBLR1gxZ0VSbzgzK3Btdi9VMlB4bDgwZTlKa0VG?=
 =?utf-8?B?NFBqODM0SGlybUFzbVlJZlpvMEh0cGtOcU50NDkwRkZEZEFaZEFjbFYrMzFB?=
 =?utf-8?B?VUkvZ1dxNjE0VW5ZVys3ZFRHYlo1WWg4T1dWUXAwVDJqbnZqbmJKRm1UVDRr?=
 =?utf-8?B?SzdOVENNSk5CUitzMVVnZTBRUUIvY21ZbitUUXQ5T2dFNkxDQjYwK0xGK2dG?=
 =?utf-8?B?bHM5RG9oNVh5S1VyTENnWWlQSGJWNWNRVVMyQTJQY3NEZWZWc0l3TTZBK2FP?=
 =?utf-8?B?b3NQZTFvUzNUTXYyVHZKQVM3UkQvQkxqMll1YkFrYmFVYW5xbGt6TTJPYzB1?=
 =?utf-8?B?enp2ZWlTMVozWGNyWWNXQXNOaDlxSFgwRWFuQUNBdFFRQVJIaFZFT1ZRZGFJ?=
 =?utf-8?B?cDBnMkM5T01YTnBCNFNaT0xjcUJZVlVTVThoaWZicnJheVJHeS92OFdQNDVF?=
 =?utf-8?B?ZTlaRVRLZVFKTVVVRzV2SEc2Qm9BRU9TRitsTTVXdUk2V3hHcGpOckFQZTdJ?=
 =?utf-8?B?eXI2SVdia0laRUM5aWVWM3krTGVEWmxjbnNBTVlIdjg4VHBPQU5hNFFsaEps?=
 =?utf-8?B?azlSSHhnS0RtQ1dGaFpqLzk0aFNjNkUvSmk0SnppZmtFT3I4bWVlYThOd1Rr?=
 =?utf-8?B?VlhKQWQxeU5QNVB1TXEvMnZJc3dnRnRscVVrUkEvYzAycnNYRGlsSzFZMXFu?=
 =?utf-8?B?TStjbkVXTXdGZ3d0ZitmUUR2azdJMGtUc3BDV0N2Wk5ybVJlSW9QRURudFh0?=
 =?utf-8?B?L3ZDUGpNUnlmd0VkUUFMQnVZKzlKbDlRVHZIU09wSXo0RVdDc29hN1k1aDZG?=
 =?utf-8?B?OFViWm5zRVJ1K1lhUWdaNGJlbTN1QjRlSXRFU3prdnJyMDZZZm5MbExuMkNi?=
 =?utf-8?B?WFpwL3cwM09sclY1Ym4zZFdqdTBtSm1OQzhkdDE3MU9PZDJZWFRsSVN5cDBu?=
 =?utf-8?B?cy85emc2b0lHclBWdWhQb3kzWnhmZXF6MlRlVitiWDIwRFdBTGRYOXBwK1RF?=
 =?utf-8?B?TUZpdHJKT1krdTlvNjh0bjVvSk9ZTUkzOUhTWGlPdUc2RzdLYU1rcGZHM080?=
 =?utf-8?B?MWwyNldhZ1A1Z3pLVmM0UUhuUjZHL3gxYU8yTlhxdzZRYWFBTnJMdDF3N2Qy?=
 =?utf-8?B?OFMxTWtqQUhHMElrM1llUmwxOU9pT25xRU9RZ3ZhTlJUbTJyeGMwU1BuUWg3?=
 =?utf-8?B?b0hnWkUzeGl0ODNPZmpqb1JyTWVXOFlCcndROU56WHpRUFhGZGlMV2lLMEg1?=
 =?utf-8?B?UldUYzRRa2s5RzFhU29CcjFobGNxcWxSVnExK09HWEsyOXF4dU0wMEFwQzdj?=
 =?utf-8?B?N294ZTA4Mkh0ZGg5ZE9wVklRWURma043NWpycG1NYmJHNlQ4aXI2UklIRjJk?=
 =?utf-8?B?YnNXcUlETVFEcE1JREJ6M3FxYUEyL1VZRHVHN3VjV0hjNFFaSmczOFZrQS8w?=
 =?utf-8?B?ZXB6ekUvVkw5YjRSSVlKYnNaS3lNU2VVblNBYXlDbjY4U3NIVU5JNDM1LzEx?=
 =?utf-8?B?aWpacStTYlhyQ0V3V3kxUCtxc0lNai9mODZkWUwrZ0hhWk5SVHNhc3RlMmZu?=
 =?utf-8?B?RGxCUGFSNk1yWFdkL2VVVmc4N2ZXQWJnc1g1U21EUzc2UGlPM3dwTTY5bDZJ?=
 =?utf-8?Q?d/AaIH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFZBOXpHd0RiVWhPQ29jTFByN2tzUTNrVmxvVktuSU5MUFZPMmVLYnZJRTlU?=
 =?utf-8?B?Y29BSGtaN3h0VE1XYjVmbE1HejZiVGxpSmZla0JwcXNYaksrQXg2OERwTk1x?=
 =?utf-8?B?YlBnSnkyWFVSQmZxOFBQeURKcnQ5ZW1NcXFkYlZVbmZyM1Y0bU1yYzlYUEtP?=
 =?utf-8?B?am5ONi92RGNDcXJLaVdydGdzbVpqWnV4MmdDZW5SMzgvb1ZWRUIybWpVVmgv?=
 =?utf-8?B?MFQxaEdNMUpiM3IzTnJzaWRMakpncURDOE9iWEJoM1l3U3VUY0hsUkszV1lY?=
 =?utf-8?B?S0J4STRnbGtXTkhyTjJ2TmlRQ3RoTDF4azdDblQ0d1lkRzdNTklRdTU2bHZT?=
 =?utf-8?B?cjZ5YTRGSSs2U2tyL1U1Qy9oZlVJTEFLVElQOS9jNHZud1R1VjJ1YVNPaXlq?=
 =?utf-8?B?SGhUQWVqY2xCb25hbXFIcXVCaHNncVRCaWhIek5XWFUra1dNbE9YUGtCVXhH?=
 =?utf-8?B?cEkycCszcGIrWlVkZzVXZEZIRGR3clFpaXdSSkxwUkJZa2haTnNFMVo5ZkxS?=
 =?utf-8?B?MHpMOTRIZ3BzVVNLVGl0M2FoN1NYVHpzTEV4RHRJcEpRVHhLbTR2cGhESFdB?=
 =?utf-8?B?Y1ppZmRwNHByRmlTZTByS0svN1VrQXVURlpDcjlZcjhMYzhyN0E3eXJEQ3dK?=
 =?utf-8?B?UHVVazRDdDJkV2VrYXJkQkIrUWxKMHZ5QWhMUVlpY2t6VzJWV1lSVDY2eTY4?=
 =?utf-8?B?SlMvZTV2RTJsNXZRczMrRzdMd25lWkNMNVp0UERhRUtReGRHWGpiWUR4OFF1?=
 =?utf-8?B?MzMrTzRZYjIrZE9pRCtza0FlR2d4ck1yeHVMclhzT1k3anJQZXkxVDFuK2tD?=
 =?utf-8?B?SjRVb2NsZ3hmUE5CUktYTWJGSHVNd3F0dXlaK3kxOWsvRVNucExDeENWT3pG?=
 =?utf-8?B?c2Q2OE42R1BWeForSlhOOHVjVjlZbk54WXk3YVVwV0V3V2VCMFFKd0hqNGk4?=
 =?utf-8?B?R2pMYXE0bElmTExFUzB4dEZnL29lNmdTSitjTEZvdTdwSVVFc0psbU4xZzRL?=
 =?utf-8?B?aG5iKzBKcEJNTkhHQ1BOaldvdk5CUWludm9kc3lWV3YvbFArOFBMcWV4T3VS?=
 =?utf-8?B?RDduazdSRTNJMzNrWEZMLzFEajR2Y2JZUldUYTZOR2NMdGRtYVNwWmE2NG9m?=
 =?utf-8?B?OGpzRzV0OFdNVnFJTnUwRUV3WkJ2S2I3eXFOUk5pMktoM0NQUG81V1FqS2FI?=
 =?utf-8?B?U3N0UE5ZRlkyeVpqVmJZQThyOXFDMVlaL0Fld3FpNDg1d2dESU1hTHJtTkNV?=
 =?utf-8?B?cTk3NGllTTRkbnluZjdyT3Y2VFA3S1ViN0lDY3BacllnMEhSQ3d3dkNGSk9i?=
 =?utf-8?B?MENMVXNQbUN3Umk5eFUvR3lpT203S1cyNWM3ZG1QMENOVDI4eVZGZGVSc3ZE?=
 =?utf-8?B?V3oycml4V08yc3VMNzZLaGRXbnhTUEFXZC9CZnY1eS9RcWVaMytrL2k0YkR3?=
 =?utf-8?B?amlnZ0VRd1owZitFNnU3azQrQnF2Lys0emtHcEh4RFBld1BhNk1la1Nja295?=
 =?utf-8?B?cExtaVByTEkyTG80dnEraVFkMjFyaUlzdVNScEJjRlNwMVpuRUxtdEQwdXJv?=
 =?utf-8?B?TVdSNG1CN0taTDJvcDl3UGZORXhUTkMwc0ZCSUtlTG1BWTlubTlUbjBvYVNl?=
 =?utf-8?B?c3IzKzFHWmkyN1JsQ1BZajlOcTMyeHpBa1FSWko1amJRcjRJL2gvR2tydWs5?=
 =?utf-8?B?Yk5teVRRZFlzckFPaXFBeGtJZk5uRFlSYWpYVjJmQTZ5WW03VElBTm9GY1Iw?=
 =?utf-8?B?VGxzT3UxTjY5VXNIbytQS0RFWWNScldJL1ZCS080NmJMalBuMzFLT0tMdmRy?=
 =?utf-8?B?clNHclp6Mk94M25wYmRmNndxdEl6eUtEb1N0anlDZCsxYjZpQnFQanZjR3Nm?=
 =?utf-8?B?TU1aT0cwWGlqZStqdjZFdDlaM3VqMzNwUmsrTllZTE1YbHNIUE1JZncxWEFh?=
 =?utf-8?B?MTArTkw4djlVT29VWkNHeXR0WU1EeDlveDJUZ0UyYjVzK0FoVzVUS2MwcHVD?=
 =?utf-8?B?ZDJ3Mkg5VG1TQVk2Vm44a1ZkZmxoR09KbDZvUUs4alRMNmREc2ZNVFVFVW9N?=
 =?utf-8?B?TjdkN3pHK0RPdXc3WlkybVR0Tmg1b09KbDR2Nk41ZzY0M21tVkQ0ZmFLRlR0?=
 =?utf-8?B?VFpzeWtBaDRXMzBncU10cVRWQTlYaUFTdGwzcW1WUjBzenUvWklON0RwQUpz?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F78F956DFAAE914B9835584DCBBCAC82@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b3208b-aec8-4f94-0d3e-08de16a143a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 04:11:41.3508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+kqN6/FNyfSr5wOfm4i7nzn19GeP+jE6R9djbb/bbCEvRJ/hwiC60ACxViJVu2Qb8mFffTvLxkZRBlZFa7qMeDmAIXNBAwOs9wOp6PFs4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDC32F4B50

T24gVHVlLCAyMDI1LTEwLTE0IGF0IDExOjU5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gSWwgMTMvMTAvMjUgMTU6NDEsIFNqb2Vy
ZCBTaW1vbnMgaGEgc2NyaXR0bzoNCj4gPiBIZXksDQo+ID4gDQo+ID4gT24gVHVlLCAyMDI1LTA4
LTA1IGF0IDA5OjQ3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3Rl
Og0KPiA+ID4gSW4gcHJlcGFyYXRpb24gdG8gYWRkIHN1cHBvcnQgZm9yIG5ldyBnZW5lcmF0aW9u
IFNvQ3MgbGlrZQ0KPiA+ID4gTVQ4MTk2LA0KPiA+ID4gTVQ2OTkxIGFuZCBvdGhlciB2YXJpYW50
cywgd2hpY2ggcmVxdWlyZSB0byBzZXQgYnVzIHByb3RlY3Rpb24gb24NCj4gPiA+IGRpZmZlcmVu
dCBidXNzZXMgdGhhbiB0aGUgb25lcyBmb3VuZCBvbiBsZWdhY3kgY2hpcHMsIGFuZCB0byBhbHNv
DQo+ID4gPiBzaW1wbGlmeSBhbmQgcmVkdWNlIG1lbW9yeSBmb290cHJpbnQgb2YgdGhpcyBkcml2
ZXIsIHJlZmFjdG9yIHRoZQ0KPiA+ID4gbWVjaGFuaXNtIHRvIHJldHJpZXZlIGFuZCB1c2UgdGhl
IGJ1cyBwcm90ZWN0aW9uIHJlZ21hcHMuDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgZG9uZSBieSBy
ZW1vdmluZyB0aGUgdGhyZWUgcG9pbnRlcnMgdG8gc3RydWN0IHJlZ21hcCBmcm9tDQo+ID4gPiBz
dHJ1Y3Qgc2Nwc3lzX2RvbWFpbiAoYWxsb2NhdGVkIGZvciBlYWNoIHBvd2VyIGRvbWFpbikgYW5k
IG1vdmluZw0KPiA+ID4gdGhlbSB0byB0aGUgbWFpbiBzdHJ1Y3Qgc2Nwc3lzIChhbGxvY2F0ZWQg
cGVyIGRyaXZlciBpbnN0YW5jZSkgYXMNCj4gPiA+IGFuIGFycmF5IG9mIHBvaW50ZXJzIHRvIHJl
Z21hcCBuYW1lZCAqKmJ1c19wcm90Lg0KPiA+IA0KPiA+IFRyeWluZyB0byBib290IHY2LjE4LjAt
cmMxIG9uIGEgR2VuaW8gNzAwIEVWSyB1c2luZyB0aGUgYXJtNjQNCj4gPiBkZWZjb25maWcsDQo+
ID4gZW5kcyB1cCBoYW5naW5nIGF0IGJvb3QgKHNlZW1pbmdseSB3aGVuIHByb2JpbmcgTVRVMyBh
bmQvb3IgbW1jLA0KPiA+IGJ1dCB0aGF0DQo+ID4gbWlnaHQgYmUgYSByZWQgaGVycmluZykuDQo+
ID4gDQo+ID4gRWl0aGVyIHJldmVydGluZyB0aGlzIHBhdGNoICpvciogaGF2aW5nIENPTkZJR19N
VEtfTU1TWVMgYnVpbHRpbg0KPiA+IHJhdGhlcg0KPiA+IHRoZW4gYSBtb2R1bGUgc2VlbXMgdG8g
c29sdmUgdGhhdC4NCj4gPiANCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCj4gDQo+IFRo
aXMgaXMgbm90IGEgcHJvYmxlbSB3aXRoIHRoaXMgcGF0Y2ggc3BlY2lmaWNhbGx5LCBidXQgc3Vy
ZWx5IHNvbWUNCj4gcmFjZSBjb25kaXRpb24NCj4gdGhhdCB3YXMgYWxyZWFkeSBwcmVzZW50IGJl
Zm9yZSBhbmQgdGhhdCBkb2VzIGdldCB1bmNvdmVyZWQgd2l0aCB0aGlzDQo+IG9uZSBpbiBzb21l
DQo+IGNvbmRpdGlvbnMuDQo+IA0KPiBXaXRob3V0IHRoZSBkZXZpY2V0cmVlIHVwZGF0ZXMgKHdo
aWNoIGFyZSBub3QgdXBzdHJlYW0geWV0KSB0aGlzDQo+IHBhdGNoIGlzDQo+IGZ1bGx5IHJldGFp
bmluZyB0aGUgbGVnYWN5IGZ1bmN0aW9uYWxpdHkgMS10by0xLg0KPiANCj4gSSdsbCBjaGVjayB3
aGF0J3MgZ29pbmcgb24gQVNBUC4NCj4gDQo+IENoZWVycywNCj4gQW5nZWxvDQo+IA0KDQpJIGRp
ZCBhIGdpdCBiaXNlY3Qgb24gbGludXgtbmV4dCBtYXN0ZXIgYnJhbmNoIGFuZA0KdGhlIHJlc3Vs
dCBzaG93cyBjMjkzNDVmYTVmNjZiZWEwNzkwY2YyMjE5ZjU3Yjk3NGQ0ZmMxNzdiIGlzIHRoZSBm
aXJzdA0KYmFkIGNvbW1pdC4gVGhpcyBjaGFuZ2UgYWxzbyBhZmZlY3QgTVQ4MTk1Lg0KDQpUaGlz
IHBhdGNoIGNvdWxkbid0IGJlIHNpbXBseSByZXZlcnRlZCBiZWNhdXNlIHRoZXJlIGFyZSBzb21l
IGRlcGVuZGVudA0KY29tbWl0cyBmb2xsb3dzIHRoaXMgY2hhbmdlLg0KSSdtIG5vdCBzdXJlIGl0
IHRoaXMgcmVmYWN0b3IgY2F1c2VzIEFQSSBvciBmbGFnIG5vdCBzeW5jZWQgd2l0aCB0aGUNClND
UCBmaXJtd2FyZS4NCkp1c3QgYSByZW1pbmQgdGhhdCBpdCBpcyBoYXJkIGZvciBNZWRpYVRlayB0
byB1cGRhdGUgc2NwIGZpcm13YXJlIGZvcg0KYW4gYWxyZWFkeSBpbiBtYXNzIHByb2R1Y3Rpb24g
c3RhdGUgY2hpcC4NCkVhY2ggc2NwIGZpcm13YXJlIGFuZCB0aGUgcG0tZG9tYWluIGludGVyZmFj
ZSBhcmUgZGVzaWduZWQgc3BlY2lmaWNhbGx5DQpmb3IgJ3RoYXQnIGNoaXAgb25seS4gU28gaXQg
aXMgZGlmZmljdWx0IHRvIGFkb3B0IHBtLWRvbWFpbiByZWZhY3Rvcg0KYnnCoG9ubHkgcmV2aWV3
aW5nIHRoZSBwYXRjaC4NCg0KSGVyZSBhcmUgdGhlIGVycm9yIGxvZ3Mgd2l0aCBsYXRlc3QgbGlu
dXgtbmV4dCBtYXN0ZXIgb24gbXQ4Mzk1LWdlbmlvLQ0KMTIwMC1ldmsuIEhvcGUgdGhpcyBjb3Vs
ZCBoZWxwIG9uIGZ1dGhlciBkZWJ1Z2dpbmcuDQoNClsgICAgMS4yOTEwNTVdIG10ay1tc2RjIDEx
MjQwMDAwLm1tYzogbXNkY190cmFja19jbWRfZGF0YTogY21kPTgNCmFyZz0wMDAwMDFBQTsgaG9z
dC0+ZXJyb3I9MHgwMDAwMDAwMg0KWyAgICAxLjI5Mjc3NV0gbXRrLW1zZGMgMTEyNDAwMDAubW1j
OiBtc2RjX3RyYWNrX2NtZF9kYXRhOiBjbWQ9NTUNCmFyZz0wMDAwMDAwMDsgaG9zdC0+ZXJyb3I9
MHgwMDAwMDAwMg0KWyAgICAxLjI5NDUzOV0gbXRrLW1zZGMgMTEyNDAwMDAubW1jOiBtc2RjX3Ry
YWNrX2NtZF9kYXRhOiBjbWQ9NTUNCmFyZz0wMDAwMDAwMDsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAw
Mg0KWyAgICAxLjI5NjI5M10gbXRrLW1zZGMgMTEyNDAwMDAubW1jOiBtc2RjX3RyYWNrX2NtZF9k
YXRhOiBjbWQ9NTUNCmFyZz0wMDAwMDAwMDsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAwMg0KLi4uDQpb
ICAgIDEuNDMwNDA4XSBtdGstbXNkYyAxMTI0MDAwMC5tbWM6IG1zZGNfdHJhY2tfY21kX2RhdGE6
IGNtZD01NQ0KYXJnPTAwMDAwMDAwOyBob3N0LT5lcnJvcj0weDAwMDAwMDAyDQpbICAgIDEuNDMz
NzY2XSBtbWMwOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBhIG5vbi1yZW1vdmFibGUgY2FyZA0KWyAg
IDIyLjI5NzI0MF0gcmN1OiBJTkZPOiByY3VfcHJlZW1wdCBkZXRlY3RlZCBzdGFsbHMgb24gQ1BV
cy90YXNrczoNClsgICAyMi4yOTg3MjNdIHJjdTogICAgIDYtLi4uMDogKDIgdGlja3MgdGhpcyBH
UCkNCmlkbGU9MTA0Yy8xLzB4NDAwMDAwMDAwMDAwMDAwMCBzb2Z0aXJxPTQ1LzQ1IGZxcz0zNw0K
WyAgIDIyLjI5OTgyN10gcmN1OiAgICAgKGRldGVjdGVkIGJ5IDIsIHQ9NTI1NiBqaWZmaWVzLCBn
PS0xMDUxLCBxPTIwMA0KbmNwdXM9OCkNClsgICAyMi4zMDA2ODldIFNlbmRpbmcgTk1JIGZyb20g
Q1BVIDIgdG8gQ1BVcyA2Og0KDQpCZXN0IHJlZ2FyZHMsDQpNYWNwYXVsIExpbg0K

