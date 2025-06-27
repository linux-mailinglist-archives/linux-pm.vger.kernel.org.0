Return-Path: <linux-pm+bounces-29702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9925DAEC028
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39053B10A0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99BF2E8E0D;
	Fri, 27 Jun 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ285+Dm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8780CA6F;
	Fri, 27 Jun 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053129; cv=none; b=irwRmoqKv2za8pdxd4olxqfWFclNejtEwbSlIJlBeHUb/MbXgmaA/SLRnkDKfUjOY/9CN280IddZHDnBfAW5cvfMhmWjTSBKoSbm3BiS7CDQP2d6J0lMtwJ8eRI4kJmP9Vcq12eEMGCIloNNgJ5JPiMxp1Fd75UyWiYcaNgHkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053129; c=relaxed/simple;
	bh=cLefzBoTu4L0x8svgda0BFQrX0t5fTTS7VuR6qXKRUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QbouQlUY4pBaGyf8AQ5LmpwOunVofZuo2kjt8R1nAfnoepEv7Rrplp+5vu9UOkNqBcFuDheJXxGJctXTZ3D3HZy1FHAxkDZ+NrMJpN0QRInV4NrWy1bSA8uXajHGpnQrppTkn7ndOwk8G5Unpqy3gjPc3sykWPmJg9oQDqpSpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ285+Dm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C99C4CEE3;
	Fri, 27 Jun 2025 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053129;
	bh=cLefzBoTu4L0x8svgda0BFQrX0t5fTTS7VuR6qXKRUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UJ285+DmR7zzCY45wYno4MT5Tw1yrlHNqS20XbapkV0J6wMPRPoQ0SKOPTpHyQARj
	 UCc2ki9J0L3VFyfx+3cEq/rNbID3A/fczjGz1oN9gJowQSmcEFB9CvUWDIX4nECqFo
	 +OO0dUv7OexFmFEYV/jO6Z01XH7jsiSxSfD/3/B4qkxjD/UJJpTyKMd7XN+zoiwrMK
	 91UWKzYXLLmB/bpoOX9eBO1R4oxjwte4Tv1FI9sPEMMDsrba0BUWp40T8aL+/KClbu
	 gjxNUMokIRJBGPFuktwt22vJ4r2q0+Ovp2RrEoid+VWcRMcsQagVBBHgoeua3Dr1ZP
	 fdAqaPJOZBvjw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 27 Jun 2025 21:37:57 +0200
Subject: [PATCH 3/4] dt-bindings: interconnect: qcom,qcs615-rpmh: Drop IPA
 interconnects
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-topic-qcs615_icc_ipa-v1-3-dc47596cde69@oss.qualcomm.com>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-clk@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751053092; l=1318;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=ZgruXfKaPncujuKscIMIQ6+RfLMQsj/eC1AUlyRhlE8=;
 b=CGrlzb/dvs2sXzZv/QqX+yCGGp7FpPT4obuE9ggWIkYJ9Q8PeDh8/HCcZ4AIg1EskxAG+MR7k
 2THJf3S2SDwBRyqjkYuVz7LE3aC2LJUa1itS52t2K9pHyIZjo2fMpXN
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This has been agreed to be characterized as a clock resource, not an
interconnect provider. Bring QCS615 in line with the expectation.

Fixes: 6c5e948f1fff ("dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in QCS615 SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
index 9d762b2a1fcf87b638a0b9060e7b90579e329cef..e0640482882481408095ee1acac5c824fa8820e0 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
@@ -27,7 +27,6 @@ properties:
       - qcom,qcs615-config-noc
       - qcom,qcs615-dc-noc
       - qcom,qcs615-gem-noc
-      - qcom,qcs615-ipa-virt
       - qcom,qcs615-mc-virt
       - qcom,qcs615-mmss-noc
       - qcom,qcs615-system-noc
@@ -46,7 +45,6 @@ allOf:
           contains:
             enum:
               - qcom,qcs615-camnoc-virt
-              - qcom,qcs615-ipa-virt
               - qcom,qcs615-mc-virt
     then:
       properties:

-- 
2.50.0


