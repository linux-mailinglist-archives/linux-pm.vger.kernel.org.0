Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA94E81D2
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiCZPxg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Mar 2022 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiCZPxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Mar 2022 11:53:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5403BFD20
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:51:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q14so13798377ljc.12
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eb8mEZgW6Pv9eJz7v3yw4vSszcng2DvogIPFiCFHPAM=;
        b=NvjALIk6sfpnadaKvnK/HRszwktc2fsPkhXqPhPoPE9FxQ6kmwr/My2ajrh0916EBg
         yJ+wJR4IW8YyzD0/cmD7EXzMzY9/Vwhom9MlXyIUddI8DrUQBY+U0qm4ZvG80pY/uWjg
         BkyTEc2ZKztYDAp3wHE93IjIL44N4uU1IJ+KiOJ/ZE/E7hKTM6SGJLAmf59mk04c48y6
         TOPLKfemYjZMIP7YpZBJmSnxoTW7TiJAvRVSUH3J+Z3rpMgZy82t2p6Qpy3gGGXnGZQh
         OxD7Z4Pq8w5Z3s+LxPtGZ0ki9FvmF6feF7Os/XTZd2vvF0UNOYD7371rbSeZCi5oKhZJ
         L2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb8mEZgW6Pv9eJz7v3yw4vSszcng2DvogIPFiCFHPAM=;
        b=2r+op70s1DXI4tMgtwKbli0H8kn1MZBwKipfESWRwv3J3d+5kRfCfFWjkgzU1PmNwf
         eSKLGpB2WqYy5Ph0Mp8YsX/MPaLx6puDWGrWiIaW10yfebkd/qk6SNcleRhtWYWWj4SC
         R/01UEMuPJ8PRWnBkp54yPU5C5UsDuHVSMWMV76/xTff+xRJPT1aS2xAH6FyrH1YRJVe
         LBgDmETqe6sJRxN4bM8PV6G9lb1bAc7paqRzpdc3Q9dHhbvDcSZsTvojF7vIuzy6rXQ7
         3Ypg7RK/8wNsNAJZX5tYV1/t74N4QcRjVUp6LqFaGSX+tG7w9PY+MoYS4g4TcUwJSvI5
         pj8w==
X-Gm-Message-State: AOAM532AGatFvNSwG0Jcsc89l59i5O3bon4Gu0aEufTf4Lj54m0QhPyX
        6d5WUuVFM78XJQa9AKaWK48c+w==
X-Google-Smtp-Source: ABdhPJwW1rh24njroI9lmlYxb90fFkGfmwUYLI+IB/0xKcVjvYlcYVztsq/DLrMEj4lZC8NJhJyvgQ==
X-Received: by 2002:a2e:5318:0:b0:249:8375:81ab with SMTP id h24-20020a2e5318000000b00249837581abmr12199030ljb.243.1648309916264;
        Sat, 26 Mar 2022 08:51:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id o17-20020a05651238b100b00443c898b598sm1097992lft.112.2022.03.26.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 08:51:55 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v4 1/4] cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
Date:   Sat, 26 Mar 2022 18:51:50 +0300
Message-Id: <20220326155153.7377-2-dmitry.baryshkov@linaro.org>
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

Drop affinity hint before freeing the throttling IRQ to fix the
following trace:

[  185.114773] ------------[ cut here ]------------
[  185.119517] WARNING: CPU: 7 PID: 43 at kernel/irq/manage.c:1887 free_irq+0x3a4/0x3dc
[  185.127474] Modules linked in:
[  185.130618] CPU: 7 PID: 43 Comm: cpuhp/7 Tainted: G S      W         5.17.0-rc6-00386-g67382a5b705d-dirty #690
[  185.147125] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  185.154269] pc : free_irq+0x3a4/0x3dc
[  185.158031] lr : free_irq+0x33c/0x3dc
[  185.161792] sp : ffff80000841bc90
[  185.165195] x29: ffff80000841bc90 x28: ffffa6edc5c3d000 x27: ffff6d93729e5908
[  185.172515] x26: 0000000000000000 x25: ffff6d910109fc00 x24: ffff6d91011490e0
[  185.179838] x23: ffff6d9101149218 x22: 0000000000000080 x21: 0000000000000000
[  185.187163] x20: ffff6d9101149000 x19: ffff6d910ab61500 x18: ffffffffffffffff
[  185.194487] x17: 2e35202020202020 x16: 2020202020202020 x15: ffff80008841b9a7
[  185.201805] x14: 00000000000003c9 x13: 0000000000000001 x12: 0000000000000040
[  185.209135] x11: ffff6d91005aab58 x10: ffff6d91005aab5a x9 : ffffc6a5ad1c5408
[  185.216455] x8 : ffff6d91005adb88 x7 : 0000000000000000 x6 : ffffc6a5ab5a91f4
[  185.223776] x5 : 0000000000000000 x4 : ffff6d91011490a8 x3 : ffffc6a5ad266108
[  185.231098] x2 : 0000000013033204 x1 : ffff6d9101149000 x0 : ffff6d910a9cc000
[  185.238421] Call trace:
[  185.240932]  free_irq+0x3a4/0x3dc
[  185.244334]  qcom_cpufreq_hw_cpu_exit+0x78/0xcc
[  185.248985]  cpufreq_offline.isra.0+0x228/0x270
[  185.253639]  cpuhp_cpufreq_offline+0x10/0x20
[  185.258027]  cpuhp_invoke_callback+0x16c/0x2b0
[  185.262592]  cpuhp_thread_fun+0x190/0x250
[  185.266710]  smpboot_thread_fn+0x12c/0x230
[  185.270914]  kthread+0xfc/0x100
[  185.274145]  ret_from_fork+0x10/0x20
[  185.277820] irq event stamp: 212
[  185.281136] hardirqs last  enabled at (211): [<ffffc6a5ac57973c>] _raw_spin_unlock_irqrestore+0x8c/0xa0
[  185.290775] hardirqs last disabled at (212): [<ffffc6a5ac572100>] __schedule+0x710/0xa10
[  185.299081] softirqs last  enabled at (0): [<ffffc6a5ab50f7b0>] copy_process+0x7d0/0x1a14
[  185.307475] softirqs last disabled at (0): [<0000000000000000>] 0x0

Fixes: 3ed6dfbd3bb98 ("cpufreq: qcom-hw: Set CPU affinity of dcvsh interrupts")
Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 618e436018c0..44d46e52baea 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -427,6 +427,7 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 	mutex_unlock(&data->throttle_lock);
 
 	cancel_delayed_work_sync(&data->throttle_work);
+	irq_set_affinity_hint(data->throttle_irq, NULL);
 	free_irq(data->throttle_irq, data);
 }
 
-- 
2.35.1

