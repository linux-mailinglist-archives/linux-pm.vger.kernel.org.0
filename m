Return-Path: <linux-pm+bounces-11573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313C93FCA3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE59281081
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63976186E46;
	Mon, 29 Jul 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcVWm2xA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE401862A9;
	Mon, 29 Jul 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275274; cv=none; b=u8r56SkYZzGe9C4/dEvsUU2lRNcrSkR8pWIi8wR81SSJdtvR8eRNlEYLmRT0uoHMxL3xHwrbIHYm5W99HzTyLXXIORejLs0rqgotgAPX2UIoLeeii3hsZxXDTR4JA3TPkxMPfy7If8SF9C51mLuRdyMKBM6tp4Xa/XO42pyUMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275274; c=relaxed/simple;
	bh=yzTgncn3XdYXI4m/F4375wxDu8sKiX7IBaYFauYToLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQkpD26xJXfG13EV431+abQBJqHwb+Sh/DVUAUluwog4lAhEcIXhlPId0ftmDG+SAFRPgX37lWQWq2zFHmnIjTK+Pxu43zPn8/mzpJKxfPM3jnJjIkeDaCUNPYiHo84/OHLdud8zmwXA1eR/MvnWNlq9dfb8aHrtgW3vGCSUGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcVWm2xA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso17688435e9.1;
        Mon, 29 Jul 2024 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275271; x=1722880071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8A9U9U2zXyxIhJ8IYiTm4hZOre3ql1iZbJoL53+qxY=;
        b=HcVWm2xA6Xha67GRBseynmNiueQjD4MQMYxQApxCFrt5BhSeEUSFryYTbvJahAJ6nX
         q01Ei32sdCyhwJ0rqIXN9hBPDe8bU79MNUJOPNXx/dWhlJG8SvfDZw1Fqm0Xhpp28HuK
         nLbqWr4YMvpDs1wHkIgH7Lydc1nHc3KL61XQM7lD5jEuQ0dWnuRI7FDhFUr5nh4jGnOf
         mtHxDzHMVoHu56EGq2ECJ/WM5K63kOo+YYQBqUixYdIZ7sspcIb3kqYrrUe8Ga+ZtXy6
         Ue/Dgic0+VqMHfYABOMQaMRLl8njf3lq91Viw8rJMqwHsjWWN1NLkDG5aLHzisfkUoP8
         Sk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275271; x=1722880071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8A9U9U2zXyxIhJ8IYiTm4hZOre3ql1iZbJoL53+qxY=;
        b=XjXO+s4Q/1BldcPBAqFrvZqDrRdNflLBpuMEsQN+G+CmA1GsJ8OL0colSO+xSpJamp
         cCviiPaIZqP+qKJsOsbGlji5Oxh17orfWL2odSgQxtgMFHvSwKvln84uhUsKVH26toXE
         y7qhIjpoGllXRylFMllHk4GolcyvsNzFgGCX50jQ6QExs3ARy1o4f+z8dMx8W0Ii5xad
         DH9ICmnPWluD/S3FvwJzPEZm0eGJ0HgAClXB1JcHJKAKTV4jxK7g3U6ViW6p+Q5KAXCt
         yVDfgF6FdTpROU4F9JUvYY5JHIByI6IQ9FGjZBh2GHUzH4KbNiDxR18OPc/C1gDWPzlf
         9R5w==
X-Forwarded-Encrypted: i=1; AJvYcCU0vWj4SefTrEKLbel0Mve0xb2Phz2R8YddwFOrVt+gPOjurlCvYhKydFG+Bb0LP++MJ7jd9Kzzem++ODf9ndwIaVqAeMedAEvhqEbBm2erCDFQlg+72MhnjoZxaSw7uVfH+L+lUvb5GPI9QMTcodCYgOwTytwurjbB8rijCQeuFwHAtQMKz9pHec/ZQVnBU3Z3db9lRLJSa7Ewt9tAG3CPstto5HQ=
X-Gm-Message-State: AOJu0YxIDsGthF4GoysJ1Ni1qUP09wuDyiMWbbAcmCmBDMsYe3o/lO+T
	6Oe3ccAWZAdMVVnjDe03Iz+eP5MJo/XRMYS8vQuWRsqA0BN932Nx
X-Google-Smtp-Source: AGHT+IHPnUSYUUKoKD1giWKdNsD6VWlt+JEHo0COx0IE3UNhdpfTFufcmAo/Dq8KAy3Q7SNPCquEfA==
X-Received: by 2002:a05:6000:1187:b0:367:9b22:28cb with SMTP id ffacd0b85a97d-36b5d0cd7fcmr5073453f8f.59.1722275270802;
        Mon, 29 Jul 2024 10:47:50 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:47:50 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:36 +0200
Subject: [PATCH v3 02/10] dt-bindings: power: supply: max77693: Add
 maxim,usb-connector property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-2-02315a6869d4@gmail.com>
References: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
In-Reply-To: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=yzTgncn3XdYXI4m/F4375wxDu8sKiX7IBaYFauYToLo=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W+sawbz8cJ5RE6MNrwl6jBilwZCozFV9tWJ
 UhRapd0AtSJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvgAKCRCzu/ihE6BR
 aLXqD/9tfY6O+3BaP1LQ5Y1zm9dJLXER6C0JByIsD7IiDknaYifkHoUQgeCtx+xOYkUv6EkH/Jd
 u0glo9QAhhR33VMkoHNaJmO6ZXxwEpvabNWr8HvAeD+xoKVCjzoURPElsTtJkQPSD7W8Aw0Fz+6
 NHxC/xitsseduCLoi+smFnVSFTc/YdmCxCFKJaIvFFKeWlD9i5hC5vh4U0bgxTWB+1NCRPJZmTE
 lE4ZoQi86w3PjCAFJ2iK1N4RKTtYcGZzMl5P5ijkJz2mYhEXJ/bqrv7UyBdc95AtUC6ymPqRyND
 0+17UT8xFVVWp/Di+3JQiaSQBMUoScQBcJunU/OMra2gN+lneZHooOkm5eBgR/YGcUGhJdDyzjl
 NPB5w9oOtQo89mDsQqiIZzqbzC3mvQW4LGPW4ssdoCVnkyH9dM57Fn66njrf9eQSbmVjTACCFKB
 lGaatkEadZOPSr8M6aQ9V3svNQz+Rzd3bTpx4XGLbfS9DqoGupLI416BtGe76CL7p12ojxmxa1J
 /l3bjbIDnPCc7kzW2ZjF+UrT62gekq3NuccuMje3tlLjvNDwsH7LDYQYFKkJbT06ZT05pZuk6en
 9pYe8uBO0ydaffRAR4M8jD0OqjGI9p/QVN0xSaIFKmDbJNV5rIy8vm0/B80NlANNPU/H3s91Ves
 4OUXGKYFzxD4nnQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Allow for specifying a USB connector to use for charger type/OTG cable
detection.

The way this is done is inspired by the rt5033-charger implementation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
index 2f4437dafdc0..b70c171bd4b9 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -73,6 +73,12 @@ properties:
     enum: [4300000, 4700000, 4800000, 4900000]
     default: 4300000
 
+  maxim,usb-connector:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      USB connector to use for charger type/OTG cable detection. Phandle
+      to a USB connector according to usb-connector.yaml.
+
 required:
   - compatible
 

-- 
2.45.2


