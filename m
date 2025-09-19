Return-Path: <linux-pm+bounces-35014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF09B87C8A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 05:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FA31C855EA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 03:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3B2580E2;
	Fri, 19 Sep 2025 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpZrw5N2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9D22F755;
	Fri, 19 Sep 2025 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251940; cv=none; b=NNY0gt+A762ZWDlws+QWxHbY8/wJfZpkGOM6KbQf62yRD4A0iTORrFdI94Gay4mmia9EMXcvCVi4MWMRKOLOnl2h/xeAxcPZQXOy9+G38rjdyNOhOJ8iizC9gbMAxVe/I7K0u1o7aM68sAMgfVeK65ewj6WUw7+hohBMijb6FDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251940; c=relaxed/simple;
	bh=4y7Qat4TBsdLXPPTnpkcAV5ZsirjHTUE90pFEsVfYQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p3o2+ZlmtYdsZx+//iO2wNMQZx6QWK9IBC58E/Zcp4iKTmB45l2sf88uKe1xht7Nxdy6l3zagxfMKBYbe2Ilbksf4krxbPh/08Xgenmfy5gGOSzg5J/G8FUvN8BzLDyea9/OthDZngbFMnlxirBSRSfQ4gvSwkAGAc4mfk6DfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpZrw5N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3949C4CEE7;
	Fri, 19 Sep 2025 03:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758251939;
	bh=4y7Qat4TBsdLXPPTnpkcAV5ZsirjHTUE90pFEsVfYQU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LpZrw5N2NMcaS44qvfLLKQGVNdtu1PGChzYuCBlRTn0ORcb4kyqdbnIMebNtS0moo
	 Kojltwj3zp7LSyPJC+JUmg2E7zhfLr/rw+AH0bEE7tVgDJptTpwjnad4wSuklYoC1n
	 4pIJ8rfYx0k3lZcgHftma3eXgO+smZadYT6h14lgClKLgcBIQXh2VYzA4awXsTOHjL
	 YOJoffmWrIqudTBLjUmFBEN5dL9XY65QP6jRxHNmCMMwBOZptqt2W9l8wzS1GMEPph
	 rT6oO9R/PxzgnHY6A6n2EDYCAybHNbwq3VaaUMPkoa3ihmJrSH/GFTjOlS+pOGTLRj
	 akfYDoaJA5Q+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB7CAC5A5;
	Fri, 19 Sep 2025 03:18:59 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Subject: [PATCH v6 0/2] power: supply: Add several features support in
 qcom-battmgr driver
Date: Fri, 19 Sep 2025 11:18:49 +0800
Message-Id: <20250919-qcom_battmgr_update_new-v6-0-ed5c38867614@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJnLzGgC/x3MOQqAMBBA0avI1AaMG+pVREKWUacwahIXEO9us
 HzF/w94dIQeuuQBhyd5Wm1EnSagZ2knZGSiIc/yKmt5w3a9LkLJEJbJiWMzMqCweDEz8koVJS8
 b1BDrzeFI93/uh/f9ANHoCARpAAAA
X-Change-ID: 20250918-qcom_battmgr_update_new-df15b34148ec
To: kernel@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758251938; l=2035;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=4y7Qat4TBsdLXPPTnpkcAV5ZsirjHTUE90pFEsVfYQU=;
 b=WOa6mruhpl/a5xoK0bbi5B7WSOB8GVBHub+Ew2/i4Jf2teFL57OaUJls5SUrt/sj6vZ22ME4i
 4tAFtj1DwqmCEl+u+Ezmk4KQ20wxFled2523tPSQhmWmd0ghBIRhRGI
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

This continues the effort of updating changes which haven't been accepted
in patch v5. Including:
  1. Add nvmem cells for x1-crd device to enable reading back charger
     control threshold.
  2. Add handling for notification 0x83 to avoid unexpected error messages.

Rebase the changes on linux-power-supply.git@for-next

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Changes in v6:
- Dropped patch[1-7] as they have been accepted and present in linux-power-supply.git@for-next.
- Formatted the commit text for easy reading, and correct the bit positions for the additional
  notifications coming along with code 0x83.
- Added "Reported-by" trailer.
- Link to v5: https://lore.kernel.org/r/20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com

Changes in v5:
- Added additional explanation for "state_of_health" in ABI document as Sebastian suggested.
- Removed "Tested-by" trailers in the patches unrelated to charge control feature.
- Updated the copyright statement in qcom_battmgr.c according to the latest guidelines.
- In [PATCH v4 5/8], add "X1E80100" in the "if" variant checks to ensure
  the correctness even if only this patch is applied.
- Format the entries for "nvmem-cells" DT properties.
- Add a new change at last to fix the error messages for unsupported notifications
- Link to v4: https://lore.kernel.org/r/20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com

---
Fenglin Wu (2):
      arm64: dts: qcom: x1e80100-crd: Add charge limit nvmem
      power: supply: qcom_battmgr: handle charging state change notifications

 arch/arm64/boot/dts/qcom/x1-crd.dtsi         |  7 +++++++
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 20 ++++++++++++++++++++
 drivers/power/supply/qcom_battmgr.c          |  5 ++++-
 3 files changed, 31 insertions(+), 1 deletion(-)
---
base-commit: cc3e883a06251ba835f15672dbe8724f2687971b
change-id: 20250918-qcom_battmgr_update_new-df15b34148ec

Best regards,
-- 
Fenglin Wu <fenglin.wu@oss.qualcomm.com>



