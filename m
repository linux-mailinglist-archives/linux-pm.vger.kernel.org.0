Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097C8BE5C1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392336AbfIYTgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 15:36:35 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:42755
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbfIYTgf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Sep 2019 15:36:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVrg9I+W5lKaijO/Q4F5zEGcJ/e1v16J3NYcQ5wz39RncS4yeBquH2s9P4I8AYmqWH9Ia+FEwT0SffT2nAd8L9XRdkm76fPfi6PWSjIZDlDraCBQZ8c2J68Dlfby80vPw3HBMwbm8/Y1Gd2fn0OKCu1z9mhX41+KAc3Qcd5SbmgKi/TaVk/eyiz12OQrHUHfJXIOYglks/M8pJVcz7cwspDkgeHghVEbZ3g6vy1dwsUaHL1EuNX0v3Lfl2cV71TdmKGrEDtEPO7j7Q+nY+BUZ4DVfasuoVQQRu7hTxu2VbxBDwEuJmylZ4qchphB3yUqKY67MsvFMDfRMG/2PFLowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRyRUfXKOLM/phDAQ2+ms4e18hLjZ992Z1LPkBI0ezs=;
 b=U0Shx8HFDckH9nleOBK4CNapw8FJPWnhelJo08ChWlJ7X8f/getKDsR2hITRFmfJ1qRvtT52na3pwHT5EMBeY316LzMdGabpvM9IPglW/3O+qpAHV1cverIAeEaCOWt2Rd7+OtF76ENgkxpn/aW6CJZGC8Cyy3zVLshs8Z5tX97B05iyJYjIbOdJ3/S9y7CC7yRuwlAHD1G68nwCJaKKHbiSsOarPMjgR9AC/tMjmr9LH0K4xDHIdcCkYQuKpi2dL/eb+3vHskDOJaiA2Rk1h7GgXi1AgiGsbIIYws60lANebc2KjyQkHogeRVAqZ1+sNkmG8HtFm6fUgId+2DpDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRyRUfXKOLM/phDAQ2+ms4e18hLjZ992Z1LPkBI0ezs=;
 b=McHclyY2t9uFKjAzl3le+htlJX8k+fsmZBpNHgar0WUrIKQyoI83DfhLob1u5pPYD69nv37kx2b6CvVzMQmQpDRooOvS9qQ3yYrHi3Z0JUDEJAAmCkUy7b3AKxYM8P9z7NNlO18KQRPYMZlqBjh/VakIyyUmcasPxAsaVwUxvQc=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4223.eurprd04.prod.outlook.com (52.134.31.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 19:36:27 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:36:27 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PM / devfreq: Lock devfreq in trans_stat_show
Thread-Topic: [PATCH] PM / devfreq: Lock devfreq in trans_stat_show
Thread-Index: AQHVcivNmZCNzE9MgU6jtsaQgcfxqQ==
Date:   Wed, 25 Sep 2019 19:36:27 +0000
Message-ID: <VI1PR04MB70236E999701EB8CE02957FEEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <CGME20190923162736epcas3p2c1db3bf767a07f17b609bc91fbbd9648@epcas3p2.samsung.com>
 <714675448e7fbf3c930b0dca6fbe54fa5f87211b.1569256001.git.leonard.crestez@nxp.com>
 <979d107f-0a52-3aa4-a397-acb0ff754a3c@samsung.com>
 <VI1PR04MB7023BF1AD2C61C8A5ABAD5FEEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <98042a95-40cc-7f05-ede7-d042640b135b@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23f609ad-2eab-4efe-4848-08d741efa87a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4223;
x-ms-traffictypediagnostic: VI1PR04MB4223:|VI1PR04MB4223:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB42238725578D5A25D54262E0EE870@VI1PR04MB4223.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(5660300002)(7416002)(229853002)(6436002)(110136005)(76176011)(66066001)(966005)(478600001)(14454004)(7696005)(71190400001)(9686003)(25786009)(71200400001)(99286004)(86362001)(186003)(486006)(14444005)(256004)(446003)(53546011)(6506007)(44832011)(91956017)(76116006)(33656002)(66476007)(66556008)(64756008)(66446008)(4326008)(66946007)(55016002)(102836004)(6246003)(6306002)(81166006)(81156014)(476003)(26005)(2906002)(54906003)(74316002)(8936002)(6116002)(3846002)(7736002)(305945005)(52536014)(316002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4223;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F3w+ZKefUoGGA8vywmNbD9tPH+qKRiUBeCIgcrmXaSeljYr7olceoUt0UNaLvrfolXlq8ZsMG2ssqFyIOlE5xM80I5YBeeHrZcF2DvNJ2TGnp9F1j2Sd16RXcse1WtRACadFuy+9MR82ODBLurw8akrSh0eUuQvmmLvlz6aT61zfr1SSUjBmnOEfaxtmteUhCMOgGRoOpm8MB/yeZP1oMFH8VHKGyX2zZpVfQ7Kl+ORnB1VeUDU+0IQPkSEy1fEWKiXHMBxIWKpXj2+NwYPMqcqCN+au9IoecADgQCbioiseB4IDubCIyydr1/Vx208NUflc4/ffM7fqyLLDKtIhPxOziuKnSzO4fN7bmiXLuYs38rM/7QdMyjvabmYUMvx9phwGPbl8cAYNv2h9bT/ZWlhl6Yzo7XOv3mnMvukIq/uoh/F/7pcZwxcqtHxxnDEPhl2GyO3gFrPUl5DlHG0bOg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f609ad-2eab-4efe-4848-08d741efa87a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:36:27.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPfNjjc0rxkRz7/uM6vsWuSjzygYg91Hpj2rT/zdgM9Al4RveR9pGZLe+QkLHCY1ozppxZsRs/qm0PuZaxr6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4223
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjUuMDkuMjAxOSAwNDoxNywgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IE9uIDE5LiA5LiAyNC4g
7Jik7ZuEIDQ6NDQsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToKPj4gT24gMjAxOS0wOS0yNCA1OjA3
IEFNLCBDaGFud29vIENob2kgd3JvdGU6Cj4+PiBIaSwKPj4+Cj4+PiBPbiAxOS4gOS4gMjQuIOyY
pOyghCAxOjI3LCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6Cj4+Pj4gVGhlcmUgaXMgbm8gbG9ja2lu
ZyBpbiB0aGlzIHN5c2ZzIHNob3cgZnVuY3Rpb24gc28gc3RhdHMgcHJpbnRpbmcgY2FuCj4+Pj4g
cmFjZSB3aXRoIGEgZGV2ZnJlcV91cGRhdGVfc3RhdHVzIGNhbGxlZCBhcyBwYXJ0IG9mIGZyZXEg
c3dpdGNoaW5nIG9yCj4+Pj4gd2l0aCBpbml0aWFsaXphdGlvbi4KPj4+Pgo+Pj4+IEFsc28gYWRk
IGFuIGFzc2VydCBpbiBkZXZmcmVxX3VwZGF0ZV9zdGF0dXMgdG8gbWFrZSBpdCBjbGVhciB0aGF0
IGxvY2sKPj4+PiBtdXN0IGJlIGhlbGQgYnkgY2FsbGVyLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1i
eTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4KPj4+PiAtLS0KPj4+
PiAgICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgMTMgKysrKysrKysrKy0tLQo+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4+Cj4+
Pj4gQ2hhbmdlcyBzaW5jZSB2MToKPj4+PiAqIFNwbGl0IGZyb20gc2VyaWVzOiBsb3ctcHJpb3Jp
dHkgYnVnZml4IG5vdCBzdHJpY3RseSByZXF1aXJlZCBmb3IgUE0gUW9TCj4+Pj4gKiBPbmx5IGtl
ZXAgbG9jayBkdXJpbmcgdXBkYXRlLCByZWxlYXNlIGJlZm9yZSBzcHJpbnRmCj4+Pj4KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS9k
ZXZmcmVxLmMKPj4+PiBpbmRleCA0YzU4ZmJmN2Q0ZTQuLjAwZmMyM2ZlYTViMiAxMDA2NDQKPj4+
PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+Pj4gKysrIGIvZHJpdmVycy9kZXZm
cmVxL2RldmZyZXEuYwo+Pj4+IEBAIC0yMDYsMTAgKzIwNiwxMSBAQCBpbnQgZGV2ZnJlcV91cGRh
dGVfc3RhdHVzKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxLCB1bnNpZ25lZCBsb25nIGZyZXEpCj4+
Pj4gICAgewo+Pj4+ICAgIAlpbnQgbGV2LCBwcmV2X2xldiwgcmV0ID0gMDsKPj4+PiAgICAJdW5z
aWduZWQgbG9uZyBjdXJfdGltZTsKPj4+PiAgICAKPj4+PiAgICAJY3VyX3RpbWUgPSBqaWZmaWVz
Owo+Pj4+ICsJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZGV2ZnJlcS0+bG9jayk7Cj4+Pgo+Pj4gSXQg
YmV0dGVyIHRvIG1vdmUgbG9jayBjaGVja2luZyBiZWZvcmUgJ2N1cl90aW1lID0gamlmZmllcycK
Pj4+IGluIG9yZGVyIHRvIHJlZHVjZSB0aGUgcmVkdW5kYW50IGNvZGUgZXhlY3V0aW9uLgo+Pgo+
PiBPSyBidXQgSSBkb24ndCBzZWUgaG93IHRoaXMgbWFrZXMgYSBkaWZmZXJlbmNlIGZvciBhbiBh
c3NlcnQ/IEl0IGp1c3QKPj4gcHJpbnRzIGEgd2FybmluZyBhbmQgY2FycmllcyBvbi4KPiAKPiBB
Y2NvcmRpbmcgdG8gdGhlIHNlcXVlbmNlIGJldHdlZW4gJ2xvY2tkZXBfYXNzZXJ0X2hlbGQnIGFu
ZCAnY3VyX3RpbWUgPSBqaWZmaWVzJywKPiBjdXJfdGltZSB3aWxsIGJlIGluaXRpYWxpemVkIHdp
dGggZGlmZmVyZW50IGppZmZpZXMgYmVjYXVzZSAnamlmZmllcycgaXMgY29udGludW91c2x5Cj4g
Y2hhbmdlZC4gSW4gb3JkZXIgdG8gZ2V0IHRoZSBtb3JlIGNvcnJlY3QgdGltZSBmcm9tICdqaWZm
aWVzJywKPiB3ZSBiZXR0ZXIgdG8gZ2V0ICdqaWZmaWVzJyBhZnRlciByZWxlYXNpbmcgdGhlIGxv
Y2suCgpUaGF0IG1ha2VzIHNlbnNlLgoKPj4+PiAgICAJLyogSW1tZWRpYXRlbHkgZXhpdCBpZiBw
cmV2aW91c19mcmVxIGlzIG5vdCBpbml0aWFsaXplZCB5ZXQuICovCj4+Pj4gICAgCWlmICghZGV2
ZnJlcS0+cHJldmlvdXNfZnJlcSkKPj4+PiAgICAJCWdvdG8gb3V0Owo+Pj4+ICAgIAo+Pj4+IEBA
IC0xNTA3LDE2ICsxNTA4LDIyIEBAIHN0YXRpYyBzc2l6ZV90IHRyYW5zX3N0YXRfc2hvdyhzdHJ1
Y3QgZGV2aWNlICpkZXYsCj4+Pj4gICAgCXN0cnVjdCBkZXZmcmVxICpkZXZmcmVxID0gdG9fZGV2
ZnJlcShkZXYpOwo+Pj4+ICAgIAlzc2l6ZV90IGxlbjsKPj4+PiAgICAJaW50IGksIGo7Cj4+Pj4g
ICAgCXVuc2lnbmVkIGludCBtYXhfc3RhdGUgPSBkZXZmcmVxLT5wcm9maWxlLT5tYXhfc3RhdGU7
Cj4+Pj4gICAgCj4+Pj4gLQlpZiAoIWRldmZyZXEtPnN0b3BfcG9sbGluZyAmJgo+Pj4+IC0JCQlk
ZXZmcmVxX3VwZGF0ZV9zdGF0dXMoZGV2ZnJlcSwgZGV2ZnJlcS0+cHJldmlvdXNfZnJlcSkpCj4+
Pj4gLQkJcmV0dXJuIDA7Cj4+Pj4gICAgCWlmIChtYXhfc3RhdGUgPT0gMCkKPj4+PiAgICAJCXJl
dHVybiBzcHJpbnRmKGJ1ZiwgIk5vdCBTdXBwb3J0ZWQuXG4iKTsKPj4+PiAgICAKPj4+PiArCS8q
IGxvY2sgYW5kIHVwZGF0ZSAqLwo+Pj4KPj4+IEl0IGlzIG5vdCBuZWNlc3NhcnkuIEFueW9uZSBj
YW4ga25vdyB0aGF0IHRoaXMgY29kZSBpcyByZWxhdGVkIHRvIG11dGV4IGxvY2svdW5sb2NrLgo+
Pgo+PiBPSy4gWW91J3JlIHRoZSBzZWNvbmQgcGVyc29uIHRvIG1lbnRpb24gdGhpcyBidXQgaXQn
cyBxdWl0ZSBzdHJhbmdlIHRvCj4+IHNlZSBvYmplY3Rpb25zIHJhaXNlZCBhZ2FpbnN0IGNvbW1l
bnRzLgo+IAo+IFRoZSBjb21tZW50IGlzIHZlcnkgaW1wb3J0YW50IHRvIHVuZGVyc3RhbmQgdGhl
IGNvZGUKPiBmb3IgZXZlcnlvbmUuIEJ1dCwgaW4gdGhpcyBjYXNlLCBhbG1vc3QgcGVvcGxlIHVu
ZGVyc3RhbmQKPiB0aGUgdXNhZ2Ugb2YgbXV0ZXhfbG9jay9tdXRleF91bmxvY2suIEl0IGlzIG5v
IGRpZmZpY3VsdAo+IHRvIHVuZGVyc3RhbmQgdGhlIG1lYW5pbmcgb2YgYmVsb3cgY29kZXMuCj4g
Cj4gVXN1YWxseSwgd2Ugd291bGQgYWRkIHRoZSBjb21tZW50cyBpZiBzb21lIGNvZGVzIGFyZSB2
ZXJ5IGRpZmZpY3VsdAo+IHdpdGhvdXQgY29tbWVudHMgb3Igc29tZSBjb2RlcyBoYXZlIGRlcGVu
ZCBvbiBzb21lIGNhbGwgc2VxdWVuY2UgYW5kIHNvIG9uLgoKT0suIFNvbWV0aW1lcyBJIGFkZCBi
cmllZiBjb21tZW50cyBhaGVhZCBvZiBhIHBhcmFncmFwaCBvZiBjb2RlIHNvIHRoYXQgCkkgY2Fu
IHJlYWQgaXQgZmFzdGVyLgoKPj4+PiArCW11dGV4X2xvY2soJmRldmZyZXEtPmxvY2spOwo+Pj4+
ICsJaWYgKCFkZXZmcmVxLT5zdG9wX3BvbGxpbmcgJiYKPj4+PiArCQkJZGV2ZnJlcV91cGRhdGVf
c3RhdHVzKGRldmZyZXEsIGRldmZyZXEtPnByZXZpb3VzX2ZyZXEpKSB7Cj4+Pj4gKwkJbXV0ZXhf
dW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsKPj4+PiArCQlyZXR1cm4gMDsKPj4+PiArCX0KPj4+PiAr
CW11dGV4X3VubG9jaygmZGV2ZnJlcS0+bG9jayk7Cj4+Pj4gKwo+Pj4+ICAgIAlsZW4gPSBzcHJp
bnRmKGJ1ZiwgIiAgICAgRnJvbSAgOiAgIFRvXG4iKTsKPj4+PiAgICAJbGVuICs9IHNwcmludGYo
YnVmICsgbGVuLCAiICAgICAgICAgICA6Iik7Cj4+Pj4gICAgCWZvciAoaSA9IDA7IGkgPCBtYXhf
c3RhdGU7IGkrKykKPj4+PiAgICAJCWxlbiArPSBzcHJpbnRmKGJ1ZiArIGxlbiwgIiUxMGx1IiwK
Pj4+PiAgICAJCQkJZGV2ZnJlcS0+cHJvZmlsZS0+ZnJlcV90YWJsZVtpXSk7Cj4+Pj4KPj4+Cj4+
PiBCYXNpY2FsbHksIGl0IGlzIG5lY2Vzc2FyeS4gUGxlYXNlIGVkaXQgaXQgYnkgbXkgY29tbWVu
dHMuCj4+PiBBbHNvLCB5b3UgaGF2ZSB0byBhZGQgdGhlIGZvbGxvd2luZyAnZml4ZXMnIGFzIGZv
bGxvd2luZzoKPj4+IGFuZCBzZW5kIGl0IHN0YWJsZSBtYWlsaW5nIGxpc3QuCj4+Pgo+Pj4gRml4
ZXM6IDM5Njg4Y2U2ZmFjZCAoIlBNIC8gZGV2ZnJlcTogYWNjb3VudCBzdXNwZW5kL3Jlc3VtZSBm
b3Igc3RhdHMiKQo+Pj4KPj4+IElmIHlvdSBlZGl0IGl0IGJ5IG15IGNvbW1lbnRzLCBmZWVsIGZy
ZWUgdG8gYWRkIG15IHRhZzoKPj4+IFJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hv
aUBzYW1zdW5nLmNvbT4KCkFscmVhZHkgcG9zdGVkIHYyIHdpdGggYWxsIHRoZSByZXF1ZXN0ZWQg
Y2hhbmdlczoKCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTExNTgyMjUvCg==
