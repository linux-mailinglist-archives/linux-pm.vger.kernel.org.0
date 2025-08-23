Return-Path: <linux-pm+bounces-32927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD9B325B8
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 02:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E0C588B9C
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CDD747F;
	Sat, 23 Aug 2025 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIWdxirT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BDC17BD6
	for <linux-pm@vger.kernel.org>; Sat, 23 Aug 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908413; cv=none; b=aLQ9LpVOT5YZSPqDAHVFI6O9Zn3ZrJfbYSODFgkzWTqZPfkwx+TwY/OPCDefrQC8t5WGvWysUN/SqOCE062U2sTnxKscO8lxakLYgWRW1mRArXmKMFdb9sk7JDmLtAbdhryYhagRNh/3DR/jz/NDLyaURLde/sLcpE5IOrEgrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908413; c=relaxed/simple;
	bh=ht3324uxa02WXVR29FjGt6nbkTU/cKUGnkifDeyr2Ew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OTCs8goiFMo1n2WPmFUrCkvfznPkzT8FcSWS979q0s7TIwIoyIVMdlIExS2d8Ix5h0wpi05YXKZ9BcwB9FoHxsmTS47P2+YmvNyVgSdd0VPcWjKUYLASoLc8uyvfZb3ObhMNv7o1L2xOpKn8Z4jzRuiIge8y/aQSd+8GJJIHgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIWdxirT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325017f25aaso3111735a91.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755908411; x=1756513211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPtkVhvKdNEC/OOAobIFcvsRhSzA2zswDnxVscwfGCI=;
        b=FIWdxirTxzMwyUsbSWkXyHRA5WEKCquBLTfP8yD8POZSMLSoxfW8Mzf7PHhbGfu9XP
         orjzu4iEXkFiqDrpsRDYb9sXhU6kFe7zRGkrLReGR1Iq6OfBWAIJmMZdticWarnOgWuD
         x7QSFFDaFCqK3YnVBGgrYJBHPDeL0K/we3gdtnDDaa4FeO6eanTc4bWdlnvtgx+p5W2T
         wvDA2ZaZDRRl6ie9fsQpaRAXkac1hjFRX33x1wQh908IozotzgT7MTpoumkOJnkjChYx
         a4cP6DecGz39tvhRWxp5udMcFXQLvGN932pjGbDo8Q3PGCiszq6d3/TY2sIm+NdVPcs/
         7IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908411; x=1756513211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPtkVhvKdNEC/OOAobIFcvsRhSzA2zswDnxVscwfGCI=;
        b=b5fKAhoMbRKwZ06XBM6vpVmvjcmJzBmTVJl9hDjgbsWCU8SJZZpUdrH0R53yzrRoTJ
         qDhDj4OD4shVFqasKnFwcuBgKWugO8JiorbYBFVhA4+b9ps+dgW9EUtglJJe/APaytQZ
         hQ5Mp34YO99olCWXy3rJhXtQHHIL6znjLQZk4crb2uren2zQxyfCQz8IaXdbB1vlfQPm
         gAmzSwmhX0UNQGaZncLFGqj5yJ/Zu3Pb41rD8eXA8uLBTKsCaRLeFSURPosdCn3jDVDG
         0fRvRKkW+AfdCwFpbpPq+DKBzV1joZ+sQwuxuAjdKVLvCLOQRPWSORVrEqem819fPXX1
         hyYA==
X-Forwarded-Encrypted: i=1; AJvYcCW+n99N+3cctXzrfZQhDmfZJu8aQcp0Id94wGkWOQwBzUOyuL9hhTDERRV90uKH1kqhiTCrsitNng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NE5FG/l0nRgkOteo48tFP0pNVga3kZ9R4sF+zvMVNNY3/vWd
	3rUZYtjktVPZDFk2cJEL3HhL7UuMqFXscejytJvkGXR2C8bWOsdrvDPJWs6Rhsqql+t6jtQTvmt
	nWoJO1JSzkQ==
X-Google-Smtp-Source: AGHT+IHg1EerCIlVVjUBZttZ2pzmPORYKnKpXLslvbloPNdCwXyDlk0htMBU3lQ01oZot3/nM+A3Kf9hcBA6
X-Received: from pjbse5.prod.google.com ([2002:a17:90b:5185:b0:321:c475:716e])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:514b:b0:321:a1fc:a425
 with SMTP id 98e67ed59e1d1-32515eda016mr6801002a91.26.1755908410927; Fri, 22
 Aug 2025 17:20:10 -0700 (PDT)
Date: Sat, 23 Aug 2025 00:17:48 +0000
In-Reply-To: <20250823001937.2765316-1-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823001937.2765316-1-pmalani@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823001937.2765316-3-pmalani@google.com>
Subject: [PATCH 1/2] cpufreq: Add driver flag to avoid initial frequency verification
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>, Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"

Some cpufreq drivers have a get() function which can return an unreliable
frequency. This can cause issues when switching governors. For instance,
a CPU would be on performance governor and have it's frequency (and
policy->cur) set to max. When the governor is switched to userspace, the
policy->cur is re-used, but it is checked against the frequency returned
by the driver's get() function. If it's different, the frequency will
get set to the new (incorrect) value.

To avoid this, add a flag that avoids this verify step on governor start
if the cpufreq driver opts in to it.

Since there are no users of this flag, no functional changes are
introduced here.

Cc: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
---
 drivers/cpufreq/cpufreq.c |  3 ++-
 include/linux/cpufreq.h   | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b8937737d096..72e6552a40ea 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2482,7 +2482,8 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	cpufreq_verify_current_freq(policy, false);
+	if (!(cpufreq_driver->flags & CPUFREQ_DONT_VERIFY_FREQ_ON_GOVERNOR_START))
+		cpufreq_verify_current_freq(policy, false);
 
 	if (policy->governor->start) {
 		ret = policy->governor->start(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95f3807c8c55..1ebc12fcc905 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -474,6 +474,16 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
 
+/*
+ * Set by drivers which want cpufreq core to avoid verifying that the current
+ * frequency of the policy matches the frequency returned by the driver's get()
+ * function. The get() function on certain drivers returns unreliable values,
+ * and this can result in the frequency (and consequently system performance)
+ * being reduced even though the governor didn't want the frequencies to be
+ * reduced.
+ */
+#define CPUFREQ_DONT_VERIFY_FREQ_ON_GOVERNOR_START	BIT(7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 void cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


