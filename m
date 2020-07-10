Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9311B21C361
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jul 2020 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGKJmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jul 2020 05:42:22 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.123]:11898 "EHLO
        xiaomi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbgGKJmW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 11 Jul 2020 05:42:22 -0400
Received: from CNBOX05.mioffice.cn (10.237.8.125) by HKBOX1.mioffice.cn
 (10.56.8.141) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Jul
 2020 19:03:21 +0800
Received: from CNBOX07.mioffice.cn (10.237.8.127) by cnbox05.mioffice.cn
 (10.237.8.125) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Jul
 2020 19:03:21 +0800
Received: from CNBOX07.mioffice.cn ([10.237.8.127]) by CNBOX07.mioffice.cn
 ([10.237.8.127]) with mapi id 15.00.1497.006; Fri, 10 Jul 2020 19:03:21 +0800
From:   =?gb2312?B?RmVpMSBKaWFuZyC9r7fJ?= <jiangfei1@xiaomi.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Qiwu Huang <yanziily@gmail.com>
CC:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?u8bG5M7k?= <huangqiwu@xiaomi.com>
Subject: =?gb2312?B?tPC4tDogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCAzLzVdIHBvd2VyOiBz?=
 =?gb2312?B?dXBwbHk6IGNvcmU6IGFkZCB3aXJlbGVzcyBzaWduYWwgc3RyZW5ndGggcHJv?=
 =?gb2312?Q?perty?=
Thread-Topic: [External Mail]Re: [PATCH 3/5] power: supply: core: add wireless
 signal strength property
Thread-Index: AQHWVqEGcOKSTFylU0y9/k4lIRbmAKkApV9A
Date:   Fri, 10 Jul 2020 11:03:21 +0000
Message-ID: <42c16fa4740244a3975bfa84b04d6574@CNBOX07.mioffice.cn>
References: <20200710084841.1933254-1-yanziily@gmail.com>
 <20200710084841.1933254-3-yanziily@gmail.com>
 <20200710100106.GC1197607@kroah.com>
In-Reply-To: <20200710100106.GC1197607@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR3JlZywNCg0KL3N5cy9jbGFzcy9wb3dlcl9zdXBwbHkvPHN1cHBseV9uYW1lPi9zaWduYWxf
c3RyZW5ndGgNCldoYXQgdW5pdHMgYXJlIHRoaXMgaW4/ICBUaGUgInZhbHVlIiBtZWFucyB3aGF0
Pw0KDQotLT4gVW5pdCBpcyBLSFosIHRoZSByZXR1cm4gdmFsdWUgaXMgYWxzbyBpbnRlZ2VyLCB0
aGUgInZhbHVlIiBtZWFucyB0aGUgd29ya2luZyBmcmVxdWVuY3kgb2YgcmVjZWl2ZXIgY2hpcCBv
ZiB3aXJlbGVzcyBjaGFyZ2luZy4NCg0KQiZSDQpGZWkgSmlhbmcNCg0KLS0tLS3Tyrz+1K28/i0t
LS0tDQq3orz+yMs6IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0Kt6LLzcqx
vOQ6IDIwMjDE6jfUwjEwyNUgMTg6MDENCsrVvP7IyzogUWl3dSBIdWFuZyA8eWFuemlpbHlAZ21h
aWwuY29tPg0Ks63LzTogc3JlQGtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRmVpMSBKaWFuZyC9r7fJIDxqaWFuZ2ZlaTFA
eGlhb21pLmNvbT47ILvGxuTO5CA8aHVhbmdxaXd1QHhpYW9taS5jb20+DQrW98ziOiBbRXh0ZXJu
YWwgTWFpbF1SZTogW1BBVENIIDMvNV0gcG93ZXI6IHN1cHBseTogY29yZTogYWRkIHdpcmVsZXNz
IHNpZ25hbCBzdHJlbmd0aCBwcm9wZXJ0eQ0KDQpPbiBGcmksIEp1bCAxMCwgMjAyMCBhdCAwNDo0
ODozOVBNICswODAwLCBRaXd1IEh1YW5nIHdyb3RlOg0KPiBGcm9tOiBRaXd1IEh1YW5nIDxodWFu
Z3Fpd3VAeGlhb21pLmNvbT4NCj4NCj4gcmVwb3J0cyB3aXJlbGVzcyBzaWduYWwgc3RyZW5ndGgu
DQo+IFRoZSB2YWx1ZSBzaG93IGRlZ3JlZSBvZiBjb3VwbGluZyBiZXR3ZWVuIHR4IGFuZCByeC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogUWl3dSBIdWFuZyA8aHVhbmdxaXd1QHhpYW9taS5jb20+DQo+
IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1jbGFzcy1wb3dlciB8IDkg
KysrKysrKystDQo+ICBkcml2ZXJzL3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBwbHlfc3lzZnMuYyAg
IHwgMSArDQo+ICBpbmNsdWRlL2xpbnV4L3Bvd2VyX3N1cHBseS5oICAgICAgICAgICAgICAgIHwg
MSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtY2xhc3Mt
cG93ZXIgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWNsYXNzLXBvd2VyDQo+IGlu
ZGV4IDIwOTljZjE5NGE4OS4uMWY0MmFhMGMwNzFlIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWNsYXNzLXBvd2VyDQo+ICsrKyBiL0RvY3VtZW50YXRpb24v
QUJJL3Rlc3Rpbmcvc3lzZnMtY2xhc3MtcG93ZXINCj4gQEAgLTczMCw0ICs3MzAsMTEgQEAgRGVz
Y3JpcHRpb246DQo+DQo+ICBBY2Nlc3M6IFJlYWQtT25seQ0KPiAgVmFsaWQgdmFsdWVzOiAiQURB
UFRFUl9OT05FIiwgIkFEQVBURVJfU0RQIiwgIkFEQVBURVJfRENQIiwgIkFEQVBURVJfQ0RQIiwN
Cj4gLSJBREFQVEVSX1FDMiIsICJBREFQVEVSX1FDMyIsICJBREFQVEVSX1BEIiBvciBvdGhlciBw
cml2YXRlIGFkYXB0ZXIuDQo+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPiArIkFEQVBU
RVJfUUMyIiwgIkFEQVBURVJfUUMzIiwgIkFEQVBURVJfUEQiIG9yIG90aGVyIHByaXZhdGUgYWRh
cHRlci4NCj4gKw0KPiArV2hhdDovc3lzL2NsYXNzL3Bvd2VyX3N1cHBseS88c3VwcGx5X25hbWU+
L3NpZ25hbF9zdHJlbmd0aA0KPiArRGF0ZTpKdWwgMjAyMA0KPiArQ29udGFjdDpGZWkgSmlhbmcg
PGppYW5nZmVpMUB4aWFvbWkuY29tPg0KPiArRGVzY3JpcHRpb246DQo+ICtSZXBvcnRzIHdpcmVs
ZXNzIHNpZ25hbCBzdHJlbmd0aC4NCj4gK1RoZSB2YWx1ZSBzaG93IGRlZ3JlZSBvZiBjb3VwbGlu
Zy4NCg0KV2hhdCB1bml0cyBhcmUgdGhpcyBpbj8gIFRoZSAidmFsdWUiIG1lYW5zIHdoYXQ/DQoN
CnRoYW5rcywNCg0KZ3JlZyBrLWgNCiMvKioqKioqsb7Tyrz+vLDG5Li9vP66rNPQ0KHD17mry761
xLGjw9zQxc+io6y99s/e09q3osvNuPjJz8PmtdjWt9bQwdCz9rXEuPbIy7vyyLrX6aGjvfvWucjO
us7G5Mv7yMvS1MjOus7Qzsq9yrnTw6OosPzAqLWrsrvP3tPayKuyv7vysr+31rXY0LnCtqGiuLTW
xqGiu/LJoreio6mxvtPKvP7W0LXE0MXPoqGjyOe5+8T6tO3K1cHLsb7Tyrz+o6zH68T6waK8tLXn
u7C78tPKvP7NqNaqt6K8/sjLsqLJvrP9sb7Tyrz+o6EgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRh
Y2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hp
Y2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVz
cyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBo
ZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9y
IHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBw
ZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVk
LiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioq
LyMNCg==
