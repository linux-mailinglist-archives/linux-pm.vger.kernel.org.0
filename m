Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773689644D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfHTP0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 11:26:42 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:34372
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730223AbfHTP0m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 11:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO4YXfPWOft8Wx3b9iwczNfHBqQk+TMj9cb9MV4rUQBDf6BT1h/H/Aya4nilueRmdlIT5Atw6GFdkbFWr5sYmECRXMN7ch+IQx+FhJ2HK2LqD0xuNzaD7CKv/JFHR2TllVSibv4zDQlLHH1xaaOvNn3P7FK7A/uZrGDZUt2l8Oz8+HjRkSrkDIgC2ZWc4HGg4sWurqFXPJH+Iqqa69p4Vg/vSybwYju3cosvQEnqromCMWV5NtvVivDcIpG9IH4enQpu5lm4+J/GiAYk5kikfOHRwT0IwuK+HABf6YWQKEP2fNgaJOA3pTI2FnRGb4o3ZmUXmM9oSvNiLpKXedDpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpVbcTAMOjPbGyaZv1yttAZSBLseKAcrpO1LXshz/4Q=;
 b=GGFkIj6rgCnycuE4LBHul+AET09AAsD5o04j6ViyuxAwwVD9kvNqgfouYVsIx093cBx5V0OyGGw9F3gPMG+rZjGkF+o9C30y/b5cPVIpGnRnMKI1nyIRQyadL2LEzCSr3kbq/UVoCxg+ZY8MM5TnF5ND6WsWJ5Ilxw9KNkJ46vBfbZ6iiE7Pe8snWUdKqxkMr7Akd2nTSRLlSjbNUoxla+qOVFiNaWbDhTqSZCRXOZxP+M4Xkzfd681vIwG+6SevkhBdoXtQzLW5cyiBd1RUFqifAo94ItWs/mZY3whlScKGLjOotBO1fSw0DAUVxbh7zXXiRbqO2LdAAxqJagA+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpVbcTAMOjPbGyaZv1yttAZSBLseKAcrpO1LXshz/4Q=;
 b=FHG7NiPIj2N1/02FH8cGs+kWQj3c7AoZrwWdWpQlYlFLoFu74j9uL6cLmJ7+54RCa9kNhT9EMyALSAKFF1l74XuV87A4tr1eSmDA6l04MkZGlzo3oODlslpq3QyAQ+Dimzch5TpIwRmPBpS/EFNLY/5mcHFq9BZ7JPwx9w9GQec=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3248.eurprd04.prod.outlook.com (10.170.232.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 15:26:36 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 15:26:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
Subject: Re: [PATCHv2] PM / devfreq: Add dev_pm_qos support
Thread-Topic: [PATCHv2] PM / devfreq: Add dev_pm_qos support
Thread-Index: AQHVUZ3LNnkjSHH5Mky7uPvCKAlxZw==
Date:   Tue, 20 Aug 2019 15:26:36 +0000
Message-ID: <VI1PR04MB7023C709356F9EBE0CA4E3C8EEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <CGME20190808143919epcas4p33c93a5a3d4df1032fa84ddad9110a160@epcas4p3.samsung.com>
 <e45c28528ff941abb1f72fdb1eedf65fb3345c5a.1565274802.git.leonard.crestez@nxp.com>
 <b3941b19-f0aa-87a6-d50a-299d07a26532@samsung.com>
 <VI1PR04MB7023EB13BB2DE94814B38477EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <a9328230-96f3-6bab-826a-bb199de4ad48@samsung.com>
 <195bef25-5235-4c24-cc7a-48d368da3bbd@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b6503c6-b546-4b36-0f9c-08d72582ca62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3248;
x-ms-traffictypediagnostic: VI1PR04MB3248:
x-microsoft-antispam-prvs: <VI1PR04MB3248DD170B834852D5C39C1EEEAB0@VI1PR04MB3248.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(199004)(189003)(31014005)(51444003)(446003)(476003)(7696005)(186003)(486006)(26005)(44832011)(76176011)(7416002)(2906002)(6116002)(86362001)(66946007)(91956017)(76116006)(305945005)(66446008)(66476007)(66556008)(64756008)(7736002)(81166006)(81156014)(8676002)(3846002)(8936002)(74316002)(478600001)(66066001)(14454004)(55016002)(14444005)(256004)(6916009)(71190400001)(71200400001)(6436002)(53936002)(33656002)(9686003)(102836004)(6506007)(53546011)(4326008)(52536014)(316002)(54906003)(5660300002)(25786009)(6246003)(229853002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3248;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CvaglGkAQrgqM/jZBqU8M1awtYR9DTMHA3VpxAUV8FQzSNhRhrAr3eOEizd6hYJfuXAzV92/AD3aoFN5x0aYn2QCrzzxXnYwuddFar01lB9svY9CNJw/p3/X3dByQHSLTO08BVIiYBL8n4RTEOTh0NoUeJqBa2IHnxDQF/YDo6yGL1ZJ0qfBfa3O3Bhd7yJQsRsJUnJtmKfD5/DkanC4esnE6EMTd81MTOasVrpvksa6gEBdkP4Yrm2ITsxDptIc7MA+pZ3mHmr2WvzqPe98E7ZGo6qvRTHD1ABIssU/kvnmanjH0cExw2K+t+V9WkabcOVADRvPXAwf3KN+U2l1cQDNYNIyo38CJV4qI/hhFvt+afjGbx5UmmxOMOtr2agsL548oRIyY16c+r1trvsoEctaw+lahxPHfwoOabRdg9w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6503c6-b546-4b36-0f9c-08d72582ca62
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 15:26:36.5983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhV1fTR2AVCLcFXQHbmG5HewE66/wPQOHoMPWO+Wz+mE1mxPfEbsZ4/2CYaVvOtI+UYCUJva86UXmsPw/H5VMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3248
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gOC8xNC8yMDE5IDQ6MTQgQU0sIENoYW53b28gQ2hvaSB3cm90ZToKPiBPbiAxOS4gOC4gMTQu
IOyYpOyghCAxMDowNiwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+PiBPbiAxOS4gOC4gMTMuIOyYpO2b
hCA4OjI3LCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6Cj4+PiBPbiAxMy4wOC4yMDE5IDA5OjEwLCBD
aGFud29vIENob2kgd3JvdGU6Cj4+Pj4gSW4gY2FzZSBvZiBjcHVmcmVxLCBjcHVmcmVxLmMgcmVw
bGFjZSB0aGUgYm9keSBvZiBzdG9yZV9taW5fZnJlcSgpCj4+Pj4gYW5kIHN0b3JlX21heF9mcmVx
KCkgYnkgdXNpbmcgc3RydWN0IGRldl9wbV9xb3NfcmVxdWVzdCBpbnN0YW5jY2UKPj4+PiB3aXRo
IGRldl9wbV9xb3NfdXBkYXRlX3JlcXVlc3QoKS4KPj4+Pgo+Pj4+IElmIHlvdSB1c2UgdGhlIG5l
dyB3YXkgd2l0aCBkZXZfcG1fcW9zX3VwZGF0ZV9yZXF1ZXN0KCkgZm9yCj4+Pj4gbWluX2ZyZXFf
c3RvcmUoKSBhbmQgbWF4X2ZyZXFfc3RvcmUoKSwgaXQgZG9lc24ndCBuZWVkIHRvCj4+Pj4gZ2V0
IHRoZSBmaW5hbCBmcmVxdWVuY3kgZnJvbSB0aHJlZSBjYW5kaWRhdGUgZnJlcXVlbmNpZXMuCj4+
Pgo+Pj4gWWVzLCBJIHNhdyB0aGF0IGJ1dCBkaWRuJ3QgaW1wbGVtZW50IHRoZSBlcXVpdmFsZW50
IGZvciBkZXZmcmVxIGJlY2F1c2UKPj4+IGl0J3Mgbm90IGNsZWFyIHdoYXQgdGhlcmUgaXMgdG8g
Z2Fpbi4KPj4KPj4gSSB0aGluayB0aGF0IGl0IGlzIGNsZWFyLiBKdXN0IHVzZSB0aGUgZGV2X3Bt
X3Fvc19yZXF1ZXN0IGludGVyZmFjZQo+PiBmb3IgYm90aCB1c2VyIGlucHV0IHRocm91Z2ggc3lz
ZnMgYW5kIGRldmljZSBpbnB1dCB3aXRoIHFvcyByZXF1ZXN0Lgo+PiBBbHJlYWR5IFBNX1FPUyBo
YXMgdGhlIGZlYXR1cmUgdG8gZ2V0IHRoZSBmaW5hbCBmcmV1ZW5jeSBhbW9uZwo+PiB0aGUgbXVs
dGlwbGUgcmVxdWVzdC4gV2hlbiB1c2UgdGhlIGRldl9wbV9xb3MgcmVxdWVzdCwgdGhlIGRldmZy
ZXEKPj4gZG9lc24ndCBuZWVkIHRvIGNvbXBhcmUgYmV0d2VlbiB1c2VyIGlucHV0IGFuZCBkZXZp
Y2UgaW5wdXQgd2l0aCBxb3MuCj4+IEl0IG1ha2UgZGV2ZnJlcSBjb3JlIG1vcmUgY2xlYXIgYW5k
IHNpbXBsZQoKPj4+IFNpbmNlIGRldl9wbV9xb3MgaXMgbWVhc3VyZWQgaW4ga2h6IGl0IG1lYW5z
IHRoYXQgbWluX2ZyZXEvbWF4X3JlcSBvbgo+Pj4gc3lzZnEgd291bGQgbG9zZSAzIHNpZ25pZmlj
YW50IGRpZ2l0cywgaG93ZXZlciB0aG9zZSBkaWdpdHMgYXJlIHByb2JhYmx5Cj4+PiB1c2VsZXNz
IGFueXdheS4KPj4KPj4gSSB0aGluayB0aGF0IGl0IGRvZXNuJ3QgbWF0dGVyLiBUaGlzIHBhdGNo
IGFscmVhZHkgY29uc2lkZXJzIHRoZSB0aGlzIGlzc3VlCj4+IGJ5IHVzaW5nICcqIDEwMDAnLiBX
ZSBjYW4gZ2V0IGVpdGhlciBLSHogb3IgTUh6IHdpdGggYWRkaXRpb25hbCBvcGVyYXRpb24uCj4+
IEkgdGhpbmsgdGhhdCBpdCBpcyBub3QgcHJvYmxlbS4KCkl0IGludHJvZHVjZXMgdGhlIGZvbGxv
d2luZyBpc3N1ZToKCiMgZWNobyAzMzMzMzMzMzMgPiAvc3lzL2NsYXNzL2RldmZyZXEvZGV2ZnJl
cTAvbWluX2ZyZXEKIyBjYXQgL3N5cy9jbGFzcy9kZXZmcmVxL2RldmZyZXEwL21pbl9mcmVxCjMz
MzMzMzAwMAoKQ2hhbmdpbmcgcm91bmRpbmcgcnVsZXMgY291bGQgY29uZnVzZSB1c2Vyc3BhY2Ug
dG9vbHMuIFRoaXMgaXMgbm90IAplbnRpcmVseSBhIG5ldyBpc3N1ZSBiZWNhdXNlIGZyZXEgdmFs
dWVzIHdoaWNoIGFyZSBub3QgYW4gaW50ZWdlciBudW1iZXIgCm9mIGtoeiBhcmUgbGlrZWx5IG5v
dCBhbiBpbnRlZ2VyIG51bWJlciBvZiBoeiBlaXRoZXIuCgo+PiBBY3R1YWxseSwgSSB0aGluayB0
aGF0IEkgd2FudCB0byB1c2UgdGhlIG9ubHkgZGV2X3BtX3Fvc19yZXF1ZXN0Cj4+IGZvciBhbGwg
ZXh0ZXJuYWwgcmVxdWVzdCBsaWtlIGRldmZyZXEgY29vbGluZyBvZiB0aGVybWFsLAo+PiB1c2Vy
IGlucHV0IHRocm91Z2ggc3lzZnMgYW5kIGRldmljZSByZXF1ZXN0IHdpdGggZGV2X3BtX3Fvc19y
ZXF1ZXN0Lgo+Pgo+PiBBbHJlYWR5LCBkZXZfcG1fcW9zX3JlcXVlc3QgaXMgZGVzaWduZWQgdG8g
Y29uc2lkZXIgdGhlIG11bHRpcGxlIHJlcXVpcmVtZW50cy4KPj4gV2UgZG9uJ3QgbmVlZCB0byB1
c2UgdGhlIHZhcmlvdXMgbWV0aG9kIChPUFAgaW50ZXJmYWNlLCBzeXNmcyBpbnB1dCwgZGV2X3Bt
X3FvcykKPj4gYmVjYXVzZSBtYWtlIGl0IG1vcmUgc2ltcGxlIGFuZCBlYXN5Lgo+Pgo+PiBJIHRo
aW5rIHRoYXQgYWZ0ZXIgZmluaXNoZWQgdGhlIHJldmlldyBvZiB0aGlzIHBhdGNoLCBJIHdpbGwg
ZG8gcmVmYWN0b3IgdGhlIGRldmZyZXFfY29vbGluZy5jCj4+IGJ5IHVzaW5nIHRoZSBkZXZfcG1f
cW9zX3JlcXVlc3QuIE9yLCBpZiB0aGVyZSBhcmUgc29tZSB2b2x1bnRlZWVyLAo+IAo+IFNvcnJ5
LCBJIHdvdWxkIHdpdGhkcmF3IHRoZSB0aGlzIG9waW5pb24gYWJvdXQgcmVwbGFjaW5nCj4gdGhl
IE9QUCBlbmFibGUvZGlzYWJsZSBpbnRlcmZhY2Ugd2l0aCB0aGUgZGV2X3BtX3Fvc19yZXF1ZXN0
Cj4gYmVjYXVzZSBldmVuIGlmIGRldmZyZXEtY29vbGluZy5jIG5lZWRzIHRoZSAnZGV2JyBpbnN0
YW5jZQo+IHRvIHVzZSB0aGUgZGV2X3BtX3Fvc19yZXF1ZXN0IG1ldGhvZCwgaXQgaXMgbm90IGNs
ZWFyIHVudGlsIG5vdy4KPiBJdCBuZWVkcyBob3cgdG8gZ2V0IHRoZSBkZXZpY2UgaW5zdGFuY2Ug
b2YgZGV2ZnJlcSBvbiBkZXZpY2UtdHJlZS4KCkkgbG9va2VkIGEgYml0IGF0IHRoZSBkZXZmcmVx
LWNvb2xpbmcgaW1wbGVtZW50YXRpb24gYW5kIGl0IHNlZW1zIGxpa2UgCnRoZXJlIGFyZW4ndCBh
bnkgdXNlcnMgaW4gdXBzdHJlYW0/CgpBcyBmYXIgYXMgSSBjYW4gdGVsbCBhIGRldmZyZXEgaW1w
bGVtZW50YXRpb24gbmVlZHMgdG8gY2FsbCAKb2ZfZGV2ZnJlcV9jb29saW5nX3JlZ2lzdGVyIGFu
ZCB0aGVuIHRoZSBkZXZmcmVxIGNvb2xpbmcgY29kZSBjb3VsZCAKcmVnaXN0ZXIgYSBkZXZfcG1f
cW9zIHJlcXVlc3Qgb24gZGV2ZnJlcS0+ZGV2LnBhcmVudC4gSSdtIG5vdCBzdXJlIEkgCnVuZGVy
c3RhbmQgd2hhdCBwcm9ibGVtIHlvdSBzZWUuCgotLQpSZWdhcmRzLApMZW9uYXJkCg==
