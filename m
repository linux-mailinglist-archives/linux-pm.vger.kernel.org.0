Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25612F4AF
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 07:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgACGoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 01:44:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:62447 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726181AbgACGoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jan 2020 01:44:17 -0500
X-UUID: e9e4b51c9fbe42fbac68190756123ae4-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ih+VIQfKXduOjptVm6qmEZ+ILG81EfY3C/tspmpMToM=;
        b=QZjmnx6+7vSaqjC7GGJ5CaY5BVyCt0Kl7Tx5BKUUG9WYwzSK3AJCkZpB9VRClHNHnFD3fbWK7ITN5VO3X9qB+plVtgX1Vdk+PBUwuy7bNYkTzvj5KIJNZmqlKWYnmDkD8vAcQIqgrilsiN2t3wt6QtcuroisWKwNcctOwIYHAjo=;
X-UUID: e9e4b51c9fbe42fbac68190756123ae4-20200103
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1938605274; Fri, 03 Jan 2020 14:44:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 14:43:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 14:44:08 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3,0/8] Add Mediatek thermal dirver and dtsi 
Date:   Fri, 3 Jan 2020 14:43:59 +0800
Message-ID: <20200103064407.19861-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaHNldCBzdXBwb3J0cyBmb3IgTVQ4MTgzIGNoaXAgdG8gbXRrX3RoZXJtYWwuYy4N
CkFkZCB0aGVybWFsIHpvbmUgb2YgYWxsIHRoZSB0aGVybWFsIHNlbnNvciBpbiBTb0MgZm9yDQph
bm90aGVyIGdldCB0ZW1wZXJhdHJ1ZS4gVGhleSBkb24ndCBuZWVkIHRvIHRoZXJtYWwgdGhyb3R0
bGUuDQpBbmQgd2UgYmluZCBjb29sZXJzIGZvciB0aGVybWFsIHpvbmUgbm9kZXMgb2YgY3B1X3Ro
ZXJtYWwuDQoNClJlYmFzZSB0byBrZXJuZWwtNS41LXJjMS4NCg0KVXBkYXRlIGNvbnRlbnQ6DQoN
ClsxLzhdDQpVcGRhdGUgc3VzdGFpbmFibGUgcG93ZXIgb2YgY3B1LCB0enRzMX41IGFuZCB0enRz
QUJCLg0KDQpbNy84XQ0KQnlwYXNzIHRoZSBmYWlsdXJlIHRoYXQgbm9uIGNwdV90aGVybWFsIHNl
bnNvciBpcyBub3QgZmluZCBpbiB0aGVybWFsLXpvbmVzDQppbiBkdHMsIHdoaWNoIGlzIG5vcm1h
bCBmb3IgbXQ4MTczLCBzbyBwcm9tcHQgYSB3YXJuaW5nIGhlcmUgaW5zdGVhZCBvZg0KZmFpbGlu
Zy4NCg0KUmV0dXJuIC1FQUdBSU4gaW5zdGVhZCBvZiAtRUFDQ0VTUyBvbiB0aGUgZmlyc3QgcmVh
ZCBvZiBzZW5zb3IgdGhhdA0Kb2Z0ZW4gYXJlIGJvZ3VzIHZhbHVlcy4gVGhpcyBjYW4gYXZvaWQg
Zm9sbG93aW5nIHdhcm5pbmcgb24gYm9vdDoNCg0KICB0aGVybWFsIHRoZXJtYWxfem9uZTY6IGZh
aWxlZCB0byByZWFkIG91dCB0aGVybWFsIHpvbmUgKC0xMykNCg0KDQpUaGlzIHBhdGNoIHNlcmll
cyBiYXNlIG9uIHRoZXNlIHBhdGNoZXMgWzFdWzJdWzNdWzRdLg0KDQpbMV1zdXBwb3J0IGZvciBy
ZWFkaW5nIGNoaXAgSUQgYW5kIGVmdXNlIChodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzEwOTAyMTMxLykNClsyXWFybTY0OiBkdHM6IG10ODE4MzogQWRkIHJlc2V0LWNlbGxzIGlu
IGluZnJhY2ZnIChodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwOTA4NjUzLykN
ClszXWNsazogcmVzZXQ6IE1vZGlmeSByZXNldC1jb250cm9sbGVyIGRyaXZlciAoaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDkwODY1Ny8pDQpbNF1QTSAvIEFWUzogU1ZTOiBJ
bnRyb2R1Y2UgU1ZTIGVuZ2luZSAoaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MDkyMzI4OS8pDQoNCk1hdHRoaWFzIEthZWhsY2tlICgyKToNCiAgYXJtNjQ6IGR0czogbXQ4MTgz
OiBDb25maWd1cmUgQ1BVIGNvb2xpbmcNCiAgYXJtNjQ6IGR0czogbXQ4MTgzOiBJbmNyZWFzZSBw
b2xsaW5nIGZyZXF1ZW5jeSBmb3IgQ1BVIHRoZXJtYWwgem9uZQ0KDQpNaWNoYWVsIEthbyAoNik6
DQogIGFybTY0OiBkdHM6IG10ODE4MzogYWRkIHRoZXJtYWwgem9uZSBub2RlDQogIGFybTY0OiBk
dHM6IG10ODE4MzogYWRkL3VwZGF0ZSBkeW5hbWljIHBvd2VyIGNvZWZmaWNpZW50cw0KICBhcm02
NDogZHRzOiBtdDgxODM6IEFkZCAjY29vbGluZy1jZWxscyB0byBDUFUgbm9kZXMNCiAgdGhlcm1h
bDogbWVkaWF0ZWs6IG10ODE4MzogZml4IGJhbmsgbnVtYmVyIHNldHRpbmdzDQogIHRoZXJtYWw6
IG1lZGlhdGVrOiBhZGQgYW5vdGhlciBnZXRfdGVtcCBvcHMgZm9yIHRoZXJtYWwgc2Vuc29ycw0K
ICB0aGVybWFsOiBtZWRpYXRlazogdXNlIHNwaW5sb2NrIHRvIHByb3RlY3QgUFRQQ09SRVNFTA0K
DQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDE1NyArKysrKysr
KysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jICAgICAgICAg
ICAgfCAgODggKysrKysrKysrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMjMxIGluc2VydGlvbnMo
KyksIDE0IGRlbGV0aW9ucygtKQ0KDQo=

