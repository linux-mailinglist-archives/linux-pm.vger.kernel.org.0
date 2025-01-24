Return-Path: <linux-pm+bounces-20918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B792A1B218
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9291883F34
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358A21A433;
	Fri, 24 Jan 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Taddr+L4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F83121A428
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709119; cv=none; b=TeZspBaGX+Xn4EpYe6p1lrxVB1NhMECWcbQAM8jr0oPgHh24zY1F8ffFu9cryyoYC8GPi0A4FsYOBSaSU0Wh361Ta4t0vqjFYadRvT6KaZjs6Hl4kgvQSoIcWjvhfRSgWQjtkh/o8nO4seqeRhDjd4AxUmknWNjIL4Uobq8ubEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709119; c=relaxed/simple;
	bh=Mh+lJKZyh+KkyabU155CrYHrGrHw881vMoEak+KHpyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X4ArX6YjVwSyWgDiAC03c253xbYuS/XOcbFEek5MmpqvvXRGS8CVOVxkPvP1ae881GLujmQfPuKYuRp2Rrlf2xOQ3Otwuq3PD92EneZxv2b6r3Gae8DPyFoJxRo3TMQm3W1Pr/bvcSmpKFJke37JQUMYmLVpwinxDRrJoA3bggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Taddr+L4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2167141dfa1so34201035ad.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709117; x=1738313917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cSIv9AP4YVY8II7Ap2oNu0OryQ4xRNmR3tG5lkJHKs=;
        b=Taddr+L4rf9IgMrgf8BrEXk1JhXP63t/YJmSl3FeOsHolFWpipkO4x9yybDmxp8Zsn
         LaLLRQb6k7GC+bLCWjA6f0ADN5SCjsHW/SPelSb4I9LLa3Rsi3WQeO09xoUqOYLqKINk
         6TehgtiSaqsVkRywIqAKurO//gISjCemI4mPXCj0J/Xzwf2bPdQ/CxCTP2R02LsTm+PY
         KzBvK9Wi8dvV20H7hg3VD6aUltNJZwVb2Fw2bVG0xto/XD0S1Hlx+ODoJ8N6P7xyQ7Yu
         ZJsDuCcTQDVzPG9ESxYRPDrsmQR9+cLdENxmjiBSDklELLi/snkWPpEBeyV8gGBQwAHV
         fEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709117; x=1738313917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cSIv9AP4YVY8II7Ap2oNu0OryQ4xRNmR3tG5lkJHKs=;
        b=SKH6Kn4mbOa8JbPU/bKMxmRrFSYqv01CEC9vfBSnflnOn0AE7tsKOLG9K8XTMsEOjP
         Phn24J636w2NO5+rPHTXDwj7LtNGGHwqfzrwkQIhPOu3maNwfM0r83yVcaUbraR79e0u
         OEL8CFWdOesai0T2OPwGyZ4KJqpzLwV1sqbOoxQU7MMnuV53B3VEepadsI6QsVxkwHuY
         4OYaQGdG6QfDdO6CK8cdyeCTGFbSbmFbs84Mzuv4tsuWoQS0tmxb0uPpVkKJD+J3EtDP
         xY0Ab3IvFDUo3K+Hjo6d626v+exw5P0ZerlT1W9L2vc1oZ0+r165aqMVFCHcYyrD0OQQ
         IktA==
X-Gm-Message-State: AOJu0YxJrYBKn1C7L350D+Yiu3t4dNlTPMdfBGWu1vW4hx3VpIHr1oOc
	GDyRk/IwGcmUAQsh/LXal1d6WkhHownZ+AH+Kd0ZLbtSBQT/PKMH5UxyW/DVWT8=
X-Gm-Gg: ASbGncvzyyJp7KYn4mzobWk/M+oHvA0p4IItEP/gPPw/VTcJeq4dRE+pyzebtetxs8l
	2R5Qq/cUm8SzPbNo1JXUi/0m9S4bs5s23ueK2Y/z5LUKFX7McZh5XlmQNU8auluc/1LlG10tpJo
	fzBntXpK88uPcKex1sGsqaVw2/tbQUqTM+ON+/SeGKFN2ptg2zGBtiOvJAPF3PiGP+fFF+4Shc/
	lDCbftPZpT2xeJvqMC2BYmS2ElrNjxXW/+DyVgrxbzLoenMcmSrFVQolyAUDuwm2CfJ9GkKQ781
	gbWcDF0=
X-Google-Smtp-Source: AGHT+IFdQFEMk3CcgOdQGVEgE0iH+83SO6Gdqu0lR5PqUhFZ6mg4COOnw41rl14vZoxm0ZQ+NOESiA==
X-Received: by 2002:a17:903:1206:b0:215:2d2c:dd0c with SMTP id d9443c01a7336-21da4a54381mr47881155ad.14.1737709117666;
        Fri, 24 Jan 2025 00:58:37 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414edb3sm11472525ad.202.2025.01.24.00.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:37 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] cpufreq: Export cpufreq_boost_set_sw()
Date: Fri, 24 Jan 2025 14:28:06 +0530
Message-Id: <bd30aeea7ab0d6bdb5fce90241b00798d6e1fbdb.1737707712.git.viresh.kumar@linaro.org>
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

This will be used directly by cpufreq driver going forward, export it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 include/linux/cpufreq.h   | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0782a6d89df2..8b0754b506fa 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2786,7 +2786,7 @@ EXPORT_SYMBOL_GPL(cpufreq_update_limits);
 /*********************************************************************
  *               BOOST						     *
  *********************************************************************/
-static int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
+int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 {
 	int ret;
 
@@ -2805,6 +2805,7 @@ static int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
 
 static int cpufreq_boost_trigger_state(int state)
 {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0e708830d30d..c7d1fe5ebf7a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -781,6 +781,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
 bool cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
 bool policy_has_boost_freq(struct cpufreq_policy *policy);
+int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state);
 
 /* Find lowest freq at or above target in a table in ascending order */
 static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
@@ -1164,6 +1165,11 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 	return false;
 }
 
+static inline int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int
 cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 			      unsigned int frequency)
-- 
2.31.1.272.g89b43f80a514


