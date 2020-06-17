Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805241FC853
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgFQIKf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 04:10:35 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:1795
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgFQIKe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 04:10:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQqYiavcVihv22syNLTYUu7yUVo0ZldNq1yPvk/lo4Ry/kNI/R213EighC7c4CAvJQdasnaC2GaUWfKVIvTyoLQM1sqoneuRLjv4SwtMAMgMlHq/9vWC4RTkTuz8VpAL/QY1FXi7E4KMwbRKnIXqI6hwhXrboUDgdqbBNVWRBmpq4ZFFUZbk0H3rs/8OB4YrGappFMPOzIVmwWzyfQ0ORFN9uivpvrz0VxetNlon0Y1NqO9UYQCuaZUceuX+pFbRV2bZ7Uxt5MFLvy0Fc0dVtiBGwNOrjDScE9oV/ZgUGwnQhLMV6yck/iEzHExDwsmh/W3u19ZrEwGLpUntiP42yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN7uTV5DN6GfOP0/OfubOL/m3XHomGUATyz+N/JEVXU=;
 b=PZB3YNJ+F08A9gw1tQXggTNI2ct2Qk0ObK1XL15sjFRixzW5Q0DKLV6GEro8KD2F2/BkBVLDGjyhZmFoYZ1+HCzBJvk1Gn9bLvLWc19JVy4twlIJX7+GpHBbqX0Q24pgzakhR//aQX5ZQXuLUP9UgjHBawcdQB9TlN2EY1y1Q672FU4QAKGeqggp474ftasDYDaT35YvDIXYvJLOoJoN5SRdNtcyeGTjEC3U4zzSJVg8Y3bkrFDYFWe+u0E2XWuClAjtsJqv3r+ira1cs1XgCNMLPkiCED/YGbyvcL9Tq1inmQFx7M68iWG0MqHgh3bdtSYD+2RbJg7VBym02PM6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN7uTV5DN6GfOP0/OfubOL/m3XHomGUATyz+N/JEVXU=;
 b=Gu4OIJv4QUBTBo0BuKmGyhZ9KBEVBxU8RRuiifWbKaKQ+eUqxknFzIKTA1qnbB0NwJBPEmQcIKTUKH1NuEGPFGD3G2oavNjZ563MhW/NvCXScxMuMrZ4xPkffC4VDA/tmQ+F9GfU3g6ke2LFiZcuu0a5H0hjKzmANcYwGAhhfYo=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Wed, 17 Jun
 2020 08:10:31 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 08:10:31 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: imx8mm: Support module autoloading
Thread-Topic: [PATCH] thermal: imx8mm: Support module autoloading
Thread-Index: AQHWRH0soZuetWFEX0qtKLrE8EkPzajcdHIg
Date:   Wed, 17 Jun 2020 08:10:31 +0000
Message-ID: <AM6PR04MB4966A52D3920CE31669B266E809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1592380074-19222-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1592380074-19222-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6fe631d-034b-401e-48a4-08d81295e779
x-ms-traffictypediagnostic: AM6PR04MB6662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6662F5489204673749A6AFC1809A0@AM6PR04MB6662.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BnZqSZkOP7vATLMhPhRVApHJsfvGTQ1o0jO2o2RTyUAveqXIEDU1z/+68Zmle6Se8ZuxEQCkM+4l9AhW7y0FjeKSywjb4n+BxxraOC6AHg8prYaDETPb+d4iKomAeMQV7aMLCr17dpEkBeqRTcMUppUEuJHC0BRKVrz90E/29GE8xy3LwFqsck+GEfSwt4BUF8zZ7kgIOoAsXK4BNcM/f8sJPNLdYXM+6k57ySDY9mkbHvW0fJoIbkVWqzZtcEcfsvjs0JzVplSDO3/LMam5HoLgI0nPuowz/KeoGEcD29ejys3k+1pB0v2/Qv0/qI6ZTr0lGePeCCHC4HYyNnhk/rhvdQXNfKCN9b712Sh0C51dJQEmv4kO4T+4xiBcLSiAqO+mngE9SPZk1qKZY4C4Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(2906002)(478600001)(71200400001)(9686003)(55016002)(110136005)(8676002)(7696005)(6506007)(8936002)(26005)(316002)(186003)(4326008)(44832011)(33656002)(66556008)(64756008)(86362001)(66476007)(66446008)(66946007)(76116006)(7416002)(5660300002)(52536014)(558084003)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ciYk7ntEc6c0JrrnJVwOKKhvSwfzNvjzc+X7RRE150kp7qh9EWTUR9OEssPF+SlDK065PtbTF8F8hJjlYtUmWeJRoqePauzMks5PHDkwA3E+ouOZYawHialOaW1MEL8kJXt2yrcZ+KRCSe35c0+UzRZZLKLxUHHn88k/7C4T7hokTaXX9xCDoYsP1q1orQpYiqr5hkp2Oi6aNHUvtAN/Q5OiqigXa09zR51+3T7S82x2INYKGVbeO7O4aLoXe7xIfmz43p/prnGxDgyXLOgWyq8APP8dSk9HBS1x1l0to/bDhow4gJ/4UWtenQv4l7ckg73QKRFemsOkCpvhPpQDqvCTiZz6s8x0v+CyduukMGtSxjEVvGguI2jXCj7pNWHYRYlLs3aboDlXGt720gNlvyG3VjMnIIwqqFdsFD8KdOgMGFH84ynF+wLp/1J5FwqDct88I2XMoYGAWrSONfJdrvPiVCR7o75lQ+DtAUJRH2zomZG8DQhWPm4YQ8hB4WtV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fe631d-034b-401e-48a4-08d81295e779
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 08:10:31.4218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4+Es8LEyZRoiVMtlny7d5MVLZF1b1pnF0hf3JIcS/V7Biw1tsIyny8UBRW1t2jQh9IAkOHF/C3hvAWykFho7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6662
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdW5lIDE3LCAyMDIwIDM6NDggUE0NCj4gDQo+IEFkZCBhIG1pc3NpbmcgTU9EVUxFX0RF
VklDRV9UQUJMRSBlbnRyeSB0byBzdXBwb3J0IG1vZHVsZSBhdXRvbG9hZGluZy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KDQpSZXZpZXdl
ZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlz
aGVuZw0K
