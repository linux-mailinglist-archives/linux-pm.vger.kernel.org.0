Return-Path: <linux-pm+bounces-35439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6219BA28B6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC51C23B69
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 06:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265527B342;
	Fri, 26 Sep 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMepNN9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48C18DF8D;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758868939; cv=none; b=tzTii1n++Jw+Lw0i0DwlDvd0kBtGrc/K3F+z5pbaOsEAWcFukzx2xyD8g4EuktNrRXnzqgNr/XrmKfdKJqu9YMhakTlruXsoNY0ksHsMoYQMzdVi5IuaW/XuXOyOkEdZSoOaMinXc6pvEd2fFbMCgykp42DVT5mP2Mi+fPN8fRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758868939; c=relaxed/simple;
	bh=w50rQbsUwHAX7rQjt1NnSquIVsSXVF6HpsxQbh+X4Zo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EUNU9PrD4o7K9WjykP3FSt3ua+mY79VUmMBJqQKIQfSvg56nqEIMCcShHZ0cHldNa7EZUW8/EdEmNrlHqKjemxFVC2u7YhOXC2Fed0YaLnKuSgrQ+l3BNzDGP6g/5bR0R7luBdqUPdW06oKoH+vTUMi/aQrm7jMJS3+iT2AhKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMepNN9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1395C4CEF4;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758868938;
	bh=w50rQbsUwHAX7rQjt1NnSquIVsSXVF6HpsxQbh+X4Zo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kMepNN9UC2aPLOVPTZ5MKfKSZf79LxorNe66eTKPvAXTcQZ3g0NaD9ncRzgjibsiy
	 YD4AR7sPd+Q0M+QUC7L0nJ9nbkTBm0zBrMH8qRpmU2/Z5MPuTBNhvpCMvtLbEJBqe4
	 MWWQipCTbxTTVXopTIH7MpzRbL7sbxmoPZXtpN60/iJpINLIksz4gLcHM4MC4FADzT
	 hm/gCwyUhUEerEMoHGlWLewwsoKMuUH5EPghNIFVYXVsneaFWEZp6SWLPAWUmDpNbB
	 nCZcOXss6O5CUAQ4MR3XDHxe676/rzD5eIKQFJFoGRSNdA21dlzyx5XEahMVmh1dc7
	 BOp7Q8UXKQs6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC74CAC5B8;
	Fri, 26 Sep 2025 06:42:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/2] interconnect: qcom: sdx75: Drop QP0 interconnect
 and BCM nodes
Date: Fri, 26 Sep 2025 12:12:08 +0530
Message-Id: <20250926-sdx75-icc-v2-0-20d6820e455c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAME11mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMz3eKUCnNT3czkZF0z82QjgyTjlFQLk0QloPqCotS0zAqwWdGxtbU
 A34DkpVsAAAA=
X-Change-ID: 20250926-sdx75-icc-67c20b3de84a
To: Georgi Djakov <djakov@kernel.org>, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
 Lakshmi Sowjanya D <quic_laksd@quicinc.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=w50rQbsUwHAX7rQjt1NnSquIVsSXVF6HpsxQbh+X4Zo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo1jXImIUMosVMEtE4ghqPdD1MJv1QPBohfPPr7
 jcaWqgcHH+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaNY1yAAKCRBVnxHm/pHO
 9frcB/9Zc7MG+v8da1LYI1ZK1cOzGIBzmucX9iVFdcve/fQzbHEVk+Xq1Xuwi0WQZCcMB5HIfRv
 G0vwDGCkPB46Krt3X35JtJ6b7aiC4i+CGwWSQkFpuuzq9TZNyBT7Tw4EKIAEoLKjXeYQxaS+oLT
 Rw0Hu4Us1HOHpiiXrDAZguzfrQLgcta8Ck2Jnl1vI6ggK1mO6ffU3rUPsxthIvP+Dv0AX4Fpzc4
 nc7xJaLYWRTEOAMqaJHuP0NEf6934HaF5SG0481sz8cLPEUFzpgXA7R/PM0DjScLm7vrUmkm4HR
 uofBSBwY/gYOOAqxCwz7l43Iy4TaKB3YLAFy3ldMViMv0shN
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series drops the QPIC interconnect and BCM nodes for the SDX75 SoC. The
reason is that this QPIC BCM resource is already defined as a RPMh clock in
clk-rpmh driver as like other SDX SoCs. So it is wrong to describe the same
resource in two different providers.

Also, without this series, the NAND driver fails to probe on SDX75 as the
interconnect sync state disables the QPIC nodes as there were no clients voting
for this ICC resource. However, the NAND driver had already voted for this BCM
resource through the clk-rpmh driver. Since both votes come from Linux, RPMh was
unable to distinguish between these two and ends up disabling the resource
during sync state.

Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Changes in v2:

- Taken over the series from Raviteja
- Reordered the patches to avoid breaking build
- Improved the patch descriptions and kept the values for other defines
  unchanged

---
Raviteja Laggyshetty (2):
      interconnect: qcom: sdx75: Drop QPIC interconnect and BCM nodes
      dt-bindings: interconnect: qcom: Drop QPIC_CORE IDs

 drivers/interconnect/qcom/sdx75.c             | 26 --------------------------
 drivers/interconnect/qcom/sdx75.h             |  2 --
 include/dt-bindings/interconnect/qcom,sdx75.h |  2 --
 3 files changed, 30 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250926-sdx75-icc-67c20b3de84a

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



