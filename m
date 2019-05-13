Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C61B472
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 13:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfEMLBu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 07:01:50 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:59894
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729209AbfEMLBt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 07:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cx0bgctgEXYbjy4gBgf9QWZa7SV4VtfnyHnIrnTQh0=;
 b=TbW+D7Pp3F5gKRiHPrG2ndyHaGAfo0sJ2YtHaSSkkk335JAFRjbF69vnkGLJZeSylwp5Y7Kn5pA66hh4f2RbsF4RvkmKj4UJHlD9YI6CLyAjbnbF2rMY/IcC5VNI843wEjN/iFeE8dZ/l+4Ud+m1RpeX73De4AzdLc6hBU0a8qU=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5138.eurprd04.prod.outlook.com (52.134.89.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 11:01:44 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 11:01:44 +0000
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
Subject: [PATCH v4 5/5] arm64: defconfig: ARM_IMX_CPUFREQ_DT=m
Thread-Topic: [PATCH v4 5/5] arm64: defconfig: ARM_IMX_CPUFREQ_DT=m
Thread-Index: AQHVCXtA1txXIhOUHEmpa7nxgpAz0Q==
Date:   Mon, 13 May 2019 11:01:44 +0000
Message-ID: <675eb0dd54855126ea6f70804c84372d386878bb.1557742902.git.leonard.crestez@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3db0faf0-b8a4-4a55-ee9a-08d6d79262b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5138;
x-ms-traffictypediagnostic: AM0PR04MB5138:
x-microsoft-antispam-prvs: <AM0PR04MB513861F03F637FE758353CB7EE0F0@AM0PR04MB5138.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:372;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(7736002)(2906002)(44832011)(99286004)(36756003)(6512007)(53936002)(54906003)(110136005)(476003)(2616005)(4326008)(52116002)(446003)(256004)(486006)(6116002)(3846002)(76176011)(11346002)(66066001)(8676002)(81156014)(81166006)(478600001)(118296001)(102836004)(7416002)(14454004)(4744005)(68736007)(5660300002)(50226002)(8936002)(6486002)(25786009)(66446008)(64756008)(66556008)(66476007)(71190400001)(71200400001)(86362001)(6436002)(6506007)(386003)(66946007)(73956011)(316002)(26005)(305945005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5138;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ELtU0rMzQAlTxaSOWRiN7gvZWL9yNCk7Hxc1Cn1wVdUzYgpMRFGs8S3jNxEM/EDlxVLW+L8FX7gFHW9IMvFaBp/9JaV7+CYJhQ2DTLpdZ08N45r6Iij3RrGAW13adh0WfZl2DNfAehAP4k2tri38nbJNQyH+OB6lYSpcA14Jf/E/qn7lcPPna87l6igpZrBTY+oqS8YqeWJxuvV/L2ybYjETPWwbVsb6xGiS35l3B2NsikL8zookMn14+91pXF/BVJ6t3gnxJR4G7/4sSPYgRVd3Qn3mv1J2ia4RnbhvlB/TddWV/F/doSIcoaB70zLV3zbpRgzYDrMLYxa4T7TOHJ1sbqB/bLxH/ksWgHsyI6qI2yXzG9ITfg4FWUTcvrKocAoyuARLN0Q4kmysJdVlhzwa0oLsRIN/SHAaxsGBEa4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <49351519BAF31D4AAE7459C4FB211EC2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db0faf0-b8a4-4a55-ee9a-08d6d79262b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 11:01:44.3653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5138
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For imx8m we need a separate small driver to read "speed grading"
information from fuses and determine which OPPs are supported.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index df756468eacc..8202b940f263 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -80,10 +80,11 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
 CONFIG_CPUFREQ_DT=3Dy
 CONFIG_ACPI_CPPC_CPUFREQ=3Dm
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=3Dy
 CONFIG_ARM_SCPI_CPUFREQ=3Dy
+CONFIG_ARM_IMX_CPUFREQ_DT=3Dm
 CONFIG_ARM_TEGRA186_CPUFREQ=3Dy
 CONFIG_ARM_SCPI_PROTOCOL=3Dy
 CONFIG_RASPBERRYPI_FIRMWARE=3Dy
 CONFIG_INTEL_STRATIX10_SERVICE=3Dy
 CONFIG_EFI_CAPSULE_LOADER=3Dy
--=20
2.17.1

