Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A66116ED8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 15:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfLIOSN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 09:18:13 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:36846
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLIOSM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 09:18:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIeauH3MO6SL3n9xPFqIibUr4gOsnLICwqwz7Z3lmpayPdYPXGqfLyT3O8YQ7n6cUff0x8X0/yxy3LK55iT4O4sDI+7Ho8ggJy7JtVFjmnTkxsaR06b8e8leCylnZ4WsddEbXIwp4TEQNvwx1cUmS9GE5fi3vETJrZOGDl2XOBPP5aEgYBIaTUzUfcp/mqGG8GAY1h68D/Y/awyAPeMxFbSgFurschvh52Y31uw7X9fsV//G129+KdugdO+eG+R2KwvOvD0KOkPWefrQnniU5xj8hsAY70dY8sSFzKUdAN6Z7EQdZwKN0ain3miJfsN7y+DZBET5UnLh6WNIzOP+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZNqZqEOSpOarukui7NZtih/mMfDuRqOAFEPm57U8+I=;
 b=PYdTgMrOdlHFcwP0XeF1QrEomozsybHdCRn13h0ssM3WOkVok/vGI0M76aqNDJ9pEN9rsk1i4QWlwrVZNSFKbASsoeCBobkN8r5lQNKxd9OAhSR8cLv7+tOa6y6LYGPN+0T5hnrNfZo19jxT52DOlh7rIlMbYMUY2crOVIpfg8F6owV6sPXBKL77oxM0oBgnU+zXUrBi/dchR1FjWPcSWsXWdBByC1jPK4q5mByjLX4d6beShmXFdpu2FD3JrC5dGsWZ0QHi8WmCKnWebAvPwSwPNFJztQEn32WwCUPrWdubThaUVKUIQjeOpEJYbZbtcZUVMJLaTT+s0ADcVqeIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZNqZqEOSpOarukui7NZtih/mMfDuRqOAFEPm57U8+I=;
 b=HQIU0ZD7LRMJn8RX46bB7RbAzfGgcB+I95I5NFDbjBlEJTTAywoZl4UujB11IyS5gh11q1OAQsd0YV2uinke0h9bg/Z14f9yyLM8NzKUbO4rKCErETOOAnwdtUGUPUQK3mVrAyBit+L0WQVrON9YGIkJqY+ROUNtt/vD/pl8y4g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Mon, 9 Dec 2019 14:18:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b5ce:fe6b:6c06:fdb1%6]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 14:18:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peng Fan <peng.fan@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUgASMyDZAABHGSAAAFLgggAAVyLYAAvd+WYAAA3omQAAEGDYAAAmWbRgAAcGGAAANDXIA=
Date:   Mon, 9 Dec 2019 14:18:08 +0000
Message-ID: <E8129DCF-DE0A-4497-A475-E3876E884DE5@nxp.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher>
 <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
 <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [2409:891e:9161:168:b1d2:a044:a19e:2890]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f9f6794-a91d-4711-7429-08d77cb29d83
x-ms-traffictypediagnostic: DB3PR0402MB3850:|DB3PR0402MB3850:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3850E1B279CEABCD3326E246F5580@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(8676002)(81166006)(305945005)(478600001)(53546011)(6506007)(5660300002)(66446008)(66556008)(64756008)(81156014)(229853002)(36756003)(8936002)(186003)(86362001)(6916009)(4326008)(2616005)(33656002)(44832011)(316002)(71200400001)(6486002)(6512007)(76116006)(91956017)(66476007)(71190400001)(2906002)(66946007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nt1u7lsgEL/+A94mjSPxfXIq6hu5zAp1fpNy4YuIG42uQsFs44Tk7Zfw1dXirokPTF49SUw/6OoaDSeBTeuORi6qXzR6iLpQViEGljVt8NjsF5XVlR22Z5CL+CAI2pvpM0CRwSKKDpZgjZ309vnB+2SKfJW0aSaFlvt235wWii+LuNwZRpAX0T6XtiJ5BzXlCYvY6ej/CQr/00BjVW+6hj/00/+acS3ssPyv64U6P/Qpgi6yGnkaU30/U3Ux/EiduVpd0/81h5jC9i9RaSWYAyKRlsA+N2jRmwbBaBNiig4AnYdFQme3qNrnwmt8On1tDcUh7P+Htw2945HVbgvmOj4bkJmfN7phkh2sRoi5h/N6vT4p1FyQRg8uGs25+N4wGnEAnoJdsKpMOaF785bsJi14I/i2PZZ/lPSn/hu1STXyY3cq+rrU1bix8NxGRhaY
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D063B76787521438FB47A478AD6B3C4@NXP1.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9f6794-a91d-4711-7429-08d77cb29d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 14:18:08.3935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qes/yypbbJsXnGP4dUXGJcszd5LOPUFFli0UyMvrns+sWn/4pRZSaFlqYgQ/jgvcw6aallh7tqPdi4YXURPlsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Q291bGQgaXQgYmUgY2F1c2VkIGJ5IOKAnHBvbGljeS0+ZHZmc19wb3NzaWJsZV9mcm9tX2FueV9j
cHXigJ0gYWx3YXlzIGJlaW5nIFRSVUUsIHNvIHRoYXQgdGhlIHBsYXRmb3JtcyB1c2luZyBjcHVm
cmVxLWR0IGRyaXZlciB3aWxsIGhhdmUgc3VjaCBpc3N1ZT8gSSB0aGluayBJIG1hZGUgYSBtaXN0
YWtlIHRoYXQgdjQuMTkgZG9lcyBOT1QgaGF2ZSBzdWNoIGlzc3VlIG9uIGkuTVggcGxhdGZvcm1z
IGlzIGJlY2F1c2Ugd2UgZG9u4oCZdCB1c2UgY3B1ZnJlcS1kdCBkcml2ZXIgd2hpbGUgdjUuNCB3
ZSBzd2l0Y2ggdG8gaXQuIEkgY2FuIHZlcmlmeSBpdCBhZ2FpbiB0b21vcnJvdyB0byBzZWUgaWYg
djQuMTkgYWxzbyBoYXZlIHN1Y2ggaXNzdWUgYnkgZm9yY2luZyBwb2xpY3ktPmR2ZnNfcG9zc2li
bGVfZnJvbV9hbnlfY3B1IHRvIGJlIFRSVUUuDQoNCkhpLCBWaXJlc2gNCiAgICAgICBZb3UgZXZl
ciB0cmllZCB0byByZXByb2R1Y2UgaXQgb24geW91ciBoYW5kLCB0aGUgcGxhdGZvcm0geW91IHVz
ZWQgaXMgdXNpbmcgY3B1ZnJlcS1kdCBkcml2ZXIgb3IgTk9UPw0KDQpGcm9tIEFuc29uJ3MgaVBo
b25lIDYNCg0KDQo+PiDlnKggMjAxOeW5tDEy5pyIOeaXpe+8jDIwOjQ077yMUmFmYWVsIEouIFd5
c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPiDlhpnpgZPvvJoNCj4+IA0KPj4gT24gTW9uLCBEZWMg
OSwgMjAxOSBhdCAxOjMyIFBNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPiB3cm90
ZToNCj4+IA0KPj4gDQo+PiANCj4+IEZyb20gQW5zb24ncyBpUGhvbmUgNg0KPj4gDQo+PiANCj4+
Pj4g5ZyoIDIwMTnlubQxMuaciDnml6XvvIwxOToyM++8jFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZh
ZWxAa2VybmVsLm9yZz4g5YaZ6YGT77yaDQo+Pj4+IA0KPj4+PiBPbiBNb24sIERlYyA5LCAyMDE5
IGF0IDExOjU3IEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPiB3cm90ZToNCj4+
Pj4gDQo+Pj4+IEZvcmdvdCB0byBtZW50aW9uZWQgdGhhdCBiZWxvdyBwYXRjaCBvbiB2NS40IGNh
biBlYXNpbHkgcmVwcm9kdWNlIHRoZSBwYW5pYygpIG9uIG91ciBwbGF0Zm9ybXMgd2hpY2ggSSB0
aGluayBpcyB1bmV4cGVjdGVkLCBhcyB0aGUgcG9saWN5LT5jcHVzIGFscmVhZHkgYmUgdXBkYXRl
ZCBhZnRlciBnb3Zlcm5vciBzdG9wLCBidXQgc3RpbGwgdHJ5IHRvIGhhdmUgaXJxIHdvcmsgcXVl
dWVkIG9uIGl0Lg0KPj4+PiANCj4+Pj4gc3RhdGljIHZvaWQgZGJzX3VwZGF0ZV91dGlsX2hhbmRs
ZXIoc3RydWN0IHVwZGF0ZV91dGlsX2RhdGEgKmRhdGEsIHU2NCB0aW1lLCB1bnNpZ25lZCBpbnQg
ZmxhZ3MpDQo+Pj4+ICsgICAgICAgaWYgKCFjcHVtYXNrX3Rlc3RfY3B1KHNtcF9wcm9jZXNzb3Jf
aWQoKSwgcG9saWN5X2Ricy0+cG9saWN5LT5jcHVzKSkNCj4+Pj4gKyAgICAgICAgICAgICAgIHBh
bmljKCIuLi5pcnEgd29yayBvbiBvZmZsaW5lIGNwdSAlZFxuIiwgc21wX3Byb2Nlc3Nvcl9pZCgp
KTsNCj4+Pj4gICAgICBpcnFfd29ya19xdWV1ZSgmcG9saWN5X2Ricy0+aXJxX3dvcmspOw0KPj4+
IA0KPj4+IFllcywgdGhhdCBpcyB1bmV4cGVjdGVkLg0KPj4+IA0KPj4+IEluIGNwdWZyZXFfb2Zm
bGluZSgpLCB3ZSBoYXZlOg0KPj4+IA0KPj4+ICBkb3duX3dyaXRlKCZwb2xpY3ktPnJ3c2VtKTsN
Cj4+PiAgaWYgKGhhc190YXJnZXQoKSkNCj4+PiAgICAgIGNwdWZyZXFfc3RvcF9nb3Zlcm5vcihw
b2xpY3kpOw0KPj4+IA0KPj4+ICBjcHVtYXNrX2NsZWFyX2NwdShjcHUsIHBvbGljeS0+Y3B1cyk7
DQo+Pj4gDQo+Pj4gYW5kIGNwdWZyZXFfc3RvcF9nb3Zlcm5vcigpIGNhbGxzIHBvbGljeS0+Z292
ZXJub3ItPnN0b3AocG9saWN5KSB3aGljaA0KPj4+IGlzIGNwdWZyZXFfZGJzX2dvdmVybm9yX3N0
b3AoKS4NCj4+PiANCj4+PiBUaGF0IGNhbGxzIGdvdl9jbGVhcl91cGRhdGVfdXRpbChwb2xpY3lf
ZGJzLT5wb2xpY3kpIGZpcnN0LCB3aGljaA0KPj4+IGludm9rZXMgY3B1ZnJlcV9yZW1vdmVfdXBk
YXRlX3V0aWxfaG9vaygpIGZvciBlYWNoIENQVSBpbiBwb2xpY3ktPmNwdXMNCj4+PiBhbmQgc3lu
Y2hyb25pemVzIFJDVSwgc28gYWZ0ZXIgdGhhdCBwb2ludCBub25lIG9mIHRoZSBwb2xpY3ktPmNw
dXMgaXMNCj4+PiBleHBlY3RlZCB0byBydW4gZGJzX3VwZGF0ZV91dGlsX2hhbmRsZXIoKS4NCj4+
PiANCj4+PiBwb2xpY3ktPmNwdXMgaXMgdXBkYXRlZCBuZXh0IGFuZCB0aGUgZ292ZXJub3IgaXMg
c3RhcnRlZCBhZ2FpbiB3aXRoDQo+Pj4gdGhlIG5ldyBwb2xpY3ktPmNwdXMuICBCZWNhdXNlIHRo
ZSBvZmZsaW5lIENQVSBpcyBub3QgdGhlcmUsIGl0IGlzIG5vdA0KPj4+IGV4cGVjdGVkIHRvIHJ1
biBkYnNfdXBkYXRlX3V0aWxfaGFuZGxlcigpIGFnYWluLg0KPj4+IA0KPj4+IERvIHlvdSBvbmx5
IGdldCB0aGUgb3JpZ2luYWwgZXJyb3Igd2hlbiBvbmUgb2YgdGhlIENQVXMgZ29lcyBiYWNrIG9u
bGluZT8NCj4+IA0KPj4gTm8sIHNvbWV0aW1lcyBJIGFsc28gZ290IHRoaXMgZXJyb3IgZHVyaW5n
IGEgQ1BVIGlzIGJlaW5nIG9mZmxpbmUuDQo+PiANCj4+IEJ1dCB0aGUgcG9pbnQgaXMgTk9UIHRo
YXQgZGJzX3VwZGF0ZV91dGlsX2hhbmRsZXIoKSBjYWxsZWQgZHVyaW5nIGdvdmVybm9yIHN0b3As
DQo+PiBpdCBpcyB0aGF0IHRoaXMgZnVuY3Rpb24gaXMgcnVubmluZyBvbiBhIENQVSB3aGljaCBh
bHJlYWR5IGZpbmlzaCB0aGUgZ292ZXJub3Igc3RvcA0KPj4gZnVuY3Rpb24sDQo+IA0KPiBZZXMs
IGl0IGlzLCBhbmQgd2hpY2ggc2hvdWxkIG5vdCBiZSBwb3NzaWJsZSBhcyBwZXIgdGhlIGFib3Zl
Lg0KPiANCj4gVGhlIG9mZmxpbmUgQ1BVIGlzIG5vdCB0aGVyZSBpbiBwcm9saWN5LT5jcHVzIHdo
ZW4NCj4gY3B1ZnJlcV9kYnNfZ292ZXJub3Jfc3RhcnQoKSBpcyBjYWxsZWQgZm9yIHRoZSBwb2xp
Y3ksIHNvIGl0cw0KPiBjcHVmcmVxX3VwZGF0ZV91dGlsX2RhdGEgcG9pbnRlciBpcyBub3Qgc2V0
IChpdCBpcyBOVUxMIGF0IHRoYXQgdGltZSkuDQo+IFRoZXJlZm9yZSBpdCBpcyBub3QgZXhwZWN0
ZWQgdG8gcnVuIGRic191cGRhdGVfdXRpbF9oYW5kbGVyKCkgdW50aWwgaXQNCj4gaXMgdHVybiBi
YWNrIG9ubGluZS4NCj4gDQo+PiBJIHRob3VnaHQgdGhlIG9yaWdpbmFsIGV4cGVjdGF0aW9uIGlz
IHRoYXQgdGhpcyBmdW5jdGlvbiBPTkxZIGJlIGV4ZWN1dGVkIG9uIHRoZSBDUFUgd2hpY2ggbmVl
ZHMgc2NhbGluZyBmcmVxdWVuY3k/DQo+PiBJcyB0aGlzIGNvcnJlY3Q/DQo+IA0KPiBZZXMsIGl0
IGlzLg0KPiANCj4+IHY0LjE5IGZvbGxvd3MgdGhpcyBleHBlY3RhdGlvbiB3aGlsZSB2NS40IGlz
IE5PVC4NCj4gDQo+IEFzIHBlciB0aGUga2VybmVsIGNvZGUsIHRoZXkgYm90aCBkby4NCj4gDQo+
PiBUaGUgb25seSB0aGluZyBJIGNhbiBpbWFnZSBpcyB0aGUgY2hhbmdlcyBpbiBrZXJuZWwvc2No
ZWQvIGZvbGRlciBjYXVzZSB0aGlzIGRpZmZlcmVuY2UsIGJ1dCBJIHN0aWxsIG5lZWQgbW9yZSB0
aW1lIHRvIGZpZ3VyZSBvdXQgd2hhdCBjaGFuZ2VzIGNhdXNlIGl0LCBpZiB5b3UgaGF2ZSBhbnkg
c3VnZ2VzdGlvbiwgcGxlYXNlIGFkdmlzZSwgdGhhbmtzIQ0KPiANCj4gVGhlIENQVSBvZmZsaW5l
L29ubGluZSAoaG90cGx1ZykgcmV3b3JrIHdhcyBkb25lIGFmdGVyIDQuMTkgSUlSQyBhbmQNCj4g
dGhhdCBjaGFuZ2VkIHRoZSB3YXkgb25saW5lIHdvcmtzLiAgTm93LCBpdCBydW5zIG9uIHRoZSBD
UFUgZ29pbmcNCj4gb25saW5lIGFuZCBwcmV2aW91c2x5IGl0IHJhbiBvbiB0aGUgQ1BVICJhc2tp
bmciIHRoZSBvdGhlciBvbmUgdG8gZ28NCj4gb25saW5lLiAgVGhhdCBtYXkgYmUgd2hhdCBtYWtl
cyB0aGUgZGlmZmVyZW5jZSAoaWYgbXkgcmVjb2xsZWN0aW9uIG9mDQo+IHRoZSB0aW1lIGZyYW1l
IGlzIGNvcnJlY3QpLg0K
