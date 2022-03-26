Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481CB4E81D5
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiCZPxh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Mar 2022 11:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiCZPxg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Mar 2022 11:53:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950412ACE
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:51:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bt26so17998319lfb.3
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGuxe1tdDb+vQ+pZhLOcPKE6MxLU7K+4INF2UgDIqr0=;
        b=Yqxt27hEZ4enS/Hz6DvVZIsJpD5jySXI/e+r7/MOZUXw7X2toawJ6gPkF4TsGR3Gj1
         kchL8DLZ1X0/YYlmaiOXXcVYTZb7l1nNi5oqxXRa+1ZW5LdCsdGejIX053syZqtEVRkw
         mYAEC5yK6oXL+oTkClsIQmPEgKGxRd0oFvh1U9HJqy27CLJHAhArRROfhUE8kDYu9iRV
         NPIvECa9yxV7+wCsywlYIMY7a5oVkbSDgQZkVPoINNGZDkr3wLM/qpM2m/LMXOuD292G
         dHNxvQ1HZwUyUpITpkb69yxI6BXO7lSGN4kWWGKFh/8KhlUOQ3KeNQAfqRGezQsZflzK
         xtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGuxe1tdDb+vQ+pZhLOcPKE6MxLU7K+4INF2UgDIqr0=;
        b=QJP2raigIFX5c7eWnDAiymPvQgviwYgyXPCo5nxcNHiLBOnd3/sAx3q6bNn2/bpIr/
         WUQttPpimoIDpNdanVXCXnPRRjUkmM+68pg/8QjwGLkvNS0pypOZxCcJS6fo+th0/tlV
         OkJMF3zbANsoDqwaOEF3RZTVmIMM/SxUBGK6G7AFvN/ZKdWxDdXUqVefiKHKTMSNSaou
         xO1cO37YP2/INkfUuQxNVWXy9fPIAmAtgit0KgA/5CzLT7U3Qe5ySTzZlpF79K1Zrz6c
         0h8fr12SBav3xS9m2TPAleUl8f0qusUKMp7tx3V6cUKx64gS0A6fre6QpHcm3DTDn69P
         O+Tw==
X-Gm-Message-State: AOAM533tI172YK2ysDSsSoS9xuLmeXtV96FRBvtOEUbi6QwKv5rr3LhD
        Vx/PEnUHAsurPDfYEKLwqxeThfGec2cBhg==
X-Google-Smtp-Source: ABdhPJx6FgKKfA7Gsm5qoa96fp4hyxULZ36tI15uJ/iTrrlmOi/3LS+TS0iR//A1d69nPukRK8VQjw==
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id i3-20020ac25223000000b004485100e427mr12565757lfl.87.1648309917316;
        Sat, 26 Mar 2022 08:51:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id o17-20020a05651238b100b00443c898b598sm1097992lft.112.2022.03.26.08.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 08:51:56 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v4 2/4] cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
Date:   Sat, 26 Mar 2022 18:51:51 +0300
Message-Id: <20220326155153.7377-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326155153.7377-1-dmitry.baryshkov@linaro.org>
References: <20220326155153.7377-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver would disable the worker when cpu is being put offline, but
it happens closer to the end of cpufreq_offline(). The function
qcom_lmh_dcvs_poll() can be running in parallel with this, when
policy->cpus already has been updated. Read policy->related_cpus
instead.

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
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 44d46e52baea..d39a0ef9ea45 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -290,7 +290,7 @@ static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
 static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 {
 	struct cpufreq_policy *policy = data->policy;
-	int cpu = cpumask_first(policy->cpus);
+	int cpu = cpumask_first(policy->related_cpus);
 	struct device *dev = get_cpu_device(cpu);
 	unsigned long freq_hz, throttled_freq;
 	struct dev_pm_opp *opp;
-- 
2.35.1

