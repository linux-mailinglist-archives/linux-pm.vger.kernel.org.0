Return-Path: <linux-pm+bounces-34499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB716B53AD5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974B0AA450F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB036209B;
	Thu, 11 Sep 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTuzZz+O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B86362097
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613439; cv=none; b=i2M1skPTRUwvBPL7IML0LWfgGY3RG3h/a5Z5pnnJfq0AL5gnElW8qqUyn7jN+WdHV2UXfem8HNTVoClJ1MXsJ8GA90WLg1kk+hDOpL8jvYDITB9X0HbEGeFeaBcwZ93Hd2UL3YInAZquouxQDp/LiCj0GO4oTGpBwKplyosqSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613439; c=relaxed/simple;
	bh=Plmdu1fxwjxVp5gRnzqd0H2THbz1pc3AN+8geukbwMM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uv22ECI5oPi6Am38apcu6qyXeah7G9h9Lv3pjfM+8TGRgq2wHekxvG2pMNrHPrB+6/Q4AFYelSO6//NCMiiK894Z/q76wSvUWlKIkek6zt+R4QNVr6S4sPmDo8u3dTR7/w+SYMJMOC5w+sUqIvKCqvPuyyvs+yTmCQ6Z/l7XTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTuzZz+O; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb78ead12so146455466b.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613436; x=1758218236; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jz5ONOLYuuEKVIS5PKxv/MfvHRUbGH54YF0vEhe629Y=;
        b=gTuzZz+OZuXRqpT9Lkwbkcf+MxFDSGG5XXYV0WUUjRMY8wUtMUA9uiHrnlBy5bPexh
         q0i7auqZFzdpLM1xBxdZGTGXtdlnSHOir6DqAlf3e29ha/vcZtn1eFgha5psJEieG7gT
         L80VH0E5ez747bKb/if05df6g37DASbORVtJCHAr6uzvHsqcvlUult0J2OhxG5dRMEMP
         zZGKA0Q3F1R0AzRGQVI6LYBPsFZpS+htHUS483/t6zzMtLNSRHBdtUCYTmvdQbYFCcMa
         Lihw+OE/4PHQD9ZFpRJWOQSmMDSn8Rlb/so7VAvmQ2SYF34O1+h4i1CjWldNA2PnpGfR
         hENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613436; x=1758218236;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz5ONOLYuuEKVIS5PKxv/MfvHRUbGH54YF0vEhe629Y=;
        b=JPUvJTcssIBZCopbPFEoROw4bWkuoPTcewDMaWAPg/EancNISbhLa8Scxl+ufOeGwl
         2Pv+RxuPmSgkrDppq1mIqniBu05TOm7GEFr73usMFk0jofNQW7T0BfVRORvDVuVwO4oc
         D5jGT3ITJ7gOKKvO1TMsMfRxfSSo6N8P8c1ysOccZr6DUEBgEYO7Lz7xU97cE0u1UJ1L
         9NApNCR6vwODdtvaLuLF++Lqhy5684IgP2Q6+ECb+/BuQN3bqRCHWKi9fx7ufb5YohNQ
         aEUhnWgbLcpJ8c+lKaX/TRN8gjt8QOKjNf9xLFkz2gwvIhq/vD1Tn6LiFqRS6W/xPVou
         0g1A==
X-Forwarded-Encrypted: i=1; AJvYcCX5ptMDnErZGrLeTmdOpHXezhdnu48ZPELwZMzmO8buzeaR0w2FoyJAGnY26FJngDRfMbcCtbmedg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOsu/VWmhddq1ke8Zey3x2CDyBr7CV/WWquqKGPwma6OluxyqZ
	BXBEh6k2QFKRI6RQXU4Akk+jGEZ8nPU7FK00BWWb6u+PG9t6lIEhRtxXYQpDAw==
X-Gm-Gg: ASbGncvP3YndgvStyGrKhu+oVIqyIfuwnB9ah/Nyqmm5sqqpzqhP9JGK9lQ3PpxbJ/J
	ubz8UNJ+lfl9JylJIIpTifszpknaAaXbXgMHILfGo7SGRHBu6+Ue6Em7WJWpkd3HXX4WpbtXiNV
	yaF5zur1jkhUi+I+F3YU00iM8APdpr/P6lG7ig+mPOB2wkO1y6NcwtD+sxwrU1wyQrkMGN4NjsQ
	ZNEqrzDb9Of9lQhKB5dwXNEsXaRNA2lKCjMCi7Ban5yMGDpCCUSOnfzMVfq89gI6h+cO7891mvI
	MUESVI5NrWHuSxM8neWaghTYy5IoZX6Utlb67m2zqtMAdhIleHbIK3hlZDP5R88TT8+wEVaxFxH
	lEh0aoGeCbxx5Z15vqaAO3dR7QAhlL+Q=
X-Google-Smtp-Source: AGHT+IE6tG226p8U2j8J7QUEBsfL5Q4SzQz0JzTkVNSqDcfA3J302DZfTEABr71yEKF6aUpkT+tYMg==
X-Received: by 2002:a17:907:f818:b0:afe:d055:7531 with SMTP id a640c23a62f3a-b07c3841de1mr564966b.48.1757613435970;
        Thu, 11 Sep 2025 10:57:15 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:15 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v3 0/9] power: supply: fixes and improvements for
 max77(705,976) chargers
Date: Thu, 11 Sep 2025 20:57:08 +0300
Message-Id: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQNw2gC/5XOTW7DIBAF4KtErEuDwQ5xVr1HVFkDHmwkAy44N
 FXkuxe6aLtsl29+Pr0HSRgtJnI5PEjEbJMNvgTxdCB6Bj8htWPJhDPesbNg1MFdSsm6QcpenoZ
 yFCeMg3VrDBkd+o2iMG0jlQHoTqRAChJSFcHruVKqPaYN4tuyoZ798Ru8JaWHNbwXbcTFZowf9
 XuNaOz9q+L1teTZpi2UVW2cmzr9V7ncUEaxbEclzNgK/jI5sMuzDo5UPvMfsmf9n0heSDiP3Ch
 oZdP1v8l93z8BC4lkDGUBAAA=
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613433; l=1912;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Plmdu1fxwjxVp5gRnzqd0H2THbz1pc3AN+8geukbwMM=;
 b=Xu0hQXOl6rwFqcVQmgIv/BMndyYjvKAZ9DZIYi2N/YtuBjelB/hEfnfIoLmLIFWlI9soY06PD
 87zeasQ/iQvCNSn38ShMe9al5DYBU2SHvyk9hwnU6s8pbBwvwTETzl/
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
Changes in v3:
- move interrupt request before interrupt handler work initialization
- Link to v2: https://lore.kernel.org/r/20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com

Changes in v2:
- fix charger register protection unlock
- Link to v1: https://lore.kernel.org/r/20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com

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
 drivers/power/supply/max77705_charger.c | 396 ++++++++++++++++++++++----------
 drivers/power/supply/max77976_charger.c |  12 +-
 include/linux/power/max77705_charger.h  | 149 ++++++------
 4 files changed, 355 insertions(+), 205 deletions(-)
---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250830-max77705_77976_charger_improvement-e3f417bfaa56

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


