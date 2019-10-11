Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAEED45F2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfJKQ6e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 12:58:34 -0400
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:55264
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728167AbfJKQ6e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 12:58:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al7Jcmd8QQvWOj+CceQBqn9LCr9cr+SIEvmK67pIdDDCuIwXGfGL6UIvENp9u71/++SOYq8+vu+tZEOyjH7tT7oX6zaFxd8hIfr8Ns7vMIx2D2i2VPw1Vf1IEpdtBwHinNDQkHelA3TNIs86Z48otP41Pz6JjyY46VStqehaSlp2oObtJYKxdRncj8ACG1mFUtyz9VYWxjryb3SU87JCiOExVPycgxGcl6mvh1f1TkqUxmtzbrNgfpNllNhuUi6aZ6JuYdi76iHWzlI9gQ9IfOUe1xi54NsEY0OdAXFpdMqdfoU9WZEc6PzLcou/fDihFbZnAdAWOno52ds8zX929w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Egx312LGY7cM26lJLKzlgA+lJ5oqM2LMPFEpg+lYSc=;
 b=Eew2WtdQ63H8MGPhooXdw96fHqjEUKbR0+cShdtzLSrt4bDuS09elvPBw4fQqwTt8dO5rwIeeynZ+cDrzyMWv+7lwKhiwi3TIO7ydfJvIRYDZiG96Yi7+6BppMMrb0wIK1I43jlWk/8lZKqzgojVwyqrxaPOeVaUb2IQivuE1uFEz0chcwbcvMhzk+Rq4toWWnRrbZyXJD6zkLGIaKytHrlb46Od4R5BWil0oTBR8qMx2CbQLqyMK+q25AvoqnFAs1RoyDp4G6pu/sgl167ZCJLudkgmNYXogddWcAhm1ruNeDdKI7r6UT9LPr7XKW3lD3wdOmjEdSPU16BZRA7VYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Egx312LGY7cM26lJLKzlgA+lJ5oqM2LMPFEpg+lYSc=;
 b=BefRxX1XEEtURRDS+pSqiMEna9Eb58rgwzcTMrqjWV0AY4aF0dc2psLYCtRpo5qdtyeR+hF1eO+l8m7Q3nP+XoqoCgDRdbuhFUFsLHoR0IW7Btp02a501Hd0GPapdTDY1m6LHxw2TV9jmm7tIqrcnID15wxqt3nK8Ov05yqloiM=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2607.namprd12.prod.outlook.com (52.135.102.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 11 Oct 2019 16:58:30 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 16:58:30 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     Thomas Renninger <trenn@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Pu Wen <puwen@hygon.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Topic: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Index: AQHVbj8CzXj8hQvM60aQ8slBTBcq36c/ayGAgACy6gCAB2VngIAElFSAgAOzTQCABBJlgIAB8D4A
Date:   Fri, 11 Oct 2019 16:58:30 +0000
Message-ID: <78c11c13-901e-7570-7822-a4a336d287b1@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
 <1798336.DyNOivuPDK@c100> <f2dc183f-68a5-d98d-7758-bad224578737@amd.com>
 <3292474.drSXM59XT9@skinner.arch.suse.de>
In-Reply-To: <3292474.drSXM59XT9@skinner.arch.suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:805::19) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b399a2c-6b88-44da-531c-08d74e6c3e0c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2607:|SN6PR12MB2607:
x-microsoft-antispam-prvs: <SN6PR12MB26070FED2FC81038BCCF9550E7970@SN6PR12MB2607.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(26005)(486006)(8676002)(256004)(14444005)(54906003)(66066001)(71200400001)(71190400001)(316002)(36756003)(7736002)(11346002)(99286004)(478600001)(86362001)(2906002)(2616005)(31696002)(305945005)(229853002)(476003)(14454004)(386003)(53546011)(446003)(6506007)(7416002)(52116002)(76176011)(102836004)(186003)(4326008)(6916009)(6436002)(5660300002)(6246003)(31686004)(81156014)(8936002)(66476007)(81166006)(25786009)(6116002)(3846002)(66946007)(6512007)(66446008)(64756008)(66556008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2607;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+ecpuxA0XUVvw5zmxz4mtSaWoM3GTqI+ViUOS/kvhLtXvutmz78uIeV8qIRfuURTODWrcm3VxMge5SeqR3Rj1Ed+lkhmX9SNS9Gj1lXVurmniQ1pelBInychk4XGR+WjIFNnLOJnkub2kHYKt1e9Bjhd3rbxpnTE7oHNJ5uLTKHEvR+Fc1WgpB+zzEpe9+mHqtU6ide/Qm6IoOZJ1r1fA3N7npCwMpLI8OUN2JvpKlslgKImK4IP3WhuM0RTGgcBR3m5U3uGoe43pJ4W1ePfavAu5thXoidF2akZSswOOPQv2WE1pPLQg0X8C5IIU0zn21+k3O7WF63AkZZ9vMa5drOEvlg/2U4JcTgG5aJm9jtc9Ws6c2L/J2NZ1yjdrAmMhUOA47LEuqRspO1wZnsRkZsLIAabizQTeL0vMfMTE8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6F3B99F29BBBA4388FA2BE39C335126@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b399a2c-6b88-44da-531c-08d74e6c3e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 16:58:30.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrhmovfA6K8PHsvGP7wPjw7woG+1hQVO29OaxMFJjPUY7aBBN834RwhcRkvpBaQJqLl99yRrM4e+DNktqY2dzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2607
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTAvMTAvMjAxOSA2OjIyIEFNLCBUaG9tYXMgUmVubmluZ2VyIHdyb3RlOg0KPiBPbiBNb25k
YXksIE9jdG9iZXIgNywgMjAxOSAxMToxMTozMCBQTSBDRVNUIE5hdGFyYWphbiwgSmFuYWthcmFq
YW4gd3JvdGU6DQo+PiBPbiAxMC81LzIwMTkgNzo0MCBBTSwgVGhvbWFzIFJlbm5pbmdlciB3cm90
ZToNCj4+DQo+IC4uLg0KPj4+PiBBUEVSRi9NUEVSRiBmcm9tIENQTCA+IDApIGFuZCBhdm9pZCB1
c2luZyB0aGUgbXNyIG1vZHVsZSAocGF0Y2ggMikuDQo+Pj4gQW5kIHRoaXMgb25lIG9ubHkgZXhp
c3RzIG9uIGxhdGVzdCBBTUQgY3B1cywgcmlnaHQ/DQo+PiBZZXMuIFRoZSBSRFBSVSBpbnN0cnVj
dGlvbiBleGlzdHMgb25seSBvbiBBTUQgY3B1cy4NCj4+Pj4gSG93ZXZlciwgZm9yIHN5c3RlbXMg
dGhhdCBwcm92aWRlIGFuIGluc3RydWN0aW9uICB0byBnZXQgcmVnaXN0ZXIgdmFsdWVzDQo+Pj4+
IGZyb20gdXNlcnNwYWNlLCB3b3VsZCBhIGNvbW1hbmQtbGluZSBwYXJhbWV0ZXIgYmUgYWNjZXB0
YWJsZT8NCj4+PiBQYXJhbWV0ZXIgc291bmRzIGxpa2UgYSBnb29kIGlkZWEuIEluIGZhY3QsIHRo
ZXJlIGFscmVhZHkgaXMgc3VjaCBhDQo+Pj4gcGFyYW10ZXIuDQo+ICAgY3B1cG93ZXIgbW9uaXRv
ciAtLWhlbHANCj4+PiAgICAgICAgICAtYw0KPj4+ICAgICAgICAgIA0KPj4+ICAgICAgICAgICAg
ICBTY2hlZHVsZSAgdGhlICBwcm9jZXNzICBvbiBldmVyeSBjb3JlIGJlZm9yZSBzdGFydGluZyBh
bmQNCj4+PiAgICAgICAgICAgICAgZW5kaW5nDQo+Pj4NCj4+PiBtZWFzdXJpbmcuICBUaGlzIGNv
dWxkIGJlIG5lZWRlZCBmb3IgdGhlIElkbGVfU3RhdHMgbW9uaXRvciB3aGVuIG5vIG90aGVyDQo+
Pj4gTVNSIGJhc2VkIG1vbml0b3IgKGhhcyB0byBiZSBydW4gb24gdGhlIGNvcmUgdGhhdCBpcyBt
ZWFzdXJlZCkgaXMgcnVuIGluDQo+Pj4gcGFyYWxsZWwuIFRoaXMgaXMgdG8gd2FrZSB1cCB0aGUg
cHJvY2Vzc29ycyBmcm9tIGRlZXBlciBzbGVlcCBzdGF0ZXMgYW5kDQo+Pj4gbGV0IHRoZSBrZXJu
ZWwgcmVhY2NvdW50IGl0cyBjcHVpZGxlIChDLXN0YXRlKSBpbmZvcm1hdGlvbiBiZWZvcmUgcmVh
ZGluZw0KPj4+IHRoZSBjcHVpZGxlIHRpbWluZ3MgZnJvbSBzeXNmcy4NCj4+Pg0KPj4+IEJlc3Qg
aXMgeW91IGV4Y2hhbmdlIHRoZSBvcmRlciBvZiB5b3VyIHBhdGNoZXMuIFRoZSAybmQgbG9va3Mg
cmF0aGVyDQo+Pj4gc3RyYWlnaHQgZm9yd2FyZCBhbmQgeW91IGNhbiBhZGQgbXkgcmV2aWV3ZWQt
YnkuDQo+PiBUaGUgUkRQUlUgaW5zdHJ1Y3Rpb24gcmVhZHMgdGhlIEFQRVJGL01QRVJGIG9mIHRo
ZSBjcHUgb24gd2hpY2ggaXQgaXMNCj4+IHJ1bm5pbmcuIElmIHdlIGRvIG5vdCBzY2hlZHVsZSBp
dCBvbiBlYWNoIGNwdSBzcGVjaWZpY2FsbHksIGl0IHdpbGwgcmVhZCB0aGUgQVBFUkYvTVBFUkYN
Cj4+IG9mIHRoZSBjcHUgaW4gd2hpY2ggaXQgcnVucy9taWdodCBoYXBwZW4gdG8gcnVuIG9uLCB3
aGljaCB3aWxsIG5vdCBiZSB0aGUgY29ycmVjdCBiZWhhdmlvci4NCj4gR290IGl0LiBBbmQgSSBh
bHNvIGRpZG4ndCBmdWxseSByZWFkIC1jLiBJIG5vdyByZW1lbWJlci4uIEZvciBDLXN0YXRlcyBh
Y2NvdW50aW5nDQo+IHlvdSB3YW50IHRvIGhhdmUgZWFjaCBDUFUgd29rZW4gdXAgYXQgbWVhc3Vy
ZSBzdGFydCBhbmQgZW5kIGZvciBhY2N1cmF0ZSBtZWFzdXJpbmcuDQo+DQo+IEl0J3MgYSBwaXR5
IHRoYXQgdGhlIG1vbml0b3JzIGRvIHRoZSBwZXJfY3B1IGNhbGxzIHRoZW1zZWx2ZXMuDQo+IFNv
IGEgZ2VuZXJhbCBpZGxlLW1vbml0b3IgcGFyYW0gaXMgbm90IHBvc3NpYmxlIG9yIGNhbiBvbmx5
IGRvbmUgYnkgZm9yIGV4YW1wbGUgYnkNCj4gYWRkaW5nIGEgZmxhZyB0byB0aGUgY3B1aWRsZV9t
b25pdG9yIHN0cnVjdDoNCj4NCj4gc3RydWN0IGNwdWlkbGVfbW9uaXRvcg0KPg0KPiB1bnNpZ25l
ZCBpbnQgbmVlZHNfcm9vdDoxDQo+IHVuc2lnbmVkIGludCBwZXJfY3B1X3NjaGVkdWxlOjENCj4N
Cj4gbm90IHN1cmUgd2hldGhlciBhOg0KPiBzdHJ1Y3Qgew0KPiAgICB1bnNpZ25lZCBpbnQgbmVl
ZHNfcm9vdDoxDQo+ICAgIHVuc2lnbmVkIGludCBwZXJfY3B1X3NjaGVkdWxlOjENCj4gfSBmbGFn
cw0KPg0KPiBzaG91bGQvbXVzdCBiZSBwdXQgYXJvdW5kIGluIGEgc2VwYXJhdGUgY2xlYW51cCBw
YXRjaCAoYW5kIG5lZWRzX3Jvb3QgdXNlcnMgYWRqdXN0ZWQpLg0KPg0KPiBZb3UgKGFuZCBvdGhl
ciBtb25pdG9ycyBmb3Igd2hpY2ggdGhpcyBtaWdodCBtYWtlIHNlbnNlKSBjYW4gdGhlbiBpbXBs
ZW1lbnQNCj4gdGhlIHBlcl9jcHVfc2NoZWR1bGUgZmxhZy4gSW4gQU1EIGNhc2UgeW91IG1pZ2h0
IHdhbnQgKHlvdSBoYXZlIHRvKQ0KPiBkaXJlY3RseSBzZXQgaXQuDQo+DQo+IEFsbCBhcm91bmQg
YSAtYi8tdSAoLS1iaW5kLW1lYXN1cmUtdG8tY3B1LCAtLXVuYmluZC1tZWFzdXJlLXRvLWNwdSkN
Cj4gcGFyYW1ldGVyIGNvdWxkIGJlIGFkZGVkIGF0IHNvbWUgcG9pbnQgb2YgdGltZSBpZiBpdCBt
YXR0ZXJzLiBBbmQgbW9uaXRvcnMNCj4gaGF2aW5nIHRoaXMgY291bGQgYmluZCBvciBub3QuDQo+
IFRoaXMgcG9zc2libHkgY291bGQgbnVrZSBvdXQgLWMgcGFyYW0uIE9yIGF0IGxlYXN0IHRoZSBp
ZGxlIHN0YXRlIGNvdW50ZXINCj4gbW9uaXRvciBjb3VsZCBkbyBpdCBpdHNlbGYuIEJ1dCBkb24n
dCBtaW5kIGFib3V0IHRoaXMuDQo+DQo+IFdoYXQgZG8geW91IHRoaW5rPw0KDQoNClRoaXMgaXMg
YSBnb29kIHN1Z2dlc3Rpb24uIEkgY2FuIHN1Ym1pdCBhIHYyIHdpdGg6DQoNCmEpIGEgcGF0Y2gg
dG8gcmVhZGp1c3QgdGhlIG5lZWRzX3Jvb3QgdmFyaWFibGUNCg0KYikgYSBwYXRjaCB0byBpbnRy
b2R1Y2UgYW5kIHVzZSB0aGUgcGVyX2NwdV9zY2hlZHVsZQ0KDQpjKSBhIHBhdGNoIHRvIGludHJv
ZHVjZSBhbmQgdXNlIHRoZSBSRFBSVSBpbnN0cnVjdGlvbg0KDQoNCj4NCj4gQW5kIHlvdSBzaG91
bGQgYmUgYWJsZSB0byByZS11c2UgdGhlIGJpbmRfY3B1IGZ1bmN0aW9uIHVzZWQgaW4gLWMgY2Fz
ZT8NCg0KDQpZZXMuIEkgbm90aWNlZCB0aGF0IGJpbmRfY3B1KCkgaXMgZG9pbmcgd2hhdCBJIG5l
ZWQuIEkgd2lsbCB1c2UgdGhhdC4NCg0KDQpUaGFua3MsDQoNCkphbmFrDQoNCg0KPg0KPiAgICAg
ICAgIFRob21hcw0KPg0KPg0KPg0K
