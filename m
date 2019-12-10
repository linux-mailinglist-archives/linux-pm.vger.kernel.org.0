Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C2A1182D0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLJIvy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:51:54 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:60457
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726881AbfLJIvx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Dec 2019 03:51:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G612oZMx33d2nW4vRJlQB/A907sCoXU4szpEDv/5gce/g+qcnf+m6gzSK/wwpI50ExugkdIf9WM7xsCvtyJB7p7IyVESq2UcKNgsnUdPaZ0lykIKV75FzyFH50FfgzdsL7yid8QvN6UWVLXIiqo+UmFKGe43/nrsUXC3WC9HlAX28jLLpPLGnhV69wsBQDWaKyj4n0wOKTwETGkbh4Im7vk6VGtWTJDAfZIOozPssGuq0UU03jW+34PpaBeDwfEaoxsF09vChX0vpxxtJpVphyXo3+Iw1/fwMvP0bTqEWHGvDd0ha+LRSpbbxR6xF4iIXGK53RI9/kM5tG7GRvWdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ8ejhLy6XifXN20Tez9eFIuTz26E1dFNPNQ6uDiQX8=;
 b=dmHMIopiD7fXzTGUCO0QxLcs74Q1cA5kRa06TB9DbjGx2OFsPZnb9X4AuqXILH6GBvZjcQE+BDz/XjUE603ksCGbGmqmXgPcy7Aa+9K7AET3W+f5j2fLxf7bhco5vF0UW/CHG7qVSbvRF5YnsFjdDHTjsDUV5tVMA2nDFhgoyOXu5MndkvM9FfGk/uegg3AHUQ4XEYKsuG8S8DwLya0vMvfxS4mq9cnRI3rOr4e8jagut/1pDAOZICog5H2pkf8rT1auX3B0FQvGguj+howxN/VvklCYSJkwfae13/vdU6VKrtEFVb0ODeuUuLC3CZxvW/thigDJY8bGsYsdVUCDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ8ejhLy6XifXN20Tez9eFIuTz26E1dFNPNQ6uDiQX8=;
 b=bcBqC1852qLMgv7oazApRrKcDwF0nELy5ZyqQCB6ocqQPxX286d7PX3hdEE571sjH4eHyQewAFQM7P9w01WLLYMRGkp0quV1zJm3uCoKo7SXA2PchdlOFFYYbFyJPQrVPEp2oqnLGpFoYjgtPFZa3bvQMr7BVIk3sNFwuOkFq+w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3660.eurprd04.prod.outlook.com (52.134.70.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Tue, 10 Dec 2019 08:51:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 08:51:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUgASMyDZAABHGSAAAFLgggAAVyLYAAvd+WYAAA3omQAAEGDYAAAmWbRgAAcGGAACPMEXAAAqbAgAACrQEAAAAfUXAAAG2mAAAAIzIAAABNT4AAAAalAA==
Date:   Tue, 10 Dec 2019 08:51:43 +0000
Message-ID: <DB3PR0402MB3916C7E77C885343B2B961CFF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0hmaCPNX3O=Yvwh6zt13F9-sFApZn1Rnqx=_xzPde34Pw@mail.gmail.com>
 <DB3PR0402MB3916781D19ECB96C530B410DF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <40413247.HltoIgKm8r@kreacher>
In-Reply-To: <40413247.HltoIgKm8r@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 818bde37-8404-4830-373c-08d77d4e2e7b
x-ms-traffictypediagnostic: DB3PR0402MB3660:|DB3PR0402MB3660:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3660E2B2EB17E2DE76765035F55B0@DB3PR0402MB3660.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(13464003)(199004)(189003)(52314003)(66446008)(229853002)(86362001)(6916009)(4326008)(966005)(5660300002)(478600001)(8936002)(33656002)(81166006)(55016002)(8676002)(45080400002)(44832011)(71200400001)(2906002)(71190400001)(9686003)(186003)(54906003)(305945005)(66946007)(66476007)(26005)(52536014)(76116006)(7696005)(81156014)(64756008)(316002)(66556008)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3660;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQTjwCxpGNAz3xxt+X+1gnINr3FvDZGnfWemqTUXdsDe7G/LgZVTc/nC+ELIoA6XYTq358qfR3M1QgARMp7YVP29QKeoGA82RptCdIg55wQoc6gVziidkn6KmtCIpsY2Dr0bn39szYiexgMGzEKj2evgHPtdmIoXbymIdzsTnE9yppHfNZCnYO6a/S4yM6PmeNi36hzf2oBRRhsMyKQh+kSkEuwYd8J7WcUmbg/N1FAn4jhceglEE67LPBXFpjHYjDNFgrGhdAloisTW4H/sm/JgtZHMCIggiAkUjdXKKjlMgA8Nt0+cpLpFAt7XwklApw8kqyHcFmC2vHOxKwU+JlhMi6FOenelbwDjjfuB2HZhmStWwkvLkDJuWFtvr1UiacgPphiYLqd/s7R+L6oG1FL7bukj90SXBVLKBmihP7lQHuRRNAGSrstgm9Y5d9S8ANgkVl4KrmB3V2FgkxTvCY2+YQqDrO4mSsyJkLW69j0UgC02oTc++J+G8IBvgBY/k7jufG4IjE8QVUg/cedYXQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818bde37-8404-4830-373c-08d77d4e2e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 08:51:43.5393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QssdA3cIwybDew38UPzLOoKuPHdrKbMJvikQXez+luD+axBSMyDr+CKXunvoUY/puxE9KEqlHq2M3/kmNwSHfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3660
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJqd0Byand5c29ja2kubmV0Pg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMCwgMjAx
OSA0OjUxIFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6
IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IFZpcmVzaCBLdW1hcg0KPiA8
dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEph
Y2t5IEJhaQ0KPiA8cGluZy5iYWlAbnhwLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsg
VmluY2VudCBHdWl0dG90DQo+IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz47IFBldGVyIFpp
amxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFBhdWwNCj4gTWNLZW5uZXkgPHBhdWxtY2tA
bGludXgudm5ldC5pYm0uY29tPg0KPiBTdWJqZWN0OiBSZTogQWJvdXQgQ1BVIGhvdC1wbHVnIHN0
cmVzcyB0ZXN0IGZhaWxlZCBpbiBjcHVmcmVxIGRyaXZlcg0KPiANCj4gT24gVHVlc2RheSwgRGVj
ZW1iZXIgMTAsIDIwMTkgOTo0NTowOSBBTSBDRVQgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4NCj4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBSYWZhZWwgSi4gV3lz
b2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAx
MCwgMjAxOSA0OjM4IFBNDQo+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20+DQo+ID4gPiBDYzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgVmly
ZXNoIEt1bWFyDQo+ID4gPiA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+OyBQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT47IFJhZmFlbCBKLg0KPiA+ID4gV3lzb2NraSA8cmp3QHJqd3lzb2NraS5u
ZXQ+OyBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyBsaW51eC0NCj4gPiA+IHBtQHZnZXIu
a2VybmVsLm9yZzsgVmluY2VudCBHdWl0dG90IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz47
DQo+ID4gPiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQYXVsIE1jS2Vu
bmV5DQo+ID4gPiA8cGF1bG1ja0BsaW51eC52bmV0LmlibS5jb20+DQo+ID4gPiBTdWJqZWN0OiBS
ZTogQWJvdXQgQ1BVIGhvdC1wbHVnIHN0cmVzcyB0ZXN0IGZhaWxlZCBpbiBjcHVmcmVxIGRyaXZl
cg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgRGVjIDEwLCAyMDE5IGF0IDk6MjkgQU0gQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+
IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gPiA+ID4gPiBT
ZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMCwgMjAxOSA0OjIyIFBNDQo+ID4gPiA+ID4gVG86IFZp
cmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gQ2M6IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPjsgUmFmYWVsIEouIFd5c29ja2kNCj4gPiA+ID4gPiA8cmFm
YWVsQGtlcm5lbC5vcmc+OyBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IFJhZmFl
bA0KPiBKLg0KPiA+ID4gPiA+IFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0PjsgSmFja3kgQmFp
IDxwaW5nLmJhaUBueHAuY29tPjsNCj4gPiA+ID4gPiBsaW51eC0gcG1Admdlci5rZXJuZWwub3Jn
OyBWaW5jZW50IEd1aXR0b3QNCj4gPiA+ID4gPiA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+
OyBQZXRlciBaaWpsc3RyYQ0KPiA+ID4gPiA+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFBhdWwg
TWNLZW5uZXkNCj4gPiA+ID4gPiA8cGF1bG1ja0BsaW51eC52bmV0LmlibS5jb20+DQo+ID4gPiA+
ID4gU3ViamVjdDogUmU6IEFib3V0IENQVSBob3QtcGx1ZyBzdHJlc3MgdGVzdCBmYWlsZWQgaW4g
Y3B1ZnJlcQ0KPiA+ID4gPiA+IGRyaXZlcg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVHVlLCBE
ZWMgMTAsIDIwMTkgYXQgODowNSBBTSBWaXJlc2ggS3VtYXINCj4gPiA+ID4gPiA8dmlyZXNoLmt1
bWFyQGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gK2ZldyBtb3JlIGd1eXMNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPbiAxMC0xMi0xOSwg
MDU6NTMsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBCdXQgcGVyDQo+ID4gPiA+ID4g
PiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQQ0KPiA+ID4gPiA+ID4gPiAlMkYlDQo+ID4gPiA+ID4gPiA+IDJGZWwNCj4gPiA+ID4g
PiA+ID4gaXhpci5ib290bGluLmNvbSUyRmxpbnV4JTJGdjUuNS0NCj4gPiA+ID4gPiByYzElMkZz
b3VyY2UlMkZrZXJuZWwlMkZzY2hlZCUyRnNjaGUNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0K
PiA+ID4NCj4gZC5oJTIzTDIyOTMmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhw
LmNvbSU3QzZmNDQ5MDANCj4gPiA+ID4gPiBiZTM0MDQNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
Pg0KPiA+ID4NCj4gZTdkMzU1NzA4ZDc3ZDRhMTZmYSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMzAxNjM1JTdDMCU3QzAlDQo+ID4gPiA+ID4gN0M2MzcNCj4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPg0KPiA+ID4NCj4gMTE1NjI5NDc1NDU2MzI5JmFtcDtzZGF0YT1YWGh3dnVUT0JiM1RMbWVy
d2tyMXpLYmFXTkE4eEElMkJsDQo+ID4gPiA+ID4gVyUyRmF3MzENCj4gPiA+ID4gPiA+ID4gMEFZ
Y00lM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+ID4gPiA+ID4gY3B1X29mKHJxKSBhbmQgc21wX3By
b2Nlc3Nvcl9pZCgpIGlzIHBvc3NpYmxlIHRvIG5vdCB0aGUNCj4gPiA+ID4gPiA+ID4gc2FtZSwN
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gV2hlbiBjcHVfb2YocnEpIGlzIG5vdCBlcXVh
bCB0byBzbXBfcHJvY2Vzc29yX2lkKCksDQo+ID4gPiA+ID4gPiA+IGRic191cGRhdGVfdXRpbF9o
YW5kbGVyIHdpbGwgdXNlIGlycV93b3JrX3F1ZXVlIHRvDQo+ID4gPiA+ID4gPiA+IHNtcF9wcm9j
ZXNzb3JfaWQoKSwgbm90IGNwdV9vZihycSkuIElzIHRoaXMgZXhwZWN0ZWQ/DQo+ID4gPiA+ID4g
PiA+IE9yIHNob3VsZCB0aGUgaXJxX3dvcmsgYmUgcXVldWVkIHRvIGNwdV9vZihycSk/DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gT2theSwgc29ycnkgZm9yIHRoZSBsb25nIHdlZWtlbmQgd2hl
cmUgSSBjb3VsZG4ndCBnZXQgdGltZSB0bw0KPiA+ID4gPiA+ID4gcmVwbHkgYXQNCj4gPiA+IGFs
bC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE5vIHdvcnJpZXMuIDotKQ0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBGaXJzdCBvZiBhbGwsIGxldHMgdHJ5IHRvIHVuZGVyc3RhbmQgZHZmc19wb3NzaWJs
ZV9mcm9tX2FueV9jcHUuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gV2hvIGNhbiB1cGRhdGUg
dGhlIGZyZXF1ZW5jeSBvZiBhIENQVSA/IEZvciBtYW55DQo+ID4gPiA+ID4gPiBhcmNoaXRlY3R1
cmVzL3BsYXRmb3JtcyB0aGUgZXZlbnR1YWwgY29kZSB0aGF0IHdyaXRlcyB0byBzb21lDQo+ID4g
PiA+ID4gPiByZWdpc3RlciB0byBjaGFuZ2UgdGhlIGZyZXF1ZW5jeSBzaG91bGQgb25seSBydW4g
b24gdGhlIGxvY2FsDQo+ID4gPiA+ID4gPiBDUFUsIGFzIHRoZXNlIHJlZ2lzdGVycyBhcmUgcGVy
LWNwdSByZWdpc3RlcnMgYW5kIG5vdA0KPiA+ID4gPiA+ID4gc29tZXRoaW5nIHNoYXJlZA0KPiA+
ID4gYmV0d2VlbiBDUFVzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEJ1dCBmb3IgdGhlIEFS
TSBhcmNoaXRlY3R1cmUsIHdlIGhhdmUgYSBQTEwgYW5kIHRoZW4gc29tZSBtb3JlDQo+ID4gPiA+
ID4gPiByZWdpc3RlcnMgdG8gcGxheSB3aXRoIHRoZSBjbGsgcHJvdmlkZWQgdG8gdGhlIENQVSBi
bG9ja3MgYW5kDQo+ID4gPiA+ID4gPiB0aGVzZSByZWdpc3RlcnMgKHdoaWNoIGFyZSB1cGRhdGVk
IGFzIGEgcmVzdWx0IG9mDQo+ID4gPiA+ID4gPiBjbGtfc2V0X3JhdGUoKSkgYXJlIHBhcnQgb2Yg
YQ0KPiA+ID4gPiA+IGJsb2NrIG91dHNpZGUgb2YgdGhlIENQVSBibG9ja3MuDQo+ID4gPiA+ID4g
PiBBbmQgc28gYW55IENQVSAoZXZlbiBpZiBpdCBpcyBub3QgcGFydCBvZiB0aGUgc2FtZSBjcHVm
cmVxDQo+ID4gPiA+ID4gPiBwb2xpY3kpIGNhbiB1cGRhdGUgaXQuIFNldHRpbmcgdGhpcyBmbGFn
IGFsbG93cyB0aGF0IGFuZA0KPiA+ID4gPiA+ID4gZXZlbnR1YWxseSB3ZSBtYXkgZW5kIHVwIHVw
ZGF0aW5nIHRoZSBmcmVxdWVuY3kgc29vbmVyLA0KPiA+ID4gPiA+ID4gaW5zdGVhZCBvZiBsYXRl
ciAod2hpY2ggbWF5IGJlIGxlc3MgZWZmZWN0aXZlKS4gVGhhdCB3YXMgdGhlIGlkZWEgb2YNCj4g
dGhlIHJlbW90ZS13YWtldXAgc2VyaWVzLg0KPiA+ID4gPiA+ID4gVGhpcyBzdHVmZiBpcyBhYnNv
bHV0ZWx5IGNvcnJlY3QgYW5kIHNvIGNwdWZyZXEtZHQgZG9lcyBpdCBmb3INCj4gZXZlcnlvbmUu
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBhbHNvIG1lYW5zIHRoYXQgdGhlIG5vcm1h
bCB3b3JrIGFuZCBpcnEtd29yayBib3RoIGNhbiBydW4NCj4gPiA+ID4gPiA+IG9uIGFueSBDUFUg
Zm9yIHlvdXIgcGxhdGZvcm0gYW5kIGl0IHNob3VsZCBiZSBva2F5IHRvIGRvIHRoYXQuDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBBbmQgaXQgdGhlIGZhaWxpbmcgY2FzZSBhbGwgb2YgdGhlIENQVXMg
aW4gdGhlIHN5c3RlbSBhcmUgaW4gdGhlDQo+ID4gPiA+ID4gc2FtZSBwb2xpY3kgYW55d2F5LCBz
byBkdmZzX3Bvc3NpYmxlX2Zyb21fYW55X2NwdSBpcyBhIHJlZCBoZXJyaW5nLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBOb3csIHdlIGhhdmUgbmVjZXNzYXJ5IG1lYXN1cmVzIGluIHBsYWNlIHRv
IG1ha2Ugc3VyZSB0aGF0DQo+ID4gPiA+ID4gPiBhZnRlciBzdG9wcGluZyBhbmQgYmVmb3JlIHN0
YXJ0aW5nIGEgZ292ZXJub3IsIHRoZSBzY2hlZHVsZXINCj4gPiA+ID4gPiA+IGhvb2tzIHRvIHNh
dmUgdGhlIGNwdWZyZXEgZ292ZXJub3IgcG9pbnRlciBhbmQgdXBkYXRlcyB0bw0KPiA+ID4gPiA+
ID4gcG9saWN5LT5jcHVzIGFyZSBtYWRlIHByb3Blcmx5LCB0byBtYWtlIHN1cmUgdGhhdCB3ZSBu
ZXZlcg0KPiA+ID4gPiA+ID4gZXZlciBzY2hlZHVsZSBhIHdvcmsgb3IgaXJxLXdvcmsgb24gYSBD
UFUgd2hpY2ggaXMgb2ZmbGluZS4NCj4gPiA+ID4gPiA+IE5vdyBpdCBsb29rcyBsaWtlIHRoaXMg
aXNuJ3Qgd29ya2luZyBhcyBleHBlY3RlZCBhbmQgd2UgbmVlZCB0byBmaW5kDQo+IHdoYXQgZXhh
Y3RseSBpcyBicm9rZW4gaGVyZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBBbmQgeWVzLCBJ
IGRpZCB0aGUgdGVzdGluZyBvbiBIaWtleSA2MjAsIGFuIG9jdGEtY29yZSBBUk0NCj4gPiA+ID4g
PiA+IHBsYXRmb3JtIHdoaWNoIGhhcyBhIHNpbmdsZSBjcHVmcmVxIHBvbGljeSB3aGljaCBoYXMg
YWxsIHRoZSA4DQo+ID4gPiA+ID4gPiBDUFVzLiBBbmQgeWVzLCBJIGFtIHVzaW5nIGNwdWZyZXEt
ZHQgb25seSBhbmQgSSB3YXNuJ3QgYWJsZSB0bw0KPiA+ID4gPiA+ID4gcmVwcm9kdWNlIHRoZSBw
cm9ibGVtIHdpdGggbWFpbmxpbmUga2VybmVsIGFzIEkgZXhwbGFpbmVkIGVhcmxpZXIuDQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlIHByb2JsZW0gaXMgc29tZXdoZXJlIGJldHdlZW4gdGhl
IHNjaGVkdWxlcidzIGdvdmVybm9yIGhvb2sNCj4gPiA+ID4gPiBydW5uaW5nDQo+ID4gPiA+ID4g
PiBvciBxdWV1aW5nIHdvcmsgb24gYSBDUFUgd2hpY2ggaXMgaW4gdGhlIG1pZGRsZSBvZiBnZXR0
aW5nDQo+ID4gPiA+ID4gPiBvZmZsaW5lL29ubGluZSBhbmQgdGhlcmUgaXMgc29tZSByYWNlIGFy
b3VuZCB0aGF0LiBUaGUgcHJvYmxlbQ0KPiA+ID4gPiA+ID4gaGVuY2UgbWF5IG5vdCBiZSByZWxh
dGVkIHRvIGp1c3QgY3B1ZnJlcSwgYnV0IGEgd2lkZXIgdmFyaWV0eSBvZg0KPiBjbGllbnRzLg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCBhIENQVSBpcyBydW5uaW5n
IGEgZ292ZXJub3IgaG9vayB3aGljaCBpdA0KPiA+ID4gPiA+IHNob3VsZG4ndCBiZSBydW5uaW5n
IGF0IGFsbC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBvYnNlcnZhdGlvbiB0aGF0IGR2ZnNf
cG9zc2libGVfZnJvbV9hbnlfY3B1IG1ha2VzIGENCj4gPiA+ID4gPiBkaWZmZXJlbmNlIG9ubHkg
bWVhbnMgdGhhdCB0aGUgZ292ZXJub3IgaG9vayBpcyBydW5uaW5nIG9uIGEgQ1BVDQo+ID4gPiA+
ID4gdGhhdCBpcyBub3QgcHJlc2VudCBpbiB0aGUNCj4gPiA+ID4gPiBwb2xpY3ktPmNwdXMgbWFz
ay4gIE9uIHRoZSBwbGF0Zm9ybShzKSBpbiBxdWVzdGlvbiB0aGlzIGNhbm5vdA0KPiA+ID4gPiA+
IHBvbGljeS0+aGFwcGVuIGFzDQo+ID4gPiA+ID4gbG9uZyBhcyBSQ1Ugd29ya3MgYXMgZXhwZWN0
ZWQuDQo+ID4gPiA+DQo+ID4gPiA+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoZSBnb3Zl
cm5vciBob29rIE9OTFkgYmUgY2xlYXIgb24gdGhlDQo+ID4gPiA+IENQVSBiZWluZyBvZmZsaW5l
IGFuZCBhZnRlciBnb3Zlcm5vciBzdG9wcGVkLCBidXQgdGhlIENQVSBiZWluZw0KPiA+ID4gPiBv
ZmZsaW5lIGNvdWxkIHN0aWxsIHJ1biBpbnRvIGJlbG93IGZ1bmN0aW9uIHRvIGhlbHAgb3RoZXIg
Q1BVDQo+ID4gPiA+IHVwZGF0ZSB0aGUgdXRpbCwgYW5kIGl0IE9OTFkgY2hlY2tzIHRoZSBjcHVf
b2YocnEpJ3MgZ292ZXJub3IgaG9vaw0KPiA+ID4gPiB3aGljaCBpcyB2YWxpZCBhcyB0aGF0DQo+
ID4gPiBDUFUgaXMgb25saW5lLg0KPiA+ID4gPg0KPiA+ID4gPiBTbyB0aGUgcXVlc3Rpb24gaXMg
aG93IHRvIGF2b2lkIHRoZSBDUFUgYmVpbmcgb2ZmbGluZSBhbmQgYWxyZWFkeQ0KPiA+ID4gPiBm
aW5pc2ggdGhlIGdvdmVybm9yIHN0b3AgZmxvdyBiZSBzY2hlZHVsZWQgdG8gaGVscCBvdGhlciBD
UFUNCj4gPiA+ID4gdXBkYXRlIHRoZQ0KPiA+ID4gdXRpbC4NCj4gPiA+ID4NCj4gPiA+ID4gIHN0
YXRpYyBpbmxpbmUgdm9pZCBjcHVmcmVxX3VwZGF0ZV91dGlsKHN0cnVjdCBycSAqcnEsIHVuc2ln
bmVkDQo+ID4gPiA+IGludA0KPiA+ID4gPiBmbGFncykgIHsNCj4gPiA+ID4gICAgICAgICAgc3Ry
dWN0IHVwZGF0ZV91dGlsX2RhdGEgKmRhdGE7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgIGRh
dGEgPQ0KPiA+ID4gcmN1X2RlcmVmZXJlbmNlX3NjaGVkKCpwZXJfY3B1X3B0cigmY3B1ZnJlcV91
cGRhdGVfdXRpbF9kYXRhLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjcHVfb2YocnEpKSk7DQo+ID4gPiA+ICAgICAgICAgIGlmIChk
YXRhKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgIGRhdGEtPmZ1bmMoZGF0YSwgcnFfY2xvY2so
cnEpLCBmbGFncyk7ICB9DQo+ID4gPg0KPiA+ID4gT0ssIHNvIHRoYXQncyB3aGVyZSB0aGUgcHJv
YmxlbSBpcywgZ29vZCBjYXRjaCENCj4gPiA+DQo+ID4gPiBTbyB3aGF0IGhhcHBlbnMgaXMgdGhh
dCBhIENQVSBnb2luZyBvZmZsaW5lIHJ1bnMgc29tZSBzY2hlZHVsZXIgY29kZQ0KPiA+ID4gdGhh
dCBpbnZva2VzIGNwdWZyZXFfdXBkYXRlX3V0aWwoKS4gIEluY2lkZW50YWxseSwgaXQgaXMgbm90
IHRoZQ0KPiA+ID4gY3B1X29mKHJxKSwgYnV0IHRoYXQgQ1BVIGlzIHN0aWxsIG9ubGluZSwgc28g
dGhlIGNhbGxiYWNrIGlzIGludm9rZWQNCj4gPiA+IGFuZCB0aGVuIHBvbGljeS0+Y3B1cyB0ZXN0
IGlzIGJ5cGFzc2VkIGJlY2F1c2Ugb2YNCj4gZHZmc19wb3NzaWJsZV9mcm9tX2FueV9jcHUuDQo+
ID4NCj4gPiBJZiB0aGlzIGlzIHRoZSBpc3N1ZSwgYWRkIGFub3RoZXIgY2hlY2sgaGVyZSBmb3Ig
dGhlIGN1cnJlbnQgQ1BVJ3MgZ292ZXJub3INCj4gaG9vaz8NCj4gPiBPciBhbnkgb3RoZXIgYmV0
dGVyIHBsYWNlIHRvIG1ha2Ugc3VyZSB0aGUgQ1BVIGJlaW5nIG9mZmxpbmUgTk9UIHRvIGJlDQo+
IHF1ZXVlZCB0byBpcnEgd29yaz8NCj4gDQo+IEdlbmVyYWxseSwgeWVzLg0KPiANCj4gU29tZXRo
aW5nIGxpa2UgdGhlIHBhdGNoIGJlbG93IHNob3VsZCBoZWxwIGlmIEknbSBub3QgbWlzdGFrZW46
DQo+IA0KPiAtLS0NCj4gIGluY2x1ZGUvbGludXgvY3B1ZnJlcS5oIHwgICAgOCArKysrKy0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+
IEluZGV4OiBsaW51eC1wbS9pbmNsdWRlL2xpbnV4L2NwdWZyZXEuaA0KPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID09
PQ0KPiAtLS0gbGludXgtcG0ub3JpZy9pbmNsdWRlL2xpbnV4L2NwdWZyZXEuaA0KPiArKysgbGlu
dXgtcG0vaW5jbHVkZS9saW51eC9jcHVmcmVxLmgNCj4gQEAgLTU5OSwxMSArNTk5LDEzIEBAIHN0
YXRpYyBpbmxpbmUgYm9vbCBjcHVmcmVxX3RoaXNfY3B1X2Nhbl8gIHsNCj4gIAkvKg0KPiAgCSAq
IEFsbG93IHJlbW90ZSBjYWxsYmFja3MgaWY6DQo+IC0JICogLSBkdmZzX3Bvc3NpYmxlX2Zyb21f
YW55X2NwdSBmbGFnIGlzIHNldA0KPiAgCSAqIC0gdGhlIGxvY2FsIGFuZCByZW1vdGUgQ1BVcyBz
aGFyZSBjcHVmcmVxIHBvbGljeQ0KPiArCSAqIC0gZHZmc19wb3NzaWJsZV9mcm9tX2FueV9jcHUg
ZmxhZyBpcyBzZXQgYW5kIHRoZSBDUFUgcnVubmluZyB0aGUNCj4gKwkgKiAgIGNvZGUgaXMgbm90
IGdvaW5nIG9mZmxpbmUuDQo+ICAJICovDQo+IC0JcmV0dXJuIHBvbGljeS0+ZHZmc19wb3NzaWJs
ZV9mcm9tX2FueV9jcHUgfHwNCj4gLQkJY3B1bWFza190ZXN0X2NwdShzbXBfcHJvY2Vzc29yX2lk
KCksIHBvbGljeS0+Y3B1cyk7DQo+ICsJcmV0dXJuIGNwdW1hc2tfdGVzdF9jcHUoc21wX3Byb2Nl
c3Nvcl9pZCgpLCBwb2xpY3ktPmNwdXMpIHx8DQo+ICsJCShwb2xpY3ktPmR2ZnNfcG9zc2libGVf
ZnJvbV9hbnlfY3B1ICYmDQo+ICsJCSAhY3B1bWFza190ZXN0X2NwdShzbXBfcHJvY2Vzc29yX2lk
KCksIHBvbGljeS0NCj4gPnJlbGF0ZWRfY3B1cykpOw0KPiAgfQ0KDQpJIHdpbGwgc3RhcnQgYSBz
dHJlc3MgdGVzdCBvZiB0aGlzIHBhdGNoLCB0aGFua3MhDQoNCkFuc29uDQo=
