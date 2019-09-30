Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3698EC1EF7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 12:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfI3Kfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 06:35:41 -0400
Received: from mail-eopbgr150139.outbound.protection.outlook.com ([40.107.15.139]:15623
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbfI3Kfl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 06:35:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMptUMCzIcPYcm2NnTjuz6S00o5qFnE0rI9+s2NX8daVwidclVWZpveIR6l5skAfM7oyYUHdHIOdjen+ea6IwKOC3D3Sajj3RJaDk2vRCSgsE+w6qCo1rCkVan7WT2LuF9W10AfiFHjI/+HExPgkN1VvtHqJEC9rZNtl3FvbXzf8vaIlKkzyTu/LtkxllyrBs4e+ilSva9NZR9BkPJUUjAOkwc62q+WrbiYOwPIDj9VT47CzJFuOOJnSnQ3+ksB0KE2JClzh9kI9gu5EVj8Vf4Oei2c14ar7YDTITnPtRHhosUw861wdM0IH6R49KJUTNVg1iMra/Ih1+G/Cn0bHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgutrwg6521FAVIMnNcAPpiMdXc1+P6ZP2osWWC9rfs=;
 b=mHAer7QvUn+u9N2liF+2XR5+ZXLUSVOPSw8UMrDisTtwhrTjtByITnzjUNtV6IiJult98E6HAf2jqMjv6wrHmT1Q7a1qYDvb5Egr0zHTKLmVEoP7jPjouqu6TfOuUmR6+kWkr2MqT/0zNPZR/njsjp/GTIK1n0rmEHg2Vwv+VKJbtBfmU2L7PhOOM6RMAQyq8ut9xkLWXdpY/BJdjGjSsAhOXeYrs68mCSTjj+iOD6E2RPsUp+0SryLRFaqxAHayZz/ZrNACy3YiP7pO7EDYgbUZ6xngHofXftxBlgsb3TUj8D5cRjwTo8cDL3ZHZTUO1SOhYNh3GivK6oXSzi9rzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgutrwg6521FAVIMnNcAPpiMdXc1+P6ZP2osWWC9rfs=;
 b=I7higLWTlaTSbCec23Kb99tIhg9nYm5AgogZlLrpYa67aBnVvHqJJbop1WghMgUp7DY+MK1gDhN7J+x/LSc8XaCCsfqZxCnkBmUlowwI39r5wkoaei2gbSmNg9xKQMaBFiT2WmuZoRlP6Ig2x/TxoqYWIxdvxI2e0r7aM53wMGw=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5869.eurprd05.prod.outlook.com (20.178.125.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Mon, 30 Sep 2019 10:35:36 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9%4]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 10:35:36 +0000
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
Subject: [PATCH 0/2] This patch introduces a feature to force gpio-poweroff
 module
Thread-Topic: [PATCH 0/2] This patch introduces a feature to force
 gpio-poweroff module
Thread-Index: AQHVd3rLAHQrXJaKQkmXW+yh5sbf2w==
Date:   Mon, 30 Sep 2019 10:35:36 +0000
Message-ID: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0212.eurprd08.prod.outlook.com
 (2603:10a6:802:15::21) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8be5aef6-8431-43d6-0fbe-08d74591ee17
x-ms-traffictypediagnostic: VI1PR05MB5869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB58692DF5F52B47CA06BA77E0F9820@VI1PR05MB5869.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39840400004)(396003)(366004)(346002)(199004)(189003)(25786009)(6486002)(4326008)(66556008)(66476007)(66446008)(64756008)(66946007)(6512007)(36756003)(81156014)(8936002)(26005)(186003)(50226002)(6436002)(81166006)(8676002)(86362001)(2501003)(5640700003)(14454004)(6506007)(386003)(478600001)(7736002)(44832011)(102836004)(54906003)(486006)(316002)(3846002)(6916009)(2616005)(476003)(256004)(2906002)(66066001)(71200400001)(5660300002)(99286004)(4744005)(1076003)(52116002)(2351001)(6116002)(71190400001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5869;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wy2W1JhspK2cqtyk3O+2bJBYMflLrm8gxd7wciRG3ylcTRmPZPbiTCq5GGneXkKeHBijgfXobKLP8xSXMHZf+EDBOzr46MBUHMvwVcPrHiuR5veyrP2wBUQG4genVbjbgJIHpEVhOk5m7FHLb8WeKAL0jQ7PyodgrhKazBlyDyzXaDsf4Na+ujGC8lf+P6C05T8lRviF/97dXln1fi+sDDf8iwVk7Hgmo6gAl+2FJmvEZvsW6jymZKxt/1Bn8MH0wqDYKkzX9Vh3ByWfaETHSryA0aZAdX5xZNux6huYP1pPluAGJEjeaBnGBi1NvMnZWiHBwv3sDw9GvtUFC5cfTKFz7b2qXVXiMFIiE9PxzlHcPBGaXc10z1URkqf0sYSvc2prGx+wdaF0ybxZN7MGqvZ7mf5l9EMs21QeJTVpjxc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be5aef6-8431-43d6-0fbe-08d74591ee17
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 10:35:36.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0/b5NalGB5M1e2fOzPkBP7IdMNe864aCvi0qhAcNoKoLywvixhlg6kYmRN7CQoRo412KUWV3Oh0C0WOtEH8ht87uu4p3zeATJHPVA+O/Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5869
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

to register its own pm_power_off handler even if someone has registered
this handler earlier.
Useful to change a way to power off the system using DT files.


Oleksandr Suvorov (2):
  power: reset: gpio-poweroff: add force mode
  dt-bindings: power: reset: gpio-poweroff: Add 'force-mode' property

 .../bindings/power/reset/gpio-poweroff.txt    |  3 +++
 drivers/power/reset/gpio-poweroff.c           | 27 ++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

--=20
2.20.1

