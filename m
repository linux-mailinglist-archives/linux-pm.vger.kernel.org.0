Return-Path: <linux-pm+bounces-7481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CCE8BAFFD
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 17:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BC91C2231F
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E4155381;
	Fri,  3 May 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VeHLohjq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2315535B
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750524; cv=none; b=nVpN3d746k4SWS4NYX5qsQaSnHnDXv0QS1m4LTXeg9gXpntIifdV4e49H8+IEqz7rpnzG3s1ggKK9gK9RPIU/TzTLOppehTTpDPQy9ED+qD/cH4TiWHqAfT1qnH6dR7ZWpWbnNTfFy15omMKONTThM3pNw2XPMhcMj2Hvf9OBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750524; c=relaxed/simple;
	bh=SP42j9CgUufiyxU3nQ+lSzjh2IG6/vPluK3RUFWHhsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTED/uhCAYIU5ea6DN4OSuL4YMckJ65jn1AyC/arefmdRp4EnDt100g1gAw8BC/I5L63B4k+tKJWfyiBWETOAMXwqSjDNhUXXozdhBbXYh/KzrVbdFhzLXxAz8+Ay6IxOOLa5eT+2H1NzC/DkBzocjJmTfXbWKiqW7reaHkF1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VeHLohjq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41bab13ca4eso50308115e9.1
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2024 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714750521; x=1715355321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vEIqX+46YstO49KdzfUit+EY7cLOMRSSqZNN+MC6uM=;
        b=VeHLohjqRINAl+EDgnGS3iABYNvFrBb9ZZJ4TZyjx+vhIp8gvL9vUbkR2g9PJK5VVR
         UY2+Fx8ciREYHiEtZ29Rxm8LbezJ/XPgRidktuFfLRes7KQcEVjNJBi6R6w0HGJVczR6
         4p48TTmYfBpBFh+51FHZEpIJ2jKqFH6zF7kTq3HjHRYW14RCQRznqpUhCOOJlOo+7A5f
         P6zvpsGUiLfhmv58QHI2DEVw+uPujMlctBMyMfIMU5mVAS92G+pj+Z9U69WVnheNFe30
         bH3q5Ux37eDnSzOc9Qz+IPl4JVZimcsvEFJ6s0V4b9mkczzniqfpGulGBm6Qsei7Whhg
         Lp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750521; x=1715355321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vEIqX+46YstO49KdzfUit+EY7cLOMRSSqZNN+MC6uM=;
        b=Um2mA52vif1cGpjCj49vDOTOwnmjqsSs6JWKB2oAOzjESuBRTcgIe2DBgDere0azj2
         JD0kHESJc+ZY2evANCLO2FMZ6dXkZSG3h0wTCuyUZ+lVFpOVTWwIkvhhSHzYtDGE4nlU
         hfyCzRZsGiTzTnFvnwSR7v2xKdyh1E8ZXaLIjgLLZXpSBII0/9B1sAgGj54V+mBfXTSW
         pzyKATzTcGGl4faoynzRubEfjOYQtKOptzR0SF3PUI/jOi5A+ZyXuwUPjBXljpycXBpw
         4hhbS99bHcOCrbis6gNCJrx8HmpBwHC17MP3WHdkrr5XdR3sXeWTHpDYhgWBfMuE6gLn
         IrTg==
X-Gm-Message-State: AOJu0Yz0LROfvcIiK6BauqxhuU2NJQAi5yqRk4Y9LnH6HOGaHw81sfzO
	8gLCWCPUtoH7dyuQWfAWK3FKW3poMbcKtCSRM6JMpZtuoiWRO7lwWjQHAzBpoyQ=
X-Google-Smtp-Source: AGHT+IEeDubyf88dJ1F/c3Og9mfDQHnx2tPeXqImVG53S9rY41X7jlVgH6PBon7anUpjzltE+G0flg==
X-Received: by 2002:a05:600c:2157:b0:41a:5521:d848 with SMTP id v23-20020a05600c215700b0041a5521d848mr2499549wml.25.1714750520756;
        Fri, 03 May 2024 08:35:20 -0700 (PDT)
Received: from [127.0.1.1] ([79.87.205.120])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00418e4cc9de7sm9702373wms.7.2024.05.03.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:35:20 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 03 May 2024 17:35:13 +0200
Subject: [PATCH 1/2] thermal/drivers/mediatek/lvts_thermal: Remove unused
 members from struct lvts_ctrl_data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com>
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714750518; l=708;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=SP42j9CgUufiyxU3nQ+lSzjh2IG6/vPluK3RUFWHhsE=;
 b=XEe30h/H6gys1feNgm+rZLzcV5J/Xy1Zpsm4B7NsLcCwZ4+d8iU7BJcBUbsdUPve9xEvBH2uz
 jqhA/ej8FdcAcU8FzxutsgptICjvq5bkBz5Off897RCh2CtDUcC3LQg
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

In struct lvts_ctrl_data, num_lvts_sensor and cal_offset[] are not used.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 86b2f44355ac..18a796386cd0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -105,8 +105,6 @@ struct lvts_sensor_data {
 
 struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
-	int cal_offset[LVTS_SENSOR_MAX];
-	int num_lvts_sensor;
 	u8 valid_sensor_mask;
 	int offset;
 	int mode;

-- 
2.37.3


