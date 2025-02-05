Return-Path: <linux-pm+bounces-21398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BCFA28AE4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1619A1882C1B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85941547E9;
	Wed,  5 Feb 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol2cnhJn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE914B088;
	Wed,  5 Feb 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759966; cv=none; b=uG/w2F69KPfqDK2nGMdJyEIarmaiqKyuO1n0etSEmSERa+5lRurfLiWeQtHTGC7TAag6qQeabMUWH0SEAKsJxEnsES7qiFS++fI/GG5Zg9y0PRP9amKB197OmDSdSWmhat8uCbIfsCyKthmZSd4pWaLD3ceRH+1/wMgozYW5VcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759966; c=relaxed/simple;
	bh=2AZBpi15m5l7/gbXPtdQaBFdRVXHrWkje2q20fJpylg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dg2eSfEgHowK3ASzmHHQ+bIy0gTV/triY1HfGhNTj+hA35OmWk9YlMj94nRogf/4uriI/cMYn4wlecIL1qgL4ihfkxjBjW020hoc20IByK2QYF4cSxyXBKNskoaOC5jmm5tUQSU5MjU71j7aMHVjV50LyaegR8l2E2zYic+OFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol2cnhJn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dce3c28889so363406a12.0;
        Wed, 05 Feb 2025 04:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759963; x=1739364763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrjpVKFbSRrE6vHiGeiawaeS65c9c+jYODEjMxySj+o=;
        b=Ol2cnhJnjoH9dDCc0UrRe/n5EbTVgnT3aURHMMUBYesNH8ySQAyJaYP+oVzTmT+Dh+
         i8GDO2oUVEzspOfK4NtL71UbomHQEsU9QBDIazsHFab/jWLCEcsfKHe8oc/ijxBp269R
         mmMZVIJ6jIxilOZ92tWR6XscRoO/i1DX0cpNcFYbscMQTZqczmaWcJClTMgnFk77ilfW
         PaQEDktqcS3lSTlUmwemwtOF/4VAOdeRjoJ9R7OhBBVnSBWwKHdYLtCEze0qCJK2IPqE
         wV7V2unfmgHotFJsJ3iXHFSYOMoqyZCNilZi0OMZH8sKIEX9Eo9QZUnLJkxkLe2GR9wM
         ZB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759963; x=1739364763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrjpVKFbSRrE6vHiGeiawaeS65c9c+jYODEjMxySj+o=;
        b=MB1xwCIKEWgAlES53DzuoiMC5mXmEzhQkSguGrHfgPpx8okBo/GJf/TaVoFGjb+HLd
         WXl+ePQfsO1NtKudRvndKPPt2mLvrCmQ0iAqoBu9sjhx54DWQTtus2n29tAkiXZD6S+/
         BWTwC2QFd7zBySbZbfqB4MOyWBXJoqTSm4NbLVm5yXVtJ6lGiRFseIwk4S2XWfXPXPd1
         sfdh5PJRTIgU7uMA+PhCJp5Nx1z+VpFNY9aJnXM5h4T0APTNN75YZjfBrfDFUpdfmXy6
         3GMk7L4zfC5MOUTzJL6P0J6bzlfBFR51pdeCltowiS5bqmFtBXDG3MKXL9gKnXZJzW90
         vlCA==
X-Forwarded-Encrypted: i=1; AJvYcCUEQ4AHDFPUq68TbegZt3J8YlfHdMbedGsi7vJ305mLouBz5G3TauZHN5Vk7r0w8fhC1kc+bdCExAdxxA/B@vger.kernel.org, AJvYcCUIbmtLQWZ/j8CVIozlTL9+4JkRnYtKPHa3Cri870/ZDJpqL4guDmeCMq6iMIZB4VzvZ5aaD+jb4yU=@vger.kernel.org, AJvYcCVSeUeN2aCtdHETCVowLYzzWi69nr+ew22Q9zFgYkoPLz4+nny9igudvAYiZNHCcc3UaG/wRKtLt1QH@vger.kernel.org, AJvYcCXm9S1IabR/dDI+L/GRl6u/XiYyePRd+R3WGeCHce3c4y1ScOqRM9JQZz4webDR2llcFYs1JNri8sPJdg==@vger.kernel.org, AJvYcCXudzL6eKsiBKRFyFP2xjp4QQsH+S/EpQBuCi3YYjCTIN/aD7/jTya1uwi0NbxooB15/I8gNktDRbaw@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4w5LWFwEDq4x2ti9KNL1qgo1XdHD+So+D9b1RGTYrmBEMAZj
	m5hAmmp1xLoXroxBI6WjA77G27dUHrVHuHecp4ORaErTdh1dxp0W
X-Gm-Gg: ASbGncsPujR45PVLl1NZQE9yoo7vxdYvYBjqSwaOrjn3M3I5SPaUaru8nY14wLiv5ex
	N+wyn98R361QozsXej040r5koUhi1VMzBcfM6NcHrSaGewAvJkCHKO0wkuE5m6I5hXgRQvAJvRG
	GR/biePHP+J6roPlkmZC/FVUiw/Qv0RsEfiHZRkDZq+0C5HS8w3+vz5yjkGcRLuVKxnPnSx6nu/
	DQ2q6Nc4m7BpHCgqNOwiKMXbpt1++R0ZvboKs16us5dvTU+Ar5Sb2Y09TzeEqn6tp98/itIZrOI
	FSSJCeHcp4kNE/o59fKpvx80LpcRY5nJbEM2qIJ52/Y9Ww==
X-Google-Smtp-Source: AGHT+IF6zoFHYoDLjXMYqUkNt9+F9g1qPDmsrM4f/DRoKSMpr0i16Ws07ZzIUfLBaqBzFn0iR+ySiQ==
X-Received: by 2002:a05:6402:5d5:b0:5dc:7464:2228 with SMTP id 4fb4d7f45d1cf-5dcdb6fff0bmr2892117a12.2.1738759962631;
        Wed, 05 Feb 2025 04:52:42 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:42 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 08/10] phy: allwinner: add v853 usb phy compatible
Date: Wed,  5 Feb 2025 13:52:23 +0100
Message-Id: <20250205125225.1152849-9-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205125225.1152849-1-szemzo.andras@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V853 has a dual role USB phy, similar to other Allwinner devices, but with
only one phy. Add a compatible for it.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 29b8fd4b9351..1610501fb8bb 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -1005,6 +1005,15 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.phy0_dual_route = true,
 };
 
+static const struct sun4i_usb_phy_cfg sun8i_v853_cfg = {
+	.num_phys = 1,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.hci_phy_ctl_clear = PHY_CTL_SIDDQ,
+	.phy0_dual_route = true,
+	.siddq_in_base = true,
+};
+
 static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
 	.num_phys = 4,
 	.phyctl_offset = REG_PHYCTL_A33,
@@ -1041,6 +1050,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	  .data = &sun50i_a64_cfg},
 	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
 	{ .compatible = "allwinner,sun50i-h616-usb-phy", .data = &sun50i_h616_cfg },
+	{ .compatible = "allwinner,sun8i-v853-usb-phy", .data = &sun8i_v853_cfg },
 	{ .compatible = "allwinner,suniv-f1c100s-usb-phy",
 	  .data = &suniv_f1c100s_cfg },
 	{ },
-- 
2.39.5


