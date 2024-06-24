Return-Path: <linux-pm+bounces-9841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD6D9140AB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 04:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4DE1F22F14
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 02:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B268523A;
	Mon, 24 Jun 2024 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bz1HqJZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAB4C6E;
	Mon, 24 Jun 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197622; cv=none; b=kJjfQ5LT9HUFTg7pzzz3A31XM6QG0teF8K3zMJ5PHC7fw/zKA9PmDo1DiUW4upRhXItT6pDlX5qBAmdntsW5Huvotup5QmVRku4tWVDHID+FCQlXnSoVBHv2/TbPLuMhSz00OZuPWyV7ZRhEkkbw3WKBPshX+d9bL1uZ7rCSBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197622; c=relaxed/simple;
	bh=NhE4Wdd5TOme60iwUa2wxxGJ4Jw6dMRqKvk1JTfaa/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qU4VDQUIZSgsJuLOKMYKrckKyuI2/YBpQAiYIqvfvgATjgBBqJy9VCb4SRlanl+LagDt339g1ANZKTc9muTIWfEGg0gdGs69Z4cpYTOqJHvFWvFnfysj4O2/UcA+6efHl4IsHZ1L5wF3OhVk5yXtJ+2D2vdUXYSgzwri2q3kGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bz1HqJZV; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719197617; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FHmcAmm5PMcsmjoFAck5LqmvyVBIKGnK7y7ckrVXkbY=;
	b=Bz1HqJZVC+97z5DBOhFZiJp74C7CcjsRwDh9MXw8qnggsxnLfA58mzyDMPAzi4bcxOXnifrogxQxfUCl0iNqVH5zwdYx48rnm7fkJJxoZZvwtIx34cTCoJbQdqJuQatNFGhtFEdEXmqFlcv0E+hkfJLkP6zk79mmilP2w3XznLo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W916FxM_1719197608;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W916FxM_1719197608)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 10:53:36 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: djakov@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] interconnect: mediatek: remove unneeded semicolon
Date: Mon, 24 Jun 2024 10:53:26 +0800
Message-Id: <20240624025326.69551-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/interconnect/mediatek/icc-emi.c:71:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9401
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/interconnect/mediatek/icc-emi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/mediatek/icc-emi.c b/drivers/interconnect/mediatek/icc-emi.c
index d420c55682d0..7da740b5fa8d 100644
--- a/drivers/interconnect/mediatek/icc-emi.c
+++ b/drivers/interconnect/mediatek/icc-emi.c
@@ -68,7 +68,7 @@ static int mtk_emi_icc_set(struct icc_node *src, struct icc_node *dst)
 	default:
 		dev_err(src->provider->dev, "Unknown endpoint %u\n", node->ep);
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
-- 
2.20.1.7.g153144c


