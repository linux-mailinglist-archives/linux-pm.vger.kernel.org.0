Return-Path: <linux-pm+bounces-37388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228BC32D04
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 20:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F2C18C653F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A22DF145;
	Tue,  4 Nov 2025 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJN9SMG5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280920E005;
	Tue,  4 Nov 2025 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284709; cv=none; b=oFkBcWnk9bJfDfYIHhaQOQq564a7q0/MphzyXCITWv7AvCyGo2/hawZdL9RCPNlhjV5PGDL6GR0esRq1+fFtc8sJqyZppZScjmmlp6HyikH4QdOI6eQUwXtABiw+LWW+K52GWMi2KlEKse5HKPh8BlKoCRqvGrpa2ZeTp0jo+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284709; c=relaxed/simple;
	bh=4pVBdcWP02Cyh/Hi6jqt29N+OCiGZUkyzPXSKHOAE80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sS4Dpoqt05zwMmoPQMY+rShe6Nf6SNGYKNX3KnBvTeaHwKygwZFFqzR/gv81jT7UqYIQkw5xfaEvk0oSK3FEVDPSd9wEUPq7z77oHO+/FQnLiuu9KaD1rzrT/1SqHRRkCMbjSRm+yhAFS7bHv1SwxzxPw1WOnyPHIDyakPK9Drg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJN9SMG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35ADC116B1;
	Tue,  4 Nov 2025 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284708;
	bh=4pVBdcWP02Cyh/Hi6jqt29N+OCiGZUkyzPXSKHOAE80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HJN9SMG5aHuo8ernmkr8elcZCk4lkAScSM+Bg5kD3OSFTnes/856Apl3vqxaMJvh6
	 RdjgFCm31jqkVfSOD7B6o9UCbxsYlV79jrcNe1bJaSnYcZVvqhxElqifw3l+rBhDkb
	 FDXf2zOpeAcEiUAMKLyeTqU0w6091D7gfzffPXJ/ALhDj9BZktymO4QyTsDYygyLlf
	 Zj15EuIL1bElIgbpuAEGObG51Ds1h0PBb9qnXbafDUgvOtL3QRnaMwJL1YSYS6Cs8q
	 6SwAulMG/jiLg3kr3JTRbK3V5TJ5+ro6WWvA/uuSrTLWgNgExlSIf2R/TiPpFnDDhz
	 +Pd+G0lpTG4ZQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 04 Nov 2025 20:31:09 +0100
Subject: [PATCH 4/5] pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-topic-8280_mxc-v1-4-df545af0ef94@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
In-Reply-To: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762284668; l=1180;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=3h2l/QbXUCfADaLNzigV82eM6piI1JEuasb/Z/CDuIc=;
 b=yZFsowppIn88QwRkJh57L8sGfccmyC7nOMcTw2pvJtfqnIPQY3wNt+/Do8lEq8KfmjJsrSWA+
 AdfrZdr9UBvBoY1DSXve7gI8XJUtEjiNrEVHBgMuleEqhDkQEgrvkJ3
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This was apparently accounted for in dt-bindings, but never made its
way into the driver.

Fix it for SC8280XP and its VDD_GFX-less cousin, SA8540P.

Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index a8b37037c6fe..19849703be4a 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -246,6 +246,8 @@ static struct rpmhpd *sa8540p_rpmhpds[] = {
 	[SC8280XP_MMCX_AO] = &mmcx_ao,
 	[SC8280XP_MX] = &mx,
 	[SC8280XP_MX_AO] = &mx_ao,
+	[SC8280XP_MXC] = &mxc,
+	[SC8280XP_MXC_AO] = &mxc_ao,
 	[SC8280XP_NSP] = &nsp,
 };
 
@@ -700,6 +702,8 @@ static struct rpmhpd *sc8280xp_rpmhpds[] = {
 	[SC8280XP_MMCX_AO] = &mmcx_ao,
 	[SC8280XP_MX] = &mx,
 	[SC8280XP_MX_AO] = &mx_ao,
+	[SC8280XP_MXC] = &mxc,
+	[SC8280XP_MXC_AO] = &mxc_ao,
 	[SC8280XP_NSP] = &nsp,
 	[SC8280XP_QPHY] = &qphy,
 };

-- 
2.51.2


