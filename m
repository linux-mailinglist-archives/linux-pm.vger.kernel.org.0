Return-Path: <linux-pm+bounces-40709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FCDD18433
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF113301D4B0
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF13816EE;
	Tue, 13 Jan 2026 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+EVIlfJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5337FF7A;
	Tue, 13 Jan 2026 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301615; cv=none; b=hUp3bIPN5aMJ6kwOCOoZ4D3j6Ob6CZFheh4y65JYhcynAGWufQp6+3W+F5bC+KojXeifsxVI5ZIpEKtunBezNK9KDL93d7SuBRuZgB+yrEKNlJH9+6EeLu3t7EI6AYtEeMvffdxCKUsIGa2oJvMYdAjFybNo0DpmrH4QQylRez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301615; c=relaxed/simple;
	bh=KXQgPW5ml/W7LyOlg7iK7RENkHv+6oYBAkBqhOMcWwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rp1EouTxxpdd18HdP5YQlq3nzKhKV738hGZJF/k+t4ID/yhEFKdZcowhc9cQHR2LFILoFg8J1Jh+GerPtkoOUjmixECz/cOIN9vfmdPnfzbEo7JzD8Vw7//N2Xchcn0QtXl9o6GfeQ1pZ0f2z7usxblOdLmsC12Gxja4oJxU6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+EVIlfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B40C16AAE;
	Tue, 13 Jan 2026 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768301615;
	bh=KXQgPW5ml/W7LyOlg7iK7RENkHv+6oYBAkBqhOMcWwc=;
	h=From:Date:Subject:To:Cc:From;
	b=c+EVIlfJIGcW2xdzqjqV62lhrUkEjHo5lmnPQxMgxbX1oDU2m/DW0xDa0PVIdeZ2Q
	 r9YH3xaCuF/WKuvuGzkHBxhIqZKt8Gq/i0dIkI1iZc2mpi8YobFPTsPLHvokDEP0gP
	 g9b2E/5qrOE99CSqmvdWIIA7VeNAFvxfgAhWUBBsY0zDkWbHbboWsS2927WcyQVRqc
	 rHac5np35C0YHWp+ZI145tFYIIrbwBCaakSAVDFLMkNB/9oTFQpl9P/s2zBo+ptdBh
	 t+UclkpxOXqxkq2zcVN7wBzRLBui03l/vk7CAt2U7wWsoYLHY1gTRac/IOYN3ozjVe
	 yZbwfY2n+vhwA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 13 Jan 2026 11:53:27 +0100
Subject: [PATCH] cpufreq: dt-platdev: Block the driver from probing on more
 QC platforms
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-topic-cpufreq_block-v1-1-91f27df19028@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQ5AMBBA4avIrDVRlfq5iogwBhOi1SIScXeN5
 bd47wFPjslDFT3g6GLPZguQcQQ4d9tEgodgSJNUJ1IqcRjLKNCeo6O97VeDi8Cyz1EXWnWZhFB
 aRyPf/7Vu3vcDQYGHUmUAAAA=
X-Change-ID: 20260113-topic-cpufreq_block-c9b7c6863a41
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768301613; l=1911;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=uavGxnTDM/UZptqcJITwS7Hsffzd9Hb5nc4S4uwbyls=;
 b=s0YGkIlwNSIyXKDb/dgq+iprmQypQpnEfp+/bAfzZlnIj8F49q+fDMroydgby/J5v73+iyRJF
 LZgaJRWH9oWBNWuCbwCsx06h0qwkFG1BOwErJOey2ZKZLCn3AbaPN/A
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Add a number of QC platforms to the blocklist, they all use either the
qcom-cpufreq-hw or scmi-cpufreq drivers.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Note: the "qcom,glymur" compatible is not in -next, but is already
approved by krzk and should be merged shortly
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1708179b2610..de5a33feebb4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -153,6 +153,8 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "nvidia,tegra234", },
 
 	{ .compatible = "qcom,apq8096", },
+	{ .compatible = "qcom,glymur", },
+	{ .compatible = "qcom,kaanapali", },
 	{ .compatible = "qcom,msm8909", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,msm8998", },
@@ -171,6 +173,8 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sdm845", },
 	{ .compatible = "qcom,sdx75", },
 	{ .compatible = "qcom,sm6115", },
+	{ .compatible = "qcom,sm6125", },
+	{ .compatible = "qcom,sm6150", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm6375", },
 	{ .compatible = "qcom,sm7225", },
@@ -181,6 +185,9 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm8450", },
 	{ .compatible = "qcom,sm8550", },
 	{ .compatible = "qcom,sm8650", },
+	{ .compatible = "qcom,sm8750", },
+	{ .compatible = "qcom,x1p42100", },
+	{ .compatible = "qcom,x1e80100", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },

---
base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
change-id: 20260113-topic-cpufreq_block-c9b7c6863a41

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


