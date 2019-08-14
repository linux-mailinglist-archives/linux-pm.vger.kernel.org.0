Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C78D047
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 12:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfHNKG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 06:06:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46285 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725861AbfHNKG5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 06:06:57 -0400
X-UUID: df20cc673a634ab783a2bf6baa4be1cf-20190814
X-UUID: df20cc673a634ab783a2bf6baa4be1cf-20190814
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 98354015; Wed, 14 Aug 2019 18:06:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 14 Aug 2019 18:06:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 18:06:52 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/4] add dts for Mediatek MT8183 thermal functions
Date:   Wed, 14 Aug 2019 18:06:45 +0800
Message-ID: <1565777209-21869-1-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Splitting the dtsi part from [1] and sending it again.

Add tzts1~5 and tztsABB from thermal sensor in SoC for
another get temperatrue. They don't need to thermal throttle.
And we bind coolers for thermal zone nodes of cpu_thermal.

Refernece:
[1] [v2,0/8] Add Mediatek thermal dirver and dtsi (https://patchwork.kernel.org/cover/10938809/)

Matthias Kaehlcke (1):
  arm64: dts: mt8183: Configure CPU cooling

michael.kao (3):
  arm64: dts: mt8183: add thermal zone node
  arm64: dts: mt8183: add dynamic power coefficients
  arm64: dts: mt8183: Add #cooling-cells to CPU nodes

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 139 +++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)


