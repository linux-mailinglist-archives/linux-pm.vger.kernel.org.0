Return-Path: <linux-pm+bounces-8095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D08CE2E0
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 11:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36650282D66
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E08129E7E;
	Fri, 24 May 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DmvVpFY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9F1292FF
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541486; cv=none; b=ZL57k8Rfo18Yl09u6lYD3D/XRs5EyLru9BcdBXygfn/+39XONCz8bLX7avrVHYz14i0aTT37Nv2okFQGqptU3phunp43A8EtYT6+qQZJUzUdMVtav1z5v2iCxSPw1b0Xdcv9VWWClBBr+JtZiE0x8lfXBd7kX3fa7th4NMu359s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541486; c=relaxed/simple;
	bh=dLqKCSSB83A5CpMYvy5y1AWx1dYh/sN+oOI5PnPOVSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEgdLEtPuBuAWLWn6nEBDxv2fvCqQEf5qugeq9mRy9dj0hrPi4/1yjxtwPcI1m5g7yjn4EUlOq6n8MsiSEe+P3gUxN9XahDGKccHGfruPcIqwIlek1Gigfj5eyBCm05KxbcT0WPhRxJaFFTOAGA4k0/knRcmJcTJYOzvMrlRw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DmvVpFY8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so62542855e9.2
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716541483; x=1717146283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoPKo6y3Rls3bork3EHcuNoN18jSBiGl7Uk9FD1A50s=;
        b=DmvVpFY8hpFCRow7A5Cx9QRJCVOvWJozy6V/XkubhpAyaOCLZhgyu8yPJluTbSJ+JS
         aDNpaLTGpigr1Oy3N+HfUoj5aqiGmW/ge/nywWHdAmkwFAOi+au1O7CBJ5Ch5QicZEui
         3T13kYIFUA5xd0r0gxcZaywdcFV9OQjbyrkiTvYeu6WvJPE/Biuyf/VbFC/m/iiRQUDk
         5GTf5YQu5a2a/ohqrU1KhDHu/i3YAJumPv6F5QdD3LiBp+jS0Eterqq00TlUImsXZmcf
         OvikT/EosdAXL53NNcajvxYPr7XWljsdE8u8t+46biX7/ikJ/u5GVkUsQ9u/8RrgUbuc
         MjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541483; x=1717146283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoPKo6y3Rls3bork3EHcuNoN18jSBiGl7Uk9FD1A50s=;
        b=oTJkt8ZpeVJDdpylYINpomyJtp3CsJHmJXAbo9RFCK2atOoipvLynZvQMacDZp7XjD
         TEksUvW9Qu3FpfAOw653XBOO+OJL6aoDVpxuId4IDgNm2Br86e9J3ca52Lxv+Vw1ptQZ
         KwD4aWq/GH8sE5+YUknwWP/X2Q+PiMZ1I1/S4iFDWFkp4hNK8qYQkJz7qcLtIGcxHcwQ
         0uhux2fRE0jIvgldyU8EEAEObyXrzK9Sff2K2Ed5lLV1nmtE8zmgXUSGAS4l7eF2R/ZS
         9cQUfz858lHaqLBJllTkkUfCgg+Pq3Wm/3HO20Svee1hwYbOcJ4S2hDpgV9Qm8KFEdUU
         eh8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuvv4Th+BhbbbPSVLgFoFZlb/PEyYHNYLw0JT0Q96+i56Z06gJsSNqbExO/QG3lyw7mUlPnp3utPW42qQjcjQXXs7UwHHJ0xE=
X-Gm-Message-State: AOJu0YzZ2WWomy7vN/5KQ8QDZkfxn4Z+SRow3rYcfZ50eB1z+YwbTBlT
	OS5QWVL1m52iE5DqUMwZYJPVWZXh/9bNGweKMun1pa0cf0+Sy0zaaEh2pjltThk=
X-Google-Smtp-Source: AGHT+IFpU4ERnNt7x7BjtA0EsmfIwtbjyLKpSwh5Xl1z3zoJKYR1+rNeB+IK22SAp4HcKpeCq9BkpA==
X-Received: by 2002:a05:600c:534f:b0:41b:b013:a2d8 with SMTP id 5b1f17b1804b1-421089f4daamr13145865e9.10.1716541483183;
        Fri, 24 May 2024 02:04:43 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f163a8sm47273045e9.13.2024.05.24.02.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:04:42 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 24 May 2024 11:04:34 +0200
Subject: [PATCH v5 1/6] dt-bindings: thermal: mediatek: Rename thermal zone
 definitions for MT8186 and MT8188
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
In-Reply-To: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
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
 linux-pm@vger.kernel.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541478; l=1161;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=dLqKCSSB83A5CpMYvy5y1AWx1dYh/sN+oOI5PnPOVSY=;
 b=UqNxuRjXPeTBHKlV/cedr5aBagTA3pLWnK/IbBAMO8LzIZYjxQP/cJw4HIrV2uIKRW8rZ0j0v
 gMjy5x16ppYCza2SKj8b9pCxHHd+9ZyJAaki0Noua2Oe4BxfAEWcQJu
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Use thermal zone names that make more sense.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 include/dt-bindings/thermal/mediatek,lvts-thermal.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index bf95309d2525..ddc7302a510a 100644
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
@@ -34,11 +34,11 @@
 #define MT8188_MCU_BIG_CPU1	5
 
 #define MT8188_AP_APU		0
-#define MT8188_AP_GPU1		1
-#define MT8188_AP_GPU2		2
-#define MT8188_AP_SOC1		3
-#define MT8188_AP_SOC2		4
-#define MT8188_AP_SOC3		5
+#define MT8188_AP_GPU0		1
+#define MT8188_AP_GPU1		2
+#define MT8188_AP_ADSP		3
+#define MT8188_AP_VDO		4
+#define MT8188_AP_INFRA		5
 #define MT8188_AP_CAM1		6
 #define MT8188_AP_CAM2		7
 

-- 
2.37.3


