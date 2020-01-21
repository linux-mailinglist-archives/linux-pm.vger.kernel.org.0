Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8FB143A43
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgAUKDi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:03:38 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18585 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgAUKDh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:37 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: /v1X6D6l6vAnnQ4G+XuD76qV5U0W8UlDQ87P0jFn+v7VdCCtp7jVzIozq6DxVNNVUdOiM4lkDh
 xv2ZwjACK7Q3OZ1Bb42anHIQpaByr4NucPKeIAZGV+uKxGl9WWBAxKal1MMrwilNiHSbygSjHB
 IiJitX0U2y8BI+eskxW2mEotUCxMgIaB2GmsdfFNeDUy+591OgPB/UbEZkDFd73qCickGTqTEl
 r6+YVqsqtebN2C/aykj39eu9aUQXQG7RHuMlW3t20z5SpoP04SEMSabu35fW1wwxU6r2RjjIRx
 U3w=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61695317"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8/fIN/BPeiiGJFDaQK0jQna0QEgEuVJ1FxESA0A7JSvIfUYMyHNOqwWLhmXuL5Rt65InfzmcpBuajGD/c6MROhC8EYQhRJV/NodiViP/f6zvb8SH+Vpqnksj1CWEwfZUaw4kGgki53Z0Cn2ml4abe3eLkyKOGDbCYOCTr7JqNBsNE4w5N/R/hgixebdL+74+eAtVqDnxIaMTDUAuBg8ysHda1QxIfI3Kfid3z0b08F5M+tmuGFBVh2oRifHv1Mxn3gm07WHYXm+I/kfngN6uf4qMdDvjFXHWe079WALKVWg/EcNong0CQMrDPm3mJ9Z+VH8VMPBW47OgZjuB1MmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQoTLeyPGWZaEfxVhk1HhANrwKlp3HUszSHXDBCHZTc=;
 b=hFmFWiNkaHv3uSLakDaoBInSO1r84oWRVPFnZVc9LYRBCK1dP3GBCOIMxu8qjyLSSUVhmjaS53ObwwW3vAE+VcJn4umMa373TiGIiY3rzK7vvCAZ4weEuH4GDT/t+/Dx/46acpt64f2fzIFSpv+LcoJ/QvfEkVC1k82VbqpcH6T2WJfFv8/xdqHscbh18V+OpU7bVJLB2Im28UzKiy2U9ukVGT7zYNn2QmhmI401enBStItMgZlH/E7VmSh/YwmfVx+0BEt0JaGU+uMubnRdOLkhFKjCH22aFLO4V5kT6BEFMePZtYKm+R3Io4qfXKdHgvfhZJARE6XxehPGYwmPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQoTLeyPGWZaEfxVhk1HhANrwKlp3HUszSHXDBCHZTc=;
 b=clbyyZAIRDsXndjbr8mSmsBWFfIx5yfgHLJF3C+2KS+Ck5bBkNbdmP2R/WeRzdmsrke6IOrFMVJpfqYd+bvHqHwNrl+CaYATLPv+lv1VxgkboI7MkUBZoiyMpOlAg97GyOjXMCUXoGWIQXvwaqjiHNNHZJp6EFKnlGz+FylEOKo=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:33 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 08/15] power: reset: at91-reset: introduce struct
 at91_reset_data
Thread-Topic: [PATCH 08/15] power: reset: at91-reset: introduce struct
 at91_reset_data
Thread-Index: AQHV0EIJAKB1rrnAy0m3EgT+VbjOYA==
Date:   Tue, 21 Jan 2020 10:03:32 +0000
Message-ID: <1579601001-5711-9-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81dc8160-20b7-4013-7dd6-08d79e592c8c
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB31951ABC56D95D105D2DBC26870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ft51/GC4XXJVp0sUlVAky0db8CfD+51Fl1rQicl/CdiE0+redg98ifQcFHjXGbAtLS9q/P2bp5040CpRS13GNGYDKhAsU4hNZi7wt+U+khBHvYmnPtodvEl3ykuLTIV9jZHMOH3pBuZgO33cqDIHqqAKGFxu+jDhRnp8wZ8ekpE4PGHeiG8XTtWZlBPqqcLLPEz4x/eR+opP7O9yMJ9pNaNb7CgNQAXm34P2Rk8SxPxWIAxlRW9OajvV2GuhWAnKGR+iQepq1eLbcCfjWM2YJT6dA8IaqBfkIcjvb42qTSiEhl0BHHY7JkF/RHddNE+ijGmnhRjpsjH3Mc8c/7Md77bmtduKcFHjGAgOEfqKIkh/Z00zmkWO0P7+yAToZdIelNHGn45lSQk8ytvz3xcClNuhVlzYPRZgvlahxbsmS9ca4fRbUwZIUQRj77xsTZjn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dc8160-20b7-4013-7dd6-08d79e592c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:32.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fr9/OAZhmsSwhgMLWTk6K4+3N+gydqzeZelQAsKLLU6k/MhP+PW/e0E+sPX1ToFchu6o7bz8bzkpDWqLDppdCf/WmFuolfa8gzLVawXSvVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce struct at91_reset_data to be able to provide per SoC
data. At the moment this being only notifier callback.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 50 +++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index 7ba77555e9e1..c653bd7ac29a 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -49,6 +49,11 @@ enum reset_type {
 	RESET_TYPE_ULP2		=3D 8,
 };
=20
+struct at91_reset_data {
+	int (*notifier_call)(struct notifier_block *this, unsigned long mode,
+			     void *cmd);
+};
+
 struct at91_reset {
 	void __iomem *rstc_base;
 	void __iomem *ramc_base[2];
@@ -203,18 +208,50 @@ static const struct of_device_id at91_ramc_of_match[]=
 =3D {
 	{ /* sentinel */ }
 };
=20
+static const struct at91_reset_data at91sam9260_reset_data =3D {
+	.notifier_call =3D at91sam9260_restart,
+};
+
+static const struct at91_reset_data at91sam9g45_reset_data =3D {
+	.notifier_call =3D at91sam9g45_restart,
+};
+
+static const struct at91_reset_data sama5d3_reset_data =3D {
+	.notifier_call =3D sama5d3_restart,
+};
+
+static const struct at91_reset_data samx7_reset_data =3D {
+	.notifier_call =3D samx7_restart,
+};
+
 static const struct of_device_id at91_reset_of_match[] =3D {
-	{ .compatible =3D "atmel,at91sam9260-rstc", .data =3D at91sam9260_restart=
 },
-	{ .compatible =3D "atmel,at91sam9g45-rstc", .data =3D at91sam9g45_restart=
 },
-	{ .compatible =3D "atmel,sama5d3-rstc", .data =3D sama5d3_restart },
-	{ .compatible =3D "atmel,samx7-rstc", .data =3D samx7_restart },
-	{ .compatible =3D "microchip,sam9x60-rstc", .data =3D samx7_restart },
+	{
+		.compatible =3D "atmel,at91sam9260-rstc",
+		.data =3D &at91sam9260_reset_data
+	},
+	{
+		.compatible =3D "atmel,at91sam9g45-rstc",
+		.data =3D &at91sam9g45_reset_data
+	},
+	{
+		.compatible =3D "atmel,sama5d3-rstc",
+		.data =3D &sama5d3_reset_data
+	},
+	{
+		.compatible =3D "atmel,samx7-rstc",
+		.data =3D &samx7_reset_data
+	},
+	{
+		.compatible =3D "microchip,sam9x60-rstc",
+		.data =3D &samx7_reset_data
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
=20
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
+	const struct at91_reset_data *reset_data;
 	const struct of_device_id *match;
 	struct at91_reset *reset;
 	struct device_node *np;
@@ -244,7 +281,8 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
 	}
=20
 	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
-	reset->nb.notifier_call =3D match->data;
+	reset_data =3D match->data;
+	reset->nb.notifier_call =3D reset_data->notifier_call;
 	reset->nb.priority =3D 192;
=20
 	reset->sclk =3D devm_clk_get(&pdev->dev, NULL);
--=20
2.7.4
