Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58749606D66
	for <lists+linux-pm@lfdr.de>; Fri, 21 Oct 2022 04:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJUCGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 22:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJUCG2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 22:06:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BBB1AE2A4
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 19:06:27 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mtnl70CJFzmVHX;
        Fri, 21 Oct 2022 10:01:39 +0800 (CST)
Received: from kwepemm000014.china.huawei.com (7.193.23.6) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:06:25 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm000014.china.huawei.com (7.193.23.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:06:24 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2375.031;
 Fri, 21 Oct 2022 10:06:24 +0800
From:   zhangqilong <zhangqilong3@huawei.com>
To:     Ido Schimmel <idosch@idosch.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSB0aGVybWFsL29mOiBGaXggcG9zc2libGUgbWVtbGVh?=
 =?gb2312?B?ayBpbiB0aGVybWFsX29mX3pvbmVfcmVnaXN0ZXIoKQ==?=
Thread-Topic: [PATCH] thermal/of: Fix possible memleak in
 thermal_of_zone_register()
Thread-Index: AQHY5HEaK1iX/X6ZikmA1e0xjM/5264YGepA
Date:   Fri, 21 Oct 2022 02:06:24 +0000
Message-ID: <9ecb5384d05a43918c0b4c7890340f89@huawei.com>
References: <20221020080048.56377-1-zhangqilong3@huawei.com>
 <Y1Em16K5jxk3BQ0h@shredder>
In-Reply-To: <Y1Em16K5jxk3BQ0h@shredder>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.246]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBPbiBUaHUsIE9jdCAyMCwgMjAyMiBhdCAwNDowMDo0OFBNICswODAwLCBaaGFuZyBRaWxvbmcg
d3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX29mLmMNCj4g
PiBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX29mLmMgaW5kZXggZDRiNjMzNWFjZTE1Li5mYzhm
YTI3NDgwYTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfb2YuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX29mLmMNCj4gPiBAQCAtNTk2LDEwICs1
OTYsNiBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZQ0KPiAqdGhlcm1hbF9vZl96b25lX3Jl
Z2lzdGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqc2Vuc29yLA0KPiA+ICAJaW50IG50cmlwcywgbWFz
azsNCj4gPiAgCWludCByZXQ7DQo+ID4NCj4gPiAtCW9mX29wcyA9IGttZW1kdXAob3BzLCBzaXpl
b2YoKm9wcyksIEdGUF9LRVJORUwpOw0KPiA+IC0JaWYgKCFvZl9vcHMpDQo+ID4gLQkJcmV0dXJu
IEVSUl9QVFIoLUVOT01FTSk7DQo+ID4gLQ0KPiA+ICAJbnAgPSBvZl90aGVybWFsX3pvbmVfZmlu
ZChzZW5zb3IsIGlkKTsNCj4gPiAgCWlmIChJU19FUlIobnApKSB7DQo+ID4gIAkJaWYgKFBUUl9F
UlIobnApICE9IC1FTk9ERVYpDQo+ID4gQEAgLTYyNiw2ICs2MjIsMTIgQEAgc3RydWN0IHRoZXJt
YWxfem9uZV9kZXZpY2UNCj4gKnRoZXJtYWxfb2Zfem9uZV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNl
X25vZGUgKnNlbnNvciwNCj4gPiAgCQlnb3RvIG91dF9rZnJlZV90cmlwczsNCj4gPiAgCX0NCj4g
Pg0KPiA+ICsJb2Zfb3BzID0ga21lbWR1cChvcHMsIHNpemVvZigqb3BzKSwgR0ZQX0tFUk5FTCk7
DQo+ID4gKwlpZiAoIW9mX29wcykgew0KPiA+ICsJCXJldCA9IC1FTk9NRU07DQo+ID4gKwkJZ290
byBvdXRfa2ZyZWVfdHpwOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCW9mX29wcy0+Z2V0X3RyaXBf
dHlwZSA9IG9mX29wcy0+Z2V0X3RyaXBfdHlwZSA/IDoNCj4gb2ZfdGhlcm1hbF9nZXRfdHJpcF90
eXBlOw0KPiA+ICAJb2Zfb3BzLT5nZXRfdHJpcF90ZW1wID0gb2Zfb3BzLT5nZXRfdHJpcF90ZW1w
ID8gOg0KPiBvZl90aGVybWFsX2dldF90cmlwX3RlbXA7DQo+ID4gIAlvZl9vcHMtPmdldF90cmlw
X2h5c3QgPSBvZl9vcHMtPmdldF90cmlwX2h5c3QgPyA6DQo+ID4gb2ZfdGhlcm1hbF9nZXRfdHJp
cF9oeXN0OyBAQCAtNjU2LDYgKzY1OCw3IEBAIHN0cnVjdA0KPiB0aGVybWFsX3pvbmVfZGV2aWNl
ICp0aGVybWFsX29mX3pvbmVfcmVnaXN0ZXIoc3RydWN0IGRldmljZV9ub2RlDQo+ICpzZW5zb3Is
DQo+ID4gIAlyZXR1cm4gdHo7DQo+ID4NCj4gPiAgb3V0X2tmcmVlX3R6cDoNCj4gPiArCWtmcmVl
KG9mX29wcyk7DQo+ID4gIAlrZnJlZSh0enApOw0KPiA+ICBvdXRfa2ZyZWVfdHJpcHM6DQo+ID4g
IAlrZnJlZSh0cmlwcyk7DQo+IA0KPiBUaGUgcGF0Y2ggbG9va3MgY29ycmVjdCwgYnV0IGl0IGNh
biBiZSBjbGVhbmVyLiBJZGVhbGx5LCB5b3Ugd291bGQgaGF2ZSBhDQo+IHNlcGFyYXRlIGxhYmVs
IHRvIGZyZWUgJ29mX29wcycgbGlrZSB3ZSBoYXZlIGZvciBvdGhlciB2YXJpYWJsZXMuDQo+IEFs
c28sIHRoZSBlcnJvciBwYXRoIGlzIG5vdCBzeW1tZXRyaWMgd2l0aCB0aGVybWFsX29mX3pvbmVf
dW5yZWdpc3RlcigpDQo+IHdoZXJlIHRoaXMgdmFyaWFibGUgaXMgdGhlIGxhc3QgdG8gYmUgZnJl
ZWQsIG5vdCB0aGUgZmlyc3QuDQo+IA0KPiBJIGFsc28gZW5jb3VudGVyZWQgdGhpcyBpc3N1ZSBh
bmQgcG9zdGVkIGEgcGF0Y2g6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBtLzIw
MjIxMDIwMTAzNjU4LjgwMjQ1Ny0xLQ0KPiBpZG9zY2hAbnZpZGlhLmNvbS8NCj4gDQo+IFVubGVz
cyB5b3Ugc2VlIHNvbWV0aGluZyB3cm9uZyB3aXRoIGl0LCBjYW4geW91IHBsZWFzZSB0ZXN0IGFu
ZCBzZWUgaWYgaXQNCj4gZml4ZXMgeW91ciBpc3N1ZT8NCj4gDQoNCkhpLA0KDQpJdCBsb29rcyBn
b29kIHRvIG1lIQ0KDQpUaGFua3MsDQpaaGFuZw0KDQo+IFRoYW5rcw0KDQo=
