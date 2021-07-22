Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73A43D205C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhGVI0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 04:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhGVI0r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Jul 2021 04:26:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EC9B610F7;
        Thu, 22 Jul 2021 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626944842;
        bh=G6uggNtHBw06DrLEyrx3+EPLEQiuV1JfBOJ1R+sWWJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=KQeV/yh9kA3Pd9NOV0uvBntromN90sb9aiaaPGvLkaYVfUNU7O8bsgBgmvO/GMaao
         LFhN0mq06HHJtG4ZO2HKrb9Y35Kf+x8VSCBty7LmZAqDvWlAN+01q6+P9hsjnc/pS5
         Pq3wCiWrVQU+WsT+gJQa+4fqc6bRKBuB/W6E6fP4MRcNNHIFPUEGqMjbyX03kniPRw
         HJqqoQZI6u1tjkjzwkx6c9yl/xRlmtD7bGpzoZYgJjaL2KuqMcAP4T7YW/T7wyRzf8
         c1CeIPgNxz3WG9CfzPamEggWU3i9gd4RVaDmSPm20nO0AkFK7eBPZkDXhbFe8dLMsB
         LGD0yeHyDmw0g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal: fix thermal_cooling_device_register() prototype
Date:   Thu, 22 Jul 2021 11:06:44 +0200
Message-Id: <20210722090717.1116748-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are two pairs of declarations for thermal_cooling_device_register()
and thermal_of_cooling_device_register(), and only one set was changed
in a recent patch, so the other one now causes a compile-time warning:

drivers/net/wireless/mediatek/mt76/mt7915/init.c: In function 'mt7915_thermal_init':
drivers/net/wireless/mediatek/mt76/mt7915/init.c:134:48: error: passing argument 1 of 'thermal_cooling_device_register' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  134 |         cdev = thermal_cooling_device_register(wiphy_name(wiphy), phy,
      |                                                ^~~~~~~~~~~~~~~~~
In file included from drivers/net/wireless/mediatek/mt76/mt7915/init.c:7:
include/linux/thermal.h:407:39: note: expected 'char *' but argument is of type 'const char *'
  407 | thermal_cooling_device_register(char *type, void *devdata,
      |                                 ~~~~~~^~~~

Change the dummy helper functions to have the same arguments as the
normal version.

Fixes: f991de53a8ab ("thermal: make device_register's type argument const")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/thermal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d296f3b88fb9..8050d929a5b4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -404,12 +404,13 @@ static inline void thermal_zone_device_unregister(
 	struct thermal_zone_device *tz)
 { }
 static inline struct thermal_cooling_device *
-thermal_cooling_device_register(char *type, void *devdata,
+thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
-	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
+	const char *type, void *devdata,
+	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
-- 
2.29.2

