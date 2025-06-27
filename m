Return-Path: <linux-pm+bounces-29703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F5AEC033
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5826556404C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B072217F2E;
	Fri, 27 Jun 2025 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPGZ7yVd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE66CA6F;
	Fri, 27 Jun 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053137; cv=none; b=udP/JaPdO4b0PlcJa+CTHrYaLhUtBbzhDJJQr+MiJoyKR4mZpoyezb+ImIZsJd+GQR+LsnK61O1RwZ+bz+uT4kPwiIh7Gygn2PtnVSco6WloHeyHsnlPhE+qmipXf2gwOt47OB99kk0bLOgmLRSN48bvsUBAReAnL2wsM3V1UF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053137; c=relaxed/simple;
	bh=OE8U2vT7ew5Dt6ec8C7hkjuElIoXUc1rAPhJAuZXxG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYZ9MYlYWJHDndU7W+ApKdo1uybbfOVWazX6AmqtZ9XF8eEfbdnKEAyqqQzRE4xFtxf4E6BSC+d58jUC1k+6926mhXp3LNQlqqWXMiFIiuuJywH2Z4YauWoCAWTIHstIGQztO8u5eNcZjnywV8BfqTT9jj6kQcNvYa+seZgAPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPGZ7yVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283C1C4CEF6;
	Fri, 27 Jun 2025 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053136;
	bh=OE8U2vT7ew5Dt6ec8C7hkjuElIoXUc1rAPhJAuZXxG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YPGZ7yVdxGLbHgm7y1rhDBnfH40vpyGmywbcIuoWgPzSGVZQylVK8pc8sG0H0Ajut
	 UP99Rzrh9GlJKv7QfNyk+MyyellutDgnFh2R7Xiu3VFkXPC665FsBfbqW+XMSo1uD5
	 bzXAQxt/ahMTNZ8xI/lRCOJQWDdo2wU2PTESbUseSewXDCcJ8kCrvpqdLWFztEPJtz
	 20s1yYt99RwhltUaKArwd/16gAMti29MT+Dl593FYEEixbTOWluSnBjT0+14f0GSwn
	 6ptEsco2UXPqaJvwHSpi0sPzGeIwxY7VCrNi6xKloyRfIMPozR3owMJ4IDbyq0YcJA
	 cP5xHbmkEl6RA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 27 Jun 2025 21:37:58 +0200
Subject: [PATCH 4/4] clk: qcom: rpmh: Define RPMH_IPA_CLK on QCS615
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-topic-qcs615_icc_ipa-v1-4-dc47596cde69@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751053092; l=1036;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=I5Frh8xqHPLbzLba+aZWZ34NiNQSkZoK0uf/p2Aol9Q=;
 b=Z32XgiO7x666mSxR3HDZ8XOdjJnY4rK71nyJqsrpxcHn+wYCGzZNbU5f/KPR/xtsw+CBzt09K
 J0n4xR3/hx/CuaFqaJDWkWSZdn2OqtSxDeCo+dnR0Rmr0Wa3ZKFU/NA
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This was previously (mis)represented in the interconnect driver, move
the resource under the clk-rpmh driver control, just like we did for
all platforms in the past, see e.g. Commit aa055bf158cd ("clk: qcom:
rpmh: define IPA clocks where required")

Fixes: 42a1905a10d6 ("clk: qcom: rpmhcc: Add support for QCS615 Clocks")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-rpmh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 00fb3e53a388ed24ed76622983eb5bd81a6b7002..e02346bccdc6f26b1a832ed62dbfdc35f271c858 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -825,6 +825,7 @@ static struct clk_hw *qcs615_rpmh_clocks[] = {
 	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
 	[RPMH_RF_CLK2]		= &clk_rpmh_rf_clk2_a.hw,
 	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_a_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_qcs615 = {

-- 
2.50.0


