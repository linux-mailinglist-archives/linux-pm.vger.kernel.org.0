Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BFD25B58E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 23:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIBVBi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 17:01:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57050 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBVBg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 17:01:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599080495; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=GbVeY0ZgqiNd29XFNDQG29M8gwgAosEfQNf1V+YMppk=; b=YzHR9JVua0a15+uZ3zMGMdurd+u8/ODWD5fMMit/MmsE6MAINQbeInyiXSeSg1raMNgnBfyD
 94qwD2n23SA0vinKyjaShVvEm7K5VpVTGxb17Wu9cdm7kDoYRZH0pWKlrUMgjf8yVB4WVSzZ
 JXO/bNo0W3t1nIK1bUH1gWAMcCs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f50082b238e1efa37359b80 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 21:01:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF3BEC43391; Wed,  2 Sep 2020 21:01:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B97ABC433C6;
        Wed,  2 Sep 2020 21:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B97ABC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] cpuidle: record state entry failed statistics
Date:   Wed,  2 Sep 2020 15:01:16 -0600
Message-Id: <20200902210116.7360-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When CPUs fail to enter the chosen idle state it's mostly because of a
pending interrupt. Let's record that and show along with other
statistics for the idle state. This could prove useful in understanding
behavior of the governor and the system during usecases that involve
multiple CPUs.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/cpuidle/cpuidle.c | 1 +
 drivers/cpuidle/sysfs.c   | 3 +++
 include/linux/cpuidle.h   | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 04becd70cc41..8dbf71f6138d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -302,6 +302,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		}
 	} else {
 		dev->last_residency_ns = 0;
+		dev->states_usage[index].failed++;
 	}
 
 	return entered_state;
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 091d1caceb41..f166687b3bcd 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -256,6 +256,7 @@ define_show_state_time_function(exit_latency)
 define_show_state_time_function(target_residency)
 define_show_state_function(power_usage)
 define_show_state_ull_function(usage)
+define_show_state_ull_function(failed)
 define_show_state_str_function(name)
 define_show_state_str_function(desc)
 define_show_state_ull_function(above)
@@ -312,6 +313,7 @@ define_one_state_ro(latency, show_state_exit_latency);
 define_one_state_ro(residency, show_state_target_residency);
 define_one_state_ro(power, show_state_power_usage);
 define_one_state_ro(usage, show_state_usage);
+define_one_state_ro(failed, show_state_failed);
 define_one_state_ro(time, show_state_time);
 define_one_state_rw(disable, show_state_disable, store_state_disable);
 define_one_state_ro(above, show_state_above);
@@ -325,6 +327,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_residency.attr,
 	&attr_power.attr,
 	&attr_usage.attr,
+	&attr_failed.attr,
 	&attr_time.attr,
 	&attr_disable.attr,
 	&attr_above.attr,
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 75895e6363b8..911b99273eba 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -38,6 +38,7 @@ struct cpuidle_state_usage {
 	u64			time_ns;
 	unsigned long long	above; /* Number of times it's been too deep */
 	unsigned long long	below; /* Number of times it's been too shallow */
+	unsigned long long	failed; /* Number of times it failed to enter */
 #ifdef CONFIG_SUSPEND
 	unsigned long long	s2idle_usage;
 	unsigned long long	s2idle_time; /* in US */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

