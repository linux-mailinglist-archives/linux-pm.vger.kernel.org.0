Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CE2859F6
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgJGHyq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 03:54:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40660 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726041AbgJGHyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 03:54:45 -0400
X-UUID: 1325b920cac44fb287c480afbd5af271-20201007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=F3angfus8D4qiCoCshqcK9DbO+mBzjLtql8LLthz2OI=;
        b=b6Fmr8NkB943gjcZ6xg6qH1lCMCmk3IrtVdMqAJqSveQsSZc/+sLh6QUKx+1UUJ4pe4jllQi2FntSSjNdXW7Xb7otaaB2wCjwJ06BljcvACq4/mnX5K8uF+b935NMJ74jKTneDxo03+Ii3oZZXpyyuiAiP6e6Oy0mdNdGdK1ETk=;
X-UUID: 1325b920cac44fb287c480afbd5af271-20201007
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1113135192; Wed, 07 Oct 2020 15:54:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Oct 2020 15:54:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Oct 2020 15:54:39 +0800
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
Subject: 
Date:   Wed, 7 Oct 2020 15:54:34 +0800
Message-ID: <20201007075437.6002-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

bSAzMDhkNTMwZWU5YzI4YzdjNzI5YTUwMjAwNzM0MDU1MjJkMjdlMDkxIE1vbiBTZXAgMTcgMDA6
MDA6MDAgMjAwMQ0KRnJvbTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4N
CkRhdGU6IFdlZCwgNyBPY3QgMjAyMCAxNTo0Mjo1NyArMDgwMA0KU3ViamVjdDogW3Y1IDAvMl0g
QWRkIE1lZGlhdGVrIHRoZXJtYWwgZGlydmVyIGFuZCBkdHNpDQpUaGlzIHBhdGNoc2V0IHN1cHBv
cnRzIGZvciBNVDgxODMgY2hpcCB0byBtdGtfdGhlcm1hbC5jLg0KQWRkIHRoZXJtYWwgem9uZSBv
ZiBhbGwgdGhlIHRoZXJtYWwgc2Vuc29yIGluIFNvQyBmb3INCmFub3RoZXIgZ2V0IHRlbXBlcmF0
cnVlLiBUaGV5IGRvbid0IG5lZWQgdG8gdGhlcm1hbCB0aHJvdHRsZS4NCkFuZCB3ZSBiaW5kIGNv
b2xlcnMgZm9yIHRoZXJtYWwgem9uZSBub2RlcyBvZiBjcHVfdGhlcm1hbC4NCg0KUmViYXNlIHRv
IGtlcm5lbC01LjktcmMxLg0KDQpVcGRhdGUgY29udGVudDoNCg0KICAgIC0gUmVtb3ZlIHRoZSBb
djQsNy83XSB0aGVybWFsOiBtZWRpYXRlazogdXNlIHNwaW5sb2NrIHRvIHByb3RlY3QgUFRQQ09S
RVNFTA0KDQpbMi8yXQ0KICAgIC0gQWRkIHRoZSBqdWRnZW1lbnQgdG8gdGhlIHZlcnNpb24gb2Yg
cmF3X3RvX21jZWxzaXVzLg0KDQpNaWNoYWVsIEthbyAoMSk6DQogIGFybTY0OiBkdHM6IG10ODE4
MzogYWRkIHRoZXJtYWwgem9uZSBub2RlDQogIHRoZXJtYWw6IG1lZGlhdGVrOiBhZGQgYW5vdGhl
ciBnZXRfdGVtcCBvcHMgZm9yIHRoZXJtYWwgc2Vuc29ycw0KDQogYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDg0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KIGRy
aXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jICAgICAgICAgICAgfCA3NyArKysrKysrKysrKysr
KysrKysrKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxNTQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCg0KLS0NCg0K

