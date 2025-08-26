Return-Path: <linux-pm+bounces-33075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C64B353EA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B57B6802F2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A172F5336;
	Tue, 26 Aug 2025 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV8+2Wak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41892248A4;
	Tue, 26 Aug 2025 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188705; cv=none; b=MrVbHgpY9TZ9uqpprSLjh3xx8D1dIOseex8pnCdOwwp1Gi8EVAdmiApQCFWouVTkWJTM0ipw1JKch/NF+FslzF6r6YIq5iORQoQdeXOI0U8nK6RvhzDO02WKyDUhkoyGgkSifzE9ZkS4ub3Ul87Ne/GdEAhnmZPJmUV1uAJ0ClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188705; c=relaxed/simple;
	bh=XPBdPYMVGNUgWDYKxBFIe4S3lmRCWccSl10OwUSskmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onb2FEnlq3NCv84Ikk48QBHKuu/SlP0dFuu7DE/lykeEN0Whrsvwfmh68IE/VcmYAM1bZGnr7qlDo+y4+Xxth1/T5H2ClB6dm+r5k+nbaxl3bJ9QSTcjebv9X9ZI5MCoWgbhx7uVg76S2bhLTUIXyND1/NlA+8eMdyu5GLp3680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV8+2Wak; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78d5e74so993876866b.1;
        Mon, 25 Aug 2025 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756188702; x=1756793502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH/lx70VW7TIKv2dzXIZ8mTA36MYFYqDtrQ7jzkc9TY=;
        b=VV8+2WakNERGSOK8ZU39tL3+OLE5E7WFC7TeS+rYRCKbnZ+VfPd4P7vLDAag78XfHQ
         WUSG68gReO1/yRnhR+9ylgvBjigddtFJa3sxL/xQHKLl8PbDn6fCMV3YYtUz7gY4FeiK
         /6jn8j6sUeYLDbAOF4Xydp7zjtdIF+ikiIYiUyxEhbLh0aJTz1jUrZ/ZGv4mTS/pUYMx
         r43NWFJW1QtG+CQ8NTlPJNIztm3mfndm0n2L5DzNSO/CnT1RqBB1ctGTzk8T1uvzqAgC
         cHVZ1frEaeSTdeS7TeDdirocJvnBoZHtARQ80T1gHWiQqo3sYHjwQ7DMduiDlGb11tr2
         yhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188702; x=1756793502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH/lx70VW7TIKv2dzXIZ8mTA36MYFYqDtrQ7jzkc9TY=;
        b=wWLnmPiIJoZ2R2eLplRDUcEu4m5BdLFAbH5FgQgd/RgPF7WB/qFJNjO1zPoegd5Def
         0VfSWoQxsWIKL5MNfWSmbAgLejB5C+rmcleF8VYpuOSiQsyFxwvC0xPZ3O9Z78tLJw03
         1LfXfhUu2EFr8lMcDMLkxCfldzNns06cCuOuVyXqnoyeiVm9Ws6K9X5wHRfU04m4cIWy
         4sbGtCqtVjspzFYmhPFcCye8foc+GZrKPc4Huo2ES0jtqjCUS7Ax67KO91XHSM27NO43
         m9mMa1lws6ph1USFqpB2gORZdaIbnbZSVv3fr9CQ4R0pkAE3aKCEnpI3ECVu2BLmY3wg
         xqLg==
X-Forwarded-Encrypted: i=1; AJvYcCV36yd8LPiKbw1Hi3cl7STfxd3db5Fb/DmSX3YsE0TUvZ7QimS+zPhoyEsVdu5DjvNzTWXn7cX19G45Qzom@vger.kernel.org, AJvYcCVfmm89XiIO/SoWsuI+EOkLj4Qa2KZgbGg5JJPxYbec/Ov6xf7qWxs5yxgEVoHjA6/L5coCrQk+bsI=@vger.kernel.org, AJvYcCXfS5BYPfaiI1hRfllCxLWYN+i7YTOGhYIsI/n+MBhEb1iKdcBGIoGe5J4x1gbUw3AtCmal6lPh+Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLqtyz0bmcgENFLDTay5JFmVl/Z/YITppTaN/+9KrupjnrzWe
	hoH25CT8rAekhM6NpcXZ5eqIdQ2sslxiP5y4l6NtYgskEouN2S0+iw7TJ+nefg==
X-Gm-Gg: ASbGncsU4Jn6wn1eQ4AyTrKtls5uscUEOfHpWwwOx9WFpMhK3x0df4cn5j864gBQV3i
	+qKe11tFcclSUToaHwgi2yaTvAbQ74/DcITHf1sI9lbVHaZl6A3LvqVwT4uVKPDmmAZ+VSFxBqq
	x1pRpLioCCSPkvEuUz3MgKkkJIYmvBKI/u8IrEjgY/LI9coQVmtFWZKiPvyee072BrwrSAIOXjG
	loT9j3oorH7iM/wOmGJpiEqCNRbc7lL088d8L35+K6Wi/eakfDrVx9aulQLwgZwDv+UMsUJ1PjY
	43+Bll7q8koRAs0MKH2DN9SYYFXCgGjEr6fP2rZMidrQOQxBx2pJACZiJ4sAnXRkMbmoIgJtqHI
	V4unRd0CG8B/+VjEyCZ2m6689
X-Google-Smtp-Source: AGHT+IGoAQ4X5gkG8Uo1qinDwN4Q5R6qyjd7depXId0IwxUvxJlGdO5W6EwETacp2bjzn6nMfM+pYA==
X-Received: by 2002:a17:907:9496:b0:afc:ebfd:c28b with SMTP id a640c23a62f3a-afe2885c304mr1416955066b.0.1756188702036;
        Mon, 25 Aug 2025 23:11:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe492da4b9sm711067966b.63.2025.08.25.23.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:11:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: reset: add Tegra114 car header
Date: Tue, 26 Aug 2025 09:11:14 +0300
Message-ID: <20250826061117.63643-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250826061117.63643-1-clamor95@gmail.com>
References: <20250826061117.63643-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding values for special resets that are placed starting from
software-defined index 160 in line with other chips.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 include/dt-bindings/reset/tegra114-car.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 include/dt-bindings/reset/tegra114-car.h

diff --git a/include/dt-bindings/reset/tegra114-car.h b/include/dt-bindings/reset/tegra114-car.h
new file mode 100644
index 000000000000..d7908d810ddf
--- /dev/null
+++ b/include/dt-bindings/reset/tegra114-car.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * This header provides Tegra114-specific constants for binding
+ * nvidia,tegra114-car.
+ */
+
+#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
+#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
+
+#define TEGRA114_RESET(x)		(5 * 32 + (x))
+#define TEGRA114_RST_DFLL_DVCO		TEGRA114_RESET(0)
+
+#endif	/* _DT_BINDINGS_RESET_TEGRA114_CAR_H */
-- 
2.48.1


