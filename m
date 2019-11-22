Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8914106649
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 07:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfKVFtr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 00:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfKVFtp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Nov 2019 00:49:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2212D2072E;
        Fri, 22 Nov 2019 05:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401784;
        bh=uqhPIXMKfLyTsWEAtu6GVSKRK/3Tjp8n6QMtSKSox/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbFQL4UXR78M7FPBgxtw5nO9JImp1LCa+Q1ZPplWGTdIMbhukUci5/VcHHdgEcfRj
         yI+U2+peUbdVpGeontsaPF0tc6t8uzkv9uTMJilaPXDOaeOOkb9aKZzClMblbA4bw6
         N4kUyqBr30WaL4yTRuEzZSbL+VnPwK+n9uY7a7Ms=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Meyer <thomas@m3y3r.de>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 033/219] PM / AVS: SmartReflex: NULL check before some freeing functions is not needed
Date:   Fri, 22 Nov 2019 00:46:05 -0500
Message-Id: <20191122054911.1750-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>

[ Upstream commit 14d338a857f05f894ba3badd9e6d3039c68b8180 ]

NULL check before some freeing functions is not needed.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/avs/smartreflex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 1360a7fa542c5..8760477d0e8af 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -1010,8 +1010,7 @@ static int omap_sr_remove(struct platform_device *pdev)
 
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);
-	if (sr_info->dbg_dir)
-		debugfs_remove_recursive(sr_info->dbg_dir);
+	debugfs_remove_recursive(sr_info->dbg_dir);
 
 	pm_runtime_disable(&pdev->dev);
 	list_del(&sr_info->node);
-- 
2.20.1

