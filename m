Return-Path: <linux-pm+bounces-37810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E2C51B6B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62ABD4F8125
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A7730C606;
	Wed, 12 Nov 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCQpVbi0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0430C61A
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943363; cv=none; b=ujMSHGQReOD0kZt2UW3SrFkdG9k4yPqSR6FIcdseOnsruYqFg/rPFQZLJAtzCqn9/nFNC6aiZcrNGv0qoH/e9zlHqx3fdbRbBZ5e136blp2Jpr2yVOxEVeq9CElEBMmibQNLxD+IAHCWdyZumZq7V6j2gfiVc23lqs4J32dhxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943363; c=relaxed/simple;
	bh=76PxURYmEkrXd49jHKzYAdKAFjWhYTCJ1RhdtYUjsPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f6+r9BG91DVv/fNEF/C/tZyCpyKNlwcGNE5qN/dh+linU6ua1awXDfQFVp9Ub6bAgzKNZyVCqc/ClYMHHWCRzS/EQGDS0RwS2RmKY7ynyZoIgM6RVqff4/8w6xhjaUELUild4AQNIPL9Uy6A20OEWq5EagXUlshO/nxDIx8JKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCQpVbi0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2a64d425so83860f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 02:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762943359; x=1763548159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8jg4fyhHK5uMCop2NLzryAbGcboP7rROBOu0cvEZn4=;
        b=FCQpVbi09ltfLl2cxT/KRsNbYos9wPP/m7C9mJMkPJTO3JeZ0e6OYNyBA3z/QpNdLs
         17YMXKj1bFd78KjvKM7Jfd62qQE7ut5kTjItagaqiNv2sb12c75phLnNqsbqUySV6p0+
         hnsGM5x9z/qIQxHWHzyCnhRo0g+Q9rPU/KK2YVV5c+B9MYDhctHJa8DpkPnqfcJ8M/ii
         XyM0c06S/vdp6yXgo98gotq2u6TIelXJI7yJxe+AH5ljcpysfHrV6hWmaNXQAvBdHeaQ
         3dbbCvQdIX1ojgLxoxddUm5s8s+arIc7ijz+ndItN0NsTi6PpD/akKRONPWw6mFrQVdM
         oSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943359; x=1763548159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U8jg4fyhHK5uMCop2NLzryAbGcboP7rROBOu0cvEZn4=;
        b=Efl/872J0/5CFma6nS1bTge6K13JO3h1udsKTV4+uDPe3TDrLkLrBDxT5bSLyNsQSj
         7/rbUouk8u9bfI0kySc3c8dqFekQpcJiMLhExHqg9ABJFLo8RYx8rdwMB+rFGbEXLHx3
         eGzC/WiyfA3r215/PrDk/x7kIpEyFDe095yVg9/mJoikYrOc2ulay1CWm9o+ztaNDV1e
         DuUVgBg2U+YOXDZos46ssQN/w8DIQ6X9mmgFzTae/oAsNn3gNS6ENCB2NF8l0BcBdCUY
         EDKX5y4US4RJA227I+PX4YI0Vm6KJTNArPqkT6/NEyteTq/PeMhDRMFPSCZb+EJ0zuPn
         d7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuR3IFUtDnWEik6tWppFVk5dAVLhvRzECnzTVHoc63za3EssGBB+xAAyAqV27+ks5JWrirVA8OYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sSVDOJAqhiOKjidxqPO74EUOUYbuwr/s1iqJUJpEv4LS2oET
	coN6f5GCdK7z0DIobjk7mK7Zc09lZg43+OS11bBDU0ioUVYkRSrP2rsa2OwfWAhnoyk=
X-Gm-Gg: ASbGncs7kfKpOeXwk3OhfcXCR8NBK+4uiGFRphaJtilu+9aMp90JPUJlEDiNw1s9poc
	X0llXk9k5NtQMhQhlzs/QxIb/ok1TT+dTUlf5aDW9mw/XZ9a/4wTTNGHM4JWxII4rADP7yBDNAl
	XDZC3seGRd90r96890zF/YApLZqpgamCajQtYaG61wjQAky0I2gZ9puGPSHlCO0aKlF4AuDgpgY
	zd+iNG8+SEjLJt75iHotFDKeo60oCsWGkvAkSjkf8AGgkbeWQsktezpPcTOG9JhLIor5aT+7pvR
	hdcVM1FZWiHsPZTEIJd/g9lxgHeohAUNe/b4H5cecDPu6Hh98EpD+mFQBDMHhwj8RVWGKcYw1fn
	OipT0tHoKLZGgVwxyMGLmwOpzO51+kovlAPDgA0FGDGA++XwBb975C1/DM6MfN1gvlYG57sAqLl
	PqxCYnw9SjuJMm3FX+
X-Google-Smtp-Source: AGHT+IH9dewJqjj8SYnFozQKateD7TpVTHzXgt+iynxiB/fNOTE+IYg7qo1u8nzX9n/vnCz19PQWWw==
X-Received: by 2002:a05:6000:2885:b0:429:d084:d217 with SMTP id ffacd0b85a97d-42b4bafc1efmr1083179f8f.0.1762943358928;
        Wed, 12 Nov 2025 02:29:18 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm22020001f8f.45.2025.11.12.02.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:29:18 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 11:28:52 +0100
Subject: [PATCH v2 07/11] irqchip/atmel-aic: Simplify with
 of_machine_get_match_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-b4-of-match-matchine-data-v2-7-d46b72003fd6@linaro.org>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=76PxURYmEkrXd49jHKzYAdKAFjWhYTCJ1RhdtYUjsPQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFGFpX1jjPcusmg50wHzOU9s2cVSWN4IaAHruN
 86AKqHOsG6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRRhaQAKCRDBN2bmhouD
 1wQ7D/4j5UVIKbJRO9w8A/0yMrLCvPEecWg0ZVm3uhY6KWZuKJ7g7X8XApS2waMecdLjYgfJ+Mq
 FJErqOD754bWjWCvrMpGFDDTACuKG5kWu4KyAFSYY6OR/QJEHzeOU7vJ7e5diotyAQprTJNCbnw
 NrwQ8Oqdt4HHxddzjRU2vG/95R3SSf9chkV+zMquFDmCbgBjoM0E3K1nVfwPGxeiIjjBxDyQFjC
 QHHgU8PDGBvzgFiWDJMl/Y3vjIktjRH1smPAj3Pjo8nHuVWCm3smB9kCsLbf1zoDGRouUADSczt
 Ez4C2udeHvfVvbtGK/tw24fiNbjNyvf/70X4gvLOyFhxIjNJvweSvvBidb8dRaw9NKWdZKlSpei
 9xVbbkfadrlo6R5yj0BfQuoKTaN3evRfHbwbKhUdQk/xXuxYHmvTkLf2/NdP5PVm39XqAZlvS1w
 +zDkmj7vlRn+UnyGifq/6AmencCimfySoC8WXsqmauZrt0HXqJ9/QoE+jst42JOgIEaJAOvjaLD
 6uZx+80X84Oe61Z6O62nPpiJZc1xSVyQubCjuoJkWJwTTwWluvapigG3/J5odPXBFur2fjDFogi
 wcd2JpItBMjyw7Vhhku/q+Tf3t66l8EB1oE5fYxYFtm/XQEGvyvI4u4XW6HH1Ny8xVFFaAjVajR
 kKm0RPvl0lbiiLQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node, matching against it and getting
the match data with new of_machine_get_match_data() helper.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first OF patch.
---
 drivers/irqchip/irq-atmel-aic-common.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 3cad30a40c19..e68853815c7a 100644
--- a/drivers/irqchip/irq-atmel-aic-common.c
+++ b/drivers/irqchip/irq-atmel-aic-common.c
@@ -187,20 +187,11 @@ void __init aic_common_rtt_irq_fixup(void)
 
 static void __init aic_common_irq_fixup(const struct of_device_id *matches)
 {
-	struct device_node *root = of_find_node_by_path("/");
-	const struct of_device_id *match;
+	void (*fixup)(void);
 
-	if (!root)
-		return;
-
-	match = of_match_node(matches, root);
-
-	if (match) {
-		void (*fixup)(void) = match->data;
+	fixup = of_machine_get_match_data(matches);
+	if (fixup)
 		fixup();
-	}
-
-	of_node_put(root);
 }
 
 struct irq_domain *__init aic_common_of_init(struct device_node *node,

-- 
2.48.1


