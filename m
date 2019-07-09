Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D428263271
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfGIHyR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 03:54:17 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:1413
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfGIHyR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jul 2019 03:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11+mE3LekTYOs6mgEEZcV/Nsgm9Uc/puEf/EYqi1M1Q=;
 b=eBa+8nqgWv3hyQzSQPvEvE6v8Igkl4FAABq02zmdldMb6PIprEgg/ARUrIayl2psUyJaf5rutyGsHtnOs+yww3tWOISzyMRq8eMbDJRojGu8geMgPjDNQho8b5jHu+e/wOzYv5HjX3+RZuFSuSIZAEbGgQ716R9Vh0g7apKP+pU=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3829.eurprd04.prod.outlook.com (52.133.29.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 07:54:12 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::d5e6:6a87:7e6:95a]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::d5e6:6a87:7e6:95a%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 07:54:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vireshk@kernel.org" <vireshk@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] opp: of: Support multiple suspend OPPs defined in DT
Thread-Topic: [PATCH 1/3] opp: of: Support multiple suspend OPPs defined in DT
Thread-Index: AQHVNibFv2pnbMa9dEaxk1dFwsj7f6bB6eKAgAAAi1A=
Date:   Tue, 9 Jul 2019 07:54:12 +0000
Message-ID: <AM6PR0402MB3911CB4D54A71EB69E8E7544F5F10@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <20190709071056.26361-1-Anson.Huang@nxp.com>
 <20190709075119.rg6ktsg7nwdadsmd@vireshk-i7>
In-Reply-To: <20190709075119.rg6ktsg7nwdadsmd@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac5f6b97-4a1b-420e-c6b5-08d70442a20c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR0402MB3829;
x-ms-traffictypediagnostic: AM6PR0402MB3829:
x-microsoft-antispam-prvs: <AM6PR0402MB3829838EB6426CA5BE249A20F5F10@AM6PR0402MB3829.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(14444005)(14454004)(25786009)(4326008)(15650500001)(229853002)(81166006)(102836004)(6436002)(74316002)(446003)(11346002)(305945005)(486006)(476003)(53936002)(81156014)(8676002)(7736002)(3846002)(6116002)(8936002)(68736007)(54906003)(99286004)(478600001)(76176011)(6246003)(7696005)(53546011)(6506007)(256004)(2906002)(26005)(186003)(73956011)(66066001)(52536014)(86362001)(76116006)(33656002)(66946007)(66476007)(66556008)(64756008)(66446008)(71190400001)(71200400001)(9686003)(6916009)(316002)(5660300002)(55016002)(44832011)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3829;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fdQdyEtUMHL7YTLMHNCIqtjqzMf5ksmmS86p4mE66X+k2ZGjNgpdHM+QvCs/mJIIO3UY2qAKCVrjs6XGcF1dAAYKtEurWbPhkYkxo6RemPQvf2VLJSiUh1WOfzAfODR+rjGZ0JCjD1MV9hgukpTHHeZoKPdHw0P/ksc02qNKo/Chlr38Bd8BATt0EwSlYCb3zIn+SLnpMTA0WSXirW9kuZVQHULze78VHGj1+Xma/NKdm7j4e8uRbozsPaU93hmm9TeWpS9CC0wAjPra5pyXQLi2W0nG/Ns0AvZXtj+oE7E0E6oBobQJ4OE3wilibLF6/B6Qyqurj923liUOY7LWV+h2B1OkDVOAX3n3DgtEVwVzSgmlwFgtIRW9iBr1KYE4ZTN3Y/sO63YUmh8WRdLylKK0q7qVO20KvQOEh0eqLz8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5f6b97-4a1b-420e-c6b5-08d70442a20c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 07:54:12.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3829
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFZpcmVzaA0KDQo+IE9uIDA5LTA3LTE5LCAxNToxMCwgQW5zb24uSHVhbmdAbnhwLmNvbSB3
cm90ZToNCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPg0K
PiA+IFdpdGggcHJvcGVydHkgIm9wcC1zdXBwb3J0ZWQtaHciIGludHJvZHVjZWQsIHRoZSBPUFAg
dGFibGUgaW4gRFQgY291bGQNCj4gPiBiZSBhIGxhcmdlIE9QUCB0YWJsZSBhbmQgT05MWSBhIHN1
YnNldCBvZiBPUFBzIGFyZSBhdmFpbGFibGUsIGJhc2VkIG9uDQo+ID4gdGhlIHZlcnNpb24gb2Yg
dGhlIGhhcmR3YXJlIHJ1bm5pbmcgb24uIFRoYXQgaW50cm9kdWNlcyByZXN0cmljdGlvbiBvZg0K
PiA+IHVzaW5nICJvcHAtc3VzcGVuZCINCj4gPiBwcm9wZXJ0eSB0byBkZWZpbmUgdGhlIHN1c3Bl
bmQgT1BQLCBhcyB3ZSBhcmUgTk9UIHN1cmUgaWYgdGhlIE9QUA0KPiA+IGNvbnRhaW5pbmcgIm9w
cC1zdXNwZW5kIiBwcm9wZXJ0eSBpcyBhdmFpbGFibGUgZm9yIHRoZSBoYXJkd2FyZQ0KPiA+IHJ1
bm5pbmcgb24sIGFuZCB0aGUgb2Ygb3BwIGNvcmUgZG9lcyBOT1QgYWxsb3cgbXVsdGlwbGUgc3Vz
cGVuZCBPUFBzDQo+ID4gZGVmaW5lZCBpbiBEVCBPUFAgdGFibGUuDQo+ID4NCj4gPiBUbyBlbGlt
aW5hdGUgdGhpcyByZXN0cml0aW9uLCBtYWtlIG9mIG9wcCBjb3JlIGFsbG93IG11bHRpcGxlIHN1
c3BlbmQNCj4gPiBPUFBzIGRlZmluZWQgaW4gRFQsIGFuZCBwaWNrIHRoZSBPUFAgd2l0aCBoaWdo
ZXN0IHJhdGUgYW5kIHdpdGgNCj4gPiAib3BwLXN1c3BlbmQiIHByb3BlcnR5IHByZXNlbnQgdG8g
YmUgc3VzcGVuZCBPUFAsIGl0IGNhbiBzcGVlZCB1cCB0aGUNCj4gPiBzdXNwZW5kL3Jlc3VtZSBw
cm9jZXNzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvb3BwL29mLmMgfCA5ICsrKysrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gUGxlYXNlIHVwZGF0ZSB0aGUgRFQgYmluZGluZ3MgZmlyc3QuDQoNCk9LLCB3aWxsIHNlbmQg
YSBWMiBjb250YWluaW5nIERUIGJpbmRpbmcgY2hhbmdlcy4NCg0KPiANCj4gRldJVywgYWxsIHRo
cmVlIHBhdGNoZXMgbG9vayBmaW5lIG90aGVyd2lzZS4NCg0KVGhhbmsgeW91IQ0KDQpBbnNvbi4N
Cg==
