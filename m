Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB91114270
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfLEOTH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:19:07 -0500
Received: from mail-eopbgr690101.outbound.protection.outlook.com ([40.107.69.101]:9088
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729236AbfLEOTH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 09:19:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT2PIgxm1tbQ9+4OspSO5TLs7P3ijJsdOcqAW3RrliyF7B6qMUWZzW+B2uvZXEL+ggvwKvTdMVvh/4J+TovRdDAe1gxbPuQucFML6gveJFz5z3nrk1Fo9y4jFn8P+dJG4aEEp22cCaur8P+o3q6MdJlo2FxMwnaz3b87Og7QNuxVheK0wpQ4lo2j2SdAGTaM6M5oF9Akp7Scjhjfocjwzg90ouP4kW6/WNZ4NwQJOVS1sT7uzmy76M9x0V4mwYtXNo/GanzDSWKKKlOq3k6D1WrkBBw8QTrk4VBAOoanbNkfJbNWU/ORB2517qAws6GV79YnAN3ADYIJYrYN3QG9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1PmQoulrMEzgf6VlyhxDDkzeSRQY96AMoY0aXYOSLs=;
 b=QRIyxaVAtjUuFJWLYstGElkEthn5MmIXitNpzJwECbMPDULzrwIRhUdfGLixjwGWfTehTi9IPS+JR+LIHafZ8ctx3XmdVtRub3kqQV37FW1flhrrI15oGXDOCxquJ8ZglkNTzM9EFrGCs7IZFT1n1++oo554uV1boxAQ1PDPlahR4CKHgF5zAYda3qlMS9y/fwNErxp4eLAUw/Ls/yfkV1bkZLDS+cL9yOWuPljd1d3OJveEvdMpIe53xjUMz1FvzZDUY/3iZMeOMiUghqGlEQcE63U08Tbh6kKHYSAGRxuSZwtK6XQsjGJK+Yl5webvZXjQgp7oRavF0/KeRJmXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1PmQoulrMEzgf6VlyhxDDkzeSRQY96AMoY0aXYOSLs=;
 b=U2YfZbfuxKNnV4in0q0DPMuGjL6WzA9x3mfKpl05eCe5X3zOVRejubPYO0jS+TO9fFUvwqZcC7DqQtzoQ8q5fD63IV27Vl69Zl2GFPMcOCtDMY8qquxSxgsQ0J15AZdfDwMz3yJKxZszZLqHNMZ0wzYQd5mC79OJk58QGRVgHz4=
Received: from BN8PR10MB3379.namprd10.prod.outlook.com (20.179.140.29) by
 BN8PR10MB3378.namprd10.prod.outlook.com (20.179.138.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 14:19:04 +0000
Received: from BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84]) by BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 14:19:04 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Zak Hays <zak.hays@lexmark.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] thermal: armada: fix register offsets for AXP
Thread-Topic: [PATCH v2 1/2] thermal: armada: fix register offsets for AXP
Thread-Index: AQHVqtv7mxwVHsmesUi/W4BU64aP7qeqa2w8
Date:   Thu, 5 Dec 2019 14:19:04 +0000
Message-ID: <BN8PR10MB3379A954079A4ECF574E80DE8C5D0@BN8PR10MB3379.namprd10.prod.outlook.com>
References: <1575485367-18262-1-git-send-email-zhays@lexmark.com>
In-Reply-To: <1575485367-18262-1-git-send-email-zhays@lexmark.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1632d4f-2fe7-42c0-82c7-08d7798e1528
x-ms-traffictypediagnostic: BN8PR10MB3378:|BN8PR10MB3378:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR10MB3378E063CCF2C2A76B7179E18C5C0@BN8PR10MB3378.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(199004)(189003)(14444005)(66946007)(11346002)(6200100001)(64756008)(2906002)(71190400001)(71200400001)(86362001)(4326008)(14454004)(305945005)(66446008)(478600001)(8676002)(66476007)(6862004)(44832011)(81156014)(81166006)(8936002)(66556008)(74316002)(9686003)(54906003)(33656002)(316002)(26005)(55016002)(76116006)(6506007)(7696005)(76176011)(52536014)(99286004)(4744005)(25786009)(5660300002)(102836004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR10MB3378;H:BN8PR10MB3379.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XK++7kIOZoWmfs11XXU/cAzz3lVLRZhkPPvs5RjOojZnoqkui0bFcy5LJTtRy7nmA345kFGxcItT8Y50H5lfXeyleNWm69LkwzJbxNhlAjbSHgUxH/3SMW1QvywVR5/5VSkEJAO3wTbdwCmpdvTbre61+QTzENwNyZc0VQ9czcfXEByfIB0cDccqlU/dFzkr+BIAiv6V+SFGOLSf7foxrnGpVmyaytt/cJBFDAene6cnkQUW1+UOgz7u98iQmYEPUQMA/oJR4pKPFLBL6st1DUoDpoiuomA7GsUE4yLr1CtA93QgHXYm1ZlbRJlf5Q7v+kYjdvVtTCKdoXFh9Bl3KZO9ix+tEj1ZwOxS5fILlS+ZEnj25DHerfXl9ylGJcslyXW0SYuf/1QUgQ7gZ9TdyDEJnyEDTdI+Rv6AUpKDLMRTI0n64Kv7eCogSs1YBfv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1632d4f-2fe7-42c0-82c7-08d7798e1528
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 14:19:04.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIEZhw0qdO8sgbwO6Awu1SfwingJ6Bs6IZ+UoJ44ZvOGLbZIXOzZ5c1m8BpKdMx5EwVbRTj0wiP1PnR8Zy1R7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3378
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As shown in its device tree, Armada XP has the control1 register at=0A=
0x184d0, not 0x182d0.=0A=
=0A=
Signed-off-by: Zachary Hays <zhays@lexmark.com>=0A=
---=0A=
v2: update commit title and add "Signed-off-by"=0A=
---=0A=
 drivers/thermal/armada_thermal.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_ther=
mal.c=0A=
index 709a22f455e9..88363812033c 100644=0A=
--- a/drivers/thermal/armada_thermal.c=0A=
+++ b/drivers/thermal/armada_thermal.c=0A=
@@ -578,7 +578,7 @@ static const struct armada_thermal_data armadaxp_data =
=3D {=0A=
        .coef_m =3D 10000000ULL,=0A=
        .coef_div =3D 13825,=0A=
        .syscon_status_off =3D 0xb0,=0A=
-       .syscon_control1_off =3D 0xd0,=0A=
+       .syscon_control1_off =3D 0x2d0,=0A=
 };=0A=
=0A=
 static const struct armada_thermal_data armada370_data =3D {=0A=
--=0A=
2.7.4=
