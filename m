Return-Path: <linux-pm+bounces-17940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7A69D58AD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 04:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44E91F235ED
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 03:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30E1632F5;
	Fri, 22 Nov 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdmHw1LD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3A1632D5
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247261; cv=none; b=BJmp2THZfJALc6JfrGt94oPUXOsrBvlmfSrUbYhRH/jOUgmHXE1VQNjuzSCtXcrX6P7y5pcNtmFRq/uC/0OFcnr0BoDYIvHZ208LPQbRveDIARxKVUdVPi018uFyOi7BRy6UEnWLb9UjvS/cxGH3h7ADJLquo9r9rGIy0M3wxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247261; c=relaxed/simple;
	bh=ecrPWNCROGbCGBvflsd6cHirBTqgXm1cERWiLr23QUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juxcLa28IJZTfVqJgkHE7XSsd91nyB0M0CowG0dyp+URsW4BqALfbmJR2kVzxas7lpx9GLV0MCxJB0wef65jtZAMUKbQg2D1SZZMSVaIXdMhhYzdsQLE7Jy5pC/irkjv53LsBK8Ymhf6H3WLkoEQTWD/cttYqqmsk1nDjK1+vKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IdmHw1LD; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e60f6ea262so821217b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 19:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732247259; x=1732852059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knk5bhF5K5WlFtwhF1HiZTyghnwunglBtYROl19Amnc=;
        b=IdmHw1LDH0scOAYCc1DRfAjBzUnhQlq5yZlBpW0FW+m+U2XxbcY5RTVsLwuLSMTJsp
         ZxbrZc0ap8+3Baj+SrZ1s+e/tuGVGW+oySEslKmUmruAG0YL0l+h4X4hlEet7DbyHqTm
         7PEzg0S7k/9MGkarD6uiOVTr0IP8Gfas56EHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732247259; x=1732852059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knk5bhF5K5WlFtwhF1HiZTyghnwunglBtYROl19Amnc=;
        b=tIMdbO8ac7BY1Dm40Q5pRieWuQMQfQUIlecnlmZxM7DvXAmu9bJGyVe/N2CKU/2vjJ
         YRWbrjwytQwgC+oeB21jw0oWoOKo5MppWBFpf7Lmgv+5LUDsO2O5U182rOiMw9CryJ9o
         wr18N7buqSyewD+0mfs03TMscsOj2C0QynQfHj0YRJQPWmQZ9MrBzvHA+j6vU519c7q/
         /Sik9ZDaUtz3LWhFtGyQthAEGKPkBaH+YnS7j5PawZ7DSp8+dvPZ5LQHBiQZJMw6CHIf
         VDl8ycN+hN3ujtkr5O0dHwxFKOrT8MSjeTekgvu/O1z1qlZ09ti8bCDQ/6+NRxgkrpHO
         hsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Lar3Ks/SPM1K6z4szV4QirY/WOUZ+XntfxXf9l3z3CJ3l9i4pM7a4yhMQB6ojMVh/xtLtBnShQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtzAVlZf/GjXm7IzbDVkME8cVef0On5YY3fsTmQv3wYhxo2Ri
	mcGJmULMq46O1bWhgn9d7yU8iORHonYyiWHSOpC8FKcXPr+BhanbFTj8iShfUCLQgKs88fy4QfE
	=
X-Gm-Gg: ASbGnct0CyEghm9xaX3GOO3dSKTc/t6G8el0YIWwTam+29SUD+Afr8DB0d0n7OAPFoS
	cR6JhdmEVy4HBa3PXr0NlNcFPyEywiublSBrGvPrAHEEgpaXbwZwcqBqS85+YuGlDi7vZ56JIao
	j7x/OZNIXiQlwBRkpB5nneu39ZxYMrY4qMaqFMP1UI620Y8TDrcShgHvDlxgBsiirZ2SMRm8u29
	UvVn1SZcsfgbBCEvmxPhCEqSM0DDueglWYhdaFA7oHzbYj22ge17aJ8vwX40qoLEcs6ODQ=
X-Google-Smtp-Source: AGHT+IG9TmutnyL2idfCzGrxIgPrFSPj4hupzoYH5zYY4fJEibqFwqT2kUZnaPO1+nOzBHXjr0fcdQ==
X-Received: by 2002:a05:6808:3186:b0:3e6:10d1:ecb6 with SMTP id 5614622812f47-3e915afc2f0mr2042657b6e.28.1732247259232;
        Thu, 21 Nov 2024 19:47:39 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:533e:26bf:b63:973a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de554b11sm550174b3a.133.2024.11.21.19.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 19:47:38 -0800 (PST)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Fri, 22 Nov 2024 11:47:22 +0800
Subject: [PATCH 2/2] dt-bindings: mfd: cros-ec: add properties for thermal
 cooling cells
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-extend_power_limit-v1-2-a3ecd87afa76@chromium.org>
References: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
In-Reply-To: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732247251; l=873;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=ecrPWNCROGbCGBvflsd6cHirBTqgXm1cERWiLr23QUw=;
 b=+Ar7fFL4Es6YoP98iJ8z+ts7PPhZxkPpxs/twgJcXy9F+hxWQE8UDw3qtSLkVEsv8smzvWQH5
 xC5M1yQiGp1B2ApDAeFU70wlo7L2T10cnh4QYIQ6sueAac/a24ZnXMn
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

The cros_ec supports limiting the input current to act as a passive
thermal cooling device. Add the property '#cooling-cells' bindings, such
that thermal framework can recognize cros_ec as a valid thermal cooling
device.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index aac8819bd00b..2b6f098057af 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -96,6 +96,9 @@ properties:
   '#gpio-cells':
     const: 2
 
+  '#cooling-cells':
+    const: 2
+
   gpio-controller: true
 
   typec:

-- 
2.47.0.371.ga323438b13-goog


