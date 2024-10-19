Return-Path: <linux-pm+bounces-16014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CE59A4D68
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8561F250DB
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55B1E1C3D;
	Sat, 19 Oct 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="HUA7lt2q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E0B1E1319;
	Sat, 19 Oct 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338657; cv=none; b=Cks/kL6r3C5NJECi0xSTug5ABgGhBr70NmPr+ubPf4oMslyRyFGEDZRwhY/uMw19m1+Gy1UB41O5WGK2EQKTp1rDisTXfHC0AMX3GPvymPfsW4KOU3LemrftF1ekkpzwiGwynJ6IwJAl7HCu7a07cv0EdA9hy4/1SnGQvQzMJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338657; c=relaxed/simple;
	bh=6kyI8Tcl7R9HDBFx1gkFswYsDmaf4ylpJeZ5Zg10oiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgXmrnudPipkdG52BWEvy/+LO3MyuakQ+SFt74U/4zbBFG26RwFPf2/gqOXQAWCYGR3uDDyns9hmt1AQuUgJ9gqRsh1HLz9X7kNk0AraRm7rKm/KNO9j6vi/pONe5mu+Q7NKIY9ZUuHsbMD+lVOCUfTnavd+OVh8FtB0fIp7gdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=HUA7lt2q; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 6CFB0E45A7;
	Sat, 19 Oct 2024 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5alMJRql3gqrqTNkSA2fg70oYcbid9R/aDxsT0IGwds=;
	b=HUA7lt2qe8OpQQQtApF83xR3uYiVfuhTwP8+FE8/h+mOuy+R0JrtG0ihXVwGp0Nm1ihvjG
	gIO9mXMlFviClrB+GWekxgqg+hb0fS/m9OiMb/y6JaSC97OLRDqXaBGakkp4gJLsbkFPll
	BJSbYbmZ6J/YXTp196AcHr0ih9fzH5b4YORVyUltWtb80JMY9wiOvV1ck0HYFxIIV6OTEG
	1/9HT5FzYUQilwlPrUXQIicXGiWtY0tG2lzAbPOQURoKwZp8wMuwFlYQugqMY9XiiRwPDr
	SDPGChSQUinGVgAyQ4i4/gqy9D+JMRpLxKkhXEcy0PM6zPoTMiiX1UUy6Lpu4g==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:48 +0200
Subject: [PATCH RFC 11/14] dt-bindings: nvmem: Add compatible for MS8917
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-11-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
In-Reply-To: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=859;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=6kyI8Tcl7R9HDBFx1gkFswYsDmaf4ylpJeZ5Zg10oiQ=;
 b=ufw5737uB19IWV5PM9IkUvAkzFDRi1X8Sv2lKjiAk865fKuZYyAqFVlLC1ZzgIRBN7ihpE9t+
 kFQjeR0M+H3CjR9wAE9/Q0JUNhRnmAq8DFL6ujbJmaSEIw4ry5jGEj2
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the QFPROM block found on MSM8917.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 80845c722ae46611c722effeaaf014a0caf76e4a..4d81f98ed37a3a12f01d444dbfa77badcc09c22d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,ipq9574-qfprom
           - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
+          - qcom,msm8917-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom

-- 
2.47.0


