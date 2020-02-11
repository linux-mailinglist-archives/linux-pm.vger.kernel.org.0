Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA2158A44
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 08:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBKHUH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 02:20:07 -0500
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6022
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728070AbgBKHUH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Feb 2020 02:20:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEO48MtKVnEVcILvP07i25Nfler8T3pXdb5mT/rz2YIfI+UkKDX5ddSgb2Uiv06TIo68nj3EcQiz1MrJVaU4BV52CbwNoC76VaQUU8YjeIm5kd5OoVnBcAR9X9G+NQZyYOu2SXhKxr1gQZhUx31bREIVrAUaty7Vsn7jMxLD62cBGEgbS21PDDhK8/CDEWCuueFnikh7U7Yb2VWB4XH0FakD1IRXlVZNcFVi2whSkMv5CXG9V6HZeaosSEVfbBDzIhOL+xWaDMj5ch7cIgwSEas5mJARtajbTz32PnD8QB6f1cfeDqY6B0xcVHpaq9hT63bBQ4AdJt+cmG+gkDu3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swCis5M99B9lvtBFYHv1jP/JpkOMAf/kh26dIan5In4=;
 b=ezmap3RYPA+rJVuBlcXYLry9VDU20YUoO182cVvG/nN4WTqFFnzyHBXMGcV0giIRt8IGnYe7AEFIV1G14p52uZllWCmADk7jFLvhU8I/OyUeFDRFdhQXI6qVLjrK4B3cvvM41weHOKdM7mXa2bGEUmutS02/Cpqf2iknrOJksBq5JNFT6nobPgO7AxQjuYtK4yfZXAHr5Gu4joKvKle64A0z1fNYvQhu0UAjovhCFHkjFdMLORzBWA4kRSA8Bj3F3/X3thYPznSVK25mRggq7xIzwb0gPvH39K+DocllKa8pnW60sCyBmgHi7TLb0y/j0ymYSzZRVG8AhAASImN8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swCis5M99B9lvtBFYHv1jP/JpkOMAf/kh26dIan5In4=;
 b=U0WZTkfbqtEi0aN000nwYzeTXNpBU9HDf47SEhMOofdYqd/4w9kyDMwYnnIfZMImrciFlWlJ7Gt7Ot13N+9KTlkzefa/CCa/rZmjTMSK5jw4ZSnWzbAw3KfEfZSJkKPFwSbzAuEtCbSkFsqxvTMwMS+04De21UEwTDOiEqzlS7Y=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5488.eurprd04.prod.outlook.com (20.178.120.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 07:20:03 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 07:20:03 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [EXT] Re: Ask for help about cpufreq issue
Thread-Topic: [EXT] Re: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxAAA6GCAAAAcdEAAA3btAADDOJ9wAANpvoAAAOC7QAAAkWqAAAGPepA=
Date:   Tue, 11 Feb 2020 07:20:03 +0000
Message-ID: <VI1PR04MB433391DABC853D5E6811B76AF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
In-Reply-To: <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [120.244.236.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91b348f3-fbf8-4aaa-866d-08d7aec2d05f
x-ms-traffictypediagnostic: VI1PR04MB5488:
x-microsoft-antispam-prvs: <VI1PR04MB5488EEDF75FBC4E976F569DBF3180@VI1PR04MB5488.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(7696005)(478600001)(54906003)(71200400001)(44832011)(316002)(8936002)(55016002)(8676002)(52536014)(4744005)(9686003)(81166006)(81156014)(4326008)(5660300002)(33656002)(66446008)(66946007)(64756008)(66556008)(66476007)(76116006)(26005)(53546011)(6506007)(186003)(86362001)(6916009)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5488;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YI6O9rRLDajNw5bTVhPCg3hpzUgDHpnmVCBihiwKmMcV/psK2hrZhW8fAW0zlvRINmIIQFt2gHq02WFz5FTfVJSUnp0M4fVBWTWJJeeo/UioFvXgbvKgYnYIxwKTLrzWo1k1Xf24HdFv/8tUfwPTxiWoHdYAT7bhVaHEjRaag3WhG1aEVbnIhg0Tr3f9WOzdb9fb6g188Aye/ZrfvHslv6K/PHMcwN+0Otd0l1+QmwxGk3BAY1zFBMOGzOEBNWLkd4dpGNWQPjM271qPLartQIIGmFgieQrE5YIKbnPH5cCC/QEOQIaL0mwgPdzSbqQooSkdcO6c41r5AAhTOIPY1fEKRd/M+RThtIsq9wF7LEuhtMMj50cA0i2X84Jtzd1IIsHowp+KMv2FrXO0EEhLsAb/OtvDdOaQTM6ad1PMnLDd1iY6DnqbnWarIPPv+t76
x-ms-exchange-antispam-messagedata: LwpVMJ1Zz5iNZGu+HC+gdumbBjkU/LEoFH6304kZxO5KKAu5EcyLxIGeOG04lX6L7mKfNCAGJIqEBLmvHawVJs2cBRghAFpaLubF+FnMChmbQosGv8133yOT31OGOkB4R+Ds+QH0rxG3Z0vHehA3yw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b348f3-fbf8-4aaa-866d-08d7aec2d05f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 07:20:03.7375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6wegfErcZuTSa2TpLl86nV60swFQwi0ymodsA22jARlb6IqN2eSFFAptPurUTdfo2OEvDSfJtfR1ZlAPmlwLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5488
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmsgeW91IHZlcnkgbXVjaC4gSSBjb25maXJtZWQgaXQgd2FzIGNhdXNlZCBieSBRT1MuDQpU
byBiZSBzcGVjaWZpYywgaXQgd2FzIGNhdXNlZCBieSBUTVUuDQoNCkJSLA0KQW5keQ0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1
bWFyQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjDE6jLUwjExyNUgMTQ6MzUNCj4gVG86IEFuZHkg
VGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IENjOiByandAcmp3eXNvY2tpLm5ldDsgbGludXgt
cG1Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogQXNrIGZvciBoZWxw
IGFib3V0IGNwdWZyZXEgaXNzdWUNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24g
MTEtMDItMjAsIDA2OjIzLCBBbmR5IFRhbmcgd3JvdGU6DQo+ID4gSSBhbSBnb2luZyB0byB0cmFj
ayB0byBkZXZfcG1fcW9zX2FkZF9yZXF1ZXN0KCkgYXMgeW91IHN1Z2dlc3RlZC4NCj4gPiBCZWZv
cmUgdGhhdCwgSSBhbSBhbHNvIHdvbmRlcmluZyB3aGF0IHRoZSBmYWN0b3IgaXQgY291bGQgYmUg
dG8gbGltaXQgdGhlIGNwdQ0KPiBtYXggZnJlcXVlbmN5Pw0KPiANCj4gT25lIG9mIHRoZW0gaXMg
dGhlcm1hbCwgYnV0IHRoZXJlIGNhbiBiZSBvdGhlcnMgYXMgd2VsbC4gSnVzdCBkbyBmb2xsb3dp
bmcNCj4gc2VhcmNoIGluIHlvdXIga2VybmVsIHNvdXJjZSBjb2RlOg0KPiANCj4gZ2l0IGdyZXAg
ZnJlcV9xb3NfYWRkX3JlcXVlc3QNCj4gDQo+IFRoaXMgd2lsbCBsaXN0IGFsbCB0aGUgc291cmNl
cyBvZiB0aGlzIGNvbnN0cmFpbnQuDQo+IA0KPiAtLQ0KPiB2aXJlc2gNCg==
