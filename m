Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F2C28CB14
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbgJMJee (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 05:34:34 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:35006
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387597AbgJMJed (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 05:34:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jab1i5voI0iICN1hCVjRjYtizSVRyBr+SHB3DscIrEMsUWLGU+YkaZuVSCeNpGnIgvPVbSM+M8WHNtfHFBQWN4Wkt7dcmMJdglOSilYySXjaEuTkazPyyif3ziHKACeCb70Hthz18VVlTL0jMa9f4qR7AcTNP2U8w6JIUzPd7Erk+yayVWDnbqA/sCnGrF7T0+oomb87mov8/EXIUeN+Ev1nVAkER5NqJ93/zwaXyl1TmcBAr8pSfwmkdsxcSSojr0csq0Ql7w4ye9IQOobqaXX08UiZpJoa8EWZ8k+qQs8ZNfRTo1Mi/OZ8Hfo+nxFkUcSQTy5SxdXm8HRbAgw9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp/lEb51zKsrJZjxa1xT/iDjQ7do8K9v/0vGPKZ4tTg=;
 b=lJjxlGLrgoHDIH2fGc4mlKtYnl5wpQbTyWG33g4D+bNP9U93NbaixrVZXJx6fvnd9IutOW2fH16uip2VzcCwOEHFZNyuB1noVcUVgmw57XnNw5wLLBsNb1Ex4wF4s/t3e1VEg+31Kjh4/YZgslzpcKfv4UBGOYDWKjhQCSI4VuKROYL0LAW4I1ovFZN6ULSIzZWtGytJr/R/ihPAg+8hyxFVL1UoEGml9rUs5YsM2ad0GB8r1qvRGfEL2dyn9OPBDOv80t+5RwdZxgFcVV59BDG3BqMPT+XGjNdr7cYhoXkt/jHa6yI5ycFQX5Chxq90pvalzRosv412O8bbdEAGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp/lEb51zKsrJZjxa1xT/iDjQ7do8K9v/0vGPKZ4tTg=;
 b=knRCZLcABigOu7GsRvLN2PR9qG7iIm++MhF+yQd+D+eZNRacqN50KLoXTKhTh+mN0CW6pTpPKxQcjzRMrT6fPAm9cf3j8+aMvx8rENxYCMUm08/a9qiKKabsBqRXGYIyOI3zaI4sJD6YEh9Q8rUHzeGI00N8rONYNleJpFO/BmY=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM5PR0401MB2450.eurprd04.prod.outlook.com (2603:10a6:203:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 13 Oct
 2020 09:34:28 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3455.029; Tue, 13 Oct 2020
 09:34:28 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Anson Huang <anson.huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Sascha Hauer <kernel@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dongas86@hotmail.com" <dongas86@hotmail.com>
Subject: RE: cpufreq regression on imx6q sabresd
Thread-Topic: cpufreq regression on imx6q sabresd
Thread-Index: AdahMGy5rDqWJMR8TQG2KN/ixfSdHwAE3z7g
Date:   Tue, 13 Oct 2020 09:34:28 +0000
Message-ID: <AM6PR04MB49663EC1988A076B82542A1680040@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <AM6PR04MB4966C65D8439BD0B0459B6AC80040@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966C65D8439BD0B0459B6AC80040@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6763f61d-6200-42e1-2a91-08d86f5b2ebb
x-ms-traffictypediagnostic: AM5PR0401MB2450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR0401MB2450C7CE37C53E4EC4857FD880040@AM5PR0401MB2450.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r90TycnxlySEBMl7joMuK5nlot28hCxNG0bKV/FVCsmvf1HFCgXzcXKHHPhdsI4IOXyTxIFby6sHGVbJZo7tRjOtgn9VN3Ef6NmZs8dcL2ewvkR2XUKMZw5zj/O+GuH/KTkTUnLgfeBLfPF3zNWp3+BBhRWiJX7BasZJcEF6HfKlA6imzD4oChK3KwretC5NTFXTLQdXH2JFLstCnWp6TEqlCGIwZ1IDzvakwXHDBf3JR53AAsQkvkylpsb3H0w5pWmOkOHy0e6ajtSnNO802Pu851ven0/NdhY/REpqluKvObYodB6JiQEBSuwltOOMhR3//Sd5e2u7n9DVh5uYlAmb8AC1hvfc76TKuos+WGvxuOKZKBp4Dr9WsXpmknPT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(76116006)(8676002)(6506007)(9686003)(316002)(26005)(186003)(66476007)(66556008)(64756008)(66446008)(66946007)(33656002)(2906002)(8936002)(5660300002)(71200400001)(4326008)(83380400001)(52536014)(7696005)(478600001)(55016002)(110136005)(44832011)(2940100002)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: w6qh+gXUbwJ8bC+uDTc+daMxHRMiBLbniM1QP1n23c2/wbIHtrvmedhasPMu5M+V94irHi74DlyY99UHo107/9c/U2EGK7ouX8kufVh71c+PiXsKX9beqKUvMBz9e/oM/CUavXfriXR2lfPQGAfkgs7xgjINJIYPaDEJw+5DASJaP3m4kDAR1Qr8xk+MqUDmWMU11cA1ZvP4HoPo6GQnk3IE8HGLQ05vrTU87K3lVg3VfsF9NzKygmyfyGUHody4VlDCO/NBWwUbITYvw55byMTULR6jlEzaqftH2oY2KLXv0njTQIWfUfPqqUFLXr9GkIjBS//9GlmZs3Fmg0jPgGC2NU0hYfo8wi2qD0m9JoOzetxpGlQAei7BqTS7JZOhautTjCEMIYz7YeQN1ITgFiEq7axPJ/Gi1PeTAP7godgMOrW0HgszRitz+RBi1zcU6KST7IEDpmP4FOkM2Kt4RNk4YhJ3tU3WE0nPNZM05PZzwEGYwS66P02nvc9dgakKRg+NXs99vY3rUOGHrIfFPt7N4re/axyoF2nZWz6tSDvjkwh2oPlAEsAG/BwKAY8sQqUr/9sHuBD8rlkbwRttzkGu6zXh1UGNxjFXUnKOsFFRW6/NvldSEnkQuf27zHGI01bwRAT5TmelDEXTW2dAGg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6763f61d-6200-42e1-2a91-08d86f5b2ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 09:34:28.8960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33PHP03kVCgZ/Tfaii/mvv6zhCBn58x+OUd6U7jeQ57gwyPIOPVGPJHumsT9X7RQB6obSEWePNqsVkwErBSZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2450
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

KyBsaW51eC1hcm0ta2VybmVsDQoNCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+IFNlbnQ6IFR1ZXNk
YXksIE9jdG9iZXIgMTMsIDIwMjAgNTowMCBQTQ0KPiBIaQ0KPiANCj4gQ3B1ZnJlcSBvbiBNWDZR
IFNEQiBiZWNvbWVzIHVud29yayBzaW5jZSBuZXh0LTIwMjAwOTAyIGFuZCB0aGlzIGlzc3VlDQo+
IGFsc28gZXhpc3Qgd2l0aCBsYXRlc3QNCj4gbGludXgtbmV4dCBuZXh0LTIwMjAxMDEyLg0KPiAN
Cj4gRXJyb3IgbG9nIGFzIGZvbGxvd3M6DQo+IFvCoMKgwqAgNi43ODIzOTVdIGNwdSBjcHUwOiBm
YWlsZWQgdG8gZGlzYWJsZSA4NTJNSHogT1BQDQo+IFvCoMKgwqAgNi43ODcyNDZdIGNwdSBjcHUw
OiBmYWlsZWQgdG8gZGlzYWJsZSAxLjJHSHogT1BQDQo+IFvCoMKgwqAgNi43OTIxODldIGNwdSBj
cHUwOiBmYWlsZWQgdG8gaW5pdCBjcHVmcmVxIHRhYmxlOiAtNjENCj4gW8KgwqDCoCA2LjgwMDIz
NF0gaW14NnEtY3B1ZnJlcTogcHJvYmUgb2YgaW14NnEtY3B1ZnJlcSBmYWlsZWQgd2l0aCBlcnJv
ciAtNjENCj4gDQo+IFNpbXBseSBiYWNrIHRvIG5leHQtMjAyMDA4MjggdmVyc2lvbiBmb3IgZHJp
dmVycy9vcHAgY2FuIGF2b2lkIHRoaXMgaXNzdWUuDQo+IGUuZy4gZ2l0IGNoZWNrb3V0IG5leHQt
MjAyMDA4MjggZHJpdmVycy9vcHAvDQo+IFNvIHRoZSBpc3N1ZSBzZWVtcyB0byBiZSByZWxhdGVk
IHRvIE9QUCBjaGFuZ2VzLg0KPiANCj4gJCBnaXQgbG9nIC0tb25lbGluZSAtLW5vLW1lcmdlcyBu
ZXh0LTIwMjAwODI4Li5uZXh0LTIwMjAxMDEyIGRyaXZlcnMvb3BwLw0KPiBhNTY2M2M5YjFlMzEg
b3BwOiBBbGxvdyBvcHAtbGV2ZWwgdG8gYmUgc2V0IHRvIDANCj4gY2I2MGU5NjAyY2NlIG9wcDog
UHJldmVudCBtZW1vcnkgbGVhayBpbiBkZXZfcG1fb3BwX2F0dGFjaF9nZW5wZCgpDQo+IDBmZjI1
Yzk5MDQyYSBvcHA6IEFsbG93IG9wcC1zdXBwb3J0ZWQtaHcgdG8gY29udGFpbiBtdWx0aXBsZSB2
ZXJzaW9ucw0KPiAyYzU5MTM4YzIyZjEgb3BwOiBTZXQgcmVxdWlyZWQgT1BQcyBpbiByZXZlcnNl
IG9yZGVyIHdoZW4gc2NhbGluZyBkb3duDQo+IDYwY2RlYWUwZDYyNyBvcHA6IFJlZHVjZSBjb2Rl
IGR1cGxpY2F0aW9uIGluIF9zZXRfcmVxdWlyZWRfb3BwcygpDQo+IDQ3NWFjOGVhZDgwMyBvcHA6
IERyb3AgdW5uZWNlc3NhcnkgY2hlY2sgZnJvbQ0KPiBkZXZfcG1fb3BwX2F0dGFjaF9nZW5wZCgp
DQo+IDkwZDQ2ZDcxY2NlMiBvcHA6IEhhbmRsZSBtdWx0aXBsZSBjYWxscyBmb3Igc2FtZSBPUFAg
dGFibGUgaW4NCj4gX29mX2FkZF9vcHBfdGFibGVfdjEoKQ0KPiA5MjJmZjA3NTlhMTYgb3BwOiBE
b24ndCBkcm9wIHJlZmVyZW5jZSBmb3IgYW4gT1BQIHRhYmxlIHRoYXQgd2FzIG5ldmVyDQo+IHBh
cnNlZA0KPiANCj4gTk9URToNCj4gRHVlIHRvIGFub3RoZXIga25vdyB1cHN0cmVhbSBrZXJuZWwg
Ym9vdCBpc3N1ZSBjYXVzZWQgYnkgcGNpZSwgd2UgaGF2ZSB0bw0KPiBhZGQgYmVsb3cgd29ya2Fy
b3VuZCBpbiBvcmRlciB0bw0KPiBCb290IE14NnEgc2FicmVzZC4NCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiBpbmRl
eCAzMTdmZjUxMmY4ZGYuLmFmZWUxYTBlODg4MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+IEBAIC00NDEsNiArNDQx
LDkgQEAgc3RhdGljIHZvaWQgX19pb21lbQ0KPiAqZHdfcGNpZV9vdGhlcl9jb25mX21hcF9idXMo
c3RydWN0IHBjaV9idXMgKmJ1cywNCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBjaWVfcG9ydCAq
cHAgPSBidXMtPnN5c2RhdGE7DQo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkd19wY2llICpwY2kg
PSB0b19kd19wY2llX2Zyb21fcHAocHApOw0KPiANCj4gK8KgwqDCoMKgwqDCoCBpZiAoIWR3X3Bj
aWVfbGlua191cChwY2kpKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
TlVMTDsNCj4gKw0KPiDCoMKgwqDCoMKgwqDCoCBidXNkZXYgPSBQQ0lFX0FUVV9CVVMoYnVzLT5u
dW1iZXIpIHwNCj4gUENJRV9BVFVfREVWKFBDSV9TTE9UKGRldmZuKSkgfA0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0lFX0FUVV9GVU5DKFBDSV9GVU5DKGRldmZuKSk7DQo+
IA0KPiBSZWdhcmRzDQo+IEFpc2hlbmcNCg==
