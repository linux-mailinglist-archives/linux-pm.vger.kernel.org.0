Return-Path: <linux-pm+bounces-26528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE7AA67B1
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 02:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101811BC6B4B
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 00:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E7522F;
	Fri,  2 May 2025 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NnnP9KQc"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF060801;
	Fri,  2 May 2025 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746144968; cv=none; b=nY5B3oIcssPE4UUsbaXHZp9/p1DBf8Ci+3FVtOhnZa8Q7pjB/bN1h3sBXA+JYC7L5Hmmo+PRa5J6Ren/56kYQ8GxQiYINeqkJQqK0QKSSouuPmUoJLDj1BooLxObWuStSbGs3Da+ILWE5WS4NytOUDV6A70XKZOQ0Y101/hd3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746144968; c=relaxed/simple;
	bh=MbhJ7X+soFGDLCAM09sPSxM4StX1n+KVVKzCqiBRku0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFyA++I9GT09pbXbqWXHoyGCEsiSnor/5hcj/Xw8vSTgchZD3htFIQfKx21aX5Yxl4xJElwC6CzbTnh3JGBa84HRjFiSLVa4gu8t+rkErqjnColJuUPH3wcGGsSYHAOo4Opvt6iWnjBYYegTUde+0c2UY4dyvN2LQhpszB7AyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NnnP9KQc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FGaYCa9Qn7rnL+FdRL5294bZ3FP2vglC+YguC9Pz028=; b=NnnP9KQcFHMDXsWNW1d472LjOJ
	hSsLY1d/Aau4lMYYe7y0b2vKtgZegzPFodDLU3jTJ5L1Wo4pypVILcjXWOsD4N2B6vIJCg/JXDLko
	US5uijxN/aP+DWlmFhrYGF9t8uLwryVDRnWim4yl3ZCv1/biIVSid/9uYGfkmq65xiuYLCSy3wkos
	UVUzR6Ln9Qc1TAfIgMrxeO6mq8WzLNKlbVtBgvhHbB8ca8N5OTfKH9Yqf383zFTYCl2brZyYDrflE
	OStiDi9ZLb5jta++WX+Jasrm9pl8LwhTHP0a2ZeyirlU7QbJulXdIBDcxmROcz/BKMurDeLvLtB2K
	QfvfRU5w==;
Received: from [50.39.124.201] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAe4S-00000000MkC-0VLu;
	Fri, 02 May 2025 00:16:04 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Balsam CHIHI <bchihi@baylibre.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal/mediatek/lvts: drop defined but not used function
Date: Thu,  1 May 2025 17:16:03 -0700
Message-ID: <20250502001603.674239-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a build warning when CONFIG_MTK_LVTS_THERMAL_DEBUGFS is not set:

drivers/thermal/mediatek/lvts_thermal.c:266:13: warning: 'lvts_debugfs_exit' defined but not used [-Wunused-function]
  266 | static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Balsam CHIHI <bchihi@baylibre.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/mediatek/lvts_thermal.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-next-20250501.orig/drivers/thermal/mediatek/lvts_thermal.c
+++ linux-next-20250501/drivers/thermal/mediatek/lvts_thermal.c
@@ -263,8 +263,6 @@ static inline int lvts_debugfs_init(stru
 	return 0;
 }
 
-static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
-
 #endif
 
 static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)

