Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD80E768E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbfJ1QhJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 12:37:09 -0400
Received: from mail-eopbgr730052.outbound.protection.outlook.com ([40.107.73.52]:59493
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729420AbfJ1QhJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 12:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALUmrz9HWHN4vQmz9TNIMs4/+GPxbiGztCXlPlEABk4Ne9dwYhdszCGo8nnGLHgQ8V9By4sspeDDDB2GjBy+9mEyRFHNz5b2OeyJb1iUxwhx0RrbEWpw8iNsqszxqARDizbHUgqT49gLlagdZgpQRsaQQCqI/M1ohxZCBsqEnOUWi4GGYKETup0Uy/uZPJIIbCDdP2zpbnRp1aJRq4jy8NG6iVjfkoIVbwmC1IOkCQiPzPKAe47BWEMr+pqBEhFELtREeVAeWQHHtWjkqcVq32sJLhgh5JYY2VJKlxQ/GUMwr4y0wB2RqXr+1asYtjz+y9nykvWSaDv26A5yz+qrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAR9jgz9dB3vgz1/ckn8uf4NZf8g9P9Yk7tpacMFqxk=;
 b=l4tDHhkgauhQdV7dtF+Y+yonaQGCoIpSiQ6io1CTlq7s1QNO52trWF0SS5ik/nWJtFbFl0Lvkvo38UDPSSYWf7Z6ME8N7VuMT5gckA1ElVmGhOvq9PPLL/P7JbWKCBkoG6M9TK7H9Z0UzRrmfRk5gX4ekfUMhKr/W96NT2HevvNGa9E160tM2MBnmia+IwkLHF+UvxdEC95MoIfrNJ7CyPRWLZ/iRxctxCRMUUfRccZp4WC6Li+caa3L8jR1Gd9bir8Yy4TeLmvkIIGlPfeyqQncL+CWmss5nxnAR+zekLkvoPaueWLYMaFUriSMJv5JwInaPzPqn4yzFbHWG2zFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAR9jgz9dB3vgz1/ckn8uf4NZf8g9P9Yk7tpacMFqxk=;
 b=29D9dhrPyy5KzfYO4kjKlhD5sh++GSq5tbkTQGbZ4LNteekw2JikM7dC8gMqby6QEffpkO2HybekijmhxdJp/NptqXYi+LQZaND0ByxaQXuIs9MHqfjnPg5gd9FNLWEtwiYWVIt1zKDmT9sji0bSgtWCSD8xAgrgEIRKv7utBEE=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 16:37:02 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 16:37:02 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     shuah <shuah@kernel.org>, Thomas Renninger <trenn@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Pu Wen <puwen@hygon.com>, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCHv2 2/3] cpupower: mperf_monitor: Introduce per_cpu_schedule
 flag
Thread-Topic: [PATCHv2 2/3] cpupower: mperf_monitor: Introduce
 per_cpu_schedule flag
Thread-Index: AQHVgGthysllBZ56ukW20e1QLXbBzadrQCYAgABSKICABMikAA==
Date:   Mon, 28 Oct 2019 16:37:01 +0000
Message-ID: <714345df-451c-c452-9d61-a8b8a8140ff5@amd.com>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
 <bb4b0e4137b62651b9d028925fa8f09ca5fbd989.1570819652.git.Janakarajan.Natarajan@amd.com>
 <24194241.SRZ5kbjNg7@skinner.arch.suse.de>
 <e5c0ed24-6b2f-ea2f-6ce1-533f3727cb17@kernel.org>
In-Reply-To: <e5c0ed24-6b2f-ea2f-6ce1-533f3727cb17@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:805:ca::28) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a6e4d59-01f9-47a0-e943-08d75bc50f23
x-ms-traffictypediagnostic: SN6PR12MB2670:|SN6PR12MB2670:
x-microsoft-antispam-prvs: <SN6PR12MB26700F2C083260216A309E90E7660@SN6PR12MB2670.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(14454004)(305945005)(71190400001)(71200400001)(256004)(52116002)(3846002)(99286004)(6116002)(229853002)(6246003)(4326008)(6486002)(8936002)(316002)(36756003)(8676002)(66946007)(66556008)(66476007)(102836004)(64756008)(66446008)(6436002)(110136005)(54906003)(81156014)(2906002)(25786009)(7416002)(81166006)(31696002)(5660300002)(11346002)(446003)(2616005)(476003)(86362001)(31686004)(76176011)(478600001)(53546011)(7736002)(26005)(386003)(6506007)(66066001)(186003)(486006)(6512007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2670;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lR+8mMoJzO40mSJzmsWMHlIFZjQc8gTe9e2q+GTLJOOyKcr8rjNmIUswpEKYb0r0zZQdvbrwcdihHBrJozkcQoJXue4enNxUv4+R6RTD+r3eKzNv/wzTvAwtY7/NuhjjwFf4jxvnKQxJFolAo5vuSPSl20IXoAA4pnwtCfU02ot6iCvTf4KisGUUm1zzFNWmHWUlnhHpspVA0LpL4k2m8v2jflukQ+l+yuI6G1Qc3oq9+/ImPL2MwEXh/plPiAEywPd1dNKbdXslZ30bgvmdmO0i3dmxUNDFeKK2VDDPx9q2bCaf+JunTtlklHGD3l1kefQWx9L914s3vRKeKTWEFs5l4NNmKIl5yGqkfeJnd6pGjsqbY6R1S+NTyd3AZwVLzp2zxSEJSfYIHxJ3IupsFQ8HuDJce0qUMfcBMV83G3B7IuOfopFwF5N1652ERwy7
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B602A58E9D0404C92FB585647D2B17D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6e4d59-01f9-47a0-e943-08d75bc50f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 16:37:02.2068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgLtNcj+NLpiHqZ+vdBKACYyxB/kV5j6xELYrxgrPfPmQzHc4iX0Bf07yYpCL4K9Ojx3JjmWQQzh4HtqVPeIDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTAvMjUvMjAxOSAxMDozMyBBTSwgc2h1YWggd3JvdGU6DQo+IE9uIDEwLzI1LzE5IDQ6Mzkg
QU0sIFRob21hcyBSZW5uaW5nZXIgd3JvdGU6DQo+PiBIaSBOYXRhcmFqYW4sDQo+Pg0KPj4gc29y
cnkgZm9yIGFuc3dlcmluZyB0aGF0IGxhdGUuDQo+PiBJIHBvc3Qgb24gdG9wIGFzIGl0IGRvZXNu
J3QgZml0IHRvIHRoZSBwYXRjaCBjb250ZXh0Og0KPj4NCj4+IFdoaWxlIEkgbGlrZSB0aGUgMiBv
dGhlciBwYXRjaGVzLCBlc3BlY2lhbGx5IHRoZSBmaXJzdCBwcmVwYXJpbmcgZm9yDQo+PiBhIGdl
bmVyaWMgImVuc3VyZSB0byBhbHdheXMgcnVuIG9uIHRoZSBtZWFzdXJlZCBDUFUgYXQgbWVhc3Vy
ZSB0aW1lIg0KPj4gaW50ZXJmYWNlLi4uLCB0aGlzIHBhdGNoIGRvZXMgbWFrZSB1c2Ugb2YgaXQg
aW4gYSB2ZXJ5IHN0YXRpYyBtYW5uZXIuDQo+Pg0KPj4gSSB0aGVuIHRyaWVkIHRvIGdldCB0aGlz
IG1vcmUgZ2VuZXJpYy4uLiwgd2l0aG91dCBhbnkgb3V0Y29tZSBmb3Igbm93Lg0KPj4NCj4+IElm
IHNvbWVvbmUgbGlrZXMgdG8gcGxheSB3aXRoIHRoaXMsIG15IGlkZWEgd291bGQgYmU6DQo+Pg0K
Pj4gLSB0aGUgbW9uaXRvcnMgbmVlZCBjcHVfc3RhcnQoKSBhbmQgY3B1X3N0b3AoKSBjYWxsYmFj
a3MgdG8gcmVnaXN0ZXINCj4+IC0gZWl0aGVyIHN0YXJ0KCksIHN0b3AoKSBhbmQvb3IgY3B1X3N0
YXJ0KCksIGNwdV9zdG9wKCkgY2FsbGJhY2tzIA0KPj4gaGF2ZSB0bw0KPj4gwqDCoCBiZSBwcm92
aWRlZCBieSBhIG1vbml0b3IuDQo+PiAtIGN1cnJlbnQgYmVoYXZpb3IgaXMgb25seSBzdGFydC9z
dG9wIHdoaWNoIG1lYW5zIHRoZSB3aG9sZSBwZXJfY3B1IA0KPj4gbG9naWMNCj4+IMKgwqAgcmVz
aWRlcyBpbnNpZGUgdGhlIG1vbml0b3INCj4+IC0gaWYgY3B1X3N0YXJ0L2NwdV9zdG9wIGlzIHBy
b3ZpZGVkLCBpdGVyYXRpbmcgb3ZlciBhbGwgY3B1cyBpcyBkb25lIGluDQo+PiDCoMKgIGZvcmtf
aXQgYW5kIGdlbmVyYWwgc3RhcnQvc3RvcCBmdW5jdGlvbnMgYXJlIGFuIG9wdGlvbmFsbHkgZW50
cnkgDQo+PiBwb2ludA0KPj4gwqDCoCBiZWZvcmUgYW5kIGFmdGVyIHRoZSBwZXJfY3B1IGNhbGxz
Lg0KPj4NCj4+IFRoZW4gdGhlIGNwdSBiaW5kaW5nIGNhbiBiZSBkb25lIGZyb20gb3V0c2lkZS4N
Cj4+IEFub3RoZXIgZW5oYW5jZW1lbnQgY291bGQgYmUgdGhlbiB0byBmb3JrIGFzIG1hbnkgcHJv
Y2Vzc2VzIGFzIHRoZXJlIA0KPj4gYXJlIENQVXMNCj4+IGluIGNhc2Ugb2YgcGVyX2NwdV9zY2hl
ZHVsZSAob3IgYW4gZXh0cmEgcGFyYW0vZmxhZykgYW5kIHRoZW46DQo+Pg0KPj4gLSBCaW5kIHRo
ZXNlIGZvcmtlZCBwcm9jZXNzZXMgdG8gZWFjaCBjcHUuDQo+PiAtIEV4ZWN1dGUgc3RhcnQgbWVh
c3VyZXMgdmlhIHRoZSBmb3JrZWQgcHJvY2Vzc2VzIG9uIGVhY2ggY3B1DQo+PiAtIEV4ZWN1dGUg
dGVzdCBleGVjdXRhYmxlICh3aGljaCBydW5zIGluIHlldCBhbm90aGVyIGZvcmsgYXMgZG9uZSAN
Cj4+IGFscmVhZHkpDQo+PiAtIEV4ZWN1dGUgc3RvcCBtZWFzdXJlcyB2aWEgdGhlIGZvcmtlZCBw
cm9jZXNzZXMgb24gZWFjaCBjcHUNCj4+DQo+PiBUaGlzIHNob3VsZCBiZSBpZGVhbCBlbnZpcm9u
bWVudCB0byBub3QgaW50ZXJmZXJlIHdpdGggdGhlIHRlc3RlZCANCj4+IGV4ZWN1dGFibGUuDQo+
PiBJdCB3b3VsZCBhbHNvIGFsbG93IGEgbmljZXIgcHJvZ3JhbSBzdHJ1Y3R1cmUuDQo+Pg0KPg0K
PiBJdCB3aWxsIGJlIGdvb2QgdG8gY2FwdHVyZSB0aGVzZSBpZGVhcyBpbiB0aGUgVG9EbyBmaWxl
Lg0KPg0KPiBOYXRhcmFqYW4hIFdPdWxkIHlvdSBsaWtlIHRvIHNlbmQgYSBwYXRjaCB1cGRhdGlu
ZyB0aGUgVG9EbyBmaWxlIHdpdGgNCj4gdGhlc2UgaWRlYXM/DQoNCg0KU3VyZS4gSSBjYW4gc2Vu
ZCBvdXQgYSBwYXRjaCBjYXB0dXJpbmcgdGhlc2UgaWRlYXMuDQoNCg0KLUphbmFrDQoNCg0KPg0K
PiB0aGFua3MsDQo+IC0tIFNodWFoDQo+DQo=
