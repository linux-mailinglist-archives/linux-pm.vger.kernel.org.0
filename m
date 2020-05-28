Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2531E6957
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 20:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405803AbgE1Sao (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 14:30:44 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:60406 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405835AbgE1Sak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 14:30:40 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 2476B30D739;
        Thu, 28 May 2020 11:20:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 2476B30D739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590690030;
        bh=/wzEsGsZX3oj///RlV8+bfcA1u7yygbmy2y0Yml+keA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SojDiFWas3ner6nC5UWQYjADQd3hA+iUokOuq2TDm6bgGjE02VZFDS8oX+IEExpBi
         StWhIbmhgPYpZo19CXx6OqaOiZzbDxymSH8m47jEUy8IbKe2vZQNbnNB/mecLuJt8b
         hZUFlOCuyCZ+nYXREms5r4qIMSO2vGf7iv+MdxAU=
Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 6AA7014008B;
        Thu, 28 May 2020 11:20:29 -0700 (PDT)
From:   Markus Mayer <markus.mayer@broadcom.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Markus Mayer <markus.mayer@broadcom.com>,
        Linux Power Management List <linux-pm@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] cpufreq: brcmstb-avs-cpufreq: send S2_ENTER / S2_EXIT commands to AVS
Date:   Thu, 28 May 2020 11:20:14 -0700
Message-Id: <20200528182014.20021-3-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528182014.20021-1-mmayer@broadcom.com>
References: <20200528182014.20021-1-mmayer@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On suspend we send AVS_CMD_S2_ENTER and on resume AVS_CMD_S2_EXIT.
These are best effort calls, so we don't check the return code or take
any action if either of the calls fails.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 79a0538a531a..3e31e5d28b79 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -506,7 +506,14 @@ static int brcm_avs_suspend(struct cpufreq_policy *policy)
 	 * AVS co-processor, not necessarily the P-state we are running at now.
 	 * So, we get the current P-state explicitly.
 	 */
-	return brcm_avs_get_pstate(priv, &priv->pmap.state);
+	ret = brcm_avs_get_pstate(priv, &priv->pmap.state);
+	if (ret)
+		return ret;
+
+	/* This is best effort. Nothing to do if it fails. */
+	(void)__issue_avs_command(priv, AVS_CMD_S2_ENTER, 0, 0, NULL);
+
+	return 0;
 }
 
 static int brcm_avs_resume(struct cpufreq_policy *policy)
@@ -514,6 +521,9 @@ static int brcm_avs_resume(struct cpufreq_policy *policy)
 	struct private_data *priv = policy->driver_data;
 	int ret;
 
+	/* This is best effort. Nothing to do if it fails. */
+	(void)__issue_avs_command(priv, AVS_CMD_S2_EXIT, 0, 0, NULL);
+
 	ret = brcm_avs_set_pmap(priv, &priv->pmap);
 	if (ret == -EEXIST) {
 		struct platform_device *pdev  = cpufreq_get_driver_data();
-- 
2.17.1

