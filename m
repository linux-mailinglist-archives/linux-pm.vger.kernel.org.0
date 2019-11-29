Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63710D640
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 14:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfK2Noq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 08:44:46 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:43942
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfK2Noq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Nov 2019 08:44:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMyWidisleSFVMa9Fa9RlMeLZpLjfUBa+tXNQl6Rlvdk8ngnb+XwjSXvXyXmVgQ1XDEgxho9LkmlhlW1u8CLHSwGhRYHPtm7ezG4luVaaWe7tOuhpDvOGqOCCKu5KRAq1MBWXlfv7atHAT76dlGplaRcgh+LPxLCDKIfhGgUTEZl0EFx5FVujQm0tdgOZNJ6bo5GgC9hLcdGrPe89JdiXw9+0W+CJ1nNQEJIek9AgddLQhWJLb3EkPEWHLUXEBURJZB6v6Cm2tc5uPP1UycJYPApOAUUS1uwafGTvhCQtQIEeDWRutA6rmZcNz9YAmM/UE1L6PRhV5Ugp4jxA/4ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL4HUgpudHiSQsXcm+9Yvp6FXZYCxitpYn98ql5fbO4=;
 b=Q7o7kPE7/h2ds3i3dry7Q4FQTH0T7ASihZwc54ZtLVGLMQdzzJYNpegSaazi+ZQ3gPKVFDW1vgzqoCAEiVVY5wS/iMozHRjqhB4aDhDkrmDJ+0eBovsQizDqA59iX6JSXhSJUJZ54tR7WRgZnrAVE1xYYkXhNVkMQV+ntr3gVhMfCr0TAjhTDUwdilXCjKWjT5CCgIv36HlVolwe0Y2rCjhBnUzmn4fVle/cnB8o6//e2euA/yALRpk2jPkkiFnYly8Hb4OdZVK8d6q2HgPjPYheUghg0D/WdLa9reMEEZJV6BOSSBISktdX+gdrzfqeisZlqGSMuTKnjWCO8LUoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL4HUgpudHiSQsXcm+9Yvp6FXZYCxitpYn98ql5fbO4=;
 b=YWUovBNgH/A8xKVr24nbc3c0HxVPfysbzIPLs3/AilKfBk5/sWvkQKB6VnDF9Kbrw6XNFEQa9IChSPbSRhP4Vu1W8JApTn52yXHSxKdSyNfu4t6uUBRuyVU6u9/tEQ4JmL+Cs2FBrWhyjWxYasjcxoWhwMYdmgLXlLp5WmaTa2s=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 13:44:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::b8dd:75d4:49ea:6360%5]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 13:44:42 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: About CPU hot-plug stress test failed in cpufreq driver
Thread-Topic: About CPU hot-plug stress test failed in cpufreq driver
Thread-Index: AdWgM3EuFQeyF1SHRka5sBhDxaFShQAG6J6AAAAKxPAAAq52AAAAFLaAACYwDoAACh8qAAAASXeAAJxYEgAAxubCAAAEUtUg
Date:   Fri, 29 Nov 2019 13:44:42 +0000
Message-ID: <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E40800E42C2E5635C7CF54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0iiJusFSrB9LRQq39K9TeGu0kndogdd060qqiJ=QOAQRw@mail.gmail.com>
 <7507929.7xP3Io3WO9@kreacher>
In-Reply-To: <7507929.7xP3Io3WO9@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7a3edc5-b329-41be-846a-08d774d249d7
x-ms-traffictypediagnostic: DB3PR0402MB3881:|DB3PR0402MB3881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3881432A30412EB50E56D4BCF5460@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(199004)(189003)(6116002)(8676002)(25786009)(66556008)(4326008)(64756008)(66476007)(305945005)(76116006)(7736002)(3846002)(66946007)(81166006)(6916009)(81156014)(256004)(6436002)(14444005)(6246003)(2906002)(66446008)(11346002)(71190400001)(446003)(71200400001)(44832011)(478600001)(33656002)(54906003)(86362001)(102836004)(316002)(26005)(55016002)(99286004)(4744005)(52536014)(76176011)(7696005)(53546011)(6506007)(5660300002)(8936002)(66066001)(74316002)(229853002)(14454004)(186003)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3881;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtrXNxnSzhi6ZwEv6i7g+deJTM0ZlUMLlP68NfHESUenRqtkHiP41svk3yRYZO9fSTK74FX8jrhGQ60B8mqfFjUzizcepv7iY1WyGWkpxiVZ/U6vxvGd9ZX/IlRUfarxqz4UHEIUKwzzlf2LFq9/aXUVd+fILQHobO9rKjRHLtpCNIhY79dOXP+RU2GXsNiW7u1oz3INzJrV+Du9ahXw8uSfSRdwOJnUBcOVykc20OoLIJf+hg9iaLE/JKW+8WhqMTd6R8fD+gwyr/K5vIW1x6Q+BCnaJGE3zmTh6XNpncHzGodyybgwdei6SiR/Tpl25ezkC0KU8vqTv8a3hEzXEKeeWliNf1SOS4S6moATzIHI3ISX+1oXLOJbeOYqIEhd5C42OQSt69b1iEaNcooacgJNEN1bB5Y2u4uDog3TG4gEBnHhIFkh5WCIQ3+ocqxa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a3edc5-b329-41be-846a-08d774d249d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 13:44:42.6629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jMajgQzegXpvoVv877zJ04WjWrPvALlc5AgThQzHDRs3Mf22xgPxtqghxYus0vOYtMAgwAnRkZZ6SQ+E5Cl/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IEFib3V0IENQVSBob3QtcGx1ZyBzdHJlc3MgdGVzdCBmYWlsZWQg
aW4gY3B1ZnJlcSBkcml2ZXINCj4gDQo+IE9uIE1vbmRheSwgTm92ZW1iZXIgMjUsIDIwMTkgMTo0
NDoyMCBQTSBDRVQgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gT24gTW9uLCBOb3YgMjUs
IDIwMTkgYXQgNzowNSBBTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3Jv
dGU6DQo+ID4gPg0KPiA+ID4gSGksIFJhZmFlbA0KPiA+ID4gICAgICAgICBMb29rcyBsaWtlIGFk
ZGluZyBwcl9pbmZvKCkgaW4gaXJxX3dvcmtfc3luYygpIG1ha2VzIGlzc3VlIGNhbiBOT1QNCj4g
YmUgcmVwcm9kdWNlZCwgYW55IHBvc3NpYmlsaXR5IG9mIHJhY2UgaGFwcGVuIHRoZXJlIGFuZCB0
aGUgcHJfaW5mbw0KPiBlbGltaW5hdGUgdGhlIHJhY2UgY29uZGl0aW9uPyBJIHdpbGwgY29udGlu
dWUgcnVuIHRoZSB0ZXN0IHdpdGggdGhlIHByX2luZm8gdG8NCj4gc2VlIGlmIGFueSBsdWNrIHRv
IHJlcHJvZHVjZSBpdC4NCj4gPg0KPiA+IFllcywgaXQgbG9va3MgbGlrZSB0aGVyZSBpcyBhIHJh
Y2UgY29uZGl0aW9uIGluIHRoZXJlLg0KPiA+DQo+ID4gSSBuZWVkIHRvIGFuYWx5emUgdGhlIGNv
ZGUgYSBiaXQgdG8gY29uZmlybSBpdCB3aGljaCBtYXkgdGFrZSBhIGJpdCBvZiB0aW1lLg0KPiAN
Cj4gSSdtIG5vdCBzZWVpbmcgYW55IHJhY2VzIGluIHRoZXJlIGV4cGVjdCBmb3IgdGhlIHBvc3Np
YmxlIG92ZXItb3B0aW1pemF0aW9uIG9mDQo+IGlycV93b3JrX3N5bmMoKSB0aGF0IEkgd2FzIHRh
bGtpbmcgYWJvdXQgYmVmb3JlLg0KPiANCj4gQ2hlZXJzIQ0KDQpUaGFua3MsDQpUaGVuIEkgaGF2
ZSB0byBkZWJ1ZyBpdCBteXNlbGYsIG1hbnkgaS5NWCBwbGF0Zm9ybXMgQ1BVIGhvdC1wbHVnIGFy
ZSBicm9rZW4NCnN1ZGRlbmx5LCB3aGlsZSBvbGQga2VybmVsIHZlcnNpb25zICg0LjE5KSBhcmUg
cnVubmluZyBqdXN0IGZpbmUuIA0KDQpBbnNvbg0KDQo=
