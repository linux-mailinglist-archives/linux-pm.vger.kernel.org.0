Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B02C27482F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIVSef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 14:34:35 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:33912 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgIVSef (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Sep 2020 14:34:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600799674; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=SpvSEszZPLlovWtyzKGQdgYTfPKz5nporXclrWcdqws=; b=pLvWU23Y2v913iXs6Q274wMVVm7OAzZfNeF81uCq70NzYtCS24jUf09OMwCNK8upmVcjoSdI
 YsJoUDRYztCDttIqPjCtBZXbMN91+GgD/qLMJKt19Ypzx9V8GE8ou6K57HYVzFkV/VVXvJr6
 420Iz23R+NRJx5wSYNa9e4YfdFo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f6a43b9429250c1ddb40bf1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 18:34:33
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B9CFC433F1; Tue, 22 Sep 2020 18:34:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DA3AC433CA;
        Tue, 22 Sep 2020 18:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DA3AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2] cpuidle: record state entry rejection statistics
Date:   Tue, 22 Sep 2020 12:34:16 -0600
Message-Id: <20200922183416.14442-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUs may fail to enter the chosen idle state if there was a pending
interrupt. The cpuidle driver would return an error value in that case.
Let's record that and show along with other statistics for the idle
state. This could prove useful in understanding behavior of the governor
and the system during usecases that involve multiple CPUs.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>

---
Changes in v2:
- Rename 'failed' to 'rejected'
- Update documentation
---
 Documentation/admin-guide/pm/cpuidle.rst | 8 ++++++++
 drivers/cpuidle/cpuidle.c                | 1 +
 drivers/cpuidle/sysfs.c                  | 3 +++
 include/linux/cpuidle.h                  | 1 +
 4 files changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index a96a423e3779..1e7fd7a64c65 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -528,6 +528,9 @@ object corresponding to it, as follows:
 	Total number of times the hardware has been asked by the given CPU to
 	enter this idle state.
 
+``rejected``
+        Total number of times the idle state requested to the CPU was rejected.
+
 The :file:`desc` and :file:`name` files both contain strings.  The difference
 between them is that the name is expected to be more concise, while the
 description may be longer and it may contain white space or special characters.
@@ -572,6 +575,11 @@ particular case.  For these reasons, the only reliable way to find out how
 much time has been spent by the hardware in different idle states supported by
 it is to use idle state residency counters in the hardware, if available.
 
+Generally, an  interrupt received when entering idle state would cause the idle
+state entry request to be rejected. The return value from the cpuidle driver
+indicates whether the idle state was entered or rejected. The files
+:file:`usage` and :file:`rejected` report the number of times the idle states
+were successfully entered and rejected, respectively.
 
 .. _cpu-pm-qos:
 
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 6c7e5621cf9a..0ed5030b89d6 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -307,6 +307,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		}
 	} else {
 		dev->last_residency_ns = 0;
+		dev->states_usage[index].rejected++;
 	}
 
 	return entered_state;
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 091d1caceb41..53ec9585ccd4 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -256,6 +256,7 @@ define_show_state_time_function(exit_latency)
 define_show_state_time_function(target_residency)
 define_show_state_function(power_usage)
 define_show_state_ull_function(usage)
+define_show_state_ull_function(rejected)
 define_show_state_str_function(name)
 define_show_state_str_function(desc)
 define_show_state_ull_function(above)
@@ -312,6 +313,7 @@ define_one_state_ro(latency, show_state_exit_latency);
 define_one_state_ro(residency, show_state_target_residency);
 define_one_state_ro(power, show_state_power_usage);
 define_one_state_ro(usage, show_state_usage);
+define_one_state_ro(rejected, show_state_rejected);
 define_one_state_ro(time, show_state_time);
 define_one_state_rw(disable, show_state_disable, store_state_disable);
 define_one_state_ro(above, show_state_above);
@@ -325,6 +327,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_residency.attr,
 	&attr_power.attr,
 	&attr_usage.attr,
+	&attr_rejected.attr,
 	&attr_time.attr,
 	&attr_disable.attr,
 	&attr_above.attr,
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 6175c77bf25e..ed0da0e58e8b 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -38,6 +38,7 @@ struct cpuidle_state_usage {
 	u64			time_ns;
 	unsigned long long	above; /* Number of times it's been too deep */
 	unsigned long long	below; /* Number of times it's been too shallow */
+	unsigned long long	rejected; /* Number of times idle entry was rejected */
 #ifdef CONFIG_SUSPEND
 	unsigned long long	s2idle_usage;
 	unsigned long long	s2idle_time; /* in US */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

