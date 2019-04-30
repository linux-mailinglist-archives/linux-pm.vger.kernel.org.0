Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5918FFC26
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfD3PGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 11:06:14 -0400
Received: from mail-eopbgr150089.outbound.protection.outlook.com ([40.107.15.89]:60544
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfD3PGO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Apr 2019 11:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdabgUnKvTa3nd+Dd0OtMspEFZUnnaVQQtE1Cnid22Q=;
 b=LsiELIrsMfPSShEokb5nXtY36ZnGDqnRodM5fSLkvtX0rDiVDlrCem43V8M1vYnQVCScA1F5rifjG4n5nPgpZYn5BGZORntEJAyoxyCb6hDWM0czr8WYy8ryOp0W5xtiKkb0A/LFG6Hw5g3Tsykn/K9R7IP0Gd20ODW/Z5dCFyU=
Received: from AM6PR04MB6440.eurprd04.prod.outlook.com (20.179.244.217) by
 AM6PR04MB5255.eurprd04.prod.outlook.com (20.177.33.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 15:06:10 +0000
Received: from AM6PR04MB6440.eurprd04.prod.outlook.com
 ([fe80::14c2:1e08:524c:6ff4]) by AM6PR04MB6440.eurprd04.prod.outlook.com
 ([fe80::14c2:1e08:524c:6ff4%2]) with mapi id 15.20.1856.008; Tue, 30 Apr 2019
 15:06:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/2] Allow imx6qp PU domain off in suspend
Thread-Topic: [PATCH v5 0/2] Allow imx6qp PU domain off in suspend
Thread-Index: AQHU/2Y+EE51fOgT1EWmJzyqb/2vLQ==
Date:   Tue, 30 Apr 2019 15:06:10 +0000
Message-ID: <cover.1556636234.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR0902CA0058.eurprd09.prod.outlook.com
 (2603:10a6:802:1::47) To AM6PR04MB6440.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53c66ed2-5aea-4763-59fc-08d6cd7d611f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5255;
x-ms-traffictypediagnostic: AM6PR04MB5255:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <AM6PR04MB5255BE93AF061ED0B545CA9EEE3A0@AM6PR04MB5255.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(2906002)(71190400001)(71200400001)(2616005)(25786009)(5660300002)(6436002)(8676002)(7736002)(15650500001)(52116002)(4744005)(110136005)(99286004)(53936002)(26005)(97736004)(305945005)(316002)(102836004)(476003)(256004)(6486002)(478600001)(66066001)(966005)(386003)(6506007)(186003)(81156014)(81166006)(73956011)(66946007)(64756008)(66476007)(8936002)(14454004)(54906003)(66556008)(68736007)(66446008)(44832011)(86362001)(50226002)(36756003)(486006)(6306002)(6512007)(4326008)(6116002)(14444005)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5255;H:AM6PR04MB6440.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s98/metyf7DZSzLE9Dm9a9AnI9rF4OIb8YH/268Ik255nG8pVSwAV/6wVaBv91S8KBzuRH1XWxIspZYexkDTOVtwhwu8IHE2+veEHLo9cVg7zDxaHyOA5Ojp03zh9ZGX87qpFS77pZ1RimZC5juFAPpB7Dvd0PEf0L/IU/8xDgrl+J5x3B/b/U0dsXhahzQ60FEO9nOdm8BZR5UDYhJarYAhBHKy7RTvmwFDaj64m1RNrb/jQI4Ts96Ez+PsxJ6mhZsmzP/FGc+QZI7r+MWEjqUCIo38UnjSQfX9Dgdl9xIaOFSMB9EKUXKzlO4f6yNE5nb7mrqGVqMlIImZwjf1DA2IPO9Fhvi7LA/5MH5WF8VpR4zMjLCeI3PmSY13VUEyKWMTV8UexmwfE+Ot8rS0ucCbZXAOa9lhN945dtOdIo8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c66ed2-5aea-4763-59fc-08d6cd7d611f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 15:06:10.5946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5255
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gaW14NnFwIHBvd2VyIGdhdGluZyBvbiB0aGUgUFUgZG9tYWluIGlzIGRpc2FibGVkIGJlY2F1
c2Ugb2YgZXJyYXRhDQpFUlIwMDk2MTkuIEhvd2V2ZXIgcG93ZXIgZ2F0aW5nIGR1cmluZyBzdXNw
ZW5kL3Jlc3VtZSBjYW4gc3RpbGwgYmUNCnBlcmZvcm1lZC4NCg0KQ2hhbmdlcyBzaW5jZSBWNDoN
CiAqIFJlbmFtZSBHRU5QRF9GTEFHX05PX1JVTlRJTUVfT0ZGIHRvIEdFTlBEX0ZMQUdfUlBNX0FM
V0FZU19PTg0KTGluayB0byB2NDogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L2xpbnV4LWFybS1rZXJuZWwvbGlzdC8/c2VyaWVzPTExMDgyOQ0KDQpJbXBsZW1lbnRlZCB3aXRo
IGEgbmV3IGNvcmUgZmxhZyBiZWNhdXNlIG90aGVyd2lzZSBkaXN0aW5ndWlzaGluZw0KYmV0d2Vl
biAicnVudGltZSBvZmYiIGFuZCAic3VzcGVuZCBvZmYiIGlzIHZlcnkgY29tcGxpY2F0ZWQuIExp
bmsgdG8NCnByZXZpb3VzIG11Y2ggb2xkZXIgYXR0ZW1wdHM6DQoNCnYzOiBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxOC83LzYvNjk4DQp2MjogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvNy81
LzU2NA0KdjE6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzcvMi8zNTcNCg0KTGVvbmFyZCBD
cmVzdGV6ICgyKToNCiAgUE0gLyBEb21haW5zOiBBZGQgR0VOUERfRkxBR19SUE1fQUxXQVlTX09O
IGZsYWcNCiAgc29jOiBpbXg6IGdwYzogVXNlIEdFTlBEX0ZMQUdfUlBNX0FMV0FZU19PTiBmb3Ig
RVJSMDA5NjE5DQoNCiBkcml2ZXJzL2Jhc2UvcG93ZXIvZG9tYWluLmMgfCAgOCArKysrKystLQ0K
IGRyaXZlcnMvc29jL2lteC9ncGMuYyAgICAgICB8IDEzICsrKysrKysrKysrLS0NCiBpbmNsdWRl
L2xpbnV4L3BtX2RvbWFpbi5oICAgfCAgNCArKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTcuMQ0KDQo=
