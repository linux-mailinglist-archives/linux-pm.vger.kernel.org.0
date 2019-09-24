Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8FBC2FF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440620AbfIXHoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 03:44:22 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:9801
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440631AbfIXHoW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Sep 2019 03:44:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBAyVryWvQPzpqXJROgVsecZnxOtYrTqApm+RyfSUV9nvChZ2juun9K2myi0fh2FfNMB4QuxPVE6NVjdsuiNFqmdy94+qrmwsVB0F0OzD3X1i0d74fR8xRrLN6+N1vKhTquMcdVcrIAjdtXKKlbzRr5hxhZT5aaMxLKpoLRyag/ElrjRqVzGKGC67nArhi4WDBePv+iZZLgFg4X01QR5AN3H9CfrLHh9nD4/uXEQjrYTjSM/QpM9SKhqVzCFIE/kxILPHB6BQHlELgVzTJQzGxG+IAex28LMFQqucxzhW+9fmupgtj0IbkXA7WhUSx1Pgo8jvp+EPYiqJuuyi/4jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypD/IK6c9c7E06RUKiWtRPoMJHHJkxztsZ1e0vubGmk=;
 b=iKdHQyh6hebN4qdHCaTElX8seZNTgx4ZjJg2wVMf/D1elFUhjBxgtHdFKjNnhv99zCMxUdLE5qcaX+AfuA0w1SoTsMRqsQrflpBPGcRkOg8H6og4T9yKYJ1KtpDKReAJZvLaiUIUmZTt7caQFfMotz2IiSvDkYQL6bchPm22IfAPK3SRl9FYdMNE5V3XGs4Y2VshM+1odsLz94aLaYCQg4nsGdzJAPzZFoJzAx5SVgj0LRbMZmycnfyuPKYtIA2BaZyDeC8+VC7Yi7eMZGZbOJFE1/csqN357KmZ7WX8aU1VoVk3Goy8kEglno4JfHyvCmhGzJONjV8w6DnjPaBOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypD/IK6c9c7E06RUKiWtRPoMJHHJkxztsZ1e0vubGmk=;
 b=E0YqgGKTNA8Aeju+Bd2L4xpVSaew92aRFUP1b4/SsU5ijMKWWGRYspnxBbdmjzK5qKMRjnNckU1zb8u8vAY4gP7b1A9Ntd0txdbHXuq86LN61/QcJS3x+QRpXJFgnvyVL13qhblWQ3FnAwhYuxsCpLJRjmVjVaAHN3rgrCY78+s=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB7006.eurprd04.prod.outlook.com (52.133.247.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 07:44:17 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:44:17 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
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
Date:   Tue, 24 Sep 2019 07:44:16 +0000
Message-ID: <VI1PR04MB7023BF1AD2C61C8A5ABAD5FEEE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <CGME20190923162736epcas3p2c1db3bf767a07f17b609bc91fbbd9648@epcas3p2.samsung.com>
 <714675448e7fbf3c930b0dca6fbe54fa5f87211b.1569256001.git.leonard.crestez@nxp.com>
 <979d107f-0a52-3aa4-a397-acb0ff754a3c@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92f38bf1-b1ed-42e1-2bfd-08d740c300ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB7006;
x-ms-traffictypediagnostic: VI1PR04MB7006:|VI1PR04MB7006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7006F967BB9B9D851385B1EEEE840@VI1PR04MB7006.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(110136005)(256004)(8676002)(86362001)(55016002)(486006)(14454004)(66476007)(52536014)(74316002)(66446008)(64756008)(229853002)(3846002)(6116002)(14444005)(7736002)(9686003)(6246003)(8936002)(305945005)(2906002)(81166006)(81156014)(5660300002)(71190400001)(71200400001)(6436002)(7696005)(44832011)(316002)(53546011)(7416002)(102836004)(66556008)(26005)(6506007)(54906003)(446003)(478600001)(99286004)(76176011)(186003)(33656002)(4326008)(91956017)(25786009)(66946007)(76116006)(476003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7006;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: opqCDMayzYa3xCkyxnpYMgiaXUx/dcyscz67zNZZjUWOp/6UZuOOEK2g8xFvinKIpJEpZH3eBXjvu+IvmtzbheK9oEOZGqUQPsM5C88vTRuox92NpeH3T76HYM3PkvdZqBERNE/3wnWvujKuyBxEjfA7mtO8/CO/jc3bjTMGDxEKysr1il/n2S0XJLfW8rBi56KxiA3iyJjv2BtF1yyecbBG2K4M+reSI7zsvZV02DBGmUc61dtZMvjONpxn6r70O0FHUSxUJ6ohlVPqjH8fMq9ZupegwKx1jMuadf5gr6ys+4RkdE/T3poNAOOyjYG9dTasjjIohSbmvJyf5silLoB3/ZVx/IJtJlGXMngcHTV4fJ18Mh/2I5MMx0lIuEkE3+kitCFCrxSLil4WOWGf+W2aKDkqPPXDHSUA8oSlDA0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f38bf1-b1ed-42e1-2bfd-08d740c300ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:44:16.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wl/XYGRWFkW7SsJHmGAkroo+Vbx+hDGYSZs1s11uT0SH16Vy79GHGW8u6VOhX252sOGjiJsHdaaP7+OSPTDEeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjAxOS0wOS0yNCA1OjA3IEFNLCBDaGFud29vIENob2kgd3JvdGU6Cj4gSGksCj4gCj4gT24g
MTkuIDkuIDI0LiDsmKTsoIQgMToyNywgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+PiBUaGVyZSBp
cyBubyBsb2NraW5nIGluIHRoaXMgc3lzZnMgc2hvdyBmdW5jdGlvbiBzbyBzdGF0cyBwcmludGlu
ZyBjYW4KPj4gcmFjZSB3aXRoIGEgZGV2ZnJlcV91cGRhdGVfc3RhdHVzIGNhbGxlZCBhcyBwYXJ0
IG9mIGZyZXEgc3dpdGNoaW5nIG9yCj4+IHdpdGggaW5pdGlhbGl6YXRpb24uCj4+Cj4+IEFsc28g
YWRkIGFuIGFzc2VydCBpbiBkZXZmcmVxX3VwZGF0ZV9zdGF0dXMgdG8gbWFrZSBpdCBjbGVhciB0
aGF0IGxvY2sKPj4gbXVzdCBiZSBoZWxkIGJ5IGNhbGxlci4KPj4KPj4gU2lnbmVkLW9mZi1ieTog
TGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4KPj4gLS0tCj4+ICAgZHJp
dmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDEzICsrKysrKysrKystLS0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4KPj4gQ2hhbmdlcyBzaW5j
ZSB2MToKPj4gKiBTcGxpdCBmcm9tIHNlcmllczogbG93LXByaW9yaXR5IGJ1Z2ZpeCBub3Qgc3Ry
aWN0bHkgcmVxdWlyZWQgZm9yIFBNIFFvUwo+PiAqIE9ubHkga2VlcCBsb2NrIGR1cmluZyB1cGRh
dGUsIHJlbGVhc2UgYmVmb3JlIHNwcmludGYKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2
ZnJlcS9kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+IGluZGV4IDRjNThm
YmY3ZDRlNC4uMDBmYzIzZmVhNWIyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2
ZnJlcS5jCj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4gQEAgLTIwNiwxMCAr
MjA2LDExIEBAIGludCBkZXZmcmVxX3VwZGF0ZV9zdGF0dXMoc3RydWN0IGRldmZyZXEgKmRldmZy
ZXEsIHVuc2lnbmVkIGxvbmcgZnJlcSkKPj4gICB7Cj4+ICAgCWludCBsZXYsIHByZXZfbGV2LCBy
ZXQgPSAwOwo+PiAgIAl1bnNpZ25lZCBsb25nIGN1cl90aW1lOwo+PiAgIAo+PiAgIAljdXJfdGlt
ZSA9IGppZmZpZXM7Cj4+ICsJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZGV2ZnJlcS0+bG9jayk7Cj4g
Cj4gSXQgYmV0dGVyIHRvIG1vdmUgbG9jayBjaGVja2luZyBiZWZvcmUgJ2N1cl90aW1lID0gamlm
ZmllcycKPiBpbiBvcmRlciB0byByZWR1Y2UgdGhlIHJlZHVuZGFudCBjb2RlIGV4ZWN1dGlvbi4K
Ck9LIGJ1dCBJIGRvbid0IHNlZSBob3cgdGhpcyBtYWtlcyBhIGRpZmZlcmVuY2UgZm9yIGFuIGFz
c2VydD8gSXQganVzdCAKcHJpbnRzIGEgd2FybmluZyBhbmQgY2FycmllcyBvbi4KCj4+ICAgCS8q
IEltbWVkaWF0ZWx5IGV4aXQgaWYgcHJldmlvdXNfZnJlcSBpcyBub3QgaW5pdGlhbGl6ZWQgeWV0
LiAqLwo+PiAgIAlpZiAoIWRldmZyZXEtPnByZXZpb3VzX2ZyZXEpCj4+ICAgCQlnb3RvIG91dDsK
Pj4gICAKPj4gQEAgLTE1MDcsMTYgKzE1MDgsMjIgQEAgc3RhdGljIHNzaXplX3QgdHJhbnNfc3Rh
dF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwKPj4gICAJc3RydWN0IGRldmZyZXEgKmRldmZyZXEg
PSB0b19kZXZmcmVxKGRldik7Cj4+ICAgCXNzaXplX3QgbGVuOwo+PiAgIAlpbnQgaSwgajsKPj4g
ICAJdW5zaWduZWQgaW50IG1heF9zdGF0ZSA9IGRldmZyZXEtPnByb2ZpbGUtPm1heF9zdGF0ZTsK
Pj4gICAKPj4gLQlpZiAoIWRldmZyZXEtPnN0b3BfcG9sbGluZyAmJgo+PiAtCQkJZGV2ZnJlcV91
cGRhdGVfc3RhdHVzKGRldmZyZXEsIGRldmZyZXEtPnByZXZpb3VzX2ZyZXEpKQo+PiAtCQlyZXR1
cm4gMDsKPj4gICAJaWYgKG1heF9zdGF0ZSA9PSAwKQo+PiAgIAkJcmV0dXJuIHNwcmludGYoYnVm
LCAiTm90IFN1cHBvcnRlZC5cbiIpOwo+PiAgIAo+PiArCS8qIGxvY2sgYW5kIHVwZGF0ZSAqLwo+
IAo+IEl0IGlzIG5vdCBuZWNlc3NhcnkuIEFueW9uZSBjYW4ga25vdyB0aGF0IHRoaXMgY29kZSBp
cyByZWxhdGVkIHRvIG11dGV4IGxvY2svdW5sb2NrLgoKT0suIFlvdSdyZSB0aGUgc2Vjb25kIHBl
cnNvbiB0byBtZW50aW9uIHRoaXMgYnV0IGl0J3MgcXVpdGUgc3RyYW5nZSB0byAKc2VlIG9iamVj
dGlvbnMgcmFpc2VkIGFnYWluc3QgY29tbWVudHMuCgo+PiArCW11dGV4X2xvY2soJmRldmZyZXEt
PmxvY2spOwo+PiArCWlmICghZGV2ZnJlcS0+c3RvcF9wb2xsaW5nICYmCj4+ICsJCQlkZXZmcmVx
X3VwZGF0ZV9zdGF0dXMoZGV2ZnJlcSwgZGV2ZnJlcS0+cHJldmlvdXNfZnJlcSkpIHsKPj4gKwkJ
bXV0ZXhfdW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsKPj4gKwkJcmV0dXJuIDA7Cj4+ICsJfQo+PiAr
CW11dGV4X3VubG9jaygmZGV2ZnJlcS0+bG9jayk7Cj4+ICsKPj4gICAJbGVuID0gc3ByaW50Zihi
dWYsICIgICAgIEZyb20gIDogICBUb1xuIik7Cj4+ICAgCWxlbiArPSBzcHJpbnRmKGJ1ZiArIGxl
biwgIiAgICAgICAgICAgOiIpOwo+PiAgIAlmb3IgKGkgPSAwOyBpIDwgbWF4X3N0YXRlOyBpKysp
Cj4+ICAgCQlsZW4gKz0gc3ByaW50ZihidWYgKyBsZW4sICIlMTBsdSIsCj4+ICAgCQkJCWRldmZy
ZXEtPnByb2ZpbGUtPmZyZXFfdGFibGVbaV0pOwo+Pgo+IAo+IEJhc2ljYWxseSwgaXQgaXMgbmVj
ZXNzYXJ5LiBQbGVhc2UgZWRpdCBpdCBieSBteSBjb21tZW50cy4KPiBBbHNvLCB5b3UgaGF2ZSB0
byBhZGQgdGhlIGZvbGxvd2luZyAnZml4ZXMnIGFzIGZvbGxvd2luZzoKPiBhbmQgc2VuZCBpdCBz
dGFibGUgbWFpbGluZyBsaXN0Lgo+IAo+IEZpeGVzOiAzOTY4OGNlNmZhY2QgKCJQTSAvIGRldmZy
ZXE6IGFjY291bnQgc3VzcGVuZC9yZXN1bWUgZm9yIHN0YXRzIikKPiAKPiBJZiB5b3UgZWRpdCBp
dCBieSBteSBjb21tZW50cywgZmVlbCBmcmVlIHRvIGFkZCBteSB0YWc6Cj4gUmV2aWV3ZWQtYnk6
IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo=
