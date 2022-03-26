Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C904E81D7
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiCZPxh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Mar 2022 11:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiCZPxg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Mar 2022 11:53:36 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CDE13D30
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:52:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b43so9308295ljr.10
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMc1zE/A8/QUCb1FtTjagGiCgSImVddv9mvDKYNqv0I=;
        b=Uz6kx32hwE8pOqayjLZLNMtOBlEijXuCQ52gWxFEl1x7BQDHpJp6pg3KnFdMVfyFu5
         OMg04yG7OXL137GWYeQz4hCYd1IsNnXsTQl3rsBb9B0LPrIMYO/un8xXztAej+/JdfTm
         J5Y9RZ++vfIHVREBcOJptKqdDeuF5/ddsIVlq6q1GJAr6NxOMTItpmpQtJWX9shkY7G2
         FZeS3RNCvo7JLg0uEvOERUSQDZb1qjFovnhoMFDGeybjjwX7o9nz7NB/63WkQV/iRX2C
         PPs7xv9THQlAnTLg4PNawM5tYHjHVhQ5wDHaFfQk2FBjv6dBb45JkFbgdUJww0NzLLIf
         9ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMc1zE/A8/QUCb1FtTjagGiCgSImVddv9mvDKYNqv0I=;
        b=sz533VIX/r8g35tpksuHpNvs6rFt6WgsZeNAM1pt+zYyqVIvWYzIx+S+GEbm8jNpVo
         Q8gosdgvyVSAfuSJawrKfrzmlC8MMHSTDfWY18AzN1v2xtOtlTs29hoZMgrn0gHUKkCw
         yhZ/9dB737hlzOjDrODjc4qWH4mjJ+OFOZszLcT4zRtiwILEhGNjBhRn/Y3alpKN9sdC
         iYUWoqB7wHUXZzvAdLy6fOaeU11y5lNGq2oT1xlcuSfB3oeTHevlW/4Us63NFdLnFyTL
         azkzNz+zsAvvZf8msO3JLLCvjiPO6sSR4GavHPSdprNjO5bv1yHO1bt86groXhPPPWGz
         xLVw==
X-Gm-Message-State: AOAM530lFGugO5smEd4rAS/x9gplKQZpzZTmRUXr2pkQbbTdmEUP/Y/V
        S8NLrXWqKr4ehNIt7wtnmCr9Rw==
X-Google-Smtp-Source: ABdhPJxri4M5kZQrnEP37Jq7Ta7kGOo0dDQTtJj350jVvnpiIScf/nEPSCAmA4g92FxTb75aep0WxA==
X-Received: by 2002:a2e:9593:0:b0:249:b90d:2544 with SMTP id w19-20020a2e9593000000b00249b90d2544mr6539830ljh.6.1648309918245;
        Sat, 26 Mar 2022 08:51:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id o17-20020a05651238b100b00443c898b598sm1097992lft.112.2022.03.26.08.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 08:51:57 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v4 3/4] cpufreq: qcom-hw: fix the opp entries refcounting
Date:   Sat, 26 Mar 2022 18:51:52 +0300
Message-Id: <20220326155153.7377-4-dmitry.baryshkov@linaro.org>
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

The qcom_lmh_dcvs_notify() will get the dev_pm_opp instance for
throttling, but will not put it, ending up with leaking a reference
count and the following backtrace when putting the CPU offline.

Correctly put the reference count of the returned opp instance.

[   84.418025] ------------[ cut here ]------------
[   84.422770] WARNING: CPU: 7 PID: 43 at drivers/opp/core.c:1396 _opp_table_kref_release+0x188/0x190
[   84.431966] Modules linked in:
[   84.435106] CPU: 7 PID: 43 Comm: cpuhp/7 Tainted: G S                5.17.0-rc6-00388-g7cf3c0d89c44-dirty #721
[   84.451631] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[   84.458781] pc : _opp_table_kref_release+0x188/0x190
[   84.463878] lr : _opp_table_kref_release+0x78/0x190
[   84.468885] sp : ffff80000841bc70
[   84.472294] x29: ffff80000841bc70 x28: ffff6664afe3d000 x27: ffff1db6729e5908
[   84.479621] x26: 0000000000000000 x25: 0000000000000000 x24: ffff1db6729e58e0
[   84.486946] x23: ffff8000080a5000 x22: ffff1db40aad80e0 x21: ffff1db4002fec80
[   84.494277] x20: ffff1db40aad8000 x19: ffffb751c3186300 x18: ffffffffffffffff
[   84.501603] x17: 5300326563697665 x16: 645f676e696c6f6f x15: 00001186c1df5448
[   84.508928] x14: 00000000000002e9 x13: 0000000000000000 x12: 0000000000000000
[   84.516256] x11: ffffb751c3186368 x10: ffffb751c39a2a70 x9 : 0000000000000000
[   84.523585] x8 : ffff1db4008edf00 x7 : ffffb751c328c000 x6 : 0000000000000001
[   84.530916] x5 : 0000000000040000 x4 : 0000000000000001 x3 : ffff1db4008edf00
[   84.538247] x2 : 0000000000000000 x1 : ffff1db400aa6100 x0 : ffff1db40aad80d0
[   84.545579] Call trace:
[   84.548101]  _opp_table_kref_release+0x188/0x190
[   84.552842]  dev_pm_opp_remove_all_dynamic+0x8c/0xc0
[   84.557949]  qcom_cpufreq_hw_cpu_exit+0x30/0xdc
[   84.562608]  cpufreq_offline.isra.0+0x1b4/0x1d8
[   84.567270]  cpuhp_cpufreq_offline+0x10/0x6c
[   84.571663]  cpuhp_invoke_callback+0x16c/0x2b0
[   84.576231]  cpuhp_thread_fun+0x190/0x250
[   84.580353]  smpboot_thread_fn+0x12c/0x230
[   84.584568]  kthread+0xfc/0x100
[   84.587810]  ret_from_fork+0x10/0x20
[   84.591490] irq event stamp: 3482
[   84.594901] hardirqs last  enabled at (3481): [<ffffb751c13c3db0>] call_rcu+0x39c/0x50c
[   84.603119] hardirqs last disabled at (3482): [<ffffb751c236b518>] el1_dbg+0x24/0x8c
[   84.611074] softirqs last  enabled at (310): [<ffffb751c1290410>] _stext+0x410/0x588
[   84.619028] softirqs last disabled at (305): [<ffffb751c131bf68>] __irq_exit_rcu+0x158/0x174
[   84.627691] ---[ end trace 0000000000000000 ]---

Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d39a0ef9ea45..db67daed99a3 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -305,12 +305,18 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 
 	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
 	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
-		dev_pm_opp_find_freq_ceil(dev, &freq_hz);
+		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
 
-	throttled_freq = freq_hz / HZ_PER_KHZ;
+	if (IS_ERR(opp)) {
+		dev_warn(dev, "Can't find the OPP for throttling: %pe!\n", opp);
+	} else {
+		throttled_freq = freq_hz / HZ_PER_KHZ;
+
+		/* Update thermal pressure (the boost frequencies are accepted) */
+		arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
 
-	/* Update thermal pressure (the boost frequencies are accepted) */
-	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
+		dev_pm_opp_put(opp);
+	}
 
 	/*
 	 * In the unlikely case policy is unregistered do not enable
-- 
2.35.1

