Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4317B47E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 03:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCFCe1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 21:34:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35962 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgCFCe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 21:34:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id l41so429700pjb.1;
        Thu, 05 Mar 2020 18:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ke0lWEigG8BKBEid+QNLchybndRR9eW4hf0oFbUv1Ok=;
        b=HoOHi/Q9IQaGvD1oqtpyHKSzG1rhsHQW4xqqEouDilS3n/XjOsULN02JVajiwx6Y51
         Q4vS9KDRYMOsxxrGhUq9S25hw6JtifKCdjzCis8U92xiyN81Ih0Z3Ee5nYW+dYC8jkJ7
         JytS7r2U1kpez5gUM5NEp0w1t/8DfXZABx9JliexMIiuuKTS8/7L/IrRDARnVbyup8IY
         TG6UpDGYloowOoEFEqdJ3tXbNejbMMTikCSz7143fwXs5rSCke3ILMn+CE/9uWhVgKsJ
         0i9osjVtFidAGmYjbWlvUJLg+01+ZUBwwD6PLRoCvYrSarreC9Omi/t4dDoZjpbOlX9z
         7W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ke0lWEigG8BKBEid+QNLchybndRR9eW4hf0oFbUv1Ok=;
        b=VlvqYyRaZHOBq6PJ7M5RevvUlnn4lI6zfvszow65Y2moTGs357I+PqQPAHnziUnNpa
         mZgPMABEWiGiCNJRUXNV9rzCpIqXREFGc0+l51COx/A7dp9IIYNLOGqb06tWLQPc67aL
         OM/X4pCyvzGIUwmOd+Z88RGHdm/an/iTq3OEBaeCML7Vz+ipqwax5yL4q8RFHhaoOUJk
         5DkSsY/jEFzoGc5W5n9U/sHgo9YBMIvwayFVf1pOhDfear7x8E5QIEvBAJse0y75z72X
         Ia5zYf2sKCvjj7O9wzZ2MKgJk9vTDQnuW0Nx/i29o4+KtgrkmUPMK+0w8IhCHStB76Gs
         syTg==
X-Gm-Message-State: ANhLgQ10V/oRARnhGun2WhlKFieozBjqCtmhsBcr+5HClwoCzNDm3ZFN
        cNUllokIwkS6hr7T458JjA8=
X-Google-Smtp-Source: ADFU+vsQfL+VUXcvJczGHkI11eMow7FWyFX82DecUQwjEAShJFar53/sKfD43LyxO7kC4kfR3sZTCg==
X-Received: by 2002:a17:90b:1953:: with SMTP id nk19mr1186304pjb.98.1583462066207;
        Thu, 05 Mar 2020 18:34:26 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r133sm5530709pgr.29.2020.03.05.18.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 18:34:25 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        saravanak@google.com, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: Allow charger manager can be built as a module
Date:   Fri,  6 Mar 2020 10:34:10 +0800
Message-Id: <5e098be25c70e07c37e743f84a901f6f756090e0.1583461755.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow charger manager can be built as a module like other charger
drivers.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v1:
 - Use IS_ENABLED() instead.
---
 drivers/power/supply/Kconfig          | 2 +-
 include/linux/power/charger-manager.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9a5591a..195bc04 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -480,7 +480,7 @@ config CHARGER_GPIO
 	  called gpio-charger.
 
 config CHARGER_MANAGER
-	bool "Battery charger manager for multiple chargers"
+	tristate "Battery charger manager for multiple chargers"
 	depends on REGULATOR
 	select EXTCON
 	help
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index ad19e68..ae94dce 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -248,7 +248,7 @@ struct charger_manager {
 	u64 charging_end_time;
 };
 
-#ifdef CONFIG_CHARGER_MANAGER
+#if IS_ENABLED(CONFIG_CHARGER_MANAGER)
 extern void cm_notify_event(struct power_supply *psy,
 				enum cm_event_types type, char *msg);
 #else
-- 
1.9.1

