Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D1EB13E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 14:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfJaNbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 09:31:31 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:28129
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbfJaNbb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 09:31:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/zejVrPvF3Tt6oBI1L0pLmyX11Iv6xcFcdkQn8DdXwtYLQlKXlh6ZenV3T6GvsjsF+Rx6CjicvM0XLbwz4C9/3yH9FatCJyPVl7eTxQsxjCS4/ZxUvLmS3mrT/vi73yHZGiG7P359HQ9Dx7FeEGZ1aGRKjcDqhQHs7mnV+E9RcSVdUbzmGOF2nfewfvXdKj4KTHjmPYZNXeYTJYE5SLzKFZviZn3uIbKZArtpf+1v4QpLNuqM104wt1+5Ath5ORcARTuug8vX5BpnQ+QHHP8UtxZoARTuAojpeXrBWcOl1GW9d89LONZtgzH6/ZUgWB0sgUASAGV3Gm+QFK95baQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Mabvy826jI1MXrUcOUXBGu6Ux0MCRATwwnFcZcRnQ=;
 b=l8E83/wMqaHoIYmLbOHcEaZlO1L9SbPdS0icuW4O3qdLk1Il2Vwx0sB8mowbn6ZNRh1VuvboKDo5QFWXud+/+ktIcCKlEZjFhj6TIp4jAHZ+KBWbA4HSjd/GNYFv5bfQturE5Q/0zJiEdgPpaWZ+FQ2EIwtmrJ3OcsqfBKH4Kf/Ls/cRjc+hyzJx6zwgdrnP9M/vDUrPLmwSuALfAsPTiOQDpKscb91pUkUmxPrH3Nvagdxs8Rz1wRc2nSHvAuw4FyzPzGD8Bo4eYg11VTMoaKT5Gsva2+hrRO8p3ZH1rzYE47/U3G/+nF7H4YQatwz1EHMAailh83CMfwsZXNNIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Mabvy826jI1MXrUcOUXBGu6Ux0MCRATwwnFcZcRnQ=;
 b=VzmHiyUBkdAc5t3Sjwj3kJD6M7QM6FbK8Z0Jmk+Zx628IVGAe8oid/ba9S0M8pc7f8QblyZGEWghb/FbK/Sj/FGZIGPakNfPIkvmf+/wh1NAlyY6J5J5qa5zqxklga94tJJCbmGVY5nzapNz03DcFLxRTAHs4FFNeq2TKv063UE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4640.eurprd04.prod.outlook.com (20.177.54.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 31 Oct 2019 13:31:25 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 13:31:25 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
CC:     Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?utf-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 4/8] PM / devfreq: Move more initialization before
 registration
Thread-Topic: [PATCH v9 4/8] PM / devfreq: Move more initialization before
 registration
Thread-Index: AQHVeVcj1XSohkLMhkijGZw3IGc8Ug==
Date:   Thu, 31 Oct 2019 13:31:25 +0000
Message-ID: <VI1PR04MB70234DF1004231D1BB02A41DEE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <CGME20191002192527epcas3p3ba24247bd1b8ce8ac33f7e4431c25241@epcas3p3.samsung.com>
 <25f46d76dc95d5509edd7bf9d1a2e0532faef4cc.1570044052.git.leonard.crestez@nxp.com>
 <0cadb00d-d34e-4028-93c4-b4902a50f5e2@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d4d597d-031b-4090-3397-08d75e06a0cb
x-ms-traffictypediagnostic: VI1PR04MB4640:|VI1PR04MB4640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4640748F520F1D47570F0B0FEE630@VI1PR04MB4640.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(51444003)(189003)(199004)(6506007)(86362001)(64756008)(71190400001)(71200400001)(8936002)(7736002)(33656002)(256004)(476003)(66476007)(26005)(44832011)(486006)(76116006)(4326008)(81166006)(81156014)(8676002)(91956017)(5660300002)(66946007)(186003)(66446008)(6246003)(446003)(316002)(53546011)(478600001)(25786009)(76176011)(102836004)(66556008)(9686003)(52536014)(229853002)(14444005)(6116002)(66066001)(54906003)(2906002)(14454004)(74316002)(55016002)(305945005)(99286004)(6436002)(7696005)(3846002)(7416002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4640;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xO7Hcwt22Ie98dJMZJbUeySkz2TUWe91a8NLPQpVSD7/xs7V7Ih9S7OVlVydS3rwwDT4l3Rhu0fbF7xl+U5+KfLFGEMlQMF7fzQvrDKMiR4omukzqze/dS9Nw1bVzFCkLsWTONN8jpRnzh74du/9ign8uOEvt+uWFDRLLDy2EqURE6NXMCSX6DBYQGF+bgf9cSlXZ/qQlfITG6CuydEOXq666c9J8YPg12Iejbe5QluC6ljQni/wpDVkBEMHFlZKFbtvQEwVOZCnaMuTLYXO4W/aWAw8PCDX/jQEnH8U0rVHcPtYud/DMa+MOYw4AAbrLK/3BBuKUPSMmg+67q62CghphVezhh1AvrqQjVoVaHyD4Mohm6IQ6Eo019V9lVzIkOaL/62t1GJwZxc5IpdrcFQug40dOfUuYjN2va97CaO3JEQwV2ZqxDh9v36KS9gq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4d597d-031b-4090-3397-08d75e06a0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 13:31:25.4271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dV3IbL7DMwXqJv/nulQc0fd9+5pdv1d02kJtjB8IgV2Ic3dVF8/WQLpR7SxChvOVywhOWFFChPtKtjwfcoClhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4640
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMzEuMTAuMjAxOSAwNToxMCwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhpIExlb25hcmQsCj4g
Cj4gVGhpcyBwYXRjaCBkaWRuJ3QgZ2V0IHRoZSBhY2tlZC1ieSBmcm9tIGRldmZyZXEgbWFpbnRh
aW5lci4KPiBJIHRoaW5rIHRoYXQgd2UgbmVlZCB0byBkaXNjdXNzIHRoaXMgcGF0Y2ggd2l0aCBt
b3JlIHRpbWUuCj4gQWxzbywgaXQgaXMgcG9zc2libGUgdG8gbWFrZSBpdCBhcyB0aGUgc2VwYXJh
dGUgcGF0Y2gKPiBmcm9tIHRoaXMgc2VyaWVzLgo+IAo+IElNSE8sIGlmIHlvdSBtYWtlIHRoZSBz
ZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcyBhbmQKPiByZXNlbmQgdGhlIHNlcGFyYXRlIHBhdGNoIG9u
IGxhdGVyLCBJIHRoaW5rIHRoYXQKPiB3ZSBjYW4gbWVyZ2UgdGhlIHJlbWFpbmVkIHBhdGNoIHJl
bGF0ZWQgdG8gUE1fUU9TLgoKVGhlIGRldmZyZXEgaW5pdGlhbGl6YXRpb24gY2xlYW51cHMgYXJl
IHJlcXVpcmVkIGZvciBkZXZfcG1fcW9zIHN1cHBvcnQsIApvdGhlcndpc2UgbG9ja2RlcCB3YXJu
aW5ncyBhcmUgdHJpZ2dlcmVkLiBJIGNhbiBwb3N0IHRoZSBjbGVhbnVwcyBhcyBhIApzZXBhcmF0
ZSBzZXJpZXMgYnV0IHRoZSBQTSBRb1Mgb25lIHdvdWxkIGRlcGVuZCBvbiB0aGUgY2xlYW51cHMu
CgpEbyB5b3UgcHJlZmVyIG11bHRpcGxlIHNtYWxsZXIgc2VyaWVzPwoKSSB0cnkgdG8gb3JkZXIg
bXkgcGF0Y2hlcyB3aXRoIHVuY29udHJvdmVyc2lhbCBmaXhlcyBhbmQgY2xlYW51cHMgZmlyc3Qg
CnNvIGluIHRoZW9yeSB0aGUgZWFybGllciBwYXJ0cyBjb3VsZCBiZSBhcHBsaWVkIHNlcGFyYXRl
bHkuIEl0J3MgdmVyeSAKcmFyZSB0byBzZWUgc2VyaWVzIHBhcnRpYWxseSBhcHBsaWVkIHRob3Vn
aC4KCkVhcmxpZXIgb2JqZWN0aW9uIHdhcyB0aGF0IGRldm0gc2hvdWxkIGJlIGtlcHQsIEkgdGhp
bmsgdGhpcyBjYW4gYmUgCmFjY29tcGxpc2hlZCBieSBzcGxpdHRpbmcgZGV2aWNlX3JlZ2lzdGVy
IGludG8gZGV2aWNlX2luaXRpYWxpemUgYW5kIApkZXZpY2VfYWRkLgoKPiBPbiAxOS4gMTAuIDMu
IOyYpOyghCA0OjI1LCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6Cj4+IEluIGdlbmVyYWwgaXQgaXMg
YSBiZXR0ZXIgdG8gaW5pdGlhbGl6ZSBhbiBvYmplY3QgYmVmb3JlIG1ha2luZyBpdAo+PiBhY2Nl
c3NpYmxlIGV4dGVybmFsbHkgKHRocm91Z2ggZGV2aWNlX3JlZ2lzdGVyKS4KPj4KPj4gVGhpcyBt
YWtlcyBpdCBwb3NzaWJsZSB0byBhdm9pZCByZW1vdmUgbG9ja2luZyB0aGUgcGFydGlhbGx5IGlu
aXRpYWxpemVkCj4+IG9iamVjdCBhbmQgc2ltcGxpZmllcyB0aGUgY29kZS4gSG93ZXZlciBkZXZt
IGlzIG5vdCBhdmFpbGFibGUgYmVmb3JlCj4+IGRldmljZV9yZWdpc3RlciAob25seSBhZnRlciB0
aGUgZGV2aWNlX2luaXRpYWxpemUgc3RlcCkgc28gdGhlIHR3bwo+PiBhbGxvY2F0aW9ucyBuZWVk
IHRvIGJlIG1hbmFnZWQgbWFudWFsbHkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQ3Jl
c3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Cj4+IFJldmlld2VkLWJ5OiBNYXR0aGlhcyBL
YWVobGNrZSA8bWthQGNocm9taXVtLm9yZz4KPj4gLS0tCj4+ICAgZHJpdmVycy9kZXZmcmVxL2Rl
dmZyZXEuYyB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEv
ZGV2ZnJlcS5jCj4+IGluZGV4IDNlMGU5MzYxODVhMy4uMGI0MGY0MGVlN2FhIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9k
ZXZmcmVxLmMKPj4gQEAgLTU5MSwxMCArNTkxLDEyIEBAIHN0YXRpYyB2b2lkIGRldmZyZXFfZGV2
X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQo+PiAgIAltdXRleF91bmxvY2soJmRldmZyZXFf
bGlzdF9sb2NrKTsKPj4gICAKPj4gICAJaWYgKGRldmZyZXEtPnByb2ZpbGUtPmV4aXQpCj4+ICAg
CQlkZXZmcmVxLT5wcm9maWxlLT5leGl0KGRldmZyZXEtPmRldi5wYXJlbnQpOwo+PiAgIAo+PiAr
CWtmcmVlKGRldmZyZXEtPnRpbWVfaW5fc3RhdGUpOwo+PiArCWtmcmVlKGRldmZyZXEtPnRyYW5z
X3RhYmxlKTsKPj4gICAJbXV0ZXhfZGVzdHJveSgmZGV2ZnJlcS0+bG9jayk7Cj4+ICAgCWtmcmVl
KGRldmZyZXEpOwo+PiAgIH0KPj4gICAKPj4gICAvKioKPj4gQEAgLTY3NCw0NCArNjc2LDQzIEBA
IHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxX2FkZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2LAo+
PiAgIAlkZXZmcmVxLT5tYXhfZnJlcSA9IGRldmZyZXEtPnNjYWxpbmdfbWF4X2ZyZXE7Cj4+ICAg
Cj4+ICAgCWRldmZyZXEtPnN1c3BlbmRfZnJlcSA9IGRldl9wbV9vcHBfZ2V0X3N1c3BlbmRfb3Bw
X2ZyZXEoZGV2KTsKPj4gICAJYXRvbWljX3NldCgmZGV2ZnJlcS0+c3VzcGVuZF9jb3VudCwgMCk7
Cj4+ICAgCj4+IC0JZGV2X3NldF9uYW1lKCZkZXZmcmVxLT5kZXYsICJkZXZmcmVxJWQiLAo+PiAt
CQkJCWF0b21pY19pbmNfcmV0dXJuKCZkZXZmcmVxX25vKSk7Cj4+IC0JZXJyID0gZGV2aWNlX3Jl
Z2lzdGVyKCZkZXZmcmVxLT5kZXYpOwo+PiAtCWlmIChlcnIpIHsKPj4gLQkJbXV0ZXhfdW5sb2Nr
KCZkZXZmcmVxLT5sb2NrKTsKPj4gLQkJcHV0X2RldmljZSgmZGV2ZnJlcS0+ZGV2KTsKPj4gLQkJ
Z290byBlcnJfb3V0Owo+PiAtCX0KPj4gLQo+PiAtCWRldmZyZXEtPnRyYW5zX3RhYmxlID0gZGV2
bV9remFsbG9jKCZkZXZmcmVxLT5kZXYsCj4+ICsJZGV2ZnJlcS0+dHJhbnNfdGFibGUgPSBremFs
bG9jKAo+PiAgIAkJCWFycmF5M19zaXplKHNpemVvZih1bnNpZ25lZCBpbnQpLAo+PiAgIAkJCQkg
ICAgZGV2ZnJlcS0+cHJvZmlsZS0+bWF4X3N0YXRlLAo+PiAgIAkJCQkgICAgZGV2ZnJlcS0+cHJv
ZmlsZS0+bWF4X3N0YXRlKSwKPj4gICAJCQlHRlBfS0VSTkVMKTsKPj4gICAJaWYgKCFkZXZmcmVx
LT50cmFuc190YWJsZSkgewo+PiAgIAkJbXV0ZXhfdW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsKPj4g
ICAJCWVyciA9IC1FTk9NRU07Cj4+IC0JCWdvdG8gZXJyX2RldmZyZXE7Cj4+ICsJCWdvdG8gZXJy
X2RldjsKPj4gICAJfQo+PiAgIAo+PiAtCWRldmZyZXEtPnRpbWVfaW5fc3RhdGUgPSBkZXZtX2tj
YWxsb2MoJmRldmZyZXEtPmRldiwKPj4gLQkJCWRldmZyZXEtPnByb2ZpbGUtPm1heF9zdGF0ZSwK
Pj4gLQkJCXNpemVvZih1bnNpZ25lZCBsb25nKSwKPj4gLQkJCUdGUF9LRVJORUwpOwo+PiArCWRl
dmZyZXEtPnRpbWVfaW5fc3RhdGUgPSBrY2FsbG9jKGRldmZyZXEtPnByb2ZpbGUtPm1heF9zdGF0
ZSwKPj4gKwkJCQkJIHNpemVvZih1bnNpZ25lZCBsb25nKSwKPj4gKwkJCQkJIEdGUF9LRVJORUwp
Owo+PiAgIAlpZiAoIWRldmZyZXEtPnRpbWVfaW5fc3RhdGUpIHsKPj4gICAJCW11dGV4X3VubG9j
aygmZGV2ZnJlcS0+bG9jayk7Cj4+ICAgCQllcnIgPSAtRU5PTUVNOwo+PiAtCQlnb3RvIGVycl9k
ZXZmcmVxOwo+PiArCQlnb3RvIGVycl9kZXY7Cj4+ICAgCX0KPj4gICAKPj4gICAJZGV2ZnJlcS0+
bGFzdF9zdGF0X3VwZGF0ZWQgPSBqaWZmaWVzOwo+PiAgIAo+PiAgIAlzcmN1X2luaXRfbm90aWZp
ZXJfaGVhZCgmZGV2ZnJlcS0+dHJhbnNpdGlvbl9ub3RpZmllcl9saXN0KTsKPj4gICAKPj4gKwlk
ZXZfc2V0X25hbWUoJmRldmZyZXEtPmRldiwgImRldmZyZXElZCIsCj4+ICsJCQkJYXRvbWljX2lu
Y19yZXR1cm4oJmRldmZyZXFfbm8pKTsKPj4gKwllcnIgPSBkZXZpY2VfcmVnaXN0ZXIoJmRldmZy
ZXEtPmRldik7Cj4+ICsJaWYgKGVycikgewo+PiArCQltdXRleF91bmxvY2soJmRldmZyZXEtPmxv
Y2spOwo+PiArCQlwdXRfZGV2aWNlKCZkZXZmcmVxLT5kZXYpOwo+PiArCQlnb3RvIGVycl9vdXQ7
Cj4+ICsJfQo+PiArCj4+ICAgCW11dGV4X3VubG9jaygmZGV2ZnJlcS0+bG9jayk7Cj4+ICAgCj4+
ICAgCW11dGV4X2xvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsKPj4gICAKPj4gICAJZ292ZXJub3Ig
PSB0cnlfdGhlbl9yZXF1ZXN0X2dvdmVybm9yKGRldmZyZXEtPmdvdmVybm9yX25hbWUpOwo+PiBA
QCAtNzM3LDE0ICs3MzgsMjAgQEAgc3RydWN0IGRldmZyZXEgKmRldmZyZXFfYWRkX2RldmljZShz
dHJ1Y3QgZGV2aWNlICpkZXYsCj4+ICAgCj4+ICAgCXJldHVybiBkZXZmcmVxOwo+PiAgIAo+PiAg
IGVycl9pbml0Ogo+PiAgIAltdXRleF91bmxvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsKPj4gLWVy
cl9kZXZmcmVxOgo+PiAgIAlkZXZmcmVxX3JlbW92ZV9kZXZpY2UoZGV2ZnJlcSk7Cj4+IC0JZGV2
ZnJlcSA9IE5VTEw7Cj4+ICsJcmV0dXJuIEVSUl9QVFIoZXJyKTsKPj4gKwo+PiAgIGVycl9kZXY6
Cj4+ICsJLyoKPj4gKwkgKiBDbGVhbnVwIHBhdGggZm9yIGVycm9ycyB0aGF0IGhhcHBlbiBiZWZv
cmUgcmVnaXN0cmF0aW9uLgo+PiArCSAqIE90aGVyd2lzZSB3ZSByZWx5IG9uIGRldmZyZXFfZGV2
X3JlbGVhc2UuCj4+ICsJICovCj4+ICsJa2ZyZWUoZGV2ZnJlcS0+dGltZV9pbl9zdGF0ZSk7Cj4+
ICsJa2ZyZWUoZGV2ZnJlcS0+dHJhbnNfdGFibGUpOwo+PiAgIAlrZnJlZShkZXZmcmVxKTsKPj4g
ICBlcnJfb3V0Ogo+PiAgIAlyZXR1cm4gRVJSX1BUUihlcnIpOwo+PiAgIH0KPj4gICBFWFBPUlRf
U1lNQk9MKGRldmZyZXFfYWRkX2RldmljZSk7Cg==
