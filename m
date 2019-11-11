Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6589DF7685
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKKOhY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 09:37:24 -0500
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:44430
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfKKOhX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 09:37:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6Pk8e63a6AZGxEeHxTdR5u3Uad57b6X4skuYh9TWMv+JyOyIJ6p4FnVqXvmN3W6AKq3yYdHYdWrkEErLxoKlGWeSMWqlGGrCNlvd0JZvAzO6w0w42Q89esgMUwnFa9bPtvPx7SYlfZpkL40Y5yDcFC5GZ+gtXggFDtWhiduw4uVBE2wMZamB1sDOcMHi4V74olWR2vbtkUFWqL8Da2JG5G6WeiXOkAV+MuUAxuyriQ1ZeOXu5zHkqRwQ/mV0an/pC5pNboU8DaKCaQm/mcNddiuNTiuVP/a7TkySdoHKIkYW8vQMRz1lvpP3bJyZiNwn898Fefatws3nvz9fJ9eDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MzICkuvu+0G7PiSLPCO6rP9cO6cf3FZIhjdPnae6u8=;
 b=DS/If0MTPewy/tP7yi/uNWNir6zHwZR8Cj+7nmWYFEkPlR+UCwBH7PPEXvySZRdcFh3Ioa3rGVt5eqefiCuBu5wrAud07WLkYkYT+r1pTamD6BwI+WpMXQvK1QIzYBcdCOY7449c+pgmfb00DPAjATZCFe6tGpHLhlOH/ZPgpuaAHiGDFYqTYuT2kACIAJ8Kt0uHod6lbkTP8W/vV88L6uc6vcn6swmO495ASSZjGueX+VTa0JcrIfoUsDugkF+stW9wPV2446laxyPBI0n6sEdlujfEDC3yFj2sii7J5i7cbBxDt1xaltKHNGzgxjKp4teyOD9Yuf/hB0NhdMjYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MzICkuvu+0G7PiSLPCO6rP9cO6cf3FZIhjdPnae6u8=;
 b=onJ8bJ21qLJmqHmlWqw1h1dbY6nBtnSEnP3Slui+ip4DK8t4jyWk5i5o45WyoAFvE1p4WsVPjMZemgd6C38q0J132rrw+xz70p90IxhFZl0Xxh9+8ClvRmbIyU/0pW6J+SE/FpkyWIcdFUtiiXbfTX9dSVYIs4oSt2dnIJK32U8=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5776.eurprd04.prod.outlook.com (20.178.127.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 14:37:18 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 14:37:18 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "a.swigon@partner.samsung.com" <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "saravanak@google.com" <saravanak@google.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        "abailon@baylibre.com" <abailon@baylibre.com>
Subject: Re: [PATCH v10 09/11] PM / devfreq: Introduce get_freq_range helper
Thread-Topic: [PATCH v10 09/11] PM / devfreq: Introduce get_freq_range helper
Thread-Index: AQHVkDMAXQ4IQOa+qUm4gPpqDKMD2aeFiTYAgACRagA=
Date:   Mon, 11 Nov 2019 14:37:17 +0000
Message-ID: <914b491c38aa7130cbf0c76203cdb7dd92a42299.camel@nxp.com>
References: <cover.1572556786.git.leonard.crestez@nxp.com>
         <CGME20191031213445epcas1p27e2afe33522f95e9b77db3d9fec62028@epcas1p2.samsung.com>
         <6fd2ab4b54f5cd3a02b3f5f8aae5e776485441e3.1572556786.git.leonard.crestez@nxp.com>
         <b6662a88-af9b-6948-a1ea-921a10ca937d@samsung.com>
In-Reply-To: <b6662a88-af9b-6948-a1ea-921a10ca937d@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50795520-fe0b-4d7e-a312-08d766b4a726
x-ms-traffictypediagnostic: VI1PR04MB5776:|VI1PR04MB5776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5776957F5E54D18A3403A6A6EE740@VI1PR04MB5776.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(7416002)(25786009)(476003)(91956017)(11346002)(81156014)(81166006)(66446008)(446003)(66476007)(66946007)(76116006)(64756008)(2906002)(8676002)(2616005)(2501003)(50226002)(66556008)(6506007)(53546011)(478600001)(44832011)(256004)(14444005)(14454004)(8936002)(36756003)(4001150100001)(76176011)(486006)(102836004)(5660300002)(186003)(7736002)(99286004)(316002)(6512007)(110136005)(54906003)(6436002)(305945005)(26005)(229853002)(71200400001)(71190400001)(6486002)(118296001)(4326008)(86362001)(6246003)(2201001)(66066001)(3846002)(6116002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5776;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fqi86ICryedIQszrZ/0TxFpNOXG5Ory0z0jznREnnLvpAb2k/FiMOewavmT5VRDlp1Y0Rerv02bmZ6dmDJ4IR/2KD0IYQYXzEUCBsXosZP+trbjDMZTkuYMxNVuaox7VGtZuf3oFsyelav9Vtn3KuhoPHf1HDCVjH1hKk+jBgZABWTgunk0uJsDJ569Me7HjIERBsmV5ywhsw0N8ExhVzqMv/03ZrhF3ohXI6gIpjTpSWL+q9wSNKp6tBArTMIKBblnWlt4RNXoLbDgkHB06qQAkQwOpVix14WciLd6X9Loh01XLK6poW+HlZYj/8d21O1gil10B3/quilFdXuedZSdXpdFy/eVN0CPKzFdS+8ud+LN3acHKYZW/0XIOrBqPoiJZVNdmG+gsqCe+za5jV7YbAzcKXIH+g7ACozHTwDBqmP12+UJRHuQlPHKkiQCv
Content-Type: text/plain; charset="utf-8"
Content-ID: <071FB3986A23254ABA78842DA07FA7D0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50795520-fe0b-4d7e-a312-08d766b4a726
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 14:37:17.9453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gev3H8qai9xc0GjwuDPpmcwILwjqabdu66JTg50e580eYENuUJTAjeNWSE9qMjbyIv/0ZllNZbCjPdT3rBOBdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5776
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTExIGF0IDE0OjU2ICswOTAwLCBDaGFud29vIENob2kgd3JvdGU6DQo+
IE9uIDExLzEvMTkgNjozNCBBTSwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOg0KPiA+IE1vdmluZyBo
YW5kbGluZyBvZiBtaW4vbWF4IGZyZXEgdG8gYSBzaW5nbGUgZnVuY3Rpb24gYW5kIGNhbGwgaXQg
ZnJvbQ0KPiA+IHVwZGF0ZV9kZXZmcmVxIGFuZCBmb3IgcHJpbnRpbmcgbWluL21heCBmcmVxIHZh
bHVlcyBpbiBzeXNmcy4NCj4gPiANCj4gPiBUaGlzIGNoYW5nZXMgdGhlIGJlaGF2aW9yIG9mIG91
dC1vZi1yYW5nZSBtaW5fZnJlcS9tYXhfZnJlcTogY2xhbXBpbmcNCj4gPiBpcyBub3cgZG9uZSBh
dCBldmFsdWF0aW9uIHRpbWUuIFRoaXMgbWVhbnMgdGhhdCBpZiBhbiBvdXQtb2YtcmFuZ2UNCj4g
PiBjb25zdHJhaW50IGlzIGltcG9zZWQgYnkgc3lzZnMgYW5kIGl0IGxhdGVyIGJlY29tZXMgdmFs
aWQgdGhlbiBpdCB3aWxsDQo+ID4gYmUgZW5mb3JjZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCj4gPiBSZXZpZXdl
ZC1ieTogTWF0dGhpYXMgS2FlaGxja2UgPG1rYUBjaHJvbWl1bS5vcmc+DQo+ID4gUmV2aWV3ZWQt
Ynk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgMTA4ICsrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCA0OCBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2RldmZy
ZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMNCj4gPiBpbmRleCBhYjEyZmQyMmFhMDgu
LmJhM2I1M2VlMjNmZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5j
DQo+ID4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KPiA+IEBAIC05NiwxMCArOTYs
NTEgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgZmluZF9hdmFpbGFibGVfbWF4X2ZyZXEoc3RydWN0
IGRldmZyZXEgKmRldmZyZXEpDQo+ID4gIAkJZGV2X3BtX29wcF9wdXQob3BwKTsNCj4gPiAgDQo+
ID4gIAlyZXR1cm4gbWF4X2ZyZXE7DQo+ID4gIH0NCj4gPiAgDQo+ID4gKy8qKg0KPiA+ICsgKiBn
ZXRfZnJlcV9yYW5nZSgpIC0gR2V0IHRoZSBjdXJyZW50IGZyZXEgcmFuZ2UNCj4gPiArICogQGRl
dmZyZXE6CXRoZSBkZXZmcmVxIGluc3RhbmNlDQo+ID4gKyAqIEBtaW5fZnJlcToJdGhlIG1pbiBm
cmVxdWVuY3kNCj4gPiArICogQG1heF9mcmVxOgl0aGUgbWF4IGZyZXF1ZW5jeQ0KPiA+ICsgKg0K
PiA+ICsgKiBUaGlzIHRha2VzIGludG8gY29uc2lkZXJhdGlvbiBhbGwgY29uc3RyYWludHMuDQo+
ID4gKyAqLw0KPiA+ICtzdGF0aWMgdm9pZCBnZXRfZnJlcV9yYW5nZShzdHJ1Y3QgZGV2ZnJlcSAq
ZGV2ZnJlcSwNCj4gPiArCQkJICAgdW5zaWduZWQgbG9uZyAqbWluX2ZyZXEsDQo+ID4gKwkJCSAg
IHVuc2lnbmVkIGxvbmcgKm1heF9mcmVxKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBsb25nICpm
cmVxX3RhYmxlID0gZGV2ZnJlcS0+cHJvZmlsZS0+ZnJlcV90YWJsZTsNCj4gPiArDQo+ID4gKwls
b2NrZGVwX2Fzc2VydF9oZWxkKCZkZXZmcmVxLT5sb2NrKTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+
ICsJICogSW5pdGlhbGl6ZSBtaW5pbXVtL21heGltdW0gZnJlcXVlbmN5IGZyb20gZnJlcSB0YWJs
ZS4NCj4gPiArCSAqIFRoZSBkZXZmcmVxIGRyaXZlcnMgY2FuIGluaXRpYWxpemUgdGhpcyBpbiBl
aXRoZXIgYXNjZW5kaW5nIG9yDQo+ID4gKwkgKiBkZXNjZW5kaW5nIG9yZGVyIGFuZCBkZXZmcmVx
IGNvcmUgc3VwcG9ydHMgYm90aC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKGZyZXFfdGFibGVbMF0g
PCBmcmVxX3RhYmxlW2RldmZyZXEtPnByb2ZpbGUtPm1heF9zdGF0ZSAtIDFdKSB7DQo+ID4gKwkJ
Km1pbl9mcmVxID0gZnJlcV90YWJsZVswXTsNCj4gPiArCQkqbWF4X2ZyZXEgPSBmcmVxX3RhYmxl
W2RldmZyZXEtPnByb2ZpbGUtPm1heF9zdGF0ZSAtIDFdOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiAr
CQkqbWluX2ZyZXEgPSBmcmVxX3RhYmxlW2RldmZyZXEtPnByb2ZpbGUtPm1heF9zdGF0ZSAtIDFd
Ow0KPiA+ICsJCSptYXhfZnJlcSA9IGZyZXFfdGFibGVbMF07DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJLyogQXBwbHkgY29uc3RyYWludHMgZnJvbSBzeXNmcyAqLw0KPiA+ICsJKm1pbl9mcmVxID0g
bWF4KCptaW5fZnJlcSwgZGV2ZnJlcS0+bWluX2ZyZXEpOw0KPiA+ICsJKm1heF9mcmVxID0gbWlu
KCptYXhfZnJlcSwgZGV2ZnJlcS0+bWF4X2ZyZXEpOw0KPiA+ICsNCj4gPiArCS8qIEFwcGx5IGNv
bnN0cmFpbnRzIGZyb20gT1BQIGludGVyZmFjZSAqLw0KPiA+ICsJKm1pbl9mcmVxID0gbWF4KCpt
aW5fZnJlcSwgZGV2ZnJlcS0+c2NhbGluZ19taW5fZnJlcSk7DQo+ID4gKwkqbWF4X2ZyZXEgPSBt
aW4oKm1heF9mcmVxLCBkZXZmcmVxLT5zY2FsaW5nX21heF9mcmVxKTsNCj4gPiArDQo+ID4gKwlp
ZiAoKm1pbl9mcmVxID4gKm1heF9mcmVxKQ0KPiA+ICsJCSptaW5fZnJlcSA9ICptYXhfZnJlcTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIGRldmZyZXFfZ2V0X2ZyZXFfbGV2ZWwo
KSAtIExvb2t1cCBmcmVxX3RhYmxlIGZvciB0aGUgZnJlcXVlbmN5DQo+ID4gICAqIEBkZXZmcmVx
Ogl0aGUgZGV2ZnJlcSBpbnN0YW5jZQ0KPiA+ICAgKiBAZnJlcToJdGhlIHRhcmdldCBmcmVxdWVu
Y3kNCj4gPiAgICovDQo+ID4gQEAgLTM0OCwyMCArMzg5LDExIEBAIGludCB1cGRhdGVfZGV2ZnJl
cShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkNCj4gPiAgDQo+ID4gIAkvKiBSZWV2YWx1YXRlIHRo
ZSBwcm9wZXIgZnJlcXVlbmN5ICovDQo+ID4gIAllcnIgPSBkZXZmcmVxLT5nb3Zlcm5vci0+Z2V0
X3RhcmdldF9mcmVxKGRldmZyZXEsICZmcmVxKTsNCj4gPiAgCWlmIChlcnIpDQo+ID4gIAkJcmV0
dXJuIGVycjsNCj4gPiAtDQo+ID4gLQkvKg0KPiA+IC0JICogQWRqdXN0IHRoZSBmcmVxdWVuY3kg
d2l0aCB1c2VyIGZyZXEsIFFvUyBhbmQgYXZhaWxhYmxlIGZyZXEuDQo+ID4gLQkgKg0KPiA+IC0J
ICogTGlzdCBmcm9tIHRoZSBoaWdoZXN0IHByaW9yaXR5DQo+ID4gLQkgKiBtYXhfZnJlcQ0KPiA+
IC0JICogbWluX2ZyZXENCj4gPiAtCSAqLw0KPiA+IC0JbWF4X2ZyZXEgPSBtaW4oZGV2ZnJlcS0+
c2NhbGluZ19tYXhfZnJlcSwgZGV2ZnJlcS0+bWF4X2ZyZXEpOw0KPiA+IC0JbWluX2ZyZXEgPSBt
YXgoZGV2ZnJlcS0+c2NhbGluZ19taW5fZnJlcSwgZGV2ZnJlcS0+bWluX2ZyZXEpOw0KPiA+ICsJ
Z2V0X2ZyZXFfcmFuZ2UoZGV2ZnJlcSwgJm1pbl9mcmVxLCAmbWF4X2ZyZXEpOw0KPiA+ICANCj4g
PiAgCWlmIChmcmVxIDwgbWluX2ZyZXEpIHsNCj4gPiAgCQlmcmVxID0gbWluX2ZyZXE7DQo+ID4g
IAkJZmxhZ3MgJj0gfkRFVkZSRVFfRkxBR19MRUFTVF9VUFBFUl9CT1VORDsgLyogVXNlIEdMQiAq
Lw0KPiA+ICAJfQ0KPiA+IEBAIC0xMjkyLDQwICsxMzI0LDI4IEBAIHN0YXRpYyBzc2l6ZV90IG1p
bl9mcmVxX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmF0dHIsDQo+ID4gIAlyZXQgPSBzc2NhbmYoYnVmLCAiJWx1IiwgJnZhbHVlKTsNCj4gPiAgCWlm
IChyZXQgIT0gMSkNCj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAgDQo+ID4gIAltdXRleF9s
b2NrKCZkZi0+bG9jayk7DQo+ID4gLQ0KPiA+IC0JaWYgKHZhbHVlKSB7DQo+ID4gLQkJaWYgKHZh
bHVlID4gZGYtPm1heF9mcmVxKSB7DQo+ID4gLQkJCXJldCA9IC1FSU5WQUw7DQo+ID4gLQkJCWdv
dG8gdW5sb2NrOw0KPiA+IC0JCX0NCj4gPiAtCX0gZWxzZSB7DQo+ID4gLQkJdW5zaWduZWQgbG9u
ZyAqZnJlcV90YWJsZSA9IGRmLT5wcm9maWxlLT5mcmVxX3RhYmxlOw0KPiA+IC0NCj4gPiAtCQkv
KiBHZXQgbWluaW11bSBmcmVxdWVuY3kgYWNjb3JkaW5nIHRvIHNvcnRpbmcgb3JkZXIgKi8NCj4g
PiAtCQlpZiAoZnJlcV90YWJsZVswXSA8IGZyZXFfdGFibGVbZGYtPnByb2ZpbGUtPm1heF9zdGF0
ZSAtIDFdKQ0KPiA+IC0JCQl2YWx1ZSA9IGZyZXFfdGFibGVbMF07DQo+ID4gLQkJZWxzZQ0KPiA+
IC0JCQl2YWx1ZSA9IGZyZXFfdGFibGVbZGYtPnByb2ZpbGUtPm1heF9zdGF0ZSAtIDFdOw0KPiA+
IC0JfQ0KPiA+IC0NCj4gPiAgCWRmLT5taW5fZnJlcSA9IHZhbHVlOw0KPiA+ICAJdXBkYXRlX2Rl
dmZyZXEoZGYpOw0KPiA+IC0JcmV0ID0gY291bnQ7DQo+ID4gLXVubG9jazoNCj4gPiAgCW11dGV4
X3VubG9jaygmZGYtPmxvY2spOw0KPiA+IC0JcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gY291bnQ7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBzc2l6ZV90IG1pbl9mcmVxX3No
b3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4g
PiAgCQkJICAgICBjaGFyICpidWYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkZXZmcmVxICpkZiA9
IHRvX2RldmZyZXEoZGV2KTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgbWluX2ZyZXEsIG1heF9mcmVx
Ow0KPiA+ICANCj4gPiAtCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVsdVxuIiwgbWF4KGRmLT5zY2Fs
aW5nX21pbl9mcmVxLCBkZi0+bWluX2ZyZXEpKTsNCj4gPiArCW11dGV4X2xvY2soJmRmLT5sb2Nr
KTsNCj4gPiArCWdldF9mcmVxX3JhbmdlKGRmLCAmbWluX2ZyZXEsICZtYXhfZnJlcSk7DQo+ID4g
KwltdXRleF91bmxvY2soJmRmLT5sb2NrKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gc3ByaW50Zihi
dWYsICIlbHVcbiIsIG1pbl9mcmVxKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHNzaXpl
X3QgbWF4X2ZyZXFfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJp
YnV0ZSAqYXR0ciwNCj4gPiAgCQkJICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQp
DQo+ID4gIHsNCj4gPiBAQCAtMTMzNyw0MCArMTM1NywzMiBAQCBzdGF0aWMgc3NpemVfdCBtYXhf
ZnJlcV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLA0KPiA+ICAJaWYgKHJldCAhPSAxKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAN
Cj4gPiAgCW11dGV4X2xvY2soJmRmLT5sb2NrKTsNCj4gPiAgDQo+ID4gLQlpZiAodmFsdWUpIHsN
Cj4gPiAtCQlpZiAodmFsdWUgPCBkZi0+bWluX2ZyZXEpIHsNCj4gPiAtCQkJcmV0ID0gLUVJTlZB
TDsNCj4gPiAtCQkJZ290byB1bmxvY2s7DQo+ID4gLQkJfQ0KPiA+IC0JfSBlbHNlIHsNCj4gPiAt
CQl1bnNpZ25lZCBsb25nICpmcmVxX3RhYmxlID0gZGYtPnByb2ZpbGUtPmZyZXFfdGFibGU7DQo+
ID4gLQ0KPiA+IC0JCS8qIEdldCBtYXhpbXVtIGZyZXF1ZW5jeSBhY2NvcmRpbmcgdG8gc29ydGlu
ZyBvcmRlciAqLw0KPiA+IC0JCWlmIChmcmVxX3RhYmxlWzBdIDwgZnJlcV90YWJsZVtkZi0+cHJv
ZmlsZS0+bWF4X3N0YXRlIC0gMV0pDQo+ID4gLQkJCXZhbHVlID0gZnJlcV90YWJsZVtkZi0+cHJv
ZmlsZS0+bWF4X3N0YXRlIC0gMV07DQo+ID4gLQkJZWxzZQ0KPiA+IC0JCQl2YWx1ZSA9IGZyZXFf
dGFibGVbMF07DQo+ID4gLQl9DQo+ID4gKwlpZiAoIXZhbHVlKQ0KPiA+ICsJCXZhbHVlID0gVUxP
TkdfTUFYOw0KPiA+ICANCj4gPiAgCWRmLT5tYXhfZnJlcSA9IHZhbHVlOw0KPiA+ICAJdXBkYXRl
X2RldmZyZXEoZGYpOw0KPiA+IC0JcmV0ID0gY291bnQ7DQo+ID4gLXVubG9jazoNCj4gPiAgCW11
dGV4X3VubG9jaygmZGYtPmxvY2spOw0KPiA+IC0JcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwly
ZXR1cm4gY291bnQ7DQo+ID4gIH0NCj4gPiAgc3RhdGljIERFVklDRV9BVFRSX1JXKG1pbl9mcmVx
KTsNCj4gPiAgDQo+ID4gIHN0YXRpYyBzc2l6ZV90IG1heF9mcmVxX3Nob3coc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPiAgCQkJICAgICBjaGFy
ICpidWYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkZXZmcmVxICpkZiA9IHRvX2RldmZyZXEoZGV2
KTsNCj4gPiArCXVuc2lnbmVkIGxvbmcgbWluX2ZyZXEsIG1heF9mcmVxOw0KPiA+ICsNCj4gPiAr
CW11dGV4X2xvY2soJmRmLT5sb2NrKTsNCj4gPiArCWdldF9mcmVxX3JhbmdlKGRmLCAmbWluX2Zy
ZXEsICZtYXhfZnJlcSk7DQo+ID4gKwltdXRleF91bmxvY2soJmRmLT5sb2NrKTsNCj4gPiAgDQo+
ID4gLQlyZXR1cm4gc3ByaW50ZihidWYsICIlbHVcbiIsIG1pbihkZi0+c2NhbGluZ19tYXhfZnJl
cSwgZGYtPm1heF9mcmVxKSk7DQo+ID4gKwlyZXR1cm4gc3ByaW50ZihidWYsICIlbHVcbiIsIG1h
eF9mcmVxKTsNCj4gPiAgfQ0KPiA+ICBzdGF0aWMgREVWSUNFX0FUVFJfUlcobWF4X2ZyZXEpOw0K
PiA+ICANCj4gPiAgc3RhdGljIHNzaXplX3QgYXZhaWxhYmxlX2ZyZXF1ZW5jaWVzX3Nob3coc3Ry
dWN0IGRldmljZSAqZCwNCj4gPiAgCQkJCQkgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LA0KPiA+IA0KPiANCj4gQXBwbGllZCBpdCBiZWNhdXNlIGl0IGRvZXNuJ3QgZGVwZW5kIG9uIHRo
ZSBwbV9xb3MgZmVhdHVyZS4NCg0KVGhhbmtzLCB0aGlzIHdpbGwgbWFrZSBpdCBlYXNpZXIgdG8g
bW92ZSBmb3J3YXJkLg0KDQotLQ0KUmVnYXJkcywNCkxlb25hcmQNCg==
