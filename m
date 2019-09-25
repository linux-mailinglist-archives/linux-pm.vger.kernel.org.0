Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2366CBE5D0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfIYTka (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 15:40:30 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:30182
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728595AbfIYTka (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Sep 2019 15:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAWz4hhwHHcfxqSRxFDr06dLfu1/Flf7WJf7SZSVd5lII7heFeKY14mk2d+wMaQGOPb8RZz4EzJ1+MNO5agcfp2Nv4ca/Tjw6o485ustZytRWmqhkczoH3XX4do5+GqP9AlmUTLjXg+yQhrEKDdfs14K3ZpzPL/HWx+gRIiV2jt6bV1viyaP7ffDCDAA4bZdQxFK70cH9pTzvkczdBk4xDisx39PWw2NaGXS/D4unuGat5iM7t72MszJkK8wI2obaT2BBWgqVkRnihPwsOhmZEhKOAU8JXPLlD80e4idNrjuT/4sW/AIJlJoBklyUZa9H5NREZ2b9CjsBFSY1HmS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PihXEuYH0dj70UuRLPRrUeK66K7J3kOrE40fwax14iQ=;
 b=ashTWsOmNeNLDX+pBf7Q+fo0Ql9GOIVwitK564EThCingrp56tloYvQ8Jh05LByCLg4o6SMjmtGWPxLAKzvzGevpkZxXb+bGDz2D3JGhz5sDbV5vYTYdQamDmKYgaH8ZbUYK2jTnQ+U13+V4LjliXjVHFsjeESWgLq922Xdw+kvAIlKT8MeKUnRSAEp0+LY9DcXtQyr+ml5gz5n184XT7XatcUWtgqs92rZ0e5pIe8/AABMUuDSFk/rVoweINaKgJ5dHvFe/Ou4fN+AMpSatZ0tXaF/FlpMDRXnNtWOthRcdk0fIc3IMOZ+kdHrxXkiwr7YhTHHjqb3tUaMptZ/WEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PihXEuYH0dj70UuRLPRrUeK66K7J3kOrE40fwax14iQ=;
 b=RFYhWg321oL7CvjFl3waejK/OYrcN4bQV9dwSNB46f3snWfLm+BPevzi/OagufJhVtUfklxuvpixYlpgzTgAVgqqPGNGKYL85P/k1tNQNvfKxTP6+LXlkk/Z4gtaBRp+89+m5xLdzr99c5IF1stmaLK+78RJPRCABzWQaz3+ACQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4223.eurprd04.prod.outlook.com (52.134.31.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 19:40:25 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:40:25 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
Thread-Topic: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
Thread-Index: AQHVcsB0h3rfWi61w06V80OWKl85wg==
Date:   Wed, 25 Sep 2019 19:40:25 +0000
Message-ID: <VI1PR04MB7023910B94E4920D329427C8EE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1569319738.git.leonard.crestez@nxp.com>
 <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
 <20190924191124.GJ133864@google.com>
 <CGME20190924192429epcas3p196a7de011d3e78508d1e643efd27e717@epcas3p1.samsung.com>
 <VI1PR04MB7023034123415F86CC045CCDEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <080027a2-d807-5fa4-f148-4469678ce849@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c44c82cf-5f52-41c3-ede4-08d741f0368d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4223;
x-ms-traffictypediagnostic: VI1PR04MB4223:|VI1PR04MB4223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB42230B3A71E0D489563324E6EE870@VI1PR04MB4223.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(476003)(26005)(81156014)(81166006)(2906002)(54906003)(6246003)(8676002)(7736002)(316002)(52536014)(305945005)(8936002)(6116002)(74316002)(3846002)(7696005)(14454004)(478600001)(99286004)(71200400001)(25786009)(9686003)(71190400001)(110136005)(6436002)(229853002)(7416002)(5660300002)(76176011)(66066001)(86362001)(66446008)(64756008)(66556008)(66476007)(33656002)(4326008)(66946007)(91956017)(76116006)(55016002)(102836004)(446003)(486006)(186003)(256004)(14444005)(44832011)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4223;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kcBT05847cs4f9cgHld1/4cDIuz7ZNeHd4J4WefApBWw4Qgu6b1cLloszzn2l+3oWbUiwz86zegR/sQPSAMaGwHMC9rRaRqWG+MT7X+6ObqJvztSpEFpVDx5td7KoZRHQDgjrnaGVqcTIHmZGiUquJfW60yIHrOSqCDjtICTiqQmlXERgnh1+h95jVEKVwYkFy/9BsnXagVWxtROJaZCMPLf7D5oRC26tKkka2v54Uhq3td8Ny6MsR2t9DQTh2GNb9gDVOeCJj0PAhqIbU9WbwBsTF9XxNeOibtRxhUP6xw+yUFjtQfrqja0LCD8m1YnuQXIWEQhLvNBB0cu6dJ1cpQEYOPtA6VFpz2PlOYNVCxnHxSGBQK2CSIu62QCqENM6evYN0rC4GX7grZrfvqfdcqFR0wRalw5yb8tbsg7aa0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44c82cf-5f52-41c3-ede4-08d741f0368d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:40:25.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWIpcKMuXYs9O0hj+P7Smz/Zrg/qvLdMwnm/ctEqZv5ee2MxuKm/dyBwbTmazQlNj8F98af1SeGs4qtVCs0IeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4223
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjUuMDkuMjAxOSAwNToxMywgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IE9uIDE5LiA5LiAyNS4g
7Jik7KCEIDQ6MjIsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToKPj4gT24gMjQuMDkuMjAxOSAyMjox
MSwgTWF0dGhpYXMgS2FlaGxja2Ugd3JvdGU6Cj4+PiBPbiBUdWUsIFNlcCAyNCwgMjAxOSBhdCAw
MToxMToyOVBNICswMzAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6Cj4+Pj4gUmVnaXN0ZXIgbm90
aWZpZXJzIHdpdGggdGhlIFBNIFFvUyBmcmFtZXdvcmsgaW4gb3JkZXIgdG8gcmVzcG9uZCB0bwo+
Pj4+IHJlcXVlc3RzIGZvciBERVZfUE1fUU9TX01JTl9GUkVRVUVOQ1kgYW5kIERFVl9QTV9RT1Nf
TUFYX0ZSRVFVRU5DWS4KPj4+Pgo+Pj4+IE5vIG5vdGlmaWVycyBhcmUgYWRkZWQgYnkgdGhpcyBw
YXRjaCBidXQgUE0gUW9TIGNvbnN0cmFpbnRzIGNhbiBiZQo+Pj4+IGltcG9zZWQgZXh0ZXJuYWxs
eSAoZm9yIGV4YW1wbGUgZnJvbSBvdGhlciBkZXZpY2VzKS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Cj4+Pj4gUmV2aWV3
ZWQtYnk6IE1hdHRoaWFzIEthZWhsY2tlIDxta2FAY2hyb21pdW0ub3JnPgo+Pj4+IC0tLQo+Pj4+
ICAgIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCA3NSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKPj4+PiAgICBpbmNsdWRlL2xpbnV4L2RldmZyZXEuaCAgIHwgIDUg
KysrCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS9k
ZXZmcmVxLmMKPj4+PiBpbmRleCBlZWU0MDNlNzBjODQuLjc4NGYzZTQwNTM2YSAxMDA2NDQKPj4+
PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+Pj4gKysrIGIvZHJpdmVycy9kZXZm
cmVxL2RldmZyZXEuYwo+Pj4+IEBAIC0yMiwxNSArMjIsMTggQEAKPj4+PiAgICAjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4K
Pj4+PiAgICAjaW5jbHVkZSA8bGludXgvcHJpbnRrLmg+Cj4+Pj4gICAgI2luY2x1ZGUgPGxpbnV4
L2hydGltZXIuaD4KPj4+PiAgICAjaW5jbHVkZSA8bGludXgvb2YuaD4KPj4+PiArI2luY2x1ZGUg
PGxpbnV4L3BtX3Fvcy5oPgo+Pj4+ICAgICNpbmNsdWRlICJnb3Zlcm5vci5oIgo+Pj4+ICAgIAo+
Pj4+ICAgICNkZWZpbmUgQ1JFQVRFX1RSQUNFX1BPSU5UUwo+Pj4+ICAgICNpbmNsdWRlIDx0cmFj
ZS9ldmVudHMvZGV2ZnJlcS5oPgo+Pj4+ICAgIAo+Pj4+ICsjZGVmaW5lIEhaX1BFUl9LSFoJMTAw
MAo+Pj4+ICsKPj4+PiAgICBzdGF0aWMgc3RydWN0IGNsYXNzICpkZXZmcmVxX2NsYXNzOwo+Pj4+
ICAgIAo+Pj4+ICAgIC8qCj4+Pj4gICAgICogZGV2ZnJlcSBjb3JlIHByb3ZpZGVzIGRlbGF5ZWQg
d29yayBiYXNlZCBsb2FkIG1vbml0b3JpbmcgaGVscGVyCj4+Pj4gICAgICogZnVuY3Rpb25zLiBH
b3Zlcm5vcnMgY2FuIHVzZSB0aGVzZSBvciBjYW4gaW1wbGVtZW50IHRoZWlyIG93bgo+Pj4+IEBA
IC0xMDksMTAgKzExMiwxMSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBmaW5kX2F2YWlsYWJsZV9t
YXhfZnJlcShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPj4+PiAgICBzdGF0aWMgdm9pZCBnZXRf
ZnJlcV9yYW5nZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwKPj4+PiAgICAJCQkgICB1bnNpZ25l
ZCBsb25nICptaW5fZnJlcSwKPj4+PiAgICAJCQkgICB1bnNpZ25lZCBsb25nICptYXhfZnJlcSkK
Pj4+PiAgICB7Cj4+Pj4gICAgCXVuc2lnbmVkIGxvbmcgKmZyZXFfdGFibGUgPSBkZXZmcmVxLT5w
cm9maWxlLT5mcmVxX3RhYmxlOwo+Pj4+ICsJdW5zaWduZWQgbG9uZyBxb3NfbWluX2ZyZXEsIHFv
c19tYXhfZnJlcTsKPj4+PiAgICAKPj4+PiAgICAJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZGV2ZnJl
cS0+bG9jayk7Cj4+Pj4gICAgCj4+Pj4gICAgCS8qCj4+Pj4gICAgCSAqIEluaXQgbWluL21heCBm
cmVxdWVuY3kgZnJvbSBmcmVxIHRhYmxlLgo+Pj4+IEBAIC0xMjUsMTAgKzEyOSwxOCBAQCBzdGF0
aWMgdm9pZCBnZXRfZnJlcV9yYW5nZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwKPj4+PiAgICAJ
fSBlbHNlIHsKPj4+PiAgICAJCSptaW5fZnJlcSA9IGZyZXFfdGFibGVbZGV2ZnJlcS0+cHJvZmls
ZS0+bWF4X3N0YXRlIC0gMV07Cj4+Pj4gICAgCQkqbWF4X2ZyZXEgPSBmcmVxX3RhYmxlWzBdOwo+
Pj4+ICAgIAl9Cj4+Pj4gICAgCj4+Pj4gKwkvKiBjb25zdHJhaW50cyBmcm9tIFBNIFFvUyAqLwo+
Pj4+ICsJcW9zX21pbl9mcmVxID0gZGV2X3BtX3Fvc19yZWFkX3ZhbHVlKGRldmZyZXEtPmRldi5w
YXJlbnQsCj4+Pj4gKwkJCQkJICAgICBERVZfUE1fUU9TX01JTl9GUkVRVUVOQ1kpOwo+Pj4+ICsJ
cW9zX21heF9mcmVxID0gZGV2X3BtX3Fvc19yZWFkX3ZhbHVlKGRldmZyZXEtPmRldi5wYXJlbnQs
Cj4+Pj4gKwkJCQkJICAgICBERVZfUE1fUU9TX01JTl9GUkVRVUVOQ1kpOyA+Cj4+PiBUaGlzIG5l
ZWRzIHRvIGJlIERFVl9QTV9RT1NfTUFYX0ZSRVFVRU5DWS4gSSBtaXNzZWQgdGhpcyBpbiB0aGUg
ZWFybGllcgo+Pj4gcmV2aWV3cywgYnV0IHN0dW1ibGVkIGFjcm9zcyBpdCB3aGVuIHRlc3Rpbmcu
Cj4+Pgo+Pj4gIVJldmlld2VkLWJ5OiBNYXR0aGlhcyBLYWVobGNrZSA8bWthQGNocm9taXVtLm9y
Zz4KPj4KPj4gSSBicm9rZSBpdCBpbiB2OCB3aGlsZSBwcm9jZXNzaW5nIGNvbW1lbnRzLiBUaGFu
a3MgZm9yIGNhdGNoaW5nIGl0Lgo+IAo+IERpZCB5b3UgdGVzdCB0aGlzIHBhdGNoc2V0IHdpdGgg
djg/Cj4gTWF5YmUgaXQgaXMgbm90IHdvcmtpbmcgd2l0aCB0aGlzIG1pc3Rha2UuCgpJIHJhbiBz
b21lIHNjcmlwdHMgd2hpY2ggdGVzdCB0aGF0IG1pbl9mcmVxIHJlcXVlc3RzIHdvcmsgYXMgZXhw
ZWN0ZWQgCih1c2luZyBpbXggaW50ZXJjb25uZWN0K2RldmZyZXEpLiBUaGV5IGRvbid0IHRvdWNo
IG1heF9mcmVxLgoKLS0KUmVnYXJkcywKTGVvbmFyZAo=
