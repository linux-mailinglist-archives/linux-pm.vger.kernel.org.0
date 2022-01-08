Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62D3488438
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jan 2022 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiAHPcH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jan 2022 10:32:07 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:53873 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233967AbiAHPcH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Jan 2022 10:32:07 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1641655923;
        bh=g2GUnqBIvgrlm2SSNhFEdepbxYmhapOcA+pRXda4f2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUxVpgthQjA9cfO/00wfeJymujjw3rdZTh/x2Oufda0j2x7s0815Vnp7fZG7MQgcn
         V7qQVQpu5TXh7c3EjhynZTV21k/IdaWkqSbLf2L6MNrPuAeCeZ9RJlBKIMAmK9rdox
         4EykuUT4OyA64k9YgcUn97+bzUmpR3a6AfxTz05c=
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        kbuild-all@lists.01.org,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "Thomas Koch" <linrunner@gmx.net>,
        =?UTF-8?q?Nicol=C3=B2=20Piazzalunga?= <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] power: supply: Provide stubs for charge_behaviour helpers
Date:   Sat,  8 Jan 2022 16:31:58 +0100
Message-Id: <20220108153158.189489-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <487dd7a3-8f29-de9a-2612-65fe895e676f@redhat.com>
References: <487dd7a3-8f29-de9a-2612-65fe895e676f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1641655915; l=1294; s=20211113; h=from:subject; bh=g2GUnqBIvgrlm2SSNhFEdepbxYmhapOcA+pRXda4f2U=; b=0lEQ05CNE2jyIe1bp1ljJaKx/Kart21q038dg+1tpd03/8qx/K317Eb82rVIgZI4k9qTu2KTWAx0 XYw4Fx5tC1V1fJElrrnc5YnGAq3o3v/Yjk3Gy14Bh+RRwcgAxhJw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When CONFIG_SYSFS is not enabled provide stubs for the helper functions
to not break their callers.

Fixes: 539b9c94ac83 ("power: supply: add helpers for charge_behaviour sysfs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/power_supply.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index d92de670d6a7..e218041cc000 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -723,6 +723,21 @@ ssize_t power_supply_charge_behaviour_show(struct device *dev,
 					   char *buf);
 
 int power_supply_charge_behaviour_parse(unsigned int available_behaviours, const char *buf);
+#else
+static inline
+ssize_t power_supply_charge_behaviour_show(struct device *dev,
+					   unsigned int available_behaviours,
+					   enum power_supply_charge_behaviour behaviour,
+					   char *buf)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int power_supply_charge_behaviour_parse(unsigned int available_behaviours,
+						      const char *buf)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif /* __LINUX_POWER_SUPPLY_H__ */

base-commit: b8170452cd5121b11a5726e3ea8dbdfc2d74e771
-- 
2.34.1

