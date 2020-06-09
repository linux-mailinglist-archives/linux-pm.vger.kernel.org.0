Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88861F385C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgFIKpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 06:45:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1185 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728170AbgFIKpl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 06:45:41 -0400
X-UUID: 9e399d9c9c6247a6b5b8b0a046b5a56d-20200609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5ak6B9yXDQG+uLwRfImrZ4YOAgSKcMnvfKkqDlCtExY=;
        b=cSb5SjzBUj4ISAuCics3f92/5QhVtl8yDQG7vW3xfESkUfLoc0ynCLA7gaO2EpvLu+pZ8PWmEjXCF0t9uqj0LEJP86UEvycMuUOCkVIP1Lk7q5oFD3jIgyfgNsFyLUBM0QlP0wGHIQHEHsKSLNcAt+DpjHhaNsPu1e4+KnVMQoQ=;
X-UUID: 9e399d9c9c6247a6b5b8b0a046b5a56d-20200609
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2070146149; Tue, 09 Jun 2020 18:45:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Jun 2020 18:45:34 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Jun 2020 18:45:34 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v9 0/3] PM / AVS: SVS: Introduce SVS engine
Date:   Tue, 9 Jun 2020 18:45:30 +0800
Message-ID: <20200609104534.29314-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F4A1B644A6F609D5CDCAC8C6F33835685D4DC4EB39D55BA2913EA8ECA89702732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MS4gU1ZTIGRyaXZlciB1c2UgT1BQIGFkanVzdCBldmVudCBpbiBbMV0gdG8gdXBkYXRlIE9QUCB0
YWJsZSB2b2x0YWdlIHBhcnQuDQoyLiBTVlMgZHRzIG5vZGUgcmVmZXJzIHRvIENQVSBvcHAgdGFi
bGUgWzJdIGFuZCBHUFUgb3BwIHRhYmxlIFszXS4NCjMuIFNWUyBhbmQgdGhlcm1hbCBkdHMgdXNl
IHRoZSBzYW1lIHRoZXJtYWwgZWZ1c2UgWzRdLg0KNC4gU1ZTIGR0cyBuZWVkcyBwb3dlci1kb21h
aW4gWzVdWzZdIGFuZCBQTUlDIHJlZ3VsYXRvciBbN10uDQoNClsxXSBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzExMTkzNTEzLw0KWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcGF0Y2gvMTEzMDQ5MzUvDQpbM10gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
YXRjaC8xMTQyMzAwOS8NCls0XSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEx
MzE2NDk1Lw0KWzVdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMjM2
ODc1Lw0KWzZdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMjM2ODc4
Lw0KWzddIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEyODQ2MTcvDQoNCnBl
bmRpbmcgZGlzY3Vzc2lvbjoNCi0gU1ZTIHN1Yi1ub2RlIGFyY2hpdGVjdHVyZSBjb25jZXJuIGlu
IGJlbG93IHBhdGNoLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEx
NzU5OTQvDQoNCmNoYW5nZXMgc2luY2Ugdjg6DQotIEFkZCBzdnMgZHJpdmVyIGRvY3VtZW50YXRp
b24gZm9yIGhlbHBpbmcgdW5kZXJzdGFuZCBpdA0KLSBNYWtlIHN2cyBkcml2ZXIgYmVjb21lIGEg
bW9kdWxlX3BsYXRmb3JtX2RyaXZlcigpDQotIFNlcGVyYXRlIHN2cyBkZWJ1ZyBmZWF0dXJlIGZy
b20gc3ZzIG1haW4gZHJpdmVyDQoNClJvZ2VyIEx1ICg0KToNCiAgZHQtYmluZGluZ3M6IHBvd2Vy
OiBhdnM6IGFkZCBtdGsgc3ZzIGR0LWJpbmRpbmdzDQogIGFybTY0OiBkdHM6IG10ODE4MzogYWRk
IHN2cyBkZXZpY2UgaW5mb3JtYXRpb24NCiAgUE0gLyBBVlM6IFNWUzogaW50cm9kdWNlIFNWUyBl
bmdpbmUNCiAgUE0gLyBBVlM6IFNWUzogYWRkIFNWUyBkZWJ1ZyBjb21tYW5kcw0KDQogLi4uL2Jp
bmRpbmdzL3Bvd2VyL2F2cy9tdGtfc3ZzLnlhbWwgICAgICAgICAgIHwgIDE0MSArKw0KIGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLWV2Yi5kdHMgICB8ICAgMTYgKw0KIGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgICAgICB8ICAgNDEgKw0KIGRyaXZl
cnMvcG93ZXIvYXZzL0tjb25maWcgICAgICAgICAgICAgICAgICAgICB8ICAgMTAgKw0KIGRyaXZl
cnMvcG93ZXIvYXZzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZl
cnMvcG93ZXIvYXZzL210a19zdnMuYyAgICAgICAgICAgICAgICAgICB8IDIxODAgKysrKysrKysr
KysrKysrKysNCiBpbmNsdWRlL2xpbnV4L3Bvd2VyL210a19zdnMuaCAgICAgICAgICAgICAgICAg
fCAgIDIzICsNCiA3IGZpbGVzIGNoYW5nZWQsIDI0MTIgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvYXZzL210
a19zdnMueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Bvd2VyL2F2cy9tdGtfc3Zz
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9wb3dlci9tdGtfc3ZzLmgNCg0K

