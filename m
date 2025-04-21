Return-Path: <linux-pm+bounces-25765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B90A94B4C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA28816FF18
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 03:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46701258CD5;
	Mon, 21 Apr 2025 03:00:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29000256C6B;
	Mon, 21 Apr 2025 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204434; cv=none; b=Cf7gGwcbCuYH9bz3XVU1P108WVwVsBtjIHq8WOz6rnUQ2b/9InH0Ptn1Cj1U4hLubnH/nVL+3CR1ZaD+ocXwZ6ZPkFvVHkDpaJoYQJQGpIBAV7cwP7/TXMfiElDl6okzQwvXFi05TqYq7M5Q8jObMZUeRAD1kniTnTKwN0Toqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204434; c=relaxed/simple;
	bh=u+JYZi/yjnuJmHTP3iaEyJF1IcIfGqUCW7J1iGOT5eU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+xC2klE7ylwlwp7eMIFFJ0UtAsBAPeA6hfK27ap+1ttkPxUMXdVBOXB4MhRbGlPZ1GxjJ9aA3CtSze1+SzSkFzC2JIh4gWCP0ksMQjicrz2E7QiEli4MNziBNARQTSt3S9gD1Piqabw44xiFsSE8ETVLLm0jpIl1Ox/tMcLjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZgqpR4Spxz1cynL;
	Mon, 21 Apr 2025 10:59:27 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 803FB180472;
	Mon, 21 Apr 2025 11:00:23 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 11:00:22 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<cenxinghai@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 4/4] PM / devfreq: Check governor before using governor->name
Date: Mon, 21 Apr 2025 11:00:20 +0800
Message-ID: <20250421030020.3108405-5-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Commit 96ffcdf239de ("PM / devfreq: Remove redundant governor_name from
struct devfreq") removes governor_name and uses governor->name to replace
it. But devfreq->governor may be NULL and directly using
devfreq->governor->name may cause null pointer exception. Move the check of
governor to before using governor->name.

Fixes: 96ffcdf239de ("PM / devfreq: Remove redundant governor_name from struct devfreq")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/devfreq/devfreq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 18e3f7e063a4..46f3a8053197 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1376,15 +1376,11 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		int ret;
 		struct device *dev = devfreq->dev.parent;
 
+		if (!devfreq->governor)
+			continue;
+
 		if (!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
-			/* we should have a devfreq governor! */
-			if (!devfreq->governor) {
-				dev_warn(dev, "%s: Governor %s NOT present\n",
-					 __func__, governor->name);
-				continue;
-				/* Fall through */
-			}
 			ret = devfreq->governor->event_handler(devfreq,
 						DEVFREQ_GOV_STOP, NULL);
 			if (ret) {
-- 
2.33.0


