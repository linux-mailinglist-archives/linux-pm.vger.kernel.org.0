Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9038168EC9
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 13:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgBVMT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Feb 2020 07:19:28 -0500
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:41756
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbgBVMT2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 22 Feb 2020 07:19:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKwMk+A6UsMEf1E5ezoNYBVTzfCNaOAX7xu78j30ZoUpgoYBElzoehiuwk4sXOIw+Yuhl2BrlXgRi8WotPnw1uIFM14KJ6B1G2YgwXq0NKYlCgjO14d6NRxZT/jXqO60kjMk3jNXWhK+75WCwLYYvRd9fXHGKU0e2W6T7S5Jk9V7PEtap3qPfHoAYviZjxGe3jOe+aeSbue1eqUGuynNE7gUvBwG4+GU/zqc8uXtKrXcO3EYpx2deNXTZhMeMlUrB1bYQC4noV2K0e2iJvGVjJvHdMs24/TAJobzy1ykD2q3Fqij7QDfSsU9MFIGuLzHmEbaJ6ivGqM7nnZzE8emrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9QEeRmRoR9QNocwVCLdB4WwrRXf1LxGi1jk+68svXo=;
 b=CiwxwZRgpnOIuJiT8naDmL0sdOp+U0wA9dmP2eUMr6PoLVtWr1oFjKwIFVN0Loc58iKsaUuSuCr6hq0bMtP6AczP/GQDvQ+rHd0bVMZ9xKU533AmqnFmwq8eT3FhemrAz2T7NRBA3NculW9YdPrTsPHvWZ+k55sKBANsC7A6po9tggMt0xEuqg34LbJS/fcVDdoeAmBUUjsXZPoTrZOUkbypf8pa0X4ZjfavJXrONAWVOnHsMT3YqoD+81AHQk8gY9AAUmtvIZD8D28JCq4+O8x6bPUG+vNat5jLlMG7xNl/nv7EoQkN5049mcmdqmU9d1EfGWys70lg7s5gxkL3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9QEeRmRoR9QNocwVCLdB4WwrRXf1LxGi1jk+68svXo=;
 b=KmdW+Ay4sqrm5L8wyv9DlMnjmlsT+Iv4wZsAkcQjdRVFQQ2w6Uv1YNx0ROUII70JkKT6txGt53X2HVKpjmeALWMKvyWiX8bKF2+yYAWiH24IcDW/6IiVj+foJJtTY4tD8tp4wfXamYJesRDpNbWpmsd9OBYL8rTQ/5KjfJWqq1M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.34; Sat, 22 Feb 2020 12:19:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 12:19:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V15 RESEND 5/5] arm64: dts: imx: add i.MX8QXP thermal
 support
Thread-Topic: [PATCH V15 RESEND 5/5] arm64: dts: imx: add i.MX8QXP thermal
 support
Thread-Index: AQHV54t0EBaEeunlYUezwg4Plo/Olqgln+YAgACz3LCAAIcQgIAASMDw
Date:   Sat, 22 Feb 2020 12:19:17 +0000
Message-ID: <DB3PR0402MB3916080CD147ACAD4A9D1621F5EE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-5-git-send-email-Anson.Huang@nxp.com>
 <20200221130448.GC10516@linaro.org>
 <DB3PR0402MB39163B3EC2B6077C51D821DEF5120@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <59784965-dba6-5878-68fa-5657f3e5f02e@linaro.org>
In-Reply-To: <59784965-dba6-5878-68fa-5657f3e5f02e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [220.161.57.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16424ddd-0314-4d52-0c79-08d7b791703f
x-ms-traffictypediagnostic: DB3PR0402MB3946:|DB3PR0402MB3946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3946040C76E93553E4044EEEF5EE0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(189003)(6506007)(66446008)(66946007)(26005)(66476007)(44832011)(76116006)(52536014)(66556008)(4326008)(2906002)(64756008)(186003)(45080400002)(33656002)(53546011)(86362001)(8936002)(7696005)(71200400001)(966005)(5660300002)(54906003)(55016002)(7416002)(6916009)(8676002)(316002)(478600001)(9686003)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +aKQ5b+2RB/lj7b9chNHqqPNO+0k2rm47r4aQxc1qKHLJcS9ea9gLj676p7XyKMGliJnQDX3V6h0ERtZou5/N00UwkjKZmZCdfWWEBvZsv72eiVKP+3qS0ICv67pNVPHow7ybvpuyPzVpBjb8IV74bq7lKvcUFTsHvU2UkAgibtkXuzlUp8FPy06exW+zQVn6W6hULC5KzJUqYr3Fjcwh+C0KnPgax/F+leN1XG5NnhWKRRnQtxR0TvfRxEDCR63X3z919u0/euz8LFsyjVgDXpSzwnIHMqLvK5ON33X2xGmqKs6aPgqM2phcgOA3h1STeBZMOGbZXp6bFGpjl6fZ/1Lpplp+vkAhRcDP4aj6rPg44OF3A8M1QPsAXqiMtjndGfZanRZYWWK751bJXpH537ejO/WFzWbjpO8ZDZn2GlYpglRZWXglUlfld4B2v4R40pb9W+wtys3h4KCORnbzhavaGLhqmk5qVy9W74vmo4Ase+6Uuqpt9xTpgt7oCGuSC59PmoAPelEmp0tU5SZR9UBqY+tKI12hcfQFDXpQp6gU3gQzjqAXblIp7Xl7NjV9UaWeRlefRbKgBg/1wDFSXd0IfyGu9kG9FhAw9jO9n9myRb0mPAlryFw/KAZLHEI
x-ms-exchange-antispam-messagedata: dIvJYft6EFXnj9PqH6BYogvwy3ugdh2PIeuVh+FaRMTmwWfv3anIDDhP5hV7pz//0N9rlDwUUnOA2Phmw4jgvGChjH+MxmdqJRysLQuY9HmMK2d60dm1fxltRMW0Wb9loSEBjk3IeuWvowZusgH7Yg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16424ddd-0314-4d52-0c79-08d7b791703f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 12:19:17.4057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwpJQaqOgZ1SjB3/2iGJUL7OpJrCfK+V4+F0D4Zl2VxTXyw01TUzMv4NNC7XHGECCd2SClU344V+95r2yDcwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjE1IFJFU0VORCA1LzVdIGFybTY0
OiBkdHM6IGlteDogYWRkIGkuTVg4UVhQIHRoZXJtYWwNCj4gc3VwcG9ydA0KPiANCj4gT24gMjIv
MDIvMjAyMCAwMDo1MywgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gSGksIERhbmllbA0KPiA+DQo+
IA0KPiBbIC4uLiBdDQo+IA0KPiA+Pj4gKw0KPiA+Pj4gKwl0aGVybWFsX3pvbmVzOiB0aGVybWFs
LXpvbmVzIHsNCj4gPj4+ICsJCWNwdS10aGVybWFsMCB7DQo+ID4+PiArCQkJcG9sbGluZy1kZWxh
eS1wYXNzaXZlID0gPDI1MD47DQo+ID4+PiArCQkJcG9sbGluZy1kZWxheSA9IDwyMDAwPjsNCj4g
Pj4+ICsJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRzZW5zIElNWF9TQ19SX1NZU1RFTT47DQo+ID4+
PiArCQkJdHJpcHMgew0KPiA+Pj4gKwkJCQljcHVfYWxlcnQwOiB0cmlwMCB7DQo+ID4+PiArCQkJ
CQl0ZW1wZXJhdHVyZSA9IDwxMDcwMDA+Ow0KPiA+Pj4gKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAw
PjsNCj4gPj4+ICsJCQkJCXR5cGUgPSAicGFzc2l2ZSI7DQo+ID4+PiArCQkJCX07DQo+ID4+DQo+
ID4+IE1heSBiZSB5b3UgY2FuIGFkZCBhICdob3QnIHRyaXAgcG9pbnQgYmVmb3JlICdjcml0aWNh
bCcgZm9yIGZ1dHVyZQ0KPiA+PiB1c2UgYmVmb3JlIHJlYWNoaW5nIHRoZSBlbWVyZ2VuY3kgc2h1
dGRvd24uDQo+ID4NCj4gPiBUaGUgJ3Bhc3NpdmUnIHRyaXAgaXMgYWN0dWFsbHkgdGhlICdob3Qn
IHRyaXAgcG9pbnQgeW91IG1lbnRpb25lZCwgYW5kDQo+ID4gSSBoYXZlIGNvbWJpbmVkIGl0IHRv
IGJlbG93IGNvb2xpbmcgbWFwIHdoaWNoIHdpbGwgdGhyb3R0bGUgY3B1LWZyZXEgd2hlbg0KPiBw
YXNzaXZlIChob3QpIHBvaW50IGlzIHJlYWNoZWQuDQo+ID4gV2UgYWxsIHVzZSAncGFzc2l2ZScg
YXMgJ2hvdCcgYWxhcm0gYW5kIHRyaWdnZXIgY3B1LWZyZXEgdGhyb3R0bGUgb24gaS5NWA0KPiBw
bGF0Zm9ybXMuDQo+IA0KPiBTb3JyeSwgSSdtIG5vdCBzdXJlIHRvIGdldCB0aGUgcG9pbnQuIEEg
J2hvdCcgdHJpcCBwb2ludCBpcyBub3QgYSAncGFzc2l2ZScgdHJpcA0KPiBwb2ludC4gVGhlICdo
b3QnIHRyaXAgcG9pbnQgaXMgYSBjcml0aWNhbCB0ZW1wZXJhdHVyZSBhbmQgYSBub3RpZmljYXRp
b24gaXMgcmFpc2VkDQo+IFsxXVsyXS4NCj4gDQo+IEl0IGlzIHRoZSBsYXN0IGNoYW5jZSBmb3Ig
dGhlIHN5c3RlbSB0byBkbyBzb21ldGhpbmcgYmVmb3JlIHRoZSBuZXh0IHRyaXAgcG9pbnQNCj4g
J2NyaXRpY2FsJyBpcyByZWFjaGVkIGFuZCB3aGVyZSBhbiBlbWVyZ2VuY3kgc2h1dGRvd24gaXMg
ZG9uZS4NCj4gDQo+IFRoZSAncGFzc2l2ZScgdHJpcCBwb2ludCBpcyB0aGUgdGFyZ2V0IHRlbXBl
cmF0dXJlIGZvciBtaXRpZ2F0aW9uIGluIGEgbm9ybWFsDQo+IHNpdHVhdGlvbiB3aGVuIHRoZSBz
eXN0ZW0gaXMgbG9hZGVkLg0KDQpBaCwgbm93IEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50LCBhcyBh
bGwgaS5NWCBTb0NzIE9OTFkgc3VwcG9ydCBwYXNzaXZlIGFuZCBjcml0aWNhbA0KcG9pbnQsIGFu
ZCBuZXZlciBzdXBwb3J0IHRoZSBub3RpZmljYXRpb24gb2YgaG90IHRyaXAgcG9pbnQsIHNvIEkg
dGhpbmsgaXQgc2hvdWxkIGJlIE9LDQp0byBsZWF2ZSBpLk1YOFFYUCBzYW1lIGFzIG90aGVyIGku
TVggU29DcywgaWYgd2UgcGxhbiB0byBzdXBwb3J0IGhvdCB0cmlwIHBvaW50IG5vdGlmaWNhdGlv
biwNCkkgd2lsbCBjdXQgYW5vdGhlciBwYXRjaCBmb3IgYWxsIGkuTVggU29DcywgZG9lcyBpdCBt
YWtlIHNlbnNlIHRvIHlvdT8gSWYgeWVzLCBwbGVhc2UgaGVscA0KcmV2aWV3IHRoZSBWMTYgcGF0
Y2ggc2V0IEkgc2VudCBvdXQuDQoNCnRoYW5rcyBhZ2FpbiBmb3IgcmV2aWV3LA0KQW5zb24NCg0K
DQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0Lmtlcg0KPiBuZWwub3JnJTJGcHViJTJGc2NtJTJG
bGludXglMkZrZXJuZWwlMkZnaXQlMkZ0b3J2YWxkcyUyRmxpbnV4LmdpdCUyRg0KPiB0cmVlJTJG
ZHJpdmVycyUyRnRoZXJtYWwlMkZ0aGVybWFsX2NvcmUuYyUyM24yODgmYW1wO2RhdGE9MDIlN0Mw
MQ0KPiAlN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0MyYTE0MjJjM2NiMGY0NmMzYjEzMzA4ZDdi
NzZjMTk4YyU3Qw0KPiA2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdD
NjM3MTc5NTQ3MjIzMzYwMDUxJmENCj4gbXA7c2RhdGE9ZlJtc0ZiQ1ZGZHYzVndGRXFwMXNTSHh0
MnJ1Y1EzM3lZbm5hUEU1Z3MxZyUzRCZhbXA7cmVzDQo+IGVydmVkPTANCj4gWzJdDQo+IGh0dHBz
Oi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmdpdC5rZXINCj4gbmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVsJTJGZ2l0
JTJGdG9ydmFsZHMlMkZsaW51eC5naXQlMkYNCj4gdHJlZSUyRmRyaXZlcnMlMkZ0aGVybWFsJTJG
dGhlcm1hbF9jb3JlLmMlMjNuNDIwJmFtcDtkYXRhPTAyJTdDMDENCj4gJTdDYW5zb24uaHVhbmcl
NDBueHAuY29tJTdDMmExNDIyYzNjYjBmNDZjM2IxMzMwOGQ3Yjc2YzE5OGMlN0MNCj4gNjg2ZWEx
ZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzE3OTU0NzIyMzM2MDA1MSZh
DQo+IG1wO3NkYXRhPVFFaXdRY0w4RlpLZzZSczd5OWg5WEt2RmYlMkZsVmVvMjBNd0tUaXFVYk13
QSUzRCZhbQ0KPiBwO3Jlc2VydmVkPTANCj4gDQo+IA0KPiANCj4gDQo+IC0tDQo+IA0KPiA8aHR0
cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0El
MkYlMkZ3d3cuDQo+IGxpbmFyby5vcmclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5n
JTQwbnhwLmNvbSU3QzJhMTQyMg0KPiBjM2NiMGY0NmMzYjEzMzA4ZDdiNzZjMTk4YyU3QzY4NmVh
MWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDDQo+IDAlN0MwJTdDNjM3MTc5NTQ3MjIzMzYw
MDUxJmFtcDtzZGF0YT14VDJVdE5ISEE4MjZhemlWMWFVbVBYcGENCj4gQm5xN2RCbSUyRkpQRkc0
UzIlMkY1cVElM0QmYW1wO3Jlc2VydmVkPTA+IExpbmFyby5vcmcg4pSCIE9wZW4NCj4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzoNCj4gPGh0dHBzOi8v
ZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJG
d3d3Lg0KPiBmYWNlYm9vay5jb20lMkZwYWdlcyUyRkxpbmFybyZhbXA7ZGF0YT0wMiU3QzAxJTdD
YW5zb24uaHVhbmclNA0KPiAwbnhwLmNvbSU3QzJhMTQyMmMzY2IwZjQ2YzNiMTMzMDhkN2I3NmMx
OThjJTdDNjg2ZWExZDNiYzJiNGM2ZmE5DQo+IDJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzcx
Nzk1NDcyMjMzNjAwNTEmYW1wO3NkYXRhPWVTcjg5am0yDQo+IFF4enBpMmJYJTJCTiUyRmNoaXpy
a0YzNzJ5cHlMZ3Y1JTJCdUk4MkljJTNEJmFtcDtyZXNlcnZlZD0wPg0KPiBGYWNlYm9vayB8DQo+
IDxodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cCUzQSUyRiUyRnR3aXR0ZQ0KPiByLmNvbSUyRiUyMyElMkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIl
N0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmMNCj4gb20lN0MyYTE0MjJjM2NiMGY0NmMzYjEzMzA4
ZDdiNzZjMTk4YyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+IGM1YzMwMTYzNSU3QzAlN0Mw
JTdDNjM3MTc5NTQ3MjIzMzYwMDUxJmFtcDtzZGF0YT1jUnlkUCUyRkpwZnVEDQo+IHVaRlhVaXZr
NkY0QXQxbGMlMkZzT0hkU3pERG5EdERPdWclM0QmYW1wO3Jlc2VydmVkPTA+IFR3aXR0ZXIgfA0K
PiA8aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHAlM0ElMkYlMkZ3d3cuDQo+IGxpbmFyby5vcmclMkZsaW5hcm8tDQo+IGJsb2clMkYmYW1wO2Rh
dGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmNvbSU3QzJhMTQyMmMzY2IwDQo+IGY0NmMz
YjEzMzA4ZDdiNzZjMTk4YyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzANCj4gJTdDNjM3MTc5NTQ3MjIzMzYwMDUxJmFtcDtzZGF0YT13bHdsYnJMR1h0JTJGZHB1dncy
eHBDVG9pQUl3ZXVkDQo+IFFEdkxjOHgwa2dKT29RJTNEJmFtcDtyZXNlcnZlZD0wPiBCbG9nDQoN
Cg==
