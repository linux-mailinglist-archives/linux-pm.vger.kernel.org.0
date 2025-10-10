Return-Path: <linux-pm+bounces-35906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD402BCCBE3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 13:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68790421728
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379FD28726D;
	Fri, 10 Oct 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="IO8I/tT6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CC286D66
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095435; cv=none; b=rmrS4yRBV1Unc8fLFC5+CM01UJ7rz7gFSnyvyOWK0L7GPcvZSYKF1QxbuJGvpnDrNEi8SmvPH6EpoVpIHLr20k6tDa9FUhL3ZRMQYNihdTQAcOBrp8RwExV/skmsNFjl7g9j5lJJnm9F0FCTL7tN7yjoSbZlnk9vsQwsIfDsWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095435; c=relaxed/simple;
	bh=rN2PnqvN06c7mlTMsnkt8Ofc5TQdsHN0zxf8VF8tMcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZoBTaYf53TUZ2j1YSSPl20n7sfc7JuMfj4CFmD9sxr6uNB+Or//kYBBFwskF/pG4bP7x79A5LBRkWccYoxmf28mDm/s+hQo2wUTJuB3CNhGBp9aEM7p7Llxrl/zLNs7Ab2NTSy4bUzaBS09RnFk+ZBTM+BcjmK9ezZ5GpAWvjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=IO8I/tT6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4539dddd99so398687966b.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095432; x=1760700232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjZxwkEE9XRYJeGqY5P3ejLLsqggmj8GPN1yD9SWCBg=;
        b=IO8I/tT677UDmGKAg/r7kbHtMkKKVyUpY6sWKWZd9EcX1j4LEKMio2otyjBDxr5KI6
         HvAGguJvbwiC5HyyUBLNW1rMqrME7xvin3O7UxbqKO48SFGq4xCAbWwh97SkFhHOITvv
         Fbd4WGx2flJDFor0BXHg8INIyYvEhthExvfdaZMob7j0XpeasdD9H+mcpG/7FHLCYIrD
         tVeGm7Ybm7K2oyhBnLXOlnDLy6fcCtDElLlVTzj4axBdqx6PzS1aLP+CYDoz8oB7PHtB
         q2k9DgZ3WRA06muim7eDprtazKIraT6K9YesmJrJm0a9hWOvdUFtvkMEzsZxZuIIGKz/
         5jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095432; x=1760700232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjZxwkEE9XRYJeGqY5P3ejLLsqggmj8GPN1yD9SWCBg=;
        b=xFxq3svuM/puyu+e8DjbZ+T3HEx8xZpLBCUPJvc0uUOTukjUreJYAyaTiR/j6hVtL2
         4U3wsSj/bbLi/GhbvwRZaQy/NxrCr4dbqjN1gil2M/wOnuBOIU3ZBDAXoOGi4oeVXiOu
         ilEfwuDvBT9gFCFAQwmNCBCfg85zZso2auAA2ZoLiKViO9cGIElRSfLdQZPMbVjKp5Bx
         M3uthT25Lgudb1P4UDm2dVSDHm1ADAxwUl7nLc1nuw4mOqwhU0FWQFEryWFkKoDiRbAp
         A+jZIh4K4E0UeR10q7YHBEQkIiqlWvPSlq0GmHyl783+vcOHTRv1SojS6UL8EgwgTu+i
         bg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWutIKdycoFwkrVo0Kz3GHCPDadUswMQz3SjMlkB+LjiZSTqOsZVfK8VBKpfJ8ioqlYP4qsBMgPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuf4dO5h9Wzaw7T05xdp37Bcke5V/R9g+NymGkvb7bb/x5Do1S
	g5KTO09d85YrTJ3dVfsNFhMnF8WtAsblm/pGcjccToZ7JA2L8omXEvSm+eQIcLEuR4U=
X-Gm-Gg: ASbGncsJbEUa0l5edxxORZ6puDqgcWjDVuP7918T9vr3juvVshwoTUB535mvQFoua0j
	JUKxjKhNXqbWo1Yfj+hxuJLf0fhaREF9GueDh+Ofx7Uk0hqFsXzFlQ0H68omuWRFUHzCTdvgUxV
	yXz6pyCvOqEG6YyQbz9RpJuzJrGW8+uO4sRekLE4PJiea7N1QjqOx6u5Q2+gIJQgY0s1nqGVYnU
	bi+YLBy94BJOA5wFhDxEQovujT0OwlNZIAM2LlZplbd+mcxJn9MUDC78aX3rPwfxT12IvMiBQXw
	zr4EL9hyKQ+nCDPkAgL6NOaGhkIkki7kFhex0ERHpJLDcXQ+1cOGVRLIT6UCbuIp1OYDYahrxjx
	Y0LzJ8M+aKkb40CXHVreWTvhVK7PDvg4qqU6ROo4GJnPt+BTFXKmecHZAaf3QT7heZdKQvpppoe
	EUm1M/qK7CI3z9na7fnfDKf2mEOgiMhw==
X-Google-Smtp-Source: AGHT+IG0l/2slu6V7bbZR48BMoHy5O2kIXbxky/cFnBGBo5QTAKOZtCP/w3ulfdBtRinJ5MOJJg6Yg==
X-Received: by 2002:a17:907:72c6:b0:b46:8bad:6970 with SMTP id a640c23a62f3a-b50abaa43b4mr1251023966b.36.1760095432092;
        Fri, 10 Oct 2025 04:23:52 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:51 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Oct 2025 13:22:00 +0200
Subject: [PATCH RFC 2/6] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-bat-temp-adc-v1-2-d51ec895dac6@fairphone.com>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=1052;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=rN2PnqvN06c7mlTMsnkt8Ofc5TQdsHN0zxf8VF8tMcY=;
 b=y9o4c7jCYDMJNFUkH54nnz+m4QRI1hucrIu/e34bCKs0obhf5/NpX3CWg8CXfUXEpdGxzNqsw
 LlijOXkdwZEAyChf4nWCfOadjRUMdruziUetVwQ5wH+z9ndzcBSuFPr
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the property to allow using this sensor with io-channels.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
index 12e6418dc24d..317fc39ed46a 100644
--- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
@@ -24,6 +24,9 @@ properties:
   '#thermal-sensor-cells':
     const: 0
 
+  "#io-channel-cells":
+    const: 0
+
   io-channels:
     maxItems: 1
 
@@ -58,6 +61,7 @@ examples:
     thermal-sensor {
         compatible = "generic-adc-thermal";
         #thermal-sensor-cells = <0>;
+        #io-channel-cells = <0>;
         io-channels = <&ads1015 1>;
         io-channel-names = "sensor-channel";
         temperature-lookup-table = <

-- 
2.51.0


