Return-Path: <linux-pm+bounces-740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAEF806DDF
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075321F21597
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832BB31759;
	Wed,  6 Dec 2023 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iPGAfKBf"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF73D50;
	Wed,  6 Dec 2023 03:26:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS298boibNLxeH79fqm7TILuMGgVJ8cmDqKT7Uw8bNhLUxA52AElxvKTdtlj6Pn0cE025qAUWbhL5outuwEKGMAPw2jXAIG3uTNbHf9iak2aTTirNQDFaETshedZLpx8UsIq8XWq8cNLf5JS3xKAJfKAwSD1gOeuyAywzwvmPHeZXu7P/OVFDJWi4zUbOAx10NTxh3DmcSqdQ5JhHukXWrfCcTf1LFE63Ooi8fNHz/GZU1g2jR5dyjiom1Hnl0Z0h4/C24dPftP+Gk2bxroC4L8Tt4LGQiqkOXZlMcr6R97PIzbDCtHmFGGBKdfXiOnL71bI3jTuLtdoUZyku7xTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hDyZ5awwS0ytC8o2Ze1Zabr6iTIPsJF9deim2KlSfY=;
 b=BNTA2K8lOTMmzp0dFzdLDoIvFzAXFyLAAOFKdFkReIT2FqLvEUqdxbKhyXF0ufQDjG14UZIk3Q/7eqArRGBwU6s5KbzhC6ybWbG7WMlYREuybHnO//Wilgy2FHto2dVRe0ejPqfCE7VmNzHMJHFPouhuh7M4V9hwCmZQFe9FGy9EKcQ14qtCROA3Pyk9eTk+e/s/3cAyUftyUJYxFnH7YnC47yXW3d8yER5c19vYq2UjY9w6SQKs54/45xdKEeYOE/UXc22DrAFiF+T2X2ezA5Kryqx3FfbbHpirgOcFSXjGeH3U4WU7jil/AhCHaETE5ky6ci+6eoBlFIaU+V4+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hDyZ5awwS0ytC8o2Ze1Zabr6iTIPsJF9deim2KlSfY=;
 b=iPGAfKBfA/8g6JhyWDsY4kA9fCnUHkfdgw36D4oHDxttEzXItN0hyoaxIGvVrvIU5DFhEsbpA39PqEk/5UP1oUnJhl1bHfPuTXXmcPdO0ner8DDIcgbw/NoiBrztM4HpzKa8M4cS0iQ7jdtEWBtvkatd1deswhB7BL3kBpec4MM=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS7PR01MB11500.jpnprd01.prod.outlook.com
 (2603:1096:604:246::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 11:26:54 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7091.010; Wed, 6 Dec 2023
 11:26:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lee Jones
	<lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Support Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Steve Twiss
	<stwiss.opensource@diasemi.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3.1 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Topic: [PATCH v3.1 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Index: AQHaJtbcW/oW/Awmmkq1FFE79BsfALCcGsgAgAABcUCAAAHXAIAAALwA
Date: Wed, 6 Dec 2023 11:26:47 +0000
Message-ID:
 <TYCPR01MB11269F3BAF922F052F192B95B8684A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
 <332dfce5-f2a8-421a-878e-85f95aa64d10@linaro.org>
 <TYVPR01MB112796A859B42CC4AC6F6EC838684A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <33b097c7-0c7f-457c-b597-19c504df5a36@linaro.org>
In-Reply-To: <33b097c7-0c7f-457c-b597-19c504df5a36@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS7PR01MB11500:EE_
x-ms-office365-filtering-correlation-id: 4e80d4cc-d974-489e-a207-08dbf64e3c00
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IEdJdz5q0zy2HiBVkgLv97L7t+hKGDPrCf45OAVEz9nkU8FvTBIf9fiBbRLqzDNdxAlg5NmBV/SX0/Z2nz8KkBvgGi9kZkl/6H2AaZic2SrG+SGS79pfuRNZbHaugQh6EiqbwnU/dHURO1HTAYvwY24zvS8pQvfZYu0sscUsaHrLpWkwyQA9RKoOVLXFeMOI132hYZFcPF++Q1ejP/nM/ZQaU2qpoEm/DFop5o+hu75PBOGdIVryWIj3LA3iGSnvZiscMW9UcNXs4yN7/sWXoJkzlfkUmVJZR4mLaZJG8LArfLeMwpHnB/ayjiwoN83NZX1C3ofVeKIrehdF88/R50tvNKo8lZeOe6pa3DWDV7sjKCXIPiCxPLptOhaMBfNCUV3gr2q/KMn5Olulele5WENj9zpLTqKUOukbf1bKEjTjw3aRfbqWw6FhqGQfldUixHU78rGNpLq/w8ihAkMMVGPGxrlQbmvvaPrASXq0rdec6JvYQ/GkyiGBL1v2IZKZtAMR1A8ZxsR1UObMJR60ilJxoyMWK3rS5B/2JVF5xz0NqFjnk4vkcMU9/eYfBhGz+rvHWv9UvLZLv27oV1ZqqfWk7Jo1B+eFSoro2smABOsPQRwwQFKYAAhfsyvzsevk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(55016003)(38070700009)(86362001)(2906002)(26005)(83380400001)(38100700002)(33656002)(122000001)(71200400001)(7696005)(53546011)(5660300002)(9686003)(8676002)(4326008)(8936002)(52536014)(7416002)(6506007)(41300700001)(478600001)(316002)(66446008)(64756008)(110136005)(54906003)(66946007)(66556008)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnVobkVGM0R6KzNLcDlUaEJnNm5ua0VZVzUyVzN0QjczbUFPN1dEVWY0UDFh?=
 =?utf-8?B?VDdISmtNVWRzSitxY003TzFTZmlPUzIyN3hUc2l1TTRBMFBWdC82WE1zYSti?=
 =?utf-8?B?dWlGcjhYSzE4dWp4KzJ2OXBrWUFhN0huOFdQT0ZCZUt0bExlN0E1VWNwc0dY?=
 =?utf-8?B?UXRvZDBXYy9Yek5pRnRPbXJMLzRUNnEveTd6V2RQS1BzSEIrUlJCUkR6MVNo?=
 =?utf-8?B?RkY4b1NJTTF3eS9KZlhJTVlKVHU1ZHc1dDBxd08wZEdWaUtKc3FhSzlrUUs3?=
 =?utf-8?B?aEIvSWNWeHlNMWhVYXV2aVB6ODlzNGpRY1dJZENmT0dRcmRveVlHdFdOYWhh?=
 =?utf-8?B?aVlobHRIZ0dZbmp6RUFCVk9BZmlUb1pGbUFMT1htaXRYTTRSMnhadkV4QXRv?=
 =?utf-8?B?Z0dueXNJWmJJcW5uZnZ4S2szWGNYWjFUcWlKK1RpaHg2djZYaDJLYVhhdWNi?=
 =?utf-8?B?cGxPQUJjNXpjR09PL21yR3V0ZHp1MWVsdnFneCtiZXp3WndCNGxvWStCNFI3?=
 =?utf-8?B?S0c1WmRFbG9kdTBIcGYrMWJySHJ4YytiSmg2d2UyekovNFIyZm1aZGo1U0lN?=
 =?utf-8?B?elVza0VSdklITVEwYUlxOXNUbG9vL2FrQlo2U0tGUXZ0NFh5MWgwS09hQ2VW?=
 =?utf-8?B?T1ZFSXZVWWF1blNDcVNpN1d0S1pSQ0tTRDA2R0VoZHVUYThvYWtabVJwdUJo?=
 =?utf-8?B?bUtYY3BaUlVZWE1HNlp1WENJN1VNUkVmOXo0MW8yMXgvUzJHN1VIUmFpQkVu?=
 =?utf-8?B?c00yd3U0dXFnSktsUWVnNmpMYitTS1dUNG9XTlErQUFRK0djaHUwSE1zTjdU?=
 =?utf-8?B?ZHV2UXlLaExhcENjb0hodGpqR0ZxQjI3YjN5YmZCWjg1eW94UnJCaE1Vcmdh?=
 =?utf-8?B?WE5PLzEzNlRqdDhUY1Ura2ZwVi9lSnBOZGFyZzBtdGVDZzBYajJxYnZOVnNv?=
 =?utf-8?B?THc3TkoyODREMjRHTFdsT09NRWZsYWVlTWtEODhQQWE5YW9PWGtqN1EvcW82?=
 =?utf-8?B?OGUzMEh3enpieGZLRUtHR2RITGxVM3hMTElheTBoVHVGdUMwRnRVL05EbTh4?=
 =?utf-8?B?VlBKTHFmWWV4UWxMb3FzL1RBaGVmdy80SGowVnh3d2ppODZ5aFF6em02UlZZ?=
 =?utf-8?B?QmpRUnFrdVo2YjVTUit0SzFYWDB2dDR3ZTZwZ0s5Ni9QZEpFZnNvUVNGWTRE?=
 =?utf-8?B?Y0JmMWQ3MWtYMTNlZUp0Mk9PN2NTTFVzVUZhUUYySHQ1OEp2d0NWWjdoRDNs?=
 =?utf-8?B?dlUvRmF5blVoYUtGWmoxWVpWZEFaUWxPakljTlFiRmJvM040blA2YTdwQTF2?=
 =?utf-8?B?cEJKUUtjR1hlZXU0dGxBS3ltQUNpN0RhWS9jYnIzbGpoNUxVQ3VTS29vNkhB?=
 =?utf-8?B?SVN6cHM4Q2ZGZ2s4SkFYdlVSU3pjTGw4MDFjZHJidVFnZ0ErQkhyQmpXYm1J?=
 =?utf-8?B?U3U4VlRWc0c1SE5tc21IMWtqb2NHK2hydmUxUUZsUnVIVU5wZVZlMGhDQThH?=
 =?utf-8?B?ajFmVDV6Zk0vOFBsMjlMWUE4b2c3dVpXQ3ZkQjUybHBLYThNaDA5cFVxdUhx?=
 =?utf-8?B?clYwaUpLeFNlblNUOEh3YWRXWkFlbFdLa2c2MkI0T0hDU2Y3c2hpYmVpeVhJ?=
 =?utf-8?B?eXBpTzRTMThSRWtzUFdNRVhwM3BqcGY2RmEvc0h0NmZsajJrOVArS003bmg4?=
 =?utf-8?B?Z1M1blJZRDZSbm9VLy9ZUWQvMnh5dkVPcXFlQ3Q3ZTUxWUZtTkZWQkNUMlNy?=
 =?utf-8?B?N3NkL1kwTm5LL00xdDg1S1BtU2ljL2xVdVEzcDdiWGJiV1RxZkhyUVZlcEI5?=
 =?utf-8?B?N0sxS3VzTnNTb0NSbkIwSHVSeldxZ3FmdGFzVEZDWHJreUNzNktrMThZS2xJ?=
 =?utf-8?B?UTAzaUZ3cm8zL3ZycWpSbXE0WGwrbEZBWmFYY3VNWHBpc3gzYTZMQnRNRnhH?=
 =?utf-8?B?MFVWdVdPS0luWXAwb3k3Vk42MFVBdHBkVzdETWlSWlFtUk5OdTJ5TVcxbmVh?=
 =?utf-8?B?aGxWem9HYVk5MlQ4a29Td1hwbHhvVGZtQ2tzU0V6Q0REK2RzbFcxTzJianJs?=
 =?utf-8?B?SlU4ZWtWNkNZUDRnTmg4UmZ3cnhROTZGWm1kaUlEbHgyeFhYbW5wUDZxbTE4?=
 =?utf-8?B?RTVCSktlTnJlZ2pvanAxaFVoelM4anNYQzBEQW9BeXlrVG9KcjBRSDlCWjlE?=
 =?utf-8?B?T3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e80d4cc-d974-489e-a207-08dbf64e3c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 11:26:47.6971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhQL+PiRJ/9CxyjnQg1ewAN5DsRZnhIQ9k+WOyAb7n30522kwpmrTiPf2FnHZCXgNKIHB8NGYfjJmOOlHNRQ9mYK3kpalHy7Bv/fT7ZeTsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11500

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2Vt
YmVyIDYsIDIwMjMgMTE6MTggQU0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2My4xIDAvOF0gQ29u
dmVydCBEQTkwNnsxLDJ9IGJpbmRpbmdzIHRvIGpzb24tc2NoZW1hDQo+IA0KPiBPbiAwNi8xMi8y
MDIzIDEyOjE2LCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YgS296bG93c2tpLA0K
PiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDYs
IDIwMjMgMTE6MDYgQU0NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2My4xIDAvOF0gQ29udmVy
dCBEQTkwNnsxLDJ9IGJpbmRpbmdzIHRvDQo+ID4+IGpzb24tc2NoZW1hDQo+ID4+DQo+ID4+IE9u
IDA0LzEyLzIwMjMgMTg6MjUsIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4gQ29udmVydCB0aGUgYmVs
b3cgYmluZGluZ3MgdG8ganNvbi1zY2hlbWENCj4gPj4+IDEpIERBOTA2ezEsMn0gbWZkIGJpbmRp
bmdzDQo+ID4+PiAyKSBEQTkwNnsxLDIsM30gb25rZXkgYmluZGluZ3MNCj4gPj4+IDMpIERBOTA2
ezEsMiwzfSB0aGVybWFsIGJpbmRpbmdzDQo+ID4+Pg0KPiA+Pj4gQWxzbyBhZGQgZmFsbGJhY2sg
Zm9yIERBOTA2MSB3YXRjaGRvZyBkZXZpY2UgYW5kIGRvY3VtZW50DQo+ID4+PiBEQTkwNjMgd2F0
Y2hkb2cgZGV2aWNlLg0KPiA+Pj4NCj4gPj4+IHYzLT52My4xOg0KPiA+Pj4gICogUGF0Y2gjMSBp
cyBtZXJnZSBvZiBwYXRjaCMxIGZyb20gdjIgKyBwYXRjaCM4IGZyb20gdjIuDQo+ID4+PiAgKiBE
cm9wcGVkIGNvbW1lbnQgZm9yIGQ5MDYxIHdhdGNoZG9nIGZhbGxiYWNrDQo+ID4+PiAgKiBSZXBs
YWNlZCBlbnVtLT5jb25zdCBmb3IgZGxnLGRhOTA2MS13YXRjaGRvZyBhbmQgaXRzIGZhbGxiYWNr
Lg0KPiA+Pj4gICogUmVzdG9yZWQgcGF0Y2gjNCBpbiBzZXJpZXMgMSBhbmQgZHJvcHBlZCB0aGUg
dGhlcm1hbCBleGFtcGxlDQo+ID4+PiAgKiBBZGRlZCBBY2sgZnJvbSBDb25vciBEb29sZXkgZm9y
IGRhOTA2MyB3YXRjaGRvZyBiaW5kaW5nIHN1cHBvcnQuDQo+ID4+PiAgKiBVcGRhdGVkIHRpdGxl
IERBOTA2Mi82MS0+REE5MDZ7MSwyLDN9IGFzIGl0IHN1cHBvcnRzIERBOTA2My4NCj4gPj4+ICAq
IFJldGFpbmVkIFJiIHRhZyBzaW5jZSB0aGUgY2hhbmdlcyBhcmUgdHJpdmlhbC4NCj4gPj4+ICAq
IEFkZGVkIEFjayBmcm9tIENvbm9yIGZvciB1cGRhdGluZyB3YXRjaGRvZyBwcm9wZXJ0eQ0KPiA+
Pj4gICogRHJvcHBlZCBsaW5rIHRvIHByb2R1Y3QgaW5mb3JtYXRpb24uDQo+ID4+PiAgKiBQYXRj
aCM1KG9ua2V5KSBpcyBzcXVhc2hlZCB3aXRoIHBhdGNoIzYgYW5kIHBhdGNoIzkgZnJvbSB2Mi4N
Cj4gPj4+ICAqIFJlcGxhY2VkIGVudW0tPmNvbnN0IGZvciBkbGcsZGE5MDYxLW9ua2V5IGFuZCBp
dHMgZmFsbGJhY2suDQo+ID4+PiAgKiBEcm9wcGVkIGV4YW1wbGUNCj4gPj4+ICAqIFJlc3RvcmVk
IHRoZSB0aGVybWFsIGJpbmRpbmcgcGF0Y2ggZnJvbSB2Mi4NCj4gPj4+ICAqIERyb3BwZWQgZXhh
bXBsZQ0KPiA+Pj4gICogUmVwbGFjZWQgZW51bS0+Y29uc3QgZm9yIGNvbXBhdGlibGUgcHJvcGVy
dHkuDQo+ID4+PiAgKiBBZGRlZCBSYiB0YWcgZnJvbSBSb2IgYW5kIHJldGFpbmVkIFJiIHRhZyBh
cyBjaGFuZ2VzIGFyZSB0cml2aWFsLg0KPiA+Pj4gICogQWRkZWQgQWNrIGZyb20gQ29ub3IgRG9v
bGV5IGZvciBwYXRjaCM3Lg0KPiA+Pj4gICogU3BsaXQgdGhlIHRoZXJtYWwgYmluZGluZyBwYXRj
aCBzZXBhcmF0ZQ0KPiA+Pj4gICogVXBkYXRlZCB0aGUgZGVzY3JpcHRpb24NCj4gPj4NCj4gPj4N
Cj4gPj4gSHVuZHJlZHMgb2YgY2hhbmdlcyBhbmQganVzdCAiMyAtPiAzLjEiPyBUaGlzIGRvZXMg
bm90IG1ha2Ugc2Vuc2UuDQo+ID4NCj4gPiBCb3QgcmVwb3J0ZWQgc29tZSBpc3N1ZXMgd2l0aCB2
Mi4gU28gaW1tZWRpYXRlbHkgSSBzZW5kIHYzIHdoaWNoDQo+ID4gY2xhc2hlZCB3aXRoIHJldmll
dyBjb21tZW50cyBmcm9tIENvbm9yIGFuZCBSb2IuDQo+ID4NCj4gPiBObyBvbmUgaGFzIHJldmll
d2VkIFYzLg0KPiA+DQo+ID4gVjMuMSA9IGJhc2ljYWxseSBSZXZpZXcgY29tbWVudHMgZnJvbSB2
MiArIEZpeCBmb3IgQm90IGVycm9ycy4NCj4gDQo+IHY0LCBkb24ndCBpbnRyb2R1Y2Ugc29tZSBt
aW5vciBudW1iZXJpbmcgdG8gY3JlYXRlIGltcHJlc3Npb24gb2Ygbm8NCj4gY2hhbmdlcywgZXNw
ZWNpYWxseSBpZiB5b3UgaGF2ZSBtdWx0aXBsZSBjaGFuZ2VzLg0KDQoNCk9LLCBXaGVuIEkgc2Vu
ZCBuZXh0IHZlcnNpb24sIEkgd2lsbCB1c2UgVjUgYW5kIHJldmlzaW9uIGhpc3RvcnkobG9nIGNo
YW5nZSkNCkkgd2lsbCB1c2UgdjQgaW5zdGVhZCBvZiB2My4xIGFzIGl0IGhhcyBtdWx0aXBsZSBj
aGFuZ2VzLg0KDQpJcyBpdCBvaz8NCg0KQ2hlZXJzLA0KQmlqdQ0K

