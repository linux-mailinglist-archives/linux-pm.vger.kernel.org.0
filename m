Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA83905B7
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhEYPnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 11:43:01 -0400
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:7587
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229704AbhEYPnA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 May 2021 11:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7+2rKsvEARZa4akZOCB3mC+BT770hjT0/5EU1QblEzVHQ7/1h/kTppaoCppvt1QIJSxjNd1hgbdscqjQ2k4jb6Q9RCV6ZIpmTYBfeaYvawVHArnO4Y0KcM65AEm7j8x9eXq8bTH7Gqz/tuvU0Sb0+xsUc0t5aFAI6nh7tdm4dRlCamG6WTIpK7u753FlKG6L2Vhza0ya/Dc3vrXwkUfxULfbPYO+ynvuMWnbz8u/UxX5H6UXwlZWeiTPNkoX5MB2SMY39R0KXZbQ0FPiQ/a2qlgpBI/WRghrYzlZjObr5UfKFgolOnEvBoGKZZyZEP6u4tZ5qqJ3Zx67NJwUjJiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H8AuORie/0zuni1TpOApbUis0k2/0zVkU6gWRxSows=;
 b=hnZ/DecxqzSKMd6x2CZjI+KNdKroJiqtb9ZntE4YaADynQgM6QPw2oqaWuxa9jjGMC/+uBFm44TwAoJbitXQunfMNFx6LxPwLdeIl7cwaVlrqOTc8u1o2D5qkqRZnW3QMUW5VtYanKqL+wiiY6Rfkt3FEEHyH2fo1PJLniEghqXJnLLuuHRfk9GkMahrVZNZ69nlgRuCV0BtQV9glwuAt7bs/js06WAzc4JM2E2lQloKH2Tg5LzrucRWo2J9A+wYN+EZT8maM3t+IhpPFeZ6POiX/pWlNy/NfpOw5O2uJfBDqWBRzWOFRmu0NmReXm8wiPK2B1+NgyyDzWcDqK5ckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H8AuORie/0zuni1TpOApbUis0k2/0zVkU6gWRxSows=;
 b=S84U7v2OwXdAdhj6wz9CAL4PnpBBGPl2NjcSEeSUah11ScWcljLHhacbePdOlwm9aXDn5+L4EWiLmHSRVV/KjqR6KdYSo2hAWSuB4qxjNo9roTgHbVrI6jsSHwn7U6BXCVaZD9USoxyBAwDlVrThjTtOiV9BU8Fa7X+19+qjejk=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2395.eurprd03.prod.outlook.com (2603:10a6:3:6d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Tue, 25 May 2021 15:41:23 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 15:41:23 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/9] rtc: bd70528: Drop BD70528 support
Thread-Topic: [PATCH 2/9] rtc: bd70528: Drop BD70528 support
Thread-Index: AQHXUU66OMBDD7qDREeYJ8kT72eroar0FLwAgAADjICAABNSAIAAKpsA
Date:   Tue, 25 May 2021 15:41:22 +0000
Message-ID: <415e1380be70a12bf2dc68b153239d1f88527c8f.camel@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
         <2beaa677bde0f9516f366b97e91419598f1dfde4.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
         <YKzjtml4GL+dhP6j@piout.net>
         <83c091bef8adecd06a5c6fac9c86ca572bcc06d4.camel@fi.rohmeurope.com>
         <YKz25PDL2Z6vgqJv@piout.net>
In-Reply-To: <YKz25PDL2Z6vgqJv@piout.net>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ac4b15c-4788-4f09-08db-08d91f938cba
x-ms-traffictypediagnostic: HE1PR0301MB2395:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB239510E671E2CC8EA8AE389DAD259@HE1PR0301MB2395.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nh9IfVuhJm9pbzdDMn3fmFZpXJ1GpbjVMqgLwNmFspoK8X3FNzDBzaak0enmX5zzdObyUG9c6i4Vdz6Z9GDjKvwkeRf/FnVLuWT/rVdHMkh07pDC5ISMQqldveWMibKfXnKPtU+B7MycuZLRuZFuFPW2/a/moOvNiA1uDLFMmyvAyllwtxDVgtdrI+0wXqjPuF+ZMA5zqMS4AoYPHhjFdumI8bnntellNAmG5ze/9obulTXryzXrx7Q8h5zvVBQSxiUCameR6zamVk3CciCPMDpG32T98ADhPG/wHMHnWrDbcB2redFiMCwG8tWT4ZobPWttNNloQofHi5yyqYctc7bnsv9KzOv0MXb0IzeyXhn74kCR8pSIyoZ4H0OFqk+Y94o9ITLyEhL5s8DBffOGPXMuTAzMRjIbX9XZtYhA3yTwHqp5RTM7BhOOnn0IKWE6AoyOzTKLKbcvhulyvvhYAeRBrIiB4Ky0HAuSOrtOJ/JmbpVkdFnZcbVdvcFqdw9z5YjCZxYT1X5oujpfOVpPlC5Yu+zIHlNJCuIYt8cvOtOZVxeODCBG5LHgoENskmquFMiOuN/LEvfZfxAuW3CYzYvdU8pQb3p8nf0+ffiD28=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(136003)(396003)(376002)(6916009)(6486002)(6512007)(71200400001)(4326008)(5660300002)(7416002)(54906003)(478600001)(6506007)(186003)(66556008)(64756008)(38100700002)(3450700001)(86362001)(66446008)(66476007)(2906002)(66946007)(2616005)(83380400001)(316002)(8936002)(8676002)(4744005)(76116006)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TzRORGlyYjVpcWVPMkZtQTlVWmZXMGVLbUJYZFpuRzlKZUtIOCt2UDE2ek92?=
 =?utf-8?B?Z1VpWUJ4dHUxU1ROVzZnN1BKL0ZYYVp1L09zYjRBTUZPNFhWdUE5YnR3aUw2?=
 =?utf-8?B?Sk5sMTM1N3U3NUVtc0I4U1VRSmZKWXdiM3RTdGovQndEeHNaSzYzc3pReHZw?=
 =?utf-8?B?U1BEcWJERHplYWZEaWhCTDEvZ2N2cHI0d0NGbGgrMjdjYmJ4VTc3THVJY0tF?=
 =?utf-8?B?a2hHckJDcDMzUmFMdjYvRHpoS0I2TThGdW4rdmxpL0hmNXF6WFlEK2d4N2Vo?=
 =?utf-8?B?TkloMGN1WkthWjlwU01aNnJOVkRhTzVrcnZMWmlhQ0FmTzR5MHI1UXowcE9B?=
 =?utf-8?B?dkZHUXl2ZnhVQUd6RlExdmJySkpFeVl4TEd4VXFpdmoycVEyaGo5RTg5ZnhD?=
 =?utf-8?B?L1JvbkIxdER0S2RIMm04Tjk1YVllT2dkNkg3cSs4dWpMSWFjTW1DVWMvMkxK?=
 =?utf-8?B?VitJcDcwZS9NWVlrMFRCdWdmQ0dBczRZN08yemF1MEI0dUF2aDIxdmxaZnNH?=
 =?utf-8?B?THpZT1lhQXRuMGdjODFmOE1LMnppaDZ6Y1d4VjJEcFpsM1dubzY5SUJCTTI0?=
 =?utf-8?B?SWhZQytqV2ZpNDVlSVZIUUIwc2YvcjlmTVlrbFVMVTd3czFEaDhJS01kc2hy?=
 =?utf-8?B?SDZOOWduazdQeXNabUNWSURtVHgrVzdJUytzejBwSWZVR1dXWmh6L2gzdFps?=
 =?utf-8?B?bUZtMUUyWmtIWjlrbmsrVnNBaDc4MDZPeW5HazBmNS9jeVlLVFo0WmNBOEhi?=
 =?utf-8?B?Yk80V3VHbjRzblZHeU94R0Mvd1Z6Q0ovV3dRSWxmRm4ranF3amxEckxFdmJn?=
 =?utf-8?B?ZGpiei9rSGNkRGZWa2ptZlVPSXB1cmgwMzNqd1RPZlU2M0I4eUtuRkoxY1Jo?=
 =?utf-8?B?bVNWN1BWdit4M0g2S1FXeDFDYytsbVBoS045enN3bXU5U0Z6ajV3c1d0S2dv?=
 =?utf-8?B?cjA3K3dZd2xBS2NJemw0UGRDZVRxbHByOXFLcnBYOEp2WTlPN0JoTzJvQjln?=
 =?utf-8?B?UmtSVS9UOWpaUkVybEpKeGRVY0gzbHpIZExUdzE5VGxPbHduWXFFRlhHeHZ4?=
 =?utf-8?B?a1czTTQ4b3pwd2s1WDlrallmV3pXSm9odS9uYlZ1NVMybytkbjlDYXc0c1Bz?=
 =?utf-8?B?d2VDU215NUJISWc3REJ4bk9EWk1VYzgxRWpSSkNlK0J5c3BDcjkyS1oxMkN3?=
 =?utf-8?B?YXE5KzIzZ3RJOGx0TUZ2ZkdMWERvcVd0NzVhS2wyNlN0SEJ3b1I2MVhabUlB?=
 =?utf-8?B?aXhyMmJRRTd1K0RoL0hMbGEzVkJhL0NCcUJHYkdrU2NJUnlaUUN6NzlVTjZ0?=
 =?utf-8?B?R0MycVVaVHJ0MGtROTUxL3FxeHdVZG1qSTZsbXBwUUhpNFVCTWFnMVJuOXFw?=
 =?utf-8?B?MWdBbkljMWpaNjVZaEtLQ3pIZHNkSldwdUJrWGdlMllaNTNmdGVLQnNUMTVy?=
 =?utf-8?B?aERLMThCL1pBTzY0NnE4NEQzY2hWZHA3d0M4VkVFajJXZSsxb0MxMDlxOUdK?=
 =?utf-8?B?WUlFb0M4K3A5WGZJZnMrSmo0cTlCdHVQaVlOVzczbThXYWdLTVYyNFNYbUlY?=
 =?utf-8?B?VHQrRUlNeXU3VkNoV2Zzc0ZDM0g5OFRaK2FORUd4Q0FaaTlHNjR6ZWNVU1Rn?=
 =?utf-8?B?aEkwdVZXQ0dTNG1Nc0NJakUzM0dBNGUrMDFMcmtKT0RPLzRqbU8wOUJDMXFt?=
 =?utf-8?B?U0UwK0k5eW91b3VoT2ovbGVYSm8rZS90NEJZdDZZQzY2WXNHTWxUbUlyM1Jx?=
 =?utf-8?B?Wm1ScVM5ZlNXcVgyN3BGMzVCSDM4TmlhS2g4RHlrRExmQlZJRi9WbGl4YVM3?=
 =?utf-8?Q?C8he0ONOPMXdxs7b8lx+mv/OhCy/BeLRMsQ0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F60438707529274CB00F4BED112AA29E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac4b15c-4788-4f09-08db-08d91f938cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 15:41:22.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAca/d6ytpgX+Vn/vfoBx9rAosePh0Ufi4vD7BFQZ1h2zU2lYeXVPq8o3hkmpPmpqXFjvkc8kZelslDjP20kTf0oidpRp2lujSgO748HqLNP+G6xtqK1ylDNwI2mtGWw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2395
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBUdWUsIDIwMjEtMDUtMjUgYXQgMTU6MDggKzAyMDAsIEFsZXhhbmRyZSBCZWxsb25pIHdy
b3RlOg0KPiBPbiAyNS8wNS8yMDIxIDExOjU5OjU4KzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3Jv
dGU6DQo+ID4gQW5kIGluIGFueSBjYXNlIGFwcGx5aW5nIHRoZSBNRkQgYW5kIFJUQyBwYXRjaGVz
IHNob3VsZCBiZSBzeW5jZWQuDQo+ID4gUlRDDQo+ID4gcGFydHMgc2hvdWxkIGJlIGFwcGxpZWQg
YmVmb3JlIE1GRCBwYXJ0cyBiZWNhdXNlIGZldyBvdGhlciBQTUlDcw0KPiA+IHVzZQ0KPiA+IHRo
aXMgc2FtZSBSVEMgZHJpdmVyIGFuZCBjb21waWxhdGlvbiB3b3VsZCBmYWlsIHdpdGggbWlzc2lu
Zw0KPiA+IGhlYWRlcnMgaWYNCj4gPiBNRkQgd2FzIHJlbW92ZWQgYmVmb3JlIFJUQyBjaGFuZ2Vz
IGFyZSBhcHBsaWVkLg0KPiA+IA0KPiA+IFN1Z2dlc3Rpb25zIG9uIGhvdyB0byBndWFyYW50ZWUg
dGhlIG9yZGVyIG9mIE1GRCBhbmQgUlRDIC0gYW5kIGhvdw0KPiA+IHRvDQo+ID4gcmVzb2x2ZSBj
b25mbGljdHM/DQo+ID4gDQo+IA0KPiBUaGUgZWFzaWVzdCBpcyB0byB0YWtlIHRoZSBSVEMgcGF0
Y2hlcyBpbiBvbmUgY3ljbGUgYW5kIHRoZSByZXN0IGluDQo+IHRoZSBuZXh0IGN5Y2xlLg0KPiAN
Cj4gDQpUaGF0IHN1aXRzIG1lIGp1c3QgZmluZS4gU2hvdWxkIEkgcmVzZW5kIHRoZSBzZXJpZXMg
dy9vIE1GRCBjaGFuZ2VzIGFuZA0Kc2VuZCB0aGUgTUZEIHBhcnQgb25seSBhdCBuZXh0IGN5Y2xl
Pw0KDQpCZXN0IFJlZ2FyZHMNCglNYXR0aSBWYWl0dGluZW4NCg==
