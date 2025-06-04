Return-Path: <linux-pm+bounces-28091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2FAACD978
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 10:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077903A4760
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A0128A1C1;
	Wed,  4 Jun 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uw26yLVI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9108524503B
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025145; cv=none; b=p7waDOe0nf7cSdbJWVYpPYQWE17p84koYZ6DI5W5/0UgjLXPLx35xDnSC9FaKG8Hf9QWVY0OxrhWjEX531YxJfdgYzFd+TK2dFUxEEsndzaIje483bkv8Y7dj4s5kDs8D80Kl5GEbeG+Sj//jy03jmBhhYogevSxMA0wVZsY6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025145; c=relaxed/simple;
	bh=fnrklUc1GaQcP7+Y33nwx3V12HO8N9hvE2hC2nnr3vM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1VP9mVoVjrS0oa2yw/wfGxqifKUdBaF7yxc6w/67uAD/PzFoMX3h+orv6ZbWh/F05DROAfi2vClqX5vowVZUmFOrcHyd+IXFmnXqNSWmPwNB56Ec3orgl6GatWhEYGOuj/qm1maqDJcBF1bG6sh8R9T6dOU232s//zeeB6ekYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uw26yLVI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f7865b22so721544f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Jun 2025 01:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749025142; x=1749629942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1A7uqqIlkBgkBqfkGTob+CBHXu+b8vRBZxoe7xNTFY=;
        b=Uw26yLVI0Pyv3LvXvbqh+s/ozzd9y52yqw/aJifsXcgWB+Am+uOLu3FcBWbj+eFYIp
         1rUtd17dLoTdEhzu17489qb6Og1I6uVQSQFFdAwd5IkkGFoi2tyL+RGaMr4vCPjdR5SV
         GPIyjX9dtmGgSWVCzUiIjnLt9mKJpJlOwahdBVuHV2JAbAwf/TYKHjoQsHzIx2iC4lwV
         XU8dcmpqSmfVOo682aKwpMGGBMFjjFAqk7KSR1pyp4gDPkvS4BTMbfZuXOCqBfQ6dNjR
         lfFihSVBzWPoCPI9keGya9EpDOGe3nH5D10g5mW+Tepq8p24PMTZcGHKAKKphCkVOcRI
         TbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025142; x=1749629942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1A7uqqIlkBgkBqfkGTob+CBHXu+b8vRBZxoe7xNTFY=;
        b=SbFyJUM+RIQCi/2AYiWw23tWIRYETxzskiS8Q7ash22T75mznGZ2P9b0qHtoMLMt7h
         Sx/CPh2Upl4RxOmkXFDLGJ40H9U2f82IFuJkC6qliCEdFYm+YGwlK3m9MAQvElEKkGIa
         L/XWRkXjxOz13vfeLoysLUSlm1843aBmnIkBQ8LsQ3Ruq1fd/KMkt92+lspDtvcx12Z/
         Sb+TVZQKj3cgBNzN522fMKMJuqswqpWG2JOgu7bY328b5KG29nPbHu/FflF+A/smzYod
         J3HlIjklOCt4H8j4+PBr7qHBDUgzkMulEPP5APxMjDwnQAVabl5KP1KwNjlRJQzKKlr7
         nz4Q==
X-Gm-Message-State: AOJu0YzT5WsVINmAnMYt5xEQemXF2TbvLbV4QCcGIWe0yx4kxSLYnzgv
	csNYuWPuxfA0vqNNZOwXwHewY46KwroLX4MhUqedR+iufH23jGjmElMwfRbQZnxim0o=
X-Gm-Gg: ASbGncsQJsGSPNXXWYPdl1cGxDZJMWXDlR/nkzzOq2l2HxX5LZfFvM/6XvtEcZSeEeI
	UCfagVVB3aKJMLImcTTBMrtkJ4hGvt7DMB3HcXQBFBV+/K0xC0STvXSbr+y+P5jNgvbC/NGcXiv
	CBuYw4LvD4QhfN6w8cUUWap1nmRF8jN84b6ZKUJL70p+MDsEghgmfB830f1Sd8S5eMdQahdLM8l
	jDctnsCppDsihfQZStXHVGib3R+X6KJDUFx+LgUlAVDrA99VUA37hs63ZCdRP9kJpjJ6W4Flbe7
	KeJ1L2m1nFab71yXupsnpi25DEy0TSapwChM4Z3Fzz5fZjRbJJbMAeHL94Kjln+jaFSJFfE7Ux+
	+lx0paFEwU2oSCj0jvdFmHHqY/5LE3QRz
X-Google-Smtp-Source: AGHT+IFl33lAuq8bykcXiyMLR4zVxs+LFHLZOCJVFEunT1CeWHb9HuZlkT32/YbozDTOSHCpdWPtlA==
X-Received: by 2002:a05:6000:22c2:b0:3a3:61ab:86c2 with SMTP id ffacd0b85a97d-3a51d91f3abmr475998f8f.7.1749025141844;
        Wed, 04 Jun 2025 01:19:01 -0700 (PDT)
Received: from [172.16.23.13] (adsl-84-227-104-5.adslplus.ch. [84.227.104.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm198301215e9.29.2025.06.04.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:19:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 04 Jun 2025 10:18:21 +0200
Subject: [PATCH 1/6] dt-bindings: power: supply: bq2515x: Add missing
 power-supply ref
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-dt-bindings-psy-monitored-battery-v1-1-7f755ff75218@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fnrklUc1GaQcP7+Y33nwx3V12HO8N9hvE2hC2nnr3vM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoQAFsK2uJDwRKj866MbW2yisjVH6lHSeXmCQYS
 ZBz/S6G+lqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEABbAAKCRDBN2bmhouD
 18duD/0cianVCYGb6f9fdarbJZrqFdXP5NHc/A5nhJxoGSv9cRRwWUutOI9ngdsz8HHb/k+w4/Q
 xIrkkcgQDfAU2l5J5RCM1GrxMMFOMRgaTwkvF+3TOoLCOxKwDUSiNtrTKeIIKug0XuD0Z4Ft1R7
 FvKJZ09QLCJKVtM/JoJx8QEjn290zJ2G9BNsbUoHb3f8gaKO0X2LdoTlu+dajzDrZi6fzS3Dg5l
 jI+NNz2sSv3cJMYGtoonVh26Ch9thdEqDxrv91+02A+EUiip1eVZ7xjIubyUH6NvnOHnM/REgnb
 vAZbvTZd5RJ4REx3pdWJKOA1uqmljRqWrwG5LUuIpZQvhNfd8tJxoIfbJkz4S5d1KFyMlpIeVmh
 XwQ7K4QHfbwzpxLPcoiqIvl6UAXx26iOEQrx54Z+XpQ2fVxA0vA0g4fcMOlKAWLq4VcBIQC6tYd
 UJ/qaOPlfI6Dh3GRzxocW+C3HpAbmYpAUORwHMaU+eTQ0PC7xUQIHhVSgX1KuBiT0CGXiwEbI1W
 8MshO5bLgbwG5Wp6Ij9MzVucrEnsiBk1T/OBT0w799AyJoEU3HiNSnQdInFojN7qmY6ff89CWpq
 y2wbQQxcPPWlSuHkUft6MMieqlynbc6TntB3FodMasnuVh+9UJyEOzdUNYwD477FCy8CwWmgez0
 XS1VPaClRVQ/8CQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Reference the common power supply schema to bring the definition of
monitored-battery property.  Drop also the obvious description because
it is duplicating what is in power-supply.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/power/supply/bq2515x.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
index 845822c87f2a4616c44907a5abaa1cc785be78ea..0e99a218e662b8400a15252fe601234bb51cd12c 100644
--- a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
@@ -53,15 +53,16 @@ properties:
     minimum: 50000
     maximum: 500000
 
-  monitored-battery:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: phandle to the battery node being monitored
+  monitored-battery: true
 
 required:
   - compatible
   - reg
   - monitored-battery
 
+allOf:
+  - $ref: power-supply.yaml#
+
 additionalProperties: false
 
 examples:

-- 
2.45.2


