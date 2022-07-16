Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF468576B52
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jul 2022 04:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGPCdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 22:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGPCdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 22:33:16 -0400
X-Greylist: delayed 1831 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 19:33:13 PDT
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAB9A18377
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 19:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=HnApO
        BaQtnvMXu8LOOo975c9QbDHJNctS6OX/79XihU=; b=NlbqtU+sRAPCIttcNmNxc
        ppI8X+grdAFcnQNGsjJ4ONgpzpj43qOcfLLyOa7gpdaA1ZtZfmMRErg1u19S/I3F
        koZgqUvUughHGMUX/7kwce9SWohuF+oE/ImXelGE9W/EZZJDdbw4SKT5n6sQWJCI
        nWFDasHFQ0YNN1DYrgPoqc=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Sat, 16 Jul 2022 10:00:41 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Sat, 16 Jul 2022 10:00:41 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Linux PM" <linux-pm@vger.kernel.org>
Subject: Re:Re: [PATCH] thermal/core: Fix refcount bugs in
 __thermal_cooling_device_register()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <CAJZ5v0iOF3n98byY5C4zAjM=AbxDiUHF9vqEp78i6_jg8M5MqQ@mail.gmail.com>
References: <20220707062112.308239-1-windhl@126.com>
 <CAJZ5v0iOF3n98byY5C4zAjM=AbxDiUHF9vqEp78i6_jg8M5MqQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4e28500a.6b9.18204bc8cd3.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowAAXHyfLG9JieTZJAA--.22509W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGhdAF1-HZgeRwAACsw
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CgoKQXQgMjAyMi0wNy0xNiAwMToxNDozMSwgIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmFmYWVsQGtl
cm5lbC5vcmc+IHdyb3RlOgo+T24gVGh1LCBKdWwgNywgMjAyMiBhdCA4OjIxIEFNIExpYW5nIEhl
IDx3aW5kaGxAMTI2LmNvbT4gd3JvdGU6Cj4+Cj4+IEZvciBlYWNoIG5ldyByZWZlcmVuY2Ugb2Yg
J2RldmljZV9ub2RlJywgd2Ugc2hvdWxkIGluY3JlYXNlIGl0cwo+PiByZWZjb3VudC4gT3RoZXJ3
aXNlLCB0aGVyZSB3aWxsIGJlIHByZW1hdHVyZSBmcmVlLgo+Pgo+PiBGb3IgZXhhbXBsZSwgaW4g
ZHJpdmVyc1x0aGVybWFsXHRlZ3JhXHNvY3RoZXJtLmMsIHRoZSBmdW5jdGlvbgo+PiBzb2N0aGVy
bV9pbml0X2h3X3Rocm90X2NkZXYoKSB3aWxsIHVzZSBmb3JfZWFjaF9jaGlsZF9vZl9ub2RlKCkg
dG8KPj4gaXRlcmF0ZSBpdHMgY2hpbGQgZGV2aWNlX25vZGUgd2hpY2ggd2lsbCBiZSB0aGVuIHBh
c3NlZCBpbnRvCj4+ICBfX3RoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIoKS4gQXMgZm9y
X2VhY2hfeHh4IE9GIEFQSXMgd2lsbAo+PiBhdXRvbWF0aWNhbGx5IGluY3JlYXNlIGFuZCBkZWNy
ZWFzZSB0aGUgcmVmY291bnQgb2YgJ2RldmljZV9ub2RlJywKPj4gd2Ugc2hvdWxkIHVzZSBhZGRp
dGlvbmFsIG9mX25vZGVfZ2V0KCkgdG8gcmVjb3JkIHRoZSBuZXcgcmVmZXJuZWNlLgo+Cj5yZWZl
cmVuY2UKClRoYW5rcyEKCj4KPj4KPj4gTk9URSwgd2Ugc2hvdWxkIGFsc28gY2FsbCB0aGUgY29y
cmVzcG9uZGluZyBvZl9ub2RlX3B1dCgpIGluIGZhaWwgcGF0aAo+PiBvciB3aGVuIHRoZSAqX3Vu
cmVnaXN0ZXIoKSBmdW5jdGlvbiBpcyBjYWxsZWQuCj4KPlRoZSBOT1RFIGluIGNhcGl0YWxzIGFi
b3ZlIGlzIHNvbWV3aGF0IGNvbmZ1c2luZy4gIEkgd291bGQganVzdCBzYXkKPiJBY2NvcmRpbmds
eSwgdGhlIGNvcnJlc3BvbmRpbmcgb2Zfbm9kZV9wdXQoKSBuZWVkcyB0byBiZSBydW4gaW4gdGhl
Cj5lcnJvciBjb2RlIHBhdGggYW5kIG9uIGNvb2xpbmcgZGV2aWNlIHVucmVnaXN0cmF0aW9uLiIK
PgpUaGFua3MsIEkgd2lsbCBjaGFuZ2UgdGhhdCBpbiBuZXcgdmVyc2lvbi4KCj4+Cj4+IEZpeGVz
OiBhMTE2YjVkNDRmMTQgKCJ0aGVybWFsOiBjb3JlOiBpbnRyb2R1Y2UgdGhlcm1hbF9vZl9jb29s
aW5nX2RldmljZV9yZWdpc3RlciIpCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5kaGxA
MTI2LmNvbT4KPj4gLS0tCj4+ICBJIGNhbm5vdCBjb25maXJtLCBpbiAqX3VucmVnaXN0ZXIsIHdl
IHNob3VsZCBwdXQgb2Zfbm9kZV9wdXQoKSBpbiBvcgo+PiBvdXQgb2YgdGhlICpfbG9jay8qX3Vu
bG9jayBmdW5jdGlvbnMuIFBsZWFzZSBjaGVjayBpdCBjYXJlZnVsbHkuCj4KPlRoaXMgZG9lc24n
dCBtYXR0ZXIgdG9vIG11Y2ggQUZBSUNTLgo+Cj5QbGVhc2Ugbm90ZSB0aGF0IHRoZSBvZl9ub2Rl
X3B1dCgpIGNhbiBzdGlsbCAibGVhayIgaW50byB0aGUgY3JpdGljYWwKPnNlY3Rpb24gdGhyb3Vn
aCB0aGUgInVubG9jayIgb3BlcmF0aW9uLCBiZWNhdXNlIHRoZSBsYXR0ZXIgaXMgbm90IGEKPmZ1
bGwgbWVtb3J5IGJhcnJpZXIuCj4KPk1vcmVvdmVyLCBkcm9wcGluZyB0aGUgcmVmZXJlbmNlIG1l
YW5zIHRoYXQgdGhlIG9iamVjdCBpbiBxdWVzdGlvbgo+d29uJ3QgYmUgdXNlZCBhbnkgbW9yZSBi
eSB0aGUgaG9sZGVyIG9mIHRoYXQgcmVmZXJlbmNlIGFuZCBpdCBpcyBubwo+cmVhc29uIEkgY2Fu
IHNlZSB3aHkgaXQgd291bGQgYmUgbmVjZXNzYXJ5IHRvIGhvbGQgdGhlIGxvY2sgd2hpbGUKPmRv
aW5nIHRoYXQuCj4KPj4gIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyB8IDQgKysrLQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIGIvZHJpdmVycy90aGVy
bWFsL3RoZXJtYWxfY29yZS5jCj4+IGluZGV4IGNkYzA1NTJlOGM0Mi4uYzQ1OWUyOTU4YjdiIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKPj4gKysrIGIvZHJp
dmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCj4+IEBAIC05MTksNyArOTE5LDcgQEAgX190aGVy
bWFsX2Nvb2xpbmdfZGV2aWNlX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsCj4+Cj4+
ICAgICAgICAgbXV0ZXhfaW5pdCgmY2Rldi0+bG9jayk7Cj4+ICAgICAgICAgSU5JVF9MSVNUX0hF
QUQoJmNkZXYtPnRoZXJtYWxfaW5zdGFuY2VzKTsKPj4gLSAgICAgICBjZGV2LT5ucCA9IG5wOwo+
PiArICAgICAgIGNkZXYtPm5wID0gb2Zfbm9kZV9nZXQobnApOwo+PiAgICAgICAgIGNkZXYtPm9w
cyA9IG9wczsKPj4gICAgICAgICBjZGV2LT51cGRhdGVkID0gZmFsc2U7Cj4+ICAgICAgICAgY2Rl
di0+ZGV2aWNlLmNsYXNzID0gJnRoZXJtYWxfY2xhc3M7Cj4+IEBAIC05NDcsNiArOTQ3LDcgQEAg
X190aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAs
Cj4+ICAgICAgICAgcmV0dXJuIGNkZXY7Cj4+Cj4+ICBvdXRfa2ZyZWVfdHlwZToKPj4gKyAgICAg
ICBvZl9ub2RlX3B1dChjZGV2LT5ucCk7Cj4+ICAgICAgICAgdGhlcm1hbF9jb29saW5nX2Rldmlj
ZV9kZXN0cm95X3N5c2ZzKGNkZXYpOwo+PiAgICAgICAgIGtmcmVlKGNkZXYtPnR5cGUpOwo+PiAg
ICAgICAgIHB1dF9kZXZpY2UoJmNkZXYtPmRldmljZSk7Cj4+IEBAIC0xMTExLDYgKzExMTIsNyBA
QCB2b2lkIHRoZXJtYWxfY29vbGluZ19kZXZpY2VfdW5yZWdpc3RlcihzdHJ1Y3QgdGhlcm1hbF9j
b29saW5nX2RldmljZSAqY2RldikKPj4KPj4gICAgICAgICBtdXRleF91bmxvY2soJnRoZXJtYWxf
bGlzdF9sb2NrKTsKPj4KPj4gKyAgICAgICBvZl9ub2RlX3B1dChjZGV2LT5ucCk7Cj4KPkNvdWxk
IHRoaXMgYmUgZG9uZSByaWdodCBiZWZvcmUgdGhlCj50aGVybWFsX2Nvb2xpbmdfZGV2aWNlX2Rl
c3Ryb3lfc3lzZnMoKSBiZWxvdz8gIFRoZW4gdGhlIHNlcXVlbmNlIHdvdWxkCj5iZSBjb21wbGV0
ZWx5IGFuYWxvZ291cyB0byB0aGUgZXJyb3IgY29kZSBwYXRoIGFib3ZlLgo+CgpUaGF0IHNvdWRz
IGdvb2QsIEkgd2lsbCBjaGFuZ2UgaXQgaW4gbmV3IHZlcnNpb24uCgo+PiAgICAgICAgIGlkYV9z
aW1wbGVfcmVtb3ZlKCZ0aGVybWFsX2NkZXZfaWRhLCBjZGV2LT5pZCk7Cj4+ICAgICAgICAgZGV2
aWNlX2RlbCgmY2Rldi0+ZGV2aWNlKTsKPj4gICAgICAgICB0aGVybWFsX2Nvb2xpbmdfZGV2aWNl
X2Rlc3Ryb3lfc3lzZnMoY2Rldik7Cj4+IC0tCj4KPk92ZXJhbGwsIHRoaXMgbG9va3MgbGlrZSBh
IGdlbnVpbmUgZml4IHRvIG1lLgo+Cj5EYW5pZWwsIHdoYXQgZG8geW91IHRoaW5rPwoKSSB3aWxs
IGFsc28gd2FpdCBEYW5pZWwncyByZXBvbnNlIGJlZm9yZSBJIHNlbmQgbmV3IHZlcnNpb24uCgpU
aGFua3MgYWdhaW4sCgpMaWFuZyAKCgo=
