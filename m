Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F71C1EFE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 12:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfI3Kfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 06:35:45 -0400
Received: from mail-eopbgr150139.outbound.protection.outlook.com ([40.107.15.139]:15623
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730637AbfI3Kfn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 06:35:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQgu2XPo5F1B7YWRl+9/FQqRWoDxKvUcGp2jd9Ea+Douo8JHBX7gchPUqDjp+mRtgyzvLfC/GtekebKIInYPzb/sDz1mFnfTWuDFwervBdGLT3f2megE5ChGfnrqVQa9k8gW1XSPzTuFeS/QsnbDmF/TsbP+ojZI5EvOvOzGEwOh6VricyJ/pJMRq+3LZQ6zrBZJ87hbldtAuCOlkUDrc6A/GfvTe6x7jAkM+aYSWMXgm84tdq8B5lhLNVSmBAth6Ongv44HoTUakqyQL5zWA2jVUYc6Hil/+wPadSdEQ+qhG2Z27tQ02OIIAcXaMMKssJgMknqrqA3ElteTQaCJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZILYJ7m8OcqtK2dnErDbwHyNN8npmp35kU2sKaCs/0=;
 b=QWse57btvibvJAaatxeLtIPtttFyZkXLddVBfqzL7dhe2ouIguC/SYFieqKu0BeVyUNDHAdxNHSiBLVxCZBLddUk9Wr1DlTtIAriwjTI2R2DsNFK4v0yU/S8666wD8g78J4eBm2Mdd1oJY/1paFHBeEroSuSriabs7dCgiNFiggz67ZFxtz9nsi9TceouaU6Z08h6yvdEWEFdsZiv7lKPDsLMVy/CZ+tkQrJR/wGbwUkhC0Fk85lXJcwBEcccTJCavFZcnUM9XsJdCbk1YwfHtgOq4u5CIzC4/ojK448P0WwBhsLXZDFWYNnQo2r4rREQerpB+W2qyZWSc4OvZHEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZILYJ7m8OcqtK2dnErDbwHyNN8npmp35kU2sKaCs/0=;
 b=nPSZA1yfEE/uLeNR1xxkxVY48B/owBj76eVg+CI0hj17+gI7zjWdq4EZbSfUxRQK0yRgke0553nhIf4chVkvUOqZNbRtoqH8ayXVtCSthaKv8ZTsZqcFgUDZGrm3EmkdjpxgiNPqwcN/aUF2lAZAQcOFAF60DvqM+3PciG+AprA=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5869.eurprd05.prod.outlook.com (20.178.125.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 10:35:38 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9%4]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 10:35:38 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jamie Lentin <jm@lentin.co.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/2] power: reset: gpio-poweroff: add force mode
Thread-Topic: [PATCH 1/2] power: reset: gpio-poweroff: add force mode
Thread-Index: AQHVd3rMNwaAxHNvgUiZVW1msP+Hyg==
Date:   Mon, 30 Sep 2019 10:35:38 +0000
Message-ID: <20190930103531.13764-2-oleksandr.suvorov@toradex.com>
References: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::38) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5723390c-272a-423e-6733-08d74591ef44
x-ms-traffictypediagnostic: VI1PR05MB5869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5869B691E25794ABB0C7C16FF9820@VI1PR05MB5869.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39840400004)(396003)(366004)(346002)(199004)(189003)(25786009)(6486002)(4326008)(66556008)(76176011)(66476007)(66446008)(64756008)(66946007)(6512007)(36756003)(81156014)(8936002)(26005)(186003)(50226002)(6436002)(81166006)(8676002)(86362001)(2501003)(5640700003)(14454004)(6506007)(386003)(478600001)(7736002)(44832011)(102836004)(54906003)(486006)(316002)(3846002)(6916009)(2616005)(476003)(256004)(2906002)(446003)(66066001)(71200400001)(5660300002)(11346002)(99286004)(1076003)(52116002)(2351001)(6116002)(71190400001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5869;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDRP5Y+tzaneN5c0Uvlsb974wnamBu/52Jphx/xwfob53xuCvz1FRpKPgWw0TnsF28TV/5ZbyQyo3esabvoSQnPVaT4g9uIhFmxY4dW0S53LlT8wame0mee+twnUdGBgEocEr5A2RKkIrQmfGj3hzZjWhs3sT1TbFp1uWxS5S0qIu5F1BaHp+uNdxYD106o7WI3jIduSb6R1Tx+ZNgjD06miDlY3QHpznM21+QDy+wIhvcYibYGNzTA01NmcF833G1MVuiY7FCikrpjxfBoJgDRfy+lYIJ1vUvyLH13/gyd1FT29q5Tpe7DLWK2y12NOWpt5CIbhT9qyrahQcdUqAZGjJ+ZiwNL0XzK7JWz9yZOCVE/xKBXGh1xC892JYg+7ffLEn/l3MXSUzezM/sW6uYLu+wAUbfMdW7HIuMPriAM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5723390c-272a-423e-6733-08d74591ef44
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 10:35:38.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUmxh2CZPFMmqouBF0M2w4p0t6sX3SpMq70UH1SsgsLQkHWHE1MWwcTcuYMmQ9Y0cLKMG3TU4zB2kxxLYQnQQc/lEUnj+ciBPRa7n8ZbssE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5869
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Property "force-mode" tells the driver to replace previously
initialized power-off kernel hook and allows gpio-poweroff to
probe and operate successfully in any case.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 drivers/power/reset/gpio-poweroff.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio=
-poweroff.c
index 6a4bbb506551..cca9f36fdce6 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -24,6 +24,7 @@ static struct gpio_desc *reset_gpio;
 static u32 timeout =3D DEFAULT_TIMEOUT_MS;
 static u32 active_delay =3D 100;
 static u32 inactive_delay =3D 100;
+static void *prev_pm_power_off;
=20
 static void gpio_poweroff_do_poweroff(void)
 {
@@ -49,14 +50,28 @@ static void gpio_poweroff_do_poweroff(void)
 static int gpio_poweroff_probe(struct platform_device *pdev)
 {
 	bool input =3D false;
+	bool force =3D false;
 	enum gpiod_flags flags;
=20
-	/* If a pm_power_off function has already been added, leave it alone */
+
+	force =3D device_property_read_bool(&pdev->dev, "force-mode");
+
+	/*
+	 * If a pm_power_off function has already been added, leave it alone,
+	 * if force-mode is not enabled.
+	 */
 	if (pm_power_off !=3D NULL) {
-		dev_err(&pdev->dev,
-			"%s: pm_power_off function already registered",
-		       __func__);
-		return -EBUSY;
+		if (force) {
+			dev_warn(&pdev->dev,
+				 "%s: pm_power_off function replaced",
+				 __func__);
+			prev_pm_power_off =3D pm_power_off;
+		} else {
+			dev_err(&pdev->dev,
+				"%s: pm_power_off function already registered",
+				__func__);
+			return -EBUSY;
+		}
 	}
=20
 	input =3D device_property_read_bool(&pdev->dev, "input");
@@ -81,7 +96,7 @@ static int gpio_poweroff_probe(struct platform_device *pd=
ev)
 static int gpio_poweroff_remove(struct platform_device *pdev)
 {
 	if (pm_power_off =3D=3D &gpio_poweroff_do_poweroff)
-		pm_power_off =3D NULL;
+		pm_power_off =3D prev_pm_power_off;
=20
 	return 0;
 }
--=20
2.20.1

