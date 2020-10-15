Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD428EB3C
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 04:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgJOCfk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 22:35:40 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:44006
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbgJOCfk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Oct 2020 22:35:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3HKi/Vm0VAhs2ore0dO4XYktb/JcKKMugsOr+dWic4V/jPDPz8jZZgkuSfo4wZB1+koxEBNlEl88KeJcep9r2J+ELp9CgG2rFAN1DelyXKXzTwWqehFxqLU9NhPkc/lnPsy5uriA9PTmUW2MYjjRdmEIkxziAm1t9SVhHOoPOLh4xX9hniI5Ergvnbq7zjOOV4r/minlhBSSCcpVvQ7H6myViyoGd0lHZmesxK4YkkcDrWCOkPoR7GjDEiB/oIqjwhGa9JDmWKJr84sOfxV7VBLEeFZpCcctahbOfmZZbw20E9nE/lot8lb/aS9LlwpsUMBnaUJDAYbpECby2oFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdKvWqAthxzuGa7ThvCQiwkWL8jFJKtftsrbQMLbFXM=;
 b=Rv5LkKPu49b7ybG3b7kyT8ZHIFzleWz62AMZfmGKtUETzJo7s/quTu4DuntXSPuApSQlXVd//b7kGyjurWVukL9OAb2RDnzWvjbWATpD4gasIGNf2Am3V1IbYMn0TKn9tYi6e3YEXtd+QpZzXRjKIe2xpnLTrvd9rEBm+4pM7SR9UrQjanNrt1Q5AKJd40GPYHf7YUKs+qnw5x+Nd8A+AZ5pc8ni1vKo2UL62XUaxuy0S3pn3n9dzyv1pg9gjauWZby8z7FRnf8k649j/I8JmLdx5jsCtrAmLcm2Hmd1JZYIJvKB5IuHF0ExELysILQunr7VYx8bOtAAkeS5aSv6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdKvWqAthxzuGa7ThvCQiwkWL8jFJKtftsrbQMLbFXM=;
 b=HxuBzYdsMAIT+SCSFYHLw/Iby5RWbZvHVjYRotm8yC4rhVrUo3z596al5DTwF88NDYZbvHAcV+b5LZFGlvzWF5NF5qfyujS35MvtM7qTzy7yBpY//rVd2MBsgnJY/Vcb3bQpxGsnCbKwDh63DLo+hnMZuMDlaluAo42HWisYJ70=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4039.eurprd04.prod.outlook.com (2603:10a6:209:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 15 Oct
 2020 02:35:35 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3455.032; Thu, 15 Oct 2020
 02:35:35 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] opp: Don't always remove static OPPs in
 _of_add_opp_table_v1()
Thread-Topic: [PATCH] opp: Don't always remove static OPPs in
 _of_add_opp_table_v1()
Thread-Index: AQHWoeIyJ2LgM4hmBkCxSzkI73YeG6mX844Q
Date:   Thu, 15 Oct 2020 02:35:35 +0000
Message-ID: <AM6PR04MB496659599D41F6B88036420680020@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org>
In-Reply-To: <2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fcdd0d4d-fad7-4aa4-e533-08d870b2fef2
x-ms-traffictypediagnostic: AM6PR04MB4039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB40391D4E5CB633D39EE0D7F580020@AM6PR04MB4039.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpGxQOBPxqGRfngkZMTn+pC4UkXYespV/d2gGOD44TnItuhzIU6MJSrqZViVNDvpAk/GFsNf2bxGHjqLePoaDleLP0xEo946VK4eaNQN59Brxyi3eeK2FCDhnKuuHkqH+NJlf/hfIkOzGfcP6UrcQD5nt3qa70a1rZFV9GPP7APiKsOHMudtAStQvMi5VSpBJhfhReFTXrxHKxL7lWC8BbfiPYn11Xq0V2VIlcQIMeiSvEhYmI4quKfLFOzoU32zFR3GLJihCN17WVoIPX0o6jsDdCSIQysK73eguDe6dUcW0TaOr5mq21iDvsxEc1XDiMBXkJkAeaQLswC13dIlTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(66946007)(478600001)(66556008)(76116006)(66446008)(64756008)(66476007)(86362001)(9686003)(4326008)(6506007)(44832011)(7696005)(55016002)(2906002)(26005)(316002)(54906003)(110136005)(33656002)(186003)(71200400001)(4744005)(8936002)(5660300002)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FCllAc1lt5g5LW46ocJE++cXytbMjTXywBtFoFTplJyYP0CrR2Z1b3OQAarbU808lgECv922GAc+WxEbf4uNU5+pCx1p/RnigIWvJiKgXS9CwX4Y0rN5hbU4EkgY8xLiw7R2PlgwVDsB1xncMrrSZKkf00L3JZP5Xoo1QW4gR5fW+oGDf8uruqd+IS8/lC5lALAvP8fgAy+4KC3Vp3414EFAN3+NLDXkq5qOr1BQnoIkdmItwr311hng7wnxsh3C2bVkJQwF3HEb3NciZCCCYBDRVfUeucPvDxCHypmHR1troJFn0gP2h7fOptvYiT5fHr67CViym/gfsEYCNeEgfgjCCmspHWcGxHrXa69WlOAEqygO8At60hKdLpu/8gQS2ZzIFA2wTKViDnziU0AG/1PU3/qBBb8XMISTMaHGloFqbDQr4VPq+dWh8FMaE00Ar2kVSYmDEtk3y2XKHoZ+H6bWDf1xO8ikX3Z6hrvfSLWkWFlrc04CnoKSjIYa3oe+lQUKgPZfW7U4jVhbNLgtBbvi0OiNbYKmQTNEZdIuzw7/miwyLhoU5n6RMUJdm9BkQ17i5ZxTAdDzxmO3D5vuP8BUzAoldHrFdMy6PXneenhT9VvTylohbiDNzauSKb/mjV+2k6SWCNTqZnB3XXPgDA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdd0d4d-fad7-4aa4-e533-08d870b2fef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 02:35:35.5516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64qqlGVTDKRdUgGyQxEkUngqABJSQL/7JAdN1VwlLlNRyQKDeVOLcb09NRD69KdqOb+0p9Dw4sR4JQjL27v4SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4039
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgVmlyZXNoDQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIGZpeC4NCg0KPiBGcm9tOiBWaXJlc2gg
S3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgMTQsIDIwMjAgMTI6MjYgUE0NCj4gDQo+IFRoZSBwYXRjaCBtaXNzZWQgcmV0dXJuaW5nIDAg
ZWFybHkgaW4gY2FzZSBvZiBzdWNjZXNzIGFuZCBoZW5jZSB0aGUgc3RhdGljIE9QUHMNCj4gZ290
IHJlbW92ZWQgYnkgbWlzdGFrZS4gRml4IGl0Lg0KPiANCj4gRml4ZXM6IDkwZDQ2ZDcxY2NlMiAo
Im9wcDogSGFuZGxlIG11bHRpcGxlIGNhbGxzIGZvciBzYW1lIE9QUCB0YWJsZSBpbg0KPiBfb2Zf
YWRkX29wcF90YWJsZV92MSgpIikNCj4gUmVwb3J0ZWQtYnk6IEFpc2hlbmcgRG9uZyA8YWlzaGVu
Zy5kb25nQG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1
bWFyQGxpbmFyby5vcmc+DQoNClRlc3RlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9vcHAvb2Yu
YyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL29wcC9vZi5jIGIvZHJpdmVycy9vcHAvb2YuYyBpbmRleA0KPiA4NzRi
NTg3NTYyMjAuLjlmYWViODNlNGIzMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9vcHAvb2YuYw0K
PiArKysgYi9kcml2ZXJzL29wcC9vZi5jDQo+IEBAIC05NDQsNiArOTQ0LDggQEAgc3RhdGljIGlu
dCBfb2ZfYWRkX29wcF90YWJsZV92MShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHN0cnVjdCBvcHBf
dGFibGUgKm9wcF90YWJsZSkNCj4gIAkJbnIgLT0gMjsNCj4gIAl9DQo+IA0KPiArCXJldHVybiAw
Ow0KPiArDQo+ICByZW1vdmVfc3RhdGljX29wcDoNCj4gIAlfb3BwX3JlbW92ZV9hbGxfc3RhdGlj
KG9wcF90YWJsZSk7DQo+IA0KPiAtLQ0KPiAyLjI1LjAucmMxLjE5LmcwNDJlZDNlMDQ4YWYNCg0K
