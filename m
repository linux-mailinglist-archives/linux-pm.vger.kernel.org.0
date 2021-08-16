Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00513ECDEF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 07:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhHPFNM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 01:13:12 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:24544
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhHPFNL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 01:13:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4JmkgMl1yq5pHm8TD/Ia3zlz2ToWdMU7TviTSqF6bIQzgDU0Em4ZPXaiibGpkcfQt1K+EIzJRi5NVsZtsQvFrL4h8VTLgN+j66VTBhS4HcAJHMyRey1iOPj1CKA6nxAkZPJp1rFC5DObTHXt+AQ6g0i/w7DzmT2bBHDGvL1EVVM7QSnbQqi7pD5TInHPK3Njf15SJve+6BL2v4SZsUOiPg0d5pVkU1CpnFgc2U3P9BAOavcgwqBqSup/E1OMvzwZZ/mGEkDhlO95awhbShq63ZNkpWMhvslcqYw/olkKybehnf03HW+dPUTpVMvcsjRMHRblnYgUcmgpBEGwv465g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7pmEFwKJaIleWzDZnVj2EW923NjX+TyduyaINB6mm8=;
 b=C+mLyQkZjhuAF2/UC1Uw5yihPgYK31g/kee+s2LwQNQsGZfcEw4cJp+EFfftjJB1c5hwXhy9v3oq7YILIJiWmF49U2XfY+KBPFh1QBkZh/1I54o2/Gdc3Cxa/OijW5Q6AgofT9jyggwafRLhTu2VTofLPORgF0T2z1yxoLvEIq4hqOIYEqinPM0PMR62TJDmAd9fLPPGWyQfI4WoAI5FdhBVjck1pwf4mrlGncmlVdNDbQB82gs4eiY+THlIXHGimhRr0mR7V9dkBDs0IqhLNfp9DDDUM4L2CXxMysMhKbOXzdnSpESpljY8utN8NsHdbzH6sDb+y/jLQfFsQcxiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7pmEFwKJaIleWzDZnVj2EW923NjX+TyduyaINB6mm8=;
 b=rQCe9Pz7oGplVDb8+nr+AAiLRPrI119SL6G4ZcgyzWUpLA/Lb8xwORbD4DNURZvwQKFXlNxgq1gNDmL7Sc88m4+i4dJ/ZV9KiFeZM7LnWW7setPy+67WBJUt1wnxcuUBHT3d9QaYSSHQcIovSVBmYJn5tRmo/RpcwZ0O6DzLgLY=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2169.eurprd03.prod.outlook.com (2603:10a6:3:21::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Mon, 16 Aug 2021 05:12:36 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fc50:7f7a:87b:f38]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fc50:7f7a:87b:f38%7]) with mapi id 15.20.4415.019; Mon, 16 Aug 2021
 05:12:35 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "benjamin.chao@mediatek.com" <benjamin.chao@mediatek.com>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "gene.chen.richtek@gmail.com" <gene.chen.richtek@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gene_chen@richtek.com" <gene_chen@richtek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wilma.Wu@mediatek.com" <Wilma.Wu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH resend v6 0/3] power: supply: mt6360_charger: add MT6360
 charger support
Thread-Topic: [PATCH resend v6 0/3] power: supply: mt6360_charger: add MT6360
 charger support
Thread-Index: AQHXfFAlWtSfICamyUif4KMb3KmIT6txvmkAgAABNgCAAAYDgIAAA3gAgAAKrQCAA+49AA==
Date:   Mon, 16 Aug 2021 05:12:35 +0000
Message-ID: <8156a7d206e4c3c6392ada533f35d1309c66a8f2.camel@fi.rohmeurope.com>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
         <20210813155438.4ssph6deqksob2uv@earth.universe>
         <20210813155858.GD5209@sirena.org.uk>
         <20210813162029.q5slrkubelfy3mvh@earth.universe>
         <20210813163254.GF5209@sirena.org.uk>
         <20210813171106.entpro4b6dstho4s@earth.universe>
In-Reply-To: <20210813171106.entpro4b6dstho4s@earth.universe>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6786717c-a40c-47b2-0f9b-08d9607475c0
x-ms-traffictypediagnostic: HE1PR0301MB2169:
x-microsoft-antispam-prvs: <HE1PR0301MB216949BBA4C672F2615E8FD8ADFD9@HE1PR0301MB2169.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggz6a2KrOdqlyrmXV0o+j9xac2o57otDsn1ZpRy+J1VrQiw09tbMiUpns8J2MwivP6gHZ8ivCRNpDJACHTITLVXGWlPr+lzaBNspcuPh78xeDRudhBI66NzDQVaC6G2UyEQ3aN8+WQWctow79fH0wZlj3ZdesrULe74yM1JBzyDVm9JpFQl4q/pjCCT391NDEaLN6vA6WoNTE+ZEMjZB3QzlPVShnYyeMzgqdSdxh4FfWC4GIagucQEHIVRUuB06yvXVxZet5WzkWR7c6wnZUm4mUujTz9OxY1UNe6GeHQF1HKGaa0wh4nxs/pNsz+Mt4F2m+bUb2ANdVbVxdEmqrf1rD/vxcqBw5FtrBBUIecuI8E+ZXP3VPednNNTBb1izr4XEt4Cj7Qr5gmg3DxCTvt5tBk4iLQyOGtSHkEZpE5JZEaGXTgVpsBG0x/bMXujXj7wRueZvW7+chVjQ4odvy1h4UTa2q8CTTNJgTV5nFnO24xUwzrO/AjuAHCOgtg9AkX65uUyfcz+7hw0LgwSbELuWeLpd5L73RgTjPm1ANoUsVonAGVeUAvW10PAe7kn5ax6LJvre9ZfRsOFl0AB70ciEx8q0pm6DnM86uwwrOigPglogQaIqY4LeZjLA27wCvL07Jj7PkZyrPQu9omDrtv476Ux72C6cV1Q/XN5ZDxRa4Ah1VVZ3x1E7cTevRfl0aEYNuaCCFxKYvgXwXatA5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(122000001)(7416002)(71200400001)(8936002)(4744005)(4326008)(38100700002)(8676002)(38070700005)(83380400001)(186003)(6512007)(6506007)(86362001)(54906003)(66476007)(2616005)(66556008)(64756008)(3450700001)(66446008)(316002)(66946007)(2906002)(508600001)(110136005)(5660300002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MElMMUdLUE1jcGJUaDJSM3RBR0g2K3lsWUhrbEwwMFFDamNDM3dUOHI1K04y?=
 =?utf-8?B?UURIMmlja2pqb1RtNkQxZmZNYzFCNzRJL1g2Nnl0U2FKdnFtcEIyMWFDU2Vl?=
 =?utf-8?B?VWlpUXBjd1RYSG5UYmtKWU9raGtucHpqRU9NUGJMdjdnMTlwODdHQ3ZUYWVR?=
 =?utf-8?B?cStDUS9OWGdlMWRFSnVhVUxxS2hHWGN3aEVLYnZZT2t0VzBRV3Nad2p1NUxn?=
 =?utf-8?B?NFBRdzBDM3Y3cDZWN0ZTUzZiQ1BwZzZONTUxY2xMRzl5VThoSVFvZGlVckRQ?=
 =?utf-8?B?YUlPT2VwN1NaVURqcnNLcVZYQzhuV0wyYk4rQzhianE2MVBZOFlGVkYwU1J4?=
 =?utf-8?B?OEtuOVJJNXhWT2hiMVlORnhlVjgrbEVxSGRXS1h5ZG9zN1dCMWhHY3dVeHBm?=
 =?utf-8?B?a3Y4QzBkOWlzbEZ4RTJHdWpTOVZpc2lKRmhKOWxOT3lrMndXWWNZUk9ySktk?=
 =?utf-8?B?S0NvNVpiQnpVdXlJRGdMU3dpZFlENkVEZUx5Ly9GNkx3a3F0TkU3U2hobG5i?=
 =?utf-8?B?T29yRmFuTVpZa2JjTEJWdzFSTCs2Qkhzcm5rODRpNGtZYXFLQVVYNUpjUHVV?=
 =?utf-8?B?bEtydWRPWU4wSWpVeXJ6M1pabjZRM2ZMUkZaSUtyU0tsbmJYaS9vdEl5RnU4?=
 =?utf-8?B?ekp6MDJwZms5K21oOVZFaEtYMi90MVg0M3dFR1RSTXhkRWdtRFRkcGg0RFhI?=
 =?utf-8?B?UHJOb2Q3MTFoTUlITHc3SFhjMFI3QXNNUGphRk9ER3dGckswcWNpWSt3M0U5?=
 =?utf-8?B?TFk0dkVmK2tSR0hQZEZTbWFWUlV3VE13VDRvdDhjTTRsSzF4emdNOWVhcXVj?=
 =?utf-8?B?NGFST0g1K1c0dnhsajExMlAzZ1R3OEJ3WVFjOThVZkgzUUx6Zi9ZR1ArZUlu?=
 =?utf-8?B?Vzc5UFFlbWtjMEdyeTE5UkNrMGFMdFRxSjAyckc5WWI5NXMrRE91VTVHWmpI?=
 =?utf-8?B?WklFNVp6eTJtK2duOE1HQWVEeVNoL2R1czJTbERPdCtpK3Y3bXJMMDA0UjZw?=
 =?utf-8?B?NU5PZnFXcW9ZMjlOUmlTLzVIdmxLSitmdm90VDZES2VVZUthOUFxbmtZOHBu?=
 =?utf-8?B?bERtQ2IxUE9JU2JkMlhvaGV6SEx2djlXK2NOR0EyM1RZOXQxWWwxSHRNWXdv?=
 =?utf-8?B?dUxhZ0tqVmVDYStveEU0RmZDVFhGVEFNYjlqaXZhV0VORTBTQXhPWllab25R?=
 =?utf-8?B?WnpmTG9CU2hQMTVRbjNBMVJvSVQ4alMyQVFHZjI0VHh2cUhqdW8xVWF0c1Z1?=
 =?utf-8?B?b1FqQkVnQXp1M1c1cGNxVnAxREdUNWdiN1lmT0lEZHNvUDNTeUVEb1NIN3Fn?=
 =?utf-8?B?Y1h5VkxiNEpVaTBDenoxak1iRS8zNUZEUkVxNTFISXB2NlZ6TTFJZHNPdEFt?=
 =?utf-8?B?eTVsVlN5dE41d09UWGc5TTlpNFVIYmNzdUpPcGtoYkRhenhxOVhSTjMrbHIz?=
 =?utf-8?B?NXBFdXpXbXFzUm9zaFRDcnpkeVd1WERYREl5bTdqbWZ4N3dsK2N3NHRyN1VI?=
 =?utf-8?B?UlRNc0tSdjFjd0pHQVludzIxR2hFaTlTSnQ2ZE9zUXN4bHh3d2k3QUNYWmpP?=
 =?utf-8?B?aXgzWmtQVXo0UXF6aFBrV0k2UHNxUUFtb2M5cWlHVHNmQ0JINnNhYnhZbmRk?=
 =?utf-8?B?MmxmZ3hYVUdIVmFWOFFYeHdzYkU5SG4wT2RXMEZ0SVRHdjNCOEpOUHRPTWVy?=
 =?utf-8?B?N1kvaFJCY1dSUUY5Rk44S1Q0WHdZYklKbUd6Y2FvOFgzM0h3SURhclBMYm1l?=
 =?utf-8?B?K3JsemZwWkFmRzdaU2ZOMURGaCtIUHNGK0N5VlVYYUlwWHBTMi9rMHI4RzJM?=
 =?utf-8?Q?pzFcWwbEuJmF6agFz4QQoxbrTvDbKwtKvs8Dw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5DC70EC5B32274194B80D2D1F3DBB12@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6786717c-a40c-47b2-0f9b-08d9607475c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 05:12:35.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IP8rdDoiVyJCXHDHjBtIKSktg+Xi4IIi2wfoiOO/6M6/6oAn0ETD2/7HxCYIB6E4x2nupCHYcchVJfmH2BpTXofvW870RvSlzgj/5GjFvIVqCUBMZ4enXOboOwS82WT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2169
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBGcmksIDIwMjEtMDgtMTMgYXQgMTk6MTEgKzAyMDAsIFNlYmFzdGlhbiBSZWljaGVsIHdy
b3RlOg0KPiBIaSwNCj4gDQo+IE9uIEZyaSwgQXVnIDEzLCAyMDIxIGF0IDA1OjMyOjU0UE0gKzAx
MDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+ID4gT24gRnJpLCBBdWcgMTMsIDIwMjEgYXQgMDY6MjA6
MjlQTSArMDIwMCwgU2ViYXN0aWFuIFJlaWNoZWwgd3JvdGU6DQo+ID4gPiBPbiBGcmksIEF1ZyAx
MywgMjAyMSBhdCAwNDo1ODo1OFBNICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+ID4gPiBX
ZSdyZSBzdGlsbCB3YWl0aW5nIGZvciByZXZpZXcgZnJvbSBNYXR0aSBvbiB0aGUgbGluZWFyIHJh
bmdlcw0KPiA+ID4gPiBiaXQgLQ0KPiA+ID4gPiBub3JtYWxseSB0aGF0IGdvZXMgdGhyb3VnaCB0
aGUgcmVndWxhdG9yIHRyZWUsIGRvIHlvdSBoYXZlIGENCj4gPiA+ID4gdGFnIHRvIHB1bGwNCj4g
PiA+ID4gaW4gY2FzZSBvZiBtZXJnZSBjb25mbGljdHM/DQo+ID4gPiBIZSBhY3R1YWxseSBhbHJl
YWR5IHByb3ZpZGVkIGhpcyBSYiBpbiB2NSwgR2VuZSBkaWQgbm90IGNhcnJ5IGl0DQo+ID4gPiBv
dmVyIHByb3Blcmx5IChJIGFkZGVkIGl0KQ0KDQpUaGFua3MgZ3V5cyEgSSBkbyBfcmVhbGx5XyBh
cHByZWNpYXRlIHlvdSB0YWtpbmcgY2FyZSBvZiBtZXJnaW5nIHRoZQ0KY2hhbmdlcyA6KQ0KDQpC
ZXN0IFJlZ2FyZHMNCgktLU1hdHRpDQo=
