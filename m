Return-Path: <linux-pm+bounces-40865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC8D1F610
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 15:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67A3F301E817
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72C339C65E;
	Wed, 14 Jan 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuL92y/R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523A399A54
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400246; cv=none; b=Yuk66hm/m4Ormu/cYHPcfk0uCBmwoNjR4fZCntsNZKmbqCECzAAroJpb0i0aOkM1E/WXDzoo6DWFKmNVe0qlpwFDxaEjSKeQHi6cZvDsoISeSxreZGvSvhoL2JgYSKS/xRpYBlUXsKU8mBuywgoSqJQ+eYdroCwnh8tuFZ4fjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400246; c=relaxed/simple;
	bh=7HVJFrG3U/QwDFKx95QyYbsMuRfAm1hbMd+GcbM229I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTMcGB3BwWWkBHb9zDGZUEJjpel/ihA47X969ApPRWHYeg/guCeZ+7NQj0BNLCZTKr3ORg2tIILNrMLMMSUYqksNSG5jel//TNIcBooNvCvj84uKXBHoCGy24as6gpCNYo2gQ0GdwtEBXsG4SvYY8b38MJvvhlm9ou2xtraBTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nuL92y/R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47796a837c7so59830735e9.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768400237; x=1769005037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDx8GJwGFtxKfvZU7MLXX1ujE0p+LvEQKHj4ysnyPoQ=;
        b=nuL92y/RyO0fqNxiOicmIEW1aX2Ns+jU4To/iVBRCBti4aD5l56mJZP8oDf4GYNr68
         PYeB3ZK/O6vNLTZ6YVFOMp3S8PzM0B/PCriopBKjDTo9xt2A7re13AS7hCsAH/w2ThcT
         BhK2EBNhEPe3IAwphi4IIbPPKDenXe7F0FvRP+jJxJAn8jxm8ZFChexF3lymH+eId8/e
         t2MbR1pHa/RpmX/wY2l1P8H19Lhwcfb//cyMKrV7WulCvE7+BZmE8oltIVU34q/tGz5h
         aNoz+bujWlIcABYuIDjf1qI3mDXcrb5wtYjNQTqCR9btD3oaRPNqnCVwczw2R54boV+n
         LYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400237; x=1769005037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDx8GJwGFtxKfvZU7MLXX1ujE0p+LvEQKHj4ysnyPoQ=;
        b=fL++IfBBALyKG4lNSeOWNqxmZV6E6kosNPUUyRbsMXPTXl0AgMHt0k7MhH4VS3Yb3/
         RJIKxcdlyS9doZFFkF8e0CSi6tWcF77370Q7yu6lCjZTOTnpWce/+LxWgEFMPy6+jVzE
         8jX+SHerVA9hv5jLO3flNspPT4c1e3iR0hRvi86JVGy/ns5Glg1QWwI6e/x23uQ9idAm
         Jr4zYZ9T4Xdy9hgK0kroVEXgctdd354IYrOPJTP6FHf87/op63GmHn68u1ipQIrderGW
         +l7Qvrf+eP6MgQfTQpkyN4jnKRRSDXUncfbWAZ7V8PbB2BSQDoIJSpysvCMius2JCoM3
         anuA==
X-Forwarded-Encrypted: i=1; AJvYcCVzwKIG3odpvTfwMogOCV56kfQBvcQVFqjUEPVYRvBwtFtLpnLecOkJ8K/3NzAX76eQdoBtLd4MMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylC3Mj9kIPPwAhO/zPhcIFUw2/C7vu4zWdO00CbIr1kQZTYElo
	S/Ajvza+Id+WoqzmCjzURFDH308rg2JMAdHiEBIbMzDMfjpdhewxe4P/I0aZ2qoHNA8=
X-Gm-Gg: AY/fxX5tNEi+H6fuh9xAO5NldeaiqRRZU6l3Mm+aH0/M2IhhJGdHXa9a/T4y3CtOt/z
	dtY1BKfDwNB0spXos+NSL9cmzXSX2JHoUbmYasORZnQj8MgoYqMBsg4xYV0jAr9ZlYu/QaV7QTG
	r22Al0662jWx2ECgxHIw/CPFiu2F61G7tz0eE2o7YhxCbcAYVsOAnZ8ZNkCk3qRXDx8SS0kOSsa
	uRfES6XOEn1Jxr7eGgQ07RfvOtJ2iK3gfmBiYJ5h0MvoEkEVpiuAAcHGVKYkuH+e1unTIY8zx72
	CtUjPVywlQMmJtlWsZNJIzo4huq9RK/ibXh2Cw2rBcIcUZIjlRMAhudpnEfL6aOer1KCcCGhcPY
	IIhElVzEM+38eStTbZJ4VaRhHgMSGx3UWY4Wiw10NcXF67zb8VOsjxA+3Z3WQp/SbsRxpEVCOWH
	CrEu8ePnxQe5kC40NzxzfqBl9jClb4cpgBIE62rc+KN5M8zEbTiV1jSzWgMWxE0R0cmcJAKF+wK
	n67tym8
X-Received: by 2002:a05:600c:4e4d:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47ee331937emr30654025e9.7.1768400237015;
        Wed, 14 Jan 2026 06:17:17 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee57a2613sm29595445e9.6.2026.01.14.06.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:17:16 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 14 Jan 2026 14:16:34 +0000
Subject: [PATCH 6/8] MAINTAINERS: Add entry for Samsung Exynos ACPM thermal
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-acpm-tmu-v1-6-cfe56d93e90f@linaro.org>
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
In-Reply-To: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768400224; l=971;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=7HVJFrG3U/QwDFKx95QyYbsMuRfAm1hbMd+GcbM229I=;
 b=pUkUka+ewej0krIsviJjojhdqN6KPY64IUp5KIuBVVECn9qSsLgLN4eTbUtjxiRCJF+4NmjV0
 aVbDoNVDAOlDzQjkDBwgjyH42sK2PdrvjnCTG1nPFaq9xixN3Ygv0sh
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9de1e9e43f63787578edd8c429ca39..ab44f2de8e8e03ad9bb022ebdf1b6c0058fb0425 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23171,6 +23171,14 @@ F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
+SAMSUNG EXYNOS ACPM THERMAL DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+F:	drivers/thermal/samsung/acpm-tmu.c
+
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.52.0.457.g6b5491de43-goog


