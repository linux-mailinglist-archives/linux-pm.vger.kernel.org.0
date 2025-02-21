Return-Path: <linux-pm+bounces-22670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2632A3FC5D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE801896C21
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F1217670;
	Fri, 21 Feb 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+Ka8z4n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A828216E39;
	Fri, 21 Feb 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156833; cv=none; b=e0MdreBYu58WyBTkyqj1j2jp/+d1F5NGIO3P7ghKaWpsF7YsbXA6X/hyRQ7az8XLdhlO1qJx8Rdwglt995zC/jsfoidD5TKzsQSDXQgGj3gQn/Cp17RT86eZH/wIFgQX3PSWuz2iGQKdC83apqVxjmP1waBMrKJEA3vLtglY4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156833; c=relaxed/simple;
	bh=AUJvMFsICvoCmVfWj5JN11a/sKwael8x29G4HCF3zLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lW7BCWVOrJ3o+RgmdA8ifHt+v6i//GZYiaxvB67v4q+9r7yZwf2iBy2C4k6r73/yjqs4f0aSH5ytv2lcukzlPWsBjKGf1RIlXgkRlTBfkzmYqlE55CIqULzJimqJGVffWC5unEoBMNt4KUezJKjXOmSOAJASHHyqFhrh58iLNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+Ka8z4n; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156832; x=1771692832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUJvMFsICvoCmVfWj5JN11a/sKwael8x29G4HCF3zLY=;
  b=M+Ka8z4nkyrdTvCI4hLG0WZqWnyU5+WUgMj5O/L2HgXyytuqiK3Q0KqI
   T70X0Kwws8TQkHEeek0nlC7tGjnluH8cyY3wEtRBRDfw0Zf2HmTtKkmJv
   kbyHjr86fwOGbptZShHbZ4C8CfivREiD9YDGpXHDFHG8nm8Annzylbchj
   kcYu1eQN0x/Gp4axuJULCGHdEgW72xbauLzI2zojEfT5fgXhMFIlS38zb
   b69NXukhXKHrpCygOymPTTqrmYsswaayy5RwghdjRSzQ+myBWom98qKPg
   dkqq4JdoCGy/fHLFfm5UduJXAzOewCFfs9OUaYJm/pOT6hLjHLhyJ4Jck
   Q==;
X-CSE-ConnectionGUID: 1Au2GLgYSUy3g6lzDkIqaA==
X-CSE-MsgGUID: Jp6PLCJBRyu8Z8RfxyFodQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41186832"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41186832"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:53:51 -0800
X-CSE-ConnectionGUID: EWt6m1H/Q7eRGM4/sJb1EA==
X-CSE-MsgGUID: KK+SZAd6SMmrj7SsiM+VWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540599"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:53:47 -0800
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
Subject: [PATCH v1 02/13] ASoC: hdac_hdmi: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:22 +0530
Message-Id: <20250221165333.2780888-3-raag.jadav@intel.com>
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
 sound/soc/codecs/hdac_hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e1a7f0b0c0f3..3bea5d09219a 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1017,8 +1017,7 @@ static int hdac_hdmi_create_pin_port_muxs(struct hdac_device *hdev,
 			return -ENOMEM;
 	}
 
-	se->texts = devm_kmemdup(&hdev->dev, items,
-			(num_items  * sizeof(char *)), GFP_KERNEL);
+	se->texts = devm_kmemdup_array(&hdev->dev, items, num_items, sizeof(items[0]), GFP_KERNEL);
 	if (!se->texts)
 		return -ENOMEM;
 
-- 
2.34.1


