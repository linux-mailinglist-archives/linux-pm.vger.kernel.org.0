Return-Path: <linux-pm+bounces-31498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECDB13FBC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA67A65DC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155C2749FA;
	Mon, 28 Jul 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDLFsK0T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD68BE4E;
	Mon, 28 Jul 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719397; cv=none; b=iQO9ROT2csTwBNA40WTS/OIaFLpauTNp1y05i3h4w8QneR+ELt8DFzKJXUkL5x3dUYSdwKCYtE4nGWEsjDUcUNfE0monKkvUknXPkYJ0LadsA/t3DOWkVGZrXr7E64JPPVkQXvzjRC+t/+abOCWtjhywP+PT3BsIGnHIPeZV5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719397; c=relaxed/simple;
	bh=omIu6R31tcy90Pr8rOdnVMPQoAcRzpwjOqEBaJct2EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rN7D1+16AZrN2a7V8PWmUtCSdwlBBsHIMCL+Tjo3eqdvvg4aaROJxzHuPOfX3DzNzoCZHAdnRKzm2EVJdBnL4N8eSkAQO5XAyEJzqTupWoereMvjHT+wdZt44bxD/zvUDKhTtmPurJSf7iZ177/H3vKMylLT/S+q2lD+swnprq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDLFsK0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5C6C4CEEF;
	Mon, 28 Jul 2025 16:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719396;
	bh=omIu6R31tcy90Pr8rOdnVMPQoAcRzpwjOqEBaJct2EE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gDLFsK0T2vWsHHsFwjszyPhFOODbM6K5eKu5mlNUpAz8l6x6AiwlWPUTI5edM3Nj/
	 asDucDUHwgOSpc+99/j+yjg3Gi4dSbSqeo4Y4rakGCd89qQcqIS5M1mqAx6DpoI9NJ
	 hCy+NJ1snmqZg4ZvYrZB2D80ON1m4xyQVr5/UVTYard8VAJck1KsQkDbjVkX7ex/sV
	 xVzEcPLFH3UwQbFkqYL2SQXF8lhjTvnvWeGsOLR44VJfxAiGGnEkwqGsCY5Bx88n4r
	 Wf5I9L33dZgtdSzNlAKPzXP4j6yJwz8XtmFgiUpLWromFJD15u5NID8qpnOiiEb4g2
	 di+ttcdxBv1OQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:02 +0200
Subject: [PATCH RFC 02/24] pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-2-09c2480fe3e6@oss.qualcomm.com>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Douglas Anderson <dianders@chromium.org>, Vinod Koul <vkoul@kernel.org>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Andy Gross <andy.gross@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jonathan Marek <jonathan@marek.ca>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719370; l=1169;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=JvBceh4pzjxFk/gFJsQ+z6Ck3HKGfaLbeZSerF94W8A=;
 b=67RHooZVTC9N60rfeRPI4nP4SaqQfw7Cf323VIG594wTNwfRnU9R/PMai6gWNN2tO33Wzsnxa
 Ty0TMQG2HE3CmqExWSnim0bcw9IoUBRLgzbhRxUPjnnGotqlGla3Kjz
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This was apparently accounted for in dt-bindings, but never made its
way into the driver.

Fix it for SC8280XP and its VDD_GFX-less cousin, SA8540P.

Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 4faa8a25618621e15d684c4f971785d604601efb..4c3cbf3abc7504cce3b8211c339b7ada03d65e38 100644
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
 
@@ -675,6 +677,8 @@ static struct rpmhpd *sc8280xp_rpmhpds[] = {
 	[SC8280XP_MMCX_AO] = &mmcx_ao,
 	[SC8280XP_MX] = &mx,
 	[SC8280XP_MX_AO] = &mx_ao,
+	[SC8280XP_MXC] = &mxc,
+	[SC8280XP_MXC_AO] = &mxc_ao,
 	[SC8280XP_NSP] = &nsp,
 	[SC8280XP_QPHY] = &qphy,
 };

-- 
2.50.1


