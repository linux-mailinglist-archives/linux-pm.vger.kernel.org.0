Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E95577D82
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiGRI3G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 04:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiGRI3G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 04:29:06 -0400
Received: from m151.mail.126.com (m151.mail.126.com [220.181.15.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AA2F63DC
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=9VKME
        ScUdfVnh7PDAM2MGpF7yFEY8NBIlwMOuI14sbw=; b=Adm7UwskyixnVeBiIrbzv
        8jUxyx6zalsR44KAACnoJK1cVXv8UMmMyhCPy8XytV8ahMrwdHC/mELum631Fn4b
        5V/Qq0pN3xpTSvdRkV5vE03MGfKArdwrMcuqqPY4oQ7NNTpQvlSmQfHS1aWlvuEv
        0V/K3Hk7mA62akLxvWzzhM=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr1
 (Coremail) ; Mon, 18 Jul 2022 16:28:15 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Mon, 18 Jul 2022 16:28:15 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Viresh Kumar" <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re:Re: [PATCH] OPP: Fix two refcount bugs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220718070848.s6qziqkr3nmv32fc@vireshk-i7>
References: <20220715144712.444104-1-windhl@126.com>
 <20220718070848.s6qziqkr3nmv32fc@vireshk-i7>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <4af1805a.2b51.182106c170c.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AcqowADH2LCgGdViEOYiAA--.56170W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgBCF18RPg79WQAAsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CkF0IDIwMjItMDctMTggMTU6MDg6NDgsICJWaXJlc2ggS3VtYXIiIDx2aXJlc2gua3VtYXJAbGlu
YXJvLm9yZz4gd3JvdGU6Cj5PbiAxNS0wNy0yMiwgMjI6NDcsIExpYW5nIEhlIHdyb3RlOgo+PiBJ
biBkcml2ZXJzL29wcC9vZi5jLCB0aGVyZSBhcmUgdHdvIHJlZmNvdW50IGJ1Z3M6Cj4+ICgxKSBp
biBfb2ZfaW5pdF9vcHBfdGFibGUoKSwgb2ZfcHV0X25vZGUoKSBpbiB0aGUgbGFzdCBsaW5lIGlz
IG5vdAo+PiBuZWVkZWQgYXMgdGhlICdvcHBfbnAnIGlzIGVzY2FwZWQgb3V0IGludG8gJ29wcF90
YWJsZS0+bnAnIGFuZAo+PiChr29wcF90YWJsZScgaXMgYW4gb3V0IHBhcmFtZXRlci4KPj4gKDIp
IGluIF9vcHBfYWRkX3N0YXRpY192MigpLCB3ZSBuZWVkIGNhbGwgb2Zfbm9kZV9nZXQoKSBmb3Ig
dGhlIG5ldwo+PiByZWZlcmVuY2UgY3JlYXRlZCB3aGVuICJuZXdfb3BwLT5ucCA9IG5wOyIgYXMg
bmV3X29wcCBpcyBlc2NhcGVkIG91dC4KPj4gSGVyZSB3ZSBzaG91bGQgYWxzbyB0YWtlIGNhcmUg
b2YgdGhlIG9mX25vZGVfcHV0KCkgd2hlbiAnbmV3X29wcCcgaXMKPj4gZnJlZWQgYmFzZWQgb24g
dGhlIGZ1bmN0aW9uIGRlc2NyaXB0aW9uOiAiVGhlIG9wcCBjYW4gYmUgY29udHJvbGxlZAo+PiAu
Li4gYW5kIG1heSBiZSByZW1vdmVkIGJ5IGRldl9wbV9vcHBfcmVtb3ZlIi4KPj4gTk9URTogX29w
cF9hZGRfc3RhdGljX3YyKCkgaXMgY2FsbGVkIGJ5IF9vZl9hZGRfb3BwX3RhYmxlX3YyKCkgaW4g
YQo+PiBmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZSgpIHdoaWNoIHdpbGwgYXV0b21h
dGljYWxseSBpbmNyZWFzZQo+PiBhbmQgZGVjcmVhc2UgdGhlIHJlZmNvdW50LiBTbyB3ZSBuZWVk
IGFuIGFkZGl0aW9uYWwgb2Zfbm9kZV9nZXQoKQo+PiBmb3IgdGhlIG5ldyByZWZlcmVuY2UgY3Jl
YXRlZCBpbiBfb3BwX2FkZF9zdGF0aWNfdjIoKS4KPj4gCj4+IEZpeGVzOiBmMDZlZDkwZTcwNTEg
KCJPUFA6IFBhcnNlIE9QUCB0YWJsZSdzIERUIHByb3BlcnRpZXMgZnJvbSBfb2ZfaW5pdF9vcHBf
dGFibGUoKSIpCj4+IEZpeGVzOiAyNzQ2NTkwMjljOWQgKCJQTSAvIE9QUDogQWRkIHN1cHBvcnQg
dG8gcGFyc2UgIm9wZXJhdGluZy1wb2ludHMtdjIiIGJpbmRpbmdzIikKPgo+VGhlIHdheSBJIGRl
c2lnbmVkIHRoZSBPUFAgY29yZSB0aGVuIHdhcyB0byBtYWtlIHN1cmUgdGhhdCBucCBpcyBvbmx5
IHVzZWQgZm9yCj5wb2ludGVyIGNvbXBhcmlzb24gYW5kIG5vdGhpbmcgZWxzZSBhZnRlciBpdCBp
cyBmcmVlZCBieSBjYWxsaW5nIG9mX25vZGVfcHV0KCkuCj5TbyBpdCBpc24ndCBhIGJ1Zy4KPgo+
QnV0IEkgZG8gdW5kZXJzdGFuZCB0aGF0IGl0IGhhcyBiZWNvbWUgZGlmZmljdWx0IHRvIHRyYWNr
IG5vdyBpZiBucCBjYW4gZ2V0IHVzZWQKPmxhdGVyIG9uIGZvciBvdGhlciBzdHVmZiBhcyB3ZWxs
IG9yIG5vdCBhbmQgaXQgd291bGQgYmUgYmV0dGVyIHRvIGtlZXAgdGhlCj5yZWZlcmVuY2UgdXAg
aW4gc3VjaCBhIGNhc2UuCj4KPlRoYXQgaXMsIHlvdSBjYW4gZHJvcCB0aGUgRml4ZXMgdGFnIGFz
IEkgZG9uJ3Qgd2FudCB0aGVzZSB0byBnZXQgYmFja3BvcnRlZCwgYnV0Cj55ZXMgcGF0Y2hlcyBh
cmUgd2VsY29tZS4KPgoKSSB3aWxsIGRyb3AgdGhlIGZpeCB0YWdzIGluIG5ldyBwYXRjaGVzLgoK
PlBsZWFzZSBwcmVwYXJlIHR3byBzZXBhcmF0ZSBwYXRjaGVzLCBvbmUgZm9yIG9wcF90YWJsZS0+
bnAgYW5kIG9uZSBmb3Igb3BwLT5ucC4KPkl0IGlzIGZpbmUgdG8gYWRkIG11bHRpcGxlIHBhdGNo
ZXMgZXZlbiBmb3IgdGhlIG9wcC0+bnAgY2FzZSwgaWYgdGhlIHJlYXNvbmluZwo+aXMgZGlmZmVy
ZW50Lgo+CgpUaGFua3MsIFZpcmVzaCwKCkJ1dCBpcyBpdCBPSyBpZiB0aGUgdHdvIHBhdGNoZXMg
Y2hhbmdlIHRoZSBzYW1lIGZpbGUgYXQgc2FtZSB0aW1lo78KCkkgd29uZGVyIGlmIHRoaXMgd2ls
bCB0cm91YmxlIHlvdSB0byBtZXJnZSB0aGVtIGxhdGVyLgoKSWYgaXQgaXMgT0ssIEkgd2lsbCBi
ZWdpbiB0byBwcmVwYXJlIHRoZSB0d28gcGF0Y2hlcyBiYXNlZCBvbiBzYW1lIGZpbGUuCgoKPj4g
U2lnbmVkLW9mZi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPgo+PiAtLS0KPj4gIGRyaXZl
cnMvb3BwL2NvcmUuYyB8IDEgKwo+PiAgZHJpdmVycy9vcHAvb2YuYyAgIHwgMyArLS0KPj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+PiAKPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvb3BwL2NvcmUuYyBiL2RyaXZlcnMvb3BwL2NvcmUuYwo+PiBpbmRl
eCA4NDA2M2VhZWJiOTEuLjcwNzc1MzYyZWIwNSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9vcHAv
Y29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvb3BwL2NvcmUuYwo+PiBAQCAtMTU3Niw2ICsxNTc2LDcg
QEAgc3RhdGljIHZvaWQgX29wcF9rcmVmX3JlbGVhc2Uoc3RydWN0IGtyZWYgKmtyZWYpCj4+ICAJ
bGlzdF9kZWwoJm9wcC0+bm9kZSk7Cj4+ICAJbXV0ZXhfdW5sb2NrKCZvcHBfdGFibGUtPmxvY2sp
Owo+PiAgCj4+ICsJb2Zfbm9kZV9wdXQob3BwLT5ucCk7Cj4+ICAJLyoKPj4gIAkgKiBOb3RpZnkg
dGhlIGNoYW5nZXMgaW4gdGhlIGF2YWlsYWJpbGl0eSBvZiB0aGUgb3BlcmFibGUKPj4gIAkgKiBm
cmVxdWVuY3kvdm9sdGFnZSBsaXN0Lgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9vcHAvb2YuYyBi
L2RyaXZlcnMvb3BwL29mLmMKPj4gaW5kZXggMzAzOTQ5MjlkNzAwLi4wYTM4ZmMyYzBmMDUgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvb3BwL29mLmMKPj4gKysrIGIvZHJpdmVycy9vcHAvb2YuYwo+
PiBAQCAtMjQyLDcgKzI0Miw2IEBAIHZvaWQgX29mX2luaXRfb3BwX3RhYmxlKHN0cnVjdCBvcHBf
dGFibGUgKm9wcF90YWJsZSwgc3RydWN0IGRldmljZSAqZGV2LAo+PiAgCW9wcF90YWJsZS0+bnAg
PSBvcHBfbnA7Cj4+ICAKPj4gIAlfb3BwX3RhYmxlX2FsbG9jX3JlcXVpcmVkX3RhYmxlcyhvcHBf
dGFibGUsIGRldiwgb3BwX25wKTsKPj4gLQlvZl9ub2RlX3B1dChvcHBfbnApOwo+Cj5XaGVyZSBk
b2VzIHRoaXMgZ2V0IGRyb3BwZWQgbm93ID8KPgoKQWZ0ZXIgSSByZWFkIHRoZSBjb2RlLCBJIHRo
aW5rIGl0IGlzIGJldHRlciB0byBkcm9wIG9wcF90YWJsZS0+bnAgaW4gJ19vcHBfdGFibGVfa3Jl
Zl9yZWxlYXNlJwpqdXN0IGxpa2Ugd2UgZG8gZm9yIHRoZSAnb3BwLT5ucCcgaW4gJ19vcHBfa3Jl
Zl9yZWxlYXNlJy4KCklmIGl0IGlzIG5vdCBPSywgcGxlYXNlIGNvcnJlY3QgbWUuCgo+WyAuLi4g
XQoKPkFsc28sIHBsZWFzZSByZWJhc2Ugb24gbGludXgtbmV4dC9tYXN0ZXIsIGluIGNhc2UgeW91
IGhhdmVuJ3QuCgpJIHdpbGwgcmViYXNlIG9uIGxpbnV4LW5leHQvbWFzdGVyIGluIGZ1dHVyZSBw
YXRjaCB3b3JrLgoKVGhhbmtzLCAKCkxpYW5nCgoKCgoK
