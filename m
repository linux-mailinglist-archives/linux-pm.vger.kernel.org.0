Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABB51843AD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgCMJef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:34:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61434 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726310AbgCMJef (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:35 -0400
X-UUID: 0eb429159a15430a92231b74d74086d7-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=urwiCCeBhATqzkJKTdVUJzgoPbW2D5JW1FSyfotRgVM=;
        b=ajJFdNBNGTH1R5MiO1amJK4LhIKUSbWdp87okfryZVtAnfOK7siLMPCzrhwC1ewGKbf23cg4bvcWr2dolJ7LRDKCSpZVLUknWgspmKO+kqWgb/+kll3ibeexyOQsa2us1djHvJhsqX4EVjnlMEoDqWvtmg/Hkfp9+YwcdwqA5ac=;
X-UUID: 0eb429159a15430a92231b74d74086d7-20200313
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1399102385; Fri, 13 Mar 2020 17:34:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:31:39 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:33:40 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V4 01/13] dt-bindings: soc: Add dvfsrc driver bindings
Date:   Fri, 13 Mar 2020 17:34:14 +0800
Message-ID: <1584092066-24425-2-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A439D69B1AF57BF434D94321C469FB946C56643CA4E7071159E60B523D3951662000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RG9jdW1lbnQgdGhlIGJpbmRpbmcgZm9yIGVuYWJsaW5nIGR2ZnNyYyBvbiBNZWRpYVRlayBTb0Mu
DQoNClNpZ25lZC1vZmYtYnk6IEhlbnJ5IENoZW4gPGhlbnJ5Yy5jaGVuQG1lZGlhdGVrLmNvbT4N
ClJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KLS0tDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2R2ZnNyYy50eHQgICAgfCAyMyArKysrKysr
KysrKysrKysrKysrKysrDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9zb2MvbXRrLGR2ZnNyYy5oICAg
ICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNs
dWRlL2R0LWJpbmRpbmdzL3NvYy9tdGssZHZmc3JjLmgNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLnR4dA0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjdmNDM0OTkNCi0tLSAvZGV2L251bGwN
CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZm
c3JjLnR4dA0KQEAgLTAsMCArMSwyMyBAQA0KK01lZGlhVGVrIERWRlNSQw0KKw0KK1RoZSBEeW5h
bWljIFZvbHRhZ2UgYW5kIEZyZXF1ZW5jeSBTY2FsaW5nIFJlc291cmNlIENvbGxlY3RvciAoRFZG
U1JDKSBpcyBhDQorSFcgbW9kdWxlIHdoaWNoIGlzIHVzZWQgdG8gY29sbGVjdCBhbGwgdGhlIHJl
cXVlc3RzIGZyb20gYm90aCBzb2Z0d2FyZSBhbmQNCitoYXJkd2FyZSBhbmQgdHVybiBpbnRvIHRo
ZSBkZWNpc2lvbiBvZiBtaW5pbXVtIG9wZXJhdGluZyB2b2x0YWdlIGFuZCBtaW5pbXVtDQorRFJB
TSBmcmVxdWVuY3kgdG8gZnVsZmlsbCB0aG9zZSByZXF1ZXN0cy4NCisNCitSZXF1aXJlZCBQcm9w
ZXJ0aWVzOg0KKy0gY29tcGF0aWJsZTogU2hvdWxkIGJlIG9uZSBvZiB0aGUgZm9sbG93aW5nDQor
CS0gIm1lZGlhdGVrLG10ODE4My1kdmZzcmMiOiBGb3IgTVQ4MTgzIFNvQw0KKy0gcmVnOiBBZGRy
ZXNzIHJhbmdlIG9mIHRoZSBEVkZTUkMgdW5pdA0KKy0gY2xvY2stbmFtZXM6IE11c3QgaW5jbHVk
ZSB0aGUgZm9sbG93aW5nIGVudHJpZXM6DQorCSJkdmZzcmMiOiBEVkZTUkMgbW9kdWxlIGNsb2Nr
DQorLSBjbG9ja3M6IE11c3QgY29udGFpbiBhbiBlbnRyeSBmb3IgZWFjaCBlbnRyeSBpbiBjbG9j
ay1uYW1lcy4NCisNCitFeGFtcGxlOg0KKw0KKwlkdmZzcmNAMTAwMTIwMDAgew0KKwkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZHZmc3JjIjsNCisJCXJlZyA9IDwwIDB4MTAwMTIwMDAg
MCAweDEwMDA+Ow0KKwkJY2xvY2tzID0gPCZpbmZyYWNmZyBDTEtfSU5GUkFfRFZGU1JDPjsNCisJ
CWNsb2NrLW5hbWVzID0gImR2ZnNyYyI7DQorCX07DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1i
aW5kaW5ncy9zb2MvbXRrLGR2ZnNyYy5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9zb2MvbXRrLGR2
ZnNyYy5oDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uYTUyMjQ4OA0KLS0t
IC9kZXYvbnVsbA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9zb2MvbXRrLGR2ZnNyYy5oDQpA
QCAtMCwwICsxLDE0IEBADQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCisg
Kg0KKyAqIENvcHlyaWdodCAoYykgMjAxOCBNZWRpYVRlayBJbmMuDQorICovDQorDQorI2lmbmRl
ZiBfRFRfQklORElOR1NfUE9XRVJfTVRLX0RWRlNSQ19IDQorI2RlZmluZSBfRFRfQklORElOR1Nf
UE9XRVJfTVRLX0RWRlNSQ19IDQorDQorI2RlZmluZSBNVDgxODNfRFZGU1JDX0xFVkVMXzEJMQ0K
KyNkZWZpbmUgTVQ4MTgzX0RWRlNSQ19MRVZFTF8yCTINCisjZGVmaW5lIE1UODE4M19EVkZTUkNf
TEVWRUxfMwkzDQorI2RlZmluZSBNVDgxODNfRFZGU1JDX0xFVkVMXzQJNA0KKw0KKyNlbmRpZiAv
KiBfRFRfQklORElOR1NfUE9XRVJfTVRLX0RWRlNSQ19IICovDQotLSANCjEuOS4xDQo=

