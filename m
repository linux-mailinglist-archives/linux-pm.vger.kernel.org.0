Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBB3497CA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 18:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCYRWE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 13:22:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36390 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCYRVw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 13:21:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lPTg4-00053q-Gy; Thu, 25 Mar 2021 17:21:48 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal/drivers/devfreq_cooling: Fix error return if kasprintf returns NULL
Date:   Thu, 25 Mar 2021 17:21:48 +0000
Message-Id: <20210325172148.485259-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when kasprintf fails and returns NULL, the error return -ENOMEM
is being assigned to cdev instead of err causing the return via the label
remove_qos_re to return the incorrect error code. Fix this by explicitly
setting err before taking the error return path.

Addresses-Coverity: ("Unused valued")
Fixes: f8d354e821b2 ("thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/devfreq_cooling.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fb250ac16f50..2c7e9e9cfbe1 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -402,10 +402,11 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err < 0)
 		goto free_table;
 
-	cdev = ERR_PTR(-ENOMEM);
 	name = kasprintf(GFP_KERNEL, "devfreq-%s", dev_name(dev));
-	if (!name)
+	if (!name) {
+		err = -ENOMEM;
 		goto remove_qos_req;
+	}
 
 	cdev = thermal_of_cooling_device_register(np, name, dfc,
 						  &devfreq_cooling_ops);
-- 
2.30.2

