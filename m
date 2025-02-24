Return-Path: <linux-pm+bounces-22830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F13A429F5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 18:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15093A5156
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026B2661AC;
	Mon, 24 Feb 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JtZNii9m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF43265CB2
	for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418332; cv=none; b=qT44bzJg+j28sDRLOJPmDGE7bwG0ww7EFArqK9X3rqHaMfO+ifjaJHQiqHO/yOLJcitvo8V+2TkeTqJc3Zo3XC2vm9heoQOoRuEdT3cL88BV1X0RhJnYdILpx3sY/rpsDIY3uRgFtU21sNbQiFTWV34fDs1qKYznlcGykl5SxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418332; c=relaxed/simple;
	bh=oIB0SGCz6w/sdFWz/voO0kJ/tz/pNsc4Pe98Mbdlmuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q20YsxeC+FieesGTBOjegGl4lcXFoRJt3Fe2jbOLlI+VXw7QuI8e13Sbob0nYQBKymVX6WemC/AEWPKb3UX3tlMY2Q42NSG0wyEj4rSHiup7OqXYLqahrDw84WO+Ddm6hidmxBj5E2W8L7EypbwePrE6yb1NIUphgFiBGT0HqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JtZNii9m; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso6282035a12.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740418328; x=1741023128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhxXNmQS7HiqcndJwzB1tfncWGWAmFhTQNVTNzL+Iew=;
        b=JtZNii9m2CclQdlEmJ8tK24LCj6XEuU3LqkFARNKiLvFT61QPErlqVStQvrREXP40V
         w+A1L3lgCtrozH3xOhaRz66a1n7CuWOfjoHeiWEu3luJbKfzNwOfr1OIhEErPIJI2EyC
         q5nKLA5INTlnHUEjGqBiTJWOSeHI5KelLduYCL/YH+mEc83wq6wIHIOrcCqidREb5Jwq
         Q6VJ2VYZdt1UhkgD+Paq5iy8S6du0Fia9Bei5NSPsCWf6SoI6uQE10+SZoMgEX3ier1m
         tFXMgJlJI8TFO4Ov3gPVP/1aThmsFKPX5U6QEN2MHUxPERrfTffo1f/lhUGEW6Q8WZw6
         Cjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418328; x=1741023128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhxXNmQS7HiqcndJwzB1tfncWGWAmFhTQNVTNzL+Iew=;
        b=IDmm7Ou0+CJhWABZ9tIPxoG/G5Bg87RNtIcxQmFs+LUvsYbxb3ONkhwidBCWmLs1vm
         iwqqWVJcYiR56/NlsIsqIaLmmAal3K+fW86QUSe0x17EmAIRrhabdLj9Llqt1+zFBPxJ
         Snzx8B8Is/3YomOiIA4HKKvjtZDOynHDv5JYL5LukVoXnSmwn3Ha93boMQwdIUCRUrwh
         PjMxcwjRjqj0SBy2rrx0rGhq+ynR5S9QdItzV+B937r04ittKtlOc+rG4GXT6qQultIf
         1GjGyjauP6mSSgKGSPWvkkIMRvdXoZNfabSOryec65vsO61jYUDFw7z73mNkg+ilHWJ7
         GySg==
X-Forwarded-Encrypted: i=1; AJvYcCXJrOAuN5s+HOFCdE5duCdRNhqWZJq7ciB2AjdadM7NMiRxKi0rdsOTUODLWTh+wM2U38R3Ftcbxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjq+6jATyJhHgQMFHsHLdS3PcbQPhJIm/Iww2q9+215JSMv/aO
	G0WF643gKa3Ig1ChL1kcRZBOpwzQeuKn0evMIRRKCbnCnilc3UGNKyuZZQIuLXE=
X-Gm-Gg: ASbGncuiUZgUWjfTRtx/sLJnH40lRhEKKHcZY+7vgs7JiNKWZhnW+3iXogo52I38t79
	vc2Rop6C8NwLUVtkTkTP/6/4fObt/3alVUFpqR8ba/iKkBUTw+GFg9vYeGGntGqw8/RVMx9OHFb
	0NyKdeu+Xx8vopF5OqM3kLPBe3xppRvEnzbuDFx1SG9gWN+U5n/vT4nMbVOtdS7+GxChquqiupU
	sKEiMR0OPGexE/9YScY0KUL0e4WYRuU9a3CRVA7m6sxhT+7syVMvD/kNvNGRWFYDfc4oqYXxrAi
	y81bGnN3fJR/KiGQn4PpFtMj66lhq23G0WB6cJHU6tZmEc5ZI7PvnOs=
X-Google-Smtp-Source: AGHT+IEOW8+Mti0kStIcH2NN1v3JN2p1VlS2xp8UH5KoJEBDGTjvf4FDX9S2JYf1r+OelyXxGOdoUA==
X-Received: by 2002:a17:907:970c:b0:abb:eec3:394c with SMTP id a640c23a62f3a-abc0d97e77amr1259252366b.5.1740418327678;
        Mon, 24 Feb 2025 09:32:07 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270a7fsm18674357a12.58.2025.02.24.09.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:32:06 -0800 (PST)
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
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 4/4] arm64: defconfig: Enable RZ/G3S thermal
Date: Mon, 24 Feb 2025 19:31:44 +0200
Message-ID: <20250224173144.1952801-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a1cc3814b09b..c3336b1342c5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -714,6 +714,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.43.0


