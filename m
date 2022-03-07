Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716404D02EC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 16:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiCGPcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 10:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242851AbiCGPcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 10:32:14 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD3775E56
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 07:31:18 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h14so1862342lfk.11
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAufLERw8MkwvkTbq61o/HNe1XRsM+QcoRT3PGoZF2M=;
        b=to07ZqJ037ZLwa48faxkbnqXN2Ei8NpUD1tMAZk642lKhs2WjW9jiQL9+IwvLyjXtR
         vfYVz56gyZo8c+62nO3BUzMggbUedaFZegNjO1sk3iuha4Yr9QYoh9wHpimqHnFRGyLZ
         RCX0xA3kc8vUquOilTJ6lmTW1gBobX3N+K5wNPyWvrb/l3pnQt9VuqUXX3GtP4BoQPjv
         xJDErQVBAaPi8tz3kw2X580Bb4pCleBuFWgDQeCtLetnZHbqyvfUxFB2xhntnlRodwbc
         B4COrOncV+MXRK+AYrk1MxlgXqrnSSgdObCCoImuhwcLe27CcIi0ju60SbjMwO9nRTVL
         2DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAufLERw8MkwvkTbq61o/HNe1XRsM+QcoRT3PGoZF2M=;
        b=aiaeFHjoYj5v+AhkC6g1xPOC0fhH9a7Ay5dxGxn6QwK4qyHVzoCks97UGvvS0XvF4I
         bNsZBsFd8GI1EHW+F7jCvxyheoZJpAvOmuFpac9yG16faiomxE6gW7dw9raaCOKjC/Mb
         9/jWMnTsnG/I6goZMwfaYAvqYU85cwSs+4ab6jhHFL41TabwntHKsWBUSJNnWqhY0BQU
         lG+s1+aunIXEKNRtyfR08sMgUwEXOQ0PO8N5V2pAxooNAGi7u1KhoDB6rhw5j7w72Jvi
         uRJwgSFzgRiCw36kNBSgU4HoiU8Ar9F5dM5bLb08F1x2o7/mQUDT9sJ5fmu5f4tPhTad
         LaHQ==
X-Gm-Message-State: AOAM533O738K9g2/fbVoFdSICqPx8JF0bC40TzacyXTeTHohLj0bnPG+
        tYjnOluFjgYc1RMK1lHJLOsHrw==
X-Google-Smtp-Source: ABdhPJx7/Z/mAoN+Dg4cUP20/VdI3YrwCOvEoAB4qqAimIDsX4w3BUeh0rgZmgOoQ2JZmfUhJ+MeBw==
X-Received: by 2002:a05:6512:313a:b0:443:5f49:b6cf with SMTP id p26-20020a056512313a00b004435f49b6cfmr8222186lfd.472.1646667074207;
        Mon, 07 Mar 2022 07:31:14 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e8e61000000b00247dd27e05bsm1662062ljk.100.2022.03.07.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:31:13 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/4] cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
Date:   Mon,  7 Mar 2022 18:30:48 +0300
Message-Id: <20220307153050.3392700-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
References: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

qcom_lmh_dcvs_poll() can be running when the cpu is being put offline.
This results in the following warning. The driver would disable the
worker, but it happens closer to the end of cpufreq_offline(). Change
the locking in the qcom_lmh_dcvs_poll(), so that the worker can not run
in parallel with cpufreq_offline() call.

[   37.122433] ------------[ cut here ]------------
[   37.127225] WARNING: CPU: 0 PID: 187 at drivers/base/arch_topology.c:180 topology_update_thermal_pressure+0xec/0x100
[   37.138098] Modules linked in:
[   37.141279] CPU: 0 PID: 187 Comm: kworker/0:3 Tainted: G S                5.17.0-rc6-00389-g37c83d0b8710-dirty #713
[   37.158306] Workqueue: events qcom_lmh_dcvs_poll
[   37.163095] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   37.170278] pc : topology_update_thermal_pressure+0xec/0x100
[   37.176131] lr : topology_update_thermal_pressure+0x20/0x100
[   37.181977] sp : ffff800009b6bce0
[   37.185402] x29: ffff800009b6bce0 x28: ffffd87abe92b000 x27: ffff04bd7292e205
[   37.192792] x26: ffffd87abe930af8 x25: ffffd87abe94e4c8 x24: 0000000000000000
[   37.200180] x23: ffff04bb01177018 x22: ffff04bb011770c0 x21: ffff04bb01177000
[   37.207567] x20: ffff04bb0a419000 x19: 00000000000c4e00 x18: 0000000000000000
[   37.214954] x17: 000000040044ffff x16: 004000b2b5503510 x15: 0000006aaa1326d2
[   37.222333] x14: 0000000000000232 x13: 0000000000000001 x12: 0000000000000040
[   37.229718] x11: ffff04bb00400000 x10: 968f57bd39f701c8 x9 : ffff04bb0acc8674
[   37.237095] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffffd87abd90092c
[   37.244478] x5 : 0000000000000016 x4 : 0000000000000000 x3 : 0000000000000100
[   37.251852] x2 : ffff04bb0a419020 x1 : 0000000000000100 x0 : 0000000000000100
[   37.259235] Call trace:
[   37.261771]  topology_update_thermal_pressure+0xec/0x100
[   37.267266]  qcom_lmh_dcvs_poll+0xbc/0x154
[   37.271505]  process_one_work+0x288/0x69c
[   37.275654]  worker_thread+0x74/0x470
[   37.279450]  kthread+0xfc/0x100
[   37.282712]  ret_from_fork+0x10/0x20
[   37.286417] irq event stamp: 74
[   37.289664] hardirqs last  enabled at (73): [<ffffd87abdd78af4>] _raw_spin_unlock_irq+0x44/0x80
[   37.298632] hardirqs last disabled at (74): [<ffffd87abdd71fc0>] __schedule+0x710/0xa10
[   37.306885] softirqs last  enabled at (58): [<ffffd87abcc90410>] _stext+0x410/0x588
[   37.314778] softirqs last disabled at (51): [<ffffd87abcd1bf68>] __irq_exit_rcu+0x158/0x174
[   37.323386] ---[ end trace 0000000000000000 ]---

Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 740518d8ae16..920c80d91c21 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -283,6 +283,23 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	struct dev_pm_opp *opp;
 	unsigned int freq;
 
+	/*
+	 * Synchronize against CPU going offline.
+	 * cpufreq_offline() will get the write lock on policy->rwsem.
+	 */
+retry:
+	if (unlikely(!down_read_trylock(&policy->rwsem))) {
+		mutex_lock(&data->throttle_lock);
+		if (data->cancel_throttle) {
+			mutex_unlock(&data->throttle_lock);
+			return;
+		}
+
+		mutex_unlock(&data->throttle_lock);
+
+		schedule();
+		goto retry;
+	}
 	/*
 	 * Get the h/w throttled frequency, normalize it using the
 	 * registered opp table and use it to calculate thermal pressure.
@@ -301,9 +318,10 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 
 	/*
 	 * In the unlikely case policy is unregistered do not enable
-	 * polling or h/w interrupt
+	 * polling or h/w interrupt.
+	 * If we are here, we have the policy->rwsem read lock,
+	 * cancel_throttle can be toggled only with the write lock.
 	 */
-	mutex_lock(&data->throttle_lock);
 	if (data->cancel_throttle)
 		goto out;
 
@@ -318,7 +336,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 				 msecs_to_jiffies(10));
 
 out:
-	mutex_unlock(&data->throttle_lock);
+	up_read(&policy->rwsem);
 }
 
 static void qcom_lmh_dcvs_poll(struct work_struct *work)
-- 
2.34.1

