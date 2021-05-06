Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3E3759BF
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 19:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhEFR4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 May 2021 13:56:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41888 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhEFR4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 13:56:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 1700C1F43B7E
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
Subject: [PATCH v2 1/4] ARM: dts: rockchip: Fix thermal sensor cells
Date:   Thu,  6 May 2021 14:55:11 -0300
Message-Id: <20210506175514.168365-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506175514.168365-1-ezequiel@collabora.com>
References: <20210506175514.168365-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The number of cells to be used with a thermal sensor specifier
must be "1". Fix this.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 208f21245095..9f02ba7a0cc2 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -517,7 +517,7 @@ tsadc: tsadc@11150000 {
 		pinctrl-0 = <&otp_pin>;
 		pinctrl-1 = <&otp_out>;
 		pinctrl-2 = <&otp_pin>;
-		#thermal-sensor-cells = <0>;
+		#thermal-sensor-cells = <1>;
 		rockchip,hw-tshut-temp = <95000>;
 		status = "disabled";
 	};
-- 
2.30.0

