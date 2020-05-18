Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF171D73E5
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 11:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgERJYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 05:24:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62365 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726040AbgERJYu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 05:24:50 -0400
X-UUID: 38ef98bc9db2438b8e621db43415db51-20200518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0DTYtg7DH/aaZsHajF1M0GEhpPDj6HE4U9Su4EW4ZBg=;
        b=Va6hluz4/bYSptacD8bkhsa7nqDZ2RFMyTranQOalM8PvJkJFDufyvfFqfxrt16Eu3JTqNK1zXkkWjaYPe4/rTWrbAF32VKsT7VVlBavvczJ9jN19kkFozRrtllCR0Kyh2vL+FHwLlmDezX0unYUnglb0LuuuzxNYqAEFeq5e5w=;
X-UUID: 38ef98bc9db2438b8e621db43415db51-20200518
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1124336748; Mon, 18 May 2020 17:24:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 May 2020 17:24:45 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 May 2020 17:24:45 +0800
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
Subject: [PATCH v8 0/3] PM / AVS: SVS: Introduce SVS engine
Date:   Mon, 18 May 2020 17:24:01 +0800
Message-ID: <20200518092403.22647-1-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5934DDCDEAF0C437AC4DD8F51EBED5FD5EACA359D2BA842B5D2816D48513A4412000:8
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
NzU5OTQvDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTE3NTk5NC8N
Cg0KY2hhbmdlcyBzaW5jZSB2NzoNCi0gQWRkICJtdGtfc3ZzLnlhbWwiIGZvciBkZXZpY2UtdHJl
ZSBiaW5kaW5nIGRvY3VtZW50Lg0KLSBBZGQgc3ZzX2FkZF90aGVybWFsX2RldmljZV9saW5rKCkg
aW4gZHJpdmVyIGZvciBzdnMgZGV2aWNlIChjb25zdW1lcikNCnRvIGxpbmsgdGhlcm1hbCBkZXZp
Y2UgKHN1cHBsaWVyKS4NCi0gcmVwbGFjZSBwbV9xb3NfYWRkX3JlcXVlc3QoKSB3aXRoIGNwdV9s
YXRlbmN5X3Fvc19hZGRfcmVxdWVzdCgpIGZvcg0KbGV0dGluZyBDUFVzIGxlYXZlIGlkbGUtb2Zm
IHN0YXRlLg0KDQpSb2dlciBMdSAoMyk6DQogIGR0LWJpbmRpbmdzOiBwb3dlcjogYXZzOiBhZGQg
bXRrIHN2cyBkdC1iaW5kaW5ncw0KICBhcm02NDogZHRzOiBtdDgxODM6IGFkZCBzdnMgZGV2aWNl
IGluZm9ybWF0aW9uDQogIFBNIC8gQVZTOiBTVlM6IEludHJvZHVjZSBTVlMgZW5naW5lDQoNCiAu
Li4vYmluZGluZ3MvcG93ZXIvYXZzL210a19zdnMueWFtbCAgICAgICAgICAgfCAgMTQxICsrDQog
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMtZXZiLmR0cyAgIHwgICAxNiArDQog
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSAgICAgIHwgICA0MSArDQog
ZHJpdmVycy9wb3dlci9hdnMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgICAxMCArDQog
ZHJpdmVycy9wb3dlci9hdnMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQog
ZHJpdmVycy9wb3dlci9hdnMvbXRrX3N2cy5jICAgICAgICAgICAgICAgICAgIHwgMjExOSArKysr
KysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvcG93ZXIvbXRrX3N2cy5oICAgICAgICAgICAg
ICAgICB8ICAgMjMgKw0KIDcgZmlsZXMgY2hhbmdlZCwgMjM1MSBpbnNlcnRpb25zKCspDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9h
dnMvbXRrX3N2cy55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcG93ZXIvYXZzL210
a19zdnMuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3Bvd2VyL210a19zdnMu
aA0K

