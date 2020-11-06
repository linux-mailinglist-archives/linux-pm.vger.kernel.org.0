Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99F2A9B8F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKFSFy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFSFx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:05:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3D2C0613CF;
        Fri,  6 Nov 2020 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=90zuK8BdS44z3twp9I9Jyw0x30yb82cvNVQYVDPC/9U=; b=AK0B6vve+vs4QnOQAcsmJ7A5X4
        PxVnO2q4QT3W4RoD/Yixod2UovCJoRby6Q3OKPC7JYJYz9pzDGO00cYzkvv/v62jORtekHV+wIm8O
        6x8wY/SRhAw3D3d/FcLdULGt74TkHAhTS9rSFSm2+HrR0QPK4EZA+33gDMuYFJ+YAMPRWzq2+28LZ
        /7S6L9YvyXzF7rUXjao6vW5BD6ckhvo9IQItoDo0lMgfjvSIjLm56eyWdHZOO816HpoUNAp3VGORd
        WaLQxPJ1VN74XOv2iiHT1BhLvJjjz0eosg7CZzyQcRX2b2rgodW0Dtv8aKwTYkzrx9C+myj9Cglfv
        nkLUuA4g==;
Received: from [2601:1c0:6280:3f0::a1cb] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb67S-0003oB-8v; Fri, 06 Nov 2020 18:05:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>, linux-next@vger.kernel.org
Subject: [PATCH -next] clk: pm_clock: provide stubs for pm_clk_runtime_suspend/_resume
Date:   Fri,  6 Nov 2020 10:05:44 -0800
Message-Id: <20201106180544.5681-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs for pm_clk_runtime_suspend() and pm_clk_runtime_resume()
to fix build errors when CONFIG_PM and CONFIG_PM_CLK are not enabled.

Fixes these build errors:

../drivers/clk/qcom/camcc-sc7180.c: In function ‘cam_cc_sc7180_probe’:
../drivers/clk/qcom/camcc-sc7180.c:1672:8: error: implicit declaration of function ‘pm_clk_runtime_resume’; did you mean ‘pm_runtime_resume’? [-Werror=implicit-function-declaration]
  ret = pm_clk_runtime_resume(&pdev->dev);
        ^~~~~~~~~~~~~~~~~~~~~
../drivers/clk/qcom/camcc-sc7180.c:1681:3: error: implicit declaration of function ‘pm_clk_runtime_suspend’; did you mean ‘pm_runtime_suspend’? [-Werror=implicit-function-declaration]
   pm_clk_runtime_suspend(&pdev->dev);
   ^~~~~~~~~~~~~~~~~~~~~~

Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: Taniya Das <tdas@codeaurora.org>
Cc: linux-next@vger.kernel.org
---
 include/linux/pm_clock.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-next-20201106.orig/include/linux/pm_clock.h
+++ linux-next-20201106/include/linux/pm_clock.h
@@ -83,6 +83,15 @@ static inline void pm_clk_remove(struct
 static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk)
 {
 }
+
+static inline int pm_clk_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+static inline int pm_clk_runtime_resume(struct device *dev)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_HAVE_CLK
