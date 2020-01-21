Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3783143A5F
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 11:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAUKE1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 05:04:27 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18585 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgAUKDe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 05:03:34 -0500
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
IronPort-SDR: bpDUilozKRmaGJlSZZSSGlx/CgHQW1pL/yIl9bRmefzzmPG4XcGVSPuwXgUJD/nqB4mZD9/m0h
 30F/f+p/4ew0ojBxYqfzk7/p+zovM+xbjPiSLNvEa/GjU/B67kmDjJGjFffO4Ark3zgaYw2zjH
 IW2ZcqaC4XaEQ2dmZWsRfiL3BeiBumvGuO+bI59VqKCubyLUUZ/NpQGxHPufFQRFes5t+xXSAq
 1S987wlIn4QV0rA1kgflijJ0h4aO5SAugcuNB93nsN7Raf6kcWlB3fZVjPWPjHboz+uSoWnDNn
 /yU=
X-IronPort-AV: E=Sophos;i="5.70,345,1574146800"; 
   d="scan'208";a="61695311"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2020 03:03:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 03:03:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jan 2020 03:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN9Griktd6S3J+bPPqCW5DL3FbR7bm7ShhpJ+ffXWiIaqRtJpujmd4K9UEmnWJhFVd01uuNQXokU6vcbU5ulfd/Tt3n7ak2Bojt2tvlNJsEmHXOM7r1JRwxIeiACeiE+hMDwRy4sxCMJ0qv5e9/noVH3MeFhHY8OPYeY9hyPFqvySI1Y4r0X615X6wcv4Br3Mk9oPCVBXdA+49v0iTRI0yluTw/IvLykLf655Ogkj6KZQKFKr5bFDV9720VYb3yE5/Fc8iFJM39RB1dytXNJ6+D9AFz4UeN3aBJdmHJcrjosap5PIXvxhhMkSiyq7iuuMu4yzL2+XW2wp0/nthLKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSpkiGqULqeav3t1233W7sXIauLKipAKcjVTQGsJ8tg=;
 b=F6Q6k+KmSug98fIqKhBjvHbB8+HEryhenGvF067vI8RnM2DTnccO3WlgaO4nxm2qVlQpu3kQJHRruVc9SWojO+uOer2M6Mx2r55sYiz/fkO6GJR9iZevGF6vRCxFSPxzV4hYGzW8CzUPnG3Yf2N1n9tmlfnnQ64RJMEgdTfedCAcG3vVxT4R1Vrxs2j+Eh0MLUbCrG/aqGj6YpIR1wL+CKenGxx4RNaMVIgB20b/3udSayIdSRk7vF25QOmr5kmMeHkEB0HG08/1yOVqdqg8/OQScAUdFDGTf6cSSNxq4Upn3V0R7imyhn4dBGY1C6R1frmSwb8uvy7rXmp1nf0Y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSpkiGqULqeav3t1233W7sXIauLKipAKcjVTQGsJ8tg=;
 b=Uno0MrKOY3JZbK+eHu7JvSbtvpuznwyRtDDY6EGTdyKksFqaWnNEU7Hd6tCs8mheeb+lhGCapfUA4hNhYml4Z6TZdqJ8x7y6i02/PRn2OnyQTy1ziBEUfaGl+4I31o/oK5Xmvf9eicxPjN3nr2OwkTdS9dgZBfWbM1tj+RNpRGw=
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
Subject: [PATCH 06/15] power: reset: at91-reset: pass rstc base address to
 at91_reset_status()
Thread-Topic: [PATCH 06/15] power: reset: at91-reset: pass rstc base address
 to at91_reset_status()
Thread-Index: AQHV0EIJ+l0RsJUa3kGPok8oJIBRaA==
Date:   Tue, 21 Jan 2020 10:03:32 +0000
Message-ID: <1579601001-5711-7-git-send-email-claudiu.beznea@microchip.com>
References: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1579601001-5711-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a46279a0-6012-40ea-7c1c-08d79e592bf0
x-ms-traffictypediagnostic: DM6PR11MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3195F9749F61B6ED7831F559870D0@DM6PR11MB3195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(107886003)(26005)(186003)(36756003)(5660300002)(110136005)(54906003)(4326008)(66556008)(66476007)(6506007)(2906002)(76116006)(91956017)(6486002)(86362001)(64756008)(6512007)(66946007)(66446008)(8676002)(81156014)(2616005)(81166006)(8936002)(6636002)(71200400001)(316002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3195;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxqY1jypbnqdTOEWii7fnUWDCWN1u+vg7abW62KlWZ5iXFHUI0dUE6Ln24o0CB+jxSmK2GTlctDizUrTaAq6ged07qQeHL8LJ5TO0UfPzNgm1nrJXKNNlj6TXrpVpiSxwk+8VFwtE69NTqlC6KSTiQEwLeHJ0dVKOWRicUQe3zDazXdplz0UjOPRnW5mwcoOJYPmP5O8W4Lv4yP3DRulbyk5rOCwZo2HuSmN98Q7GEJriHBgt/r+IEAsz13d3S++2IwmgoUlemuli2jk/dmQ/rOk3H5pJYvjFkxclScn41fU1XBCsFigtoMgt6Pv3CUMNMccui9I6hpuSym/uPsoVjAuLmnb7xUk8BqIUSMJ38LSpe5uBAhbIkeifKq4sJYjU+oZHy6mcfawCRwvNTZSZzCmrr5APYZU/vm9A5baGCAn5YJiBZStDtLm4BHjpY3I
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a46279a0-6012-40ea-7c1c-08d79e592bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 10:03:32.0304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wXK9muvbgF5WXRZj4BhCrO4jVJbKQ/hkkmQCeyLq6/+jQaPgFfDynBDYZOnpW0OtFwF4ia2fUol/X+8dt1nyuFn2Z5g2cTUR1AFhtTNJPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3195
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new argument to at91_reset_status() that is the pointer to reset
controller base address.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-re=
set.c
index 4bb5eef4b258..bd05496c5ac7 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -152,10 +152,11 @@ static int samx7_restart(struct notifier_block *this,=
 unsigned long mode,
 	return NOTIFY_DONE;
 }
=20
-static void __init at91_reset_status(struct platform_device *pdev)
+static void __init at91_reset_status(struct platform_device *pdev,
+				     void __iomem *base)
 {
 	const char *reason;
-	u32 reg =3D readl(reset->rstc_base + AT91_RSTC_SR);
+	u32 reg =3D readl(base + AT91_RSTC_SR);
=20
 	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
 	case RESET_TYPE_GENERAL:
@@ -255,7 +256,7 @@ static int __init at91_reset_probe(struct platform_devi=
ce *pdev)
 		return ret;
 	}
=20
-	at91_reset_status(pdev);
+	at91_reset_status(pdev, reset->rstc_base);
=20
 	return 0;
 }
--=20
2.7.4
