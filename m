Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35C11AB55
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 13:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfLKMyZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 07:54:25 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbfLKMyZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 07:54:25 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N4Qg2-1hgpT044jG-011S0Q; Wed, 11 Dec 2019 13:54:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: tegra: add COMMON_CLK dependency
Date:   Wed, 11 Dec 2019 13:54:04 +0100
Message-Id: <20191211125411.1857250-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sP9VUyPZgvStU62dAlKy08xLXzFdkJka9Q5nGaK/wb5wuFnVPT8
 shTcHY3PhXY8zJATgm8XtoMAoKopzMg4scNkDssxMTottbiV+AtePfeHxDbwfaB1CItv/fy
 gu0mspEk19RgqnyEcz89MvnD773Ztm2tCKryufHQosrXloVVV9Zs71C1ErMAHeXisjbUSam
 M9GZpT/B9Fu6kTVh/RS4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zg9yD6HNEx8=:N1kwQltLc4Jwr/NpJXDYkL
 Fkxc/q4nBsRp08NfLNz7d+/ka0ccgZ5FO1bL4Tppbtd5Wm9PX4DKpnea0edq2tx78b/3y/mGy
 8oziLFjz9ussoBPJ5ywnJEZ9UvbIA45VDK5TqM1bUscsFgirSGlLoq64fAFR0w44fEeZX6fUY
 Z8iTA/l+st5VU/rPwCmwLbIpMu3QSN/leTDp7OAAFWqlV6IQ+TvGxF1ZVt3lUpYfMgE10R10z
 ZVWUuD9YMiCpXah0k9zg8icSU6xqLfW3pI2jdDBAmQHHbSMprxcRk/9REYnNmjNFOu4wELJm7
 BfSjml6NuU3MB1WOoHqIgTdtHrZkr//40Ywg3yj+SHkEuMHxMcgSNeTsNRDSuejUlr1OCLxR0
 8KT8uUNVLYkdTNS9ITsZdbewu9ajK/pyt8rtAlmuraly6jMDbfQc+WVhGadEsXnlCUtD7IjwK
 d7mD8bw6QBvvUG1RgyEZnXN+v1ujWx/lSfPExow19CeDUJIpvxlDI+R3EjHDWZ2dVjKJmw/kz
 sn5vEaPTIljeNvZBKCtuCS72BJRxhrwWr0xvnS7Z/5+byP/aaVljtB7+6Fpn4zPp25O0h9MFx
 hJT0UFgBRWHT8uKV7z805WGQS72SCzwucuk7aEH4LaEw20MtL6q0kcNS4DhxHpWpH80TxZ+CW
 aXeqg4TJ6QcIDM2J2K65we5JtM6Gv9rx8+XqmwULdpArs8+SQiyV3bfs8jQOfPi/yNALnoaM9
 5mwD+qESf+hqG9grrTQUzELPy7+KgDk1wZSy3yJeMiYfjQZs3nx+Kvdq2edhYj6EGhXWTOBlb
 dJdqyRs4uIfHTy4SXMYh2sh+sSOxNUGTkYgp55rusxKcHQsmsmNSChqRiJm3hRyU6ys8crtoi
 uzIXydiJRqTYTiGhznCQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Compile-testing this driver fails if CONFIG_COMMON_CLK is not set:

drivers/devfreq/tegra30-devfreq.o: In function `tegra_devfreq_target':
tegra30-devfreq.c:(.text+0x164): undefined reference to `clk_set_min_rate'

Fixes: 35f8dbc72721 ("PM / devfreq: tegra: Enable COMPILE_TEST for the driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/devfreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index defe1d438710..f712c3de0876 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -98,6 +98,7 @@ config ARM_TEGRA_DEVFREQ
 		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
 		ARCH_TEGRA_210_SOC || \
 		COMPILE_TEST
+	depends on COMMON_CLK
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
-- 
2.20.0

