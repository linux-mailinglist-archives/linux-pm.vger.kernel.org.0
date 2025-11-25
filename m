Return-Path: <linux-pm+bounces-38584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 819AAC84E98
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B408E4E18B2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3C3246F2;
	Tue, 25 Nov 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGLz//ba"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBA3242AB
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072398; cv=none; b=BkP6Ve51iTpyFvyAqzZZVFz3XqggfQ9ugSvj8gZcFK7T3tUd7/hSx1oNYbJMktVrhc1rG7aj6/flpOyImewgHXcw6FazmJ3YnAihc/ZZk2rvNvaj6+wDWYUsNviO+I+ThUB+Hju0S0Qi8md4I22Ahl4cnr+TgHLkd2+IY6vZI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072398; c=relaxed/simple;
	bh=YadarWm8iXVMTc3kvOXTZJwKC0IolLXgB3hQl9V7qZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XocVkdROMapXn/DSpNU1773AaIbgbFAksmx63oMGT5zCDq2Wv82ADH0axvIcTGaR9ASQnfGRxpJ8zvxHgWccJzweWQnlBaicJesoZhmeK8GAsICz7o8SJfzakhVIV23DO41eAMVKeIY70H5QpZskrgwTI/P/vIEWWRoHhoVlD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGLz//ba; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59581e32163so6362302e87.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072394; x=1764677194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQWD0QKdZ0TkCEqYFYnGsqgX6XSV5QR52vBKePlFe20=;
        b=RGLz//baihWAjD5nCVgsMTRIlPsz7FlyFz1LidxQXKjMnKJ4XLI7nZblQO4b+W83xl
         B7VVFQy5IMHRgrPkf7qAoP0/Rk/piTDtoOmA07h9Dtk5rQ+ReS6ipC0aWTMY/42jVn3p
         JF8T1Qdi3ED9C5ofQ2ktByJFLjWnStELGOtwZ+8B/6sXVYRy7Opc7XBhyzTmg5iVsz9m
         CD4kQQ2qqhvk1AI1iX759I8SeGp9dSh1S0WYR0WJCVVBIdAsVmLRFVVCfelVubtsz+Ij
         3zDXDNrVa9rDvJGvM/ROWPm9MSkUESuU/w4wO+z13R9MO5EFpDDy8IqZ2hShiiQDct6R
         1sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072394; x=1764677194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQWD0QKdZ0TkCEqYFYnGsqgX6XSV5QR52vBKePlFe20=;
        b=HQa/7sDEtCCQwoE9JPjAI0iNlXz3fD13Mufqaf4MW12sA7odzyqSOdmauj+h+dB6Qj
         KfQHv2SAJrJyAZv2GWnrRvsyNepSuV52uhWHUSqK1xCLpCHUMEgIUYV4J5USWscaYMbF
         YCPu/YHQdiRS41AfH895Uf3ootlXE6rySjXKjowxGYnXukm/mJlVSGPDVZmW5Y57vfPX
         Bcf228snw8JbbGaAthqeJoQzip16OvdwUhkwJPEeTA1bnCMkdip4E5A9RxDBkGfii9q+
         jb+r/Qa1l1SjEWSzvBOVZy+eAjNOL4T9VlYBw+M7q9jLMwl18WXgjQLEGtLOabL3HK+5
         IBtg==
X-Forwarded-Encrypted: i=1; AJvYcCUiFdYcGVr62D0NGbrKVkCVi031lM3iQD/oL32P/2JXec1IuixxANWbxVxAMkFqpaxVGXA6m7f6kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsYbYhZKf/b0oh297OXsZzxDOpIR/fL2sp6ZEmI6PdwuIiFuh
	epTFPmEkzsPJFyCfsrHOPZ1SqRcXB+mKDG0iTy8TDsrnZY+03ksxDis3
X-Gm-Gg: ASbGncvlxxCqMefXG3B9V9ihuoL8MB6+lh8esisH29skDE+wJa8YtfdHcSfkzUBN2vF
	7Pmji3Xq6os7HQ4oHxMAy9NbbAd7FCLr3A7WNgajBz4xJQumVty1/4Tbn+gGFr/R+GInwW67+jo
	QkILZ/CnVVt0rxWxLvbSqW1x1eA3k/FCzIKz1UOWfDgMD5ftpD+5LtRRVGD/qEruA1hr3J7JG/3
	yuf8tYe+0m0Tkh2Raty8CFN23EZXehvxU5wlr2Z2Unmo+YH0agXrC6rg8cFAPv1mE5IE2NomG20
	lltDGgRaxo5j5pjfAj52OFeoK/Z2jgxpD3+4ZcWRqHR93dX8RSHd++vDwqTsg9/vKYonJ0wU1cV
	kqYre/ehvaLrDX0wB+oXhN7GDb9xVO6RxaE4lh3sh6IA+d5BOPzMi7mV9IYxhvGWt0PLvkcOYv2
	o=
X-Google-Smtp-Source: AGHT+IFhS9KE1wuZQzl8w9HsDmWL1weqKWL9f1LhqVtawTbvw8WoVOvtMYz13PNxZKJZHBsKo2LqMw==
X-Received: by 2002:a05:6512:118a:b0:595:82ed:ff28 with SMTP id 2adb3069b0e04-596b5062a6cmr1017970e87.32.1764072394159;
        Tue, 25 Nov 2025 04:06:34 -0800 (PST)
Received: from xeon ([188.163.112.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbbecb9sm5150993e87.58.2025.11.25.04.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:06:33 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 12/12] ARM: tegra: add DC interconnections for Tegra114
Date: Tue, 25 Nov 2025 14:05:59 +0200
Message-ID: <20251125120559.158860-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125120559.158860-1-clamor95@gmail.com>
References: <20251125120559.158860-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DC interconnections to Tegra114 device tree to reflect connections
between MC, EMC and DC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 6221423b81d1..732f8b5b4eed 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -125,6 +125,17 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA114_MC_DISPLAY0A &emc>,
+					<&mc TEGRA114_MC_DISPLAY0B &emc>,
+					<&mc TEGRA114_MC_DISPLAY1B &emc>,
+					<&mc TEGRA114_MC_DISPLAY0C &emc>,
+					<&mc TEGRA114_MC_DISPLAYHC &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -144,6 +155,17 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA114_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA114_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA114_MC_DISPLAY1BB &emc>,
+					<&mc TEGRA114_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA114_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
-- 
2.51.0


