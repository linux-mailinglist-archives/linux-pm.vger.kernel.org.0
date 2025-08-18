Return-Path: <linux-pm+bounces-32533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAEB2A0AC
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 13:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF972A641B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C2126F2A9;
	Mon, 18 Aug 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueodRc72"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF93524F;
	Mon, 18 Aug 2025 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516831; cv=none; b=DTwhY4hW1QxBU895mwRvwbmbRkcDwolY7G9bATJfCQF9x9U47xgi8adOeMxMdKlIneE1/iGWQCvKHGa7w7jCq0CpbQTpt/df5S3rio4WWhuTBVGvQ8lrn9nxUbaGIW8zxfm1jqutn3sSkmDhjBeCKe0l0bVedK60RdYTk1dR4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516831; c=relaxed/simple;
	bh=VPmvGppSNUUnpQzLUFB81MV2LG6iGpEROwF2e1F+jus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWRhH653/F+QoYBPIrfpqyXhWzAdOIi7qpqFihuBapocMj2Q5PuACLHxhpiqC/D6Uz3BCZKGfH8hTMikSsPlSYykDzqYaJ/tVVN2mqJA4UpDsqRF3LVBJh435KOY1it7mkLWBBn4et4qigHJqUWkccFIeJ8LcuAkJkj6Rj6Q9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueodRc72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 711C8C4CEF1;
	Mon, 18 Aug 2025 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516831;
	bh=VPmvGppSNUUnpQzLUFB81MV2LG6iGpEROwF2e1F+jus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ueodRc72EMgF/Q9L+I2u4VuFQW/tcuarUAY+AscYrkddw1/d5EWKbuyQoP/IesvJ3
	 qiontaNMK3PEdOLw3g22Y7v530JDYq8U96Y2BMmdB8VyyzQd3LPVWOGn47DZEnvJqd
	 YcxnvWVq/2IAvjjOX914iPy6LIfuYWKijZ70q6pRi96Rtkn9gIByHeUVaqFU0HcNa+
	 jBqO2PYDYNiMEmbWL51Dk5nXsiRI5vvPtW6EI9BhntPJZ+N7sVwV+YovHy9omQpre5
	 bubMDMZ5Yg6lP02s3vC7sBRvIADISrk9tW8IuGRDX12RAm27jmeqPff3C07AOvnjtd
	 R4hPgjNtd3KZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60225CA0EC0;
	Mon, 18 Aug 2025 11:33:51 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 18 Aug 2025 15:33:46 +0400
Subject: [PATCH 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018 tsens
 standalone compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ipq5018-tsens-fix-v1-1-0f08cf09182d@outlook.com>
References: <20250818-ipq5018-tsens-fix-v1-0-0f08cf09182d@outlook.com>
In-Reply-To: <20250818-ipq5018-tsens-fix-v1-0-0f08cf09182d@outlook.com>
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755516829; l=1557;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=h6GA/ttuT5bOVLTfp0krHWJVqoQSwvPud4lHYllswcw=;
 b=Jz8rZ8j0SE3OH7xPW3fuaGbzqG1ZtX07jgsJ254EVi9k1/G3+YpCotI53W7PKERBFReUjY38r
 Eh9gtlGjDw6BbcodGpLI6WBxE1mqtSlwkeMv2azigjmy30tOdUtu4nO
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The tsens IP found in the IPQ5018 SoC should not use qcom,tsens-v1 as
fallback since it has no RPM and, as such, must deviate from the
standard v1 init routine as this version of tsens needs to be explicitly
reset and enabled in the driver.

So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.

Fixes: 77c6d28192ef ("dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 94311ebd7652d42eb6f3ae0dba792872c90b623f..9f342e63bdb1d27bd12373fb4c7611964bfd8d4b 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -36,10 +36,15 @@ properties:
               - qcom,msm8974-tsens
           - const: qcom,tsens-v0_1
 
+      - description:
+          v1 of TSENS without RPM which requires to be explicitly reset
+          and enabled in the driver.
+        enum:
+          - qcom,ipq5018-tsens
+
       - description: v1 of TSENS
         items:
           - enum:
-              - qcom,ipq5018-tsens
               - qcom,msm8937-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens

-- 
2.50.1



