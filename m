Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40F3C685E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 04:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGMCIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 22:08:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33460 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230037AbhGMCIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 22:08:48 -0400
X-UUID: 77241456ec8c4ab48f2209d8af4e055a-20210713
X-UUID: 77241456ec8c4ab48f2209d8af4e055a-20210713
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yt.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 652442460; Tue, 13 Jul 2021 10:05:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Jul 2021 10:05:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Jul 2021 10:05:55 +0800
From:   YT Lee <yt.lee@mediatek.com>
To:     <yt.lee@mediatek.com>, <roger.lu@mediatek.com>,
        <matthias.bgg@gmail.com>, <eballetbo@gmail.com>,
        <khilman@kernel.org>, <robh+dt@kernel.org>, <drinkcat@google.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>
CC:     <srv_heupstream@mediatek.com>, <fan.chen@mediatek.com>,
        <xiaoqing.liu@mediatek.com>, <charles.yang@mediatek.com>,
        <angus.lin@mediatek.com>, <mark.rutland@arm.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux@roeck-us.net>, <louis.yu@mediatek.com>
Subject: [PATCH 0/2] soc: mediatek: SVS: add mt8195 SVS GPU driver
Date:   Tue, 13 Jul 2021 10:05:50 +0800
Message-ID: <20210713020552.18667-1-yt.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

this patch series is based on Linux kernel 5.13-rc1,
it adds SVS GPU support on mt8195 and depends on
"soc: mediatek: SVS: introduce MTK SVS"[1]

[1]http://lists.infradead.org/pipermail/linux-mediatek/2021-July/026270.html

YT Lee (2):
  dt-bindings: soc: mediatek: add mt8195 svs dt-bindings
  soc: mediatek: SVS: add mt8195 SVS GPU driver

 .../bindings/soc/mediatek/mtk-svs.yaml        |   1 +
 drivers/soc/mediatek/mtk-svs.c                | 228 +++++++++++++++++-
 2 files changed, 217 insertions(+), 12 deletions(-)

-- 
2.18.0

