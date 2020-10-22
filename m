Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3B29584D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 08:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503519AbgJVGX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 02:23:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40389 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503508AbgJVGX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 02:23:27 -0400
X-UUID: 14e3fc6cc1f14dea82c5c74ad970b620-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/vJ1k/CvUjLCTTWs6xEGCY+dakvbAFTCMIhNiUr7NTo=;
        b=SDvkG+yEmdWAXQuTQPGcxBlenMnAEjrGKN2jpDwlfEFiqOn3UDEv1dE3iavCxUbJT8kpBEPH9JZdTZJwoHEMMX27dvV8lpyv3R/1PkwAedjDpGAICKwNLXWjG3ewdpv512JnJRG4CC212O5rBeVoh7lJe8AVP7mguiLVhJ24cxA=;
X-UUID: 14e3fc6cc1f14dea82c5c74ad970b620-20201022
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <claude.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 980784132; Thu, 22 Oct 2020 14:18:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 14:18:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 14:18:13 +0800
From:   Claude Yen <claude.yen@mediatek.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <claude.yen@mediatek.com>
Subject: [PATCH] PM / s2idle: Export s2idle_set_ops
Date:   Thu, 22 Oct 2020 14:17:48 +0800
Message-ID: <20201022061748.13730-2-claude.yen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201022061748.13730-1-claude.yen@mediatek.com>
References: <20201022061748.13730-1-claude.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QXMgc3VzcGVuZF9zZXRfb3BzIGlzIGV4cG9ydGVkIGluIGNvbW1pdCBhNWU0ZmQ4NzgzYTINCigi
UE0gLyBTdXNwZW5kOiBFeHBvcnQgc3VzcGVuZF9zZXRfb3BzLCBzdXNwZW5kX3ZhbGlkX29ubHlf
bWVtIiksDQpleHBvcnRpbmcgczJpZGxlX3NldF9vcHMgdG8gbWFrZSBrZXJuZWwgbW9kdWxlIHNl
dHVwIHMyaWRsZSBvcHMgdG9vLg0KDQpJbiB0aGlzIHdheSwga2VybmVsIG1vZHVsZSBjYW4gaG9v
ayBwbGF0Zm9ybSBzdXNwZW5kDQpmdW5jdGlvbnMgcmVnYXJkbGVzcyBvZiBTdXNwZW5kLXRvLVJh
bShTMlIpIG9yDQpTdXNwZW5kLXRvLUlkbGUoUzJJKQ0KDQpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGUg
WWVuIDxjbGF1ZGUueWVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGtlcm5lbC9wb3dlci9zdXNwZW5k
LmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBh
L2tlcm5lbC9wb3dlci9zdXNwZW5kLmMgYi9rZXJuZWwvcG93ZXIvc3VzcGVuZC5jDQppbmRleCA4
YjFiYjVlZTdlNWQuLjBkYzNlODM0NDMxOCAxMDA2NDQNCi0tLSBhL2tlcm5lbC9wb3dlci9zdXNw
ZW5kLmMNCisrKyBiL2tlcm5lbC9wb3dlci9zdXNwZW5kLmMNCkBAIC03OSw2ICs3OSw3IEBAIHZv
aWQgczJpZGxlX3NldF9vcHMoY29uc3Qgc3RydWN0IHBsYXRmb3JtX3MyaWRsZV9vcHMgKm9wcykN
CiAJczJpZGxlX29wcyA9IG9wczsNCiAJdW5sb2NrX3N5c3RlbV9zbGVlcCgpOw0KIH0NCitFWFBP
UlRfU1lNQk9MX0dQTChzMmlkbGVfc2V0X29wcyk7DQogDQogc3RhdGljIHZvaWQgczJpZGxlX2Jl
Z2luKHZvaWQpDQogew0KLS0gDQoyLjE4LjANCg==

