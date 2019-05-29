Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D907B2DC5E
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 14:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfE2MDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 08:03:46 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:13709
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfE2MDq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 08:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b74Mw+FHeiJ8HFnmZ17okaizX5gjHun9n1pw139QcI8=;
 b=jSAJRYOtFlFbpodxsVQ4r0acK7XAwSeW5nV9pN1Wg9r6ft0aoucF3AkHEDxZBVYaHktZf4tYUBndRw0jxL9I+a3O1FGpXnSwTjm7aTT+bkFU4TIkOfuI/i1c6vMV+e19Ky/SMRkFHIlKl+sz3mmPQO4GgwPnYZCLr64zqhjOt/M=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5998.eurprd04.prod.outlook.com (20.178.123.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Wed, 29 May 2019 12:03:41 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:03:41 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_ARM_IMX_CPUFREQ_DT
Thread-Topic: [PATCH 2/3] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_ARM_IMX_CPUFREQ_DT
Thread-Index: AQHVFhaOovX+0voa2kC167S+xokfJg==
Date:   Wed, 29 May 2019 12:03:41 +0000
Message-ID: <b97f8f2590df9b487543b73c5ac73ac494df9754.1559131365.git.leonard.crestez@nxp.com>
References: <b6a9b9f80534af5c12db30a0bb699ec850f85be7.1559131365.git.leonard.crestez@nxp.com>
In-Reply-To: <b6a9b9f80534af5c12db30a0bb699ec850f85be7.1559131365.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: LO2P265CA0432.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::36) To VI1PR04MB5055.eurprd04.prod.outlook.com
 (2603:10a6:803:5a::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09e61512-7b00-4496-ff39-08d6e42db0fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5998;
x-ms-traffictypediagnostic: VI1PR04MB5998:
x-microsoft-antispam-prvs: <VI1PR04MB5998FD2CE5FBE75D04DC59A2EE1F0@VI1PR04MB5998.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(6436002)(6512007)(73956011)(478600001)(66446008)(5660300002)(6116002)(6486002)(386003)(6506007)(102836004)(110136005)(25786009)(81156014)(305945005)(54906003)(3846002)(50226002)(6636002)(99286004)(7736002)(8936002)(68736007)(86362001)(76176011)(53936002)(8676002)(52116002)(316002)(4326008)(81166006)(14454004)(66476007)(4744005)(64756008)(66946007)(66556008)(118296001)(2906002)(26005)(186003)(11346002)(256004)(486006)(476003)(446003)(2616005)(44832011)(71200400001)(71190400001)(36756003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5998;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wnxV9JQoDVS1Y+zFQ9bkOBWYXMQxC6fsojXAN4UufKqHDCB92NDmw+Uzf1sqE7tjgdFQ/DfyX68xfp830Wif15Ru2zaw7tGvPOWiHaaca/FBpkcNVlbPU8biSisTNKU1chXtYwGzAOXWNPFzTwGhQKbDu+uN1K8pWxLOGsUtiVd7aYG+jYH0s+eYfZUV8ngPV4uYbUe3a/WMYX8ZlQ+KnqbppSPoQnDQTbykWqsYllxL1bw6fMr85OEkKU3dIVsv4nRUfnAiZQKc+AeIq4e/QGPheznSSScoh+2/4t3huiecrExdl+Wx/uv5h2YUopsfX3Qxa4tynaCUkAl9Ogjx0Y9JOReRy1FIjjdm0cmytaJhInzkfgwYW7gC+EuL8fuTOfqWvrMUPrAewsNVPOU72f/H9ifaREP81O/AU2DmCgI=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CCEF5E368A8EC5459BAFA0A7A852AD39@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e61512-7b00-4496-ff39-08d6e42db0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:03:41.6712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5998
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is used for imx7d speed grading.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6=
_v7_defconfig
index 4daf807e6970..507c1fcca624 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -52,10 +52,11 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
 CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
 CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
 CONFIG_CPUFREQ_DT=3Dy
 CONFIG_ARM_IMX6Q_CPUFREQ=3Dy
+CONFIG_ARM_IMX_CPUFREQ_DT=3Dy
 CONFIG_CPU_IDLE=3Dy
 CONFIG_ARM_CPUIDLE=3Dy
 CONFIG_VFP=3Dy
 CONFIG_NEON=3Dy
 CONFIG_PM_DEBUG=3Dy
--=20
2.17.1

