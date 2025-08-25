Return-Path: <linux-pm+bounces-33011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6496B33D06
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00E37AD749
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C72E0408;
	Mon, 25 Aug 2025 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHTduqsx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894E2DF701;
	Mon, 25 Aug 2025 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118457; cv=none; b=F7eu2LbhG2HUOykSfU+kjLF8+7yNvmGiaz+xjIbje37MCvCL+aaTF3QQOL9OqEusvzYyOIyIGL6DyKBkMISPy78OCfzU+nN0xGD4xX5fMkUgtEfq12IvEjOjX90IVB5A15H2jo2U5lJkLntPbYJKgr1iqExiL8jNTu4Y1YZYhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118457; c=relaxed/simple;
	bh=gUmQ+Nf46bwGxjK8pVp+PQhFLZpu+LepZfvOsoRg3wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To3YubdoyP07aNQCV9vBVZqlHVyfXKSn+AYtNU6gM6xhUB3KpAMov+tMyMFmgxqCpVnMounD80qxQTp0dMBXt+oQEQaUakLVW2mzsw0X5t9NFmOP2YD/uQrLyoUczaUnPhHEBH2Fo0IHwLCxTodSZTCfw927erHBBooRnmXSSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHTduqsx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78c66dcso579393666b.1;
        Mon, 25 Aug 2025 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756118453; x=1756723253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/qizeYAvE4ouJx8E6D3heoPlpVqhCwX4j8ynBkYKjc=;
        b=lHTduqsxsufeHg1+vhSYK5V2d9H741V6m3wJtCs8XGjotGAgh+zkSGD51cC3o0dLuI
         qAK/595gBex5WyRjAKx/IUcWMkgJSPBBtJGVxN+8TWlqqskt5CivE8wxp7fhtkAMWRjh
         0pdRElyDXjnQsT6jh3+WxdiQaRB5a4bpd2DtaATdfZaKgDefbjgiOoTw8BEyWZMzB6Hm
         KFZ7MWa6siI8b4aieJOpuDd9XRa3TnKkTwJCbCmZTZ/w+GPUA4lHL83ELFjWEuM177Gt
         jdUsEnJaRSEVm+CZTuWvLnBpmmZZlhGHV9f3qeq5hir7dzmTzaLmGkcsZDSxzlZW5Ddt
         oX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756118453; x=1756723253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/qizeYAvE4ouJx8E6D3heoPlpVqhCwX4j8ynBkYKjc=;
        b=D2Lbsac0yJlUUxkm0YqYe7tAJAapd68zN1x5iMMXH+DYLtYJlAM8QFUEj7bRL4KJmB
         NK3xh/1JGmTvzfp9y+pD6IvRPEPzF/aJnLwifO25zMHYEwWCM1BsRoA0R0uS9dCpMxxm
         Mj3IJaIDy1gj6F7RNNHj2EQ4Xu6ZVPkTqtaWTcFH2IzptHP9mgb71qJWgFBW1NrHDv0R
         m++sGgM14UJPhgc6p+XcIaq4BVq/iDy5D0PGZai6u4o/wsp7VRHvwymRLEH1bIX+4iNn
         D83BHb3jeQoWRNa1Hf/Qc/ot8qhI+qnOfRLKc8WBRH2Zh3iHtJNkeWiOcS4ch2ZcXzPS
         M/cg==
X-Forwarded-Encrypted: i=1; AJvYcCVlGrIULCLFELDgwPb3SmH5yu0NVHxAJcpmaJN09XUC9qgFOflO9SMlvvLSzSlXIw4naUM/PfFkKJYWGbQ=@vger.kernel.org, AJvYcCWgb2J3eCAMTY1FPCJUFM9A4MpN3N4QyYe+yOo4ZJTA60oGA7ztHWCXZN+eZICAUdNme/Vy9uDqiX15ijzz@vger.kernel.org, AJvYcCX0euy3FaVk77er+AY5FPY0AK2Yp378ABG8Yhr75FHrEgG/h6ll4UoJBT4E+DsPh1Fbzr4qXtC94Sgr@vger.kernel.org
X-Gm-Message-State: AOJu0YzLO7IXsfljnKCQagmg2H2iSG1pC/4TyLxW6tfni9ndzBWGrorJ
	5p2BrrdJpaXm+K1WJTkLFfDwxbVEfX+PFmTGzuy4G1NCt6H/7Ge++6d7
X-Gm-Gg: ASbGnctc/kviijG9ge/j+FQlKahDrSD859g5ZflQDLaqNOBjgwe4qGpfXjydIFnO//7
	YNGrUWBClY2vq/26q+Y//Bsiq9G2pqK6WU6QAkz5xW4Pz7dz3voziiUnzOKYh0OKmZYxCkoN4fT
	nVnD9pd8Dexz2iuPzcZY8MSFNpqsVMnR2KwsBq77Vs/6tjm4Wa8yIHOp/OCu3ddObSffwPNIGUv
	MUwka5gPomqWMATuvF/5WDewJSOQrEbu8xPF0IgtMvj+c7oE+EIKYrPeHeraQIpGzk8tsJosAeG
	YbzrX3C9UiIxBFNWABxiIv7uy0oAZU6lhyTvvyDZHOIGs5rDZZpvdpLhAtHlBUzKoKox4EjBJir
	kSRb7AOm8Q2rzDQ==
X-Google-Smtp-Source: AGHT+IGBeiEhEejt8YHJ6sKKYFMjlFHRpzqgxuKF3WkFLDUjedUVpHRu79+/uIv8WkDg+Pi07J+ahg==
X-Received: by 2002:a17:907:7b85:b0:afd:ff8c:1307 with SMTP id a640c23a62f3a-afe28ec571fmr1082375566b.11.1756118452699;
        Mon, 25 Aug 2025 03:40:52 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc0912sm531683166b.42.2025.08.25.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:40:52 -0700 (PDT)
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
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] dt-bindings: thermal: add Tegra114 soctherm header
Date: Mon, 25 Aug 2025 13:40:24 +0300
Message-ID: <20250825104026.127911-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825104026.127911-1-clamor95@gmail.com>
References: <20250825104026.127911-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds header for the Tegra114 SOCTHERM device tree node.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
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


