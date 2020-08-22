Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6815424E8DF
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHVQg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Aug 2020 12:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgHVQg6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 22 Aug 2020 12:36:58 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5769C206C0;
        Sat, 22 Aug 2020 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598114218;
        bh=dfGnt+5ykVIU/FKUhQ2ZU0csLC2jXSrfImGzu3SlobE=;
        h=From:To:Subject:Date:From;
        b=VtoK6mSENvhmAMvISv5x+bJ2DnA5oyFI0rfuKfuxKeuc1SAIPWaD6V/IKivGTYJK0
         J59OBL4HpDhg7gWLPCaL62PO66FtWhN4RHfw9Sa+cSJ7QdfhJy/4h+NsVMGm852PC1
         A7ZQVtIvaqWpoY1YXxlM+V255D+JGEP1qjZMM9OU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: samsung: exynos5422-dmc: add missing kerneldoc for dmc_opp_table
Date:   Sat, 22 Aug 2020 18:36:46 +0200
Message-Id: <20200822163646.24202-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

To be squashed with https://lore.kernel.org/linux-samsung-soc/20200822163218.21857-3-krzk@kernel.org/T/#u
---
 drivers/memory/samsung/exynos5422-dmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index a9d04bd31603..4961a565c462 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -98,6 +98,8 @@ MODULE_PARM_DESC(irqmode, "Enable IRQ mode (0=off [default], 1=on)");
 
 /**
  * struct dmc_opp_table - Operating level desciption
+ * @freq_hz:		target frequency in Hz
+ * @volt_uv:		target voltage in uV
  *
  * Covers frequency and voltage settings of the DMC operating mode.
  */
-- 
2.17.1

