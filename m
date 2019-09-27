Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0FFC092D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfI0QIB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 12:08:01 -0400
Received: from mail-eopbgr710079.outbound.protection.outlook.com ([40.107.71.79]:41520
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727517AbfI0QIB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 12:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmzGLLXIlfb6DNhSrULagTBFBxn2sx/L8sGTgqZIPEk8HCFY0omHZLk/gT6x2R0WBQ51i09wCoP4MnUvBflqiEVZcbSLfc6racQHWTavws8ODMAeNP4OFmeEnyU4icBfFEtHCTsUkGNHsCv75vzyKdI/lJ6avTCIdR1BzTL/QHhSwC32+FPRKn4u1XeyW5DtPo35KuII1LZLh3Diuzh3Q19cHt8oqbuuKKIz1ZubMPNtU9R3IX2hnfIGnTVbCKoa5nQ/nWCzew1LkTxsRk9L8ZpUE6aZX5lUsIgwFvQ/c7Lhi4WhSGkS2mIbAvoeHyw2UcAMpqC4Zrwp+Iu/Wvzu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk0Y7qc/jlK+PYbSUyeY4D+Q/yHqdtmpb4/YPsjcLaY=;
 b=l5GUc/8sMBK7k2MMcePrdqiYpynrLpla12GEvxV6JElrO4wCz57nVq8YXH10JY84p+Eb72FdsSeKbdGz1cOdCgoYtToCz7vhN1e/NaF//MdgW0t8PbvhtcnYv6mGyVMiXKD7LoIDSpHEiPK/GJR9JVJXvYXJPlfk9BWiHTM5bNyl3eCPW3ntq5a2N7GJEILl+l4WfBvIVFIJZOqC7UGF2xnI7juDmV1qfaem1RUzM1Nz0BATD/tmXoA1zreThKvq249iV5jXEXlE4aVfcnjpn7aoMzkVfGxjRgVcYDVuFU6sotFyLDvUMBxIrLircZckY09PUjUs5puDU2XYQZ6z8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk0Y7qc/jlK+PYbSUyeY4D+Q/yHqdtmpb4/YPsjcLaY=;
 b=0NRvRhwRV8r0Xu/7P09cT0g2360evtaCLl4VDiSvCzdBnhWz6xzpykE+W3Nv+k4TGeXjbCj06vBp2dWEq5tgGr8nxk/n3/jCkJzyysr0466QCMj2dtdKx7eTx2MdbaQHQPNF8bR3ip47MAC6KCUWqhUTeM/fY/4y7YLGa5OSY3w=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2671.namprd12.prod.outlook.com (52.135.103.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Fri, 27 Sep 2019 16:07:56 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 16:07:56 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Pu Wen <puwen@hygon.com>, Borislav Petkov <bp@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Topic: [PATCH 1/2] Modify cpupower to schedule itself on cores it is
 reading MSRs from
Thread-Index: AQHVbj8CzXj8hQvM60aQ8slBTBcq36c/vvOA
Date:   Fri, 27 Sep 2019 16:07:56 +0000
Message-ID: <9f94bb60-4be2-4303-54de-f50bdd7cb3e6@amd.com>
References: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
In-Reply-To: <20190918163445.129103-1-Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR01CA0018.prod.exchangelabs.com (2603:10b6:805:b6::31)
 To SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76b5aeb2-aff4-478b-f817-08d74364dc1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2671;
x-ms-traffictypediagnostic: SN6PR12MB2671:|SN6PR12MB2671:
x-microsoft-antispam-prvs: <SN6PR12MB2671763FD9A034C68306B2D2E7810@SN6PR12MB2671.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(186003)(25786009)(2616005)(6486002)(53546011)(6506007)(102836004)(386003)(26005)(36756003)(54906003)(52116002)(446003)(11346002)(229853002)(7416002)(31686004)(66946007)(316002)(486006)(76176011)(6436002)(14454004)(66556008)(66476007)(64756008)(66446008)(2501003)(4326008)(476003)(6246003)(5660300002)(81156014)(81166006)(31696002)(7736002)(110136005)(99286004)(71190400001)(305945005)(86362001)(2906002)(8936002)(478600001)(8676002)(6512007)(6116002)(3846002)(66066001)(256004)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SnlUakypfxu5PKId7qnacXhS5ju9Xrc+GlWLYEHAD2tXQL9cRSP5B+dXHb6IUcuVIv68CLSL9UW2TU6Sh/PNo//SYtQ/I0NDt7Pd6JZqH30cO9BwWeVi9dfYoBilkyVR9LRrcdXzO3NaLG/ZCwal9dvsQz0SL+9ldciGBn04XjgTm3wQgN0lnJH7CTi1RC3C+/efcNB1oTRplmT/xS/I5VjbV9sJ21YKntr/VE0ULxLnTbtFRLehcYkm/7Rl3Wz5bpOjaebWltmh6XA6B5FEOMrGcm4xzWaOblUJHvwMFRiqaE9H4tMyKjNdMFkMBrxzBn7yewhZuiNIgyGjK84WycH2YqjNMVPH7EwliCSNvN58DDkSrPMlmdcJSGljYQqc5qPpVbkHXSXtFBskFK8Cnb1xEQSMXw0BvVT99bW209c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02461F61FA778A4CBD87D0AB3ABEEFC8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b5aeb2-aff4-478b-f817-08d74364dc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 16:07:56.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqe50y7YV2DQZsse+YM8sX27sjE/Wj/KWBDyx+jlr0sCgGiyhPdDs+UfonptmLWvl1dbP/0vZoKF9byAd8lLSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gOS8xOC8yMDE5IDExOjM0IEFNLCBOYXRhcmFqYW4sIEphbmFrYXJhamFuIHdyb3RlOg0KPiBN
b2RpZnkgY3B1cG93ZXIgdG8gc2NoZWR1bGUgaXRzZWxmIG9uIGVhY2ggb2YgdGhlIGNwdXMgaW4g
dGhlIHN5c3RlbSBhbmQNCj4gdGhlbiBnZXQgdGhlIEFQRVJGL01QRVJGIHJlZ2lzdGVyIHZhbHVl
cy4NCj4NCj4gVGhpcyBpcyBhZHZhbnRhZ2VvdXMgYmVjYXVzZSBhbiBJUEkgaXMgbm90IGdlbmVy
YXRlZCB3aGVuIGEgcmVhZF9tc3IoKSBpcw0KPiBleGVjdXRlZCBvbiB0aGUgbG9jYWwgbG9naWNh
bCBDUFUgdGhlcmVieSByZWR1Y2luZyB0aGUgY2hhbmNlIG9mIGhhdmluZw0KPiBBUEVSRiBhbmQg
TVBFUkYgYmVpbmcgb3V0IG9mIHN5bmMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEphbmFrYXJhamFu
IE5hdGFyYWphbiA8SmFuYWthcmFqYW4uTmF0YXJhamFuQGFtZC5jb20+DQoNCg0KQW55IGNvbmNl
cm5zIHJlZ2FyZGluZyB0aGlzIHBhdGNoc2V0Pw0KDQoNClRoYW5rcy4NCg0KDQo+IC0tLQ0KPiAg
IC4uLi91dGlscy9pZGxlX21vbml0b3IvbXBlcmZfbW9uaXRvci5jICAgICAgICB8IDM4ICsrKysr
KysrKysrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTAg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91dGls
cy9pZGxlX21vbml0b3IvbXBlcmZfbW9uaXRvci5jIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRp
bHMvaWRsZV9tb25pdG9yL21wZXJmX21vbml0b3IuYw0KPiBpbmRleCA0NDgwNmE2ZGFlMTEuLjhi
MDcyZTM5Yzg5NyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaWRs
ZV9tb25pdG9yL21wZXJmX21vbml0b3IuYw0KPiArKysgYi90b29scy9wb3dlci9jcHVwb3dlci91
dGlscy9pZGxlX21vbml0b3IvbXBlcmZfbW9uaXRvci5jDQo+IEBAIC0xMCw2ICsxMCw3IEBADQo+
ICAgI2luY2x1ZGUgPHN0ZGxpYi5oPg0KPiAgICNpbmNsdWRlIDxzdHJpbmcuaD4NCj4gICAjaW5j
bHVkZSA8bGltaXRzLmg+DQo+ICsjaW5jbHVkZSA8c2NoZWQuaD4NCj4gICANCj4gICAjaW5jbHVk
ZSA8Y3B1ZnJlcS5oPg0KPiAgIA0KPiBAQCAtODYsMTUgKzg3LDMzIEBAIHN0YXRpYyBpbnQgbXBl
cmZfZ2V0X3RzYyh1bnNpZ25lZCBsb25nIGxvbmcgKnRzYykNCj4gICAJcmV0dXJuIHJldDsNCj4g
ICB9DQo+ICAgDQo+ICtzdGF0aWMgaW50IGdldF9hcGVyZl9tcGVyZihpbnQgY3B1LCB1bnNpZ25l
ZCBsb25nIGxvbmcgKmF2YWwsDQo+ICsJCQkgICB1bnNpZ25lZCBsb25nIGxvbmcgKm12YWwpDQo+
ICt7DQo+ICsJY3B1X3NldF90IHNldDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJQ1BVX1pFUk8o
JnNldCk7DQo+ICsJQ1BVX1NFVChjcHUsICZzZXQpOw0KPiArCWlmIChzY2hlZF9zZXRhZmZpbml0
eShnZXRwaWQoKSwgc2l6ZW9mKHNldCksICZzZXQpID09IC0xKSB7DQo+ICsJCWRwcmludCgiQ291
bGQgbm90IG1pZ3JhdGUgdG8gY3B1OiAlZFxuIiwgY3B1KTsNCj4gKwkJcmV0dXJuIDE7DQo+ICsJ
fQ0KPiArDQo+ICsJcmV0ID0gcmVhZF9tc3IoY3B1LCBNU1JfQVBFUkYsIGF2YWwpOw0KPiArCXJl
dCB8PSByZWFkX21zcihjcHUsIE1TUl9NUEVSRiwgbXZhbCk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0
Ow0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCBtcGVyZl9pbml0X3N0YXRzKHVuc2lnbmVkIGlu
dCBjcHUpDQo+ICAgew0KPiAtCXVuc2lnbmVkIGxvbmcgbG9uZyB2YWw7DQo+ICsJdW5zaWduZWQg
bG9uZyBsb25nIGF2YWwsIG12YWw7DQo+ICAgCWludCByZXQ7DQo+ICAgDQo+IC0JcmV0ID0gcmVh
ZF9tc3IoY3B1LCBNU1JfQVBFUkYsICZ2YWwpOw0KPiAtCWFwZXJmX3ByZXZpb3VzX2NvdW50W2Nw
dV0gPSB2YWw7DQo+IC0JcmV0IHw9IHJlYWRfbXNyKGNwdSwgTVNSX01QRVJGLCAmdmFsKTsNCj4g
LQltcGVyZl9wcmV2aW91c19jb3VudFtjcHVdID0gdmFsOw0KPiArCXJldCA9IGdldF9hcGVyZl9t
cGVyZihjcHUsICZhdmFsLCAmbXZhbCk7DQo+ICsJYXBlcmZfcHJldmlvdXNfY291bnRbY3B1XSA9
IGF2YWw7DQo+ICsJbXBlcmZfcHJldmlvdXNfY291bnRbY3B1XSA9IG12YWw7DQo+ICAgCWlzX3Zh
bGlkW2NwdV0gPSAhcmV0Ow0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4gQEAgLTEwMiwxMyArMTIx
LDEyIEBAIHN0YXRpYyBpbnQgbXBlcmZfaW5pdF9zdGF0cyh1bnNpZ25lZCBpbnQgY3B1KQ0KPiAg
IA0KPiAgIHN0YXRpYyBpbnQgbXBlcmZfbWVhc3VyZV9zdGF0cyh1bnNpZ25lZCBpbnQgY3B1KQ0K
PiAgIHsNCj4gLQl1bnNpZ25lZCBsb25nIGxvbmcgdmFsOw0KPiArCXVuc2lnbmVkIGxvbmcgbG9u
ZyBhdmFsLCBtdmFsOw0KPiAgIAlpbnQgcmV0Ow0KPiAgIA0KPiAtCXJldCA9IHJlYWRfbXNyKGNw
dSwgTVNSX0FQRVJGLCAmdmFsKTsNCj4gLQlhcGVyZl9jdXJyZW50X2NvdW50W2NwdV0gPSB2YWw7
DQo+IC0JcmV0IHw9IHJlYWRfbXNyKGNwdSwgTVNSX01QRVJGLCAmdmFsKTsNCj4gLQltcGVyZl9j
dXJyZW50X2NvdW50W2NwdV0gPSB2YWw7DQo+ICsJcmV0ID0gZ2V0X2FwZXJmX21wZXJmKGNwdSwg
JmF2YWwsICZtdmFsKTsNCj4gKwlhcGVyZl9jdXJyZW50X2NvdW50W2NwdV0gPSBhdmFsOw0KPiAr
CW1wZXJmX2N1cnJlbnRfY291bnRbY3B1XSA9IG12YWw7DQo+ICAgCWlzX3ZhbGlkW2NwdV0gPSAh
cmV0Ow0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCg==
