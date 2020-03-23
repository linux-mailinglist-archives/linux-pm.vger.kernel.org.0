Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B8E18F6D9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 15:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgCWO1L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 10:27:11 -0400
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:56448
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgCWO1K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Mar 2020 10:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak3QL1mWpvTrOJjMUFhb+oq9yXiuXXpYV6vRaOVVRi6Mo4iH2/IyZCVjVElMXLzhiTrlwUYA+7SmuX+kVCPik1datZrkkqssT9t/ASWsVCKTFs/tSoD20fS5q7OeWxQ8E/GZvVagjHs78vDRQjztdhXPhj9YWvjTJGMYcb6D+VRnc7/UYlMWSjAvkRkDSlK4n+Tidvex2HIECa6Xy4wnSXUmDzNlHuvV9PRfXcQqlLoZwwOnlBOMOsKiXO/RUqv503eplmb+wN5S+7zlhGDEbdosqUyv4g9RX5sRZLvuFrt+eVBcRkFjwJ2nObb5kcPsiDdnnTG/pOSGW7kVe4xvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkmnU8GffRjmH68GP4oWaUsiK16+2vCNv89n62n4mBM=;
 b=GFCnfTDxf+IJstNcFBlDM4hAKZwi86dsKBIwObWEvbyZiqsJS/JxX1tTG3ym6LjIhDY8lH8nlXGtzdyynUBaZQVQsYgtpHkMYrCGNiBRUHZKP3fk30JLEBxCKCgEVx9JplK4iuOEU8ezRMy6Wl2dJhw/4Glue/bOcB/227nHH+hPPBmvxiSvjOIjLwZK2Wep2qRXdYQjsxVp5gj3A+AKtAtem6NYIVHQiRYkMHS5DIQstta110w0Dxtt8ubyYc5nn8lBZKWd9sVqHW/IaEPUvqVqW16l6vavOkYmqdCQ+jjldCOgMe4JQM/TKSAa0yQiQywn47UC1qwQ03+OimpMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkmnU8GffRjmH68GP4oWaUsiK16+2vCNv89n62n4mBM=;
 b=iLKAdACTQ070FHDukf27vDPDHvUk/f9lpBfx9C/+UNtqSsnuBKUROlNLno+j48cUa4XR69oTQELJjN8zX6hBHfZKLTG1eeT1wEV3IA8DCwFVq6XklkkqSkyIlaHFZykNMGhLvd84sY3zU5XyaEvPkKHpWWQ0W5ok2qHoSmSytEQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (52.134.65.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Mon, 23 Mar 2020 14:27:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 14:27:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 2/3] thermal: imx8mm: Add i.MX8MP support
Thread-Topic: [PATCH V3 2/3] thermal: imx8mm: Add i.MX8MP support
Thread-Index: AQHWAQ+PMwlXAHkCzkSegBP0Of4mRKhWN38AgAAEZRA=
Date:   Mon, 23 Mar 2020 14:27:05 +0000
Message-ID: <DB3PR0402MB3916CA154E7D1FDED469B8DEF5F00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
 <1584966504-21719-2-git-send-email-Anson.Huang@nxp.com>
 <644b108e-596c-64d6-9693-80ac7f706dc7@linaro.org>
In-Reply-To: <644b108e-596c-64d6-9693-80ac7f706dc7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19c2e8f3-428f-479c-5cd5-08d7cf364348
x-ms-traffictypediagnostic: DB3PR0402MB3913:|DB3PR0402MB3913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3913155857D432E8890EE023F5F00@DB3PR0402MB3913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(199004)(7696005)(186003)(8936002)(26005)(81156014)(52536014)(76116006)(86362001)(478600001)(8676002)(66476007)(66556008)(64756008)(81166006)(66446008)(5660300002)(7416002)(33656002)(66946007)(316002)(55016002)(71200400001)(2906002)(44832011)(6506007)(53546011)(4326008)(4744005)(9686003)(110136005)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YO9LEJCvdpwAh/Icu50w2mD/wP4ATbDZWV8xlRpRH7NDdaBk5BPlJoZFROo9tlqL77Ps9hVSCXCulHsMAbd/3cXYtO5g2HLll3qqhe4iows2VZI6aNZZ/Sr8oeTp2czWHkmFY5i91DmF7y1TfpR3c9gMixuLgig0VWghzEvT3Ip1nilFu5VMEuoW5j19EmQJwJC0xHWqV4px9KC6Ad4rx1T8nkHaAyaqEok/shO4WGfOWIMM7E6/i0ZZRHfXPu/J2zB1SdMCVB/Xg+AYSrrep4zeBf53JZPLQ0jS8CbTgsuSgUvubUiHp+U21awgeMUys9MQVGVMmWJQ9LlkQFjTmrGV9dW8pObjhulE58r7xtRoefJIZI1PGe4fD9MEbQKWdr5ejKa360OuAZ8CHibg+uP2pz2WkDWnTY6slvKg37ELETyLmUik9YiEuyD5Cs/3UjWGFdE4AsSR6oHRye4T+2NH7s7ltsAvQHWJF+kRksiG9HYq+YTums/YruNxuOwwH2pZljqfw0YSOBFCu1znZg==
x-ms-exchange-antispam-messagedata: Qzl17yqdBCN1x+21ylCnUGBI9lZ7DD314RptBkguiYB/OegTiFCGkv9ELh/AFzzN5ub8sRt4B+ZnRvlu49hGCSa0pMtv2Yf+BgArGuvQMBVY0R+yZkl1YNIikk5m8k97nlHADE5pkizPoXAUaiKoag==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c2e8f3-428f-479c-5cd5-08d7cf364348
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 14:27:05.9164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4BI4CfvMlcMIPDJxDA4tG3HagDUkdmlSYeqVM3BGEXrV9owp1ZWETXuFJrPyXBPBrlF2rFQosvFRmCFoz4PaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMi8zXSB0aGVybWFsOiBpbXg4
bW06IEFkZCBpLk1YOE1QIHN1cHBvcnQNCj4gDQo+IE9uIDIzLzAzLzIwMjAgMTM6MjgsIEFuc29u
IEh1YW5nIHdyb3RlOg0KPiA+IGkuTVg4TVAgc2hhcmVzIHNhbWUgVE1VIHdpdGggaS5NWDhNTSwg
dGhlIG9ubHkgZGlmZmVyZW5jZSBpcyBpLk1YOE1QDQo+ID4gaGFzIHR3byB0aGVybWFsIHNlbnNv
cnMgd2hpbGUgaS5NWDhNTSBPTkxZIGhhcyBvbmUsIGFkZCBtdWx0aXBsZQ0KPiA+IHNlbnNvcnMg
c3VwcG9ydCBmb3IgaS5NWDhNTSBUTVUgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBz
aW5jZSBWMjoNCj4gPiAJLSBGaXggYnVpbGQgd2FybmluZyBhYm91dCB0ZXN0X2JpdCBzZWNvbmQg
YXJndW1lbnQgdHlwZS4NCj4gPiAtLS0NCj4gDQo+IFBsZWFzZSwganVzdCBzZW5kIGEgZml4IG9u
IHRvcCBvZiB0aGlzIHBhdGNoIGJlY2F1c2UgdGhlIHNlcmllcyBpcyBhbHJlYWR5DQo+IG1lcmdl
ZC4NCg0KRG9uZS4gU29ycnkgdGhhdCBJIGRpZCBOT1QgcmVjZWl2ZSB0aGUgbWFpbCBvZiBwYXRj
aCBtZXJnZWQsIGp1c3Qgc2VudCBhIG5ldyBwYXRjaA0Kb24gdG9wIG9mIGl0Lg0KDQpUaGFua3Ms
DQpBbnNvbg0K
