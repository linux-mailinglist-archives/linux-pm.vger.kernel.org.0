Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4EEB0E9
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 14:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJaNNF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 09:13:05 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:57764
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfJaNNF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 09:13:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibG+G38RzxLuY89xCJ7+y9+Co4vWNZT2ZtJj7BIxICcLnjDAaKULxwZITKowe9jA9ewKz8Ye2HXQaIEMyOMEDlM5LSoRDXP6visMGBf2jMZDF/fr017P4uC0fCd43a5nnxdQtCRy42VD0Vwvj8qFqopesVtezzTyTTghXEPqx2fE4pXf9hZ65fOKvmsB5nPgtgXe5QYsTLHHUDE2GlVkLGnHY4z9VxjBVdgUISIdkOYwZC/bC1tl8w63MX4Y7l/WzTIN4TeoOIqqevtJvnm/0pvn/wKEYGHsV447gfCSTqGMUTquSG1vvbZicew1vAOHWNOdcwH0xgjNSo9EKav84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63CePQIZ/qdegEEdCpetiRa4QjRtNweme8EFfLBUTLE=;
 b=a2mTMfZoqxnm9uecImUD1WWl09R+8aYREH8sDaH8A7mRhi+vd0q3oXMDQCpXjVHGQj3jQPr9sz7gqzM8ZXGeHvNuTCG2Y3hVn4om+HXC5G2zTpbQm9UTRm6HJ2Otw9Km42gVswebrDUAq9AxxxDAOGm9wQgXgMonYhanTSMsdB41uF21S2GJy4NzpOEFpYkjb/XnCC64RxkDHN+M9LNpfC65Hotmb8BvjzD+HYaL4rPwXMK0Ts+cy7yF9kJl63YxPn1+x0I6aKkwxFJHqVj6z9VbSK7snA+ybsEhjcbknisTKmfWxw36Sx5j4SJHXDe1Yjs8GMHPnt8MA8qa9U6Yww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63CePQIZ/qdegEEdCpetiRa4QjRtNweme8EFfLBUTLE=;
 b=oRUmN4xNZcEtPVoUVAebw6nFtCOBgWg6S/3wwBpt3oghpn8KKNmWGLpq8N4/HQbuKH4eTgKBhGJ/5pRBJ1TeYwlvBRGJca69ryOlAjh/YPHXpn6ffjDGRB64wpT8NBSXe3GdBldZyV7pnlGizNFDE6hS8vw+OA5+7cxSNoqhEDU=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4671.eurprd04.prod.outlook.com (20.177.56.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 31 Oct 2019 13:12:58 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 13:12:58 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
CC:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
Thread-Topic: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
Thread-Index: AQHVeVcjG1LoKlXGikmvzB33amMNOQ==
Date:   Thu, 31 Oct 2019 13:12:58 +0000
Message-ID: <VI1PR04MB702322FBAD1EB3F7C9AB8B9CEE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <CGME20191002192528epcas4p4d6fd2e70c8ffe0fd319990c744ddd8d2@epcas4p4.samsung.com>
 <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
 <a4b4c295-b230-5f15-61a2-d0e826584393@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: affd1da9-06dd-479b-ca1f-08d75e040d0c
x-ms-traffictypediagnostic: VI1PR04MB4671:|VI1PR04MB4671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4671BD4C1AE431E87E502E8BEE630@VI1PR04MB4671.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(6116002)(54906003)(446003)(6246003)(86362001)(4326008)(478600001)(6916009)(476003)(25786009)(486006)(52536014)(3846002)(26005)(229853002)(7736002)(6436002)(33656002)(76176011)(44832011)(55016002)(9686003)(74316002)(81156014)(8936002)(53546011)(76116006)(2906002)(6506007)(91956017)(14444005)(305945005)(66066001)(256004)(8676002)(7696005)(186003)(66476007)(66946007)(5660300002)(66556008)(66446008)(64756008)(7416002)(14454004)(102836004)(71190400001)(71200400001)(316002)(81166006)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4671;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2hD768TsZ4grAtNfmqV2xyGyzyTu0vJSVDfvqIBWO5NZFj5ST0x2upxJNYcXdZSXm1AbW/lEul5WxQoVe7ReWxuUu1Iahe0psjnhpo7loR8tL24Emq50ZBjBAzX0+NfZBQ7xgmmaEQ4X4pKxLQaJorUUwfsdXi/+m0t6j96ecyUUtlcGf1sC03FIPP2uqapFabas9kM6AhdNU9TU/hPpcz4icJVqmAuhnc2vUH7hrIv1BmndXQH8p3CLv2wdWcUpoEpD/wGyWW2bHz0/ZIRQTfbeKuFfwkh6ArzOJqELej2ekjPln3ArZY1g8aM5NnlX4BQebK+Toe8nf3BbCxKaArFeWDuHJDovijqVVS5f2aUlCRI2lnYllzbZNO2oVGyIKj1FhPZJdADgx2k6RODIdiGJbUpx/PuANNwiJY1JkIOJS1w1pRnuQV2QvBmEwxK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affd1da9-06dd-479b-ca1f-08d75e040d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 13:12:58.6483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7iMUyE8FVeVQ87llFNtCSF+yXb0PK3ZCc0lUYdjfne2/YVXqmQdIBM6e9Y08kzo7BDkq0O6203JADiRDt+6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4671
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMzEuMTAuMjAxOSAwNDozNywgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IE9uIDE5LiAxMC4gMy4g
7Jik7KCEIDQ6MjUsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToKPj4gTW92aW5nIGhhbmRsaW5nIG9m
IG1pbi9tYXggZnJlcSB0byBhIHNpbmdsZSBmdW5jdGlvbiBhbmQgY2FsbCBpdCBmcm9tCj4+IHVw
ZGF0ZV9kZXZmcmVxIGFuZCBmb3IgcHJpbnRpbmcgbWluL21heCBmcmVxIHZhbHVlcyBpbiBzeXNm
cy4KPj4KPj4gVGhpcyBjaGFuZ2VzIHRoZSBiZWhhdmlvciBvZiBvdXQtb2YtcmFuZ2UgbWluX2Zy
ZXEvbWF4X2ZyZXE6IGNsYW1waW5nCj4+IGlzIG5vdyBkb25lIGF0IGV2YWx1YXRpb24gdGltZS4g
VGhpcyBtZWFucyB0aGF0IGlmIGFuIG91dC1vZi1yYW5nZQo+PiBjb25zdHJhaW50IGlzIGltcG9z
ZWQgYnkgc3lzZnMgYW5kIGl0IGxhdGVyIGJlY29tZXMgdmFsaWQgdGhlbiBpdCB3aWxsCj4+IGJl
IGVuZm9yY2VkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQu
Y3Jlc3RlekBueHAuY29tPgo+PiBSZXZpZXdlZC1ieTogTWF0dGhpYXMgS2FlaGxja2UgPG1rYUBj
aHJvbWl1bS5vcmc+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCAxMTAg
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgNjIgaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+PiBp
bmRleCA4N2VmZjc4OWNlMjQuLjJkNjM2OTI5MDNmZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9k
ZXZmcmVxL2RldmZyZXEuYwo+PiArKysgYi9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+IEBA
IC05NiwxMCArOTYsNTMgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgZmluZF9hdmFpbGFibGVfbWF4
X2ZyZXEoc3RydWN0IGRldmZyZXEgKmRldmZyZXEpCj4+ICAgCQlkZXZfcG1fb3BwX3B1dChvcHAp
Owo+PiAgIAo+PiAgIAlyZXR1cm4gbWF4X2ZyZXE7Cj4+ICAgfQo+PiAgIAo+PiArLyoqCj4+ICsg
KiBnZXRfZnJlcV9yYW5nZSgpIC0gR2V0IHRoZSBjdXJyZW50IGZyZXEgcmFuZ2UKPj4gKyAqIEBk
ZXZmcmVxOgl0aGUgZGV2ZnJlcSBpbnN0YW5jZQo+PiArICogQG1pbl9mcmVxOgl0aGUgbWluIGZy
ZXF1ZW5jeQo+PiArICogQG1heF9mcmVxOgl0aGUgbWF4IGZyZXF1ZW5jeQo+PiArICoKPj4gKyAq
IFRoaXMgdGFrZXMgaW50byBjb25zaWRlcmF0aW9uIGFsbCBjb25zdHJhaW50cy4KPj4gKyAqLwo+
PiArc3RhdGljIHZvaWQgZ2V0X2ZyZXFfcmFuZ2Uoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4+
ICsJCQkgICB1bnNpZ25lZCBsb25nICptaW5fZnJlcSwKPj4gKwkJCSAgIHVuc2lnbmVkIGxvbmcg
Km1heF9mcmVxKQo+PiArewo+PiArCXVuc2lnbmVkIGxvbmcgKmZyZXFfdGFibGUgPSBkZXZmcmVx
LT5wcm9maWxlLT5mcmVxX3RhYmxlOwo+PiArCj4+ICsJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZGV2
ZnJlcS0+bG9jayk7Cj4+ICsKPj4gKwkvKgo+PiArCSAqIEluaXRpYWxpemUgbWluaW11bS9tYXhp
bXVtIGZyZXF1ZW5jeSBmcm9tIGZyZXEgdGFibGUuCj4+ICsJICogVGhlIGRldmZyZXEgZHJpdmVy
cyBjYW4gaW5pdGlhbGl6ZSB0aGlzIGluIGVpdGhlciBhc2NlbmRpbmcgb3IKPj4gKwkgKiBkZXNj
ZW5kaW5nIG9yZGVyIGFuZCBkZXZmcmVxIGNvcmUgc3VwcG9ydHMgYm90aC4KPj4gKwkgKi8KPj4g
KwlpZiAoZnJlcV90YWJsZVswXSA8IGZyZXFfdGFibGVbZGV2ZnJlcS0+cHJvZmlsZS0+bWF4X3N0
YXRlIC0gMV0pIHsKPj4gKwkJKm1pbl9mcmVxID0gZnJlcV90YWJsZVswXTsKPj4gKwkJKm1heF9m
cmVxID0gZnJlcV90YWJsZVtkZXZmcmVxLT5wcm9maWxlLT5tYXhfc3RhdGUgLSAxXTsKPj4gKwl9
IGVsc2Ugewo+PiArCQkqbWluX2ZyZXEgPSBmcmVxX3RhYmxlW2RldmZyZXEtPnByb2ZpbGUtPm1h
eF9zdGF0ZSAtIDFdOwo+PiArCQkqbWF4X2ZyZXEgPSBmcmVxX3RhYmxlWzBdOwo+PiArCX0KPj4g
Kwo+PiArCS8qIEFwcGx5IGNvbnN0cmFpbnRzIGZyb20gc3lzZnMgKi8KPj4gKwkqbWluX2ZyZXEg
PSBtYXgoKm1pbl9mcmVxLCBkZXZmcmVxLT5taW5fZnJlcSk7Cj4+ICsJKm1heF9mcmVxID0gbWlu
KCptYXhfZnJlcSwgZGV2ZnJlcS0+bWF4X2ZyZXEpOwo+PiArCj4+ICsJLyogQXBwbHkgY29uc3Ry
YWludHMgZnJvbSBPUFAgaW50ZXJmYWNlICovCj4+ICsJKm1pbl9mcmVxID0gbWF4KCptaW5fZnJl
cSwgZGV2ZnJlcS0+c2NhbGluZ19taW5fZnJlcSk7Cj4+ICsJLyogc2NhbGluZ19tYXhfZnJlcSBj
YW4gYmUgemVybyBvbiBlcnJvciAqLwo+PiArCWlmIChkZXZmcmVxLT5zY2FsaW5nX21heF9mcmVx
KQo+IAo+IG5pdHBpY2s6Cj4gVGhpcyBpZiBzdGF0ZW1lbnQgaXMgbmVjZXNzYXJ5Pwo+IAo+IFRo
ZSBwYXRjaDMgaW4gdGhpcyBzZXJpZXMgaW5pdGlhbGl6ZXMgdGhlICdkZXZmcmVxLT5zY2FsaW5n
X21heF9mcmVxJwo+IGlzIFVMT05HX01BWCBpZiBmYWlsZWQgdG8gZ2V0IHRoZSBhdmFpbGFibGUg
ZnJlcXVlbmN5IGZyb20gZmluZF9hdmFpbGFibGVfbWF4X2ZyZXEuCgpPaywgc2VlbSBJIGZvcmdv
dCB0byBkcm9wIHRoZSBpZiBzdGF0ZW1lbnQuCgo+IAo+PiArCQkqbWF4X2ZyZXEgPSBtaW4oKm1h
eF9mcmVxLCBkZXZmcmVxLT5zY2FsaW5nX21heF9mcmVxKTsKPj4gKwo+PiArCWlmICgqbWluX2Zy
ZXEgPiAqbWF4X2ZyZXEpCj4+ICsJCSptaW5fZnJlcSA9ICptYXhfZnJlcTsKPj4gK30KPj4gKwo+
PiAgIC8qKgo+PiAgICAqIGRldmZyZXFfZ2V0X2ZyZXFfbGV2ZWwoKSAtIExvb2t1cCBmcmVxX3Rh
YmxlIGZvciB0aGUgZnJlcXVlbmN5Cj4+ICAgICogQGRldmZyZXE6CXRoZSBkZXZmcmVxIGluc3Rh
bmNlCj4+ICAgICogQGZyZXE6CXRoZSB0YXJnZXQgZnJlcXVlbmN5Cj4+ICAgICovCj4+IEBAIC0z
NDgsMjAgKzM5MSwxMSBAQCBpbnQgdXBkYXRlX2RldmZyZXEoc3RydWN0IGRldmZyZXEgKmRldmZy
ZXEpCj4+ICAgCj4+ICAgCS8qIFJlZXZhbHVhdGUgdGhlIHByb3BlciBmcmVxdWVuY3kgKi8KPj4g
ICAJZXJyID0gZGV2ZnJlcS0+Z292ZXJub3ItPmdldF90YXJnZXRfZnJlcShkZXZmcmVxLCAmZnJl
cSk7Cj4+ICAgCWlmIChlcnIpCj4+ICAgCQlyZXR1cm4gZXJyOwo+PiAtCj4+IC0JLyoKPj4gLQkg
KiBBZGp1c3QgdGhlIGZyZXF1ZW5jeSB3aXRoIHVzZXIgZnJlcSwgUW9TIGFuZCBhdmFpbGFibGUg
ZnJlcS4KPj4gLQkgKgo+PiAtCSAqIExpc3QgZnJvbSB0aGUgaGlnaGVzdCBwcmlvcml0eQo+PiAt
CSAqIG1heF9mcmVxCj4+IC0JICogbWluX2ZyZXEKPj4gLQkgKi8KPj4gLQltYXhfZnJlcSA9IG1p
bihkZXZmcmVxLT5zY2FsaW5nX21heF9mcmVxLCBkZXZmcmVxLT5tYXhfZnJlcSk7Cj4+IC0JbWlu
X2ZyZXEgPSBtYXgoZGV2ZnJlcS0+c2NhbGluZ19taW5fZnJlcSwgZGV2ZnJlcS0+bWluX2ZyZXEp
Owo+PiArCWdldF9mcmVxX3JhbmdlKGRldmZyZXEsICZtaW5fZnJlcSwgJm1heF9mcmVxKTsKPj4g
ICAKPj4gICAJaWYgKGZyZXEgPCBtaW5fZnJlcSkgewo+PiAgIAkJZnJlcSA9IG1pbl9mcmVxOwo+
PiAgIAkJZmxhZ3MgJj0gfkRFVkZSRVFfRkxBR19MRUFTVF9VUFBFUl9CT1VORDsgLyogVXNlIEdM
QiAqLwo+PiAgIAl9Cj4+IEBAIC0xMjgxLDQwICsxMzE1LDI4IEBAIHN0YXRpYyBzc2l6ZV90IG1p
bl9mcmVxX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmF0dHIsCj4+ICAgCXJldCA9IHNzY2FuZihidWYsICIlbHUiLCAmdmFsdWUpOwo+PiAgIAlpZiAo
cmV0ICE9IDEpCj4+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPj4gICAKPj4gICAJbXV0ZXhfbG9jaygm
ZGYtPmxvY2spOwo+PiAtCj4+IC0JaWYgKHZhbHVlKSB7Cj4+IC0JCWlmICh2YWx1ZSA+IGRmLT5t
YXhfZnJlcSkgewo+PiAtCQkJcmV0ID0gLUVJTlZBTDsKPj4gLQkJCWdvdG8gdW5sb2NrOwo+PiAt
CQl9Cj4+IC0JfSBlbHNlIHsKPj4gLQkJdW5zaWduZWQgbG9uZyAqZnJlcV90YWJsZSA9IGRmLT5w
cm9maWxlLT5mcmVxX3RhYmxlOwo+PiAtCj4+IC0JCS8qIEdldCBtaW5pbXVtIGZyZXF1ZW5jeSBh
Y2NvcmRpbmcgdG8gc29ydGluZyBvcmRlciAqLwo+PiAtCQlpZiAoZnJlcV90YWJsZVswXSA8IGZy
ZXFfdGFibGVbZGYtPnByb2ZpbGUtPm1heF9zdGF0ZSAtIDFdKQo+PiAtCQkJdmFsdWUgPSBmcmVx
X3RhYmxlWzBdOwo+PiAtCQllbHNlCj4+IC0JCQl2YWx1ZSA9IGZyZXFfdGFibGVbZGYtPnByb2Zp
bGUtPm1heF9zdGF0ZSAtIDFdOwo+PiAtCX0KPj4gLQo+PiAgIAlkZi0+bWluX2ZyZXEgPSB2YWx1
ZTsKPj4gICAJdXBkYXRlX2RldmZyZXEoZGYpOwo+PiAtCXJldCA9IGNvdW50Owo+PiAtdW5sb2Nr
Ogo+PiAgIAltdXRleF91bmxvY2soJmRmLT5sb2NrKTsKPj4gLQlyZXR1cm4gcmV0Owo+PiArCj4+
ICsJcmV0dXJuIGNvdW50Owo+PiAgIH0KPj4gICAKPj4gICBzdGF0aWMgc3NpemVfdCBtaW5fZnJl
cV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
Cj4+ICAgCQkJICAgICBjaGFyICpidWYpCj4+ICAgewo+PiAgIAlzdHJ1Y3QgZGV2ZnJlcSAqZGYg
PSB0b19kZXZmcmVxKGRldik7Cj4+ICsJdW5zaWduZWQgbG9uZyBtaW5fZnJlcSwgbWF4X2ZyZXE7
Cj4+ICAgCj4+IC0JcmV0dXJuIHNwcmludGYoYnVmLCAiJWx1XG4iLCBtYXgoZGYtPnNjYWxpbmdf
bWluX2ZyZXEsIGRmLT5taW5fZnJlcSkpOwo+PiArCW11dGV4X2xvY2soJmRmLT5sb2NrKTsKPj4g
KwlnZXRfZnJlcV9yYW5nZShkZiwgJm1pbl9mcmVxLCAmbWF4X2ZyZXEpOwo+PiArCW11dGV4X3Vu
bG9jaygmZGYtPmxvY2spOwo+PiArCj4+ICsJcmV0dXJuIHNwcmludGYoYnVmLCAiJWx1XG4iLCBt
aW5fZnJlcSk7Cj4+ICAgfQo+PiAgIAo+PiAgIHN0YXRpYyBzc2l6ZV90IG1heF9mcmVxX3N0b3Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCj4+ICAg
CQkJICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCj4+ICAgewo+PiBAQCAtMTMy
Niw0MCArMTM0OCwzMiBAQCBzdGF0aWMgc3NpemVfdCBtYXhfZnJlcV9zdG9yZShzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAo+PiAgIAlpZiAocmV0ICE9
IDEpCj4+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPj4gICAKPj4gICAJbXV0ZXhfbG9jaygmZGYtPmxv
Y2spOwo+PiAgIAo+PiAtCWlmICh2YWx1ZSkgewo+PiAtCQlpZiAodmFsdWUgPCBkZi0+bWluX2Zy
ZXEpIHsKPj4gLQkJCXJldCA9IC1FSU5WQUw7Cj4+IC0JCQlnb3RvIHVubG9jazsKPj4gLQkJfQo+
PiAtCX0gZWxzZSB7Cj4+IC0JCXVuc2lnbmVkIGxvbmcgKmZyZXFfdGFibGUgPSBkZi0+cHJvZmls
ZS0+ZnJlcV90YWJsZTsKPj4gLQo+PiAtCQkvKiBHZXQgbWF4aW11bSBmcmVxdWVuY3kgYWNjb3Jk
aW5nIHRvIHNvcnRpbmcgb3JkZXIgKi8KPj4gLQkJaWYgKGZyZXFfdGFibGVbMF0gPCBmcmVxX3Rh
YmxlW2RmLT5wcm9maWxlLT5tYXhfc3RhdGUgLSAxXSkKPj4gLQkJCXZhbHVlID0gZnJlcV90YWJs
ZVtkZi0+cHJvZmlsZS0+bWF4X3N0YXRlIC0gMV07Cj4+IC0JCWVsc2UKPj4gLQkJCXZhbHVlID0g
ZnJlcV90YWJsZVswXTsKPj4gLQl9Cj4+ICsJaWYgKCF2YWx1ZSkKPj4gKwkJdmFsdWUgPSBVTE9O
R19NQVg7Cj4+ICAgCj4+ICAgCWRmLT5tYXhfZnJlcSA9IHZhbHVlOwo+PiAgIAl1cGRhdGVfZGV2
ZnJlcShkZik7Cj4+IC0JcmV0ID0gY291bnQ7Cj4+IC11bmxvY2s6Cj4+ICAgCW11dGV4X3VubG9j
aygmZGYtPmxvY2spOwo+PiAtCXJldHVybiByZXQ7Cj4+ICsKPj4gKwlyZXR1cm4gY291bnQ7Cj4+
ICAgfQo+PiAgIHN0YXRpYyBERVZJQ0VfQVRUUl9SVyhtaW5fZnJlcSk7Cj4+ICAgCj4+ICAgc3Rh
dGljIHNzaXplX3QgbWF4X2ZyZXFfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLAo+PiAgIAkJCSAgICAgY2hhciAqYnVmKQo+PiAgIHsKPj4gICAJ
c3RydWN0IGRldmZyZXEgKmRmID0gdG9fZGV2ZnJlcShkZXYpOwo+PiArCXVuc2lnbmVkIGxvbmcg
bWluX2ZyZXEsIG1heF9mcmVxOwo+PiArCj4+ICsJbXV0ZXhfbG9jaygmZGYtPmxvY2spOwo+PiAr
CWdldF9mcmVxX3JhbmdlKGRmLCAmbWluX2ZyZXEsICZtYXhfZnJlcSk7Cj4+ICsJbXV0ZXhfdW5s
b2NrKCZkZi0+bG9jayk7Cj4+ICAgCj4+IC0JcmV0dXJuIHNwcmludGYoYnVmLCAiJWx1XG4iLCBt
aW4oZGYtPnNjYWxpbmdfbWF4X2ZyZXEsIGRmLT5tYXhfZnJlcSkpOwo+PiArCXJldHVybiBzcHJp
bnRmKGJ1ZiwgIiVsdVxuIiwgbWF4X2ZyZXEpOwo+PiAgIH0KPj4gICBzdGF0aWMgREVWSUNFX0FU
VFJfUlcobWF4X2ZyZXEpOwo+PiAgIAo+PiAgIHN0YXRpYyBzc2l6ZV90IGF2YWlsYWJsZV9mcmVx
dWVuY2llc19zaG93KHN0cnVjdCBkZXZpY2UgKmQsCj4+ICAgCQkJCQkgIHN0cnVjdCBkZXZpY2Vf
YXR0cmlidXRlICphdHRyLAo+Pgo+IAo+IFJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3MDAu
Y2hvaUBzYW1zdW5nLmNvbT4KPiAKCg==
