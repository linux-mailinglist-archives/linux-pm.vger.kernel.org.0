Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B970E3D50F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 20:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406859AbfFKSIJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 14:08:09 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60230 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406739AbfFKSIJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 14:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1560276483; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=F92Hgvhl4FW1kSKmvn0gmYzIQd65L6N4f7rKJUGKlLY=;
        b=MFYmu7nMhGPBRi2lqewJHzgo4uCKPVKDPAJ2IbRdcv3xvqrH6HVC5rEoiygSPWVspfSDWg
        dIY3wMpsk1tB4ZTywq5TD9PHRlqDMjkTlkR5OP8S7Tf9ECcXy6pdxGj7rArW+wplLhUASP
        pJfiOFRo5tQAHHVP6aTXHB/XTHtZgAs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/5] clk: ingenic: Add missing header in cgu.h
Date:   Tue, 11 Jun 2019 20:07:53 +0200
Message-Id: <20190611180757.32299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cgu.h has structures that contain 'clk_onecell_data' and 'clk_hw'
structures (no pointers), so the <linux/clk-provider.h> header should be
included.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Rebase on v5.2-rc4

 drivers/clk/ingenic/cgu.h         | 1 +
 drivers/clk/ingenic/jz4725b-cgu.c | 1 -
 drivers/clk/ingenic/jz4740-cgu.c  | 1 -
 drivers/clk/ingenic/jz4770-cgu.c  | 1 -
 drivers/clk/ingenic/jz4780-cgu.c  | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index bfbcf6db437d..ef2db1e26e58 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -10,6 +10,7 @@
 #define __DRIVERS_CLK_INGENIC_CGU_H__
 
 #include <linux/bitops.h>
+#include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
 
diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 8901ea0295b7..6e8bbf620c76 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -6,7 +6,6 @@
  * Author: Paul Cercueil <paul@crapouillou.net>
  */
 
-#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <dt-bindings/clock/jz4725b-cgu.h>
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index c77f4e1506dc..2deac19a8d04 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -6,7 +6,6 @@
  * Author: Paul Burton <paul.burton@mips.com>
  */
 
-#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index dfce740c25a8..42b2ee121642 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/bitops.h>
-#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 2464fc4032af..6d524e760180 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -6,7 +6,6 @@
  * Author: Paul Burton <paul.burton@mips.com>
  */
 
-#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
-- 
2.21.0.593.g511ec345e18

