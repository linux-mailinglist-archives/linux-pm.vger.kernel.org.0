Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4EC22EB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfI3OM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:12:58 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:19599
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731568AbfI3OM4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 10:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD22pp6EZ/FKf9JK79A23buRyFnejZ9ZyY95jm7tylZdjoTvzN4huKCzr0GL4/2sNQLTSPzzO3xs2RiIARAx4znhwPQOuclYgjVo+16T5bgErlImzv4fi0LWEIJcnvwFFCv8L2dKJ62xJVBdr3ZdcGv5ObLhaWzR4YVJ+ghQ9MgBl4W7AioPJcNSGvXD2hp1iQvcONo0XIFAoR2SJ4N0QGvuz6/t6BqP4F8WqyQAjwq+rlHUyot2huQVHiGlFR/YKSnQQVP5fv+UyXtupeJ+PKZUR1Nk+aJE87QLT+wok+IcAs7379rghmYJt+i+atv6QpoRaHQq7bIlDamrCHW09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riiXxkyy6zJ60qHkPCwUN1/dr6dBAn1/gDEAS+Yk2L4=;
 b=axlFSczG/8nGmemKed0elbEqx0Zgu4q3jb5/RX7w7yuWeCogtnHocsApxsL/qtOpNEsJ3kb1y0dDyF0ytWg4qTaqrqiTpwUQfAjVXrlYjFif31s6CwQcYhRmXURUYMxefD8HstoK53Is0Oxxx8OR9dcNJQT7JrL50UMx7fjUEk4revkcg3Rc0h2gi9ygZkNyNUHW7Ay7Cz7flk0YOeFCzGB2UQ31cwAlylbdUXjUndeSVtC9W1faRPkE3MZxZ5JaOMO2Xn8IkTGaOrAe3YaqlLXPsH2E58bpwAIvlplibPao70AdSftKq+lgaHOecig9N52l28JgM2dqupnOL0N9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riiXxkyy6zJ60qHkPCwUN1/dr6dBAn1/gDEAS+Yk2L4=;
 b=qoV6PRmUsEIIPeNUkt/otWMP0OSNIyKS6Vfp9fR6a7yjMPwJ4JfS9z27SEBJE6cwQKj4YrjybYJFV8AiQEeQUiBhdsox/LUR0Hw2i7izk9T+UkWub5exn4L2u4UQkKap09OJ8r3jh2c57MjQSN52P7rCXPgP0kBUNMkk8ltUFBg=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5453.eurprd05.prod.outlook.com (20.177.200.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 14:12:53 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9%4]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 14:12:53 +0000
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
Subject: [PATCH v2 2/2] dt-bindings: power: reset: gpio-poweroff: Add
 'force-mode' property
Thread-Topic: [PATCH v2 2/2] dt-bindings: power: reset: gpio-poweroff: Add
 'force-mode' property
Thread-Index: AQHVd5kmNVbiGB9hFkiQV9KnDe2C0Q==
Date:   Mon, 30 Sep 2019 14:12:53 +0000
Message-ID: <20190930141244.12311-3-oleksandr.suvorov@toradex.com>
References: <20190930141244.12311-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190930141244.12311-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0042.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::30)
 To VI1PR05MB6544.eurprd05.prod.outlook.com (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92953926-543f-43e9-a218-08d745b04894
x-ms-traffictypediagnostic: VI1PR05MB5453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB545301E04DAE31D6E61D8125F9820@VI1PR05MB5453.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(189003)(199004)(4326008)(66066001)(66556008)(66946007)(66476007)(64756008)(66446008)(2501003)(305945005)(71200400001)(6916009)(71190400001)(7736002)(256004)(36756003)(99286004)(1076003)(2351001)(102836004)(6512007)(3846002)(6116002)(8676002)(2906002)(50226002)(25786009)(11346002)(76176011)(81166006)(52116002)(5640700003)(8936002)(486006)(6506007)(26005)(54906003)(316002)(478600001)(6486002)(14454004)(476003)(44832011)(5660300002)(86362001)(186003)(2616005)(6436002)(386003)(446003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5453;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gsYbjQuLe+TCZWQBlki9FFQ5vF70/Hzfb+35sKx2CXlrI2CBMvyHvym5NzIoW48fKccm3lV+BFJNiEU9kr3l7tgQJ3G66QSgb7qdQreZoU2614eHYq/5ckY8z55+aNXscWdgE7xXgxBTOqFUTPDhUGeLqQucFdgP8jhECZtZQLwjaVGFzXLN0z/MflXCIuRfr9PP5quOf+eCDoAkQCzZKDs0M7N9df0rRSxaXm2bNeaoV+PJIjS09nN16PVthy6ZO2KP+NgRHBwbn7lug0hta0vVUM++eAw+DTCccNta3emSCZZhkIgloX8idxs0QFiUVICf3OwbbbRplR8Ok+OTPUl4+5LwIPnw5W7THPr39yCikrNIggmk+BrmvL6/ItsQsVWh0Dhz+BKu+cZqKBHQPXesw2krRsBV6K4d8SZlmQg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92953926-543f-43e9-a218-08d745b04894
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 14:12:53.1964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L80AQiHKd6+czQa2YhRRzrPYntVQ4y/+Z9UrpjDzbfyIjO/hj1T1txcucYcUmPxWDx9Q/M+Jm/3XfTBT/yhRIsrxPoU4JR14RzCxS/RAMRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5453
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add 'force-mode' property to allow the driver to load even if
someone has registered the pm_power_off hook earlier.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

Changes in v2: None

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

