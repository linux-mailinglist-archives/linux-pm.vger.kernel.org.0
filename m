Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749D8C8B9F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfJBOpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 10:45:06 -0400
Received: from mail-eopbgr730068.outbound.protection.outlook.com ([40.107.73.68]:10676
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbfJBOpG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 10:45:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOYa066HT1F4vKji9qUNRX8OD34mqW/crlD4cDrSnhVo2RdudhsiLW4hFMIfItBaruw3PjWyVPrzsAiejqN9zJ9/Z40FRai/Gs/dgLPPvcYyL6yUI9vHfzvWN/9KUFByyeTWuGvjONMI9coIFRYlNipAW1mbY5hNhmzfGiFCzinYXqClEfytWmvWKLkLL3PvYHsvtY4w6rkWlsFXJejqhDv0NnSpA3jOW6lMvi3fb2hHCBespgvsKyA4RfITdShpdaYPfj5/qFmm3nj3WiWlIkM1mKyzx/CuLpUULk3JDHyVOJ0IxTHJ/Nd3xaxFTCJijMOs1wmnWTqbWNwNZ57LxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvaKNYVE6/tMzARK0Ib/fT9RTYVYxqvPH1E+HhExsbA=;
 b=cr/1aSEuX7BX6P0VHIwsLBZ/JiN57NqWfpMYzS8AG6tMe83T85jd29GfpXq9PZcsYaLimjQ41zQjMpAIqfTdzqXl770HTLdfEiJTrVlmWU13w3IarrPBDNo64jCS/JFXytt3ejhdhW1bOkK5UqeX8N+Ec3gsdPzFd7reAgK9qA431h/J8Ws9sk/i7o9/hRohwE5q3xnqePfSU2Sa2v2E3nHYvlG8cYC0Q9aXMEaeNo5KteiQFU2lrGIQjufExPJADAeo5yTeA+qEdKH79INi0PhEbrCfdsOuhoDLBItL5pI4vhQf/PKipB3kfsJ4BO5K1o36VUv7uwXT7UnEr8gD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvaKNYVE6/tMzARK0Ib/fT9RTYVYxqvPH1E+HhExsbA=;
 b=lnFZJ9/n3kecQ+c9otVSZSgann7kiXyJwxDsrXx57590s6HQvxBJbUEi3fa1w0S+mHPwPyoyA8/aonyU2PvZMzvZgxgh+iDbdse8wf4qJex8Kx2586IvhC7Izym1frtQQDWIgHPwLVBPzpBCbO5F5IWnf2j+dzy+NSyXoNqaJlM=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2848.namprd12.prod.outlook.com (52.135.107.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 14:45:03 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 14:45:03 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     Thomas Renninger <trenn@suse.de>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Pu Wen <puwen@hygon.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Renninger <trenn@suse.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Topic: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Index: AQHVbj8CzXj8hQvM60aQ8slBTBcq36c/ayGAgACy6gCAB2VngA==
Date:   Wed, 2 Oct 2019 14:45:03 +0000
Message-ID: <64022abd-a798-c679-1c1d-eec9b18c4fb2@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
 <9f94bb60-4be2-4303-54de-f50bdd7cb3e6@amd.com> <4340017.MFpoU6RDpq@c100>
In-Reply-To: <4340017.MFpoU6RDpq@c100>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2501eeb7-f00c-4791-32ae-08d747471bd9
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2848:|SN6PR12MB2848:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28485B9A30EB40BF43971B37E79C0@SN6PR12MB2848.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(11346002)(26005)(229853002)(446003)(3846002)(6506007)(386003)(53546011)(6116002)(2906002)(4326008)(31686004)(102836004)(476003)(31696002)(2616005)(8936002)(486006)(186003)(478600001)(25786009)(81156014)(81166006)(8676002)(66946007)(36756003)(64756008)(66556008)(66476007)(66446008)(99286004)(54906003)(86362001)(71190400001)(71200400001)(6246003)(6512007)(14454004)(110136005)(5660300002)(7416002)(52116002)(66066001)(6486002)(256004)(76176011)(305945005)(7736002)(6436002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2848;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgVFzRxZxM/QFJ1ApQb9/tD1rWImPlsOILloFzafduqEQ772021lXZAfkOj6O7x1PvTrGhZzE4BkTCpsO4jvVkxODbDptlecPscgc8LN7EKgHqenx0So96pYzGQZ7SOa8zeaADNt3Ri+7+A4SOuB7ZBOloRiN8BoY/8ld8sYBzpR8Fz9qLfQbMHPG6Nf1h33i13sBivBb1ShOzeNGTsUaYWzEKcjIl+7CE3NOOlI3ZqPARAmjpkpiNVVBtmwQvoukdfnpOZtt+w+uW29vTHwb4fD3+2e6Xk+8vVOTazdLlpAO/FH5UD94smzu2mDAC3JsFCez6GeeMj7HmOtsDBB/NBzD22KSx32TJse0urJwTL2qrNnjmxOP1SBzvvWIzwFAt+QIX1ZOn7e/9a/R1UAXwsg8AIzCCj4DqxuR9eiTkQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6525CBB5C8FDDF4DBA23207276827836@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2501eeb7-f00c-4791-32ae-08d747471bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 14:45:03.6381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: so9rBbSirUpcpkIxgAc2r48Lr+abBCXz2+1Ch2hjlPAuuUVDIb2od0TyzBgJThD07m8ZGpO0pIFC0VfflFTuTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2848
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gOS8yNy8xOSA0OjQ4IFBNLCBUaG9tYXMgUmVubmluZ2VyIHdyb3RlOg0KPiBPbiBGcmlkYXks
IFNlcHRlbWJlciAyNywgMjAxOSA2OjA3OjU2IFBNIENFU1QgIE5hdGFyYWphbiwgSmFuYWthcmFq
YW4gIHdyb3RlOg0KPj4gT24gOS8xOC8yMDE5IDExOjM0IEFNLCBOYXRhcmFqYW4sIEphbmFrYXJh
amFuIHdyb3RlOg0KPj4+IFRoaXMgaXMgYWR2YW50YWdlb3VzIGJlY2F1c2UgYW4gSVBJIGlzIG5v
dCBnZW5lcmF0ZWQgd2hlbiBhIHJlYWRfbXNyKCkgaXMNCj4+PiBleGVjdXRlZCBvbiB0aGUgbG9j
YWwgbG9naWNhbCBDUFUgdGhlcmVieSByZWR1Y2luZyB0aGUgY2hhbmNlIG9mIGhhdmluZw0KPj4+
IEFQRVJGIGFuZCBNUEVSRiBiZWluZyBvdXQgb2Ygc3luYy4NCj4+PiArCWlmIChzY2hlZF9zZXRh
ZmZpbml0eShnZXRwaWQoKSwgc2l6ZW9mKHNldCksICZzZXQpID09IC0xKSB7DQo+Pj4gKwkJZHBy
aW50KCJDb3VsZCBub3QgbWlncmF0ZSB0byBjcHU6ICVkXG4iLCBjcHUpOw0KPj4+ICsJCXJldHVy
biAxOw0KPiBPbiBhIDgwIGNvcmUgY3B1IHRoZSBwcm9jZXNzIHdvdWxkIGJlIHB1c2hlZCBhcm91
bmQgdGhyb3VnaCB0aGUNCj4gc3lzdGVtIHF1aXRlIGEgbG90Lg0KPiBUaGlzIG1pZ2h0IGFmZmVj
dCB3aGF0IHlvdSBhcmUgbWVhc3VyaW5nIG9yIHRoZSBvdGhlciBtZWFzdXJlIHZhbHVlcz8NCj4g
T3RoZXJ3aXNlIGl0J3MgdGhlIGtlcm5lbCdzIE1TUiByZWFkIG9ubHksIG5vdCB0aGUgd2hvbGUg
Y3B1cG93ZXIgcHJvY2VzcywNCj4gcmlnaHQ/IE5vIGlkZWEgYWJvdXQgdGhlIGV4YWN0IG92ZXJo
ZWFkLCB0aG91Z2guIE90aGVycyBpbiBDQyBsaXN0IHNob3VsZA0KPiBrbm93Lg0KDQoNCk9uIGEg
MjU2IGxvZ2ljYWwtY3B1IFJvbWUgc3lzdGVtIHdlIHNlZSBDMCB2YWx1ZSBmcm9tIGNwdXBvd2Vy
IG91dHB1dCBnbyANCmZyb20gMC4wMSB0byB+KDAuMSB0byAxLjAwKQ0KDQpmb3IgYWxsIGNwdXMg
d2l0aCB0aGUgMXN0IHBhdGNoLg0KDQpIb3dldmVyLCB0aGlzIGdvZXMgZG93biB0byB+MC4wMSB3
aGVuIHdlIHVzZSB0aGUgUkRQUlUgaW5zdHJ1Y3Rpb24gDQood2hpY2ggY2FuIGJlIHVzZWQgdG8g
Z2V0DQoNCkFQRVJGL01QRVJGIGZyb20gQ1BMID4gMCkgYW5kIGF2b2lkIHVzaW5nIHRoZSBtc3Ig
bW9kdWxlIChwYXRjaCAyKS4NCg0KDQo+IEFmYWlrIG1zciByZWFkcyB0aHJvdWdoIG1zciBtb2R1
bGUgc2hvdWxkIGJlIGF2b2lkZWQgYW55d2F5Pw0KPiBUaG9zZSB3aGljaCBhcmUgd29ydGggaXQg
YXJlIGFic3RyYWN0ZWQgdGhyb3VnaCBzeXNmcyBub3dhZGF5cz8NCj4NCj4gRm9yIGFwZXJmL21w
ZXJmIGl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gZGVmaW5lIGEgc3lzZnMgZmlsZSB3aGVyZSB5b3UN
Cj4gY2FuIHJlYWQgYm90aCwgYXMgdGhpcyBpcyB3aGF0IHlvdSBhbHdheXMgbmVlZD8NCj4NCj4g
SXQgd291bGQgdGFrZSBhIHdoaWxlLCBidXQgY291bGQgYmUgYSBsb25ndGVybSBzb2x1dGlvbiB3
aGljaCBpcyBhbHNvDQo+IHVzYWJsZSBpbiBzZWN1cmUgYm9vdCBvciB3aXRob3V0IG1zciBtb2R1
bGUgY2FzZS4NCg0KDQpZZXMuIFRoYXQgaXMgYSBnb29kIGxvbmcgdGVybSBpZGVhLiBBbiBpbnRl
cmZhY2Ugd2hpY2ggY291bGQgYmUgdXNlZCB0byANCnF1ZXJ5IEFQRVJGLCBNUEVSRg0KDQpmb3Ig
YSBsb2dpY2FsIGNwdSBpbiBvbmUgZ28uDQoNCkhvd2V2ZXIsIGZvciBzeXN0ZW1zIHRoYXQgcHJv
dmlkZSBhbiBpbnN0cnVjdGlvbsKgIHRvIGdldCByZWdpc3RlciB2YWx1ZXMgDQpmcm9tIHVzZXJz
cGFjZSwgd291bGQgYQ0KDQpjb21tYW5kLWxpbmUgcGFyYW1ldGVyIGJlIGFjY2VwdGFibGU/DQoN
CmkuZS4gcDogcHJlY2lzZSBtZWFzdXJlbWVudC4NCg0KV2hlbiB0aGlzIGlzIHNldCwgdGhlIGNw
dXBvd2VyIHByb2Nlc3MgY2FuIG1pZ3JhdGUgdG8gZWFjaCBjcHUgYW5kICxpZiANCmFuIGluc3Ry
dWN0aW9uIGlzIGF2YWlsYWJsZQ0KDQp3aGljaCBjYW4gZ2V0IHRoZSBBUEVSRi9NUEVSRiBmcm9t
IENQTCA+IDAsIHVzZSBpdC4gVGhhdCB3b3VsZCBjdXQgb3V0IA0KdGhlIG1zciBtb2R1bGUgYW5k
IHRoZQ0KDQpvdmVyaGVhZCBjYW4gYmUgcmVkdWNlZC4NCg0KDQpUaGFua3MuDQoNCg0KPiAgICAg
ICAgVGhvbWFzDQo+DQo+DQo+DQo=
