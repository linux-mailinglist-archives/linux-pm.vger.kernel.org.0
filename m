Return-Path: <linux-pm+bounces-17665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9861E9CFE8E
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D34DB26B69
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC7190674;
	Sat, 16 Nov 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnGEno9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF722338;
	Sat, 16 Nov 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756683; cv=none; b=G291b/RIldyOtN5u8H/yaO8O6bCyg6FfNBgbkpx4yTnIyhT382YfXseCdhlDDc+Tcil2Pf0+2p9yzQqKyt7ATJzp8+zytNmLtvdcTIWgvX6ZL5OX6gKLccCP3yStRFhB/wLjATH5PbJfmal1X3dcypB7i4E5h4cGZ/rs/dQP2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756683; c=relaxed/simple;
	bh=cj87K21fiofZv5vzKeP0rOuBx822aemdxsrd4srrtaU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SVtzuu3JbLyehynGYkbw3ETyEvq8IExLx49nplNE7TNe5zqDgSC+YuxGbZXoZsGNhUIpsp2eGoh17VnYtoUIeowgUgQCfSeubU9L0LbS9j4U5NxpKc2Z64VnhuUfthPd7ROpRb4DyFnFNPNb0JFCfUsA7q23sEf1mZekaAhegTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnGEno9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FD7C4CEC3;
	Sat, 16 Nov 2024 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731756682;
	bh=cj87K21fiofZv5vzKeP0rOuBx822aemdxsrd4srrtaU=;
	h=From:Subject:Date:To:Cc:From;
	b=bnGEno9UlChK/cjIKJhDHBGZR9beusm+X1/Rj4zSqTJDM50i9PEfM4HgaqJYOjGcT
	 ANYUctiMydk2swyerWuCzVr3wSmQ2uNnFO6mCcNHSOdMD/31dVuniGMDk3nERgvOgz
	 lwz3DGkmQ9lbI1jKbtSo4bqSdOR46RlWVUmFv58LCbktU/RIz3bOLmuBL96dGzhlSV
	 HGdXbBp+4hxGUIpLtPoYJvUG2oscKCfjZRBTWtOXpua97Vn4+VDM2QoH5m6aU4otoF
	 JaSjnOh9TcPa2z9PPlaUKHJzeU/0NreTY0hK2+lxj/RuGocSN5Bcoyd8kyO6Mv8sE/
	 JAbvsPV5lNPUg==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/2] Fix SC8180X cpufreq dt-bindings error
Date: Sat, 16 Nov 2024 12:31:16 +0100
Message-Id: <20241116-topic-sc8180x_cpufreq_bindings-v1-0-e7db627da99c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAISCOGcC/x3NQQqDMBBA0avIrA1kgqahVykimkzsbGKaaUWQ3
 N3Q5dv8f4FQYRJ4dhcUOlh4Tw3Yd+DfS9pIcWgGo82AiFZ998xeiXfo9Dn7/IuFPvPKKXDaRDk
 bx9U+0GqzQIvkQpHP/+A11XoDPyb/jnAAAAA=
X-Change-ID: 20241116-topic-sc8180x_cpufreq_bindings-86f5b671602a
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731756678; l=814;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=cj87K21fiofZv5vzKeP0rOuBx822aemdxsrd4srrtaU=;
 b=lvnZGuVjrdgCr4nYrC4JSHAQhDKU35nLWlNDxPvkNRGwEtkBwS997Ptzy+25xXmSSml2VDDow
 q/Au2QOziSgBqr34uGFhOsS2nH/eOk4vnkjMfRb/+C4hNRNKz/CZD9E
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the bindings and dt bits to fix:

cpufreq@18323000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['qcom,cpufreq-hw'] is too short

No functional changes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (2):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SC8180X compatible
      arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                          | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241116-topic-sc8180x_cpufreq_bindings-86f5b671602a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


