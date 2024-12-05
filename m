Return-Path: <linux-pm+bounces-18630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E11D9E5C14
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB37F16596D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32933221457;
	Thu,  5 Dec 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZAVJh5B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146721D592;
	Thu,  5 Dec 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417449; cv=none; b=HXoKXwU5CyzB4Z+jj3q6PJBHlREJ6AUrCys1hGQDyJ2/0OM3oH8EZtcwJxFhYNx8/2Z/0w7/YDIk3y6TV64TnHJhXZ8edKtTOea1CD/o6kGjS/FDGOFGSt9CU+JB1XIF2atNlJzJDBeS53T0duXc+rJ87qoeS7ZGNSW0F/JdeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417449; c=relaxed/simple;
	bh=dJ3uHGKm141EUtpjkl8lgeTC3Mt+dxJ7luN1jss0jFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJAz4kE4cp+a5O5J3i13FXj7KQAysVhoKGZax41kS8Kf0mxj75QpC3fYvCAKb0OsrEL57bOQd7G2XeeOWM0y2tSn4EOPLkzZU042twLn+IL6uO85qn06xgk72LInsQWp8qXSTPgDmfKdzuiX63RrB0tYfd9yJIlq1GTsFoeBmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZAVJh5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C617EC4CEDD;
	Thu,  5 Dec 2024 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733417448;
	bh=dJ3uHGKm141EUtpjkl8lgeTC3Mt+dxJ7luN1jss0jFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gZAVJh5BBUOaJnfr6AeKfhpdnlNQv4qH4+7vjs4QJ8xgYCT51IbYFpcLSu+9E8WHR
	 MdN2oJC54IZnnxdkqtrF6VORnCN9R/+hou+OvZscDwA3kthKHjFfsMOLp+Wyd5fbrD
	 iLsEHJ87EEQKhtFxQ1zrs4ggXjDHwhrcmmAV6do5AnmVBzj9cBuFUi8Z8JGBu+idbB
	 hQZapT4kcT3cdKcJYSYjKPMiJoQkZ+qtWMyAyPU/rCmLiYmX44qQr4JuugrS8thCG5
	 DaG3Wlh7l0OV3qg8HYjObpCL0vUV6VM30S1waf43nVd/S/wZt5wLQq7dYhdENTyrhE
	 O04WKSFnUtaVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E30E77178;
	Thu,  5 Dec 2024 16:50:48 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 05 Dec 2024 22:20:28 +0530
Subject: [PATCH 1/2] cpufreq: qcom: Fix qcom_cpufreq_hw_recalc_rate() to
 query LUT if LMh IRQ is not available
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-qcom-cpufreq-clk-fix-v1-1-de46c82e0fe5@linaro.org>
References: <20241205-qcom-cpufreq-clk-fix-v1-0-de46c82e0fe5@linaro.org>
In-Reply-To: <20241205-qcom-cpufreq-clk-fix-v1-0-de46c82e0fe5@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan+linaro@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3875;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=xmiEc5cOXq2ANoWwzxjIO5rWx7Q3nJD+YIF6y04T2iQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnUdnlBP1CABLHnZzjSP6jNwaGz5daIXzuoAOAa
 WynAPeIWE+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ1HZ5QAKCRBVnxHm/pHO
 9azSB/0cw6Y73j0oaalOLQST8EQUx/erBarpb7V+I1aDXzmr42UHP7Q38PGRYMkav9CBTh2zjBb
 WovoRP8hFtZMawolRvd7Bh0p19K2V2+qpRWhE9e3J7lV0qDSAuFAQwmPEvsQzrrR5NvDv5bPgCx
 xkcYO60T771CLqonKOsVlzgLmhlynuZCfH/nMg4bPir9GrsXS5gePTegdda3uHFpkDn+rPVx+IW
 flrIk+fpDfAmYzgs9Ve8cjld4lWGXQ2OoqorR+NeQ6Uz8RPWw6YfCmARQq8c96a4n3/ZnL1b+7j
 3UvvX+sPxa/Q8RkV5wY0VHqPDBNOKRa4m0dhJjOIJFofTNnu
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Currently, qcom_cpufreq_hw_recalc_rate() returns the LMh throttled
frequency for the domain even if LMh IRQ is not available. But as per
qcom_cpufreq_hw_get(), the driver has to query LUT entries to get the
actual frequency of the domain. So do the same in
qcom_cpufreq_hw_recalc_rate().

While doing so, refactor the existing qcom_cpufreq_hw_get() function so
that qcom_cpufreq_hw_recalc_rate() can make use of the existing code and
avoid code duplication. This also requires setting the
qcom_cpufreq_data::policy even if LMh IRQ is not available.

Fixes: 4370232c727b ("cpufreq: qcom-hw: Add CPU clock provider support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 98129565acb8..c145ab7b0bb2 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -143,14 +143,12 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
 }
 
 /* Get the frequency requested by the cpufreq core for the CPU */
-static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
+static unsigned int qcom_cpufreq_get_freq(struct cpufreq_policy *policy)
 {
 	struct qcom_cpufreq_data *data;
 	const struct qcom_cpufreq_soc_data *soc_data;
-	struct cpufreq_policy *policy;
 	unsigned int index;
 
-	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy)
 		return 0;
 
@@ -163,12 +161,10 @@ static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
 	return policy->freq_table[index].frequency;
 }
 
-static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+static unsigned int __qcom_cpufreq_hw_get(struct cpufreq_policy *policy)
 {
 	struct qcom_cpufreq_data *data;
-	struct cpufreq_policy *policy;
 
-	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy)
 		return 0;
 
@@ -177,7 +173,12 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 	if (data->throttle_irq >= 0)
 		return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
 
-	return qcom_cpufreq_get_freq(cpu);
+	return qcom_cpufreq_get_freq(policy);
+}
+
+static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+{
+	return __qcom_cpufreq_hw_get(cpufreq_cpu_get_raw(cpu));
 }
 
 static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
@@ -363,7 +364,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	 * If h/w throttled frequency is higher than what cpufreq has requested
 	 * for, then stop polling and switch back to interrupt mechanism.
 	 */
-	if (throttled_freq >= qcom_cpufreq_get_freq(cpu))
+	if (throttled_freq >= qcom_cpufreq_get_freq(cpufreq_cpu_get_raw(cpu)))
 		enable_irq(data->throttle_irq);
 	else
 		mod_delayed_work(system_highpri_wq, &data->throttle_work,
@@ -441,7 +442,6 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 		return data->throttle_irq;
 
 	data->cancel_throttle = false;
-	data->policy = policy;
 
 	mutex_init(&data->throttle_lock);
 	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
@@ -552,6 +552,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = data;
 	policy->dvfs_possible_from_any_cpu = true;
+	data->policy = policy;
 
 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
@@ -622,7 +623,7 @@ static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned lon
 {
 	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
 
-	return qcom_lmh_get_throttle_freq(data);
+	return __qcom_cpufreq_hw_get(data->policy) * HZ_PER_KHZ;
 }
 
 static const struct clk_ops qcom_cpufreq_hw_clk_ops = {

-- 
2.25.1



