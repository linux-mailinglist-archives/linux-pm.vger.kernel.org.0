Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3729BC22F1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfI3ON5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:13:57 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:19599
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731472AbfI3OMy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 10:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/kFdHFqpKQqjg4Mh5Hr8v6r7B+/wkY9COeYeS10WiEJoH207ypr5TqWOgGYaH2RAZ0Dq/Aa2jFAiWs6Vm7go/7ZTKXzIPIqar0OeNLgufqXlqq9dVGwetq1c5mi2je0Icyoam1UQpgeq2keBX8CjSSWTlFRghETn3fC0GyylBGcIeXAexoSrk/Uzd+8W2MdzeVH5rbZ0khw4GeZ5MI+Jw6JjSZGsfI6j/YbPx22AJoUUwEzNqeDK67VGcMVzmvYrfoRqL4DZ25QuZiSMw88TOEdl/VyBNHAOe9pW3Pe0hjVKeI3xz1JiEOZwLGm/1dcXKJB5SGswMJbTglTUHwcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v35nkFf5jjR/pcRTmtSmuECz60GsBvSDAXYnLzmngF8=;
 b=J1O1syOb2XddTxceu+npRqnhyEfbfPa4h9+p+Zg2kJIytWL2CYN7RKGxeWb9p46yLw/GovnOW3a4kJZyF8PbYVbjoLRPCbc3kbr4vMD6XV2dnu12XHFDijlzzbpJ3AVqoMgBYV+sjyCMj+cGv/9p0SWZHQQgYSnnzs1D3VhWrNRo9RkvgXOH8wfW2aeX4up6g8uZjDuPMLEWjdzvEyaMijVo9Twznv3KT+fkOyXGwKBqQqt854cYa2tcBzpG24TQpLFnKbL8lUwycR3LkTUg7+JXKO0n0+JdkFM6q0jmglqCXb5hxvUTCQT8fnUJ5mlMbUn56UYbomxp8GxDcBnkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v35nkFf5jjR/pcRTmtSmuECz60GsBvSDAXYnLzmngF8=;
 b=fhRZlWCeRD63ZDghrYlrVEyogElOHJGVXpuxG+CUb+wH57Wjobn2g60Iht+Ej6/BmTZk+NFhPm0jZmo2kgjSmiB+fM/wzeQ24yLygXn2pH1GYwRwghuXseWLSdxj+4bHgrwjEhoXcJoyPIlEJ8HD2fIc5fuWPQDCYo0+YD9zW2g=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5453.eurprd05.prod.outlook.com (20.177.200.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 14:12:51 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9%4]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 14:12:51 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jamie Lentin <jm@lentin.co.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 1/2] power: reset: gpio-poweroff: add force mode
Thread-Topic: [PATCH v2 1/2] power: reset: gpio-poweroff: add force mode
Thread-Index: AQHVd5klCjuumUro80SnJBlK9gDhKw==
Date:   Mon, 30 Sep 2019 14:12:51 +0000
Message-ID: <20190930141244.12311-2-oleksandr.suvorov@toradex.com>
References: <20190930141244.12311-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190930141244.12311-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::24) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 551231ca-af36-4309-c452-08d745b04765
x-ms-traffictypediagnostic: VI1PR05MB5453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5453D5BDFD8A441844DF27E9F9820@VI1PR05MB5453.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(189003)(199004)(4326008)(66066001)(66556008)(66946007)(66476007)(64756008)(66446008)(2501003)(305945005)(71200400001)(6916009)(71190400001)(7736002)(256004)(36756003)(99286004)(1076003)(2351001)(102836004)(6512007)(3846002)(6116002)(8676002)(2906002)(50226002)(25786009)(11346002)(76176011)(81166006)(52116002)(5640700003)(8936002)(486006)(6506007)(26005)(54906003)(316002)(478600001)(6486002)(14454004)(476003)(44832011)(5660300002)(86362001)(186003)(2616005)(6436002)(386003)(446003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5453;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJDLWWDblDhiJA+zkiSu61HSy/RoU4arASAGoLQ1fuLHmbDLlswH1f/SzeVEC81R8R/0lns26ISMNH4XZi21pYl71q39vpT1u+h0pHfkSSzmK7TYzleJiAuS/5d6xydoKEjFYts3KhG6KIRizSsrGRlgucsqftAN7i2NdXURz2/eT+juttwU3bCmE/cKaOwWRU1DqEIJSOpwR2lxgttD37phnvv9lEEv/s5YMjDc21CRNQmIILzFL4MFkHxkTVTyWStVO4XQsxn2DM555sAhHw+tlzxuTj79FjutMlbWGu9tJ68I+sjw8U3DD9k6DQbZcUA24hEdXFlAp97gkjEhpmFOuybWjNUVkgEH+yGNQyW0PW1dIL7O09MM+iEl3MyZRLk+riOTfNYaBL6XxSQVzeBCngwpWXwx0jT10KiEj4M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551231ca-af36-4309-c452-08d745b04765
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 14:12:51.2355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEXsFD1ZmHMzsXD5gn7vhpnca2taT6W1AGzYDeAdDgjX9qizE3y0e5IpZpGSlA2GeGdYhh9gE/6HbiQXVpzfp7rTh9+jisoWUYe+/CtHOBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5453
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Property "force-mode" tells the driver to replace previously
initialized power-off kernel hook and allows gpio-poweroff to
probe and operate successfully in any case.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2:
Call next pm_power_off handler if the current one
fails to power system off.

 drivers/power/reset/gpio-poweroff.c | 34 ++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio=
-poweroff.c
index 6a4bbb506551..94056af9ba0d 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -24,6 +24,7 @@ static struct gpio_desc *reset_gpio;
 static u32 timeout =3D DEFAULT_TIMEOUT_MS;
 static u32 active_delay =3D 100;
 static u32 inactive_delay =3D 100;
+static void (*next_pm_power_off)(void);
=20
 static void gpio_poweroff_do_poweroff(void)
 {
@@ -43,20 +44,41 @@ static void gpio_poweroff_do_poweroff(void)
 	/* give it some time */
 	mdelay(timeout);
=20
+	/*
+	 * The kernel should not reach this code. If it does, fall back to
+	 * the next registered power off method.
+	 */
+	if (next_pm_power_off)
+		next_pm_power_off();
+
 	WARN_ON(1);
 }
=20
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
+			next_pm_power_off =3D pm_power_off;
+		} else {
+			dev_err(&pdev->dev,
+				"%s: pm_power_off function already registered",
+				__func__);
+			return -EBUSY;
+		}
 	}
=20
 	input =3D device_property_read_bool(&pdev->dev, "input");
@@ -81,7 +103,7 @@ static int gpio_poweroff_probe(struct platform_device *p=
dev)
 static int gpio_poweroff_remove(struct platform_device *pdev)
 {
 	if (pm_power_off =3D=3D &gpio_poweroff_do_poweroff)
-		pm_power_off =3D NULL;
+		pm_power_off =3D next_pm_power_off;
=20
 	return 0;
 }
--=20
2.20.1

