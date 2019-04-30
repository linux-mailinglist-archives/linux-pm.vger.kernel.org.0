Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C827CFC27
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfD3PGQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 11:06:16 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:54787
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfD3PGQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Apr 2019 11:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCyXE2v0gaGjYZIuzW3baa0FKPpsncWzwhLAVdtmFlM=;
 b=Nnj7Nrxe5vJgrYIDfMOiYaavkMREGMOt8rX2bm1Y/yiy8ATDw5QpcLoPi6bftHJuIeeGxsBOz2sCneZrkdlvQBv4By9c6GuWYTAihrO6dWG4PNUDtYTX6MQn6W9LtMi1Ry0dxrMjgIWVnbhS6NYK5Cgrhfhzw6Qt68QmU31MAN0=
Received: from AM6PR04MB6440.eurprd04.prod.outlook.com (20.179.244.217) by
 AM6PR04MB5478.eurprd04.prod.outlook.com (20.178.93.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 30 Apr 2019 15:06:12 +0000
Received: from AM6PR04MB6440.eurprd04.prod.outlook.com
 ([fe80::14c2:1e08:524c:6ff4]) by AM6PR04MB6440.eurprd04.prod.outlook.com
 ([fe80::14c2:1e08:524c:6ff4%2]) with mapi id 15.20.1856.008; Tue, 30 Apr 2019
 15:06:12 +0000
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
Subject: [PATCH v5 2/2] soc: imx: gpc: Use GENPD_FLAG_RPM_ALWAYS_ON for
 ERR009619
Thread-Topic: [PATCH v5 2/2] soc: imx: gpc: Use GENPD_FLAG_RPM_ALWAYS_ON for
 ERR009619
Thread-Index: AQHU/2Y/OY5ccvekDkmJRXHYA33jSA==
Date:   Tue, 30 Apr 2019 15:06:12 +0000
Message-ID: <8f53bef00e72aa35d146210bb71ca05b8a3af141.1556636234.git.leonard.crestez@nxp.com>
References: <cover.1556636234.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1556636234.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2aa435b3-0c2e-4f36-fd1c-08d6cd7d6239
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5478;
x-ms-traffictypediagnostic: AM6PR04MB5478:
x-microsoft-antispam-prvs: <AM6PR04MB54782D46C4BA453664A70070EE3A0@AM6PR04MB5478.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(8936002)(6116002)(50226002)(81156014)(3846002)(81166006)(8676002)(66446008)(4326008)(25786009)(64756008)(66476007)(66556008)(6512007)(73956011)(2906002)(66066001)(86362001)(66946007)(52116002)(53936002)(118296001)(36756003)(99286004)(316002)(110136005)(54906003)(7736002)(44832011)(305945005)(97736004)(14444005)(6506007)(386003)(102836004)(26005)(11346002)(186003)(446003)(256004)(486006)(476003)(6436002)(5660300002)(6486002)(14454004)(478600001)(71200400001)(71190400001)(68736007)(76176011)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5478;H:AM6PR04MB6440.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A8KeZJb3yRx9e626m8wGmurcZ4NXukO23oGR5KNBr9mhzDpkZLrukHYCKVDQqaVEBjoqPiS+wfeFelRBnJMWSvabjsc/qHzjeC0uOgRvLVL6LJ4ofC209nTfRhEn19vOEyh5GWG5XoNfAylgO0TdLhf6lQSkOuwEJ1PQsEpVk4yc6kjHlQHuNlyM+Sb54JbGjKIqyvy+wyvUoDE2IJG8CxoiL6SNC+r2a986F0zjzBRtLaqxIMV785c878KDaDflFgXO1qI/+90N7kNObXSAM8FWNN6FyDv/lPC11FlrxbCGEa1kZNfu9RRgSY57PL2I5fYTiF5jfoDD3ajwPFbb22o917+aI75YRMaEBSvpQ1EVcqSVIXTEwb/dEAIsPQCKvoxSiRxgpNHfH0AelEkp+vUjXEwcbpTWI/Q/iIPPW48=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa435b3-0c2e-4f36-fd1c-08d6cd7d6239
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 15:06:12.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5478
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBhbGxvd3MgUFUgZG9tYWluIHRvIGJlIHR1cm5lZCBvZmYgaW4gc3VzcGVuZCBhbmQgc2F2
ZSBwb3dlci4NCg0KU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0
ZXpAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL2lteC9ncGMuYyB8IDEzICsrKysrKysrKysr
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9ncGMuYyBiL2RyaXZlcnMvc29jL2lteC9ncGMu
Yw0KaW5kZXggYThmMWU0N2NlNjk4Li5kOTIzMWJkM2M2OTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3NvYy9pbXgvZ3BjLmMNCisrKyBiL2RyaXZlcnMvc29jL2lteC9ncGMuYw0KQEAgLTQyNywxNCAr
NDI3LDIzIEBAIHN0YXRpYyBpbnQgaW14X2dwY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGluaXQgcmVnbWFwOiAl
ZFxuIiwNCiAJCQlyZXQpOw0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KLQkvKiBEaXNhYmxlIFBV
IHBvd2VyIGRvd24gaW4gbm9ybWFsIG9wZXJhdGlvbiBpZiBFUlIwMDk2MTkgaXMgcHJlc2VudCAq
Lw0KKwkvKg0KKwkgKiBEaXNhYmxlIFBVIHBvd2VyIGRvd24gYnkgcnVudGltZSBQTSBpZiBFUlIw
MDk2MTkgaXMgcHJlc2VudC4NCisJICoNCisJICogVGhlIFBSRSBjbG9jayB3aWxsIGJlIHBhdXNl
ZCBmb3Igc2V2ZXJhbCBjeWNsZXMgd2hlbiB0dXJuaW5nIG9uIHRoZQ0KKwkgKiBQVSBkb21haW4g
TERPIGZyb20gcG93ZXIgZG93biBzdGF0ZS4gSWYgUFJFIGlzIGluIHVzZSBhdCB0aGF0IHRpbWUs
DQorCSAqIHRoZSBJUFUvUFJHIGNhbm5vdCBnZXQgdGhlIGNvcnJlY3QgZGlzcGxheSBkYXRhIGZy
b20gdGhlIFBSRS4NCisJICoNCisJICogVGhpcyBpcyBub3QgYSBjb25jZXJuIHdoZW4gdGhlIHdo
b2xlIHN5c3RlbSBlbnRlcnMgc3VzcGVuZCBzdGF0ZSwgc28NCisJICogaXQncyBzYWZlIHRvIHBv
d2VyIGRvd24gUFUgaW4gdGhpcyBjYXNlLg0KKwkgKi8NCiAJaWYgKG9mX2lkX2RhdGEtPmVycjAw
OTYxOV9wcmVzZW50KQ0KIAkJaW14X2dwY19kb21haW5zW0dQQ19QR0NfRE9NQUlOX1BVXS5iYXNl
LmZsYWdzIHw9DQotCQkJCUdFTlBEX0ZMQUdfQUxXQVlTX09OOw0KKwkJCQlHRU5QRF9GTEFHX1JQ
TV9BTFdBWVNfT047DQogDQogCS8qIEtlZXAgRElTUCBhbHdheXMgb24gaWYgRVJSMDA2Mjg3IGlz
IHByZXNlbnQgKi8NCiAJaWYgKG9mX2lkX2RhdGEtPmVycjAwNjI4N19wcmVzZW50KQ0KIAkJaW14
X2dwY19kb21haW5zW0dQQ19QR0NfRE9NQUlOX0RJU1BMQVldLmJhc2UuZmxhZ3MgfD0NCiAJCQkJ
R0VOUERfRkxBR19BTFdBWVNfT047DQotLSANCjIuMTcuMQ0KDQo=
