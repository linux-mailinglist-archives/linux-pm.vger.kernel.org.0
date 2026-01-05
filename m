Return-Path: <linux-pm+bounces-40192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F3CF4F26
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 18:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC6BD30FA227
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0033339856;
	Mon,  5 Jan 2026 13:13:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D533984D;
	Mon,  5 Jan 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618817; cv=none; b=nVqbc3bOD0IYaATv2Ta6McwzI5Vr1G+kGBsm+Wbbbvf6ZW+EQEFJHF0VkO1N9IKFD60evodG4g7LPHMJEEvj9TkyarBzd/a7I18cw+NIuQ4vUblt1nLH1IQ6mLKdg3nADpX9MaIyJsym/zz2G5HnOftfuUiEyivAHbAWf7L0WYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618817; c=relaxed/simple;
	bh=Vy6RaF7s9rFJKANr5LYAB2S+8LdhlBMuOdgH4W3YKtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJjH/kBI51yKOkpCT7P/M7HHos3nqitwKcvz1EFVRrMwNXEeVWjJr5tgSfBKXlmnAwaGnOAEtqnc2ZCdY+TRapB2B7bUy7zaFbHeqKIIYd5/L3Kktt7VMUuxZIZoRXdisQ31ixgESh+cGgKm0+CW854zym2PhEQEDvfYxDwugPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowADneAzsuFtpFst0Aw--.17822S2;
	Mon, 05 Jan 2026 21:13:18 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: andreas@kemnade.info,
	khilman@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-omap@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] cpufreq: OMAP: Fix resource leak in probe error path and remove
Date: Mon,  5 Jan 2026 21:12:53 +0800
Message-ID: <20260105131253.2692-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215030327.1771-1-vulab@iscas.ac.cn>
References: <20251215030327.1771-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADneAzsuFtpFst0Aw--.17822S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1fAFyrGr4kJry5JF18Zrb_yoW8Zw1kpF
	Z8WrWakr48JF97C39rAF4xCa4ru3WSyw409w1xGwsav3WDAF15Wa4DGa4UAF45K3ykJr4I
	vryUZa1xCF4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUejjgDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8SA2lbeC64dQAAs+

The current omap_cpufreq_probe() uses regulator_get() to obtain the MPU
regulator but does not release it in omap_cpufreq_remove() or when
cpufreq_register_driver() fails.

Add the missing regulator_put() in the remove function and in the
error handling path of the probe function to prevent resource leaks.
Also ensure the mpu_reg pointer is set to NULL after release to avoid
dangling pointers.

Fixes: 53dfe8a884e6 ("cpufreq: OMAP: scale voltage along with frequency")
Suggested-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

---
Changes in v2:
 - Revert to using regulator_get() instead of devm_regulator_get()
   to ensure immediate release of unusable regulators and
   safer handling of the global mpu_reg variable.
 - Add explicit regulator_put() in omap_cpufreq_remove().
 - Add error handling for cpufreq_register_driver() in probe.
---
 drivers/cpufreq/omap-cpufreq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index bbb01d93b54b..b3d58090d202 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -151,6 +151,8 @@ static struct cpufreq_driver omap_driver = {
 
 static int omap_cpufreq_probe(struct platform_device *pdev)
 {
+	int ret;
+
 	mpu_dev = get_cpu_device(0);
 	if (!mpu_dev) {
 		pr_warn("%s: unable to get the MPU device\n", __func__);
@@ -174,12 +176,23 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
 		}
 	}
 
-	return cpufreq_register_driver(&omap_driver);
+	ret = cpufreq_register_driver(&omap_driver);
+	if (ret) {
+		if (mpu_reg) {
+			regulator_put(mpu_reg);
+			mpu_reg = NULL;
+		}
+	}
+	return ret;
 }
 
 static void omap_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&omap_driver);
+	if (mpu_reg) {
+		regulator_put(mpu_reg);
+		mpu_reg = NULL;
+	}
 }
 
 static struct platform_driver omap_cpufreq_platdrv = {
-- 
2.43.0


