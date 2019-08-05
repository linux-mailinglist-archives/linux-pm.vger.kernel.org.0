Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69134812AE
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfHEHCW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:02:22 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:24887
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfHEHCV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 03:02:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf4x0ev0pUzivTO/fsgkgWnqZlbBGwT/1HK7BaL/XbQhMynoDl4UVU7vxniBDsITRBjWZiXUgJTV6hkCVt+pnBtpJkwib8QTOQjJGFKqz2BPVIhIbYIFQ5Bc3Mwa1dALxC1kGXlVY3YfudSwswvYvuBjfQgUQOJqKr8jXnbvyauN1+Coi37OjRlxgKxfT6CPzryZYZ4Remi28jYsSZpYZk0zdsscPF4IOCr4P5S4lOGOSmu7DANNZ6icLGgAiXL0TdPA3lpyvyFxoBiZPlpVM0lVsCNa2GEYGBFNf18aydEyGuD9jyoDedKof4LTdSW8yTJL/HvGUfOhDWokEsi0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FasgfijNPfOcYE2Jn0q6IRo98EgSZLH4r/M6N/zpwh4=;
 b=POHIqPCiOrbyqRsPPZF/J0lH+4bUNX3BlErJeo54XkDxOEOhE4BISgpK9BY5/S1ZQfg0LGQRJhnLP+y39u7tQlq4PkNtzpZ+UvHGLk9qZ/U5tu5J2J6v/iRBd+h0O9dNHWezIxEG3Uptu3gm51KTlPdKq0a4Btl6O2pXVk24/pUpVk6OveB0WRk0fGhFQgvyY14io1Y2ZJQ2yA7u7l/1j+jsUvXfCBm4pe3153nWrSee8r7eWYHe5DfRuxxO4VX9C9epEKI1R8kTpl6mA5fFRCwCAHV3bH1fB/rveSHJunv8JIdV3tjmNrNTbd48388QoQVWodWhZrHof2KupcvXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FasgfijNPfOcYE2Jn0q6IRo98EgSZLH4r/M6N/zpwh4=;
 b=fPhEJup2lUUcP62SsGGvgoB81H67TBasQubSgyQxCgotM87SPAAQ8abnCEHau6+3ljIp7SOFaMm5REiCcpQP8rogcfYxFjc2hJZ7a0tpbtFndyf2Mux2WVD9GhAzpC81Sa6JkHUk15QYUbAF5ZOihHCEU8VtdeKUtbn2RzSGeGg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6947.eurprd04.prod.outlook.com (10.255.225.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.15; Mon, 5 Aug 2019 07:02:17 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe%5]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:02:17 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 4/5] thermal: qoriq: Use __maybe_unused instead of #if
 CONFIG_PM_SLEEP
Thread-Topic: [PATCH V3 4/5] thermal: qoriq: Use __maybe_unused instead of #if
 CONFIG_PM_SLEEP
Thread-Index: AQHVRn7VKNmIUzslPEOka6PhrPTWNabsKkwQ
Date:   Mon, 5 Aug 2019 07:02:17 +0000
Message-ID: <AM0PR04MB42111BCE0526BADF6F5755C680DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
 <20190730022126.17883-4-Anson.Huang@nxp.com>
In-Reply-To: <20190730022126.17883-4-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d424d208-5926-412b-f4e0-08d71972da84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6947;
x-ms-traffictypediagnostic: AM0PR04MB6947:
x-microsoft-antispam-prvs: <AM0PR04MB69471F743345EF4231C854AA80DA0@AM0PR04MB6947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(52536014)(7736002)(305945005)(316002)(14454004)(66476007)(2906002)(256004)(76116006)(8936002)(74316002)(66946007)(71190400001)(71200400001)(7696005)(64756008)(66446008)(102836004)(446003)(3846002)(558084003)(6506007)(11346002)(66556008)(26005)(2501003)(81166006)(81156014)(110136005)(86362001)(6116002)(6436002)(99286004)(76176011)(478600001)(9686003)(6246003)(44832011)(55016002)(229853002)(8676002)(66066001)(186003)(5660300002)(4326008)(25786009)(33656002)(53936002)(68736007)(476003)(486006)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6947;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vew3k39tO6+cF5M3EizeX92/y5Uxl/35hf65Jr7tC1G/isG9ywhRtAr4PVG1h826P+OWhIYjdVvD1J1ilSXsSHPdkKoGAi8zLtaoIOg2Jzo43kGZ7/Q1YUTdZBbIkKkuwMsF4/caohWzAGpSZMLLIbFHhfAEjOJZ26wI5hcmoKH9U+hrLcKunu7naiF0jHakumgStTm/P8AV9RX0KVC7e/xb1GDCW/pcokkDWY5Nhunqvk9O13zl82YTswBErkYVO6z9mTUInIIZT4wgOiKsF2ZDOCMBRUcrVlwF9o4uZxvW2Xp1V/KMKPNBCyZHwBDlQ2G10RzVJoAlpfvSCLmQc6DlpPo88wbRg8YBPt2+63MeWZFzJIiGKHmp1s4AfqR+n3x3bGBFk7GN/FxHs0ZBRvqEjnrye/RlJONDyXtLA1Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d424d208-5926-412b-f4e0-08d71972da84
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:02:17.8117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6947
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDE5IDEwOjIxIEFNDQo+IA0KPiBVc2UgX19tYXliZV91bnVz
ZWQgZm9yIHBvd2VyIG1hbmFnZW1lbnQgcmVsYXRlZCBmdW5jdGlvbnMgaW5zdGVhZCBvZiAjaWYN
Cj4gQ09ORklHX1BNX1NMRUVQIHRvIHNpbXBseSB0aGUgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogRG9u
ZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
