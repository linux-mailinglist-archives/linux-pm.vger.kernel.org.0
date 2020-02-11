Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B11A159435
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 17:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgBKQDo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 11:03:44 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35570 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgBKQDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 11:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581437018; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eqz+dXWlx2geLx0boHuaL+MtB8wylUNe2oXXeMBk+b4=;
        b=KKmkEw7pd22w0XgOCjrbIn8PNXgZwPr6PRuxA/FyfEjE/JPYgR35m30PIIgztpPcbfmxzv
        YA1ncxuCcjkmEQcRXJuki64g3cZYqkzduz05OCyuynCtM9eJJFFDvED6KXWGB6MP4uwrDP
        Qv3ZweTZTU5hkOHryP25EXSu/kJj3AU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [RFC PATCH 1/3] PM: introduce pm_ptr() and pm_sleep_ptr()
Date:   Tue, 11 Feb 2020 13:03:19 -0300
Message-Id: <20200211160321.22124-2-paul@crapouillou.net>
In-Reply-To: <20200211160321.22124-1-paul@crapouillou.net>
References: <20200211160321.22124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These macros are analogous to the infamous of_match_ptr(). If CONFIG_PM
or CONFIG_PM_SLEEP are enabled (respectively), these macros will resolve
to their argument, otherwise to NULL.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/linux/pm.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e057d1fa2469..1e183d78a1ae 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -374,6 +374,18 @@ const struct dev_pm_ops name = { \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
 
+#ifdef CONFIG_PM
+#define pm_ptr(_ptr) (_ptr)
+#else
+#define pm_ptr(_ptr) NULL
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+#define pm_sleep_ptr(_ptr) (_ptr)
+#else
+#define pm_sleep_ptr(_ptr) NULL
+#endif
+
 /*
  * PM_EVENT_ messages
  *
-- 
2.25.0

