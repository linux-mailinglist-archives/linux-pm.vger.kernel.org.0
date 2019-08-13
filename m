Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9668B870
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 14:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfHMMVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 08:21:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51316 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHMMVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 08:21:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hxVnl-0000lQ-Jy; Tue, 13 Aug 2019 12:21:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: remove redundant assignment to ret
Date:   Tue, 13 Aug 2019 13:21:21 +0100
Message-Id: <20190813122121.28160-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ret is initialized to a value that is never read and it is
re-assigned later. The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c28ebf2810f1..26d82e0a2de5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2140,7 +2140,7 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
 			  unsigned int target_freq,
 			  unsigned int relation)
 {
-	int ret = -EINVAL;
+	int ret;
 
 	down_write(&policy->rwsem);
 
-- 
2.20.1

