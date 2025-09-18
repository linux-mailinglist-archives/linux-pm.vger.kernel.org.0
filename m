Return-Path: <linux-pm+bounces-34978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EFBB8625E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52CF3ACEF4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C830FC0F;
	Thu, 18 Sep 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QusXKV+B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CD2F7ADC
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215212; cv=none; b=EGnCYjmqsoRtsEVUfOGPiTxPxMTuzLsyv34eiXo9JZUQGXY3F9sER2Lt2x4CpmirQhMiHTQsqdJQvRL7QDt7RkWjDsblCvGgoM+2mr7NwgqQQZxkI4+mak/2tlV/4FYAyFhg6D/7PjNnYoyCGERFdw5ccyggX+Qf0Mu6aTg65C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215212; c=relaxed/simple;
	bh=Snu3DlC7DX4VFV981Eh74gFnhCpjPpOJJ95LxP+JvLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jm4QN5qMltM+RtsNQ19f3cMcGKc5vXMo8QRybCOrPNJbqN2WpGlO+UD74YMkKilxuLpGVf/y89RQL53Tv3uXYsDYqoIslL/+cBnkqWyiGlOy4IU+UxyP2lZRU4vAvl73tJ+dmORe+Nkd1rJdABcgqawNygbxP4P6j9wLXjkhzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QusXKV+B; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b042cc3954fso237238466b.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215209; x=1758820009; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OgEPdidWZUCKfjqucDbsRTdLfQYdNUkekhd18tzklWA=;
        b=QusXKV+BbPx+vg7lQlQjo5tg2fjbqYHtsgpENpDA7+SOcx7Nz/EwGYkoHZXummEm/o
         1fx0+636QcWyPax4lb6gkO3X4TeWRObzLhth9k/mOc/XnvPgYLzAUw73eInEDxkjM0Sa
         hSE26wPahO3QaMmTi6+MOU2shsk1wJ+wM+jzQZCOLQpixMFj4XIMbdVzFtMrfUsDh5Zh
         qfaANS8SK6WbRLojbsH8grx1a5eTZy2a5Xq/aeFlAFYG+NM2y0YrJeD9FczfjG0me+XK
         XztUvEHBDIDj8JypvruiX/3oUa8S0EanuSJKx5XJIZE2mlnaQb5t3H1Tax6CMC/7PJ6l
         KglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215209; x=1758820009;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgEPdidWZUCKfjqucDbsRTdLfQYdNUkekhd18tzklWA=;
        b=YVu/gxfrQFPER9V6PTf5WF8TBx727AepzEI2R3I+6/0IHJFZUqBBIel79WkNS4VzHk
         SXViYZxZP20jNcGVms9zOnWLXj9cftdoU7CHrtd+d+yrWc95zJXs4Cg3iViTn9MP9DHb
         DNGyjUuiu+FPxQL2Phf9AsicuFNyLPKL5nFn65H0LummGpr181fdkOElGhcVsm8oWthY
         FaxLumTastINidVWfApG8C1e1rRNG71qnHJPZKxa8acH9K+qIia8RcJll9+W4vhr97UR
         eN/IYkrCpuKyNUnUH3NAxYgTk+ybLg0xvCAFtLDtnCRfiyltQPRiSh+MD2g8SIss/1Hi
         Cmag==
X-Forwarded-Encrypted: i=1; AJvYcCWYlm8GwooozwMWF7Rd7atJMjmUZX18kY7xdGKuW+zdiJ/yhnQjsGKAZ+HZ2uAQRYhSVDQsePqHSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkDDmBhAskpgyk0X9Alp2yJGWfpFut611q0Yl8AjETC8aTrQ1
	jsr7Fkst+tKDhFNGxOFaK/Dm5/ZLzbEfiMqmzvQUjaJZvu4GA1DNN6co
X-Gm-Gg: ASbGnctVnxyK2xueAosuN6WBVagZb6vBaBmkp+qmXDrWuEwAyGyP7ABnSerjMwVvwg6
	LxLDpAnUJCYxtiUp5vz9KcdxIy892TqQPP2KB2SrPwgidaFgPuMatBB1e64g0jkI+RA7lDgkMK+
	TQL5ql854yjlH+ZkW4/jWz0C8FFJ4SbfMUFGo5yYO8ZXziFSpqkvH01vw+SqUw4Tqe7BoChQokw
	eAh6yR54TSLimO1HAIGAzzPiDmkYg1kBjITAzEBDNsRYHt5CRRaScPhP9hkcnJi/s1cNpQne5VW
	HC/RdHa0XQAJOHcRBaJfZPxFBkwfeoMI01MRmX3MV58ej/S+XSKsJ1BVr2HZVUQU0gtbvY5g9jC
	Pib3VEScFxKnMC/3pYUmDIoSmFF0W3HjygTo68UY=
X-Google-Smtp-Source: AGHT+IEa80hbsr27dP86R8EESZ/NUboAc4XQo4V5MaLrIyBAxmcmVYTLCjC7KQgkEfYpTXVruphemQ==
X-Received: by 2002:a17:907:f497:b0:b07:6454:53f7 with SMTP id a640c23a62f3a-b1bb7f2ad5bmr626407566b.52.1758215208966;
        Thu, 18 Sep 2025 10:06:48 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:48 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v4 0/9] power: supply: fixes and improvements for
 max77(705,976) chargers
Date: Thu, 18 Sep 2025 20:06:44 +0300
Message-Id: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQ8zGgC/5XOy06EMBQG4FeZdG2dXoCCK9/DGHJaTqEJFGyxj
 pnw7rYuvK3G5X8uX/4riRgcRvJwupKAyUW3+hyquxMxE/gRqRtyJoKJmrWS0QUuSilW90p1qun
 zURgx9G7ZwppwQb9TlLbiSluAuiEZ0hCR6gDeTIXS1TnuEF7mHc3kz1/ga9Sm39a3rA04u4Thv
 XxvAa27fFZ8es55cnFf86o0TrxM/1Uuccoo5u2gpR0qKR7HBdx8b9aFFD6Jb7Jj3U2kyCS0g7A
 aKsXr7i8pf5Cc30TKTMpaMNm0jQXxizyO4wMVfcMUuAEAAA==
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=2240;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Snu3DlC7DX4VFV981Eh74gFnhCpjPpOJJ95LxP+JvLE=;
 b=PgajctlOTxV+Mbi/NAuoRUD72DElTHIGyiCp37Ks7HUicZKgSsAfKH3/jHZ7wlJR3Ge3v12lL
 6L9fYjoxc+XCdWewUXZIq2DS6k2s01Yaa/DsE4KR64mhjPbeRK+8Twa
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
Changes in v4:
- fix commit message
- use IRQF_TRIGGER_NONE, because non physical irqs
- minor rename refactoring
- rebase on latest linux-next
- patch reorder: put fixes patch first
- aicl feature cleanup
- Link to v3: https://lore.kernel.org/r/20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com

Changes in v3:
- move interrupt request before interrupt handler work initialization
- Link to v2: https://lore.kernel.org/r/20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com

Changes in v2:
- fix charger register protection unlock
- Link to v1: https://lore.kernel.org/r/20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com

---
Dzmitry Sankouski (9):
      power: supply: max77976_charger: fix constant current reporting
      mfd: max77705: max77705_charger: move active discharge setting to mfd parent
      power: supply: max77705_charger: refactoring: rename charger to chg
      power: supply: max77705_charger: use regfields for config registers
      power: supply: max77705_charger: return error when config fails
      power: supply: max77705_charger: add writable properties
      power: supply: max77705_charger: rework interrupts
      power: supply: max77705_charger: use REGMAP_IRQ_REG_LINE macro
      power: supply: max77705_charger: implement aicl feature

 drivers/mfd/max77705.c                  |   3 +
 drivers/power/supply/max77705_charger.c | 386 +++++++++++++++++++++-----------
 drivers/power/supply/max77976_charger.c |  12 +-
 include/linux/power/max77705_charger.h  | 149 ++++++------
 4 files changed, 344 insertions(+), 206 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250830-max77705_77976_charger_improvement-e3f417bfaa56

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


