Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDAFC22E8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfI3OMy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:12:54 -0400
Received: from mail-eopbgr150100.outbound.protection.outlook.com ([40.107.15.100]:55622
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731549AbfI3OMx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 10:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKsxaKq9T6fKRi5HeWAn5oG5g2JsTmE8/v6RQ9ogy0qUxU7n7G3ZyhUhMvxpehe4PSKFka1/M0Qw6hmYUcpkfYldg328G7qW7tcGCEJrqkd4NTpHZDhpifjHJswXde/OYI3n4RhjeGtBgTiXnBXuWFDgeNh1zqKRd2h31mNAAB+wO5nsCEMgs904VIMXhzn2dYcTOV4n12ZsjdmALJsoTVqcY/f+cuHSLPpZ20DeQWCLyjetMGwNyssJs+go30K4y/ul+s/0zA+gv+F9O2N9CJcuatRz48CQBM3h/AQRkpGDVAK83980si/4C6bFmdqGj/ecdbJncwt4kTVcewFxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdtHPGNui0akt29I+xUOdLi46oAzfIr2lMf9SvGRL4Q=;
 b=MibakMkG+6zWq//xBal6YTAUpNwY0dnHYQwL6hpivDkp9XANuBGD9k4/mNA9xNtguky8bH+v/rQu0Ux3LqT4EUoZq7kMyIjpZcN3sRWV2/6mEcc8jFHIX1NwD4jgb6/wo9o5UhUfDXSwmDc6WzqISYJs39lknrnoyilfIFrDNzhDy/4Wvi0p41DUo+DRDcPNPgDKkrz6Pt7NLFa7NOAO9Ev78A9ptCzSFiRM60VMNRPzNmxeTKiQxrBusZLrOXAdtsJQqDnHfTXcsiZ4xNTax4vh7yRWrNRMYoHux1iwoasyqfjk53ZGR5IZF79nD6z5u4L+Ws2PLS0/7Ik3iLsMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdtHPGNui0akt29I+xUOdLi46oAzfIr2lMf9SvGRL4Q=;
 b=pZocJZzkCYomniJ1KP0VkcSa/8xQqImvr+pgDCf3VJdW4LwLmsuTgoHLhPI6RIiezJC8PHPQWXP2fj8ijGdt36LLeZlWjA8JRKx2G3mmUr6M6m6+Clus3sI10QNPzCanYS6GLVReyeyfnbMv72sOKFsC2mycfrWnEYe5J3jS4WA=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5487.eurprd05.prod.outlook.com (20.177.63.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 14:12:49 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9%4]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 14:12:49 +0000
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
Subject: [PATCH v2 0/2] 'force-mode' for gpio-poweroff driver
Thread-Topic: [PATCH v2 0/2] 'force-mode' for gpio-poweroff driver
Thread-Index: AQHVd5kj1D/eGcvdoESk1xC4kZu/RA==
Date:   Mon, 30 Sep 2019 14:12:49 +0000
Message-ID: <20190930141244.12311-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0141.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::33) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa3f5e94-a723-435c-aeda-08d745b0462c
x-ms-traffictypediagnostic: VI1PR05MB5487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB54871BF507EE8497CDBB982CF9820@VI1PR05MB5487.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(39840400004)(376002)(189003)(199004)(6506007)(186003)(316002)(386003)(26005)(66476007)(66556008)(305945005)(64756008)(2616005)(44832011)(476003)(486006)(25786009)(102836004)(5640700003)(2351001)(66066001)(66446008)(6436002)(6486002)(256004)(5660300002)(6916009)(54906003)(7736002)(71200400001)(71190400001)(36756003)(66946007)(1076003)(4326008)(86362001)(6512007)(4744005)(8936002)(50226002)(14454004)(81166006)(81156014)(3846002)(6116002)(8676002)(478600001)(99286004)(2501003)(2906002)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5487;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sn/yblA8fjQ5rlM4Mqr7vshrwqECj/04DsVqU0/lUiNBMXrlHzmrWyUaLOed/XO4SsTWw86jk4DqQnqqB6MfzW/+u3zFfyh5k6Ev/i08tmNWcmPbFMEA93Fulqs8adi7Zu52WdckArXcIK29JsiiKwCfwEt3a+6Cl+JEEeLQLdWBcQT0WjYL2IBZUB/vs/78AVPE8AvD+eUw2v2YP9c9e/uo308V7cMt6dNt0NLditAEaSgDB/CJozvQSKxlWS27/qE59/BXO0AApiNX98j0dWmkoZSHsn7sIa8xOuO5sCls1f3SCm4y4fswAyDP8OKu0i+70peVBNJtabnvFVmQgiBWFzmKaz/OfyVgylMM08d6x5XVBreCwmsJniXlIIq76s9aXCjSD62phEQrti2VShT0siqEJAnpqvnDiuQ3+oI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3f5e94-a723-435c-aeda-08d745b0462c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 14:12:49.1997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pV5sruqmNZQey8VPaGKmZMXZMtaOnByiyBJFkV+OcdQIYK3olm6jYqFe6Z5q3t4L3Q8rmV63qh/z8xjMunl31Iil2Tl7jRmWaC8YOwII9og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5487
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch introduces a feature to force gpio-poweroff module
to register its own pm_power_off handler even if someone has registered
this handler earlier.
Useful to change a way to power off the system using DT files.

Changes in v2:
Call next pm_power_off handler if the current one
fails to power system off.

Oleksandr Suvorov (2):
  power: reset: gpio-poweroff: add force mode
  dt-bindings: power: reset: gpio-poweroff: Add 'force-mode' property

 .../bindings/power/reset/gpio-poweroff.txt    |  3 ++
 drivers/power/reset/gpio-poweroff.c           | 34 +++++++++++++++----
 2 files changed, 31 insertions(+), 6 deletions(-)

--=20
2.20.1

