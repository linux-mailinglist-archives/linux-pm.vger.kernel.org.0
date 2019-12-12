Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A7611C1B7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 01:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfLLA5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 19:57:01 -0500
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:54254
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbfLLA5B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Dec 2019 19:57:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBw44SC/aEU2k5YzpKTo/cm5+nXwYrSmbirNvaqT6mR5pDBgLqJ9JN3PWAcbRHksWXOzcz2QCM9KQs4EXltyNwcobLt0uYhZJ4NJGIEh+D1eVfCN/xiRJPpQsBODvEUkmogQC9kvwq3+xqgAaACv0/9cuSz3rI5SScD5w5etuDGjy2eE623K5/aRV8HuqACfDHW+luy1BMZh9Wrw8ngI2pvpAwP5wxVFEhvdHZKcso5pKJRq6cvUsefYGWe7VecTiYX8S7A0EUdzaakvuCGdSfwu+Bb/D6wX6PQQczYDnL5kWU/DOGa6mjP2O5qdtv2pOKWLnt1mIAuis1+frnLnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9Fs3NZ4MrUWX+C6gIp7wtrnelgKW4EQ+OjdhoC7MbU=;
 b=O6etovwqz/Xdgofj0cDc2jdpB9U3hUx1kADKDi+K9qKBD1J9Tw7i1gmpSYZJ1mr+uxxjIExk3m9dYwJg17gekbzqLjOjztoci3dyvT+6/VNTx0+cIfyVfoMdZOJnr09YDR/Vvw4tLu8MBdKUOkpfUAH+MhFNTOrS0l+9O5f6JCEXbl0ndTc0fJ+MZVeGXPjooM8/p7hj2GBKOylLipgpKIxEEEriipsACG5DYOawtvMCh8IRHcCdXQQ7qf2Lbjpd77naEbxim704DP87wQ3SA8N76qPJV/23vJoYBog0+DUwp9Jl1baeOFP8zNfnSLGD+HqHdrfrVR6Pe3/Eooq9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9Fs3NZ4MrUWX+C6gIp7wtrnelgKW4EQ+OjdhoC7MbU=;
 b=MW5UjbR+1+hE4Zjqf0z+TP1j4RaZAUAQXFzyH47qqBYsjyTHzU+8tzl/GrXQLWpfpTZ1Tq5Ndeu5AkTnsJB06Pi9XG6Go/WNVfTbLfTIH2tM9cg6Y/EsPdXLs/E9KcnIPg6jt7Cgu8sPd+WYsU0CBqRgMSCWriCc2g7oL9ioWmY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (52.134.65.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 12 Dec 2019 00:56:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1%6]) with mapi id 15.20.2516.019; Thu, 12 Dec 2019
 00:56:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU
 offline
Thread-Topic: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU
 offline
Thread-Index: AQHVsA3Ecnx4aV5tfUCsloz8GpMk3qe1rV8g
Date:   Thu, 12 Dec 2019 00:56:54 +0000
Message-ID: <DB3PR0402MB3916878EFE50C11EB41DFFFEF5550@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <2691942.bH9KnLg61H@kreacher>
In-Reply-To: <2691942.bH9KnLg61H@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a80596a1-44a7-4862-3c6a-08d77e9e2e89
x-ms-traffictypediagnostic: DB3PR0402MB3913:|DB3PR0402MB3913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3913EB02A907B921A166935AF5550@DB3PR0402MB3913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(44832011)(71200400001)(66946007)(55016002)(478600001)(316002)(54906003)(9686003)(110136005)(966005)(5660300002)(45080400002)(86362001)(2906002)(66556008)(186003)(76116006)(52536014)(66446008)(64756008)(26005)(33656002)(6506007)(66476007)(8936002)(81166006)(81156014)(8676002)(4326008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5yCrvXl+eHR8eYt0lZsrHbcyC0optjgdsSTZ1saKr2kCs0ITbi+RyVJbP1orEZ/GngbFoilV1zwpwJNGy5mxqH9yqXCI2I5m1mW7398H3luKAPmykx0aTu3lFHfedhfbedv9ywGASurINj2ng/1jKORMobPKszFm6cPJwR6sVQdg5/bl4CTd1HM4gG+ccsCBPVwTFsJbXkbeeNEKh9VDgFg0wUx8Nd0Lub1fXyXqC2fjQsp5VTEdzak/hWvv/yACjlok86cWrGzZezPnv2Utot101YgaqWymzByt5A5q3AHYUxOOX5P/gjsKv3N2piiwoykpuK3Qm6MK8nBmCa56ERlZJT7G3f5O5TnzLbXtDmHRTR1bcZ6NMhUKZmHxLKZ9URpEcUdkqwSfdWadZDw2YGo1R5frv6AM7WqOf9G7jdGcZD2QVejs6K9BbXArkJlti4KbM1fGx6Ge7G0Wrj1SMvNblU8MGffQuqiynewuFd0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80596a1-44a7-4862-3c6a-08d77e9e2e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 00:56:54.4544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLbYA923Mlc1SeoJ2QSdRNzC9k8Kde5Fcg48NLeyJgL/hnv5pQbu40qtEAws4v2awi4R9wgKYy/sd/BElj4cqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQo+IFN1YmplY3Q6IFtQQVRDSF0gY3B1ZnJlcTogQXZvaWQgbGVhdmluZyBzdGFsZSBJUlEgd29y
ayBpdGVtcyBkdXJpbmcgQ1BVDQo+IG9mZmxpbmUNCj4gDQo+IEZyb206IFJhZmFlbCBKLiBXeXNv
Y2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gDQo+IFRoZSBzY2hlZHVsZXIgY29k
ZSBjYWxsaW5nIGNwdWZyZXFfdXBkYXRlX3V0aWwoKSBtYXkgcnVuIGR1cmluZyBDUFUgb2ZmbGlu
ZQ0KPiBvbiB0aGUgdGFyZ2V0IENQVSBhZnRlciB0aGUgSVJRIHdvcmsgbGlzdHMgaGF2ZSBiZWVu
IGZsdXNoZWQgZm9yIGl0LCBzbyB0aGUNCj4gdGFyZ2V0IENQVSBzaG91bGQgYmUgcHJldmVudGVk
IGZyb20gcnVubmluZyBjb2RlIHRoYXQgbWF5IHF1ZXVlIHVwIGFuDQo+IElSUSB3b3JrIGl0ZW0g
b24gaXQgYXQgdGhhdCBwb2ludC4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoYXQgbWF5IG5vdCBi
ZSB0aGUgY2FzZSBpZiBkdmZzX3Bvc3NpYmxlX2Zyb21fYW55X2NwdSBpcyBzZXQNCj4gZm9yIGF0
IGxlYXN0IG9uZSBjcHVmcmVxIHBvbGljeSBpbiB0aGUgc3lzdGVtLCBiZWNhdXNlIHRoYXQgYWxs
b3dzIHRoZSBDUFUNCj4gZ29pbmcgb2ZmbGluZSB0byBydW4gdGhlIHV0aWxpemF0aW9uIHVwZGF0
ZSBjYWxsYmFjayBvZiB0aGUgY3B1ZnJlcSBnb3Zlcm5vciBvbg0KPiBiZWhhbGYgb2YgYW5vdGhl
ciAob25saW5lKSBDUFUgaW4gc29tZSBjYXNlcy4NCj4gDQo+IElmIHRoYXQgaGFwcGVucywgdGhl
IGNwdWZyZXEgZ292ZXJub3IgY2FsbGJhY2sgbWF5IHF1ZXVlIHVwIGFuIElSUSB3b3JrIG9uDQo+
IHRoZSBDUFUgcnVubmluZyBpdCwgd2hpY2ggaXMgZ29pbmcgb2ZmbGluZSwgYW5kIHRoZSBJUlEg
d29yayB3aWxsIG5vdCBiZQ0KPiBmbHVzaGVkIGFmdGVyIHRoYXQgcG9pbnQuICBNb3Jlb3Zlciwg
dGhhdCBJUlEgd29yayBjYW5ub3QgYmUgZmx1c2hlZCB1bnRpbA0KPiB0aGUgIm9mZmxpbmluZyIg
Q1BVIGdvZXMgYmFjayBvbmxpbmUsIHNvIGlmIGFueSBvdGhlciBDUFUgY2FsbHMgaXJxX3dvcmtf
c3luYygpDQo+IHRvIHdhaXQgZm9yIHRoZSBjb21wbGV0aW9uIG9mIHRoYXQgSVJRIHdvcmssIGl0
IHdpbGwgaGF2ZSB0byB3YWl0IHVudGlsIHRoZQ0KPiAib2ZmbGluaW5nIiBDUFUgaXMgYmFjayBv
bmxpbmUgYW5kIHRoYXQgbWF5IG5vdCBoYXBwZW4gZm9yZXZlci4gIEluIHBhcnRpY3VsYXIsDQo+
IGEgc3lzdGVtLXdpZGUgZGVhZGxvY2sgbWF5IG9jY3VyIGR1cmluZyBDUFUgb25saW5lIGFzIGEg
cmVzdWx0IG9mIHRoYXQuDQo+IA0KPiBUaGUgZmFpbGluZyBzY2VuYXJpbyBpcyBhcyBmb2xsb3dz
LiAgQ1BVMCBpcyB0aGUgYm9vdCBDUFUsIHNvIGl0IGNyZWF0ZXMgYQ0KPiBjcHVmcmVxIHBvbGlj
eSBhbmQgYmVjb21lcyB0aGUgImxlYWRlciIgb2YgaXQgKHBvbGljeS0+Y3B1KS4gIEl0IGNhbm5v
dCBnbw0KPiBvZmZsaW5lLCBiZWNhdXNlIGl0IGlzIHRoZSBib290IENQVS4NCj4gTmV4dCwgb3Ro
ZXIgQ1BVcyBqb2luIHRoZSBjcHVmcmVxIHBvbGljeSBhcyB0aGV5IGdvIG9ubGluZSBhbmQgdGhl
eSBsZWF2ZSBpdA0KPiB3aGVuIHRoZXkgZ28gb2ZmbGluZS4gIFRoZSBsYXN0IENQVSB0byBnbyBv
ZmZsaW5lLCBzYXkgQ1BVMywgbWF5IHF1ZXVlIHVwIGFuDQo+IElSUSB3b3JrIHdoaWxlIHJ1bm5p
bmcgdGhlIGdvdmVybm9yIGNhbGxiYWNrIG9uIGJlaGFsZiBvZiBDUFUwIGFmdGVyIGxlYXZpbmcN
Cj4gdGhlIGNwdWZyZXEgcG9saWN5IGJlY2F1c2Ugb2YgdGhlIGR2ZnNfcG9zc2libGVfZnJvbV9h
bnlfY3B1IGVmZmVjdA0KPiBkZXNjcmliZWQgYWJvdmUuICBUaGVuLCBDUFUwIGlzIHRoZSBvbmx5
IG9ubGluZSBDUFUgaW4gdGhlIHN5c3RlbSBhbmQgdGhlDQo+IHN0YWxlIElSUSB3b3JrIGlzIHN0
aWxsIHF1ZXVlZCBvbiBDUFUzLiAgV2hlbiwgc2F5LCBDUFUxIGdvZXMgYmFjayBvbmxpbmUsIGl0
DQo+IHdpbGwgcnVuDQo+IGlycV93b3JrX3N5bmMoKSB0byB3YWl0IGZvciB0aGF0IElSUSB3b3Jr
IHRvIGNvbXBsZXRlIGFuZCBzbyBpdCB3aWxsIHdhaXQgZm9yDQo+IENQVTMgdG8gZ28gYmFjayBv
bmxpbmUgKHdoaWNoIG1heSBuZXZlciBoYXBwZW4gZXZlbiBpbiBwcmluY2lwbGUpLCBidXQNCj4g
KHdvcnNlIHlldCkgQ1BVMCBpcyB3YWl0aW5nIGZvciBDUFUxIGF0IHRoYXQgcG9pbnQgdG9vIGFu
ZCBhIHN5c3RlbS13aWRlDQo+IGRlYWRsb2NrIG9jY3Vycy4NCj4gDQo+IFRvIGFkZHJlc3MgdGhp
cyBwcm9ibGVtIG5vdGljZSB0aGF0IENQVXMgd2hpY2ggY2Fubm90IHJ1biBjcHVmcmVxDQo+IHV0
aWxpemF0aW9uIHVwZGF0ZSBjb2RlIGZvciB0aGVtc2VsdmVzIChmb3IgZXhhbXBsZSwgYmVjYXVz
ZSB0aGV5IGhhdmUgbGVmdA0KPiB0aGUgY3B1ZnJlcSBwb2xpY2llcyB0aGF0IHRoZXkgYmVsb25n
ZWQgdG8pLCBzaG91bGQgYWxzbyBiZSBwcmV2ZW50ZWQgZnJvbQ0KPiBydW5uaW5nIHRoYXQgY29k
ZSBvbiBiZWhhbGYgb2YgdGhlIG90aGVyIENQVXMgdGhhdCBiZWxvbmcgdG8gYSBjcHVmcmVxIHBv
bGljeQ0KPiB3aXRoIGR2ZnNfcG9zc2libGVfZnJvbV9hbnlfY3B1IHNldCBhbmQgc28gaW4gdGhh
dCBjYXNlIHRoZQ0KPiBjcHVmcmVxX3VwZGF0ZV91dGlsX2RhdGEgcG9pbnRlciBvZiB0aGUgQ1BV
IHJ1bm5pbmcgdGhlIGNvZGUgbXVzdCBub3QgYmUNCj4gTlVMTCBhcyB3ZWxsIGFzIGZvciB0aGUg
Q1BVIHdoaWNoIGlzIHRoZSB0YXJnZXQgb2YgdGhlIGNwdWZyZXEgdXRpbGl6YXRpb24NCj4gdXBk
YXRlIGluIHByb2dyZXNzLg0KPiANCj4gQWNjb3JkaW5nbHksIGNoYW5nZSBjcHVmcmVxX3RoaXNf
Y3B1X2Nhbl91cGRhdGUoKSBpbnRvIGEgcmVndWxhciBmdW5jdGlvbg0KPiBpbiBrZXJuZWwvc2No
ZWQvY3B1ZnJlcS5jIChpbnN0ZWFkIG9mIGEgc3RhdGljIGlubGluZSBpbiBhIGhlYWRlciBmaWxl
KSBhbmQNCj4gbWFrZSBpdCBjaGVjayB0aGUgY3B1ZnJlcV91cGRhdGVfdXRpbF9kYXRhIHBvaW50
ZXIgb2YgdGhlIGxvY2FsIENQVSBpZg0KPiBkdmZzX3Bvc3NpYmxlX2Zyb21fYW55X2NwdSBpcyBz
ZXQgZm9yIHRoZSB0YXJnZXQgY3B1ZnJlcSBwb2xpY3kuDQo+IA0KPiBBbHNvIHVwZGF0ZSB0aGUg
c2NoZWR1dGlsIGdvdmVybm9yIHRvIGRvIHRoZQ0KPiBjcHVmcmVxX3RoaXNfY3B1X2Nhbl91cGRh
dGUoKSBjaGVjayBpbiB0aGUgbm9uLWZhc3Qtc3dpdGNoIGNhc2UgdG9vIHRvDQo+IGF2b2lkIHRo
ZSBzdGFsZSBJUlEgd29yayBpc3N1ZXMuDQo+IA0KPiBGaXhlczogOTlkMTRkMGUxNmZhICgiY3B1
ZnJlcTogUHJvY2VzcyByZW1vdGUgY2FsbGJhY2tzIGZyb20gYW55IENQVSBpZiB0aGUNCj4gcGxh
dGZvcm0gcGVybWl0cyIpDQo+IExpbms6DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUuaw0KPiBlcm5lbC5vcmcl
MkZsaW51eC1wbSUyRjIwMTkxMTIxMDkzNTU3LmJ5Y3ZkbzR4eWluYmM1Y2IlNDB2aXJlc2hrLQ0K
PiBpNyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDOTY5ODcy
YTBkNzAxDQo+IDRhMTRiMDdiMDhkNzdlMjRlNWI3JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTlj
NWMzMDE2MzUlN0MwJTdDMA0KPiAlN0M2MzcxMTY1NjkyNTExOTM1NTImYW1wO3NkYXRhPWhwTVZa
THYyJTJCeCUyRjRzMVZkMjM5dXdWSlhpDQo+IGFXVGNPTWdrVklMdmo1bmloNCUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KPiBSZXBvcnRlZC1ieTogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+
DQo+IENjOiA0LjE0KyA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA0LjE0Kw0KPiBTaWduZWQt
b2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQoN
ClBhc3NlZCBvdmVyIDEgZGF5IENQVSBob3RwbHVnIHN0cmVzcyB0ZXN0IG9uIHNpbmdsZS9kdWFs
IGNsdXN0ZXJzIHBsYXRmb3Jtcy4NCiANClRlc3RlZC1ieTogQW5zb24gSHVhbmcgPGFuc29uLmh1
YW5nQG54cC5jb20+DQoNCg==
