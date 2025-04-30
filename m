Return-Path: <linux-pm+bounces-26441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B125AA44D9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 10:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FB1178A79
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E412139D1;
	Wed, 30 Apr 2025 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hU94Xi0V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35422135DD
	for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000447; cv=none; b=I8k1RVY0O76aOARuZFjaWoWn9OAOx92g6wPDOqGE9vCWTgqm4/BsRBBk+swB2V+Xw03tJyvqb5LqQqxksQ4de4+++XNDf3zSDC3dJ68rEm6hOIA4T5CNQ5J++0/iZSzD34EpWfSZuQLnQc3maw+SSjHzX+G0rYwgsLE3ZyPr9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000447; c=relaxed/simple;
	bh=TwBAWvhA2LMsfzhyPe3YteWvIvV7NRQQgO+b0MIyY2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PbKcwOg7djaWmHS3v4m3etD2Xqb/U0ggmJWUK10/1mZc+nVGicRvW2+WqpjPcGaVYtnJL/669pmHch2WrA+3g2TVfvsKuHvridSVZK48mAAEWyFi83ZB+4K1c2Lb3UJwgIYPaDRpyUSGMyEts+dn+/sM1vUMcmddCVYxoqgMQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hU94Xi0V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so45224865e9.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746000444; x=1746605244; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uc9OCM7ZIzJpNzeChHt6JK3Q3WLBO25WpfMZPcs6ME4=;
        b=hU94Xi0VZ1VYHLijxt+hy0dhmt+OGjjL/bmcMkTMS5IA0+V04UBj6y/JHuDEyBN5Yg
         t3e0x+8LRgy71mJZSwNrdnMwewNasb7SKcCt4XkfMn7Ar5GhYdfh7HlQyyuHpzuLTlbQ
         ikG54sfa13kbbbKbX+C1CgJdWY1SJk+N99uBrmlIRolKabm4Td6iXtNuFdwg4nD9mw99
         4rvsQklhXAikRXcwMokReJ1cjZ2TF12jKGF+Adb4KBUwQN46GFa0ASPL3I+FTDIgMRk4
         Qd93TSZlKWjqlbgdztkyE/S7r39kJZFdMle6/gy1lG2lPA4c3NK2JdDrpSGbPpWx/bV+
         nbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000444; x=1746605244;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc9OCM7ZIzJpNzeChHt6JK3Q3WLBO25WpfMZPcs6ME4=;
        b=YRDQCnXDTEidNSTar9GEOZv8X1inS5iaqx1w+Yb7Wv9C3oBNXdkqmy6lIdn8GOnL82
         lVWxWvcgueDd8Xz+ACmWs2RXFsUZF0Ewcdg1h/D3Yk3gTr0RErxxGu1GOFSFsaywMW7h
         VTb2Pk+8gNkk1h+/aMHeYuZGVeyZs4b7SVRWLGEpjy/RLmmpQYV3CT3aV2FJ0B0nw+rq
         JMZ2b2pWHDv9vzSHGnPaFKZHfO9HdgHjbf60LL8j/UgPLZsUkvrpKfewcx1kgBUfvvK4
         /62eZez6M/9UThThJalHBQH+LH6cpFfJJxUAjsaqomVAKYmnDrzEobsD8Kt2HJe7Q/0Y
         2xzA==
X-Forwarded-Encrypted: i=1; AJvYcCWiMQXDfBu201pJu2GK1L2ItkHNtZCE5wnA5ms6KaMKKhiixlqWwbAC/JRVa/5wOCtN1vhT9fbzig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSAgx7/1lXlvzDf51FcmSa/ow/0iaWuFTWN4LZt1ZpxjkS/nA
	40APYqQH1/an4C4zKv+cPJkne3jB28cQMcElcaxX0A7M8ttTLLbMIr5jhF7d6Gk=
X-Gm-Gg: ASbGnct2E3cpSzAVFRoJYL6hcKvlRuwIQcfXr7DmVSygZr4oowvkGWQzmiSl71XYCS5
	xeDhXojMk8UPnsN1knC4Ao7TjT6rMtB1h94EaZRs9HtJZ0I5H87exlinuzxYy2yMWu5oRV2UmS+
	azc+QZ0S2CIqSNNVvxGqp2cPfbqnyhYCxUAgO5KNLkTxgdRSdjZTu20P5rjWKo7A81tZB9UhA0h
	QNPEXzsR4Pq0XokKY6fiGygeIAeEWICRHL3OVlRPfyFmsIzBgWoCM9clfwaYNGdD1u9T0SPMdnD
	nB6UOdXJETZYrMaDWE5r9by7osktjUcNo4Payj29EOE5tg==
X-Google-Smtp-Source: AGHT+IHu/zka1ZNTIDULuYu0Lh1rRpwgaoOIaY8sTkizKLpXGbJF9/FHIhltJWjgeRoIv/Od3HWxDQ==
X-Received: by 2002:a05:600c:4e8f:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-441b1f35811mr16919135e9.11.1746000444147;
        Wed, 30 Apr 2025 01:07:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2aecc20sm15588745e9.13.2025.04.30.01.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:07:23 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:07:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] OPP: core: Fix loop in dev_pm_opp_sync_regulators()
Message-ID: <aBHaOOE8xHTsMap2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We accidentally deleted the if statement in this loop during a cleanup.
Add it back.

Fixes: 5330d0dab736 ("OPP: Define and use scope-based cleanup helpers")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/opp/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fc9874946453..f56ddae35ef2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2889,7 +2889,7 @@ int dev_pm_opp_sync_regulators(struct device *dev)
 {
 	struct opp_table *opp_table __free(put_opp_table);
 	struct regulator *reg;
-	int i;
+	int i, ret;
 
 	/* Device may not have OPP table */
 	opp_table = _find_opp_table(dev);
@@ -2906,7 +2906,9 @@ int dev_pm_opp_sync_regulators(struct device *dev)
 
 	for (i = 0; i < opp_table->regulator_count; i++) {
 		reg = opp_table->regulators[i];
-		return regulator_sync_voltage(reg);
+		ret = regulator_sync_voltage(reg);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.47.2


