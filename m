Return-Path: <linux-pm+bounces-37553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA7C3D2D6
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 905F63522B5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB5357A4B;
	Thu,  6 Nov 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ur2QlCq0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AA357A28
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456110; cv=none; b=clqEJsDFbpizwD6egaljYRnrXzQ9z8A09Y0/bxg/udIHaSsoWetnbdF66J8AHziBL6u7pdXJ5MZdyi3deOSoYIoM5vL1V4vjyYaVKk9FYskMHijKcqu+ojxVm99aTMNqeC1inUXMuM4ZlxME1JcGQ+P+e/oV1A9vrnUK8rhpn7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456110; c=relaxed/simple;
	bh=em6T/0hfaUrxxPHQSOCVHJqt17fZcoSzBpufVPMk75E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esye7+OhwgzoHApFT0RBxnCituDHxF5MkfldqTjRSeR/jkNz7rI4UOwRpndhEIWXYSgcsWQj3xl9/eidB+mc3X1rBWxAIJlnE8bjMvp/MxvtgGnK0I/q+IyRHDL0BJ7TJtteoEcYdXqNKf4aZbAG8KSrRBFL8c0uBUjESZjhNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ur2QlCq0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6411f1c4b4fso231890a12.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456107; x=1763060907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFhUWdS232/zvQ5zx8YGxHTaYNY9a/jDdBok4SLTbUo=;
        b=Ur2QlCq0ik29I9065yrZX8pGcAy4KLJfXQcFRn0IllUo1D+SF98qQ+QnVFdRCi6cFl
         2mAM8N7jvIdZAA97AlUZU4ll5Bu/OFJx+IYTkptxqv1A4dnMwLJ12PMyFfT8Ol8Fh9UG
         kCMlk/hiY2R65TKOp9ROfIsKUJ0n/u4FkAUm7jiwtLd09a48ccspztfEgjg1CW1jtEuS
         AXgOID7XiciDjMC/nMt9wKRFOYCBjuO+zmh5YO2YZFpB5YpZsIuKZdXsuSfAPU+pDZ/t
         K1tdaFWDECiQdPmRcjS0sraSvMHRaciRa3Y8e/O/34dgDeKzr9txD8DxfgHwXaqU35nE
         RyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456107; x=1763060907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eFhUWdS232/zvQ5zx8YGxHTaYNY9a/jDdBok4SLTbUo=;
        b=vZ4g2aI8ELsfAyr+vbordWoZflaZf0ZPHAq2KTuFRGIkistrCn4sjH9SgMNhbkDM73
         Gz8GH0DMPihp+io0sVWnhNtOMQXlR3ypOhsSYU4N3YnSjfIEmwS9VtQRUe2Kah+ti1gn
         iLTZf8hrg0Lt2qifhaU6085CPqX8Gl3eZPROpuAEq1xsrZzaWOqQ1NrHv1KMBbLBXb83
         td/vmqX1Yme0EcsXjr37araqgllYbulkXuws0luSgxwNKxPYFGZdEkr25VtaKS+zb7vZ
         WXnEFtYTriTe4PaXKUo+HtfreZHeWD9yXdef3leP2uBYRXnVfmAumEayKNi/LvPV4bnP
         KBPg==
X-Forwarded-Encrypted: i=1; AJvYcCVieq8FGJF8cx5wCsslhRBSDSLXoKc2lhX7itTnkZYMvfUm6KlCJz2hTXxOy+s33C94DLdMKABqcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbHMdFZDWUvyQl/BqlCB3Tv1r/KagT/AylMxj982jYahB6wbF
	9NfWCPYXDg2agaj+X5OnEW/r/UoB+3jEm4zIBbzar5Ylxoy4ehKhaUTn8ec+LYB7R9Y=
X-Gm-Gg: ASbGncutFuohVWFU7/kXJyXyOfIdgwx36Hj4XjsMkc/OrqqEtyFFkoC+VcpZxLJduAt
	Tgc0DrJQ/1pOLrlMk9QGp2TdCz58442k/89mc0esuG/78TLnFQ1pUJJn+LLdJfBCOlJ/CAUAf4C
	DjYcj4HkllfHMozIgLtROkF45gFLzZiBNUI/nsiB2tdzgGWxgEqYYiWjMgEwxIiD45loyJlX9Ca
	nG3gX5zk4oDXClAZftwOE16DYSsNtipJgatThizlHrR0cEV/8toOOIk+2bgJ/v0OCCZvbuqwEPg
	3HfsZeSdNGxk7BBmwcdakLVOT/upUP72t7te9zSEKMoBiZBttBzVec5YQt9fgDTJSlQz05nEUW1
	gCSmJjAcauLgX0Rk3lFjVZnPFVu2CYdTcFUVqqBffoly3Bf4vhJ3iTMG+BSi0owBN7KFBEjvt77
	3QPwd5h3RC5dAzeUeA1JVq05PIXNFZyiNnjpguqw==
X-Google-Smtp-Source: AGHT+IHV0gcmtT5dHOFz2RWdjjPo4Ym0Dxek/nZLw6T0N6UfI+vf5qBD6z9VCh47UKxNTUDt+Fg2GA==
X-Received: by 2002:a05:6402:1d4c:b0:641:2a32:b8bd with SMTP id 4fb4d7f45d1cf-6413f062ecfmr273551a12.1.1762456106689;
        Thu, 06 Nov 2025 11:08:26 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:15 +0100
Subject: [PATCH 08/13] irqchip/atmel-aic: Simplify with
 of_machine_get_match_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-8-d780ea1780c2@linaro.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=em6T/0hfaUrxxPHQSOCVHJqt17fZcoSzBpufVPMk75E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIQPP9Q0idGJx68rbMt6LPDzi2dtyc+qS5Mu
 2MGYLCnw72JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyEAAKCRDBN2bmhouD
 19RJD/0S4D7rWxJnMM5I0ZYvnbWMyO/Pj+zZl5eFKXP8jMODrKLvsKA6Fg3LnSAdO8L+5R5rOrn
 4EUnjlQYlM54t/RRDk+Nzjd/KH48/DE/2WCAFiGImlDsuBP056TT98RR3yrY4NzyX24N/8z3ax3
 8GZFPox1BIaAcX+3EomDyR36I+92AkCvbnhnFPDKUTooHlSVWPX+K3FdtM//a58/chL6TZ86jq6
 1SgBn6KYSc22lQ59475GTGt4ta3S+5ZvHrQi2366EGm69VLEQq9Ysm+AGe/x12eHW53kGE9p0AM
 wapt3PIh/Lvpie5yT6jh7TtmdKuIaka3XM6EOgFwnkDLzsSGOZCBPg2Rcpos//m5AjddN2J1KGl
 0EZJIVYOqxPDRKY61SJacWclPPPmdC+hJOMGk4tr4v3b3IMuXPSQOSyZSkCuum4QMkPYk7LPZO/
 MVGJ3XH65qFgUsUwv7MGHHUkz2dgMMvzpi2oFBbsriL+FY82SE0gsjda3sfKcjj4IKMEEb5wCRu
 jHeDHhMGRpgqfbXiosWKNkJQpOp4gHIsuCueX40vRwcWy89afIZXxJ9cyXTBcyDrzOQVF6NovFl
 9Nz4nRsyPVVgw3gPqrDfWqzQlrFQeSwu5UTDL0iIWxTLElBqYmjApnQ6PvZPKC1N8OTCYhLlGUy
 JC6bgRbAddOP0nw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node, matching against it and getting
the match data with new of_machine_get_match_data() helper.

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


