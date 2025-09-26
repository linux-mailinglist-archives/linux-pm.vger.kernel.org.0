Return-Path: <linux-pm+bounces-35440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E2BA28B8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 08:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B081C23D3D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1627B505;
	Fri, 26 Sep 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwsqQx6w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F51DC1AB;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758868939; cv=none; b=tYXWbpxMloOw+GWfsT8e/pk4bj9i3UkLvAmPlaCg8UZV6gePLRMbXdfBu8zr5nGAtOPw/k50SllLKNPUisLdb18L44SfkDBW+fIgVRoM6jE7NURENVQ71oj2mO7yYPxBzntMi/1rHLxSn5GCOtIE0lH7OKVNex7DxW0lRpXGj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758868939; c=relaxed/simple;
	bh=1hl/eyhRTaS4YhKyjRWY+YNFz7eL/tPWBIU1thtDpTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QbP6J4pLvi0kA32BlAHugD2XbHrqhm1KYNqPAEAxtjOTdt8YFvFn4ymwW9ta6QImVxJbkhaVRhJeTMqtl/7lwF4iQ8K1wC34Rk5U6giNx+hq1QxgWoxsluLTHVHnaKNFIwNIerOr47NObQRy0l4Ol+SI2YTgWYWOfn9bXSJd1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwsqQx6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF597C4AF0C;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758868938;
	bh=1hl/eyhRTaS4YhKyjRWY+YNFz7eL/tPWBIU1thtDpTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hwsqQx6wXXNfOk+GZ5DZACD4DI1pRU1+Av16R0Fk1mhc+FJfEfw8Fql6zjYBrU/ae
	 JLkd1nHPErDmsqRIYIU0hnxwtH3nUMuLh+vIvMbO67a91urGlLoZeZZ777zzIAn73S
	 lNTpxH5kpC1CeqOzj7BjUnzu2zIEBG2+s5x7CVTO4gllDlC4qTsfsKE5rYrCH02yrg
	 P9PmvneirI4cbr8NFNrnWqNTnhP+Hzg2LM8z0rcOPNlJzaCnJi5srA9UQ2XKHzQrt5
	 X/V1GSd++qsDzXyCqCJ21umwSXeAVmcP0agloS9hS0vp7HB5FcnoPXdAowK5At32qK
	 w8Wn6hDHor8Og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C6CAC5AE;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Fri, 26 Sep 2025 12:12:10 +0530
Subject: [PATCH v2 2/2] dt-bindings: interconnect: qcom: Drop QPIC_CORE IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-sdx75-icc-v2-2-20d6820e455c@oss.qualcomm.com>
References: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
In-Reply-To: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Lakshmi Sowjanya D <quic_laksd@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=H39PzgE3sz0Da1E79p3mlCmC8enF7l/7/JpoIn/7roE=;
 b=kA0DAAoBVZ8R5v6RzvUByyZiAGjWNcij4ji5d+OhMrWz2FxnQl6c2qbFTx8lbJJF8CcwRBhjD
 4kBMwQAAQoAHRYhBGelQyqBSMvYpFgnl1WfEeb+kc71BQJo1jXIAAoJEFWfEeb+kc71B90IAJ3O
 NF6hWgKBnE3EgdacmcdNpOSGVehcU8hcZiamdB+PleuTeoN9pL3E+8hGmnsOfXJuGuZbdwLtr+V
 teI4RWa5ME5PBIqvLB0R2e1l/ZB2vwAxv34z5QV/XFLCTT5lVQ/rJDRxprKSoZT6gwLOkG6gH2q
 Gt5dHj3Aik2ILARl2jjCJP8uLUVGIeRp9dQBrsoK0ufZfvKJmcJC4qqlbz04qW6esskry0xA78t
 osi7EffgvUa1YiIF0lCV4MvXBi+5ug4iw1Th2GcAhnGmgdhgDqhYRNoYDt82GIg6FmIVFFMG2Z6
 I22cBZAFIaxY6cm/DBif1Qah/HCsCbQr7lkJ+Rg=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>

As like other SDX targets, SDX75 QPIC BCM resource is also modeled as a
RPMh clock in clk-rpmh driver. However, for SDX75, this resource was also
described as an interconnect node mistakenly.

Hence, drop the QPIC interconnect IDs and let the clients use clk-rpmh
driver to vote for this resource.

Even though this change is an ABI break, it is necessary to avoid
describing the same resource provider in two different drivers, as it may
lead to votes from clients overriding each other.

Fixes: 956329ec7c5e ("dt-bindings: interconnect: Add compatibles for SDX75")
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
[mani: kept the QUP defines value unchanged]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/dt-bindings/interconnect/qcom,sdx75.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/dt-bindings/interconnect/qcom,sdx75.h b/include/dt-bindings/interconnect/qcom,sdx75.h
index e903f5f3dd8f63b257222b78e8ea41143d3dc86c..0e19ee8f168702a364f4101991ce9a6213da2eea 100644
--- a/include/dt-bindings/interconnect/qcom,sdx75.h
+++ b/include/dt-bindings/interconnect/qcom,sdx75.h
@@ -6,9 +6,7 @@
 #ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
 #define __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
 
-#define MASTER_QPIC_CORE		0
 #define MASTER_QUP_CORE_0		1
-#define SLAVE_QPIC_CORE			2
 #define SLAVE_QUP_CORE_0		3
 
 #define MASTER_LLCC			0

-- 
2.48.1



