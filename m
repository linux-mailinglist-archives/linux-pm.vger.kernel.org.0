Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06F6130809
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 13:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgAEMu5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 07:50:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39870 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgAEMu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 07:50:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so25657536pfs.6
        for <linux-pm@vger.kernel.org>; Sun, 05 Jan 2020 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O73F02mr1vEr7ShVhQ/rPt/DWjk1N7vtrWpN2HwbxPw=;
        b=RxnpqQhvQ5bv7z0xIAnD8gdhFyHKqKqpdXwTBhsUdEpg4sSugA+Vrg+Lmzf2NpnmLO
         k22F3pGksCJ5uQ+ueN0NIRXsZNOZuD1vRoDmkDrxuHiRk6/pl0MzljAmGMdmWfGPQFjF
         MZWdUkytwQeduUN8GEa4mwe+wZ2F3Krq2JVCeI+/Pyf/cuxId0btKL3aCfzLBsSwv1rp
         slF/9GvYZkEQ5yxavZwbu0zKrbowEHUqxJ4GsYFcAcxmKtp90yi1nke2ieHiW/Y7W8rs
         Pv0qHXykJtQjq3Ag0JxThiJ0f+3T4jeeYm2rTkdjGLbaIp/Z0LZ6y8p/qj/x0xjdFpBB
         QY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O73F02mr1vEr7ShVhQ/rPt/DWjk1N7vtrWpN2HwbxPw=;
        b=E3UvgFNvK+6BOo40nYuUikmmW0ZEsxfokChijKmNEmyMlHPd47sExMGrHbkSKauaqx
         8kMwYRP8/rWF2VLg6tL/tRvKzT/Hj/jQBjo3ZLpziCR47z4/O9XsDEqKJlkSDEhe1mgI
         bHDlrLUC64P8T/7p9DR6WazvyvW23eMhCa2q0kjIKsfnnUSuhB3697ukXhAMJZLzX8Ye
         rq/koyP1IMv9yJomw01ANzjbjsnomdqF00LeuXzCax8Mxi1NtHJztGZRFe6jILWh97pA
         BVgL6JlBHoIf0DbQP1D+Y5/B3wy4MnuDCzrvlMN+aT61gEXV0avXY0qmYKeCTg19irab
         kWmA==
X-Gm-Message-State: APjAAAXvH9DfqYOddhIpYVPyoLPih3C/34E/ihKw1Vjq6Afj5oFxtd4O
        crf4SIUWLgNQnE7XB4HluOE=
X-Google-Smtp-Source: APXvYqxUgpmdlnIXGhbVIEYm+2ZG/SLeZ4ocWYD5rb0O++qhXkZAxHm0/oxmD2mMWohAObY+FG5NaQ==
X-Received: by 2002:a62:e908:: with SMTP id j8mr93764073pfh.55.1578228656502;
        Sun, 05 Jan 2020 04:50:56 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z130sm70081453pgz.6.2020.01.05.04.50.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 04:50:56 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     mmayer@broadcom.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH v2] cpufreq: brcmstb-avs-cpufreq: avoid potential stuck and UAF risk
Date:   Sun,  5 Jan 2020 20:50:50 +0800
Message-Id: <1578228650-17157-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get cpufreq policy,
meanwhile, it also increments the kobject reference count of policy to
mark it busy. However, a corresponding call of cpufreq_cpu_put() is
ignored to decrement the kobject reference count back, which may lead
to a potential stuck risk that percpu cpuhp thread deadly waits for
dropping of kobject refcount when percpu cpufreq policy free.

The call trace of stuck risk could be:
cpufreq_online()  //If cpufreq online failed, goto out_free_policy.
    ->cpufreq_policy_free()     //Do cpufreq_policy free.
        ->cpufreq_policy_put_kobj()
            ->kobject_put()       //Skip if policy kfref count is not 1.
                ->cpufreq_sysfs_release()
                    ->complete()  //Complete policy->kobj_unregister.
                ->wait_for_completion() //Wait for policy->kobj_unregister.

A simple way to avoid this stuck risk is use cpufreq_cpu_get_raw()
instead of cpufreq_cpu_get(), since this can be easily exercised by
attempting to force an unbind of the CPUfreq driver.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d..6d2bf5c 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -452,8 +452,15 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct private_data *priv = policy->driver_data;
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct private_data *priv;
+
+	if (!policy)
+		return 0;
+
+	priv = policy->driver_data;
+	if (!priv || !priv->base)
+		return 0;
 
 	return brcm_avs_get_frequency(priv->base);
 }
-- 
1.9.1

