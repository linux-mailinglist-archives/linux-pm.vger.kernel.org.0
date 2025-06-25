Return-Path: <linux-pm+bounces-29527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9BAE88E4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 17:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166233B2D27
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9589029B8FB;
	Wed, 25 Jun 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEBD4hb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3FB1C5489;
	Wed, 25 Jun 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866950; cv=none; b=BLRmAPfaPBmudffIvv0HafYrAH+jk6V33x7a75Bhh3LT0Z8mJwOgLZPg9DugQEefVrSO2Ri4yGWErC2098kGLS+zU2EUYH9mdY/xcC+FaF6meRloZM8IKjN7V3ff/3946YuTDeViBtPPtMOWu5HJQSnTRcmfiZiyLAcc0MBttsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866950; c=relaxed/simple;
	bh=0j0akyBk6oQld4bN9tG/Rx9YD8D+rRhxa5mPhKSc6H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RO/d3FTyr6oGxqsfRxresgiZtRBekyOvFDArqgf1ehEF+C/zuzSGuPt6xeGSsGGKnIaDGpkQJCDxLQLPRD8xFgI9uN9CmeG+rwW+Vvc4FxyfIXAe3Zn0lUmMHOVxl0HvJYrP5kUbFD3vL5+SLstjAy99jAb2ze1KFP4GLi3qm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEBD4hb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65274C4AF09;
	Wed, 25 Jun 2025 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750866949;
	bh=0j0akyBk6oQld4bN9tG/Rx9YD8D+rRhxa5mPhKSc6H0=;
	h=From:Date:Subject:To:Cc:From;
	b=BEBD4hb/5OWP7R/2N6ogA3Vtbfktn1v98YFG/Ur/IjltKG9UddZqBBrWsFcqIqh/V
	 /oRPYzCkoIvUVR8VvRNYklYE4mPfDNTwO9UCGS28sH86uRzwHcB/1oGPZ06vJeRAvD
	 bQtOvLEAvh2INsMj9zbo1FZOZbcPyIDoR3DPLAOeUkzeHOp+09QkuVAm6lMq7L2LDx
	 xAh9Vrbs/xdBLs2FeZJZ8Ysi/3m8j3jSRt95OI2vId3DkUyvzuF57y6n8TDVLhkMe3
	 fNzLzsVFGBUyPHK3Kb/Ia4ZSyQnLozu3iqZmpT1AXacjUJis1eznk36Mw1bQIcVeqc
	 mJ6uL14oS77Cg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 25 Jun 2025 17:55:43 +0200
Subject: [PATCH] power: sequencing: qcom-wcn: Fix bluetooth-wifi copypasta
 for WCN6855
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-topic-wcn6855_pwrseq-v1-1-cfb96d599ff8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAP4bXGgC/x3MQQqAIBBA0avErBNM0aKrRETZVLMxGyOD6O5Jy
 7f4/4GITBihLR5gvCjS7jOqsgC3jX5FQXM2KKmMtMqIcw/kRHLeNsYMIXHEQ8i6lnbRk3ZzAzk
 NjAvd/7br3/cDNLolemYAAAA=
X-Change-ID: 20250625-topic-wcn6855_pwrseq-07706f3b3cd8
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750866948; l=1175;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=u/0JVYWkgvI137HLdQQO/HO3teeewn/2ooWhSaU/+Bw=;
 b=XJ7PcsaNxOpJhh+h+vkT/0EQI4i/FftTvFFBYvaFbjq41OAl0wkaeTAQgG3s7uo99xSrxlMXr
 DOtD9hBeex1ACg/54aYe8hcPbjbG70I2U9OrlNEHwSLec3/wMWu46MO
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Prevent a name conflict (which is surprisingly not caught by the
framework).

Fixes: bd4c8bafcf50 ("power: sequencing: qcom-wcn: improve support for wcn6855")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index e8f5030f2639a69254ad5efe0a313d2f3d10fa1d..7d8d6b3407495c28a780d5bb0668b2b35837b48a 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -155,7 +155,7 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn_bt_unit_data = {
 };
 
 static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_bt_unit_data = {
-	.name = "wlan-enable",
+	.name = "bluetooth-enable",
 	.deps = pwrseq_qcom_wcn6855_unit_deps,
 	.enable = pwrseq_qcom_wcn_bt_enable,
 	.disable = pwrseq_qcom_wcn_bt_disable,

---
base-commit: 2ae2aaafb21454f4781c30734959cf223ab486ef
change-id: 20250625-topic-wcn6855_pwrseq-07706f3b3cd8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


