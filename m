Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8875E109A19
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 09:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKZIWv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 03:22:51 -0500
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:56605
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbfKZIWu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Nov 2019 03:22:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhjvJPpZoCAMd2X5wUaVlfXEVfoDy4ZjaTvEfNFZZCYipcC9koJ6hVSFP8Z+70mdi77DN96UZiBTL8ZqCON/KVXg1n1boWJFMhghUWTS89IiLwnhZA+wytjMWdpayQtjUJITEedYf7xc9lBA8nA0vSpzA/VBiJ3F+Fj/tzGFS+nv+xi+oVUlWuJvm65TIh+BooMBv+BNqUzNx+ChoVhcVUtGnI5eB8PUecaU8lNt6pdWuAg3F+RaZqyuwmSMVgKlrUGtnBE+fPMlAwGvZSmNDFSWHqYUObyrmt9folpbzH2oEkJJu3Zp5lPL9HdqWKNM2uNNwxXhT56DcJkfg4PwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHJq+hBb4ROaJTMDK2Iq/oAzs43SLF2xxG9UjJi14UY=;
 b=amlhpsygGC2JUTIbjhGQYSAht1sMMiUa0d/YaIaNxbj1s7AObQW6us1ie1XaXb8I8oDvcNzmgJjwXHnY6a9tDZD/F1qe+z69LTNYiSpLdKFXJhK4SxajiykZAAb/A+6w51Z2QTHFbrmFEEfiNRLS8ivLet0TshbLyGUmn7M6uFF5yA8OW0ZH9celfabdJeuZ6S9u5ExhbAp3jYKkpye9d6qALXDGz7z2HHjd0IUtjUdi0T1pic+nzubkqJw4x5JHGGG2Typ1PB+9SX2nTwuwf2DL/5FUWipeKQmC4enwvgsEINRm4usg2Xh+HZe/dkmUeP74eZ9p/o87CBcgDdIbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHJq+hBb4ROaJTMDK2Iq/oAzs43SLF2xxG9UjJi14UY=;
 b=S/aKk2GnDLrqR+SnwdsREq9F2ocD1R5vAB0Wi5HtTalOPkjuFTq46/gClIb1tEGxwm0Rm4q7StuyCY2aAq9fw4hP3yuWrGIUyjP01gPcuVJXO1oxZp19NNMACIEFd3zvK8U3bsLEEIipmSW6j4WoQMSCkxpeBQcoXN0nJAsLHMk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 08:22:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 08:22:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJVUNIAAK9HfAAAEUz1Q
Date:   Tue, 26 Nov 2019 08:22:46 +0000
Message-ID: <DB3PR0402MB391646169704A952F7CEC4EFF5450@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7>
 <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
 <CAJZ5v0j4z9tEDCGKRc7dHqTiJ1Fq3So=ELfvR6H25UkRmKeBvg@mail.gmail.com>
 <DB3PR0402MB3916BDC24BDA1053B7ADBDCFF5490@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0g5EGWVAm4A8ynoWAPc1wJRpR6wgZqwhvbmeT4eT49EUA@mail.gmail.com>
 <DB3PR0402MB39165E40800E42C2E5635C7CF54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391638C66C7EB93B5156A2D2F54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191126061810.okkw3wkjmi2uvqjj@vireshk-i7>
In-Reply-To: <20191126061810.okkw3wkjmi2uvqjj@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f171a79-cb51-4405-7dd2-08d77249d199
x-ms-traffictypediagnostic: DB3PR0402MB3881:|DB3PR0402MB3881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38819D8D2605A9EA986D1EBCF5450@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(33656002)(446003)(11346002)(99286004)(4744005)(6246003)(6916009)(66066001)(256004)(71190400001)(71200400001)(186003)(25786009)(14454004)(478600001)(9686003)(7696005)(81166006)(66476007)(76116006)(26005)(6436002)(44832011)(66946007)(8936002)(86362001)(2906002)(5660300002)(6506007)(4326008)(7736002)(53546011)(305945005)(8676002)(14444005)(316002)(74316002)(229853002)(3846002)(6116002)(52536014)(55016002)(76176011)(102836004)(54906003)(66556008)(64756008)(66446008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3881;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGElf2fwtpq55adHoRZUfsPrJLb2DWCVd2lSrd89NYBknZsaVWajJb2DDWtoC34uYRsHcdfbVoUd/i9fdRkAUlDK7ixpArWmBw7578BvZtBIXnr2f4Q54HYJfnGFwKNlyBnzAwhsnPNDIOV3lcDvYQr1kveny+W2TQb+IDGijAkasq6hn33bh9tWy9hyN6Uv7jHGN1ZeiPJ/xVpGBSjkCXYypU9/ooWiVN+9bOOe63BW5n55oUlWnXRGnZYlUKr3HiC8KksYxk9I6Lc4bmUcsLFOyaL3OLvI/Ba7NfKYzETEYuW5HzpRKY4mKV4B75pfz4i+npADfb8sHnEkim8/FxKbcfZWp+Mz79Wbett1Q/IFUyPPJpnRxM77Okqcv7aM3YwPx5fyfZmLbC0AxvowFbMqr7y7pyE5KuArGmVa6koYxebV5EKQR4C0aVJJimIF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f171a79-cb51-4405-7dd2-08d77249d199
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 08:22:47.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xHLOG5QbqopM40uRWsj/ZlrMpkyThy1u4CxRlSnvbb4By5LEfe1+5OMGFvUYv0lYDqf2Ja2AjFEmbtbKTFicw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFZpcmVzaA0KDQo+IE9uIDI1LTExLTE5LCAwOTo0MywgQW5zb24gSHVhbmcgd3JvdGU6DQo+
ID4gSGksIFJhZmFlbA0KPiA+IAlJIHRyaWVkIHRvIHByaW50IHRoZSBuZWNlc3NhcnkgaW5mbyBp
bnRvIERSQU0gaW5zdGVhZCBvZiBjYWxsaW5nIHByX2luZm8NCj4gPiAJZGlyZWN0bHksIHRoZW4g
aXNzdWUgY2FuIGJlIHJlcHJvZHVjZWQgZWFzaWx5IGFnYWluLCB3aGVuIGlzc3VlDQo+ID4gCWhh
cHBlbmVkLCB0aGUgTE9HIHNob3dzIHRoZSBsYXN0IGlycV93b3JrX3N5bmMoKSBpcyBOT1QgY29y
cmVjdGx5DQo+ID4gCWZpbmlzaGVkLiBCZWxvdyBhcmUgdGhlIGxvZyBhbmQgcGF0Y2ggSSBhZGRl
ZCwgdGhlIHRlc3QgY2FzZSBpcyBzaW1wbHkNCj4gPiAJdG8gcmVwZWF0IHJlbW92aW5nIENQVTEv
Q1BVMi9DUFUzIHRoZW4gYWRkaW5nIGJhY2sNCj4gQ1BVMS9DUFUyL0NQVTMuDQo+ID4gCVdoZW4g
aXNzdWUgaGFwcGVucywgYmVsb3cgbG9nIHNob3dzIGxhc3Qgcm91bmQgb2YgcmVtb3ZpbmcgQ1BV
cywNCj4gPiAJQ1BVMS9DUFUyL0NQVTMgaXJxX3dvcmtfc3luYygpIGFsbCB3b3JrZWQgYXMgZXhw
ZWN0ZWQsIHRoZSB3b3JrLQ0KPiA+Y3B1IGlzDQo+ID4gCS0xLCB0aGVuIHdoZW4gQ1BVMSB3YXMg
YWRkZWQgYmFjaywgdGhlIGlycV93b3JrIGZsYWcgaXMNCj4gcGVuZGluZy9idXN5IG9uDQo+ID4g
CUNQVTEsIGFuZCBpc3N1ZSBoYXBwZW5lZDoNCj4gDQo+IEZXSVcsIEkgdHJpZWQgdG8gcmVwcm9k
dWNlIGl0IG9uIG15IGhpa2V5IGJvYXJkIGFuZCBJIGNvdWxkbid0IGV2ZW4gYWZ0ZXINCj4gaG91
cnMgb2YgdGVzdGluZyA6KA0KDQpEaWQgeW91IHVzZSBvbmRlbWFuZCBnb3Zlcm5vcj8gQnkgZGVm
YXVsdCB0aGUgZ292ZXJub3IgaXMgcGVyZm9ybWFuY2UgYW5kDQppdCBoYXMgbm8gaXNzdWUuDQoN
ClRoYW5rcywNCkFuc29uDQo=
