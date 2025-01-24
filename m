Return-Path: <linux-pm+bounces-20917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2259BA1B213
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572DC16D78C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914FB219E82;
	Fri, 24 Jan 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQ+vRevF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2C219A91
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709116; cv=none; b=bS2clSi2jMuJMuFfSUzbn9+f6FU6zEV0CJ/WZdV25wuu7j+okp6ONfe7t/ehBytSbPe062ZfGd/L6radWNbBdDYSX9zj7cO3oOWdbg0ATWLXNKiODHptf6RJEPHzXqJtTxQg20+Bucnkxr4Fg1N5RNbPErmJwSHCa1dc668CRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709116; c=relaxed/simple;
	bh=wv5lK1t6q3Up5NAGc8MERFbt25hqrNJiRLpe7fRJRlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8Chvmy802Lyt5UT+rHEbfBLZsa2x0CecWYSDCH2d4Shhdd00KPoXBkRDVZp45S8dM4tq2OII1hBQ5tLv4RgdDH5mMVttNFQgpj2qH6uotx42GV/Z4aB1dtoZyYCWUfdI93ZoJochgXrCFWpDJId7rtoLQZBLlgvP4NT9OyIn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQ+vRevF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so2662313a91.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709114; x=1738313914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTbVj2JiCj6/pNfOZdRNpD/qIv2cEUDOMfDgqaCF9EA=;
        b=DQ+vRevFO72QonqFSYgwpFlvFqDyDWLOvLdW3xy0+n6kVmHwXDWWtYS1xZExz4vjGx
         hyQoRbqXn61KhyqyNbIZr9sv5h0BLKC4BssYN3UuIeTK8qfQM4WUFHO+rjNwz7xMsCAX
         CzOyrXtDsaxrla5+5Oz9cZk6P36klHBScmbl5xLcEgyu+Hd8folofH5QjLZZLCAESzeH
         UpVwl/nwPoBUM8Mm1H6JCl81vbHrZkR9V4MZC9PSVS7O3XY7B3RTu0X4ys/2+EOO+cZw
         bmUooyb0webi/GwawkzYkN3N8VT/f9C1G4htZPNm86NAuH7eFrbCW/UR4WVJAY3OYrjP
         yXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709114; x=1738313914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTbVj2JiCj6/pNfOZdRNpD/qIv2cEUDOMfDgqaCF9EA=;
        b=RhnGPj2/y8nrCA5uyPpJfrl5V3Hh8srmv7xfEmw4038q+J1psxOJGQ2OwBegAkuWpE
         TNxYABDWuXsQWSMWdi5qxTFPNZvL77p8T2w6c64oiz83P8BhUp44Gxq7n5jPEOTNu+Ty
         GQeLibrZedzLenIvyDd6MJ9zxjXag3Ix9i+DVo049GqQQeiI6//tVYQURCKzDQDd1Fhq
         z/2IdBURHv5YULykRVxob+hgvUKz53x31rp8t2FAI/6GyrjifpkF3yW1PhDBibJbkkEj
         x0WqirHx2MTtGf5P26IPjfyFrOMjswqoP1xR+BQPSIzUNXK1vQeS/x/q4xs0VuQqAsft
         5hQA==
X-Gm-Message-State: AOJu0YxhCQ6uoVlzHkCKlOpbIpnep3Cd66nclf7iyMZQvv+KrwYmu7lq
	JtHUtRnMu1Rs5Xa86uFL5BXTxB06XL8hQc2kxneTUaogxCTkvKIZcnpE9ls1AAE=
X-Gm-Gg: ASbGncuOnz6NV0qt+EVouK7h9lOMCa26jhigHg8JL9ADSs8PicGzJMioI8iBtDtRuoy
	WGoXhlkUgqCKjBvig2lhrrT8Fw868NB9r5Orkf4rDPTp7p6p9EH30DDgz5fk34XvwtoTN5F0dCQ
	euJU4IHT1Vfr9NZ9zExaVl/i980uUI+w1Vh9tcd8uBIe2po6p13KDs1gONdC+TL79NlPvCS7ksA
	TGyMHZlydtB1HBq5/+LAyEsAVcrUjU5AGhlBwqEFExdR86uIqkO0brIwEDUYrfLY/aINgIU+7qw
	Fp/4Pmk=
X-Google-Smtp-Source: AGHT+IG4QgMNgRuPdhLzSefYDVkG5uWzW/GyEACYlaytVe9bY03mqBN9ChD/+04NOVeTJUhuQ1Jq+w==
X-Received: by 2002:a17:90b:520e:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2f782d4ef17mr35435847a91.22.1737709114299;
        Fri, 24 Jan 2025 00:58:34 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa67840sm1259487a91.21.2025.01.24.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:33 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] cpufreq: staticize cpufreq_boost_trigger_state()
Date: Fri, 24 Jan 2025 14:28:05 +0530
Message-Id: <751338633b070ee570c3c7da053bd6b9497ee50e.1737707712.git.viresh.kumar@linaro.org>
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

cpufreq_boost_trigger_state() is only used by cpufreq core, mark it
static.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 include/linux/cpufreq.h   | 5 -----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index faca6a143263..0782a6d89df2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -87,6 +87,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      struct cpufreq_governor *new_gov,
 			      unsigned int new_pol);
 static bool cpufreq_boost_supported(void);
+static int cpufreq_boost_trigger_state(int state);
 
 /*
  * Two notifier lists: the "policy" list is involved in the
@@ -2805,7 +2806,7 @@ static int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
-int cpufreq_boost_trigger_state(int state)
+static int cpufreq_boost_trigger_state(int state)
 {
 	struct cpufreq_policy *policy;
 	unsigned long flags;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d237ef91d1f1..0e708830d30d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -778,7 +778,6 @@ int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
 
 #ifdef CONFIG_CPU_FREQ
-int cpufreq_boost_trigger_state(int state);
 bool cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
 bool policy_has_boost_freq(struct cpufreq_policy *policy);
@@ -1150,10 +1149,6 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 	return 0;
 }
 #else
-static inline int cpufreq_boost_trigger_state(int state)
-{
-	return 0;
-}
 static inline bool cpufreq_boost_enabled(void)
 {
 	return false;
-- 
2.31.1.272.g89b43f80a514


