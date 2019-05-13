Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83071B46C
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 13:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfEMLBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 07:01:46 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:59894
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729208AbfEMLBp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 07:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HLsto6RypR9wpu4UvLd3TTLZClxjB7pGoFCvtXVU4c=;
 b=SFOgF7sBtQBK53o4LPfMsqwxjaPbkdPy0vMtXfC2U1d5DYVy9pUJZBEa7RYJJJXD8Vp3C7kwn6pS3gLTPFgeaFWGSc5Vk9YLhPUDhPw+/almg2yLFXKwaD3VaRNbtM/QwmmSGbSC7iz6pu/5M5AEpM+MJdvncfUhmC/tiaBE5g8=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5138.eurprd04.prod.outlook.com (52.134.89.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 11:01:40 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 11:01:40 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/5] dt-bindings: imx-cpufreq-dt: Document opp-supported-hw
 usage
Thread-Topic: [PATCH v4 2/5] dt-bindings: imx-cpufreq-dt: Document
 opp-supported-hw usage
Thread-Index: AQHVCXs9inARAVSFcUWhxp3Op/Tu/Q==
Date:   Mon, 13 May 2019 11:01:39 +0000
Message-ID: <7948ab63fe5c92da280542a9a372349486d40c65.1557742902.git.leonard.crestez@nxp.com>
References: <cover.1557742902.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1557742902.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VI1PR04CA0134.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::32) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ffd7468-d9b4-4faa-14c3-08d6d7926016
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5138;
x-ms-traffictypediagnostic: AM0PR04MB5138:
x-microsoft-antispam-prvs: <AM0PR04MB51386384DC3CA370378AADFDEE0F0@AM0PR04MB5138.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(7736002)(2906002)(44832011)(99286004)(36756003)(6512007)(53936002)(54906003)(110136005)(476003)(2616005)(4326008)(52116002)(446003)(256004)(486006)(6116002)(3846002)(76176011)(11346002)(66066001)(8676002)(81156014)(81166006)(478600001)(118296001)(102836004)(7416002)(14454004)(68736007)(5660300002)(50226002)(8936002)(6486002)(25786009)(66446008)(64756008)(66556008)(66476007)(71190400001)(71200400001)(86362001)(6436002)(6506007)(386003)(66946007)(73956011)(316002)(26005)(305945005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5138;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gv2/HoUT8RCeTA4yBgbY0F4VG7/Xq+pAxqaTPXQWqcWuvDtQ9aI9q8w+vXbJWbfNoDBuOak3IVfzpW0rL4hwgpmqZmNeAVEIL4Y2VPoVHkCr9rz0znDZ0lphhmTtT/mJEWSgUnzbK3dbiyRFnxOF0YdEcRc8lsL0WkPHE+MC6R8sp5QPxkgdsm+6I0SK2gn516l9gDEvJ6QG1BKzwRxwaRhjH6aGi4ihVQyT0uA8CqkSCN8QsPfdwNgQREQMsJGJNSn/Sp8wdJSgjtEujgxoVWxv3syUuFUsaDslAn4repg8y6YUkArKq2GR32PALWDArHEu17878tGdzhIQQoIeAXFKUI09CT0/MaZRCdMxXCbHyCiwXd9ZerQm+VNEqytOqnp7vSAdEP60G/U7zYcZ5bmV0vswaLYYeMdgS6iud54=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1609FAC9533FF0449E0A30AD2B339619@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffd7468-d9b4-4faa-14c3-08d6d7926016
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 11:01:39.9489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5138
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interpretation of opp-supported-hw bits for imx-cpufreq-dt driver is
not very obvious so attempt to explain it.

There is no OF compat string associated.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 .../bindings/cpufreq/imx-cpufreq-dt.txt       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/imx-cpufreq-d=
t.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt b=
/Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt
new file mode 100644
index 000000000000..87bff5add3f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt
@@ -0,0 +1,37 @@
+i.MX CPUFreq-DT OPP bindings
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+Certain i.MX SoCs support different OPPs depending on the "market segment"=
 and
+"speed grading" value which are written in fuses. These bits are combined =
with
+the opp-supported-hw values for each OPP to check if the OPP is allowed.
+
+Required properties:
+--------------------
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: Two bitmaps indicating:
+  - Supported speed grade mask
+  - Supported market segment mask
+    0: Consumer
+    1: Extended Consumer
+    2: Industrial
+    3: Automotive
+
+Example:
+--------
+
+opp_table {
+	compatible =3D "operating-points-v2";
+	opp-1000000000 {
+		opp-hz =3D /bits/ 64 <1000000000>;
+		/* grade >=3D 0, consumer only */
+		opp-supported-hw =3D <0xf>, <0x3>;
+	};
+
+	opp-1300000000 {
+		opp-hz =3D /bits/ 64 <1300000000>;
+		opp-microvolt =3D <1000000>;
+		/* grade >=3D 1, all segments */
+		opp-supported-hw =3D <0xe>, <0x7>;
+	};
+}
--=20
2.17.1

