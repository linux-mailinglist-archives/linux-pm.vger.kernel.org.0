Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE71650E
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEGNwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 09:52:33 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:51872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbfEGNwd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 May 2019 09:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGbl+gAFgO1V5cR2PKg351rAjFabMk5PNLef7wxZEJU=;
 b=PETNffK5umX1VT0ElvTv7Viu1CF0uBIa1ANmaKYME2BG16BEcCJJy8XbyJT8LQe/DBLSiTtByxA2CK7sbVKvRnoMryZFKVyfWw96WQo/7Kbs8qCyIpBEzsgQLd1CPnJ13g1LFfexz0kCMGVN7U4u4E4qRuuvRu9KtqxEFEoiegU=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB6548.eurprd04.prod.outlook.com (20.179.254.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 13:52:23 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 13:52:23 +0000
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
Subject: [PATCH v3 2/4] dt-bindings: imx-cpufreq-dt: Document opp-supported-hw
 usage
Thread-Topic: [PATCH v3 2/4] dt-bindings: imx-cpufreq-dt: Document
 opp-supported-hw usage
Thread-Index: AQHVBNwY/kQ/3ak9eEqbSCeWjXpTtg==
Date:   Tue, 7 May 2019 13:52:23 +0000
Message-ID: <79a798d7d93cc89549e5fe290c8139011b72ee01.1557236799.git.leonard.crestez@nxp.com>
References: <cover.1557236799.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1557236799.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: e3a41e83-fb92-4a74-41e6-08d6d2f33b59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6548;
x-ms-traffictypediagnostic: AM0PR04MB6548:
x-microsoft-antispam-prvs: <AM0PR04MB6548FC6E6B1E3343DBECC92DEE310@AM0PR04MB6548.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(8676002)(81156014)(81166006)(486006)(11346002)(86362001)(68736007)(6512007)(110136005)(53936002)(54906003)(71190400001)(4326008)(118296001)(102836004)(66066001)(76176011)(8936002)(36756003)(52116002)(6506007)(50226002)(386003)(446003)(256004)(14454004)(476003)(478600001)(25786009)(6116002)(5660300002)(2616005)(3846002)(44832011)(305945005)(66946007)(6486002)(73956011)(66476007)(71200400001)(2906002)(99286004)(6436002)(26005)(186003)(316002)(64756008)(66556008)(66446008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6548;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /41C6Bg9jHzc72qWMI0lWXXPht+LS4o0Iw/ozo04nvvhgrV2Of2llvDGIKkdA1RoaC/3wHDUDy6ZHB8gNTPZFChlRZfo8hpXaKzHehR/mAWMz9ziiBO+6afnZzS4lCqKz44XSMoJ0ab8gOywDFjRCM/BKTFbevzxHEGUVaOgewIWXsIfqSiIeR+dV2x0Z2f9Tnp/nb5e1FPfgvrWx+eYdQVl/+qlpfqb9SK7bt2pQTAd9ceGgBT4FBGFNfz9jk2y5jPLEWYljIVKUx3jyuw34c/c0YcdgKaaxGIKp3IjUG/MVR0N584e/IkXQRx/EKMfEhXq0Do/XrILgAHKHuNmqP6FbFtHXQV4WA92uDyGBAxl2Gn68u23OnG3rG/RyE4IpcRyzmrFziMZPYHzFBBlrTI0udIIow3g+0lp4Mo1QPo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a41e83-fb92-4a74-41e6-08d6d2f33b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 13:52:23.6243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlIGludGVycHJldGF0aW9uIG9mIG9wcC1zdXBwb3J0ZWQtaHcgYml0cyBmb3IgaW14LWNwdWZy
ZXEtZHQgZHJpdmVyIGlzDQpub3QgdmVyeSBvYnZpb3VzIHNvIGF0dGVtcHQgdG8gZXhwbGFpbiBp
dC4NCg0KVGhlcmUgaXMgbm8gT0YgY29tcGF0IHN0cmluZyBhc3NvY2lhdGVkLg0KDQpTaWduZWQt
b2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KLS0tDQog
Li4uL2JpbmRpbmdzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQudHh0ICAgICAgIHwgMzcgKysrKysr
KysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2lt
eC1jcHVmcmVxLWR0LnR4dA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQudHh0DQpuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi44N2JmZjVhZGQzZjkNCi0tLSAvZGV2L251bGwN
CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2lteC1jcHVm
cmVxLWR0LnR4dA0KQEAgLTAsMCArMSwzNyBAQA0KK2kuTVggQ1BVRnJlcS1EVCBPUFAgYmluZGlu
Z3MNCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KKw0KK0NlcnRhaW4gaS5NWCBT
b0NzIHN1cHBvcnQgZGlmZmVyZW50IE9QUHMgZGVwZW5kaW5nIG9uIHRoZSAibWFya2V0IHNlZ21l
bnQiIGFuZA0KKyJzcGVlZCBncmFkaW5nIiB2YWx1ZSB3aGljaCBhcmUgd3JpdHRlbiBpbiBmdXNl
cy4gVGhlc2UgYml0cyBhcmUgY29tYmluZWQgd2l0aA0KK3RoZSBvcHAtc3VwcG9ydGVkLWh3IHZh
bHVlcyBmb3IgZWFjaCBPUFAgdG8gY2hlY2sgaWYgdGhlIE9QUCBpcyBhbGxvd2VkLg0KKw0KK1Jl
cXVpcmVkIHByb3BlcnRpZXM6DQorLS0tLS0tLS0tLS0tLS0tLS0tLS0NCisNCitGb3IgZWFjaCBv
cHAgZW50cnkgaW4gJ29wZXJhdGluZy1wb2ludHMtdjInIHRhYmxlOg0KKy0gb3BwLXN1cHBvcnRl
ZC1odzogVHdvIGJpdG1hcHMgaW5kaWNhdGluZzoNCisgIC0gU3VwcG9ydGVkIHNwZWVkIGdyYWRl
IG1hc2sNCisgIC0gU3VwcG9ydGVkIG1hcmtldCBzZWdtZW50IG1hc2sNCisgICAgMDogQ29uc3Vt
ZXINCisgICAgMTogRXh0ZW5kZWQgQ29uc3VtZXINCisgICAgMjogSW5kdXN0cmlhbA0KKyAgICAz
OiBBdXRvbW90aXZlDQorDQorRXhhbXBsZToNCistLS0tLS0tLQ0KKw0KK29wcF90YWJsZSB7DQor
CWNvbXBhdGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12MiI7DQorCW9wcC0xMDAwMDAwMDAwIHsN
CisJCW9wcC1oeiA9IC9iaXRzLyA2NCA8MTAwMDAwMDAwMD47DQorCQkvKiBncmFkZSA+PSAwLCBj
b25zdW1lciBvbmx5ICovDQorCQlvcHAtc3VwcG9ydGVkLWh3ID0gPDB4Zj4sIDwweDM+Ow0KKwl9
Ow0KKw0KKwlvcHAtMTMwMDAwMDAwMCB7DQorCQlvcHAtaHogPSAvYml0cy8gNjQgPDEzMDAwMDAw
MDA+Ow0KKwkJb3BwLW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsNCisJCS8qIGdyYWRlID49IDEsIGFs
bCBzZWdtZW50cyAqLw0KKwkJb3BwLXN1cHBvcnRlZC1odyA9IDwweGU+LCA8MHg3PjsNCisJfTsN
Cit9DQotLSANCjIuMTcuMQ0KDQo=
