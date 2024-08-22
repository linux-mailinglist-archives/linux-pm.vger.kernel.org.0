Return-Path: <linux-pm+bounces-12740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEA495BA5C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A828F28679F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7EE1D04AC;
	Thu, 22 Aug 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lSC0pPIt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54981D048C
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340524; cv=none; b=XsRDqQDAQap+xlBtRPPvD9ydkDinHfCOvDHYB4sYYBbIaajU4Q2/T63e141g7hdpYmqGYoiG0wECSTpS+X7WbPhUhYq6Ac0dX/n0wqb22sYufVSN8xj6wtNaqgdEfJmlVcyXkRWAhwV+U1tTlMzl7tEfIYRKzm2glyoDqXs6+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340524; c=relaxed/simple;
	bh=qfMyBWF/BL7cu1fLu2yMExkkMJ+Iv5WKiP7iKrRAAGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsJ7BTFqeRaX2EkJBbaF/VDWzr5Yu6+PY2ZvOhkq+iVdFBkq1PZYrTsrFBV7UoM9QUctcWV4SZm699lRn48ux5zOYCFtxmT4N14MmHcK92sPPqi9iHlKlQ/m7NUxlEVLImGJ3rPAZPOAlxq6B1ooRBvUmxJER96+bnSzhL6sHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lSC0pPIt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so128653766b.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724340521; x=1724945321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSWof3eimbYWdm3Zde2Iz4BDEJwC1Ylc5fdAQ7iNZKY=;
        b=lSC0pPItQ1mmbd/o/QKaAbzFexzBwZt/gpoSig4MEDA4mHOPelhwzMiF/rZuoZInu/
         VBmHIcOAZuBPYPociUCPZ6/i7ddtKNX9wDIlf60CRd0/o2UD5NIFX8FeBseGM/bFzcq2
         JZhSDAJNyfZP6dq9l39kgZg+aF08Vps8GNna4ZLCpuX21L3Nkzuq5/EGNLoKMjFs0kPp
         JdXpg5t4kTjozpqV3botNWvrNDrSihivB48ih82yxvFYvD00NQ/DCIxaifF5s61+OFVB
         VRKjzGxHaUxqJS5eazktQEb/1jl4E9KpvgEahhoq/0eUjAAFhLgyr4LzKkVWByARNMq7
         /NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340521; x=1724945321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSWof3eimbYWdm3Zde2Iz4BDEJwC1Ylc5fdAQ7iNZKY=;
        b=PgCTEqavSv1AdFjRlQrejYaqN5vsr8luAR+AoPuKallq8VXFckHRMG2vuHNA+nCMgM
         TUxE+DFCXd8SAjZ+dgXu9geM7MeaxcdBHN77AXUOCJtAsvQM+hGF9yyqw6KhTpnpMpzo
         uny3nUu6Q7/Y7BmpUkLyD/h+OlpC1k86qTmirkH+ouE6MaadTe36iIUlqmHbXPPzNI6B
         tVRMUSdki66ZvmbAGXTkcBsgWVUCHkxOcnUddZeoA5xWmg8TpfFhwqFDFIh33pKJ1sWi
         F+OLSAJM1RS5DUgczeQfc4UEkbaJbZTd3EEy7koWc3bJbnymebw+eFVIFAdmSuGesXun
         or8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnsE3KUBzX0Aja8aAvP0lNJ0H/fQkRE/l86TLXwQFY4EbTGmq/Vwrrii6KDr0R3CmOTrlCM4HU5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFLCtP/YGZLU8UBbfvBrhGGqEdurZ+Q3MEFMMCYkbbY9Q1uo9
	d4Hjuh3WbypfMrshBtuK8egcRFePv81kQ46s52lBcmdCM3eX+X6TQiT09rUjOl8=
X-Google-Smtp-Source: AGHT+IEBQZ1FZ/LXCGsRTtDo2mrL6RRIsqfYVgMxLk7cvYuAGygDFmxNvFc2QDySBzsJWYCvzMOvmg==
X-Received: by 2002:a17:907:7214:b0:a86:82e2:8c64 with SMTP id a640c23a62f3a-a8691b5c943mr185347366b.35.1724340521191;
        Thu, 22 Aug 2024 08:28:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484dc5sm134189166b.171.2024.08.22.08.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:28:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com,
	ulf.hansson@linaro.org
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 12/16] phy: renesas: rcar-gen3-usb2: Add support for the RZ/G3S SoC
Date: Thu, 22 Aug 2024 18:27:57 +0300
Message-Id: <20240822152801.602318-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support for the Renesas RZ/G3S SoC. The support is similar with the
rest of RZ/G2 devices with the except that the RZ/G3S needs bus
initialization due to hardware limitation.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index cf4299cea579..58e123305152 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -583,6 +583,12 @@ static const struct rcar_gen3_phy_drv_data rz_g2l_phy_usb2_data = {
 	.no_adp_ctrl = true,
 };
 
+static const struct rcar_gen3_phy_drv_data rz_g3s_phy_usb2_data = {
+	.phy_usb2_ops = &rcar_gen3_phy_usb2_ops,
+	.no_adp_ctrl = true,
+	.init_bus = true,
+};
+
 static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
 	{
 		.compatible = "renesas,usb2-phy-r8a77470",
@@ -604,6 +610,10 @@ static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
 		.compatible = "renesas,rzg2l-usb2-phy",
 		.data = &rz_g2l_phy_usb2_data,
 	},
+	{
+		.compatible = "renesas,usb2-phy-r9a08g045",
+		.data = &rz_g3s_phy_usb2_data,
+	},
 	{
 		.compatible = "renesas,rcar-gen3-usb2-phy",
 		.data = &rcar_gen3_phy_usb2_data,
-- 
2.39.2


