Return-Path: <linux-pm+bounces-39544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0441ACBD792
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B00300941E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036E532FA16;
	Mon, 15 Dec 2025 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caSLTLM8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178C42AB7
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797170; cv=none; b=lhCysToTPuN6YCha4RH1eEuRq7bVRVw1wl7LqZH7dljlz+u+R1I3WAxS/IE3IrESJz7al0wdogY5sDISbCUXsYgPoizb3M6pohgwChBxjNspQXnjZLXMkWVZpomaKqd3rapUcUIaWWEqJfYIz5ykUER7U4pZJ07+it8Y/2U8Bzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797170; c=relaxed/simple;
	bh=MJVk8MuO79pEG/+6Ze4gkydvIydSGQTCyLAgE9BvPY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+RHiF29c3AfcWE7oxbCplATby5HOxdoOwdB6b1QtgG9WtDnBqviTXvzZx/2fWix4a2qjZli9Grw/S4sqv8mHzuZVw1Z5Lut9+/TSzjFGxAgagqc3Brualt8ZPgJrTKhtSdfouHUb40MKcCgdhP6oZXIVEEa4mA6IkQQBheOfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caSLTLM8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5945510fd7aso2860760e87.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765797166; x=1766401966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6b7rNdshD8IyVVxO6s1MwSq7awp4iLV0wHXJDYiizR4=;
        b=caSLTLM8oBmK/c0W4ZsQZKYiLlt4I+S1btTov2jLtuXJD5wNOE/6O5o9byeRA+n3p9
         vaJK9vkfh87uqGw/DAp+OWuMxpRu77nFaza4r6ccFpM52nxgXp3P2Hin50uMooHWhrRw
         97Vo/F/hvPwLhucqobJ2CmPNS8zPd8H1oM4dlvq8B5huDg8E6Fe/h93gpZFRA8Wkp7Gx
         BU3XrCxpz9sed3IF1afFUVEDZcjZ9ffw9JwXfMj3RStiIG5Ln3XUSHHd4p/PPqUm3NQj
         6pwWz44V2B2U8jU0sgd6pkdJ0/ruLcBBi0hAgi3CU2A4wf7NdsmgjI2y1W8uX7uWk7bf
         vBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765797166; x=1766401966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b7rNdshD8IyVVxO6s1MwSq7awp4iLV0wHXJDYiizR4=;
        b=GRa7B5TuZc8lbsXru47RHP+4c+Hz4+4j1o1AQH4Z/ahZCrvn0SFygyJ8c1GG8zKyG/
         TkTGlmO54ykudohS/hNgD9s1pbehZm6TJb3uhuo99/Ux60RFGwnxyfwxR1R1BVAz88Lq
         /SG4PA8EE0UpMvLyg0s23DQtu+fvyhJzJ8pUMEvDbwEYUUdp8dn0XnMJav4weT0MrST+
         LxzYtUAhgRgw6UCmiLkg2Zt7G72OAne4ZyaLU7fxCK83uQne3w5UIWMG/HQ+Xbao8VuT
         TWfJ9lmbbTsIovYzI6z4iB3ok3JH+VIvVfHk1vCfN5wdtOkm+kj3Rzh4KzNw0sYaWxal
         jtvw==
X-Gm-Message-State: AOJu0YydDGwP9P5DAzjqPacGBiER+jCtZfHja6BMIKWUmZrpdlDEuf0u
	nHDuRvP22MbkPsAepp+5Wj4Wa/FQsFj+N6fFQY7q6PyNei43FPEhzH5Vg9sXTQbFtKA=
X-Gm-Gg: AY/fxX5YRkf1ujYIEOO7rH9IzAhOf4DYI6ryMQggD+OIoMHHnknoTphuamNpRA+2R2O
	6rDQWJPfVaXDjf49Cqq28lU9u4cleapZuONqeNGTWqKV3x7pREqhyrvwf+TItaFEa5IwdlZZ3PS
	DYcO10O0ZlS6neY7yioon316EsMrMcd69qY8TBio6VuaJa3Zdz98lrLeuI7ZUnpNRGp1DwKO8IN
	bEneV+sIAi7gA2v25ishIQuMuiTAoNd6ul2W9Y7zuqoxfe5iXRuyVssF0uu/VxOWkzITr+PpN9M
	ICxtmdWlAQNpnacU2Fyhid4duJ0+PK5c7yKOKyyQk857anX1sDCRf5tJbF2g0P1zLfS+Ca+zM3y
	rBI+EHNoGXDu2oHNm4sCiI5JOZOR+fDoNS9ht0tyo9gNgOzA1STJ49swvP1Ts2O/GHUgnR8rQAk
	A6Sl1uRhzEqVD9sNOLBIsSRMoce8JDtAs745cv4RlsED3s9tueuHvqDWdjRZisHMzAtNsl5Pfid
	pd+Ua0=
X-Google-Smtp-Source: AGHT+IFEBCTqUQhNgiAM8fyydQA6hn6G6U3+Pcj848Us+ssjkPExMfUus639cN0KkP2wimgketg3tw==
X-Received: by 2002:a05:6512:230d:b0:595:7cb8:3eae with SMTP id 2adb3069b0e04-598faa4ad30mr3470884e87.20.1765797166050;
        Mon, 15 Dec 2025 03:12:46 -0800 (PST)
Received: from abityuts-desk (2001-14bb-ab-c176-62a0-4b37-648c-102.rev.dnainternet.fi. [2001:14bb:ab:c176:62a0:4b37:648c:102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f379f5sm5417194e87.11.2025.12.15.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:12:45 -0800 (PST)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH resend 1] intel_idle: Remove unused driver version constant
Date: Mon, 15 Dec 2025 13:12:29 +0200
Message-ID: <20251215111229.132705-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The INTEL_IDLE_VERSION constant has not been updated since 2020 and serves
no useful purpose. The driver version is implicitly defined by the kernel
version, making this constant redundant.

Remove the constant to eliminate potential confusion about version
tracking.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/idle/intel_idle.c | 5 -----
 1 file changed, 5 deletions(-)

Re-sending, for some reason the first submission did not arrive to the linux-pm
mailing list, I cannot find it in the archives.

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9ba83954c2555..aa44b3c2cb2c4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -63,8 +63,6 @@
 #include <asm/fpu/api.h>
 #include <asm/smp.h>
 
-#define INTEL_IDLE_VERSION "0.5.1"
-
 static struct cpuidle_driver intel_idle_driver = {
 	.name = "intel_idle",
 	.owner = THIS_MODULE,
@@ -2478,9 +2476,6 @@ static int __init intel_idle_init(void)
 		return -ENODEV;
 	}
 
-	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
-		 boot_cpu_data.x86_model);
-
 	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
 	if (!intel_idle_cpuidle_devices)
 		return -ENOMEM;
-- 
2.52.0


