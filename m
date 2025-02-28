Return-Path: <linux-pm+bounces-23161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E78A492D7
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E034D3B94F0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9311DE893;
	Fri, 28 Feb 2025 08:04:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C781DE2D7;
	Fri, 28 Feb 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729869; cv=none; b=MxQs1B7z2LU7C8OjntRCzeKe0IACW03NEBe5dl5mvCUBtpTnVt5F2vjo+KdTH00PhrQKZhuTSYddTwOsmYgGmmqOtZLtEOR8P+Dltj3Fc1v+rwC2S/096O6kJ98xqngXTfr9cXdXeG95o7rVKuJHiTUEzwhhL1fhg5fUdzRGv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729869; c=relaxed/simple;
	bh=LZeDjq3zcDhwawYqyuQVbx9MgRYcL24VFWPCX1A1+YE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aL8CHV8jxBMyLYyABFofA3N8OlbFnbTv/+O+8kZNQyQDn/FmQbzsJAv8Yl9ynDttAQi0Rzz16ck+AEVu1JSbZuFz2ySIpCqI9R6YUPsy5LXBB8w3+9NFCdLV2rUNDs++tTw3MQuQyZcSBnJgUdx91vjgbwzSBR1eT7WoTKn2EqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502281604151950;
        Fri, 28 Feb 2025 16:04:15 +0800
Received: from localhost.localdomain (10.94.16.254) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 16:04:14 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sre@kernel.org>, <mazziesaccount@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 9/9] power: supply: smb347: convert to use maple tree register cache
Date: Fri, 28 Feb 2025 03:02:36 -0500
Message-ID: <20250228080236.2759-10-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20250228080236.2759-1-liubo03@inspur.com>
References: <20250228080236.2759-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20252281604153e8fb176888a91abaffca26035795d77
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/power/supply/smb347-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index c8392933ee28..75ad3bb16ac8 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1488,7 +1488,7 @@ static const struct regmap_config smb347_regmap = {
 	.max_register	= SMB347_MAX_REGISTER,
 	.volatile_reg	= smb347_volatile_reg,
 	.readable_reg	= smb347_readable_reg,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static const struct regulator_ops smb347_usb_vbus_regulator_ops = {
-- 
2.31.1


