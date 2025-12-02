Return-Path: <linux-pm+bounces-39093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9EC9C6CA
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 18:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E62EC3460F6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0672C21C3;
	Tue,  2 Dec 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+bXBErP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2402C1788;
	Tue,  2 Dec 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697009; cv=none; b=Xr6eW5+kxGCuP1Z1QjmejTXSsHV+UT0eEh4ga9XD+R9SZhzSnjnhSEs2s9CglauvSlHc9BqLll0yRpz8xAUIzFU8PkcfYQerNFwh0otRUiVJ66oTZOo0DTuiGsi0X/Yjri2vVVhCmeP0QTwvHS/iIvd7w2QM71ZglvsQFab/bM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697009; c=relaxed/simple;
	bh=X12PndyHroreQFIJf00P4HquKZkPkL6meJAYJRfj8Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDOojYOklk1CDf82ta1tb6u/+dE/FuSH0cOAuBdvalUqQh2oqkHnrE2WxLvZr/vFn7a5nAm7EaEFXk9jiLLN7H/aaplD75XGHJK6ep8xo+3qRt0wvhYhqGENX8ternOjMh0ZbWQA6ou381EEHRG7QrI8iHhwwvOQeAKSmYj8qyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+bXBErP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAC7C116B1;
	Tue,  2 Dec 2025 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764697008;
	bh=X12PndyHroreQFIJf00P4HquKZkPkL6meJAYJRfj8Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P+bXBErPLKaIrybQErE8NxIS+t2VWyLB9o4QSnw+zDNHrqYmHR+nWDz28t7Au8WEa
	 p1N/kgQOIHuyZVVGxnZqOMZtfRQ964Rd1Rju+vBQjQzxFocKvdnumqtwdkYVpbFcUt
	 eZ5XNqwRFd1sHUbuBbh5GXejOWjev7bgZXoFQ+a+Gc4EO4hWrkLlJBKpw8DReMvi5Q
	 HEv2WeJVq1/s5V0NqPQKi0UyqR/+jsLZewb6nC6k1ZBK1rlF9EwNewClqZetER57Cq
	 4QEiSB2LY4js0UDa52nr1sjrmFeCzsJfcwiQzswVDsR6ujMlbLuantGdqacCZFX8Np
	 Ix7hL2nCV2cEQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 02 Dec 2025 18:36:21 +0100
Subject: [PATCH v2 2/3] pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-topic-8280_mxc-v2-2-46cdf47a829e@oss.qualcomm.com>
References: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
In-Reply-To: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764696985; l=1180;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=TrNqU+NFvZt8X8boVtl/37MvasfHczPy5pB7FCnZowU=;
 b=Qtx2uxu68B2JiwzSVnp6ufe8l69XZS94GHMT8oAmljmDxUF3TKawE99iUQF+2fAboP5Q4Dbm9
 APg1DWBweMkDOAdTwrt060O1fWDTAjQUvabK9GrXWgBT2pbis45Ymur
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
2.52.0


