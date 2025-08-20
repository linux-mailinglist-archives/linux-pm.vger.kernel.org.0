Return-Path: <linux-pm+bounces-32710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14353B2DB72
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F571757DF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0F2F0C40;
	Wed, 20 Aug 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrEyxCS2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627202EBDCB;
	Wed, 20 Aug 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690185; cv=none; b=GMqxTxFnWOjoN2rL+gSTIdj+JGJyvqa1HcF8nWPzzU7o7TS4BHg9edFgQZkfuAb8vsnPmdquiNP0zzlWI7WI/QBZ3H9ZKBWZ13icde8STUULWyDBe8QRr9lLgRbEScd2sUlN4C5GEuGYRk2hxdcDbQPQbdYdrnHCQ8pgQ7rHKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690185; c=relaxed/simple;
	bh=QdYnES4cwlcrca5USo06AZC1LFVUxxkl+I6z1Mjr+BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMbNOJFaeTXBMQB1q44DKX6AQNOHejQE3Mdf5iBtqzspkOfmfIFfz2FxhlA+Ax/OMzo+OB30tfp/ucR+VndpHHAID7oHulvbKApKAVwAD7vWDmuSTRHEghuqK+tXt9/Wb+UeCuCEs47DLAmiBBk9QWzLf8cGqulYvVOp/u66GSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrEyxCS2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb78e70c5so987321266b.1;
        Wed, 20 Aug 2025 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690182; x=1756294982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LfFmY4U8kY58SVjpy6opyksnjG31QAa2Rve/vTCXp8=;
        b=LrEyxCS2cdvoNFACLK3SiVNE49KtlawxHYg7VGMh0FbZHqufiq6+PTBVcAfJqhhhw9
         NqpruQezxPVfY3kxT7SHB3ckK02QPxuRQHnV5ku/YELO05txrOlMYpEj7DyJRNSGG2Xh
         LFL8ay7qeRYXkTfQ/0s7tmhXI8UV1OKatonscTYMmdf1rzfe+Iuf8+jzrcPADgUFdvVD
         72cCLWAs2cmwK60DaRFaMEkLp3+b2p49f82yOFzqazpf/zWjF62ZvVTZRz42uY7ftSqL
         YQdfpn3NLOgqqaGWhxQp/D8HtAsEP3+NSAkZtinqcg50ZQ8xwh5UyQ5ShsZJqgi3j4qH
         KuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690182; x=1756294982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LfFmY4U8kY58SVjpy6opyksnjG31QAa2Rve/vTCXp8=;
        b=p6S6O+cZx+NbX8me1I+yL4xGYCjTj9cI7NI5fqQjLGTws7Mu7/YxPNE0U6JV9u/ACK
         XOk3c5ThcK8ZN7oRtjuzxZkW125hfgCIj2GaKEmp3HsBtxkprleM2qviBUgt1pfEUMkw
         Nq036Y0OEcqFVlzPnvRFYjJFYdUp5wN6REEFnYsvnujFuutDpPfnrEaefntz3dxrHpCK
         vwgghOr34PwPL5mPCYOaj8VfXYjGPAOGHhEGyYDzA/+6/cCBc68KAXGttLkdsy+7aZbm
         b57raT5Vf8Fuy42uepJh9jEFnhVe9piLE+uSOkgg6a+s66M5ON3D3ZS3wEtcfXL7ztmx
         PfkA==
X-Forwarded-Encrypted: i=1; AJvYcCVdnhRfdiFjE/Ep/SMYeiHO1zA4+rXQ1ZGQC+PcKOdwz1TtLg52kYwPdNesVr84QPs7BbLO0fsWcwiprFxd@vger.kernel.org, AJvYcCW7xTeCAGkqxLhMdD2Fce28rnQRczmZWW8Yi3LAm072mbrE03e7A+22OV/EEfCwKQzpah8DgcQZosLkNdE=@vger.kernel.org, AJvYcCXWxSyY9fE0GiV0xWKHI+xqa0euXMnQh33FrLb6n/b6vDMB9Dw2iKzOKXK+VGZ0g02zef0rJth0Gdg6@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqXFFhUlEYpMtPSSULs1LBSv4gaWq0h7eWrskrFUY+3CPng4h
	ARxzjiuK5l9AMcBPXEHnUWwrcZnbkWWJVPaA2PG/H6Nth1za5cxPvn2H
X-Gm-Gg: ASbGncv2hq0MF+TZyPj2Thr7wg5fJO4dwkop21y/TDyX0lMtlogM9D3mgqWiWjw1w4a
	iy2FHNQSA0pRyW7pBUKiWW3jVNEWpAHeaw/QhAJpBtmsNRryfXn7n3P2Piubtzja+NdXXS0d+Ht
	To+PvaqQ/FF8kDleELMu9XLWCoLrz0h6a3KCUR54haMFt4oDiLRyqRhBTb1ALtFuMqg1ylRwGsq
	pLoUDSHr1IsPyHJ46z2x7Sxq8+gQ89ef8AmSmbH73T6bTn1WC5Decu5FYLYIESdfjg3vdHXdDxt
	fT9nmde2hqPprlrxUQhUqRtHIPx6VxpqFANk7WP4ZsZ2Y9NmMm59xGznNoO69VnkS1cEVBvTbRx
	RrO8qW8TqV7qOJQ==
X-Google-Smtp-Source: AGHT+IGxMpA1rllC6s1YggNswG3Xhw0Y4FNZerRnnR/VraYeDBIkKCV//HSVO1mswxBxi+j6c01yrg==
X-Received: by 2002:a17:907:3f8d:b0:af9:7c1c:b4ce with SMTP id a640c23a62f3a-afdf020b5e5mr159972566b.39.1755690181432;
        Wed, 20 Aug 2025 04:43:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4ca695sm161769566b.90.2025.08.20.04.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:43:01 -0700 (PDT)
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
Subject: [PATCH v3 4/6] dt-bindings: thermal: tegra: add Tegra114 soctherm header
Date: Wed, 20 Aug 2025 14:42:29 +0300
Message-ID: <20250820114231.150441-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820114231.150441-1-clamor95@gmail.com>
References: <20250820114231.150441-1-clamor95@gmail.com>
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
 .../dt-bindings/thermal/tegra114-soctherm.h   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h

diff --git a/include/dt-bindings/thermal/tegra114-soctherm.h b/include/dt-bindings/thermal/tegra114-soctherm.h
new file mode 100644
index 000000000000..b605e53284fe
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra114-soctherm.h
@@ -0,0 +1,20 @@
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
+#define TEGRA114_SOCTHERM_SENSOR_NUM 4
+
+#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
+#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
+#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
+#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3
+
+#endif
-- 
2.48.1


