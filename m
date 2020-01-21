Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED8C143A46
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAUKDj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:03:39 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18585 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgAUKDf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:35 -0500
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
IronPort-SDR: ca0145M9G2SDBq7LioglYWvecn0gKET4x5AZhCqBRL96JscZ08L9dm48BmUys93cwjzdYWnGfW
 /yU4Coqepf098M1whu/sdph2Yu8GUQnH/SxxlwWh5aOmvpIsl2eGSy+47HSAyR7HsqsUKt5mDU
 iAyQGtuxT57UtlH+49EYKONGKOHhBwefBBE+SQz+y/NE0LoqeYtqziX8/uJznRFotBQ5KHbenq
 /0s06swNoVWvMMj9CU+xbkNmn/l+Kn4cFeM0eWT98w3t6Fyc8LMrZDJRTM83S4iaFo6s19xRvx
 YA8=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61695314"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EifYahtq8uidVjkwEWDVEJVTUAjRLpah1AtPq+9ujWinbqoBMFVkWorQ3gjuuXDPkM29FEVkkg4TMP+AyQA6Lx94TS4WDX7+16nH5Tdy50zjS74WQ8bZR6mzQsFnTSassZ9Z/ALG1CAZyH0YMgWXvJWYxkiBHq6IOtayD6O2yOzLzSkWiwVYWEefiHaW624uV7Aoq7UjPmfLTHbt+0ONP/lRli3HN9jJzr63PWnfbjbjd1hqbgpbgSfrWbR14SijO6o27IwLTO8ZSndVoO3LhHNrc+XKh6vvlepKwFMItJ+DRGHkpZfMw/VzCzVjdfCnhSbjsTHgmi6qw8EYSo8oeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2AYo1W7LWGeA2MKm2KYZLXjVcNJip8lPG4/cv8t56o=;
 b=ayqOa/OnoQIkknzaMe3IAveJtkV5iET09RkHU6aGt5Uzh9FQwehWIBQ1dln4aFCo5BMziT4RJzqzYTJQRLCJXTxHn7XDseCfDkQ0EwNztnSa+DxGBNwA2Hm7HgF8l3kMKcz9cdG8RQkqQZ9Spe48LqUVNO8d8Q7rsruUI+EcgtSQkWRbWG9OZ4HW6i+9CPb57JVBcq2VUAg1pq/XsCs9tIRPP5/xdUXQIwNeMqwgLti2OXNv/49ZaXCQ/wMzc9NN7teAVGPbijUfbXNzgal/gMD63chRjmldETkEuMNuu1KTPKODuRJZIzi4GCeWWoGFT9fORPnTymUnBNiw4qHAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2AYo1W7LWGeA2MKm2KYZLXjVcNJip8lPG4/cv8t56o=;
 b=ulIOMOJABSjYjj/XyOYm0jSZv15ITLyoSCABZ3lXLEzVQqIJUEsh53GuBtcbWxJJBEaAyv+jv/p0HXrghl12Xtc3OPdE2Y433/OTkR/H6zzejfxl4lN206Me44wPs4kRCCLGFzEPzlKFkbN3XWiiZ6Fw4WbsKMc8XHJNEY5FkiM=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:31 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 05/15] power: reset: at91-reset: convert reset in pointer to
 struct at91_reset
Thread-Topic: [PATCH 05/15] power: reset: at91-reset: convert reset in pointer
 to struct at91_reset
Thread-Index: AQHV0EIJnY4G7esm70ub3Ro4FxXzlA==
Date:   Tue, 21 Jan 2020 10:03:31 +0000
Message-ID: <1579601001-5711-6-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ad519e4-6372-4489-81ec-08d79e592b9f
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3195AF521FED3B2F02E3E86E870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EXGMJNT52j9dpkURZINgyDnr5X19HKBvGAusI+ebnc2yyZ+0lBktbyHvilFACduaQSN4lBxUll7rrZA0QTYBK73O0taLnI69nEvFKWETpsFshOYb2JZ17v6T1cxbfS9Zm52G8M/z0VvrbNASEZjyacpaRwiu73tSEdzTMNFvEwm5raOcz7gHfQ7Gby7BqFnKqRYYgHEDc/LDVKYWGaKsvroDFZbCGfzdtt9V3kQBBZ7FBwNJHfdwpaOtrlNRR+CEFEsRsFOtYjBo6ZlhuCvseLcjtL5v+BDImxQKY9h/jpDOPxyCDyw3hv8/1/jHAk6l6BmoY52Hw2rcoM39RufPsuhruy3qPpb9ojlkXUNINqMjOOPrWDujCgJVmsuxmxiRb6iEC1sk/vZkZClzv1aQI6SRBSp6ccRiQnFno9wuUnVcM6hB1an4pheNqVkPO8in
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad519e4-6372-4489-81ec-08d79e592b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:31.6486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKoOCoLsWAHPpZUQtmm5yG3mjaadVVYkGH5fT8j7t2ggmfdV3kcZP/I+zoP+PcQ5wllKRV54hgVFEhqZmJ6f5OYmSeqmj8FClWdwtSrrq0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert reset in pointer to struct at91_reset.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 50 ++++++++++++++++++++++--------------=
----
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index e8840193620d..4bb5eef4b258 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -56,7 +56,7 @@ struct at91_reset {
 	struct notifier_block nb;
 };
=20
-static struct at91_reset reset;
+static struct at91_reset *reset;
=20
 /*
 * unless the SDRAM is cleanly shutdown before we hit the
@@ -81,8 +81,8 @@ static int at91sam9260_restart(struct notifier_block *thi=
s, unsigned long mode,
=20
 		"b	.\n\t"
 		:
-		: "r" (reset.ramc_base[0]),
-		  "r" (reset.rstc_base),
+		: "r" (reset->ramc_base[0]),
+		  "r" (reset->rstc_base),
 		  "r" (1),
 		  "r" cpu_to_le32(AT91_SDRAMC_LPCB_POWER_DOWN),
 		  "r" cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST))=
;
@@ -123,9 +123,9 @@ static int at91sam9g45_restart(struct notifier_block *t=
his, unsigned long mode,
=20
 		"	b	.\n\t"
 		:
-		: "r" (reset.ramc_base[0]),
-		  "r" (reset.ramc_base[1]),
-		  "r" (reset.rstc_base),
+		: "r" (reset->ramc_base[0]),
+		  "r" (reset->ramc_base[1]),
+		  "r" (reset->rstc_base),
 		  "r" (1),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPCB_POWER_DOWN),
 		  "r" cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST)
@@ -138,7 +138,7 @@ static int sama5d3_restart(struct notifier_block *this,=
 unsigned long mode,
 			   void *cmd)
 {
 	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
-	       reset.rstc_base);
+	       reset->rstc_base);
=20
 	return NOTIFY_DONE;
 }
@@ -147,7 +147,7 @@ static int samx7_restart(struct notifier_block *this, u=
nsigned long mode,
 			 void *cmd)
 {
 	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PROCRST),
-	       reset.rstc_base);
+	       reset->rstc_base);
=20
 	return NOTIFY_DONE;
 }
@@ -155,7 +155,7 @@ static int samx7_restart(struct notifier_block *this, u=
nsigned long mode,
 static void __init at91_reset_status(struct platform_device *pdev)
 {
 	const char *reason;
-	u32 reg =3D readl(reset.rstc_base + AT91_RSTC_SR);
+	u32 reg =3D readl(reset->rstc_base + AT91_RSTC_SR);
=20
 	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
 	case RESET_TYPE_GENERAL:
@@ -212,8 +212,12 @@ static int __init at91_reset_probe(struct platform_dev=
ice *pdev)
 	struct device_node *np;
 	int ret, idx =3D 0;
=20
-	reset.rstc_base =3D of_iomap(pdev->dev.of_node, 0);
-	if (!reset.rstc_base) {
+	reset =3D devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->rstc_base =3D of_iomap(pdev->dev.of_node, 0);
+	if (!reset->rstc_base) {
 		dev_err(&pdev->dev, "Could not map reset controller address\n");
 		return -ENODEV;
 	}
@@ -221,8 +225,8 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
 	if (!of_device_is_compatible(pdev->dev.of_node, "atmel,sama5d3-rstc")) {
 		/* we need to shutdown the ddr controller, so get ramc base */
 		for_each_matching_node(np, at91_ramc_of_match) {
-			reset.ramc_base[idx] =3D of_iomap(np, 0);
-			if (!reset.ramc_base[idx]) {
+			reset->ramc_base[idx] =3D of_iomap(np, 0);
+			if (!reset->ramc_base[idx]) {
 				dev_err(&pdev->dev, "Could not map ram controller address\n");
 				of_node_put(np);
 				return -ENODEV;
@@ -232,22 +236,22 @@ static int __init at91_reset_probe(struct platform_de=
vice *pdev)
 	}
=20
 	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
-	reset.nb.notifier_call =3D match->data;
-	reset.nb.priority =3D 192;
+	reset->nb.notifier_call =3D match->data;
+	reset->nb.priority =3D 192;
=20
-	reset.sclk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(reset.sclk))
-		return PTR_ERR(reset.sclk);
+	reset->sclk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(reset->sclk))
+		return PTR_ERR(reset->sclk);
=20
-	ret =3D clk_prepare_enable(reset.sclk);
+	ret =3D clk_prepare_enable(reset->sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
 	}
=20
-	ret =3D register_restart_handler(&reset.nb);
+	ret =3D register_restart_handler(&reset->nb);
 	if (ret) {
-		clk_disable_unprepare(reset.sclk);
+		clk_disable_unprepare(reset->sclk);
 		return ret;
 	}
=20
@@ -258,8 +262,8 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
=20
 static int __exit at91_reset_remove(struct platform_device *pdev)
 {
-	unregister_restart_handler(&reset.nb);
-	clk_disable_unprepare(reset.sclk);
+	unregister_restart_handler(&reset->nb);
+	clk_disable_unprepare(reset->sclk);
=20
 	return 0;
 }
--=20
2.7.4
