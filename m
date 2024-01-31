Return-Path: <linux-pm+bounces-3044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A244D843D1D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 11:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52155284282
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D669D33;
	Wed, 31 Jan 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="pUgnciB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2117.outbound.protection.outlook.com [40.107.114.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063F69979;
	Wed, 31 Jan 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698055; cv=fail; b=QBSrft4SsGKJTBXOfxX+x4X13vUiek3Brpbr47w5qX/wpQfoXKYV8PmnESYoHHgpd21Xx7Dz6nxrO0mXDed4Kw6w+hwrBoJX74BXRSF30Ypad8aR3vCgyM0TyfIK3i0hE6G1+/nP9VHtzv8MUkyeS80I8xCmW7f/7xrfpJTeOkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698055; c=relaxed/simple;
	bh=PauUiCOkLuZaBpOPAn/UUbZE3M+/HWwJN4bK3L4jeys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LbskeNq+9H5mUeMi1TXo659rhFnrLxEzsy2v9TVpLXUTNHTib/KGUbTT7wTETlwMoUXqrAveJUWORXSunLNHkBsVxxHWyoiW9/UNl4f+TDudnbFjjM/dZwOLVBbdj3BdLXfT4BUjBAxd7Kkg9KC2SmovLht9EMmSuKlg8inJ3OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=pUgnciB2; arc=fail smtp.client-ip=40.107.114.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxiHE0rAA5tOn4SCjEe9V9NzuS9NjOLqSNyg2OaYYOpK//VvTWu2G2ZNLx4Irj4nH/G/x78dIZ6ZKf4L1NoPTB8OKptYu8P6E2Ud0wu/0bPy5sZxJcaPZm1DHJOhH3LyhvbFb1MzZbVQhM7IFXIC98a4IqUqrV0+hnn3QsQ2NRbuv3H2xQ3xEBNwE+xDeE0j1dR0/VTeJTmRQ3ia/0Kc2xvFpdvs+As3dVxYQIdUP5MN5l6ZXQ2vvwq6YrBOUJe7C3U8lAf53yiUAjY3V+SH9RxAFwwevRukAg4r8XIvfg8xG72AwyI6feYZXrPf9l4uFFvCme0Vj77DIQSktRqXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PauUiCOkLuZaBpOPAn/UUbZE3M+/HWwJN4bK3L4jeys=;
 b=XTalTb6gAdSdSX2eAqqQC+iCJWDDk0U8dGSN873sQLSnady8hQtg6wA1sI1o8jQIgIWJnbaBjeQymWKjURMRpyHP5WoHc8gLaih/AO9AXPtYimBJr9XqEbjqRNtdEvfv9UfHd9jE5kWWLPNRwobcyJdq2yN2CDh4J+IU3v+FhRFtbMjfjeMPpA7qw/BZpF43BY2f7sm+mGRgraGpwfzfaC9iBraI61N9zSofV8n9UfoMPkFwi42+H97AUBnfWp5IpK1K7kG/8d4hmcTNhn3SrHCMItJEi84aVl0ke8EzaNWSOhOiLLrc1k1DwjenrEqTzMZm39xnnej3ogJGs3SR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PauUiCOkLuZaBpOPAn/UUbZE3M+/HWwJN4bK3L4jeys=;
 b=pUgnciB26xyKoHIu64pAUa3W2YOeqFKMujHU9/jzV/QxtcLfkD/ZmyXyhQrc6hQYlnpyXRruO2ZMAlBGBWkXf/SmWrePJvlvcQrh6knnMntwTabbNDS3rENf3K72Plzp0p5bJM4uwDFfovcrdWyp4TXJhbruUupujWeTqKTsoV0=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB5607.jpnprd01.prod.outlook.com
 (2603:1096:604:c0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 10:47:29 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 10:47:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lee Jones <lee@kernel.org>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Steve Twiss
	<stwiss.opensource@diasemi.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Topic: [PATCH v6 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Index: AQHaLmTZZmVT0psB8keMNtPm4cmnmbCz04OAgAAE+gCAPOHi4IADLZ4AgAAgd9A=
Date: Wed, 31 Jan 2024 10:47:29 +0000
Message-ID:
 <TYCPR01MB112699B7CE63C8467E43FBDFB867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231214080911.23359-1-biju.das.jz@bp.renesas.com>
 <170316812973.586675.6248412029985031979.b4-ty@kernel.org>
 <20231221143318.GH10102@google.com>
 <TYCPR01MB1126921A54B9260CC33505FCA867E2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20240131084924.GD8551@google.com>
In-Reply-To: <20240131084924.GD8551@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB5607:EE_
x-ms-office365-filtering-correlation-id: 0791faa3-9f23-4d41-d2c4-08dc224a05b5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jUHJYiPBf76udGxbZS59kKBFG1ALJPaO90QkDWQdxgwKzRXNszAEQEfPoz025TT4mVhth7R36zffJv3KRBoN2CB+o0PPq/shAI4CMTcN4oveB9xbgEQUsrk/UmNKow1dR0EbtuAfgsWqO048GqJLhvWc3BQ7xSUCRw8kVZcGu2GUMkw6Q/5PBXPhYU4uI6nrS+QlZGFUa79ii1aBun9ugZzbybcdfgiIy3bGa3IYmJtlJlQCmGk/05iBqGOp9lwlgWHS51JsZJqScsCO3PFeRVgkSmZEsj8Uoi3r1HNeT+pWrzpr50OhjdMVWwDDy/odJMya+eqx8TwueUW38GtvVNC7zxxBjVFolIibyR/Jk60S8ine+LYIcxE8cOcZUreI5Iru9Y/nn6CkocvGfV47+3QhmZxCgG9aXTSjuXojgULqc6w6YGsBOg5isIxGx+hisElF22Q3V82dvpZND93l+yzNm4Q5WBgV6xPxX782DtwDNcrd4/Loodeki2Gfl8lWGu+CN4jEugTGnWHmhpvSRYpkO2ZWDEUkAlQ+Uk8P73f9ADnyguajjvJYZQPkTaJsejgWEbxJOH9Ed7eFMPodcQQ8gYtoI9l9SLKRzjxUUE0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(55016003)(83380400001)(26005)(9686003)(53546011)(966005)(478600001)(86362001)(66946007)(66556008)(316002)(6916009)(76116006)(66446008)(64756008)(122000001)(6506007)(71200400001)(7696005)(38100700002)(54906003)(66476007)(8676002)(8936002)(4326008)(7416002)(5660300002)(33656002)(2906002)(41300700001)(52536014)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Si9tK28xYnJ1OFRTcTBxK2djSkR2eUVxSmdJV1JncDc0NGZtOVdSV0hRa2l4?=
 =?utf-8?B?dmdqcFRBTmFQVlIyREVpZzNWaXZuRWxrWTE3a3FhVkRwVVZRYWo3RFJnWWdZ?=
 =?utf-8?B?Zk0wUmtTc1NaZWNDUWRCdGJZMVJIR3BsZjlsd3pKcnBmOGZTblNVZkpucU00?=
 =?utf-8?B?Qy9kKzJ0MmgreHljQjc5MWhaT2lUSDhWaTdod0VLL2dvYlArN2VOenR3SlhY?=
 =?utf-8?B?SUlnVS8vNTllL3RFYjF5ZjBwR0k2a0hTNis1U0UvdWJMS1VFeGxUbnJWMGVm?=
 =?utf-8?B?aHQ3c2RYWUxPanlzbTMzd0VaNlJicHVPOG5jeFFLRFlCdFNCbXk0Z1E1dDlk?=
 =?utf-8?B?L2lzZ2lzS25ISHJjc2laUTBNbS9lSG5DbGhDWnpaaFBnQXRQUDU1Mlg1V3VN?=
 =?utf-8?B?N040Nld5SXZYVkE0a3NIU2V6bmFISWZNRFkzems5RVpCNEo4eUlnSXFMWC9t?=
 =?utf-8?B?bWZjZGFKVGRYNzBXam52YThQdFRCWlRlMkdBQ1RHYUwycE5rR1BVOXJ0MTM1?=
 =?utf-8?B?aFBlQWZNdFA1SG9ZcUQvQy9QU2sxNXdKMHZFQW9aSHhPQjBPeUhVTTY2eE0w?=
 =?utf-8?B?QmJpUk1mWlNpUFBmdWc0Zlljd2JBSFFXMStHS0oxanJOVEliYUVtU3ZQRlNP?=
 =?utf-8?B?NEFuL0pzQzlUcmJ0SUdTTG14VlZaZmNYTlIxaHFOR2hlS3ViT2FWbUlnaGNl?=
 =?utf-8?B?UzNCRFhKTXJmTlRDS01tMlJtazM0TmdPTnV3VDVVR2pUSUxkT0cxaUF4RGtB?=
 =?utf-8?B?djVqeWdZM011NDV6L3J3dnlRYW10ZXQ1UE5iWFMvZTJtVHZCb005TVJKVkR4?=
 =?utf-8?B?OUduUHYzZGJPajhUNWlpM2JmMFIycEsrU1MzYXZaU2JieG51YzdaL1h6eVAv?=
 =?utf-8?B?YTV2Um9hbG5zZDhOZHRSSFQ2SERvVHNMdmxpeG1GZ0VQVDRKU3EvTjhOUTgw?=
 =?utf-8?B?T1dkbWNzOWgzcDkrRElSYkFERHNFeTloY3NWNlZ2KzJDTHp0QTFBVW4wTmM3?=
 =?utf-8?B?ZDYzYTB6ZDN0dUlicnMvMUVkc2RrV2VveTR1UHlPQ3EzMm43VVhVbjBWbWR1?=
 =?utf-8?B?YkpWcGoydE1xSi9CYm9yc3JIMDlKaWd5d1ZXK2Q4UnJaNThnUTdsSW9tU3FU?=
 =?utf-8?B?MlRZZmlBYUZvTU5WbXZiUTdrNEdKNXhMSTJYdVZ0ZFp3YnNZV3ZOZGc0NC9O?=
 =?utf-8?B?N2NhMlhBK2ZxbTEralNtQUEvR3BhT2YxT05ZQ3FnSmNsQWNlVG1sdW1wMGRD?=
 =?utf-8?B?emZ6elEyZG1qQXgwVW40VHdWZXJYaG9WU1QwOHFSb1ZJZlJKeFkwK1g5UXlB?=
 =?utf-8?B?b0ZxbDhIdjlLOGVtTVVYRjJDWGFJVFcvZ1FWYlVJcVdOUWdPeU51aGVJZGlY?=
 =?utf-8?B?eWIrMUJGcEZzckFWbk9GWFJFTlNSOW5Bd3pWSUZsWkJTSXBqbStEWi9wOEJB?=
 =?utf-8?B?LzNpWXV5MmFNTzRFb3BQNXJJeWdxWnVYdUsxZHdjcEk4bzBSQk5sSlN0aW9y?=
 =?utf-8?B?SEtiYjlXcVo4WU1SNFhPa0VhTEQ3ZERRSC9xRFg1RWJ6aklEYktaZGZEUzhS?=
 =?utf-8?B?QllTUXNDK21hUThNSzMvMmErZkFEa3RlQ0FkZ08yVmt2NVJqYWRubkVTL3BC?=
 =?utf-8?B?SW1TdzF2VWcxTVJZTzB6dnN1WENrdnNaMTRhZzE3czZ3a1VvQVUySmZqSitr?=
 =?utf-8?B?TUlkSE5ZeHd6L0wrcCswbTF0ZzNwbGpYT3ZrbEVWZ3hQaksrVENHVzNXditN?=
 =?utf-8?B?SFI5cjJhZHRodHUwNjErd2d4UnRmamJURndjYytlVDhMeUdqZUpkbnh6MWk1?=
 =?utf-8?B?bzRVTG9wTkNIeTBVMUU2Q080WTM0RnM0QkdTRlBmSXYxcy96MFJHNHdxemZw?=
 =?utf-8?B?bnZYZ1RTV0EvUjErSC9ad0VwbVR3M2xOSW9yNEp5SUl2S3pYM3Y1a1I2OWsz?=
 =?utf-8?B?d2JmOFNBYng5UWU4MWpNWXZvdnllQi9CblEvaDNScExKa3FjdDJUUHJ0SVZt?=
 =?utf-8?B?cFRXMVpiWFcvNjRkMGt6a2NKajFCNWZrOEhodDM5TW1LT2ZZeWZMdE5LWFR6?=
 =?utf-8?B?RFhtMmIvSzhBb3VoK2IxcDJQL2lqTEtNdE1BTFpaa3pSTmcyMmxWQ1cxQm1o?=
 =?utf-8?B?MkhreDdVdHFKdjJVR0V2c1VqaUtBdU9HVnRiS3JDYVI5RWhoOFpXSUhkUmUx?=
 =?utf-8?B?Q3c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0791faa3-9f23-4d41-d2c4-08dc224a05b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 10:47:29.8381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RRWxKIIIFyxXapcKonP/pNbLI9eAda8Z3kJoEekrjzcIOmNxrzikIpFgz1rZ1qviLelQxDftZGZEnFGoTXDKIHrS4MO5AKLb0Dju0sT7b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5607

SGkgTGVlIEpvbmVzLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZWUgSm9uZXMgPGxlZUBrZXJuZWwub3JnPg0KPiBT
ZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMzEsIDIwMjQgODo0OSBBTQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2IDAvOF0gQ29udmVydCBEQTkwNnsxLDJ9IGJpbmRpbmdzIHRvIGpzb24tc2NoZW1h
DQo+IA0KPiBPbiBNb24sIDI5IEphbiAyMDI0LCBCaWp1IERhcyB3cm90ZToNCj4gDQo+ID4gSGkg
TGVlIEpvbmVzLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
RnJvbTogTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBE
ZWNlbWJlciAyMSwgMjAyMyAyOjMzIFBNDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAv
OF0gQ29udmVydCBEQTkwNnsxLDJ9IGJpbmRpbmdzIHRvDQo+ID4gPiBqc29uLXNjaGVtYQ0KPiA+
ID4NCj4gPiA+IE9uIFRodSwgMjEgRGVjIDIwMjMsIExlZSBKb25lcyB3cm90ZToNCj4gPiA+DQo+
ID4gPiA+IE9uIFRodSwgMTQgRGVjIDIwMjMgMDg6MDk6MDMgKzAwMDAsIEJpanUgRGFzIHdyb3Rl
Og0KPiA+ID4gPiA+IENvbnZlcnQgdGhlIGJlbG93IGJpbmRpbmdzIHRvIGpzb24tc2NoZW1hDQo+
ID4gPiA+ID4gMSkgREE5MDZ7MSwyfSBtZmQgYmluZGluZ3MNCj4gPiA+ID4gPiAyKSBEQTkwNnsx
LDIsM30gb25rZXkgYmluZGluZ3MNCj4gPiA+ID4gPiAzKSBEQTkwNnsxLDIsM30gdGhlcm1hbCBi
aW5kaW5ncw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxzbyBhZGQgZmFsbGJhY2sgZm9yIERBOTA2
MSB3YXRjaGRvZyBkZXZpY2UgYW5kIGRvY3VtZW50DQo+ID4gPiA+ID4gREE5MDYzIHdhdGNoZG9n
IGRldmljZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFsuLi5dDQo+ID4gPiA+DQo+ID4gPiA+IEFw
cGxpZWQsIHRoYW5rcyENCj4gPiA+ID4NCj4gPiA+ID4gWzEvOF0gZHQtYmluZGluZ3M6IG1mZDog
ZGE5MDYyOiBVcGRhdGUgd2F0Y2hkb2cgZGVzY3JpcHRpb24NCj4gPiA+ID4gICAgICAgY29tbWl0
OiA5ZTdiMTNiODA1YmNiZTUzMzVjMjkzNmQ0YzdlYTAzMjNhYzY5YTgxDQo+ID4gPiA+IFsyLzhd
IGR0LWJpbmRpbmdzOiB3YXRjaGRvZzogZGxnLGRhOTA2Mi13YXRjaGRvZzogQWRkIGZhbGxiYWNr
IGZvcg0KPiA+ID4gREE5MDYxIHdhdGNoZG9nDQo+ID4gPiA+ICAgICAgIGNvbW1pdDogMjhkMzRk
Yjc3NzJmMTg0OTBiNTIzMjhmMDRhM2JmNjllZDUzOTBkMg0KPiA+ID4gPiBbMy84XSBkdC1iaW5k
aW5nczogd2F0Y2hkb2c6IGRsZyxkYTkwNjItd2F0Y2hkb2c6IERvY3VtZW50IERBOTA2Mw0KPiA+
ID4gd2F0Y2hkb2cNCj4gPiA+ID4gICAgICAgY29tbWl0OiBkMmE3ZGJiODA4ODcwYzE3Y2ZmYTI3
NDllYTg3N2Y2MWYyOThkMDk4DQo+ID4gPiA+IFs0LzhdIGR0LWJpbmRpbmdzOiBtZmQ6IGRsZyxk
YTkwNjM6IFVwZGF0ZSB3YXRjaGRvZyBjaGlsZCBub2RlDQo+ID4gPiA+ICAgICAgIGNvbW1pdDog
ZDQwMTg1NDdhMTVhOTRjN2U4NjViMmNlZjgyYmZmMWNkNDNhMzJiMw0KPiA+ID4gPiBbNS84XSBk
dC1iaW5kaW5nczogaW5wdXQ6IENvbnZlcnQgZGE5MDZ7MSwyLDN9IG9ua2V5IHRvIGpzb24tc2No
ZW1hDQo+ID4gPiA+ICAgICAgIGNvbW1pdDogZGI0NTlkM2RhN2JiOWMzN2NiODY4OTdjN2IzMjFh
NDlmOGU0MDk2OA0KPiA+ID4gPiBbNi84XSBkdC1iaW5kaW5nczogdGhlcm1hbDogQ29udmVydCBk
YTkwNnsxLDJ9IHRoZXJtYWwgdG8ganNvbi0NCj4gc2NoZW1hDQo+ID4gPiA+ICAgICAgIGNvbW1p
dDogOTk4ZjQ5OWM4NDNlMzYwYmNkOWVlMWZlOWFkZGMzYjVkMzJmMTIzNA0KPiA+ID4gPiBbNy84
XSBkdC1iaW5kaW5nczogbWZkOiBkbGcsZGE5MDYzOiBTb3J0IGNoaWxkIGRldmljZXMNCj4gPiA+
ID4gICAgICAgY29tbWl0OiAyYmJmOWQyYThlM2JjOTMzNzAzZGZkYTg3Y2FjOTUzYmVkNDU4NDk2
DQo+ID4gPiA+IFs4LzhdIGR0LWJpbmRpbmdzOiBtZmQ6IGRsZyxkYTkwNjM6IENvbnZlcnQgZGE5
MDYyIHRvIGpzb24tc2NoZW1hDQo+ID4gPiA+ICAgICAgIGNvbW1pdDogNTIyMjI1MTYxODMwZjZh
OTNmMmFhYWJkYTk5MjI2YzFmZmRkYzhjNA0KPiA+ID4NCj4gPiA+IFN1Ym1pdHRlZCBmb3IgdGVz
dGluZy4gIFB1bGwtcmVxdWVzdCB0byBmb2xsb3cuDQo+ID4NCj4gPiBUaGUgY29tbWl0IGRjODA1
ZWEwNThjMGUgKCJNQUlOVEFJTkVSUzogcmVjdGlmeSBlbnRyeSBmb3IgRElBTE9HDQo+ID4gU0VN
SUNPTkRVQ1RPUiBEUklWRVJTIikgaW4gbWFpbmxpbmUgd2lsbCBnaXZlIGEgY29uZmxpY3QgZm9y
IHBhdGNoIzEuDQo+ID4NCj4gPiBQYXRjaCMyIGFuZCBwYXRjaCMzIGFyZSBhbHJlYWR5IGluIG1h
aW5saW5lLg0KPiA+DQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUg
dG8gcmViYXNlIGFuZCByZXNlbmQgdGhlIHBhdGNoDQo+ID4gc2VyaWVzDQo+IA0KPiBUaGF0IHdv
dWxkIGJlIGhlbHBmdWwsIHRoYW5rcy4NCj4gDQo+IFBsZWFzZSBlbnN1cmUgYWxsIG9mIHRoZSBw
YXRjaGVzIGhhdmUgbXk6DQo+IA0KPiBBY2tlZC1ieTogTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9y
Zz4NCj4gDQo+IC4uLiBhcHBsaWVkLCB0aGVuIEknbGwga25vdyB0byBqdXN0IGFwcGx5IHRoZW0g
YWdhaW4uDQoNCk9LLCBSZXNlbmQgdGhlIHNlcmllc1sxXSB3aXRoIEFjayB0YWcgYW5kIFJiIHRh
ZyBmcm9tIENvbm9yIGZvciBwYXRjaCM2DQoNClsxXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjQwMTMxMTAyNjU2LjMzNzktMS1iaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbS8NCg0K
Q2hlZXJzLA0KQmlqdQ0K

