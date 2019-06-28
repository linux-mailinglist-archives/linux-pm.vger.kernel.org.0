Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88F459870
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfF1Kcl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 06:32:41 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1Kck (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 06:32:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1g3U-1iiM2L2LVY-0122IQ; Fri, 28 Jun 2019 12:32:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] devfreq: tegra20: add COMMON_CLK dependency
Date:   Fri, 28 Jun 2019 12:32:20 +0200
Message-Id: <20190628103232.2467959-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xhFrlLf9WRsFZysgRMvpYZSAo7T4pW2ZaZmYc/wRs8vpFy7E5xr
 7S6L2CV+f/6B7ifuk+MUFRIU2zmgkCGWtDzIk/q+RgA7IPl4Ap38X0eSLPjfCNpQ82srMRg
 zdVBYAgJItSmqT4CIRsnDCakn7wW9YUMYTX8RNn3zS6BCLn4mNBj2vnk4WvzzwJqI2qi0kw
 C+0O7XnNbUwrnjnp26opw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWmgNnRSzZw=:QqmRafXxr6ylAwu1Ap+5OY
 P12lZ4lA9RESodDWEaBL0WU3oJlpyVGCL1b1ZXYaUbvI5q6eJPGTrs9HBJ0A+T29cvtMNSG3Q
 dph3QEsfhgXnlmLgYy8GweuZkEjvPM9a3piyIP9t7A+6MvxDpZEg7pzg1pK6pxWK049Czp0Xc
 yw5LCD5Mlp7M8dXI7jY8651fxBkfvfAtuuRG6Jul3NqfjwJqsH5IatDgOof2Pt41pB0UzAdy0
 wf9Nx6OzFqrHCcZMam50WME1TalCWo+SsgqnMVhIUIHApmd5ka69qwHJJCBUmgoNvlgGZ7g0S
 a6UR25e9yiHiRcPourvTxU9oS9zjqGIKdVgvtWwmsmWcbYIvHft9Pb5spQFCGbUyczjLWEPJY
 jbzOhhkb7zeoY9EiQtU18hhxYaUQj1ekorObFi2RwFam6vXVq/ZNa1uvQAC8C2NBVZb4DEu2i
 Lw3+rra7W698ApYCMgLCzlcPzfgY6ktakra1XOTREG1zjV9yWFHrCdTJQja5jOhnEHfFFYdwQ
 YLQxZIWRO6uSd4y/R8x6jS7GLK4lJUuJP+wYS0BrjULlbJC6qI1H99XrOHP9gfpG9BAqDtZT0
 XS/T1L4He9T7w8ZxESPId+BUCJ2SLaK5XplHAIoRGkuo/TeiscYovgZz1v+QR7z15niA6YlX0
 qzjcKDxlCQrmQbcJGemD2T1el4RrvZ9SkCMKfBwAPcGV1olIvV5q6DF8KFyf86J0y4Uq77MR0
 5lkFHeg3MSj3W1QTgnlAZpkY7H5WLVBjXgZr2w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Compile-testing the new driver on platforms without CONFIG_COMMON_CLK
leads to a link error:

drivers/devfreq/tegra20-devfreq.o: In function `tegra_devfreq_target':
tegra20-devfreq.c:(.text+0x288): undefined reference to `clk_set_min_rate'

Add a dependency on COMMON_CLK to avoid this.

Fixes: 1d39ee8dad6d ("PM / devfreq: Introduce driver for NVIDIA Tegra20")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/devfreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index f3b242987fd9..defe1d438710 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -107,6 +107,7 @@ config ARM_TEGRA_DEVFREQ
 config ARM_TEGRA20_DEVFREQ
 	tristate "NVIDIA Tegra20 DEVFREQ Driver"
 	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
+	depends on COMMON_CLK
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_OPP
 	help
-- 
2.20.0

