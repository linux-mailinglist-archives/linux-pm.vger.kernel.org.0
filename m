Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB60D1E0BFE
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 12:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbgEYKjy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 06:39:54 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:60824 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389720AbgEYKjy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 May 2020 06:39:54 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Mon, 25 May 2020 18:39:48
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Mon, 25 May 2020 18:39:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Kangjie Lu" <kjlu@umn.edu>, "Sebastian Reichel" <sre@kernel.org>,
        "Linux PM" <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] power: supply: bq24190_charger: fix runtime pm
 imbalance
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAJZ5v0j5XB_me9YSUemUaz6URair4CtRVSU1U6F62FWCi2SRJg@mail.gmail.com>
References: <20200520074309.19366-1-dinghao.liu@zju.edu.cn>
 <CAJZ5v0j5XB_me9YSUemUaz6URair4CtRVSU1U6F62FWCi2SRJg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <29d2d7f2.c835d.1724b6ac5fc.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCHIAR0oMtexCkGAA--.1585W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEJBlZdtORShQA8s8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbX0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r4DMIAIbVCY0x0Ix7I2Y4AK64vIr41lV2
        xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY6xC20s026xCa
        FVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s026x8GjcxK67
        AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUAVWUtwCS07vEIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIAIbVCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiBPbiBXZWQsIE1heSAyMCwgMjAyMCBhdCAxMDowMSBBTSBEaW5naGFvIExpdSA8ZGluZ2hhby5s
aXVAemp1LmVkdS5jbj4gd3JvdGU6Cj4gPgo+ID4gcG1fcnVudGltZV9nZXRfc3luYygpIGluY3Jl
bWVudHMgdGhlIHJ1bnRpbWUgUE0gdXNhZ2UgY291bnRlciBldmVuCj4gPiBpdCByZXR1cm5zIGFu
IGVycm9yIGNvZGUuIFRodXMgYSBwYWlyaW5nIGRlY3JlbWVudCBpcyBuZWVkZWQgb24KPiA+IHRo
ZSBlcnJvciBoYW5kbGluZyBwYXRoIHRvIGtlZXAgdGhlIGNvdW50ZXIgYmFsYW5jZWQuCj4gPgo+
ID4gU2lnbmVkLW9mZi1ieTogRGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+Cj4g
PiAtLS0KPiA+ICBkcml2ZXJzL3Bvd2VyL3N1cHBseS9icTI0MTkwX2NoYXJnZXIuYyB8IDQgKysr
LQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9zdXBwbHkvYnEyNDE5MF9jaGFyZ2VyLmMg
Yi9kcml2ZXJzL3Bvd2VyL3N1cHBseS9icTI0MTkwX2NoYXJnZXIuYwo+ID4gaW5kZXggNDUzZDYz
MzJkNDNhLi40ZjdjNmI2YWJiNTYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Bvd2VyL3N1cHBs
eS9icTI0MTkwX2NoYXJnZXIuYwo+ID4gKysrIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvYnEyNDE5
MF9jaGFyZ2VyLmMKPiA+IEBAIC00ODEsOCArNDgxLDEwIEBAIHN0YXRpYyBzc2l6ZV90IGJxMjQx
OTBfc3lzZnNfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LAo+ID4gICAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7Cj4gPgo+ID4gICAgICAgICByZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKGJkaS0+
ZGV2KTsKPiA+IC0gICAgICAgaWYgKHJldCA8IDApCj4gPiArICAgICAgIGlmIChyZXQgPCAwKSB7
Cj4gPiArICAgICAgICAgICAgICAgcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoYmRpLT5kZXYp
Owo+IAo+IFRoZSBhdXRvc3VzcGVuZCB0aGluZyBpcyBub3QgbmVjZXNzYXJ5IGhlcmUsIGJlY2F1
c2UgdGhlIHN1c3BlbmQgaXMKPiBub3QgZ29pbmcgdG8gd29yayBhbnl3YXkgZHVlIHRvIHRoZSBy
ZXN1bWUgZXJyb3IsIHNvIHRoaXMgY2FuIGJlCj4gX3B1dF9ub2lkbGUoKS4KPiAKPiBZb3UgbWln
aHQgYXMgd2VsbCBkbyBzb21ldGhpbmcgbGlrZQo+IAo+IGNvdW50ID0gcmV0Owo+IGdvdG8gb3V0
Owo+IAo+IGhlcmUgYW5kIGFkZCBhbiAib3V0IiBsYWJlbCBiZWZvcmUgdGhlIHBtX3J1bnRpbWVf
bWFya19sYXN0X2J1c3koKSBjYWxsLCB0aG91Z2guCj4gCj4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsKPiA+ICsgICAgICAgfQo+ID4KPiA+ICAgICAgICAgcmV0ID0gYnEyNDE5MF93cml0
ZV9tYXNrKGJkaSwgaW5mby0+cmVnLCBpbmZvLT5tYXNrLCBpbmZvLT5zaGlmdCwgdik7Cj4gPiAg
ICAgICAgIGlmIChyZXQpCj4gPiAtLQo+ID4gMi4xNy4xCj4gPgoKVGhhbmsgeW91IGZvciB5b3Vy
IGFkdmljZSEgSSB3aWxsIGZpeCB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgcGF0Y2guCgpS
ZWdhcmRzLApEaW5naGFvCg==
