Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA13C464E88
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 14:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349496AbhLANMM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 08:12:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:9000 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349493AbhLANMM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 08:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638364111;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6Z3g1/mwk77gEhWZbS8sZveQKgDd8C79HMRf2V9exqM=;
    b=mzoJ827xSG7tLJMh7/svtTNeVbV05vR3GXfbUkj9vhHvGZ1dh2K2Av07ftZBKqp/3v
    xUuB4P090wp1BKLjJiBuaOxckktKNl+amRWDT7ByfyNd72FvakTU+ZAQB3r4YHlTmeUQ
    xVIpkDULfWhfxfDP4W9zkMNa6mRayObvaVGAOArxprEee5KCRlWl6xwH1Ri6aWhELj73
    qTghQ9D9HLMsua9DLeHtodmm+kILitB/H08XaB08+uSNTAT1Sxki32Yt51EFalYX7MW1
    /le1KwX1HsT8vykAgTMOVv/gWpJ2dG3CP8pypH0rztF5UeD0VDqRpRlllJ94V9CBMt5D
    AfhQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fyL2moo2"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.34.10 AUTH)
    with ESMTPSA id j03bcbxB1D8Ughl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Dec 2021 14:08:30 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 1/4] cpuidle: qcom-spm: Check if any CPU is managed by SPM
Date:   Wed,  1 Dec 2021 14:05:02 +0100
Message-Id: <20211201130505.257379-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201130505.257379-1-stephan@gerhold.net>
References: <20211201130505.257379-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

At the moment, the "qcom-spm-cpuidle" platform device is always created,
even if none of the CPUs is actually managed by the SPM. On non-qcom
platforms this will result in infinite probe-deferral due to the
failing qcom_scm_is_available() call.

To avoid this, look through the CPU DT nodes and check if there is
actually any CPU managed by a SPM (as indicated by the qcom,saw property).
It should also be available because e.g. MSM8916 has qcom,saw defined
but it's typically not enabled with ARM64/PSCI firmwares.

This is needed in preparation of a follow-up change that calls
qcom_scm_set_warm_boot_addr() a single time before registering any
cpuidle drivers. Otherwise this call might be made even on devices
that have this driver enabled but actually make use of PSCI.

Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/86e3e09f-a8d7-3dff-3fc6-ddd7d30c5d78@samsung.com/
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Daniel, would be great if you could ack this patch and PATCH 3/4
(the cpuidle part) if they look good to you. I think it's easiest if Bjorn
takes them together with the qcom_scm changes through the qcom tree.

Marek had an alternative fix for this [1], the difference in this patch is
that it avoids creating the platform device entirely if no CPU is managed
by a SPM.

[1]: https://lore.kernel.org/r/20211020120643.28231-1-m.szyprowski@samsung.com/
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 01e77913a414..5f27dcc6c110 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -155,6 +155,22 @@ static struct platform_driver spm_cpuidle_driver = {
 	},
 };
 
+static bool __init qcom_spm_find_any_cpu(void)
+{
+	struct device_node *cpu_node, *saw_node;
+
+	for_each_of_cpu_node(cpu_node) {
+		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+		if (of_device_is_available(saw_node)) {
+			of_node_put(saw_node);
+			of_node_put(cpu_node);
+			return true;
+		}
+		of_node_put(saw_node);
+	}
+	return false;
+}
+
 static int __init qcom_spm_cpuidle_init(void)
 {
 	struct platform_device *pdev;
@@ -164,6 +180,10 @@ static int __init qcom_spm_cpuidle_init(void)
 	if (ret)
 		return ret;
 
+	/* Make sure there is actually any CPU managed by the SPM */
+	if (!qcom_spm_find_any_cpu())
+		return 0;
+
 	pdev = platform_device_register_simple("qcom-spm-cpuidle",
 					       -1, NULL, 0);
 	if (IS_ERR(pdev)) {
-- 
2.34.1

