Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4651C194115
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 15:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgCZORL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 10:17:11 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:9447
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727751AbgCZORL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 10:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjlQa9HgI+twreTv1Hv6oJmaNjbki1o2sjaxpm9de3dHOHNHO8hiHXZLXr6iPUWUSWmqcteY0WpnOJzDmgYVpVeRDP+Q5Unl/Za6dEm64C4KLnWDSKZqDwFoZE0K5w80I5pi3yaalRMmMNbkHoQJ0Cqr3j8Y24MsYROpJtpa2GIABlWz5ogKALfykt4OIsh7DlXTeSRIghzaSpkI5MukH0DWt4jIqXPx9GNNrpqfh+GsAsO8jTqdMgFh8+Cg1kOqLK0F75j9Sgf9JIMe0d3WtRBuie5Q3F78OsOF+rzoPYUIz3k3nL2OERpLKVtoNJOh1UaxL03j23wwAHvsXKmkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xRMCs5XdbSctT6VGReAGpgj7mfw20McXX7MyGgey5c=;
 b=Z5UWfAPuenbdb/E2l0YmqgigiAxXQZXSYrisQtU22Gyu93/yrmLGD4mh9WBnrCzXy6KkCkM5HoUR6/Z2ridw1zUNu7u44MSnsaUOok2VniI7ly+wqLuL7cMSdT2nT47VoaepSuGt5MlfTuRw2biHYIHBnQwGicoQ71uVa812kHh4R3/A7yQEhaMtWPh8WkBJiclnlgBmUx9A24uEnogwE5844tl727T9yqokz8Ug+x8/N7DvQDb4Y7hx5CXW+C2c0+wCAyZeW0pZcqB0FYH+3E5YW7ihfGPjEOReHQhKu/8KJeP7FrzD86dB7v+BS21mj4sVsBS5M0i89aJbgEEUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xRMCs5XdbSctT6VGReAGpgj7mfw20McXX7MyGgey5c=;
 b=pwpUmBWd1E60RkmOcXNYhJEPM1fneMG6ZMadb7VbVSMwtMQmE4y1wg0rSB1rwYyjtCqUUQMNLapmdU/SmGhdg3HXrpGBUo4NdbSWiPSMSk7p4HktaLzn+DuKFcplV9fji0g/L7YodWOKvSC01nnF5MnbMTaBHoggT62jOT/MpsQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Thu, 26 Mar 2020 14:17:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 14:17:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: imx: Add missing of_node_put()
Thread-Topic: [PATCH] thermal: imx: Add missing of_node_put()
Thread-Index: AQHWAzBAgRLyKlHtTk2Dsujd2fCjGqha6SaAgAABlyA=
Date:   Thu, 26 Mar 2020 14:17:05 +0000
Message-ID: <DB3PR0402MB3916F370C524F3F8CE590167F5CF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1585200445-16461-1-git-send-email-Anson.Huang@nxp.com>
 <8325cde9-02f3-b913-b020-4c98d19936f4@linaro.org>
In-Reply-To: <8325cde9-02f3-b913-b020-4c98d19936f4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba938f9a-0f00-4771-59fb-08d7d1905c86
x-ms-traffictypediagnostic: DB3PR0402MB3865:|DB3PR0402MB3865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3865D6D42F57C637AFD29BBDF5CF0@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(2906002)(66556008)(66476007)(66446008)(55016002)(8676002)(316002)(64756008)(66946007)(5660300002)(86362001)(7416002)(71200400001)(9686003)(110136005)(7696005)(33656002)(52536014)(26005)(81166006)(44832011)(478600001)(4326008)(76116006)(53546011)(81156014)(8936002)(6506007)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qSWLBoj/p6fNgEdU3KD7xRMF16qBlT+xNQkHhuae6EvlAvTEXzi6xZ8iT8K/SvYP71Q3aQco2MCmUdegW0nLQCoZlZPnGQ667GO3BqIlyafUHD9qmjSAlzKmXx82axKBF9qgQcn0F/3J0wJyssVhYSon0OZZ5Sj8cuvKM4Jpm3i5ofO7flgJTnKKRZOXgaTWgkrmYV70UpSrLVSzLUN0LJvLVb0lt2FD+1JkfzAZtM4cctco31K/qrDZIKDaQej4dTAXe2evut4b9DiQuCDSPDZILro7tKeRtcVbjTppUsUiSpLZHuklntis6TJGgnho0ZpjdYad1c0wl7a0IMmdUvXL/C+2Ig5iPrHlWNDRC6DNBN1eN2Sxt2d0pBPuoOp2WdCVrB1+RQmzc8avZgDdEujwDGwrEeeOZxwmvsHqafRokjGHyOgTguI8Kqv7t7WYm3GasKn0d6mHYgQZOPPWyOwUyeA+KqGpiMv14pQqsZKnrka0SY9d64bf0kxoudqW
x-ms-exchange-antispam-messagedata: gE/0lHS7dG4g/Pamo49kCnc32z8NiJAq1jqQJ71iYRS122shG4KV32FCvtYQnocMXlwJmaVidBjAUIa/9xIDMIW1JLLSJMJiM8U5VmamuEfn1XgYffs4aqTfDwAqvjddIuHWYMAujFW71ejNw6k62A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba938f9a-0f00-4771-59fb-08d7d1905c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 14:17:05.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdiKLiBjDF0tPqWcat0h528FQDWxOa7XzkFRdS2vDhi9MUjAyRLFuQrWtjGggFYdqgZwb+5Qf36hHBV22s0i2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRoZXJtYWw6IGlteDogQWRkIG1p
c3Npbmcgb2Zfbm9kZV9wdXQoKQ0KPiANCj4gT24gMjYvMDMvMjAyMCAwNjoyNywgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gQWZ0ZXIgZmluaXNoaW5nIHVzaW5nIGNwdSBub2RlIGdvdCBmcm9tIG9m
X2dldF9jcHVfbm9kZSgpLA0KPiA+IG9mX25vZGVfcHV0KCkgbmVlZHMgdG8gYmUgY2FsbGVkLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
IC0tLQ0KPiA+IGRyaXZlcnMvdGhlcm1hbC9pbXhfdGhlcm1hbC5jIHwgMTAgKysrKysrKy0tLSAx
IGZpbGUgY2hhbmdlZCwgNw0KPiA+IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL2lteF90aGVybWFsLmMNCj4gPiBiL2Ry
aXZlcnMvdGhlcm1hbC9pbXhfdGhlcm1hbC5jIGluZGV4IGU3NjFjOWIuLmY3Yjk3MGQgMTAwNjQ0
IC0tLQ0KPiA+IGEvZHJpdmVycy90aGVybWFsL2lteF90aGVybWFsLmMgKysrIGIvZHJpdmVycy90
aGVybWFsL2lteF90aGVybWFsLmMNCj4gQEANCj4gPiAtNjQ5LDcgKzY0OSw3IEBAIE1PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIG9mX2lteF90aGVybWFsX21hdGNoKTsNCj4gc3RhdGljDQo+ID4gaW50
IGlteF90aGVybWFsX3JlZ2lzdGVyX2xlZ2FjeV9jb29saW5nKHN0cnVjdCBpbXhfdGhlcm1hbF9k
YXRhICpkYXRhKQ0KPiA+IHsgc3RydWN0IGRldmljZV9ub2RlICpucDsgLQlpbnQgcmV0OyArCWlu
dCByZXQgPSAwOw0KPiA+DQo+ID4gZGF0YS0+cG9saWN5ID0gY3B1ZnJlcV9jcHVfZ2V0KDApOyBp
ZiAoIWRhdGEtPnBvbGljeSkgeyBAQCAtNjY0LDExDQo+ID4gKzY2NCwxNSBAQCBzdGF0aWMgaW50
IGlteF90aGVybWFsX3JlZ2lzdGVyX2xlZ2FjeV9jb29saW5nKHN0cnVjdA0KPiA+IGlteF90aGVy
bWFsX2RhdGEgKmRhdGEpIGlmIChJU19FUlIoZGF0YS0+Y2RldikpIHsgcmV0ID0NCj4gPiBQVFJf
RVJSKGRhdGEtPmNkZXYpOyBjcHVmcmVxX2NwdV9wdXQoZGF0YS0+cG9saWN5KTsgLQ0KPiAJcmV0
dXJuDQo+ID4gcmV0OyArCQkJZ290byBwdXRfbm9kZTsgfSB9DQo+ID4NCj4gPiAtCXJldHVybiAw
OyArcHV0X25vZGU6ICsJaWYgKG5wKSArCQlvZl9ub2RlX3B1dChucCk7DQo+IA0KPiBvZl9ub2Rl
X3B1dCgpIGlzIGFscmVhZHkgY2hlY2tpbmcgaWYgJ25wJyBpcyBOVUxMLg0KDQpPSywgSSB3aWxs
IHJlbW92ZSB0aGUgY2hlY2tpbmcgb2YgaWYgJ25wJyBpcyBOVUxMLg0KDQpUaGFua3MsDQpBbnNv
bg0K
