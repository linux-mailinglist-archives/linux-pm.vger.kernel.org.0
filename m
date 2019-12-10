Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D938A11924B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLJUmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 15:42:24 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:48729 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLJUmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 15:42:24 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N5FxN-1hgnme1lkD-011BkA; Tue, 10 Dec 2019 21:42:17 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: add dependency for THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
Date:   Tue, 10 Dec 2019 21:41:37 +0100
Message-Id: <20191210204216.3239987-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UYu9Yni7N+axnXFBFKI7TF3Khq4E0zNO6t7XpHvIy+uL7OGK6Cd
 5NA/a3BBvmuRR20iitPteWhaA/3BRnlDjx9zMWwph2rGDSYkyfvVyHzwWqjERScPc0SckLG
 Dp9SqOMkWyR3g/3jkI5GeibvffS4bIV8/2fZthX/F8KFVnnOvnpdX9oNVl8MCAN53uPYAVt
 AbhTDhT0x6gV6nX7UTWaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0W0aQrU20D8=:9k/tKOypgaOBDi+mJIVO9n
 pDYftY82Zwgm60B47DDddGWbYGoqWdj20qtgGuRRmZ5ahMufyZhBX8R5N5QOG6wBRtsa464+K
 XwOCGu4FMFYSw4hwVPItQvU7XgaiajYOqzLJHJfrkJoUwtiWablnA8WtQ4VuvQRL3ToGLYc1I
 rB2SUHsGyHEHXwBT+jW0nAgrqg8AWcPw3NOh3GOlXFzSbLKIG3/4qdqWOSstGLolNXi5sIYrg
 oA3hXC43FtUtoOTYys9yg0HqYFkeEOCo8Yx0DcKMbVOiMuiQdXAGiO4t/nc3QyQC/sGOrnISc
 jIplDs96G22F/BigbOzM/aAYi70Ds14pqmTIGIIITKcL83U0gLAJ53cI2cPYexa9HX3DK2XBT
 UsQ/IOYrlwJTONGCfXrRQuSy/Hw1ZQJ+esWt4XULb3o79k1p6PbzwG+jHkEH+074sNyzhcqfH
 ns8CmveRE537j8mhQtV9k+bZPYSmdGsWbVY8uhUZpaUkdqkMgZ8H9uXog4Iw1n/NhZ4R5NuOc
 kmokw6XGMzNvg8LP4qiraJ/ZGPLq+Cr1CPqHtD3r8WRU5JSMsJhp0hovlEuYs3cZs0SHaoVs0
 l4++TqqBrskehaoR/qGzxSOHKLqaMP9cUTSgU5Ll1fdb/5RxjGaunKWvb+w7l33goNhMczPZC
 zWekbbaoC1lJY94zIsh4kkfyrqA787JRJNfcTB9JhRTk0MYyEMRwAtaEN+y/9zGOCWJv9LjjG
 LLHxzW6uAXs7plRFgSTMVJsc52+cRfY8m+49Q+aIumamQbL0pucwpCgjDPZzSVFUi8HqrBWd1
 uzCbe4LYdydX074P/xbK1zZxX57RPCOr/XKImvT+ODT2OW2uQN674q/fLegVtz+2cmd6ggGz5
 FZPwcR4fQsiCHo46VsQQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The THERMAL_GOV_POWER_ALLOCATOR symbol requires CONFIG_ENERGY_MODEL:

WARNING: unmet direct dependencies detected for THERMAL_GOV_POWER_ALLOCATOR
  Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
  Selected by [y]:
  - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>

Add this as a dependency for THERMAL_DEFAULT_GOV_POWER_ALLOCATOR to
avoid creating invalid configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 59b79fc48266..712bcd668a4d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -109,6 +109,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
 config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
 	bool "power_allocator"
 	select THERMAL_GOV_POWER_ALLOCATOR
+	depends on ENERGY_MODEL
 	help
 	  Select this if you want to control temperature based on
 	  system and device power allocation. This governor can only
-- 
2.20.0

