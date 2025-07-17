Return-Path: <linux-pm+bounces-30975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC0B08584
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 08:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F983ACA18
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 06:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2FF218E99;
	Thu, 17 Jul 2025 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="EOaMkJ4S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A908219A67
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735304; cv=none; b=HjjXHZNohbDlkBK4W6s5DAU0RONAk+SkErtasRYDQYcQTbYKxrtKOZ61OGqw7IssLzGm2w+jNuJpn71EC1PRdBSLDi9p9zq7ELC1RpkSVNsTUoaxSZLMQFXSo1nCxIgwetVhxZlTtUrsojItFA7i/lOWCniZcCUvNm7+VCoR3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735304; c=relaxed/simple;
	bh=i7s0v0nCPikT/RlnCFQrGLw0cSeknoNVK1hgQ+6VOwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVhvFVU5ufVsLBMDq1/jj/VhWsNOz30guA5IwfPDjYUd9C2pDWYKuwXJx+zdr9QObiu9BhgoHwZW7eavjQDOnqgij4WIRU4zR7Y10WsMFYXWts2Ne3TwuX+VYO32e5ej879XbffYfqqsUuOmwZjytMZPsXh2KUR+Cq9UeKOaCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=EOaMkJ4S; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so1026840a12.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 23:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752735299; x=1753340099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRgWywsYki9+S7u+IaQYasfESPXgRzQ8YgLBcuyvrqM=;
        b=EOaMkJ4SE8r9jo8n/Z7rgam3sG0VQX3OmjwGnXQmbYfJv6nz+1+lxWQFRxO0Ke/nxf
         3SCiKW1yiGESaMuLGtz3hINyAykNLoYzXleZ1RALPNUCFazEoNyxYiUfJOfJ6G4muFOY
         SaMLB5eqQvyG4HnJQehpeJm0S+Cs8hdvs6+M9YqRXZEKPJ7ud1mgRTVe/ZAIR1XM1MtL
         e7jVnlE91qWzxegrI758yIDEub0B7l8N2F1XiTp/cPoYLMxTVXbmtbZOG5SlWNSqYcj7
         IR2geoac5QQMUkt7wI7HMI+ub42ckKG7GL9VnKOY8oJAH9HIDdO+UOXbI6w6KjSYDAPp
         XrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735299; x=1753340099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRgWywsYki9+S7u+IaQYasfESPXgRzQ8YgLBcuyvrqM=;
        b=tbNUeYXCnpsKmxjx4hEDhjEQjDEQpBGZbAqPe6SWqcsRq8gL/MyohIH5i5EMm+lxSV
         AJXCCSB+n+U1AsyXZiTuMb3q6q57+o0bOJQXo3FpkXDsmUxEm0nAOH1d5y9tuWlzs/Fo
         BmBcx/XPu2y6NZ65ixj/Dtdh6FY119y16kYJwRgI50apDoxBwm/rJCaYV+wCTKA8vygU
         z9pi6ECtevr4QM4T/AWczh1e4N4GCQYnPbYVz9/kPMAW1m+VhaERcMHMK0qbuN1Fkrd7
         C50pNzMOGneUA7xelAqQipaJpdhubFSdWdhKBeavSsZrBbFMz1nyf/Mnm0nrfIg5bOWf
         qMFw==
X-Forwarded-Encrypted: i=1; AJvYcCVDgHPN7JkKz88uZV8jP6EDkDmQT8vTvi1actgP2LStE1YWk8CFf2XrK2ytL8kjCCTSubmtpQTnhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw521t2WqM6009TxIPlruKPMN/iJTxXYR3LpTrD1w+YRGYl9tNy
	luvN0bCn4FEnjeXU0Y90mMKxpDi5QPFggtnKjsfzLeDHlF6X6ZImtYoiU9wUeFsaJCA=
X-Gm-Gg: ASbGncvexsXQT8tnRAx5P0xANSEsJjboCGhqLfQAFJurwZ79M1fOE8RkUrqNOnlKNZZ
	Gxr/xCgjGSCgjvfrfP1m2u7rsrjy0Z1pOl3yy6+0PQLBd1SwfG/zFPtg0H1kyvIYkhu5wAJTgGG
	W0tNfbpRIMqgq5wM5fZa3Tz2Lpo9HuNNJAS0dQcO+HRJsEnVdnLwo8i4I8SlI1iXfUZ7RepsqNk
	/+f9J90qZIivKTko4dYoYYYSwLeR48pWkN9SH03BY6ndR8yAcJTRV7d5rySrVSWgH2KdBosvux7
	6dgflBJJCjZMZRY8wn8QIpsWiOkSBnW+VL4eAhxyUA6uavveaD5uQyvzsyb4R0O3EDxXBPVuT8L
	Glw5BuuqYKxF7GI8+pglW0UCEvARDNOCMuyPMS1pVofACkDxy7fOzTOFz+2tWPvymqYuf
X-Google-Smtp-Source: AGHT+IHunSuz4FAtGbYOqlprTaq41FVAvhhEoOa8rvlRsvBGymGK6r/HCrFJkvg90ZjN2mF4yoaoNA==
X-Received: by 2002:a05:6402:2353:b0:612:b548:46d1 with SMTP id 4fb4d7f45d1cf-612b5484ad5mr210934a12.7.1752735298891;
        Wed, 16 Jul 2025 23:54:58 -0700 (PDT)
Received: from otso.local (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612477e1d2bsm4688882a12.34.2025.07.16.23.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:54:58 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 17 Jul 2025 08:54:44 +0200
Subject: [PATCH 1/3] dt-bindings: clock: qcom: Remove double colon from
 description
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-bindings-double-colon-v1-1-c04abc180fcd@fairphone.com>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
In-Reply-To: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Martin Botka <martin.botka@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robert.markoo@sartura.hr>, Shawn Guo <shawn.guo@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 krishna Lanka <quic_vamslank@quicinc.com>, Iskren Chernev <me@iskren.info>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Ajit Pandey <quic_ajipan@quicinc.com>, Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david@mainlining.org>, Jens Reidel <adrian@travitia.xyz>, 
 Priya Kakitapalli <quic_skakitap@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752735293; l=44620;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=i7s0v0nCPikT/RlnCFQrGLw0cSeknoNVK1hgQ+6VOwk=;
 b=7wKc/FLpZQ8dN1w0Sd+s4CdhRMvR9bA+XNpvF9YimDnsKJQOlf95Knu0tCjvmkjBtMo3uyl+F
 Y8p4jd+3AEsBNOhvQYh9NVp9xD5u6Ia+iFUh2nNtw0A/3qssIG/mLi5
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

No double colon is necessary in the description. Fix it for all bindings
so future bindings won't have the same copy-paste mistake.

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kernel.org/
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6115.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8350.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,qcm2290-dispcc.yaml     | 2 +-
 Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml     | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml     | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml     | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml       | 2 +-
 59 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
index 3fd3dc1069fb170532fdb37a3cacc0fee057f565..5c3ff37ec0d75b3dc8947b62d376bb6bd28df2dd 100644
--- a/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,camcc-sm8250.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and
   power domains on SM8250.
 
-  See also:: include/dt-bindings/clock/qcom,camcc-sm8250.h
+  See also: include/dt-bindings/clock/qcom,camcc-sm8250.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
index 0a3ef7fd03fa40cdbb1ff11d2d2cdf6ecec81bc8..ef2b1e2044309ad00d95ae03f3f372296e7d53d4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks and power domains
   on SM6125.
 
-  See also:: include/dt-bindings/clock/qcom,dispcc-sm6125.h
+  See also: include/dt-bindings/clock/qcom,dispcc-sm6125.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
index 46403b98411f81d6d136d8c9e5602095b72e0e33..a602e882e964e39d2e9b1d012e5d803b6568690a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SM6350.
 
-  See also:: include/dt-bindings/clock/qcom,dispcc-sm6350.h
+  See also: include/dt-bindings/clock/qcom,dispcc-sm6350.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
index 012048921f92e43a78a2606fe63594a36932a947..c91039dc100e19a7c105ea7d210cbc38864e37aa 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
@@ -15,7 +15,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on IPQ4019.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-ipq4019.h
+  See also: include/dt-bindings/clock/qcom,gcc-ipq4019.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index 38b9e42839004158deed1f8eacba4ddf660edfb9..00d7df75b3d6af58fafca9158b7b0ac53502e330 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on IPQ8074.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-ipq8074.h
+  See also: include/dt-bindings/clock/qcom,gcc-ipq8074.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
index cd49704dcb95a99a91eab2018465fccc571d77ee..92195091a91962941ebf24450610d6b72c24628a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on MSM8976.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-msm8976.h
+  See also: include/dt-bindings/clock/qcom,gcc-msm8976.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml
index 10afe984e2fbc1fd190b6cb901b0f1f5df43157f..93bcd61461e7b45f1710efb0fce70224405df36a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on MSM8994 and MSM8992.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-msm8994.h
+  See also: include/dt-bindings/clock/qcom,gcc-msm8994.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
index 013fd074a8d56f384561a885569253ea134a9c9d..64796f45f2948d08f1224b4a53715f4a0d90c252 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module which provides the clocks, resets and
   power domains on MSM8996.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-msm8996.h
+  See also: include/dt-bindings/clock/qcom,gcc-msm8996.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml
index abae658c0ed959bf05c752967da76446d8562de4..d882f2b6620ee4f89ce27173480ea47ab3e70cd7 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on MSM8998.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-msm8998.h
+  See also: include/dt-bindings/clock/qcom,gcc-msm8998.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml
index 38c4c8c61b3af6478960c79128421930fa51c9c1..b9194fa11e47526b65f62096bc0483ef5a8d3830 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qcm2290.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on QCM2290.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-qcm2290.h
+  See also: include/dt-bindings/clock/qcom,gcc-qcm2290.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml
index 94755465c1fb42a472e0cc80221b4fe7318b70e1..6b35a3c080a2625c32538bf5e1cb22af8c5cd897 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on QCS404.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-qcs404.h
+  See also: include/dt-bindings/clock/qcom,gcc-qcs404.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
index 1847bbeaa9d1852379bb9ff8168121e70ef50ea7..e30d1df3eeb50bb3829af3a8176cc08f0335283d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SC7180.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sc7180.h
+  See also: include/dt-bindings/clock/qcom,gcc-sc7180.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
index 4e4f68b9f6d2802774030d652a26ce14e053aa4d..5ddaf27bb1f4b1d3c2a3e1b27a5c88e1d91967de 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SC7280.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sc7280.h
+  See also: include/dt-bindings/clock/qcom,gcc-sc7280.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml
index b4784ecaf58d2f1c360c2e94cef681b26c308b2c..82c2ef39934d1ab373d9e4119c3aade544c873c4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SC8180x.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sc8180x.h
+  See also: include/dt-bindings/clock/qcom,gcc-sc8180x.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
index 5cfde8a4de4e9a1275d53a0bc7aa0f01f47f304e..c1eeccef66b4528834ef12984a4d19822e8133db 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and
   power domains on SC8280xp.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sc8280xp.h
+  See also: include/dt-bindings/clock/qcom,gcc-sc8280xp.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
index ef0a20456e8a5a8a9a9dcb6af29766d99a283656..a7523a4143419fe19148e6a1ba9c5a8651935d13 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SDM670 and SDM845
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sdm845.h
+  See also: include/dt-bindings/clock/qcom,gcc-sdm845.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml
index 30819f3d85c621ac8326b706d76cd888fb907d2d..320e4f5b2b1806a4e218515de20826f255f2ecdd 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and
   power domains on SDX55
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sdx55.h
+  See also: include/dt-bindings/clock/qcom,gcc-sdx55.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
index 9154492286685f9b9ec7a6cb1ab1577888809adb..9242e6e191399c223c3cdad1100a6fb878a2c247 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SDX65
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sdx65.h
+  See also: include/dt-bindings/clock/qcom,gcc-sdx65.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6115.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6115.yaml
index ecb69c707f09b858a3e0c5936d34581077fe478c..c926630907c51ec971b2648a0430dea4a36a5f28 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6115.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6115.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM4250/6115.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sm6115.h
+  See also: include/dt-bindings/clock/qcom,gcc-sm6115.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml
index 1fe68e07a2b208b7caffe181328ddc26e09cd20e..5bd422e94a384994e165ab1725f63130a3f2dbfb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6125.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM6125.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sm6125.h
+  See also: include/dt-bindings/clock/qcom,gcc-sm6125.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml
index 78e232fa95dc603b58848b45ffd2fc79b32577c0..819e855eaf9af04ca86361c6b73e7a561b6b52f1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm6350.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM6350.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sm6350.h
+  See also: include/dt-bindings/clock/qcom,gcc-sm6350.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
index 1dcf97c0c064ed56cb249846a0d6f7b032cb3d2f..5f3f69fe9ddbed545a84c86f4e2429611c253a6d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM8150.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sm8150.h
+  See also: include/dt-bindings/clock/qcom,gcc-sm8150.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
index 979ff0a8bf6868068c11dd15db764c6708489d86..f4cd5a509c6053eaca45a8e1009921f663d81571 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM8250.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sm8250.h
+  See also: include/dt-bindings/clock/qcom,gcc-sm8250.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8350.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8350.yaml
index 594e87f5ba092af66ca029fdb399db48fe14875d..97ffae3b55227d1b0d2523f03e3ccc0bfd1a40c9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8350.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8350.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM8350.
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sm8350.h
+  See also: include/dt-bindings/clock/qcom,gcc-sm8350.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
index 77273aee5d52d63996b19490bb5ed15ecf96d013..3169ac05e1d8ac704566d36943e9cf35b4674ebf 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM8450
 
-  See also:: include/dt-bindings/clock/qcom,gcc-sm8450.h
+  See also: include/dt-bindings/clock/qcom,gcc-sm8450.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml
index b9b218ef9b68d21ebc7c55a731c9911bb57c9e46..374de7a6f8d9f56f3619b2704309686fdace2beb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm graphics clock control module provides the clocks, resets and power
   domains on MSM8998.
 
-  See also:: include/dt-bindings/clock/qcom,gpucc-msm8998.h
+  See also: include/dt-bindings/clock/qcom,gpucc-msm8998.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,qcm2290-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qcm2290-dispcc.yaml
index 243be4f76db3b69b522408ad56bde877ace9e728..4a533b45eec2d8e7b866c3436bfe6f80fcd714fb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qcm2290-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qcm2290-dispcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on qcm2290.
 
-  See also:: include/dt-bindings/clock/qcom,dispcc-qcm2290.h
+  See also: include/dt-bindings/clock/qcom,dispcc-qcm2290.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
index fd21df0e76976e6fecd32db5ee4a5eeec2757083..3038307ff2c5c4baf2c72f1a1c471bae63693eac 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm ECPRI Specification V2.0 Common Public Radio Interface clock control
   module which supports the clocks, resets on QDU1000 and QRU1000
 
-  See also:: include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
+  See also: include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
index 86befef0265061b849f6633ccf82b0f438b324b2..2c5a9ef4fe4d3b620cd845615a392000c0269dfc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module which supports the clocks, resets and
   power domains on QDU1000 and QRU1000
 
-  See also:: include/dt-bindings/clock/qcom,qdu1000-gcc.h
+  See also: include/dt-bindings/clock/qcom,qdu1000-gcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml
index addbd323fa6d7650f57866650bda655f3077bd8d..c641aac8c451e4ab69d3d6933636498421690eab 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sa8775p-gcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and
   power domains on sa8775p.
 
-  See also:: include/dt-bindings/clock/qcom,sa8775p-gcc.h
+  See also: include/dt-bindings/clock/qcom,sa8775p-gcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
index c7fe6400ea13b1bd53cac591e0da06b0715d0ddc..98ee9be84794a35f773a4aa92a9a028e4762ef70 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and power
   domains on SC7180.
 
-  See also:: include/dt-bindings/clock/qcom,camcc-sc7180.h
+  See also: include/dt-bindings/clock/qcom,camcc-sc7180.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
index 0d8ea44d8141a61bf2e7fe6da06f4b56aed794f7..f147d06ad2ef6fcc418d4d9efb6f37ab79526f17 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SC7180.
 
-  See also:: include/dt-bindings/clock/qcom,dispcc-sc7180.h
+  See also: include/dt-bindings/clock/qcom,dispcc-sc7180.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml
index fdfb389083c10cfa12ba97101356556ed838c82f..ad360debef7cd447f656be3b568fd851f785c243 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm LPASS core clock control module provides the clocks and power
   domains on SC7180.
 
-  See also:: include/dt-bindings/clock/qcom,lpasscorecc-sc7180.h
+  See also: include/dt-bindings/clock/qcom,lpasscorecc-sc7180.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
index dcef8de3a905ad7d2668fb847dc3560c697d6ee0..2f28be58e82e09dcc631fa06d48aab6eb132ee17 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and
   power domains on SC7280.
 
-  See also:: include/dt-bindings/clock/qcom,camcc-sc7280.h
+  See also: include/dt-bindings/clock/qcom,camcc-sc7280.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
index 23177661be4030b8f540e0476c4d7ff144aa104e..95b1e4f48c4f3eb41498264ee24940468ed4285b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SC7280.
 
-  See also:: include/dt-bindings/clock/qcom,dispcc-sc7280.h
+  See also: include/dt-bindings/clock/qcom,dispcc-sc7280.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
index f44c5c130d2d8a1704a01d1ca2d6d984fcc759a3..a90961d8656ce6bb7928d034a026d8b53c98b3d2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm LPASS core clock control module provides the clocks and power
   domains on SC7280.
 
-  See also:: include/dt-bindings/clock/qcom,lpass-sc7280.h
+  See also: include/dt-bindings/clock/qcom,lpass-sc7280.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
index fa95c3a1ba3aa31589658d99cf870e44db034d08..6214e41eec1fcc3d7eba3f04bad2cfcbd00d9511 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-camcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and power
   domains on SDM845.
 
-  See also:: include/dt-bindings/clock/qcom,camcc-sm845.h
+  See also: include/dt-bindings/clock/qcom,camcc-sm845.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
index 220f4004f7fdcda4e3e14cf3f98b7e2b685a9f58..854c391c83076a9e7ab67bbf0bec6fd9797133be 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SDM845.
 
-  See also:: include/dt-bindings/clock/qcom,dispcc-sdm845.h
+  See also: include/dt-bindings/clock/qcom,dispcc-sdm845.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml
index a96fd837c70ae1b1c54fc7de7ad83be21cdb2101..f9feb7049b214ca83e3e81ac87a490948c753349 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-lpasscc.yaml
@@ -12,7 +12,7 @@ maintainers:
 description: |
   Qualcomm SDM845 LPASS (Low Power Audio SubSystem) Clock Controller.
 
-  See also:: include/dt-bindings/clock/qcom,lpass-sdm845.h
+  See also: include/dt-bindings/clock/qcom,lpass-sdm845.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml
index 567182aba30060ed018d512a4b0ae0aca0ee4ed2..29a0b29bcb81616886330846da526db38437a254 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SDX75
 
-  See also:: include/dt-bindings/clock/qcom,sdx75-gcc.h
+  See also: include/dt-bindings/clock/qcom,sdx75-gcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
index f54ce865880dedfb4bb7c38cbd39a6f5690cda31..0b340b2f3205344c7d80eb20b98b9a8db1215ecb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-camcc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and power
   domains on SM4450
 
-  See also:: include/dt-bindings/clock/qcom,sm4450-camcc.h
+  See also: include/dt-bindings/clock/qcom,sm4450-camcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
index 2aa05353eff17326b9f4234ac1c99dcd82a6abdb..378f05e5988c24f7e3c76a3d9977918cf5b0742e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-dispcc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SM4450
 
-  See also:: include/dt-bindings/clock/qcom,sm4450-dispcc.h
+  See also: include/dt-bindings/clock/qcom,sm4450-dispcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
index 0ac92d7871e12b70115a3830ce9545f0fc6b287a..9cfe859bacc939d62104fa3bcb24b175ebf82601 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
@@ -14,7 +14,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM4450
 
-  See also:: include/dt-bindings/clock/qcom,sm4450-gcc.h
+  See also: include/dt-bindings/clock/qcom,sm4450-gcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
index 00be36683eb5d7a64380ea8f63209196651882f1..b31424306f494bbed15af6bf4e4c1b9db9907b8d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks and power domains
   on SM6115.
 
-  See also:: include/dt-bindings/clock/qcom,sm6115-dispcc.h
+  See also: include/dt-bindings/clock/qcom,sm6115-dispcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
index 4ff17a91344badaf572b15f657f0c740ea1859b7..104ba10ca5737ee1ed94fcb2df5a38bda9c86d14 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm graphics clock control module provides clocks, resets and power
   domains on Qualcomm SoCs.
 
-  See also:: include/dt-bindings/clock/qcom,sm6115-gpucc.h
+  See also: include/dt-bindings/clock/qcom,sm6115-gpucc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
index 10a9c96a97b6a1390736f701488311670017d911..12d6f0cdbcd8d0acacd4d096affcf664cf1bb412 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm graphics clock control module provides clocks and power domains on
   Qualcomm SoCs.
 
-  See also:: include/dt-bindings/clock/qcom,sm6125-gpucc.h
+  See also: include/dt-bindings/clock/qcom,sm6125-gpucc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
index c03b30f64f359abd03e61a543522c81ce542e274..ba6f4c4d295e99abd1662619bc1b1bcf55f81293 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6350-camcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and  power
   domains on SM6350.
 
-  See also:: include/dt-bindings/clock/qcom,sm6350-camcc.h
+  See also: include/dt-bindings/clock/qcom,sm6350-camcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
index 3cd422a645fd876b9f834a6f8389160f5aab4bf2..519ea76cb0525feab977cf3aa1b8130f432c63a9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SM6375.
 
-  See also:: include/dt-bindings/clock/qcom,dispcc-sm6375.h
+  See also: include/dt-bindings/clock/qcom,dispcc-sm6375.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
index de4e9066eeb835fd8215c40fed58c4b2baa28504..66dfa72fa9751e7ee6b0ea2c9358f5b8efc82799 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM6375
 
-  See also:: include/dt-bindings/clock/qcom,sm6375-gcc.h
+  See also: include/dt-bindings/clock/qcom,sm6375-gcc.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
index d9dd479c17bd63956a43055e007c3a612ef5b569..3aad6b5bb1c507f68decb14e61b613bbc80cf14b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm graphics clock control module provides clocks, resets and power
   domains on Qualcomm SoCs.
 
-  See also:: include/dt-bindings/clock/qcom,sm6375-gpucc.h
+  See also: include/dt-bindings/clock/qcom,sm6375-gpucc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
index 7be4b10c430cdc8a162b2981fdc023ceeb02ca77..b96091c28c5a84c3ae6778db6e888ad7e0952022 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
@@ -15,7 +15,7 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and power
   domains on SM7150.
 
-  See also:: include/dt-bindings/clock/qcom,sm7150-camcc.h
+  See also: include/dt-bindings/clock/qcom,sm7150-camcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
index b8d6e1d05ce2fd2e15db597fcdfb34798aa77f7b..13ab3359b5927a484a1647c47290219ea631f343 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
@@ -15,7 +15,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SM7150.
 
-  See also:: include/dt-bindings/clock/qcom,sm7150-dispcc.h
+  See also: include/dt-bindings/clock/qcom,sm7150-dispcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
index 4d7bbbf4ce8affb29f3bc3c825162c644f701f35..3878808f811ee2bb9afa348198847fbd00d7c9cc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
@@ -15,7 +15,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM7150
 
-  See also:: include/dt-bindings/clock/qcom,sm7150-gcc.h
+  See also: include/dt-bindings/clock/qcom,sm7150-gcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
index 037ffc71e70e08d8e14e64fa2ac526665471e397..9f7928730386168b4f892c7a69ff2770fd0bae7e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
@@ -15,7 +15,7 @@ description: |
   Qualcomm video clock control module provides the clocks, resets and power
   domains on SM7150.
 
-  See also:: include/dt-bindings/clock/qcom,videocc-sm7150.h
+  See also: include/dt-bindings/clock/qcom,videocc-sm7150.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml
index 5e9f62d7866cfc816845e5cd3fc132894bffe5fd..a210ec9d820cb252735dedad98f39c663b477e20 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm camera clock control module provides the clocks, resets and
   power domains on SM8150.
 
-  See also:: include/dt-bindings/clock/qcom,sm8150-camcc.h
+  See also: include/dt-bindings/clock/qcom,sm8150-camcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
index e9123bbfd49109ef7196f80b2146e1a32d89ad02..bd131a1ff16583ad75272fdc4c0ba051112b1a4f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm display clock control module provides the clocks, resets and power
   domains on SM8450.
 
-  See also:: include/dt-bindings/clock/qcom,sm8450-dispcc.h
+  See also: include/dt-bindings/clock/qcom,sm8450-dispcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
index d83b64dcce4faa91b0fabb2e7ed3e595e59ac2ed..c4e9b9bb63f51bf2b09cc88c6a0513e4d5f128d2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM8550
 
-  See also:: include/dt-bindings/clock/qcom,sm8550-gcc.h
+  See also: include/dt-bindings/clock/qcom,sm8550-gcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml
index 976f29cce809c4a42393b202090813e2e39cf010..c7143e2abc80c209ddb455ff7263b6505cac4444 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8650-gcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM8650
 
-  See also:: include/dt-bindings/clock/qcom,sm8650-gcc.h
+  See also: include/dt-bindings/clock/qcom,sm8650-gcc.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml
index 28797d0c5d8db3527db985f324d7288b5175bd53..68dde0720c711320aa0e7c74040cf3c4422dda72 100644
--- a/Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,x1e80100-gcc.yaml
@@ -13,7 +13,7 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on X1E80100
 
-  See also:: include/dt-bindings/clock/qcom,x1e80100-gcc.h
+  See also: include/dt-bindings/clock/qcom,x1e80100-gcc.h
 
 properties:
   compatible:

-- 
2.50.1


