Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5269D4D02E9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiCGPcJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 10:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiCGPcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 10:32:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FDE69CF5
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 07:31:13 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g39so26842319lfv.10
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzzJB7/1+x4ObuDP7KlAr0feJZSWs8EfgXuS3ZrA+UU=;
        b=FAT+k8fSKkkIpdTQYB9n5xAT/EkrRJSNfGIsjAwHV31fWxC0KEcsmCDeoPBZ3aIpiJ
         nV1txfiKxtAXTatlaxy6GZ8IXWFWddNATTXIaRVdHolq+zXRbx80huoAmQQesNkKutLZ
         HC69+rP6SvwiRC6J2sfGg90XQx2wf9l8J9CYZvTe175P4bf3BigT+UFor5Q+ld1SRKRn
         zfMECn06pIJPfVsXJRTDkE7Wh3RrhYGT+vvU1oKtRAsRJ5IQckk1q/0y0VE9veC0vzNB
         9PN2Oi1GT2zQNOPeTZj8YM12z+V9wgQfFu952JMc9E14RWel9brUjEH7ivLRcUN6pffR
         0lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzzJB7/1+x4ObuDP7KlAr0feJZSWs8EfgXuS3ZrA+UU=;
        b=UoI3JibFyKwGXwavBxSvOemJ7f8r8uT9j8i4aGA0J13cV4t2OJ1JjvVEpmoRQ/gs4U
         jO47OY+m8wvFwRQj8LylEbipEaOVVTdKqG14WlpHY8WJBQjcx67mbFwfLOb5XOl5A6Lr
         HnE+kAVjoZWcRes4udvC1MoFTaQ1E4sOQ9h2vCWj8BfYyoxVAU8lT+LeyiYF73LW10uQ
         wp1cG13MbSqBp0jibluqKW3V85+VcIhRxiLysf2xY35gep7VgZsLi2IqLJ1HuChOaAOo
         BAp2dSu2Ye6RcdTRid5TAsgeYJ9iCRlHZAnyb/tPyQslhl6sDxzLMNMU42QmBd4R1jBY
         n50A==
X-Gm-Message-State: AOAM533XnxplqOHvXcBt57nT65W5GlSN8N43rS6z5dTxniQ1s0oNkHyM
        5TvQW70sQ7c1udUwOmx0kR6QTaT7G+A6TA==
X-Google-Smtp-Source: ABdhPJw8INgNGbdwdQV26RzaBi+dJhni5zk737tPTT00wvy1/P1/5qXipe0v8ewhExpMvn7nQHsdow==
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id cf8-20020a056512280800b0043f4baa7e5fmr7666803lfb.498.1646667069636;
        Mon, 07 Mar 2022 07:31:09 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e8e61000000b00247dd27e05bsm1662062ljk.100.2022.03.07.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:31:09 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/4] cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
Date:   Mon,  7 Mar 2022 18:30:47 +0300
Message-Id: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index effbb680b453..740518d8ae16 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -412,6 +412,7 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 	mutex_unlock(&data->throttle_lock);
 
 	cancel_delayed_work_sync(&data->throttle_work);
+	irq_set_affinity_hint(data->throttle_irq, NULL);
 	free_irq(data->throttle_irq, data);
 }
 
-- 
2.34.1

