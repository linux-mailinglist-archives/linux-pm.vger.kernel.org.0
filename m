Return-Path: <linux-pm+bounces-31727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874B8B17D04
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 08:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 230417AC0FF
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D51F463C;
	Fri,  1 Aug 2025 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zj3vTsvo"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19041F09A8;
	Fri,  1 Aug 2025 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754030172; cv=none; b=VEJJ+P+z3ZCf8iVC3HzO1A37Fyupv3A7Ld8dEKg9u9iQKi1iUwqlGHodPtgfP4UW/MNThyWnw9Nb2CnvBGyYJk1KWbd2kAsAICMUtajy3L1FPlzeZcxkiCoYmKAsllTlJEIa4+7mj2GLuKo9KcheV2l0mRFEKOhmiyqFvInOh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754030172; c=relaxed/simple;
	bh=pM/QBuIYaRKXnp5dOtfsp04gUrSP40de5purZtlACYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlGhTsft6aIJRSXtK6Ac4SQhuyDLt+h5ySbFVm4T8DP+5NFYtDiBb1t78Xz+t8VrXb2Urt6AHCNP8Wdng/ACGmfNeoxzKIEwHLYkFJ9oAP2N6SAboTwt6TP7QvJxcoaM7G3yh3s/L9CJNDP4G54/vfv2k3b8TTRJfjOY2/nawrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zj3vTsvo; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754030157; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nH/yQqjXFlgNpji/ayBxu2aP+izc9H8eGxFTy7MIHfs=;
	b=Zj3vTsvoApX8ORjvcwRK4tooNssFU+avcS7H+3kzKbqusdLKMG9ZOK9YIrOpQkcxA76Zw3/ijLZrASuzoy1gjWUYrG/8MuzuBD3B6m2c1CB882qzB7RpSxj8DA2hT1epCCc2Po3dsf9HP+copUi87CsJHHV4Ag7zw7Y7ivBWhkU=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Wkcn-QC_1754030141 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Aug 2025 14:35:56 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] thermal/drivers/mediatek/lvts_thermal: remove unneeded semicolon
Date: Fri,  1 Aug 2025 14:35:40 +0800
Message-ID: <20250801063540.2959610-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/thermal/mediatek/lvts_thermal.c:642:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=23244
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index f4d1e66d7db9..ab55b20cda47 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -639,7 +639,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 
 		lvts_sensor[i].low_thresh = INT_MIN;
 		lvts_sensor[i].high_thresh = INT_MIN;
-	};
+	}
 
 	lvts_ctrl->valid_sensor_mask = lvts_ctrl_data->valid_sensor_mask;
 
-- 
2.43.5


