Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D829852F
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 01:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420947AbgJZAyZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 20:54:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:8152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1420944AbgJZAyY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 25 Oct 2020 20:54:24 -0400
IronPort-SDR: PkD+CALuW65F0K+nOjcc0kT5VJOJZVU6cyjzOHNrmQVxYqtNNphoGYcF5XgV4iaSAf75bPz0D3
 GZiH8WMq1ikQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="154830880"
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="154830880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2020 17:54:23 -0700
IronPort-SDR: HN9nkUjtT1hTkoq911CDEB08SF0czOfL4YeC4arXtATrh4XjZoREB7hvV5VMSsmJjtsULFMr0W
 XT8zwE5BJYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="525331540"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 25 Oct 2020 17:54:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 25 Oct 2020 17:54:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 25 Oct 2020 17:54:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 25 Oct 2020 17:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpHSVGRCK8WzsDWqycSIq5SDuTOif1r2TUQIdu1h5meueiZkJl0XI9vIz/ZO8BALxFoWAcDeVaAVeNXaGNR7GxlNJwNpPE5yLDOrEJQl4yml17TOrK9PpCbuOh8FJaxTq/HFOZEfqgBan+itXvRafr3axE4tr437DR5vCozRtDo0kcGbmXtc/5JmIu/QCy064xU6gOavwab16qbGTQ1+GQOOfXWCP1ZXE7La2fom21hQyDB+0vO08teGtG0MRFz75aAxQ+NQZmP5KyNneQBs+gnjkYMs5GlEp+30Sf9ddmJsxVe/YegKL1TthCRAafP4peUT7nvXI/+8+p2c8ac+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRWgkX3wTOs8LWwscatjLHQQw9l2RnFQe7QSWQPoBvs=;
 b=gGScUFlXUQDIZ72EX64vvudqbjymw6skJ3YqDhNwTN0IpZXZD4Nt1isn/4i4mJd9EBR1BkGvbkAGC9YloQ13gI9nw83p3J8NoybmftZbHyUtxe+3dqMrR0+tpMZOJwyWYXrj4rT6fKjiQstxTwZE75tdNAn/6ohQQyUXZrh8p8ixDkAaWRdiqtw5sQhYl7b+aMGrXgXG0lgZPB+HWALq5xVl+fIiZ/iWO9RwR8uzSuadToj0NyIYxmNVWp7cbwpVBaPPdpCvJU77ft6QyW8etmAYzj57KkLif6lAeEPW8KL1xHpbdtjgfTXi7AAMCUfGwG0cEJpKdHB6FmbUquMH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRWgkX3wTOs8LWwscatjLHQQw9l2RnFQe7QSWQPoBvs=;
 b=mG1NfB8KzrhjpW6MkTek6fmb1nGtzTr5kMOpMEljQMk3V9CBH1xTYoWoUqpqNaXB28lCgSLvRMq2Z3T+l4xdL5FIHGfD3ZV9BrGiPCXXPc3JFbKxSFq8EDRZ8TEvb6JpRZPpK05a1NJqQSZhsInv1Ew68rQlDYaZYaKTDLwdknM=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA0PR11MB4606.namprd11.prod.outlook.com (2603:10b6:806:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 00:54:01 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::b901:8e07:4340:6704%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 00:54:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "cl@linux.com" <cl@linux.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "rientjes@google.com" <rientjes@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "luto@kernel.org" <luto@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "Brown, Len" <len.brown@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: Re: [PATCH 4/4] arch, mm: make kernel_page_present() always available
Thread-Topic: [PATCH 4/4] arch, mm: make kernel_page_present() always
 available
Thread-Index: AQHWqrgGgdwDAwy5cUu01lVq6vOTuKmpD4sA
Date:   Mon, 26 Oct 2020 00:54:01 +0000
Message-ID: <979889bf987fdc7268a973fe7398198bfad1644f.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <20201025101555.3057-5-rppt@kernel.org>
In-Reply-To: <20201025101555.3057-5-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 794bf28d-df69-4611-d787-08d87949a137
x-ms-traffictypediagnostic: SA0PR11MB4606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB4606B6552F6501FD8D221323C9190@SA0PR11MB4606.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpsZHvV7qYqVZkCugBUPgRi9DL10h/AUHnveifgqN9JpA8IFkUv7bt5xz6eGR/ksklqW+9+q+128RgXC3thRkQMIkW0PlUlukp3wAnmnY8otCvotpLJTU6Jktfe/WkvTsx+XpDygoVqigXpodFPS/TFPX4RjXKgE89S+0cerqvk4tfpvbxC+JiIH0Gv14+gp4/5uCmxJYQQl5gRu/P5ZoeCbeBehBEZ22910ojoSjV6bWBubCt3l1M4q+nYdULkv27GRgV1gOq1STzO7ZoygRe84LfUZpxoWFsRuqM9WL1w+NbH3kRPu4OwmXWSLwdSdFjFc3hfIZaCZzdh7dsqHBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(6486002)(66476007)(110136005)(4326008)(8676002)(316002)(478600001)(4001150100001)(186003)(8936002)(54906003)(6506007)(26005)(5660300002)(66446008)(7416002)(83380400001)(64756008)(66946007)(86362001)(2906002)(71200400001)(7406005)(2616005)(6512007)(76116006)(66556008)(36756003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WAIHpPlEyh9DlbJJ/HkKEjOrj3rQTFAXq28J6rFp9fxqgNatbPTiPYg+oeGUXvggbItHHwuxwqsxuG6AHxqEF1H9fPV5AzT8aRT17vKmThSysopdmlhcVvH2YwKru2BULVmzfJaFRPwRyZrWC7betBc97pFfyUv/lQos2cQpLXO8RMD7hWxHmtGc7sobHvEjBRmSyNswdy3x4v9DDvM9xpeQRm04NuS3OxLwdMn6L4G4gCi1DawpuiAXBBE987W6RCIpQ2G1tj5yBfk18Y2a1SFz5pdWBppAbYAyn/6X5nSecw5hdRDQx1SOuSfNMp2WJPMMLZ/3QtLQXeWwkasoz83BcIXEBeNEPnDb5hz6NM3achdThdAJUjTwgT6ErCbulmK4JmMrv6dfPxonICRckO+uqE9BpVGau9aZtECbxJBob8557MktYD4Fkv0DqruhhH6CPIUQAA0uGbwi4tdDjA3kjBqjTmLY3KXT4kDpr/qWpD3rgANwbJ0U8KF9XTPrUqnVOhZGB5JSRwtsrixZx69oZTLagHwd4QCZHDfBfnolAA51+Jfc9UCU330/TO/52wK08EmwiG+6DH4pPU4430qKKkR6IV8mQpOGF4h4roux8zLrDgmSXZahvSvdkf77d0vvPMrFXqLeR0g5ZSHcpw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D4CB5DDF3DD214BA434D481A4E9F078@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794bf28d-df69-4611-d787-08d87949a137
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 00:54:01.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1jBix2rtmPMikGlcaNeeA3YbAxRYzrAps7Fk/uxDW3dOkih6NNXzKLnvvbPTR1ZWAlg7y969nwvK8cVE8l7Usd+u1HEw4Gt3mXtH90WVL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4606
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gU3VuLCAyMDIwLTEwLTI1IGF0IDEyOjE1ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBpbmRleCA3ZjI0OGZjNDUzMTcuLjE2Zjg3OGMyNjY2NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYvbW0vcGF0L3NldF9tZW1vcnkuYw0KPiArKysgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9y
eS5jDQo+IEBAIC0yMjI4LDcgKzIyMjgsNiBAQCB2b2lkIF9fa2VybmVsX21hcF9wYWdlcyhzdHJ1
Y3QgcGFnZSAqcGFnZSwgaW50DQo+IG51bXBhZ2VzLCBpbnQgZW5hYmxlKQ0KPiAgfQ0KPiAgI2Vu
ZGlmIC8qIENPTkZJR19ERUJVR19QQUdFQUxMT0MgKi8NCj4gIA0KPiAtI2lmZGVmIENPTkZJR19I
SUJFUk5BVElPTg0KPiAgYm9vbCBrZXJuZWxfcGFnZV9wcmVzZW50KHN0cnVjdCBwYWdlICpwYWdl
KQ0KPiAgew0KPiAgICAgICAgIHVuc2lnbmVkIGludCBsZXZlbDsNCj4gQEAgLTIyNDAsNyArMjIz
OSw2IEBAIGJvb2wga2VybmVsX3BhZ2VfcHJlc2VudChzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gICAg
ICAgICBwdGUgPSBsb29rdXBfYWRkcmVzcygodW5zaWduZWQgbG9uZylwYWdlX2FkZHJlc3MocGFn
ZSksDQo+ICZsZXZlbCk7DQo+ICAgICAgICAgcmV0dXJuIChwdGVfdmFsKCpwdGUpICYgX1BBR0Vf
UFJFU0VOVCk7DQo+ICB9DQo+IC0jZW5kaWYgLyogQ09ORklHX0hJQkVSTkFUSU9OICovDQoNClRo
aXMgaXMgb25seSB1c2VkIGJ5IGhpYmVybmF0ZSB0b2RheSByaWdodD8gTWFrZXMgc2Vuc2UgdGhh
dCBpdCBzaG91bGQNCnJldHVybiBhIGNvcnJlY3QgYW5zd2VyIGlmIHNvbWVvbmUgc3RhcnRzIHRv
IHVzZSBpdCB3aXRob3V0IGxvb2tpbmcgdG9vDQpjbG9zZWx5IGF0IHRoZSBoZWFkZXIuIEJ1dCBj
b3VsZCB3ZSBqdXN0IHJlbW92ZSB0aGUgZGVmYXVsdCBzdGF0aWMNCmlubGluZSByZXR1cm4gdHJ1
ZSBpbXBsZW1lbnRhdGlvbiBhbmQgbGV0IHRoZSBsaW5rZXIgZmFpbCBpZiBzb21lb25lDQpzdGFy
dHMgdG8gdXNlIGl0IG91dHNpZGUgaGliZXJuYXRlPyBUaGVuIHdlIGNvdWxkIGxlYXZlIGl0IGNv
bXBpbGVkIG91dA0KdW50aWwgdGhlbi4NCg0KQWxzbyBpdCBsb29rcyBsaWtlIHJpc2N2IGRvZXMg
bm90IGhhdmUgQVJDSF9ISUJFUk5BVElPTl9QT1NTSUJMRSBzbyB0aGUNCm5ldyBmdW5jdGlvbiBh
ZGRlZCBoZXJlIGNvdWxkbid0IGJlIHVzZWQgeWV0LiBZb3UgY291bGQgYWxzbyBqdXN0IGxldA0K
dGhlIGxpbmtlciBjYXRjaCBpdCBpZiByaXNjdiBldmVyIGVuYWJsZXMgaGliZXJuYXRlPw0K
