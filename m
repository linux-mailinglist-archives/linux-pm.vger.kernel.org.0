Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237811BD1F1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 04:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgD2CA2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 22:00:28 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:15328
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgD2CA2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 22:00:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge4HbujKEqzBgFcGhx3KHwzPDf/kPPix2al0LwbUvFhGHCwwmiZbIiOkEMbo9/x7ttVdAE7fTIo3q1MkWbuRPlt9dSeXR1acnDhuRIw4TSUt+lVl89PDXOABQDegMCnGWVVo5qHcY7XX1NG5RNXCg5HALDD2ZXsZyto3+tSBiaTD4Cguccm2wTcf2BvsTC2HcSemVzzTwSBYLhpKreTjfGsEj+o++WssUuBu3Dt841WB+FkRLIRFLq8twdqgb+IlKHMdfrr7khahxw1jdPL6JAd4+jMVuSe9UdaDV3ZcNxJ0dDGz2iXQ9+lH/n1D4mY9N7lTqPUXTtQ72Ep8fEviQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsKOs36Po3PsPaxTcCQR1X9piHfdZlMmT+V+TEzwSGc=;
 b=VxBjwbiFVoEUZwGOYdYRR32GasV8/qcm9syRnlcwhwKdhUHHw5dNvlLanhv7GMTKM9aHK3gf/7h06qQiZio6NRmx0U/PVT3RZ1zpKGjstpB0FjVHsjOjsl8JhxDbRbVgyqcofBUXgk+2qvF3WPHXhGADdm1oAwKreoAC26oswysder7DigZ9ZaklBepB8Vd1l1FTUI6GZaSKn825FACRxgTJ+X5e13gO7ikSF6I/oe7EebhCtUdKWxSlPDn6JWqeILKUXGjk1zhPPv4SkEvkoB6BMRORU3ylVFjS05PyMXnoCHArkzE3mhQPDCkIkLivbZ3wTMu4tZehJdg5JOTCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsKOs36Po3PsPaxTcCQR1X9piHfdZlMmT+V+TEzwSGc=;
 b=USDt4vRTgxwrCu6/vGRjzuXaoohQ88TcIoGZnYdoLndNIc6IbC5xGbCpjyHfg8wJHo332d0Gr7vLpOHuEtqy0S90oJmdJZ6pjO4LJbILr10KfJdfgVcqDswjfsaF0zHrj5pjxsacuWE39l1jHDZWnFZJvZCOoaABD3EibYQMMQ0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3868.eurprd04.prod.outlook.com (2603:10a6:8:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 02:00:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 02:00:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] thermal: imx: Add missing of_node_put()
Thread-Topic: [PATCH V2] thermal: imx: Add missing of_node_put()
Thread-Index: AQHWA3vs1K0ehrl/EEGfGjkXLirnQKiPME8AgABcN3A=
Date:   Wed, 29 Apr 2020 02:00:23 +0000
Message-ID: <DB3PR0402MB3916E5752413D058A5177820F5AD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1585232945-23368-1-git-send-email-Anson.Huang@nxp.com>
 <CAHLCerP7O19cRsK6OfmGm89K7KefRQnCUdNCNQM8mEAbycUjbg@mail.gmail.com>
In-Reply-To: <CAHLCerP7O19cRsK6OfmGm89K7KefRQnCUdNCNQM8mEAbycUjbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: verdurent.com; dkim=none (message not signed)
 header.d=none;verdurent.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20fc65e7-c203-4faf-8d67-08d7ebe1148e
x-ms-traffictypediagnostic: DB3PR0402MB3868:|DB3PR0402MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38681B194F58DAE2FC78D806F5AD0@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(44832011)(5660300002)(2906002)(478600001)(33656002)(4326008)(7416002)(8936002)(6916009)(66476007)(66946007)(66556008)(64756008)(66446008)(52536014)(76116006)(55016002)(8676002)(7696005)(71200400001)(53546011)(54906003)(316002)(9686003)(6506007)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZq5459DAqr58mUH1G4bW0tkbLPWXluFnnAMWnYEBACliHJi3zKjXRrGfpcXRWbLsdzhDffN1wiXTca4cCKW4tDJ1Dq0fK9xZ6ivwYhZOH0vIPEzGPB7LEkbc755v6fQg4nacSY73Xusm9hLe0/HtC9LMHSnLANIKl28CiQF4nXhnqk/scIdfBg4BjSuenxf2sJNXg2x8/v4UrL2NXrOHA/Ux5U64YzKPAcT9Uc1wkCDxhOqxZPhTVFruwJ+/Fa0rLU+JXCq2hygtgJJQeXFrGt3osgo6LzlWaB546TlzvJlHbnB35Ddc6GYfN3qDcaTzmXgbkW0uSQDPJXxku9O8nT0JHjugpr4GEjaRJ21ffDVG9tddNwnoSU3DuQBp2cwu69tOHbDMONxDTE3YT25AEtr/9zM4jYg+gYLsrMHk29eeNPgMeESvl2lACq/MjxT
x-ms-exchange-antispam-messagedata: mROZT0VzJTi1WfNfgw7qRD5MG+XaahEn5QwhA5gBp+ZhkeUCxc1DLD9ZjnrnTwbwvhFYIDU1VtPyuE1FPKTrjsm962rt6r4OdgERNEp0TJMnY65G3+aedQmSVZOIpWy7Nm9N2FVPBOmYhLA+JVIG0N1LfbH4+3jQBoC+xODUj7AjYm5ZT6hXNoXpHn30E/aXPeNelvbLkHrIb+gh4zRCedzAmGlxxJLL2umB2mvS+vl1+GUK5iw+PK7ky2MBwB1H4k8b4sO3ubYdhkgwhjRymqAmPDtFmBwzQPsex7T0Sjby+cfegyBRb8QvmrcN3emlPEpD2kCU1eA9ByQlh+2VVrnLxxjvs9g7cPw6FF5V9pmBiKGNOWQdOdQmg9+vrshdZDBaiH+u2gPqdd7qZ7ps/KP7owgE/KCX790URXUQhQGUSqs86DYgdtowGpNZlBabH8SnNQbB5y0NPx5tSTmIQ3sLrtnXvuDaKXTfKvvqxit0rPjQ0bccXbk5awaVivykbQCi1GdeiDRI4+nLdVbzZjhU+Jb/hWnhtUrYPjXTMEDE5DD2mhtLC/K2jqjEZEVJ/VywCpCtggDClA7X2e41Qw/Ol6ZC4Vqyc8IDed1j2X9NxwsZeFO+r1zQHOTjDOVM03LD1IXEKieJDe//mJioXS6QZuvdeb9y0WiyoHZLs/vszgB6SRUu6msnu7P6ADYBkyaXliNAm+coJZCmExKvMCElxvKOnjxoMadP4TjDvrxM5dUSa8+pG1sxaEpfAnrrZRdXQWuB9wm49UdEMMG/tGu7xael8rOP+FKp9v903Tw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fc65e7-c203-4faf-8d67-08d7ebe1148e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 02:00:24.0120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dgeegBiRe/lj/4sh+nS0WGaSlLYBkG8TOuIfyYsYuVxti1S4+c3hTuAmX00gp7vyzOJTuaRPP28jonuvraeI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFtaXQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIHRoZXJtYWw6IGlteDogQWRk
IG1pc3Npbmcgb2Zfbm9kZV9wdXQoKQ0KPiANCj4gT24gVGh1LCBNYXIgMjYsIDIwMjAgYXQgODow
NiBQTSBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4g
PiBBZnRlciBmaW5pc2hpbmcgdXNpbmcgY3B1IG5vZGUgZ290IGZyb20gb2ZfZ2V0X2NwdV9ub2Rl
KCksDQo+ID4gb2Zfbm9kZV9wdXQoKSBuZWVkcyB0byBiZSBjYWxsZWQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiA+ICAgICAgICAgLSBpbXByb3ZlIHRoZSBsb2dpYywgbm8g
bmVlZCB0byB1c2UgZ290Lg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvaW14X3RoZXJt
YWwuYyB8IDcgKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbXhf
dGhlcm1hbC5jDQo+ID4gYi9kcml2ZXJzL3RoZXJtYWwvaW14X3RoZXJtYWwuYyBpbmRleCBlNzYx
YzliLi4xYjg0ZWE2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbXhfdGhlcm1h
bC5jDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL2lteF90aGVybWFsLmMNCj4gPiBAQCAtNjQ5
LDcgKzY0OSw3IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsDQo+IG9mX2lteF90aGVybWFsX21h
dGNoKTsNCj4gPiBzdGF0aWMgaW50IGlteF90aGVybWFsX3JlZ2lzdGVyX2xlZ2FjeV9jb29saW5n
KHN0cnVjdCBpbXhfdGhlcm1hbF9kYXRhDQo+ID4gKmRhdGEpICB7DQo+ID4gICAgICAgICBzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+IC0gICAgICAgaW50IHJldDsNCj4gPiArICAgICAgIGlu
dCByZXQgPSAwOw0KPiA+DQo+ID4gICAgICAgICBkYXRhLT5wb2xpY3kgPSBjcHVmcmVxX2NwdV9n
ZXQoMCk7DQo+ID4gICAgICAgICBpZiAoIWRhdGEtPnBvbGljeSkgew0KPiA+IEBAIC02NjQsMTEg
KzY2NCwxMiBAQCBzdGF0aWMgaW50DQo+IGlteF90aGVybWFsX3JlZ2lzdGVyX2xlZ2FjeV9jb29s
aW5nKHN0cnVjdCBpbXhfdGhlcm1hbF9kYXRhICpkYXRhKQ0KPiA+ICAgICAgICAgICAgICAgICBp
ZiAoSVNfRVJSKGRhdGEtPmNkZXYpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gUFRSX0VSUihkYXRhLT5jZGV2KTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBjcHVm
cmVxX2NwdV9wdXQoZGF0YS0+cG9saWN5KTsNCj4gDQo+IFlvdSBjb3VsZCBtb3ZlIHRoaXMgcG9s
aWN5IHJlbGVhc2Ugb3V0c2lkZSB0aGUgaWYgYmxvY2sgdG9vLCBubz8NCg0KTG9va3MgbGlrZSB5
ZXMsIHRoZSBwb2xpY3kgY2FuIGJlIHB1dCBiZWZvcmUgZnVuY3Rpb24gcmV0dXJuIGFueXdheSwg
SSB3aWxsIGRvIGl0IGluIFYzLg0KDQpUaGFua3MsDQpBbnNvbg0K
