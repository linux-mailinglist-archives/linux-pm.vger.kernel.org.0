Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6987179273
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfG2Rni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:43:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:48715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387717AbfG2RnI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 13:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564422142;
        bh=Wnnz+hi8y3tJujc3hWEm/IcLnQTjhjL2xa9xcuHyzKk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FfyhephkYe4DRdaN9w0q2KGd7KBz5Kl/nduMUa+jjfyznWLXupDAPLwPA2fZC+z8v
         kTzTAaDwrgbp5X05rsyJRG5ILIt1GRRR64bFoNvD4K4qWLw2GqTfOnosA2dWw3z+W4
         txPUiJ/4bidMlThsHBRvh1QUOR/E0tX7gwoBzzu0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.76.97.79]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MNZgw-1hl0mi23Cs-007GSj; Mon, 29 Jul 2019 19:42:22 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v3 06/10] mfd: mt6323: some improvements of mt6397-core
Date:   Mon, 29 Jul 2019 19:41:50 +0200
Message-Id: <20190729174154.4335-7-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729174154.4335-1-frank-w@public-files.de>
References: <20190729174154.4335-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:9xr+xz6oCi8Hq4CxtCXG8ydc0wfU5FupCf1TxOUhXy6Ecocb1fM
 aSVn8md8+cUGLjxd3vi917JGfyikoDSJeei6MChESdK7Jj8dqbSE0fTobO4F6TIS2kX9rX1
 bPqrizS5f4gfTyT4O8PsAX+IlwXuqefq3O8E3APcwZ9xot8tXdy9BR9x+3gfmVOXOzBoMDQ
 +G36n671GmPttm2gsgkgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UsEvIRAap4I=:ImFGOhnDLWESNcA1tn3e5B
 qa4DdURE/2MH5X+YbFL1qkr2uBiNool0SuWPHiLFYJ8txoCdqxQvyTe75X1G0bvFiJwjZluhy
 ubyGGi2GVNn0lQ7k2QOtsmBvgP3ob4t9ehHNW63Fo6kF546PyhG+fu5HAdDDtCkeTrg+jKyhU
 OSAKKgrT6DRiDsocSWyvoz9gDqWFJr822IGt2DhMCHqLt6/ebu/WblKVAByYJJzWbYy/FXNG1
 As0LBu9IuorSfXIE/NU2/9NjKe23ZosC9grywzd7h/eHtPR2NGoMrN8n44eLUwRzyK/44nQOY
 IoXQA7VyhJ5YsyZhP8lLI9ZgqFfURg6SYNSJs3XZWUC+NPUmAemhVJLm9u3Ysv4PufLmvDct1
 blp5Xs1akUj3pduj5mvC8zGVC3YyFHI+opCm1r6ZoqwYxF4fLEJ2TFGXeUyUVkPurO3ciVQkl
 /dFSOlLTe21+5ZUSi0+/ttZnVuQ8HXBFH0/yrW1pKnLEVJ5r0e9p74fb0u9hSOPkX5hs9FHxk
 Vf+pXxwyVY4CP6v3XhbU9HSBJ8Gf64ktFEVmb+RcEQUGNVEMSPvE7wP64r9mbKV30koIimJuD
 jVOoAZWGycFuHPuFmu5simcTCrrk42BnO3aRXY9wrSZA1ZFEeOJCr+du6N6+xmKxjdEoi+8Tb
 v/9feww+oQEmF9tl74of1kh2FOLk2rh3YZEiZPSLtDRhu5EFSZ+BgB2JWk9vY84WM3uVZ44rY
 TjkbEFH3jbVPG7Ogx2EHWavvOl89BoaHo0izGSEkhvfoLkfsmeeo9jMP33zbzW+zSFPDcHEWM
 KTvVqA75htmhR8T9lLYa1I/z6FtdRzlKTrEUKFBZtyQeyfRbLQfkPC/BgPrIXhhtU0fBDwOi3
 bH1NpIeQ+U3/ceVV/9ixyZUsJ1vtx4UzKq3QsEO8l5n7dMdUFIatsM12u5Tb36Oervu7giv+O
 5JRU5uOZO+YcUZvP4Lzi3kdpXQyvvG+m1PRpqBFJoLVtQVBE72/2EGuDDBraczlrzpbog4Fc2
 XvjOKXR6/hatReNJp8Et0ESRVGXya9JiC+CEb7oDRg6pnRA5a8pwYQVi9ygKLp1JXNuEt0dxO
 cKDLo59U6DofOA=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

simplyfications (resource definitions my DEFINE_RES_* macros)

changes since v2: splitted v2 part 4 into 6+7

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/mfd/mt6397-core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 337bcccdb914..5f7070267c9a 100644
=2D-- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2014-2018 MediaTek Inc.
  * Author: Flora Fu, MediaTek
  */

 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -23,16 +24,8 @@
 #define MT6397_CID_CODE		0x97

 static const struct resource mt6397_rtc_resources[] =3D {
-	{
-		.start =3D MT6397_RTC_BASE,
-		.end   =3D MT6397_RTC_BASE + MT6397_RTC_SIZE,
-		.flags =3D IORESOURCE_MEM,
-	},
-	{
-		.start =3D MT6397_IRQ_RTC,
-		.end   =3D MT6397_IRQ_RTC,
-		.flags =3D IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(MT6397_RTC_BASE, MT6397_RTC_SIZE),
+	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
 };

 static const struct resource mt6323_keys_resources[] =3D {
=2D-
2.17.1

