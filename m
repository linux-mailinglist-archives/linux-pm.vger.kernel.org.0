Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B9F1DC5CF
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 05:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgEUDnc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 23:43:32 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:14028 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728327AbgEUDnb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 23:43:31 -0400
X-Greylist: delayed 72007 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 23:43:28 EDT
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 21 May 2020 11:42:55
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Thu, 21 May 2020 11:42:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     "Dmitry Osipenko" <digetx@gmail.com>, kjlu@umn.edu,
        devel@driverdev.osuosl.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pavel Machek" <pavel@ucw.cz>, "Len Brown" <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance
 on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200520150230.GC30374@kadam>
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn>
 <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com>
 <20200520150230.GC30374@kadam>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2a46539d.b977f.1723553aa81.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHkD6_+MVeENzlAQ--.38589W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUHBlZdtOOvVwAHsl
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbtIS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
        82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
        v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
        JwCS07vEFIxGxcIEc7CjxVA2Y2ka0xkIwI1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r
        48MIAIbVCY0x0Ix7I2Y4AK64vIr41lV2xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS
        07vE4x8a6x804xWlV2xY6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14
        v26r1j6r18MIAIbVC20s026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWU
        tVW8ZwCS07vEIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIAIbVCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lV2xY6IIF0xvE
        x4A2jsIE14v26r1j6r4UMIAIbVCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73U
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIERhbiwKCkkgYWdyZWUgdGhlIGJlc3Qgc29sdXRpb24gaXMgdG8gZml4IF9fcG1fcnVudGlt
ZV9yZXN1bWUoKS4gQnV0IHRoZXJlIGFyZSBhbHNvIAptYW55IGNhc2VzIHRoYXQgYXNzdW1lIHBt
X3J1bnRpbWVfZ2V0X3N5bmMoKSB3aWxsIGNoYW5nZSBQTSB1c2FnZSAKY291bnRlciBvbiBlcnJv
ci4gQWNjb3JkaW5nIHRvIG15IHN0YXRpYyBhbmFseXNpcyByZXN1bHRzLCB0aGUgbnVtYmVyIG9m
IHRoZXNlIAoicmlnaHQiIGNhc2VzIGFyZSBsYXJnZXIuIEFkanVzdGluZyBfX3BtX3J1bnRpbWVf
cmVzdW1lKCkgZGlyZWN0bHkgd2lsbCBpbnRyb2R1Y2UgCm1vcmUgbmV3IGJ1Z3MuIFRoZXJlZm9y
ZSBJIHRoaW5rIHdlIHNob3VsZCByZXNvbHZlIHRoZSAiYnVnIiBjYXNlcyBpbmRpdmlkdWFsbHku
CgpJIHRoaW5rIHRoYXQgRG1pdHJ5J3MgcGF0Y2ggaXMgbW9yZSByZWFzb25hYmxlIHRoYW4gbWlu
ZS4gCgpEaW5naGFvCgomcXVvdDtEYW4gQ2FycGVudGVyJnF1b3Q7ICZsdDtkYW4uY2FycGVudGVy
QG9yYWNsZS5jb20mZ3Q75YaZ6YGT77yaCj4gT24gV2VkLCBNYXkgMjAsIDIwMjAgYXQgMDE6MTU6
NDRQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOg0KPiA+IDIwLjA1LjIwMjAgMTI6NTEs
IERpbmdoYW8gTGl1INC/0LjRiNC10YI6DQo+ID4gPiBwbV9ydW50aW1lX2dldF9zeW5jKCkgaW5j
cmVtZW50cyB0aGUgcnVudGltZSBQTSB1c2FnZSBjb3VudGVyIGV2ZW4NCj4gPiA+IGl0IHJldHVy
bnMgYW4gZXJyb3IgY29kZS4gVGh1cyBhIHBhaXJpbmcgZGVjcmVtZW50IGlzIG5lZWRlZCBvbg0K
PiA+ID4gdGhlIGVycm9yIGhhbmRsaW5nIHBhdGggdG8ga2VlcCB0aGUgY291bnRlciBiYWxhbmNl
ZC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1
QHpqdS5lZHUuY24+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVn
cmEtdmRlL3ZkZS5jIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFn
aW5nL21lZGlhL3RlZ3JhLXZkZS92ZGUuYyBiL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS90ZWdyYS12
ZGUvdmRlLmMNCj4gPiA+IGluZGV4IGQzZTYzNTEyYTc2NS4uZGQxMzRhM2ExNWM3IDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS92ZGUuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZkZS92ZGUuYw0KPiA+ID4gQEAgLTc3
Nyw3ICs3NzcsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX3ZkZV9pb2N0bF9kZWNvZGVfaDI2NChzdHJ1
Y3QgdGVncmFfdmRlICp2ZGUsDQo+ID4gPiAgDQo+ID4gPiAgCXJldCA9IHBtX3J1bnRpbWVfZ2V0
X3N5bmMoZGV2KTsNCj4gPiA+ICAJaWYgKHJldCA8IDApDQo+ID4gPiAtCQlnb3RvIHVubG9jazsN
Cj4gPiA+ICsJCWdvdG8gcHV0X3J1bnRpbWVfcG07DQo+ID4gPiAgDQo+ID4gPiAgCS8qDQo+ID4g
PiAgCSAqIFdlIHJlbHkgb24gdGhlIFZERSByZWdpc3RlcnMgcmVzZXQgdmFsdWUsIG90aGVyd2lz
ZSBWREUNCj4gPiA+IA0KPiA+IA0KPiA+IEhlbGxvIERpbmdoYW8sDQo+ID4gDQo+ID4gVGhhbmsg
eW91IGZvciB0aGUgcGF0Y2guIEkgc2VudCBvdXQgYSBzaW1pbGFyIHBhdGNoIGEgd2VlayBhZ28g
WzFdLg0KPiA+IA0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJv
amVjdC9saW51eC10ZWdyYS9wYXRjaC8yMDIwMDUxNDIxMDg0Ny45MjY5LTItZGlnZXR4QGdtYWls
LmNvbS8NCj4gPiANCj4gPiBUaGUgcG1fcnVudGltZV9wdXRfbm9pZGxlKCkgc2hvdWxkIGhhdmUg
dGhlIHNhbWUgZWZmZWN0IGFzIHlvdXJzDQo+ID4gdmFyaWFudCwgYWx0aG91Z2ggbXkgdmFyaWFu
dCB3b24ndCBjaGFuZ2UgdGhlIGxhc3RfYnVzeSBSUE0gdGltZSwgd2hpY2gNCj4gPiBJIHRoaW5r
IGlzIGEgYml0IG1vcmUgYXBwcm9wcmlhdGUgYmVoYXZpb3IuDQo+IA0KPiBJIGRvbid0IHRoaW5r
IGVpdGhlciBwYXRjaCBpcyBjb3JyZWN0LiAgVGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGlzIHRvIGZp
eA0KPiBfX3BtX3J1bnRpbWVfcmVzdW1lKCkgc28gaXQgZG9lc24ndCBsZWFrIGEgcmVmZXJlbmNl
IGNvdW50IG9uIGVycm9yLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCBhIGxvdCBvZiBmdW5j
dGlvbnMgZG9uJ3QgY2hlY2sgdGhlIHJldHVybiBzbw0KPiBwb3NzaWJseSB3ZSBhcmUgcmVseWlu
ZyBvbiB0aGF0IGJlaGF2aW9yLiAgV2UgbWF5IG5lZWQgdG8gaW50cm9kdWNlIGENCj4gbmV3IGZ1
bmN0aW9uIHdoaWNoIGNsZWFucyB1cCBwcm9wZXJseSBpbnN0ZWFkIG9mIGxlYWtpbmcgcmVmZXJl
bmNlDQo+IGNvdW50cz8NCj4gDQo+IEFsc28gaXQncyBub3QgZG9jdW1lbnRlZCB0aGF0IHBtX3J1
bnRpbWVfZ2V0X3N5bmMoKSByZXR1cm5zIDEgc29tZXRpbWVzDQo+IG9uIHN1Y2Nlc3Mgc28gaXQg
bGVhZHMgdG8gYSBmZXcgYnVncy4NCj4gDQo+IGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jOiAg
ICAgICAgICAgICByZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKGRkZXYtPmRldik7DQo+IGRyaXZl
cnMvZ3B1L2RybS9zdG0vbHRkYy5jLSAgICAgICAgICAgICBpZiAocmV0KSB7DQo+IC0tDQo+IGRy
aXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jOiAgICAgICAgICAgICByZXQgPSBwbV9ydW50aW1lX2dl
dF9zeW5jKGRkZXYtPmRldik7DQo+IGRyaXZlcnMvZ3B1L2RybS9zdG0vbHRkYy5jLSAgICAgICAg
ICAgICBpZiAocmV0KSB7DQo+IA0KPiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMv
bXRrX3Zjb2RlY19kZWNfcG0uYzogIHJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMocG0tPmRldik7
DQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2RlY19wbS5j
LSAgaWYgKHJldCkNCj4gDQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vdGktdnBlL2NhbC5jOiAg
ICByZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKCZwZGV2LT5kZXYpOw0KPiBkcml2ZXJzL21lZGlh
L3BsYXRmb3JtL3RpLXZwZS9jYWwuYy0gICAgaWYgKHJldCkNCj4gDQo+IGRyaXZlcnMvbWZkL2Fy
aXpvbmEtY29yZS5jOiAgICAgICAgICAgICAgICAgICAgIHJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5
bmMoYXJpem9uYS0+ZGV2KTsNCj4gZHJpdmVycy9tZmQvYXJpem9uYS1jb3JlLmMtICAgICAgICAg
ICAgICAgICAgICAgaWYgKHJldCAhPSAwKQ0KPiANCj4gZHJpdmVycy9yZW1vdGVwcm9jL3Fjb21f
cTZ2NV9hZHNwLmM6ICAgIHJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoYWRzcC0+ZGV2KTsNCj4g
ZHJpdmVycy9yZW1vdGVwcm9jL3Fjb21fcTZ2NV9hZHNwLmMtICAgIGlmIChyZXQpDQo+IA0KPiBk
cml2ZXJzL3NwaS9zcGktaW1nLXNwZmkuYzogICAgIHJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMo
ZGV2KTsNCj4gZHJpdmVycy9zcGkvc3BpLWltZy1zcGZpLmMtICAgICBpZiAocmV0KQ0KPiANCj4g
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXBjaS5jOiAgICByZXQgPSBwbV9ydW50aW1lX2dldF9zeW5j
KCZkd2MzLT5kZXYpOw0KPiBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtcGNpLmMtICAgIGlmIChyZXQp
DQo+IA0KPiBkcml2ZXJzL3dhdGNoZG9nL3J0aV93ZHQuYzogICAgIHJldCA9IHBtX3J1bnRpbWVf
Z2V0X3N5bmMoZGV2KTsNCj4gZHJpdmVycy93YXRjaGRvZy9ydGlfd2R0LmMtICAgICBpZiAocmV0
KSB7DQo+IA0KPiByZWdhcmRzLA0KPiBkYW4gY2FycGVudGVyDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1l
LmMNCj4gaW5kZXggOTljN2RhMTEyYzk1Li5lMjgwOTkxYTk3N2QgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMNCj4gKysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3J1
bnRpbWUuYw0KPiBAQCAtMTA4Miw2ICsxMDgyLDkgQEAgaW50IF9fcG1fcnVudGltZV9yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2LCBpbnQgcnBtZmxhZ3MpDQo+ICAJcmV0dmFsID0gcnBtX3Jlc3Vt
ZShkZXYsIHJwbWZsYWdzKTsNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPnBvd2Vy
LmxvY2ssIGZsYWdzKTsNCj4gIA0KPiArCWlmIChyZXR2YWwgPCAwICYmIHJwbWZsYWdzICYgUlBN
X0dFVF9QVVQpDQo+ICsJCWF0b21pY19kZWMoJmRldi0+cG93ZXIudXNhZ2VfY291bnQpOw0KPiAr
DQo+ICAJcmV0dXJuIHJldHZhbDsNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKF9fcG1fcnVu
dGltZV9yZXN1bWUpOw0K
