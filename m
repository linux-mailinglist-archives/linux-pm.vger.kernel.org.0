Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7BC167956
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 10:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBUJ0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 04:26:35 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:6081
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbgBUJ0e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 04:26:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDRmH9arAq3dFlz5BPv5KEa1L6+aYcpL/tpK+kMFhu6QECXeQ6gKZhx8q3M8TU0bX5vt37oYSinzoTUK5dcY9CNEkQxgT24Hi9qmnW8uiIwZn/FsjeBIIlIv/WZZGg2+ZBKhV8kAn8kr0m0KrtgXQYpYxzkDKNA5mgEKo+YT8Q6jbUh2S4qsH3VtzWd4WV1srB8XPvlCIr1eXDFmW6ak9vnnLGCCaKRGfrP7Z6j12StCx263qb6FzPkexsakhNL2U9s9kzxpNTXD4EO9Znk2v+KvzeXZJQ7IxU2xbzgSfCMVUkIXu6YJDYh8BNgQAN45fOs1zYRXiykyHD3ja6VX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0giFPnSvmnjpbwqhx8Hne85FcxFlRSPX0nwydJJbV0=;
 b=ea71PZEa7psZhZ/zU0IXl40vQpKiKh2FF/mgHXJiaULjFCPEZdYF8DA+1IbQddivzXRx39k6aETbML2wGEsJnCv7yTh19uJRpDp9dInPnELmLwlHyoOFItGbMR+LAgfFKjrhHWpUFnFEpkTsASKRP2hudhOO0kyIxLrqxvrPzRAxiMYDfxt4my2uUlcjAcrn8gX2uclBXGTGcFNENe1+vv862xCW8AtHOYrKg+diD7tveQEoGK8RWWFtrLU5SXMOJKcTSTJPUZDINOGUhxJPkbJv8NMT343VTpL7m87VeqtxnqUBtSiq7wLJ/PGUzf8p9NgK/sVtx5YRmAg+0BLXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0giFPnSvmnjpbwqhx8Hne85FcxFlRSPX0nwydJJbV0=;
 b=fgBAY7wQ5rrlqTVa5i5oJVN868rO1ymlSsWHP4cXuPz3xegrijO5Gm9D3dVFKQkHno2ocYOTAQ9gXi/HvYtkBVkEBxR+Eqs7VHR2DOTw1bYqhBgqY52D8CA+9qzHmFCuvZRRO995xv/cgFfENHeU3It9zOhw879SoNvbZNV9L+4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3737.eurprd04.prod.outlook.com (52.134.66.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 21 Feb 2020 09:26:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 09:26:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V15 RESEND 2/5] thermal: of-thermal: add API for getting
 sensor ID from DT
Thread-Topic: [PATCH V15 RESEND 2/5] thermal: of-thermal: add API for getting
 sensor ID from DT
Thread-Index: AQHV54twqrQqqnnsY0eYUhsqk5r9AKglXqIAgAADj2A=
Date:   Fri, 21 Feb 2020 09:26:29 +0000
Message-ID: <DB3PR0402MB39161BB726FE5413F30F0263F5120@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-2-git-send-email-Anson.Huang@nxp.com>
 <20200221091112.GA10516@linaro.org>
In-Reply-To: <20200221091112.GA10516@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [220.161.57.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e40dc78a-034b-4243-515d-08d7b6b021cc
x-ms-traffictypediagnostic: DB3PR0402MB3737:|DB3PR0402MB3737:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3737A1FE521DD5D7155104F4F5120@DB3PR0402MB3737.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(189003)(199004)(44832011)(9686003)(66946007)(6506007)(66476007)(71200400001)(7696005)(2906002)(54906003)(66446008)(66556008)(64756008)(478600001)(4326008)(26005)(6916009)(8936002)(86362001)(7416002)(55016002)(76116006)(81166006)(8676002)(186003)(81156014)(316002)(52536014)(33656002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3737;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zO4VrkzUXXZXpFJqPsWE2OvpQjaaM0Wu066Dw4MX8udYfK5S8H03IR8tLBlybzHcNY7/kYFYVPBU68WBwqUL/sBeGiqc8oZ3PZ4ieRzgzph1w+/WKLSSbgEifO9nM5VzD0E9B20258hx6e5r/3iWmZ7qA9KQfmCWFnxL/yW0GNpbISkrt6gB5czTOOiqaPgcI9wk0K46PqJFse9NWfYJiR5EpywHOUGvMrAKsdW3y9D7yKXM7PmwkbsV1A70p9Clr2tZewh0vm8Fg2qp0eAmpqaRDOps9h0krUGGtX4y7H0uRsprXmyT4jti4s7BxlY8ulRhJ0Wz+nKKzVXI+460UBskFFxU9i08/+OAq1fx23Gnecim4e7CY1ZVRENFHEATO+HINOBHz4DBdphm7llI/ZXI7SsJgNmsvhGsvYZe31O3JKa+z4eL/jmADzSLuOQr
x-ms-exchange-antispam-messagedata: kcMEX8JNac2kGJTadbF7k9I+B4iORTg2BVPIE/IGZv7grFZlJFF98ymJHD/YLr/l0luyYF8Co0/7YndxxiyJc05Qrx67ZOFZDO/nbbqO2c83P7w4O8Hd/U9b6gchiWWez87hZFI+Um5RGsxQYZOgiw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40dc78a-034b-4243-515d-08d7b6b021cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 09:26:29.1703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQAKJOZtFIi4RJviNGgYUDwsOUUHcY7vBTkGvPGzsvT73sTIHv8pj54HosqOxhw/Y64myy/gs1sQnMqR7+wYpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3737
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjE1IFJFU0VORCAyLzVdIHRoZXJt
YWw6IG9mLXRoZXJtYWw6IGFkZCBBUEkgZm9yIGdldHRpbmcNCj4gc2Vuc29yIElEIGZyb20gRFQN
Cj4gDQo+IEhpLA0KPiANCj4gT24gVGh1LCBGZWIgMjAsIDIwMjAgYXQgMDk6MTA6MjVBTSArMDgw
MCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIG5ldyBBUEkgdGhlcm1h
bF96b25lX29mX2dldF9zZW5zb3JfaWQoKSB0byBwcm92aWRlIHRoZQ0KPiA+IGZlYXR1cmUgb2Yg
Z2V0dGluZyBzZW5zb3IgSUQgZnJvbSBEVCB0aGVybWFsIHpvbmUncyBub2RlLiBJdCdzIHVzZWZ1
bA0KPiA+IGZvciB0aGVybWFsIGRyaXZlciB0byByZWdpc3RlciB0aGUgc3BlY2lmaWMgdGhlcm1h
bCB6b25lIGRldmljZXMgZnJvbQ0KPiA+IERUIGluIGEgY29tbW9uIHdheS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+
IENoYW5nZXMgc2luY2UgVjE0Og0KPiA+IAktIGltcHJvdmUgdGhlIGNvbW1pdCBtZXNzYWdlIGFu
ZCBjb21tZW50LCBubyBjb2RlIGNoYW5nZS4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90aGVybWFs
L29mLXRoZXJtYWwuYyB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4g
LS0tLS0tLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCAgICAgIHwgMTAgKysrKysr
Kw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMNCj4g
PiBiL2RyaXZlcnMvdGhlcm1hbC9vZi10aGVybWFsLmMgaW5kZXggZWYwYmFhOS4uMGY1NzEwOCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvb2YtdGhlcm1hbC5jDQo+ID4gKysrIGIv
ZHJpdmVycy90aGVybWFsL29mLXRoZXJtYWwuYw0KPiA+IEBAIC00NDksNiArNDQ5LDUzIEBAIHRo
ZXJtYWxfem9uZV9vZl9hZGRfc2Vuc29yKHN0cnVjdCBkZXZpY2Vfbm9kZQ0KPiA+ICp6b25lLCAg
fQ0KPiA+DQo+ID4gIC8qKg0KPiA+ICsgKiB0aGVybWFsX3pvbmVfb2ZfZ2V0X3NlbnNvcl9pZCAt
IGdldCBzZW5zb3IgSUQgZnJvbSBhIERUIHRoZXJtYWwNCj4gPiArIHpvbmUNCj4gPiArICogQHR6
X25wOiBhIHZhbGlkIHRoZXJtYWwgem9uZSBkZXZpY2Ugbm9kZS4NCj4gPiArICogQHNlbnNvcl9u
cDogYSBzZW5zb3Igbm9kZSBvZiBhIHZhbGlkIHNlbnNvciBkZXZpY2UuDQo+ID4gKyAqIEBpZDog
dGhlIHNlbnNvciBJRCByZXR1cm5lZCBpZiBzdWNjZXNzLg0KPiA+ICsgKg0KPiA+ICsgKiBUaGlz
IGZ1bmN0aW9uIHdpbGwgZ2V0IHNlbnNvciBJRCBmcm9tIGEgZ2l2ZW4gdGhlcm1hbCB6b25lIG5v
ZGUNCj4gPiArIGFuZA0KPiA+ICsgKiB0aGUgc2Vuc29yIG5vZGUgbXVzdCBtYXRjaCB0aGUgdGVt
cGVyYXR1cmUgcHJvdmlkZXIgQHNlbnNvcl9ucC4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAw
IG9uIHN1Y2Nlc3MsIHByb3BlciBlcnJvciBjb2RlIG90aGVyd2lzZS4NCj4gPiArICovDQo+ID4g
Kw0KPiA+ICtpbnQgdGhlcm1hbF96b25lX29mX2dldF9zZW5zb3JfaWQoc3RydWN0IGRldmljZV9u
b2RlICp0el9ucCwNCj4gPiArCQkJCSAgc3RydWN0IGRldmljZV9ub2RlICpzZW5zb3JfbnAsDQo+
ID4gKwkJCQkgIHUzMiAqaWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3Mg
c2Vuc29yX3NwZWNzOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBvZl9wYXJz
ZV9waGFuZGxlX3dpdGhfYXJncyh0el9ucCwNCj4gPiArCQkJCQkgInRoZXJtYWwtc2Vuc29ycyIs
DQo+ID4gKwkJCQkJICIjdGhlcm1hbC1zZW5zb3ItY2VsbHMiLA0KPiA+ICsJCQkJCSAwLA0KPiA+
ICsJCQkJCSAmc2Vuc29yX3NwZWNzKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJl
dDsNCj4gPiArDQo+ID4gKwlpZiAoc2Vuc29yX3NwZWNzLm5wICE9IHNlbnNvcl9ucCkgew0KPiA+
ICsJCW9mX25vZGVfcHV0KHNlbnNvcl9zcGVjcy5ucCk7DQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHNlbnNvcl9zcGVjcy5hcmdzX2NvdW50ID49IDEp
IHsNCj4gDQo+IEZvciB0aGUgc2FrZSBvZiBjbGFyaXR5LCBtb3ZlIHRoZSBzYW5pdHkgdGVzdHMg
YmVmb3JlOg0KPiANCj4gCWlmIChzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCA+IDEpDQo+IAkJcHJf
d2FybigiLi4uIik7DQo+IA0KPiAJKmlkID0gc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQgPyBzZW5z
b3Jfc3BlY3MuYXJnc1swXSA6IDA7DQo+IA0KDQpNYWtlIHNlbnNlLCB3aWxsIGltcHJvdmUgaXQg
aW4gVjE2Lg0KDQo+ID4gKwkJKmlkID0gc2Vuc29yX3NwZWNzLmFyZ3NbMF07DQo+ID4gKwkJV0FS
TihzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCA+IDEsDQo+ID4gKwkJICAgICAiJXBPRm46IHRvbyBt
YW55IGNlbGxzIGluIHNlbnNvciBzcGVjaWZpZXIgJWRcbiIsDQo+ID4gKwkJICAgICBzZW5zb3Jf
c3BlY3MubnAsIHNlbnNvcl9zcGVjcy5hcmdzX2NvdW50KTsNCj4gPiArCX0gZWxzZSB7DQo+ID4g
KwkJKmlkID0gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlvZl9ub2RlX3B1dChzZW5zb3Jfc3Bl
Y3MubnApOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1C
T0xfR1BMKHRoZXJtYWxfem9uZV9vZl9nZXRfc2Vuc29yX2lkKTsNCj4gPiArDQo+ID4gKy8qKg0K
PiA+ICAgKiB0aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyIC0gcmVnaXN0ZXJzIGEgc2Vu
c29yIHRvIGEgRFQgdGhlcm1hbA0KPiB6b25lDQo+ID4gICAqIEBkZXY6IGEgdmFsaWQgc3RydWN0
IGRldmljZSBwb2ludGVyIG9mIGEgc2Vuc29yIGRldmljZS4gTXVzdCBjb250YWluDQo+ID4gICAq
ICAgICAgIGEgdmFsaWQgLm9mX25vZGUsIGZvciB0aGUgc2Vuc29yIG5vZGUuDQo+ID4gQEAgLTQ5
OSwzNiArNTQ2LDIyIEBAIHRoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVnaXN0ZXIoc3RydWN0IGRl
dmljZQ0KPiAqZGV2LCBpbnQgc2Vuc29yX2lkLCB2b2lkICpkYXRhLA0KPiA+ICAJc2Vuc29yX25w
ID0gb2Zfbm9kZV9nZXQoZGV2LT5vZl9ub2RlKTsNCj4gPg0KPiA+ICAJZm9yX2VhY2hfYXZhaWxh
YmxlX2NoaWxkX29mX25vZGUobnAsIGNoaWxkKSB7DQo+ID4gLQkJc3RydWN0IG9mX3BoYW5kbGVf
YXJncyBzZW5zb3Jfc3BlY3M7DQo+ID4gIAkJaW50IHJldCwgaWQ7DQo+ID4NCj4gPiAgCQkvKiBG
b3Igbm93LCB0aGVybWFsIGZyYW1ld29yayBzdXBwb3J0cyBvbmx5IDEgc2Vuc29yIHBlcg0KPiB6
b25lICovDQo+ID4gLQkJcmV0ID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MoY2hpbGQsICJ0
aGVybWFsLXNlbnNvcnMiLA0KPiA+IC0JCQkJCQkgIiN0aGVybWFsLXNlbnNvci1jZWxscyIsDQo+
ID4gLQkJCQkJCSAwLCAmc2Vuc29yX3NwZWNzKTsNCj4gPiArCQlyZXQgPSB0aGVybWFsX3pvbmVf
b2ZfZ2V0X3NlbnNvcl9pZChjaGlsZCwgc2Vuc29yX25wLCAmaWQpOw0KPiA+ICAJCWlmIChyZXQp
DQo+ID4gIAkJCWNvbnRpbnVlOw0KPiA+DQo+ID4gLQkJaWYgKHNlbnNvcl9zcGVjcy5hcmdzX2Nv
dW50ID49IDEpIHsNCj4gPiAtCQkJaWQgPSBzZW5zb3Jfc3BlY3MuYXJnc1swXTsNCj4gPiAtCQkJ
V0FSTihzZW5zb3Jfc3BlY3MuYXJnc19jb3VudCA+IDEsDQo+ID4gLQkJCSAgICAgIiVwT0ZuOiB0
b28gbWFueSBjZWxscyBpbiBzZW5zb3Igc3BlY2lmaWVyICVkXG4iLA0KPiA+IC0JCQkgICAgIHNl
bnNvcl9zcGVjcy5ucCwgc2Vuc29yX3NwZWNzLmFyZ3NfY291bnQpOw0KPiA+IC0JCX0gZWxzZSB7
DQo+ID4gLQkJCWlkID0gMDsNCj4gPiAtCQl9DQo+IA0KPiBQbGVhc2UgdGFrZSBhbHNvIHRoZSBv
cHBvcnR1bml0eSB0byBmYWN0b3Igb3V0IHRoZSBmdW5jdGlvbg0KPiB0aGVybWFsX3pvbmVfb2Zf
c2Vuc29yX3JlZ2lzdGVyKCkuDQoNClNvcnJ5LCBJIGRvIE5PVCBxdWl0ZSB1bmRlcnN0YW5kIHRl
cm1zICJmYWN0b3Igb3V0IHRoZSBmdW5jdGlvbiAuLi4iLCBjb3VsZCB5b3UgcGxlYXNlIGFkdmlz
ZSBtb3JlIGRldGFpbD8NCg0KVGhhbmtzLA0KQW5zb24NCg==
