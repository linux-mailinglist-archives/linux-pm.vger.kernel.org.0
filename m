Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A1FEF406
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 04:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfKEDYE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 22:24:04 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:54304 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbfKEDYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 22:24:04 -0500
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Nov 2019 22:24:02 EST
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 82CA978E2A;
        Tue,  5 Nov 2019 11:17:26 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5865T139886076045056S1572923844811932_;
        Tue, 05 Nov 2019 11:17:26 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7b586cca0afd8c8e7450e099e60d9917>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     amit.kucheria@verdurent.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 0/3] thermal: rockchip: Support the RK3308 SoC in thermal driver
Date:   Tue,  5 Nov 2019 11:17:23 +0800
Message-Id: <1572923846-23310-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RK3308 SOC has two Temperature Sensors for CPU and GPU.

Elaine Zhang (3):
  dt-bindings: rockchip-thermal: Support the RK3308 SoC compatible
  thermal: rockchip: Support the RK3308 SoC in thermal driver
  ARM64: dts: rockchip: rk3308: add tsadc node

 .../bindings/thermal/rockchip-thermal.txt          |  1 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           | 20 ++++++++++++++++
 drivers/thermal/rockchip_thermal.c                 | 28 ++++++++++++++++++++++
 3 files changed, 49 insertions(+)

-- 
1.9.1



