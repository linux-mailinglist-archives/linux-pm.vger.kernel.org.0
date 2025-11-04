Return-Path: <linux-pm+bounces-37384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656AC32C98
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 20:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0D9534C9F6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206D129B78E;
	Tue,  4 Nov 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+M40Ynf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DD23183F;
	Tue,  4 Nov 2025 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284678; cv=none; b=CnSkonHj+wGyhHRj2Xeg+6ALfGyVSLLd6gmqY7PDzgazu+gy3suPD0foYM3KY7CVDpR8Pzg1lhQGwgjGDaUUDmF4TUlnZ6GXPJmZ2QyKDVzR3PntVp+DSYVqkXnY8fRO04Eo0Uc6D65Ua3gB128HrE4xHSz/FkJ5VGoFHU4Mb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284678; c=relaxed/simple;
	bh=bv5RrLvyhbRRTVmzsWpNHNTYrpGvKzpe/nqRzbjAMOc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uTNXtKZ6sgVsmkXyCp63aqeAgU8sIkQrdzc/GEaJpuWXIKv76cwu2Yq7wKZUkPJ6AYLXvJvUNOqL+LYrHYRQN6PDDf3YNlP1ifgkQznNzjuF5yNV2Ru5W7ufm/N2ek0jZ1hC0IF2DcUwU6dVM0t69TDofCFBr+NemG8xLzPg3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+M40Ynf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD05FC116B1;
	Tue,  4 Nov 2025 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284677;
	bh=bv5RrLvyhbRRTVmzsWpNHNTYrpGvKzpe/nqRzbjAMOc=;
	h=From:Subject:Date:To:Cc:From;
	b=c+M40YnfD7beibvpnLx5x7JTJxsI8UKfWeerqy+wnhCGnuIEEdKuAPbMRrmL14vG7
	 OP5Z8LhbKV6qlXKCmk/umHqs2ez0wm6y99i+x+3EE8JpbkXhTr14Lc6PZYNTbaQecI
	 7U1is6qB+I4HGST8GzSf0pZIKBGMbda5tDdOmPNHr8H+gntvMRIX9oQngYiEvGYZz/
	 ScJEhzNnsDL/NDqU63Mt3U8z7f6wYjzLXSuybWHK81ljSvq4Zlq6OJ6TAXpb2gnSPH
	 1uy+xh8BIcofnCeXYt3SuC3AqYaxjFkrJwyTENJo73bWBCt0SxHd2b0BE8/SwC53JT
	 zeFXGRBL7tLew==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/5] Define VDD_MXC for SC8280XP
Date: Tue, 04 Nov 2025 20:31:05 +0100
Message-Id: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlUCmkC/x3MSwqAMAwA0atI1haSqlC9iohIGjULP7QiQvHuF
 pdvMZMgSlCJ0BUJgtwa9dgzqCyA12lfxKjPBou2IcLaXMepbJx1OG4PG2kte+KKkBBydAaZ9fm
 H/fC+H75OoqtgAAAA
X-Change-ID: 20251104-topic-8280_mxc-e92cd1c31010
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762284668; l=1567;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=bv5RrLvyhbRRTVmzsWpNHNTYrpGvKzpe/nqRzbjAMOc=;
 b=H5Hd0okQAulEy5VeWlV8Ukx2Eq3uQdliujWHUP28jquv7CdJcQSVW5tPKUZqcsIBq/Oc0n+VX
 g4PRdGKoPoZDtMDG/DJ8gVlJ+7R3S7koWQx/xzhvi9gc0dNm/ZJgGt2
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This has somehow been omitted, leading to potentially stale votes.
On the flip side, the domain will now be powered off, which will
uncover any omissions we've made in the DTs so far.

Reasonably tested on an x13s without pd_ignore_unused (camera still
works).

Video (not upstream right now) will also need this connection.

This series defines VDD_MXC and wires it up to consumers.

pmdomain patches extracted from:
https://lore.kernel.org/linux-arm-msm/20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (5):
      dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
      dt-bindings: remoteproc: qcom,sc8280xp-pas: Fix CDSP power desc
      dt-bindings: clock: qcom: Allow MXC on SC8280XP CAMCC
      pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
      arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links

 .../bindings/clock/qcom,sa8775p-camcc.yaml         | 13 -------------
 .../bindings/clock/qcom,sm8450-camcc.yaml          |  2 ++
 .../bindings/remoteproc/qcom,sc8280xp-pas.yaml     |  4 ++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 22 ++++++++++++++++------
 drivers/pmdomain/qcom/rpmhpd.c                     |  4 ++++
 include/dt-bindings/power/qcom,rpmhpd.h            |  1 +
 6 files changed, 27 insertions(+), 19 deletions(-)
---
base-commit: 17490bd0527f59d841168457b245581f314b5fa0
change-id: 20251104-topic-8280_mxc-e92cd1c31010

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


