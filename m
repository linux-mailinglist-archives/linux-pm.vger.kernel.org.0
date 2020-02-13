Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF41015BA66
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 09:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgBMIBi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 03:01:38 -0500
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:37385
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729477AbgBMIBh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 03:01:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCVImkh3nQWvBlL6w8EFjo7N84A+nC69L2sConF4g9ld32CneKNhDlem5RH2/b66ANMnyAU8WCeMKIiKzEy6AakZwgfTtowNeagODM5EfJ2+ohvzc4D6zi6jITTf+lpbq51g3rbGRF1WM0feMDygtJO/NmNhLDu9F+yR2+iqPpt2r4APnyRCkSE7yf29vC2DZEuMHBSDPypAuJNzUvqA1oZqOVrRn3381pIFfuR1WQHBrtRKIvBLdRhR0WDcVzsKIw/X8l/c9JlN3w6F2nU4AqXPCTCfgm1LKkvrS6qNkA4/JJuLolPfUtWO5gDLMhT8zaYVFdEjvXVeIR1UxVctCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9s+ySQSNKdYZ6S2tTGS02m8AEAHLTN7RslG7UchFQo=;
 b=Ytj1J6CTdU0i/vPB1t7AYgJwcKTzdaWRR7KIh5sVjldGIxlJqnNuU5y8TqzKctnO+IJD+KbfnpMv248SCTsQUTNWb513kFADZR5Vzhh416s2U0uz2ZgNNSGES0D8rnCEmzuTtzOlCMfRBg6z0y4OdM13RgqBCjKMVHv/lYpwzUThCWNRh2obb8OSnAZhlomiht1tKwOCdzwI62Rx1csZXYZlKh/jwyUEu0knQL/lxV2CNnvPvS9yhCS36EO7urz8fiBXn4+phx1YN9cYWOntH2eAiOGAiBcZA4H8o7zjjS1rfMLqs0E1hRoD2MAk6nxFp9uaADSFJx57ArpjBn8S4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9s+ySQSNKdYZ6S2tTGS02m8AEAHLTN7RslG7UchFQo=;
 b=kTA2sp1u6yhcRAgPKZtOlSA3zq7PXdG/z3enRLvAEFf0pi+g+CANGxq40kHQfp3T2LgIsf/3dIfQiGUwBpEO5N6g22hnsky9C5fu0CXTUlhZi35cZ3zc/Jb6e38WS/j859C4Ue9rHbdQ8Fd1hKACxMMnOwaPZNYECXzerVqWX5E=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2623.jpnprd01.prod.outlook.com (20.177.105.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 08:01:33 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::318b:31aa:4212:bd49%7]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 08:01:33 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] thermal: rcar_gen3_thermal: Remove unneeded curly
 brackets
Thread-Topic: [PATCH] thermal: rcar_gen3_thermal: Remove unneeded curly
 brackets
Thread-Index: AQHV4fZy7Fyhn5L/AkuHpP91AaZAc6gYw4MQ
Date:   Thu, 13 Feb 2020 08:01:33 +0000
Message-ID: <TYAPR01MB4544EF734FC5E993CB88A594D81A0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200212224732.736785-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200212224732.736785-1-niklas.soderlund+renesas@ragnatech.se>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 318cb3c1-d348-48b2-8e4f-08d7b05af143
x-ms-traffictypediagnostic: TYAPR01MB2623:
x-microsoft-antispam-prvs: <TYAPR01MB26239E14B87933A3B9861E60D81A0@TYAPR01MB2623.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(376002)(396003)(39850400004)(199004)(189003)(81156014)(81166006)(8936002)(478600001)(8676002)(86362001)(9686003)(55016002)(110136005)(33656002)(71200400001)(4744005)(55236004)(6506007)(2906002)(186003)(7696005)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(26005)(316002)(5660300002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2623;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6VBUZ5IV+SqFH+VpR1PmtFYrSCOO5hrGuGgZ01VY97WEAiMzuSmOjf+qIJnYl5oD9vT1G4i2H97ErFMaKhrRNluWIyOHIu9XncJhxW7Zn4SpSr3SQz/5JoEZSU5M2FKgR+rww/dBpODXBeQPG4mYXBKYK0CpTVUla2E6FLd3PPL48jq2+m8o4HBkpYYgueragneU49DeCvibuc8PBjyAR7tcsLmDcy6VfegjA7QKHwYcZqK5LyTzRUlVSJFM+5UyyXei20XDQUhiXinGiMHiF/XsawlWh8+TX8R34ENWIPOv6zpOnyF28tx4dRdlSwO/lQNmQBvDb8XHirCqq8AIrYpmwZU+daPXKvErfhgYnUGMhFfoO2emM37wQyNB6LVurwGNfGtx6N5KO3MWTZr8aJDnJP03aS9GdeAz4o+ryT0OCSD6MZszQ9mgbjszlrm
x-ms-exchange-antispam-messagedata: wXb48m7co1TaGKpuhCJC+ALIyV5viRZ1Dlbi8mf9u+nAZVeoOd++mIVhbgGWvtpcRZONLi5T00Bq4wgcWuhQLaEndc7NN6wrwRdRpFrsp1iANLCqVRg2ab9M8qnB37v25OOPYycvaPSvg9QmN/SgYg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318cb3c1-d348-48b2-8e4f-08d7b05af143
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 08:01:33.6136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8/3kadhgt57ZjJE9/30U823ryWkhBhoDZgQf0+or4svNenqt6o8JlrZGB1MB6xhBPGJzA1QoHTtDbZobEfBppeYOF1RR4i6vgyhwLtMd8DdwzZVV/WEfZv9FcAYbZ1C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2623
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTmlrbGFzLXNhbiwNCg0KPiBGcm9tOiBOaWtsYXMgU29kZXJsdW5kLCBTZW50OiBUaHVyc2Rh
eSwgRmVicnVhcnkgMTMsIDIwMjAgNzo0OCBBTQ0KPiANCj4gV2hlbiBkZXZtX2FkZF9hY3Rpb24o
KSB3YXMgdHVybmVkIGludG8gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCkgdGhlDQo+IGN1cmx5
IGJyYWNrZXRzIGZvciB0aGUgZXJyb3IgY2FzZSB3aGVyZSBrZXB0IGJ1dCBhcmUgbm90IG5lZWRl
ZCwgcmVtb3ZlDQo+IHRoZW0gdG8gbWF0Y2ggdGhlIHN0eWxlIG9mIHRoZSBkcml2ZXIuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBOaWtsYXMgU8O2ZGVybHVuZCA8bmlrbGFzLnNvZGVybHVuZCtyZW5l
c2FzQHJhZ25hdGVjaC5zZT4NCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghDQoNClJldmlld2Vk
LWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+
DQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCg==
