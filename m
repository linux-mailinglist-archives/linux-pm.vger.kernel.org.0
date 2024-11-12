Return-Path: <linux-pm+bounces-17431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10F9C6127
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 20:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E75C8B82179
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462C204084;
	Tue, 12 Nov 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="kPn7md7K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C298204000;
	Tue, 12 Nov 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426591; cv=none; b=Mtr51Nj/p0Iacuop376mLXb/z5RvErS7F6kRvaP93g/cxmKI0nLo+m5N/UDFYjrW8ula+mn3rqidXPFEIIdVC4WumphcEjBNKX7+wMPD0Vl6Ka2la+wj61LzH/+yn/O53zPUWcDLgEcE+acTrnBQcibGYIALNOGHgaCpdkQZ528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426591; c=relaxed/simple;
	bh=9EpBDn6+VrUhl6s9RDziNCH5FD1n12+IVb+sGxL5HO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nK2Lr0QmrSF4SLU8KljiThPp0frBXjTe/5rA/WxtOK8u4DZR3tcv7SJReZxiurGtJHBD+npSJQT/pbcZI/gB8mBeBayoTUnuEzPxWXDk9itfvDfm/dbSMY5MbmOd71rfUxsZXmBcsXTMy2QMbZyRdZXuaWGOd02Ei1c30i2bY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=kPn7md7K; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.93.162] (254C22F6.nat.pool.telekom.hu [37.76.34.246])
	by mail.mainlining.org (Postfix) with ESMTPSA id E8DC6E45D3;
	Tue, 12 Nov 2024 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731426588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgTkMERpFtHVYtKjLiYY15MruMqcfI9oO4bj8B7L2VI=;
	b=kPn7md7KBIgfpO4gpTYsanRs+K5bGEyEYiEHhYgtzqWxLo4T4teBiB1ZiNOTojNowcAnas
	SckXrtpmtuEsWh4t3PH5P2eZLUcinsrKrSLyDSwriz4RxgSQhFeiHQUDz6weF1y8WBFKLV
	0Y2vQHmGi3aHkBd7UF8jG5DwtU+66mVrVGyM67WX/e/mVaj9NwfXp1meutAXCmPYbjxuk1
	3dpESs8txa1fUZ8OjsjFGz5DQMCNrE1Kc+aMG4vGJWW1MxNBoUd3J50p3/1Y7JMSHQ5o1t
	q/g1e16oaIKo1hQxdRydBmJizVUt0T0yiaXSirZLZGyUtrNLpe0BJfMlWCy5uA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 12 Nov 2024 16:49:36 +0100
Subject: [PATCH v5 06/10] dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU
 to SMMUv1 compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-msm8917-v5-6-3ca34d33191b@mainlining.org>
References: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
In-Reply-To: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731426576; l=1003;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=9EpBDn6+VrUhl6s9RDziNCH5FD1n12+IVb+sGxL5HO0=;
 b=I82ffqJ2HaD59hhVEMY7dxGLl0cR2kK3mB5xGEY75nSONRwQiSS15nOkiWf0pmOgiL84/uSIB
 iA3rZUH++OuCuyVCaVG08ZXoNFpaTLF13GuNQeD8tcFMIew3kPtQW7M
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add MSM8917 compatible string with "qcom,msm-iommu-v1" as fallback
for the MSM8917 IOMMU which is compatible with Qualcomm's secure
fw "SMMU v1" implementation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index f8cebc9e8cd9d46b449cd297153dbebe5c84bf3f..5ae9a628261fd251c1e991a70662c6d37ef2c4e3 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - qcom,msm8916-iommu
+              - qcom,msm8917-iommu
               - qcom,msm8953-iommu
           - const: qcom,msm-iommu-v1
       - items:

-- 
2.47.0


