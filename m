Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731A9366A94
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhDUMSI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 08:18:08 -0400
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:17646
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239646AbhDUMSG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 08:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGbDNN6yb5F4q+FUWQ0Fir2DyVTT9uHARMHC2m7PF459qaq25vkaC1LavvaLolcYSV8mW9j9Bfy+sDBN6W5UV+WOHduMKtE7aWpVTj4cJng0+bkkDpjfN+0V3X3UynkT0bSmM77dSO3FdwL2HD9giFm03IIyQvHHjONKIEwVcRLtAeRJZjhpgu9cnmcVH1QmHYl/zduzqvE2COqbQoJywtYUOMzNAA23K3lKlosVQ1t6zWxhxFt/e1wP1eUd5XQs9uG03yApEHIe3AThWQZWDa69ytSa+WM+AfUqVgVIbnae4pDD/3soVUGiqfKWua7+0MD4ID3BjZ7iJdNled5OoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVHthfYadrf/jFkRfdlC8DuyDrKnCXXQKO3mhm7JAok=;
 b=OzD4KkiRwm1nKGaaD8CxLC+nM1sKpbXhwqNtPskWc9c8m97DdUbBgJ154j1VVtNFArFXDwZWOX/d7TfTItt1Biz1XQoSboUM5HyVKz6vtQmjGGGya5gP9VJ8i7M/GIbBgdfTpwioEaq/Jsm85KFL+NXUPn4UHld+RrKokx78T9q5WbcrxGuWfABSrs/90gDuf3/ZnzGvdtz+CEeGPUm3uGQlv8XbUyg/vvgp8hu7jeMoLmOlmu6MImaBOnVamN3vtVRBu+yiREuQNeRTie7AuKL4NQRrk77OoQy77FbaJGBwtx7MFtxL3VRul7Q3nDN2RBG+tn9u3VF9BPKUcmY1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVHthfYadrf/jFkRfdlC8DuyDrKnCXXQKO3mhm7JAok=;
 b=p5kuB8RsNOWMKOqCnLbaSaIowq9fL9Il0F0oBp10A4VaItbJMBLJiT/DqaZq2jetM3JzgYZX9GWQ+Bx4Jz/oSbY8FoSouv54OZXFosOXRShqmUQGRJt4osVqWUivr3rRaJWhXAcIYeMQwR1zTIX0P+SXKLfbU+rp44Mq4tyfj48=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2171.eurprd03.prod.outlook.com (2603:10a6:3:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Wed, 21 Apr 2021 12:17:28 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd%3]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 12:17:28 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
Thread-Topic: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
Thread-Index: AQHXH+xi61CpXgfyeUm0V+UG1OxzHKqRmVoAgAAF/ICALWwlmoAABUKA
Date:   Wed, 21 Apr 2021 12:17:28 +0000
Message-ID: <2f6d096c30a6d1d22422cf9c3553d74132f75708.camel@fi.rohmeurope.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
         <YFn5CSB1O3i+SzgR@kroah.com>
         <da0233f3223d7c0816581afe0969caf0abe20378.camel@fi.rohmeurope.com>
         <96935c55-c799-595e-024c-56fd352f279e@redhat.com>
In-Reply-To: <96935c55-c799-595e-024c-56fd352f279e@redhat.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a88b512-63c5-47de-907c-08d904bf6e53
x-ms-traffictypediagnostic: HE1PR0301MB2171:
x-microsoft-antispam-prvs: <HE1PR0301MB2171E4C4136F18B1C5704B71AD479@HE1PR0301MB2171.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGJ2GA0BaQwL5o0w0LhUG0Q4UVrUZfO1Pb9X9YJ+06LQeqjCeFg9+7wFkiV/N5PgHiqHImzQYJ6tk7kbE83OmlRo6u/nr7lwc+6WO4H99z8YxIUZqS9ZutJb9pk0vrsyR4fMjewvoWQzwhEMsnD2HbFxhjTBn2Z/sxbvBiU8XiUeOgp8nge2gNHoel9YlohdloYn4Bz+clQZAEnuWYL1W+1ywl4ISJyq86JZ/KDiBQ6DXvTB+RViGBcHIB0objHJTbJL7byhv4Z0cEiJMQGX8gAOivm9oIwrMLlq5pZVkFabvpx5ykUC+O27bfpugQm5LoJhHXWv6M7J1Kxhv0KqwxoLMvtLrAfGVfDO4eIZ3b3a3bVNQQWAVCvcGOl1vKPSawL3PPXt/LdZPDz2GSHD1U7QGU35orML+GDRsV4pW1+DOMAqjdJ/aGtPvzw7spFcgeOoiJVCfZ83UYltWIcmjCtmktSMS35e4ek/OXUsR8Qms8MiNtwEHJso1xpWxtO5q/J8oOFBGyuzHujqy5I/N0ovINQk8Q1dXyOkzzPODzLqjdOtNUlbpKMm/nHulktdmozxZGXEiaaWAsyJQReuFKQiswPZZS6JZQhD0PD16jzmEQi8Xc1DTzTnw7OtuvmhjhIk93hDe17Tevb6k6JY9pUGkI8r/HmlBzBPjOd/7Blo7amDqkKGOJf3/yox/mc5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(316002)(86362001)(122000001)(3450700001)(38100700002)(53546011)(2906002)(64756008)(71200400001)(4326008)(186003)(110136005)(8676002)(66476007)(66556008)(66446008)(5660300002)(2616005)(7416002)(966005)(76116006)(6486002)(8936002)(478600001)(66946007)(6506007)(54906003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aWxpaFh1QVNBbWtRN3lMZEphY3J0RTVpYnloM3dmaDBTSVRLMEZRMXBTb2hx?=
 =?utf-8?B?Nkdac21QRUlRNmtwMmVkTVNaUzVrb2pQMVJBSC9VdFlYK3k5R0dnaXpiTkNo?=
 =?utf-8?B?Wmg4RVhRdlJ6bm9PSkxDeHhpS2RzNlZlbk9ldVFzVDhtNDlabmo5OUk2eUw1?=
 =?utf-8?B?dEV6eUZtaEdNcXg4REJaUEpsb1kySnRCeHJ4bE9ZeU1keWFUNVppbG5UWW40?=
 =?utf-8?B?dlY2VnBJYm9vT1NBbTFRN2lyNDduSFpuODU5M1pyenVnbUNsQm1SN1pYZHkw?=
 =?utf-8?B?T3orcVBuaUV4b2ZvNWdwWmRLRnV2SzVVYTBSNGJaOUd1dmpjUTcwUVB5L05m?=
 =?utf-8?B?b1Z4ZzNCbURvWmFqczlpY2xVRUQ4U3FDK2hNb09sdXBtaDgxcTBHNWM5VURw?=
 =?utf-8?B?ZmgzdEJaVXAxRVNuS0gxbzR1ZDJXYzFkQ2RRaXJjSzVtYWwya0ZlWHZJRDdS?=
 =?utf-8?B?OU94dzduYWxDc093Wk1TRDI0YzhKN3JEcDBMMTNDaXk0K3N4Y1VXYmxTOXk0?=
 =?utf-8?B?V0Y5K0pXZTVYdjVuRlpmaDJDbFJHeFIxL2RSQzNhWEpaQUlvQTROV2R1Rno3?=
 =?utf-8?B?UHEvSVRMNjVINEU1czA2VXNyd3c0UHRGb2NIRXhSL2p4VWFxYkhNVTcvNE56?=
 =?utf-8?B?RzdQdDFWK2R1a1FxK0RXT2dBcCszUXRsTWFJd2o1Y2Qwc3BLN2FyRERmY1Fq?=
 =?utf-8?B?SGhLajdWNGlveGlTbzB6Zm9BYTFNTTRtSGl6ZW9mdXNoYlVsZUdDSnhRWVJQ?=
 =?utf-8?B?ZU14Rm1XN25zMVdvbUtrOHduVnU0dk5vU2pWWS9UY0hxWmJ2RHdzZHhPcEhP?=
 =?utf-8?B?bEJnNkZEZUFWVm85am9ZdUdxaHE5UlJ2TENQbytsMWpwSlllTWdXSzd4Y0Nh?=
 =?utf-8?B?RUUvY2JWMXNwMHQ2R3RFbzEzQkFQTElXV2JVOUZXY2VtclJFSlU3d3V4d3N5?=
 =?utf-8?B?MnZBQndlNnZOVGxaV2d4Y2dRblREbzlmOTdWWitjMVJ4bVJQVzEwb1l4STdW?=
 =?utf-8?B?TTVUZkE1eGNLaU1JR1Z1MWdhUVdERW5Rb1BPWkxMSlhVa3BsUHo3ckJpVk9V?=
 =?utf-8?B?bmJhVEVpb1dFbDJQTHBTOVdtODNyRE50OGc1VmZia2ZXeHluK1BGWCtHMkVM?=
 =?utf-8?B?TWloajcrdEV4MFlTMUxhY2t2TFVlc3l0ZU1Eb3g2bWJ1YnM1RjdZelJOdlpP?=
 =?utf-8?B?NkdlRjRJcFJORncxdlJiaGc4Z2pTMlI4d0hMeGFGYXB6TDBZdlRwYnVvWHpn?=
 =?utf-8?B?b3F5cVJnYWd4Vzh1YmxzS1dhbVB4NGkvWlhEcmF6b1d3Z2pZbGU1blAxV0xE?=
 =?utf-8?B?Sm5ZM1cwWmdYdUZUZVpDUUJnV2VoYTcwMHV0T2dNN3NZQ1ZyN3RTUDc4R2NU?=
 =?utf-8?B?YTBnVEZtcGxTdnRxQ1AvTE9qU2haL0tYYjlGaE9GVlFMcitpTHQ4b3NIQytW?=
 =?utf-8?B?YlBzRHJab3F1M0gxUXBkZEdOVE0wVEZKSWFlS2RGQjJjaVk2ckpha1RQWlp4?=
 =?utf-8?B?MUVVRk9EVlMxQWVLZ3E2UVlSY3R3bjZPc0tWQTROcVdTVmUrT2lNWVVHK284?=
 =?utf-8?B?MWlDWGdDUStXNUt1d2FIdUROY21lL2lsQ3BFRjRmekdOdEs1Qm9nQnBCcGFR?=
 =?utf-8?B?Tk8xVGxNOXZ3ZWFEZ3kwVkM1b2ovVGQxRUJxSDE3U0U0SmdhOU52NHpLVU9I?=
 =?utf-8?B?Y3BOLzZGS1BaL0dpUWJ3S2p5ODFFejA2emltYzdKRUlxUnp0QzJRM0VxUnVR?=
 =?utf-8?B?WmYvVlR4WEExQlpmYUkyNXduZWI5alBNZzBNYTdvNUl1bDhqekkwK0ZKU2VV?=
 =?utf-8?Q?7sCzpgQiuOCfV7b28gjEa5dntAS/AJy8kMhsI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <959386FBA1E5004782EE25B5B7D07C2C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a88b512-63c5-47de-907c-08d904bf6e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 12:17:28.5301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCnxdBnE3eCLvjeFwdNNdHACRO7XHm3j+ZYOwU6ISkkWT8vI/C65iSP54MdDSCj77xP75u7vKBf3s+ff26mgYj4/a+jyONMyKauKRiuIA1+FydHkWfbj9SpDs2a+59UA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2171
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBXZWQsIDIwMjEtMDQtMjEgYXQgMTM6NTggKzAyMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6
DQo+IEhpLA0KPiANCj4gT24gNC8yMS8yMSA5OjUxIEFNLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6
DQo+ID4gT24gVHVlLCAyMDIxLTAzLTIzIGF0IDE1OjE5ICswMTAwLCBHcmVnIEtIIHdyb3RlOg0K
PiA+ID4gT24gVHVlLCBNYXIgMjMsIDIwMjEgYXQgMDI6NTg6MjhQTSArMDEwMCwgSGFucyBkZSBH
b2VkZSB3cm90ZToNCj4gPiA+ID4gSGksDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiAzLzIzLzIxIDI6
NTYgUE0sIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiA+ID4gPiBEZXZtIGhlbHBlciBoZWFk
ZXIgY29udGFpbmluZyBzbWFsbCBpbmxpbmUgaGVscGVycyB3YXMgYWRkZWQuDQo+ID4gPiA+ID4g
SGFucyBwcm9taXNlZCB0byBtYWludGFpbiBpdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZGQg
SGFucyBhcyBtYWludGFpbmVyIGFuZCBteXNlbGYgYXMgZGVzaWduYXRlZCByZXZpZXdlci4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gVWx0aW1hdGVseSB0aGlzIGlzIHVwIHRvIEdyZWcgdGhvdWdoLCBz
byBsZXRzIHdhaXQgYW5kIHNlZSB3aGF0DQo+ID4gPiA+IEdyZWcgaGFzIHRvIHNheSBhYm91dCB0
aGlzLg0KPiA+ID4gDQo+ID4gPiBDYW4gd2UgbW92ZSBzb21lIG9mIHRoZSBkZXZtXyogY2FsbHMg
aW4gaW5jbHVkZS9kZXZpY2UuaCBpbnRvDQo+ID4gPiBoZXJlIGFzDQo+ID4gPiB3ZWxsIHNvIHRo
YXQgeW91IGFsbCBjYW4gYmUgaW4gY2hhcmdlIG9mIHRoZW0gaW5zdGVhZCBvZiBtZT8NCj4gPiAN
Cj4gPiBTZWVtcyBsaWtlIHRoaXMgd2FzIGxlZnQgdy9vIGFuc3dlci4gSSBndWVzcyB0aGUgcXVl
c3Rpb24gd2FzDQo+ID4gcG9pbnRlZA0KPiA+IHRvIEhhbnMNCj4gDQo+IEkgYmVsaWV2ZSB0aGF0
IEdyZWcgd2FzIChtb3N0bHkpIGpva2luZyBoZXJlLiBBdCBsZWFzdCB0aGF0IGlzIGhvdw0KPiBJ
IGludGVycHJldGVkIEdyZWcncyByZXBseSx3aGljaCBpcyB3aHkgSSBkaWQgbm90IGFuc3dlci4N
Cg0KQWguIEkgbWlzc2VkIHRoZSBzYXJjYXN0aWMgdG9uZSBvZiB0eXBpbmcuIEkgc2hvdWxkJ3Zl
IG5vdGVkIHRoYXQgYnkNCnRoZSBmb250IDpdDQoNCj4gQWxzbyBub3RlIHRoYXQgR3JlZyBtZXJn
ZWQgdGhpcyBzZXJpZXMsIGJ1dCBub3QgdGhpcyBwYXRjaCwNCj4gc28gdGhlIG5ldyBkZXZtLWhl
bHBlcnMuaCBmaWxlIHdpbGwgcHJlc3VtYWJseSBiZSBtYWludGFpbmVkIGJ5IEdyZWcuDQoNCkht
bS4gQXJlIHlvdSBzdXJlPw0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvZ3JlZ2toL2RyaXZlci1jb3JlLmdpdC9jb21taXQvP2g9ZHJpdmVyLWNvcmUtbmV4
dCZpZD0yMDc3Y2E2ODIxNjlhZmIyMTJkOGE4ODdjNzAwNTdhNjYwMjkwZGY5DQoNCg0KQmVzdCBS
ZWdhcmRzDQoJTWF0dGkgVmFpdHRpbmVuDQo=
