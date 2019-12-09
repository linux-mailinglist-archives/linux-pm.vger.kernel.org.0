Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C36DB116D21
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 13:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLIMcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 07:32:10 -0500
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:30765
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727074AbfLIMcK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 07:32:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mjd/PbXcZ5rxUsCMlLZF5KcT9LUg0TMRAaxmTgkFLCz2BTURhxjE1IQDVdEBUca0n46zjTL/0mRdYvECIwwPRwfbmpJFFZ10f1WXQdAuCxsZ/ki/xe74GVGKy3BAEhS0kWFH8JG6ez2i/FaXjFjjr9VwEGzVIaOZtWkdX+5zD1IoDqDe6sJhL+b8+wMso849RwAQwFea5Xhlurq8A5k7WbluCcgk0jwN6eIpDiFb3zp8apBC8lmypniTbAwj7dDibOX7DeADTGChF0bNCcC/Ef3hWV0iC/LwWcFZgqisA+4xu/vAlTXGt4Is0eHN+Am+pOYes0KZSS15zkCQrmUtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHlkJMyLnrHWFKYrpcDMxZtoeTnaX8Nb2UZkAoQI+g0=;
 b=YRtZjxEr8okmWqSQxWQLm7u+Z5bgRZwvBwA/qPiAU5DCh7KzDKmKO4IYER/1x0p9a8Wao/3I3ssfxVpYnLi1ooxfR6Tvfgb40HwbhAFMCMpI5WAKyiP41qcRS5xTNDj+C9Ej6oGd3Lib8tcGfUqBDctzcgTvg/spVLj2wa7X3vDfN7p6mATCTPETxYzgFRHJ7tdsZaY4VhFTlbEoeqfVdhOV2K3Epld0ivtA7OMy7u84y31nsxOA8yYbvWarjsxOHNBCme+gf2dxKo+qVHMbeUe8Wp/s+20FM12NilD4SXiZm4PjHMEKT2Mrpv+ag7Tf2bR8UJ7PaUY39l4n849mfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHlkJMyLnrHWFKYrpcDMxZtoeTnaX8Nb2UZkAoQI+g0=;
 b=lAaoDeEupkPGBXfiDAPeCH54xh3+xHTbP59PuiZvynFHwPAYgURTgWo5MF0xcQPyML6GMwgo0Q/51AVpL2fOjaxhxhsqA7dlKWlQCmUjfONbyZzCzJVIAUN3DR79cUBIdA8ye2aGt+JOqXbz4wL6PMWpYXpj5wkDwR1kNuz3Pf0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3691.eurprd04.prod.outlook.com (52.134.66.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Mon, 9 Dec 2019 12:32:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1%6]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 12:32:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peng Fan <peng.fan@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUgASMyDZAABHGSAAAFLgggAAVyLYAAvd+WYAAA3omQAAEGDYAAAmWbRg==
Date:   Mon, 9 Dec 2019 12:32:07 +0000
Message-ID: <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher>
 <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>,<CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.18.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ae137d0-4e56-48fc-f7e1-08d77ca3cde7
x-ms-traffictypediagnostic: DB3PR0402MB3691:|DB3PR0402MB3691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36919498B59E504CCCB3C85DF5580@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(189003)(199004)(6506007)(2906002)(36756003)(8676002)(8936002)(81156014)(6916009)(229853002)(81166006)(316002)(4326008)(53546011)(6512007)(6486002)(54906003)(71200400001)(71190400001)(86362001)(76116006)(33656002)(66946007)(66556008)(91956017)(64756008)(186003)(2616005)(26005)(66446008)(5660300002)(478600001)(305945005)(66476007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3691;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: evuV5Vm6AEKpWnQwDxfDWXlWhTHZG850THU2E77L52ePK4kg5ROLSCSzOCnIhlHo32SOprAPkxoQA/utKYGepe2pDspLWVQBeC3u6RWNWYq72FVcIHq5+JKiniKLAaWAbzo3bkrZAt5cPlu94PcWkFTagdeWKKTM76KEXKqnFCqx1+/U4/pnD35MlqZQtetdNZPhcGczFEDCccOVfWoEYPrfiMmV0y4Vrg/ytZMv28wvcvje00h9RdGNFInoWOhs1jHLxOxTrnR5L7CVb77maAYDAKAOnbR0PTwWc127GpJtBZuosZzfXjG4DQGLpYT6k/4rKCTjv5aZpJkVzwjjCsZ8aMny/SzADoscTy7scA251txfUXWPZ5LLvkZvSBx4IcCFGfo99uiF9IbgviSKouRlh/N9ebATmjDXHS7kD4CyzJA0wgm8CkzZ6fWpjjhZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae137d0-4e56-48fc-f7e1-08d77ca3cde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 12:32:07.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zmb+X1wEo11D6K4c4QEPaWo8q1kd6oY2cqkOWQsduvTJNEawkywQMDa7FRyuihuU5ewf9lD3ShA5o4Or3KS0LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCkZyb20gQW5zb24ncyBpUGhvbmUgNg0KDQoNCj4g5ZyoIDIwMTnlubQxMuaciDnml6XvvIwx
OToyM++8jFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4g5YaZ6YGT77yaDQo+
IA0KPj4gT24gTW9uLCBEZWMgOSwgMjAxOSBhdCAxMTo1NyBBTSBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4gd3JvdGU6DQo+PiANCj4+IEZvcmdvdCB0byBtZW50aW9uZWQgdGhhdCBi
ZWxvdyBwYXRjaCBvbiB2NS40IGNhbiBlYXNpbHkgcmVwcm9kdWNlIHRoZSBwYW5pYygpIG9uIG91
ciBwbGF0Zm9ybXMgd2hpY2ggSSB0aGluayBpcyB1bmV4cGVjdGVkLCBhcyB0aGUgcG9saWN5LT5j
cHVzIGFscmVhZHkgYmUgdXBkYXRlZCBhZnRlciBnb3Zlcm5vciBzdG9wLCBidXQgc3RpbGwgdHJ5
IHRvIGhhdmUgaXJxIHdvcmsgcXVldWVkIG9uIGl0Lg0KPj4gDQo+PiBzdGF0aWMgdm9pZCBkYnNf
dXBkYXRlX3V0aWxfaGFuZGxlcihzdHJ1Y3QgdXBkYXRlX3V0aWxfZGF0YSAqZGF0YSwgdTY0IHRp
bWUsIHVuc2lnbmVkIGludCBmbGFncykNCj4+ICsgICAgICAgaWYgKCFjcHVtYXNrX3Rlc3RfY3B1
KHNtcF9wcm9jZXNzb3JfaWQoKSwgcG9saWN5X2Ricy0+cG9saWN5LT5jcHVzKSkNCj4+ICsgICAg
ICAgICAgICAgICBwYW5pYygiLi4uaXJxIHdvcmsgb24gb2ZmbGluZSBjcHUgJWRcbiIsIHNtcF9w
cm9jZXNzb3JfaWQoKSk7DQo+PiAgICAgICAgaXJxX3dvcmtfcXVldWUoJnBvbGljeV9kYnMtPmly
cV93b3JrKTsNCj4gDQo+IFllcywgdGhhdCBpcyB1bmV4cGVjdGVkLg0KPiANCj4gSW4gY3B1ZnJl
cV9vZmZsaW5lKCksIHdlIGhhdmU6DQo+IA0KPiAgICBkb3duX3dyaXRlKCZwb2xpY3ktPnJ3c2Vt
KTsNCj4gICAgaWYgKGhhc190YXJnZXQoKSkNCj4gICAgICAgIGNwdWZyZXFfc3RvcF9nb3Zlcm5v
cihwb2xpY3kpOw0KPiANCj4gICAgY3B1bWFza19jbGVhcl9jcHUoY3B1LCBwb2xpY3ktPmNwdXMp
Ow0KPiANCj4gYW5kIGNwdWZyZXFfc3RvcF9nb3Zlcm5vcigpIGNhbGxzIHBvbGljeS0+Z292ZXJu
b3ItPnN0b3AocG9saWN5KSB3aGljaA0KPiBpcyBjcHVmcmVxX2Ric19nb3Zlcm5vcl9zdG9wKCku
DQo+IA0KPiBUaGF0IGNhbGxzIGdvdl9jbGVhcl91cGRhdGVfdXRpbChwb2xpY3lfZGJzLT5wb2xp
Y3kpIGZpcnN0LCB3aGljaA0KPiBpbnZva2VzIGNwdWZyZXFfcmVtb3ZlX3VwZGF0ZV91dGlsX2hv
b2soKSBmb3IgZWFjaCBDUFUgaW4gcG9saWN5LT5jcHVzDQo+IGFuZCBzeW5jaHJvbml6ZXMgUkNV
LCBzbyBhZnRlciB0aGF0IHBvaW50IG5vbmUgb2YgdGhlIHBvbGljeS0+Y3B1cyBpcw0KPiBleHBl
Y3RlZCB0byBydW4gZGJzX3VwZGF0ZV91dGlsX2hhbmRsZXIoKS4NCj4gDQo+IHBvbGljeS0+Y3B1
cyBpcyB1cGRhdGVkIG5leHQgYW5kIHRoZSBnb3Zlcm5vciBpcyBzdGFydGVkIGFnYWluIHdpdGgN
Cj4gdGhlIG5ldyBwb2xpY3ktPmNwdXMuICBCZWNhdXNlIHRoZSBvZmZsaW5lIENQVSBpcyBub3Qg
dGhlcmUsIGl0IGlzIG5vdA0KPiBleHBlY3RlZCB0byBydW4gZGJzX3VwZGF0ZV91dGlsX2hhbmRs
ZXIoKSBhZ2Fpbi4NCj4gDQo+IERvIHlvdSBvbmx5IGdldCB0aGUgb3JpZ2luYWwgZXJyb3Igd2hl
biBvbmUgb2YgdGhlIENQVXMgZ29lcyBiYWNrIG9ubGluZT8NCg0KTm8sIHNvbWV0aW1lcyBJIGFs
c28gZ290IHRoaXMgZXJyb3IgZHVyaW5nIGEgQ1BVIGlzIGJlaW5nIG9mZmxpbmUuDQoNCkJ1dCB0
aGUgcG9pbnQgaXMgTk9UIHRoYXQgZGJzX3VwZGF0ZV91dGlsX2hhbmRsZXIoKSBjYWxsZWQgZHVy
aW5nIGdvdmVybm9yIHN0b3AsIGl0IGlzIHRoYXQgdGhpcyBmdW5jdGlvbiBpcyBydW5uaW5nIG9u
IGEgQ1BVIHdoaWNoIGFscmVhZHkgZmluaXNoIHRoZSBnb3Zlcm5vciBzdG9wIGZ1bmN0aW9uLCBJ
IHRob3VnaHQgdGhlIG9yaWdpbmFsIGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhpcyBmdW5jdGlvbiBP
TkxZIGJlIGV4ZWN1dGVkIG9uIHRoZSBDUFUgd2hpY2ggbmVlZHMgc2NhbGluZyBmcmVxdWVuY3k/
IElzIHRoaXMgY29ycmVjdD8gdjQuMTkgZm9sbG93cyB0aGlzIGV4cGVjdGF0aW9uIHdoaWxlIHY1
LjQgaXMgTk9ULiANCg0KVGhlIG9ubHkgdGhpbmcgSSBjYW4gaW1hZ2UgaXMgdGhlIGNoYW5nZXMg
aW4ga2VybmVsL3NjaGVkLyBmb2xkZXIgY2F1c2UgdGhpcyBkaWZmZXJlbmNlLCBidXQgSSBzdGls
bCBuZWVkIG1vcmUgdGltZSB0byBmaWd1cmUgb3V0IHdoYXQgY2hhbmdlcyBjYXVzZSBpdCwgaWYg
eW91IGhhdmUgYW55IHN1Z2dlc3Rpb24sIHBsZWFzZSBhZHZpc2UsIHRoYW5rcyENCg0KQW5zb24=
