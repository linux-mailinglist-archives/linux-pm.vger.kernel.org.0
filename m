Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451E51973E
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 05:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfEJDnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 23:43:42 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:23779
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbfEJDnl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 23:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXuh5Qj14BjpcB2GXfmw3N38LGxLDvlDFZae48cTw18=;
 b=LKLMS5fMD8qCyO1psjlQ8B96cvZwPmnpJP0TQfcMrBHHIJ4VpQloC8M/Fq7+gwfxsIZLmviwXmC41XQS96XKuAwDIzXfVfJTk8l7a3es9XJrvqAWl5/EKxSnP34exFuCDz3muMbA6qrnr+1t7rPISQZTcZWyCVO2UAlPcgfJ6yw=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB6239.eurprd04.prod.outlook.com (20.179.24.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 10 May 2019 03:40:57 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::3ca0:86a9:eb1:a8c2]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::3ca0:86a9:eb1:a8c2%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 03:40:57 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Subject: RE: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
Thread-Topic: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
Thread-Index: AQHU+XzmCgrzkjA8mUWSxshg4ZOzYKZjybwAgAADYUA=
Date:   Fri, 10 May 2019 03:40:57 +0000
Message-ID: <VI1PR04MB4333D24227603D1497BA3CB9F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190423022507.34969-1-andy.tang@nxp.com>
 <20190510031335.GD15856@dragon>
In-Reply-To: <20190510031335.GD15856@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afcfd707-12f0-4472-a763-08d6d4f94fe9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(49563074)(7193020);SRVR:VI1PR04MB6239;
x-ms-traffictypediagnostic: VI1PR04MB6239:
x-microsoft-antispam-prvs: <VI1PR04MB6239B2886C016E9F7BE3FB98F30C0@VI1PR04MB6239.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(13464003)(199004)(3846002)(229853002)(54906003)(25786009)(9686003)(7696005)(53936002)(86362001)(55016002)(64756008)(4326008)(186003)(256004)(2906002)(6916009)(26005)(7736002)(316002)(6246003)(66946007)(5660300002)(76116006)(73956011)(66616009)(66476007)(66556008)(66446008)(14454004)(52536014)(6116002)(99936001)(6436002)(102836004)(8676002)(53546011)(6506007)(74316002)(81156014)(305945005)(81166006)(446003)(33656002)(76176011)(11346002)(44832011)(66066001)(99286004)(68736007)(71190400001)(8936002)(71200400001)(478600001)(7416002)(476003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6239;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xqtXHAt1jcr0h3xj+Dl7bCEdX9N4uWboe9ifepFyRAUTUIJkaOOrAGAIKSKhcVnF2249jTPpI7SKtWwShLWedofk9BKSBHvIrihhcaNFEQZB6D+jxvcmXeID+eyZl57jS2HEtItU6tqnAIUwgZK2mz8EF4s4kqnAt9Ax53QfFNtvqF/EzegzayNdEcGakH9/bYTpZbLXtUXNUu52bvhm5/xAFFKl4mriBc5gAvVxGnSst2DlU2EoVRikGKX7NtePkw87qnzZpNuySo4f/6tV3fit7C+5dAsKVuN5HObaoO8jyJBd1Ht70AqolxmfTTfG/44f7OjHv7EEtQMUKeVznJ2fMBfI68fJVzRqkWyL7AHAMjmzA1ZMH0GgqAL0vsmldoOYwy+ypaDzDaPl/wlBRWx+Q0RwpGJJiqyB8ee3IOQ=
Content-Type: multipart/mixed;
        boundary="_002_VI1PR04MB4333D24227603D1497BA3CB9F30C0VI1PR04MB4333eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcfd707-12f0-4472-a763-08d6d4f94fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 03:40:57.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6239
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--_002_VI1PR04MB4333D24227603D1497BA3CB9F30C0VI1PR04MB4333eurp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTnE6jXUwjEwyNUgMTE6MTQNCj4gVG86IEFuZHkgVGFu
ZyA8YW5keS50YW5nQG54cC5jb20+DQo+IENjOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47
IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgcnVpLnpoYW5nQGludGVsLmNvbTsNCj4gZWR1
YmV6dmFsQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY2XSBhcm02NDog
ZHRzOiBsczEwODhhOiBhZGQgb25lIG1vcmUgdGhlcm1hbA0KPiB6b25lIG5vZGUNCj4gDQo+IENh
dXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gVHVlLCBBcHIgMjMsIDIwMTkgYXQgMTA6MjU6MDdB
TSArMDgwMCwgWXVhbnRpYW4gVGFuZyB3cm90ZToNCj4gPiBMczEwODhhIGhhcyAyIHRoZXJtYWwg
c2Vuc29ycywgY29yZSBjbHVzdGVyIGFuZCBTb0MgcGxhdGZvcm0uIENvcmUNCj4gPiBjbHVzdGVy
IHNlbnNvciBpcyB1c2VkIHRvIG1vbml0b3IgdGhlIHRlbXBlcmF0dXJlIG9mIGNvcmUgYW5kIFNv
Qw0KPiA+IHBsYXRmb3JtIGlzIGZvciBwbGF0Zm9ybS4gVGhlIGN1cnJlbnQgZHRzIG9ubHkgc3Vw
cG9ydCB0aGUgZmlyc3Qgc2Vuc29yLg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgc2Vjb25kIHNl
bnNvciBub2RlIHRvIGR0cyB0byBlbmFibGUgaXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
dWFudGlhbiBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiB2NjoNCj4gPiAg
ICAgICAgIC0gYWRkIGNvb2xpbmcgZGV2aWNlIG1hcCB0byBjcHUwLTcgaW4gcGxhdGZvcm0gbm9k
ZS4NCkkgbGlrZSB0byBleHBsYWluIGEgbGl0dGxlLiBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRo
YXQgbXVsdGlwbGUgdGhlcm1hbCB6b25lIG1hcCB0byBzYW1lIGNvb2xpbmcgZGV2aWNlLiANCklu
IHRoaXMgd2F5LCBubyBtYXR0ZXIgd2hpY2ggdGhlcm1hbCB6b25lIHJhaXNlcyBhIHRlbXAgYWxh
cm0sIGl0IGNhbiBjYWxsIGNvb2xpbmcgZGV2aWNlIHRvIGNoaWxsIG91dC4NCkkgYWxzbyBhc2tl
ZCBjcHVmcmVxIG1haW50YWluZXIgYWJvdXQgdGhlIGNvb2xpbmcgbWFwIGlzc3VlLCBoZSB0aGlu
ayBpdCB3b3VsZCBiZSBmaW5lLg0KSSBoYXZlIHRlc3RlZCBhbmQgbm8gaXNzdWUgZm91bmQuIA0K
DQpEYW5pZWwsIHdoYXQncyB5b3VyIHRob3VnaHQ/DQoNClRoYW5rcywNCkFuZHkNCj4gDQo+IEBE
YW5pZWwsIGFyZSB5b3UgZmluZSB3aXRoIHRoaXMgdmVyc2lvbj8NCj4gDQo+IFNoYXduDQo=

--_002_VI1PR04MB4333D24227603D1497BA3CB9F30C0VI1PR04MB4333eurp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Fri, 10 May 2019 03:40:54 GMT";
	modification-date="Fri, 10 May 2019 03:40:54 GMT"

Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:15::45)
 by VI1PR04MB4333.eurprd04.prod.outlook.com with HTTPS via
 VI1PR0102CA0104.EURPRD01.PROD.EXCHANGELABS.COM; Mon, 22 Apr 2019 08:13:29
 +0000
Received: from AM6PR0402CA0030.eurprd04.prod.outlook.com (2603:10a6:209::43)
 by VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.12; Mon, 22 Apr
 2019 08:13:29 +0000
Received: from VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e01::205) by AM6PR0402CA0030.outlook.office365.com
 (2603:10a6:209::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.12 via Frontend
 Transport; Mon, 22 Apr 2019 08:13:28 +0000
Received: from mail-pg1-f180.google.com (209.85.215.180) by
 VE1EUR01FT043.mail.protection.outlook.com (10.152.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1771.16 via Frontend Transport; Mon, 22 Apr 2019 08:13:28 +0000
Received: by mail-pg1-f180.google.com with SMTP id e6so5514342pgc.4
        for <andy.tang@nxp.com>; Mon, 22 Apr 2019 01:13:28 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id b128sm15015624pga.50.2019.04.22.01.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:13:25 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Tang <andy.tang@nxp.com>
Subject: [EXT] Re: Ask for help about cooling device map
Thread-Topic: [EXT] Re: Ask for help about cooling device map
Thread-Index: AdT4u6shVhjIu6UxTEaSdrTYxYKoAQAJ5W6A
Date: Mon, 22 Apr 2019 08:13:23 +0000
Message-ID: <20190422081323.lkgwbso36sshafbf@vireshk-i7>
References:
 <VI1PR04MB43334F646A71A0575CAB7C03F3220@VI1PR04MB4333.eurprd04.prod.outlook.com>
In-Reply-To:
 <VI1PR04MB43334F646A71A0575CAB7C03F3220@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthSource:
 VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Has-Attach:
X-MS-Exchange-Organization-Network-Message-Id:
 e685b2e4-38d5-4f3e-b0cd-08d6c6fa66c9
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
received-spf: Pass (protection.outlook.com: domain of linaro.org designates
 209.85.215.180 as permitted sender) receiver=protection.outlook.com;
 client-ip=209.85.215.180; helo=mail-pg1-f180.google.com;
x-ms-exchange-organization-originalclientipaddress: 209.85.215.180
x-ms-exchange-organization-originalserveripaddress: 10.152.3.151
x-ms-publictraffictype: Email
X-Microsoft-Antispam-Mailbox-Delivery:
 ucf:1;jmr:0;ex:0;auth:0;dest:C;OFR:CustomRules;ENG:(20160514016)(750119)(520011016)(944506303)(944626516);
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?IbWP+c9O+B6xVhT+Nzx+QQOFw37IxId7KMmLg5XkKnN0UZY+LRHixBr4k6ay?=
 =?us-ascii?Q?8klLBBs4IqVSHqKdI9Xq5V7xMGCgW3CNvW8tkpplDb4VsjxCyDGmKIAkoIPE?=
 =?us-ascii?Q?YSIxEOCm/JWUYI7XrEJ1UxCuUxbLcrFVgs3WQctdNTv1FPLgH5ngyB4E9CkT?=
 =?us-ascii?Q?lZV3hD2v9OgLMJav2GkXvM+bJ0dGbkZY6ain6aKoY5DYOYeG+u/XRiIJjhb0?=
 =?us-ascii?Q?drymRxUrfnObNRnZwoWaJnOWuD0aJPnbo13XLrwRBYiiyUgvqRVjs5/YwUAE?=
 =?us-ascii?Q?NgjhOliSjF37rVlJ22yQbn2rjei/3QR/6LblMk1eYplxLizfcO3PDWCbUvcr?=
 =?us-ascii?Q?hHDqS5Dfs79vX8ZeFTyX3/L4wwojIxcdhxCMfwxbhS84yzzsGE8nLSMjH/xy?=
 =?us-ascii?Q?jEso6Zcoqt0gZERJW0tQHdJPdHSjuoHsKCI9F7kQN5Aq4esRHIFuboTIwV+o?=
 =?us-ascii?Q?zkjYhhpdfi95/mevCIVTusbE98WCzptjkbgibsuqrWnXBmEL7EwZRR01NJM/?=
 =?us-ascii?Q?5vcYI7JYQW9f3VpYHweFFfrI3KLeBQIQ0R2YQlAnmkRINP7V/cjbDhIyTUIb?=
 =?us-ascii?Q?qf4dZZyCThobYSTzvM2Qrq3Qn5+rzkM9KhiaKGdsJnKMqa5A4sGUULARN+LS?=
 =?us-ascii?Q?BBruYhhb5LBmE+Ot+Ufpm5zsRpQ/EHoeNF5gDoyi0begjfrO4q7zBUgE+kgl?=
 =?us-ascii?Q?A4CCkY97vzK0MsMseSVk2RFnKoSuWXPRvtuFFz9sHafvzacykaTzBFY3CNBh?=
 =?us-ascii?Q?j1k23MQ5WWrwDQcnPIHEDxUnqPuQ09Uo4sTJ695V/8JUot5GbeUhd8Lx7TjQ?=
 =?us-ascii?Q?AVORaPHo09Cxa5dWGSkP5gxhEVUvbjU9KOL6duZibv1LcYs2SLG511EQZy8R?=
 =?us-ascii?Q?XbT12CpGrAFkn/bl9B74l/E0X3NtStdtImf1YgfAZRQ32Zz7dbI8i6tM3Tbd?=
 =?us-ascii?Q?XQ83l/yeLuqfG55DFkyskAAUyJQK8Llt8XXtVqnQtQbKufXP9MkMnWqPkJR/?=
 =?us-ascii?Q?Cbx9IhILi1DxB0AncZ9c58SzrdNYH2DZBxFgM9vgVZId/ABi0G1aLe6fxGve?=
 =?us-ascii?Q?mTRBKwwMTAQ7rHehsJ6Gj2beHN39QaXZsHu+HagX9e4wrlYYT1Pklt9jfPu5?=
 =?us-ascii?Q?JCcTabNxG1FU?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD189B44EDC1F8428EC76FB0AAE2E1FC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

WARNING: This email was created outside of NXP. DO NOT CLICK links or attac=
hments unless you recognize the sender and know the content is safe.



On 22-04-19, 07:09, Andy Tang wrote:
> Hi Viresh,
>
> Sorry to bother you. I have a question, hope I can get you help.
> Here it is:
>
> I want to add multiple "Thermal Zone" support in dts ( driver is ready).
> The final dts looks like below:
>
>         thermal-zones {
>                 cpu_thermal: cpu-thermal {
>                         polling-delay-passive =3D <1000>;
>                         polling-delay =3D <5000>;
>                         thermal-sensors =3D <&tmu 0>;
>
>                         trips {
>                                 ccu_alert: ccu-alert {
>                                         temperature =3D <85000>;
>                                         hysteresis =3D <2000>;
>                                         type =3D "passive";
>                                 };
>                                 ccu_crit: ccu-crit {
>                                         temperature =3D <95000>;
>                                         hysteresis =3D <2000>;
>                                         type =3D "critical";
>                         cooling-maps {
>                                 map0 {
>                                         trip =3D <&ccu_alert>;
>                                         cooling-device =3D
>                                                 <&cpu0 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu1 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu2 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu3 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu4 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu5 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu6 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu7 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>;
>                                 };
>                         };
>                 };
>                 platform {
>                         polling-delay-passive =3D <1000>;
>                         polling-delay =3D <5000>;
>                         thermal-sensors =3D <&tmu 1>;
>                         trips {
>                                 plt_alert: plt-alert {
>                                         temperature =3D <85000>;
>                                         hysteresis =3D <2000>;
>                                         type =3D "passive";
>                         };
>                                 plt_crit: plt-crit {
>                                         temperature =3D <95000>;
>                                         hysteresis =3D <2000>;
>                                         type =3D "critical";
>                                 };
>                         };
>                         cooling-maps {
>                                 map0 {
>                                         trip =3D <&plt_alert>;
>                                         cooling-device =3D
>                                                 <&cpu0 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu1 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu2 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu3 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu4 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu5 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu6 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>,
>                                                 <&cpu7 THERMAL_NO_LIMIT T=
HERMAL_NO_LIMIT>;
>                         }
> }
>
> Here we have 2 thermal zones, but both map cpu0-7 as cooling device.  I h=
ave tested and didn't find any issues.
> My query is: is it allowed to map same device as "cooling device" to more=
 than one "thermal zone"?

That should be fine IMO.

--
viresh

--_002_VI1PR04MB4333D24227603D1497BA3CB9F30C0VI1PR04MB4333eurp_--
