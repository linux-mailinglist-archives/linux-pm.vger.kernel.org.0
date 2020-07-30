Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B9233727
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG3Qvm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 12:51:42 -0400
Received: from foss.arm.com ([217.140.110.172]:42538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3Qvl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 12:51:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F37141FB;
        Thu, 30 Jul 2020 09:51:40 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CF543F66E;
        Thu, 30 Jul 2020 09:51:39 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     lukasz.luba@arm.com
Subject: [PATCH] thermal: Update power allocator and devfreq cooling to SPDX licensing
Date:   Thu, 30 Jul 2020 17:51:17 +0100
Message-Id: <20200730165117.13998-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the license to the SPDX licensing format.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c     | 10 +---------
 drivers/thermal/gov_power_allocator.c |  9 +--------
 include/linux/devfreq_cooling.h       |  9 +--------
 3 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index f7f32e98331b..a12d29096229 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * devfreq_cooling: Thermal cooling device implementation for devices using
  *                  devfreq
  *
  * Copyright (C) 2014-2015 ARM Limited
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * TODO:
  *    - If OPPs are added or removed after devfreq cooling has
  *      registered, the devfreq cooling won't react to it.
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 44636475b2a3..5cb518d8f156 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -1,16 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * A power allocator to manage temperature
  *
  * Copyright (C) 2014 ARM Ltd.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #define pr_fmt(fmt) "Power allocator: " fmt
diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
index 79a6e37a1d6f..9df2dfca68dd 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -1,17 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * devfreq_cooling: Thermal cooling device implementation for devices using
  *                  devfreq
  *
  * Copyright (C) 2014-2015 ARM Limited
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __DEVFREQ_COOLING_H__
-- 
2.17.1

