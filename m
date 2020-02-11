Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0067A159439
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 17:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgBKQDv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 11:03:51 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35620 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgBKQDv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 11:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581437022; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSs233FqwzrAQhGx3I3FXSTx8oMxW68K2mq8KzZioEg=;
        b=LwA+BxFFHor5krEJ8gi5GbgIf17RQl0b3XBN44Bma1gxBy0Zg6ckP6/ypWNq2b1h5T5fTL
        MktWsXHtpqOG/FX++/V2YxvUVcN79qkNAfP1VZH4SFMzDdAGzIPNB2nX4iip/Hrf5+gPm7
        pvSuJN4Av4wo55g2uJo3OKsxcTg38zc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [RFC PATCH 2/3] PM: Make *_DEV_PM_OPS macros use __maybe_unused
Date:   Tue, 11 Feb 2020 13:03:20 -0300
Message-Id: <20200211160321.22124-3-paul@crapouillou.net>
In-Reply-To: <20200211160321.22124-1-paul@crapouillou.net>
References: <20200211160321.22124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This way, when the dev_pm_ops instance is not referenced anywhere, it
will simply be dropped by the compiler without a warning.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/linux/pm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1e183d78a1ae..892e4fd198c0 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -351,7 +351,7 @@ struct dev_pm_ops {
  * to RAM and hibernation.
  */
 #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops name = { \
+const struct dev_pm_ops __maybe_unused name = { \
 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 }
 
@@ -369,7 +369,7 @@ const struct dev_pm_ops name = { \
  * .runtime_resume(), respectively (and analogously for hibernation).
  */
 #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-const struct dev_pm_ops name = { \
+const struct dev_pm_ops __maybe_unused name = { \
 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
-- 
2.25.0

