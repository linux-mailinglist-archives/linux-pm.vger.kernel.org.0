Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722872588B5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAHFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 03:05:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31494 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbgIAHFy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 03:05:54 -0400
X-UUID: cbe7ac62e7e548e1b23fc4688f1e3c67-20200901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VRgBNvTtVHr8xsM0oGrT8CR3Lw13vv4ccslbq+kluY8=;
        b=BDfhEuriDBR8vybYGb20smjGwe7mGiufoD6fde/Afax25sZ8CF2i3EUUVCr6DlEiDpyg5vJMk9AW7rDh1rG7NwJjJhZx5sRZ7UEjXO19esrtaCw3QYBjLq9YkVXeCYVWNh49MoAk5WKBzMHzqOknquN++oUjpaIy7/YVJ5PZlkk=;
X-UUID: cbe7ac62e7e548e1b23fc4688f1e3c67-20200901
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <claude.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1165505367; Tue, 01 Sep 2020 15:05:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Sep 2020 15:05:47 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Sep 2020 15:05:47 +0800
From:   Claude Yen <claude.yen@mediatek.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH] PM: s2idle: Introduce syscore callbacks in s2idle flow
Date:   Tue, 1 Sep 2020 15:04:18 +0800
Message-ID: <1598943859-21857-1-git-send-email-claude.yen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBzZXJpZXMgYmFzZWQgb24gNS45LXJjMQ0KVGhpcyBwYXRjaCBtYWtlcyBzMmlkbGUgY2Fs
bCBleGlzdGluZyBzeXNjb3JlIGNhbGxiYWNrcy4gQ3VycmVudGx5LA0Kd2hlbiBzMmlkbGUgaXMg
c2VsZWN0ZWQgYXMgc3lzdGVtIHN1c3BlbmQgbWV0aG9kLCBjYWxsYmFja3MgaG9va2VkDQpieSBy
ZWdpc3Rlcl9zeXNjb3JlX29wcygpIHdpbGwgbm90IGJlIHRyaWdnZXJlZC4gVGhpcyBtYXkgaW5k
dWNlDQp1bmV4cGVjdGVkIHJlc3VsdHMuIA0KDQpGb3IgZXhhbXBsZSwgc2NoZWRfY2xvY2tfc3Vz
cGVuZCgpIHdhcyBhZGRlZCB0byBzMmlkbGUgZmxvdyBpbg0KY29tbWl0IDNmMjU1MmY3ZTljNSAo
InRpbWVycy9zY2hlZF9jbG9jazogUHJldmVudCBnZW5lcmljIHNjaGVkX2Nsb2NrDQp3cmFwIGNh
dXNlZCBieSB0aWNrX2ZyZWV6ZSgpIikgdG8gZml4IGNsb2NrIHdyYXAgcHJvYmxlbS4gSG93ZXZl
ciwNCnNjaGVkX2Nsb2NrX3N1c3BlbmQoKSBpcyBvcmlnaW5hbGx5IHJlZ2lzdGVyZWQgaW4gc3lz
Y29yZSBjYWxsYmFjay4NCldpdGggdGhpcyBwYXRjaCwgaWYgYW5vdGhlciBzeXNjb3JlIGNhbGxi
YWNrIGlzIG5lZWRlZCBpbiBzMmlkbGUsDQphZGRpdGlvbmFsIG1pZ3JhdGlvbiBlZmZvcnQgY291
bGQgYmUgc2F2ZWQuDQoNCg0KDQoqKiogQkxVUkIgSEVSRSAqKioNCg0KY2xhdWRlLnllbiAoMSk6
DQogIFBNOiBzMmlkbGU6IEludHJvZHVjZSBzeXNjb3JlIGNhbGxiYWNrcyBpbiBzMmlkbGUgZmxv
dw0KDQogZHJpdmVycy9jcHVpZGxlL2NwdWlkbGUuYyB8ICAgMzYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tDQoga2VybmVsL2NwdV9wbS5jICAgICAgICAgICB8ICAgMTcgKysr
KysrKysrKysrKysrKysNCiBrZXJuZWwvdGltZS90aWNrLWNvbW1vbi5jIHwgICAxNyArKy0tLS0t
LS0tLS0tLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRp
b25zKC0pDQoNCi0tDQoxLjcuOS41

