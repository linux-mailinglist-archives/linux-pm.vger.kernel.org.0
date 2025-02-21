Return-Path: <linux-pm+bounces-22669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B1A3FC33
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C16A7A3DE4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425DF2153FE;
	Fri, 21 Feb 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWRPxbTA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D02153E8;
	Fri, 21 Feb 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156829; cv=none; b=r7o9mg3A+rvGmFNgMhb6yUJ5QwYQQh2Qtht3TtVwTDoOASH6o0v9eP0CLysI1yL5i5g0WkmuLFbMgSjtDg2sXeY8gySSSwrrNu5IqxQK9pHGOmW2aeGvvnOeWmvVwf4rWHQGNv65hsnnXXvWtE2siGPf0i5fO8PJNBItZJYZc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156829; c=relaxed/simple;
	bh=/m+iPWmk6kJV3QtWKryVvX1MLMg/lAVfhh9LHnQYHeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcmdEF0H4K8FOM8bSZnsKNJTWLgK4ADAJrSRTWK6BqUKcCTZKI3tcQS/6y9/iBoQZapZckWP+n/yM7bmA2SGNBTcvMzES/RrjwwjLKJQ0SUHpTojtHLBB77h7RHz/UwvWKTAmWrMOGmzyCJoA32mSow1PLx78rNjG28XjwAYxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWRPxbTA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156827; x=1771692827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/m+iPWmk6kJV3QtWKryVvX1MLMg/lAVfhh9LHnQYHeM=;
  b=gWRPxbTAdHihja02UTPfbEF4NDgpwL3AIwxpCHfe7WulxQKZ9Gm5kIAy
   F44NB09v+bhyV5tDf5B54s0RojxIzfPh2dHyVfQtdi3P52mUVWBqxIXi3
   dmblixteK+6ZbDi79JXbtuNEvu5oeeLU2/RbBe1q75EAtmPftFA6qQ9D6
   E2lDcr9VX00Xgqq20Ful32oAYEkNQf1bXPhr+7pTgCCPmUb1Ey95iq/eT
   mQC8VzYwpHEsrpuS7Zww5aCqbi+f0w4e8G732iFHvrQXDWzXUab6p3izo
   gBr2sYgoYizgVZs2TlaKGMrtrKB9voWUXuzy4Zdf+ZR7kyd1c345zT8Y/
   w==;
X-CSE-ConnectionGUID: nU4HRqPETvaCLdSNY1v4dA==
X-CSE-MsgGUID: M5A/iBDaQUiekI2zoDf0fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41186827"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41186827"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:53:47 -0800
X-CSE-ConnectionGUID: H1vya97bSdmaM8tzU3W6YQ==
X-CSE-MsgGUID: Gc3D43G4SjSNP7U9Syvt5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540594"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:53:41 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	deller@gmx.de,
	andriy.shevchenko@linux.intel.com,
	sre@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	jdmason@kudzu.us,
	fancer.lancer@gmail.com
Cc: linux-sound@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 01/13] ASoC: Intel: avs: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:21 +0530
Message-Id: <20250221165333.2780888-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() and while at it, use source size
instead of destination.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/intel/avs/boards/da7219.c  | 3 ++-
 sound/soc/intel/avs/boards/es8336.c  | 3 ++-
 sound/soc/intel/avs/boards/nau8825.c | 3 ++-
 sound/soc/intel/avs/boards/rt274.c   | 3 ++-
 sound/soc/intel/avs/boards/rt286.c   | 3 ++-
 sound/soc/intel/avs/boards/rt298.c   | 3 ++-
 sound/soc/intel/avs/boards/rt5663.c  | 3 ++-
 sound/soc/intel/avs/boards/rt5682.c  | 3 ++-
 8 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/avs/boards/da7219.c b/sound/soc/intel/avs/boards/da7219.c
index 76078a7005b0..9507a96f26ac 100644
--- a/sound/soc/intel/avs/boards/da7219.c
+++ b/sound/soc/intel/avs/boards/da7219.c
@@ -113,7 +113,8 @@ static int avs_da7219_codec_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	num_pins = ARRAY_SIZE(card_headset_pins);
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
index 426ce37105ae..6f3c4f6c9302 100644
--- a/sound/soc/intel/avs/boards/es8336.c
+++ b/sound/soc/intel/avs/boards/es8336.c
@@ -109,7 +109,8 @@ static int avs_es8336_codec_init(struct snd_soc_pcm_runtime *runtime)
 	data = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/nau8825.c b/sound/soc/intel/avs/boards/nau8825.c
index bf902540744c..6833eebd82d6 100644
--- a/sound/soc/intel/avs/boards/nau8825.c
+++ b/sound/soc/intel/avs/boards/nau8825.c
@@ -88,7 +88,8 @@ static int avs_nau8825_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt274.c b/sound/soc/intel/avs/boards/rt274.c
index 4b6c02a40204..f5caafc21861 100644
--- a/sound/soc/intel/avs/boards/rt274.c
+++ b/sound/soc/intel/avs/boards/rt274.c
@@ -98,7 +98,8 @@ static int avs_rt274_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt286.c b/sound/soc/intel/avs/boards/rt286.c
index e40563ca99fd..1eb0399c0fae 100644
--- a/sound/soc/intel/avs/boards/rt286.c
+++ b/sound/soc/intel/avs/boards/rt286.c
@@ -59,7 +59,8 @@ static int avs_rt286_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt298.c b/sound/soc/intel/avs/boards/rt298.c
index 94fce07c83f9..85269a3be981 100644
--- a/sound/soc/intel/avs/boards/rt298.c
+++ b/sound/soc/intel/avs/boards/rt298.c
@@ -70,7 +70,8 @@ static int avs_rt298_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt5663.c b/sound/soc/intel/avs/boards/rt5663.c
index b456b9d14665..e3310b3268ba 100644
--- a/sound/soc/intel/avs/boards/rt5663.c
+++ b/sound/soc/intel/avs/boards/rt5663.c
@@ -65,7 +65,8 @@ static int avs_rt5663_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = &priv->jack;
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt5682.c b/sound/soc/intel/avs/boards/rt5682.c
index 335960cfd7ba..339df0b944c1 100644
--- a/sound/soc/intel/avs/boards/rt5682.c
+++ b/sound/soc/intel/avs/boards/rt5682.c
@@ -102,7 +102,8 @@ static int avs_rt5682_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_jack_pins);
 
-	pins = devm_kmemdup(card->dev, card_jack_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_jack_pins, num_pins,
+				  sizeof(card_jack_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
-- 
2.34.1


