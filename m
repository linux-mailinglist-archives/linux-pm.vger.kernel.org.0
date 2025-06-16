Return-Path: <linux-pm+bounces-28839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55CCADB71F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A3516A01F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA50286D70;
	Mon, 16 Jun 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyoHsJ+c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD728751F;
	Mon, 16 Jun 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091935; cv=none; b=R2K65fzt9vRyqTmodaniBAyJroSeDQnHJnv9njLcW7UaFzclaeYS+d9JED6mrPwHSdXyevN1ldM2mqF07QBXJRnc3huz1KFZhmMqB7TRuZ3Jbj64duV6sYPcxytILiS+3uN+UxzvfNlJOmIHByo6jiQEoLa1nXl1GVBc3HAi41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091935; c=relaxed/simple;
	bh=wOqPeUwPdUqdKZ7+K/uvr4WY5Mk/P3mjbO5/Bdwu+UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kARh/IPDL7U3RMvGlZMdHMudXUaabcI6q3RqSCe/VzL0Pz7TEfxcn86ksmWP1h0Ad5tMJ+Y7yPLO9QAYjtsbHSll1GiBDLKrZjc2j9agOyMLsfxieWGfbCu4jreQSULGLhm1IWx2JkLVy5QwynZem1QJdTS1RYZcunWrk4siQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyoHsJ+c; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2f62bbb5d6so3764199a12.0;
        Mon, 16 Jun 2025 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750091933; x=1750696733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sWs8wQgAGPAM0o0VVdnXAORTFo9mCsk0jubxv6TpMv8=;
        b=IyoHsJ+cBKsSPYqWD1uSQxoimjtUgAY2bX31ytL4TMad/IeyMmLUJbGnjiHd/22C6R
         hBJ3MnWZwvNWp0UcIzOtzQp8v7U6BLTl7QmrrjUYnB8UXDgXsxL3DaDVuzMl1jfKAWkm
         weBj4WrqGKwTLoHyh+sM5VQ4e0/sV2aa35u/F8RrJ2QPvOjKBbc/Hrl4Ely+aySSixUX
         ziJtG+bZlih7AakwOoppNx0faejbRpWlLK7/1Yd7DValmrVyFDVNDkwNOOAGaO1xMTGf
         MfdpHXINpwxyQ1sJC1UenizdrR247aJ/uKyaWMpWjlTQ08qJdXFzrTZoRjZRNbNZfoqD
         pH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750091933; x=1750696733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWs8wQgAGPAM0o0VVdnXAORTFo9mCsk0jubxv6TpMv8=;
        b=eDKRLavLnVWrS3x1iLe/hJssSJtWZQ8YyXtZ2SE32lJeNUJuVZFUsbY2Hl8WoKBwxj
         /UeVO9YFzUtA4qwXLpGDrP2xV3U6rgovCL32cF/kCGgMCUbMRZX8J/PQnmmOIVKp8K9e
         +tM+lMM1iVcaagnpOXTijsMDMAGkc3qjQZB0RcuHhu713UqjLoS00BBmehpXsavOAhDx
         Rzq/B3iPITeth/4ji81YFekRrx9JflIabFoEuvwSb+YHD+B1vRoJiiyAsfhPJ7sNOem2
         BcMXSLp7qQFLjFtiocswMCllq9sCDJ3QjxwG1WoobN8wOrJQyB+7TX1DP8uiueDIk50s
         m+WA==
X-Forwarded-Encrypted: i=1; AJvYcCUwJYIDurel2ukAsHsk0PXdOApPXGa8FQMPwqXNmFRLXdbvX6388vE7uJd6kgeeUsceHYTArUXci1s=@vger.kernel.org, AJvYcCX8k+iIRsg9cm8rPpyr580Ns1TMutwAAKfHRd97WGmUdJaz4wjWKvmndldB71RREW4rImNYhctV667WRrPX8uOoXIA=@vger.kernel.org, AJvYcCXstatljnVst2K0AUM1uOh5AT2Z2be6VITBGamn8///ZnOyMZLFApAAWR+E9Tvr9LfccdEJjGivBy1Yuns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qfZejD2M0G5tGQc1M7iBt/gEkuzbcTLT9kkuUY7s+Bj+aZM0
	TgU9XYBxwj6fmHD+tGRezTOHbyCSTXrd66/4PulGoNYHX8g2eQdczync
X-Gm-Gg: ASbGncuAhzNe2u8/KbgoySOrAYyeloungCukRyDhgA8s+ca404eeMg1rDGwm1mnmp6x
	lOnYwisWv8cnz2zoV3nAwALgaiBaKATeomjrSzGr3jJjf+/D1gwU2tRivT4ltKxg40BSmNqMKfp
	jVtue96GETzpP/8CBEnl46IQl37H9SLhoHjMjlQM+fqK77ujtY6DpU9SjaKZSQaEdpSdgTbkwnW
	q7Tg3dOLR/zGBweQLy1r0F2gYMi0c8vEmRbW+wt2YJbopzwvQi4FFE79EQTqnflV0Hi0i4yJ/JQ
	3dFIc0z3AfJJ9U/r73vO2bEkc5ikcLho8uYZAiUDaOGAVL0hFm4/jvjQxQY2p59U3wAC3KW2JJk
	=
X-Google-Smtp-Source: AGHT+IH4xd4I2Qt7PPA+9XeEa/AfXG3Kby6dSj3ue9eZ8UR+VJKo7fekmIJ/oBsPB6H67fFEhSIn5Q==
X-Received: by 2002:a05:6a20:a115:b0:1ee:e20f:f14e with SMTP id adf61e73a8af0-21fbd668cacmr15317222637.38.1750091933163;
        Mon, 16 Jun 2025 09:38:53 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c6asm6067882a12.42.2025.06.16.09.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:38:52 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RRC v1 0/3] Simplify Exynos TMU IRQ clean logic
Date: Mon, 16 Jun 2025 22:08:21 +0530
Message-ID: <20250616163831.8138-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per Exynos TMU user manual the interrupt status register, maps the
active rising and falling edges of interrupt to the appropriate clear bit,
and writes it to the interrupt clear register to acknowledge and
clear the interrupt.

Refactors the IRQ clear logic in the Exynos TMU driver to eliminate
redundant code to use single unified exynos_tmu_clear_irqs()
function.

Thanks
-Anand

Anand Moon (3):
  thermal/drivers/exynos: Remove unused base_second mapping and
    references
  thermal/drivers/exynos: Handle temperature threshold interrupts and
    clear corresponding IRQs
  thermal/drivers/exynos: Refactor IRQ clear logic using SoC-specific
    config

 drivers/thermal/samsung/exynos_tmu.c | 118 +++++++++++++++++----------
 1 file changed, 73 insertions(+), 45 deletions(-)


base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.49.0


