Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCB28CB88
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgJMKYH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 06:24:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45376 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729142AbgJMKYF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 06:24:05 -0400
X-UUID: 62c5888df13443448298e49461e47086-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PWbV9UJVNx5Rqkoezdtv//5m6JUAtb7ulTjtaO+ZtI8=;
        b=fCOnt20siAhWL/cCwso+jL+Fjm66NNvrTfaPF+p+YAwsMOiLXxVu4xYijifMZ/u3VFwxmb4Xgdm4dsOcc6rPRBKy2eXsbAR/a8Njlx1t+IPxNnrPxbdlM++LB3OE+rSsH3uYLkuCCcRS+h9xEWHfB9c087GSz1kAF2vR1OclvE4=;
X-UUID: 62c5888df13443448298e49461e47086-20201013
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1942852951; Tue, 13 Oct 2020 18:24:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Oct 2020 18:24:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 18:24:00 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v5 0/3] mt8183: Add Mediatek thermal driver and dtsi 
Date:   Tue, 13 Oct 2020 18:23:55 +0800
Message-ID: <20201013102358.22588-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaHNldCBzdXBwb3J0cyBmb3IgTVQ4MTgzIGNoaXAgdG8gbXRrX3RoZXJtYWwuYy4N
CkFkZCB0aGVybWFsIHpvbmUgb2YgYWxsIHRoZSB0aGVybWFsIHNlbnNvciBpbiBTb0MgZm9yDQph
bm90aGVyIGdldCB0ZW1wZXJhdHJ1ZS4gVGhleSBkb24ndCBuZWVkIHRvIHRoZXJtYWwgdGhyb3R0
bGUuDQpBbmQgd2UgYmluZCBjb29sZXJzIGZvciB0aGVybWFsIHpvbmUgbm9kZXMgb2YgY3B1X3Ro
ZXJtYWwuDQoNCkNoYW5nZXMgaW4gdjU6DQogICAgLSBSZWJhc2UgdG8ga2VybmVsLTUuOS1yYzEu
DQogICAgLSBSZXZpc2UgdGhlIHRpdGxlIG9mIGNvdmVyIGxldHRlci4NCiAgICAtIERyb3AgIlt2
NCw3LzddIHRoZXJtYWw6IG1lZGlhdGVrOiB1c2Ugc3BpbmxvY2sgdG8gcHJvdGVjdCBQVFBDT1JF
U0VMIg0KICAgIC0gWzIvMl0NCiAgICAgICAgLSAgQWRkIHRoZSBqdWRnZW1lbnQgdG8gdGhlIHZl
cnNpb24gb2YgcmF3X3RvX21jZWxzaXVzLg0KDQpDaGFuZ2VzIGluIHY0Og0KICAgIC0gUmViYXNl
IHRvIGtlcm5lbC01LjYtcmMxLg0KICAgIC0gWzEvN10NCiAgICAgICAgLSBTcXVhc2ggdGhlcm1h
bCB6b25lIHNldHRpbmdzIGluIHRoZSBkdHNpIGZyb20gW3YzLDUvOF0NCiAgICAgICAgICBhcm02
NDogZHRzOiBtdDgxODM6IEluY3JlYXNlIHBvbGxpbmcgZnJlcXVlbmN5IGZvciBDUFUgdGhlcm1h
bCB6b25lLg0KICAgICAgICAtIFJlbW92ZSB0aGUgcHJvcGVydHkgb2YgaW50ZXJydXB0cyBhbmQg
bWVkaWF0ZWssaHctcmVzZXQtdGVtcC4NCiAgICAtIFsyLzddDQogICAgICAgIC0gQ29ycmVjdCBj
b21taXQgbWVzc2FnZS4NCiAgICAtIFs0LzddDQogICAgICAgIC0gQ2hhbmdlIHRoZSB0YXJnZXQg
dGVtcGVyYXR1cmUgdG8gdGhlIDgwQyBhbmQgY2hhbmdlIHRoZSBjb21taXQgbWVzc2FnZS4NCiAg
ICAtIFs2LzddDQogICAgICAgIC0gQWRqdXN0IG5ld2xpbmUgYWxpZ25tZW50Lg0KICAgICAgICAt
IEZpeCB0aGUganVkZ2VtZW50IG9uIHRoZSByZXR1cm4gdmFsdWUgb2YgcmVnaXN0ZXJpbmcgdGhl
cm1hbCB6b25lLg0KDQpDaGFuZ2VzIGluIHYzOg0KICAgIC0gUmViYXNlIHRvIGtlcm5lbC01LjUt
cmMxLg0KICAgIC0gWzEvOF0NCiAgICAgICAgLSBVcGRhdGUgc3VzdGFpbmFibGUgcG93ZXIgb2Yg
Y3B1LCB0enRzMX41IGFuZCB0enRzQUJCLg0KICAgIC0gWzcvOF0NCiAgICAgICAgLSBCeXBhc3Mg
dGhlIGZhaWx1cmUgdGhhdCBub24gY3B1X3RoZXJtYWwgc2Vuc29yIGlzIG5vdCBmaW5kIGluIHRo
ZXJtYWwtem9uZXMNCiAgICAgICAgICBpbiBkdHMsIHdoaWNoIGlzIG5vcm1hbCBmb3IgbXQ4MTcz
LCBzbyBwcm9tcHQgYSB3YXJuaW5nIGhlcmUgaW5zdGVhZCBvZg0KICAgICAgICAgIGZhaWxpbmcu
DQoNCiAgICAgICAgUmV0dXJuIC1FQUdBSU4gaW5zdGVhZCBvZiAtRUFDQ0VTUyBvbiB0aGUgZmly
c3QgcmVhZCBvZiBzZW5zb3IgdGhhdA0KICAgICAgICBvZnRlbiBhcmUgYm9ndXMgdmFsdWVzLiBU
aGlzIGNhbiBhdm9pZCBmb2xsb3dpbmcgd2FybmluZyBvbiBib290Og0KDQogICAgICAgICAgdGhl
cm1hbCB0aGVybWFsX3pvbmU2OiBmYWlsZWQgdG8gcmVhZCBvdXQgdGhlcm1hbCB6b25lICgtMTMp
DQoNCkNoYW5nZXMgaW4gdjI6DQogICAgLSBbMS84XQ0KICAgICAgICAtIEFkZCB0aGUgc3VzdGFp
bmFibGUtcG93ZXIsdHJpcHMsY29vbGluZy1tYXBzIHRvIHRoZSB0enRzMX50enRzQUJCLg0KICAg
IC0gWzQvOF0NCiAgICAgICAgLSBBZGQgdGhlIG1pbiBvcHAgb2YgY3B1IHRocm90dGxlLg0KDQoN
Ck1hdHRoaWFzIEthZWhsY2tlICgxKToNCiAgYXJtNjQ6IGR0czogbXQ4MTgzOiBDb25maWd1cmUg
Q1BVIGNvb2xpbmcNCg0KTWljaGFlbCBLYW8gKDIpOg0KICB0aGVybWFsOiBtZWRpYXRlazogYWRk
IGFub3RoZXIgZ2V0X3RlbXAgb3BzIGZvciB0aGVybWFsIHNlbnNvcnMNCiAgYXJtNjQ6IGR0czog
bXQ4MTgzOiBhZGQgdGhlcm1hbCB6b25lIG5vZGUNCg0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTgzLmR0c2kgfCAxNDAgKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJz
L3RoZXJtYWwvbXRrX3RoZXJtYWwuYyAgICAgICAgICAgIHwgIDk5ICsrKysrKysrKysrKy0tLS0N
CiAyIGZpbGVzIGNoYW5nZWQsIDIxNiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCg0K
DQo=

