Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2048F1E6947
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405801AbgE1SZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 14:25:40 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:56322 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405744AbgE1SZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 14:25:39 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 14:25:38 EDT
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 042F130D897;
        Thu, 28 May 2020 11:20:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 042F130D897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590690016;
        bh=OMwH5PlSdBCTh+TgNNXxVNVUH+PkcvF0SwghNsWFLvg=;
        h=From:To:Cc:Subject:Date:From;
        b=fEoi258tdQ2UsqTvPaDSxg0TZe/gRjRptwVyKNO8zlgoASLxCzJV22AFSKkBZAoSJ
         wxsrPN23eIKFpaprQFWhjR1xPxLy1l+IshoaAgPMC1j3sn+IW9coKB1mtyjAWLTMB+
         GpDrJstRjEjGJJHcqF+Le9+15o5IwNtZ16wF2ReM=
Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 96627140069;
        Thu, 28 May 2020 11:20:15 -0700 (PDT)
From:   Markus Mayer <markus.mayer@broadcom.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Markus Mayer <markus.mayer@broadcom.com>,
        Linux Power Management List <linux-pm@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] cpufreq: brcmstb-avs-cpufreq: more flexible interface for __issue_avs_command()
Date:   Thu, 28 May 2020 11:20:12 -0700
Message-Id: <20200528182014.20021-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are changing how parameters are passed to __issue_avs_command(), so we
can pass input *and* output arguments with the same command, rather than
just one or the other.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 30 +++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 4f86ce2db34f..c8b754694a5e 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -195,7 +195,8 @@ static void __iomem *__map_region(const char *name)
 	return ptr;
 }
 
-static int __issue_avs_command(struct private_data *priv, int cmd, bool is_send,
+static int __issue_avs_command(struct private_data *priv, unsigned int cmd,
+			       unsigned int num_in, unsigned int num_out,
 			       u32 args[])
 {
 	unsigned long time_left = msecs_to_jiffies(AVS_TIMEOUT);
@@ -225,11 +226,9 @@ static int __issue_avs_command(struct private_data *priv, int cmd, bool is_send,
 	/* Clear status before we begin. */
 	writel(AVS_STATUS_CLEAR, base + AVS_MBOX_STATUS);
 
-	/* We need to send arguments for this command. */
-	if (args && is_send) {
-		for (i = 0; i < AVS_MAX_CMD_ARGS; i++)
-			writel(args[i], base + AVS_MBOX_PARAM(i));
-	}
+	/* Provide input parameters */
+	for (i = 0; i < num_in; i++)
+		writel(args[i], base + AVS_MBOX_PARAM(i));
 
 	/* Protect from spurious interrupts. */
 	reinit_completion(&priv->done);
@@ -256,11 +255,9 @@ static int __issue_avs_command(struct private_data *priv, int cmd, bool is_send,
 		goto out;
 	}
 
-	/* This command returned arguments, so we read them back. */
-	if (args && !is_send) {
-		for (i = 0; i < AVS_MAX_CMD_ARGS; i++)
-			args[i] = readl(base + AVS_MBOX_PARAM(i));
-	}
+	/* Process returned values */
+	for (i = 0; i < num_out; i++)
+		args[i] = readl(base + AVS_MBOX_PARAM(i));
 
 	/* Clear status to tell AVS co-processor we are done. */
 	writel(AVS_STATUS_CLEAR, base + AVS_MBOX_STATUS);
@@ -338,7 +335,7 @@ static int brcm_avs_get_pmap(struct private_data *priv, struct pmap *pmap)
 	u32 args[AVS_MAX_CMD_ARGS];
 	int ret;
 
-	ret = __issue_avs_command(priv, AVS_CMD_GET_PMAP, false, args);
+	ret = __issue_avs_command(priv, AVS_CMD_GET_PMAP, 0, 4, args);
 	if (ret || !pmap)
 		return ret;
 
@@ -359,7 +356,7 @@ static int brcm_avs_set_pmap(struct private_data *priv, struct pmap *pmap)
 	args[2] = pmap->p2;
 	args[3] = pmap->state;
 
-	return __issue_avs_command(priv, AVS_CMD_SET_PMAP, true, args);
+	return __issue_avs_command(priv, AVS_CMD_SET_PMAP, 4, 0, args);
 }
 
 static int brcm_avs_get_pstate(struct private_data *priv, unsigned int *pstate)
@@ -367,7 +364,7 @@ static int brcm_avs_get_pstate(struct private_data *priv, unsigned int *pstate)
 	u32 args[AVS_MAX_CMD_ARGS];
 	int ret;
 
-	ret = __issue_avs_command(priv, AVS_CMD_GET_PSTATE, false, args);
+	ret = __issue_avs_command(priv, AVS_CMD_GET_PSTATE, 0, 1, args);
 	if (ret)
 		return ret;
 	*pstate = args[0];
@@ -381,7 +378,8 @@ static int brcm_avs_set_pstate(struct private_data *priv, unsigned int pstate)
 
 	args[0] = pstate;
 
-	return __issue_avs_command(priv, AVS_CMD_SET_PSTATE, true, args);
+	return __issue_avs_command(priv, AVS_CMD_SET_PSTATE, 1, 0, args);
+
 }
 
 static u32 brcm_avs_get_voltage(void __iomem *base)
@@ -593,7 +591,7 @@ static int brcm_avs_cpufreq_init(struct cpufreq_policy *policy)
 	/* All cores share the same clock and thus the same policy. */
 	cpumask_setall(policy->cpus);
 
-	ret = __issue_avs_command(priv, AVS_CMD_ENABLE, false, NULL);
+	ret = __issue_avs_command(priv, AVS_CMD_ENABLE, 0, 0, NULL);
 	if (!ret) {
 		unsigned int pstate;
 
-- 
2.17.1

