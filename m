Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1141D1098C2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 06:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfKZFfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 00:35:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56934 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727379AbfKZFfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 00:35:02 -0500
X-UUID: 6538519289be4a80823965c00f1f7dfa-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PTHlyvPT7+DKctsDgzzDOzGrtWUVdvF9uAmdUpUUCzI=;
        b=mj2lbBLvkictvFSSj+JAgzHcQAc4bXK2h+Ln6vu27+lO41QJPsV5dmm+cnyQd0MGxR5vvilDM1cbmzvlhVQQSk5Mfs40q71MwdvBPexx59/WypM7JnpUQ3y+9Ug/4Bz3bWa2a6X/DHAAp3hZ7ZPe1+qor5um8q2b7nAun44O/Co=;
X-UUID: 6538519289be4a80823965c00f1f7dfa-20191126
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 787183843; Tue, 26 Nov 2019 13:34:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 13:34:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 13:34:35 +0800
From:   <freddy.hsin@mediatek.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <matthias.bgg@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC:     <Chang-An.Chen@mediatek.com>, <wsd_upstream@mediatek.com>,
        Freddy Hsin <freddy.hsin@mediatek.com>
Subject: [PATCH v1 4/4] dt-binding: power: reset: Add documentation for MTK RGU (Reset Gernation Unit) reboot driver
Date:   Tue, 26 Nov 2019 13:34:50 +0800
Message-ID: <1574746490-625-5-git-send-email-freddy.hsin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574746490-625-1-git-send-email-freddy.hsin@mediatek.com>
References: <1574746490-625-1-git-send-email-freddy.hsin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogRnJlZGR5IEhzaW4gPGZyZWRkeS5oc2luQG1lZGlhdGVrLmNvbT4NCg0KQWRkIGRvY3Vt
ZW50YXRpb24gZm9yIE1USyBSR1UgKFJlc2V0IEdlbmVyYXRpb24gVW5pdCkgcmVib290IGRyaXZl
ci4NCg0KU2lnbmVkLW9mZi1ieTogRnJlZGR5IEhzaW4gPGZyZWRkeS5oc2luQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L210ay1yZWJvb3Qu
dHh0IHwgICAzMCArKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wb3dlci9yZXNldC9tdGstcmVib290LnR4dA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L210ay1yZWJvb3QudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L210ay1yZWJvb3Qu
dHh0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uNzA4ZDM1MQ0KLS0tIC9k
ZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jl
c2V0L210ay1yZWJvb3QudHh0DQpAQCAtMCwwICsxLDMwIEBADQorR2VuZXJpYyBNVEsgUkdVIG1h
cHBlZCByZWdpc3RlciByZXNldCBkcml2ZXINCisNCitUaGlzIGlzIGEgcmVzZXQgZHJpdmVyIHVz
aW5nIHRvcHJndSB0byBtYXAgaXRzIG5vbi12b2xhdGlsZSByZWdpc3Rlci4NCitUaGUgcmVzZXQg
aXMgZ2VuZXJhbGx5IHBlcmZvcm1lZCB3aXRoIGEgd3JpdGUgdG8gdGhlIG5vbi12b2xhdGlsZSBy
ZWdpc3Rlcg0KK2RlZmluZWQgYnkgdGhlIHJlZ2lzdGVyIG1hcCBwb2ludGVkIGJ5IHRvcHJndSBy
ZWZlcmVuY2UgcGx1cyB0aGUgb2Zmc2V0DQord2l0aCB0aGUgbWFzayBkZWZpbmVkIGluIHRoZSBy
ZWJvb3QtbW9kZSBub2RlLg0KKw0KK1JlcXVpcmVkIHByb3BlcnRpZXM6DQorLSBjb21wYXRpYmxl
OiBzaG91bGQgY29udGFpbiAidG9wcmd1LXJlYm9vdC1tb2RlIg0KKy0gcmVnbWFwOiB0aGlzIGlz
IHBoYW5kbGUgdG8gdGhlIHJlZ2lzdGVyIG1hcCBub2RlDQorLSBvZmZzZXQ6IG9mZnNldCBpbiB0
aGUgcmVnaXN0ZXIgbWFwIGZvciB0aGUgcmVib290LW1vZGUgcmVnaXN0ZXIgKGluIGJ5dGVzKQ0K
Ky0gbWFzazogdGhlIHJlc2V0IHZhbHVlIHdyaXR0ZW4gdG8gdGhlIHJlYm9vdCByZWdpc3RlciAo
MzIgYml0IGFjY2VzcykNCisNCitFeGFtcGxlczoNCisJcmVib290LW1vZGUgew0KKwkgICBjb21w
YXRpYmxlID0gInRvcHJndS1yZWJvb3QtbW9kZSI7DQorCSAgIHJlZ21hcCA9IDwmdG9wcmd1PjsN
CisJICAgb2Zmc2V0ID0gPDB4MjQ+Ow0KKwkgICBtYXNrID0gPDB4Rj47DQorCX07DQorDQorT3B0
aW9uYWwgcHJvcGVydGllcyAtIHJlYm9vdCBtb2RlIHZhbHVlIHRoYXQgd2lsbCBrZWVwIGluIHRv
cHJndSBub25yc3QgUkc6DQorLSBtb2RlLWNoYXJnZXIgPSA8Qk9PVF9DSEFSR0VSPjsNCistIG1v
ZGUtcmVjb3ZlcnkgPSA8Qk9PVF9SRUNPVkVSWT47DQorLSBtb2RlLWJvb3Rsb2FkZXIgPSA8Qk9P
VF9CT09UTE9BREVSPjsNCistIG1vZGUtZG0tdmVyaXR5LWRldi1jb3JydXB0ID0gPEJPT1RfRE1f
VkVSSVRZPjsNCistIG1vZGUta3BvYyA9IDxCT09UX0tQT0M+Ow0KKy0gbW9kZS1kZHItcmVzZXJ2
ZSA9IDxCT09UX0REUl9SU1ZEPjsNCistIG1vZGUtbWV0YSA9IDxCT09UX01FVEE+Ow0KKy0gbW9k
ZS1ycG1icGsgPSA8Qk9PVF9SUE1CUEs+Ow0KLS0gDQoxLjcuOS41DQo=

