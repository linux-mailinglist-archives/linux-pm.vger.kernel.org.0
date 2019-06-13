Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14844B18
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 20:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFMSuI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 14:50:08 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37777 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfFMSuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 14:50:05 -0400
Received: by mail-qt1-f202.google.com with SMTP id g56so18287915qte.4
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iJr+4ggl20eIHBVlJYsDbfpCyG/SofOdghTKFndlSZ8=;
        b=ZNmrxIDGISYo8WckRqA+U9BeAMfdaZgYUeKcQK7fqG1we20mp4O5NLtseFdKS5ovVQ
         mVvM7smCjfbZn21w0Dc+HJALtNy4FX71JUunI1r7qtidj3JlFGmMM4kN6LUGbQQfwqGu
         l0BiTL2Tj/qD0qEMEIEdt8W1xjodgCc8PIPMCUDv1d5cG04G4lfrRFsp7Z2FtAjAwo4G
         UYhbibGtJHebHm8ekp4H8FTx5qtAWgrXJlBzD88dHmBzkCB0eGIozvLcbvXPa6foCDaR
         623GQqP2YExDAwSdh3ZxV6LtEhqOQMqin5MIjLf4Ryrx2qywPAItgttFSnoHpbWJQ5jT
         5O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iJr+4ggl20eIHBVlJYsDbfpCyG/SofOdghTKFndlSZ8=;
        b=MOi8XznKfcsd1aMP5B7NTavmSMHVlatyABNTjWK0DJcR+Is1VQBtZkQmIZUs/z7kgF
         py3IXwNPRbD43LNCKCjAHxVvphb9gFEPjORb3oM8WO9NTZ/c4yAO+bcX5ozt/2XUwo1y
         EXik3Ebav89cCkcCR7LO4pD55Ov9l8RL294U8qgf6cZUWoT4fd6HeL40/VIbBGfBW/Yz
         U7SxSq411sOVn7hyxs3uFA0m3qSAPSIkXdFBABW9SLxsp/2yck1tZ3DtrWEpCdBcDJ2D
         BkZTKxuzPu9+Gbhqpbz/E/aif2rIftzSF3HGtblBLi0xdiSufJLcGyIMymD/u/fXdTTn
         sAUA==
X-Gm-Message-State: APjAAAWtyZOUAJEqJhzy407Ge4UxvOy8mk7Hx8GTESBQo6I5hh2K5Tee
        dOSK7dSlu3DcdWrwEuGoeRoL8TYAyw==
X-Google-Smtp-Source: APXvYqwhjG00MYYwYwHHJbawQhq3fK3to0Ed8wqqChYuKXI3+Et4oxHXvuWz9NCupF34Rw4x45Pi6oYfAQ==
X-Received: by 2002:ac8:2bd4:: with SMTP id n20mr67510092qtn.131.1560451804213;
 Thu, 13 Jun 2019 11:50:04 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:49:23 -0700
Message-Id: <20190613184923.245935-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] thermal: armada: Fix -Wshift-negative-value
From:   Nathan Huckleberry <nhuck@google.com>
To:     miquel.raynal@bootlin.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Clang produces the following warning

drivers/thermal/armada_thermal.c:270:33: warning: shifting a negative
signed value is undefined [-Wshift-negative-value]
1 warning        reg &= ~CONTROL1_TSEN_AVG_MASK <<
CONTROL1_TSEN_AVG_SHIFT; generated
.
               ~~~~~~~~~~~~~~~~~~~~~~~ ^

CONTROL1_TSEN_AVG_SHIFT is defined to be zero.
Since shifting by zero does nothing this variable can be removed.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/532
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/thermal/armada_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 8c07a393dc2e..709a22f455e9 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -53,7 +53,6 @@
 #define CONTROL0_TSEN_MODE_EXTERNAL	0x2
 #define CONTROL0_TSEN_MODE_MASK		0x3
 
-#define CONTROL1_TSEN_AVG_SHIFT		0
 #define CONTROL1_TSEN_AVG_MASK		0x7
 #define CONTROL1_EXT_TSEN_SW_RESET	BIT(7)
 #define CONTROL1_EXT_TSEN_HW_RESETn	BIT(8)
@@ -267,8 +266,8 @@ static void armada_cp110_init(struct platform_device *pdev,
 
 	/* Average the output value over 2^1 = 2 samples */
 	regmap_read(priv->syscon, data->syscon_control1_off, &reg);
-	reg &= ~CONTROL1_TSEN_AVG_MASK << CONTROL1_TSEN_AVG_SHIFT;
-	reg |= 1 << CONTROL1_TSEN_AVG_SHIFT;
+	reg &= ~CONTROL1_TSEN_AVG_MASK;
+	reg |= 1;
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 }
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

