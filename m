Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986853759BD
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhEFR4k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 May 2021 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhEFR4j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 13:56:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F58C061574;
        Thu,  6 May 2021 10:55:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 427831F43B7B
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kever Yang <kever.yang@rock-chips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 0/4] Rockchip thermal YAML and RK3568
Date:   Thu,  6 May 2021 14:55:10 -0300
Message-Id: <20210506175514.168365-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v2:
* Convert to YAML
* Fix rk322x.dtsi
* Add comments as suggested by Daniel

Ezequiel Garcia (3):
  ARM: dts: rockchip: Fix thermal sensor cells
  dt-bindings: thermal: convert rockchip-thermal to json-schema
  dt-bindings: rockchip-thermal: Support the RK3568 SoC compatible

Finley Xiao (1):
  thermal/rockchip: Support RK3568 SoCs in the thermal driver

 .../bindings/thermal/rockchip-thermal.txt     |  85 ------------
 .../bindings/thermal/rockchip-thermal.yaml    |  96 ++++++++++++++
 arch/arm/boot/dts/rk322x.dtsi                 |   2 +-
 drivers/thermal/rockchip_thermal.c            | 121 ++++++++++++++++++
 4 files changed, 218 insertions(+), 86 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml

-- 
2.30.0

