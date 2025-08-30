Return-Path: <linux-pm+bounces-33473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA56B3CF4E
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D092040C3
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8842E7194;
	Sat, 30 Aug 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQlPsZuy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D52472BA;
	Sat, 30 Aug 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586730; cv=none; b=D17ykFNcYHAc8ofdVq+UDefST+PUNdoR8ItohDjzk4QHlm1Rq72zPRkOTVAsjyPu7bejmIm01B6K2bl79EWT1EOpEqLB4IJ/i7H7EM3aaZmhFDtaitbk9VasV2Igh974sigRxROZkqpQFzqyLaB58Nru3eeAM9ViLUZZ0zmyzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586730; c=relaxed/simple;
	bh=bsMbeskizZ3+m+ew2tNDknotQDjax91iTAZv7fXPpnQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UmdeEIG+52w4MqXje9CqxNiY2zgW8ADz/uF/bei0farqrAizgo5Z0KYhp2iMsRIkWxEbimPtuBnOghWaIBLQToemVjkIX/n1cQPGSTZeLkVHOpb3BiHuPU+lCWNgxWj739I95QH8VvjGtG+vsKtWX5H2GfMy97Fb7W5PxyV7ZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQlPsZuy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-affc2eb83c5so160454066b.2;
        Sat, 30 Aug 2025 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586727; x=1757191527; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpjDZlCCSxzX1q0S8x/0HEmKCcPEymF68KMYns7ekvw=;
        b=aQlPsZuyiljjfUxVQkBKFEaI32Qp5T488IHSc9lhM+iUIKneuswI0qM1hx9U2mImzG
         U8uOFQC81+7ZTR27CuXWHLbIp/QfhhO1xx6kl7Gn1K9K9sH/BFKa1YlHh4KqfNrvWNq7
         V+A/FfCrwUfAAS9MeCuLTS2f9zAor7WCHfghFRrtJeNuLVE0n9BiuEuW7AI8+CjeOB8Y
         iN03ibxwLNZQw34lnHnoGTZWnGmlVeHcIxUYym8cTOVN2LoTPEetsRf0Q3HlLa2C3toB
         h57jRVxTD00NKuZzGCmQ4YmXY5t/CcdGmnqnYOPchFiGJI8ZvYw2aVX091u/h7J1mGNU
         f0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586727; x=1757191527;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpjDZlCCSxzX1q0S8x/0HEmKCcPEymF68KMYns7ekvw=;
        b=hviv3pZPXOFh1xwDKCXYg8QWbXxdXf5UWL6kWbRBmmWOIGOq5DB65UluOKphrcv2LV
         DZLLWYMIt4+Q/H6weg5X9w60UGba70kNqDeyWKxLhynPWrMmaCV2CaO7+Hg8jJQU4fi+
         aVWfdYg5QpFw8T5BTBmGF8yzSJ1IK/FJiweM95de6ye2edEe9diiWRv/oDt/5My1Exvk
         5PPvulu5Siu5mwXVubyvHAcZxWsJ8XZwTs4P5S8b4NYK6Kdglxu1r6kScaGV6jWmkBt/
         +ojFltmoTh0bPNvTpvovMR22V+NXWGFTnOry5BfR/1H8r58z3PMo0qvV1ZOX4hnBNfwn
         AOcg==
X-Forwarded-Encrypted: i=1; AJvYcCVVoewHixmYu20ktS22SoermrH1JxaYhWunTXjAb8lSll9Z702jfTuPnVQZmnk1U3FLO2wCmwALv4Y=@vger.kernel.org, AJvYcCVsji1PbJ+sx6CwdYcgjgFCu1l9REajW3GMM1RF7hTbHZ/X6LK97gVk6MgzTzK6pz1kz+uxHhYKI3bwwFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/G7wInKe7ZathGO2AfEm76eL9in8/0dwU6QIe5/xNKxsarGO
	sfcewdzOvt9Er6Hr/TLtb7jJrjWdgifrxHsTUbyt+dWkxGlxvyRdSR9M
X-Gm-Gg: ASbGncsOAfsjFrgN+OqWsS7a53v0L3I3MUPKKw2gAQOpANf1KJyH9kV/09807wMkNiE
	TV6qfNpalyFv0fG9S/OBefGTuzMcnUKKgY0u5dQL4ahiDTZcutw97D8PYFiGDLrfLCFiZjZCWIh
	1QbJONbpImn4EGvzW7qi+nESOy2N62tcp2AbRqsHmMCMAv+xqkE8nJC2N7OTYGVCtsGA9gz7mR0
	1Yx//2PSrvskVwaLSZH9ulEXZbAh4oeIdW8I+G7Buh2aA2cam/6KeBHNbhXU911jnhX85faqLG8
	aVvTHpvOKGFI6yCQXLtMv7LVGuqcK07GmXjj5twbNF9hRJqCcxNe6uJgM3gKaJZUwKm5xvZg9qQ
	czCgEItQQijp1cFkxDkHJ66anQRhFOMVlb+ZTTWRtyg==
X-Google-Smtp-Source: AGHT+IGRPOBFp3JnR5dh8ZPVi2wj7ba20iZDFAa8VCsY76wVE2IHKKw+IPXNfg5o4YNN8RcvH2tAhw==
X-Received: by 2002:a17:907:7b97:b0:aff:3dda:31c1 with SMTP id a640c23a62f3a-b01d8c90d25mr336896366b.28.1756586722770;
        Sat, 30 Aug 2025 13:45:22 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:22 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 0/9] power: supply: fixes and improvements for
 max77(705,976) chargers
Date: Sat, 30 Aug 2025 23:45:13 +0300
Message-Id: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpis2gC/z3OzQ6CMBAE4FchPdtQfld9FWOabVmgCRTcImIM7
 27x4HGSmS/zEYHYURDX5COYVhfc5GPITomwPfqOpGtiFrnKK3UulBxxAwBVaYAL1DqWuCPWbpx
 5Wmkkv0gq2jID0yJWtYiQwUDSMHrbH5Qp07AgP4aFbO/TP/gMxup5ekWtocGtxO9jPTO1bvtdv
 N33/QsEi/KnsgAAAA==
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=1532;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=bsMbeskizZ3+m+ew2tNDknotQDjax91iTAZv7fXPpnQ=;
 b=M4Ae+v/739Xx/y0sC4GaVmEXLngxEioXHIikybdcf00uIaI2oVpXGYsL2+O97r9tF7+tD1dXz
 szHiz3uDEL0D24A7D9Kt5z8z82rQNOv9Gn8vaXHzh+gWbzmspPd4y4n
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This series consists of:
- max77705: interrupt handling fix
- max77705: make input current limit and charge current limit properties
  writable
- max77705: add adaptive input current limit feature
- max77705: switch to regfields
- max77705: refactoring
- max77976: change property for current charge limit value

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Dzmitry Sankouski (9):
      power: supply: max77705_charger: move active discharge setting to mfd parent
      power: supply: max77705_charger: refactoring: rename charger to chg
      power: supply: max77705_charger: use regfields for config registers
      power: supply: max77705_charger: return error when config fails
      power: supply: max77705_charger: add writable properties
      power: supply: max77705_charger: rework interrupts
      power: supply: max77705_charger: use REGMAP_IRQ_REG_LINE macro
      power: supply: max77705_charger: implement aicl feature
      power: supply: max77976_charger: fix constant current reporting

 drivers/mfd/max77705.c                  |   3 +
 drivers/power/supply/max77705_charger.c | 386 +++++++++++++++++++++-----------
 drivers/power/supply/max77976_charger.c |  12 +-
 include/linux/power/max77705_charger.h  | 146 ++++++------
 4 files changed, 344 insertions(+), 203 deletions(-)
---
base-commit: 3cace99d63192a7250461b058279a42d91075d0c
change-id: 20250830-max77705_77976_charger_improvement-e3f417bfaa56

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


