Return-Path: <linux-pm+bounces-11671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E02941404
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D675E1C2302C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180661A08DA;
	Tue, 30 Jul 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syUL+W51"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EE19F499;
	Tue, 30 Jul 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348703; cv=none; b=DX+SSRB5f0vzl+PtVUmJ/6Rliyo9Ybg192160s7ed1SptmLEHqjnGaFReJ/1zrOyuLjDRRJVu+oqUIMzLS+c1G0H6fDTmhp2tkn0DeV8wl5pnYfxCfbuBNmUxoEcthAr2X53TX6Px4332jARPzzAIFtcPoTAfcD86zNQEAFxz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348703; c=relaxed/simple;
	bh=DNNAvsBgtEMxyU0K/tgTdZjkyyIouP9Wz2FU5+7NrB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9G2ht4t0SqFM4tCLCdoL6EhIUQEcNzMkiC3b2aGQJ9b2PHKW7V+pHsUEswmVqA0jQFWt+xAHJyYKTgUsWnWEFmZDZGO4n8dw8r32Zlju9Ji8G0owrmk+0Ab4c3AGPdcvBtEeFF+36c+xUOoziD0h6jUzDLFOV5NAS27JUArG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syUL+W51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A890DC32782;
	Tue, 30 Jul 2024 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722348702;
	bh=DNNAvsBgtEMxyU0K/tgTdZjkyyIouP9Wz2FU5+7NrB8=;
	h=From:To:Cc:Subject:Date:From;
	b=syUL+W51v5ODSxCIYb4BjhevWjQjsWw2HdfXuDf16FcIPMffZdGGzpMDpW6dxaTdW
	 kR91k51aBUDTBGb4Q7gS8SSss6BcxpT8qvcbxAu9uhLWKCQ+kkGjdDAppyIdk84lWr
	 yR7pF34500PSlHZd7C/ldyBXCtbVqqhfh5zZfza7Qqga8ebO+1/U+YW2RXLpIYNVBb
	 Mbhv4AleQJbwNwl4ZkuPxyx+QC+8/BrXLLxInbSK4hBPOLekeZZai/GlbiH3Gpu+vV
	 BsoDeKNR+po9b4BvMmQG1uCTqY2hPBkNGTj1JbioJ4U39W6ZxLQtBlN9jnmpbofw52
	 thHT0/bBBkR7g==
From: djakov@kernel.org
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quic_okukatla@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: interconnect: qcom: Do not require reg for sc8180x virt NoCs
Date: Tue, 30 Jul 2024 17:10:16 +0300
Message-Id: <20240730141016.1142608-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georgi Djakov <djakov@kernel.org>

The virtual interconnect providers do not have their own IO address space,
but this is not documented in the DT schema and the following warnings are
reported by dtbs_check:

sc8180x-lenovo-flex-5g.dtb: interconnect-camnoc-virt: 'reg' is a required property
sc8180x-lenovo-flex-5g.dtb: interconnect-mc-virt: 'reg' is a required property
sc8180x-lenovo-flex-5g.dtb: interconnect-qup-virt: 'reg' is a required property
sc8180x-primus.dtb: interconnect-camnoc-virt: 'reg' is a required property
sc8180x-primus.dtb: interconnect-mc-virt: 'reg' is a required property
sc8180x-primus.dtb: interconnect-qup-virt: 'reg' is a required property

Fix this by adding them to the list of compatibles that do not require
the reg property.

Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 9318b845ec35..70f5b2670085 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -113,6 +113,9 @@ allOf:
         properties:
           compatible:
             enum:
+              - qcom,sc8180x-camnoc-virt
+              - qcom,sc8180x-mc-virt
+              - qcom,sc8180x-qup-virt
               - qcom,sdx65-mc-virt
               - qcom,sm8250-qup-virt
     then:

