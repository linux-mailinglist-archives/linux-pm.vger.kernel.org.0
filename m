Return-Path: <linux-pm+bounces-17666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B09CFE92
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 12:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC0B286E0
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B7619A2A3;
	Sat, 16 Nov 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwpfYpLP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4D22338;
	Sat, 16 Nov 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756687; cv=none; b=K+nI/P60PU5OLogQsjbbkBmNTiQsBX9UdU+C8UydZrY0uqrGC1m34wTuT4yHFT+rC4jeiDg+wQ0zNuM5v0dXJEuL1L4c1cdf1Wj0KOV6tS8m1E+xcHUr8HlGW1f9T5Lo0TLFRgimfn6U6VE1jVPPNrZngVNyJ6faZtDApedX5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756687; c=relaxed/simple;
	bh=8GcodKB88++Kr94XKflhS+lzQOpD3Fcjty+zEZyc4Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLBfp9A+o6/7Rvu9jxbd5ktIqUfOW4D+G337dSeXGj2XuRGbu0vZSlYj01yPULqRzc3mMyFHfVrtr9sug7WXqTpUZIl9GKMP23kC4J9tRJCn1OhBxFMcLgsiJPjeoiYY5AuvsB8VG5kKyn0xqNcPGt+FQts3Bq/94Ij7BF4HsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwpfYpLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D97FC4CED9;
	Sat, 16 Nov 2024 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731756686;
	bh=8GcodKB88++Kr94XKflhS+lzQOpD3Fcjty+zEZyc4Eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TwpfYpLPVwpaWuK3bVCmluDriUaKrl/PoYVN3Z1GojGjQ+Skhbov71Rg5/x5xeGXa
	 A1LMyFpgIIDsjX7VefIAVnMs0S952zOo4+En+8xkR5Luqj9iM/ZKNm2Ag7UhcCn81u
	 +1m2P7wGBwdrlTEkuUYxnuLMRyZ8yQsqO3z+3fUrh7zDVYYeJSoFysXPRpyFzi6Avc
	 gstE9rJf2X3Rove02k2vBZb/N7BvTP2cHdXV7zdXcHOTNzw8O9rsk/AIO77q9F5FeX
	 7MHDnZs+GJ/+cKhLwvuPSgnRR0Q9wVAsEZ6MwywlLna2sEds4rfRFAt2r3Wht9hWyU
	 ObGqT0U0PaZcQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Sat, 16 Nov 2024 12:31:17 +0100
Subject: [PATCH 1/2] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SC8180X
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-topic-sc8180x_cpufreq_bindings-v1-1-e7db627da99c@oss.qualcomm.com>
References: <20241116-topic-sc8180x_cpufreq_bindings-v1-0-e7db627da99c@oss.qualcomm.com>
In-Reply-To: <20241116-topic-sc8180x_cpufreq_bindings-v1-0-e7db627da99c@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731756678; l=1298;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=UJAqeQny8c13BwkHDfrGF6OfhjTo040lRi9YpokJKFM=;
 b=XerdUPOqLSqZuuadnP6PRbh1qP09duhQj5siAAIIyGF/K/6ARqS/KN1uTThsq4LmlYmv+T7SP
 ZHHiZRjXOmaBMxjtc9Kz8txngF3+NkhrME+6zJmJdbO8D40stjGc4L6
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Add a SoC-specific compatible for SC8180X. It has 2 domains and uses
the older, non-EPSS hardware.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 729f68c1f81d32e54e170879c4f7dd91c0d7c80a..e937eb7355e7fb74c0aeafb4cb9f5ed80d96e6c3 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -23,6 +23,7 @@ properties:
           - enum:
               - qcom,qcm2290-cpufreq-hw
               - qcom,sc7180-cpufreq-hw
+              - qcom,sc8180x-cpufreq-hw
               - qcom,sdm670-cpufreq-hw
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
@@ -135,6 +136,7 @@ allOf:
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
               - qcom,sc7180-cpufreq-hw
+              - qcom,sc8180x-cpufreq-hw
               - qcom,sc8280xp-cpufreq-epss
               - qcom,sdm670-cpufreq-hw
               - qcom,sdm845-cpufreq-hw

-- 
2.47.0


