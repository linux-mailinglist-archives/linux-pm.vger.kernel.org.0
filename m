Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B373A28CD53
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgJML6r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 07:58:47 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:45790
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728407AbgJML6q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 07:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj3kcHPs65ENTfO4D8CKKVOqIJEQbyqnFGH4OetZYGQBE8DiQuAcijSdGtGwP7bMjhF8QkSJRFZmoI6F3VmfbsH8EZAOiryAeJ6U33wr3vbnY+bdqXRcOLY0UYyDnc+i1VJ9asqRdAS/KcLtqnN+h3NE6VA18tgptZImH5D0krCi9ZUwQnitfu/i7F9tb7PUosl+RUoiGxuN4cejI0KE/8uakgQUCfcbF4LP0svw+8h27xKtEsII20dX+D9TpV5HYRdk2Lm3b1xMNcqK+y/IdxJcZ9whldQX9KWp0CjCEztgJ8yboXK3CRyW2PcAk8Vll0Q070ppPlPEqgEhXH4Q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lbNMGYXtUy+YhreNFYwNYYHpc7VKv8mAdwr/xpaFYM=;
 b=Ov1C4u5iszsctKZYOefBWZxgKpfz96dLrWW/K+F9kbx7WAqtDWlNB9+wYROkcG32yvIJPgpQ7U3LznPh4VfW403FbwJP6JH9ZcrfCGn+Vty1eclKzo+BvAqKBcgzLmlMvO1G5sKnYqE380zFnzC7keLg7cknZj8EcHDo218yOrSvJql9aGgjAxphSayvYLdIx1S6d5x/hkoh5ymN/d45Sn3v2cRJMmwCLx8aiQWtPotzVrNEgAEBT7YikDiq0jAzTFPkwKpuLNt72NBeq65a03Qu18PDwkgwbT/DlAWQ7unO16qEs7QTpqymKC1fT0U9pHyo6GsUCzXhGb2i/zzR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lbNMGYXtUy+YhreNFYwNYYHpc7VKv8mAdwr/xpaFYM=;
 b=h8wXvUFCoGcFbr2kYr7El7LZQJDGDPQ4vwFMn+nGEXd8VGH/zclPfZOvLAF72JlvR1zrdV2dztAfFz7j3riA5eCJMjR/Ce626nKe+ISrBW4SdZmr222NrOa4Uwc+G/HLZGh1AfFyiw33tTSGSu76twCA1RuUgE3PhdM4yIwAilQ=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 13 Oct
 2020 11:58:42 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3455.029; Tue, 13 Oct 2020
 11:58:42 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Anson Huang <anson.huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: cpufreq regression on imx6q sabresd
Thread-Topic: cpufreq regression on imx6q sabresd
Thread-Index: AdahMGy5rDqWJMR8TQG2KN/ixfSdHwAEq9YAAAJu27A=
Date:   Tue, 13 Oct 2020 11:58:42 +0000
Message-ID: <AM6PR04MB49666E48C1761543CE86B07280040@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <AM6PR04MB4966C65D8439BD0B0459B6AC80040@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201013092746.ancm24mp7tu4wjve@vireshk-i7>
In-Reply-To: <20201013092746.ancm24mp7tu4wjve@vireshk-i7>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 584121b7-05ad-43da-0749-08d86f6f54d3
x-ms-traffictypediagnostic: AM7PR04MB7062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB7062FA5DC1AEAF0CBB79A1BF80040@AM7PR04MB7062.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Z6WJrLTtktxhg0rk16ko+YJMXPDVsxuKLFtDP21L05csPOXdQUdu0jROpA3osNcAgP13FV9cXw/wlTVKRWcFm84m65QODyXYcfp0DLM5ESFIROZdCGGGnkHJsm1MN4gwPDV94EA8dO1sJW/7NQQzyBsafKuJbu9S2lGy55f0E02HdHyr+s3/SJcwAuSgjgymz6+VydiQmUIYzUGCLWA8C7x9Wk2gvkT1ERakMkyAqv4/qANxew3Q+4EHv4YNr1Cz6/1XAGwU+oDpRGXXPd8uZ7cnnyC99XXvgmUFluc11MW/UqO787Afnhm1HbXsk3A1XL0lbJeSzzTJpqgRtlj8pEnhQoJLJEHSV3X4VsZD5qJBp/jZbrFBhE50pVwQzj3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(5660300002)(86362001)(76116006)(52536014)(66946007)(2906002)(66446008)(66476007)(66556008)(64756008)(44832011)(4326008)(498600001)(55016002)(6506007)(53546011)(26005)(186003)(6916009)(33656002)(54906003)(8676002)(83380400001)(9686003)(71200400001)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: i6mzXIJU/0njg1l64WKR9ksi0dqlHXK2pt+yLLaE1nFHOC82v/9INUw9+vFBstG3/AEMvYmbgxPdM2rgpXPBBqKgWRnY2mAV0ifmbwOKlTauLVc1g9qH3XK2U6TEearUDgRWa7Z/k7JaJqFk1a9PopqgxBHqfeSFF6xF/62AqbWEbDnyP+9JOIsGwncTVQoYmgc0XBN9kfkxYWI8C5vL/hzlwE1PaDhb1peGyXZmCQFsvZWOEyf9bS20b+6IRw05XEj97yb5eHgMX1JDB5z6vR2XEQay2GM3KIhCoqXZQYTFgC3i9lyqO8a4yLz1eZtrOPfCEiLI8lpkU6LtEzgcD+Brmkv3ZANdAu/HZc/JzSUPJ3N6ekyv9TU/mYia72rGrjqbXtDYqEb/i6ubyhzfNLGFH6lVR8SF997yL3mUsGyQXtoL/Qe4qvfh8T+d1V6Mu1gqBSPinvpoW82m1Fjln46wvZJN9VNQ3CUvgvcHxGTJLP6zJ6942xUNLhiQ3DcyDP4Rl5KVtB7O6JX8qDuYVCZc220gk2xitkjNd64ApWzgFs195EqzZqjXp/wZb9g0IwjrgONQ611sRtqlfA3Lvj6rtS+R3V7GHjHarSrPogobet6k01HBS53GkAI394AIl9pkksSiMt69+NIGOyVcBg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584121b7-05ad-43da-0749-08d86f6f54d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 11:58:42.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6MOqVgn4ozBfBzngJspmv+m89beDL95EdqY3KCixYA/XzyOjoQa3a7MntkNeflWLk59r/d0TZcZghm50dvcGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiBTZW50OiBU
dWVzZGF5LCBPY3RvYmVyIDEzLCAyMDIwIDU6MjggUE0NCj4gDQo+IE9uIDEzLTEwLTIwLCAwOTow
MCwgQWlzaGVuZyBEb25nIHdyb3RlOg0KPiA+IEhpDQo+ID4NCj4gPiBDcHVmcmVxIG9uIE1YNlEg
U0RCIGJlY29tZXMgdW53b3JrIHNpbmNlIG5leHQtMjAyMDA5MDIgYW5kIHRoaXMgaXNzdWUNCj4g
PiBhbHNvIGV4aXN0IHdpdGggbGF0ZXN0IGxpbnV4LW5leHQgbmV4dC0yMDIwMTAxMi4NCj4gPg0K
PiA+IEVycm9yIGxvZyBhcyBmb2xsb3dzOg0KPiA+IFsgICAgNi43ODIzOTVdIGNwdSBjcHUwOiBm
YWlsZWQgdG8gZGlzYWJsZSA4NTJNSHogT1BQDQo+ID4gWyAgICA2Ljc4NzI0Nl0gY3B1IGNwdTA6
IGZhaWxlZCB0byBkaXNhYmxlIDEuMkdIeiBPUFANCj4gPiBbICAgIDYuNzkyMTg5XSBjcHUgY3B1
MDogZmFpbGVkIHRvIGluaXQgY3B1ZnJlcSB0YWJsZTogLTYxDQo+ID4gWyAgICA2LjgwMDIzNF0g
aW14NnEtY3B1ZnJlcTogcHJvYmUgb2YgaW14NnEtY3B1ZnJlcSBmYWlsZWQgd2l0aCBlcnJvciAt
NjENCj4gPg0KPiA+IFNpbXBseSBiYWNrIHRvIG5leHQtMjAyMDA4MjggdmVyc2lvbiBmb3IgZHJp
dmVycy9vcHAgY2FuIGF2b2lkIHRoaXMgaXNzdWUuDQo+ID4gZS5nLiBnaXQgY2hlY2tvdXQgbmV4
dC0yMDIwMDgyOCBkcml2ZXJzL29wcC8gU28gdGhlIGlzc3VlIHNlZW1zIHRvIGJlDQo+ID4gcmVs
YXRlZCB0byBPUFAgY2hhbmdlcy4NCj4gPg0KPiA+ICQgZ2l0IGxvZyAtLW9uZWxpbmUgLS1uby1t
ZXJnZXMgbmV4dC0yMDIwMDgyOC4ubmV4dC0yMDIwMTAxMg0KPiA+IGRyaXZlcnMvb3BwLw0KPiAN
Cj4gZGlmZiB3aXRoIDIwMjAwOTAyIHdvdWxkIGhhdmUgYmVlbiBtb3JlIGludGVyZXN0aW5nIGFz
IHlvdSBzYWlkIGl0IGRpZG4ndCB3b3JrDQo+IHRoZXJlIGVpdGhlciA/IEkgaGFkIGEgbG9vayBh
dCBpdCBhbmQgYW0gbm90IHN1cmUgd2h5IHdvdWxkIGl0IGZhaWwgdGhpcyB3YXkuDQo+IA0KPiBJ
IHRyaWVkIHRvIGxvb2sgaW50byB0aGlzIGJ1dCBJIGFtIGFmcmFpZCB5b3UgbmVlZCB0byBkaWcg
aW4gYSBiaXQgZnVydGhlciB0byBzZWUNCj4gd2hlcmUgaXQgaXMgZ29pbmcgYmFkLg0KPiANCg0K
SSB0aGluayBpdCdzIGNhdXNlZCBieSB0aGUgcGF0Y2ggYmVsb3c6DQo5MGQ0NmQ3MWNjZTIgb3Bw
OiBIYW5kbGUgbXVsdGlwbGUgY2FsbHMgZm9yIHNhbWUgT1BQIHRhYmxlIGluIF9vZl9hZGRfb3Bw
X3RhYmxlX3YxKCkNCg0KTXkga2VybmVsIGlzIG5leHQtMjAyMDEwMTIuDQokIGdpdCBsb2cgLS1u
by1tZXJnZXMgLS1vbmVsaW5lIC1uMTAgZHJpdmVycy9vcHAvDQphNTY2M2M5YjFlMzEgb3BwOiBB
bGxvdyBvcHAtbGV2ZWwgdG8gYmUgc2V0IHRvIDANCmNiNjBlOTYwMmNjZSBvcHA6IFByZXZlbnQg
bWVtb3J5IGxlYWsgaW4gZGV2X3BtX29wcF9hdHRhY2hfZ2VucGQoKQ0KMGZmMjVjOTkwNDJhIG9w
cDogQWxsb3cgb3BwLXN1cHBvcnRlZC1odyB0byBjb250YWluIG11bHRpcGxlIHZlcnNpb25zDQoy
YzU5MTM4YzIyZjEgb3BwOiBTZXQgcmVxdWlyZWQgT1BQcyBpbiByZXZlcnNlIG9yZGVyIHdoZW4g
c2NhbGluZyBkb3duDQo2MGNkZWFlMGQ2Mjcgb3BwOiBSZWR1Y2UgY29kZSBkdXBsaWNhdGlvbiBp
biBfc2V0X3JlcXVpcmVkX29wcHMoKQ0KNDc1YWM4ZWFkODAzIG9wcDogRHJvcCB1bm5lY2Vzc2Fy
eSBjaGVjayBmcm9tIGRldl9wbV9vcHBfYXR0YWNoX2dlbnBkKCkNCjkwZDQ2ZDcxY2NlMiBvcHA6
IEhhbmRsZSBtdWx0aXBsZSBjYWxscyBmb3Igc2FtZSBPUFAgdGFibGUgaW4gX29mX2FkZF9vcHBf
dGFibGVfdjEoKQ0KOTIyZmYwNzU5YTE2IG9wcDogRG9uJ3QgZHJvcCByZWZlcmVuY2UgZm9yIGFu
IE9QUCB0YWJsZSB0aGF0IHdhcyBuZXZlciBwYXJzZWQNCmRkNDYxY2Q5MTgzZiBvcHA6IEFsbG93
IGRldl9wbV9vcHBfZ2V0X29wcF90YWJsZSgpIHRvIHJldHVybiAtRVBST0JFX0RFRkVSDQo4YWFm
NjI2NGZjN2Ygb3BwOiBSZW1vdmUgX2Rldl9wbV9vcHBfZmluZF9hbmRfcmVtb3ZlX3RhYmxlKCkg
d3JhcHBlcg0KDQpJZiBiYWNrIHRvIHRoZSB2ZXJzaW9uIGVhcmxpZXIgdGhhbiB0aGF0IGNvbW1p
dCwgdGhlIGlzc3VlIHdhcyBnb25lLg0KZS5nLg0KZ2l0IGNoZWNrb3V0IDkyMmZmMDc1OWExNiBk
cml2ZXJzL29wcC8NCk5PVEU6IG5vIGR0IGNoYW5nZXMuIE9ubHkgb3BwIGNoYW5nZXMuDQoNCkFz
IEknbSBidXN5IHdpdGggc29tZSBvdGhlciB1cmdlbnQgdGhpbmdzLCBzbyBzdGlsbCBkaWQgbm90
IHNwZW5kIHRvbyBtdWNoIHRpbWUgdG8gZGlnDQpJbnRvIHRoZSBjb2RlIHRvIHNlZSB3aHkgdGhl
IGlzc3VlIGhhcHBlbmVkLg0KSSBtYXkgZmluZCBzb21lIHRpbWUgdG8gbG9vayBpbnRvIGl0IGxh
dGVyIGlmIG5vIG9uZSBlbHNlIGxvb2sgYXQgaXQuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiBI
aW50LCBmcm9tIHRoZSBlcnJvciBtZXNzYWdlIGFuZCB0aGUgcmV0dXJuIGVycm9yIChFTk9FTlQp
LCBpdCBsb29rcyBsaWtlIHRoZXJlDQo+IGFyZSBubyBlbnRpcmVzIGluIHRoZSBPUFAgdGFibGUg
dGhhdCBhcmUgdmFsaWQgYW5kIHNvIGEgY291bnQgb2YgMCBpcyByZXR1cm5lZCwNCj4gd2hpY2gg
bWFkZSBPUFAgY29yZSByZXR1cm4gRU5PRU5ULiBZb3UgbmVlZCB0byBsb29rIGludG8gd2h5IHRo
ZSBjb3VudCBpcw0KPiB6ZXJvLCB3aGlsZSB5b3Ugd2VyZSBhYmxlIHRvIGFkZCB0aGUgT1BQIHRh
YmxlLg0KPiANCj4gLS0NCj4gdmlyZXNoDQo=
