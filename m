Return-Path: <linux-pm+bounces-31509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A60FB13FF8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9490718C0EF0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0DD275B19;
	Mon, 28 Jul 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR5iwORV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE1274671;
	Mon, 28 Jul 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719486; cv=none; b=GrL9oJtgfFsU19D8ZZKUR3aU7eOeiTi9Pl1M/2knyJqtmzs50yOkbppO1NkaJffN8Qd/iCfb2C8WwH175xAWUaptPCvGKV+Zdx7KgTJKo7Uq8U/B03QoW3otAbI60We8D5jBqQCA0TnaL79HetBwj50gQAjpbyogQ0AhAgHsp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719486; c=relaxed/simple;
	bh=gjXpTq+Te0uKTIGPFy9Ve/JM87H6b0zAXUV6KaaPpdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYeQyYOIV2OBj0sR3om8ESfyzclnwxp7XJy7Ol/hUJuWKnPBmyP1LJYYL4RBBemxX7E+3Uvw9qmN0FiMl+pgeGcpAtU6ELChbKLhQIt1oqwyHoJgQmQuDflGVFf1oPivwpzgobx/vdFC6QEhIEAMLRNGaqYDQlcjn9oYO8dJjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR5iwORV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F71C4CEEF;
	Mon, 28 Jul 2025 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719486;
	bh=gjXpTq+Te0uKTIGPFy9Ve/JM87H6b0zAXUV6KaaPpdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FR5iwORVDzJT+htulJN+ER8PlQUKPQhhjAfEZIqIbbYZwzdsUj4PqcsnpwmtJHVX6
	 RGVjhc3CrSDpLurcxBgly84vxetFfQ4oQUIRhsmsUpH17VoljbuqztULqSg5iKgQ+9
	 8Jb2YIEtm/SwfqdIL9UOhqWMRIBzWfm60ndbbopiGmGGvPu2Y4umgxDpDffyim/0GW
	 6h1URo8AAU+oEd+hxk+0X+KBltT/CVp09BwpOX+0fadPMGT2LdesyQTkVWlCZJcGKp
	 anlkKpjnzoG0VMoKQSlV3jweqV55xGdKogbS7aWklgsuKwJe6Fd8HFJivDNWXhgx0L
	 dTwVjaqrus9kA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Jul 2025 18:16:13 +0200
Subject: [PATCH RFC 13/24] arm64: dts: qcom: sc8280xp: Describe GPU_CC
 power plumbing requirements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-topic-gpucc_power_plumbing-v1-13-09c2480fe3e6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753719371; l=1063;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=KARGeDAk3U/DbiUG3wMZD0Z+bMC39NlxivYX2Oz0uO8=;
 b=vSiKeWxWMVrgqDZBKxtq7c22H3xsZ8vgx7YFhhIG0h/78QLVFfOYBLJ42a44k5ew3sUHi8kgH
 qL1+JKQrPd5BPy4jRjlDDVZDWhqmE+XAeylggnB/jowRfbrf9GpgbkV
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

A number of power rails must be powered on in order for GPU_CC to
function. Ensure that's conveyed to the OS.

Fixes: eec51ab2fd6f ("arm64: dts: qcom: sc8280xp: Add GPU related nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 87555a119d947dca75415675807f7965b2f203ac..eec0d8d3d30e161d079cfac800c45af638574747 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3106,7 +3106,11 @@ gpucc: clock-controller@3d90000 {
 				      "gcc_gpu_gpll0_clk_src",
 				      "gcc_gpu_gpll0_div_clk_src";
 
-			power-domains = <&rpmhpd SC8280XP_GFX>;
+			power-domains = <&rpmhpd SC8280XP_CX>,
+					<&rpmhpd SC8280XP_MX>,
+					<&rpmhpd SC8280XP_GFX>,
+					<&rpmhpd SC8280XP_MXC>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.50.1


