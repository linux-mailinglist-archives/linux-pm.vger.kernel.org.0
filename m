Return-Path: <linux-pm+bounces-16907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27C19BA82C
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 22:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCA1F214E7
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7015C14B;
	Sun,  3 Nov 2024 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="iYja/L+Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6F155392;
	Sun,  3 Nov 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667788; cv=none; b=nY6Vfj7nwZAQAeA5S7IVb8iN56Zc0a1vMWFWBJ5UXqs3rMfeEcFWfH7i6mdG3fRDSJFbXK1UGU90RI3WxaTbxnxxUYaepLj7rbAp6+1b4gL0bidqAYcuqZDHqVPdJO8ROlBjP4VjX2mlq2wqj/FcyE2yf0EwxqZpivg2mjuISqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667788; c=relaxed/simple;
	bh=RN0M6qzQAq5/lg/qY5cha5a7Da3fSLtOhF4obNnPasQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UGJGApGZuyB+o8Ko28Z76Im1cne7WTH7PJ6cwW4yNtfG05nwvzIyTJbSWfQH5obed/PkMfDa39mDScF53BlisheD+9slQXJ3CwF6xUQEZTTjZ+TvIzulszAT5zkkturtJ6ra//6cOmBGfbG9dfQQbqF5DSEtYbbAdROUBJJ1ivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=iYja/L+Y; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=OYn3TGqzIwKjwq71n9v00fPB4midY8IRa1hhwIt0HAQ=; b=iYja/L+YF5xKYwAezfF52lm16t
	1UmgMAw3GuWQWjQN7rWlpEoKsx9SDqeuUzX+rKm1t4Sjp07LBw8FqUIlPe1NUXwmMPhHPRun6m4UY
	uI78iYbYjaAUoSB+LJITCwIvs1Am2T0ykUbEGO9LfC0xY8af9/4d85jp1fOIKnwczXgm12UwBv0/X
	OvNB8CSM73QFsWgSPwDUII6USixtDOv+NKLC3Ojl+nU1aUckZPphurLRg8EUEq6w4T8WSMnaoGoZN
	aBZTqCkTA7h8t8r1ParwFiSrJDnmv5YTQKqG1OAUSTBg9i+ztG3EtSTWXLSXDkhqs49SULYt0RlCI
	IX+3L0jg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	zhipeng.wang_1@nxp.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: fix using cpufreq-dt as module
Date: Sun,  3 Nov 2024 22:02:51 +0100
Message-Id: <20241103210251.762050-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E.g. omap2plus_defconfig compiles cpufreq-dt as module. As there is no
module alias nor a module_init(), cpufreq-dt-platdev will not be used and
therefore on several omap platforms there is no cpufreq.

Enforce builtin compile of cpufreq-dt-platdev to make it effective.

Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/cpufreq/Kconfig              | 2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2561b215432a8..4547adf5d2a7d 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -218,7 +218,7 @@ config CPUFREQ_DT
 	  If in doubt, say N.
 
 config CPUFREQ_DT_PLATDEV
-	tristate "Generic DT based cpufreq platdev driver"
+	bool "Generic DT based cpufreq platdev driver"
 	depends on OF
 	help
 	  This adds a generic DT based cpufreq platdev driver for frequency
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 18942bfe9c95f..78ad3221fe077 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -234,5 +234,3 @@ static int __init cpufreq_dt_platdev_init(void)
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
 core_initcall(cpufreq_dt_platdev_init);
-MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
-MODULE_LICENSE("GPL");
-- 
2.39.2


