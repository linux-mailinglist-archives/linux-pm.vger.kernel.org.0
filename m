Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C316170A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 17:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgBQQMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 11:12:20 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:22542 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgBQQMU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 11:12:20 -0500
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Tue, 18 Feb 2020
 00:12:41 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: [PATCH] soc: amlogic: fix compile failure with MESON_SECURE_PM_DOMAINS & !MESON_SM
Date:   Tue, 18 Feb 2020 00:12:13 +0800
Message-ID: <1581955933-69832-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When MESON_SECURE_PM_DOMAINS & !MESON_SM, there will be compile failure:
.../meson-secure-pwrc.o: In function `meson_secure_pwrc_on':
.../meson-secure-pwrc.c:76: undefined reference to `meson_sm_call'

Fix this by adding depends on MESON_SM for MESON_SECURE_PM_DOMAINS.

Fixes: b3dde5013e13 ("soc: amlogic: Add support for Secure power domains controller")

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: patchwork-bot+linux-amlogic<patchwork-bot+linux-amlogic@kernel.org>
Reported-by: Stephen Rothwell<sfr@canb.auug.org.au>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/soc/amlogic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index 6cb06e7..321c5e2 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -50,7 +50,7 @@ config MESON_EE_PM_DOMAINS
 
 config MESON_SECURE_PM_DOMAINS
 	bool "Amlogic Meson Secure Power Domains driver"
-	depends on ARCH_MESON || COMPILE_TEST
+	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
 	depends on PM && OF
 	depends on HAVE_ARM_SMCCC
 	default ARCH_MESON
-- 
2.7.4

