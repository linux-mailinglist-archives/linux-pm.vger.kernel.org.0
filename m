Return-Path: <linux-pm+bounces-12363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F1B954D5A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA4A286400
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF51BE244;
	Fri, 16 Aug 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlY0dP8G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3A1BDAAD
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820983; cv=none; b=UGpqHVqKJyv+juTpjbEEvdSQvlUHVgLECJMozBZT2pFwlnVJ8CEBIuRXN5pNrTbpTzC0343ry3WLr6B+rr8+wP7nrOpAfrUf8qHfIOHVCq70mocPt/RwbwYbDLAe1FgE4DIBeuFXthTuGXyUSWnNJ3w/Ea8DpSVKtkXZQ1V/i0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820983; c=relaxed/simple;
	bh=CEjcql4r8jrN0HpKHlQy9SWhvCfWbDDbc0f9H3G2KSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2pYVr2KgPAmMRdMV7zCQkS+XfuRsgQ7zDHgr8qEAD9xTbVtBjvsD6GT3OZayEfLZOV/zDbfjgtozCt5i0SHMVx5Tgj42YPDQTH4anNVEfr/Qp34UWaFJXDXpwj8DE0dRK4PB19dSdJq+TYFTql28vTxwHg8nhqg21D+it1ZuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlY0dP8G; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efd8807aaso2851012e87.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723820980; x=1724425780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbmbkUcCYIXjsRgrPS/3FHLQvhhOEq6OSnn8VLc5BA8=;
        b=jlY0dP8Gytm4C5jvW0XvkzV8S7Bv6+nYQ1L0z80eocpVlTKd9f/GJ26nI8jq/5FpR7
         JKa/2GY+e2HqZ0b6i7lIqOe7Xsvz9brFsnXAmAFmsw6w54UM2rISmsfbSJ2rJo2Rr2qc
         bMIEzqnaO3WsNojRZdSGQe5Uj96HSsT4b+eXuV+JtB1ej3n5Q/hV1Vt8tUocgqNMO8GD
         GFB6Et/SDseXA9isXRCz2WM0gRCN5hy6RRjWaEcCDZAkbyKCN3xK9diH6zZ1IIFrWWug
         cei0/NMdPyQ6Cfh5lwuCClMrzwGo1RJ63rZ8vhePS5UFKHPUjf++lZetb76Ql5CDc17i
         h4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820980; x=1724425780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbmbkUcCYIXjsRgrPS/3FHLQvhhOEq6OSnn8VLc5BA8=;
        b=QWM16gugK45YfEmB0a0vXZq2Fee6VXfKNApJACsqmWtvft48nm7QEjohrfGaCqS8H1
         B3iY91w6U64p12skMJvxYIJvFZPdvyivQd+HNtNrg3PWC9+mOVNAQcBaMmfw4L9iqP+Q
         56/eJtE9RPVNChoBQin54AlkKtRk03AIm+rZI4isivlv2VGxDyzpJ3VM3BwfcpWefLsB
         jH6Tt+V1U6yDLl9gjOR3Zzybp7BxPYnrIs0k0m9/vuvrOrqfxX7DzQXQUBQarXt6S8Vg
         60rXoahbuaS8UH/W3pnyGI8ytzzLaIpWiOhgI5P0JAVOwXx3ROWSe/8gAkrpGBMKred5
         zKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLCC0tgvdAxDT22xnzLebBwz3e2NWNpwCoti2rAfbGZZ+iQrzhQPzERVhqM+Irv109yYflNxOQvlH5p9wIuRgyiwIqiTP3VAg=
X-Gm-Message-State: AOJu0YyUGadt2QKYJuHknuuA7/vNtQSlu8/KYsj8O6kzt13SsptszlIf
	by6Sq5PtHRutoZJEULS/0LxqLyZbkiKS4tDpmMQ/xXSfj/jKbyv6QslfWt1sXIM=
X-Google-Smtp-Source: AGHT+IFmY/sEGKzTKMYSCVLBNr0cmG/bAj/lYGZIFzFIBymPr4dUDTzJ6fAp0qTNkGSzAxbZDMsqbw==
X-Received: by 2002:a05:6512:239e:b0:52f:c0ee:3b5f with SMTP id 2adb3069b0e04-5331c691494mr2172309e87.10.1723820980087;
        Fri, 16 Aug 2024 08:09:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984993fsm3808758f8f.31.2024.08.16.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:09:39 -0700 (PDT)
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
Subject: [PATCH 4/4] cpuidle: dt_idle_genpd: Simplify with scoped for each OF child loop
Date: Fri, 16 Aug 2024 17:09:31 +0200
Message-ID: <20240816150931.142208-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
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
 drivers/cpuidle/dt_idle_genpd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
index 1af63c189039..203e9b754aea 100644
--- a/drivers/cpuidle/dt_idle_genpd.c
+++ b/drivers/cpuidle/dt_idle_genpd.c
@@ -130,11 +130,10 @@ struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
 
 int dt_idle_pd_init_topology(struct device_node *np)
 {
-	struct device_node *node;
 	struct of_phandle_args child, parent;
 	int ret;
 
-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (of_parse_phandle_with_args(node, "power-domains",
 					"#power-domain-cells", 0, &parent))
 			continue;
@@ -143,10 +142,8 @@ int dt_idle_pd_init_topology(struct device_node *np)
 		child.args_count = 0;
 		ret = of_genpd_add_subdomain(&parent, &child);
 		of_node_put(parent.np);
-		if (ret) {
-			of_node_put(node);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -154,11 +151,10 @@ int dt_idle_pd_init_topology(struct device_node *np)
 
 int dt_idle_pd_remove_topology(struct device_node *np)
 {
-	struct device_node *node;
 	struct of_phandle_args child, parent;
 	int ret;
 
-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (of_parse_phandle_with_args(node, "power-domains",
 					"#power-domain-cells", 0, &parent))
 			continue;
@@ -167,10 +163,8 @@ int dt_idle_pd_remove_topology(struct device_node *np)
 		child.args_count = 0;
 		ret = of_genpd_remove_subdomain(&parent, &child);
 		of_node_put(parent.np);
-		if (ret) {
-			of_node_put(node);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.43.0


