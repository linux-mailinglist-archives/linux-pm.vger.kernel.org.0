Return-Path: <linux-pm+bounces-21089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26624A21C0B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF5A1885AD1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C861B4153;
	Wed, 29 Jan 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="owozF8mF"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC551AD403;
	Wed, 29 Jan 2025 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149700; cv=none; b=HG4T8J6yoKEi52QwHzUeXZVv/8aBGa9k2N2WpAXzuH88LfXQVU1Huyz4Ob+Y/a5B5SMbpN6Qzn+kUlYlDT2f2ymfM1rWzx5+Sr6FYzj4QtXjJdn0gHH34bCeNT4zhyUr02KfH/X4vxj7HHZdHb/VpOxjONbPNC12tt0M07vvXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149700; c=relaxed/simple;
	bh=8LK+KtB0c7mKMjmYn8pc9osO52h6T2euevSCkixwT64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L8pw7O0gs6fQjnO/oQEFKoKlaFEocykS4T5JcCeKitMl/aww75Ew1uDF8YOsdixmSi9EZ46slaRBus83hRY8oNfuMvQrlIopIDH7hsnEjtx8j5HxOBdkkx1l/LUupWUTHpBfLUCNVjfATFSkYnqwSwwUiJtkGFCnxNj1pUQjBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=owozF8mF; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50TBLPDm1306219
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 29 Jan 2025 05:21:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738149685;
	bh=89OYclrPi1g9pKERBN4H2LEY3kk/rtnsJy6D8T4hZkg=;
	h=From:To:CC:Subject:Date;
	b=owozF8mF2HnUyQsDNtgUaUszy2ROiGle4N4bnHxllqKHuQbpmjWWQ0pZf7T/jFeDO
	 YIaKGzalxnvqVp+3h3qkokztmYwcwYWOp7d3uM1mNqdp6jdJd3tYQHmDKpRM/2HB6q
	 wfYKZVQ5T9kvodv6gIUaULDL79i8wquTsVMx69uc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50TBLPOx110289;
	Wed, 29 Jan 2025 05:21:25 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 Jan 2025 05:21:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 Jan 2025 05:21:25 -0600
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50TBLMjs121417;
	Wed, 29 Jan 2025 05:21:23 -0600
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Markus
 Schneider-Pargmann <msp@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [RFC PATCH] PM: wakeup: set device_set_wakeup_capable to false in case of error
Date: Wed, 29 Jan 2025 16:50:56 +0530
Message-ID: <20250129112056.3051949-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

In device_init_wakeup enable, we first set device_set_wakeup_capable to
true. However in case the device_wakeup_enable fails for whatever reason,
there was no error handling being done.
Consequenty, there was no cleanup being done to device_set_wakeup_capable.

If a certain API is enabling something, it should take care of disabling it
in error scenarios. In this case device_init_wakeup should on it's own
check for errors and clean up accordingly.

Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

This patch was briefly proposed in a related thread [1], where this discussion
was taking place.
That probably got missed due to some confusion around the device_init_wakeup
return value.

There is infact error returning being done in drivers/base/power/wakeup.c, and
ideally we should be using that info as done in this patch.

If this patch get accepted, it might even bring forth few hidden bugs
due to missing error handling, and it will also change the patch for
devm_device_init_wakeup() helper slightly[2].

[1] https://lore.kernel.org/linux-pm/20241218064335.c72gmw56ogtp36a2@lcpd911/
[2] https://lore.kernel.org/linux-pm/20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp/

---
 include/linux/pm_wakeup.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index d501c09c60cd..ed62a7055a54 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -231,9 +231,13 @@ static inline void pm_wakeup_hard_event(struct device *dev)
  */
 static inline int device_init_wakeup(struct device *dev, bool enable)
 {
+	int err;
 	if (enable) {
 		device_set_wakeup_capable(dev, true);
-		return device_wakeup_enable(dev);
+		err = device_wakeup_enable(dev);
+		if (err)
+			device_set_wakeup_capable(dev, false);
+		return err;
 	}
 	device_wakeup_disable(dev);
 	device_set_wakeup_capable(dev, false);
-- 
2.34.1


