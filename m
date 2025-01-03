Return-Path: <linux-pm+bounces-19950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47FCA00C44
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A043A402D
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181A1FCD1B;
	Fri,  3 Jan 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dEQYtl93"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076AB1FBCB0
	for <linux-pm@vger.kernel.org>; Fri,  3 Jan 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922324; cv=none; b=C+iKM50rh/K7UprqG3RR6a95Nh00r+yuuXFx41LImEilMP8sXrmbUSizggIsDRovjQxWYx1xPK7P9TcP7oPS+xr4c2W1les5C2/W/UEmPvD+VGRuenki+w2Bz55JOE0+1TUzFboEQFv0rXCzq+PLCxwgkcLq+FutbA79rBmB2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922324; c=relaxed/simple;
	bh=ElJIj15I7VDEmOYeFsm2GgBst4b8C7b3V/BjoymFWVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA5c/uHBEqKl1lLIbDTVXxl8ZsbYnXeMSaBkTIKvM63oxA7+mgq7qJZGawd55YY2kJlzjDRt74dMBSHlUbpmYRDx1LwLKQinfyRP6J6jcEes75E/jsrBlLEoEvwJGxOrYw6tq/jJ4weHQnK2GMbzc0vwjqGeinosTk54GhbnQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dEQYtl93; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa67333f7d2so1782077466b.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2025 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735922320; x=1736527120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8obrWVZsJoXmrid0pqmVf5t2hFsLjtOlv8BcTL5IH0U=;
        b=dEQYtl93Df3LWWZvuu5qW2QRtK6fz0b649Scup7lS23/SuQ9/KQDOgPN7ppr1aenF4
         q63qwk7oxnvuPpshdbbfQBsnOPWstop+STH848gnsTIChZgs7WPuo0zdLCkMA3uStnAS
         Vbgr0oCnJlvnaWbGknRBenUL2jFQIYe9jkLMzq8XcmEQHpiBe9Wu0DHc/GalexKHJSrj
         FAFPXpjVMUaRJXki7CvVVxhjHwob84XazPeQI2ly5Tqidrm8uljlEjLdxcIXw4vrFaKu
         JkEjSFQtPYRZFdAA81pzamLW/j/7zFSXM5w812OzwOJ8MhCU8Fx3EgwepehiBHIyuZqt
         6+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735922320; x=1736527120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8obrWVZsJoXmrid0pqmVf5t2hFsLjtOlv8BcTL5IH0U=;
        b=vq9dPPZjcNFiWqjCRfwBEulmdfih4cqOUiGGF/hbblfECmoOxUgZV1Ki0Nxj96LyGE
         jHcWrJQnjAcPtfz6xcqJpZQMfZNrPL3eIoIjlAFrHnrAAt7W7g4GorumOQZx/17agW4n
         0VdOB0WoFQqH2TIKqVHg4z1DF4FEyESvKuCTL+A3hsUW8S8pm77g8EGXUGJ7T3pa7S6w
         +y/m60NL8lfkX43fMduLHeVitQqdWoNTVyDHpJOGXqMndSKxTNvuO6uss9ZEG5rKQa9n
         Ne7bD76T5nq2L4Ay//WgD70d8UF8VPnrA7v8fPvB5BbqKO8h1Ke34imxsq0pR+MHgWVu
         b8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDoAQNQi5CsY6BYAmvAdTbdZNRZAuyrMhpHst6luNdw+YGKdC/dvTNtBl4Tch4zG/KsLxzhBPzQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2NPY4m3vFgGJAFS+ONdPHrATZ2ulEDDzZYXl2UslU+ZbwMqW
	NRC3oeLWh9JMht9b7AcMIIz728qU+lILRBVz8+pmvgwv11ua1+BdZyi+0XbkY5g=
X-Gm-Gg: ASbGncvKTMuHPh86meSSmy2V56yOw9M0Sywjrr2gEUC8gvZHxnRA0d6BIUDU5d8q4jP
	ILwCIKZ3h0K/O6IkuOiwhwZFpUigL9btxvHUTNIMLmDwjbT9+nEkvixFFUHzURNNzIeCQLTTUwI
	EBNPacMz5YzQtHiUpLKe+nnCA0i+cSV5JZ8mEVkE3VunpixdFI0DhOoSgAmMjGdelm8XQkuLGmo
	+tjEeWQ6wvI+PE7VtL9W2tBgbIDf/EWsjItS6L41Y0xYkkww8V3UMZxHQwbY9nL9DYTb24xCk0v
	d5u4IoR9+CE=
X-Google-Smtp-Source: AGHT+IH+DUY6nprcntI+5aClJEE8pz4wAhTYG8dCJD+t8yU/xxOBpHwSJqf9myK1PfsCCnfBeBYRqg==
X-Received: by 2002:a17:907:1b96:b0:aae:83c6:c67e with SMTP id a640c23a62f3a-aae83c6c8f5mr3028524366b.55.1735922320359;
        Fri, 03 Jan 2025 08:38:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8953b6sm1932984066b.65.2025.01.03.08.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:38:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	ulf.hansson@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6/6] arm64: defconfig: Enable RZ/G3S thermal
Date: Fri,  3 Jan 2025 18:38:05 +0200
Message-ID: <20250103163805.1775705-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dfa5c8d5b658..576a544b8c79 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -706,6 +706,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.43.0


