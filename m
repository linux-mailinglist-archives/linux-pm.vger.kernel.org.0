Return-Path: <linux-pm+bounces-39091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1268C9C6A6
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A6C3A5A18
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B632C11E1;
	Tue,  2 Dec 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0f4JNed"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F01F936;
	Tue,  2 Dec 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696993; cv=none; b=Hnvue6QpuVd57yTkzjXG8UDfuK9JySnKNBsq8aaeoKw2m8vmS3Xi4H4dtCynUal553L3SIVQU9+Yl4CfYrMg98tfrsk8pMsEQQR38TSzPIyq3PDwZSce8jblhksxebver8sroDaMDQk0YMaeOC58a70i3w7IYtFEV/uzhfFb31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696993; c=relaxed/simple;
	bh=WKKb96dUnxTtpWwcBwoo1OA9xy5FjU1ALlxxuK48MAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cdQ2p5oWaj0VdRXXSHtcBH8zb+9uQt3qhpoOBWkx4tOyVMUxzy+lXnIltCMJn+m3LC7pMwVG0TyQDEwKCN5eqa67g8LC2pGurJyRrpj9c/wFw4n9rzvjNbfl24AJq/6mvfZij4vn/NgcohL3Jf2qT5c8iUUtnNOO55d7mSfoWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0f4JNed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A39C4CEF1;
	Tue,  2 Dec 2025 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764696993;
	bh=WKKb96dUnxTtpWwcBwoo1OA9xy5FjU1ALlxxuK48MAs=;
	h=From:Subject:Date:To:Cc:From;
	b=E0f4JNedYyiClUR69btfsYAhZi/SEn8ziXGbqO2dr0wCd25sVoQTc2GQGO+6DmC+R
	 xp00DkYvmNffUl9P5LXIeLBIkjTAK8o3P4Nvt1/rDUd/y1e6hHFPSv6OgapB3kBXFT
	 DZHmYLvmbeTZtd8+4QxlBGaVeV+7umZdxyrgmudJc3W8OgUbgZjAQgbQrr/supbETi
	 Mw5wrc0E8z9IjIaKnbgcyBMElf5NAmYmEau1yS18v3Y0YgZ9m2vUlKjB+JZ0t7XMRy
	 gsSW9R5JA2royho0cpCPESOgBieTLUhJ3rqNh9qiS/8B1+8NPnAVCIazYxduMC20LA
	 R93TcO+pW22tQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 0/3] Define VDD_MXC for SC8280XP
Date: Tue, 02 Dec 2025 18:36:19 +0100
Message-Id: <20251202-topic-8280_mxc-v2-0-46cdf47a829e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJMjL2kC/3WMQQqDMBBFryKzbmQmTUC76j2KFImTOlCNTaxYx
 Ls3dd/Nh/fhvQ0SR+EEl2KDyIskCWMGfSrA9e34YCVdZtCoLREaNYdJnKp0hfdhdYpr7TpyZ0J
 CyNIU2ct6BG9N5l7SHOLn6C/0e/+mFlKoOm+NbT2yr801pFS+3u3ThWEo80Cz7/sX9rHxqrMAA
 AA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764696985; l=1512;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=WKKb96dUnxTtpWwcBwoo1OA9xy5FjU1ALlxxuK48MAs=;
 b=tz8DPat9g0IuiRFgkkc2iTr2M9xkz83BQgKLwpFaqjLcv2xIinrs6zdMPflAkFrIRbVeau6Jb
 kz/Wr73BI41CLrVifgBeYwgyEaLdzjYn3VQmxgP9IV57Keo9vvIBAeD
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
Changes in v2:
- Remove the CAM_CC bits (thanks Imran for pointing that out, I was
  beyond sure this also applied to this SoC)
- Drop the applied rproc dt-bindings patch
- Pick up tags as appropriate
- Link to v1: https://lore.kernel.org/r/20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com

---
Konrad Dybcio (3):
      dt-bindings: power: qcom,rpmpd: Add SC8280XP_MXC_AO
      pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
      arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi  | 16 ++++++++++++----
 drivers/pmdomain/qcom/rpmhpd.c          |  4 ++++
 include/dt-bindings/power/qcom,rpmhpd.h |  1 +
 3 files changed, 17 insertions(+), 4 deletions(-)
---
base-commit: 47b7b5e32bb7264b51b89186043e1ada4090b558
change-id: 20251104-topic-8280_mxc-e92cd1c31010

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


