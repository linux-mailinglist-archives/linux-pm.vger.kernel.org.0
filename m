Return-Path: <linux-pm+bounces-19505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296B9F781E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438D3188DBEA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E99217701;
	Thu, 19 Dec 2024 09:13:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683C149DF4;
	Thu, 19 Dec 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599612; cv=none; b=eslypUGeO5SZjc3al70CQqAfaE/OM1dF3J/zapilNMyjG672e6UNjkAS2eO64nsHGMZR3qxuw3/5MerGBW3C5/1ZX0XR1BibDiHQVnV4IECc3nKVIFUSE3M+laPxyQflVJA7JupGfdpvQho4WaVUyYx1NAfTx5nvHXmtDrXb2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599612; c=relaxed/simple;
	bh=FLyhzf61d1e5xczKgiwad5y57JUj3aNOvMvwhXidjkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ubWaN9WmGNtbcGI22IxehU2Wl1TCAECdOvy/HmaTzR8qL6Bj6ugDWw0p7QvcPQd1RmyiUoFzH/VxMh3Pk7KWdHw3Gi8IDgyIyeYtHW1Xd+iKPO1qTlxvI0mQ2hGI5UNlWEe1z6HLsPIRiRY3QizlHQZe6umlgEBTxGf4Qpz3Z0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 4BJ9DNrQ094464;
	Thu, 19 Dec 2024 17:13:23 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4BJ9BKPu084324;
	Thu, 19 Dec 2024 17:11:20 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YDPqf6zzBz2Mjnt5;
	Thu, 19 Dec 2024 17:09:02 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 19 Dec 2024 17:11:18 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <rafael@kernel.org>, <lukasz.luba@arm.com>, <len.brown@intel.com>,
        <pavel@ucw.cz>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>, <jeson.gao@unisoc.com>,
        <di.shen@unisoc.com>
Subject: [PATCH] power: energy_model: Rework the depends on for CONFIG_ENERGY_MODEL
Date: Thu, 19 Dec 2024 17:11:09 +0800
Message-ID: <20241219091109.10050-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4BJ9BKPu084324

From: Jeson Gao <jeson.gao@unisoc.com>

Now not only CPUs can use energy efficiency models, but GPUs
can also use. On the other hand, even with only one CPU, we can also
use energy_model to align control in thermal.
So remove the dependence of SMP, and add the DEVFREQ.

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
---
 kernel/power/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index afce8130d8b9..c532aee09e12 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -361,8 +361,7 @@ config CPU_PM
 
 config ENERGY_MODEL
 	bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
-	depends on SMP
-	depends on CPU_FREQ
+	depends on CPU_FREQ || PM_DEVFREQ
 	help
 	  Several subsystems (thermal and/or the task scheduler for example)
 	  can leverage information about the energy consumed by devices to
-- 
2.25.1


