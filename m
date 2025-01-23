Return-Path: <linux-pm+bounces-20838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ECDA1A31D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC6C164321
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011420F07F;
	Thu, 23 Jan 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAislcQ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE920F064
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632289; cv=none; b=rP1HH46tNq96FqNrnIr6H+Z+Bh56b3y3gIVwLuYu4o0ZfzjSNtF15IcNa71ELB67f3w52qDdG/Fbzr7EDCAhvb1zlArDQdhHzlLa2g29ylQoFAovx+Yp0361qtXOc3IG6Y//qcubcxroSbsqMcXMQeLIYjonsXTTxIzl9iJQ8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632289; c=relaxed/simple;
	bh=TK/02vJH9qxC6L2RbiiTzvpI0aWvujEjiv/pmlf0b60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MyAemQ1OiVzDazqn8O9QH6uLRaSdPdOXKlqOWrFzEo7dOiVqtzJexu9H4Hrsiy0LIjQWJi/IHVzfg9skpe/vYwMh9DCn3/vRVg5pimO8IpA3FOE/EOSUWExKelplZlccLzjn2wCiMAKRHRNLmbHhznRSL6nX4w6kLqMDjfMTb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAislcQ+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166360285dso12889105ad.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632287; x=1738237087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHLQc6TpMRiBo7O03RUpvPo/6POy19GAQNZJ+hIGUAs=;
        b=DAislcQ+URhaKANnDvJAbPOCYQ7RAIwD9IRp6UWd58LVQHMEAM0LR4vteDyiVcuzeN
         L6wXVWhOxKl/9q/mkgFxN6iXZgWqHG7poW2SP4lYlSN7JXuDlHChTMbTmFvnfIzQug8r
         Q+fvhZnBi9CEURcKKHh5Sm5aRyzeDQn8+0xS1G8Hero7ktm39h2HDB+i6DeOiFOFX93+
         UYNtDGZ4PuXKVF55EEcHoUtam4kBLt5RM4Vxrh2/AM5RP9675mrxNJYVhfLITdVY5x/P
         NgDQ6beSdupHouts+75X1qObjS9yBSsShTpspXDW4WvIgbWvQFmkrXMrUZiy7pxqbsDT
         6k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632287; x=1738237087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHLQc6TpMRiBo7O03RUpvPo/6POy19GAQNZJ+hIGUAs=;
        b=Gq78vixPDFE9D5v14EiRGZPqVo7PDp05noHpq/X9O/7YvWeIjF6JpljYld1QiDvbcO
         sRYkKnybWBSdZ0ZRsE454yAIjbFHVK/nZIw+D2C6WDfz4TbtEhR9UW6ngzf78R3p16uH
         kG23PIgjwC1A0gBVuZG3e/moEOHfwPVtTwzHpWYqvVI5qUUaSEbUD8YUXWIwzrie//Lw
         TLesOhLi72Tf3cW3YA7MY/nKm/lIMXOAh30g+s1rSgifyS68wRHsF1t7qalcNTFBb0kx
         KmrfpOuI3ElkkA0la41i/j3wueINyfz5qGlxjNByZNoiRgOobdgEi8bct4P4F6qXNVTY
         EE0A==
X-Gm-Message-State: AOJu0YzurH5aiREgl10wRBZNqeQz26OyLE4tNCw7AY0Vrt1E6Ux0LJd7
	l8komXOAo5ENCUqGa+i9+jOyND/O66kpJlyhRyaVrXA7hoGiZpFyF75sve2WuAqZzh8+5sBr/F7
	z
X-Gm-Gg: ASbGncuBR0KrcaG3UhIw+uu0Z6W0EAa7ViH/LyyQo7+XcPNcCj/MN/8rR5m0GgD5k/m
	t0Q/gDNWp68xp4wb/3kNhgenhfYUsvAr7hb977nhGEeESQhL5UwSUchWYfcjld4tMyDkLjPHQZo
	MZgeF1FwNOZBkTF7bzq26mOQNfG6yPTIlMNVeerGjB6u7LjV31gmyZqin0hj1UuYLshhAN6QgdV
	/BWqwtAViJX87MSSBTsSYK5zzneVRLn/RRbnYx1Y7OEa8c64TMJrcoqfVzc0cDO8KfmAEJ1AUlC
	Sn8jafk=
X-Google-Smtp-Source: AGHT+IHi41Np/qBLdPixkWfJVnY+1Zg5h/hxk1aFRCjn6UmJXabZCfHQZ/z7wsx3IMhaEnina5TEYw==
X-Received: by 2002:a05:6a00:2294:b0:728:e745:23cd with SMTP id d2e1a72fcca58-72daf92bbd7mr37719465b3a.3.1737632287338;
        Thu, 23 Jan 2025 03:38:07 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f2e73sm12919004b3a.32.2025.01.23.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:06 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/33] cpufreq: dt: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:38 +0530
Message-Id: <3ed3afa4e161644ea7f0b71803d409abc7565a87.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq-dt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 3a7c3372bda7..072ccf0c2e41 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -36,12 +36,6 @@ struct private_data {
 
 static LIST_HEAD(priv_list);
 
-static struct freq_attr *cpufreq_dt_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,   /* Extra space for boost-attr if required */
-	NULL,
-};
-
 static struct private_data *cpufreq_dt_find_data(int cpu)
 {
 	struct private_data *priv;
@@ -126,7 +120,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		ret = cpufreq_enable_boost_support();
 		if (ret)
 			goto out_clk_put;
-		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
 	return 0;
@@ -169,7 +162,6 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.offline = cpufreq_offline,
 	.register_em = cpufreq_register_em_with_opp,
 	.name = "cpufreq-dt",
-	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
 };
 
-- 
2.31.1.272.g89b43f80a514


