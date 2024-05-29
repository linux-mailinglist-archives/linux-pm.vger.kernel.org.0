Return-Path: <linux-pm+bounces-8330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAFA8D2CC0
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 07:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19958B239F9
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 05:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315DC15CD7C;
	Wed, 29 May 2024 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YrsXVuY0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311A15CD53
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962287; cv=none; b=tpkq5oCEzaQlhwvOjTPwBPQf9j7MEvBFkS+AWtkN5Vpx6+ygGYLdEn3sqUQi/XHpX2Yd82wLXCTAX7Cm6aJAen8q2zpgKvtic8yPb0v71pEwX7fX7NWe7WiogySMjzCJXw2mzVwrtLcNp3OLTfkF+K582PIkIuBMyK+LRoFIEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962287; c=relaxed/simple;
	bh=7TWp6ZYqTnWbqyJ5Cw7vRGWMMiL4bndT4gl1LDFj+mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1T6MzDAp0nS8msZpd9jRdiA8784OXNgHPXj3q/EFiu+DXMZy0Vj/grv6Njvf3ajJv3gnn5STXzUOKRC70/unM2bXeUaGb1+mY9wh8qui8/kxwv+zx1MwMnRyQwQ3nRGyy7oQde//1mt7qhSYYZjckwYqgVlk1NFKzGM9KY4KzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YrsXVuY0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42108856c33so2476065e9.1
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716962284; x=1717567084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=py0GeonwgnNaknxyxyM/bPk5f/ta2UYkhS/HU0w7EWw=;
        b=YrsXVuY0Zx7BFxRbNvnM5FSdWileK5EEkh0l6UZIOJHH4TlR5G2sTeQDaaULYs+f3W
         Awb+X2+MedshRhyEoDl1BFp7M3UwUl8731ozo9HV7/q8GUjdfELydCsMFMCV8XtHeDtU
         LBEHVCei1MWtwQblCPvptPikxcemUAxwuOaMwXFhGWulTp3kjCmeyK2W/oTpfAgib+KN
         72RzuTgkz0vgUm3MPqt1kdnjT3H06QQQM8lxSumU95eLZlUjOECf80Sm3q+vIaX4P9q1
         iYRDNqiyt8TWTYWiRFoL7hAwTpiUbTiWfX1WWvuDEb3qtAYKbA1KP7ncLvVYH9lwJzmY
         3HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716962284; x=1717567084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=py0GeonwgnNaknxyxyM/bPk5f/ta2UYkhS/HU0w7EWw=;
        b=WT/HQs+tK7qiTgKlJjBkbr8B81udZK5MDx1VSEShOv/U0gD/6JhXDeIuUd3P+XQdIt
         fS0yJM7ZyM9tTXLkDsGk4WHx0Za9d49MavkWtKo5E9qbg1Qlaq+b2++scB9hhl7zJ48H
         hwzwQtiGxHoflUG58bbYdWKIwSndOELyjx3kBlTi50QOrsh6eSRErW5dr3A/LA5WW5ER
         R1dUgkO0TxMOH/m5tI27eOPCPF+v38oxwOiCBL8TvaU6mTBZGe3LVoCHO7/8doTHLHtj
         fB8cw5MslHK3bXA6sHxe2XM5njGSvGmZXY0vdl213Mnt/380gTWfoF5dEcsuA7Qm6ZnM
         3gWA==
X-Forwarded-Encrypted: i=1; AJvYcCVE3mARPeChjYOieN1Bgl/ZYDlB6he9qP3tjxInnJe7VoUxZXnghMeHUpTuHMsYuW+4i2v+2UhQd21a1UG4V6NVigla+7ogqWQ=
X-Gm-Message-State: AOJu0Yxz+EPmWX1q6dzWNP17k41wh5cDvg5IEG6d02ql8LY6yKqTCgjU
	yyhxkWVzD+Lx9+S2Ez8E5mwA19MOJUdyw2OswQZzlp+uJDSW2eBPg1/l0ok1ha8=
X-Google-Smtp-Source: AGHT+IFBgBr868w8QAU+3YcZoh4tBW+ET1fjETfVihg6NGnEmbzACXvx/JGf3dJqRJTP60EWqb8pZg==
X-Received: by 2002:adf:feca:0:b0:357:bedc:b555 with SMTP id ffacd0b85a97d-35c7b80e05dmr778871f8f.26.1716962283532;
        Tue, 28 May 2024 22:58:03 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896676bsm169075435e9.4.2024.05.28.22.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 22:58:03 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Wed, 29 May 2024 07:57:56 +0200
Subject: [PATCH v6 1/6] dt-bindings: thermal: mediatek: Fix thermal zone
 definition for MT8186
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-mtk-thermal-mt818x-dtsi-v6-1-0c71478a9c37@baylibre.com>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716962279; l=1871;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=7TWp6ZYqTnWbqyJ5Cw7vRGWMMiL4bndT4gl1LDFj+mw=;
 b=fNpJGdF1e6oIhg16Qw3yuccxDifJLORx4N3h7feO2qRv4t5zX5kGrg92RNMGZjYaq0FJMoxzr
 kn93J44LFi/ClblQAuQP6CjaErOlZbnOjF2/u1vbrtp9LVgiaEPecsf
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Fix a thermal zone name for consistency with the other SoCs:
MFG contains GPU, the latter is more specific and must be used here.

The naming must be fixed "atomically" so compilation does not break.
As a result, the change is made in the dt-bindings and in the LVTS
driver within a single commit, despite the checkpatch warning.

The definition can be modified safely here because it is used only
in the LVTS driver, which is modified accordingly.

Fixes: a2ca202350f9 ("dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8186")
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c             | 2 +-
 include/dt-bindings/thermal/mediatek,lvts-thermal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0bb3a495b56e..506eed52db1e 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1436,7 +1436,7 @@ static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
 			  .cal_offsets = { 29, 30, 31 } },
 			{ .dt_id = MT8186_ADSP,
 			  .cal_offsets = { 34, 35, 28 } },
-			{ .dt_id = MT8186_MFG,
+			{ .dt_id = MT8186_GPU,
 			  .cal_offsets = { 39, 32, 33 } }
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 0),
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index bf95309d2525..85d25b4d726d 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -24,7 +24,7 @@
 #define MT8186_BIG_CPU1	5
 #define MT8186_NNA		6
 #define MT8186_ADSP		7
-#define MT8186_MFG		8
+#define MT8186_GPU		8
 
 #define MT8188_MCU_LITTLE_CPU0	0
 #define MT8188_MCU_LITTLE_CPU1	1

-- 
2.37.3


