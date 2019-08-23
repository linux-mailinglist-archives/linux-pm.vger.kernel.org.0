Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7639AE5E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 13:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393023AbfHWLsD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 07:48:03 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:19071
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393008AbfHWLsC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Aug 2019 07:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7OLK/HD5M/WGZfaPcqxIcWvUNU35Zwgn1n2fzAcr4LL/wJGLqZEDWFIRZlWAhzkJY6YnfEU2p+bzDw7dbHLBkd3Q7ia6LUVNyDewlI0FRhJCperEnXVYxO1fdu7E5PL7yhqFYFavt2Lip7/Jr4rSGf4VP8/YAMQDyj9kZpYRKXnwnhLpYZF/nyvK3aiHzQMnFrx1BNQCg5f9XiSN/OUTke5i0c6fGpkw+WZ+EPqWa0u5+i1inpkU7Rq+Epf1xDdpRbK5Q2sNgHlsclrfejWpqVRM2nqHakKsWXb/JFkheMi+J1b8duT3aLatR/e5etHJAE8QuT1AB5YRoYNgCi49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VULKfr57prhywgzxr2+E/LJ33ICGezmSZyCtqKvZItE=;
 b=L8Hpyz5+6vt1r3xPoYvMlI+CTC1XHvciQ8DMGdPFqU9+200Rz0f4pCbvzippXyT4bGxhyWP3ysvVR07H0+8o/Q9iGZQCkUWYs2Dv7ZqQ+LmtUHDyGu4Jv01oJT7Kqjt8GEJ3WmRX97O6t1toQjUN91XJr5wUP8UnYRmqvXyr1Wh1IpLkt5IZedu4Z4PzQqdIR7BvnI9iC3TQgqZxxHhZMZyiKin9KZPj+S1UjfFsyB5YMzWIICBVBCFNiey98h1e771rpA9/IDs9XHD6Z2TYDEWWFj8KvsIyoVT6DouUoluiymHloi8pneVRzYabxTm3Ty4crelgBiIWNb7b9JuAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VULKfr57prhywgzxr2+E/LJ33ICGezmSZyCtqKvZItE=;
 b=SichgAGXNlvdkaDLmBH67fD1gWWzbeBkWpiOpZtWgoBpSqiGomObYbbM4r0IcjqeXF3nZKkR+h1da2/6dJfJdO85WxI44LMyQfSquFb8XGiYYuQ/5MPxvPIOPgYLBTeKmwm0wJhPNO8l45OnsCq12LwnbEOzwChLlV4CGlIxs2c=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5278.eurprd04.prod.outlook.com (20.177.51.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 11:47:53 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 11:47:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Subject: Re: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
Thread-Topic: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
Thread-Index: AQHVV8RskIGk1lt2FkKxkb2XApS7YQ==
Date:   Fri, 23 Aug 2019 11:47:53 +0000
Message-ID: <VI1PR04MB7023836E865F1F14459616A7EEA40@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566314535.git.leonard.crestez@nxp.com>
 <CGME20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1@epcas4p3.samsung.com>
 <af14021b98254032e856397b54329756c1cc59c0.1566314535.git.leonard.crestez@nxp.com>
 <e2ba9b0d-1930-0d2a-c262-72f0f85c86d0@samsung.com>
 <VI1PR04MB7023A7AC7DDE349BF6D2D2C9EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <921d9eb8-aa38-6e67-ac2e-55e01bf630f5@samsung.com>
 <VI1PR04MB7023D551332373BE98CA60E8EEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <4bdc0742-42ab-1ab6-4868-409eb9738cd8@samsung.com>
 <VI1PR04MB70231FF65C1A50FD6830D88FEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <c03f5a54-4c7c-f574-55ba-d84b6b160a06@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc4b09d4-04ba-4b26-b61d-08d727bfbb6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5278;
x-ms-traffictypediagnostic: VI1PR04MB5278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5278C9CC9C7FAF547EF1E54DEEA40@VI1PR04MB5278.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(51444003)(199004)(189003)(7416002)(81156014)(44832011)(446003)(66066001)(74316002)(186003)(6916009)(66446008)(86362001)(91956017)(14454004)(478600001)(76176011)(76116006)(66476007)(26005)(8676002)(256004)(81166006)(102836004)(6506007)(486006)(305945005)(53546011)(476003)(7736002)(9686003)(71190400001)(99286004)(54906003)(33656002)(2906002)(6436002)(25786009)(64756008)(55016002)(8936002)(14444005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(52536014)(6246003)(4326008)(229853002)(3846002)(316002)(6116002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5278;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2pymWOCVARgZU/V3bxAwXsZ9XpTcsA3i3azBcwwVRmZ6uKYJeFVdhVdpj+uTLEUM96S9blFvuvMYhPGZJbxrEwFNZZBacuzZLQaOUM4AQDPHDwwK1U975T01SJMVsjJ/aCfz3nObg2GNt0wa7kIeTyRx0LzbHxcXdfb+0FlgMK4AfbaFSszmW7dLA+rsiI02u0ReWduFKfwGSrGzSHxHakCqbPRg8M73k+jOzpzM8b0R2ZnRelww4is20Ns/ROOGjAt+TJwLAMzj7XhEZMs4SqK6P1ErAgrYRQH3m9/0rgVhbn5xnoJDSde/Kp7FenDogp1QlbCfQKckTQFYqjo6RqH3jJRyN6DGefleyVIfW0ZYKa4SrBp6dZAC5tH0NU842YKX7OGvTNi721ZRNi9xZh2r5poLu82FMAH3JZ4t4aI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4b09d4-04ba-4b26-b61d-08d727bfbb6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 11:47:53.2011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioU+AAOG+oVvtvh7L76+f4OazwLmJq2QG6zDjMj7ni6HkasgQpQX8DiiLo+g9vv8XiQ/Sszx1lfig5PT/Tyg8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5278
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMjMuMDguMjAxOSAxMTozNiwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IE9uIDE5LiA4LiAyMi4g
7Jik7ZuEIDk6MjQsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToKPj4gT24gMjIuMDguMjAxOSAxNDow
NiwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+Pj4gT24gMTkuIDguIDIyLiDsmKTtm4QgNzo1OCwgTGVv
bmFyZCBDcmVzdGV6IHdyb3RlOgo+Pj4+IE9uIDgvMjIvMjAxOSAxOjAzIFBNLCBDaGFud29vIENo
b2kgd3JvdGU6Cj4+Pj4+IFRoaXMgcGF0Y2ggZG9lc24ndCBjaGVjayB0aGUgcmFuZ2Ugb2YgaW5w
dXQgdmFsdWUKPj4+Pj4gd2l0aCB0aGUgc3VwcG9ydGVkIGZyZXF1ZW5jaWVzIG9mIGRldmZyZXEg
ZGV2aWNlLgo+Pj4+Pgo+Pj4+PiBGb3IgZXhhbXBsZSwKPj4+Pj4gVGhlIGRldmZyZXEwIGRldmlj
ZSBoYXMgdGhlIGZvbGxvd2luZyBhdmFpbGFibGUgZnJlcXVlbmNpZXMKPj4+Pj4gMTAwMDAwMDAw
IDIwMDAwMDAwMCAzMDAwMDAwMDAKPj4+Pj4KPj4+Pj4gYW5kIHRoZW4gdXNlciBlbnRlcnMgdGhl
IDUwMDAwMDAwMCBhcyBmb2xsb3dpbmc6Cj4+Pj4+IGVjaG8gNTAwMDAwMDAwID4gL3N5cy9jbGFz
cy9kZXZmcmVxL2RldmZyZXEwL21pbl9mcmVxCj4+Pj4+Cj4+Pj4+IEluIHJlc3VsdCwgZ2V0X2Vm
ZmVjdGl2ZV9taW5fZnJlcSgpIHdpbGwgcmV0dXJuIHRoZSA1MDAwMDAwMDAuCj4+Pj4+IEl0IGlz
IHdyb25nIHZhbHVlLiBpdCBzaG93IHRoZSB1bnN1cHBvcnRlZCBmcmVxdWVuY3kgdGhyb3VnaAo+
Pj4+PiBtaW5fZnJlcSBzeXNmcyBwYXRoLgo+Pj4+Cj4+Pj4gVGhyb3VnaCBkZXZfcG1fcW9zIGRl
dmljZXMgY2FuIGFsc28gYXNrIGZvciBhIGZyZXEgaGlnaGVyIHRoYW4gdGhlCj4+Pj4gbWF4aW11
bSBPUFAgYW5kIHVubGlrZSBzeXNmcyB0aGVyZSBpcyBubyB3YXkgdG8gcmVqZWN0IHN1Y2ggcmVx
dWVzdHMsCj4+Pj4gaW5zdGVhZCBQTSBxb3MgY2xhaW1zIGl0J3MgYmFzZWQgb24gImJlc3QgZWZm
b3J0Ii4KPj4+Pgo+Pj4+IFRoZXJlIGFyZSBtYW55IHJlcXVlc3RzIGluIHRoZSBrZXJuZWwgZm9y
ICJQTV9RT1NfQ1BVX0RNQV9MQVRFTkNZIDAiIGFuZAo+Pj4+IEkgdGhpbmsgdGhhdCBERVZfUE1f
UU9TX01JTl9GUkVRVUVOQ1ksIE1BWF9TMzIgaXMgYSByZWFzb25hYmxlIHdheSBmb3IgYQo+Pj4+
IGRldmljZSB0byByZXF1ZXN0ICJtYXggcGVyZm9ybWFuY2UiIGZyb20gZGV2ZnJlcS4KPj4+Pgo+
Pj4+IFJlamVjdGluZyBtaW4gPiBtYXggaXMgY29tcGxpY2F0ZWQgKHdoYXQgaGFwcGVucyB0byBy
ZWplY3RlZCByZXF1ZXN0cwo+Pj4+IHdoZW4gbWF4IGdvZXMgYmFjayB1cD8pIGFuZCBJIHRoaW5r
IGl0J3MgYmV0dGVyIHRvIGp1c3Qgc3RpY2sgd2l0aCBhCj4+Pj4gIm1heCBvdmVycmlkZXMgbWlu
IiBwb2xpY3kgc2luY2UgaXQgY2FuIGFscmVhZHkgZGVhbCB3aXRoIGNvbmZsaWN0cy4KPj4+Pgo+
Pj4+IERvIHlvdSBoYXZlIGEgdXNlY2FzZSBmb3IgcmVqZWN0aW5nIG91dC1vZi1yYW5nZSBtaW5f
ZnJlcSBmcm9tCj4+Pj4gdXNlcnNwYWNlPyBjcHVmcmVxIGFsc28gYWNjZXB0cyBhcmJpdHJhcnkg
bWluL21heCB2YWx1ZXMgYW5kIGhhbmRsZXMgdGhlbS4KPj4+Cj4+PiBJIGRvbid0IG1lYW4gdGhl
IHJlamVjdGluZyB3aGVuIHVzZXIgZW50ZXIgdGhlIG91dC1vZi1yYW5nZSBmcmVxdWVuY3kuCj4+
PiBBcyBJIGNvbW1lbnRlZCwgdXNlciBjYW4gZW50ZXIgdGhlIHZhbHVlIHRoZXkgd2FudC4gQnV0
LCB3ZSBzaG91bGQKPj4+IGNoZWNrIHRoZSByYW5nZSBvZiBpbnB1dCBiZWNhdXNlIGRldmZyZXEg
aGF2ZSB0byBzaG93IHRoZSBjb3JyZWN0IHN1cHBvcnRlZAo+Pj4gZnJlcXVlbmN5IHRocm91Z2gg
c3lzZnMuCj4+Cj4+IFdlIGNhbiBhdm9pZCBzaG93aW5nIGFuIG91dC1vZi1yYW5nZSB2YWx1ZSBp
biBtaW5fZnJlcSBieSBwcmludGluZwo+PiBtaW4obWluX2ZyZXEsIG1heF9mcmVxKS4KPiAKPiBZ
b3UgY2FuIGNoZWNrIHRoZSByYW5nZSBvZiBmcmVxdWVuY3kgaW4gdGhlIGdldF9taW5fZnJlcSgp
L2dldF9tYXhfZnJlcSgpLgo+IEkgd2FudCB0byByZXR1cm4gdGhlIG1lYW5pbmdmdWwgZnJlcXVl
bmN5IGZyb20gZ2V0X21pbl9mcmVxKCkvZ2V0X21heF9mcmVxKCkuCj4gCj4gRXZlcnlvbmUgZXhw
ZWN0cyBnZXRfbWluX2ZyZXEoKS9nZXRfbWF4X2ZyZXEoKSBmdW5jdGlvbnMgd2lsbCByZXR1bnJu
Cj4gdGhlIHN1cHBvcnRlZCBtaW4vbWF4IGZyZXF1ZW5jeS4gSWYgZ2V0X21pbl9mcmVxKCkvZ2V0
X21heF9mcmVxKCkKPiByZXR1cm4gdGhlIG91ci1vZi1yYW5nZSBmcmVxdWVuY3ksIGl0IGlzIG5v
dCBuaWNlIGFuZCBjYXVzZSB0aGUgY29uZnVzaW9uCj4gd2h5IHRoZXNlIGZ1bmN0aW9ucyByZXR1
cm4gdGhlIG91dC1vZi1yYW5nZSBmcmVxdWVuY3kuLgo+IAo+IEFsc28sIGlmIHdlIGRvbid0IGNo
ZWNrIHRoZSByZXR1cm4gdmFsdWUgb2YgZGV2X3BtX3Fvc19yZWFkX3ZhbHVlKCksCj4gdGhlIG91
dC1vZi1yYW5nZSBmcmVxdWVuY3kgb2YgZGV2X3BtX3Fvc19yZWFkX3ZhbHVlKCkgd291bGQgYmUg
dXNlZAo+IG9uIG11bHRpcGxlIHBvaW50IG9mIGRldmZyZXEuYy4gSSB0aGluayB0aGF0IGl0IGlz
IG5vdCBnb29kLgoKT0ssIEkgd2lsbCB0cnkgdG8gcGFydGlhbGx5IG1vdmUgdGhlIG1pbi9tYXgg
Y29uZmxpY3QgbG9naWMgZnJvbSAKInVwZGF0ZV9kZXZmcmVxIiB0byBhICJnZXRfZnJlcV9yYW5n
ZSIgZnVuY3Rpb24gYW5kIGNhbGwgdGhhdCBmcm9tIApzaG93X21pbl9mcmVxL3Nob3dfbWF4X2Zy
ZXEuCgo+PiBUaGUgbWF4X2ZyZXEgdmFsdWUgZnJvbSBwbV9xb3MgY2FuIHN0aWxsIGJlIGJldHdl
ZW4gT1BQcyBzbyBtYXliZSBwcmludAo+PiBkZXZmcmVxX3JlY29tbWVuZGVkX29wcChtYXhfZnJl
cSwgREVWRlJFUV9GTEFHX0xFQVNUX1VQUEVSX0JPVU5EKS4KPj4KPj4+PiBJbiB0aGVvcnkgcG1f
cW9zIGNvdWxkIGJlIGV4dGVuZGVkIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiAic29mdCIKPj4+
PiByZXF1ZXN0cyAoY3VycmVudCBiZWhhdmlvcikgYW5kICJoYXJkIiByZXF1ZXN0cyB3aGljaCBy
ZXR1cm4gZXJyb3JzIGlmCj4+Pj4gdGhleSBjYW4ndCBiZSBndWFyYW50ZWVkIGJ1dCB0aGlzIGlz
IGZhciBvdXQgb2Ygc2NvcGUuCj4+Pgo+Pj4gSSB0aGluayB0aGF0IHlvdSBhZ3JlZWQgdGhlIGxp
bWl0YXRpb24gb2YgZGV2X3BtX3FvcyB3aGVuIGVudGVyaW5nCj4+PiBvciByZXF1ZXN0aW5nIHRo
ZSB1bnN1cHBvcnRlZCBmcmVxdWVuY3kuCj4+Cj4+IFllcywgImJlc3QgZWZmb3J0IHFvcyIgaXMg
YWNjZXB0YWJsZSBmb3Igbm93Lgo+IAo+IEFuZCBwbGVhc2UgZG9uJ3QgcmVtb3ZlIHRoZSBteSBw
cmV2aW91cyBjb21tZW50Lgo+IEp1c3QgcmVwbHkgeW91ciBvcGluaW9uIHdpdGhvdXQgYW55IHJl
bW92YWwuCgpTb3JyeSwgd2hlbiByZXNwb25kaW5nIEkgdXN1YWxseSB0cmltIHNlY3Rpb25zIHdo
aWNoIGFyZSB2ZXJ5IG9sZCBvciAKd2hlcmUgdGhlcmUgYXBwZWFycyB0byBiZSBicm9hZCBhZ3Jl
ZW1lbnQuCgotLQpSZWdhcmRzLApMZW9uYXJkCg==
