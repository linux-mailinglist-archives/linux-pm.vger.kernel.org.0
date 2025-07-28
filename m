Return-Path: <linux-pm+bounces-31497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DBB13FB6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EFF189D54C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6441274674;
	Mon, 28 Jul 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW5F169j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5C2741DA;
	Mon, 28 Jul 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719388; cv=none; b=WZkanL1FfmPvgk+96EUQ3OQTAn1vnTVMI92zjww799ycAprf93xrtOx1JG2d/Zd5TybsfQLam72NAeu8/fvedoVGHe2X52WQJF5jWhM7wok5sIAmd6vOPpQjvyMgBWgkIfMwMbOL21iSAQdvnXoa5ot5rzaufv6Z3o6i3KDvjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719388; c=relaxed/simple;
	bh=jGsUtdZ1DFaSSsWdQo0E7uwH0s+xbUVZgMWBDuAjr1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZ6ZfX8PBLQOFOHEptrg+yVIYWYIYGsDoUjS9NSpWED4rGcPG8paujdBuT31KDvGN9RM+o1pkjcDnditSEdgC99yQsxlsazKGze1u4VsEhrrTY6V2SXZGjjVceoI9Sj7YQPOh9N9dH3INlsQbxLhhq+We/ILdQS4+bP4U/AZSqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW5F169j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A371CC4CEE7;
	Mon, 28 Jul 2025 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719388;
	bh=jGsUtdZ1DFaSSsWdQo0E7uwH0s+xbUVZgMWBDuAjr1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WW5F169jEiPe6QB4If8TbxjdMg7dinbcnnYHMDkiyWQ+av4FkaBzHAtee4XKy2bI3
	 zFR6TZ4HFwwxPwzZhhqCOvMv3M5It0sgqpK8v+M7ybnkUxFhwC8ZGBBajvKvzkZGdq
	 svU+jAwi8DlXZlnUi5QQ5FPjXa+1PEcu+PiqEl/pePdVrrkoerhZfs11/codvMEe1W
	 1d6PlyTvhN2tE7R4HVPW/tskdL65SY7yaibrdUUP3b1j38mbi2mHMrtB8QMLoZ0C+A
	 PXGt/PvQTfRpVnmN1W02iq2WwIu/RAHLVjXC0xb7VymLieIcXnjy2tJpbIOiNvFy0Q
	 bGUIszj4DCAtQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:01 +0200
Subject: [PATCH RFC 01/24] dt-bindings: power: qcom,rpmpd: Add
 SC8280XP_MXC_AO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-1-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719370; l=962;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=tZIB269mD5O0ZRPTEJmMSWb8CDLZjJ8PqK7fbNyu0TA=;
 b=pn1X5zYDKG3JbVTY6qgMxFW4ou/3z8R610DoM+bmgFa6ozqC8H4SQADiFw1Rh9kpDpFhWjYlt
 8xmuXq8fWnNCLD1FaQxh8IPw+SrHQA+7t9iJcevS3xhBrEe4JqX9vE1
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Not sure how useful it's gonna be in practice, but the definition is
missing (unlike the previously-unused SC8280XP_MXC-non-_AO), so add it
to allow the driver to create the corresponding pmdomain.

Fixes: dbfb5f94e084 ("dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index f15bcee7c9283e74dc8e6f9b6b6f73c0ced009e4..6860ca6360a7bce43a331f9d1c10a11646b0041f 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -214,6 +214,7 @@
 #define SC8280XP_NSP		13
 #define SC8280XP_QPHY		14
 #define SC8280XP_XO		15
+#define SC8280XP_MXC_AO		16
 
 /* SDM845 Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION		16

-- 
2.50.1


