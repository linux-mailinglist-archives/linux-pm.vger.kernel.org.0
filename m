Return-Path: <linux-pm+bounces-20212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98750A090F3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676753A9DCB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D4211A36;
	Fri, 10 Jan 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdtWeqSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07F20E70C;
	Fri, 10 Jan 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512791; cv=none; b=L2sajKKaoOAJc9dhtqtc+uirBtmUgdPZ8V+Sk7xoHE7GT8hSjudMYsCWdp4tVrm6y5gx0pcRlzQ5Cjcb6vzk7VERPDTHIEgEBrP0cp5jqrriXPcTqvyWEmGJqlnOmNsr5op/Bb3sloDqur4ykmaZqalzH9oPpr0FZPWDHxppQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512791; c=relaxed/simple;
	bh=sNeUaSsNfk2mWBS/Z6Pa2pSYUp7Gc/6G9bD5NGx0EYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSKm1WD3UNVcrB5T8dXZhLA0gjxl4iugt8jRLEB1Exftwm0r6oFFTcBCADFOO+tuoimDpU1xUY3CclEX7RxoZFuZIKwZGYq8yGNEHF1KuiMbU23CkINGnp31FFs+A0IMJ9xtlu/M4WyZER0BwcEXUM6a653cgrsLMciZTPbUYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdtWeqSl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4363ae65100so21492175e9.0;
        Fri, 10 Jan 2025 04:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736512788; x=1737117588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEOAzVx6WPB9stA5mr4n7x/fL+LclH0gvOV71KsByXY=;
        b=YdtWeqSleBJ18nLwi0p/vrAcz5gbXm7H36E+U9j0uMdL+1yIUCZvZkXarXenu59sem
         oMs9tqVybHSHPoXVh7vbMUFpqAPz+CrXJH3tXvY45y080/AlfvYBiDUQvnSRvQTAtUUc
         TqxpTnMQAL8ltVinDKfDMHUb5pm9MqjX8a2SLrXTsqIEJwYzNrv/bIUwzA64W/9T8SDu
         tM+Nw4WT/Ua9k5hcQBwGcKtrBYO4VpXZKuRdSVXFQXVLnma87NpUVfrOy4cXb5QIpqmv
         9M3RPqjq1Y6ji2GdxxV0CTneqURQvA7xdph+YXiIj42VnpjN6K3nhcTA2HnB1D8Hadb5
         W9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736512788; x=1737117588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEOAzVx6WPB9stA5mr4n7x/fL+LclH0gvOV71KsByXY=;
        b=S0Nc2GiXoSD2sVRe00DYM7EDrPE5QaSewV0R5YnIlI5ksXm3llPZIGrUzCWdykGXEV
         y45fWIN7ZiOaIKJEq8Pq9AUf6W4vbKPBnLpd+jLcBM6x9Sw98tHMYk0aFjci99lK3e+x
         qLKbP6pbSyXUA52awfli63Za4BCkRmxoIH+y0vj38SzRGSi4Qv/J15bwDwqH8ICk685s
         uDsPq3dy4f4MGh6rOjMGCkgGesvX7WFq1Xs1GhCZqxe78FiNXNZK0gex5yKBPPmlCV3M
         WnQO418w2PzcBzqXsp0f3JMnszAv1WZt48ltSio7e4EstUvVotXdoISV0YB3r/uXYZ0X
         dG8A==
X-Forwarded-Encrypted: i=1; AJvYcCU0DIgQ6lAHTEPPA9Ej25EAabvMdQovpX+nCZBs1wIkK8s8q6VeOBUPOtEHDtv4goINY+rqnNvtA78n2g==@vger.kernel.org, AJvYcCUgN5SGTGVtI2j903YS0J9DLGjdU8KQ+9h2xePohQaiQW4xtfzUV5fXYM8zkgL2FPOuLvk4L5CBTM+fpCg2@vger.kernel.org, AJvYcCUs/8Tm53h9eyIHwlAb55cVBokPBYYIhQwEiAc8+uVd9hBwvCqiGoLoXMmTyS7WmXijYKjhgj5nqWHY@vger.kernel.org, AJvYcCVs9Eq5qbrDlqUrKMNrPKcFh1qV3aKEU0Qu4lDHT4OfVpTjqdL+SaR3eDflU5GkNY9v4l6SDXdxp40=@vger.kernel.org, AJvYcCVvo7U3F09S1uLeN9e/uxrC4KUudG2WgCzDggmxji414M+lqOXLfgRfAzts87w3sfqx4Da08fnr8qYb@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVCHs2bIKhLhmTrF88aFEf6keIS7rME3TTuAzU+PnT7guhXqs
	IZNlpK2ay6LoDcuLp20PPopj/dC2aAmzFDKJD0G8DquPSuYCWkeY
X-Gm-Gg: ASbGncupA2OtA5AMcAWSdh9gNlOqwhsRZQcdIoVJUanvMyapQjXCJKqlnHuNXEIbEwE
	GwCxePN1Qe3cMzalrv5nrDfi8FfQi6bl9vTxf1wEOqfwN2luG5E4kjTzYWW9cauYC5SCFPIucBl
	lz7Ng3QxElgYnSAt7TGWLQ/M4OTdTj/sSKpiZViWDbjch7kOFCdHb4sODrLUqKHjUMQxk1E0FKq
	y0eknnB9ZWqlNO9rCMBlrHYqiEYmHFAVWSSCp5SyA7HIKaMqHJ8mNwj482GwFRB4wNC3jVuFjO0
	4OfbFNnAOb4=
X-Google-Smtp-Source: AGHT+IGYtDeMlu8hfZifmTM4bzi5kVdCz0Uy02NYRi086ThdTGE7sBQII/cjdXeOIBug2nPd3a+1Pw==
X-Received: by 2002:a05:600c:1c9a:b0:428:d31:ef25 with SMTP id 5b1f17b1804b1-436e26975f1mr107396075e9.12.1736512787861;
        Fri, 10 Jan 2025 04:39:47 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm86738715e9.2.2025.01.10.04.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:39:47 -0800 (PST)
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
Subject: [PATCH 08/12] pmdomain: sunxi: add V853 ppu support
Date: Fri, 10 Jan 2025 13:39:19 +0100
Message-Id: <20250110123923.270626-9-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110123923.270626-1-szemzo.andras@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V853 has a similar ppu like Allwinner D1, add compatible and the available pd names.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 drivers/pmdomain/sunxi/sun20i-ppu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pmdomain/sunxi/sun20i-ppu.c b/drivers/pmdomain/sunxi/sun20i-ppu.c
index 8700f9dd5f75..9f002748d224 100644
--- a/drivers/pmdomain/sunxi/sun20i-ppu.c
+++ b/drivers/pmdomain/sunxi/sun20i-ppu.c
@@ -182,11 +182,26 @@ static const struct sun20i_ppu_desc sun20i_d1_ppu_desc = {
 	.num_domains	= ARRAY_SIZE(sun20i_d1_ppu_pd_names),
 };
 
+static const char *const sun8i_v853_ppu_pd_names[] = {
+	"RISCV",
+	"NPU",
+	"VE",
+};
+
+static const struct sun20i_ppu_desc sun8i_v853_ppu_desc = {
+	.names		= sun8i_v853_ppu_pd_names,
+	.num_domains	= ARRAY_SIZE(sun8i_v853_ppu_pd_names),
+};
+
 static const struct of_device_id sun20i_ppu_of_match[] = {
 	{
 		.compatible	= "allwinner,sun20i-d1-ppu",
 		.data		= &sun20i_d1_ppu_desc,
 	},
+	{
+		.compatible	= "allwinner,sun8i-v853-ppu",
+		.data		= &sun8i_v853_ppu_desc,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun20i_ppu_of_match);
-- 
2.39.5


