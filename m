Return-Path: <linux-pm+bounces-13320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A09681CD
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 10:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D3D28147E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723B1865EB;
	Mon,  2 Sep 2024 08:28:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383E018754E;
	Mon,  2 Sep 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265707; cv=none; b=h27eANbhUkt4oBp2fRpXxJ+3jn4Rox80lCCZbU+ScbJq9wR8Zdk6xbUUTWxMY/7EtfTewdkhQ1OOxtCXhREkAJUw3se3BmDWZt0+pjqoaoBC67hfepr2vbQnwl+OTuPxMnDMVb1J+dE4OMegUww4+PqaZ1Qj6BSmb1s8vAjB/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265707; c=relaxed/simple;
	bh=Y59PE6FOhBP8a8YwZZtWys/kxKg9+7Gc0nG5ZazRhv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J6YMAWinCV8WXW7+7SoUMxDc5K6VhDt+HUHUWp1lmE+cC50ofujFIpLoyXBlK/X05qIx+pJDIU5f+kajXpMANxMHRGy/P/D7hjurkimm2fDcR0HqOtDOhJ75cPcNDKjm1Vg3Dktg/QfHHjTsNpLY/ai/f3bwcu0tM0MNorO6GvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966d57722b75-d7b79;
	Mon, 02 Sep 2024 16:28:19 +0800 (CST)
X-RM-TRANSID:2ee966d57722b75-d7b79
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866d577213ed-915e4;
	Mon, 02 Sep 2024 16:28:18 +0800 (CST)
X-RM-TRANSID:2ee866d577213ed-915e4
From: Liu Jing <liujing@cmss.chinamobile.com>
To: rafael@kernel.org
Cc: viresh.kumar@linaro.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] cpufreq: Fix the cacography in powernv-cpufreq.c
Date: Mon,  2 Sep 2024 16:28:16 +0800
Message-Id: <20240902082816.2599-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'swtich' is wrong, so fix it.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index fddbd1ea1635..64fa92623a51 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -692,7 +692,7 @@ static void gpstate_timer_handler(struct timer_list *t)
 	}
 
 	/*
-	 * If PMCR was last updated was using fast_swtich then
+	 * If PMCR was last updated was using fast_switch then
 	 * We may have wrong in gpstate->last_lpstate_idx
 	 * value. Hence, read from PMCR to get correct data.
 	 */
-- 
2.33.0




