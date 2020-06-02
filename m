Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63F81EB2F6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 03:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgFBBaR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 21:30:17 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:25588
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbgFBBaR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 21:30:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVmxWUQHafnUNqz8oQawKfuJ9R+0AqHpe+PnufYu5NZS+zMtX8S+8JP68XqNj09QJsZSMoCHmqdIu3Ixh6bvHTTdtFH6ILySqXCjZJ9yWPFZAKtNsmmf1Zp72s8nmC429hhh38G/swVA8SE30y6WpCkDVBd4OgGn/BbwNtWv0c3/K/AyeWk9UiTILPpo81wdI+yMabGn+mW3NdN1KMMvUE0dsb5eyw9zPJpVDyt3A6mJHX4heINTcxXaCAvsyC4QmNw1wX79oRtAiAK+47N9xPu5ohT2LgBKTFjDl073pbhAc+nzjG8Ol56FCFDsxnI1Z3uZSubrKYuRsxEA/rIVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXWSrDHmWDDaPsQ8anOVWjn7hHX4VhiJGoTb8l/gFw4=;
 b=S3iyHuEYlZWpR5ciROhuRsAZzXGty62iHHbpwcDQkcovWN3GOt3PH6RqiUdzbb/Q8zJOiqoRTw/QES+vcBBRFUs08HzJWfNCUgo9paa00uZPTcEcMi7s++V6wuaTMxIdv1JFhyF3brvdYpotxcxE5SAPudrava49aUmLrDm1WxuRcdD+GVBhPiRDyGoFriPQ39XuQ+hKQxS6Cf9xKbEJq9yNBc9hYMmBJjObma2Co+Oo7l6iLbfMppPuvr3R4GPLEhi1eWHkB1HboCJHTU8vfKqaX7RxfOtabsMOz6PcNpAfrIeDxtdLgR8p6VH7dSK2WrJ+GMOlM9Dd9DKOB75HkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXWSrDHmWDDaPsQ8anOVWjn7hHX4VhiJGoTb8l/gFw4=;
 b=n7ldVgRI9Loe3R0Xb7uxkdYuZuwlXlZzQhqSuZjGzR9DKJW68WZhJgVQMjGmxFUcaGfWWnGpLjEMlqCbUHJRqQagqNEpgaKpQWIewN5BXVDzPdts/gN5Ps4laFREz9/q9jYM5+4vPjCoIeqFHqWMluocSoUbAbIQRBN79AeGRkY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Tue, 2 Jun
 2020 01:30:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 01:30:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Jia Hongtao <hongtao.jia@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: thermal: Convert qoriq to json-schema
Thread-Topic: [PATCH V2] dt-bindings: thermal: Convert qoriq to json-schema
Thread-Index: AQHWN8cm5TKythWm10iiXmW2MSrcIajD+siAgACPbVA=
Date:   Tue, 2 Jun 2020 01:30:13 +0000
Message-ID: <DB3PR0402MB3916B92E3975C594DD980B08F58B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1590982520-5437-1-git-send-email-Anson.Huang@nxp.com>
 <CAL_JsqKVL4J=-aLPsSYgGVdnx3qjA=J8M08ztzv9=0V9gY=14A@mail.gmail.com>
In-Reply-To: <CAL_JsqKVL4J=-aLPsSYgGVdnx3qjA=J8M08ztzv9=0V9gY=14A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28aecac9-43e9-495f-1cf6-08d806947f45
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB391688EAA8253BC4906A3E4DF58B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/k43LCm/3PjF4OqGp/sliYMSivq0yA6CsotMJOrfzR8V3PQBfciZzB5eXTF+VItmwHxu/xXO6Hb39xJwBWGaI8P7Ba7zV1IEAyTXZh0T10JpYZSFG5bTInSxBqXP1xVP20A3JrI4hFNPCfxSKrO+tg4Bw+icGbFhB8KNeuRgjIxI+h51HZkit7jJXhKT/pDfPw6HjHgNPvQAJNC3x8QldgHp1kjObxrp4fhLLZVjkAI6g5AJ/fqRrei5DuSiHeDk+raCxTLidjGrIMDXajsvqCYWvh8SbdmVrfZnetlgSKvo9k4yGeePwt/kDujVbpwQhkskXtw2B4iAOVdU6GS2U7aZ94vwvpv1WLA0/aKw/IID8q2u9AI4jFCKihF5XMoOlyMdsEPQFV9RfmdZ6JCCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(52536014)(8936002)(66476007)(64756008)(66556008)(66446008)(55016002)(5660300002)(9686003)(26005)(53546011)(6506007)(44832011)(83080400001)(71200400001)(316002)(2906002)(8676002)(83380400001)(478600001)(86362001)(7696005)(54906003)(66946007)(33656002)(76116006)(4326008)(45080400002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: t9Gd/v+thKNdYUxjPcWQxL4jYdWQrsYcp74PnQ9eOiCToyYQlX7w+/GFXXyTJfB6zEQrgrUwkOvShjM245YKJrys2ae1cpmqV0wS04+5Xz/zXwoz7+w4UPx+vNZqQ9Go6XDPXCd23UpkOoA5PA/teCB9YR7VgGAaj1cGq7hlFyB5lFAlDcxx4Grfd/fN6VUEQgxxTw+Ys3EPSq8m9SIP/hPXCuGvA77aPmLtWVlmiY3/M1W00uvkSKL1ZsesDkECzlnhLkk2Y3QBRdApSYy52NPllC7Mj5Sj3M8JVNsELWlIzDOB4C0Xzg4bghNWdAwrVYj4BMNQwXMy7fJmkB2GhZP2le9WLfVtv8RPFryzhTQlA0vP5LPNQKasEGh5atqdj7HkzB4HNqeHkuM4L6BYrsUTvXxtLKYsMQ6Ng4mWEPxhuJuejkIiTFwL1zhkk7LnCm1yDcWV7ImbnehfJ9Qzi0menFM+pzslTlOy/io4OKY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aecac9-43e9-495f-1cf6-08d806947f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 01:30:13.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTnSsZgdsw6YtGEFoQNelXVoL5+EjCkO2ej0DpCpxK6Htt51vFLhv0ksB6f2vETYhtwfARJdyBQSfez/0wHTrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFJvYg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIGR0LWJpbmRpbmdzOiB0aGVybWFs
OiBDb252ZXJ0IHFvcmlxIHRvIGpzb24tc2NoZW1hDQo+IA0KPiBPbiBTdW4sIE1heSAzMSwgMjAy
MCBhdCA5OjQ1IFBNIEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiB3cm90ZToN
Cj4gPg0KPiA+IENvbnZlcnQgdGhlIHFvcmlxIHRoZXJtYWwgYmluZGluZyB0byBEVCBzY2hlbWEg
Zm9ybWF0IHVzaW5nDQo+ID4ganNvbi1zY2hlbWENCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgc2lu
Y2UgVjE6DQo+ID4gICAgICAgICAtIGFkZCAnbWF4SXRlbXMnIGZvciAnZnNsLHRtdS1yYW5nZScg
cHJvcGVydHk7DQo+ID4gICAgICAgICAtIGFkZCAnbWluSXRlbXMnLydtYXhJdGVtcycgYW5kIGl0
ZW1zIGRlc2NyaXB0aW9ucyBmb3INCj4gJ2ZzbCx0bXUtY2FsaWJyYXRpb24nIHByb3BlcnR5Ow0K
PiA+ICAgICAgICAgLSByZW1vdmUgZGVzY3JpcHRpb24gZm9yIGNvbW1vbiBwcm9wZXJ0eSAnI3Ro
ZXJtYWwtc2Vuc29yLWNlbGxzJzsNCj4gPiAgICAgICAgIC0gcmVmaW5lICdmc2wsdG11LWNhbGli
cmF0aW9uJyBmb3JtYXQgaW4gZXhhbXBsZS4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvdGhlcm1hbC9xb3JpcS10aGVybWFsLnR4dCAgfCAgNzENCj4gPiAtLS0tLS0tLS0t
LS0tICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwueWFtbCB8
DQo+ID4gMTEyICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEx
MiBpbnNlcnRpb25zKCspLCA3MSBkZWxldGlvbnMoLSkgIGRlbGV0ZSBtb2RlDQo+ID4gMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwu
dHh0DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwueWFtbA0KPiANCj4gWy4uLl0NCj4gDQo+
ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Ro
ZXJtYWwvcW9yaXEtdGhlcm1hbC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvdGhlcm1hbC9xb3JpcS10aGVybWFsLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLmM1ZGY5OTkNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvcW9yaXEtdGhl
cm1hbC55YW1sDQo+ID4gQEAgLTAsMCArMSwxMTIgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICst
LS0NCj4gPiArJGlkOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUyRnNj
aGVtYXMlMkZ0aGVybWFsJTJGcW9yaXEtdGhlcm1hbC55YW1sJTIzJmFtcDtkYXRhPTANCj4gMiU3
Qw0KPiA+DQo+ICswMSU3Q0Fuc29uLkh1YW5nJTQwbnhwLmNvbSU3Q2JiMTQyMDBiZjlkZDQ3NDA0
ZmQzMDhkODA2NGM1NzE5DQo+ICU3QzY4NmVhDQo+ID4NCj4gKzFkM2JjMmI0YzZmYTkyY2Q5OWM1
YzMwMTYzNSU3QzAlN0MwJTdDNjM3MjY2MjcyMjMyMzI5NzExJmFtDQo+IHA7c2RhdGE9Z3oNCj4g
PiArekxVcnI5ZjU2SGNQQjFpeTR4UXZqMnR3NDFNYzlBZjVRVUpidXZuQ1klM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gPiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4gK2NldHJlZS5v
cmclMkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmYW1wO2RhdGE9MDIlN0MwMSU3Q0Fucw0K
PiBvbi5IdWENCj4gPg0KPiArbmclNDBueHAuY29tJTdDYmIxNDIwMGJmOWRkNDc0MDRmZDMwOGQ4
MDY0YzU3MTklN0M2ODZlYTFkM2JjMg0KPiBiNGM2ZmE5Mg0KPiA+DQo+ICtjZDk5YzVjMzAxNjM1
JTdDMCU3QzAlN0M2MzcyNjYyNzIyMzIzMjk3MTEmYW1wO3NkYXRhPTdxa0hrcGoNCj4gWFBYTVlu
MTNjDQo+ID4gK0kxcG5kQndGZ2ZJMiUyRjZnTWZDZ1dQclFTbm1jJTNEJmFtcDtyZXNlcnZlZD0w
DQo+ID4gKw0KPiA+ICt0aXRsZTogVGhlcm1hbCBNb25pdG9yaW5nIFVuaXQgKFRNVSkgb24gRnJl
ZXNjYWxlIFFvcklRIFNvQ3MNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gSG9u
Z3RhbyBKaWEgPGhvbmd0YW8uamlhQGZyZWVzY2FsZS5jb20+DQo+IA0KPiBUaGlzIGVtYWlsIGlz
IGJvdW5jaW5nLiBTaG91bGQgYmUgQG54cC5jb20/DQoNClllcywgYnV0IGxvb2tzIGxpa2UgaG9u
Z3RhbyBpcyBubyBsb25nZXIgaW4gTlhQLCBzbyB0aGUgaG9uZ3Rhby5qaWFAbnhwLmNvbQ0KY2Fu
IE5PVCBiZSB0b3VjaGVkIGluLCBJIHNlbnQgb3V0IFYzIHBhdGNoIGFuZCBhbHNvIGdvdCB0aGUg
bm90aWZpY2F0aW9uIG9mIGZhaWxlZA0KdG8gc2VuZCB0byBob25ndGFvLmppYUBueHAuY29tLCBz
byBJIHdpbGwgdXNlIG15c2VsZiBhcyBtYWludGFpbmVyLCBjb3JyZWN0IG1lIGlmIGFueXRoaW5n
DQp3cm9uZy4gV2lsbCBzZW5kIGEgVjQuDQoNClRoYW5rcywNCkFuc29uIA0KDQo=
