Return-Path: <linux-pm+bounces-11474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503993E081
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7225B20A65
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD12187348;
	Sat, 27 Jul 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIIs5B4U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791486126
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104812; cv=none; b=DkZ4kaqB4NdfaWuZi/pkm7N0rmZ2BYcsviyM2EOtiHQWZm3jX9bx7LLM3S678G/fWvlopvLwsfT0ruNrrMYTcc5Hs6usKWxSvfeRb+O+gPt5OsaQJKmQGMFEK4z6R+Dq8yoAzuJcJeCI9cXth/se3P1EitortyVSusKndGg/LNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104812; c=relaxed/simple;
	bh=rGXAhKVyk4Ev/ZkKoHngtOoSaOUNivcYvH2Xxo0KmjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjtnK2vC0FTc2qVeFbJY8zed/TCZaPl9PgbMrVWis55/2xmcz2ifgSd/SeC7tzmNFfRVVq6qRNcK6My9m4PirgH7+WoMesMF1dTIhzTydIWPS1L8vJwkBsaHYj+bm2gUBNst9/2afsx8qCQfz0y1fG4yVtGoFKgEBf1XPLwma80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIIs5B4U; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-260f81f7fb5so1361066fac.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104810; x=1722709610; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bood/67WGQs5A2mO38CZBp0ICSQxPgaKM4cTJFOTZ6o=;
        b=KIIs5B4UenhrpImJ2KMVbbzerJMM/o7sQQpPI+HktlYFg+iZErSmJgFlK53qkECHyv
         PgMeFdXaDjYJilDP1Qu2qwsIaR4cEiUhC9wwXxKEyT8Ubf1spySi2eEzXNCDOspPT5Cb
         4f32OLFZW2BoVI7oJOc2USo8EV6EWrqSTDd+FRX0GI7JT6sbHRXEvTcC4k/YqM3BC6/t
         AHNlI5/ZLpjJz5q5XccRAKm3XExBhNbSSS28aihbqYSkwBLzu9BslG63ZDPG15gHMq+3
         gVVZeaEQWrrcnm5kX9SUmbYdhZ8VIu0LKNPq0yYl0JIDpmA8HH/7MELbCbc3wwvG/YFG
         mEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104810; x=1722709610;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bood/67WGQs5A2mO38CZBp0ICSQxPgaKM4cTJFOTZ6o=;
        b=l7N1qYL0gjfRXr2eS36zDM8oF5dz9O1G5RrnbQq6Y6Tz5+Z8Gh8jtGXQ4g5C0UDdKn
         E+HlEiBlrGwWYp6HHKLebtJciZlxF/qxnZZx1ligg96c9FzUyHi5nJfNEQ/YjWxxkCWy
         9T/EnJqHIaR6r8nZ6zq5dgUaLoLI2c5ElKf5vjHrPTX9OYN8Dk2egT6bXQrcO/w/FJwd
         nZ8PWlV1jWdAQPhEcKLWd/k2rW242uHtBHm9J9V6xEqi07IgPOCBY+8cn4h8y0Dtb7SL
         jsQZBNTRneNpC8ONx9uk6VRz3WZzyMjnKCButBrzuO4kV6yThNjlCMRtx5BytPOW0rqp
         6WHA==
X-Gm-Message-State: AOJu0YyLeqQdy1COBnfNEyXErSxQLIUSPqO1+WbeMUJRyLEos2FuxdXO
	0YTRUm6RbnKq3vFb9ByuvH8SLl/2msWrOOYxrPmUqOtwmZ/YIxwdWHS7EA==
X-Google-Smtp-Source: AGHT+IGEZqg4MtWYJIVXrjc28L3lj7/DNcpuM6KElkGo5TlfS9wOyluuLB4pVH0C7IbaLYWsnPuR8A==
X-Received: by 2002:a05:6870:a2cf:b0:260:f827:243c with SMTP id 586e51a60fabf-267d4d37ed9mr3760360fac.12.1722104810166;
        Sat, 27 Jul 2024 11:26:50 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:49 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 04/18] tools/power turbostat: Add ZERO_ARRAY for zero initializing builtin array
Date: Sat, 27 Jul 2024 14:23:30 -0400
Message-ID: <25e713c6b54a899b5a8b5e09b58f4b87a5b3664b.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

It makes it harder to shoot yourself in the foot, by using
additional __must_be_array() check.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0fc6c107e371..29751b41ea0d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1060,6 +1060,8 @@ size_t cpu_present_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affi
 #define MAX_ADDED_PACKAGE_COUNTERS 16
 #define BITMASK_SIZE 32
 
+#define ZERO_ARRAY(arr) (memset(arr, 0, sizeof(arr)) + __must_be_array(arr))
+
 /* Indexes used to map data read from perf and MSRs into global variables */
 enum rapl_rci_index {
 	RAPL_RCI_INDEX_ENERGY_PKG = 0,
@@ -3733,9 +3735,9 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 	assert(ccstate_counter_info);
 	assert(cpu <= ccstate_counter_info_size);
 
-	memset(perf_data, 0, sizeof(perf_data));
-	memset(perf_data_core, 0, sizeof(perf_data_core));
-	memset(perf_data_pkg, 0, sizeof(perf_data_pkg));
+	ZERO_ARRAY(perf_data);
+	ZERO_ARRAY(perf_data_core);
+	ZERO_ARRAY(perf_data_pkg);
 
 	cci = &ccstate_counter_info[cpu];
 
-- 
2.43.0


