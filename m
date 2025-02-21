Return-Path: <linux-pm+bounces-22671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1743CA3FC75
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A5E8619E0
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E859C218AB4;
	Fri, 21 Feb 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAlHXCxh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0FE21506B;
	Fri, 21 Feb 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156838; cv=none; b=cHryPq0rH+EFzUv+LFbygOHsK34Qg23DFM1edoFpWsyREKjJYd2ZYsZNmrLB7kqoO3Kjbmp8MCiyu+MABkZwlX5CU6cyx83EaYjRaAZYovtYVVLX5G91n07N2Oy4Yp6dhnXShcBxvCb82/E/9wE2EFsG2b2pfrU5u/+GujN/cYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156838; c=relaxed/simple;
	bh=NSXN9VYfQFUizYJYR++h6usWkL8OeRS3X1QV/7FBf64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHrbOVw4aZuvtXR6+JkxVWVL3hWhriPzFJv2NPT42jFo+RwrcDzGDgtofdWq0M8QMpmb3gN6BGlWFDeTZaOKI/AOWXMbvdbPiO74Qfur7LwNjjYE9g7T7qt1nQ5BjqpO+9CxhHTiZzr9R0NdPAoTkMkV4dYvU6uX0EcWIud1fJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAlHXCxh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156837; x=1771692837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSXN9VYfQFUizYJYR++h6usWkL8OeRS3X1QV/7FBf64=;
  b=OAlHXCxhlVrlq0n1PA8AtBEj0dFdTOL2JOIjlnYNsHHeuwAXg72H4qu4
   VOMRNw38/sOa6KcZE6BsvYV5N1Xyd/oNDr/s6xVGxO+8J9FY8wV5jfv/h
   f7xgNQB4yOvgysWUbXgKLXnIljoYgWRlqMNa8jRptLOW2IE19xoLLtc1E
   02oG2uYznTQcYqw5jR47AlhaNNag9vo9KJ/Yym1POP2VkRYhsLVZYPd0w
   X0Y6mM/UMnxwG9v+cJEefOvkSi/fp93DGDIsxVLtGRdtYPf1FAJuhz+Ei
   ZJymAwPVM0AabQvmJYIbJo2p/t8lsbmDGTgQpDI4Q0YzPe5bCgRc7GB5s
   g==;
X-CSE-ConnectionGUID: 9FKyZIrXTjSrhXt3vGRsxg==
X-CSE-MsgGUID: fmRZ5xJDRCqsxJo8YNW0fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41186845"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41186845"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:53:56 -0800
X-CSE-ConnectionGUID: gHWQkauHT3m/IXceYRuaWA==
X-CSE-MsgGUID: 8iBYFwX8RIOmuLf5oeELGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540606"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:53:52 -0800
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
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 03/13] ASoC: tlv320dac33: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:23 +0530
Message-Id: <20250221165333.2780888-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() and while at it, make the size robust
against type changes.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/codecs/tlv320dac33.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index fa46f51d4341..423b9264a205 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1477,10 +1477,8 @@ static int dac33_i2c_probe(struct i2c_client *client)
 	if (dac33 == NULL)
 		return -ENOMEM;
 
-	dac33->reg_cache = devm_kmemdup(&client->dev,
-					dac33_reg,
-					ARRAY_SIZE(dac33_reg) * sizeof(u8),
-					GFP_KERNEL);
+	dac33->reg_cache = devm_kmemdup_array(&client->dev, dac33_reg, ARRAY_SIZE(dac33_reg),
+					      sizeof(dac33_reg[0]), GFP_KERNEL);
 	if (!dac33->reg_cache)
 		return -ENOMEM;
 
-- 
2.34.1


