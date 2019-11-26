Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6E1098CA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 06:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKZFfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 00:35:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:61355 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727436AbfKZFfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 00:35:04 -0500
X-UUID: 052d8fe813694e919e0a0ce9ade97d23-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PGHAjeNFj61JuQZqzPm0qOjVOVPlbCv9F5NL4JCmFUs=;
        b=FhlbflNrqT0mPEQx/nAIsSi4t5cEhAjHxVUiphH/Q9tVgKiRK+nxjIA6po2ShhyWbVfh/BzqXob0gnEEOMz7ikLoTN9iWkABemf/FxOVoI0Klo0EfCAxLqvKhTlY7EEo+whpsDlheONn/9gY1FRCMPsJUfw1O2ruqdxkZJzJHBM=;
X-UUID: 052d8fe813694e919e0a0ce9ade97d23-20191126
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1097498708; Tue, 26 Nov 2019 13:34:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 13:34:50 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 13:34:34 +0800
From:   <freddy.hsin@mediatek.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <matthias.bgg@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC:     <Chang-An.Chen@mediatek.com>, <wsd_upstream@mediatek.com>
Subject: [PATCH v1 0/4] Support MTK reboot mode driver 
Date:   Tue, 26 Nov 2019 13:34:46 +0800
Message-ID: <1574746490-625-1-git-send-email-freddy.hsin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpUaGlzIGRyaXZlciBwYXJzZXMgdGhlIHJlYm9vdCBjb21tYW5kcyBsaWtlICJyZWJvb3QgYm9v
dGxvYWRlciINCiBhbmQgInJlYm9vdCByZWNvdmVyeSIgdG8gZ2V0IGEgYm9vdCBtb2RlIGRlc2Ny
aWJlZCBpbiB0aGUNCiBkZXZpY2UgdHJlZSAsIHRoZW4gY2FsbCB0aGUgd3JpdGUgaW50ZXJmYWUg
dG8gc3RvcmUgdGhlIGJvb3QNCiBtb2RlIGluIG10ayBSR1UgKHJlc2V0IGdlbmVyYXRpb24gdW5p
dCkgbm9uLXZvbGF0aWxlIHJlZ2lzdGVyLA0KIHdoaWNoIGNhbiBiZSByZWFkIGJ5IHRoZSBib290
bG9hZGVyIGFmdGVyIHN5c3RlbSByZWJvb3QsIHRoZW4NCiB0aGUgYm9vdGxvYWRlciBjYW4gdGFr
ZSBkaWZmZXJlbnQgYWN0aW9uIGFjY29yZGluZyB0byB0aGUgbW9kZQ0KIHN0b3JlZC4NCiANCiBG
cmVkZHkgSHNpbiAoNCk6DQogIHBvd2VyOiByZXNldDogYWRkIHJlYm9vdCBtb2RlIGRyaXZlcg0K
ICB3YXRjaGRvZzogcG9wdWxhdGUgcmVib290IG1vZGUgbm9kZSBpbiB0b3ByZ3Ugbm9kZSBvZiBN
VEsgUkdVIChSZXNldA0KICAgIEdlbmVyYXRpb24gVW5pdCkNCiAgc29jOiBtZWRpYXRlazogYWRk
IHJlYm9vdC1tb2RlIGhlYWRlcg0KICBkdC1iaW5kaW5nOiBwb3dlcjogcmVzZXQ6IEFkZCBkb2N1
bWVudGF0aW9uIGZvciBNVEsgUkdVIChSZXNldA0KICAgIEdlcm5hdGlvbiBVbml0KSByZWJvb3Qg
ZHJpdmVyDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9yZXNldC9tdGstcmVib290
LnR4dCB8ICAgMzAgKysrKysNCiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgMTEgKysNCiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvcG93ZXIvcmVzZXQvbXRrLXJl
Ym9vdC5jICAgICAgICAgICAgICAgICAgIHwgIDExNiArKysrKysrKysrKysrKysrKysrKw0KIGRy
aXZlcnMvd2F0Y2hkb2cvbXRrX3dkdC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMyAr
DQogaW5jbHVkZS9kdC1iaW5kaW5ncy9zb2MvbWVkaWF0ZWssYm9vdC1tb2RlLmggICAgICAgfCAg
IDE3ICsrKw0KIDYgZmlsZXMgY2hhbmdlZCwgMTc4IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L210
ay1yZWJvb3QudHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcG93ZXIvcmVzZXQvbXRr
LXJlYm9vdC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3Mvc29jL21l
ZGlhdGVrLGJvb3QtbW9kZS5o

