Return-Path: <linux-pm+bounces-11765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7352943498
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B8E1C219A2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7711B5AA;
	Wed, 31 Jul 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE5Wcd+T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A112B8B
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445242; cv=none; b=LYCR+fF1NVj1kny1QqVpxwSxSdVic/VrweClqb/FN6Rbjc/vroVft83Z/6zVFpXV/DhJpcF9KZOm0pKcKQc+tM7j+QKd/VpSMjzLmkSuBuEIpfvrZL0csQm82mT+qo272+Gzi76NCNL89poqZf59JnVj4qTu7ez4QIr04mrLgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445242; c=relaxed/simple;
	bh=ggPD0Wb0t/zOJLOXjmHXHuw0t4LdtheCB2Q6Hd3qtH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LndB+4hzwGad01q+ObPyF1+0BQkGPaANB9yJZ2xbG9MQ4AADA/GgfYqVcNhOOgSUdF3kRAZ1Ji8FX/Q+kdj3J/8mfCJzsC3zYwYBaVXP07sLXEE1lwou37lvHShVAD7uwQxBm9hCAGCVrHrj9rIzXsK55hVRw/aJ1khoWHsZ3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE5Wcd+T; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f96ea9ff7so195305339f.3
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445239; x=1723050039; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CddiQbWnJSfccqZO7KZf6gUZUZrq9TTP2ifCah8VEfs=;
        b=XE5Wcd+Tw0c/shAImKDHSnZh98YelFgUgg1ixN8itEzeC90k5tbutq4YThhfCcymr8
         +zTt3gd67y6yHX0g6ZR3Py5HSU4FMAWDW9MuGjLdsZ9mrGk4GeipaaNcpJXlIawNAjVy
         DT7C7s0yzRbutyp0BWbSpbRP3FYjN6otkPx7qbebHzHeKI/fPBwq4yfibbbyQ+0M2OZQ
         8NlxBPiac04GdPMj/SqbYnOgsrw+bLE97tmyf3qGNOBMmi4PdLjZSy/xsnXpQRz5ARhy
         m6EB2zGQgdWQLaq5ZgzRoZCkVlkkYU/VcA6/5JArDPHmwG/7otGG0XAd3/7MsP6nkuTs
         3fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445239; x=1723050039;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CddiQbWnJSfccqZO7KZf6gUZUZrq9TTP2ifCah8VEfs=;
        b=ix6KM8A6na7AMPTQzB5CWVsjnQTL8WdM/Wg9JIO6TM6y5GX4Tv6soc0ejo9EJhridr
         kwy6TzgHs0X8Edd1nF40/a2kXb1G25RZZNmoJCOcc0kQbAGIM3ksyQUCtu1hhAfj8y93
         DDVEH24JSLWuMmFUV/GqSF5xhwsy5WoQ6pDXFSIQBwQhrNqCvVCrRier6z4sJPC6Dgs7
         nKmFSwscf/z/zbliKrzT2+UXZfUkawO+kLnK0Km/sc07OHRxqCBRl9MCflf3Uiy+9UzY
         f4MXmZnxJWgjslI52QlUYfsd1SCgPdakbFrxZzlnnByPA5x7xTwfZE17Pza/NH/FM2fv
         12yQ==
X-Gm-Message-State: AOJu0Yzh/8BKpSo5ox7MdSlKQoY6QegBwJqhRtHfMc+1ZTRUfHyg4mgT
	65c4EjudpkLMVQPE1yvvOaC/asiO5r7/ndchyDQ2YjIj36fLenp+c3N6Zw==
X-Google-Smtp-Source: AGHT+IECv5DN5NyfQl/EO7MlJXDwkPxFEWbHWBcQmSO1wcketCfH/QZfadSxawibkzXia0fnGX2ixw==
X-Received: by 2002:a05:6602:3404:b0:804:f2be:ee21 with SMTP id ca18e2360f4ac-81f95a37971mr1930677739f.3.1722445239133;
        Wed, 31 Jul 2024 10:00:39 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d6cc3e9sm417351139f.7.2024.07.31.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:00:38 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Todd Brandt <todd.e.brandt@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] tools/power turbostat: fix GCC9 build regression
Date: Wed, 31 Jul 2024 13:00:12 -0400
Message-ID: <75879bd898eeec6e977b779af704b991081c6610.1722445174.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Todd Brandt <todd.e.brandt@intel.com>

Fix build regression seen when using old gcc-9 compiler.

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 089220aaa5c9..00674f7abdf5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2788,6 +2788,8 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	}
 
 	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = t->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -2799,9 +2801,6 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = t->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}
@@ -2869,6 +2868,8 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	}
 
 	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = c->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -2880,9 +2881,6 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = c->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}
@@ -3068,6 +3066,8 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	}
 
 	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = p->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -3079,9 +3079,6 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = p->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}
-- 
2.43.0


