Return-Path: <linux-pm+bounces-12741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD195BA60
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53141F2279B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5781D0DD7;
	Thu, 22 Aug 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="EjQNyK6u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E011D04B1
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340526; cv=none; b=gR7yJ5cKMbzBLXIpkDZUEwhfgx2Fn5tqpuapyqIPGrLleakLWR+ClE5hm5nqTzgiQbmizOLR3p2i1YmYoabtj+2gH6nEtV5Dfh0Oh2hmVlmkSkq4v7a6qVxAK11IKt3e3gaQk1Q1PRnj1D/NtvTq6Js39CgcqzkhrgshGR+oWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340526; c=relaxed/simple;
	bh=Fdk5QGcF0Of61Ef45y7VdXpM+rCxir0BEowLZBYRpu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VB5r3ClvXZxds6AZ4QmiuLXRfh1h10ojzTT1JYBuQCBGs2tjSabUODnDxPIjwTR6r9zevidPQJiGOe3U8cRZYdXQbekjpyxogQHtZ55IbPZ/QVXiNeOTF3gbwmANDWYvfhcVaj+va7zSpMJX3x54evKU98o7iGA+WreZnwHf/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=EjQNyK6u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so140599466b.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724340523; x=1724945323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWNzbrWT4cjZwlbw/B+Ku5dXdfTILO3SL/AQs9G2I5o=;
        b=EjQNyK6uwTm57ffpzmcg2r9a+thZq4TEOL6Cf3vcKF/Ent6/ZvZvJkbkvnHWh61d1N
         K3NbO/SiWFsTG9+8pz5Jx/H+BKw7ft4qq1kJBUmnoXql7waQYC8zUX1FkHFPk22KttV8
         OzUpEw2SdwTJBEgQUm/shuAFN2onvEwRQNwtSr2aVwDJOdSnGyKeBf5K/MJwzswxN+LH
         0BrAaOj3sLKZ2tCEKZEwIiIZOqdpRQbJQeJ9MQ36xaCKTJShpemhUz7lsa4WJCA9521U
         esrrbHLwdXTxpkfO7dmG9skkMyAQxC2Je2atdaqNiprxy5IG+TIjfTyHNCjhwgqcqvoH
         dxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340523; x=1724945323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWNzbrWT4cjZwlbw/B+Ku5dXdfTILO3SL/AQs9G2I5o=;
        b=fY9EL3UaSe0oIJA9eZJJTNyWTMkJo+idyd6zAnQ4b6W4IY984ur0Z5310eJYiv6cq4
         Kde0FVETi+WrEuNeyPXPgQLjfEpLH16+8sXTavbbl01QQWi8vp/4dbk2o64Hxs5CK6cy
         i8Oq3jWS6yAyOqe0CokoGhsqRPbgK+6+5qz65YIfY0bIZr20taDceWd8K72Aefvd3XFy
         luQdjl9SOqXJp0HrjAn2rMf5D9amW4TOQe9n6CeBdxOIYSj7f0HsBG77n5Ffy/D4JFQe
         CkRSNLIZgVqv7BQ2dJI+qfaZBgkj7kMBLKMEWsMboinqaBE1WY8Kh5XhjG2NWsSTzxcB
         /yfg==
X-Forwarded-Encrypted: i=1; AJvYcCVlAfxPlnCzMUO+fydqRz6VWrkz3/Fx3gdxx5Gm0Xqv2J/XgFhHWqjJ3JfY3QDFtQ89T9cwICorfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjdh0kovR+Cv99oWRkh2ZUALjvK8riZ3hOvojD2kpHisiip4KT
	3EhRlRSFXz+i/sKX81+Zr+hFmWrebwfqIWC7fLDI7sJU2oGXvMLR+kA2d1FbvMw=
X-Google-Smtp-Source: AGHT+IHil/3QLm3fW6hjS77rGDv48oy9/7q2NQAgMRaJIdEszcJA4lXA3RSoaEhwajY77aZMJWnb/Q==
X-Received: by 2002:a17:906:7313:b0:a86:700f:93c1 with SMTP id a640c23a62f3a-a86700fb357mr451883866b.60.1724340523183;
        Thu, 22 Aug 2024 08:28:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484dc5sm134189166b.171.2024.08.22.08.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:28:42 -0700 (PDT)
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
Subject: [PATCH 13/16] arm64: dts: renesas: Add #reset-cells to system controller node
Date: Thu, 22 Aug 2024 18:27:58 +0300
Message-Id: <20240822152801.602318-14-claudiu.beznea.uj@bp.renesas.com>
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

System controller on RZ/G3S can act as a reset controller. Add #reset-cells
for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 0d5c47a65e46..cd7cefdb2bab 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -91,6 +91,7 @@ sysc: system-controller@11020000 {
 				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "lpm_int", "ca55stbydone_int",
 					  "cm33stbyr_int", "ca55_deny";
+			#reset-cells = <1>;
 			status = "disabled";
 		};
 
-- 
2.39.2


