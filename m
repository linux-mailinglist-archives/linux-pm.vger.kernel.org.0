Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017B34D3D20
	for <lists+linux-pm@lfdr.de>; Wed,  9 Mar 2022 23:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiCIWkx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Mar 2022 17:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiCIWkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2022 17:40:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF95121503
        for <linux-pm@vger.kernel.org>; Wed,  9 Mar 2022 14:39:53 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s25so6289935lfs.10
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2022 14:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soWKcqKpCVRBynURRotS1gzCb/Cc5Zuwi5TpQP3/+YY=;
        b=nAHZOAvhvsOkFTRcc8CDRqLyHOCiyOM7lSEvnltXotHrdt4R4+nGsG+cfw5ahZxODy
         1gzbtYVM+IGCobQQTYwQm6zmBQA536wJTdugCWLgXxzpXyZOJpak1VrOcJXOK9AuHLkN
         9y7cMN1w4TtqHjQ+Pq7920CaxJlnRiij1r7+9HFrbxvGrj801xwOugolabb5XO51vdzx
         uv0w+ZlNZwOFFcn893vDPYFzcyNbRZ0jVA97WUZnOvw58/dKcH/fXTvONNNZSZlymptN
         2qybJ0b2Upbk51bXiXV+YG8UItC0XdKoub+BpBcoursp+C6xGpr/HxWUC6iVOLncti1c
         dHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soWKcqKpCVRBynURRotS1gzCb/Cc5Zuwi5TpQP3/+YY=;
        b=XkYH17cej/n9PH6bcGRSVWiVY8FbVqXp0WS0We7KdkbbPDwMuktb2QFhN6upwBJh+y
         uhim8CIjUqatBnK2/QQ6HaOJQ6rzXjnGcppEXjW4KvlmbKzg3vOI75UbtsbQ2UnEZuXo
         iJlnhM4o9MIYian8sGizDsuJr0poNJftX7C7HoYsEayrRN1ODTU5bqCFZDdWYoEzSbXk
         ENctu5XgheozrR3sTk6aYpmwL6VNYeLLuOxniZVEKep+IMRVHIPPikz0mHRU70hWqUoW
         y0IQHGZ9pV0jwmJDIUs4O34tgbSgZsIbMDFVDJCmU2aoJNqbSAoR0XQW/maKiPMH7x6n
         EE8w==
X-Gm-Message-State: AOAM532Mj8A3uCJv20pYD2OFxVhQyFgOZ+kQ/CNTCOoU+xpPzYmM4dSf
        rm1EfzrBWTyWd5N/A1M2+Sd+jw==
X-Google-Smtp-Source: ABdhPJykeVFKtAdF5RQ8I2WfOOkNWg8NsUOWFKa2u8g4LToyYksEZkKdZAKQ82dPcccFepg6STgP3g==
X-Received: by 2002:a05:6512:1319:b0:448:429d:c6f4 with SMTP id x25-20020a056512131900b00448429dc6f4mr1189751lfu.472.1646865591430;
        Wed, 09 Mar 2022 14:39:51 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b24-20020a196458000000b004483734e0afsm621036lfj.12.2022.03.09.14.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:39:50 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v2 1/4] cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
Date:   Thu, 10 Mar 2022 01:39:35 +0300
Message-Id: <20220309223938.3819715-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
References: <20220309223938.3819715-1-dmitry.baryshkov@linaro.org>
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
following trace. One is not allowed to call free_irq() with an affinity
hint in place (which was set by qcom_cpufreq_hw_lmh_init()).

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
2.34.1

