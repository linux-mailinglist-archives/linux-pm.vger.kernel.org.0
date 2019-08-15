Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2FFA8ED3C
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 15:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfHONrc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 09:47:32 -0400
Received: from mail-eopbgr710047.outbound.protection.outlook.com ([40.107.71.47]:9042
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732328AbfHONrc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Aug 2019 09:47:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+vjQUkQ9gwmZxj+JE3hxT5BfJdH0kxUZqBOdUkHWJX+67OrDqAqLVZIEDY6MqqQdDP0L65bH37mdUIf4pfT/uz0kxYSowCObTXPYmUQOYZnPG525RyR46Xk012AyPEnut/NP8NsczFL2fv89j+Lt4OdFX/zt6wAYLvoNSfXr8g8sgGQzfYQfnfRL9rKuuQJXWX+vkhND+oPrnh7+ZTcvH70pjcjD9IRMPslqUIGobGLtatDJ9oZJTOxuorjjjixLdefcKOdb36I2I61s0Lr+EX2d7q0rD3Av5oLgWy13mHJmAAJlhX/mCO7DeoefH20M1hYoDGmjuSDoIuW44n++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMxHmHnxcII6zKzgFfm/MbP55RbjusO36v+k+IgwlRc=;
 b=luPmHvj+zpAbCBMuVC4vt57SIogQzZzmsWZx+GxrAiss81nv3/XxeluZIvIrVqtusQI3PyXcgFChPGP/vbtp/hC8CHWsBcf+Uu5+uG755+RPmAU5P01Qu49IP45Dt6SQalwErvsWM0+Z0457iOpSxiJmJeJoXjd0WpYYB/jMDJ1J57RXexe1TSrxRG4zgQJwNQcgy2B9TK+fJLjlZvJYyE2sXpcMfhoyxc01stk2pgud5lHZCreWCiFnvMq5ENHKLyUaEakiocPz5mqoL8vSW+HYQSmO6bDUjTWV4t1MhcEtL2s4q/XtxYM7wJSq7evFimfAEeH65bHoEXpcWcZUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMxHmHnxcII6zKzgFfm/MbP55RbjusO36v+k+IgwlRc=;
 b=OgzNjMW7a8RgVqkMnc2PmCsq+SN8u1WF8NzjQrLe4c5pYfZg7ZUadh/827ZcbEA/jAcyiGUXKSLirNsiNthmF9q9LjCOm4Ftxheszk1RsVZvywAc+0V9t+GHZY4zWqjBX2SPLdcVCRu6mxO7jomCohFP8+1RmXi0Q45PrjYz+2k=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB4042.namprd12.prod.outlook.com (10.141.185.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 15 Aug 2019 13:47:24 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 13:47:24 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
Thread-Topic: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family
 15h/16h
Thread-Index: AQHVUuW0/upDXQeDUkyQJLUEYNL76ab7zjSAgABr7QA=
Date:   Thu, 15 Aug 2019 13:47:24 +0000
Message-ID: <768aa720-1db1-81ca-4d0d-adf31f4d134b@amd.com>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <20190815071940.GB15313@zn.tnic>
In-Reply-To: <20190815071940.GB15313@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0018.namprd04.prod.outlook.com
 (2603:10b6:803:21::28) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ed4f61-1ce6-498d-9c0d-08d721871a5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB4042;
x-ms-traffictypediagnostic: DM6PR12MB4042:
x-microsoft-antispam-prvs: <DM6PR12MB40422BEE6CC5DD6220A10EC9ECAC0@DM6PR12MB4042.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(189003)(199004)(8676002)(81166006)(81156014)(14454004)(7416002)(305945005)(76176011)(52116002)(7736002)(66446008)(8936002)(6436002)(53546011)(102836004)(6486002)(66476007)(66556008)(386003)(6506007)(64756008)(66946007)(66066001)(26005)(186003)(6512007)(316002)(11346002)(446003)(478600001)(54906003)(2616005)(476003)(486006)(5660300002)(14444005)(71190400001)(25786009)(6246003)(53936002)(71200400001)(30864003)(256004)(31696002)(2906002)(86362001)(36756003)(229853002)(6916009)(99286004)(31686004)(4326008)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4042;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 21NTF9h0Jfwsl2tfMLv7gQFmxtC5bYIBsP3g4/6unwzgrLjDOFgQULG2uSHR+wGcyOrqgNReHgh7D6k8P+F6IZ2oYt5lSIq18/bw1Bu3lg6Jq1pVgVlFeBIClGSoAKF9OS2HdmJX+0s08qyzZuGJHJyYYsCBP+WL5VXtYROvhTtgwx3AtZ1tVeLmkLvBOKBweAjY4SCoPvzIK8Zn5fGNVWjRgHX4fAfGjyNZIgmnUobUlwHvcOAM2Bc6A2Y5UcDTjqDyfs3/FMyo/m8OpQzrMQQvjuHLOwcICeVi4IZeT1axWkC3oeQMQUq4i88LnW3eGZZddFKMgOSB9hgRbbI1TR3Q/g7oC6yiN4ac7q+79r7uGXFPVSI0EyzOZxprIhJ5NjGezn+KtBv8lGo//xCp6p+0hmcbAxDxsyFTinv1TbI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D02D0B2C79BF6D409110C1C4ED2A02D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ed4f61-1ce6-498d-9c0d-08d721871a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 13:47:24.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oesCSS0fxeqk1davvX/WN2z7WMG3AkrLd5u/ZxU3MmH/XU8Ya7cvIWNVOZLyA5GARwrTOlZujPesgROjc76VWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gOC8xNS8xOSAyOjIxIEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIFdlZCwgQXVn
IDE0LCAyMDE5IGF0IDA5OjE3OjQxUE0gKzAwMDAsIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+
PiBGcm9tOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KPj4NCj4+IFRo
ZXJlIGhhdmUgYmVlbiByZXBvcnRzIG9mIFJEUkFORCBpc3N1ZXMgYWZ0ZXIgcmVzdW1pbmcgZnJv
bSBzdXNwZW5kIG9uDQo+PiBzb21lIEFNRCBmYW1pbHkgMTVoIGFuZCBmYW1pbHkgMTZoIHN5c3Rl
bXMuIFRoaXMgaXNzdWUgc3RlbXMgZnJvbSBCSU9TDQo+PiBub3QgcGVyZm9ybWluZyB0aGUgcHJv
cGVyIHN0ZXBzIGR1cmluZyByZXN1bWUgdG8gZW5zdXJlIFJEUkFORCBjb250aW51ZXMNCj4+IHRv
IGZ1bmN0aW9uIHByb3Blcmx5Lg0KPiANCj4gSWYgdGhpcyBoYXBwZW5zIG9ubHkgZHVyaW5nIHN1
c3BlbmQvcmVzdW1lLCB0aGlzIHByb2JhYmx5IHNob3VsZA0KPiBiZSBkb25lIG9ubHkgb24gY29u
ZmlndXJhdGlvbnMgd2hpY2ggaGF2ZSBDT05GSUdfU1VTUEVORCBhbmQvb3INCj4gQ09ORklHX0hJ
QkVSTkFUSU9OIGVuYWJsZWQuIEknbSBhc3N1bWluZyBCSU9TIGRvZXMgaW5pdCBpdCBwcm9wZXJs
eQ0KDQpTdXJlLCB0aGF0IG1ha2VzIHNlbnNlLiBJJ2xsIHRpZSBpdCB0byBDT05GSUdfUE1fU0xF
RVAgc2luY2UgdGhhdCBpcyB3aGF0DQphcmNoL3g4Ni9wb3dlci9jcHUuYyBpcyBkZXBlbmRlbnQg
b24uDQoNCj4gYXQgbGVhc3QgZHVyaW5nIGJvb3QgLSBJIG1lYW4sIHRoZXkgc2hvdWxkJ3ZlIHBh
c3NlZCBzb21lIHNvcnQgb2YgYQ0KPiBjZXJ0aWZpY2F0aW9uLg0KPiANCj4gT1RPSCwgaWYgdGhl
IGJyZWFrYWdlIGhhcHBlbnMgb24gcmVzdW1lLCB0aGV5IGNsZWFybHkgZGlkbid0IHRlc3QgdGhl
DQo+IEJJT1Mgc3VzcGVuZC9yZXN1bWUuIEkgbWVhbiwgSSdtIG5vdCBhdCBhbGwgc3VycHJpc2Vk
IC0gaXQgaXMgZipja2luZw0KPiBCSU9TLiBOZXdzIGF0IDExLg0KPiANCj4+IFJEUkFORCBzdXBw
b3J0IGlzIGluZGljYXRlZCBieSBDUFVJRCBGbjAwMDAwMDAxX0VDWFszMF0uIFRoaXMgYml0IGNh
biBiZQ0KPj4gcmVzZXQgYnkgY2xlYXJpbmcgTVNSIEMwMDFfMTAwNFs2Ml0uIEFueSBzb2Z0d2Fy
ZSB0aGF0IGNoZWNrcyBmb3IgUkRSQU5EDQo+PiBzdXBwb3J0IHVzaW5nIENQVUlELCBpbmNsdWRp
bmcgdGhlIGtlcm5lbCwgIHdpbGwgYmVsaWV2ZSB0aGF0IFJEUkFORCBpcw0KPj4gbm90IHN1cHBv
cnRlZC4NCj4+DQo+PiBVcGRhdGUgdGhlIENQVSBpbml0aWFsaXphdGlvbiB0byBjbGVhciB0aGUg
UkRSQU5EIENQVUlEIGJpdCBmb3IgYW55IGZhbWlseQ0KPj4gMTVoIGFuZCAxNmggcHJvY2Vzc29y
IHRoYXQgc3VwcG9ydHMgUkRSQU5ELiBJZiBpdCBpcyBrbm93biB0aGF0IHRoZSBmYW1pbHkNCj4+
IDE1aCBvciBmYW1pbHkgMTZoIHN5c3RlbSBkb2VzIG5vdCBoYXZlIGFuIFJEUkFORCByZXN1bWUg
aXNzdWUgb3IgdGhhdCB0aGUNCj4+IHN5c3RlbSB3aWxsIG5vdCBiZSBwbGFjZWQgaW4gc3VzcGVu
ZCwgdGhlICJyZHJhbmRfZm9yY2UiIGtlcm5lbCBwYXJhbWV0ZXINCj4+IGNhbiBiZSB1c2VkIHRv
IHN0b3AgdGhlIGNsZWFyaW5nIG9mIHRoZSBSRFJBTkQgQ1BVSUQgYml0Lg0KPj4NCj4+IEFkZGl0
aW9uYWxseSwgdXBkYXRlIHRoZSBzdXNwZW5kIGFuZCByZXN1bWUgcGF0aCB0byBzYXZlIGFuZCBy
ZXN0b3JlIHRoZQ0KPj4gTVNSIEMwMDFfMTAwNCB2YWx1ZSB0byBlbnN1cmUgdGhhdCB0aGUgUkRS
QU5EIENQVUlEIHNldHRpbmcgcmVtYWlucyBpbg0KPj4gcGxhY2UgYWZ0ZXIgcmVzdW1pbmcgZnJv
bSBzdXNwZW5kLg0KPj4NCj4+IE5vdGUsIHRoYXQgY2xlYXJpbmcgdGhlIFJEUkFORCBDUFVJRCBi
aXQgZG9lcyBub3QgcHJldmVudCBhIHByb2Nlc3Nvcg0KPj4gdGhhdCBub3JtYWxseSBzdXBwb3J0
cyB0aGUgUkRSQU5EIGluc3RydWN0aW9uIGZyb20gZXhlY3V0aW5nIHRoZSBSRFJBTkQNCj4+IGlu
c3RydWN0aW9uLiBTbyBhbnkgY29kZSB0aGF0IGRldGVybWluZWQgdGhlIHN1cHBvcnQgYmFzZWQg
b24gZmFtaWx5IGFuZA0KPj4gbW9kZWwgd29uJ3QgI1VELg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQo+PiAtLS0NCj4+ICAuLi4v
YWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0ICAgICAgICAgfCAgOCArKw0KPj4gIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oICAgICAgICAgICAgICB8ICAxICsNCj4+ICBh
cmNoL3g4Ni9rZXJuZWwvY3B1L2FtZC5jICAgICAgICAgICAgICAgICAgICAgfCA0MiArKysrKysr
KysrDQo+PiAgYXJjaC94ODYvcG93ZXIvY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ODMgKysrKysrKysrKysrKysrKy0tLQ0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgMTIxIGluc2VydGlv
bnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+PiBpbmRleCA0N2Q5ODFhODZlMmYuLmY0N2Vi
MzM5NThjMSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVs
LXBhcmFtZXRlcnMudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5l
bC1wYXJhbWV0ZXJzLnR4dA0KPj4gQEAgLTQwOTAsNiArNDA5MCwxNCBAQA0KPj4gIAkJCVJ1biBz
cGVjaWZpZWQgYmluYXJ5IGluc3RlYWQgb2YgL2luaXQgZnJvbSB0aGUgcmFtZGlzaywNCj4+ICAJ
CQl1c2VkIGZvciBlYXJseSB1c2Vyc3BhY2Ugc3RhcnR1cC4gU2VlIGluaXRyZC4NCj4+ICANCj4+
ICsJcmRyYW5kX2ZvcmNlCVtYODZdDQo+PiArCQkJT24gY2VydGFpbiBBTUQgcHJvY2Vzc29ycywg
dGhlIGFkdmVydGlzZW1lbnQgb2YgdGhlDQo+PiArCQkJUkRSQU5EIGluc3RydWN0aW9uIGhhcyBi
ZWVuIGRpc2FibGVkIGJ5IHRoZSBrZXJuZWwNCj4+ICsJCQliZWNhdXNlIG9mIGJ1Z2d5IEJJT1Mg
c3VwcG9ydCwgc3BlY2lmaWNhbGx5IGFyb3VuZCB0aGUNCj4+ICsJCQlzdXNwZW5kL3Jlc3VtZSBw
YXRoLiBUaGlzIG9wdGlvbiBhbGxvd3MgZm9yIG92ZXJyaWRpbmcNCj4+ICsJCQl0aGF0IGRlY2lz
aW9uIGlmIGl0IGlzIGtub3duIHRoYXQgdGhlIEJJT1Mgc3VwcG9ydCBmb3INCj4+ICsJCQlSRFJB
TkQgaXMgbm90IGJ1Z2d5IG9uIHRoZSBzeXN0ZW0uDQo+PiArDQo+PiAgCXJkdD0JCVtIVyxYODYs
UkRUXQ0KPj4gIAkJCVR1cm4gb24vb2ZmIGluZGl2aWR1YWwgUkRUIGZlYXR1cmVzLiBMaXN0IGlz
Og0KPj4gIAkJCWNtdCwgbWJtdG90YWwsIG1ibWxvY2FsLCBsM2NhdCwgbDNjZHAsIGwyY2F0LCBs
MmNkcCwNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oDQo+PiBpbmRleCA2YjRmYzI3ODgwNzgu
LjI5YWUyYjY2YjllOSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci1p
bmRleC5oDQo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaA0KPj4gQEAg
LTM4MSw2ICszODEsNyBAQA0KPj4gICNkZWZpbmUgTVNSX0FNRDY0X1BBVENIX0xFVkVMCQkweDAw
MDAwMDhiDQo+PiAgI2RlZmluZSBNU1JfQU1ENjRfVFNDX1JBVElPCQkweGMwMDAwMTA0DQo+PiAg
I2RlZmluZSBNU1JfQU1ENjRfTkJfQ0ZHCQkweGMwMDEwMDFmDQo+PiArI2RlZmluZSBNU1JfQU1E
NjRfQ1BVSURfRk5fMDAwMDAwMDEJMHhjMDAxMTAwNA0KPiANCj4gSSBrbm93IHRoZSBQUFIgaGFz
IGFsbCB0aGUgMHMgYnV0IGxldCdzIHdyaXRlIGl0DQo+IA0KPiBNU1JfQU1ENjRfQ1BVSURfRk5f
MQ0KPiANCj4gc28gdGhhdCBpdCBpcyByZWFkYWJsZSBpbiB0aGUga2VybmVsLg0KDQpPaywgd2ls
bCBkby4NCg0KPiANCj4+ICAjZGVmaW5lIE1TUl9BTUQ2NF9QQVRDSF9MT0FERVIJCTB4YzAwMTAw
MjANCj4+ICAjZGVmaW5lIE1TUl9BTUQ2NF9PU1ZXX0lEX0xFTkdUSAkweGMwMDEwMTQwDQo+PiAg
I2RlZmluZSBNU1JfQU1ENjRfT1NWV19TVEFUVVMJCTB4YzAwMTAxNDENCj4+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2FtZC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9hbWQuYw0K
Pj4gaW5kZXggM2FmZTA3ZDYwMmRkLi44NmZmMTQ2NDMwMmIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L3g4Ni9rZXJuZWwvY3B1L2FtZC5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2FtZC5j
DQo+PiBAQCAtODA0LDYgKzgwNCw0MCBAQCBzdGF0aWMgdm9pZCBpbml0X2FtZF9sbihzdHJ1Y3Qg
Y3B1aW5mb194ODYgKmMpDQo+PiAgCW1zcl9zZXRfYml0KE1TUl9BTUQ2NF9ERV9DRkcsIDMxKTsN
Cj4+ICB9DQo+PiAgDQo+PiArc3RhdGljIGJvb2wgcmRyYW5kX2ZvcmNlOw0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgX19pbml0IHJkcmFuZF9mb3JjZV9jbWRsaW5lKGNoYXIgKnN0cikNCj4+ICt7DQo+
PiArCXJkcmFuZF9mb3JjZSA9IHRydWU7DQo+PiArDQo+PiArCXJldHVybiAwOw0KPj4gK30NCj4+
ICtlYXJseV9wYXJhbSgicmRyYW5kX2ZvcmNlIiwgcmRyYW5kX2ZvcmNlX2NtZGxpbmUpOw0KPiAN
Cj4gTGV0J3MgbWFrZSB0aGlzIGEgbW9yZSBnZW5lcmljIHBhcmFtOg0KPiANCj4gCXJkcmFuZD1m
b3JjZVssIC4uLl0NCj4gDQo+IGluIGNhc2Ugd2Ugd2FubmEgYWRkIHNvbWUgbW9yZSBvcHRzIGhl
cmUgbGF0ZXIuDQoNClN1cmUsIEkgY2FuIGRvIHRoYXQuIERvIHdlIHdhbnQgdG8gdGllIHRoaXMg
aW50byB0aGUgbm9yZHJhbmQgb3B0aW9uIGFuZA0KYWRkIHJkcmFuZD1vZmYgb3Iga2VlcCB0aGF0
IHNlcGFyYXRlPw0KDQo+IA0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIGluaXRfaGlkZV9yZHJhbmQo
c3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPiANCj4gY2xlYXJfcmRyYW5kX2NwdWlkX2JpdCgpDQo+
IA0KPiBpcyB3aGF0IHRoaXMgZnVuY3Rpb24gZG9lcy4NCg0KT2suDQoNCj4gDQo+PiArew0KPj4g
KwkvKg0KPj4gKwkgKiBUaGUgbm9yZHJhbmQgb3B0aW9uIGNhbiBjbGVhciBYODZfRkVBVFVSRV9S
RFJBTkQsIHNvIGNoZWNrIGZvcg0KPj4gKwkgKiBSRFJBTkQgc3VwcG9ydCB1c2luZyB0aGUgQ1BV
SUQgZnVuY3Rpb24gZGlyZWN0bHkuDQo+PiArCSAqLw0KPj4gKwlpZiAoIShjcHVpZF9lY3goMSkg
JiBCSVQoMzApKSB8fCByZHJhbmRfZm9yY2UpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCW1z
cl9jbGVhcl9iaXQoTVNSX0FNRDY0X0NQVUlEX0ZOXzAwMDAwMDAxLCA2Mik7DQo+PiArCWNsZWFy
X2NwdV9jYXAoYywgWDg2X0ZFQVRVUkVfUkRSQU5EKTsNCj4+ICsJcHJfaW5mb19vbmNlKCJoaWRp
bmcgUkRSQU5EIHZpYSBDUFVJRFxuIik7DQo+IA0KPiBObyBuZWVkIGZvciB0aGF0IEkgZ3Vlc3Mg
LSB0aGF0J3MgdmlzaWJsZSBpbiAvcHJvYy9jcHVpbmZvLg0KDQpJIHRoaW5rIHRoaXMgaXMgYSBj
bGVhcmVyIGluZGljYXRpb24gdGhhdCB0aGUgYWN0aW9uIGhhcyB0YWtlbiBwbGFjZS4NCg0KPiAN
Cj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgaW5pdF9hbWRfamcoc3RydWN0IGNwdWluZm9f
eDg2ICpjKQ0KPj4gK3sNCj4+ICsJLyoNCj4+ICsJICogU29tZSBCSU9TIGltcGxlbWVudGF0aW9u
cyBkbyBub3QgcmVzdG9yZSBwcm9wZXIgUkRSQU5EIHN1cHBvcnQNCj4+ICsJICogYWNyb3NzIHN1
c3BlbmQgYW5kIHJlc3VtZS4gQ2hlY2sgb24gd2hldGhlciB0byBoaWRlIHRoZSBSRFJBTkQNCj4+
ICsJICogaW5zdHJ1Y3Rpb24gc3VwcG9ydCB2aWEgQ1BVSUQuDQo+PiArCSAqLw0KPj4gKwlpbml0
X2hpZGVfcmRyYW5kKGMpOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgdm9pZCBpbml0X2FtZF9i
ZChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+PiAgew0KPj4gIAl1NjQgdmFsdWU7DQo+PiBAQCAt
ODE4LDYgKzg1MiwxMyBAQCBzdGF0aWMgdm9pZCBpbml0X2FtZF9iZChzdHJ1Y3QgY3B1aW5mb194
ODYgKmMpDQo+PiAgCQkJd3Jtc3JsX3NhZmUoTVNSX0YxNUhfSUNfQ0ZHLCB2YWx1ZSk7DQo+PiAg
CQl9DQo+PiAgCX0NCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogU29tZSBCSU9TIGltcGxlbWVudGF0
aW9ucyBkbyBub3QgcmVzdG9yZSBwcm9wZXIgUkRSQU5EIHN1cHBvcnQNCj4+ICsJICogYWNyb3Nz
IHN1c3BlbmQgYW5kIHJlc3VtZS4gQ2hlY2sgb24gd2hldGhlciB0byBoaWRlIHRoZSBSRFJBTkQN
Cj4+ICsJICogaW5zdHJ1Y3Rpb24gc3VwcG9ydCB2aWEgQ1BVSUQuDQo+PiArCSAqLw0KPj4gKwlp
bml0X2hpZGVfcmRyYW5kKGMpOw0KPj4gIH0NCj4+ICANCj4+ICBzdGF0aWMgdm9pZCBpbml0X2Ft
ZF96bihzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+PiBAQCAtODYwLDYgKzkwMSw3IEBAIHN0YXRp
YyB2b2lkIGluaXRfYW1kKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4+ICAJY2FzZSAweDEwOiBp
bml0X2FtZF9naChjKTsgYnJlYWs7DQo+PiAgCWNhc2UgMHgxMjogaW5pdF9hbWRfbG4oYyk7IGJy
ZWFrOw0KPj4gIAljYXNlIDB4MTU6IGluaXRfYW1kX2JkKGMpOyBicmVhazsNCj4+ICsJY2FzZSAw
eDE2OiBpbml0X2FtZF9qZyhjKTsgYnJlYWs7DQo+PiAgCWNhc2UgMHgxNzogaW5pdF9hbWRfem4o
Yyk7IGJyZWFrOw0KPj4gIAl9DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvcG93ZXIvY3B1LmMg
Yi9hcmNoL3g4Ni9wb3dlci9jcHUuYw0KPj4gaW5kZXggMWM1OGQ4OTgyNzI4Li4xNDZjNGZkOTBj
M2QgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9wb3dlci9jcHUuYw0KPj4gKysrIGIvYXJjaC94
ODYvcG93ZXIvY3B1LmMNCj4+IEBAIC0xMiw2ICsxMiw3IEBADQo+PiAgI2luY2x1ZGUgPGxpbnV4
L3NtcC5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC9wZXJmX2V2ZW50Lmg+DQo+PiAgI2luY2x1ZGUg
PGxpbnV4L3Rib290Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2RtaS5oPg0KPj4gIA0KPj4gICNp
bmNsdWRlIDxhc20vcGd0YWJsZS5oPg0KPj4gICNpbmNsdWRlIDxhc20vcHJvdG8uaD4NCj4+IEBA
IC0yMyw3ICsyNCw3IEBADQo+PiAgI2luY2x1ZGUgPGFzbS9kZWJ1Z3JlZy5oPg0KPj4gICNpbmNs
dWRlIDxhc20vY3B1Lmg+DQo+PiAgI2luY2x1ZGUgPGFzbS9tbXVfY29udGV4dC5oPg0KPj4gLSNp
bmNsdWRlIDxsaW51eC9kbWkuaD4NCj4+ICsjaW5jbHVkZSA8YXNtL2NwdV9kZXZpY2VfaWQuaD4N
Cj4+ICANCj4+ICAjaWZkZWYgQ09ORklHX1g4Nl8zMg0KPj4gIF9fdmlzaWJsZSB1bnNpZ25lZCBs
b25nIHNhdmVkX2NvbnRleHRfZWJ4Ow0KPj4gQEAgLTM5MywxNSArMzk0LDE0IEBAIHN0YXRpYyBp
bnQgX19pbml0IGJzcF9wbV9jaGVja19pbml0KHZvaWQpDQo+PiAgDQo+PiAgY29yZV9pbml0Y2Fs
bChic3BfcG1fY2hlY2tfaW5pdCk7DQo+PiAgDQo+PiAtc3RhdGljIGludCBtc3JfaW5pdF9jb250
ZXh0KGNvbnN0IHUzMiAqbXNyX2lkLCBjb25zdCBpbnQgdG90YWxfbnVtKQ0KPj4gK3N0YXRpYyBp
bnQgbXNyX2J1aWxkX2NvbnRleHQoY29uc3QgdTMyICptc3JfaWQsIGNvbnN0IGludCBudW0pDQo+
PiAgew0KPj4gLQlpbnQgaSA9IDA7DQo+PiArCXN0cnVjdCBzYXZlZF9tc3JzICpzYXZlZF9tc3Jz
ID0gJnNhdmVkX2NvbnRleHQuc2F2ZWRfbXNyczsNCj4+ICAJc3RydWN0IHNhdmVkX21zciAqbXNy
X2FycmF5Ow0KPj4gKwlpbnQgdG90YWxfbnVtOw0KPj4gKwlpbnQgaSwgajsNCj4+ICANCj4+IC0J
aWYgKHNhdmVkX2NvbnRleHQuc2F2ZWRfbXNycy5hcnJheSB8fCBzYXZlZF9jb250ZXh0LnNhdmVk
X21zcnMubnVtID4gMCkgew0KPj4gLQkJcHJfZXJyKCJ4ODYvcG06IE1TUiBxdWlyayBhbHJlYWR5
IGFwcGxpZWQsIHBsZWFzZSBjaGVjayB5b3VyIERNSSBtYXRjaCB0YWJsZS5cbiIpOw0KPj4gLQkJ
cmV0dXJuIC1FSU5WQUw7DQo+PiAtCX0NCj4+ICsJdG90YWxfbnVtID0gc2F2ZWRfbXNycy0+bnVt
ICsgbnVtOw0KPj4gIA0KPj4gIAltc3JfYXJyYXkgPSBrbWFsbG9jX2FycmF5KHRvdGFsX251bSwg
c2l6ZW9mKHN0cnVjdCBzYXZlZF9tc3IpLCBHRlBfS0VSTkVMKTsNCj4+ICAJaWYgKCFtc3JfYXJy
YXkpIHsNCj4+IEBAIC00MDksMTkgKzQwOSwyNyBAQCBzdGF0aWMgaW50IG1zcl9pbml0X2NvbnRl
eHQoY29uc3QgdTMyICptc3JfaWQsIGNvbnN0IGludCB0b3RhbF9udW0pDQo+PiAgCQlyZXR1cm4g
LUVOT01FTTsNCj4+ICAJfQ0KPj4gIA0KPj4gLQlmb3IgKGkgPSAwOyBpIDwgdG90YWxfbnVtOyBp
KyspIHsNCj4+IC0JCW1zcl9hcnJheVtpXS5pbmZvLm1zcl9ubwk9IG1zcl9pZFtpXTsNCj4+ICsJ
aWYgKHNhdmVkX21zcnMtPmFycmF5KSB7DQo+PiArCQkvKiBDb3B5IHByZXZpb3VzIE1TUiBzYXZl
IHJlcXVlc3RzICovDQo+PiArCQltZW1jcHkobXNyX2FycmF5LCBzYXZlZF9tc3JzLT5hcnJheSwN
Cj4+ICsJCSAgICAgICBzaXplb2Yoc3RydWN0IHNhdmVkX21zcikgKiBzYXZlZF9tc3JzLT5udW0p
Ow0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIHRvIGNvcHkgdGhvc2U/IFdoeSBjYW4ndCB5b3UgdXNl
IHRoZSBpbmZyYXN0cnVjdHVyZSBsaWtlDQo+IG1zcl9pbml0aWFsaXplX2JkdygpIGRvZXM/DQoN
Ck5vdCBzdXJlIHdoYXQgeW91IG1lYW4uIFdlIGNhbid0IHVzZSB0aGUgRE1JIHN0dWZmIGZvciB0
aGlzLiBTbyBub3csIHdpdGgNCnRoZSB4ODYgZmFtaWx5IGNoZWNrcywgaWYgYW55b25lIGFkZHMg
c29tZSBETUkgc3R1ZmYgb3IgeDg2IGZhbWlseSBzdHVmZg0KaW4gdGhlIGZ1dHVyZSB0aGF0IG1h
dGNoZXMgYm90aCB0aGUgRE1JIGFuZCB4ODYgZmFtaWx5IGNoZWNrcywgdGhpcyB3aWxsDQpiZSBj
YWxsZWQgbW9yZSB0aGFuIG9uY2UgYW5kIHNvIHlvdSBuZWVkIHRvIGNvcHkgYW55IHByZXZpb3Vz
IHNldHRpbmdzIGFuZA0KYWRkIHRoZSBuZXcgb25lcy4NCg0KPiANCj4+ICsJCWtmcmVlKHNhdmVk
X21zcnMtPmFycmF5KTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlmb3IgKGkgPSBzYXZlZF9tc3JzLT5u
dW0sIGogPSAwOyBpIDwgdG90YWxfbnVtOyBpKyssIGorKykgew0KPj4gKwkJbXNyX2FycmF5W2ld
LmluZm8ubXNyX25vCT0gbXNyX2lkW2pdOw0KPj4gIAkJbXNyX2FycmF5W2ldLnZhbGlkCQk9IGZh
bHNlOw0KPj4gIAkJbXNyX2FycmF5W2ldLmluZm8ucmVnLnEJCT0gMDsNCj4+ICAJfQ0KPj4gLQlz
YXZlZF9jb250ZXh0LnNhdmVkX21zcnMubnVtCT0gdG90YWxfbnVtOw0KPj4gLQlzYXZlZF9jb250
ZXh0LnNhdmVkX21zcnMuYXJyYXkJPSBtc3JfYXJyYXk7DQo+PiArCXNhdmVkX21zcnMtPm51bSAg
ID0gdG90YWxfbnVtOw0KPj4gKwlzYXZlZF9tc3JzLT5hcnJheSA9IG1zcl9hcnJheTsNCj4+ICAN
Cj4+ICAJcmV0dXJuIDA7DQo+PiAgfQ0KPj4gIA0KPj4gIC8qDQo+PiAtICogVGhlIGZvbGxvd2lu
ZyBzZWN0aW9uIGlzIGEgcXVpcmsgZnJhbWV3b3JrIGZvciBwcm9ibGVtYXRpYyBCSU9TZW46DQo+
PiArICogVGhlIGZvbGxvd2luZyBzZWN0aW9ucyBhcmUgYSBxdWlyayBmcmFtZXdvcmsgZm9yIHBy
b2JsZW1hdGljIEJJT1NlbjoNCj4+ICAgKiBTb21ldGltZXMgTVNScyBhcmUgbW9kaWZpZWQgYnkg
dGhlIEJJT1NlbiBhZnRlciBzdXNwZW5kZWQgdG8NCj4+ICAgKiBSQU0sIHRoaXMgbWlnaHQgY2F1
c2UgdW5leHBlY3RlZCBiZWhhdmlvciBhZnRlciB3YWtldXAuDQo+PiAgICogVGh1cyB3ZSBzYXZl
L3Jlc3RvcmUgdGhlc2Ugc3BlY2lmaWVkIE1TUnMgYWNyb3NzIHN1c3BlbmQvcmVzdW1lDQo+PiBA
QCAtNDM2LDcgKzQ0NCw3IEBAIHN0YXRpYyBpbnQgbXNyX2luaXRpYWxpemVfYmR3KGNvbnN0IHN0
cnVjdCBkbWlfc3lzdGVtX2lkICpkKQ0KPj4gIAl1MzIgYmR3X21zcl9pZFtdID0geyBNU1JfSUEz
Ml9USEVSTV9DT05UUk9MIH07DQo+PiAgDQo+PiAgCXByX2luZm8oIng4Ni9wbTogJXMgZGV0ZWN0
ZWQsIE1TUiBzYXZpbmcgaXMgbmVlZGVkIGR1cmluZyBzdXNwZW5kaW5nLlxuIiwgZC0+aWRlbnQp
Ow0KPj4gLQlyZXR1cm4gbXNyX2luaXRfY29udGV4dChiZHdfbXNyX2lkLCBBUlJBWV9TSVpFKGJk
d19tc3JfaWQpKTsNCj4+ICsJcmV0dXJuIG1zcl9idWlsZF9jb250ZXh0KGJkd19tc3JfaWQsIEFS
UkFZX1NJWkUoYmR3X21zcl9pZCkpOw0KPj4gIH0NCj4+ICANCj4+ICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGRtaV9zeXN0ZW1faWQgbXNyX3NhdmVfZG1pX3RhYmxlW10gPSB7DQo+PiBAQCAtNDUxLDkg
KzQ1OSw1OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgbXNyX3NhdmVfZG1p
X3RhYmxlW10gPSB7DQo+PiAgCXt9DQo+PiAgfTsNCj4+ICANCj4+ICtzdGF0aWMgaW50IG1zcl9z
YXZlX2NwdWlkX2ZlYXR1cmVzKGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkICpjKQ0KPj4gK3sNCj4+
ICsJdTMyIGNwdWlkX21zcl9pZFtdID0gew0KPj4gKwkJTVNSX0FNRDY0X0NQVUlEX0ZOXzAwMDAw
MDAxLA0KPj4gKwl9Ow0KPj4gKw0KPj4gKwlwcl9pbmZvKCJ4ODYvcG06IGZhbWlseSAlI2h4IGNw
dSBkZXRlY3RlZCwgTVNSIHNhdmluZyBpcyBuZWVkZWQgZHVyaW5nIHN1c3BlbmRpbmcuXG4iLA0K
Pj4gKwkJYy0+ZmFtaWx5KTsNCj4+ICsNCj4+ICsJcmV0dXJuIG1zcl9idWlsZF9jb250ZXh0KGNw
dWlkX21zcl9pZCwgQVJSQVlfU0laRShjcHVpZF9tc3JfaWQpKTsNCj4+ICt9DQo+PiArDQo+PiAr
c3RhdGljIGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkIG1zcl9zYXZlX2NwdV90YWJsZVtdID0gew0K
Pj4gKwl7DQo+PiArCQkudmVuZG9yID0gWDg2X1ZFTkRPUl9BTUQsDQo+PiArCQkuZmFtaWx5ID0g
MHgxNSwNCj4+ICsJCS5tb2RlbCA9IFg4Nl9NT0RFTF9BTlksDQo+PiArCQkuZmVhdHVyZSA9IFg4
Nl9GRUFUVVJFX0FOWSwNCj4+ICsJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCltc3Jf
c2F2ZV9jcHVpZF9mZWF0dXJlcywNCj4+ICsJfSwNCj4+ICsJew0KPj4gKwkJLnZlbmRvciA9IFg4
Nl9WRU5ET1JfQU1ELA0KPj4gKwkJLmZhbWlseSA9IDB4MTYsDQo+PiArCQkubW9kZWwgPSBYODZf
TU9ERUxfQU5ZLA0KPj4gKwkJLmZlYXR1cmUgPSBYODZfRkVBVFVSRV9BTlksDQo+PiArCQkuZHJp
dmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpbXNyX3NhdmVfY3B1aWRfZmVhdHVyZXMsDQo+PiAr
CX0sDQo+PiArCXt9DQo+IA0KPiBJIHRoaW5rIHlvdSBjYW4gbWFrZSB0aGF0IHRhYmxlIGEgc2lu
Z2xlIGVudHJ5IGJ5IHNldHRpbmcNCj4gDQo+IAkudmVuZG9yICA9IFg4Nl9WRU5ET1JfQU1ELA0K
PiAJLi4uDQo+IAkuZmVhdHVyZSA9IFg4Nl9GRUFUVVJFX1JEUkFORCwNCj4gDQo+IGFuZCB0aGVu
IGNoZWNraW5nIGZhbWlseSBpbiBtc3Jfc2F2ZV9jcHVpZF9mZWF0dXJlcygpLg0KDQpFeGNlcHQg
dGhhdCBYODZfRkVBVFVSRV9SRFJBTkQgaXNuJ3Qgc2V0IGFueW1vcmUuIEkgY291bGQgY3JlYXRl
IGEgbmV3DQpzb2Z0d2FyZSBmZWF0dXJlIHRoYXQgaXMgc2V0IHdoZW4gdGhlIENQVUlEIGJpdCBp
cyBjbGVhcmVkIGlmIHRoYXQncw0KcHJlZmVycmVkLg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4g
VGh4Lg0KPiANCg==
