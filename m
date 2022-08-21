Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4159B577
	for <lists+linux-pm@lfdr.de>; Sun, 21 Aug 2022 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiHUQfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Aug 2022 12:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUQfP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Aug 2022 12:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E01B794
        for <linux-pm@vger.kernel.org>; Sun, 21 Aug 2022 09:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5930560ED9
        for <linux-pm@vger.kernel.org>; Sun, 21 Aug 2022 16:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87624C433D6;
        Sun, 21 Aug 2022 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661099712;
        bh=O32y1zqLXbZinPeNnLjAWzuQGSI1DeHh0i5QsXH6O0M=;
        h=From:To:Cc:Subject:Date:From;
        b=eCj0YzdRp9ngIH7cEYUWkV57HySaeR4s/ejFoRZW5EW4394gwxSLmLHQoQ8fQ54yy
         3L7C5MwvudwdPdplcenYlqLSWt+i+YY+xF9/bOup6CJ3lxYIb/ZPBl2qJTBZQVFgCD
         wwqP/y4YzJUTr/HkyP46zUGv5D31AmiXTiC9i1I+wnhT73so7OluSz0K5tzYY10LoI
         7AGNhbHuxzRqfsY9fZImDYdQCWbNVHi9MEiIVDicey2gTYhv0C9yPTpJNzWKf9g0qk
         1w5JOqVN+jdI2SnugQKHk97DY4xcyWyf9/VQphvc3EX/PsMjXvLa6A5m505ApzPbgq
         4GSO+gVwdHwwQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: [PATCH] thermal/drivers/qcom: Drop false build dependency of all QCOM drivers on QCOM_TSENS
Date:   Sun, 21 Aug 2022 17:00:32 +0100
Message-Id: <20220821160032.2206349-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The SPMI QCOM drivers have no dependency in Kconfig, but the Makefile
will not be included without QCOM_TSENS. This unnecessarily reduces
build coverage.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---

Run into whilst trying to build test a namespace move for the IIO
interfaces used in these drivers.

Maintainers entry for TSENS should probably also be made more
specific.
---
 drivers/thermal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a0399c..2506c6c8ca83 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
 obj-y				+= intel/
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-y				+= st/
-obj-$(CONFIG_QCOM_TSENS)	+= qcom/
+obj-y				+= qcom/
 obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
-- 
2.37.2

