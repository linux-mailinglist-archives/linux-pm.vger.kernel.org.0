Return-Path: <linux-pm+bounces-11203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC01933974
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 10:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFF31C212BE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90D3BB25;
	Wed, 17 Jul 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="TEccIcr8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="K0F8Dj8Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C864D8A1;
	Wed, 17 Jul 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206526; cv=none; b=GCpD9dNXardkJVjyu4IxAdjPIpbmkVXklvwU7XqFoT0NmO/mrERAHwi0F4CdPLVB/q4K0ZVq8A4LZckjU37+R5JZyup5Oe3ztbUEh/5LQIiUXP0Q6W43e3HaZPJuI7cJA3i/UZr8CBqdcE0fp24Nnfz/+tRhb467rO4mbrL1JIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206526; c=relaxed/simple;
	bh=CQp1cT/49Mwlk8eFwb0NQaZATlg5S44nxd6/Gbydbzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cd7hUwNfHLn6zZlPB+IV0KjKarYKHWiE+YDfYHC3JnOlwiieZoOaxVZB/wZ6KkzUNDJFwDQNGXtTKvSaDpmIwJuOVbYqmplryn+QdCboffYcSwgqFotx5juLQY+WTzzkM9JDkVaJEp2ZT0qauu8Gh3R3vcN3aebN6xIdijzcJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=TEccIcr8; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=K0F8Dj8Y reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721206523; x=1752742523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b1vcI/K+2KLMZuvtnOBL0GjEFEZymTOWIpsTg/FE3Xs=;
  b=TEccIcr8osyYwf506ZsOU8bgdul5UrZYMueVa7cccdtb5ALYE98BLWpi
   CBW9+51QIFMqyM5TbN83ACrZVVk9n9DTy6hHtUdkhW2Gnv4Ll5kb/cdG9
   uKmErdl+kQxg7moLyRx4du2XMMitXXxprZSRu5nsgZ5ELpQ51pIFhARVF
   eNr1rywjJmQIch63hDfi3mn/2O/zH0ytf5rV1IhGbA50ZjLgH3oEdtJuS
   oIPDULAwLAKX7UIwwHOoDBPEnW9mbylCfC1eEu/k+p1UBOlkzWlnAmBSH
   81A0HZyHmJ3y+j0ZFDRaDnJeWsi7GYgCXybPy3Gvfg5JwhZjgoWbba5dc
   w==;
X-CSE-ConnectionGUID: 4h9HXuQdSfCFkDR2+B26lw==
X-CSE-MsgGUID: jmJozPOvQ4ycQ9dyeGcR1A==
X-IronPort-AV: E=Sophos;i="6.09,214,1716242400"; 
   d="scan'208";a="37946769"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jul 2024 10:55:21 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29A37172575;
	Wed, 17 Jul 2024 10:55:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721206520; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=b1vcI/K+2KLMZuvtnOBL0GjEFEZymTOWIpsTg/FE3Xs=;
	b=K0F8Dj8YmqBQrwiO14nwlRuOyhU1UEq2KnnpBiwXNs9esg/kV5y1fJDIMN+zJyOnQJUqwP
	lq590ZVhkcG4XRGKMKiFViFp/ffvM0qaF1MMHZAFkv4HJbdsHGvHV3asXIogscTuDtURME
	BGCXiw+/s5rp5nL8fLObfhcNh08k52I7XT9pcQEh3SwHttWFBA6vht1wVagNK17ajmMeSi
	dZLkHLnaw9QMRxzXSbvrim8+3JOv/YHvJOw+drx658188lADF+/tCQXYljRFbPjEN3oHHH
	SSOYv3qQSKvfHE56AwmLIZXjtNQUhrACS9pHRpj82FRz46r+CWhaogdaqYqL6g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] thermal/drivers/imx_sc_thermal: Use dev_err_probe
Date: Wed, 17 Jul 2024 10:55:16 +0200
Message-Id: <20240717085517.3333385-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds the error code to the error message and also stores that
message in case of probe deferral.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/thermal/imx_sc_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 7224f8d21db97..88558ce588807 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -111,8 +111,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			if (ret == -ENODEV)
 				continue;
 
-			dev_err(&pdev->dev, "failed to register thermal zone\n");
-			return ret;
+			return dev_err_probe(&pdev->dev, ret, "failed to register thermal zone\n");
 		}
 
 		devm_thermal_add_hwmon_sysfs(&pdev->dev, sensor->tzd);
-- 
2.34.1


