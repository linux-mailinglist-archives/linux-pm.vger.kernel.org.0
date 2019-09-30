Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67978C1EFB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 12:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfI3Kfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 06:35:47 -0400
Received: from mail-eopbgr150139.outbound.protection.outlook.com ([40.107.15.139]:15623
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730758AbfI3Kfq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 06:35:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK2WP45HphI6XFR3Vk2uKC9q52zSzF+UesFNIniqD+l6tIqEMcu52uEB1pnPfAf66+hDZWowQOyCtKGec0y2OS9SHu0LsRYqN/BU+0mNZXzonHIRBHNus3XV1pv7L8erBjK5u8ZdYRC3tB1QfNGL0V6ki7u8yHqtW8LPqYZ/PvBevFvsqji818PC4P6vRckcGv35olJIUN9HA/2+SndrMGZFRnUS98t9T7IiqOtKps5TRxkQkScLkubhmF4yUcVl9F0MV9gYDre1E6fB+kX41bj4+gxenjAkW1oBiELPtiGlf+r8CTCwi5hzJAr6RRdIZkCxWxC5ubwAXaFDCVwhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laBTgwff35eTVehETztbvmD5kzoeZqXKxpdNcFr9kV0=;
 b=RjtUTkpsO4ovGNa9xted/Kfw/qnSlgUiETq/7pvTiSmz9Xj5uo9wBTxyWEvjHTd6OpjB1XcLP952ssn1SyVpmNPkWFvCeLT4IgL+e1XgHHfAJcZTyX8f4t9XywpG90CimSwA+IEKcww2YtPhumZiyuIEfPTJ2xYkbN38RnpKgHP7E8EJRcAYfRjFli0IBlUrLgv3jV7t3s95Ht6OUmznurt6KdAE7vD3rWKnFYkDDjvJCSdt4WH7Lw4vHskgKTFnSjV9bwKI2B6UkETZ0Ri6D6Lk7xMHW/jWya4Nz7lhqseQF2JP+X+U3jExFzwlSe0NFVlcDSLsEgVwxGaaFYN2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laBTgwff35eTVehETztbvmD5kzoeZqXKxpdNcFr9kV0=;
 b=jJ6ybMrik/B3IHVd48mCpm7lrUqBmYecyqVK5kHYWTn5rBMDqH9pCoWb6VdeffGuENPdGkDbA2e4+5U04O6IKPqOUPHLLFVRH1RtEtnZadusG72h2ud8qJP2yPLajvoWKFmam/IcfMfayhYcYNvGXUb07XPBvA7JWMmTHE75RvQ=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5869.eurprd05.prod.outlook.com (20.178.125.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 10:35:40 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9%4]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 10:35:40 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jamie Lentin <jm@lentin.co.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] dt-bindings: power: reset: gpio-poweroff: Add
 'force-mode' property
Thread-Topic: [PATCH 2/2] dt-bindings: power: reset: gpio-poweroff: Add
 'force-mode' property
Thread-Index: AQHVd3rNRNdBZKbn8UmpJVv1G8lxdg==
Date:   Mon, 30 Sep 2019 10:35:39 +0000
Message-ID: <20190930103531.13764-3-oleksandr.suvorov@toradex.com>
References: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0243.eurprd07.prod.outlook.com
 (2603:10a6:802:58::46) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aa8d98c-7f38-49bd-c3a8-08d74591f029
x-ms-traffictypediagnostic: VI1PR05MB5869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB586975DE87BFC983A861EA5CF9820@VI1PR05MB5869.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39840400004)(396003)(366004)(346002)(199004)(189003)(25786009)(6486002)(4326008)(66556008)(76176011)(66476007)(66446008)(64756008)(66946007)(6512007)(36756003)(81156014)(8936002)(26005)(186003)(50226002)(6436002)(81166006)(8676002)(86362001)(2501003)(5640700003)(14454004)(6506007)(386003)(478600001)(7736002)(44832011)(102836004)(54906003)(486006)(316002)(3846002)(6916009)(2616005)(476003)(256004)(2906002)(446003)(66066001)(71200400001)(5660300002)(11346002)(99286004)(4744005)(1076003)(52116002)(2351001)(6116002)(71190400001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5869;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLLDLtXuD3t0ThxDTBwjzrP7e/DHs4LdIix6DdT7LaxbQSUG+NTkAEd/oLXUtQYZ2ixC/Hz3BaVUCKBC3O2+MKHXImipnoNuXyQrgUDQtK+dtGiLmZshTXORCJhtroRTmcedo8bfSUJcgOd5I5iB4voR0XQtGAQcsIZ7D/6YlKdvh6/5fNAeWrs4KY7cPSKTNJUQJkjB1mrvjduU7fGMdrkxx2N77JDVic7wMyiphEqZfg6G4OJi0vuQz9PtJ2hW+gSO7xo+hYjuH4hyDD1Ajl2h4MfwcUXtnRIdm4pCFGbxm9pkwaFNr2avtwOZZKe/Xjkgu/G52EXma/wiwFE9BqWm3FWmTJ9C97gz/JC+Y44b94VYoqk02c+68/jIZEWx505/ZNV5iHf1IJ+/hsFh0Q7Wbkv8ox8f9K5m8e1MQTw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8d98c-7f38-49bd-c3a8-08d74591f029
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 10:35:39.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/i1flB+aSFU2j9OQ25o3kjoyBiuwyjtwJesknfDqd5vxOZGi7OusO4jf/W/HzSsvaC/Uxdo9HEtO4AL+4758c8iQrjMJQsyXtDABkGlnNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5869
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add 'force-mode' property to allow the driver to load even if
someone has registered the pm_power_off hook earlier.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

 .../devicetree/bindings/power/reset/gpio-poweroff.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.tx=
t b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
index 3e56c1b34a4c..2056e299a472 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
@@ -31,6 +31,9 @@ Optional properties:
 - inactive-delay-ms: Delay (default 100) to wait after driving gpio inacti=
ve
 - timeout-ms: Time to wait before asserting a WARN_ON(1). If nothing is
               specified, 3000 ms is used.
+- force-mode: Force replacing pm_power_off kernel hook.
+  If this optional property is not specified, the driver will fail to
+  load if someone has registered the pm_power_off hook earlier.
=20
 Examples:
=20
--=20
2.20.1

