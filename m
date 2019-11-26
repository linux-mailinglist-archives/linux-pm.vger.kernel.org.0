Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBF10A0BE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKZOx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 09:53:28 -0500
Received: from mail-eopbgr760103.outbound.protection.outlook.com ([40.107.76.103]:42888
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfKZOx2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Nov 2019 09:53:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsZ1G5GFowrNkECKxQV++ULROzHVRtyxT78kCl8s8DLdt+WS5akFK8w+6CI5lVb8GgmJAB8K+NA/8fLEtRpRXBYBy53soRH2BV2dv1yXB9g4PsAY7iqbLRRuPs79Yhiw9/vsPpYjyjUDT0rOWIUEmu9udC0PXmFtDpWLV7z8/wC6k5dK0GOCfKBmdlsENupNpvE2RYpC65W2zqncuv4j55lIskhc2aaVXEHHYA02jhoZftWRNVXAPqIe21LoDAZLfdaCmNKyQO5t2tZ/vCTI6ifr6+WpWYr1UV2j2xRrwzpSDOYTnsMUE8Cg3qXH8sLCnKjuCYQadFQhAD/hjShe4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/7iKUHmPJhqvYXlcTbsxv0a7URUhOY+4dWVhFYRAGI=;
 b=ipn9hnz7iUjUh6KfWm89XNprkhRE5SlC0pePFBDk0auSYw07bIfQjgjRDEcS85UKw3sk9Fo341h2dtCEGlvFzsAPpQatv5+0WzwPyZd+tWKHphChbcqVuovt0v3AV07WQB4ICyqCO5Bh3lh/BcdjzHLFM5WLHDtKAQhOd611iUnp3NFwr/vGz0bFKFxQFCMxH1hIX2te9JNCbqKbPOoJcTf65YPlpNbT8gl42v87HJD2N23s4qW+MoY0qLMMdzvKrgq/Brt2FOcdSNzUXQrL0DwlsLZ9Jpsaxn0pw+WQXijM9y3RWnnh+yrNYPCGNq8QhbhWCK9qAzPQk4L9Obr3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/7iKUHmPJhqvYXlcTbsxv0a7URUhOY+4dWVhFYRAGI=;
 b=fYM/7E4fmHW90JkA1xMg09sCV2PI1tMPEpUdop3KNwn90XT0LKbmD+8GTgjEa2+erFUVyaDXv188SmcKxpjPjzMNIfsLJQ2NHZv6HepqAVSYRn4qOBfOqypzQai6wCPpmPxg1kQ3zrQkY4WOjABQggK9wONFI3Ofb2aDeZJPiZ4=
Received: from MWHPR10MB1343.namprd10.prod.outlook.com (10.169.233.144) by
 MWHPR10MB1328.namprd10.prod.outlook.com (10.169.232.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 14:53:25 +0000
Received: from MWHPR10MB1343.namprd10.prod.outlook.com
 ([fe80::f806:6c17:ea13:b9e2]) by MWHPR10MB1343.namprd10.prod.outlook.com
 ([fe80::f806:6c17:ea13:b9e2%11]) with mapi id 15.20.2474.023; Tue, 26 Nov
 2019 14:53:24 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Zak Hays <zak.hays@lexmark.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] thermal: armada-thermal: fix register offsets for AXP
Thread-Topic: [PATCH 1/2] thermal: armada-thermal: fix register offsets for
 AXP
Thread-Index: AQHVo+iA/kMgO33t3k+uGX+0amwVlKedigab
Date:   Tue, 26 Nov 2019 14:53:24 +0000
Message-ID: <MWHPR10MB1343E9F9A2AE7FAC27DEDC758C450@MWHPR10MB1343.namprd10.prod.outlook.com>
References: <1574721077-29892-1-git-send-email-zhays@lexmark.com>
In-Reply-To: <1574721077-29892-1-git-send-email-zhays@lexmark.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9eb2263-c123-48b8-1af4-08d7728063a1
x-ms-traffictypediagnostic: MWHPR10MB1328:|MWHPR10MB1328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB13284D86F5A5A91AD1CF9D418C450@MWHPR10MB1328.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(199004)(189003)(305945005)(7736002)(4744005)(86362001)(186003)(2906002)(3846002)(6116002)(81166006)(74316002)(6200100001)(99286004)(6436002)(102836004)(14454004)(44832011)(25786009)(6506007)(81156014)(478600001)(8936002)(54906003)(52536014)(71190400001)(14444005)(26005)(256004)(316002)(5660300002)(8676002)(9686003)(76176011)(71200400001)(7696005)(11346002)(4326008)(6862004)(66066001)(446003)(66446008)(55016002)(76116006)(64756008)(66556008)(33656002)(66476007)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR10MB1328;H:MWHPR10MB1343.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /v7Ug79h2QvPmho8LqGlYdVhCZOX6s3QmQAXeJQa5JTiM4UWO4wtR5YsAhINIW4YQCWJDVOPMy9RuYNb0YNhVmmBZixYd/Mrfm4hK61GrFnNr6VqIk4qgriMHPr/YttDpXuyxYK6rClLU/otOJaMjZKfmzzEplmUY5GsvZjQbhAO81SeMFH7+ijutjnHnWi2tKh69lKdK6l1m9JX8FDdF70+lJumZh78rCXa9osHOFRjLWtNivvSZ3nE7FOAuhQaDU3W7c3P/kuq4Wsyv7beLhLQG4VVIJrpAbB4uJ1nH549270m9Ef0Adf33i9MuUQgRggVCnz35N0hxQaR6a4JMq9FgUAEfmzI3YDMWF7+SvExP6gPL48CVbrazSZSpgPVN+qGADLaTi+bbWLSeowdDChTPxlOKBcWaOR6oNt2/8yA4L1higZ7hFWKWxibSHEr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eb2263-c123-48b8-1af4-08d7728063a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 14:53:24.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSTyo4w+BQr/RrsHsvSDTYwbM1nyFW9sG8euFPsbthak+Mik/peLrSDAdSJPZQ4thB7OI8RMnd1ir4mcQxTCJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1328
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As shown in its device tree, Armada XP has the control1 register at=0A=
=0A=
0x184d0, not 0x182d0.=0A=
=0A=
---=0A=
=0A=
=A0drivers/thermal/armada_thermal.c | 2 +-=0A=
=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_ther=
mal.c=0A=
=0A=
index 709a22f455e9..88363812033c 100644=0A=
=0A=
--- a/drivers/thermal/armada_thermal.c=0A=
=0A=
+++ b/drivers/thermal/armada_thermal.c=0A=
=0A=
@@ -578,7 +578,7 @@ static const struct armada_thermal_data armadaxp_data =
=3D {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .coef_m =3D 10000000ULL,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .coef_div =3D 13825,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .syscon_status_off =3D 0xb0,=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 .syscon_control1_off =3D 0xd0,=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 .syscon_control1_off =3D 0x2d0,=0A=
=0A=
=A0};=0A=
=0A=
=A0=0A=
=0A=
=A0static const struct armada_thermal_data armada370_data =3D {=0A=
=0A=
-- =0A=
=0A=
2.7.4=0A=
=0A=
=0A=
=0A=
