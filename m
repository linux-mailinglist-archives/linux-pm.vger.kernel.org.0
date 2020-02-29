Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D021C1744B7
	for <lists+linux-pm@lfdr.de>; Sat, 29 Feb 2020 04:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB2DhK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 22:37:10 -0500
Received: from mail-am6eur05on2055.outbound.protection.outlook.com ([40.107.22.55]:63072
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbgB2DhK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Feb 2020 22:37:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+5OonKfGMbe5YXEVuBqa4+NAZpOUBJ1T2huP3fCoGoJfgbtZGRzIQFf9HicHdbnXDrdnCnUfCFF1k+Hg7Z1ReTpr7qtyKGKUhd/pbJVjJdHzubqDD23Ye1HvLL0Is4lupnZRkRr2ysOaliFV9lt43e0VAwbAoDV9EzBer7UxEJuewCr7NURtQHk7RLHzxlOy2TsSI5SJEzTySC4Nqr4zz26w0YVFKpkvNI4bMkMHvbAX9sQTcLNpA+yvZMgaJc1j0QAw8DnZtloXNag77xn6uI+JSAGKRjcuV4tldu2zVetDwj0YwHh8ejWFdPRoxPnyvfFoPsY+yon8oM6/glE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HiP7wU4u+cSKZ4bUyp4/UgGO9XUeOqbcw7XBSvWpTk=;
 b=WnZXgYHGzc4HI7klvhgU/AKOJDk/NxZkxmt3Lz56+Pc+x/z6BQRtOzwhuptYE/Ud/x6iSmzoB9yuljwNtLaRK3TsIDRzBFPN4X2x14Zz63djqRtzK60o882AiWg3VmVFfV+hwVBKvnf7OZuWZHxm7RfgWBKEaxwFSYLa8WGSP9o8ygFWenz5u3NlISMkOXp3lib4Ds4+NhAAO7O73CYZ4cy9xO0Zne8pbb4hiEkOcORk6TI8FVmcLdNmwM2cV/djTDWyEgZ82hJN/I2pESZ1NaQ+xTGgYQ5d/hxiPY1ZWdB4/i59WrSmkx1/inrSbWmKBbHHR/y7HWQlIPmTR8CGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HiP7wU4u+cSKZ4bUyp4/UgGO9XUeOqbcw7XBSvWpTk=;
 b=eNe6W9/D6alvjRpT6ZJTmsh3xAjm2KARC4mHOIHLpdBmKGV7mqcUsVkpthxBSipVc01TZFPieeUmP+7F7bw90fkUFr0ktGq2/rafZIOfPEPbxCe1he3trhW7VVjadFMIMWN0sKaPbHPtoTnkhg6EHP2DNAc5zOHETKWrPQaNHXk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Sat, 29 Feb 2020 03:37:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2772.018; Sat, 29 Feb 2020
 03:37:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH RESEND 2/4] thermal: imx8mm: Add support for i.MX8MM
 thermal monitoring unit
Thread-Topic: [PATCH RESEND 2/4] thermal: imx8mm: Add support for i.MX8MM
 thermal monitoring unit
Thread-Index: AQHV58cPTXVn3qoaD0ekPBUouxzRXKgu7K0AgADqiSCAAIztAIABLqNA
Date:   Sat, 29 Feb 2020 03:37:02 +0000
Message-ID: <DB3PR0402MB39160BF1E6FDF0990E462708F5E90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1582186646-22096-1-git-send-email-Anson.Huang@nxp.com>
 <1582186646-22096-2-git-send-email-Anson.Huang@nxp.com>
 <f8dfdb39-14e5-4ee2-927a-fecbcd66c71e@linaro.org>
 <DB3PR0402MB39163AE75E59613AB6B21575F5E80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <07994b0e-9735-2f3e-e5c3-a57e2344dbc0@linaro.org>
In-Reply-To: <07994b0e-9735-2f3e-e5c3-a57e2344dbc0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2288d29c-009e-425c-a6a1-08d7bcc8a3c0
x-ms-traffictypediagnostic: DB3PR0402MB3899:|DB3PR0402MB3899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3899D50190BD9B07E194F66AF5E90@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(7416002)(9686003)(6506007)(110136005)(53546011)(71200400001)(55016002)(26005)(186003)(7696005)(33656002)(52536014)(478600001)(8676002)(44832011)(86362001)(8936002)(316002)(5660300002)(4326008)(66556008)(66946007)(66446008)(64756008)(2906002)(81156014)(66476007)(81166006)(76116006)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVkouESgX8d312YHm8PqbzCk48SVZHhSTYVEhqVRcHM3P6hBoUDISW0CYV2QpMDLGVD/+bKxI1l650iSp0+lV4ta3tv5x2iAt7PGtkVDTzmCgZAk0sto+oL2prINPPw00Om3jL8EGfsfAl134ScZ/V9akLw7Is8vlr//pLuYyUZFVO6DSAgzdFrACeOe3C0AeirOUe4ctJqB75YF7HaRvMi6ir7Hfeeh/8XnAsxIQ6aIzWwBeBOjOMsZitZ8BEqaGwSVMDB4Pccy3/1ntzG3fAE0I6cJHGdSeW0tl5IRYw0f7S2RGBgbYEDosrhDIESK0m23YJoxJLyiz4/fMAUBrLygYGPLQeVgg2JFfCqyza8UJ26xF5hjPYpXit9zYcEp6E3Gl2GxggpHsQI/b+jkyKBeYMdskSk0ZsXnQ+lnc3SaRaShSKAKcsSFRbMnC9nh3NDgugg96WuCU5wlUdtJrrWML7Dwrl3y9NS29T2q0ogHGUE+4CsZhOzxlQ5mLB19GJI9FixVM4N9qf4p/gz5Ow==
x-ms-exchange-antispam-messagedata: KWvdbkvmNm4epppZmMiY22IDli0y43WrWM9yNPPEvuFOBw4pi3lal/om4HDUBzLNwiG4jNpZIG2rg64Jz5QKUfDBnMKUtbwWq6XQBepzgZIK9/BEGRGQUCPehx1LuGdeQyn1pVBDcqEL8jZjY+8/Mw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2288d29c-009e-425c-a6a1-08d7bcc8a3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 03:37:02.1498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MN/lWzRFPSBRQCFqYEZ+r/eDZUh5EDKKCpAu3cz1lXqNXFB2JjguM/YJd5eGnWq/JmmiCe3lE4fVEINWxvPFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIDIvNF0gdGhlcm1hbDog
aW14OG1tOiBBZGQgc3VwcG9ydCBmb3INCj4gaS5NWDhNTSB0aGVybWFsIG1vbml0b3JpbmcgdW5p
dA0KPiANCj4gT24gMjgvMDIvMjAyMCAwMjoxMiwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gSGks
IERhbmllbA0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPj4+ICtzdGF0aWMgaW50IHRtdV9nZXRfdGVt
cCh2b2lkICpkYXRhLCBpbnQgKnRlbXApIHsNCj4gPj4+ICsJc3RydWN0IGlteDhtbV90bXUgKnRt
dSA9IGRhdGE7DQo+ID4+PiArCXUzMiB2YWw7DQo+ID4+PiArDQo+ID4+PiArCS8qIHRoZSB0ZW1w
IHNlbnNvciBuZWVkIGFib3V0IDFtcyB0byBmaW5pc2ggdGhlIG1lYXN1cmVtZW50ICovDQo+ID4+
PiArCXVzbGVlcF9yYW5nZSgxMDAwLCAyMDAwKTsNCj4gPj4NCj4gPj4gV2h5IGRvIHlvIG5lZWQg
dG8gZm9yY2UgYSBkZWxheSBoZXJlPyBJZiB0aGUgc2Vuc29yIGNhbiBub3QgYmUgcmVhZA0KPiA+
PiBtb3JlIHRoYW4gb25lIHRpbWUgZXZlcnkgMW1zLCB0aGVuIHNwZWNpZnkgdGhhdCBpbiB0aGUg
RFQgc3dpdGNoaW5nDQo+ID4+IHRoZSBwb2xsaW5nIHRvIHRoZSByaWdodCB2YWx1ZSwgbm8/DQo+
ID4NCj4gPiBUaGUgcG9sbGluZyB0aW1lKDIgc2Vjb25kcykgaXMgT0sgZm9yIHRoaXMgY2FzZSwg
YWRkaW5nIHRoaXMgc2xlZXAgaXMNCj4gPiB0byBwcmV2ZW50IHVzZXIgZnJvbSByZWFkaW5nIHRl
bXBlcmF0dXJlIGZyb20gc3lzZnMgaW50ZXJmYWNlIHZlcnkNCj4gZnJlcXVlbnRseSBsaWtlIGxl
c3MgdGhhbiAxbXMsIGRvZXMgaXQgbWFrZSBzZW5zZT8NCj4gDQo+IE5vdCByZWFsbHksIHdlbGwg
ZXhjZXB0IGlmIHRoZSB1c2VyIGlzIGFibGUgdG8gcHJlc3MgdGhlIGtleXMgaW4gbGVzcyB0aGFu
IDFtcyA6KQ0KPiANCj4gSWYgdGhlIHVzZXJzcGFjZSB3cml0ZXMgYSBwb2xsaW5nIHNjcmlwdCBy
ZWFkaW5nIHRoZSB0ZW1wZXJhdHVyZSBpbiBhIGJ1c3kgbG9vcCwNCj4gdGhlcmUgaXMgbm90aGlu
ZyB3ZSBjYW4gZG8gYWdhaW5zdCBzaWxseSBwcm9ncmFtbWluZyA6Lw0KDQpNYWtlIHNlbnNl8J+Y
ig0KDQo+IA0KPiBIb3dldmVyLCBpdCBjb3VsZCBpbnRlcmVzdGluZyB0byBhZGQgYSA8bWluIHBv
bGxpbmcgaW50ZXJ2YWw+IGluIHRoZSB0aGVybWFsDQo+IHN0cnVjdHVyZSBhbmQgaGFuZGxlIHRo
YXQgZnJvbSB0aGUgY29yZSBmcmFtZXdvcmsgYnkgY2FjaGluZyB0aGUgbGFzdCB2YWx1ZQ0KPiBh
bmQgcmV0dXJuIGl0IGluIGNhc2UgZ2V0X3RlbXAgaXMgY2FsbGVkIHRvbyBmYXN0Lg0KDQpPSywg
SSB3aWxsIHJlc2VuZCBWMiBwYXRjaCBzZXQgdG8gcmVtb3ZlIHRoZSBzbGVlcCBpbiB0aGlzIGRy
aXZlciBhbmQgc2VlIGlmIHRoZXJlIGlzDQpyZWFsIGlzc3VlIG9mIHN1Y2ggY29ybmVyIGNhc2Us
IGlmIGFueSBpc3N1ZSBvYnNlcnZlZCwgSSB3aWxsIHRyeSBzdW1taXQgYSBwYXRjaCB0byBjb3Jl
DQpmcmFtZXdvcmsgbGF0ZXIuDQoNClRoYW5rcywNCkFuc29uDQoNCg==
