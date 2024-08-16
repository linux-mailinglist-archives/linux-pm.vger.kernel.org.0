Return-Path: <linux-pm+bounces-12360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9D7954D54
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 17:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AD51C2174D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F122E1BD02A;
	Fri, 16 Aug 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7EqRt58"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC21BCA16
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820978; cv=none; b=eYcbZz0rd/KChtCTvg0NOp6i833iHRiLRG2wP9LSKC9nE6GvnPqwA7msLRHL54LbDBH/YQB9gg0e67ukv9zrym52f6bFO3i0E/dS0d7+OeMjnGIfE3vLERYszoxsaZjef5Kb0FvIAEtTIEzq5uQO/YpUAUt2Qj8yan/+KiERmy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820978; c=relaxed/simple;
	bh=XzdvY7dTSy94mw2/rQM0iFi1pa3M0LsbqBKyIiUy9+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a52hxITVW5TXhhu4AaASBlP7zTwPN8jZoI3m87SZz3XeMEgKVEcbrCujs59ZSrAk2D93rzWRen8AGlELBJKlM4gl39mGs3PvjrLvC/ePNi5FNY0iR1jyYwNXblcawzHmvPHDC/0NnZT/kjNt3Lb7bB+eyDpEFgB0ea+GtiJSSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7EqRt58; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e3129851so15427515e9.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723820975; x=1724425775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0sK0ufc7qEbd/mn2fdq4hcobz3MRQ2PN+HK1BuFHRw=;
        b=A7EqRt58KZpuu8L6OoagPNaPAUwSjSK232MEGaoWfylAW460Vb00U5ZlN17Upgg8VW
         G33U4BBxwNrucuhDozqGE/8FQzNi5NFPnld1Z31K6AFMbJAOayEhK6nI0MvIMjHsyu37
         D+LFh/Jl2QvqImFpUYU5TvkQHE9nFy+gVkuZ1BhR/PL3tY3iRE+Uz7T3++Qi+pZ8fdlK
         ywd6SHF++ACZERowTLSQgiWbquKqWgvf04KA9CkSAh37V+BmIM7/gs00KhKcCJk6+gS5
         9HAF5BZ483yrDepzc/+ejCdWTvtyVf9Ku86V1yV0edj4hefGl+NOgQ9LKYQoN7no6yGX
         QB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820975; x=1724425775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0sK0ufc7qEbd/mn2fdq4hcobz3MRQ2PN+HK1BuFHRw=;
        b=YlFGUBUIUPOSH88mBTG9SMIsl88vDoghckJ0fgtTNH3roHQUFDU5WI3vCKE6tGBleo
         lN5kOcNUrG0qAM/Fe1k2zD1IrjMKUzxhdAW5bKZ+Dp3zqVe5noCphGzE2TBGztuxMt6a
         Tpaiab8gKkhl1EImLsHbb54o48PTRz/aiqVA3e3+/libQNCGQrrYEKhXIOMo0AaLof4f
         ziO9tF1O2EqKph1v/SRDW8XAFB99XnSSkKbHcRZKyfBPl2QZa0+4Gl4NT9CUHyCcdmC8
         aQS49h1/ij0ACywILM7BfanfGGEvq2Ux7iFlE29BeLPSasN/N/B5gCw6pqbaZldygCmL
         2pSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUztKbTtIlRDtBQAOf46tbOIoyBUb8ePsxUd80dirSztMc+8ZmK6vyd+Oqqb5L51dS+n/M8n0HQpIl0PZG9tU8JFBdcpppXeEs=
X-Gm-Message-State: AOJu0Yx7aEX+Mz1kp6DEnq806furuIBrtTnc+AmxW+IX6P5aKrmNu7gf
	/MXaKZ95tuJ4gduLiOAm34nXhJ2BFGPn9IhZkHKAIoPlA+bPsMDUVbVuvvFqWMtwdkLRrjSIqnj
	F
X-Google-Smtp-Source: AGHT+IFhP/NIsW9PWfnEcWLqi7chpg87KWhwfD8tKVYrnOj6sJddsAiBh6dq11WCBuqo717hp+HeUw==
X-Received: by 2002:a05:600c:444b:b0:426:6320:7ddf with SMTP id 5b1f17b1804b1-429ed7f944bmr19485875e9.35.1723820975298;
        Fri, 16 Aug 2024 08:09:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984993fsm3808758f8f.31.2024.08.16.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:09:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] cpuidle: psci: Simplify with scoped for each OF child loop
Date: Fri, 16 Aug 2024 17:09:28 +0200
Message-ID: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index ea28b73ef3fb..146f97068022 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -142,7 +142,6 @@ static const struct of_device_id psci_of_match[] = {
 static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *node;
 	bool use_osi = psci_has_osi_support();
 	int ret = 0, pd_count = 0;
 
@@ -153,15 +152,13 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
 	 */
-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (!of_property_present(node, "#power-domain-cells"))
 			continue;
 
 		ret = psci_pd_init(node, use_osi);
-		if (ret) {
-			of_node_put(node);
+		if (ret)
 			goto exit;
-		}
 
 		pd_count++;
 	}
-- 
2.43.0


