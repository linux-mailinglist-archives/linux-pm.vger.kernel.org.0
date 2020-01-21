Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58A1143A4E
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgAUKDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:03:48 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14578 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgAUKDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:45 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: FgnFxgx6x3b7Tr+yCyoZYn9TiZGMqXmPtnrRp4byYDgc4RXA0cWRRROw5VAxiLCKDCKItx5ggl
 faTaYpSi+mNDMYv6j6EMJitAPPXqJ06Kny+ah1w64dGllOmqELtUs5Km3Swoa3XVqXKLWYJOgs
 BHnfY9sZ2LUAWYQG8Wb+b+BfunNiHpzwLQA3EVUnSgVXOcVXFGrpY0x5WgXNQisbtjd3YoGplf
 aSj7pM1MvSO6H0Cf5aR4jEunmv5ABG5bnQdNhr9QZ5/Zw3cgVAscZwNT9RJVnL4QI2jzzkYhbp
 t70=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61481969"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWvemKOZcIRnTvKfOhcOIIxkMR/m0bHUjtRhzEEoI/yFJPmx9OtuKfhYO02Luk4VGWCrWZfymZNCxRGTpawxxXY9Xr4xZXEpN3iqI/T2fxW1M4CZaTYup8/UCx+BGWWK2MubTONQLHaIjP9UcEXcpTat7ELPpd200eDmDx5Ia7InUNMrRaL8JfKZLFbLxayps3qjt4v1HZ7HBOll48Z3BhPVzY17iBSi72k9p2tc969MqpMosj4lfx+2uYXR22bg3gh1Uhk18UEngp4TVGCBaH6HP8wX0aKQGaPr2Wy1SUSX+R3JvJd39F1WCCYmZ+qTC1L7lP6jz31qbobOQNK0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvwHzKD28G/sirKaExsqRL0HJLR903anvMEANz44yYg=;
 b=L0kOGJkWLlQjLTGq6bHq/zF3vG/AQN0VS5S7cmrXT/cq/EcUuo/LczwEg03zyZPKG54UoZVp+RuEKlwGKWHiT3JjdazN1nKSTOtXSoUHO7vnWbQ45ZA6FhYfwdOc696t2TpUG1CW0Ebtm1N+luH0jeJy241jueER9YHjyD4lDD2FXCCQh04myx9ma98VLYoq4aotoscH2dcSTzOKWWvfhr9m5BHzIYy6Us8I+KByv1JSQvbqZO+/rfQMWBWiaBLkrMQJ5BY/KRiiWk0H47F9+WT1ib9b8JqujNVnaoJ6hLj7upf57zs1dl84o6t4YqJH+ftpFbdeQRDMjIyhO1LjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvwHzKD28G/sirKaExsqRL0HJLR903anvMEANz44yYg=;
 b=YxGoWl4YrUqCwACUpX4rHXLTu2rDKSYf2ugHcLENJL0dIQGveAwB5Bb3oBu2zUhhrJHnaz0cus3jro7Xz+ayBSQxy+oIbfk/EKElbfLG/xmpeGNb5gKnZeiiMgmr4e8lH9gNCBWnM6fmL4Xnb/JqcdO3lMN3mCE47IvJ8Qp4Alk=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3195.namprd11.prod.outlook.com (20.176.121.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 10:03:32 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 10:03:32 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 07/15] power: reset: at91-reset: devm_kzalloc() for at91_reset
 data structure
Thread-Topic: [PATCH 07/15] power: reset: at91-reset: devm_kzalloc() for
 at91_reset data structure
Thread-Index: AQHV0EIJK7jrmwT79UOEMXED2p1fmQ==
Date:   Tue, 21 Jan 2020 10:03:32 +0000
Message-ID: <1579601001-5711-8-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b7cc2c1-360b-458a-763a-08d79e592c41
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3195DAE15325EF90CA5879A7870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XrslaVEPRCCTVcLnk5wPhU0sUCwL25gLDi+d2Jo7pxXXGwr06P1cU0BCpfHsMvSnoRqtCoGKauUnPXuumoJl0uXVIwv0nv0AV3tK8CT8zdMDgORgCJG+Rj+RnguxG1Gm2HHtMTqtNw0YC7L6NO8OmAYygTfGfnBjDdF2Ywhf1BlsB6sQ2i2egDNh3TLV72muqOgcy6xXRC5LTx1qrEOWcu7i+EPlka//G0b790sS5RXcR85sTTxoC4DqIuioijgSvEdriJsW4S+fblwQDHgjlCTlDSQ6s2/wZcZm4EVUz/RY4OEm1fhouz18D8j/Vft5AtzNuwo0WDcAop5pa4vfZrscSO683oex95KWeE6V2T/61TLY46AxbDsRiWOAI1Yg5pETiGeghDYHD5L+4hBO3mMYiK8PNdbUKPPWcyyym3kFQg1nuXbLcBObKqu6Tek
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7cc2c1-360b-458a-763a-08d79e592c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:32.4632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCVkepElQzv1wwWJbvg0CPBrpmTjYupsA4BH6MIsNTIcVMxx3qTB4V+2Qj0EV1ddXJqWCYw/Nqc66/F+2oQAVyU/g2yc1YczWeXwbOsOBKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allocate at91_reset data on probe and set it as platform data.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index bd05496c5ac7..7ba77555e9e1 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -56,8 +56,6 @@ struct at91_reset {
 	struct notifier_block nb;
 };
=20
-static struct at91_reset *reset;
-
 /*
 * unless the SDRAM is cleanly shutdown before we hit the
 * reset register it can be left driving the data bus and
@@ -66,6 +64,8 @@ static struct at91_reset *reset;
 static int at91sam9260_restart(struct notifier_block *this, unsigned long =
mode,
 			       void *cmd)
 {
+	struct at91_reset *reset =3D container_of(this, struct at91_reset, nb);
+
 	asm volatile(
 		/* Align to cache lines */
 		".balign 32\n\t"
@@ -93,6 +93,8 @@ static int at91sam9260_restart(struct notifier_block *thi=
s, unsigned long mode,
 static int at91sam9g45_restart(struct notifier_block *this, unsigned long =
mode,
 			       void *cmd)
 {
+	struct at91_reset *reset =3D container_of(this, struct at91_reset, nb);
+
 	asm volatile(
 		/*
 		 * Test wether we have a second RAM controller to care
@@ -137,6 +139,8 @@ static int at91sam9g45_restart(struct notifier_block *t=
his, unsigned long mode,
 static int sama5d3_restart(struct notifier_block *this, unsigned long mode=
,
 			   void *cmd)
 {
+	struct at91_reset *reset =3D container_of(this, struct at91_reset, nb);
+
 	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
 	       reset->rstc_base);
=20
@@ -146,6 +150,8 @@ static int sama5d3_restart(struct notifier_block *this,=
 unsigned long mode,
 static int samx7_restart(struct notifier_block *this, unsigned long mode,
 			 void *cmd)
 {
+	struct at91_reset *reset =3D container_of(this, struct at91_reset, nb);
+
 	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PROCRST),
 	       reset->rstc_base);
=20
@@ -210,6 +216,7 @@ MODULE_DEVICE_TABLE(of, at91_reset_of_match);
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
+	struct at91_reset *reset;
 	struct device_node *np;
 	int ret, idx =3D 0;
=20
@@ -250,6 +257,8 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
 		return ret;
 	}
=20
+	platform_set_drvdata(pdev, reset);
+
 	ret =3D register_restart_handler(&reset->nb);
 	if (ret) {
 		clk_disable_unprepare(reset->sclk);
@@ -263,6 +272,8 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
=20
 static int __exit at91_reset_remove(struct platform_device *pdev)
 {
+	struct at91_reset *reset =3D platform_get_drvdata(pdev);
+
 	unregister_restart_handler(&reset->nb);
 	clk_disable_unprepare(reset->sclk);
=20
--=20
2.7.4
