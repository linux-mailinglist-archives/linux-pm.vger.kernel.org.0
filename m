Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65221F1F5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGNM4c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGNM4c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 08:56:32 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC66C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 05:56:31 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id 30wT2300B4C55Sk010wTZF; Tue, 14 Jul 2020 14:56:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jvKTz-0004x1-5e; Tue, 14 Jul 2020 14:56:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jvKTz-0000h1-30; Tue, 14 Jul 2020 14:56:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / Domains: Restore comment indentation for generic_pm_domain.child_links
Date:   Tue, 14 Jul 2020 14:56:25 +0200
Message-Id: <20200714125625.2584-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The rename of generic_pm_domain.slave_links to
generic_pm_domain.child_links accidentally dropped the TAB to align the
member's comment.  Re-add the lost TAB to restore indentation.

Fixes: 8d87ae48ced2dffd ("PM: domains: Fix up terminology with parent/child")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Feel free to fold into the original, if deemed appropriate.
---
 include/linux/pm_domain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 574a1fadb1e50631..ee11502a575b0eca 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -96,7 +96,7 @@ struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
 	struct list_head parent_links;	/* Links with PM domain as a parent */
-	struct list_head child_links;/* Links with PM domain as a child */
+	struct list_head child_links;	/* Links with PM domain as a child */
 	struct list_head dev_list;	/* List of devices */
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
-- 
2.17.1

