Return-Path: <linux-pm+bounces-39404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D99B8CB2BBA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 11:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395DC30181BF
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 10:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B7F21257F;
	Wed, 10 Dec 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tqdc2U9i";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cR836lmb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FB316918;
	Wed, 10 Dec 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765363552; cv=fail; b=oAzhhFbkm+c6hjT4NWUYrGidqE+pC0U0pPKObtoLZ8p5OC5ZUJ5sKYGYmZINIv/vG+n1AYxt/MSXAfQkQwMblf/stbDT5SBOmiWPqvLudYpwXq1+iZHe91szkG1KO4gCoSyPkGC8mz3g4qalYPvjtcDmx7BSdmvGsUTEVzyvRn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765363552; c=relaxed/simple;
	bh=vj7zT45RDxhuyFfkAg1Wh55UeIFK6NkGr68XdrxhC6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fffbhdTUaoLaVNApAgpTEIRa4gO/kacrPsbdn/Zr1NV44Py6zwj41/DBrd4xVYutL8d50WhJuvrrS0SvOGQ/Fhlu0SrTfupibKjgXgk+ARZjcaWjR5mXxNZG8enDW3MQumx0h9Qd399JgIM9/E96p08ICrypxKMm8Vm50z1B0EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tqdc2U9i; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cR836lmb; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3eee6d8ad5b311f0b2bf0b349165d6e0-20251210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vj7zT45RDxhuyFfkAg1Wh55UeIFK6NkGr68XdrxhC6M=;
	b=tqdc2U9iR+XYPRXEeRHZtJC8nJ0niA3Ykn5oSiRBg4b/YWI6DIXYqu1Y2UGeV/tTP8Lt/y6F4lroMDET6nHyhJIM+Y2YQVFXxHpPm/L+OPMCxXRZMNAQ0QrRosv+/B2AihYrnv/DylhyPBEmfVbWnfALSX+pwPj1LepQILD/4xo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:57e75ae0-c644-4869-93e2-e22f13a7e1ba,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:79e65d28-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3eee6d8ad5b311f0b2bf0b349165d6e0-20251210
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <irving-ch.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2119102158; Wed, 10 Dec 2025 18:30:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 10 Dec 2025 18:30:26 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 10 Dec 2025 18:30:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzkFzbwBiodqbdeXG1i6F6IucZebJUrAsW6vnTw7lUlL5fXOm7LyjPIcvW6K3nIoxe2RSNooAHkQ1c334BjakKNd51UJ07BtgGcptn1o5sigWsLYG1KWGx7cWHsqajy/pmWD4rdX5Q20JlIUhx2zwf9I2Qs2uGa66/8oLnTjPumC/mOerh7K71o0RGqrWf1lE70mp5o5/ad6XiqEf+Ea/vrac8unxqFyFi/PFlQ49mP1oe1MCZjQUe1mPpTK/xY+F855xacfJowRNFRjHGDE3rhFZYLEVILik+/KZ0I67+dNGCGEtR8WBGqJZmVBPf/pcjtwTsfJq82q7gI6oAKtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj7zT45RDxhuyFfkAg1Wh55UeIFK6NkGr68XdrxhC6M=;
 b=JudeNPDOrn9HRxHEpJOSYdjAKCj66rHNt91yQ6tWw23oMxm/S4WSxr8+ROGnh43PfbFN5ArbPafpFwmvPHhWW6axtuL7I/dqBC0wbKKBXHK4DythSBWN/n5cFQWvqp8uZEYc5e93WSNu8OfeazuRQApFfQxCdACaTvsLJL4DCaUR3kkQgDD2vVrR9d1TWjsGkR8Nb2a6ddA+nufxAnzJJ8hPq0w4SbzZvu2OjdMn4yjroP+KpzxVN5e+TzAL0eL0W/1AB8nNSzItAA1afIwvQkcY5iiI8t9t8BA8Wm0fOMFTFqGM2dMH7RlJh1djK2agq481yhmF+Otdv13LF2cYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj7zT45RDxhuyFfkAg1Wh55UeIFK6NkGr68XdrxhC6M=;
 b=cR836lmboDcDJRgfedWz8cU33a6RYJd7M495cHt8cnrP/rM3yqEzc2hQKhyKd4jEpF8cU4e8Js5DOwv38eTX/4v4D4UmUQsvRwZ1QQy/ynncpb8D/95GfG1xLyg0+MFuN+4JhfqI7UJV4Myw8M276jsa5JMNeCm7jk/A4MZ9AqM=
Received: from SI2PR03MB5708.apcprd03.prod.outlook.com (2603:1096:4:138::14)
 by SEZPR03MB7775.apcprd03.prod.outlook.com (2603:1096:101:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 10:30:23 +0000
Received: from SI2PR03MB5708.apcprd03.prod.outlook.com
 ([fe80::e92e:bf09:eb56:b0b8]) by SI2PR03MB5708.apcprd03.prod.outlook.com
 ([fe80::e92e:bf09:eb56:b0b8%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 10:30:23 +0000
From: =?utf-8?B?SXJ2aW5nLUNIIExpbiAo5p6X5bu65byYKQ==?=
	<Irving-CH.Lin@mediatek.com>
To: "sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?UWlxaSBXYW5nICjnjovnkKbnkKYp?= <Qiqi.Wang@mediatek.com>,
	=?utf-8?B?SmggSHN1ICjoqLHluIzlrZwp?= <Jh.Hsu@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?VmluY2UtV0wgTGl1ICjlionmlofpvo0p?= <Vince-WL.Liu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, =?utf-8?B?SGFuY2hpZW4gTGluICjmnpfnv7DorJkp?=
	<Hanchien.Lin@mediatek.com>
Subject: Re: [PATCH v3 20/21] pmdomain: mediatek: Add bus protect control flow
 for MT8189
Thread-Topic: [PATCH v3 20/21] pmdomain: mediatek: Add bus protect control
 flow for MT8189
Thread-Index: AQHcTxsaVEziJZ+xFUyZNxnOIf6J8rTnBp2AgDPbJgA=
Date: Wed, 10 Dec 2025 10:30:23 +0000
Message-ID: <174a8f4ec6e04ec06f4ec77345615bd3e0f7671c.camel@mediatek.com>
References: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
	 <20251106124330.1145600-21-irving-ch.lin@mediatek.com>
	 <6f1bbbc7-ca54-43f9-953d-725902af7b10@collabora.com>
In-Reply-To: <6f1bbbc7-ca54-43f9-953d-725902af7b10@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5708:EE_|SEZPR03MB7775:EE_
x-ms-office365-filtering-correlation-id: 86e57e84-443e-4bc2-0864-08de37d72031
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NjVsQVNWNGNVczZoVzZKRHhSMGlwbEFFUC9sTmd5MXBiZzJpQ3NKZS9Kc21B?=
 =?utf-8?B?MWRYN1Y2NWtibjNweUlNb090RUpIWHBKRnFqVWZIMy93Y09NOUlnTURTaGJ4?=
 =?utf-8?B?N2NScXRuVTdZM2txaWpIMUwyUnRBQk9EV242Y0FaZHZaQkFXaTZWNW5iOFR1?=
 =?utf-8?B?bXIyVUtQOGhkYno1a2lwZHpSZERRaDBBOUJtN1Y4eDVYdVArYjMvWXR4YWRw?=
 =?utf-8?B?dkw0UGRiUE1mZFNDR2luZ2tRTGEwUHh6clNHNUpSeVI1Nmt4T2x3S01wVzRR?=
 =?utf-8?B?a1JDMC9hemk4N0tIRVgwWnV4OWpEM1A0dHNoY3Z2a2p3VzF0RlhHWE5hQ0Y2?=
 =?utf-8?B?S3F6RlJURVRKU3NOa1RVZHFnKzJHL1BuZ3lOSjR1YzN3ejA4Rjd2U2EzOG1P?=
 =?utf-8?B?RE1NWlRralU0RzFhS2xSNlFSRlI1ZlpWNGtBTitUSEhIRkRuRUVXbWxHRWNQ?=
 =?utf-8?B?U2ZTWUtrU1JsMzF4b1Z6MCtCNExXMU11Tzk5U2tBSFFwZlFnNHFHcTI2b0JC?=
 =?utf-8?B?NHRaR09oQUlYMnZEK21lL25BczBCM2QxS0QwNE1rbzlRNHR4RnNCcU9NWTJy?=
 =?utf-8?B?Q1U4aW1qbUx5eGZnYVZHOG1yODdpRWw3Sjk1aFRYVms5dHRYYjJXWDB1SUxk?=
 =?utf-8?B?NHVUWTNXVk5ocEsvbHVPRis1NGc2RFpnR3BEQURSbXJEVWVBY0ZxdnJXT0Z6?=
 =?utf-8?B?SmZFRngzcVhaZUZHZjNwTzJiSnduZ2tHcXlNT0J2NEFKK3VtOUsvRVFNbFR6?=
 =?utf-8?B?SU9vV1NxQ0ZJb1ZQUUFGNmNFcnNWK00xdXF6RHRQbHFVa1JiTktZRi9UOFJC?=
 =?utf-8?B?UFNnM3NvQk9XNmdXcmYwSCtOSk43cFgwSUZkMkhXMjdVQ3RtbTRsYjVlWGNr?=
 =?utf-8?B?Qnpscjg4M0x1Z0JxbGdYd2M2dlZORmF4dkNsZVVBbE54M3lyZE9pU3h3bDVq?=
 =?utf-8?B?R3dmandselErM3NpQUI2Wit0MFdKbUpOMkcxTmN4NmJ4UDJPcjRJb0g1SU4y?=
 =?utf-8?B?Z1UvSlNHUklJRFQvWWFjTTdDb2s4d3ptTFFSV0FzdEtjUUxKcm9CNFc4N3Yr?=
 =?utf-8?B?dVhCS2kyUVBqSjNaMk1DTGNtQmhsaUMvZ3FQNk51ajhlZHJsdEtFYk9LL1Mw?=
 =?utf-8?B?K25SSDl2eHRBWG5RSnpLa2liaFVnMHlpU3prcFRYNHBnczRYRXMrSlllZkdC?=
 =?utf-8?B?aTdtUkdacFVqY2ZXYXVUSWxFUjNZaHVwVzc0Q0VGMm9lYWpvY3RLS1BsTDZM?=
 =?utf-8?B?K1FGY2VrVUlCcVN5NTB4Z2REY1Zpbm1mWFJWUExwTkVXUTlPejNWOVYyL2Y4?=
 =?utf-8?B?M25BOEcwVEhBZU96ZmFTZXNLazl1QXQwa1RhYkFSTFRrK2pJazhxQ3o5T1Vw?=
 =?utf-8?B?M291QmxtRTlTU0h4WlpRWWtZNEhoTWwyb20rdC9jY3FsMVMyblhDSGk5Nmdr?=
 =?utf-8?B?Rmtzam9nYlQ5ZWRMSHRBcmx2b1pUcHZQRHdaQVRQR0VaYnFySDBKMnJGT1dy?=
 =?utf-8?B?NVN2L1lHNDJEaENJRHBjYzNtbnJhSEhtUHBsU1Ntekp4b2NaZW1uMk80OUR5?=
 =?utf-8?B?c1FNMEpIaktVVkZrOW90dzd0N3RDZkNETUVBeGZjZkdVZHhiYzVud0dRelhK?=
 =?utf-8?B?VWtYQ2ZPMkkwK0x1S1RhbE5RL3IwUkhSdTdqNXAvZ0FoOXRLdEc1Zm85NHZu?=
 =?utf-8?B?RFBTMFg0S2NqOUN4NFVKZFB0NkhBMExnZ3pkZ2hIQlV5NUtIZmJQeis3aGN5?=
 =?utf-8?B?UDhUZmlOS0tnU0x1WXpDdkZadGUyQkRFc1h1UDJpNVJwdDJDZWxNa3poUmRU?=
 =?utf-8?B?dG91UFdjMTc1QTBIWTNvTWtweVhieHdiYWIvdmh4dnBoOHJVYjFzc2hPN25L?=
 =?utf-8?B?eUc5YUE2bEluR0ZmOTB1V1VKbTRCN2VLQStSdUwxclNKSlh1TEtoaW1WM3Iv?=
 =?utf-8?B?aVhub0FlUC9uMVMyVzlMR2hCd2UvUDNaZnFXYXpwNTFEclBkT29BZURobm1k?=
 =?utf-8?B?UFBhQ1pRV0ZLWHlncjlUVlFWc1F5WkxlRS9oQnFERkYwMHpZOWZWV1h5czhE?=
 =?utf-8?Q?VfPEhw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5708.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUs0VzRxd3RmYnhIS3kxWEJSbkV5MHJnN2ZpTThYWXlWK0hxM0c4ZTY3YjVN?=
 =?utf-8?B?OEl6Y1NoM05hRVdGWjBjQzhubGVUUWFVOG1jZEhEdWRGbEpZK1pnWC9HMEtl?=
 =?utf-8?B?bXhGYXNZUTZZS0hMNzYxL1RnZWtNei80QjlzRFdCc2xjYlZIQk1VWDFybzlZ?=
 =?utf-8?B?aVNCcnBHRFdwSi9pMWJVdjlJNEppWFNiaUNHemluaFdSS25Yc2NSQnduV1lz?=
 =?utf-8?B?ODdJOXpRWU1vbThPMjVSR3BuVFNFcGdQNHRHS2NKQ0g5NjR0OCtmU3g2WTBl?=
 =?utf-8?B?Z1ovaXVZT1pSNTZnUnlZaTdXQUpqUnNQYjVzRXNEODNxZE50M1hkSkYrRHpU?=
 =?utf-8?B?Unp1OEgxb1MxU2N5TXZlUWM2T1BQeVZKV1YwUWxtUWEyc24rTyt0ek1OcVpv?=
 =?utf-8?B?RFpzTTFwVGhZUzNiRnRoU1BqU1BGYSsvQ1RZYkNURkdsVG9ob1BwS0h4QzQ3?=
 =?utf-8?B?Y3hXaExMcThJbGNnaWpKTCtubHI1TkxsOFJ4bzh6aFNLcGZhbHFyS1p0UnVV?=
 =?utf-8?B?K25xdVg1QkE3cWF2MjdCdUY3MDRZdHBzdUNXbXhRZkJRSG82cU1xS1JzOEJS?=
 =?utf-8?B?NGdtTWVURERaSGdKK3p1NnNVWnVXaG51Mmw4bzhWZ1Fob21aaDY0SzloM1B6?=
 =?utf-8?B?VzNhdDYwV2R5NFFIaUNZeC9XdjNUZTdRbXhHeElVZkV4dWxyTGs2bVlxd0ZM?=
 =?utf-8?B?RmtZL0ZSTlN1d1hrdGVIa3pvYzRlYmhFNmtmS2NaT1p1dXN1NmMvOURMYUY4?=
 =?utf-8?B?SFRjVzdESXV2Z3lIVHNkenM5ZTc1NlpSN2c2RlBYSElYOXFVSWNSMUtZSnNv?=
 =?utf-8?B?Skk1VElxS213MTFCcC9sUkR1am9mWDBuNSszR2ovSEEvc1RJOFppaGdBNFlD?=
 =?utf-8?B?a0JuMGhwdWxxUFNjcXcvaW42blBGd0ZTUk1MZi93amFlQklzbEFrSFhRNlhz?=
 =?utf-8?B?RWlTN3NqT2graExGMHhOWmwwQkF1ZDNlQUI0b0NWUDRlcURycnF1SzRmcjZN?=
 =?utf-8?B?c04vMUFWVFRyV3MrNFVIYUtqRW9odW4yWFJ0UkdGNkxpeElpS1IyUFdKL1B6?=
 =?utf-8?B?NUNXOXMyVUh6NXRXdHFEak43Wk5NMTFGUTllbWhrejRSSnNGUVZ0K0lmNUFk?=
 =?utf-8?B?NlJiSXhvMVo1YlJ2RlY5Nm0yZWRqRVlReDVCVXgveWhKUjh1dHhqbXh6UG1u?=
 =?utf-8?B?TTk3OENZa0pyWW03NytRRHJMcXhCYUdYbXV3ZjFBdG1PNlJsdHNLS0hpME9N?=
 =?utf-8?B?TjA4eWpVajExWnFHelpMZnJxdkFtcXY0dkRaL2c5QWQ4cHAyR25GZ05qK2NV?=
 =?utf-8?B?cW9sbUdVakJUMDB2NVZMOU5RWWRER3hwdExjeXM3SE9qck95cWZwenFjMllz?=
 =?utf-8?B?NW5obnpGTndoL1FUdnRFc2RGTExrZnFtN1E4U2tPRytOWkw2RFZZamdRMWR4?=
 =?utf-8?B?ZkxKUnNQcXo3TlpJT3pld3E3THRJQlcwVVBnYmxjaGN1VTZ1LzRKK3JSRHY5?=
 =?utf-8?B?ZFBmOXI4L25sTDFydEppSHVpdm9GbHIwcWtmZ2ZRMEgxTTk1dFJoMlY2b2R0?=
 =?utf-8?B?YUtBMEJ4czA1TTZ0Y1NMN0w3WE4vdFk4ZmgvOUxwalQ4RWVTM1A0ekloOUMy?=
 =?utf-8?B?b25TUlFPd1JHVVF6OEFXeUpXUzM4b0tyVHdlTTFicEx0ckRCdDFzVWg2U2x2?=
 =?utf-8?B?NHlBb2x6eTR4bDVxaUVnMEJJT0loRTVFd3BjQXlaYzM3L0dlT3U1eEp4azND?=
 =?utf-8?B?RmMrOFFtMzE5UFRJVW9YZFFOOXRhTEM1SE1TQVdiY0I0ZXZGNlREYUF2L0VX?=
 =?utf-8?B?Z1hWRmUzenVjeEVGODVsaE9uWTJIZ2FGbDBORlFCbUFMTjVlUFRFMzNINThR?=
 =?utf-8?B?R084L0tkbmlUWlREZlR0UXJrK3B4dnRXMHQrUEM2T2pDV1k0SnhTeHlJZHVX?=
 =?utf-8?B?b2xibW5yeDBXSUNCQ3htVmMzL1FWdUh5dENhTUZsWmlsdVcvMkZuNGtrelo0?=
 =?utf-8?B?T0dhME8xemN3dDFtRXdxZ0FPNmE1cEorbG81bWFiUGJCcjBxSklnRTN5a3FG?=
 =?utf-8?B?a0JpSUd6dzltN1g1cjhTbmV0cGh2VjVERklEcG5rR0k5OXJ4TXdlMkhMT2Ry?=
 =?utf-8?B?cWVyWWk4VnpjSkN6cW5ENWRFY3NBaVBCU084MW1USExMc3JwRGs2WVFOTk93?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D8A7CE493C63B448210E39EAF339E0D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5708.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e57e84-443e-4bc2-0864-08de37d72031
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 10:30:23.0368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Djcrvyyzlg9PII9acDEFpluZZ7B/3zjlaljbmjGCEzcyNtwD7eG4VGcJwLeM+1coGEpArpBTOSDFR9vL4OJI+gkqqOMDSLKF4euNDmOsMuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7775

SGkgQW5nZWxvLAoKT24gRnJpLCAyMDI1LTExLTA3IGF0IDExOjM2ICswMTAwLCBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyB3cm90ZToKPiAKPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbAo+IHlvdSBoYXZlIHZlcmlm
aWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuCj4gCj4gCj4gSWwgMDYvMTEvMjUgMTM6NDIs
IGlydmluZy5jaC5saW4gaGEgc2NyaXR0bzoKPiA+IEZyb206IElydmluZy1DSCBMaW4gPGlydmlu
Zy1jaC5saW5AbWVkaWF0ZWsuY29tPgo+ID4gCj4gPiBJbiBNVDgxODkgbW1pbmZyYSBwb3dlciBk
b21haW4sIHRoZSBidXMgcHJvdGVjdCBwb2xpY3kgc2VwYXJhdGVzCj4gPiBpbnRvIHR3byBwYXJ0
cywgb25lIGlzIHNldCBiZWZvcmUgc3Vic3lzIGNsb2NrcyBlbmFibGVkLCBhbmQKPiA+IGFub3Ro
ZXIKPiA+IG5lZWQgdG8gZW5hYmxlIGFmdGVyIHN1YnN5cyBjbG9ja3MgZW5hYmxlLgo+ID4gCj4g
PiBTaWduZWQtb2ZmLWJ5OiBJcnZpbmctQ0ggTGluIDxpcnZpbmctY2gubGluQG1lZGlhdGVrLmNv
bT4KPiA+IC0tLQo+ID4gwqAgZHJpdmVycy9wbWRvbWFpbi9tZWRpYXRlay9tdGstcG0tZG9tYWlu
cy5jIHwgMzEKPiA+ICsrKysrKysrKysrKysrKysrKy0tLS0KPiA+IMKgIGRyaXZlcnMvcG1kb21h
aW4vbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuaCB8wqAgNSArKysrCj4gPiDCoCAyIGZpbGVzIGNo
YW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BtZG9tYWluL21lZGlhdGVrL210ay1wbS1kb21haW5zLmMKPiA+IGIvZHJp
dmVycy9wbWRvbWFpbi9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5jCj4gPiBpbmRleCAxNjRjNmI1
MTlhZjMuLjIyMjg0NmU1MmRhZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvcG1kb21haW4vbWVk
aWF0ZWsvbXRrLXBtLWRvbWFpbnMuYwo+ID4gKysrIGIvZHJpdmVycy9wbWRvbWFpbi9tZWRpYXRl
ay9tdGstcG0tZG9tYWlucy5jCj4gPiBAQCAtMjUwLDcgKzI1MCw3IEBAIHN0YXRpYyBpbnQgc2Nw
c3lzX2J1c19wcm90ZWN0X3NldChzdHJ1Y3QKPiA+IHNjcHN5c19kb21haW4gKnBkLAo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgTVRLX1BPTExfREVMQVlfVVMsCj4gPiBNVEtfUE9MTF9USU1FT1VUKTsK
PiA+IMKgIH0KPiA+IAo+ID4gLXN0YXRpYyBpbnQgc2Nwc3lzX2J1c19wcm90ZWN0X2VuYWJsZShz
dHJ1Y3Qgc2Nwc3lzX2RvbWFpbiAqcGQpCj4gPiArc3RhdGljIGludCBzY3BzeXNfYnVzX3Byb3Rl
Y3RfZW5hYmxlKHN0cnVjdCBzY3BzeXNfZG9tYWluICpwZCwgdTgKPiA+IGZsYWdzKQo+ID4gwqAg
ewo+ID4gwqDCoMKgwqDCoCBmb3IgKGludCBpID0gMDsgaSA8IFNQTV9NQVhfQlVTX1BST1RfREFU
QTsgaSsrKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3Qgc2Nw
c3lzX2J1c19wcm90X2RhdGEgKmJwZCA9ICZwZC0+ZGF0YS0KPiA+ID5icF9jZmdbaV07Cj4gPiBA
QCAtMjU5LDYgKzI1OSwxMCBAQCBzdGF0aWMgaW50IHNjcHN5c19idXNfcHJvdGVjdF9lbmFibGUo
c3RydWN0Cj4gPiBzY3BzeXNfZG9tYWluICpwZCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICghYnBkLT5idXNfcHJvdF9zZXRfY2xyX21hc2spCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiAKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKChicGQtPmZsYWdzICYgQlVTX1BST1RfSUdOT1JFX1NVQkNMSykgIT0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoZmxhZ3MgJiBCVVNfUFJPVF9J
R05PUkVfU1VCQ0xLKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnRpbnVlOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGJw
ZC0+ZmxhZ3MgJiBCVVNfUFJPVF9JTlZFUlRFRCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBzY3BzeXNfYnVzX3Byb3RlY3RfY2xlYXIocGQsIGJw
ZCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlCj4gPiBAQCAtMjcwLDcgKzI3
NCw3IEBAIHN0YXRpYyBpbnQgc2Nwc3lzX2J1c19wcm90ZWN0X2VuYWJsZShzdHJ1Y3QKPiA+IHNj
cHN5c19kb21haW4gKnBkKQo+ID4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+IMKgIH0KPiA+IAo+
ID4gLXN0YXRpYyBpbnQgc2Nwc3lzX2J1c19wcm90ZWN0X2Rpc2FibGUoc3RydWN0IHNjcHN5c19k
b21haW4gKnBkKQo+ID4gK3N0YXRpYyBpbnQgc2Nwc3lzX2J1c19wcm90ZWN0X2Rpc2FibGUoc3Ry
dWN0IHNjcHN5c19kb21haW4gKnBkLCB1OAo+ID4gZmxhZ3MpCj4gPiDCoCB7Cj4gPiDCoMKgwqDC
oMKgIGZvciAoaW50IGkgPSBTUE1fTUFYX0JVU19QUk9UX0RBVEEgLSAxOyBpID49IDA7IGktLSkg
ewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHNjcHN5c19idXNf
cHJvdF9kYXRhICpicGQgPSAmcGQtPmRhdGEtCj4gPiA+YnBfY2ZnW2ldOwo+ID4gQEAgLTI3OSw2
ICsyODMsMTAgQEAgc3RhdGljIGludCBzY3BzeXNfYnVzX3Byb3RlY3RfZGlzYWJsZShzdHJ1Y3QK
PiA+IHNjcHN5c19kb21haW4gKnBkKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KCFicGQtPmJ1c19wcm90X3NldF9jbHJfbWFzaykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPiA+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoKGJwZC0+ZmxhZ3MgJiBCVVNfUFJPVF9JR05PUkVfU1VCQ0xLKSAhPQo+IAo+
IElzIHRoYXQgdGhlIHJpZ2h0IG5hbWUgZm9yIHRoaXMgZmxhZz8KPiAKPiBBcyBmYXIgYXMgSSB1
bmRlcnN0YW5kLCB5b3UgaGF2ZSB0byBzZXQgYnVzIHByb3RlY3Rpb24gaW4gdHdvIHN0ZXBzLAo+
IHJpZ2h0Pwo+IFNvIGluIHRoZSBmaXJzdCBzdGVwIHlvdSdyZSBzZXR0aW5nIGJ1cyBwcm90ZWN0
aW9uIGZvciB0aGUgTU1fSU5GUkEKPiBhbmQgZm9yCj4gTU1fSU5GUkFfMk5EIC0gYW5kIGluIHRo
ZSBzZWNvbmQgc3RlcCB5b3UncmUgc2V0dGluZyBNTV9JTkZSQV9JR04gYW5kCj4gMl9JR04uCj4g
Cj4gU28gdGhlIGZpcnN0IHN0ZXAgKHRoZSBwcm90cyB3aXRoIEJVU19QUk9UX0lHTk9SRV9TVUJD
TEspIHVubG9ja3MKPiBTVUJTWVMgY2xrcwo+IGFuZCBTUkFNIElTTyBhY2Nlc3MsIHRoZSBzZWNv
bmQgb25lIGRvZXMgdGhlIHJlc3QuCj4gCj4gSSB0aGluayB0aGF0IGEgYmV0dGVyIG5hbWUgZm9y
IHRoaXMsIGF0IHRoaXMgcG9pbnQgd291bGQgYmUuLi4KPiAKPiBpZiAoKGJwZC0+ZmxhZ3MgJiBs
b2NhbF9mbGFncykgJiBCVVNfUFJPVF9TUkFNX1BST1RFQ1RJT04pCj4gwqDCoMKgwqDCoMKgwqAg
Y29udGludWU7Cj4gCj4gV2hhdCBkbyB5b3UgdGhpbms/Cj4gCj4gUmVnYXJkcywKPiBBbmdlbG8K
PiAKWWVzLCB0aGUgcHVycG9zZSBpcyB0byBzZXQgYnVzIHdpdGggdHdvIHN0ZXBzOgpJbiBnZW5l
cmFsIGNhc2UsIGJ1cyBwcm90ZWN0aW9uIG5lZWRzIHRvIGNvbnRyb2wgYWZ0ZXIgc3Vic3lzIGNs
b2NrCmVuYWJsZWQuIEJ1dCBvbiBNVDgxODkgTU1fSU5GUkEgc3Vic3lzLCBzb21lIGJ1cyBwcm90
ZWN0aW9uIHNldCBiZWZvcmUKc3Vic3lzIGNsb2NrIGVuYWJsZWQuCgpTbyBoZXJlIGkgbmFtZSBi
dXMgcHJvdGVjdGlvbiBzZXR0aW5nIHcvbyBzdWJzeXMgY2xvY2sgYXMKSUdOT1JFX1NVQkNMSy4K
CnRoYW5rcwoKQlIsCmlydmluZwoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAoZmxhZ3MgJiBCVVNfUFJPVF9JR05PUkVfU1VCQ0xLKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKGJwZC0+ZmxhZ3MgJiBCVVNfUFJPVF9JTlZFUlRFRCkKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBzY3BzeXNfYnVz
X3Byb3RlY3Rfc2V0KHBkLCBicGQpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxz
ZQo+ID4gQEAgLTYzMiw2ICs2NDAsMTUgQEAgc3RhdGljIGludCBzY3BzeXNfcG93ZXJfb24oc3Ry
dWN0Cj4gPiBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpCj4gPiDCoMKgwqDCoMKgIGlmIChyZXQp
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9wd3JfYWNrOwo+ID4gCj4g
PiArwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoMKgICogSW4gTVQ4MTg5IG1taW5mcmEgcG93ZXIg
ZG9tYWluLCB0aGUgYnVzIHByb3RlY3QgcG9saWN5Cj4gPiBzZXBhcmF0ZXMKPiA+ICvCoMKgwqDC
oMKgICogaW50byB0d28gcGFydHMsIG9uZSBpcyBzZXQgYmVmb3JlIHN1YnN5cyBjbG9ja3MgZW5h
YmxlZCwKPiA+IGFuZCBhbm90aGVyCj4gPiArwqDCoMKgwqDCoCAqIG5lZWQgdG8gZW5hYmxlIGFm
dGVyIHN1YnN5cyBjbG9ja3MgZW5hYmxlLgo+ID4gK8KgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDC
oCByZXQgPSBzY3BzeXNfYnVzX3Byb3RlY3RfZGlzYWJsZShwZCwgQlVTX1BST1RfSUdOT1JFX1NV
QkNMSyk7Cj4gPiArwqDCoMKgwqAgaWYgKHJldCA8IDApCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGdvdG8gZXJyX3B3cl9hY2s7Cj4gPiArCj4gPiDCoMKgwqDCoMKgIC8qCj4gPiDCoMKg
wqDCoMKgwqAgKiBJbiBmZXcgTWVkaWF0ZWsgcGxhdGZvcm1zKGUuZy4gTVQ2Nzc5KSwgdGhlIGJ1
cyBwcm90ZWN0Cj4gPiBwb2xpY3kgaXMKPiA+IMKgwqDCoMKgwqDCoCAqIHN0cmljdGVyLCB3aGlj
aCBsZWFkcyB0byBidXMgcHJvdGVjdCByZWxlYXNlIG11c3QgYmUgcHJpb3IKPiA+IHRvIGJ1cwo+
ID4gQEAgLTY0OCw3ICs2NjUsNyBAQCBzdGF0aWMgaW50IHNjcHN5c19wb3dlcl9vbihzdHJ1Y3QK
PiA+IGdlbmVyaWNfcG1fZG9tYWluICpnZW5wZCkKPiA+IMKgwqDCoMKgwqAgaWYgKHJldCA8IDAp
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9kaXNhYmxlX3N1YnN5c19j
bGtzOwo+ID4gCj4gPiAtwqDCoMKgwqAgcmV0ID0gc2Nwc3lzX2J1c19wcm90ZWN0X2Rpc2FibGUo
cGQpOwo+ID4gK8KgwqDCoMKgIHJldCA9IHNjcHN5c19idXNfcHJvdGVjdF9kaXNhYmxlKHBkLCAw
KTsKPiA+IMKgwqDCoMKgwqAgaWYgKHJldCA8IDApCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGVycl9kaXNhYmxlX3NyYW07Cj4gPiAKPiA+IEBAIC02NjIsNyArNjc5LDcgQEAg
c3RhdGljIGludCBzY3BzeXNfcG93ZXJfb24oc3RydWN0Cj4gPiBnZW5lcmljX3BtX2RvbWFpbiAq
Z2VucGQpCj4gPiDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gCj4gPiDCoCBlcnJfZW5hYmxlX2J1
c19wcm90ZWN0Ogo+ID4gLcKgwqDCoMKgIHNjcHN5c19idXNfcHJvdGVjdF9lbmFibGUocGQpOwo+
ID4gK8KgwqDCoMKgIHNjcHN5c19idXNfcHJvdGVjdF9lbmFibGUocGQsIDApOwo+ID4gwqAgZXJy
X2Rpc2FibGVfc3JhbToKPiA+IMKgwqDCoMKgwqAgc2Nwc3lzX3NyYW1fZGlzYWJsZShwZCk7Cj4g
PiDCoCBlcnJfZGlzYWJsZV9zdWJzeXNfY2xrczoKPiA+IEBAIC02ODMsNyArNzAwLDcgQEAgc3Rh
dGljIGludCBzY3BzeXNfcG93ZXJfb2ZmKHN0cnVjdAo+ID4gZ2VuZXJpY19wbV9kb21haW4gKmdl
bnBkKQo+ID4gwqDCoMKgwqDCoCBib29sIHRtcDsKPiA+IMKgwqDCoMKgwqAgaW50IHJldDsKPiA+
IAo+ID4gLcKgwqDCoMKgIHJldCA9IHNjcHN5c19idXNfcHJvdGVjdF9lbmFibGUocGQpOwo+ID4g
K8KgwqDCoMKgIHJldCA9IHNjcHN5c19idXNfcHJvdGVjdF9lbmFibGUocGQsIDApOwo+ID4gwqDC
oMKgwqDCoCBpZiAocmV0IDwgMCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByZXQ7Cj4gPiAKPiA+IEBAIC02OTcsNiArNzE0LDEwIEBAIHN0YXRpYyBpbnQgc2Nwc3lzX3Bv
d2VyX29mZihzdHJ1Y3QKPiA+IGdlbmVyaWNfcG1fZG9tYWluICpnZW5wZCkKPiA+IAo+ID4gwqDC
oMKgwqDCoCBjbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShwZC0+bnVtX3N1YnN5c19jbGtzLCBw
ZC0KPiA+ID5zdWJzeXNfY2xrcyk7Cj4gPiAKPiA+ICvCoMKgwqDCoCByZXQgPSBzY3BzeXNfYnVz
X3Byb3RlY3RfZW5hYmxlKHBkLCBCVVNfUFJPVF9JR05PUkVfU1VCQ0xLKTsKPiA+ICvCoMKgwqDC
oCBpZiAocmV0IDwgMCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsK
PiA+ICsKPiA+IMKgwqDCoMKgwqAgaWYgKE1US19TQ1BEX0NBUFMocGQsIE1US19TQ1BEX01PREVN
X1BXUlNFUSkpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY3BzeXNfbW9kZW1fcHdy
c2VxX29mZihwZCk7Cj4gPiDCoMKgwqDCoMKgIGVsc2UKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BtZG9tYWluL21lZGlhdGVrL210ay1wbS1kb21haW5zLmgKPiA+IGIvZHJpdmVycy9wbWRvbWFp
bi9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5oCj4gPiBpbmRleCBmNjA4ZTZlYzQ3NDQuLmE1ZGNh
MjRjYmMyZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvcG1kb21haW4vbWVkaWF0ZWsvbXRrLXBt
LWRvbWFpbnMuaAo+ID4gKysrIGIvZHJpdmVycy9wbWRvbWFpbi9tZWRpYXRlay9tdGstcG0tZG9t
YWlucy5oCj4gPiBAQCAtNTYsNiArNTYsNyBAQCBlbnVtIHNjcHN5c19idXNfcHJvdF9mbGFncyB7
Cj4gPiDCoMKgwqDCoMKgIEJVU19QUk9UX1JFR19VUERBVEUgPSBCSVQoMSksCj4gPiDCoMKgwqDC
oMKgIEJVU19QUk9UX0lHTk9SRV9DTFJfQUNLID0gQklUKDIpLAo+ID4gwqDCoMKgwqDCoCBCVVNf
UFJPVF9JTlZFUlRFRCA9IEJJVCgzKSwKPiA+ICvCoMKgwqDCoCBCVVNfUFJPVF9JR05PUkVfU1VC
Q0xLID0gQklUKDQpLAo+ID4gwqAgfTsKPiA+IAo+ID4gwqAgZW51bSBzY3BzeXNfYnVzX3Byb3Rf
YmxvY2sgewo+ID4gQEAgLTk1LDYgKzk2LDEwIEBAIGVudW0gc2Nwc3lzX2J1c19wcm90X2Jsb2Nr
IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9CVVNfUFJPVChfaHdpcCwgX21hc2ss
IF9zZXQsIF9jbHIsIF9tYXNrLAo+ID4gX3N0YSzCoMKgwqDCoMKgwqDCoCBcCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJVU19QUk9UX1JFR19VUERB
VEUpCj4gPiAKPiA+ICsjZGVmaW5lIEJVU19QUk9UX1dSX0lHTl9TVUJDTEsoX2h3aXAsIF9tYXNr
LCBfc2V0LCBfY2xyLAo+ID4gX3N0YSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX0JVU19QUk9UKF9od2lwLCBfbWFzaywgX3NldCwg
X2NsciwgX21hc2ssCj4gPiBfc3RhLMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCVVNfUFJPVF9JR05PUkVfQ0xSX0FDSyB8
Cj4gPiBCVVNfUFJPVF9JR05PUkVfU1VCQ0xLKQo+ID4gKwo+ID4gwqAgI2RlZmluZSBCVVNfUFJP
VF9JTkZSQV9VUERBVEVfVE9QQVhJKF9tYXNrKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJVU19QUk9UX1VQREFURShJTkZS
QSwgX21hc2sswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSU5G
UkFfVE9QQVhJX1BST1RFQ1RFTizCoMKgwqDCoMKgwqDCoMKgIFwKPiAKPiAKCg==

