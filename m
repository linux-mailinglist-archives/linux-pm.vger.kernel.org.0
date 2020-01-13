Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1213996B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 19:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgAMS5A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 13:57:00 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:43153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMS47 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 13:56:59 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1YtP-1iphB20GaJ-0032W1; Mon, 13 Jan 2020 19:56:43 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V5 4/4] ARM: configs: Build BCM2711 thermal as module
Date:   Mon, 13 Jan 2020 19:56:18 +0100
Message-Id: <1578941778-23321-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
References: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:O+u6pr4dhxrOSuuoknJ0DKNWGQ3vtlKGMbnvZc7/pEHB71+lP+5
 GOE3qd05FrcJ8FBdCfOzxwdLICo+DAZoBiHFL/n+IQJKXnOiIJL7YGMZ20AzSjIq1ukoC1k
 elTVjDTE9+1ElflUv3hqX3kqVI8HCckwLZJlI+51Jn/I85rOFSrPc4g8HLA2f9tFtpFbgQ3
 H3qP+9vGpB34IcID6KaKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gyygl/ACfQE=:ygkkfD/TXRtXjs1fyw13d2
 LemAh7UlXhneJPcb07l0sfrl7GzRJh/ZPAL16wRuc41qmzH5OQl8n5WB3qmNrVihu9rXn/SYx
 tyxY8fhIOfIO50B1fHtKyqsidXwaY+3dROUCan/WHRqmQHEfTpSJCrjR2EwVO5RtmJAjgOGyU
 HdFY6KvdqoTBtkOdfWFIok2dwV8n7B5QhTPJShug6GIzAE9t7ZbPk/vGtQudnCtYrNjRgEi3A
 LisEhG9GRYvYXSUYEuSfhjAchrzpGbgphwLSrNI54kEI42m3xOsaSmEl5MIssagEhz5BmEUDX
 v9qXfc0Y0iJTSPPVuhHn1HPwb0De+TcZblaYLPVqaMFTeSn7kKQqDPyUy9R0Y7FIFacIT2UoV
 yS7LLW7E4hvecp6tnJOzb0rAtF1FHocjspL5Iyo2V7LGSeSKGNjBFtz8B25qr3ce3wh3cHhr+
 FC8ZWFxW5pNG4AXxRxgutVAKwT7PdEXXqbC3MWVitACsC9yw7e52ac0NcjO7WwSZ/sCvl9f+I
 7q+mon0DP0fLEGVlHXkvLIslsrC34MBQPIroSCnBd3gf/TPd756a75uYRRNAjYrnBEP5K1A6O
 yH7hHnia+mEhijrqKPSIvQ7Pl9iIdaTfA70otgD+BDaUDDU5Syq+G0zoZzZTB7MN7jSaPcs05
 SxaU4FjP+9ZLo0fJSoxqlXMWV2iMaVPuIxlO+Xrk0R8kbJ67Iu0mR/4sfFqAmSIgJXaSpL8FW
 vhwLxYtKvCeW7h8+jOZ7VUfWf0AEkyTYzaeITvznreg5BV8rJ26VmFm3EVgjGdRWcIcf599k2
 HaulVm5OR6GEEfjuGUQLziZSl1UtnpxZIvTngLsUdAKNiKqt3b1ms/BVl0bJEhyc9RVv6rjHl
 +SMoH/iES+i0u8k/7sL4B9Xba9duNZ4+zQrhI0ldo=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This builds the BCM2711 thermal driver as module for the Raspberry Pi 4.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm64/configs/defconfig        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3f1b96d..f5d19cc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -496,6 +496,7 @@ CONFIG_IMX_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_ST_THERMAL_MEMMAP=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a83ba2..b2f6673 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -442,6 +442,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
-- 
2.7.4

