Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C225E336EE9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 10:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhCKJb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 04:31:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhCKJa6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 04:30:58 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKHeg-0002ZS-C0; Thu, 11 Mar 2021 09:30:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: Fix spelling mistake "disabed" -> "disabled"
Date:   Thu, 11 Mar 2021 09:30:54 +0000
Message-Id: <20210311093054.5338-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a comment, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 include/uapi/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index c105054cbb57..9aa2fedfa309 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -60,7 +60,7 @@ enum thermal_genl_event {
 	THERMAL_GENL_EVENT_UNSPEC,
 	THERMAL_GENL_EVENT_TZ_CREATE,		/* Thermal zone creation */
 	THERMAL_GENL_EVENT_TZ_DELETE,		/* Thermal zone deletion */
-	THERMAL_GENL_EVENT_TZ_DISABLE,		/* Thermal zone disabed */
+	THERMAL_GENL_EVENT_TZ_DISABLE,		/* Thermal zone disabled */
 	THERMAL_GENL_EVENT_TZ_ENABLE,		/* Thermal zone enabled */
 	THERMAL_GENL_EVENT_TZ_TRIP_UP,		/* Trip point crossed the way up */
 	THERMAL_GENL_EVENT_TZ_TRIP_DOWN,	/* Trip point crossed the way down */
-- 
2.30.2

