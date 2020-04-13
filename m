Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CC91A6659
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 14:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgDMMcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 08:32:15 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38224 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgDMMcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 08:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586781132; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=QlPjAfIdxHj090lbf0AL7B7989su6jjJKS5OiMvvzVo=;
        b=NrwbG2DMnHeYDYnmBQ+HqRUSGSlIHH5XnXzPDiJSIODzVNKjXubrbXIDykEIIjbfE6HeUO
        KQN54fBp1Br1FWhIXSqUMOQsevNi/WkNXZmfd/hNylSTL81Cn6T+mpymu0HCTYkhfOnWts
        ho5GTCRvVdlClxVX7Bu5/SwzucQPvy4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     od@zcrc.me, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] PM: introduce pm_ptr() macro
Date:   Mon, 13 Apr 2020 14:32:05 +0200
Message-Id: <20200413123207.74552-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This macro is analogous to the infamous of_match_ptr(). If CONFIG_PM
is enabled, this macro will resolve to its argument, otherwise to NULL.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Remove pm_sleep_ptr() macro

 include/linux/pm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e057d1fa2469..1c0eec06905d 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -374,6 +374,12 @@ const struct dev_pm_ops name = { \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
 
+#ifdef CONFIG_PM
+#define pm_ptr(_ptr) (_ptr)
+#else
+#define pm_ptr(_ptr) NULL
+#endif
+
 /*
  * PM_EVENT_ messages
  *
-- 
2.25.1

