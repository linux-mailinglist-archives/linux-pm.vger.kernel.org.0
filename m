Return-Path: <linux-pm+bounces-30898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C9B07596
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42111C2534C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9BB2F50B1;
	Wed, 16 Jul 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxjMcc7g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09762AD0C;
	Wed, 16 Jul 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668763; cv=none; b=mKEiY4Luxp2mBnOi0zD/+iePnRns3fbx3W6ZQ+3jLNlP/mTINIJhaWIv0KO0LjPyv0fculrmHAiOWBjMgPJaNbPLVvVY35yVbo1J+jFqBZ8VFk+wDm19Fz/j51GBOOf1BwqioO4fmt7GTfZ55yCR3kyTwm+MdR4aquOvw5VD/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668763; c=relaxed/simple;
	bh=XTcbpx6ly1tN7Dsl/20qzjTFviLC65pdQAn44GRgM1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FStq+XvkCaI8r34SlqtdPD351pLrO2i1QyTbfkYHKAT8xB4ahG+iCVluAjhq8WGr2suQvXIjo3Z/L0kI8AlJOhhdR3OjGXOzCVD4TXWYElBfruBQNgrzNarzPocaxJDVQPuduBwB2IycjunvqM5JJt/pOZP+REVUzjBdF9c3meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxjMcc7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD57C4CEF4;
	Wed, 16 Jul 2025 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668763;
	bh=XTcbpx6ly1tN7Dsl/20qzjTFviLC65pdQAn44GRgM1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LxjMcc7gVCehcHe5kdok9nWTK0qkgZyIc0wsf8UpcgRACRBZqm5xNRHow1Y9XGtpK
	 /Iifv9YjGyk14JElvFl5zXNBxNbdXopYue6yfar1aBy5+GDB7xJF9ow2RWNl+Nhmsq
	 /bWGAJTa+IS3CJQm90TgwiiK6em2/mzwaTIfzi64SIRX3B0gt3gU1rnVXzzR80Vjqq
	 MNH68ww+fWpe9wri3sk52rcXn9UE7kM8K66qnW7gS6KvUQ9U/L3RyULFD8RmUs4b9b
	 10xBp+nbLv6yh9wLcIlbMHSrWA9QP2Oc1SXxxcXhZu7DYkDOt3Z2Q4xRDMAw3656Y3
	 V53IuxF9IDNNA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 16 Jul 2025 14:25:46 +0200
Subject: [PATCH v4 1/2] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Allow 'nonposted-mmio'
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-8750_cpubwmon-v4-1-12212098e90f@oss.qualcomm.com>
References: <20250716-8750_cpubwmon-v4-0-12212098e90f@oss.qualcomm.com>
In-Reply-To: <20250716-8750_cpubwmon-v4-0-12212098e90f@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752668753; l=950;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=H82ybSIYYWgf8nJT6YxvsZanbze8JoVpwEX+cHYGT9U=;
 b=0Pw8KZUpLk/OR43jwSnsUMpJkYM+Ozv0ppfMbc4Vvf5TOfzsiMv7l4zrHJMGTB0CODCNlwpi/
 L+blVU2b/6NDGx1FjJsdFObvqbWPFcO8XjmEK4fbvTD6fxfpqc6cJwP
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

One of the BWMON instances on SM8750 requires that its MMIO space is
mapped specifically with the nE memory attribute.

Allow the nonposted-mmio property which instructs the OS to do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 83bcf0575cd372926102e2764055c3576822c915..256de140c03dc50cb77bc38a6bbc2ff96b910207 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -76,6 +76,8 @@ properties:
     minItems: 1
     maxItems: 2
 
+  nonposted-mmio: true
+
 required:
   - compatible
   - interconnects

-- 
2.50.1


