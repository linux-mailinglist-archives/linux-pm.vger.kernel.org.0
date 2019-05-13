Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463F61B468
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfEMLBl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 07:01:41 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:59894
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbfEMLBk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 07:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO6gaIlOGNiwxpeyq1/UarEoxpVmmpAv5XZMDwy+bUs=;
 b=Gz+RpwjmBj6SdA18JLV7LQ9yubJj+S9UcbQ32iNxzibwDEzS5AVFExUnHwF+yz5olPPlF/oaZy7Jp/D9J7jubupK4cqtbyDGulQC8ivC4aRs9tOTwN2tlopSqiIJUoGORDD5ZoDrTIcPzHSD3IvKvoCcDAF+CpSY7AILsQKzD0c=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5138.eurprd04.prod.outlook.com (52.134.89.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 11:01:37 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 11:01:37 +0000
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
Subject: [PATCH v4 0/5] cpufreq: Add imx-cpufreq-dt driver for speed grading
Thread-Topic: [PATCH v4 0/5] cpufreq: Add imx-cpufreq-dt driver for speed
 grading
Thread-Index: AQHVCXs8MBVHQc8rXk+VbTw870d1OQ==
Date:   Mon, 13 May 2019 11:01:37 +0000
Message-ID: <cover.1557742902.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: c118f5d9-fc81-42ec-7f23-08d6d7925e81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5138;
x-ms-traffictypediagnostic: AM0PR04MB5138:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <AM0PR04MB513891F95DB3E83E63735157EE0F0@AM0PR04MB5138.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(7736002)(2906002)(6306002)(44832011)(99286004)(36756003)(6512007)(53936002)(54906003)(110136005)(476003)(2616005)(4326008)(52116002)(256004)(486006)(6116002)(3846002)(14444005)(66066001)(8676002)(81156014)(81166006)(478600001)(102836004)(7416002)(14454004)(966005)(68736007)(5660300002)(50226002)(8936002)(6486002)(25786009)(66446008)(64756008)(66556008)(66476007)(71190400001)(71200400001)(86362001)(6436002)(6506007)(386003)(66946007)(73956011)(316002)(26005)(305945005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5138;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gN2oYHLkf37KAcdh14g8gP4EzbCxF7hyWR4jmtg42lS5mBttH62C26wMF0C6QqIAuHFB/jkUS94AgBIC4hBmvWpWgUwvWPeBmy0vjg5S25qdEVik9iIF1vQsICnShw4wajtazY2QU8zkuylr4wFKGgUgci3dy+2stIqUIp7GWjVjdInSUhN7hqKsAMD5HNxutUGeF/wZYsORcoZS4j4dvTRQF+uBQ2tAxB1jWX2Q1bXPZuowhYdKW+rrS9BKqFntrOsUVJHx4u6y3jr4XUYrc/9UX3KcwO+pFC0zomnKFwrvOILX399Tox8eYsEZP+ntyMaHvxLA9TUFQfUSc4MwLUYS3vAQhrp1rXH3zjwh+TNDPJfMouAfMdmi/iCUIdCnokhUDi4Wxer6NJW7ma2mWhC8h9I0IynGr/sZmka9CS4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <13C41D9609273F49A77AE0DA0AB8AA6B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c118f5d9-fc81-42ec-7f23-08d6d7925e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 11:01:37.2824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5138
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Right now in upstream imx8m cpufreq support just lists a common subset
of OPPs because the higher ones should only be attempted after checking
speed grading in fuses.

Driver reads from nvmem and calls dev_pm_opp_set_supported_hw before
registering cpufreq-dt.

Changes since v3:
 * Drop default m entirely (Viresh)
Link to v3: https://patchwork.kernel.org/project/linux-arm-kernel/list/?ser=
ies=3D114685

Changes since v2:
 * Minor reformatting in Kconfig (Viresh)
 * Open-code imx_cpufreq_dt_match_node (Viresh)
 * Add mkt_segment bits to supported_hw and update .dtsi to match after
reviewing latest datasheets.
 * Add devicetree list (keep forgetting dts needs to be reviewed)
Link to v2: https://patchwork.kernel.org/project/linux-arm-kernel/list/?ser=
ies=3D113163

Link to v1 (RFC): https://patchwork.kernel.org/patch/10916769/

Driver is built as a module. It depends on nvmem-imx which can also be a
module.

I never noticed anything wrong with going above the fused speed grading
however it's technically unsafe so the cpufreq code changes should go in
before DT changes.

Leonard Crestez (5):
  cpufreq: Add imx-cpufreq-dt driver
  dt-bindings: imx-cpufreq-dt: Document opp-supported-hw usage
  arm64: dts: imx8mm: Add cpu speed grading and all OPPs
  arm64: dts: imx8mq: Add cpu speed grading and all OPPs
  arm64: defconfig: ARM_IMX_CPUFREQ_DT=3Dm

 .../bindings/cpufreq/imx-cpufreq-dt.txt       | 37 +++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 17 +++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 26 ++++-
 arch/arm64/configs/defconfig                  |  1 +
 drivers/cpufreq/Kconfig.arm                   |  9 ++
 drivers/cpufreq/Makefile                      |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |  3 +
 drivers/cpufreq/imx-cpufreq-dt.c              | 96 +++++++++++++++++++
 drivers/soc/imx/soc-imx8.c                    |  3 +
 9 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/imx-cpufreq-d=
t.txt
 create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c

--=20
2.17.1

