Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2538C31AB55
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 13:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBMM1y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 07:27:54 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:63400
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229531AbhBMM1w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Feb 2021 07:27:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv5jSww8iObBQCvL4/NAL/5Hcccgcqw1M0Uo86sDv6lVQOalYyiKSugOLhEoXnse+KbmrLJoOvnMlVrQ8VlUvbY5VsjMXtQQD/JjxGTYCSapAHLPmgdmqvtiKQAekjDsGC9w+ydESOJeh6HCPaSQyDrDinuimDTuKAyRi3fxNT9fRlGBtITbN2vGODOfhCA4cKzcCP1qJDPBeQG8hADXlhSzcH879o6TUccNWBUwVirpXlMOaxueNaKCNRqucgnrCgHdp+d0q+9iFckk/YLk/ks2wWjfW3vpMcAgkA7pIrqhZ4Vy+AyNAjl42SPumPjxi2vneIajsrhhaXykguk8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmJiAJ8tyZMZ2xRNEtGxTy+uupWjzi4dz5Hw5ISaYgE=;
 b=Np9h+poXJS1KZyIL27L9N48I74XFw/fboUzeEOMYvcCVMPc5+3gNXblLB/AmrutcWBeoGurbcr83iLe336xbuwB/S/gtuxGgPtDifkhzcXA5ZciW5qMyxerdWedZp9aBt5pHgwXyNHUpe64oU3HkBqJE/l7ZIoOF79wjKORub33nPdtsrqDdc/OB1RrlJ8p/oQRZaCftzm5hknlWLTIpL2jUFJ9GUjIOkm5vHzuXkbeOT3cDTbrVYV5TCWwy7iyAwct0nleTUSsOAt6eIM91cGGncGboduj/1nh19JiTms+rxPtK7QtYdGOUPugAgtCtDPnAHN6S7sGkm6lAzfh+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmJiAJ8tyZMZ2xRNEtGxTy+uupWjzi4dz5Hw5ISaYgE=;
 b=Fh8bntZPpyn4nv3V+c//zNUzzmWEM4jZ9HZX04ubftZ4Sjwz4qgQorLEpj3u4CwZpjMaEALOSwCgmqb62zTybUpdYo8OeXi9rT6h0whewjF4T532sN518R3AFRWX/E8IlsTY25I7dCnArsvWo+wdWIWGtCvzeJ/i2dBDM+FbRoE=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2172.eurprd03.prod.outlook.com (2603:10a6:3:1e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.30; Sat, 13 Feb 2021 12:27:00 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c18c:4a01:ca24:78c1]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c18c:4a01:ca24:78c1%5]) with mapi id 15.20.3846.031; Sat, 13 Feb 2021
 12:26:59 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saravanak@google.com" <saravanak@google.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Thread-Topic: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Thread-Index: AQHXAf+bFCY4blJH0Uy048cUlqVjwKpV//0AgAADEIA=
Date:   Sat, 13 Feb 2021 12:26:59 +0000
Message-ID: <0bf56f1c5eb8262bd734ceb81fc832655253adc0.camel@fi.rohmeurope.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <YCfDAly9b0zHMpJT@kroah.com>
In-Reply-To: <YCfDAly9b0zHMpJT@kroah.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49e37b2b-676f-40b3-6915-08d8d01aa937
x-ms-traffictypediagnostic: HE1PR0301MB2172:
x-microsoft-antispam-prvs: <HE1PR0301MB2172954D017D52CD9B540697AD8A9@HE1PR0301MB2172.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZOm1/seD2lQ3fyA3LjrFItX+COVr8blGM39aODk5S4XQW/Y5opUafaJk1hZfv73ylSlGjiNb2Zpb58xWeWICKm8D/gTlh0GR9ArIsVdnsQ6V1d+Dy0qHiH8lkfN8yRYaF2H7c1IcOmUL/zwYyTq4l2aujGX3B90xFzk0YJ12UGFbb16NBznrD82CJG0l0NLhqZPSa9X4j3nmyv+WUjPRyC1flFEnxcldWvc/oFthNfnQfpF7LQ3EOdnX3/cFoZUE8RfB5/oJY0m3w7nkMTjbgy8Dddg8sR/O9eY13v9J9SxPxndTSOyWdKdalMmKF5Opl5CPy1RR8noq+Ruv3HAMofUbHyWok9ewky5OwbZsXQWyfDWz2FJzcY0NFflnY25ExQkSze1LEV3QBW+Xu2SZJn6+iOsXgxNGe5VKDyStoTI1warjSKyDx/Nf+eHM8vsV1B8hwrWMzh6hwtkYy3KUIdDnTNz7yEPKWaOS/IvKelSB21mgCrTGdhe/fNIuJ0CjWO632hlUEmB/KYkoishbbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39830400003)(71200400001)(2906002)(8676002)(76116006)(6506007)(3450700001)(83380400001)(66476007)(64756008)(66446008)(4326008)(7416002)(6916009)(2616005)(478600001)(5660300002)(86362001)(54906003)(6512007)(316002)(66946007)(6486002)(186003)(66556008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QXR6M2JqZEFYbFJJc3hXQTcvN3dENExNTHpYdDVINUZ4Y3VzdjE3QUN0UEEw?=
 =?utf-8?B?Wmt4VXhRZ0t4SWhreVF4Q0hReWx4TXlGVjdmQnk5RGJSY3FwUmdEcnRaL2JT?=
 =?utf-8?B?djJGOFpTWTRudG9ZVkRFVjlYVFFsWS9WSUc0amRVT3dRWDZYYnM0WVFReSt3?=
 =?utf-8?B?bDQ3RjVCbmFRYzc0V0VqY2N2OXdTdU5TeUZ0YXNRTjBBbzFvQ0p2MmJIQzZ2?=
 =?utf-8?B?Qy94RzlZbVQxL1B1eFNXekJRL0pQVmxHR05JSEt0ajBhMkd0TVo1MGVxUnVn?=
 =?utf-8?B?blJsUHYra0dUSFJoVUtjSFdBclU3Q1ZYUEZLTkxCOUQ3ektHLzFhc3cxZVZW?=
 =?utf-8?B?bXJtb1lXTlpMa0NyRE5VUzRXVnRLL1YrWmRZQTgzUTVieEM0MnVDSlVlR2dw?=
 =?utf-8?B?UFlRcnhoS2kwN2U4anVUblZOaUprOGg2eW9VZGs3M1hBVWxGTDNDbXBka1Ba?=
 =?utf-8?B?S1BVWjF0dVZRU0dyWkF0OGtuUlJZbHlpb0RaSlpTSFE1TCszMmN5WW1NeC9j?=
 =?utf-8?B?OEVVcWpROFhid3ZwVlVweThvcWRiTDRMb1pnbHAvTkE2bEd2OHdld2hUMWp2?=
 =?utf-8?B?clZYTk9Oci9JUERUWTVaM1R2NWV6RE93MitpR05pRGZsUURScE5KbkFiUG1v?=
 =?utf-8?B?Zkt2djBiaEJKVnpQZjNsYTF0MW9PeU03dFJOSDZqeGhUdmwrVHZwelpCRHQ3?=
 =?utf-8?B?NjFtWXlrVE0yQXZuaHgwVk1VQTI3WlpodXFaSWlwNHJ3eGg2NDlscFhKbnk0?=
 =?utf-8?B?KzZxMXBKUHBsLzdUWGNlViszdXVDSUZnMFNkR25NK0ozUlpkM1FGNEhaR1dV?=
 =?utf-8?B?M0t5T3MrRmRsL0gxa2EvOTA2UGFEWTJuRkZycmd5MlRVTCtIZU9vbTZkTEtG?=
 =?utf-8?B?M3ZocjY1MVlJSHhiU0gwanFZcEFLaE1TNjJLOTNOSEdJcU5IWExLTG8rSnNl?=
 =?utf-8?B?Q2JjYy9Wd1h2RWlQdG9qUXh5UjRENVJNcWRJR3hQTFBtTFIrTlZ1VjlnNmMx?=
 =?utf-8?B?WWVUeVNkTzF4ZFEvb2JsVzR4L1JpdEJoZThQelBKZGRQY3NNVG55ZlZJQUE3?=
 =?utf-8?B?U1NyZnltNE9qK0h4ZHRvNHVDam1HYi84NVVhbkd1NEQ3SENic0xNbDc4UVlP?=
 =?utf-8?B?aU1GZ2dnM1JJZXc0Rnp0TUJYQWlJMFFRci9hOE1vVzFuOGY4NzVreHdvVzQ0?=
 =?utf-8?B?TDdLcEx0ZnUvMkhDY1ZzYWxOU29vUkk0UTI1ajlxdTRCaTAzS09JY2FJNEk1?=
 =?utf-8?B?cE1ldFo5Y2dDNTc4MkRTMVpkcmtTWGFjVStCTDlBbjJyWmlFM3dXUE1OUHNP?=
 =?utf-8?B?VWk2NUlaYldPOXBCdUVkUE02bVNsbitoZ2pSbG1SaFZMZnRRRjI1ZnlFTmdl?=
 =?utf-8?B?NHJSbUltMURlUGtmSmlBZTFHQWprVEhkNisvRTgxZXlmcm5YV3dHZEJZTWl1?=
 =?utf-8?B?WHJWdWpOVFJ4TWJLbnFvazBXU095cUtMcm93SzZTdmNLRkRuV3M3OXhHWHRX?=
 =?utf-8?B?WjlXaFVCVCszNmFlMTF5alRXOUlXdzBzRU9za2k2QmxhOXUyR3pUOVdBRjhj?=
 =?utf-8?B?S3lmaXcxeFMrWG1ic3lDVHU4QTVoWlVSZ2srVDRId0JKTTJKRExGRmxxUUgx?=
 =?utf-8?B?d3hvS1lvMzhONUNZakMySjdDN3FxeW9kWnVBQlkxamNCUFBNN3JGT3NNZDBK?=
 =?utf-8?B?WEtlZURQcURhdHE1WWs2c0tuSTR6empWWFBkUkhDNXhRVzZGQ05GUHZBUjRi?=
 =?utf-8?B?R28wbG1LeHFHaEhYTmVuaUFEZzYzV0JXbkV2c1hZampnazBKZ3FEUTJYM2ZK?=
 =?utf-8?Q?7uE00E8xM617tlUjnMjNKzo5HedXvVQAbQ+E8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8704ED98593ECF4D995BD30866B3DFD5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e37b2b-676f-40b3-6915-08d8d01aa937
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2021 12:26:59.7664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2ML2ysOPk4PouKot9CR52pmkTBLiRrsekRCWD3tIymJASudUGaWtSLxDItMbr0Z371/anRT5Ci4MG1oI3pC8CEc+jipZ3tOiXybEcBvfahqBql9XYL4HMpsFt5JZCxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2172
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBTYXQsIDIwMjEtMDItMTMgYXQgMTM6MTYgKzAxMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3
cm90ZToNCj4gT24gU2F0LCBGZWIgMTMsIDIwMjEgYXQgMDE6NTg6NDRQTSArMDIwMCwgTWF0dGkg
VmFpdHRpbmVuIHdyb3RlOg0KPiA+IEEgZmV3IGRyaXZlcnMgd2hpY2ggbmVlZCBhIGRlbGF5ZWQg
d29yay1xdWV1ZSBtdXN0IGNhbmNlbCB3b3JrIGF0DQo+ID4gZXhpdC4NCj4gPiBTb21lIG9mIHRo
b3NlIGltcGxlbWVudCByZW1vdmUgc29sZWx5IGZvciB0aGlzIHB1cnBvc2UuIEhlbHANCj4gPiBk
cml2ZXJzDQo+ID4gdG8gYXZvaWQgdW5uZWNlc3NhcnkgcmVtb3ZlIGFuZCBlcnJvci1icmFuY2gg
aW1wbGVtZW50YXRpb24gYnkNCj4gPiBhZGRpbmcNCj4gPiBtYW5hZ2VkIHZlcmlzaW9uIG9mIGRl
bGF5ZWQgd29yayBpbml0aWFsaXphdGlvbg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRp
IFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiANCj4gVGhh
dCdzIG5vdCBhIGdvb2QgaWRlYS4gIEFzIHRoaXMgd291bGQga2ljayBpbiB3aGVuIHRoZSBkZXZp
Y2UgaXMNCj4gcmVtb3ZlZCBmcm9tIHRoZSBzeXN0ZW0sIG5vdCB3aGVuIGl0IGlzIHVuYm91bmQg
ZnJvbSB0aGUgZHJpdmVyLA0KPiByaWdodD8NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmFz
ZS9kZXZyZXMuYyAgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
aW5jbHVkZS9saW51eC9kZXZpY2UuaCB8ICA1ICsrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
MzggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZGV2
cmVzLmMgYi9kcml2ZXJzL2Jhc2UvZGV2cmVzLmMNCj4gPiBpbmRleCBmYjlkNTI4OWE2MjAuLjI4
Nzk1OTViYjVhNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvZGV2cmVzLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2Jhc2UvZGV2cmVzLmMNCj4gPiBAQCAtMTIzMSwzICsxMjMxLDM2IEBAIHZv
aWQgZGV2bV9mcmVlX3BlcmNwdShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gdm9pZCBfX3BlcmNw
dSAqcGRhdGEpDQo+ID4gIAkJCSAgICAgICAodm9pZCAqKXBkYXRhKSk7DQo+ID4gIH0NCj4gPiAg
RVhQT1JUX1NZTUJPTF9HUEwoZGV2bV9mcmVlX3BlcmNwdSk7DQo+ID4gKw0KPiA+ICtzdGF0aWMg
dm9pZCBkZXZfZGVsYXllZF93b3JrX2Ryb3Aoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpyZXMp
DQo+ID4gK3sNCj4gPiArCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygqKHN0cnVjdCBkZWxheWVk
X3dvcmsgKiopcmVzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGRldm1fZGVs
YXllZF93b3JrX2F1dG9jYW5jZWwgLSBSZXNvdXJjZS1tYW5hZ2VkIHdvcmsgYWxsb2NhdGlvbg0K
PiA+ICsgKiBAZGV2OiBEZXZpY2Ugd2hpY2ggbGlmZXRpbWUgd29yayBpcyBib3VuZCB0bw0KPiA+
ICsgKiBAcGRhdGE6IHdvcmsgdG8gYmUgY2FuY2VsbGVkIHdoZW4gZGV2aWNlIGV4aXRzDQo+ID4g
KyAqDQo+ID4gKyAqIEluaXRpYWxpemUgd29yayB3aGljaCBpcyBhdXRvbWF0aWNhbGx5IGNhbmNl
bGxlZCB3aGVuIGRldmljZQ0KPiA+IGV4aXRzLg0KPiANCj4gVGhlcmUgaXMgbm8gc3VjaCB0aGlu
ZyBpbiB0aGUgZHJpdmVyIG1vZGVsIGFzICJ3aGVuIGRldmljZSBleGl0cyIuDQo+IFBsZWFzZSB1
c2UgdGhlIHByb3BlciB0ZXJtaW5vbG9neSBhcyBJIGRvIG5vdCB1bmRlcnN0YW5kIHdoYXQgeW91
DQo+IHRoaW5rDQo+IHRoaXMgaXMgZG9pbmcgaGVyZS4uLg0KPiANCj4gPiArICogQSBmZXcgZHJp
dmVycyBuZWVkIGRlbGF5ZWQgd29yayB3aGljaCBtdXN0IGJlIGNhbmNlbGxlZCBiZWZvcmUNCj4g
PiBkcml2ZXINCj4gPiArICogaXMgdW5sb2FkIHRvIGF2b2lkIGFjY2Vzc2luZyByZW1vdmVkIHJl
c291cmNlcy4NCj4gPiArICogZGV2bV9kZWxheWVkX3dvcmtfYXV0b2NhbmNlbCgpIGNhbiBiZSB1
c2VkIHRvIG9taXQgdGhlIGV4cGxpY2l0DQo+ID4gKyAqIGNhbmNlbGxlYXRpb24gd2hlbiBkcml2
ZXIgaXMgdW5sb2FkLg0KPiA+ICsgKi8NCj4gPiAraW50IGRldm1fZGVsYXllZF93b3JrX2F1dG9j
YW5jZWwoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gPiBkZWxheWVkX3dvcmsgKncsDQo+
ID4gKwkJCQkgdm9pZCAoKndvcmtlcikoc3RydWN0IHdvcmtfc3RydWN0DQo+ID4gKndvcmspKQ0K
PiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZGVsYXllZF93b3JrICoqcHRyOw0KPiA+ICsNCj4gPiArCXB0
ciA9IGRldnJlc19hbGxvYyhkZXZfZGVsYXllZF93b3JrX2Ryb3AsIHNpemVvZigqcHRyKSwNCj4g
PiBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghcHRyKQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0K
PiA+ICsNCj4gPiArCUlOSVRfREVMQVlFRF9XT1JLKHcsIHdvcmtlcik7DQo+ID4gKwkqcHRyID0g
dzsNCj4gPiArCWRldnJlc19hZGQoZGV2LCBwdHIpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0K
PiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGRldm1fZGVsYXllZF93b3JrX2F1dG9jYW5j
ZWwpOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmljZS5oIGIvaW5jbHVkZS9s
aW51eC9kZXZpY2UuaA0KPiA+IGluZGV4IDE3NzlmOTBlZWI0Yy4uMTkyNDU2MTk4ZGU3IDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2aWNlLmgNCj4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L2RldmljZS5oDQo+ID4gQEAgLTI3LDYgKzI3LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L3VpZGdpZC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZ2ZwLmg+DQo+ID4gICNpbmNsdWRlIDxs
aW51eC9vdmVyZmxvdy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvd29ya3F1ZXVlLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9kZXZpY2UvYnVzLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9kZXZp
Y2UvY2xhc3MuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS9kcml2ZXIuaD4NCj4gPiBA
QCAtMjQ5LDYgKzI1MCwxMCBAQCB2b2lkIF9faW9tZW0gKmRldm1fb2ZfaW9tYXAoc3RydWN0IGRl
dmljZQ0KPiA+ICpkZXYsDQo+ID4gIAkJCSAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsIGlu
dCBpbmRleCwNCj4gPiAgCQkJICAgIHJlc291cmNlX3NpemVfdCAqc2l6ZSk7DQo+ID4gIA0KPiA+
ICsvKiBkZWxheWVkIHdvcmsgd2hpY2ggaXMgY2FuY2VsbGVkIHdoZW4gZHJpdmVyIGV4aXRzICov
DQo+IA0KPiBOb3Qgd2hlbiB0aGUgImRyaXZlciBleGl0cyIuDQo+IA0KPiBUaGVyZSBpcyB0d28g
ZGlmZmVyZW50IGxpZmVzcGFucyBoZXJlICh3ZWxsIDMpLiAgQ29kZSBhbmQNCj4gZGF0YSoyLiAg
RG9uJ3QNCj4gY29uZnVzZSB0aGVtIGFzIHRoYXQgd2lsbCBqdXN0IGNhdXNlIGxvdHMgb2YgcHJv
YmxlbXMuDQo+IA0KPiBUaGUgbW92ZSB0b3dhcmQgbW9yZSBhbmQgbW9yZSAiZGV2bSIgZnVuY3Rp
b25zIGlzIG5vdCB0aGUgd2F5IHRvIGdvDQo+IGFzDQo+IHRoZXkganVzdCBtb3JlIGFuZCBtb3Jl
IG1ha2UgdGhpbmdzIGVhc2llciB0byBnZXQgd3JvbmcuDQo+IA0KPiBBUElzIHNob3VsZCBiZSBp
bXBvc3NpYmxlIHRvIGdldCB3cm9uZywgdGhpcyBvbmUgaXMgZ29pbmcgdG8gYmUNCj4gYWxtb3N0
DQo+IGltcG9zc2libGUgdG8gZ2V0IHJpZ2h0Lg0KDQpUaGFua3MgZm9yIHByb21wdCByZXBseS4g
SSBndWVzcyBJIG11c3QndmUgbWlzdW5kZXJzdG9vZCBzb21lIG9mIHRoaXMNCmNvbmNlcHQuIEZy
YW5rbHkgdG8gc2F5LCBJIGRvbid0IHVuZGVyc3RhbmQgaG93IHRoZSBkZXZtIGJhc2VkIGlycQ0K
bWFuYWdlbWVudCB3b3JrcyBhbmQgdGhpcyBkb2VzIG5vdC4gTWF5YmUgSSdkIGJldHRlciBzdHVk
eSB0aGlzIGZ1cnRoZXINCnRoZW4uDQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0K
