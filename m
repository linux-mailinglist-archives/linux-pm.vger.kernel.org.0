Return-Path: <linux-pm+bounces-28090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1130ACD977
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 10:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA62A3A4300
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688F2269898;
	Wed,  4 Jun 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIGpYvuO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E8239561
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025144; cv=none; b=YRc2WgsOVn2hgTud88bnQnkXD/k0GCp5Dz2z+iln+6nXEUxFsrC5EklUy/CkgydZWDsDaXwUtjqKQIjhYwgiiaU82WytlYNNMD8ufWluutvHXUNuVmEpAz8A0v8iYF0BSaGEwH0ZMAHo+ihtyL3tENGfw8dWpLMqYABTRRtPM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025144; c=relaxed/simple;
	bh=EslNEbGkoEtGZPgNzSbXr84zl40yV8m1mM0v265VQvE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CpOvox409ay9gclkusQIAV2WJdV08R9b6JYJ/d+tEfESbckZcc03+MYhVYztQk79MADSsIpYgHlTeU3KgwGgZVUNGtGaFiaKz0+BKcs8axrdG6l55pjrKFPQh+QOHJPyOrcxe1IDz0fQFFnS0Qi4WX7UX4tCHzVB2CXNhNPaTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mIGpYvuO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4ef05f631so663819f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Jun 2025 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749025140; x=1749629940; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMiMkiTF0Z00OlwzviIMPLOkZdxr4W49dCOYPK/ZpVY=;
        b=mIGpYvuOHCjKomlYTQ4uMwwrTevmSOc2ukO3WhCaV+9k+1q4fM57HMI0k9w3sMOWdW
         a9FepbbOSkA7SPSdFhlP09gVt13hivgMKF9ihPA8vQKqv89QlBOFhH8F7cVgd2HNPrg4
         wcGPQGCY4LSGIFdZiKLwo8B6/F5F3bUE7my7R67F3qmgztVK5EOKNE0Do98Xg1OuPQG4
         fD+iyPcfEMYHOy3NPYPEY2xqv3Cfh4SlWWKA1GX8z+XgQDxdBfk7bCYGj4EtfxyUTrCS
         lrEPzf9IFpJJPGoU3BhtCz97KYIRUASVwWNjH4YQ5bIJxple+m28MqRDvShx6KtVIoCj
         PPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025140; x=1749629940;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMiMkiTF0Z00OlwzviIMPLOkZdxr4W49dCOYPK/ZpVY=;
        b=tS1HLRMmNvfgvN1OWzO6Nwxsd4ggT5pb/io25TJKOJqLjxySSe4AQi2cA2EN46pC8E
         BkWUTxHCir40ZX37kjimJ8ny1ShpIbuKCGWBhm1WMz0FUZ8ZeEZoqnmfV5h7IDAniTcL
         mQL3OiIhCCbbCd1z6x5UCNJcHCLdTqw0Qx1eGGt5m1oD92+eBL9Kbc7COElylmOHqifP
         YbS12cWadqYCxzOJrptDOi8q6WeO+z3NbFCJiClusBiUippeONo3hEY5ckSaaZDl/CWj
         aAK03Ax19cCxkmzOf9NCejAdc4r1Q1U66MtiZfemIEUeVyoDGKfeRBSXL/yJpmcwweAD
         z2tQ==
X-Gm-Message-State: AOJu0YxxblGU3HhzUWS/JIj6bJQWfZMeMRIyboR6DLPfve6AVaCIaoWn
	EIdDwYO0aI7gyHtHr6TZ7onLBYC0vGwBCD25InbcQrJtVPhHyBpEdMLPrkwOgVh2zEE=
X-Gm-Gg: ASbGnct5Jj2Nq6xBNqoxacvaiZR+FGvm/wlxkAS6KH9oBThk0TDW9iG0yVmo32ySi+4
	lEi9CMGevyzUMftXAH2k3mTndxKoVyy4dX81hNC9K0MBRqhAQiZHpQsN29vvOIqGVrvLoccZGVv
	S8fZHPBkKPXrgd1GVGM6ApwW02OITXdb5ewteFg5plQ66braKchfgHgq9EA3U4M4JeD69dGhxzs
	Gm045YzJmuQVQAgTF50vvV/zUlG9HwMDEwvcy/0RJxEqQnf//0HzBB6qfrhcWCpc+0IVGU+5Z72
	WY8JMr2qOuTRlXq5LbmTdAWPePGnD8Pi+nJ+rBVOcAf5ZhyGex+GK0RAR1CTcGmk1Xq1LY2W/GC
	opRXer9LPb7fqYLfPwUV8dQ==
X-Google-Smtp-Source: AGHT+IGQDltAdK05Fw11inWndjZRxULWek/GxMwsA6OXvhVhdjJ8bm9JYWwetuY8H/FAb8SLNfuwKg==
X-Received: by 2002:a05:6000:1a86:b0:3a4:dd00:9ac3 with SMTP id ffacd0b85a97d-3a51d9789b1mr540032f8f.12.1749025139734;
        Wed, 04 Jun 2025 01:18:59 -0700 (PDT)
Received: from [172.16.23.13] (adsl-84-227-104-5.adslplus.ch. [84.227.104.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm198301215e9.29.2025.06.04.01.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:18:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/6] dt-bindings: power: supply: Few cleanups around
 monitored-battery
Date: Wed, 04 Jun 2025 10:18:20 +0200
Message-Id: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwBQGgC/x2NQQqDMBAAvyJ7diEaLaVfKR5Msto9dCO7oVTEv
 xu8DMxl5gAjZTJ4NQco/dg4S5WubSB+ZlkJOVWH3vWje7gBU8HAklhWw812/GbhkpUShrkU0h3
 908cYKv3YQe1sSgv/78d7Os8L1ghAF3MAAAA=
X-Change-ID: 20250604-dt-bindings-psy-monitored-battery-383ccb383351
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=EslNEbGkoEtGZPgNzSbXr84zl40yV8m1mM0v265VQvE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoQAFP0q6p3Md047rFs8XK9lvNwEHiD07KFK1wf
 aKho7OfiNOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEABTwAKCRDBN2bmhouD
 10kAD/9+ewY94g516RgISR2hTlXUOvV1mN4U2JDYN0SqKKHDmKhhBY2u1RcUQ2NU9mdDCiQmuES
 AiChnX+LznSGTSV/Fls4v7KJJ/dypq6wZdj1gj0U6iQLkkzymLCyIWUa5JEK+8571B7nmLSN5UQ
 x+P6QAUe87VM4rRg9M0rkMf8W+HxGzoF1Xwpurc+Xix81+3tzQB0ZzTj+oAJiWVRD+c+DLzrgHa
 qgRddcHN/8BnYMRFe3CZz49PyALOigaaPRcnoD/ufic/uWRx/xWgNLdJ0jPANx640WCnEmCHz5r
 ynrwbZuoAGcfQGt1etu+OSxGZWSufd486M/+oEiUYr3XZg03Wmko5G2biwTtBZNVQVIhIf8q0iI
 uV041jbic4CSHpL8GHpLoGuTuHrVdSEK4tKu+G13CKQQT7FR7FSJNE2pguj4tBGTVuifbybMCWT
 bGt67GHwmxFoMqs7JL01a7Rb+pptMbbvr6znG+RBunHrYLSTRcokDt/vj+vf7MtguCQRBHx95bu
 ASkdck1Boudvhdt+rqCkR51K9JAU2slJveMMIX3diTmGB9XcYuO8ZZLrbPTs+x3w7Q2ayHS0etR
 GbkwQWAHa6uj1schUY0nCGnVKGGfAPTXdaU86MLtIHzusWYN5MuxVLocMNiqDgyNoHw1rW1LH7w
 PPsYXMAofsbSIZg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Reference the common power supply schema to bring the definition of
monitored-battery property allowing to drop redundant pieces.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      dt-bindings: power: supply: bq2515x: Add missing power-supply ref
      dt-bindings: power: supply: bq256xx: Add missing power-supply ref
      dt-bindings: power: supply: qcom,pmi8998: Add missing power-supply ref
      dt-bindings: power: supply: richtek,rt5033: Add missing power-supply ref
      dt-bindings: power: supply: summit,smb347: Add missing power-supply ref
      dt-bindings: power: supply: Drop redundant monitored-battery ref

 Documentation/devicetree/bindings/power/supply/bq24190.yaml        | 1 -
 Documentation/devicetree/bindings/power/supply/bq2515x.yaml        | 7 ++++---
 Documentation/devicetree/bindings/power/supply/bq256xx.yaml        | 5 ++---
 Documentation/devicetree/bindings/power/supply/bq25980.yaml        | 4 +---
 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml | 5 +----
 .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml     | 7 ++++---
 .../devicetree/bindings/power/supply/richtek,rt5033-charger.yaml   | 4 +++-
 .../devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml  | 4 +---
 .../bindings/power/supply/stericsson,ab8500-chargalg.yaml          | 4 +---
 .../bindings/power/supply/stericsson,ab8500-charger.yaml           | 4 +---
 .../devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml     | 4 +---
 .../devicetree/bindings/power/supply/summit,smb347-charger.yaml    | 5 ++---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml         | 6 +-----
 13 files changed, 22 insertions(+), 38 deletions(-)
---
base-commit: 3be1a7a31fbda82f3604b6c31e4f390110de1b46
change-id: 20250604-dt-bindings-psy-monitored-battery-383ccb383351

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


