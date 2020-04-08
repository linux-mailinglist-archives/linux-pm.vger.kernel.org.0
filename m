Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7107F1A1DD5
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgDHJGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 05:06:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35313 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727707AbgDHJGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 05:06:08 -0400
X-UUID: 3ff769d2b0dc491e98f7f0ed90186d6f-20200408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Qh7przKIfX21C6nfkvmRwxpYgUWlMX6+C+g6YzZ+NXs=;
        b=InlYd7LeMy115A3DqScaSQfXkS8jnDbxcIsSL6fehyjFi9d7r6QFG4aXRHJwoNy9X4pZl9BWNZ9veTzX/l2rQANV5Jpq20XrhKf9cLipg7PMwjpt+gjQajaXGYVTZThlRO4HffKztJR+mRIF5oiGJE9zruaHen5SfZL7QY3kJl0=;
X-UUID: 3ff769d2b0dc491e98f7f0ed90186d6f-20200408
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1092597428; Wed, 08 Apr 2020 17:06:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Apr 2020 17:05:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Apr 2020 17:05:56 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     <michael.kao@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
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
Subject: [RESEND PATCH 0/1] thermal: mediatek: add suspend/resume callback
Date:   Wed, 8 Apr 2020 17:05:57 +0800
Message-ID: <20200408090558.12410-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Q2hhbmdlIGl0ZW1zOg0KDQoxLiBGaXggdHlwbyBvZiBtZWFzdXJlbWVudC4NCjIuIENoYW5nZSBu
YW1lIG9mIG10a190aGVybWFsX2dldF9iYW5rIHRvIG10a190aGVybWFsX2xvY2tfYmFuay4NCjMu
IENoYW5nZSBuYW1lIG9mIG10a190aGVybWFsX3B1dF9iYW5rIHRvIG10a190aGVybWFsX3VubG9j
a19iYW5rLg0KDQpVbmNoYW5nIGl0ZW1zOg0KDQoxLiBUaGVyZSBhcmUgbXRrX3RoZXJtYWxfZ2V0
X2JhbmsgYW5kIG10a190aGVybWFsX3B1dF9iYW5rIGluIHRoZQ0KICAgbXRrX3RoZXJtYWxfaW5p
dF9iYW5rLiBTbyB3ZSBhbHNvIGFkZCBtdGtfdGhlcm1hbF9nZXRfYmFuayBhbmQNCiAgIG10a190
aGVybWFsX3B1dF9iYW5rIGluIHRoZSBtdGtfdGhlcm1hbF9kaXNhYmxlX3NlbnNpbmcuIEFueQ0K
ICAgY29udHJvbCBhbmQgc2V0dGluZ3Mgb2Ygc2Vuc29yIGluIHRoZSB0aGVybWFsIGNvbnRyb2xs
ZXIgc2hvdWxkDQogICBsb2NrIGFuZCB1bmxvY2sgdG8gcHJldmVudCB0aGVybWFsIGNvbnRyb2xs
ZXIgZnJvbSByZXBvcnRpbmcNCiAgIHdyb25nIHRlbXBlcmF0dXJlLg0KDQoyLiBUaGUgbXV0ZXgg
bG9jayB3YXMgY2hhbmdlZCBpbiB0aGlzIHBhdGNoLg0KICAgW3Y0LDcvN10gdGhlcm1hbDogbWVk
aWF0ZWs6IHVzZSBzcGlubG9jayB0byBwcm90ZWN0IFBUUENPUkVTRUwNCiAgIChodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNDUyODM1LykNCg0KDQoNCkxvdWlzIFl1ICgxKToN
CiAgdGhlcm1hbDogbWVkaWF0ZWs6IGFkZCBzdXNwZW5kL3Jlc3VtZSBjYWxsYmFjaw0KDQogZHJp
dmVycy90aGVybWFsL210a190aGVybWFsLmMgfCAxNTIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMzQgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRp
b25zKC0pDQo=

