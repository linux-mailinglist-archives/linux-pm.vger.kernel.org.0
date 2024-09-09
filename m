Return-Path: <linux-pm+bounces-13883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5227B9714C4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 12:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DE4284698
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063431B3F18;
	Mon,  9 Sep 2024 10:05:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from muminek.juszkiewicz.com.pl (muminek.juszkiewicz.com.pl [213.251.184.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC281B3748;
	Mon,  9 Sep 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.251.184.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876299; cv=none; b=gOV2XLeMym8AwCM4VQWy/xmEoChjIB4wJcOSqvs6BiDcrEIZFMUAUeE3bQGGXzbg/H8Bug9u8Najj1fZOJR/pM3HQXvks6kWJxojxDphlsZlZk9wo3vzbRpGNBuBDRlPwGI31RxmIa4MCqVFIdX4CgWaA/BKmadAoiI4h/pXJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876299; c=relaxed/simple;
	bh=1lOMULwcBauh1sqgHcdJ6uL4LTWImRVViMjKIv46xvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKzbXuCJATvexVXXRRXeJGSWXPvGF4ZwSur0hYB3Gu1ifYJeghdt3wrbbJjEEgnq7RmJqmfzYiJDvbVcuhaL18rvhcI2OTTv7PJ0krx5qdOn0svkRJieDI95irKggmA/oPd3hZXn6Ywuwv7ryrScmgwz2eVRaaGfWHIyrlqKDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; arc=none smtp.client-ip=213.251.184.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: from localhost (localhost [127.0.0.1])
	by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 8AAC0260984;
	Mon,  9 Sep 2024 11:55:37 +0200 (CEST)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id rkwDbRIG9CqB; Mon,  9 Sep 2024 11:55:35 +0200 (CEST)
Received: from puchatek.lan (83.11.24.101.ipv4.supernova.orange.pl [83.11.24.101])
	by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 4E68A2601B2;
	Mon,  9 Sep 2024 11:55:35 +0200 (CEST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH] cpufreq: use proper units for frequency
Date: Mon,  9 Sep 2024 11:55:29 +0200
Message-ID: <20240909095529.2325103-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I booted my RK3588 based system I noticed that cpufreq complained
about system clock:

[  +0.007211] cpufreq: cpufreq_online: CPU0: Running at unlisted initial frequency: 816000 KHz, changing to: 1008000 KHz

Then I realized that unit is displayed wrong: "KHz" instead of "kHz".

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04fc786dd2c0..76da29c2bd3f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1539,7 +1539,7 @@ static int cpufreq_online(unsigned int cpu)
 			 * frequency for longer duration. Hence, a BUG_ON().
 			 */
 			BUG_ON(ret);
-			pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
+			pr_info("%s: CPU%d: Running at unlisted initial frequency: %u kHz, changing to: %u kHz\n",
 				__func__, policy->cpu, old_freq, policy->cur);
 		}
 	}
-- 
2.46.0


