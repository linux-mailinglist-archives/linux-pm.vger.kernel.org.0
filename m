Return-Path: <linux-pm+bounces-20932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED47A1B237
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C3B1883081
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532F21D5A1;
	Fri, 24 Jan 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivK3KX8h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6921CFEC
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709164; cv=none; b=fzp/jWfSqamupUMtL0w/crTQXmylfHxheqAVtV28tzC/c2NY07hSsAEvNZy9WbY/c1WRrJ5WxHEp1QEwtSeksD+lMdRnIxwA6NIt4XDdM72tCWaCFgAzqsUwAotkLYmLw3Zj5IZOanj6rM4wTdDY7yFyloEo5zqkLt5G0soYpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709164; c=relaxed/simple;
	bh=ULjGKJsjTMG+mV2ZHVBBRQHfJU3m/qH7+3cmB5CXtFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUUhsAjNBVzvOND+4vfeSv2zbajuXt3WYMm+QawIvlx+grtxUSm4vmBAz/a3ONJ6v+1X5mrW0j0Fo80lf/dhFUXihPMuoBcirg8hgcA2unCQYMuC1wSzMzpxiTomISRv+cujOJ8P10i4d9bp7qnb6d2P73AqOSJ6nePagSRWIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivK3KX8h; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21a7ed0155cso31504555ad.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709162; x=1738313962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFxnMHbxvTTBmLKPzYlOGeC6vsDfeppBbE2mTHF/Sos=;
        b=ivK3KX8hSf+M2FepoE+W8xHNaKhiG/NGCiKxovz4zf7OVDjCyLQHWhwzYfx2+LSKrl
         e1EY4Eaakxm17zFulnOr9UHT2Z+Z00p7X3c8ccIP7yPt/we7gfpA1Tcxl4K72S4dfUNQ
         v5FPVrbhoSWmfLM/vMVHfS6JHjn6z/qq7A4xceMIWQQPBjzaF8vgYYXHf3Jc04PiyKUu
         +wT6kEp43V+6uPIUPePW5xaF2waHOTuphzioeMf7TUS8++oDw1cLdEiRtYta/+AB4bQF
         plsHXpDbSXlGgJGUuauG7be2/wKEuMXCa/Fferfxly84/W1cfRqPNmId2hYoR4U3/1JL
         Rm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709162; x=1738313962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFxnMHbxvTTBmLKPzYlOGeC6vsDfeppBbE2mTHF/Sos=;
        b=ucrLQOLkUaChqUPsO6HSk0+f120JSfkvVuexdZepMzHZEEJXsJN0lxGT8vbpcTfe++
         ImiU0Ggyjj2exKAkwPtxLAw6VyVelOSsqe8TlNlDr7xIkXp2q810jHxFfehJilVdld3l
         Jc7DxFYQzxjI3GzDLZq0dOWLdoMCoaDcu6XNBAHI05Qr/lzlcylB6oqEWGALDWu9wxmT
         O1HZ4hc86moYElWTtRj2uXyPXy1hCV4qiWBGWuc7XcTmHGOE2RIlcoc1HucuHZ3Ud3AQ
         YdITKxSFrTPYcIjzYPzDz//5EBq2F5N1tP1pQ9BhRsCvn1Aa8P52qE7YhC0ygNvP/xCX
         LT6w==
X-Gm-Message-State: AOJu0Yy4TJjeTgqKlJpA3RgPfwffPLOqn9eyTB/l0+4TkhgBxV17YaLs
	AdlMoiCqdUnt3YfUpj8wyLeZ20ip3GEUPXtzIYxxcnO89+7adCHca3e75nKz0C0=
X-Gm-Gg: ASbGncuwLfk/ZRgOUc8dYXtAWZm4YT7DKLLlLzVzu9oujZd+y4ssi7COoNVfcZ+E3sW
	O6EwNbjS4ySmoTuqF0+wsoGNiv36UjAu5M8vpSP5fpyANXnexsCXUW00h8JopLYua+0vUza4CgH
	9qfenwbSoBpQg+wXFSe9eefmE71INqjSSOOj+Iwz/+vx517dXLg3xiSqDWBsk/SN4KJ1RQiCQhj
	xuZPB2vLEA+GvCPKrm0t1Y+SW5dIqu98A/UX7C0pucqF3/G7MeG3Y47kBfU/Bmj1v8ND/3tKpYs
	iptkWno=
X-Google-Smtp-Source: AGHT+IGA4U5PKUSB/Fl/ucI3iPDUmdY7tysT41SGfU4UDpVf+D8dWvWjPH6QK7CS/STrOa6a+1M9Kw==
X-Received: by 2002:a17:903:186:b0:216:1ad4:d8fd with SMTP id d9443c01a7336-21c352de48cmr370279565ad.8.1737709162069;
        Fri, 24 Jan 2025 00:59:22 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141c43sm11593165ad.122.2025.01.24.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:59:21 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] cpufreq: Remove cpufreq_enable_boost_support()
Date: Fri, 24 Jan 2025 14:28:19 +0530
Message-Id: <b93712eba5a114c9b68d22dcba532d22c3f12c67.1737707712.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737707712.git.viresh.kumar@linaro.org>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the now unused helper, cpufreq_enable_boost_support().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 ---------------
 include/linux/cpufreq.h   |  6 ------
 2 files changed, 21 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1e6ab42b405f..00d86dd7945a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2876,21 +2876,6 @@ static void remove_boost_sysfs_file(void)
 		sysfs_remove_file(cpufreq_global_kobject, &boost.attr);
 }
 
-int cpufreq_enable_boost_support(void)
-{
-	if (!cpufreq_driver)
-		return -EINVAL;
-
-	if (cpufreq_boost_supported())
-		return 0;
-
-	cpufreq_driver->set_boost = cpufreq_boost_set_sw;
-
-	/* This will get removed on driver unregister */
-	return create_boost_sysfs_file();
-}
-EXPORT_SYMBOL_GPL(cpufreq_enable_boost_support);
-
 bool cpufreq_boost_enabled(void)
 {
 	return cpufreq_driver->boost_enabled;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 466d186166da..cefd853abfd1 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -782,7 +782,6 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
 
 #ifdef CONFIG_CPU_FREQ
 bool cpufreq_boost_enabled(void);
-int cpufreq_enable_boost_support(void);
 int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state);
 
 /* Find lowest freq at or above target in a table in ascending order */
@@ -1157,11 +1156,6 @@ static inline bool cpufreq_boost_enabled(void)
 	return false;
 }
 
-static inline int cpufreq_enable_boost_support(void)
-{
-	return -EINVAL;
-}
-
 static inline int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 {
 	return -EOPNOTSUPP;
-- 
2.31.1.272.g89b43f80a514


