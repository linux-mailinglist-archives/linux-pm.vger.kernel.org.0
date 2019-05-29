Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8BF2DC33
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 13:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE2LwN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 07:52:13 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:22150
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfE2LwM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 07:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D/Gg8qSHSqJQGQHiq32cJjXVFES/JbGTqcX6A7suFU=;
 b=JcZiKf+XtADtW7RPo3RqV6DLkOuWb27QwvyE3UcdyzeylvqV7ocdJQWXVAZeTk7xjeSM4c2sm9uK9FWNWO0Jhgf/Bb9nI2AxGkBt0EtkDDa5NnuyqBssnguGuov0g+Kxvd07Exv44IRYm7QwXXI09LDOnQ6TpibuLZqqBvwfd6E=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5231.eurprd04.prod.outlook.com (20.177.51.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.21; Wed, 29 May 2019 11:52:08 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 11:52:08 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] cpufreq: imx-cpufreq-dt: Fix no OPPs available on unfused
 parts
Thread-Topic: [PATCH] cpufreq: imx-cpufreq-dt: Fix no OPPs available on
 unfused parts
Thread-Index: AQHVFhTxPvevUIzw3UGv3Gp2x1Kq6g==
Date:   Wed, 29 May 2019 11:52:08 +0000
Message-ID: <64c450d4ee5119ef21ae744a3ca90d7172f973fd.1559130569.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: LO2P265CA0367.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::19) To VI1PR04MB5055.eurprd04.prod.outlook.com
 (2603:10a6:803:5a::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a001f2d-21eb-4927-205c-08d6e42c13b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5231;
x-ms-traffictypediagnostic: VI1PR04MB5231:
x-microsoft-antispam-prvs: <VI1PR04MB5231C38F8DC288511EEB12F7EE1F0@VI1PR04MB5231.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(366004)(39860400002)(189003)(199004)(386003)(50226002)(6506007)(8936002)(102836004)(476003)(186003)(305945005)(4326008)(99286004)(73956011)(316002)(66066001)(2616005)(52116002)(7736002)(6436002)(36756003)(53936002)(6916009)(71190400001)(71200400001)(14454004)(44832011)(486006)(66946007)(66476007)(66556008)(478600001)(6486002)(3846002)(118296001)(26005)(6116002)(6512007)(86362001)(66446008)(25786009)(5660300002)(81166006)(14444005)(81156014)(68736007)(8676002)(2906002)(54906003)(256004)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5231;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MQp0K8Jicoc/sf040FtDzSikKL3TeMAKZZuTQbxhl2L7TIYrlnQtYB1vela3GShW9F2J1CaASUZN7EJpVniqRk13ijQrYaHK0NkOYZO7t4RGQ5WTcETWATjpPkB1JyPqNvpfmb7H/O6fnoJlZ1DbWjUJhZPxb6NHTH4lixnP/gGo5ivrh0VCdNxOQfL8hu1WThSCDKkGsEBwMkJ3n7edJuGsDyESQuHAUql979F2eOKS9ZMBXg7s8qbmE4vY+7ROZLoq8p5+N0SQLCVtheqJgFtNY1KfHOdHlP8TJR9WInXB2WSg19HcNXGthzqIFxt6kv9kanXLHyFSkkulaFhyvhIPJkrrMKS5i4rhV36GsDvSzn2XSz5t03x8P1vfG9C2mdZP2WToBGXzOVOQp1z/IsQ+k9VEOjSD+NR8r9hciuw=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8E96EBCD316AAA43BF7BF4B50D10C3A6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a001f2d-21eb-4927-205c-08d6e42c13b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 11:52:08.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5231
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Early samples without fuses written report "0 0" which means consumer
segment and minumum speed grading. According to datasheet the minimum speed
grade is not supported for consumer parts so all OPPs are disabled
which results in stack dumps later on.

Fix by clamping minimum consumer speed grade to 1 on imx8mm and imx8mq.

Fixes: 4d28ba1d62c4 ("cpufreq: Add imx-cpufreq-dt driver")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/cpufreq/imx-cpufreq-dt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq=
-dt.c
index 27b9b94cd4fc..ce26ffc18ce6 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -49,10 +49,25 @@ static int imx_cpufreq_dt_probe(struct platform_device =
*pdev)
 	if (ret)
 		return ret;
=20
 	speed_grade =3D (cell_value & OCOTP_CFG3_SPEED_GRADE_MASK) >> OCOTP_CFG3_=
SPEED_GRADE_SHIFT;
 	mkt_segment =3D (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_=
MKT_SEGMENT_SHIFT;
+
+	/*
+	 * Early samples without fuses written report "0 0" which means
+	 * consumer segment and minumum speed grading.
+	 *
+	 * According to datasheet minimum speed grading is not supported for
+	 * consumer parts so clamp to 1 to avoid warning for "no OPPs"
+	 *
+	 * Applies to 8mq and 8mm.
+	 */
+	if (mkt_segment =3D=3D 0 && speed_grade =3D=3D 0 && (
+			!strcmp(match->compatible, "fsl,imx8mm") ||
+			!strcmp(match->compatible, "fsl,imx8mq")))
+		speed_grade =3D 1;
+
 	supported_hw[0] =3D BIT(speed_grade);
 	supported_hw[1] =3D BIT(mkt_segment);
 	dev_info(&pdev->dev, "cpu speed grade %d mkt segment %d supported-hw %#x =
%#x\n",
 			speed_grade, mkt_segment, supported_hw[0], supported_hw[1]);
=20
--=20
2.17.1

