Return-Path: <linux-pm+bounces-33217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63DB39360
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50A2463CA3
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5427F754;
	Thu, 28 Aug 2025 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkZ1sFli"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380027B35A;
	Thu, 28 Aug 2025 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360284; cv=none; b=qdEWy1+IEqABLcOXTDTvRf7UxvGElRgk+NpCHV2NIF3K6l8iAZYUMXCG2+Q1N5g3g9FhMSMydPQGhJ2UR/0MLVObhLfQ4u+/6BwQegq54xyXezWNdb1FqgNvmneF5zxCtHLPtWIr6b366Sis+NsDJ3WBwoiO409uIE2O/atZrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360284; c=relaxed/simple;
	bh=DF8GpCCH2Uf6fqT6G3C68pdtEHy+WOYbHHpFjwYTl6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIfhLhaLkBHNK64TtcOE8rQfs6edHKq6WPLZMHUCaxMoDY50oT6yDUbaIX+P5PsOxsZf4eBxfENHmK5CkdtSjYmEchQ604MOaew8rINPUEvkoytihsWA1747s0USqHn5DI0HfB88K+iVwCsgm8YTUUzmBPSTcj7D75NAggj3V7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkZ1sFli; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c325a4d18so891800a12.0;
        Wed, 27 Aug 2025 22:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756360280; x=1756965080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPmCuO+4/dk/m1MTp+3/jgQL3yO5A6BRwl+XO7yexR4=;
        b=TkZ1sFliLvIY/h+KMhEeJDcisfDA0i7HZVJUDISkJxq4VEj2Y/dtnJnutaDdDP1wqA
         nFKjuxZWHPBmKupPLF4XJi+W1SD7i0vTEoFlrRumfnCk76pIr5U8EiEE+IgbfyL8tAvq
         N6drLXT7NLKXmc3xvHLZdK+qJkhu81Gxhyu6qEc3JTmNKTOdazE5xbTtqBbNXzq/rK68
         mAxt4Pt8e004YHCYT4hg+DlZalH5auPvcn4+A+xWV8ZHsewIzBeCu9ODO9HKZ16GtaTM
         c4LUC+Si5e1Qk7XoR58BHYrTvXhy519OPGFaETbX4/bT5WLj3srKirqXXP5olOgUBBgq
         Kt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756360280; x=1756965080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPmCuO+4/dk/m1MTp+3/jgQL3yO5A6BRwl+XO7yexR4=;
        b=OpqlyXATMn+dhaqbZSv5aVuuLoCQPhw04LDN+hHg70M0saQuzwT4xSEaCcUaqv+qB5
         hEYp5sNqMM9RWNFlP9HWXjT0sce/n0Mm8SPpnRktGOd/u0EbMy1jF//CCqrv+HoaIb8j
         Gjtj6smV05cz9x44T73Zq93eZNjsOvZHrQfMB6f0PzbMUAclQ8C7d1q24cpf6JHt+43Y
         Bua1abyG5HbTeqgy1raxQqx7LgLpHYxERkQXJWVQfR4OFbXgoY1IdxZDBTKY2fbcMxuS
         jQYHrI8Q6dTzM2/sxAw3j3eOB09jxC9jTJBbQ52zUzP39dv7ia5mQvvi6MQzYz6FWXAQ
         ZSEw==
X-Forwarded-Encrypted: i=1; AJvYcCVXpGwCugmECqI3JVaNft1XcgV1/7KWzKk8Q+vOnJOaBQ5ZLkwltfq7AANePOelzwlOlNGspgkbcpWL74s=@vger.kernel.org, AJvYcCVn5aLyAvD4YI4grYIZecAHXGaSbUzqdFlpY8O9v304jbuJ86NI47+rgy8xZM8KlBBghXq1DAVXPqXq@vger.kernel.org, AJvYcCWkjmMprnOZWOaSa6JvoWoXwl8iJgRFyahB9UzkWiKrs8f07hXAs2ZDoMN3ppyHl25l+tVmv6bEpsP8i25s@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDlUZjGrDkAFmpQTnKmevY7DqT/pefkojnUEl8d7Nx9CzxTgb
	a2FAXUrbkFRj8nhxnWphYSVAid4uVxLytJbwiwpy4IT6jP6KsgTQu3VU
X-Gm-Gg: ASbGnct8cu/Vz3sxSoWDD1AQziNdZvAfjptkWIvfdbGB/dc2B29ToOKt3sOLEtPx8lw
	O19mGtcENZ7vUVOiXfESMrlXEFaRUIwregQ2LRJpgupC11VPSQVnevcBXkskN7xi+95delV4xZX
	9bnq4ruuIslJreVJx5hY9rN/dX9i2T6AziTVfEckgRXrLEtsqkbm6eb1QwUhTvyFrKbZD8LGwk/
	Cv/ceTXLmZrccLvuLDJFbX4/yxLW9lmdEEQ16wsuEEvM6wm14ST8HsrIUgEOmtMHQ4jw4iP5YCz
	PNPrB123pz5ETsdYGBGVSeCufdr9DCaUpXhXLtLdV7cRVQ/VS8XHLih6whNIg+a8arCDkloHlGh
	KDv3anC+FnL3nq7pKguwUeCggljNYYfS28uw=
X-Google-Smtp-Source: AGHT+IE7Aq5Yy9+wSte1H9puM3Mza0TduVuheBApOB9oAQQPUK92ho92GaSRIBgYQZFOcTvDCpnsGw==
X-Received: by 2002:a17:907:d1a:b0:afe:dbfb:b119 with SMTP id a640c23a62f3a-afedbfbb9abmr145757266b.1.1756360279608;
        Wed, 27 Aug 2025 22:51:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe72c35ebdsm927942666b.7.2025.08.27.22.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:51:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] dt-bindings: thermal: add Tegra114 soctherm header
Date: Thu, 28 Aug 2025 08:51:02 +0300
Message-ID: <20250828055104.8073-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250828055104.8073-1-clamor95@gmail.com>
References: <20250828055104.8073-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds header for the Tegra114 SOCTHERM device tree node.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../dt-bindings/thermal/tegra114-soctherm.h   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h

diff --git a/include/dt-bindings/thermal/tegra114-soctherm.h b/include/dt-bindings/thermal/tegra114-soctherm.h
new file mode 100644
index 000000000000..b766a61cd1ce
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra114-soctherm.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for binding nvidia,tegra114-soctherm.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
+#define _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
+
+#define TEGRA114_SOCTHERM_SENSOR_CPU 0
+#define TEGRA114_SOCTHERM_SENSOR_MEM 1
+#define TEGRA114_SOCTHERM_SENSOR_GPU 2
+#define TEGRA114_SOCTHERM_SENSOR_PLLX 3
+
+#define TEGRA114_SOCTHERM_THROT_LEVEL_NONE 0
+#define TEGRA114_SOCTHERM_THROT_LEVEL_LOW  1
+#define TEGRA114_SOCTHERM_THROT_LEVEL_MED  2
+#define TEGRA114_SOCTHERM_THROT_LEVEL_HIGH 3
+
+#endif
-- 
2.48.1


