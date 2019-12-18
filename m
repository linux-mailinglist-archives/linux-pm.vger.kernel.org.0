Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA65E124EE0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLRRNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 12:13:38 -0500
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:37446
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbfLRRNi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 12:13:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfqt2J2dzWZsh8bQBSebe/xUu6RFf2juw2IuL2u+1+jwxNtjHIhN4Mzn+dsZqzzxbmf7LGAA7tpUU8pCaRWwvT1b53tm1oZrGUA1TtCfFV2293EMWC4Bcg7mo9WUzHoDfNVh5tkIjHRu36VPlchghiw45pB0Sbk7hxl/AGqXXYUYj13MV5lGii/tIQM2g+lj4V6uWrE0VXqI43xf06NmC1qh094cf6dgKjgwT5qATgWI/GqykbBkpQ9wuXt0+ZBNRpzWRGN4d5iicve2dZp0wD8tI9NVlO/YXIWfYlQBUgmIGpY1rebWjV5+ltdRlUT6u5J5fNDA9YCTLTYBsiwCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M7jWWbYdprhFwXLnYqSVUa/WdXz0TZG3xv7L7rNTRQ=;
 b=PE4UOlEsunToWBJrCSHfKeNfU0pVfZDslpQkGTLGW9uCN1Lh4nv7Qi3jJiz+PJkWNRyD99StFikMHfU2VWfkmhAfRDJ9TTlaWRGAnycuv1nwlvdod8URJTmAo5m6OI8Ru7lySZHYM1SK5aw8Pl4F/zPJ70s3YJ14ysQ+imNKwMLzUCrEYGJMXBTiUuHzRhkF4QU+G1CHq6klvzqK/lCVi/ydf2q7aljt7fjhC8+grvOw1YV6j+7lyR5BkAbiU52tnZlI4UUN85xCAfMOGASwbY3sBZcoe/bESNbrElN8Om3z/qiPsumxrnhv60nXtvU1Y+TburfsRMZxjwCJMOjjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M7jWWbYdprhFwXLnYqSVUa/WdXz0TZG3xv7L7rNTRQ=;
 b=P/IIVCxc39rFL7IegH2mEHfve2Y2aRrHJeKDNu8Rt2LK/m/3k0Knq97TNvp1dtNxjnj27h3TnL2zwvxOcRP8PHc5fpeJz91+DQLohq3gAC6LTfetzyWaTp5B4/nkJWFvvkZIFdqr8JpdHiFWVvApLJpL9wlA9AIDFHvgfzK0s8I=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4926.eurprd04.prod.outlook.com (20.177.48.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 17:13:24 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 17:13:24 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <chanwoo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v6 3/9] PM / devfreq: imx: Register interconnect
 device
Thread-Topic: [PATCH RFC v6 3/9] PM / devfreq: imx: Register interconnect
 device
Thread-Index: AQHVmyeZRYeaOo08e0y/DVNQANceVQ==
Date:   Wed, 18 Dec 2019 17:13:24 +0000
Message-ID: <VI1PR04MB7023B782510853FE0FDDEFEEEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <CGME20191114201049epcas5p370853a1d78584bf00d8493ce20320bf9@epcas5p3.samsung.com>
 <e0e6a1685ccdad95c9d0c922801afdda8adb9f05.1573761527.git.leonard.crestez@nxp.com>
 <4d45cd39-24df-1714-0a27-5019c1367063@samsung.com>
 <VI1PR04MB7023F511BAE7D1EDF971CC48EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <60fe19c6-6e73-4133-ed7e-a13a875589c0@samsung.com>
 <VI1PR04MB7023DAC69C8B4B7CF144F29EEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAGTfZH1omr9jqRv9JX+X253YardFx_B26Hm-cT8UNF2J7eC_og@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a13e83ca-d15e-4861-e547-08d783dd9756
x-ms-traffictypediagnostic: VI1PR04MB4926:|VI1PR04MB4926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4926C3D05CA1BCE7AB18DFD5EE530@VI1PR04MB4926.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(51444003)(199004)(189003)(66446008)(64756008)(86362001)(66556008)(91956017)(66946007)(186003)(76116006)(7416002)(55016002)(9686003)(5660300002)(53546011)(54906003)(26005)(6506007)(66476007)(44832011)(33656002)(8676002)(2906002)(52536014)(478600001)(7696005)(81156014)(110136005)(81166006)(4326008)(8936002)(316002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4926;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rmyMP62vFMtAJtZ41gzGevjTEIe3QRvRpVODedwD+HVmaOw/+9LCGvm1njwsKDVKNR2wVygxFuXlBtmczy4UmFKGx9CmYHRl0Tkx7vu0tGKOnYyanyq3er7415PyInWqZCKSK0cfh35DBPzn9WfTiqAnf5Org0fl57IybJYqJ9bs3pOCJuIC+Bo2DSACOIVjHunU12Qb6oUs+gNqat7IhiIYKujq5UjUU4yNUFrcUtVHDM7iAL0HyL/9LKzEGE/FQ8GV7Ls4MnNHPe09zPF95e19UMiRE/qhJWjsHHlBmFN0yKxin/JZi5zRoKAeCHbZ79GqNdGwhys0NfmZ5l8UyDVwhc0vTk3lZXQe1vglrN7CTaYP7SuPph1Hfxn+1csYjgpQRpXFcmC6NICxuFa7urzMCuKNDSRvuecQK/7zTJdMCx3OFFUc/xqNXrTOK6l+5Q4A4BZROOlpuKrIdRTlODZzT1DIpRsWugThOmKm7HcAUqhtAt8NHzb2cjIQtiex
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13e83ca-d15e-4861-e547-08d783dd9756
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 17:13:24.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijzG876/Ao/3bKaVSyjH6lAoa6OIhsHqVUskkgKpCKO6V/zEmy9vF7+Rm/plJY9OEIn0eCAps5HNOIvDSJv93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4926
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTguMTIuMjAxOSAxMzowNiwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IDIwMTmz4iAxMr/5IDE4
wM8gKLz2KSC/wMjEIDc6MTQsIExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5j
b20+tNTAzCDA27y6Ogo+PiBPbiAxNy4xMi4yMDE5IDAyOjU1LCBDaGFud29vIENob2kgd3JvdGU6
Cj4+PiBPbiAxMi8xNy8xOSAxMjowMCBBTSwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+Pj4+IE9u
IDEzLjEyLjIwMTkgMDY6MjIsIENoYW53b28gQ2hvaSB3cm90ZToKPj4+Pj4gT24gMTEvMTUvMTkg
NTowOSBBTSwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOgo+Pj4+Pj4gVGhlcmUgaXMgbm8gc2luZ2xl
IGRldmljZSB3aGljaCBjYW4gcmVwcmVzZW50IHRoZSBpbXggaW50ZXJjb25uZWN0Lgo+Pj4+Pj4g
SW5zdGVhZCBvZiBhZGRpbmcgYSB2aXJ0dWFsIG9uZSBqdXN0IG1ha2UgdGhlIG1haW4gJm5vYyBh
Y3QgYXMgdGhlCj4+Pj4+PiBnbG9iYWwgaW50ZXJjb25uZWN0IHByb3ZpZGVyLgo+Pj4+Pj4KPj4+
Pj4+IFRoZSBpbXggaW50ZXJjb25uZWN0IHByb3ZpZGVyIGRyaXZlciB3aWxsIHNjYWxlIHRoZSBO
T0MgYW5kIEREUkMgYmFzZWQKPj4+Pj4+IG9uIGJhbmR3aWR0aCByZXF1ZXN0LiBNb3JlIHNjYWxh
YmxlIG5vZGVzIGNhbiBiZSBhZGRlZCBpbiB0aGUgZnV0dXJlLAo+Pj4+Pj4gZm9yIGV4YW1wbGUg
Zm9yIGF1ZGlvL2Rpc3BsYXkvdnB1L2dwdSBOSUNzLgo+Pj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Cj4+Pj4+PiAtLS0K
Pj4+Pj4+ICAgICBkcml2ZXJzL2RldmZyZXEvaW14LWRldmZyZXEuYyB8IDM3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDM3IGlu
c2VydGlvbnMoKykKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2lt
eC1kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEvaW14LWRldmZyZXEuYwo+Pj4+Pj4gaW5kZXgg
NjIwYjM0NGU4N2FhLi41ODVkMzQwYzBmNmUgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2Rl
dmZyZXEvaW14LWRldmZyZXEuYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2lteC1kZXZm
cmVxLmMKPj4+Pj4+IEBAIC0xNSwxMCArMTUsMTEgQEAKPj4+Pj4+ICAgICBzdHJ1Y3QgaW14X2Rl
dmZyZXEgewo+Pj4+Pj4gICAgICAgICAgICAgc3RydWN0IGRldmZyZXFfZGV2X3Byb2ZpbGUgcHJv
ZmlsZTsKPj4+Pj4+ICAgICAgICAgICAgIHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxOwo+Pj4+Pj4g
ICAgICAgICAgICAgc3RydWN0IGNsayAqY2xrOwo+Pj4+Pj4gICAgICAgICAgICAgc3RydWN0IGRl
dmZyZXFfcGFzc2l2ZV9kYXRhIHBhc3NpdmVfZGF0YTsKPj4+Pj4+ICsgIHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKmljY19wZGV2Owo+Pj4+Pj4gICAgIH07Cj4+Pj4+Pgo+Pj4+Pj4gICAgIHN0YXRp
YyBpbnQgaW14X2RldmZyZXFfdGFyZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nICpmcmVxLCB1MzIgZmxh
Z3MpCj4+Pj4+PiAgICAgewo+Pj4+Pj4gQEAgLTYwLDExICs2MSw0MCBAQCBzdGF0aWMgaW50IGlt
eF9kZXZmcmVxX2dldF9kZXZfc3RhdHVzKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+Pj4+ICAgICAg
ICAgICAgIHJldHVybiAwOwo+Pj4+Pj4gICAgIH0KPj4+Pj4+Cj4+Pj4+PiAgICAgc3RhdGljIHZv
aWQgaW14X2RldmZyZXFfZXhpdChzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+Pj4+PiAgICAgewo+Pj4+
Pj4gKyAgc3RydWN0IGlteF9kZXZmcmVxICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cj4+
Pj4+PiArCj4+Pj4+PiAgICAgICAgICAgICBkZXZfcG1fb3BwX29mX3JlbW92ZV90YWJsZShkZXYp
Owo+Pj4+Pj4gKyAgcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIocHJpdi0+aWNjX3BkZXYpOwo+
Pj4+Pj4gK30KPj4+Pj4+ICsKPj4+Pj4+ICsvKiBpbXhfZGV2ZnJlcV9pbml0X2ljYygpIC0gcmVn
aXN0ZXIgbWF0Y2hpbmcgaWNjIHByb3ZpZGVyIGlmIHJlcXVpcmVkICovCj4+Pj4+PiArc3RhdGlj
IGludCBpbXhfZGV2ZnJlcV9pbml0X2ljYyhzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+Pj4+PiArewo+
Pj4+Pj4gKyAgc3RydWN0IGlteF9kZXZmcmVxICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7
Cj4+Pj4+PiArICBjb25zdCBjaGFyICppY2NfZHJpdmVyX25hbWU7Cj4+Pj4+PiArCj4+Pj4+PiAr
ICBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0lOVEVSQ09OTkVDVF9JTVgpKQo+Pj4+Pj4gKyAgICAg
ICAgICByZXR1cm4gMDsKPj4+Pj4KPj4+Pj4gSXQgaXMgbm90IHByb3BlciB0byBjaGVjayB0aGUg
ZW5hYmxlIHN0YXRlIG9mIENPTkZJR19JTlRFUkNPTk5FQ1RfSU1YIGNvbmZpZ3VyYXRpb24KPj4+
Pj4gb24gZGV2aWNlIGRyaXZlci4gV2h5IGRvbid0IHlvdSBhZGQgdGhlICdzZWxlY3QgQ09ORklH
X0lOVEVSQ09OTkVDVF9JTVgnIG9uIEtjb25maWc/Cj4+Pj4KPj4+PiBCZWNhdXNlIGl0J3Mgb3B0
aW9uYWwuCj4+Pj4KPj4+PiBZb3UgY2FuIGRpc2FibGUgaW50ZXJjb25uZWN0IHN1cHBvcnQgYW5k
IGp1c3QgdHdlYWsgZnJlcXVlbmNpZXMgdXNpbmcKPj4+PiB0aGUgZGV2ZnJlcSBzeXNmcyBBUEku
IEJ1dCBpbmRlZWQgd291bGQgb25seSByZWFsbHkgYmUgdXNlZnVsIGZvciBkZWJ1Z2dpbmcuCj4+
Pgo+Pj4gRXZlbiBpZiBpdCdzIG9wdGlvbmFsLCBJIGRvbid0IHByZWZlciB0byB1c2UgJ0lTX0VO
QUJMRUQnIG1hY3JvLgo+Pj4KPj4+IEdlbmVyYWxseSwgYWRkIG9yIGRlbGV0ZSB0aGUgcHJvcGVy
dHkgb3IgdmFsdWUgYXQgRFQgZmlsZQo+Pj4gdG8gZWl0aGVyIGVuYWJsZSBvciBkaXNhYmxlIHRo
ZSBzb21lIGZlYXR1cmUgcHJvdmlkZWQgYnkgZGV2aWNlIGRyaXZlcgo+Pj4gaW5zdGVhZCBvZiBj
aGVja2luZyB0aGUgY29uZmlndXJhdGlvbi4KPj4+Cj4+PiBJZiB1c2VyIGFkZHMgdGhlIHByb3Bl
cnR5L3ZhbHVlIHJlbGF0ZWQgdG8gaW50ZXJjb25uZWN0Cj4+PiBhbmQgaW14LWJ1cy5jIGNvbmZp
Z3VyYXRpb24gaXMgZW5hYmxlZCwgdGhlIGJlaGF2aW9yCj4+PiByZWxhdGVkIHRvIGludGVyY29u
bmVjdCBvbiBpbXgtYnVzLmMgZG9lc24ndCB3b3JrLiBJdCBtYWtlIHNvbWUgY29uZnVzaW9uLgo+
Pgo+PiBNYXliZSBJIGNvdWxkIHByaW50IGEgd2FybmluZyBpZiAjaW50ZXJjb25uZWN0LWNlbGxz
IGlzIHByZXNlbnQgYnV0Cj4+IENPTkZJR19JTlRFUkNPTk5FQ1RfSU1YIGlzIG9mZj8KPiAKPiBB
Y3R1YWxseSwgdXNlciBtaWdodCB0aGluayB0aGF0IGlmIGlteC1idXMuYyBpcyBlbmFibGVkCj4g
LCBDT05GSUdfSU5URVJDT05ORUNUX01JWCBpcyBlbmFibGVkLgo+IEJlY2F1c2UsIHRoZSBkdCBi
aW5kaW5nIGRvY3VtZW50IG9mIGlteC1idXMuYyB3aWxsCj4gY29udGFpbiB0aGUgcHJvcGVydHkg
Zm9yIGludGVyY29ubmVjdC4KPiAKPiBJZiBkZXZpY2UgZHJpdmVyIHN1cHBvcnQgdGhlIHZhcmlv
dXMgZmVhdHVyZSwKPiB0aGUgZGV2aWNlIGRyaXZlciBoYXZlIHRvIGVuYWJsZSBhbGwgY29uZmln
dXJhdGlvbgo+IGluIG9yZGVyIHRvIHN1cHBvcnQgdGhlIGZlYXR1cmVzIGZvciB1c2VyLgoKCj4+
IEFuIGV4cGxpY2l0IHNlbGVjdCBpbiBLY29uZmlnIHNlZW1zIGxpa2UgYSBwb2ludGxlc3MgbGlt
aXRhdGlvbiBidXQgaW4KPj4gcHJhY3RpY2UgaXQgd291bGQgYWxtb3N0IG5ldmVyIGJlIHVzZWZ1
bCB0byBidWlsZCBvbmUgd2l0aG91dCB0aGUgb3RoZXIuCj4gCj4gVGhpcyBwYXRjaCBpcyBmb3Ig
dGhlIHNvbWUgQ09ORklHX0lOVEVSQ09OTkVDVF9JTVggZHJpdmVyLgo+IEkgZG9uJ3QgdW5kZXJz
dGFuZCB3aHkgaXMgbm90IG1lYW5pbmdmdWwgdG8gc2VsZWN0IENPTkZJR19JTlRFUkNPTk5FQ1Rf
SU1YCj4gaW4gS2NvbmZpZz8KCk9uZSBpc3N1ZSBpcyB0aGF0IHRoZSBpbnRlcmNvbm5lY3QgZ3Jh
cGggaXMgZGVzY3JpYmVkIHBlci1zb2MgYW5kIHRoZXJlIAphcmUgcGVyLXNvYyBjb25maWcgb3B0
aW9ucyB3aGlsZSBpbXgtYnVzIGFwcGxpZXMgdG8gYWxsLiBTbyB0aGUgImlmIiAKY29uZGl0aW9u
IGlzIG5vdCBzdWZmaWNpZW50IGVpdGhlcjsgaWYgdGhlIHBlci1zb2MgaW50ZXJjb25uZWN0IGRy
aXZlciAKaXMgb21pdHRlZCB0aGVuIHRoZSBwbGF0Zm9ybSBkZXZpY2Ugd2lsbCBiZSBhZGRlZCBi
dXQgbm8gZHJpdmVyIHdpbGwgYmUgCmV2ZXIgYmUgZm91bmQuCgpUaGVyZSBhcmUgd2F5cyBhcm91
bmQgdGhpczogZm9yIGV4YW1wbGUgYWxsIG9mIGlteCBpbnRlcmNvbm5lY3QgY291bGQgYmUgCmJ1
aWx0IGFzIGEgc2luZ2xlIG1vZHVsZS4gQnV0IEkgdGhpbmsgaXQncyByZWFzb25hYmxlIGZvciBk
ZXZpY2VzIHRvIGJlIApwYXJ0aWFsbHkgZnVuY3Rpb25hbCBpZiBzb21lIGNvbmZpZyBvcHRpb25z
IGFyZSBtaXNzaW5nIGFuZCBoZWF2eSBjb25maWcgCmN1c3RvbWl6YXRpb24gc29tZXRpbWVzIHJl
cXVpcmVzIGEgYml0IG9mIGRlYnVnZ2luZy4KClRoZXJlIGFyZSB2YXJpb3VzIGlzc3VlcyB3aGVu
IGJ1aWxkaW5nIHRoZSBjdXJyZW50IHNlcmllcyBhcyAibSIgYnV0IEkgCmNhbiBzb2x2ZSB0aGVt
IGFuZCBwb3N0IGEgZmluYWwgcGF0Y2ggd2hpY2ggc2V0cyBhbGwgdGhlIHJlbGV2YW50IApvcHRp
b25zIG9uICJtIiBpbiBhcm02NCBkZWZjb25maWcuIFRoZSBpdCB3aWxsIGFsbCAianVzdCB3b3Jr
IiBvdXQgb2YgCnRoZSBib3guCgo+Pj4gVGhlIGlteC1idXMuYyBoYXZlIHRvIGFkZCB0aGUgJ3Nl
bGVjdCBDT05GSUdfSU5URVJDT05ORUNUX0lNWCcKPj4+IGFuZCBoYW5kIG92ZXIgdGhlIHJpZ2h0
IHdoaWNoIHVzZSB0aGUgaW50ZXJjb25uZWN0IGZlYXR1cmUgb3Igbm90LCB0byB1c2VyLgo+Pj4K
Pj4+IElmIHRoZXJlIGFyZSBhbnkgcmVxdWlyZW1lbnQgdG8gYWRkIHRoZSBhZGRpdGlvbmFsIHBy
b3BlcnR5Cj4+PiB0byBjaGVjayB3aGV0aGVyIGludGVyY29ubmVjdCBmZWF0dXJlIHdpbGwgYmUg
dXNlZCBvciBub3QsCj4+PiB5b3UgY2FuIGFkZCB0aGUgZXh0cmEgcHJvcGVydHkuIEJ1dCwgSSB0
aGluayB0aGF0IGl0IGlzIGVub3VnaAo+Pj4gdG8gY2hlY2sgdGhlICcjaW50ZXJjb25uZWN0LWNl
bGxzJy4KPj4+Cj4+PiBJbiByZXN1bHQsIEkgdGhpbmsgdGhhdCBpdCBpcyByaWdodCB0byBkZWNp
ZGUgdGhlIHVzYWdlIG9mIGZlYXR1cmUKPj4+IG9mIGRldmljZSBkcml2ZXIgYnkgdXNlciBvbiBE
ZXZpY2V0cmVlLgo+Pj4KPj4+Pgo+Pj4+Pj4gKyAgaWYgKCFvZl9nZXRfcHJvcGVydHkoZGV2LT5v
Zl9ub2RlLCAiI2ludGVyY29ubmVjdC1jZWxscyIsIDApKQo+Pj4+Pj4gKyAgICAgICAgICByZXR1
cm4gMDsKPj4+Pj4+ICsKPj4+Pj4+ICsgIGljY19kcml2ZXJfbmFtZSA9IG9mX2RldmljZV9nZXRf
bWF0Y2hfZGF0YShkZXYpOwo+Pj4+Pj4gKyAgaWYgKCFpY2NfZHJpdmVyX25hbWUpCj4+Pj4+PiAr
ICAgICAgICAgIHJldHVybiAwOwo+Pj4+Pj4gKwo+Pj4+Pj4gKyAgcHJpdi0+aWNjX3BkZXYgPSBw
bGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfZGF0YSgKPj4+Pj4+ICsgICAgICAgICAgICAgICAgICBk
ZXYsIGljY19kcml2ZXJfbmFtZSwgMCwgTlVMTCwgMCk7Cj4+Pj4+PiArICBpZiAoSVNfRVJSKHBy
aXYtPmljY19wZGV2KSkgewo+Pj4+Pj4gKyAgICAgICAgICBkZXZfZXJyKGRldiwgImZhaWxlZCB0
byByZWdpc3RlciBpY2MgcHJvdmlkZXIgJXM6ICVsZFxuIiwKPj4+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgIGljY19kcml2ZXJfbmFtZSwgUFRSX0VSUihwcml2LT5kZXZmcmVxKSk7Cj4+
Pj4+PiArICAgICAgICAgIHJldHVybiBQVFJfRVJSKHByaXYtPmRldmZyZXEpOwo+Pj4+Pj4gKyAg
fQo+Pj4+Pj4gKwo+Pj4+Pj4gKyAgcmV0dXJuIDA7Cj4+Pj4+PiAgICAgfQo+Pj4+Pj4KPj4+Pj4+
ICAgICBzdGF0aWMgaW50IGlteF9kZXZmcmVxX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCj4+Pj4+PiAgICAgewo+Pj4+Pj4gICAgICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsKPj4+Pj4+IEBAIC0xMjAsMTggKzE1MCwyNSBAQCBzdGF0aWMgaW50IGlt
eF9kZXZmcmVxX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+Pj4+PiAgICAg
ICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIocHJpdi0+ZGV2ZnJlcSk7Cj4+Pj4+PiAgICAg
ICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGFkZCBkZXZmcmVxIGRldmlj
ZTogJWRcbiIsIHJldCk7Cj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+Pj4+
Pj4gICAgICAgICAgICAgfQo+Pj4+Pj4KPj4+Pj4+ICsgIHJldCA9IGlteF9kZXZmcmVxX2luaXRf
aWNjKGRldik7Cj4+Pj4+PiArICBpZiAocmV0KQo+Pj4+Pj4gKyAgICAgICAgICBnb3RvIGVycjsK
Pj4+Pj4+ICsKPj4+Pj4+ICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4+Pj4KPj4+Pj4+ICAgICBl
cnI6Cj4+Pj4+PiAgICAgICAgICAgICBkZXZfcG1fb3BwX29mX3JlbW92ZV90YWJsZShkZXYpOwo+
Pj4+Pj4gICAgICAgICAgICAgcmV0dXJuIHJldDsKPj4+Pj4+ICAgICB9Cj4+Pj4+Pgo+Pj4+Pj4g
ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9kZXZmcmVxX29mX21hdGNo
W10gPSB7Cj4+Pj4+PiArICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bXEtbm9jIiwgLmRhdGEg
PSAiaW14OG1xLWludGVyY29ubmVjdCIsIH0sCj4+Pj4+PiArICB7IC5jb21wYXRpYmxlID0gImZz
bCxpbXg4bW0tbm9jIiwgLmRhdGEgPSAiaW14OG1tLWludGVyY29ubmVjdCIsIH0sCj4+Pj4+PiAr
ICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bW4tbm9jIiwgLmRhdGEgPSAiaW14OG1uLWludGVy
Y29ubmVjdCIsIH0sCj4+Pj4+PiAgICAgICAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4
bS1ub2MiLCB9LAo+Pj4+Pj4gICAgICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG0t
bmljIiwgfSwKPj4+Pj4+ICAgICAgICAgICAgIHsgLyogc2VudGluZWwgKi8gfSwKPj4+Pj4+ICAg
ICB9Owo+Pj4+Pj4gICAgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGlteF9kZXZmcmVxX29mX21h
dGNoKTsK
