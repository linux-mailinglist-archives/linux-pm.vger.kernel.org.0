Return-Path: <linux-pm+bounces-17264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516729C2D39
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEEE1C20D7C
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81471186E2E;
	Sat,  9 Nov 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDu38UYm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836C145B03;
	Sat,  9 Nov 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156284; cv=none; b=Gg3aZSXOgBPFRhHfYP/pB+2G465t0O2FDnprsBascgAaUh+l6DDVyVqHXgXF5mZsFkfkvOr4qsPZrt+qryDdGjUxtHP5ieueDeAQ/UzE4fP7dagqEjYeLPWzv3a2O48hAGH2CBdXU1BtBb8n5D6XwhuSata9i0rAKKzS1BILeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156284; c=relaxed/simple;
	bh=AViyC/+sdOhddIa9xjAO4k6SS339kVhh4BSc9RyXqEo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MGKtUjIQe545oe68W7L8ee5qtyyat6sD5M/9kHu2cm1U/9ycTu/h36AfEtWU56UbRmfCKgQtKPbTAekuaAQk8Le4u7jFa0I5RvfgjsesSIEXjHG8AyAvVs6MyyQuYD7tIev3viKjCb7limONfWO7ZqWjKwqcJBe/LbiRjd71ANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDu38UYm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so3730697a12.1;
        Sat, 09 Nov 2024 04:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731156281; x=1731761081; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnvmniB3LeK8KeMuMSmkjZysB0f8NngS3V/dJUbHuv8=;
        b=WDu38UYmC0NRAKFTptp7zOBMsyA5ayJJgUL43UQiOJnt8r5HAQike/778DduoI7J7d
         dtTlmHpi5pOeesFocKIPlLairuTSeqsdTlHyU26ACZiWRQfGFINiDJvCXdzsanSE3MiF
         KACvDERJy6wqabjvleI2c52a5v/K6vYUYSzoLPsuwsOzOviOkgoeK47HN28Jiv14bVsM
         eGzP3iiGyLU/6M/5MnEN4KyfQDCwPljCr1sl5qn575cWeUIWxgbtBxqAbye6iVn3Nma/
         /J0VDr8VTS0Ko6RdsuStXW5D5rstuRXj++/h/hzsuxMiJJi0WCQdJueoQ7zmCcXhR7wa
         +DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731156281; x=1731761081;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnvmniB3LeK8KeMuMSmkjZysB0f8NngS3V/dJUbHuv8=;
        b=IfB4q+Tkb8LtcJMPgAL8T/6qA3ar0ch+HigzKMEwvOwUY22FEkRWZDb8YVqkiGNsIq
         hqcHJaV1/MejI5G/P0Yv3xyYTRrp50rQ7EnhN7teoS/0DvJQYu6ji7LhHqlqet9G1hH9
         4yG5fwaQt3WoDSd5AiWI92uIaiAm76THZ3awvt1QBnh7HJcEkdIqoRQkba9kYwZcv6X9
         XLSP8qY1OUP424K3KrNQ4ANhnmjOvBkQ/+uePuGlAAxxA8BVrPKt2FrnHVRgB3aWZmFS
         aIYP0I3Ebc+YFooiwxlAozn0GhyBtob8mC0WQLgbXLyY8pl0le0jtu62rK9e6Rd4wa3l
         maag==
X-Forwarded-Encrypted: i=1; AJvYcCUntGCwCq8a1j/G+QqwSi14nFt8APFcChCqH+YZZktnSRO4OtypeWlqnXL340NjuYE0ZNoFL0SiVxv3UhuW8OhLs3I=@vger.kernel.org, AJvYcCVTqs8ipIgNicwTBwfe+Pd26ADpN9iFfAx/StxVau00xbucuyMRcRJSB1zS1Mxun6zl0H6YcoLB1E69HFwq@vger.kernel.org, AJvYcCVgGyIqwnfXF2OpjboVH4kEQN6Yl0/QjRbP40TTOSce/HJO0uLeP31dATaRCg76rsLd6h4HJF3BXLqk@vger.kernel.org, AJvYcCWp4cuLDiUIsdWJ9/DX1zhOqFjmXSghaPUh+BMwpW1XaNR/hUW0nlwUhslkbQTUF6Die4xpjcu9sX+8gzi4Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uxc3oKbNfNUJQQphVCESjEDUu4YoePuZT2RVHZY0Ia1QDsly
	u+RHmhsjQFBJRProPGmeZA5yZgOC904SvkW7ycGvptq25/GHH+b2qNsCv+HR
X-Google-Smtp-Source: AGHT+IEIGCuxXrmbH3JmjmIhypDxiqT7VZZMvZ/3txPu0Ud1UAxyBs1Rg9CLp2YCTFkbDWAYDWeRnw==
X-Received: by 2002:a05:6402:40ce:b0:5cf:1122:88bc with SMTP id 4fb4d7f45d1cf-5cf11228de0mr4137881a12.20.1731156280475;
        Sat, 09 Nov 2024 04:44:40 -0800 (PST)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d793sm2940166a12.17.2024.11.09.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:44:39 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 0/4] power: supply: max17042: cleanup and more features
Date: Sat, 09 Nov 2024 15:44:32 +0300
Message-Id: <20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADBZL2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwML3SQT3dzECkNzAxMjXUtjA7O0ZHPTxLTEVCWgjoKi1LTMCrBp0bG
 1tQDfK1uyXQAAAA==
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731156277; l=1826;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=AViyC/+sdOhddIa9xjAO4k6SS339kVhh4BSc9RyXqEo=;
 b=90pggLnOjDwy8XmUHTXmK3BpQlR4sHc6LVU9DiIpq7VL088R8yBC5A5aftKbu82FSxx1GYGTA
 X/vuKAzVUFHAIDmfWW6YeaEl/dP8pdBpT3O5BkRrjvSkaf7a3lu1vLO
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Maxim max17042 driver cleanup, and shared-irq feature.

Fuelgauge blocks often are incorporated in bigger chip,
which may use only 1 line for interrupts. Shared-irq
handles that case by requesting irq as shared.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Dzmitry Sankouski (4):
      dt-bindings: power: supply: max17042: add share-irq node
      power: supply: max17042: implement dts shared-irq
      power: supply: max17042: use microvolts for voltage comparison
      power: supply: max17042: rename maxim,rsns-microohm property

 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 13 +++++++++----
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts                     |  2 +-
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi                     |  2 +-
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi                    |  2 +-
 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi                   |  4 ++--
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts                |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi                  |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-motorola-harpia.dts               |  6 +++---
 arch/arm64/boot/dts/qcom/msm8916-motorola-osprey.dts               |  6 +++---
 arch/arm64/boot/dts/qcom/msm8916-motorola-surnia.dts               |  6 +++---
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi           |  4 ++--
 drivers/power/supply/max17042_battery.c                            |  9 +++------
 include/linux/power/max17042_battery.h                             |  1 +
 13 files changed, 32 insertions(+), 29 deletions(-)
---
base-commit: 929beafbe7acce3267c06115e13e03ff6e50548a
change-id: 20241108-b4-max17042-9306fc75afae

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


