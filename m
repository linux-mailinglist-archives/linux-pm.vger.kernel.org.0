Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B01158B77
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 09:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBKIvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 03:51:19 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:32977 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgBKIvS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 03:51:18 -0500
Received: by mail-pj1-f68.google.com with SMTP id m7so740416pjs.0;
        Tue, 11 Feb 2020 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kufx2b86GhMKj2/5JRyQcdEYbiaBCWhtsF2yQMRwNJQ=;
        b=ISuJhI952AfdvwSTac/cDpCFI/qpWyE+qRpiSDF8F50DWcKhHDp1sy9MaKVp5uCazY
         X+dq/WQzT6gQb8eY4hqESnGG8bQrEA1Z/uAsVIu74NKdz4BqCgyafsBt1FwQ7SnXKn4E
         cMeVKyLRS2zHdq1GrScxcz1Mj1RFR6B5dMTw1Prlw9oSRowV1Jz4e/xXImXryTkY93Iq
         gerJNXOyJbQJKtbFdKhPg+ja353+WtT+9i3Vy2guNKNxOK3qHdFH0M6MpSBOYAJn4oUR
         ohq/1x02oA6Zc+9vZdlhdBY4MmlEBnMuoNpD3sFWXrcEtKMojx69JZ+BXlMO/eX+L0ev
         5INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kufx2b86GhMKj2/5JRyQcdEYbiaBCWhtsF2yQMRwNJQ=;
        b=S4SjxqWcneIB2zxyZ2Rz+ZHIMmq7JxRQuIthb00rfhmUUiV7y/2KkYMel6NiZZjoia
         UvLhuHMtVPKk6zZ9TCqmcoQ1YNmaBskFvrX7S8nVRAH4mQRzNLD6Rc5laaqEZXCX0qG8
         xNhJjw0pjsQR1rMzVDHfIc4Wb5UxSs4USfRw/ZbiDw0D1Jv+qkvOKOSSrJKzA0KcCN/N
         NPCX90bb20Tn8gUmUPbRX6f5QfYCpMAYapR2/354/2BgE4KPZqEd64FWxsOEfpdLplJ7
         elA5WXvVLtFyHwV8SqTBnxJDBv3rzE2Lk3BusVGIiBsBJY/5HMxpwLIuzR4cv0ykNOEV
         pmQQ==
X-Gm-Message-State: APjAAAUlkX/+5aDoRO+lCCwr0wpsPiqWV8s+iWjD6WKfn5OaTGxbGQ6P
        H88V/4L1m1qXHHTst403hwA=
X-Google-Smtp-Source: APXvYqxnj7704HHSz3OzLC6RklyKHrNrKRxeJMkFXmg3pfeK2UpiIbXY1kMPj4g0PxeKZt8Dw5WO0g==
X-Received: by 2002:a17:90a:c697:: with SMTP id n23mr2334308pjt.37.1581411076548;
        Tue, 11 Feb 2020 00:51:16 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g19sm3179271pfh.134.2020.02.11.00.51.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Feb 2020 00:51:15 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH] power: supply: Allow charger manager can be built as a module
Date:   Tue, 11 Feb 2020 16:50:22 +0800
Message-Id: <2d0854b00d7f85e988aff4f8186e8ac5d8a9aff2.1581410798.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow charger manager can be built as a module like other charger
drivers.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/supply/Kconfig          |    2 +-
 include/linux/power/charger-manager.h |    7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

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
index ad19e68..40493b2 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -248,11 +248,6 @@ struct charger_manager {
 	u64 charging_end_time;
 };
 
-#ifdef CONFIG_CHARGER_MANAGER
 extern void cm_notify_event(struct power_supply *psy,
-				enum cm_event_types type, char *msg);
-#else
-static inline void cm_notify_event(struct power_supply *psy,
-				enum cm_event_types type, char *msg) { }
-#endif
+			    enum cm_event_types type, char *msg);
 #endif /* _CHARGER_MANAGER_H */
-- 
1.7.9.5

