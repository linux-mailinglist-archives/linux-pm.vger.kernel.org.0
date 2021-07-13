Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF53C7451
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhGMQWO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 12:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231428AbhGMQWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 12:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626193162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkVbvILKBq40WaEmHLBRSgoHvH/vzwrA0dUxLC2cHSE=;
        b=h4NVAU573xF6cAzB8SuI9BaVEwASb+RKGKVCOETmsdML3QHe8s8FsGt4NzHrPAskGWAbK7
        p8fBOY2ENmIXGh5LXEcHR3/Q2pQMNUxblg7UTRMj7xtCFTVlBsLWoZisZtYS98kQVPOoDu
        vG0qD+imlrDNaM7bcGWu3/VDOcl8h7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-kWE6OaooNECjV1bN-9szzQ-1; Tue, 13 Jul 2021 12:19:21 -0400
X-MC-Unique: kWE6OaooNECjV1bN-9szzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF48C1009444;
        Tue, 13 Jul 2021 16:19:19 +0000 (UTC)
Received: from localhost (ovpn-112-172.ams2.redhat.com [10.36.112.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 713906091B;
        Tue, 13 Jul 2021 16:19:19 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
        linux-block@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        virtualization@lists.linux-foundation.org,
        linux-pm@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 3/3] softirq: participate in cpuidle polling
Date:   Tue, 13 Jul 2021 17:19:06 +0100
Message-Id: <20210713161906.457857-4-stefanha@redhat.com>
In-Reply-To: <20210713161906.457857-1-stefanha@redhat.com>
References: <20210713161906.457857-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tm9ybWFsbHkgc29mdGlycXMgYXJlIGludm9rZWQgd2hlbiBleGl0aW5nIGlycXMuIFdoZW4gcG9s
bGluZyBpbiB0aGUKY3B1aWRsZSBkcml2ZXIgdGhlcmUgbWF5IGJlIG5vIGlycS4gVGhlcmVmb3Jl
IHBlbmRpbmcgc29mdGlycXMgZ28KdW5ub3RpY2VkIGFuZCBwb2xsaW5nIGNvbnRpbnVlcyB3aXRo
b3V0IGludm9raW5nIHRoZW0uCgpBZGQgYSBzb2Z0aXJxX3BvbGwoKSBmdW5jdGlvbiB0byBleHBs
aWNpdGx5IGNoZWNrIGZvciBhbmQgaW52b2tlCnNvZnRpcnFzLgoKU2lnbmVkLW9mZi1ieTogU3Rl
ZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KVGhpcyBjb21taXQgaXMgbm90
IG5lZWRlZCBmb3IgdmlydGlvLWJsay4gSSBhZGRlZCBpdCB3aGVuIEkgcmVhbGl6ZWQKdmlydGlv
LW5ldCdzIE5BUEkgc2NoZWR1bGluZyBtaWdodCBub3QgYmUgZGV0ZWN0ZWQgYnkgdGhlIGNwdWlk
bGUgYnVzeQp3YWl0IGxvb3AgYmVjYXVzZSBpdCBpcyB1bmF3YXJlIG9mIHNvZnRpcnFzLiBIb3dl
dmVyLCBldmVuIGFmdGVyIGRvaW5nCnRoaXMgdmlydGlvLW5ldCdzIE5BUEkgcG9sbGluZyBkb2Vz
bid0IGNvbWJpbmUgd2l0aCBjcHVpZGxlIGhhbHRwb2xsLgoKUGVyaGFwcyB0aGlzIHBhdGNoIGlz
IHN0aWxsIGRlc2lyYWJsZSBmb3IgY3B1aWRsZSBwb2xsX3N0YXRlIGluIGNhc2UgYQpzb2Z0aXJx
IGlzIHJhaXNlZD8KLS0tCiBpbmNsdWRlL2xpbnV4L2ludGVycnVwdC5oICAgICB8ICAyICsrCiBk
cml2ZXJzL2NwdWlkbGUvcG9sbF9zb3VyY2UuYyB8ICAzICsrKwoga2VybmVsL3NvZnRpcnEuYyAg
ICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaCBiL2luY2x1
ZGUvbGludXgvaW50ZXJydXB0LmgKaW5kZXggNDc3Nzg1MGE2ZGM3Li45YmZkY2M0NjZiYTggMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaW50ZXJydXB0LmgKKysrIGIvaW5jbHVkZS9saW51eC9p
bnRlcnJ1cHQuaApAQCAtNTczLDYgKzU3Myw4IEBAIHN0cnVjdCBzb2Z0aXJxX2FjdGlvbgogYXNt
bGlua2FnZSB2b2lkIGRvX3NvZnRpcnEodm9pZCk7CiBhc21saW5rYWdlIHZvaWQgX19kb19zb2Z0
aXJxKHZvaWQpOwogCitleHRlcm4gdm9pZCBzb2Z0aXJxX3BvbGwodm9pZCk7CisKIGV4dGVybiB2
b2lkIG9wZW5fc29mdGlycShpbnQgbnIsIHZvaWQgKCphY3Rpb24pKHN0cnVjdCBzb2Z0aXJxX2Fj
dGlvbiAqKSk7CiBleHRlcm4gdm9pZCBzb2Z0aXJxX2luaXQodm9pZCk7CiBleHRlcm4gdm9pZCBf
X3JhaXNlX3NvZnRpcnFfaXJxb2ZmKHVuc2lnbmVkIGludCBucik7CmRpZmYgLS1naXQgYS9kcml2
ZXJzL2NwdWlkbGUvcG9sbF9zb3VyY2UuYyBiL2RyaXZlcnMvY3B1aWRsZS9wb2xsX3NvdXJjZS5j
CmluZGV4IDQ2MTAwZTVhNzFlNC4uZWQyMDBmZWIwZGFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2Nw
dWlkbGUvcG9sbF9zb3VyY2UuYworKysgYi9kcml2ZXJzL2NwdWlkbGUvcG9sbF9zb3VyY2UuYwpA
QCAtNiw2ICs2LDcgQEAKICNpbmNsdWRlIDxsaW51eC9sb2NrZGVwLmg+CiAjaW5jbHVkZSA8bGlu
dXgvcGVyY3B1Lmg+CiAjaW5jbHVkZSA8bGludXgvcG9sbF9zb3VyY2UuaD4KKyNpbmNsdWRlIDxs
aW51eC9pbnRlcnJ1cHQuaD4KIAogLyogVGhlIHBlci1jcHUgbGlzdCBvZiByZWdpc3RlcmVkIHBv
bGwgc291cmNlcyAqLwogREVGSU5FX1BFUl9DUFUoc3RydWN0IGxpc3RfaGVhZCwgcG9sbF9zb3Vy
Y2VfbGlzdCk7CkBAIC0yNiw2ICsyNyw4IEBAIHZvaWQgcG9sbF9zb3VyY2VfcnVuX29uY2Uodm9p
ZCkKIAogCWxpc3RfZm9yX2VhY2hfZW50cnkoc3JjLCB0aGlzX2NwdV9wdHIoJnBvbGxfc291cmNl
X2xpc3QpLCBub2RlKQogCQlzcmMtPm9wcy0+cG9sbChzcmMpOworCisJc29mdGlycV9wb2xsKCk7
CiB9CiAKIC8qIENhbGxlZCBmcm9tIGlkbGUgdGFzayB3aXRoIFRJRl9QT0xMSU5HX05SRkxBRyBz
ZXQgYW5kIGlycXMgZW5hYmxlZCAqLwpkaWZmIC0tZ2l0IGEva2VybmVsL3NvZnRpcnEuYyBiL2tl
cm5lbC9zb2Z0aXJxLmMKaW5kZXggNDk5Mjg1M2VmNTNkLi5mNDViZjAyMDQyMTggMTAwNjQ0Ci0t
LSBhL2tlcm5lbC9zb2Z0aXJxLmMKKysrIGIva2VybmVsL3NvZnRpcnEuYwpAQCAtNjExLDYgKzYx
MSwyMCBAQCB2b2lkIGlycV9lbnRlcih2b2lkKQogCWlycV9lbnRlcl9yY3UoKTsKIH0KIAorLyoq
CisgKiBzb2Z0aXJxX3BvbGwoKSAtIGludm9rZSBwZW5kaW5nIHNvZnRpcnFzCisgKgorICogTm9y
bWFsbHkgaXQgaXMgbm90IG5lY2Vzc2FyeSB0byBleHBsaWNpdGx5IHBvbGwgZm9yIHNvZnRpcnFz
LCBidXQgaW4gdGhlCisgKiBjcHVpZGxlIGRyaXZlciBhIHBvbGxpbmcgZnVuY3Rpb24gbWF5IGhh
dmUgcmFpc2VkIGEgc29mdGlycSB3aXRoIG5vIGlycSBleGl0CisgKiB0byBpbnZva2UgaXQuIFRo
ZXJlZm9yZSBpdCBpcyBuZWNlc3NhcnkgdG8gcG9sbCBmb3IgcGVuZGluZyBzb2Z0aXJxcyBhbmQK
KyAqIGludm9rZSB0aGVtIGV4cGxpY2l0bHkuCisgKi8KK3ZvaWQgc29mdGlycV9wb2xsKHZvaWQp
Cit7CisJaWYgKCFpbl9pbnRlcnJ1cHQoKSAmJiBsb2NhbF9zb2Z0aXJxX3BlbmRpbmcoKSkKKwkJ
aW52b2tlX3NvZnRpcnEoKTsKK30KKwogc3RhdGljIGlubGluZSB2b2lkIHRpY2tfaXJxX2V4aXQo
dm9pZCkKIHsKICNpZmRlZiBDT05GSUdfTk9fSFpfQ09NTU9OCi0tIAoyLjMxLjEKCg==

