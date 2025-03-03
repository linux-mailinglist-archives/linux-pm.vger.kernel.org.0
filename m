Return-Path: <linux-pm+bounces-23249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853E5A4B61F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 03:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FF51644F1
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 02:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632613AD38;
	Mon,  3 Mar 2025 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kCIsg9AX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HUBsU8X9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F535947;
	Mon,  3 Mar 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740969050; cv=fail; b=mbdux9irEKBVBv3GyShqQ0gpvSxqzFqbpbg5wZG+NU2J9+1T4HYZoZhi99OoHUDwMzgxA76Pjnssy1Jz45uFgGd6+xXXDrILDRvGlsE2S2VZgqFkwyOSNuRVsuPrTaTJmpu5Pou5n8Q2U1Dm1BVR+uHk6hvl/UI/7Z5uK3Bk7bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740969050; c=relaxed/simple;
	bh=PIEjm2qDnln0S5SdcS537j/NRsnSejo75EtEX8drNnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ROV55QVSJiNO4O74ksy7z/r7LQRAoQPmjm1k2CTEW1UVFzIpEqI7gje9ur32hp6IOq3aQXjFGgWJq1ONSjG+pLejTR5IDpAcNszugZvPZJoFxKvyyfTZMwdL/cN8L5zWoBil5zhLJ0LpmxZlibaAfvd5VIp2ZObTvpMf9RMn978=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kCIsg9AX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HUBsU8X9; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 78cbe240f7d711efaae1fd9735fae912-20250303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PIEjm2qDnln0S5SdcS537j/NRsnSejo75EtEX8drNnA=;
	b=kCIsg9AX7aS3Zhpc1ffqI/LEH+k4A/C/ub32+JdqT9cGEiAeq8A+q73JKLMeWZfUvfEDgytGp2pLvnLPh6K9B0/RWNi4vCxJLxxbMK3rK5X7TkN6hDK6McUQNIUsC+0SsYkQxOM7Tcj9V2IqdJ5jrQF7bfY+amgpj4eQ9iRe4h8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:9c66cd05-29a3-4247-8a91-8f32b73d2093,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:85ffbca4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 78cbe240f7d711efaae1fd9735fae912-20250303
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1061817625; Mon, 03 Mar 2025 10:30:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Mar 2025 10:30:27 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 3 Mar 2025 10:30:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI9aKUZYiEUjoiStdK8yXMFKCOvPbZtp4QPPsdkUFHKZ01DJRTVnE4gLNdUxAA38xYIUQkCsvGSVR59svEJQQuwGJkkyHkJrHPIyLtWasNtNvccOx35JVnVesk1jK5rbenYKLAw5DXnIn/vvp8oNjMY9vQXTSVrfoENVsetx7GIpo4SCB94iLugqEtuI26hPsQXuN1qvoTpQvXXYB7lvc88V0ieXK3kgIvcHvoW5kTK6ZvTx/+bjeX0A9q3CY1vTrYm1YrgenZCaoT8GxYk4Dw1CV/EhmtM/CvxcAZ6WQc9/PFvkuU+wNXkiEOGEIi7ND10buRoChxTNuLKO15XCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIEjm2qDnln0S5SdcS537j/NRsnSejo75EtEX8drNnA=;
 b=u/b+2WTqZueWVHTY7MTXhjV5MuOCI5TVylJMb2WbLJ/iMX86vRgs3zmkBfFtmBU814TUyQpWaBQcKmrqoQuqyk1HwWULPa/9ggRt3/+jh/yETtvmyM33dtHaGFKMvHbjKUSw9ADqqGW486xHPeleG2GpjWqudCDw7dfdqSVUT/dBE3D9S7j+7TEqt3TYfIUyVJxEOPRbc/mITmuyaygTLkaktTCBcts66xkuYs6LGwWDsutp85SmRG3kS0RJ8fne1mhie48oCaLstV8We6SQNMta0/13mdMyFOFcGC2gs8tfM+aBBP+IUl10OmFSl1yBDA6YcSB4n64YjAhq9EZ/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIEjm2qDnln0S5SdcS537j/NRsnSejo75EtEX8drNnA=;
 b=HUBsU8X9dA5Oz8pe07kWaJO1R5hsOKR7mGEWh0hDMjvEBjAX9AoN2nh/VFug/LHKKueShTfkV1ZYfX0N982YgRAcJsuEZT9GraPKrZFjvaLZwUHDCKWffPrYdlef7/DtqJrG4yrVfrhlTcW7fZriAXlr2KD5xvaGoJtA81VW6N4=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by JH0PR03MB7594.apcprd03.prod.outlook.com (2603:1096:990:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 02:30:24 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:30:24 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: =?utf-8?B?U2VuIENodSAo5YKo5qOuKQ==?= <Sen.Chu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tiwai@suse.com"
	<tiwai@suse.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
	"robh@kernel.org" <robh@kernel.org>, "lee@kernel.org" <lee@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, Sean Wang
	<Sean.Wang@mediatek.com>, "will@kernel.org" <will@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, Nicolas Prado
	<nfraprado@collabora.com>, "perex@perex.cz" <perex@perex.cz>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	Andrew Perepech <andrew.perepech@mediatek.com>
Subject: Re: [PATCH v2 19/20] arm64: dts: mt6359: Add accessory detect node
Thread-Topic: [PATCH v2 19/20] arm64: dts: mt6359: Add accessory detect node
Thread-Index: AQHbi5DX6Z1elc3FSkmb7GGW/UilLrNgsUyA
Date: Mon, 3 Mar 2025 02:30:24 +0000
Message-ID: <3dd23bad242f1578a8084ad7acfce883a412cfe7.camel@mediatek.com>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
	 <20250302-mt6359-accdet-dts-v2-19-5bd633ee0d47@collabora.com>
In-Reply-To: <20250302-mt6359-accdet-dts-v2-19-5bd633ee0d47@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|JH0PR03MB7594:EE_
x-ms-office365-filtering-correlation-id: 41e1732b-696f-43ed-3da1-08dd59fb5a62
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VXpUaE93ZTR2em5CeFpDL2pFSE1ESWhBblREUkFaSU1qYlM1eTRaWDdzd1N1?=
 =?utf-8?B?bnFyQjR1MlFBbTVMNmxoYUFGc3ZMeHhkRDdXaUxCWDBUYys4b3lkVWFQeFJF?=
 =?utf-8?B?OW9jRHd0dldOUEY1RnpPQ2lkK2YwZjNsZ0M1RnhKb2dPWms4WXVKNGhDRmhy?=
 =?utf-8?B?WkNZeW1PdFJSdlFmb1hUZFF6amtoSG13VVh2ejBtUUtzcmZ1bW92ak9RV2Zm?=
 =?utf-8?B?VjdMeGl3Mkx2SEVzeDhBRlozKzl5TndTMjhwaUJuV212dEZzNlpETUppU2t6?=
 =?utf-8?B?SEwxYjQ3SUxibmlBbXRjSDRCT3pkcGJQUXVSaFB0T0Z2YkE5MXpyTy96aktR?=
 =?utf-8?B?V2l2NENTaUpiRGtMcTZNVDVBeTdHNzQ2b1VGOHRiV0JNWXdXMWpNZG90b2k4?=
 =?utf-8?B?SGhWUVgxa1BEQXNBaExaeWRTdTJ6REEzY1hvN2drRGx2MjlzY0VtNjh3T2Fl?=
 =?utf-8?B?a08xbTlFRm9PWmxJV1pGME56RXQzbU9nOHF6MDBYWk1EQkdpNUJjWGRrTXFL?=
 =?utf-8?B?UDRBM0Zha1VsNnZGaTBXK1BQSHFJZnFFOHZoQ0ZDbUdrZnFuaWRkUjZuNHRP?=
 =?utf-8?B?KzlrM3VPUW9BZnhFenhxK3BYa0VGVHhhRzM5QmhBbDdWT1E4dmhlOG5NTDhk?=
 =?utf-8?B?alhsWW9ucTBML3pJMGttMjlRZzVuVE9rTStwSnd3K1U3THpvdFhjQWh5NWZu?=
 =?utf-8?B?Y1pxcW5qekxkNTM5OWlTS0ZrbXlvdXJGekcwWlpCc1RUNXkyTUpyb0FlZm5R?=
 =?utf-8?B?ZTRjNWkzalVQOU5RWldDc3VzdmNlSEJQeEl3eE81aks1NTdVWXE3VFJNMXdk?=
 =?utf-8?B?UWQwNHRpM0laNGM1Z3Y1c1ZOZWFFVjdOdTFKSGRMeGp2aTJhUURmTDMzaDFS?=
 =?utf-8?B?MHZBUFp0Z3dwUGpHU3dpZFBuWHdvZ2hveXNrY29IdHBtNy95Zk1pUWo2SEVZ?=
 =?utf-8?B?SmFFVUVIdTJOODFoaUIzdG9FakM1NUUwZ1FPNjJLbVRvNEw0K0hLRjBPZ09D?=
 =?utf-8?B?aVVOVFFkdWRqRHYybU12Uk9UM2lnV0Zwd1puUDNrRDQ5dlZxdDNFWDAvN2xh?=
 =?utf-8?B?alFmNmg1YXZzcmFyVGF2Zjhxc1A5anRLRFZNdVlwbVVFS1lkOEg4NFBkQWd3?=
 =?utf-8?B?Nld0VFJtcTdHcUQ4SGtPWlZPcTJMZGJzR3NpTzZvalNMTGhCWkZPNXowOURl?=
 =?utf-8?B?WThiNU1qVFJxQkdlQks5bXA0NzJkMnJzRTgzR1QvdkFHd3JVWFVPTWRvT014?=
 =?utf-8?B?WFFMVzhZMTYzdkd5T1kxZVZMMW1LNzBQYzZIdXpwMEJTYzdlNFc1SzBWbisv?=
 =?utf-8?B?b2JEVHpLREFiVEY0LzhGeDEyME9OQ0swRzVjeDZ4UmQ0R3VnT0JERkV0R2p0?=
 =?utf-8?B?VG9NNDlpQ1NaWms2dmZWSFkzbVZJQ2hvWlU0ZVBFekxXb0hJQmo0YUV3Y2RQ?=
 =?utf-8?B?T1d2WG9DSkhpMk1HTC9xMUY3NFlLVEE0Wm1aVTZZbUlXbWZOdkpwUFNyN0Rk?=
 =?utf-8?B?SkttdGFRQ1hrZjJuN3B5eXVoS3RiUTZIRjQ3dDBLalRzbnlOdG1YYlNCZEdm?=
 =?utf-8?B?M3JsYmlpc1BJc2poaW5nYUQ2SXA2eFhOaXExNWRMdFhiSUtTaTRHN1lFMVov?=
 =?utf-8?B?QjlqUGtVenkwTGVZUXZ6Rk1jZzdiTUpUYXRqU2F3TkkxOU1rTVJlQ2lyUnVh?=
 =?utf-8?B?RFBRbEtYZ2xBcERBblMzek9tY1hjQ2tHcmo5S1dYU3pSQi83ekI4WldpNnNj?=
 =?utf-8?B?RmVGRU51NXVwZG90d2ZHbG1xMWFLaExSRzRLa0VobUl0dktBdzBtQWZlOWEw?=
 =?utf-8?B?Zi81RU90bDRodDh4dFBUdHF1TnNaMUV1c2Jlc0xaQ0h3Ni9yL2Q4ZVlkdlFW?=
 =?utf-8?B?MFVlK3BIRTFrMmpwZlU2MHJMdzJ3aDBHSUM3ZXBJYjVJZEFtMU92dmxXMFFl?=
 =?utf-8?B?bFF4bXlzZUJJRXJITGhBdi9tTzRDYUVlZkluM0VjMm9nWDFRT25pV3RMbUl6?=
 =?utf-8?B?cC82OTRjN3FRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUx3eWNmbWUzM3Q5aVN6RjZQdkF6Z0xBKytJalMxMlJFTDB3MzM3YVNQc0ZB?=
 =?utf-8?B?U3lMSWZLU1FTYjdNTkgwSkhWSkVPR1JDVFg5UFA1UENWQ2xaVUtSOE9taVRD?=
 =?utf-8?B?V2R1eG9HOVk1MnJwOXZQcys5YytPeXVrbjIrWHE0MnlPMkwzdjBsWTJHUXIr?=
 =?utf-8?B?QW85bHRLRWs0Yk5LRHc2WkZnb1hPODNNOXhCSnBXNTZMU1ZEQWVjKzRITDBz?=
 =?utf-8?B?cFhmNVBPc0c4d2JqM0grZ2pTcTg4a0IrcFdjZHY2bmtFY0NvNEY1QnZzU2l5?=
 =?utf-8?B?eTJlRWhUVEpxZlFmbzBMUDJnaEZHbFZ2SS95dUVseUtOUktpM2QzQlNvejhs?=
 =?utf-8?B?UmY3MEQ0N1BiZzhoYWtNeERCd1JZdnZwWVdQOG1QMVRTUDAwVG9Da1JLOG9U?=
 =?utf-8?B?MFlEbGl6K1FJc3RhZkVidExoVlJ1SHZaaUF1TWZRQWNBMWc3d1FTdWw2cnk3?=
 =?utf-8?B?UzNseHZJNnJETWlBSDRIREc2dDJjY2FFS2p0d3NlU21sR1JmQjVWUFl5T21m?=
 =?utf-8?B?eUZUWkF1WVdLRUxaRzVXWEs2VTdhb3pXT2orYWpUT3RRQURUSXgyWnU0N29u?=
 =?utf-8?B?ZEIyZU5nVU1vTDMxWmdFeUNhdThUV2R6WDFSbk8zdkxMUC9GVkZMVVFsV3Ex?=
 =?utf-8?B?WmsvTVNZbCtsM0h6NW1IdzZlL1UySEZJd3ArWFZ4TldqUUxMZjVXNXlkVE1w?=
 =?utf-8?B?WDZPUzdOMkswY0RYRTN3NmhoSUR6N24yT2VWMThMaFRESjdkM1Vwc20vNjlK?=
 =?utf-8?B?ekgvaXdncVMwS0kycWJOTStmMFFOamRNOGp2TERmQVpxZm5oMmtpL1FBdlll?=
 =?utf-8?B?N0g2MXpMR3VsYnR6eXFoYThWRVZobWJPZmlYUTF4QVZZYWozZFd6eEVjOU9O?=
 =?utf-8?B?MXltTWNkY2NKbExhaVIvUGZ5Tk9pTmg3TE80ZStVd2taOENsaW1MbzZlSyta?=
 =?utf-8?B?NnpDNFFEVTExM1VGSDdITVpzcFhUdUZUSG00ZGxiWERjMVIzdXd4MDQwZzU5?=
 =?utf-8?B?b00xMXNyZEtYV01IMHRaNmpyMnVmVTZ6OUIwRlFCMTU5czQwRjFLOERzNTY5?=
 =?utf-8?B?M0E5V3o1SnRuREFCYytzYU5lcHoxZnRMUElyODhzMWZzdlRhTzdCTmk0aWR0?=
 =?utf-8?B?NWNhV3VxUlFBcno1MWhtSHlJMnRaaml5SUg5ZUkvNDJNQ3VtKytDVjNLSGx0?=
 =?utf-8?B?TlBtb2cwMEpqMVJzRFAxeVFXOVgwUDhZbjE0L3lzbUFPT3hjNk5KY1ZGUHcw?=
 =?utf-8?B?d0VnQzExU0ZVQzVVU3Y0YUVrd002b3h4UEFoVE5EaXdGUTFEVGlnL2o3VUVD?=
 =?utf-8?B?NzUzaVNxZ3VGcEdmWDVpbCtOWmMrMkJPaS9HL3pGeWlaRlQ1L3hWMzAwdGha?=
 =?utf-8?B?R3pPQ2ZyZlhEaXNvNFFGRnhoL2gwcGN1bElMOWNSSk93b1lFekFvckFJdDlS?=
 =?utf-8?B?NnhpY0twSWl4eXkvRTJFWGgyZlN6d0VoZXVJM3JTSTcrTXl2aUZ1UlA2Rzhl?=
 =?utf-8?B?Y2kwQ1JxdDJnVS9PUXh1d3dTZzN1eDJrV0NtVW4xVFRkem0vTEx1ZWZRTklF?=
 =?utf-8?B?cFF4SFRFdFFYeWtJWk1GV1FiZ3QvSi96REFUaUh2VGFRVytwcjNpaHl4dlRF?=
 =?utf-8?B?aWxjWDBKU0Y2dTJCNEE2TUNwYjNhMndPY2ZzR3NLeWt2QzRkcG5WWmg0dVRV?=
 =?utf-8?B?dXRBOTRHaWpsb3Y4SEJNSUhyRVcvVG9wTnBrczIyMmpBUDRDdjJvWTFDRXk3?=
 =?utf-8?B?V0pNYlF0TVNwV1NRZDdCa0xBTmdHNWlwNmV5OEVQaGVCTXFlMTNFUTlCR3Z5?=
 =?utf-8?B?aUZNOFRNQXdQNzVEVUp3WWxWV0l1aXIwTHhCT3hManZCRXFSd2w1LzY2MDMy?=
 =?utf-8?B?TzlXOXQ3UlN2a0F5THFnaEJjdk1seU0rRW9UQ1grSU1xREN6SWRTdFVZZ2Ey?=
 =?utf-8?B?dHNMRS8raVhueWtGNUEyam5WSHMrb0czT2U1c3QyNGZoUXBjNStubVZJdHZ1?=
 =?utf-8?B?ZmJrUlNsWUNyZFc3Q2ZnOFhVQ1B6c05DZHZGTStnejRKT2NyV04rbUJZMncy?=
 =?utf-8?B?NUx4S0ZxV3lWTS8zVDl5emExVVFPSUxFenJJc2M2ZGtQbFM2TEk5Kys1ZzV1?=
 =?utf-8?B?QW1aS0VCVVJ3MGNyMWdIVzhBOXQxUmc5MEVDemJBaVFYVEhSUWxRZUVWRDcy?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC9F9BF1DFCC0543B6A135AC28CF0C1A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e1732b-696f-43ed-3da1-08dd59fb5a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 02:30:24.4428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NA/h8Ly6Cj8hmIH8i6EIyqAIlvZ2B0gvdRVLkqo+VjNSJE1ob7HzJAjFSLRWvDWFljKUpDOpbUNjOuKz5ZpL7NivEWvq8RapRm960Sm7uG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7594

T24gU3VuLCAyMDI1LTAzLTAyIGF0IDEzOjMwIC0wMzAwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFk
byB3cm90ZToKPiAKPiBBZGQgYXVkaW8gamFjayBkZXRlY3Rpb24gbm9kZS4gUE1JQyBhY2Nlc3Nv
cnkgZGV0ZWN0IGRyaXZlciB3aWxsCj4gY3JlYXRlIGFuIGlucHV0IGRldmljZSB0aGF0IHdpbGwg
c2VuZCBrZXkgZXZlbnRzIG9uIGphY2sKPiBpbnNlcnRpb24vcmVtb3ZhbCBvciBhY2Nlc3Nvcnkg
ZGV2aWNlIGtleSBwcmVzc2VzLgo+IAo+IENvLWRldmVsb3BlZC1ieTogQW5kcmV3IFBlcmVwZWNo
IDxhbmRyZXcucGVyZXBlY2hAbWVkaWF0ZWsuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBQ
ZXJlcGVjaCA8YW5kcmV3LnBlcmVwZWNoQG1lZGlhdGVrLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBO
w61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+Cj4gLS0tCj4g
wqBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1OS5kdHNpIHwgNCArKysrCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kKPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ2MzU5LmR0c2kKPiBpbmRleAo+IDdiMTBmOWM1OTgxOWE5YWQwMjMxOWYwMDkz
OGYzNWM5MzEwOTFmOWYuLmUyNGU0YWViM2I5Y2FmYTJhZjU2YzYyYmM0Ywo+IDU0OWRmMjdkMGVj
NzMgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTkuZHRz
aQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kKPiBAQCAt
MTUsNiArMTUsMTAgQEAgcG1pY19hZGM6IGFkYyB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjaW8tY2hhbm5lbC1jZWxscyA9IDwxPjsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhY2NkZXQ6IGFjY2RldCB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2MzU5LWFjY2RldCI7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG10NjM1OWNvZGVjOiBhdWRpby1jb2RlYyB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjM1
OS1jb2RlYyI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gCj4gLS0KPiAy
LjQ4LjEKPiAKClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsu
Y29tPgoKVGhhbmtzIQpNYWNwYXVsIExpbgo=

