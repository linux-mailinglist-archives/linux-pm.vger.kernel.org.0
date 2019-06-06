Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A0376C5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfFFObV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 10:31:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:49950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbfFFObQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 10:31:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFB4CAFE0;
        Thu,  6 Jun 2019 14:31:14 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 7/7] arm64: defconfig: enable cpufreq support for RPi3
Date:   Thu,  6 Jun 2019 16:23:00 +0200
Message-Id: <20190606142255.29454-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606142255.29454-1-nsaenzjulienne@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables both the new firmware clock driver and cpufreq driver
available for the RPi3 family of boards.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..3b7baffb3087 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,6 +82,7 @@ CONFIG_CPUFREQ_DT=y
 CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
+CONFIG_ARM_RASPBERRYPI_CPUFREQ=y
 CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
@@ -639,6 +640,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_CLK_RASPBERRYPI=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_TI_SCI_CLK=y
-- 
2.21.0

