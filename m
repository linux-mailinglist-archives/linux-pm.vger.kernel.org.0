Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A60C313E28
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2019 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfEEHaa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 May 2019 03:30:30 -0400
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:63811
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfEEHaa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 May 2019 03:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkvGQNK/ddM8eS1pTiZAvs1Z+zuAhMlIp1WRqYMFU4o=;
 b=LQeSlQNeRrQfcmvQG/4j0nU1jZVoYkseH6Qesj84ZyTPaM7AjGsY+j7YXgeGJtXtbQKF2Pl2+RoIFeV3JLoyF97nG9/UUmLiv72Cdu+VoC2ke/UvmrPPmqTm2+NOLdW1yGLz8yx99lCRLx/dXIwz0Lvo4R9aRVZd80gkl8GsqXM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6531.eurprd04.prod.outlook.com (20.179.254.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 07:30:25 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 07:30:25 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Jacky Bai <ping.bai@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: imx6q: Fix the resource leak caused by incorrect
 error return
Thread-Topic: [PATCH] cpufreq: imx6q: Fix the resource leak caused by
 incorrect error return
Thread-Index: AQHVAvvcgKY/ghVFik+vqE7MN5XPPaZcInQw
Date:   Sun, 5 May 2019 07:30:25 +0000
Message-ID: <AM0PR04MB42116F910886537F4C35AC8A80370@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190505043929.19071-1-ping.bai@nxp.com>
In-Reply-To: <20190505043929.19071-1-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b07a3144-438c-4e34-5118-08d6d12b8a95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6531;
x-ms-traffictypediagnostic: AM0PR04MB6531:
x-microsoft-antispam-prvs: <AM0PR04MB653155E60EFF2F8EA13ED01380370@AM0PR04MB6531.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(73956011)(66476007)(66556008)(64756008)(66446008)(68736007)(8936002)(486006)(446003)(102836004)(52536014)(44832011)(7696005)(6506007)(26005)(110136005)(76176011)(11346002)(476003)(186003)(54906003)(74316002)(99286004)(33656002)(256004)(25786009)(6436002)(71200400001)(2501003)(55016002)(71190400001)(66946007)(7736002)(2906002)(6246003)(53936002)(5660300002)(66066001)(3846002)(6116002)(316002)(8676002)(2201001)(86362001)(76116006)(81166006)(81156014)(305945005)(14454004)(478600001)(9686003)(4326008)(229853002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6531;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4vYv+CnxX8NrMQRBGRysa1I/KRKm9mLGS5E0tVGUpy8k0g7jBgvnGZGK1P3xbzbsVr5pqVE4xiOiAP0VT2d1p+f1RZYNoDIgr+1KVSMl2nuS8KPfR+oSPU7B+XYDHnfcTI605rTZ0lK5r1oTZRcfLY3fEh0RUti/M8n5Q5N7EZNzeoknmG0kzxVviMH0dCCTA1QIXVcO4JbwBTzeEbWOK1mdGr9MVu6qgccB7OhWGwYz+t6FdQgJBa57FFoyUHALbQVWKKotSwUVq/KECPPEiTxtyZbMB+T6yIyj2O7yhL2Jb8QbGjRUuqICfshk1O4Om8Nfrke0hhPhKWPHP4GBltYf0AjRBv7ffIvxl4X0bapEqxcJtqL3juGF3a9oEVnCucKUXn2DdvmtaUImzI8uzpD0HMiYk5cvZKKMfnW6B3o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07a3144-438c-4e34-5118-08d6d12b8a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 07:30:25.7744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6531
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBKYWNreSBCYWkNCj4gU2VudDogU3VuZGF5LCBNYXkgNSwgMjAxOSAxMjozNSBQTQ0K
PiANCj4gUHJldmlvdXMgZ290byBvbmx5IGhhbmRsZWQgdGhlIG5vZGUgcmVmZXJlbmNlLCB0aGUg
b3BwIHRhYmxlLCByZWd1bGF0b3IgJiBjbGsNCj4gcmVzb3VyY2UgYWxzbyBuZWVkIHRvIGJlIGZy
ZWUgYmVmb3JlIGVycm9yIHJldHVybi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphY2t5IEJhaSA8
cGluZy5iYWlAbnhwLmNvbT4NCg0KQmV0dGVyIHRvIGhhdmUgYSAnRml4ZXM6JyB0YWcuDQpPdGhl
cndpc2U6DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4N
Cg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2NwdWZyZXEvaW14
NnEtY3B1ZnJlcS5jIHwgMTUgKysrKysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3B1ZnJlcS9pbXg2cS1jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvaW14NnEtY3B1ZnJlcS5j
DQo+IGluZGV4IDNlMTc1NjBiMWVmZS4uMWQ0ZWNlZmFhYmM2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2NwdWZyZXEvaW14NnEtY3B1ZnJlcS5jDQo+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9pbXg2
cS1jcHVmcmVxLmMNCj4gQEAgLTM4MywyMyArMzgzLDIyIEBAIHN0YXRpYyBpbnQgaW14NnFfY3B1
ZnJlcV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlnb3RvIHB1
dF9yZWc7DQo+ICAJfQ0KPiANCj4gKwkvKiBCZWNhdXNlIHdlIGhhdmUgYWRkZWQgdGhlIE9QUHMg
aGVyZSwgd2UgbXVzdCBmcmVlIHRoZW0gKi8NCj4gKwlmcmVlX29wcCA9IHRydWU7DQo+ICsNCj4g
IAlpZiAob2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14NnVsIikgfHwNCj4gIAkgICAg
b2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14NnVsbCIpKSB7DQo+ICAJCXJldCA9IGlt
eDZ1bF9vcHBfY2hlY2tfc3BlZWRfZ3JhZGluZyhjcHVfZGV2KTsNCj4gIAkJaWYgKHJldCkgew0K
PiAtCQkJaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiAtCQkJCWdvdG8gcHV0X25vZGU7DQo+
IC0NCj4gLQkJCWRldl9lcnIoY3B1X2RldiwgImZhaWxlZCB0byByZWFkIG9jb3RwOiAlZFxuIiwN
Cj4gLQkJCQlyZXQpOw0KPiAtCQkJZ290byBwdXRfbm9kZTsNCj4gKwkJCWlmIChyZXQgIT0gLUVQ
Uk9CRV9ERUZFUikNCj4gKwkJCQlkZXZfZXJyKGNwdV9kZXYsICJmYWlsZWQgdG8gcmVhZCBvY290
cDogJWRcbiIsDQo+ICsJCQkJCXJldCk7DQo+ICsJCQlnb3RvIG91dF9mcmVlX29wcDsNCj4gIAkJ
fQ0KPiAgCX0gZWxzZSB7DQo+ICAJCWlteDZxX29wcF9jaGVja19zcGVlZF9ncmFkaW5nKGNwdV9k
ZXYpOw0KPiAgCX0NCj4gDQo+IC0JLyogQmVjYXVzZSB3ZSBoYXZlIGFkZGVkIHRoZSBPUFBzIGhl
cmUsIHdlIG11c3QgZnJlZSB0aGVtICovDQo+IC0JZnJlZV9vcHAgPSB0cnVlOw0KPiAgCW51bSA9
IGRldl9wbV9vcHBfZ2V0X29wcF9jb3VudChjcHVfZGV2KTsNCj4gIAlpZiAobnVtIDwgMCkgew0K
PiAgCQlyZXQgPSBudW07DQo+IC0tDQo+IDIuMjEuMA0KDQo=
