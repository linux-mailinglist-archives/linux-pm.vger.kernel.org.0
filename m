Return-Path: <linux-pm+bounces-37385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F222C32CA8
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 20:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D955D3B6CB1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59B2EFD8F;
	Tue,  4 Nov 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFwvRvy1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807D184540;
	Tue,  4 Nov 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284686; cv=none; b=XdQUeQMMJVZZfXs1rT4LS+yB2wy1b38b6vagDPjwwhSKMPjYZOHtFSZ/bP7ITOWIRIAzfd4nSxSGaZ4xP+6kI0cttxvb09Pm4nS47P/0VYlqFz+A/NLX2srvbeTIRABNuxwqHvuK9xmIY2TkO3bKT5pcryg88ULHRyR5ZuJfmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284686; c=relaxed/simple;
	bh=SAKuXSfZNz9/EAVAmCp7JYbqmQM7W23GtYtWdelr3Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0Xm0lbx4IAeEQnVFgM7Pa50i1ZWIUDgcDzaBaRgQ4k7MmG8xa2Uicc+Kc1UYY7CrayL+40ky3Ll/CdscCBAkBk+owGdqA3Lqklk8yQpCP3lBIl5pnWf1IG/agb46kr4cMMevn1981NbNlR2/7fyanioY787+gxDeWDRX1CriZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFwvRvy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B8CC4CEF7;
	Tue,  4 Nov 2025 19:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284686;
	bh=SAKuXSfZNz9/EAVAmCp7JYbqmQM7W23GtYtWdelr3Qo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pFwvRvy155KkheZWLi+wQphNKPKdkknzqvqNRPudlH+RDQMMaz+ei3L5gjXQF28Hh
	 eB5mnHBu1cVLhJ1gi7i6NDWsyuL1JtliDOOV2YWg6K/zVUD1Lj9vHHEI6NYYZKcQP6
	 dIWD4DOgv+3f4M+R+tj0U3jBeWBVDRU6t15MN/8BjrIbTbdMknnrAvFUenlTTWPf2r
	 Y10Wk9ISdl776cJwunw1LmJCIzvGGlg7lDFq5dCbrBZ58YtwK/chXjy/v3j35e5BAG
	 qRP8FrUNWIqQrVbosnfAY8T3mhDy9TQVayHIMy2wlL+nCqatfaqiSJRean5o0xrtHf
	 NIq3PHwODeexQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 04 Nov 2025 20:31:06 +0100
Subject: [PATCH 1/5] dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-topic-8280_mxc-v1-1-df545af0ef94@oss.qualcomm.com>
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
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762284668; l=875;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=1su1l6NZzR9E7hkUkP7zqBfafRJ3lMp5LWeh0VrhAV4=;
 b=EruAmEhpnU07EYNQ6TKVTAUFr+3mDDVKu8jVNijcBHnUsXio0M8FFOpcidXtcfopj0H1B25zE
 MxMIPBEc0qjDRrWdNeJGEHWaVceFawA2tK6Br3SqerQFDaEDVtj0uv0
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Not sure how useful it's gonna be in practice, but the definition is
missing (unlike the previously-unused SC8280XP_MXC-non-_AO), so add it
to allow the driver to create the corresponding pmdomain.

Fixes: dbfb5f94e084 ("dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains")
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 50e7c886709d..06851363ae0e 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -264,5 +264,6 @@
 #define SC8280XP_NSP		13
 #define SC8280XP_QPHY		14
 #define SC8280XP_XO		15
+#define SC8280XP_MXC_AO		16
 
 #endif

-- 
2.51.2


