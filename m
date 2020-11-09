Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFBF2AAFDA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 04:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgKIDVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Nov 2020 22:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgKIDVZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Nov 2020 22:21:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD6C0613CF;
        Sun,  8 Nov 2020 19:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9ccmp8c2bM7yoQL9161bvYGYwR+a7M197QPEnd7pBS8=; b=sMcA3xodBofJCZFcVjN+CXOwGD
        3UMUWvK7TnT5vvv3P12VZi29eJ40OTnWoEv+GnCBVO6WPQbWqsIQxfn2ebL7QSXYddlSb+mGiCmWZ
        nhUOWQVFRppWLbiL7YSNz6mtD+uxXeRI6uMCyx5myzYA8Mzo16Iaoz3yUsHY4nA1NUF1V1e6bJMhd
        Lp+Dh5YpCyflbGyThrOnDxJNN9OEH6AW6Xnq4aPpOCqFb10l5C9kzGD7m1FDi1t7jMxgf1eAxFIHs
        ZQb8r/JJsRsGUoMYS++aje65p13oYrLmu5/1lwv2lEXAcnXG8CE46CJ4u/gsSUrzI6SH2lQOimRn8
        i6eIO7og==;
Received: from [2601:1c0:6280:3f0::64ec] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kbxk9-0003It-9p; Mon, 09 Nov 2020 03:21:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>, linux-next@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -next v2] clk: pm_clock: provide stubs for pm_clk_runtime_suspend/_resume
Date:   Sun,  8 Nov 2020 19:21:15 -0800
Message-Id: <20201109032115.10610-1-rdunlap@infradead.org>
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
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v2: move the function stubs to be inside the #else (for !CONFIG_PM)
    as suggested by Nathan to fix another build error

 include/linux/pm_clock.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-next-20201106.orig/include/linux/pm_clock.h
+++ linux-next-20201106/include/linux/pm_clock.h
@@ -27,6 +27,14 @@ extern int pm_clk_runtime_resume(struct
 	.runtime_resume = pm_clk_runtime_resume,
 #else
 #define USE_PM_CLK_RUNTIME_OPS
+static inline int pm_clk_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+static inline int pm_clk_runtime_resume(struct device *dev)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PM_CLK
