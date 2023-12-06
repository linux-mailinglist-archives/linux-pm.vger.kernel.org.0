Return-Path: <linux-pm+bounces-737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC31D806DA4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F1AB20D83
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48431721;
	Wed,  6 Dec 2023 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oXJrP5aL"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F922B5;
	Wed,  6 Dec 2023 03:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCXFojypfY7WDNXJk3L2UfqReUmwwine/O1hg94/p4Yc/ibK5nnyYZkfbKOtRx9+5xumNc4AQd3As3Zy5wUjEo4clbk2l10VUlCXtW5SWAqDfyt3BucNOP4ow0nn/8VC97hzPGB6ZfQqNyHSe9VAuDr2XnZ1RuHZDNhu/bwANFGw9uqgDZTgWc/BSc/1KLOnENY7r4mzKa7xij7JY68rhxYbQkJITdT+GToh47tAG96IflESxaOjVF0UzkvjaXYQXBIxAriSVAlTbzfsbvuJR7p/nw5dkzcM8aJXprMOefZaY5lSWEA1emwb+oaA9owelnqCcNXamMbQbsMeHsX5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4ZLXJwLn0LidQPV8/YIR3PA5QniN5sszCl19CqCEA4=;
 b=h35BQbFjXQasV71eRwaKRcQJuusc9piPZFISeXyCfGJWK3Mt+Te+t7eP+ncME9QK1c1IO6uXEE4E/8UpqkKJpf3Wd4jlx+on3CrONpAlSIoFNCXOeZWwaik8YaKaNFEh4D3W/oXA5+5haRwKpxo5SRE0+i8lWS0cY4btMfcVQ6sZIkLVcYdj9eq7K7jhdUxHGKteSl1bI7QkxSlrPDrIINE+mCVaYhSsg+wCSTld0jq2Kkm1Z086Prl5tcxzhRagVWBni1dNv3NbUwcudPoxT8kGx+dArfNUAJ2+yeUnVIN9hhvY9Q5q/nnMV4x3jVySa1kpNHcEgkHBUkNfqkC30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4ZLXJwLn0LidQPV8/YIR3PA5QniN5sszCl19CqCEA4=;
 b=oXJrP5aLVMVWvYgKztLcLd7ZiG2pAcuo5f4nblgUC6dFajIvjUsdnmVWrj6rkHHgx0f7HQEEOlThYDbXsTubbuzrgds4ZkSFt7QOspxHzeiGoNqeWQJFH7wL/D3LRrxUbWfGR2le+Zcdv5xMgPTFJO626kc/ML9u6bO+MbjhY3k=
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 (2603:1096:400:366::13) by OS3PR01MB8649.jpnprd01.prod.outlook.com
 (2603:1096:604:19d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 11:16:43 +0000
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::db2e:9e88:68f8:486b]) by TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::db2e:9e88:68f8:486b%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 11:16:43 +0000
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
Thread-Index: AQHaJtbcW/oW/Awmmkq1FFE79BsfALCcGsgAgAABcUA=
Date: Wed, 6 Dec 2023 11:16:43 +0000
Message-ID:
 <TYVPR01MB112796A859B42CC4AC6F6EC838684A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
 <332dfce5-f2a8-421a-878e-85f95aa64d10@linaro.org>
In-Reply-To: <332dfce5-f2a8-421a-878e-85f95aa64d10@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11279:EE_|OS3PR01MB8649:EE_
x-ms-office365-filtering-correlation-id: 0ef4203f-da07-4f84-b9e7-08dbf64cd39d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jRJhCcVHLUfaLk1pBCVsbgbWtPLlRGhIIv4P36ABK951hkTFFc7v8Dy6Kx70pJ9DsIb1HzFHGzEUA0jlHAjJjqzWcrhTEXXDtRPhn9LANtlVPFllRZ9/O05dRuUk4sZw+xV+NfRX5ZLRIx8AiEjqlzG3/zVKmmcH2oapEp5IDfALx/k137pMzCrheNXKe/9PlT9KOU0NIdbvH3z93xhWa8rDncm1LlOo/O/8432ya5WSmW5Xg0l344xZq3okW0gal5mbHexnegNVFi6sTOczFGrDIOwUPIyrswHHBHOjJYREWh8drYtTEGnvMYoy9uIiqMEum2BIUUVet6HU6IPz5ghfg/e7d6n+LZF7FYRf7Ej6e5m71Yc3/OpAXeQFZCyP8a5Bv9gEee8NJxaqeKrnKoND9QCsDYS5GbTWa3ANjP/74OZ+PkivWyZnS8zBFIMHKG07J7OGwCnn1qF7rHXDZzS3m2VPBnbWXKxqitiHE1EINiRlpuoE8Dt0D+0CO0Xl08KVFhlZmfcDVEBdkkd05ICuLfakWcbwnoO18U928K3zJj1FjfQ+SigdRH9qOBUqtdadauOZxB8w1pwSsumR0PEEGDVG54lYhV1/3cXCglg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11279.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(7696005)(53546011)(6506007)(9686003)(83380400001)(55016003)(4326008)(8676002)(8936002)(110136005)(66946007)(76116006)(316002)(54906003)(478600001)(52536014)(86362001)(64756008)(66446008)(66476007)(84970400001)(66556008)(122000001)(71200400001)(38100700002)(33656002)(41300700001)(7416002)(2906002)(5660300002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3ZrRzY4dklhZjlOZk4yNzJuNDNib3BqQW9hbWg1M2pEZFNUdkswMHExVDc0?=
 =?utf-8?B?QnhTcEtVcVFnaldxLy9qT3hhNnNLS0lhV2lsZGFSWStoeGUwNWlQNE81c0lx?=
 =?utf-8?B?RFBaNmlEZmxONktJMkwwaHBycHp1WWtUa0RTc2hWSUV6eTVReWJveFluc09n?=
 =?utf-8?B?b3NzbzNXODc3UEVCVnk5bXVjbUtlYSs3NE44YUtPZFJlcHh3OFVIRFoxSU1L?=
 =?utf-8?B?aEQrSlhMOVlOazZkZkZuQ3BzdkFrUU1YQ0RKUGhoUnp5eWlOY1BMUWdwSSs3?=
 =?utf-8?B?cHhPS0orV0c2ajE4RDVCaEo2WGN2alFpNmZ2RE9Mb1Y3N1J4RFQrZEFSKys1?=
 =?utf-8?B?U2pBWmQxSCtqbEtuTVdGeEJDcjlpR01HcUlRWjdwRUxxa09CNFBkTjZxM1Zi?=
 =?utf-8?B?cXE3NVUvbzB4TkdkbTJCVXpoMncxMFN0dGFXejl4SUdLZkg4aDhObzlzMnBN?=
 =?utf-8?B?N3lDVWVrWXFTK2Q2M3RsQTE3ZUN6YWZGdUtZUU8zREdtT3FNRW9qS0RGakxQ?=
 =?utf-8?B?VnhLRlI5T1NYT3dIQnhaaHNRV09uVnMxYWFsdjV5Mk5sYmRxU0E1b1VuV3R6?=
 =?utf-8?B?ZWo2ekwwbmFqeU9wU0R3WWM5U1I0UlFtd2t1cVpJdjZOTEo4Y3dOS1NnVWpy?=
 =?utf-8?B?eEFqWHFHNlNFc25OT1pDeVh5RkFtaWY4RXgxbGxCNWhzRTJicHE5dTdzeklU?=
 =?utf-8?B?a2dMcjZmdHlxcFNjUHd1bGJHY1gyc1g3YVRDdmNraDBJUFE5eElXWHRGK1hr?=
 =?utf-8?B?d0crMDNBc2o4QytyVmJKY1BsNGRFeStqanQrVHpIWVRLckJxYzRqSEdjaUtv?=
 =?utf-8?B?MEFZV0xWKzljenpiaEZaajkvZThHUXBxOVFtMjBMM2lzcjFEN09nU2dqYkJF?=
 =?utf-8?B?NjVHTFVEeXRqa2ZPUEpPV0cwVDk0eFRnRHJrUjN5SDQxdkM2b1pMbHJybE9t?=
 =?utf-8?B?ekkxU2l1NWdETGNOYzArRzZPbElzMk5pemQ4RFlZemt5emdSTEpZU2FKSmRl?=
 =?utf-8?B?OWtPSW1tZlQwT0dhTXJ3L1F4ZTc5NmlwMVRxb1c1TWtJUmxLNTVXQWhKSGNZ?=
 =?utf-8?B?YjFxcWFzeVdVYVBOYkhFWW1aMk1MRFRIM0N1QUZvQjFId2kvTFVLbXkyTkR4?=
 =?utf-8?B?eUM3bXIxQW5qeHJ4Y09EQ0lwNERHdWg1Q0JDUXpYQy9NL3RqdW91ZEQ5UnB5?=
 =?utf-8?B?TDZLSVJsOENSNjI5NWtBUmI5eGx1MVBTMUphQVJXaEJqVHcydlgxS2JIMDdO?=
 =?utf-8?B?SHpwcWNYMEs4ZWUzRU1WNmNCTHNXd1d5TVVob0haclV5ak5WM0R6ZTVCK2xP?=
 =?utf-8?B?YWxBQ0VXbVBMbm9VSjBpa0VFbDhabERDZVI5V2pxNy85eVJNUnZtZ1Y4V2p6?=
 =?utf-8?B?YmhqejN2Ry9nV1Zvc21zdUxFUzJMRXlWekR0cEljaWl6ZlBMQmNOMzA4VnVN?=
 =?utf-8?B?Um1SVHJucVErNGZOSkFzOG5vcUFvZ0lIMzFxa3VyckswQmY5VHlZUzFSeWZr?=
 =?utf-8?B?N2Vmc0gvczhyQzZjNGl5eW0xdkhUSkUrQlVlNHJyTkRxWGUzd2FsSFlCckJS?=
 =?utf-8?B?R1IrMG5IRzBpNjJjZWx0dkZMRlJpbGQ1WFdMNDZjNGIxWmNtWjloT1FwTC9m?=
 =?utf-8?B?Z0QzVVNXQlJvcnBUNHh1UkJFamtTUjQzU3dLN2FZb3BJaGtudjlLV3QybEJO?=
 =?utf-8?B?b20wcWc4eWFMUnRRdExuN3l0WWFjZTg2Y1ZFbUNTa09aVDEzSEpBUHB3eUtI?=
 =?utf-8?B?dGZURjdwakpkaHhNYjFnVnhKZGE1RFovd2RuRkd6bStlVE5FOFM0NkJUYm4r?=
 =?utf-8?B?WWhWSTdtWnVLbExKRnVpTHhneFU3TFdLOVRtRmwzaFcxYldTSk1CWGliR2dS?=
 =?utf-8?B?RWxFYUFtMThxV0NCR3lLZnNHSjRtSDBVTk5aVmJUWitOazJXK2RBOCtFTmZC?=
 =?utf-8?B?VHIwSzhCMzVEdXBqQWJyTUZxbTlBVkNoRDI0TklmZDdBbjlzYkJ0d0ZSWGVR?=
 =?utf-8?B?NERPRElObi9ZRHBPVW5XRTFMM25YdFZjWVR3VHVqMmd1cm0zTE1OWFVCSTRR?=
 =?utf-8?B?c2RlWG5HeTBGVUdEY0VLZnB3SEJkNWJ5ZTFNWTlGR1pJbUZISk5UMVh6QlVT?=
 =?utf-8?B?QjdNelA4akxKUlBOL0Zha1U3ZVZGUTdoS3E4cXliZlJYSThabnY5L01MTjVt?=
 =?utf-8?B?OUE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11279.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef4203f-da07-4f84-b9e7-08dbf64cd39d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 11:16:43.0741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwITEHHr8mTEPW2E1wZHp1vIpSVx3Dwlv1Ecz/vci5rSqEgFDoIU+D78AWtqgj3lyZvMNbG5ilKmIGntHUpXgkHAzY6okpp4qIGNtqRuDYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8649

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2Vt
YmVyIDYsIDIwMjMgMTE6MDYgQU0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2My4xIDAvOF0gQ29u
dmVydCBEQTkwNnsxLDJ9IGJpbmRpbmdzIHRvIGpzb24tc2NoZW1hDQo+IA0KPiBPbiAwNC8xMi8y
MDIzIDE4OjI1LCBCaWp1IERhcyB3cm90ZToNCj4gPiBDb252ZXJ0IHRoZSBiZWxvdyBiaW5kaW5n
cyB0byBqc29uLXNjaGVtYQ0KPiA+IDEpIERBOTA2ezEsMn0gbWZkIGJpbmRpbmdzDQo+ID4gMikg
REE5MDZ7MSwyLDN9IG9ua2V5IGJpbmRpbmdzDQo+ID4gMykgREE5MDZ7MSwyLDN9IHRoZXJtYWwg
YmluZGluZ3MNCj4gPg0KPiA+IEFsc28gYWRkIGZhbGxiYWNrIGZvciBEQTkwNjEgd2F0Y2hkb2cg
ZGV2aWNlIGFuZCBkb2N1bWVudA0KPiA+IERBOTA2MyB3YXRjaGRvZyBkZXZpY2UuDQo+ID4NCj4g
PiB2My0+djMuMToNCj4gPiAgKiBQYXRjaCMxIGlzIG1lcmdlIG9mIHBhdGNoIzEgZnJvbSB2MiAr
IHBhdGNoIzggZnJvbSB2Mi4NCj4gPiAgKiBEcm9wcGVkIGNvbW1lbnQgZm9yIGQ5MDYxIHdhdGNo
ZG9nIGZhbGxiYWNrDQo+ID4gICogUmVwbGFjZWQgZW51bS0+Y29uc3QgZm9yIGRsZyxkYTkwNjEt
d2F0Y2hkb2cgYW5kIGl0cyBmYWxsYmFjay4NCj4gPiAgKiBSZXN0b3JlZCBwYXRjaCM0IGluIHNl
cmllcyAxIGFuZCBkcm9wcGVkIHRoZSB0aGVybWFsIGV4YW1wbGUNCj4gPiAgKiBBZGRlZCBBY2sg
ZnJvbSBDb25vciBEb29sZXkgZm9yIGRhOTA2MyB3YXRjaGRvZyBiaW5kaW5nIHN1cHBvcnQuDQo+
ID4gICogVXBkYXRlZCB0aXRsZSBEQTkwNjIvNjEtPkRBOTA2ezEsMiwzfSBhcyBpdCBzdXBwb3J0
cyBEQTkwNjMuDQo+ID4gICogUmV0YWluZWQgUmIgdGFnIHNpbmNlIHRoZSBjaGFuZ2VzIGFyZSB0
cml2aWFsLg0KPiA+ICAqIEFkZGVkIEFjayBmcm9tIENvbm9yIGZvciB1cGRhdGluZyB3YXRjaGRv
ZyBwcm9wZXJ0eQ0KPiA+ICAqIERyb3BwZWQgbGluayB0byBwcm9kdWN0IGluZm9ybWF0aW9uLg0K
PiA+ICAqIFBhdGNoIzUob25rZXkpIGlzIHNxdWFzaGVkIHdpdGggcGF0Y2gjNiBhbmQgcGF0Y2gj
OSBmcm9tIHYyLg0KPiA+ICAqIFJlcGxhY2VkIGVudW0tPmNvbnN0IGZvciBkbGcsZGE5MDYxLW9u
a2V5IGFuZCBpdHMgZmFsbGJhY2suDQo+ID4gICogRHJvcHBlZCBleGFtcGxlDQo+ID4gICogUmVz
dG9yZWQgdGhlIHRoZXJtYWwgYmluZGluZyBwYXRjaCBmcm9tIHYyLg0KPiA+ICAqIERyb3BwZWQg
ZXhhbXBsZQ0KPiA+ICAqIFJlcGxhY2VkIGVudW0tPmNvbnN0IGZvciBjb21wYXRpYmxlIHByb3Bl
cnR5Lg0KPiA+ICAqIEFkZGVkIFJiIHRhZyBmcm9tIFJvYiBhbmQgcmV0YWluZWQgUmIgdGFnIGFz
IGNoYW5nZXMgYXJlIHRyaXZpYWwuDQo+ID4gICogQWRkZWQgQWNrIGZyb20gQ29ub3IgRG9vbGV5
IGZvciBwYXRjaCM3Lg0KPiA+ICAqIFNwbGl0IHRoZSB0aGVybWFsIGJpbmRpbmcgcGF0Y2ggc2Vw
YXJhdGUNCj4gPiAgKiBVcGRhdGVkIHRoZSBkZXNjcmlwdGlvbg0KPiANCj4gDQo+IEh1bmRyZWRz
IG9mIGNoYW5nZXMgYW5kIGp1c3QgIjMgLT4gMy4xIj8gVGhpcyBkb2VzIG5vdCBtYWtlIHNlbnNl
Lg0KDQpCb3QgcmVwb3J0ZWQgc29tZSBpc3N1ZXMgd2l0aCB2Mi4gU28gaW1tZWRpYXRlbHkgSSBz
ZW5kIHYzIHdoaWNoIGNsYXNoZWQNCndpdGggcmV2aWV3IGNvbW1lbnRzIGZyb20gQ29ub3IgYW5k
IFJvYi4NCg0KTm8gb25lIGhhcyByZXZpZXdlZCBWMy4NCg0KVjMuMSA9IGJhc2ljYWxseSBSZXZp
ZXcgY29tbWVudHMgZnJvbSB2MiArIEZpeCBmb3IgQm90IGVycm9ycy4NCg0KDQo+IA0KPiBBbHNv
LCB1c2Ugbm9ybWFsIHZlcnNpb25pbmc6DQo+IA0KPiBiNCBkaWZmICc8MjAyMzEyMDQxNzI1MTAu
MzUwNDEtOS1iaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4nDQo+IEdyYWJiaW5nIHRocmVhZCBm
cm9tDQo+IGxvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEyMDQxNzI1MTAuMzUwNDEtOS0NCj4gYmlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20vdC5tYm94Lmd6DQo+IC0tLQ0KPiBBbmFseXppbmcgMjEg
bWVzc2FnZXMgaW4gdGhlIHRocmVhZA0KPiBFUlJPUjogQ291bGQgbm90IGF1dG8tZmluZCBwcmV2
aW91cyByZXZpc2lvbg0KPiAgICAgICAgUnVuICJiNCBhbSAtVCIgbWFudWFsbHksIHRoZW4gImI0
IGRpZmYgLW0gbWJ4MSBtYngyIg0KDQoNCkNhbiB5b3UgcGxlYXNlIGNsYXJpZnkgbW9yZT8gSSBt
YXkgYmUgbWlzc2luZyBzb21ldGhpbmcgaGVyZT8NCg0KSSBqdXN0IHJlYmFzZSB0byBsaW51eC1u
ZXh0IGFuZCBzZW5kIHBhdGNoZXMgdXNpbmcgdGhlIGNvbW1hbmQNCg0KZ2l0IHNlbmQtZW1haWwg
LS1kcnktcnVuIC0tYW5ub3RhdGUgKi5wYXRjaA0KDQpBbGwgcGF0Y2hlcyBVcGRhdGVkIHdpdGgg
VE8gYW5kIENDIHJlY2lwaWVudHMuDQoNCkFtIEkgbWlzc2luZyBhbnl0aGluZyBoZXJlIHcuci50
byB2ZXJzaW9uaW5nPw0KDQoNCkNoZWVycywNCkJpanUNCiANCg0K

