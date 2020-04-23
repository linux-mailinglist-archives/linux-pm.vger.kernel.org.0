Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BB1B5F94
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDWPj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 11:39:29 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:55534
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729332AbgDWPj3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 11:39:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcqhEkt2yevtKwGqWB0y+dgEY5GhNWa0tc0M/MnFLZrJiFccfHtNkuGSy449qCFXdvPD4QSIc93L4ob+5Yt3CAFCLHwhvBtrXjWC1MvE3JgE/H+6A2WSP3ISKXlAXuIT0bytgWA+80AC/mlnaBAG2E5lrKtfwpHHhTIjqmWaMDQbD0rO07j+8kYml4TkWkHuy7Nl3eEaTKCpTyr1EkOEtNarnvmat50sAzbpRxGOCde+U7M4gSXLWgIJjQwnyMr8h2FQIfErUSMnp0UWPe5a7fzKACHd6wdymFkFBHFUMl2xBNeCJ9uoRTwS5YxfqdM/4wmvWN6M4M4kuvgxB4Z/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIWm0BOwSfWeNSZUykaS0hHq8GTcL3jy9xN51aSqa5Y=;
 b=ma/b3HxxcDFh1hlWMPAoiI8S1QPlLBPYpgwX10dI/Ea7EcXEahfBUj7PPHVGmwUpXsCfJzBrdwievyg7Hh1zW5f37YFFaiIrm8hGpgyqG08zhvUm0Bp3H0aA+LCLDLSg01IHk2o7pgd+qRUXH5076JJh5NNoLj27JK9h0U9ObEuvw5jGdLmQ/N2LDaNVVHS8XSUEGev3SxrdpTSugYxLrwfKjgKjfEldjNlPRkzu7piJ7dCTcbBH9zHBYPewtPWP2ARYQONYeeg99dLctnfZtxZEqUNO+YziMgVADnjO+lVI2/CdSGF5yvVRabGjzMq30NN6wkGwisNl1iWD7ZFQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIWm0BOwSfWeNSZUykaS0hHq8GTcL3jy9xN51aSqa5Y=;
 b=idZVkBu5x7e5FON5hOEp5wayuBMPX2e6EVsKKgLv3JGCKCF5QAexTCCClyhGGW5ExCRbAm7vMVmzW8R9Tcq2MGcglZ9RRf5rpGyfwtn9KWjcCoQKv32yHM25fBXj8Y4hMNHH9RxJzGwcQSB/7qeYHnuk3vsksSCQRvFq+NaIYEY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3899.eurprd04.prod.outlook.com (2603:10a6:8:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 15:39:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 15:39:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Peng Fan <peng.fan@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings: firmware: imx: Move system control into
 dt-binding headfile
Thread-Topic: [PATCH 1/3] dt-bindings: firmware: imx: Move system control into
 dt-binding headfile
Thread-Index: AQHWGXizyKpLQyPoM0K6vK6jVENDPKiGxoOAgAAQV6A=
Date:   Thu, 23 Apr 2020 15:39:24 +0000
Message-ID: <DB3PR0402MB39167F9D8D3101FDA02E3077F5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587650406-20050-1-git-send-email-Anson.Huang@nxp.com>
 <CAHLCerP3jGUZC+i2i6CEYhOtBjLYKAPe7M0bKUs1b5oQEsdfEg@mail.gmail.com>
In-Reply-To: <CAHLCerP3jGUZC+i2i6CEYhOtBjLYKAPe7M0bKUs1b5oQEsdfEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51351c67-cb01-4163-ae22-08d7e79c802a
x-ms-traffictypediagnostic: DB3PR0402MB3899:|DB3PR0402MB3899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38998B5117959DDDDA7E1167F5D30@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(7416002)(76116006)(9686003)(8676002)(86362001)(64756008)(66476007)(4326008)(478600001)(66946007)(66446008)(66556008)(33656002)(5660300002)(55016002)(4744005)(316002)(186003)(54906003)(6916009)(2906002)(81156014)(71200400001)(52536014)(26005)(44832011)(8936002)(7696005)(6506007)(53546011);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2bNCzmRQmwBbRCntm7MOTMnHzdshrQOzhpHE0wR+oIQ1XK6MX60rxF9mgiJ2I+Z0Cd0GVcdxyIS9iUWJwCbPVuvZHGCWT7eE1SGYdUSvvFWPbMe8WELWJEVw9rfVYjX4FjYs7kRVdjeJU2ztsgUmFNGwI1IPSWLTpem3f/Y30KGrPQsqXtWBVJn7Ol8UkoE2z/TWwrhLdRDlTlhhhiY/DPBZVNvMAf2nJX991D2mubgsvBQx+kIG5Y2tNKZcpLKoQ9YbUtTgEwIiqwtSBmP4UgV89cpp5w7WKXPa0bU48s5QOez/bhZY43FI/asW2SKaOB9hobstqxCsKstYOh8IdEuI8AVpa0pL+PKxeig0aIjooCgs3E+sFGzyPI8lAqLQNQcMnlap1JQa9GDG9784Japvnh2M8xv+mUM76bknazDGUlE9qdlUAKTejCy+FZ2Y
x-ms-exchange-antispam-messagedata: Dw/cntGq1vYYAttlywiimH/vxgYh56tc8l0GU37ZfBU3a1v2xHr3JiVxFYFsbzjCeKb2zx5Ha6awmi015ttWoYkYFzVKGW2JUORKYgg8AO0Wgl/S4QDTQ6cFqje3pdYMCoU0KKvReoRyfJuQO0oZErj53N1o7XLam44cZBY6fpHVSqXFNfSXrsXULZ3qCa4ZwkQfuGGcM8kiaRfViU0tuk9rHwPrbOY3vw9JpuY3vagIhTLA6I3n5p7cn3KcRSaPAd2Xg4OMOc5eVkrWcXYpUZW0CxKsu9nB3J3b9oi+yjLVcfVVx9MY0xc68MfEvHYZO7/O1HQNjQreoYSFPsy3zzd0GwbJUy02EQ3+vk8JUK0xgH+pNapz574g1l+dVG3uYf8ItZP4xi8OnHntpjhVYTG1QGAyM8KnPNwFmp6v2cgjosMSF5vozKhdTLZIKB2gWwwkRZo2r8mk341TZvrkcmHhZW+SzLT5qDi/LlAFldeiNs38deR6bSnuvfbA6eSiO9InuEjISiv51/kKNJ2I2MLXF5pip3WaT6P6RzNbFQDpl29UWGgZFGTpDsIcWklJAptXb3j07wCbwwIh9FpTq22SJq1eHoZYnxN9/QzmeFgx++FmCvpANw/pFz+cgVR0zAq4Bt5EVGEhzUT9Fl3Wc4mCfCQpqSYSJ4/DGUqgOd+OlRlkC9/U0F1wZQ+PDniwCzzRbC0tZ/aLqswBNEeAo2BME2twi9GozVZJtBteppSlVboVlSoe1R601Ex7vbmUZ6ouQwQvcBeT6g6RYb4llBZIHgq4U/irAfX+PNt5pLs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51351c67-cb01-4163-ae22-08d7e79c802a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 15:39:24.6320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1dEcNp63/K34Y0bMOVtZMZOkgOfOICSQsTbB63VwSah77NnDDhbzXEqBMLOXlMAtR53LaZPIBBmbZptkZUlEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIEFtaXQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IGZpcm13
YXJlOiBpbXg6IE1vdmUgc3lzdGVtIGNvbnRyb2wgaW50bw0KPiBkdC1iaW5kaW5nIGhlYWRmaWxl
DQo+IA0KPiBPbiBUaHUsIEFwciAyMywgMjAyMCBhdCA3OjM4IFBNIEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IGkuTVg4IFNvQ3MgRFRTIGZpbGUg
bmVlZHMgc3lzdGVtIGNvbnRyb2wgbWFjcm8gZGVmaW5pdGlvbnMsIHNvIG1vdmUNCj4gPiB0aGVt
IGludG8gZHQtYmluZGluZyBoZWFkZmlsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gV2h5IGFtIEkgc2VlaW5nIG11bHRp
cGxlIHZlcnNpb25zIG9mIHRoZSBzYW1lIHNlcmllcz8NCj4gDQo+IFlvdSBuZWVkIHRvIHNxdWFz
aCB0aGlzIHNlcmllcyBzbyB0aGF0IHRoZSBzd2FwcGluZyBvZiB0aGUgaGVhZGVyIGZpbGUgaGFw
cGVucw0KPiBpbiBhIHNpbmdsZSBwYXRjaCBvdGhlcndpc2UgY29tcGlsYXRpb24gd2lsbCBicmVh
ayB3aXRoIG9ubHkgcGF0Y2ggMSBhcHBsaWVkLg0KDQpUaGUgZmlyc3QgdmVyc2lvbiBJIHNlbnQg
aXMgaGF2aW5nIGNvbW1hbmQgZXJyb3IgYnkgbWlzdGFrZSBhbmQgcGF0Y2ggMS8zIGlzIG1pc3Np
bmcsDQpTbyBJIHNlbmQgaXQgYWdhaW4uDQoNClllcywgSSB3aWxsIHNxdWFzaCB0aGlzIHNlcmll
cywgc29tZXRpbWVzIEkgd2FzIGNvbmZ1c2VkIGFib3V0IHRoZSBwYXRjaCBjYXRlZ29yeSwgYnV0
DQptYWtpbmcgaXQgTk9UIGJyZWFrIHRoZSBiaXNlY3Qgb3IgYnVpbGQgc2hvdWxkIGJlIHRoZSBt
b3N0IGltcG9ydGFudCBmYWN0b3IuDQoNClRoYW5rcywNCkFuc29uDQo=
