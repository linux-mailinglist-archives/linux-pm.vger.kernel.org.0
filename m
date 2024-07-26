Return-Path: <linux-pm+bounces-11429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC2B93D212
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EFA1F235DC
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AA17B503;
	Fri, 26 Jul 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6knsEC1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611717B437
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992730; cv=none; b=fmtY32LVN/ymYhLbBc751QHdzFPpemTqNC2N/0LC1/DeYfsK/pJREWGkhrVYaP2QfsEnQkGkw8gLaCRsuBZUPmETBqI3ZZelP80HgeRBb7X/dE12GJh7Aj4SPl2U4s0slWdHgOLwpGJW2kFWhxoWTpm9zw27jmKDwZYJ1sMWNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992730; c=relaxed/simple;
	bh=eooUCy7cgdlKNssM/JCAsOy3YbfB6M7AKQ74WlrJuBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IP1jtD7taGi8HsRk8pmCr2UU4jndYCsAhwDC+hguYsk5FQywNzyScIgSNuT0XKLs7bVYevDkHVTdzjdUwkiD3ZrHrmTKURfG5joxX1/5PqaI0Vw25zCU4oqV1rZaUB1UQ0XYxLNfE2W/PxR3uTwoAuCTe+/98YsU17fTDUpEqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H6knsEC1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7b237so2713798a12.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 04:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721992725; x=1722597525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IESLEzTWGsAxxNXIgU5OtMkJQ2JQYSGpAEOQx4aKzU=;
        b=H6knsEC1eAogzd6r9T5+w0XJZurzQKoQ0eA6DE8LCmTSF9+d/anMIBaQtXsPEUr+dM
         vG96kajti/Y5SRjcpwhJFiDtTC6F+UlYuKxqMCOj1XRXALZbj4Izqng/5gDbhWf3h6xs
         gKklS7LVgDD/adGZ3j1XpGI5gbCKOVUuGr+gqoLV7YEpjyqkAoWXabZho2YucafAZVsi
         gxXMtb6bzrFie5YtBE0vV+ttmZFCH1LMNMWlRg5iaOiW6pZeDkC9Id+dizHHGqxym/Zf
         zfne/jeAYtg849qApZwqLS4ER9VXcR2LZ9+W8vh0BXB+/Ne5KEzS3Le3DYTwKkYepcJS
         E44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721992725; x=1722597525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IESLEzTWGsAxxNXIgU5OtMkJQ2JQYSGpAEOQx4aKzU=;
        b=swEhCqbTkVo3oA8mgaBDVhybkhdivPK89zHHKyFAiD/GBW7RPWuv+EIoppUv9Y2MTS
         UMnONfGcbINQSo7jUIBjhRRZabx9fzGgcmML9LzsbZlg5ZU3WLuS5gsymXowQRsNdYQt
         Ng4czJSWjd4RWTn0z3q0sRqrBCn6qz5rlzm5XTe9lhWoYm/r3k++EaMIR0CKwf/btnqa
         I/pe6FTBT9bLAtX8L4e3FXrStlFseyYdN281Tuh4VkwHgkpGEYCdZOfFLNpsy7fz9991
         /Bg1SOgz90pkdvcmV/u7HxNBYixyuI/70OePSIVHybNoy57ycFLlzq1wSorW5+2mj2b3
         KAeA==
X-Forwarded-Encrypted: i=1; AJvYcCXgRgN/r5MNwNfWglQ8c/ZjcWgbHo3f2wdoSNDVaJBNUNFWHvdlALd+fS+xV7WPS+YZCRd6PL987zHJtykAdZbyGlQIC8xgN+I=
X-Gm-Message-State: AOJu0YxW8Q7uenjnOf7qLBGKwXQs5/bIluXfNPA7y+sTDZ5fp+tVZLcK
	8K8glHk4IhgZu4EBzWf+40CAr3njyYs8JcFibd5/zMm4D+IAZymojYc3tQij63g=
X-Google-Smtp-Source: AGHT+IFhhN8xRiKysJz9yh+YWrRmeS+J61zYNRg7UrNyD378nQHiFE0BdwzdB5Rftl36tM+2fx7dJg==
X-Received: by 2002:a17:907:7ea0:b0:a77:e0ed:8bb with SMTP id a640c23a62f3a-a7ac5075320mr437613466b.42.1721992724587;
        Fri, 26 Jul 2024 04:18:44 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab233aasm164703166b.8.2024.07.26.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:18:44 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Google-Original-From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 26 Jul 2024 13:18:25 +0200
Subject: [PATCH 3/3] dt-bindings: Batch-update Konrad Dybcio's email
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-topic-konrad_email-v1-3-f94665da2919@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
In-Reply-To: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721992717; l=18097;
 i=konradybcio@kernel.org; s=20230215; h=from:subject:message-id;
 bh=eooUCy7cgdlKNssM/JCAsOy3YbfB6M7AKQ74WlrJuBI=;
 b=TG0HCsiq+Eu65Km+iH2B/s2bq6jQNCShW2H8UW/DrA3msau6K5bnktbZuvNZ6lzxiIj74XrC6
 BRazGxMJ6HWCxn3Q8CXtNK0P1QGWNG2+hRemOsBgoTm+cIvPAsxpvjH
X-Developer-Key: i=konradybcio@kernel.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Use my @kernel.org address everywhere.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml            | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml            | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml            | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml          | 2 +-
 Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml     | 2 +-
 .../devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml      | 2 +-
 Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml    | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml    | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml  | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml    | 2 +-
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml                 | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml        | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml         | 2 +-
 Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml         | 2 +-
 Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml         | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml   | 2 +-
 24 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
index a584b4953e68..46403b98411f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Display Clock & Reset Controller on SM6350
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm display clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml
index 6b9c1d198b14..10afe984e2fb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller on MSM8994
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml
index a5a29dc75ae1..1fe68e07a2b2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller on SM6125
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml
index 2280b859b2ad..78e232fa95dc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller on SM6350
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
index cf19f44af774..4ff17a91344b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Graphics Clock & Reset Controller on SM6115
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm graphics clock control module provides clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
index 374a1844a159..10a9c96a97b6 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Graphics Clock & Reset Controller on SM6125
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm graphics clock control module provides clocks and power domains on
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
index fd6658cb793d..c03b30f64f35 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Camera Clock & Reset Controller on SM6350
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm camera clock control module provides the clocks, resets and  power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
index 183b1c75dbdf..3cd422a645fd 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Display Clock & Reset Controller on SM6375
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm display clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
index 147b75a21508..de4e9066eeb8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller on SM6375
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
index cf4cad76f6c9..d9dd479c17bd 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Graphics Clock & Reset Controller on SM6375
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm graphics clock control module provides clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
index 46d1d91e3a01..5c2ecec0624e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SM8350 Video Clock & Reset Controller
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm video clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
index 3c2cac14e6c3..d10bb002906e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Graphics Clock & Reset Controller on SM8450
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm graphics clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
index 8e8a288d318c..e22b4c433fd0 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SM6375 Display MDSS
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description:
   SM6375 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
diff --git a/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml b/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
index 2399cabf044c..dd614e077bbf 100644
--- a/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
+++ b/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ASUS Z00T TM5P5 NT35596 5.5" 1080×1920 LCD Panel
 
 maintainers:
-  - Konrad Dybcio <konradybcio@gmail.com>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |+
   This panel seems to only be found in the Asus Z00T
diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
index 191b692125e1..032a989184ff 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Sony TD4353 JDI 5 / 5.7" 2160x1080 MIPI-DSI Panel
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   The Sony TD4353 JDI is a 5 (XZ2c) / 5.7 (XZ2) inch 2160x1080
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
index 9fce7203bd42..78210791496f 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
@@ -8,7 +8,7 @@ title: Qualcomm RPMh Network-On-Chip Interconnect on SC7280
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   RPMh interconnect providers support system bandwidth requirements through
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
index 6c2da03f0cd2..100c68636909 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
@@ -8,7 +8,7 @@ title: Qualcomm RPMh Network-On-Chip Interconnect on SC8280XP
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   RPMh interconnect providers support system bandwidth requirements through
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
index 3cff7e662255..300640a533dd 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
@@ -8,7 +8,7 @@ title: Qualcomm RPMh Network-On-Chip Interconnect on SM8450
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   RPMh interconnect providers support system bandwidth requirements through
diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index 571e5746d177..f8cebc9e8cd9 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies legacy IOMMU implementations
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   Qualcomm "B" family devices which are not compatible with arm-smmu have
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
index bd3cbb44c99a..e75393b3d196 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. MDM9607 TLMM block
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MDM9607 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
index a4771f87d936..b262af6be97d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. SM6350 TLMM block
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm SM6350 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
index 047f82863f9b..c11af09c3f5b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. SM6375 TLMM block
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@somainline.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm SM6375 SoC.
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
index 7afafde17a38..61cf4fe19ca5 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Resource Power Manager (RPM) Processor/Subsystem
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
   - Stephan Gerhold <stephan@gerhold.net>
 
 description: |
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
index 9410404f87f1..ad2dcc39a5f5 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. (QTI) RPM Master Stats
 
 maintainers:
-  - Konrad Dybcio <konrad.dybcio@linaro.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
 
 description: |
   The Qualcomm RPM (Resource Power Manager) architecture includes a concept

-- 
2.45.2


