Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5763412FB91
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 18:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgACRYv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 12:24:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:59297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgACRYv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jan 2020 12:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578072275;
        bh=Ki5Xx495F4YsB6ncXu7kfMIyiYqWsyfQhKXh4uBlEQU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GEZctov4iOwNBeFTSqRZTAQF4JKqhkJagQ1e89tgBXjEgFFN+oWtXJqbYkgsBpZz2
         gtGBaotnXK58d0wE01SGgMjCOcJuYyd2W7zSFFRGtacGg1f6NENPJ3sh+8/hZBFgjD
         Y3lG64Dt4s686/BlvSelQgpd3nGvPvb/p5iZlonU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MRmfi-1jAy5p0hiM-00TGog; Fri, 03 Jan 2020 18:24:35 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
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
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 4/4] ARM: configs: Build BCM2711 thermal as module
Date:   Fri,  3 Jan 2020 18:23:56 +0100
Message-Id: <1578072236-31820-5-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
References: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:6YiHejA8tz/7oRcej/Y+aw4g3ItMrl44kB/QtEKWQ9VUcM8sLzF
 GraS2XuJy48/Tbe+V+qJojRYmnmXrxp4x1p05vtH/Nlo3cC+rot5nYH+v7iugevRXef/s6d
 k74SGUKH6no2bTAJrWqZJN780NAS95qNtFymhMZX/nnBFJkEqYP5IWJYrsOfWF8rSEit4NB
 efCy1K2tzGNwfxrM/CDVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jdbFcKc7zF4=:XLFLIi7nawvnlcyUr6+46L
 0SDMsXKCo0dpBTbfncvc/bocSkvxF+lzgryxE9dRixoytn29pcF48aaXp6OeSkGDfzjnVxKJF
 RPeeJPLPrLtlTWZKRinPwPiEd7NU00xgIjQwXHisHMHcGpO/gjqVZk4H5KE8/bSXf5JBpl5Kp
 3UwTS08qBnm1Wef2p3HDgjVvFwfGkwWGGyAqj+Gmxxtq5dsHULTXjDFLgqqvU/3qnIe/KwMSG
 LW5/tbOR+OViQGKktaypu/6Ik4O/fOHTy86wi+uwNq8LLQhc9htGKP6TIg+u1dC/8hVwl11hH
 LWMiBNE88Yn0yvMqpu79DvTSfXmGw1w6LJ9oGeOAarHrIPJeHXCX/WodvXDHiRFTLTRJzWqIj
 grGwhggFT9HSJ3OngwXgrtOt6Fd3KJy3QQdNls/KJHOVcRoUnW4+7voHAXWWLGMkQS773NWQ5
 fx/QJWfT7d/Al3cxxOqDoBepvXuLXJqa8ZIZDkhZcvh8juhx0JMDx2rp5hI4QVj2DFZzrIozK
 WbZYhvp5PqyUJ9ra6KmfaaavlNAGvgU/AQTP8pott4zlBdN3DYHRbs5ywZWf+RtQPPoaUNqAL
 3oBkOFepo+vLzxa/MKNRFD7xxpA1w81aMyVyfC4EuKUxkhqY8uVtPd9zGo6/OY4bD64eua1wr
 /A1EffQcoN+HcNnT6kTdFVvvEctTpq1YCQeMh636jJJd+ooHzWIeOI92fKQdk/LNPXuXdbxbv
 nJFBjh0wAZPalxnpnf9jrae2MIaius6vls7nuHoZM9d2aUC96lDd2/F6tDh9rJ8jTcV/88/AQ
 4RZeNd2VRAzFrWakhLnaexgPb8bpm5H/PdLhSa5xoMH3/olZfHWbPHWrDslAijUklEb7UF8Vs
 0CMa39WkFW4a5YkjBnni/FCWq7xsrvZV2CLYi1NhoCtuM9/loBBMT3Hwdh+WWqCv0joOrmvVK
 Tz8s6qnNenSNTkPkUjeZcx4jFXtKpuheXzhxCPhJpu8j95yLl+ykgyyZIoD58Wi2JD0PDUNkj
 nZFpbfVrbH3WxNOBCozexVF+bO//YEqBfEwWwwuJrmseCr4VRbpDpyIBBGZP2iYBPnCO/K1gP
 3isX6gUnwS9xCgLTWVkUFDhWVPVhM2TEfDk5ohUqLUJYndOOaH4UVo6aMB8BZzGMflgYWq27f
 5j0bu/WqQQ0N55l4pAhO5L54BsaTLr5uxvQ8MLLN0y0QpbGJ/hwMYq5f6ylhCwiA2e9sEtKEF
 NGe3ULhh4Kr0WoPUv7dHadTIjrohwWBCmo38lXg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This builds the BCM2711 thermal driver as module for the Raspberry Pi 4.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
=2D--
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm64/configs/defconfig        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_=
v7_defconfig
index 3f1b96d..f5d19cc 100644
=2D-- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -496,6 +496,7 @@ CONFIG_IMX_THERMAL=3Dy
 CONFIG_ROCKCHIP_THERMAL=3Dy
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
+CONFIG_BCM2711_THERMAL=3Dm
 CONFIG_BCM2835_THERMAL=3Dm
 CONFIG_BRCMSTB_THERMAL=3Dm
 CONFIG_ST_THERMAL_MEMMAP=3Dy
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a83ba2..b2f6673 100644
=2D-- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -442,6 +442,7 @@ CONFIG_ROCKCHIP_THERMAL=3Dm
 CONFIG_RCAR_THERMAL=3Dy
 CONFIG_RCAR_GEN3_THERMAL=3Dy
 CONFIG_ARMADA_THERMAL=3Dy
+CONFIG_BCM2711_THERMAL=3Dm
 CONFIG_BCM2835_THERMAL=3Dm
 CONFIG_BRCMSTB_THERMAL=3Dm
 CONFIG_EXYNOS_THERMAL=3Dy
=2D-
2.7.4

