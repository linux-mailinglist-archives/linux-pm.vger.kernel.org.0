Return-Path: <linux-pm+bounces-1879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54B9825228
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 11:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31CF1C21775
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623262D042;
	Fri,  5 Jan 2024 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCDxuDH0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958E2D029
	for <linux-pm@vger.kernel.org>; Fri,  5 Jan 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce2170b716so995715a12.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Jan 2024 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704450898; x=1705055698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ+3lkUD3PcgGfGxvkRaWTL+ma2UbkIJWkqsRj7YstE=;
        b=KCDxuDH08tdQOVTXAWmPxq70pEK1uW7fGJDet6ALwH697BN8l52jB3aQnmjX5s7UHG
         bhVirNpURID9AQO26/hnHfp4FrG5fLl4wv1cV4WNYazQkVkfeo0i7wCmn0U5zz/gVjS1
         MT2TbVTiJwtZgrCPGCRJiG1rUc63wNUFQD1woDmAhqgRMTeg2fWnvDfD0hek685mA5at
         wVcqjDDt1j646f1R+lxdtcj2locmLy3bGpV9ZqwMaJPYIy3KvuW/YKIyA84dbafk7KaD
         ajzMeu9XB26TETptGAZomv7rK/KimwpuEuV1EKnG2PrP0gM7Mbx67/wpzVE066RMgaeg
         UFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704450898; x=1705055698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJ+3lkUD3PcgGfGxvkRaWTL+ma2UbkIJWkqsRj7YstE=;
        b=IKMbqOzkCJ8HBRCM5Kzu0erPIjTTHFw6c3limCckfPyVykaWQq9btl7S/uvNA0ptgQ
         /HJcgxfmkERPd1cfW4Hn4DlX4x7V3NGbZgrIPDcraIQPJZ5uVnEkCn3iIkyFxs8b3Z61
         Z0qZ26aZQSm405S45ridlyB6U6sIPijidH4FmGP9oLdRrlAfL9L84caoj3rzrc8CCtwG
         gXN7xFscq7Osbn9LkXWUrWQjDAnGgqn7WKCsAEkyyVJoKyUEL8v2525Y98R1tNh7mWc7
         pFe15QccoW81ACepOlgwUKijiDZVTq5KOSehyxGEOHjowqem2M9mKdtUcIWecZqRy/8l
         vO0Q==
X-Gm-Message-State: AOJu0YyB6JYz0AzBXr3bSthbjTRtL6CYTAjGVNjVxvnE7IWMpokfOJSO
	eYTnpMW+5nLEkH0vuADG4CwEnMb8IcJZtw==
X-Google-Smtp-Source: AGHT+IGUo41ABXS8rCxKJiuRcNLhqF2QPdz0DGJ/Fk7r3EeZouzt3jwZJdmpivBVOkXjjJi3lr2lZQ==
X-Received: by 2002:a05:6a20:c759:b0:196:2018:2bac with SMTP id hj25-20020a056a20c75900b0019620182bacmr1486037pzb.107.1704450898337;
        Fri, 05 Jan 2024 02:34:58 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id ks13-20020a056a004b8d00b006d9b93ca5e2sm1126988pfb.146.2024.01.05.02.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 02:34:57 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"v5 . 18+" <stable@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Pass rounded rate to _set_opp()
Date: Fri,  5 Jan 2024 16:04:52 +0530
Message-Id: <7269c250db1b89cda72ca419b7bd5e37997309d6.1704450876.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OPP core finds the eventual frequency to set with the help of
clk_round_rate() and the same was earlier getting passed to _set_opp()
and that's what would get configured.

The commit 1efae8d2e777 ("OPP: Make dev_pm_opp_set_opp() independent of
frequency") mistakenly changed that. Fix it.

Fixes: 1efae8d2e777 ("OPP: Make dev_pm_opp_set_opp() independent of frequency")
Cc: v5.18+ <stable@vger.kernel.org> # v6.0+
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 29f8160c3e38..5e6cfcbd2e87 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1352,12 +1352,12 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * value of the frequency. In such a case, do not abort but
 		 * configure the hardware to the desired frequency forcefully.
 		 */
-		forced = opp_table->rate_clk_single != target_freq;
+		forced = opp_table->rate_clk_single != freq;
 	}
 
-	ret = _set_opp(dev, opp_table, opp, &target_freq, forced);
+	ret = _set_opp(dev, opp_table, opp, &freq, forced);
 
-	if (target_freq)
+	if (freq)
 		dev_pm_opp_put(opp);
 
 put_opp_table:
-- 
2.31.1.272.g89b43f80a514


