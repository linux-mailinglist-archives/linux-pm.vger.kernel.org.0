Return-Path: <linux-pm+bounces-28095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DFACD983
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 10:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D167F3A3D11
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E578228C846;
	Wed,  4 Jun 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHOEjb37"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B128C5AF
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025153; cv=none; b=UVO8QP+ShxkQ8ZJzP3P1YtBHQpf12utee8r6fGnDxUIbUBtLW8BU2KwndoXrOziuAXFEIVxgh6LgcX5I42B0vUm7/OthM/WDLstG1/ss8bGjURSFS1S3TAnKbEVioOuAlgCUII1a28fbYfSmxU1TBd1xBZViJ35sCzfitMLN7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025153; c=relaxed/simple;
	bh=c3ZhkkgovKXxuwS4xu4/Ddch1klTKWepTgclJipCla0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3FsnhUcC5O7f7hvrmK6cZPDXOTi5wUNUQVFNom+XfXp7X3Yi3FE2eK1bW9nOaffAEpP/PjuDDl4zYPdZ5sjlOEjIu4nOL4mKtkocxnPRzQL5deCU7+EG3Qcu9Wdh4ywcXZj9qaP/pwvP+BsVLAaHJp8Pl6J/w9OwSQNLRFAyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DHOEjb37; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a51043228eso334569f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Jun 2025 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749025150; x=1749629950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbantlUERPSuY7CGMj3C60FaJaeXJoquFE5NLQDxQ7s=;
        b=DHOEjb37epul/g/03sqeJ8KOoZmYZnbOu7NF+ha2ZbLg/LDyu+4mnAnAu7hhPboneZ
         jHqfYLRYLnoz8TCe+8w3wStz4kg9KBFpVYt9sCF+U60sDPYyM9g8gF6rZHQRkem2xQTh
         dHfTFY146F+1o1+oi6a6FyGITJVlZnxsVyQFXDEuOTMrYdU8CRGZgR9g0KQc0lalGDS1
         cVEQzhY6UuXSrGiiEFtIjaWz2hR5IMd0PT4vEOSS/a/p12JCDS1MSkF3vVynRnP4u+Dg
         Wy+0GFF05/thPGlCmiP4s/4HKsSo66QpfGELufibrPtJ1E2qlCtFZBGeMghluyl+dznE
         bEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025150; x=1749629950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbantlUERPSuY7CGMj3C60FaJaeXJoquFE5NLQDxQ7s=;
        b=Cr+63WzyfYOH2GELcfbQ8zJCRZ7ZMtjRF2NEL6iHppTWGTAUPXCxeoAUf4QLyupdhT
         MnCQWU6BcfnR0pR2R4OIe/Tnh426oZTQHM1U40IltHN4unr2vcrKVVW52i9X2QqWOjlg
         XMN9B9LB5CtsACDs42jpIhK9jQO2frFxNErlWM84wvbvtAMfM264Ftm7EjihFXiWtqxN
         kn0pau/oPeVYjiw+aBC1fxEza0fmjX+MUagdOmUDB9cmZ83/dBMin5qjSM4QZMdcvLT5
         AKfITkk8UPLI47hIMCrAJ6b6ap1vsbEGsK1/QNu2Vb7FmhH+7AGjIDJUdrhzr+1NX/Mm
         7IPA==
X-Gm-Message-State: AOJu0YygAP8Y2MzgGPZHnFm7p0xhL5I0Ti2Gv1DlCOclxXHYvDtu2EDx
	CFfCIzmjkbYMK7Kj/O36tanIZweSWlrPcursorOTqJlysBnmWXmNOoCc0QApM4pltTE=
X-Gm-Gg: ASbGncuDsLH/MI3PUFYx98SDixW32q7TAUYrJD5NB4mFeOjbXpxd9KnT+Re10OG/94Z
	v/3qzwTgHwf1TFY8mm1938oLGugCS843KEdTufg8D2S4dRAwQRLaP+9QdPNeOMD57OPzfooCZZw
	qzNP+2QaxcHIisEdqOaLGbOue4wW8o6DuFR2RlOG5YRCx9T6Sm5cYai3WXWyWhm8TQ8e1Ini/Em
	nYkWhyFli1sQR+d56GMxzaqbBqR6iwtJ/p5APau25zotNvo0ztJ0GJ6Rrc8T6gnhOTdYJIs4EPS
	cukFKw6NQK8h4d8bgsnQD5ExU0dpcRBSL3MlwHwU1hpRpqs9zgC5npUfelGFrkphIoxgRyiQDI1
	7/DLHid2mz8POdOdkRzWM6g==
X-Google-Smtp-Source: AGHT+IEMnMgPmMwhkgUv59GGxhpUw6FqG/2zeQOKCFcAARbwyxtAv4UBiJATzShvTS7Iehn9wMKRrg==
X-Received: by 2002:a05:600c:3510:b0:441:c5ee:cdb4 with SMTP id 5b1f17b1804b1-451f0b188b0mr5846925e9.4.1749025150206;
        Wed, 04 Jun 2025 01:19:10 -0700 (PDT)
Received: from [172.16.23.13] (adsl-84-227-104-5.adslplus.ch. [84.227.104.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm198301215e9.29.2025.06.04.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:19:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 04 Jun 2025 10:18:25 +0200
Subject: [PATCH 5/6] dt-bindings: power: supply: summit,smb347: Add missing
 power-supply ref
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-dt-bindings-psy-monitored-battery-v1-5-7f755ff75218@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=c3ZhkkgovKXxuwS4xu4/Ddch1klTKWepTgclJipCla0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoQAFvgu177p43lpImNcls6Ad3F9pYIhqEV+Xnq
 xlN4h+o3jmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEABbwAKCRDBN2bmhouD
 13D/D/4jbwgQpcLMKS5ZuxOM26GW9d2BXw1v9VRfgGFRTPNWPC/E/IuzkyWbjclrSRCtOyV//r4
 FYzHDNOJmeVO4FEhozs0JI0xQaafc0tj2/SYFqkqMnYgXmKMWVxHCGYr5YQQ1tGhy8u9AwNnIRr
 9JGnYQB6L/0ep7oWrm7K4+Fs10ePIvaGTYPfEezN7BupOQuZHrWTdapLcCVVAmdmgEKzzQ/D6Ho
 64E4K1auoc26VB/DT/DMwpzIoAYkWRBetTM1wyrV4i5GCEzfyTKX2fCTXT2HIZuKUC/zcGh582t
 Qp1RPo2E5+Sn8MiIorfWTBsqi0fJA3bc2n1SYxkvSoblm+RLzSgSaFZhA4CAyXMTdbXQmHJWn/s
 p+QpkPR6O/1a0hf8Z48mnc/fw20w1b/zk6B3hU9qimBozs/jpQPQ9Hc9I8C1LTfQhokdghbQJi9
 g3TtkKoZTe+4bgvjuj4EMsb34aEVzRMDSFpN6Wh+qD3WqUdBIfheZBevEJ1vCZGki/0zvkcIM57
 SEmbPhGW4Nk/7SyEn7ySB2MCwODcEweZt0a6saJxQpRsnJcO+PfXG62wiXmUZmVUDWsnHkbsFhf
 pS+QY55iy6l3i5lL2G6bMHWC3yNDj2w6Z61jMlxTRxDpMD33YtwNezxv+fVwWf2642nUZnZaUr/
 lavpvvszyOueHnA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Reference the common power supply schema to bring the definition of
monitored-battery property.  Drop also the obvious description because
it is duplicating what is in power-supply.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/supply/summit,smb347-charger.yaml      | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
index 2d552becbfe6cb08c72f2a5584bdddc67443a2e4..65ed92bb05f30f91e24978d3261c7f29e4233e2b 100644
--- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -23,9 +23,7 @@ properties:
   interrupts:
     maxItems: 1
 
-  monitored-battery:
-    description: phandle to the battery node
-    $ref: /schemas/types.yaml#/definitions/phandle
+  monitored-battery: true
 
   summit,enable-usb-charging:
     type: boolean
@@ -94,6 +92,7 @@ properties:
     unevaluatedProperties: false
 
 allOf:
+  - $ref: power-supply.yaml#
   - if:
       properties:
         compatible:

-- 
2.45.2


