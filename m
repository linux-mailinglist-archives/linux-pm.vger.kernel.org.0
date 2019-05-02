Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05D6124A8
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 00:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEBWoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 18:44:19 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:14403
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfEBWoT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 May 2019 18:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD44n0LNV7d+Q3win+lRE+QGq21+saaKfyFxzy1FYPM=;
 b=RhTzOtUUIUQlJk3lay/EtDZXQoHPqUo2tHAaW7IfejXngufyXVQBZPfZwjND1I51srprEYP4veUoazv28QoVBK4Irq0XIGRCNiWbJD+49i0OrYGiQ9r1J6fjhPDb/jhP+G2lNQyor/l4Lzx8/WPo6Vc8JPKirSYbvbwAqXi7W4I=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5315.eurprd04.prod.outlook.com (20.176.215.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 22:44:13 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 22:44:13 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3] cpufreq: Add imx-cpufreq-dt driver
Thread-Topic: [PATCH v2 0/3] cpufreq: Add imx-cpufreq-dt driver
Thread-Index: AQHVATiQtlzuIooEwkqEvC93VXXdZg==
Date:   Thu, 2 May 2019 22:44:12 +0000
Message-ID: <cover.1556836868.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: LO2P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::28) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a1d4126-e3b1-4954-e2c5-08d6cf4fb2b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5315;
x-ms-traffictypediagnostic: AM0PR04MB5315:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB5315D51E5C3A8C690B685C61EE340@AM0PR04MB5315.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(86362001)(6116002)(66446008)(66476007)(66946007)(6436002)(66556008)(71190400001)(73956011)(71200400001)(64756008)(52116002)(53936002)(14444005)(3846002)(36756003)(6306002)(256004)(5660300002)(2906002)(8676002)(26005)(44832011)(186003)(478600001)(4326008)(6506007)(305945005)(386003)(8936002)(316002)(476003)(6486002)(54906003)(6512007)(50226002)(99286004)(68736007)(81156014)(81166006)(486006)(110136005)(102836004)(14454004)(66066001)(966005)(25786009)(7736002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5315;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xIgPmS0vTTMKzV2G8UnXGu/NAZu23Vy9VeahLU9SezRVqjRflt+h7jGzvlaBLkqdTKFADk2P7ED8WOAGwi8qukSKsuQAlEwexX2ACA5WTP++A0j86o0miVAFwFA31yqrmdBBpOi+ZeZgUKv9FbkI/86OXpOEupPxyuzzEwgnPHAjdEU+Au0z64YWZas2kIPxqzQdXNNxAlaySLZ7c8DVU9ryDgADOQuB4iRJxQsy4S3I8iQUWmMN3BH4rEh3zQH3hWNi/rDQPk/rbLoYErkLYe01Wbw9Tk1pQdkhjLICG+czR+XzVyaEIZsvZeW7rYx47dVARNBEHZ/pTCBaVrMIvs4ykT4sJLXM36Q1oVX9PYFRVCWNdcXRcSJxE+nhCsHlYycb13fsgr2jkTE4prUDYabtZsqm6n9bSi4zuSPgrGo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1d4126-e3b1-4954-e2c5-08d6cf4fb2b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 22:44:12.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5315
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UmlnaHQgbm93IGluIHVwc3RyZWFtIGlteDhtIGNwdWZyZXEgc3VwcG9ydCBqdXN0IGxpc3RzIGEg
Y29tbW9uIHN1YnNldA0Kb2YgT1BQcyBiZWNhdXNlIHRoZSBoaWdoZXIgb25lcyBzaG91bGQgb25s
eSBiZSBhdHRlbXB0ZWQgYWZ0ZXIgY2hlY2tpbmcNCnNwZWVkIGdyYWRpbmcgaW4gZnVzZXMuDQoN
CkFkZCBhIHNtYWxsIGRyaXZlciB3aGljaCBjaGVja3Mgc3BlZWQgZ3JhZGluZyBmcm9tIG52bWVt
IGNlbGxzIGJlZm9yZQ0KcmVnaXN0ZXJpbmcgY3B1ZnJlcS1kdC4NCg0KLS0tDQoNCkJ5IGRlZmF1
bHQga2NvbmZpZyBidWlsZHMgaXQgYXMgYSBtb2R1bGUgZXZlbiB0aG91Z2ggaXQncyB2ZXJ5IHNt
YWxsLg0KQ291bGRuJ3QgZmluZCBhIHdheSBmb3IgTU9EVUxFX0RFVklDRV9UQUJMRSB0byBtYXRj
aCBvbiByb290IG5vZGUgY29tcGF0DQpzdHJpbmcgYW5kIHRoZXJlIHdhcyBubyBvdGhlciBhcHBy
b3ByaWF0ZSBub2RlIHNvIHJlZ2lzdGVyIHRoZQ0KaW14LWNwdWZyZXEtZHQgcGxhdGZyb20gZGV2
aWNlIGRpcmVjdGx5IGZyb20gaW14OCBzb2MgZHJpdmVyIGluc3RlYWQuIEkNCmNoZWNrZWQgbW9k
dWxlIGlzIHByb2JlZCBieSBkZWZhdWx0IGFuZCBybW1vZC9tb2Rwcm9iZSBhZ2FpbiB3b3Jrcy4N
Cg0KSXQgc2VlbXMgdGhhdCBjcHVmcmVxLWR0IGluc2lzdHMgb24gYWRkaW5nIHRoZSBvcHAgYW5k
IHJlZ3VsYXRvciBpdHNlbGYNCnNvIGNhbid0IGFjdHVhbGx5IGNhbGwgZGV2X3BtX29wcF9vZl9h
ZGRfdGFibGUgYW5kIHRoZW4NCmRldl9wbV9vcHBfZGlzYWJsZSBzbyBpbXBsZW1lbnRhdGlvbiB3
YXMgc3dpdGNoZWQgdG8gb3BwLXN1cHBvcnRlZC1ody4NCk1heWJlIEknbSBjb25mdXNlZCBieSBB
UEkgcXVpcmtzPw0KDQpUaGUgbWFya2V0IHNlZ21lbnQgbG9naWMgd2FzIGRyb3BwZWQgYmVjYXVz
ZSBJIGNvdWxkbid0IGZpbmQgYW55IGdvb2QNCnJlZmVyZW5jZXMgaW4gZGF0YXNoZWV0cyBmb3Ig
d2h5IGxvd2VyIG9yIGludGVybWVkaWFyeSBPUFBzIHNob3VsZCBiZQ0KZGlzYWJsZWQgb24gY2Vy
dGFpbiBtYXJrZXQgc2VnbWVudHMuIFVzaW5nIG9wcC1zdXBwb3J0ZWQtaHcgbWVhbnMgdGhhdA0K
YWRkaW5nIHRoaXMgaW4gdGhlIGZ1dHVyZSB3b3VsZCByZXF1aXJlIGNoYW5naW5nIGZsYWdzIGlu
c2lkZSBEVCBpbnN0ZWFkDQpvZiBjb2RlLCB0aGF0IHNlZW1zIHVuZGVzaXJhYmxlIGZvciBEVCBj
b21wYXQgcmVhc29ucy4NCg0KVGhpcyBjb3VsZCBhbHNvIGJlIGV4dGVuZGVkIHRvIG1hY2gtaW14
N2Qgc3BlZWQgZ3JhZGluZy4NCg0KSSBuZXZlciBub3RpY2VkIGFueXRoaW5nIHdyb25nIHdpdGgg
Z29pbmcgYWJvdmUgdGhlIGZ1c2VkIHNwZWVkIGdyYWRpbmcNCmhvd2V2ZXIgaXQncyB0ZWNobmlj
YWxseSB1bnNhZmUgc28gdGhlIGNwdWZyZXEgcGFydHMgc2hvdWxkIGdvIGluIGJlZm9yZQ0KRFQg
Y2hhbmdlcy4NCg0KT3RoZXIgY2hhbmdlcyBzaW5jZSB2MToNCiAqIFR1cm4gaW50byBhIHByb3Bl
ciBtb2R1bGUNCiAqIFN1cHBvcnQgaW14OG1xDQpMaW5rIHRvIHYxIChSRkMpOiBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwOTE2NzY5Lw0KDQpMZW9uYXJkIENyZXN0ZXogKDMp
Og0KICBjcHVmcmVxOiBBZGQgaW14LWNwdWZyZXEtZHQgZHJpdmVyDQogIGFybTY0OiBkdHM6IGlt
eDhtbTogQWRkIGNwdSBzcGVlZCBncmFkaW5nIGFuZCBhbGwgT1BQcw0KICBhcm02NDogZHRzOiBp
bXg4bXE6IEFkZCBjcHUgc3BlZWQgZ3JhZGluZyBhbmQgYWxsIE9QUHMNCg0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgMjMgKysrKystDQogYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgfCAyMyArKysrKy0NCiBkcml2ZXJzL2NwdWZy
ZXEvS2NvbmZpZy5hcm0gICAgICAgICAgICAgICB8IDEwICsrKw0KIGRyaXZlcnMvY3B1ZnJlcS9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVx
LWR0LXBsYXRkZXYuYyAgICAgIHwgIDMgKw0KIGRyaXZlcnMvY3B1ZnJlcS9pbXgtY3B1ZnJlcS1k
dC5jICAgICAgICAgIHwgOTkgKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL3NvYy9p
bXgvc29jLWlteDguYyAgICAgICAgICAgICAgICB8ICAzICsNCiA3IGZpbGVzIGNoYW5nZWQsIDE2
MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2NwdWZyZXEvaW14LWNwdWZyZXEtZHQuYw0KDQotLSANCjIuMTcuMQ0KDQo=
