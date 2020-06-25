Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A655C209861
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 04:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbgFYCGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 22:06:18 -0400
Received: from mail-eopbgr1400119.outbound.protection.outlook.com ([40.107.140.119]:3344
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389121AbgFYCGS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jun 2020 22:06:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiV4C5XUZP1yGWCGblzXi6TkaYE8CRwn8TePEoIMCwk0M+6uNlrqNGoN8bAUATL7rhz5sGDhSXkBGT0D9/IrjlQ0VvDntx/4LHzv5nir0XsJmz61jV7CsKBN4LU/GVosNPdzejFQUCw8FUhQNVrU0EiPEHrTaNe3q7+tDNjtTyrbVihj+iL/AH4K16KX2crYn7MzW/0Ept5uAqZTkDaK8FXBbdVM4ZddGBeDQOHkfqOHhyvecHhXoE2D5yAsU9mrQ75Hcfjb8BBshOH8Wd2Dn0MBXXwpCE9zGF4Mr/iw+thgAeeQOGnU8wFkLDjBArL9hK2rJtUP1RAUtRReIuuLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtrKUGIeCk95Jbakt8PJJQmjjtVpXtZL2RgMHZuzRdM=;
 b=DBSiEom4Yzh49GZItv7J6SIdws3CO0FRW+JGMxqp2ok52u2UWRknC8PlnvzR11cttvfFSzMMEyxgt5OPTCU0MM7fbtll26Grx7n41A5eCHNiQXOg+GXqS/h2ZE61GG4s9N0HWsmFO5dWpN2wu2qgQdtFmlposiJtFwoNI5JKgYjofGs5Nu0uF7mAamsoG/pJxnZcRJmNGSwA44/kmGD46b2OqST29PWKjOa8Dv5XJ2tQoklnBgQ7ptBwPSQ+zAu6I7iVAZaluJRqaIKHUW0mhoD46RxfWXsDmqY3JkUtyC2ufj7oOEaJ/gT++1WrQnMWliiSMDor923luGFT7FwGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtrKUGIeCk95Jbakt8PJJQmjjtVpXtZL2RgMHZuzRdM=;
 b=qcdtZRSZZhO17jCJ4lfrirWCgrxsbT7kZ1fTTbRKkwKOAVYj7jYkjZECv0NHe6WuGWQYI78Zc5+aTw/MFkuQpWFtMN1egPwD6dzYBbdyCh5BLJ7WUavD9/6vlS81jEGUj2ptzEQG8WfSyMaa0HnIv1kAZ6AhnAMaM/4W+KKy7jA=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB4221.jpnprd01.prod.outlook.com (2603:1096:404:cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 25 Jun
 2020 02:06:14 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 02:06:14 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "niklas.soderlund+renesas@ragnatech.se" 
        <niklas.soderlund+renesas@ragnatech.se>,
        Van Do <van.do.xw@renesas.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] thermal: rcar_gen3_thermal: Fix undefined temperature
 if negative
Thread-Topic: [PATCH v2] thermal: rcar_gen3_thermal: Fix undefined temperature
 if negative
Thread-Index: AQHWPlN1wG1n6rFmi0qJ4l1XbYnhsqjmMNuAgAJ8N7A=
Date:   Thu, 25 Jun 2020 02:06:14 +0000
Message-ID: <TY2PR01MB369280CE8C9709CDBFC2AB88D8920@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1591703110-14869-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAHLCerOxKuqhzfNSEMk6dB7B8Y_nvhQ0F0yO+BGrUE-P4SKBEA@mail.gmail.com>
In-Reply-To: <CAHLCerOxKuqhzfNSEMk6dB7B8Y_nvhQ0F0yO+BGrUE-P4SKBEA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf6b92a4-4f7a-469d-b338-08d818ac5714
x-ms-traffictypediagnostic: TYAPR01MB4221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB4221BF495F6826AFD95B27ECD8920@TYAPR01MB4221.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyeTPZ0JKNlNwEV7lMIwUydkjx/H1rSd9Pbr2Ca9D7/PRu7oab//3YRapV/h+2wwHeS3qbXmL380Jisk8PyzUEWpWyQ27TABjk96tiFM/iJt/wVv10GYSuVZdXWsm6RJEoc1mESbXf4UEUMjU0GGW48GKaQTglKRfhVGgbFCqTYWU4Go7Ds3gXQK38C71rFQYhMkZPxkkjrzHD8rHNGugZDVyFG3jsUeK4tEC74tiqtageEDd5wP+W/drlVd3ZeleQ25AeAVdIh/RIHImDoq9zbBG3MaBgxwECm0upYlKQMzNweD2LQce23zbMNnneCEZG7Q/iYWxZygpPMWTL6ukg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(86362001)(7696005)(52536014)(186003)(55236004)(6506007)(6916009)(2906002)(66556008)(66476007)(64756008)(66946007)(66446008)(8936002)(71200400001)(33656002)(55016002)(76116006)(478600001)(4326008)(8676002)(54906003)(316002)(5660300002)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dTyqKZbrM+O/WF0k12VTsFFbCQiSix4DK1n16L7MeSdP6ptN+hkeBpP2awtIFA1GjW5zqvCjCZhzDS1Jlb2J4CQwyT14kS2VgCMBYupu5uBv/n+obc7a5LRIC8AHajc7eeK6/ruFA+1LopokXV2FF7O9yn2Km8OAv59ovxkqPAU6ruYWxST5h9c0i3czFbe6BLpLCwjOkSI8qZ+f7zfc+Zt95voI2g1BAVypfCg/R0NhjYOWrjDAyVkxjiBvXSptbncA3UgM6Gjrzm7eXfqzFVZ9nvuyd1TqAffTDnLfqyJjUWMIVb8DRqIrFakUzF8g9TU1HR4xnwUb9N9MLJDddkOiddP6TlcA4kbRFYCcWHKNOXVBAd2M1n7lbNKHB4Fy/oTCGRKYVWwrfytT6D8XDZblHRrxtg0nYkEAl5EWtOf7jJ/wNgtPhv0RMrVHsqyj175bNztQg+ZYl9KSLCdARnFstBb86TR4ro3RnzWtcs+54FKD4MJH/EJ0SxymUeEW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6b92a4-4f7a-469d-b338-08d818ac5714
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 02:06:14.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHq8QBJLWOTFk6i4uL+g4y72+7Zjsl9OSISOmsxQUEZdCS3mygUhg29ioqnLRgQRjeuKQrLLzCJqVz/YruOQWd5FhggDJAyThZDEGHExFTm+WPodu7YprVY6eC2/8/h3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4221
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQoNCj4gRnJvbTogQW1pdCBLdWNoZXJpYSwgU2VudDogVHVlc2RheSwgSnVuZSAyMywgMjAy
MCA5OjA3IFBNDQo8c25pcD4NCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvcmNhcl9nZW4zX3Ro
ZXJtYWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9yY2FyX2dlbjNfdGhlcm1hbC5jDQo+
ID4gQEAgLTE2NywxNiArMTY3LDE2IEBAIHN0YXRpYyBpbnQgcmNhcl9nZW4zX3RoZXJtYWxfZ2V0
X3RlbXAodm9pZCAqZGV2ZGF0YSwgaW50ICp0ZW1wKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1
Y3QgcmNhcl9nZW4zX3RoZXJtYWxfdHNjICp0c2MgPSBkZXZkYXRhOw0KPiA+ICAgICAgICAgaW50
IG1jZWxzaXVzLCB2YWw7DQo+ID4gLSAgICAgICB1MzIgcmVnOw0KPiA+ICsgICAgICAgaW50IGN0
ZW1wOw0KPiANCj4gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGNoYW5nZSB0aGUgdmFyaWFibGUg
dHlwZSB0byBmaXggdGhlIGJ1ZyBpbg0KPiB0aGlzIHBhdGNoIGFuZCBtYWtlIGEgc2VwYXJhdGUg
b25lIGZvciB0aGUgdmFyaWFibGUgcmVuYW1lPw0KDQpJIGdvdCBpdC4gSSdsbCBrZWVwIHRoZSB2
YXJpYWJsZSBuYW1lIGluIHRoaXMgcGF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBT
aGltb2RhDQoNCj4gUmVnYXJkcywNCj4gQW1pdA0KPiANCj4gPiAgICAgICAgIC8qIFJlYWQgcmVn
aXN0ZXIgYW5kIGNvbnZlcnQgdG8gbWlsaSBDZWxzaXVzICovDQo+ID4gLSAgICAgICByZWcgPSBy
Y2FyX2dlbjNfdGhlcm1hbF9yZWFkKHRzYywgUkVHX0dFTjNfVEVNUCkgJiBDVEVNUF9NQVNLOw0K
PiA+ICsgICAgICAgY3RlbXAgPSByY2FyX2dlbjNfdGhlcm1hbF9yZWFkKHRzYywgUkVHX0dFTjNf
VEVNUCkgJiBDVEVNUF9NQVNLOw0KPiA+DQo+ID4gLSAgICAgICBpZiAocmVnIDw9IHRoY29kZVt0
c2MtPmlkXVsxXSkNCj4gPiAtICAgICAgICAgICAgICAgdmFsID0gRklYUFRfRElWKEZJWFBUX0lO
VChyZWcpIC0gdHNjLT5jb2VmLmIxLA0KPiA+ICsgICAgICAgaWYgKGN0ZW1wIDw9IHRoY29kZVt0
c2MtPmlkXVsxXSkNCj4gPiArICAgICAgICAgICAgICAgdmFsID0gRklYUFRfRElWKEZJWFBUX0lO
VChjdGVtcCkgLSB0c2MtPmNvZWYuYjEsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0c2MtPmNvZWYuYTEpOw0KPiA+ICAgICAgICAgZWxzZQ0KPiA+IC0gICAgICAgICAgICAg
ICB2YWwgPSBGSVhQVF9ESVYoRklYUFRfSU5UKHJlZykgLSB0c2MtPmNvZWYuYjIsDQo+ID4gKyAg
ICAgICAgICAgICAgIHZhbCA9IEZJWFBUX0RJVihGSVhQVF9JTlQoY3RlbXApIC0gdHNjLT5jb2Vm
LmIyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHNjLT5jb2VmLmEyKTsN
Cj4gPiAgICAgICAgIG1jZWxzaXVzID0gRklYUFRfVE9fTUNFTFNJVVModmFsKTsNCj4gPg0KPiA+
IC0tDQo+ID4gMi43LjQNCj4gPg0K
