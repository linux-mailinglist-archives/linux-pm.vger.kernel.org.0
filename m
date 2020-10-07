Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97F2859F8
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgJGHys (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 03:54:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58434 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727783AbgJGHyq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 03:54:46 -0400
X-UUID: 7ef162ae471a4838a307524fd0b0c3c3-20201007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CnyxkLbDuHIqQhWDCHDnStdnLN4hfclSRDq2vswcWhY=;
        b=cBEIf0WWi2etrJOsw8wgOerd7/u3cWs+EUO35tE7KjVlU+J4YEfSH10hoWE10Hr/sWMaGmTSE9U8mYPm9fWiw9hhkQ39rUzf6IqHouzOwtN4GuR2CvXxrIxuw5LvNZcAItEyKGzvyirfj84ehfy3raXydFq3dt5QqpDVWgHZbu4=;
X-UUID: 7ef162ae471a4838a307524fd0b0c3c3-20201007
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1612243403; Wed, 07 Oct 2020 15:54:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
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
        <linux-mediatek@lists.infradead.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [v5 0/2] Add Mediatek thermal dirver and dtsi
Date:   Wed, 7 Oct 2020 15:54:35 +0800
Message-ID: <20201007075437.6002-2-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201007075437.6002-1-michael.kao@mediatek.com>
References: <20201007075437.6002-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UmViYXNlIHRvIGtlcm5lbC01LjktcmMxLg0KDQpVcGRhdGUgY29udGVudDoNCg0KICAgIC0gUmVt
b3ZlIHRoZSBbdjQsNy83XSB0aGVybWFsOiBtZWRpYXRlazogdXNlIHNwaW5sb2NrIHRvIHByb3Rl
Y3QgUFRQQ09SRVNFTA0KDQpbMi8yXQ0KICAgIC0gQWRkIHRoZSBqdWRnZW1lbnQgdG8gdGhlIHZl
cnNpb24gb2YgcmF3X3RvX21jZWxzaXVzLg0KDQpNaWNoYWVsIEthbyAoMSk6DQogIGFybTY0OiBk
dHM6IG10ODE4MzogYWRkIHRoZXJtYWwgem9uZSBub2RlDQogIHRoZXJtYWw6IG1lZGlhdGVrOiBh
ZGQgYW5vdGhlciBnZXRfdGVtcCBvcHMgZm9yIHRoZXJtYWwgc2Vuc29ycw0KDQogYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDg0ICsrKysrKysrKysrKysrKysrKysr
KysrKw0KIGRyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jICAgICAgICAgICAgfCA3NyArKysr
KysrKysrKysrKysrKysrKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxNTQgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE4LjANCg==

