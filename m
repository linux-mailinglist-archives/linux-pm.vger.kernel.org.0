Return-Path: <linux-pm+bounces-13326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F31E9682EF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7061C2061C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B433186E5D;
	Mon,  2 Sep 2024 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Zzb828Ym"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010034.outbound.protection.outlook.com [52.101.228.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31631714A4;
	Mon,  2 Sep 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268722; cv=fail; b=naedPTeBLK2l9KMy1Ah8Uz3YBrpZhyCa61HWDVQwbFlv4lfbuscdI/DwhLsC6lN2KG893hU9rrZWRPfW2eKPC6iNXrA9z6jjBuJw+iC1ZRMfdjYkET6bSqUTojQLAB1XImQoTbYRaxlvBRw+rQJF/iydjzIHx2m5LxLRsGczmYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268722; c=relaxed/simple;
	bh=/rictM0+YSiR3cvbGVKFo6ZHgeTyeBEFJSfkTaA1T5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SPff/csy1e9/g8g9PoA+tx3JX7xjhnc7ivOpZ6TYzZdzBwJhRFOg1nUpNrEy6sMt6sgtzwR95TnEewbyWtuLfx3wvvTaNxQZa3jJaQ/NwFVQHt7iPaMzjFw8vNamgbfkHQG3EPUiOQAlGA0wD5xUytkaPC3kMEjf2eaUTF+sCTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Zzb828Ym; arc=fail smtp.client-ip=52.101.228.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkrTBGEtLRTOI+IA9X/pHx6LNpJ9VAwyo6Nz54FjPUyDf+oD+inVlbzS7lAINHSAZ/PKZF3FhyJfTt1N24/UItXgW/L5thrsUz0zQFJ0KRlcUGKpz/0u5alex/IEWxz6BlmHcrLn7/33CvUN80Jsov4yJSdBIGaO6iHZOTmUO2visp3D2Wz5Uwcj2eedFJTfPwep7Vo00OYccLROUi6Jzx9i7+XQg1Kufkv0k9leiUYH/NxmyKN9rE7HsL6RXxo49JixA8AwzLSU6FaDfHmtoQrnHjns97A6ONBgreSqgzIzc+xfjiS3GEBM65wlgn2jXaGaj/OSAgFJ1aSLb4Xh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rictM0+YSiR3cvbGVKFo6ZHgeTyeBEFJSfkTaA1T5E=;
 b=dOthPWJqcdY/kgjL3pypj87/OLefI0vj/9XIQTxQ+3bw7YJH+I8csmBFbv2WZvBB51No8dLV72ZtiKBUApqjd7qPs8WlLQ9lvu1lH0MsNeWpKJa6WVcvU9yyZg2RP6Zj+8ZxuAU0dqKlp7hqBoO28HjjI7dFR7T4L+Js74bBLfCYF209laB+skmLzNuq2MNh1kFWp9Vm7Jj3c9Gng9ze2mNx4f2YLXeRCwaCf5K8GiiWEPzNJ+j7CGS6QF6K9vwlMx3If04D64vawKzEqKco5hhKy44ZqwzgrwycSFq1Q0pIxnrG++XIKPSmgxkZZD6RneOPebEnpv3THI/RAtnaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rictM0+YSiR3cvbGVKFo6ZHgeTyeBEFJSfkTaA1T5E=;
 b=Zzb828YmGO/31eRaaPawXz79Jc3YcYyWF3RfWyu67dy4s2fbtJbhyJfS/nSWGIDOWG7ULpOQ1qRgPykGvR4tGxkw21ZVD+L39giBMHm5/I3kKPYDSndPFVcfEHcCb8d1CpDsCJsmcgysgZ7mDRBF/3FnNbZWlIzBzeC+UMKmqaQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7220.jpnprd01.prod.outlook.com (2603:1096:400:f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 09:18:34 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:18:34 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, Yoshihiro
 Shimoda <yoshihiro.shimoda.uh@renesas.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Thread-Topic: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Thread-Index:
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkA=
Date: Mon, 2 Sep 2024 09:18:34 +0000
Message-ID:
 <TY3PR01MB11346505565B81AD2894E035586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
 <TY3PR01MB113464D53083F4C8A5DBBA36586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <590a4fb2-24b2-432b-92db-534c5a52ed0b@tuxon.dev>
In-Reply-To: <590a4fb2-24b2-432b-92db-534c5a52ed0b@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7220:EE_
x-ms-office365-filtering-correlation-id: beb73a6c-5e7b-45c8-bbc4-08dccb303865
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkFVRkhsSkRzVGdIeTlkaVJXVHFJL2syWEtSUFBtdjhUU1FiU0NMa1QwY1ly?=
 =?utf-8?B?VzhlZlhaSUJCNDZkajJNWkI5V3lERENxb0tONDBWeUdvRHR5cWxKbzNsKzN0?=
 =?utf-8?B?VzFObU44REJaZDgyYlZ4bmlrQjRvRUd5Rll1SGZNa05QMnVnV1NDNDJBdTZL?=
 =?utf-8?B?Y21IMjhUU2g0MHdXelhyVStmaHNyc2ozbHJKVm9NL1RqNytIL2tvUG40WnFT?=
 =?utf-8?B?aW1JMmNaUFB1OEdjb3VaMGx0S0tOQXRhYU1FVlR0c1lxUzQ4SEFqRmdlbFFZ?=
 =?utf-8?B?clprRnRnTHZDSUNjaFVud3FRSkxDNnNDSEpka1ZERC9OVkpZTFQ2RFMwdFB5?=
 =?utf-8?B?eFJDdHlPM1l4Szg4WlZxUWplbU5yOEZuMUlnSWRGalp1OXljRndSdlBrTkk3?=
 =?utf-8?B?by9XdHFkSjRncG01dDJHQ1FxUW5BdWFQRUhFWUZWRTJpR29ZKzRKTlA0TWZU?=
 =?utf-8?B?endqTGNmQmpqT1hvSjlXY285U3lmdVRXV2Q5V3pHSjJnQjJnbmV0Q0IrNytL?=
 =?utf-8?B?YzdYaERGYmVMeHZlLzJIQVN3Wm0vYlZ1L3pJRWp1WjJxWGVuT0R0cnNqdTha?=
 =?utf-8?B?V2FZWkdHN3VKVnRNdUk4RXN3RklBczRaa085WTRaeEx6aDhnSjYycG5PYXRD?=
 =?utf-8?B?YTdHM21YaGpXb1FoS2FlYitVS20vTG1hbnBVR2tha1FJVTJVOTR5Sk5za3JG?=
 =?utf-8?B?eFV4RExvdHZNc2hlajZURGx2Mnp5RkpoU3NxNFdHNmw0ZGFScmY1VDJUS0xx?=
 =?utf-8?B?R1d0RUovWjc2bTFvRjBtTUhGMHRUYjFZNjQzei9RY2dpMS9zVGNPbzJsM1Rk?=
 =?utf-8?B?eXNqMU5RajlMOFViaUc1MnJ2VHRZeGRRc3ZER1hJSWVTUERkTUNiM215MHps?=
 =?utf-8?B?eDYxUnJ5d0pQWlR5cXJsaEgxRnQ5ZzFzOUhWUlZjL1lUdnA3S1ZWZUU1dER2?=
 =?utf-8?B?ZGQrTXJ3OEtHQUFITXJ4OGFBOXRTcWRRekt5cmRJK050VEw5T2JjRzl2dWJL?=
 =?utf-8?B?VnAvZE9FTE1QWno3N21TeExubnpQWU5FYy9pWmJ0SXFEOENta0pkcndieVU5?=
 =?utf-8?B?d2d4MHRoQVppUmdadmpnd0d5R0E4UnBvTm9VOWVvSWFNTzRIbUpaeUVJcFJ0?=
 =?utf-8?B?Ris4UVllUjBHa1h2dFpwRkhnUDNWbTRiczI2c3R0WmxpbWdSVXk3Y2p3SHBO?=
 =?utf-8?B?c2RzUi83QnNQMzRYZnQ4WXRFeHU2QWpTenlHdXNXdkczbHJqSnM0K3d4UVpM?=
 =?utf-8?B?dWF1Z2trdjRrVU0va1ZyNEtGVFlLK0pRVVhJcFBOa04rUEpHbXFDMjJRaXJj?=
 =?utf-8?B?UENWZjJQcXh2Ylk5c1I0dnl0a3JqQzZHUHpFamlZMTlvK0lkek9TY1Y4STNF?=
 =?utf-8?B?anlsOFZtSTR1WVBqUWdaUFk1eGFyeTAvZmk4SkVxcVpWSmJ5YUw2UGRBT0VI?=
 =?utf-8?B?U0FYT3VIUzJ4WDVzVXJPbUowT2k2RFp4aGh6dmg1b2N1SlFFSmNCZ2p5QlVX?=
 =?utf-8?B?UzRCTElzbk0zYVJodEtyTDlEU3hLcE5BdjFhN0VYckszSEtoTnJ3L1lpNkVB?=
 =?utf-8?B?dmUrT1dwNi9pbUZiQWFjYjZ5aEtmblhoZVdoSHB5Y1lZaVRKSlVtM2xGRmlX?=
 =?utf-8?B?QzE3NytPWkVxeUh3Rjhha1NQZVZ5TUs2c2Q1OFgzK21STEFzbFB6UnpPTlJR?=
 =?utf-8?B?OTRTVG5WK1A3TkJOWXlyendveFBDOVJ4c3B1TUhRaW14QmU1L2RaU0pWSkRM?=
 =?utf-8?B?VlNUSGVDZ3J0Nmw5R295VCs4NGVFeU10TjRwaHllV0EwUno4L0RxdTR6R0w5?=
 =?utf-8?B?VkRTYlVjL2grUGxTdDRSb2I5aE9rVjlBVHQ3QmllUlVPSG1HbzJ6TGJLdlJ0?=
 =?utf-8?B?Y09NRmZZenRpdzlQL0NLMWxVOXJBdVM5cGpickk2WHF2Rmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N21ZQnJXYXo1ZjFQY0huczRsZlB4UWtkU1VoQmltVVRINDRzU0w4RGhRbHMy?=
 =?utf-8?B?cUhLVnJvQmhYQXR3aU5pbW9GYkdXelZQZGh6aldKakg5TElxaWxBRzRDUzBx?=
 =?utf-8?B?OElEdFl4eEhnKytyd3lQLy9Fckxvc2Q3Y1VJcUc3T215Q05jMFdnU0pjeTcx?=
 =?utf-8?B?c0lSWTNKeTFIRXZGbFhEd1Nyckk5TlhyREVxdk12N1lqdmQ5NS9MN0xBZUNJ?=
 =?utf-8?B?OTVzUno4am1qcDdZUnl1YzN1Z3k4dE1zR1lJTXU2cGQ5Y1Y0dHd1d2IzUE5F?=
 =?utf-8?B?cTJpZTI3azlhTHZOL0I0cGFBQitVZWZiQytvK0VtWHF3NXB4T0czZXNMdnhy?=
 =?utf-8?B?VFJpQ1huQmFtazBWWVhCMkR1bStITnBsMnN6NjdWS3RQSU9NTU9ad1Bnd3FG?=
 =?utf-8?B?Sjc0L051WFg2YWJHTHZIM0pqUXJNRGFjbWdaeUsxbjhOZllpM0JaMHNsZ3J6?=
 =?utf-8?B?Zk9pTG8ySHgyVllKM1pRREdOUXNQd2czVHJqdDJaK05TN1RXM2RzMmExRlcr?=
 =?utf-8?B?YWhzS3ZjeHYwMWlWUlVUcWQrTGZCM0d6SzVLVTJCa1BOb0lQUFZnRmJOd25p?=
 =?utf-8?B?U3FlMWJZdzVOYzJ0TEpmL0tqYW1vb1dZT3BKTUlyYlVSbXRWQXJScEVhRHNR?=
 =?utf-8?B?WWxNcEJzNmF3QnVIdW5zYndpblZsSzJYTGd1ek5JSUlkNXR2ZG9Sa3RMRDE1?=
 =?utf-8?B?SkVwVTNSRUY3L2M3TUptKzM4U1pNSEM3MmxkRkp5QmVySW9xUEtncm1lbkx6?=
 =?utf-8?B?WU5DQU93T0JsWUlDN0czeUtoUUNsRzZYbmk4WTh1SHhPMzdVOWNINXZuMnBE?=
 =?utf-8?B?Yis2Y01TanY0eDdHckpEMitLM012YXlMWG5qVWxVUDI4RmZSaVkwMGlyWnl4?=
 =?utf-8?B?OUlGVFRqRndMRTZ1MmlQY1NXRTdJWkJoejZOTG1UWkIxdmpRSEtvZUhnblVt?=
 =?utf-8?B?M2xWdzRJa3VuN2svUm91b2ZRS2hoaml5eWh2d1Q5SDJBL0piRjZqTE9lVVlD?=
 =?utf-8?B?Z0djRzlJM24vdlp6YjRpeXhGcU1MSTJ3NG90a3RIeWRrd0doaWJvWm1TWkZ2?=
 =?utf-8?B?eWg1a05OczBDUGFjZ1k0cnc5S2hZcFNvS1hTOWV3SVBVM3pJb1hoakowL1h6?=
 =?utf-8?B?MFlqWENMNkcxOU4rNDdjNVdkMlNldlBxNWEvNEhTZDM3VGVMSksxenlHY1I0?=
 =?utf-8?B?NW9NRHFjSEdkV3hSMHFYc2Rnak9obnZaVzNCNWY0cnFjMmEwdHI4NVM2bzJw?=
 =?utf-8?B?dUt4NlNJYXI1U2MyNCtWRVJKUjYxOUQ0ZHQ1NkRnRlZGQVA5VmNmVXFjK0V4?=
 =?utf-8?B?VGR3LzRrMzVtWG5oV3NKdmcwWSt0cFNUenpoMTlXUWJnVWRvVHJ0MHZUM2dO?=
 =?utf-8?B?Y3ZLVVFLNTJvM2YwZ1FvaFhDTmtoSEdvWURkQjVrOGg4Tk9ONnlHRDFKTEEx?=
 =?utf-8?B?TDcxLzlzT3U1cWFTU1V0TFNObHdsWERtSWJDZXlXOXgrQ1RQMDllQjZ1Y2NP?=
 =?utf-8?B?c1ZzZFo4dWY0UDdZU2JJcEdrTmxHUmFtek5aeWlsZ01HWTh6N0JYcllzOUs5?=
 =?utf-8?B?MDUzTm1aR1BZMkoxRDJZWVorKzk1bXJzN1Y2ZklYNjlFVXRWbEdvZTUxNSs4?=
 =?utf-8?B?MDcvSVowLzlkMzZGeFBMYm83ZjFKY3JxSlZNa1daSVdlY3dxVlJNTExqbzFt?=
 =?utf-8?B?Z21nVGRwL0d5dGNWbGEzTGFrWEc3SXVjSUZoSTVoNDVaMVgxNzRSZGxaS0tQ?=
 =?utf-8?B?UWdiMUgyeWRGOVVRWDdSbGFJQ0NFRkZrb2MvdDZobTNGSXQ0MnRMdmtqSkNl?=
 =?utf-8?B?SFZDcGM1QXBUUmlIVDJNcDJiWXQzazFMZUVYa1FNeWxqSEhLL1JtMzVLcllT?=
 =?utf-8?B?UDZHaUlEMExVMmtpZkUrRk5xdkMxY0hwVzE5OEFHUTZvTWpzSmV3d0FhQ3dx?=
 =?utf-8?B?QmVJaE1LYkF6RFNxaExqcWRpSkhqRGUzY3JXNzU1MXM3eXJKZGp6ZWhWSFY5?=
 =?utf-8?B?K254ZzZ2V3U3b28weGU1SVdwaXZndERicVBQQU0vbTJWUkZOS3RsS3g4UE15?=
 =?utf-8?B?eVZMd3U4MDR1MHdaa1NLZktZRFV3bkdWYW4wYTBZM2JmNmYxU1ZqN1Y0L2ZG?=
 =?utf-8?B?MkloSitETHN1RmR6UUNEeXdmVFdQMm5YZGowTXdFcXE0L0Z4UFgxK3lpa1RC?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb73a6c-5e7b-45c8-bbc4-08dccb303865
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:18:34.4465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nA4ULZCivVyEbBd8szvvxGvZ6T11AnHOZtq6g/+Pvsh2nYR3yNFNL2sSBh2dt0UISjtZd6CMEFUdzMFMzSqu5OXRI+9oUP/BKdtweDM9w6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7220

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBNb25kYXksIFNl
cHRlbWJlciAyLCAyMDI0IDEwOjE0IEFNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTZdIEFk
ZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DDQo+IA0KPiAN
Cj4gDQo+IE9uIDAyLjA5LjIwMjQgMTE6NTMsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhpIENsYXVk
aXUsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogY2xh
dWRpdSBiZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4gU2VudDogTW9uZGF5
LCBTZXB0ZW1iZXIgMiwgMjAyNCA5OjQ3IEFNDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAv
MTZdIEFkZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcw0KPiA+PiBSWi9HM1Mg
U29DDQo+ID4+DQo+ID4+IEhpLCBCaWp1LA0KPiA+Pg0KPiA+PiBPbiAwMi4wOS4yMDI0IDEwOjU0
LCBCaWp1IERhcyB3cm90ZToNCj4gPj4+IEhpIENsYXVkaXUsDQo+ID4+Pg0KPiA+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogQmlqdSBEYXMNCj4gPj4+PiBTZW50
OiBTYXR1cmRheSwgQXVndXN0IDMxLCAyMDI0IDY6MTQgQU0NCj4gPj4+PiBTdWJqZWN0OiBSRTog
W1BBVENIIDAwLzE2XSBBZGQgaW5pdGlhbCBVU0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMNCj4g
Pj4+PiBSWi9HM1MgU29DDQo+ID4+Pj4NCj4gPj4+PiBIaSBDbGF1ZGl1LA0KPiA+Pj4+DQo+ID4+
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+IEZyb206IGNsYXVkaXUgYmV6
bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+Pj4+IFNlbnQ6IEZyaWRheSwgQXVn
dXN0IDMwLCAyMDI0IDk6MjMgQU0NCj4gPj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xNl0g
QWRkIGluaXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2FzDQo+ID4+Pj4+IFJaL0czUyBT
b0MNCj4gPj4+Pj4NCj4gPj4+Pj4gSGksIFVsZiwNCj4gPj4+Pj4NCj4gPj4+Pj4gT24gMjkuMDgu
MjAyNCAxODoyNiwgVWxmIEhhbnNzb24gd3JvdGU6DQo+ID4+Pj4+PiBPbiBUaHUsIDIyIEF1ZyAy
MDI0IGF0IDE3OjI4LCBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+IHdyb3RlOg0K
PiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
LnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gSGksDQo+ID4+Pj4+Pj4N
Cj4gPj4+Pj4+PiBTZXJpZXMgYWRkcyBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNh
cyBSWi9HM1MgU29DLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gU2VyaWVzIGlzIHNwbGl0IGFzIGZv
bGxvd3M6DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiAtIHBhdGNoIDAxLzE2ICAgICAgICAgICAtIGFk
ZCBjbG9jayByZXNldCBhbmQgcG93ZXIgZG9tYWluIHN1cHBvcnQgZm9yIFVTQg0KPiA+Pj4+Pj4+
IC0gcGF0Y2ggMDItMDQvMTYgICAgICAgIC0gYWRkIHJlc2V0IGNvbnRyb2wgc3VwcG9ydCBmb3Ig
YSBVU0Igc2lnbmFsDQo+ID4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICB0aGF0IG5l
ZWQgdG8gYmUgY29udHJvbGxlZCBiZWZvcmUvYWZ0ZXINCj4gPj4+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHRoZSBwb3dlciB0byBVU0IgYXJlYSBpcyB0dXJuZWQgb24vb2ZmLg0KPiA+
Pj4+Pj4+DQo+ID4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBQaGlsaXBwLCBVbGYs
IEdlZXJ0LCBhbGwsDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEkgZGV0YWlsZWQgbXkgYXBwcm9hY2ggZm9yIHRoaXMgaW4gcGF0Y2gNCj4gPj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDA0LzE2LCBwbGVhc2UgaGF2ZSBhIGxvb2sgYW5kIGxl
dCBtZSBrbm93DQo+ID4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICB5b3VyIGlucHV0
Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEkgaGF2ZSBsb29rZWQgYnJpZWZseS4gWW91ciBzdWdnZXN0
ZWQgYXBwcm9hY2ggbWF5IHdvcmssIGJ1dCBJDQo+ID4+Pj4+PiBoYXZlIGEgZmV3IHRob3VnaHRz
LCBzZWUgYmVsb3cuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3Rs
eSwgaXQgaXMgdGhlIGNvbnN1bWVyIGRyaXZlciBmb3IgdGhlDQo+ID4+Pj4+PiBkZXZpY2UgdGhh
dCBpcyBhdHRhY2hlZCB0byB0aGUgVVNCIHBvd2VyIGRvbWFpbiB0aGF0IGJlY29tZXMNCj4gPj4+
Pj4+IHJlc3BvbnNpYmxlIGZvciBhc3NlcnRpbmcvZGUtYXNzZXJ0aW5nIHRoaXMgbmV3IHNpZ25h
bC4gUmlnaHQ/DQo+ID4+Pj4+DQo+ID4+Pj4+IFJpZ2h0IQ0KPiA+Pj4+Pg0KPiA+Pj4+Pj4NCj4g
Pj4+Pj4+IEluIHRoaXMgcmVnYXJkLCBwbGVhc2Ugbm90ZSB0aGF0IHRoZSBjb25zdW1lciBkcml2
ZXIgZG9lc24ndA0KPiA+Pj4+Pj4gcmVhbGx5IGtub3cgd2hlbiB0aGUgcG93ZXIgZG9tYWluIHJl
YWxseSBnZXRzIHBvd2VyZWQtb24vb2ZmLg0KPiA+Pj4+Pj4gQ2FsbGluZw0KPiA+Pj4+Pj4gcG1f
cnVudGltZV9nZXR8cHV0KigpIGlzIGRlYWxpbmcgd2l0aCB0aGUgcmVmZXJlbmNlIGNvdW50aW5n
LiBGb3INCj4gPj4+Pj4+IGV4YW1wbGUsIGEgY2FsbCB0byBwbV9ydW50aW1lX2dldCooKSBqdXN0
IG1ha2VzIHN1cmUgdGhhdCB0aGUgUE0NCj4gPj4+Pj4+IGRvbWFpbiBnZXRzLW9yLXJlbWFpbnMg
cG93ZXJlZC1vbi4gQ291bGQgdGhpcyBiZSBhIHByb2JsZW0gZnJvbQ0KPiA+Pj4+Pj4gdGhlIHJl
c2V0LXNpZ25hbCBwb2ludCBvZiB2aWV3Pw0KPiA+Pj4+Pg0KPiA+Pj4+PiBJdCBzaG91bGQgYmUg
c2FmZS4gRnJvbSB0aGUgSFcgbWFudWFsIEkgdW5kZXJzdGFuZCB0aGUgaGFyZHdhcmUNCj4gPj4+
Pj4gYmxvY2sgaXMgc29tZXRoaW5nIGxpa2UgdGhlDQo+ID4+Pj4gZm9sbG93aW5nOg0KPiA+Pj4+
Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiAgICAgICAgICAgICAgICAgICBVU0IgYXJlYQ0KPiA+Pj4+PiAg
ICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPj4+Pj4gICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4+Pj4+ICAgICAgICAgIHwgUEhZIC0tLT5VU0Ig
Y29udHJvbGxlciAgfA0KPiA+Pj4+PiBTWVNDIC0tPiB8ICBeICAgICAgICAgICAgICAgICAgICAg
IHwNCj4gPj4+Pj4gICAgICAgICAgfCAgfCAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4+Pj4+
ICAgICAgICAgIHwgUEhZIHJlc2V0ICAgICAgICAgICAgICAgfA0KPiA+Pj4+PiAgICAgICAgICAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPj4+Pg0KPiA+Pj4+IEhvdyBVU0IgUFdSUkRZ
IHNpZ25hbCBpcyBjb25uZWN0ZWQgdG8gVVNCPw0KPiA+Pj4+DQo+ID4+Pj4gVVNCIGJsb2NrIGNv
bnNpc3RzIG9mIFBIWSBjb250cm9sLCBQSFksIFVTQiBIT1NUIGFuZCBVU0IgT1RHIENvbnRyb2xs
ZXIgSVBzLg0KPiA+Pj4+DQo+ID4+Pj4gSXMgaXQgY29ubmVjdGVkIHRvIHRvcCBsZXZlbCBibG9j
ayBvciBjb25uZWN0ZWQgdG8gZWFjaCBJUCdzIGZvciB0dXJuaW5nIG9mZiB0aGUgVVNCIHJlZ2lv
bg0KPiBwb3dlcj8NCj4gPj4+Pg0KPiA+Pj4+ID8gT3IgSnVzdCBQSFkgKEhXIG1hbnVhbCBtZW50
aW9ucyBmb3IgQVdPLCB0aGUgVVNCIFBXUlJEWSBzaWduYWwtPlVTQiBQSFkgUFdSUkRZIHNpZ25h
bCBjb250cm9sKT8NCj4gPj4+DQo+ID4+PiBBcyBwZXIgdGhlIHVwZGF0ZSBmcm9tIEhXIHRlYW0s
DQo+ID4+Pg0KPiA+Pj4gIlNZU19VU0JfUFdSUkRZIGFuZCBTWVNfUENJRV9SU1RfUlNNX0IgYXJl
IHVzZWQgd2hlbiB0cmFuc2l0aW9uIGZyb20NCj4gPj4+IEFMTF9PTiB0byBBV08gKG9yIGZyb20g
QVdPIHRvDQo+ID4+IEFMTF9PTikuDQo+ID4+Pg0KPiA+Pj4gUmVmZXIgdG8gc3RlcCA4LDkgaW4g
VGFibGUgNDEuMTAgRXhhbXBsZSBUcmFuc2l0aW9uIEZsb3cgT3V0bGluZSBmcm9tIEFMTF9PTiBN
b2RlIHRvIEFXTyBNb2RlLg0KPiA+Pj4gUmVmZXIgdG8gc3RlcCA5LDEwIGluIFRhYmxlIDQxLjEx
IEV4YW1wbGUgVHJhbnNpdGlvbiBGbG93IE91dGxpbmUgZnJvbSBBV08gTW9kZSB0byBBTExfT04g
TW9kZS4NCj4gPj4NCj4gPj4gQWxsIHRoaXMgaXMgbm90IG5ldyBpbmZvcm1hdGlvbi4NCj4gPj4N
Cj4gPj4gRnJvbSBleHBlcmltZW50cywgd2UgbmVlZCB0byBjb250cm9sIHRoZXNlIHNpZ25hbHMg
YWxzbyB3aGVuIGJvb3RpbmcNCj4gPj4gYXMgaW50ZXJtZWRpYXJ5IGJvb3RpbmcgYXBwbGljYXRp
b24gbWF5IGNvbnRyb2wgYW5kIGxlYXZlIGl0IGluDQo+ID4+IGltcHJvcGVyIHN0YXRlLiBXL28g
aGF2aW5nIFNZU0Mgc2lnbmFscyBjb25maWd1cmVkIHByb3Blcmx5IHRoZXJlIGlzIG5vIGNoYW5j
ZSBmb3IgVVNCIHRvIHdvcmsgKGl0DQo+IHNob3VsZCBiZSB0aGUgc2FtZSBmb3IgUENJZSBidXQg
SSBoYXZlbid0IGV4cGxvcmVkIGl0IHlldCkuDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gV2hlbiB0dXJu
aW5nIG9mZiBVU0IgUEhZIGFuZCBQQ0llIFBIWSwgaWYgdGhleSBhcmUgbm90IGNvbnRyb2xsZWQs
IFBIWSBtYXkgYnJlYWsuIg0KPiA+Pg0KPiA+PiBGcm9tIGV4cGVyaW1lbnRzLCBJIGtub3cgdGhp
cywgYXMgdGhpcyBpcyB0aGUgcmVhc29uIHRoZSBTWVNDIFVTQg0KPiA+PiBQV1JSRFkgaGFzIGJl
ZW4gaW1wbGVtZW50ZWQgaW4gTGludXggYW5kIHByb3Bvc2VkIGluIHRoaXMgc2VyaWVzLg0KPiA+
DQo+ID4gWW91IG1lYW4geW91IGNhbGwgcmVzZXQgYXNzZXJ0IGZvciBVU0IgUFdSUkRZIHNpZ25h
bCBmb3Igc3lzdGVtIHRyYW5zaXRpb24gKEFXTyBNb2RlIHRvIEFMTF9PTg0KPiBNb2RlKT8/DQo+
IA0KPiByZXNldCBhc3NlcnQgb24gc3VzcGVuZCwgcmVzZXQgZGUtYXNzZXJ0IG9uIHJlc3VtZS4N
Cj4gDQo+IEFuZCBwbV9ydW50aW1lX3B1dCgpL3BtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSBv
biB0aGUgdmVyc2lvbiB3aGVyZSBVU0IgUEhZUkRZIGlzIHByb3ZpZGVkIGJ5IFNZU0MNCj4gYXMg
YSBQTSBkb21haW4uIEFzIEkgbWVudGlvbmVkIGluIHRoZSB0aHJlYWQgd2l0aCBVbGYsIHRoaXMg
aXMgc29tZXRoaW5nIEkgZXhwbG9yZWQgbG9jYWxseS4NCj4gDQo+IEFsbCB0aGVzZSBhcmUgaW50
ZXJuYWwsIG5vdCBwdWJsaXNoZWQgaW4gdGhpcyB2ZXJzaW9uLiBUaGlzIHZlcnNpb24ganVzdCBh
ZGRzIGluaXRpYWwgYnJpbmctdXANCj4gc3VwcG9ydC4NCj4gDQo+ID4NCj4gPg0KPiA+DQo+ID4+
Pg0KPiA+Pj4gRG8geW91IGhhdmUgYW55IHBsYW4gdG8gY29udHJvbCB0aGlzIHBvd2VyIHRyYW5z
aXRpb25zKEFMTF9PTiB0byBBV08gYW5kIHZpY2UgdmVyc2EpIGluIGxpbnV4Pw0KPiA+Pg0KPiA+
PiBBcyB5b3Uga25vdywgdGhlIFJaL0czUyBVU0IgUE0gY29kZSBpcyBhbHJlYWR5IHByZXBhcmVk
LiBUaGlzIGlzIGFsc28NCj4gPj4gY29uZmlndXJpbmcgdGhlc2Ugc2lnbmFscyB3aGVuIGdvaW5n
IHRvIHN1c3BlbmQvZXhpdGluZyBmcm9tIHJlc3VtZS4NCj4gPj4gVy9vIGNvbmZpZ3VyaW5nIHBy
b3Blcmx5IHRoZXNlIHNpZ25hbHMgdGhlIFVTQiBpcyBub3Qgd29ya2luZyBhZnRlciBhIHN1c3Bl
bmQvcmVzdW1lIGN5Y2xlLg0KPiA+DQo+ID4gT25lIG9wdGlvbiBpcyB0byBoYW5kbGUgU1lTQyBV
U0IgUFdSUkRZIHNpZ25hbCBpbiBURi1BLCBpZiB5b3UgcGxhbiB0byBoYW5kbGUgc3lzdGVtIHRy
YW5zaXRpb25zDQo+IHRoZXJlPz8NCj4gDQo+IEFzIEkgbWVudGlvbmVkLCB0aGUgc2V0dGluZ3Mg
aW4gdGhlc2UgcmVnaXN0ZXJzIG1heSBiZSBjaGFuZ2VkIGJ5IGludGVybWVkaWFyeSBib290aW5n
IGFwcGxpY2F0aW9ucy4NCj4gRGVwZW5kaW5nIG9uIHRoYXQsIExpbnV4IG5lZWQgdG8gY29udHJv
bCBpdCBhbHNvIG9uIHByb2JlIGZvciBVU0IgdG8gd29yayAoaXQgc2hvdWxkIGJlIHRoZSBzYW1l
IHdpdGgNCj4gUENJZSwgdGhlc2Ugc2lnbmFscyBzZWVtcyBzaW1pbGFyIGZyb20gSFcgbWFudWFs
IGRlc2NyaXB0aW9uKS4NCg0KWW91IG1lYW4gc3lzdGVtIHRyYW5zaXRpb24gc2V0dGluZ3Mgd2ls
bCBiZSBvdmVycmlkZSBieSBVLWJvb3QsIHNvIExpbnV4IG5lZWRzIHRvIHJlc3RvcmUgaXQgYmFj
az8/DQoNCkNoZWVycywNCkJpanUNCg==

