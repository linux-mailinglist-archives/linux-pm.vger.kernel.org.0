Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26361F3B1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfD3KJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 06:09:55 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:45020 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfD3KJz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 06:09:55 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.190])
        by regular1.263xmail.com (Postfix) with ESMTP id 5A98366C;
        Tue, 30 Apr 2019 18:09:48 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P7395T139736951809792S1556618984950678_;
        Tue, 30 Apr 2019 18:09:47 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e40b688152b9bf062824c7dd589b4166>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 0/3] thermal: rockchip: fix up thermal driver
Date:   Tue, 30 Apr 2019 18:09:43 +0800
Message-Id: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

1. add pinctrl control.
2. support PX30 soc

change in V3:
PATCH V3 1/3: remove panic.
PATCH V3 2/3: No change in V3.
PATCH V3 2/3: No change in V3

change in V2:
PATCH V2 1/3: keep tshut_mode TSHUT_MODE_GPIO;
              In case of pinctrl get or lookup error, just bail out;
              No need to use the thermal_pinctrl_select_otp/gpio wrappers,
              just replace them with:
PATCH V2 2/3: No change in V2.
PATCH V2 2/3: keep tshut_mode TSHUT_MODE_GPIO;
              Remove the grf in 'rk_tsadcv4_initialize' function.

Elaine Zhang (3):
  thermal: rockchip: fix up the tsadc pinctrl setting error
  dt-bindings: rockchip-thermal: Support the PX30 SoC compatible
  thermal: rockchip: Support the PX30 SoC in thermal driver

 .../bindings/thermal/rockchip-thermal.txt          |  1 +
 drivers/thermal/rockchip_thermal.c                 | 74 +++++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

-- 
1.9.1



