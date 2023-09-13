Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4265379EA28
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjIMN4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 09:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbjIMN4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 09:56:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C0519B1
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 06:56:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6448AC433C7;
        Wed, 13 Sep 2023 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694613372;
        bh=o4jDMBY/hW8fInCN3I+ux6T0Enwz8Oe9i7WgkTQcpOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndsj7tPzacC0Ar6PaF4k28acwyFWjDnI3ko/E/fWbfx+h/QwAibD4UXiPEw8iIdXr
         UOU99wLcXgEVHrIl7zeQZ1V6Dw6b7cHYTCjHVfKcenmM3gKYG04SdvAMCHLZEIkeRh
         psdDvTStuQ6+kcLwTJynXcufmncpXS2OMHnKrgfxEvb3H9Yz2VeWktdkhPBZYtH/sS
         sNkg2YnQJq9058UVtH8QYZixcyZCQMh87lOWsWuirZAK651bzKnLBv6Tz+2HkamIvV
         +hf++tbbi4n1BMBaYK49sxuunA4xs2PzBiA223s5SxTfdwQOCJcJhOBM0kNJEwpvb0
         VbEZiLtrGzjtA==
From:   Conor Dooley <conor@kernel.org>
To:     ulf.hansson@linaro.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        arnd@arndb.de, changhuang.liang@starfivetech.com,
        jiajie.ho@starfivetech.com, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh@kernel.org,
        walker.chen@starfivetech.com
Subject: [GIT PULL 2/5] dt-bindings: power: Add power-domain header for JH7110
Date:   Wed, 13 Sep 2023 14:54:25 +0100
Message-Id: <20230913-grumbly-rewrite-34c85539f2ed@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=UZA+qdMFmjRCS72vsUWIOMkmR/rc8R2MaitOCzwhKaI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmM+wUSfWNlL7slf9jvGTC5ReKH7Ykfn17OkbFfen3PM s7UNSkLO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjAR8z+MDL+FEm5m6c4qOFrM vWLbux72+t9/3fYJdR3Zt43r184yLUeG/1FKikGq//azc1h/mz7v1e9+3QaBKmHfJv3yc7eW2B8 5ywkA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Changhuang Liang <changhuang.liang@starfivetech.com>

Add power-domain header for JH7110 SoC, it can use to operate dphy
power.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 include/dt-bindings/power/starfive,jh7110-pmu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt-bindings/power/starfive,jh7110-pmu.h
index 132bfe401fc8..341e2a0676ba 100644
--- a/include/dt-bindings/power/starfive,jh7110-pmu.h
+++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
  * Author: Walker Chen <walker.chen@starfivetech.com>
  */
 #ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
@@ -14,4 +14,7 @@
 #define JH7110_PD_ISP		5
 #define JH7110_PD_VENC		6
 
+#define JH7110_PD_DPHY_TX	0
+#define JH7110_PD_DPHY_RX	1
+
 #endif
-- 
2.39.2

