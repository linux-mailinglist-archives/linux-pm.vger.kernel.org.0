Return-Path: <linux-pm+bounces-13337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D83968540
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 12:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEDEB26FCE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9811D1F44;
	Mon,  2 Sep 2024 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UwjwtYg0"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010065.outbound.protection.outlook.com [52.101.229.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307C17C7C3;
	Mon,  2 Sep 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274080; cv=fail; b=Lb23TaRlcHL8AqO8YcnKt5IXtpWDTGoIue3aN0TKlO4Vd4UBLYcMrtdwAR3sYo/flZQdXjobhJQgj0vFNcyl6PDeL9JzsuOtEIfh0gFVaPg8iZcA2zJ85blqFodEWX8ixPKHthpdUv1rfQuus1kbYjsK3ZJ7gzIOFHk9XSLGU8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274080; c=relaxed/simple;
	bh=oUExOcXEmynL6jpn8PmXBpgXUD8IziRIUmGl4vJTJrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qjw48Y3vBUlPsP5qHsPHnJNmyGad4Eki/2eDv1G8exLPbLeOVdrss8ffsKYLMNzVfTP+gzo6ILWXiNvIIaYlu1gfjWKE/rfOTTbK2kWOGp/ChqmUyTTgPuE/0ZEdGnjV+P7ZPgFtlfdpjIE96S2IuQz3RqwzIfL60412iuZ/jQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UwjwtYg0; arc=fail smtp.client-ip=52.101.229.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6ngAG2YX+W2+54RzIgeYBqlZZZnjUZ6MhtWDueY8eSX/gp3dbGOaxgdBzoQ6O8KvnM2S2jJd4MUeohhKf4Ko79OrZ4+zrYxpVt02D5jNcuaCZ1CV9Y4CdPJwpxyOvO54VE7nq9V98xtoppyCuX42rLijH2QHLuuMxJDmjyV9aBPj5FGEZU79PjnCgx/sl9dc7IR8VzsWKabLXCbz3rjlnDW8QB9wFcej2bHswJuWfHNE/wQDYikfVvZJ0yaJflBJVVVgngIdHKJ41cFOx0AE8T3mBMM35hs1yLMOVb1BaEBCKlvvsblGgo3HdUr+xW22HqIzeW3zcC3bTbto1JMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUExOcXEmynL6jpn8PmXBpgXUD8IziRIUmGl4vJTJrw=;
 b=MmbUo8JpB+A3byQrTIdJm4cLfjYN+ckvdEDV+etlCVMC3l67EHhtWR39hd/OjCnZjitLfTbWTBZXMA/s1cOtgcegXueTlKy+CRlO0MF/vnjRm/D6ySjLdTaKsD/bis1bCPwpFm+jS9pO6qOMu8qfc+byk4EprANHC1UEhk5nMFdfakAwS4x0t3OYoD7cGEAJOfepFr8QFd0gYGC9TZBDFpdemAMB/W/zcAPAs8AtBj8VhAAvxca7YxMUIHdh1FxdHF34cbeHmnhrQx5v8rAxbH2gFAQIA2XKvVY540Pr2s/zOyBbzVBl9T/jfWEkcVeZrRwmg2rEvsUqduwWorxz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUExOcXEmynL6jpn8PmXBpgXUD8IziRIUmGl4vJTJrw=;
 b=UwjwtYg0Wfncasrab0BH1BbUqBG7zaRoeitEs/oQ1nZG3h1lq0ASfHQq7Sme1gTZeE3YBYkhZGth1TgXENaPR9ht5RsULy7MGRzjTkwHM3qchf4+tYPRwsO3rW82sfG9e85rcB/9kz7ZHv+70oyrP7laW2WFq7tSFuPA8uL5nu4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB9496.jpnprd01.prod.outlook.com (2603:1096:604:1cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:47:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:47:50 +0000
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
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkCAABeagIAAAFcw
Date: Mon, 2 Sep 2024 10:47:50 +0000
Message-ID:
 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
 <TY3PR01MB113464D53083F4C8A5DBBA36586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <590a4fb2-24b2-432b-92db-534c5a52ed0b@tuxon.dev>
 <TY3PR01MB11346505565B81AD2894E035586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
In-Reply-To: <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB9496:EE_
x-ms-office365-filtering-correlation-id: 655d0a62-8584-4d1e-d956-08dccb3cb0e7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlN2RWR0R1B6SXhoWjNVUjZFaG56Mm1DYjkzUmRWT0pUam12bkFUT2F4WXk1?=
 =?utf-8?B?TTEvdVZFaUluREV2aU1JYWQ2clptdk91R1JuQzV1MTg3ZklaaVk2VDlvNDVT?=
 =?utf-8?B?TjgzMXNSVmk4OEx0bXJFK1FKZld3eW1jdWt2ZWdmUXAvS3ljbVZBbzFCb0xu?=
 =?utf-8?B?N3M3TkNJRC9aVkxNTm1oMWorWUpBMWMwSTdUZkViNUcwSklVL1UvN052K1RV?=
 =?utf-8?B?U09CYlE4ZmdZbGpQOFZSQTJDNHpDSHhEUFlLZWlWeGNQT0Zoem1QcVFhMnNx?=
 =?utf-8?B?d0pQRjRBZ1Q2K1V6WVhTL1lYMitQTEpkRFJkOEthN1RoNUFjS0x2Z2pTMXIz?=
 =?utf-8?B?U0hiYlhuT3VJVW5sbk9EeklodTlmcjlCdTd2N0Y0QUUyNGFvRDhUb2l5RUVG?=
 =?utf-8?B?ODN5bkJVdnc2VHpYbEh0ckZFR0RFbDIvakhWWFRtZ0svbHhFSkRZMEdzK3A0?=
 =?utf-8?B?aW44Y1g0bEI3MVBMRHYxRjltSERRQ05ZcnVQbFk4a1BzS29ndU95MWJWVjRG?=
 =?utf-8?B?TGh4dno3VFVwamdjVjVNb0hqb1QrVmRGZ01CQVkxeFF0bFJDUXRiTFowenM2?=
 =?utf-8?B?OUJ4REJ6ZFhOTElwVU1McFRPbnovZWs2RG5ESW4xNE5JaDFreGRhN1ZhdDNa?=
 =?utf-8?B?cEZEVmg0L1dQUnJhSWZ2VzkwL1VLSytVVDV4bmFVV2JHRHBsenF4N1IweWpr?=
 =?utf-8?B?ZDhTRzNWbXh5TnIybEdZd3IxbTN2Qm1XTzlJN25PWWs3RlpNMWFkaS9MWm5m?=
 =?utf-8?B?YnVwSHROOGZUQkh5ejFuSHQvRllpMGhUMU1PTHZQOWY1VTBINkJWM2RqRXVI?=
 =?utf-8?B?SWt5UmdNNkhQbmFROGNJUDNGbUlOVlV5YXk1dEwrWnp3UVBLNXF4K20wUXFU?=
 =?utf-8?B?TFdsOWFPeVd1SlRZUWJYNUdIa292SFZXWG9NVGQ0aFd5L0ZoLzlJZmxWZGly?=
 =?utf-8?B?RmU0RnlwMm9IdXU4S0xpaFVHd1dNc2dycnQyUHFFN091eGNWYzRlYWFGazBI?=
 =?utf-8?B?cE11RUd4UDVXYkl0dTZsYnN1SmRrV05xVlRTYUZjK1I2RjN3cW9FQXpWM0ho?=
 =?utf-8?B?alJiVnc1cXZQMzFiL2IyTVloRFl1RUswc0QwRU1NRzR4S2xwVVZxZ0pPVGk1?=
 =?utf-8?B?WGRSTHp3REZJdmVUMHoyRng5blRsenhBd1VvZnE2R0tjOFYva0NFckZmeHE1?=
 =?utf-8?B?RzBPWVVEU0NIaXQwdU5UdlIwQ290emFBeFdiUkdDeEI3aWhvU1YrU1NLUUgv?=
 =?utf-8?B?c0hnREN1QjVraGxJL3BROG5hSGdqWTdIQTBjbnRyV0ZNQ3gzUWE4Z0hwZldk?=
 =?utf-8?B?RjRoVzE4ZUFzaWlTcTV2MEJPNWFROU5CczVYYlNjMFVlRGwxUWppQ1VTVVYv?=
 =?utf-8?B?TDhkU05jZ3JtK0lUanE0Tmd0MG5UQ2tRTlZjR0p1Yk5QZW9rNkY2Y25IamRu?=
 =?utf-8?B?N3JwS3hjcUx3U0xxcGNjTytlR0owd1NFb2hDVUYzVU5vRk5SbnN3WTZTRUpa?=
 =?utf-8?B?bnl0Wmt6UTBqRHdTVlN4RHFKNEdyd0V6cDVKbmVyblVDZ1U4aU5ZZUQ0cTJV?=
 =?utf-8?B?UGlxbGVac1pHdnArdVNLVkFFRWgrS0JkdUY1czNGblJrajdCaUs4NEJqMDRZ?=
 =?utf-8?B?d2tyLzNnN2RJQ1FLc3JlLzRGVnNoTUNoZFpoaExSZDVKUHppVWJNR0hPeVFP?=
 =?utf-8?B?SGNOdU9ZSlhzVFFBWTMxTFpTS3k0aGpKL3d1ZG1UL3A5MVBlUFBoSDRHUEdT?=
 =?utf-8?B?dHRyM0cxTmxJdWo2ZE5RakpRU3RxNG15dmxOeU9qMnlJcGRaTXExdTIwZWRU?=
 =?utf-8?B?UGZsUS9PL01VZUVJQXNJYkZlY2pCdEhUY012OWdVSmFIQkovZGlEbmgvRVZs?=
 =?utf-8?B?emVzcXlvVG5WRndsay9ORTVnSmk2OTFTYm9YRFRuZEJCd0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3UrVEdBckkvOVVFYmt1VTN6UUJNbWxlV0NZVVZGL3VRQXBIMmFvRFhEdVFm?=
 =?utf-8?B?Smtya29vUG4vZjhwM3U1ak16QnJ1aHQvdnIxOWlkdVhwVXM2M0tNc3U3aURz?=
 =?utf-8?B?R09lc01Jd09vMkIvZFBVZUdKUzhhdTF0M0hCMDl5Zk1IeUUvTzlpUlFDeWl6?=
 =?utf-8?B?WG44WmloWlViM204TW5tMXQ3blF1RytLRm5CK1N4YUE0N2kwT3lwSGlkWTVh?=
 =?utf-8?B?VDk5bXNvQ3FrQmhudUN0dEp1aWFBYUdaVy8zVG55RFBWQVMvMlkwVEtVTUxz?=
 =?utf-8?B?dUFUR0dQODFtczl2RFBnS0JsSTJ0RFM2cDI2enE1U01pNjBEU1FOd0Jvb25p?=
 =?utf-8?B?dGNQWVNUajVWK2hDTFE4b21SRGFZcUtDOTRUUkw5ZkZkRUVPNDFGT3QvL1RH?=
 =?utf-8?B?cS95SXd3aVZZdU9rbVBZUDNoR0pwbGwwbWowOFBtdlgzQUJkeGlselN0TmlG?=
 =?utf-8?B?TThVN01ZVVF4SWNMWk5hekdmYzJyZGxmbklxbngrR3YvRld6NVJ4cWdHbEZ1?=
 =?utf-8?B?a0FVcHdiUjRpQ1VLcjl3Y0xaaStBV0p1bmY2amVjbnNpMWtQZTlvRkd3Z2Jk?=
 =?utf-8?B?UWk5MVhvQUtMSDZFMDdQY1ZCYWJXQzVvRk1LcEZZb0dlOVVrZXdCOHZoRkNG?=
 =?utf-8?B?ZjdOejlWZWhUNHM5eE9MdW9pSWh3aFBoRW05ZmFZajVUSXFvSzhESDJrMWs3?=
 =?utf-8?B?Q0R3ZitDWnZYYW9WanZlRm15TmxWRGkxZnk2RCs2VnlNVEpkZjhCNVJrTlBw?=
 =?utf-8?B?M3RiZW5jb3Iyb3dZQW1jNHdhcG1YbHZlamNENS9reEFSMGEvS2h5b0J2cnBD?=
 =?utf-8?B?eFFlNmN0SGQyMmlNM0VaN2Q0MjFZMTBHR3FlQ1FORGpkMkdZZitOSGJlaS8w?=
 =?utf-8?B?VkRCYzkrc1diN1BibURzdUNlRGxlYlVLdk9aTlhhZEh4M21lNllwOEtCM0kr?=
 =?utf-8?B?aUx4ckpwODMzVm95aHJ0M1dLeVNXLzZoeHVpZVZKb3I0V0pENXY4ZXNqRWhm?=
 =?utf-8?B?cEpwcDdtM3BIRERwSzh1RW1zM2lHTFdIWXBmSm1iMk1hLzNPSmlpbC9xWDhC?=
 =?utf-8?B?YkgzbWhpZXRrK1pIYzhHMFVVVTRwaC9DV2RWYU5vdHdHZ3dkWkRXZUhDRjNp?=
 =?utf-8?B?VVpJd1QxazRiNSt2bmkwSlVYVHNlZzJWM0MyMHRkQkFFbmxuSk81MlZ5NCts?=
 =?utf-8?B?TEs4UUNKcGYvR2VqSkJxVFF5VjNybVdBM2Q3UjFpa0lFM3ZUeUhGbC93ckND?=
 =?utf-8?B?MHdqdTE2TnhvYmlFRHhjRjNIY3VMd25hT01oL2NDODRjVjY0TlZMU3FoSXpH?=
 =?utf-8?B?OUZUdHRURlFJb3FORjdkMlNvM242d0hCN3hia3pXaW9YcU5HdTMvTjlqYktl?=
 =?utf-8?B?ZTRqUUFCV2FWVE1hNnk0eXExOXFZWGE0YldWdG9rdU5JdEpNUFJreklFZWpZ?=
 =?utf-8?B?dzZmdDVmOGp3Mk1xcmtPSXMvbzhTOSt2eWNKZG9oNkFlbmFCQlpTelJWaC9k?=
 =?utf-8?B?TEhYekpNdVBKcDN6SjhGQzE2QUppYXFUc1BnUy96NUlpYi8wUU9JT2Q1V0hn?=
 =?utf-8?B?UXZYNEhKQ0lHZ1o2RXZZSzk1Mlc2cTZaenptRHdLSi91WVZSYjFXZXQ4TGUv?=
 =?utf-8?B?bHAwRnVUY2FXak9CRGYrQXUwZGNYcld3Q2F6MnozeTNML0lmMXQzdXNaZUJF?=
 =?utf-8?B?SS9HeWxEbXYzUHVmV0FmNUV0UGtTZUNuNU1UdThhcjNOMkNLMHBWQUhKeWM5?=
 =?utf-8?B?bFNWcTNLa3JtNnl4ZnJFYVFiQzlXTnY3dnVDVjBKM2xobnRvZGVmMnRTcm40?=
 =?utf-8?B?c3l0VTBsSU9pbXppdTlRR3QzdGZtUG96NDhHYTdNTnhXZXdiY05EQXAwVW9O?=
 =?utf-8?B?MGZ1dU5udDNZd2ZyNVVPNXBDQ0Q1OGJCQ1ZQc25BTTBXMWVkcWxYZkdTRWo1?=
 =?utf-8?B?WUtRQ3VlaFd3ODJsZDFialpFOFplYU9xYUlMMTlBR3JZYWtmY3pycXMwQVZC?=
 =?utf-8?B?aWxNeUR6MTNxT1hlMGkvZW1JWGFDZmJSeFFnenc1MjlCQXBMa1ViazRMWWhV?=
 =?utf-8?B?N2RaRWdzWE42cHZqKzJwYUNJUzJ2dFdGYWducDluMDhQaml3Tk9EcUxyZnRv?=
 =?utf-8?B?MHhoMVRBTGZSSWRYV2J4QjJ4cmhHYTFxRXpiU1g5QzNJeTZHNjFRS0RaZ1Ns?=
 =?utf-8?B?WUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 655d0a62-8584-4d1e-d956-08dccb3cb0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:47:50.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GsIlTkcT3MgbXqdO8mCbrHPMfyIB+Bz9jweyTHeIRiNRtNtPjogtLeIeT41pkI90ykaXJpI57VpeupKaM7jmOmWLMIrGj9yWsdyG1SF/fa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9496

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBNb25kYXksIFNl
cHRlbWJlciAyLCAyMDI0IDExOjQxIEFNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTZdIEFk
ZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DDQo+IA0KPiAN
Cj4gDQo+IE9uIDAyLjA5LjIwMjQgMTI6MTgsIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4+PiBEbyB5
b3UgaGF2ZSBhbnkgcGxhbiB0byBjb250cm9sIHRoaXMgcG93ZXIgdHJhbnNpdGlvbnMoQUxMX09O
IHRvIEFXTyBhbmQgdmljZSB2ZXJzYSkgaW4gbGludXg/DQo+ID4+Pj4gQXMgeW91IGtub3csIHRo
ZSBSWi9HM1MgVVNCIFBNIGNvZGUgaXMgYWxyZWFkeSBwcmVwYXJlZC4gVGhpcyBpcw0KPiA+Pj4+
IGFsc28gY29uZmlndXJpbmcgdGhlc2Ugc2lnbmFscyB3aGVuIGdvaW5nIHRvIHN1c3BlbmQvZXhp
dGluZyBmcm9tIHJlc3VtZS4NCj4gPj4+PiBXL28gY29uZmlndXJpbmcgcHJvcGVybHkgdGhlc2Ug
c2lnbmFscyB0aGUgVVNCIGlzIG5vdCB3b3JraW5nIGFmdGVyIGEgc3VzcGVuZC9yZXN1bWUgY3lj
bGUuDQo+ID4+PiBPbmUgb3B0aW9uIGlzIHRvIGhhbmRsZSBTWVNDIFVTQiBQV1JSRFkgc2lnbmFs
IGluIFRGLUEsIGlmIHlvdSBwbGFuDQo+ID4+PiB0byBoYW5kbGUgc3lzdGVtIHRyYW5zaXRpb25z
DQo+ID4+IHRoZXJlPz8NCj4gPj4NCj4gPj4gQXMgSSBtZW50aW9uZWQsIHRoZSBzZXR0aW5ncyBp
biB0aGVzZSByZWdpc3RlcnMgbWF5IGJlIGNoYW5nZWQgYnkgaW50ZXJtZWRpYXJ5IGJvb3RpbmcN
Cj4gYXBwbGljYXRpb25zLg0KPiA+PiBEZXBlbmRpbmcgb24gdGhhdCwgTGludXggbmVlZCB0byBj
b250cm9sIGl0IGFsc28gb24gcHJvYmUgZm9yIFVTQiB0bw0KPiA+PiB3b3JrIChpdCBzaG91bGQg
YmUgdGhlIHNhbWUgd2l0aCBQQ0llLCB0aGVzZSBzaWduYWxzIHNlZW1zIHNpbWlsYXIgZnJvbSBI
VyBtYW51YWwgZGVzY3JpcHRpb24pLg0KPiA+IFlvdSBtZWFuIHN5c3RlbSB0cmFuc2l0aW9uIHNl
dHRpbmdzIHdpbGwgYmUgb3ZlcnJpZGUgYnkgVS1ib290LCBzbyBMaW51eCBuZWVkcyB0byByZXN0
b3JlIGl0IGJhY2s/Pw0KPiANCj4gSXQgd2FzIHRhbGtpbmcgYWJvdXQgYm9vdGluZy4uLg0KDQpJ
IGFtIGFsc28gcmVmZXJyaW5nIHRvIGJvb3QuIEJvb3Qgc3RhcnRzIHdpdGggVEYtQSBhbmQgaXQg
aGFzIGEgc3lzdGVtIHN0YXRlLg0KDQo+IA0KPiBZb3UgcHJvcG9zZWQgdG8gaGFuZGxlIFNZU0Mg
c2lnbmFscyBmcm9tIFRGLUEgaW4gYSBkaXNjdXNzaW9uIGFib3V0IHN5c3RlbSBwb3dlciB0cmFu
c2l0aW9uczoNCj4gDQo+ICJPbmUgb3B0aW9uIGlzIHRvIGhhbmRsZSBTWVNDIFVTQiBQV1JSRFkg
c2lnbmFsIGluIFRGLUEsICBpZiB5b3UgcGxhbiB0byBoYW5kbGUgc3lzdGVtIHRyYW5zaXRpb25z
Ig0KPiANCj4gKEkgd2FzIGd1ZXNzaW5nIHRoZSAic3lzdGVtIHRyYW5zaXRpb24iIHN0YXRlbWVu
dCB0aGVyZSByZWZlcnMgdG8gcG93ZXIgc3RhdGVzIHRyYW5zaXRpb25zLCBBTExfT04gPC0+DQo+
IEFXTy9WQkFUKQ0KDQpUaGF0IGlzIGNvcnJlY3QuDQoNCj4gDQo+IGFuZCBJIGdhdmUgdGhlIGJv
b3RpbmcgcHJvY2VzcyBhcyBhIGNvdW50ZXIgZXhhbXBsZTogaWYgd2UgaGFuZGxlIGl0IGluIFRG
LUEgaXQgbWF5IG5vdCBiZSBlbm91Z2ggYXMNCj4gdGhlc2Ugc2lnbmFscyBtaWdodCBiZSBjaGFu
Z2VkIGJ5IGludGVybWVkaWFyeSBib290aW5nIGFwcGxpY2F0aW9ucyAoZS5nLiwgVS1Cb290KS4N
Cg0KV2h5IHNob3VsZCBVLWJvb3Qgb3ZlcnJpZGUsIHN5c3RlbSBzdGF0ZSBzaWduYWxzIHN1Y2gg
YXMgVVNCIFBXUlJFQURZPyBDYW4geW91IHBsZWFzZSBnaXZlIGFuIGV4YW1wbGUuDQoNCj4gDQo+
IFRvIGNvbmNsdWRlLCB0aGVyZSBhcmUgMyBzY2VuYXJpb3MgSSBzZWUgd2hlcmUgdGhlc2Ugc2ln
bmFscyBuZWVkIHRvIGJlDQo+IGhhbmRsZWQ6DQo+IDEvIGJvb3RpbmcgDQo+IDIvIHN1c3BlbmQg
dG8gUkFNDQo+IDMvIGRyaXZlciB1bmJpbmQvYmluZA0KDQotLT4gSXQgc2hvdWxkIGJlIE9LIGFz
IGxpbnV4IGlzIG5vdCBoYW5kbGluZyBVU0IgUFdSUkVBRFkgc2lnbmFsLg0KDQo+IA0KPiBJbiBj
YXNlIG9mIGJvb3Rpbmc6IGlmIHdlIGhhdmUgVEYtQSB0byBzZXQgc2lnbmFscyB0aGVyZSBtaWdo
dCBiZSBpbnRlcm1lZGlhcnkgYm9vdGluZyBhcHBsaWNhdGlvbnMNCj4gKGUuZy4gVS1Cb290KSB0
aGF0IHNldCB0aGVzZSBzaWduYWxzIGFsc28uIElmIGl0IGxlYXZlcyBpdCBpbiBpbXByb3BlciBz
dGF0ZSBhbmQgTGludXggd2FudHMgdG8gdXNlDQo+IFVTQiB0aGVuIHRoZSBVU0Igd2lsbCBub3Qg
d29yayAoaWYgTGludXggZG9lc24ndCBoYW5kbGUgaXQpLg0KDQpUaGF0IGlzIHRoZSBwcm9ibGVt
IG9mIFUtYm9vdC4gVS1ib290IHNob3VsZCBub3Qgb3ZlcnJpZGUgc3lzdGVtIHN0YXRlIHNpZ25h
bHMgc3VjaCBhcyBVU0IgUFdSUkVBRFkuDQoNCj4gDQo+IEluIGNhc2Ugb2Ygc3VzcGVuZCB0byBS
QU06IGFzIFRGLUEgaXMgdGhlIG9ubHkgYXBwbGljYXRpb24gaW4gdGhlIHN1c3BlbmQgdG8gUkFN
IGNoYWluLCBpdCBzaG91bGQgd29yaw0KPiBoYW5kbGluZyBpdCBpbiBURi1BLg0KDQpUaGF0IGlz
IGNvcnJlY3QsIFRGLUEgc2hvdWxkIGhhbmRsZSBiYXNlZCBvbiBzeXN0ZW0gc3RhdGUuDQoNCj4g
DQo+IEluIGNhc2Ugb2YgdW5iaW5kL2JpbmQ6IGN1cnJlbnRseSB3ZSBkb24ndCBrbm93IGlmIHRo
ZXNlIHNpZ25hbHMgaW50cm9kdWNlcyBhbnkga2luZCBvZiBwb3dlciBzYXZpbmcNCj4gc28gYXNz
ZXJ0aW5nL2RlLWFzc2VydGluZyB0aGVtIGluIExpbnV4IG1heSBiZSB1c2VmdWwgZnJvbSB0aGlz
IHBlcnNwZWN0aXZlLCBpZiBhbnkuDQoNClRoZXNlIGFyZSBzeXN0ZW0gc2lnbmFscywgYWNjb3Jk
aW5nIHRvIG1lIHNob3VsZCBub3QgYmUgdXNlZCBpbiB1bmJpbmQvYmluZC4NCg0KSSBtYXkgYmUg
d3JvbmcuDQoNCkNoZWVycywNCkJpanUNCg==

