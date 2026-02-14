Return-Path: <linux-pm+bounces-42651-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLPIN8i8kGntcgEAu9opvQ
	(envelope-from <linux-pm+bounces-42651-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:19:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C013CCDD
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D766300598C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F9D299950;
	Sat, 14 Feb 2026 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP6qGDr8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1292DCBF4
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093188; cv=none; b=iln0trWUB2I0zNImU+QsExUj4piHqeoKvu8VFbbHiuxk6ha0rm85o/jWCTNrOnvkcNtSJTW0qMZu3WvytCeKfWwVc3TWBoUHlY1CJ1cHNrUO4H9GOKXSdXuN3yEm0UMVfDwIbI0meOZsNttVksxBuRBYDlf7qEVlvDvUX6W3ZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093188; c=relaxed/simple;
	bh=qdjAMl7pVZLzrJY8XhRsX1huAGzjKOhJ/3DLSBciWKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTClfSmbQT+3/WDrH7E2JfqkYAVoAA+xgdMN5SyhudHqSmnHdAbHWA3v48xNGH67jjRVqe6FwTki6Nfdt7sMfD5bX3rT/VtA9TPDg13CGzS5MKSskCz4sB9tAUwcL2nTg/ApHdUPbHS4uQgB7+yCqvenYSZdGADwGVz/6rvBd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP6qGDr8; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a929245b6aso20953965ad.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093186; x=1771697986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBz/VS0n7QHhwwTW/twbu0ESsUBq5BIV+GsuXlYuLBc=;
        b=IP6qGDr82tSPBUHJVoAiWUBM3kbAl4bL6mB0fBf6WjtnwCYk++XeF1kbZfKoDmpJYm
         isijt1KCNOVs8o/wsoWq5vocrdOTqEGMZ+HbWQyttawLLO/UHUPNaqEfIVPYwhIGU3IM
         yNNgS0IMbzhGxTBm/GDTVret6gEbYcLrpQ31HCT+RgWzMa62w9eTKWn7CAUg1vxw2pzj
         iq1QsxrJ7i4S12uJesjjwy7T2SOBUS3wsHnnZqL8FL1b97crLUmQG0Z0gq2U2WOllcx4
         MQNQQ01ku99ahDK4yabU3yi4qEH890SPAlG7eb7JZzxDvMoSyC8lbT5TvVjs2myAd5Fj
         2p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093186; x=1771697986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBz/VS0n7QHhwwTW/twbu0ESsUBq5BIV+GsuXlYuLBc=;
        b=CIiRnDjrCVlpuKipUwZ93Wib1G3erCppgtgVVkji8gSE4Jqrx+C2ZJzFl57oX6h9wn
         k23nc0OkF6h5oNyL+PJQ5R7CGHx/ErTbjIZXYJ58Oin24WZAvt/SRPbdPcaCCgy5aXVs
         be/85wQwp1O8RoTUOrbHf6knJZ4EWj7SXcL32HrspQXGhZLwq5fRxiESdfKSaqm1plm2
         u1pEaIQ0Lq7yf83Nx1+6Dln8agRMLXiDNgG9scgkL9fr73glnAAuZZpilGGFahShntTX
         jnlT8BiN7mYHq2m8rnjPOOae1bes79m0oRtbocoGuKXQ4EeR+hMDBuTcE3ZX+BmVqoV4
         fcQw==
X-Forwarded-Encrypted: i=1; AJvYcCWS+sk62184KXYsbe8fkBZaoe0SYKrSqwQymZf74mgMO84TpsX61JKKAKWKeiD2BQnM5D3oAL/BOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjBLrKGnm+fTtG7D6wMFd9HaUf7R9DM7kBUWg/3BJoIGmdBNO
	SnbOsR5A6+wy+ty4jqGRTPXfkLP97G2trP11L3TB+8Nj0o8pWOx+qZMX
X-Gm-Gg: AZuq6aIAzw6mIEA8+8ny8T8rQ1Fv/r1ae2BgSvwYMQMPxSQy/SadjoLhmdgoaExnHIm
	4/He0Mk3AKYlBWy7HooHpzEMPF2mJp9iZk1857URjB8xwTn5w+saDagOZrmXx+NnFLkONHb0yEE
	a887GPrP7y1+wNELYYC710yXqPUkov8k9sJCyXjAl9g1dm33P+82RMjY3XaYydN09bfaRw5tTB4
	WeMGH9U7F2STdcmscsng0+yBhZDLbB2PlRhp7aVKFuYHWcHzvf7kZ5sysKrW6kxBXL5Zc/TPpvo
	7VBeLASCfSk1tUnN9vFOiO+FoxQVHSUTvKfgzC0BKvu9T9W78K8IYETR4llhn4+LR9so3qbpQLi
	fw1BdseRJod6GJ/UoUwZtk0KlbA3+b/exbVPonmqF2ZqzdqK2HAAL2drkoKaXD0lzFy5zH+R/56
	Hn7iq0aP35dry8Cq7PlwE=
X-Received: by 2002:a17:902:e5cc:b0:2a9:db7:446a with SMTP id d9443c01a7336-2ad1743398cmr29145525ad.9.1771093186513;
        Sat, 14 Feb 2026 10:19:46 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:19:45 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 1/9] thermal/drivers/exynos: Refactor clk_sec initialization inside SOC-specific case
Date: Sat, 14 Feb 2026 23:48:58 +0530
Message-ID: <20260214181930.238981-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214181930.238981-1-linux.amoon@gmail.com>
References: <20260214181930.238981-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42651-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,samsung.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 886C013CCDD
X-Rspamd-Action: no action

Refactor the initialization of the clk_sec clock to be inside the
SOC_ARCH_EXYNOS5420_TRIMINFO case. It ensures that the clk_sec clock
is only initialized for the specified SOC and not for other SOCs,
thereby simplifying the code. The clk_sec clock is used by the TMU
for GPU on the Exynos 542x platform.

Removed redundant IS_ERR() checks for the clk_sec clock since error
handling is already managed internally by clk_unprepare() functions.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v8: None
v7: None
v6: Add Rb Lukasz and try to address Daniel review coments.
v5: None
v4: Fix the aligment of code clk for clk_prepare in proper if/else block.
    update the commit for clk_sec used.
    checked to goto clean up all the clks are proper.
    drop IS_ERR() check for clk_sec.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 36 +++++++++++++---------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..04517d52afbd 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1040,26 +1040,26 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk))
 		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
 
-	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
-					     "Failed to get triminfo clock\n");
-	} else {
-		ret = clk_prepare(data->clk_sec);
-		if (ret) {
-			dev_err(dev, "Failed to get clock\n");
-			return ret;
-		}
-	}
-
 	ret = clk_prepare(data->clk);
 	if (ret) {
 		dev_err(dev, "Failed to get clock\n");
-		goto err_clk_sec;
+		return ret;
 	}
 
 	switch (data->soc) {
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			ret = dev_err_probe(dev, PTR_ERR(data->clk_sec),
+					    "Failed to get clk_sec clock\n");
+			goto err_clk;
+		}
+		ret = clk_prepare(data->clk_sec);
+		if (ret) {
+			dev_err(dev, "Failed to prepare clk_sec clock\n");
+			goto err_clk_sec;
+		}
+		break;
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get(dev, "tmu_sclk");
@@ -1112,11 +1112,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 err_sclk:
 	clk_disable_unprepare(data->sclk);
+err_clk_sec:
+	clk_unprepare(data->clk_sec);
 err_clk:
 	clk_unprepare(data->clk);
-err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
 	return ret;
 }
 
@@ -1128,8 +1127,7 @@ static void exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->sclk);
 	clk_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+	clk_unprepare(data->clk_sec);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.50.1


