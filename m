Return-Path: <linux-pm+bounces-36815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFBAC08AE4
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 06:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDF9D4E5139
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 04:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F6272E45;
	Sat, 25 Oct 2025 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+YihWyp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E872261B8F
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366748; cv=none; b=cDDt/mP/cN4BId1wHNIxnFzjYPqdjBOUV07W5G2dEW+/09Q6oVppkqYjqrKtohY32Kg6fYiWNJy3U8KCDhnRsy1ZxZNfIhip8CvNMOeaUj56FmZ7l+2lZ1nHGE5s7zByGlgFZwjJ3wmDIiPqMbk6gnMYnItpny6P+d4MpG55ScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366748; c=relaxed/simple;
	bh=OXisvb9gi/TE1J28fYKNKmNR9Heo/ymBioo9V+DNdQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSiyxSGiNFrZE/r0VfgAcUr3z4cRYLk+UbkWq5LGA6RQ/y/nMyrs7IsTbDqas4yKCTqZBzFMjntLjkSaoy1IvTb2G2Z0bCjOpBoHEWbF4oVD+Lm9AjxFudpHNn/Unp1zClv1O/V/GAk67wQawDbwzbchYCfjo4DWaHEEzAOD/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+YihWyp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378d50e1cccso30696891fa.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 21:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366745; x=1761971545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw4z9PVBnrl74pcQ+V85ZiVa2r5TmKnZAhW/Uv6GfHQ=;
        b=R+YihWypytT+BYopJ6H1ko8x1lvV7sFSCuzdQisFVc8mp0p3RNjyiL5xEege9jTbbl
         eHY3wcO7Z5ugKxaCIeZmPBt2j7QRzMJJgmL+H0W5u5JuWNj8/9RVzrkM8yw9Zh0HwMC/
         tsAbogbD88rNrUFYB25YI5xVkB6AdcOGQuQwaYb8mUlWebEtmyhN9fhIKDxUc0wON/nB
         98Uk9TQZtJIdeTA4m9vSNhn3QAKd3ihv431BYg107Wcqv2XJ5M980JCR/UlqEnDOQrTT
         4eaAI/eZkqsxSfd6+CIDe+HJnWBlVlV9fI5q15fM+wHIMXnR11bkS79UhID6agLnAkyN
         uQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366745; x=1761971545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bw4z9PVBnrl74pcQ+V85ZiVa2r5TmKnZAhW/Uv6GfHQ=;
        b=pO2SnPrrNLy+RWjfqgHUqmwpX5mlpRuhpb8L3Dhi9fdLg0VJCJLejt5x8t2/gF9mxl
         /VJcnV/NUvfboLOGm1k6qymdLbS6lhuTO2BUaNa9JfQnChrEWrpeIKUEblOkI6mkleHz
         ku43wQrBRcHOO+THYSenoeY11ciqkxKnIwcZhj9QYw7E+QVx/NqMWIlS71DtlZcmZ2+7
         Gx/IqwKyM24hK9kK+obnaUItEZNG3cArleG6rl+gFVvxWVPqsqqNhXrtm0cNCIQkXsQf
         pDhTUfpzz6pXm+dVv52pkGFBIUL48C9TAaTBLU31CKuag2w5+DpYR4/65Qbm0gZpedao
         dj1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7+wz9yTz9S/kUc+oQO+iYGPgcz2AkPs7i0LXgw+W9x1WkT6QStRsinLAtoDb7fpiJIh2iKZBj1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTUHh3aqwPiEORxal5spnU8wMCLok5EkuAyyYu12B+eiCXu7F
	AZAZMBx83SaBL6L+r0NOpVDNjQbP4C9Ssk+Qo+Evi+/pro7x633YvhqI
X-Gm-Gg: ASbGncsUeZ0OU011d5Dc804MF6ZMOwp85BsJhmO+l8Or4ra9YNWiJsoCDGxM7aE64eg
	5/wAoU+Qk2wM0i8MAcNA8oYaSv0qGVG2zKB/LdIOaLFXDypDHJ2l2AzAalrhJGUIQDCXvCMmYWw
	cEXrTTVDIKeB04GxmDjo4mXZMUsFOVxJ/aar7HPCtNVRoWPDTTjXA+Nuiq1RB8vG7Uz3dwDI4je
	zyUmDrpSI4j6DJ/8IvYoHRdJyXM2l8DaHA5Dw41CgKWfeUiExlLrvYFRx2SumJFCIMmXsTtgaCy
	dw4YsoPkQOiK1Ak3xi/Qry4052cvTfk6MbhKqqES1xsio04ThYjJjOc+O88+jo2wLXunwUFawtm
	7HbMrp4IstHlqly21DnOuYvmTyplbSi36u0TiLRXmbjITNE4A4ID5ygRVsI1gcCeTN1yfTg3WI5
	+R
X-Google-Smtp-Source: AGHT+IFIlO0Xnz3NfsASBS+sA6Ogolz52/zgOOHUf1BRiQNX9JIhdrYW1iCIFtP2vXKndrvpB2lUXQ==
X-Received: by 2002:a05:651c:221f:b0:375:db6e:fac9 with SMTP id 38308e7fff4ca-37797a0dab3mr93162251fa.31.1761366745177;
        Fri, 24 Oct 2025 21:32:25 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:32:24 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] thermal/drivers/sun8i: add gpadc clock
Date: Sat, 25 Oct 2025 12:31:25 +0800
Message-ID: <20251025043129.160454-3-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025043129.160454-1-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Some processors (e.g. Allwinner A523) require GPADC clocking activation for
temperature sensors to work. So let's add support for enabling it.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 226747906..c02c398b0 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -66,6 +66,7 @@ struct tsensor {
 };
 
 struct ths_thermal_chip {
+	bool		has_gpadc_clk;
 	bool            has_mod_clk;
 	bool            has_bus_clk_reset;
 	bool		needs_sram;
@@ -89,6 +90,7 @@ struct ths_device {
 	struct regmap_field			*sram_regmap_field;
 	struct reset_control			*reset;
 	struct clk				*bus_clk;
+	struct clk				*gpadc_clk;
 	struct clk                              *mod_clk;
 	struct tsensor				sensor[MAX_SENSOR_NUM];
 };
@@ -417,6 +419,12 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		return ret;
 
+	if (tmdev->chip->has_gpadc_clk) {
+		tmdev->gpadc_clk = devm_clk_get_enabled(&pdev->dev, "gpadc");
+		if (IS_ERR(tmdev->gpadc_clk))
+			return PTR_ERR(tmdev->gpadc_clk);
+	}
+
 	if (tmdev->chip->needs_sram) {
 		struct regmap *regmap;
 
-- 
2.51.0


