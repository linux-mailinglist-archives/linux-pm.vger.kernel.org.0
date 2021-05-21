Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D08638BCD7
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 05:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhEUDGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 23:06:15 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:16256
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238456AbhEUDGO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 May 2021 23:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqGAhJpqZTZVJd6QHjXjdXp82B9ivjaSAwfz0mnZf+/ZV+ZRpDZOu28AjkF+Y+TnPg8t7VWx46NWfByvV+6a9ZhH9zl2getr9larHiXcwIJWT6/Vm+Z00rnMqGV0VqOMKr1MVfkD5NgvT3kLgOOJboB+NAvYOOU/iCy9PvO3j+lEuY4j03OGByA6tc9hAubD9YoXMhOwFCyBForVkC9pz6f3C3etmeaUBFmivXPgoa1UzSQ/4nzyr4kFP/rwxUS2I7bD5rgo6DD8Bkwy5XwECU2ftYhxYC7O1SBe7YGD/GKKw8TRYR2OwbXp8Tk/pIGl7txFC43sMTWMBEAmB1JiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E12HXHYf4cKv1KRjEFVi/BUsac+27bI3b37aQRbo9k=;
 b=JmsBEUHF76kQhrs9EPWdZpefxeCEa6Ibtp9OEy5yqOGdlHksT4J3d6oV2nPMkqbW6/KqHhenpSmty4bAJXEDKCbol44kbwBKyCVRkota6XKuIo6ZZ6tiuWarsMbAR8mZeLELHmIZF/OBlhi+H1UD7yr0tt40Ih8i1vpV5PXh4y3RIi1jNhA40AEP/Rv5vniZqtWHKIIkomKP2KLTJ21Uc/4elV/pazfFT6ugD0nYegYB/bkapMVPe+g7rPx9LZxB+HthIkT2DxcTgEAiZcmZs5eDHllUIWX9GaM8/4PsQpbiW2Uv7Y7PQUPhY81yZcOtnDrowaK+Lazbx90LDK8xFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E12HXHYf4cKv1KRjEFVi/BUsac+27bI3b37aQRbo9k=;
 b=FQrnlnqhfxHWy/AdaBD5V+p/tdeumRtFhXk0Ms4uwpuo4fvav+W8445nYyfgAIVxmQYVvGqSxPmkkSt1HofxyyCM1BlnZp8ru89PO12+1+c7pXRx3lwUi9Cg/4jrZ4nnAPx3NUD+Myaw8JkU4HbX2D90G7wlhULqc13bdJUyLRk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 03:04:48 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 03:04:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH 2/2] devfreq: imx8m-ddrc: de-select
 DEVFREQ_GOV_SIMPLE_ONDEMAND
Thread-Topic: [PATCH 2/2] devfreq: imx8m-ddrc: de-select
 DEVFREQ_GOV_SIMPLE_ONDEMAND
Thread-Index: AQHXTH2HGsiAh6hOh0WHgWLbFPSGcqrrsmKAgAGQpdA=
Date:   Fri, 21 May 2021 03:04:48 +0000
Message-ID: <AM6PR04MB4966B0755DA727E1B477C25780299@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20210519070545.1728197-1-aisheng.dong@nxp.com>
        <CGME20210519070650epcas1p1b4070dd9636125d708803b4cd94e5dbc@epcas1p1.samsung.com>
        <20210519070545.1728197-2-aisheng.dong@nxp.com>
 <a6f61bf1-b1c3-692a-608c-fe5486a77e52@samsung.com>
In-Reply-To: <a6f61bf1-b1c3-692a-608c-fe5486a77e52@samsung.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5efd5678-f06e-489f-673a-08d91c0531e8
x-ms-traffictypediagnostic: AS8PR04MB7878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB787817D78604246FDAB8C4DD80299@AS8PR04MB7878.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UTrMFM89s2NkBCIURA6/SKk6N8RtSOXuEnu6aJSR/tb53AkfWZwZzJnncismxbwgFyJiTZI7eDLIK+2zwQv9IvPDJeEDxI5aUrRN4wR3iLw9ceviYDPEP19syLe4rQ44cD5Gp+GXcdbF6RVCMbZYZk5K0LpBooy8Njl9lRq5MnS+076avP4OE+5HkWttl56iryKmy4c7zYxM+2nDR54EM8nKlTRIDPyxzj2Y0Z/bj4A/rP5tnTgpqqHzO/R7SWKZyhIqvSgnUVGkRj3NSu1/JtUHWI/vt2txablKfpF4E3KccmIVZ1Hg7xH8zKQdK0MtEU/WgcQBC3rIeINYNagMyDJPprLPEW+R8lwIXBd2iluZ8G78yatxOLJLuv+jzJYY6pNmD/PGL2BYwEN2Sb4XpYOK2VwZpWwknieUiOm9Y4smCOdwhhOW/k+/mqWjVor4eaVIr8tKA1qDlhX9UAPmtFSQ0qOdOQoNqBuU+lTOZ8o0GzZ9suPbKmz5rV6u/ctyOJ1UV6GTo8HEpkFi8BgVgGWsSqevFe9C5ChrOx3Ncgxx4t1/2nsqeu8YTmkmo8OD2wiTgZygHZL5xc9AyaGOAjGEI4RRxIxRnxgNLs3wJnqIFqtIlOHNJ+TaDLdm5iuHiHZvRFpx3CyJV/vKXiVE+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(6506007)(110136005)(53546011)(478600001)(8936002)(316002)(9686003)(33656002)(54906003)(76116006)(52536014)(122000001)(71200400001)(7696005)(86362001)(38100700002)(66476007)(26005)(4326008)(55016002)(66946007)(44832011)(66556008)(64756008)(5660300002)(186003)(8676002)(66446008)(2906002)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QlNzUmRudTVaSkJjUXpDQlZTSDJkZ2lXRC9RdkFmZ0k5UUd5MGFMd0RGcVpE?=
 =?utf-8?B?WUZlOUcrREVlR1BzaFpTbUh0YndGV0oycndxSkdNeFRNcWJGQlVJbk5XSDZL?=
 =?utf-8?B?dDlKR2tKdmhTNmlvbXNuUVRSQWdVRVp1c3MwTzNKUVhSTzF1bDNkV2k2U2Nv?=
 =?utf-8?B?MHRvcVdYYXVBeDdES0diVUhrVkF4SFI5VldUelA1QitTZkdia0d1Ly9SRFU1?=
 =?utf-8?B?bTM3aG1TRmNUZ1pSRU1TV05IYUpMZUozQXlTc1REVlhXeWYrNXIxQitJUXNW?=
 =?utf-8?B?WnFKUG9pYXVrR0lWSWM2bFR2NktXWHlWcWo1QURjZnErUEM4NUJsVGI1blc1?=
 =?utf-8?B?T0FMWWVZN2VWVmtxSjFnZ2FDVlRnU2h1QnVZZml1bkhQVXkzazVnbzhZMS84?=
 =?utf-8?B?NSszcjMrUlZ4WmZSRW9SVytxT2pOaXBSdXJSeGIzd3JWeE1rWkVDOS9HWE10?=
 =?utf-8?B?bW9US3hmUnZBdE5ZZUtydUFTRlBJSnhMNGg1VE1XRS9yZ2xOTVZlUTRRRXVt?=
 =?utf-8?B?YjU1QS9CcTFBNGF5Z01ObXFpOVJuaUdya3hxc3hVczN3aktDRU1Hd3Z1R01M?=
 =?utf-8?B?Q0FZNEd1TzlHdkVTc01QSUZUZkloZ1UxSkFCUUFmTW1DYjZQRCtXcHNrOGgw?=
 =?utf-8?B?YkxFWTByQVVCcnZ3K2ZWYlZVeUcycnc5b1FkQU01RW1PaGV2STJwMmlUZTRo?=
 =?utf-8?B?bzN3UlpOMGZtbHdxRXBNcTcvQlJCRGxWdDJVbU9DcjJERXEwUkp2WmZYYW9n?=
 =?utf-8?B?ZDZuYlBWdHRZOHpsWW0vWkhSYlhUYlE5WHRndEwxWWhCVm5iLzk0MFJ0c3Bz?=
 =?utf-8?B?c05UaTNWYmVKaXMzUDd5T2UrNmY4ZFRJOEtLVUc0QnZVeU9rRU9USGZUMUVK?=
 =?utf-8?B?TXBqUS9KZGcrUmFaZlRDTDdscmpRdVBkUVUrb1RWdGJzY3AwV1pVQ0hWN05l?=
 =?utf-8?B?d1UreVZXWVVIa09Va3ZSbnV5Z2JsUnNhYlQ5NVJNNTd0a0M5K1lPUkRFYlBV?=
 =?utf-8?B?elkvZlVkNy8rT05waXdzUUg5VXphR1R6eTJUZTdJUDQ4SjN6Y1drUkJtUDEw?=
 =?utf-8?B?c3ROUndoRzRNYUwrbTRsZ2NNZUF0c1dnVmI3RmlHblJxcTE0R3ZOL3lxaGVn?=
 =?utf-8?B?b3lNOG1aWkM0R3p6b2lRQ2VrRmlxVFBYVTdUU0p1dWx4c3pjRDZRc3lpVkty?=
 =?utf-8?B?YUQ2SC9iSTJsRTkyWnBDMFBmMmpYZmNCWWZVeGNKdWIranVCamgvck5NbXla?=
 =?utf-8?B?MW5BcmVKRjBFYXZPMXFzSmlJNEF2Sks2aVA0aDFoOEt5ejN2UUhyQis3Z05h?=
 =?utf-8?B?VkpYUUEyMnEzYTBxMWNKWm1VZVFubmVoTDU3SGRNRGsrUWhRd05JdFFWMlVB?=
 =?utf-8?B?MFdPK3BGRkV0dStuMGFnVGRTaEFJRjE2QzY1c1dLZ1g4Vm9vSHZ0OWxLWTFh?=
 =?utf-8?B?U2NIR0VyT0RQWEQ5SEtsOVYrTVJITkZQUlNlWW4vaGVsTTZ3Q0crVDVBUllO?=
 =?utf-8?B?NnV6YUdNMFZPeE0zalZQZU1Fd1hWUkc3YVpxMFNPMVVxOTZHTGJOSW5mUnBi?=
 =?utf-8?B?TUhYVVNEU1dyVjQ5TVE2MG1pWGJjMXU0VWJwZTZYWGRTV3VIbnhYVVdxcUxW?=
 =?utf-8?B?MEkwZGg1ZVhSRm1lZEZzbFdFZzZrU09BWVVoOURuVnUyNG5SaXlvZ3BZR2pB?=
 =?utf-8?B?SGZmZitmaVlVdWl0L3gveFRIVm9SRmdxdUFmd1hIZ1dVcUlSYmtGU214REI4?=
 =?utf-8?Q?phASGlh3os2SQakbwI8c9opLuhblJbSt/g590tK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efd5678-f06e-489f-673a-08d91c0531e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 03:04:48.6205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D01BZEXFjTtHQ3uLGRpFDpLl2SEOyAETWwznT1dhO7Cf5Rf1mp1TscBUZfJ2zwYYaFvGvYEs0M966qtdW+IxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBGcm9tOiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIE1heSAyMCwgMjAyMSAxMToxMCBBTQ0KPiANCj4gT24gNS8xOS8yMSA0OjA1IFBNLCBE
b25nIEFpc2hlbmcgd3JvdGU6DQo+ID4gVGhlIGRyaXZlciBjYW4ndCBzdXBwb3J0IHNpbXBsZSBv
bmRlbWFuZCBnb3Zlcm5vciBkdWUgdG8gbWlzc2luZw0KPiA+IC5nZXRfZGV2X3N0YXR1cygpIGNh
cGFiaWxpdHkuDQo+ID4NCj4gPiBDYzogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9kZXZmcmVxL0tjb25maWcgfCAxIC0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2RldmZyZXEvS2NvbmZpZyBiL2RyaXZlcnMvZGV2ZnJlcS9LY29uZmlnIGluZGV4DQo+ID4gMjAz
NzNhODkzYjQ0Li5lODdkMDFjMGI3NmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9kZXZmcmVx
L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2RldmZyZXEvS2NvbmZpZw0KPiA+IEBAIC0xMDMs
NyArMTAzLDYgQEAgY29uZmlnIEFSTV9JTVg4TV9ERFJDX0RFVkZSRVENCj4gPiAgCXRyaXN0YXRl
ICJpLk1YOE0gRERSQyBERVZGUkVRIERyaXZlciINCj4gPiAgCWRlcGVuZHMgb24gKEFSQ0hfTVhD
ICYmIEhBVkVfQVJNX1NNQ0NDKSB8fCBcDQo+ID4gIAkJKENPTVBJTEVfVEVTVCAmJiBIQVZFX0FS
TV9TTUNDQykNCj4gPiAtCXNlbGVjdCBERVZGUkVRX0dPVl9TSU1QTEVfT05ERU1BTkQNCj4gPiAg
CXNlbGVjdCBERVZGUkVRX0dPVl9VU0VSU1BBQ0UNCj4gPiAgCWhlbHANCj4gPiAgCSAgVGhpcyBh
ZGRzIHRoZSBERVZGUkVRIGRyaXZlciBmb3IgdGhlIGkuTVg4TSBERFIgQ29udHJvbGxlci4gSXQN
Cj4gPiBhbGxvd3MNCj4gPg0KPiANCj4gTG9va3MgZ29vZCB0byBtZS4gQnV0LCBIb3cgYWJvdXQg
Y2hhbmdpbmcgdGhlIHBhdGNoIHRpdGxlIGFzIGZvbGxvd2luZz8NCj4gLSBQTSAvIGRldmZyZXE6
IGlteDhtLWRkcmM6IFJlbW92ZSBERVZGUkVRX0dPVl9TSU1QTEVfT05ERU1BTkQNCj4gZGVwZW5k
ZW5jeQ0KDQpZZXMsIGdvb2Qgc3VnZ2VzdGlvbi4gVGhhbmtzDQpJIHdpbGwgcmVzZW5kIHYyLg0K
DQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gDQo+IA0KPiAtLQ0KPiBCZXN0IFJlZ2FyZHMsDQo+IENo
YW53b28gQ2hvaQ0KPiBTYW1zdW5nIEVsZWN0cm9uaWNzDQo=
