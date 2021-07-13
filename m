Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701F93C744B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhGMQWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 12:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230229AbhGMQWI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 12:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626193157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=awbwz8Mi1G1+f2fwGt3ZEpkOa0ZEsi8ROYjzYe/Okus=;
        b=PoxG3ZFQEIknPgusP3jAlPopWFK8MOplxhvPlQ2MYBymohwpwqs7RRESBlrr/PIQ7r1MgN
        yILgJUWeVdPoaJ6k3pgEBvY9JfrFKROZeJ3IzsQJxrGxSoWecbADwrshRumoIVF7xWhlPn
        brxHJX0zBCcu+boIfCx7zS3+gHE2gD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-JG1pSGTjO-m9PADZ5-L7Wg-1; Tue, 13 Jul 2021 12:19:16 -0400
X-MC-Unique: JG1pSGTjO-m9PADZ5-L7Wg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 258DB1B2C983;
        Tue, 13 Jul 2021 16:19:15 +0000 (UTC)
Received: from localhost (ovpn-112-172.ams2.redhat.com [10.36.112.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C1F819C44;
        Tue, 13 Jul 2021 16:19:14 +0000 (UTC)
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
Subject: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
Date:   Tue, 13 Jul 2021 17:19:03 +0100
Message-Id: <20210713161906.457857-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlc2UgcGF0Y2hlcyBhcmUgbm90IHBvbGlzaGVkIHlldCBidXQgSSB3b3VsZCBsaWtlIHJlcXVl
c3QgZmVlZGJhY2sgb24gdGhpcw0KYXBwcm9hY2ggYW5kIHNoYXJlIHBlcmZvcm1hbmNlIHJlc3Vs
dHMgd2l0aCB5b3UuDQoNCklkbGUgQ1BVcyB0ZW50YXRpdmVseSBlbnRlciBhIGJ1c3kgd2FpdCBs
b29wIGJlZm9yZSBoYWx0aW5nIHdoZW4gdGhlIGNwdWlkbGUNCmhhbHRwb2xsIGRyaXZlciBpcyBl
bmFibGVkIGluc2lkZSBhIHZpcnR1YWwgbWFjaGluZS4gVGhpcyByZWR1Y2VzIHdha2V1cA0KbGF0
ZW5jeSBmb3IgZXZlbnRzIHRoYXQgb2NjdXIgc29vbiBhZnRlciB0aGUgdkNQVSBiZWNvbWVzIGlk
bGUuDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGV4dGVuZHMgdGhlIGNwdWlkbGUgYnVzeSB3YWl0IGxv
b3Agd2l0aCB0aGUgbmV3IHBvbGxfc291cmNlDQpBUEkgc28gZHJpdmVycyBjYW4gcGFydGljaXBh
dGUgaW4gcG9sbGluZy4gU3VjaCBwb2xsaW5nLWF3YXJlIGRyaXZlcnMgZGlzYWJsZQ0KdGhlaXIg
ZGV2aWNlJ3MgaXJxIGR1cmluZyB0aGUgYnVzeSB3YWl0IGxvb3AgdG8gYXZvaWQgdGhlIGNvc3Qg
b2YgaW50ZXJydXB0cy4NClRoaXMgcmVkdWNlcyBsYXRlbmN5IGZ1cnRoZXIgdGhhbiByZWd1bGFy
IGNwdWlkbGUgaGFsdHBvbGwsIHdoaWNoIHN0aWxsIHJlbGllcw0Kb24gaXJxcy4NCg0KVmlydGlv
IGRyaXZlcnMgYXJlIG1vZGlmaWVkIHRvIHVzZSB0aGUgcG9sbF9zb3VyY2UgQVBJIHNvIGFsbCB2
aXJ0aW8gZGV2aWNlDQp0eXBlcyBnZXQgdGhpcyBmZWF0dXJlLiBUaGUgZm9sbG93aW5nIHZpcnRp
by1ibGsgZmlvIGJlbmNobWFyayByZXN1bHRzIHNob3cgdGhlDQppbXByb3ZlbWVudDoNCg0KICAg
ICAgICAgICAgIElPUFMgKG51bWpvYnM9NCwgaW9kZXB0aD0xLCA0IHZpcnRxdWV1ZXMpDQogICAg
ICAgICAgICAgICBiZWZvcmUgICBwb2xsX3NvdXJjZSAgICAgIGlvX3BvbGwNCjRrIHJhbmRyZWFk
ICAgIDE2NzEwMiAgMTg2MDQ5ICgrMTElKSAgMTg2NjU0ICgrMTElKQ0KNGsgcmFuZHdyaXRlICAg
MTYyMjA0ICAxODEyMTQgKCsxMSUpICAxODE4NTAgKCsxMiUpDQo0ayByYW5kcncgICAgICAxNTk1
MjAgIDE3NzA3MSAoKzExJSkgIDE3NzkyOCAoKzExJSkNCg0KVGhlIGNvbXBhcmlzb24gYWdhaW5z
dCBpb19wb2xsIHNob3dzIHRoYXQgY3B1aWRsZSBwb2xsX3NvdXJjZSBhY2hpZXZlcw0KZXF1aXZh
bGVudCBwZXJmb3JtYW5jZSB0byB0aGUgYmxvY2sgbGF5ZXIncyBpb19wb2xsIGZlYXR1cmUgKHdo
aWNoIEkNCmltcGxlbWVudGVkIGluIGEgc2VwYXJhdGUgcGF0Y2ggc2VyaWVzIFsxXSkuDQoNClRo
ZSBhZHZhbnRhZ2Ugb2YgcG9sbF9zb3VyY2UgaXMgdGhhdCBhcHBsaWNhdGlvbnMgZG8gbm90IG5l
ZWQgdG8gZXhwbGljaXRseSBzZXQNCnRoZSBSV0ZfSElQUkkgSS9PIHJlcXVlc3QgZmxhZy4gVGhl
IHBvbGxfc291cmNlIGFwcHJvYWNoIGlzIGF0dHJhY3RpdmUgYmVjYXVzZQ0KZmV3IGFwcGxpY2F0
aW9ucyBhY3R1YWxseSB1c2UgUldGX0hJUFJJIGFuZCBpdCB0YWtlcyBhZHZhbnRhZ2Ugb2YgQ1BV
IGN5Y2xlcyB3ZQ0Kd291bGQgaGF2ZSBzcGVudCBpbiBjcHVpZGxlIGhhbHRwb2xsIGFueXdheS4N
Cg0KVGhlIGN1cnJlbnQgc2VyaWVzIGRvZXMgbm90IGltcHJvdmUgdmlydGlvLW5ldC4gSSBoYXZl
bid0IGludmVzdGlnYXRlZCBkZWVwbHksDQpidXQgaXQgaXMgcG9zc2libGUgdGhhdCBOQVBJIGFu
ZCBwb2xsX3NvdXJjZSBkbyBub3QgY29tYmluZS4gU2VlIHRoZSBmaW5hbA0KcGF0Y2ggZm9yIGEg
c3RhcnRpbmcgcG9pbnQgb24gbWFraW5nIHRoZSB0d28gd29yayB0b2dldGhlci4NCg0KSSBoYXZl
IG5vdCB0cmllZCB0aGlzIG9uIGJhcmUgbWV0YWwgYnV0IGl0IG1pZ2h0IGhlbHAgdGhlcmUgdG9v
LiBUaGUgY29zdCBvZg0KZGlzYWJsaW5nIGEgZGV2aWNlJ3MgaXJxIG11c3QgYmUgbGVzcyB0aGFu
IHRoZSBzYXZpbmdzIGZyb20gYXZvaWRpbmcgaXJxDQpoYW5kbGluZyBmb3IgdGhpcyBvcHRpbWl6
YXRpb24gdG8gbWFrZSBzZW5zZS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWJsb2NrLzIwMjEwNTIwMTQxMzA1LjM1NTk2MS0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vDQoNClN0
ZWZhbiBIYWpub2N6aSAoMyk6DQogIGNwdWlkbGU6IGFkZCBwb2xsX3NvdXJjZSBBUEkNCiAgdmly
dGlvOiBhZGQgcG9sbF9zb3VyY2UgdmlydHF1ZXVlIHBvbGxpbmcNCiAgc29mdGlycTogcGFydGlj
aXBhdGUgaW4gY3B1aWRsZSBwb2xsaW5nDQoNCiBkcml2ZXJzL2NwdWlkbGUvTWFrZWZpbGUgICAg
ICAgICAgIHwgICAxICsNCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5oIHwgICA3
ICsrDQogaW5jbHVkZS9saW51eC9pbnRlcnJ1cHQuaCAgICAgICAgICB8ICAgMiArDQogaW5jbHVk
ZS9saW51eC9wb2xsX3NvdXJjZS5oICAgICAgICB8ICA1MyArKysrKysrKysrKysrKysNCiBpbmNs
dWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgIHwgICAyICsNCiBpbmNsdWRlL2xpbnV4L3Zp
cnRpb19jb25maWcuaCAgICAgIHwgICAyICsNCiBkcml2ZXJzL2NwdWlkbGUvcG9sbF9zb3VyY2Uu
YyAgICAgIHwgMTAyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9jcHVp
ZGxlL3BvbGxfc3RhdGUuYyAgICAgICB8ICAgNiArKw0KIGRyaXZlcnMvdmlydGlvL3ZpcnRpby5j
ICAgICAgICAgICAgfCAgMzQgKysrKysrKysrKw0KIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
Y29tbW9uLmMgfCAgODYgKysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm4uYyB8ICAgMiArDQoga2VybmVsL3NvZnRpcnEuYyAgICAgICAgICAg
ICAgICAgICB8ICAxNCArKysrDQogMTIgZmlsZXMgY2hhbmdlZCwgMzExIGluc2VydGlvbnMoKykN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9wb2xsX3NvdXJjZS5oDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3B1aWRsZS9wb2xsX3NvdXJjZS5jDQoNCi0tIA0KMi4zMS4x
DQoNCg==

