Return-Path: <linux-pm+bounces-1598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B90081ED12
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 08:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4463283773
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897B6134;
	Wed, 27 Dec 2023 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRMdmhv7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA035680
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so19612245ad.2
        for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2023 23:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703663910; x=1704268710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8t7/AbGXjepf/LwJRFQy50BWlpGsnwthyjQJC5TMKQs=;
        b=tRMdmhv7c7kCX988h07V7Lc+tmGIYENi+emPbPU6pUB9sTs/N/b7qLpnp67dXhqgJY
         qOjvJacEYzLMwZQHGDA8ZsNQH/kIEGznIg6iyjjbozP7UzgA6GLP/znA5C/pSvHsWuo6
         io16DKaBchv4a8hxXAvSVBFUt3Boz9bjFQGyUXvQVRmSC0dkbOjGZsPKOmFMEfoYkrKq
         Bs6wwyy5W2VnU7q+N2wjNxe9zmZdBy/mRPZC6hoZSoBHNVKgFw88W7l6itvIPOA2LkXY
         WMTNx4p/aj/NfbuEBPzYaOXsM9x3q03xW0PRCyXTiGj/YsAXUkZQKZDrsXacDsm78C8h
         1bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703663910; x=1704268710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8t7/AbGXjepf/LwJRFQy50BWlpGsnwthyjQJC5TMKQs=;
        b=dUQckTVwQ7l4nMAEKl2HgJvFGakeyqoGkbuef6tnboUs6X/55EJwYLj0U+lFf5PA0y
         Lci0XoJD78Tu82gbWwChIK8293VRyw6Jeo6Iol2dadsWwWQNWdCAnQpvW9ZSRt/SChoC
         dkBYPZSAGAFJWAmoTnZRbOGpQvRabWJru7g5qRuEf6lnSQdrRyBm2SHtWcWn9qX6GA8S
         iEPe7W9BGfZRpZRTMUohHQCc8a2K77sj7Nv9KYi4rp7B0qN5dNwJihMc4Bs6PhUOTWSp
         BBes5u+hXl5uvIe1FN1ClVLNnwwvJ+Z3/DKkGjZLbUkoUYEDOnbF9DUZ+2/al/uVl76u
         GHDw==
X-Gm-Message-State: AOJu0YxvYWDoNGhnjQhvhni+v6FkWK1W04sTSN9J4kX5Q6XCCdUBxvsa
	HN78iw2u2+wQ6mOhw12oIGDCRY0ZkuxzFw==
X-Google-Smtp-Source: AGHT+IH75JcNEW1rZ0DW+fJLF9UJq172z0WlP+a3B0raXcxKnbLFDoaqgaYeRiicq3lmS+i8XVdP9A==
X-Received: by 2002:a17:903:22d2:b0:1d0:c345:c1d7 with SMTP id y18-20020a17090322d200b001d0c345c1d7mr3822513plg.77.1703663910512;
        Tue, 26 Dec 2023 23:58:30 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b001d40ca98b9esm10772936plb.65.2023.12.26.23.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 23:58:29 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: The level field is always of unsigned int type
Date: Wed, 27 Dec 2023 13:28:24 +0530
Message-Id: <ba367479c7ad0b870461024cd5ae7a1ea6e1e3db.1703663882.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By mistake, dev_pm_opp_find_level_floor() used the level parameter as
unsigned long instead of unsigned int. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 9 +++++++--
 include/linux/pm_opp.h | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c022d548067d..49b429984bdb 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -842,9 +842,14 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
  * use.
  */
 struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
-					       unsigned long *level)
+					       unsigned int *level)
 {
-	return _find_key_floor(dev, level, 0, true, _read_level, NULL);
+	unsigned long temp = *level;
+	struct dev_pm_opp *opp;
+
+	opp = _find_key_floor(dev, &temp, 0, true, _read_level, NULL);
+	*level = temp;
+	return opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_floor);
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 81dff7facdc9..74768c47d790 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -163,7 +163,7 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					      unsigned int *level);
 
 struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
-					       unsigned long *level);
+					       unsigned int *level);
 
 struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 					   unsigned int *bw, int index);
@@ -330,7 +330,7 @@ static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 }
 
 static inline struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
-							     unsigned long *level)
+							     unsigned int *level)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.31.1.272.g89b43f80a514


