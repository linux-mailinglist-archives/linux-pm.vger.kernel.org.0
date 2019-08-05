Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43339812AC
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHEHBs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:01:48 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:60184
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfHEHBs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 03:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M50Hv1Tf1btIqEtX9Tw6A0zHnP8seEE2HgMe+KBTqLOieq6uQYIgwc48Lir+RMOhTyTPPvQ42RR8IBnuUyZ8kw9lSHSFLTmPO/XEM7bAFi7TA/8Ys/4HaVawho9ZwElHgzC/lw6qGn0GDfgR3cw1Gw1Ih8Z1wSQHe/GQf4fNtAXmixJi8hIvXipFCLe0asq5WqIq3ExCySzVfmqxHcabMfckNOghjvAo3rSyZzrCdQF6fLd9l+PnhOxcTsANJ30rYctEXLHHSmWRWuF1RTaP+gA3z8FNfps8Jhcw9IX7Rjb6nZhImxMsDpu//Ob5KIlTU9hdK7mZAEg6bzsf+iT6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o3cHJx0HoKwCi7DvPfluU9hXaCriVlrdGIMWhqQXn8=;
 b=UAS2cQW8LS69Bpl2V9iRiLrm75IVKiL9xq0nSjH9QA4WMjmcQ2ChdEdPHuyd3kPGH41uoD6mrUOfUsxIfVqSlpILJy+7DUK+uF42tnuDO04ZCappGSysLzbipHJAB7Myn/UdknzD2Yno9x/V3BPg2uti4jDPlHWus3OUNOjo7xT+jrC8/h64iEnapGJTUeM5hFPwSAOWNNy2o31LKlrLMmz0dwjvn+7XEz6UfKIhnayDN9rkPIh03yHDc7a44t+xE2kdLq5rMzhWWGpp/YrfetSeiOxyWMSMOmP5agsGRU6oEjRnS+mqGzMLyH7wa+FuljnTgfTVPGvaBzHG+hzKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o3cHJx0HoKwCi7DvPfluU9hXaCriVlrdGIMWhqQXn8=;
 b=Lcf/sWBTipHOTSq+Zhn5tNJ8b5UM02lfX1kVL/zaauD2keOr0w2i7IMhP8PWMZdahO0vZ4USQJjCda+ocCy0l2MR4p/Pssv4gGG+Tan574xtRvuvME8RGxLpmk75vmtUxN/G9OhfhZFxgk284q+pvXo6yIPCw6EEicpyTJq7yq4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6577.eurprd04.prod.outlook.com (20.179.255.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Mon, 5 Aug 2019 07:01:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5553:29b6:d66c:6afe%5]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:01:43 +0000
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
Subject: RE: [PATCH V3 3/5] thermal: qoriq: Use
 devm_platform_ioremap_resource() instead of of_iomap()
Thread-Topic: [PATCH V3 3/5] thermal: qoriq: Use
 devm_platform_ioremap_resource() instead of of_iomap()
Thread-Index: AQHVRn7UMzUWOu+yZk61/o6NBry8U6bsKitA
Date:   Mon, 5 Aug 2019 07:01:42 +0000
Message-ID: <AM0PR04MB42118D4ECDEDA63B6CCA4C4D80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
 <20190730022126.17883-3-Anson.Huang@nxp.com>
In-Reply-To: <20190730022126.17883-3-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b87af8a9-dcad-49c2-eec6-08d71972c5b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6577;
x-ms-traffictypediagnostic: AM0PR04MB6577:
x-microsoft-antispam-prvs: <AM0PR04MB6577A515576E77C4EBBE15B180DA0@AM0PR04MB6577.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(6436002)(76176011)(81156014)(11346002)(8676002)(478600001)(74316002)(476003)(7736002)(256004)(9686003)(14454004)(66066001)(2501003)(305945005)(55016002)(53936002)(8936002)(71190400001)(71200400001)(33656002)(44832011)(66556008)(66476007)(64756008)(66946007)(66446008)(52536014)(76116006)(81166006)(558084003)(229853002)(110136005)(25786009)(486006)(5660300002)(2906002)(316002)(99286004)(6246003)(2201001)(6506007)(86362001)(186003)(446003)(3846002)(6116002)(102836004)(7696005)(68736007)(4326008)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6577;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /BfbSeqQh635rE1USI1ovv6roOaB8fz/tKgEjkV+cQVjuXrxnBQBmQdInGFcZIVFEh0s+o+5iGfKpdO0qbTnnbSjEui86iHKelnkq8noCwUcxLOpIjFQq2Gk+gcJr4ywofvd3D5Gk8VrFuqXY4UNgzJzyHBz2/y/4PBY2jraskqoybz4yxiORFGJbiGaipSUQ9FYohrj/DnUPWL3GVX7S9C0hWqRqgV8v0WtalUoKuKdEWVCgfW+HrLzmIVFu5tHOCWUZXSsHYdiy0AtzZrR3gcGkJPPU/1xtwRdPbtoZiLQ5pbUUOKH3xV/uiKQpoPX7nQdqQttEnLM3VCy46wEJ9eatxOjDqy7tKenzq4k8XqflnoJnbm3PYctYZ0E6OkxFuHzh/+BZEeNIUH8h9dxv2WhH3DzFfBMhk55Pll5/Dw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87af8a9-dcad-49c2-eec6-08d71972c5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:01:42.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6577
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDE5IDEwOjIxIEFNDQo+IA0KPiBVc2UgZGV2bV9wbGF0Zm9y
bV9pb3JlbWFwX3Jlc291cmNlKCkgaW5zdGVhZCBvZiBvZl9pb21hcCgpIHRvIHNhdmUgdGhlDQo+
IGlvdW5tYXAoKSBjYWxsIGluIGVycm9yIGhhbmRsZSBwYXRoOw0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25n
IEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
