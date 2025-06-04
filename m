Return-Path: <linux-pm+bounces-28094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF0ACD989
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEF41892CB0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AE28C5B5;
	Wed,  4 Jun 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gx8HQNdP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524D28C2B4
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025152; cv=none; b=nOARy1rU9QxulCsxXCRwODkCW80qS1hJiVeCArFWFzg2JTxpOJmR1aeyLx4G/fwKfKkFdtR3OcTp+dCTJ2SN9cHVGStcGGHxxDlDwicZksQPfcQ5NeU3iwagbnEJhVN4e5c4T7DN48jKWxYl0oW3vy2y1wAGLUqBCWsgkK0/6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025152; c=relaxed/simple;
	bh=UTeNsNR6bkd9E6kagWjp3E7mLctc/FLUKCEhhW/eFAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHO0r+WrQ8crfQV1cWu6Hlyizn6jqNbCsMn6AffJsEHGHNCclG3fRMWlaQ7DSoU0j4shHBU+LqzYpcvztktnkbuup4dhN9g0IU/FArH5rI/r3XQCdw98X0fJA8dBAhlRqvz+R6CYtA7/gAuXmlLh5w0n0zTlT8tbX0FuQEXoW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gx8HQNdP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a51043228eso334563f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Jun 2025 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749025148; x=1749629948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03dY5vQbZPme8BEDwalWCSn5Z4C2mE5vvXX1DN3LMjE=;
        b=Gx8HQNdPqUm1F9FMWLv5XRjZenCB8lQYU6TXXh/m2EAgwdY+yC2bh+6owZZR+T537l
         j6Huz8sVc7JH3bX/EJYwRMOCmSO4MpOeXykJy2N2cN2Haiy562rJYpZNFC/Lklhfs66P
         daWOQCckC0CTLxsWlvncdSyKSSVxskUGkmJ2yx9uRq5lvGsbMGz8J8eDSNVFsFuJinfQ
         vI/FSKH9PZuTpUExHRWUaJr/hSZcNIGvdKaA8qP7c/XudngN/A8P6tqIySJeIjmnhQ7C
         gKCIPu3dndE1IHVfPRDsd1iGVHUx66NcQuvUKgqhWnZPaqB0QE7b/Td3sp3EmPZHJLL3
         +bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025148; x=1749629948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03dY5vQbZPme8BEDwalWCSn5Z4C2mE5vvXX1DN3LMjE=;
        b=FJOI0P+1i9bU9wRzORXwh3xODHAYFyLUhfT3qwyP0x5xyrSdjZ22ZjDnEdszDYx89/
         BO7TmqkRsLfDEtyredIesmA8j16iYOtSorsrlkfI2a67yinGo1iBnN18ot3JVr1rw9Zl
         l8nGOY8AAQ8XO1aPYYdL/9ln50bS3VbPCOjr3vyNlGpU6Wy4WHuH6e0gT65i56ETiUZi
         HQ2oHZST4032NR2kfxmIsDbbGAPwaEHgNiZXG3FghAiqRhP5es8efpb/aoX1mqhB9HL3
         8gIeovamdUNq2N0mEVmpE0ftZ7ybP7o6QOQQ5JDYtOijuk4GoGWZg7ib/k6q35UqgO1K
         AU7A==
X-Gm-Message-State: AOJu0YxtwmKc8ogVScoPevKrAuvbFeZIAyditWwpchF2MPBre/UYBqy9
	9DRAZdadIz5zC2N1c0bFki4F2X0fLtG99N7yOPXKVLgSg2jfzkfpzg4ahye1Fmzeqv4=
X-Gm-Gg: ASbGnct6m7+OP6JQBgo6KeX2a6ShpjyIvwjzndgnaN/AF9A7Z4WRh29pL35L3MFXHT7
	4G4KcyDTTshm/T21/CU8CoeRoUTUDn45EiBTqk85k+3XoZgA6OtO575CgnCEyEv1yANLAt6WR7t
	MYx2b03X3RUEl0+YGzRjkcGv5sdXaJ/pFwjN0LMp4+D85xDmsuiUmd3ignhq5tQOAj1cmpK4eXg
	nz7xjmiOqdabhiciMdvuA+2PdIsn8FqcI6uvHM67AGgOVC3afcRmwEcU89QHSnTpqijnmkV5D8F
	o3JSKC1ALfOFY7D3U2Qo5WbwWHUuPjDLAczc5eIIQIuKkvO7yYn/1x4DQ94Ck0UTiojSZThk+TX
	dQ40sOD6w1bTSOCFAf4mhTZxdSgQPASRj
X-Google-Smtp-Source: AGHT+IHHygMD2m1sGCc1XUvuJeS4axXYh1I97rA7ITp9lqsk7sbKuQvWklULTIQpEov0harJwMy9HQ==
X-Received: by 2002:a05:600c:45d0:b0:43b:c825:6cde with SMTP id 5b1f17b1804b1-451f0a8beabmr5403075e9.3.1749025148356;
        Wed, 04 Jun 2025 01:19:08 -0700 (PDT)
Received: from [172.16.23.13] (adsl-84-227-104-5.adslplus.ch. [84.227.104.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm198301215e9.29.2025.06.04.01.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:19:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 04 Jun 2025 10:18:24 +0200
Subject: [PATCH 4/6] dt-bindings: power: supply: richtek,rt5033: Add
 missing power-supply ref
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-dt-bindings-psy-monitored-battery-v1-4-7f755ff75218@linaro.org>
References: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
In-Reply-To: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jakob Hauser <jahau@rocketmail.com>, David Heidelberg <david@ixit.cz>, 
 Dmitry Osipenko <digetx@gmail.com>, Tobias Schrammm <t.schramm@manjaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UTeNsNR6bkd9E6kagWjp3E7mLctc/FLUKCEhhW/eFAA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoQAFvbC2+7Zykw5D57QD64d4BWG2frpLt2XOZZ
 blm4g59vq+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEABbwAKCRDBN2bmhouD
 10Q9EACHf/JkDhi62QNqQhaRNVguZ+FPSdOvhfj2MLfnoceXwj3LEvWxfUYe7XoBIErDzOVDspL
 GnA4vRtBT7s9mpYRTXSYEY1tX5LmD0Hy+4WDlXP0MUdAovLW1nOzLQL5eg+VY1V6dRH37QZmshX
 53UcNp/8qWKmbqd+qjOxqd+EWz3nN48ySUfiakdSLK6m9FzaLaPX9qRw6iU88TVn4zb2QX0bm5N
 z/CXdgG2tmmTkCp3koRF//qAxIFCR69/66IMJMTW/ETnDrqRIOUZ7oIyqI8gkItZg/4nPUkmDTL
 cdCYudMlt96LIjgaytWfbqo7ywsaWfOzsODJC3g3iO+fMz9rgjke60ygNa/iHKbuSP0koYDPIOy
 KIq6EiCX2M5FDhGpd9v+Gl7tLhsEifMXWwq4U/C1mcz2Vd1yHOwdbpVbIeQ/pVp0f03qecXVcxZ
 SHIBOGHl5v2g/MphoWuuBQZkCBR+Nu0hdNnoc3s+QZpfmLUwpfBIAwsop/PfN0Lf10Dp977CtLl
 MyO1jRWjh9F+YiWQyNB9aiI5hrQrJv5LAbB9tW8AlE4Bk2PIZcBAhIbCMbzoJhMsfK1wlaIFINB
 g+s8uzr67ky0b6PqT+L/FqjX18pxy4TJoO3OaLA7uFyh4XA2PybW4/cmRd0UG2zLZQZk+R+IPL4
 NHmKlTcFiNzSvJA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Reference the common power supply schema to bring the definition of
monitored-battery property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/supply/richtek,rt5033-charger.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
index 5b3edd79a523ff7f8f04cadc425c208a63cd8f85..d91eced9f5fb0b330c91aa61e0be9aa6bee52ae4 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
@@ -18,7 +18,6 @@ properties:
     const: richtek,rt5033-charger
 
   monitored-battery:
-    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Phandle to the monitored battery according to battery.yaml. The battery
       node needs to contain five parameters.
@@ -54,6 +53,9 @@ properties:
 required:
   - monitored-battery
 
+allOf:
+  - $ref: power-supply.yaml#
+
 additionalProperties: false
 
 examples:

-- 
2.45.2


