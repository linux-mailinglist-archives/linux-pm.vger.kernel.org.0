Return-Path: <linux-pm+bounces-20864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B0A1A369
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9098A16D4DF
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E0A217716;
	Thu, 23 Jan 2025 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmuA34BV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857F216E2F
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632381; cv=none; b=sA9G6XZ1yl+4x6Rg/BG6aqI+6v5SneWtlJjNru+NzCnI+Lj8a4tXvUOQbmV4W66OuGRx7PezGUciwC4blri2LLsB9e/3WyKXBUXBxLjqk0FY2bn7tY7hEspZTJNhPTzQdjH06EEwuA+0mab4dYU4/Md71i7vxBEesCEoU596oEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632381; c=relaxed/simple;
	bh=9oOev658oCheE+irPhEfKW32u9AIDGcsZDIGTbry3tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FrKX4OTwNp8FTZCnZR3zexYu87gdUfQrk1nGmmg82yIVY6nh25QjFsuN0Iif7kpDqaIU1KvTHQjRyJDiT27XAk6nW8tdu+XnG66pRg5XeADqb2c4jmT7tW40wN/U58xS6JiLPBZKKyb/poDR4T+9rAUESEpL918oHU59QP2Ue1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmuA34BV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2164b662090so13513605ad.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632372; x=1738237172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1qoMOIo+OLN2OfUa7PaSWk3Sg/XRX4qZfCM9AlKq4E=;
        b=AmuA34BVruhkv7BlNBzt6ZAzbWlhodGNnQI9B+AaMD5Sun99gKKIqeZekQsRsj3sWk
         muYfeyNvQRwEsON+sAJScHmKeUKuYzyYbGsyqLsNHaX9m0CEAl1ouTyN5pmbXzhTuzgq
         ZuZH8CfqDbsiBuo1RR0Z75jLKspqI2juRbt7shmTgVTzNwub/Nbg/LuUH0EHY0gby9OV
         rLF+gP8OR1YIMCDt5QeABwZTm6wUqUzKwLXtCBHymYKuRGMF2Q7wGcRfNqdj8FSpb24o
         8vm4gX0xXE4OAaoJDPXRzqh5kR9MG0ihsV798JutjUJgQv4+sXhAl3jBlQ0n50sWRuIP
         QIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632372; x=1738237172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1qoMOIo+OLN2OfUa7PaSWk3Sg/XRX4qZfCM9AlKq4E=;
        b=XWiZjc1T3imRrfsDoIiCYIpZwnYJ2iWXwERkVkpmMmGMRZJp8I3XZ7UZR9cz5gpJrM
         ex1n7ykNoH3EN3VS1DtMWAYYMLymKmbFUqEqdOPqrkGeA3y4ZYYedJEtKd4z5Hm75oxc
         zYzFytLR489ItGp1scs9qPp+voudiYAt8rEPxSDOoR3Lis7ZYlcNKiPJNg6La08BbRiM
         52flBgHkXIt2Qg7qBa9ZTSGS/Y2vvkVNJfZd1QiohUrYJb4ahw9FbNal03VZ/Ikbrrml
         mJjQuU1Fp8I/jkahIdA0srZYbV0mBT4rOVCLSWTQDJK5rvys61lq3fYwRECri8QVOp3N
         2R8A==
X-Gm-Message-State: AOJu0YzCTMDNwGwlANPWktu1uvHaVDa1rCF1rTsC1LWoy1nYMCT/eWH3
	ut3gTTsIyfAuRG2rFyIxp8L7nUHgr0ESu/pmzC85FzOyCGjW24sPJVRIT9SVuAo=
X-Gm-Gg: ASbGncu8MHtroNUZyBInuoKeHVak5rmirxpqiDO6JUXTmCHJGMboO0EhfA1iuC/gP2h
	03SVC4Kno5AgWtSpj4CiFBa4DJlJ/9++yTyyGF7JWo6wZNox6qtAKmDS/vGDTwMcwruYpYmxbP9
	mQHEM4ZJILdwNILgNSEFcv6Rr1rRlZamQrO18i1S5zyoDDj181WWfUM7qa5sy+Zj1ECf5igfyEs
	XtVdaXla+jaQlxKNjbDjbULzvoCxbY/G1fSDBR/NbEe9RFTYYRaZ/8GxFTXWsrHHVgSGllvgoMe
	zmTaFdo=
X-Google-Smtp-Source: AGHT+IE1AhkQc7qL6VS4zFBoS2qj3rH+icxtjNX5Hc7Cx+vRs4GTv/u3rSA4LANdaudIKlcxq8Pbag==
X-Received: by 2002:a05:6a20:394b:b0:1e5:a0d8:5a33 with SMTP id adf61e73a8af0-1eb21480ef0mr43895785637.18.1737632372479;
        Thu, 23 Jan 2025 03:39:32 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab848321sm12935134b3a.76.2025.01.23.03.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:31 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/33] cpufreq: spear: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:06:03 +0530
Message-Id: <24443216b7d69eb64d01441eb8d9bd0e23e8981f.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index d8ab5b01d46d..707c71090cc3 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -165,7 +165,6 @@ static struct cpufreq_driver spear_cpufreq_driver = {
 	.target_index	= spear_cpufreq_target,
 	.get		= cpufreq_generic_get,
 	.init		= spear_cpufreq_init,
-	.attr		= cpufreq_generic_attr,
 };
 
 static int spear_cpufreq_probe(struct platform_device *pdev)
-- 
2.31.1.272.g89b43f80a514


