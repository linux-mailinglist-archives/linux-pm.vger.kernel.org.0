Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE757737D
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiGQC6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 22:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiGQC6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 22:58:33 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C72261DF
        for <linux-pm@vger.kernel.org>; Sat, 16 Jul 2022 19:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Ic+B6
        60ed7g3ej/bsoM+5CBq0RmQkFW+Cr49jwEetY8=; b=gnZmigA8bTL/9Qo9xPdvQ
        9Fdqlzpvfg0f+f/W8h8X+e6vdtEIGe3qHBCZ6uJ+K9HUq9PVO4e7TSjgOBuBW+dm
        qVxds5pTNt4rvIOnQ4Nb8JfxU2B1YsKK3z1DMQ7Apl0vx/y6pSj8RSqba0mkGeQB
        Bv5SMqLMD/O88JHiYbWXV0=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Sun, 17 Jul 2022 10:57:08 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Sun, 17 Jul 2022 10:57:08 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Daniel Lezcano" <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Linux PM" <linux-pm@vger.kernel.org>
Subject: Re:Re: [PATCH] thermal/core: Fix refcount bugs in
 __thermal_cooling_device_register()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <f9e72fdf-ec3e-d2bf-691e-70b51123566c@linaro.org>
References: <20220707062112.308239-1-windhl@126.com>
 <CAJZ5v0iOF3n98byY5C4zAjM=AbxDiUHF9vqEp78i6_jg8M5MqQ@mail.gmail.com>
 <f9e72fdf-ec3e-d2bf-691e-70b51123566c@linaro.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <1cf907bc.6f2.1820a1695f9.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADXLPGFetNig6BKAA--.12639W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7R5AF1pEAaZotwACsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CgoKQXQgMjAyMi0wNy0xNyAwNjowMzo0NiwgIkRhbmllbCBMZXpjYW5vIiA8ZGFuaWVsLmxlemNh
bm9AbGluYXJvLm9yZz4gd3JvdGU6Cj5PbiAxNS8wNy8yMDIyIDE5OjE0LCBSYWZhZWwgSi4gV3lz
b2NraSB3cm90ZToKPj4gT24gVGh1LCBKdWwgNywgMjAyMiBhdCA4OjIxIEFNIExpYW5nIEhlIDx3
aW5kaGxAMTI2LmNvbT4gd3JvdGU6Cj4KPlsgLi4uIF0KPgo+Pj4gLSAgICAgICBjZGV2LT5ucCA9
IG5wOwo+Pj4gKyAgICAgICBjZGV2LT5ucCA9IG9mX25vZGVfZ2V0KG5wKTsKPj4+ICAgICAgICAg
IGNkZXYtPm9wcyA9IG9wczsKPj4+ICAgICAgICAgIGNkZXYtPnVwZGF0ZWQgPSBmYWxzZTsKPj4+
ICAgICAgICAgIGNkZXYtPmRldmljZS5jbGFzcyA9ICZ0aGVybWFsX2NsYXNzOwo+Pj4gQEAgLTk0
Nyw2ICs5NDcsNyBAQCBfX3RoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0IGRl
dmljZV9ub2RlICpucCwKPj4+ICAgICAgICAgIHJldHVybiBjZGV2Owo+Pj4KPj4+ICAgb3V0X2tm
cmVlX3R5cGU6Cj4+PiArICAgICAgIG9mX25vZGVfcHV0KGNkZXYtPm5wKTsKPj4+ICAgICAgICAg
IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfZGVzdHJveV9zeXNmcyhjZGV2KTsKPj4+ICAgICAgICAg
IGtmcmVlKGNkZXYtPnR5cGUpOwo+Pj4gICAgICAgICAgcHV0X2RldmljZSgmY2Rldi0+ZGV2aWNl
KTsKPj4+IEBAIC0xMTExLDYgKzExMTIsNyBAQCB2b2lkIHRoZXJtYWxfY29vbGluZ19kZXZpY2Vf
dW5yZWdpc3RlcihzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldikKPj4+Cj4+PiAg
ICAgICAgICBtdXRleF91bmxvY2soJnRoZXJtYWxfbGlzdF9sb2NrKTsKPj4+Cj4+PiArICAgICAg
IG9mX25vZGVfcHV0KGNkZXYtPm5wKTsKPj4gCj4+IENvdWxkIHRoaXMgYmUgZG9uZSByaWdodCBi
ZWZvcmUgdGhlCj4+IHRoZXJtYWxfY29vbGluZ19kZXZpY2VfZGVzdHJveV9zeXNmcygpIGJlbG93
PyAgVGhlbiB0aGUgc2VxdWVuY2Ugd291bGQKPj4gYmUgY29tcGxldGVseSBhbmFsb2dvdXMgdG8g
dGhlIGVycm9yIGNvZGUgcGF0aCBhYm92ZS4KPj4gCj4+PiAgICAgICAgICBpZGFfc2ltcGxlX3Jl
bW92ZSgmdGhlcm1hbF9jZGV2X2lkYSwgY2Rldi0+aWQpOwo+Pj4gICAgICAgICAgZGV2aWNlX2Rl
bCgmY2Rldi0+ZGV2aWNlKTsKPj4+ICAgICAgICAgIHRoZXJtYWxfY29vbGluZ19kZXZpY2VfZGVz
dHJveV9zeXNmcyhjZGV2KTsKPj4+IC0tCj4+IAo+PiBPdmVyYWxsLCB0aGlzIGxvb2tzIGxpa2Ug
YSBnZW51aW5lIGZpeCB0byBtZS4KPj4gCj4+IERhbmllbCwgd2hhdCBkbyB5b3UgdGhpbms/Cj4K
PlllcywgdGhlIG9mX25vZGVfcHV0KCkgaXMgb2Z0ZW4gbWlzc2luZyB3aGVuIHRoZXJlIGlzIHRo
ZSBmb3JfZWFjaF94eHggCj5PRiBBUEkuIEJ1dCBoZXJlIHRoZSBjZGV2LT5ucCBpcyBvbmx5IHVz
ZWQgdG8gY29tcGFyZSBwb2ludGVycyBzbyB1c2VkIAo+YXMgYW4gaWRlbnRpZmllciwgbm90IGRl
LXJlZmVyZW5jZWQganVzdCBjb21wYXJpbmcgdGhlIGFkZHJlc3Nlcy4KCj4KClRoYW5rcywgdGhp
cyBpcyBhIGdvb2QgbGVzc29uIHRoYXQgZXhwbGFpbnMgd2hlbiB0aGVyZSBpcyBubyBuZWVkCnRv
IHJlZmNvdW50IG5ldyByZWZlcmVuY2UuClNvIEkgdGhpbmsgdGhlcmUgaXMgYWxzbyBubyBuZWVk
IHRvIHBhdGNoIGFueXRoaW5nLCByaWdodD8KClRoYW5rcyBhZ2FpbiwKCkxpYW5nCgo+SXQgaXMg
dXNlZCB0byBiaW5kIGEgdGhlcm1hbCB6b25lIHdpdGggYSBjb29saW5nIGRldmljZToKPgo+dGhl
cm1hbF9vZi5jOiAgICAgICAgICAgICAgICAgICBpZiAodGNicC0+Y29vbGluZ19kZXZpY2UgPT0g
Y2Rldi0+bnApIHsKPnRoZXJtYWxfb2YuYzogICAgICAgICAgICAgICAgICAgaWYgKHRjYnAtPmNv
b2xpbmdfZGV2aWNlID09IGNkZXYtPm5wKSB7Cj4KPlRoYXQgaXMgcHJvYmFibHkgd2h5IG5vIHJl
ZmNvdW50IHdhcyB0YWtlbiBvbiB0aGlzIGRldmljZSBub2RlLgo+Cj5Nb3Jlb3ZlciwgdGhpcyB3
aWxsIGdvIGF3YXkgd2l0aCB0aGUgc2VyaWVzIHJld29ya2luZyB0aGUgdGhlcm1hbC1vZiBJIAo+
c2VudCBsYXN0IHdlZWsKCj4KPj4KPi0tIAo+PGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFy
by5vcmcgqaYgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCj4KPkZvbGxvdyBMaW5h
cm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8Cj48
aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8Cj48aHR0cDovL3d3dy5s
aW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwo=
