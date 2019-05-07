Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348E616509
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEGNw1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 09:52:27 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:51872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbfEGNw1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 May 2019 09:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPIpNe/sYvT8+vNlOIzRA0yEC0RBd/6uokBQ1R65OJg=;
 b=eF4tvebw2SrJ2KVBZ0WDIdfczNO7xUsuknMnyRZq82UW6S/E4exm2NC5mJypPD9XHRYobif0rcrM2zT5netzJgjyvkqgbXZUcvD+txD7y1dh3//GyE14Sz+79aZIDyBHJuLV6hTNl7GswuLZpUSnqmri0rz2jpnRRA9VbhXLaHg=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB6548.eurprd04.prod.outlook.com (20.179.254.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 13:52:21 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 13:52:21 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/4] cpufreq: Add imx-cpufreq-dt driver
Thread-Topic: [PATCH v3 0/4] cpufreq: Add imx-cpufreq-dt driver
Thread-Index: AQHVBNwXNrFwRf2w50WsyF+7BjHmLQ==
Date:   Tue, 7 May 2019 13:52:21 +0000
Message-ID: <cover.1557236799.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:803:14::19) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a627e12e-34c6-4f7a-e30a-08d6d2f339f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6548;
x-ms-traffictypediagnostic: AM0PR04MB6548:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB654844701CDA9F9DD15BEBBDEE310@AM0PR04MB6548.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(8676002)(81156014)(81166006)(486006)(86362001)(68736007)(6512007)(110136005)(53936002)(54906003)(71190400001)(4326008)(966005)(102836004)(66066001)(8936002)(36756003)(52116002)(6506007)(50226002)(386003)(14444005)(256004)(14454004)(476003)(478600001)(25786009)(6116002)(5660300002)(2616005)(3846002)(44832011)(305945005)(66946007)(6486002)(73956011)(66476007)(71200400001)(6306002)(2906002)(99286004)(6436002)(26005)(186003)(316002)(64756008)(66556008)(66446008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6548;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l1o3fE00RwJVE88vcA7ytHEOw84YshlG4SlHTEJrtzjq5Le0Lrz776QK53de/ZzUV5Rmf6bFn5xQJ4bI6IotWI95aZKFf9mQpHxTAyNbUZCXkkUEBrpWAuy+YcPMrszs812jqFgB/INbvWuBlh5syrct6ElyzDp+413+gDBG1znBmx5B0Mn3adst8QqUQgvpoShphsx2WP/gSV0o1zHDujHcIeyKVXBIKyrLlWenoVvpU51MD+Zi+TbtQKZEWGQPJVwgcxSMWrj+2gDe5PNPBk4Yv6tX4gKlxGMo+660iiE3Yl3gVRgWiKPy7lVBPq4PkNCfzET53O/ljWs4Uddr0etVpZtXryRwI3tl+Tdt6MNXpB4y7HE6lg3jyRek7mHpGJaWz0q59PgnMBBUT5wXzIN0/Qc9rQ199S3ZKgPUpc0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a627e12e-34c6-4f7a-e30a-08d6d2f339f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 13:52:21.3147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UmlnaHQgbm93IGluIHVwc3RyZWFtIGlteDhtIGNwdWZyZXEgc3VwcG9ydCBqdXN0IGxpc3RzIGEg
Y29tbW9uIHN1YnNldA0Kb2YgT1BQcyBiZWNhdXNlIHRoZSBoaWdoZXIgb25lcyBzaG91bGQgb25s
eSBiZSBhdHRlbXB0ZWQgYWZ0ZXIgY2hlY2tpbmcNCnNwZWVkIGdyYWRpbmcgaW4gZnVzZXMuDQoN
CkRyaXZlciByZWFkcyBmcm9tIG52bWVtIGFuZCBjYWxscyBkZXZfcG1fb3BwX3NldF9zdXBwb3J0
ZWRfaHcgYmVmb3JlDQpyZWdpc3RlcmluZyBjcHVmcmVxLWR0Lg0KDQpDaGFuZ2VzIHNpbmNlIHYy
Og0KICogTWlub3IgcmVmb3JtYXR0aW5nIGluIEtjb25maWcgKFZpcmVzaCkNCiAqIE9wZW4tY29k
ZSBpbXhfY3B1ZnJlcV9kdF9tYXRjaF9ub2RlIChWaXJlc2gpDQogKiBBZGQgbWt0X3NlZ21lbnQg
Yml0cyB0byBzdXBwb3J0ZWRfaHcgYW5kIHVwZGF0ZSAuZHRzaSB0byBtYXRjaCBhZnRlcg0KcmV2
aWV3aW5nIGxhdGVzdCBkYXRhc2hlZXRzLg0KICogQWRkIGR0LWJpbmRpbmdzIGxpa2Ugb3RoZXIg
b3BwLXN1cHBvcnRlZC1odyB1c2Vycw0KICogQWRkIGRldmljZXRyZWUgbWFpbGluZyBsaXN0IChr
ZWVwIGZvcmdldHRpbmcgZHRzIG5lZWRzIHRvIGJlIHJldmlld2VkKQ0KTGluayB0byB2MjogaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWFybS1rZXJuZWwvbGlzdC8/
c2VyaWVzPTExMzE2Mw0KTGluayB0byB2MSAoUkZDKTogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wYXRjaC8xMDkxNjc2OS8NCg0KSSBuZXZlciBub3RpY2VkIGFueXRoaW5nIHdyb25nIHdp
dGggZ29pbmcgYWJvdmUgdGhlIGZ1c2VkIHNwZWVkIGdyYWRpbmcNCmhvd2V2ZXIgaXQncyB0ZWNo
bmljYWxseSB1bnNhZmUgc28gdGhlIGNwdWZyZXEgY29kZSBjaGFuZ2VzIHNob3VsZCBnbyBpbg0K
YmVmb3JlIERUIGNoYW5nZXMuDQoNCkRyaXZlciBpcyBtb2R1bGUgYnkgZGVmYXVsdC4gSXQgZGVw
ZW5kcyBvbiBudm1lbS1pbXggd2hpY2ggY2FuIGFsc28gYmUgYQ0KbW9kdWxlLg0KDQpJdCdzIGEg
cGxhdGZvcm0gZGV2aWNlIHJlZ2lzdGVyZWQgZnJvbSBzb2MtaW14OCBiZWNhdXNlIGNvdWxkbid0
IGZpbmQNCmFueSBhcHByb3ByaWF0ZSBub2RlIGZvciBNT0RVTEVfREVWSUNFX1RBQkxFKG9mKS4N
Cg0KTGVvbmFyZCBDcmVzdGV6ICg0KToNCiAgY3B1ZnJlcTogQWRkIGlteC1jcHVmcmVxLWR0IGRy
aXZlcg0KICBkdC1iaW5kaW5nczogaW14LWNwdWZyZXEtZHQ6IERvY3VtZW50IG9wcC1zdXBwb3J0
ZWQtaHcgdXNhZ2UNCiAgYXJtNjQ6IGR0czogaW14OG1tOiBBZGQgY3B1IHNwZWVkIGdyYWRpbmcg
YW5kIGFsbCBPUFBzDQogIGFybTY0OiBkdHM6IGlteDhtcTogQWRkIGNwdSBzcGVlZCBncmFkaW5n
IGFuZCBhbGwgT1BQcw0KDQogLi4uL2JpbmRpbmdzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQudHh0
ICAgICAgIHwgMzcgKysrKysrKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS5kdHNpICAgICB8IDE3ICsrKy0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bXEuZHRzaSAgICAgfCAyNiArKysrLQ0KIGRyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLmFybSAgICAg
ICAgICAgICAgICAgICB8IDEwICsrDQogZHJpdmVycy9jcHVmcmVxL01ha2VmaWxlICAgICAgICAg
ICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLWR0LXBsYXRkZXYu
YyAgICAgICAgICB8ICAzICsNCiBkcml2ZXJzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQuYyAgICAg
ICAgICAgICAgfCA5NiArKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9zb2MvaW14L3NvYy1p
bXg4LmMgICAgICAgICAgICAgICAgICAgIHwgIDMgKw0KIDggZmlsZXMgY2hhbmdlZCwgMTkxIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2lteC1jcHVmcmVxLWR0LnR4dA0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQuYw0KDQotLSAN
CjIuMTcuMQ0KDQo=
