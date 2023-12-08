Return-Path: <linux-pm+bounces-815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA180971E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 01:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEF21F21243
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663E7F;
	Fri,  8 Dec 2023 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="cdX5NWyW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAED1729
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 16:24:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c2718a768so15553765e9.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 16:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995051; x=1702599851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFcvWyGzy7I7g+xwi5n944IlgZ7CY3p5798f0wmNhcc=;
        b=cdX5NWyWCBwXaoh8OWBzi6gu+rNuV2bBH/2eVclyphUVCJIi3HYqdO3+95cxomldmM
         S0Ly4YLHh5kVQSxqv7ZXyy7X/NurSo4a/NGpcPwKNB6xvFOM/8v5IoA7TUsiw7Uo4/bt
         NFjNhGzQl28Aa2NZ7ZDmfynSzxWVTeBnN7GRIvNF0gHY1Jc/uM1jQzd5fNmqkltJ3NRc
         OS/5OwLvc+0dExB8HOUUkeQ4XHRofF2IOBCUvyqO8DGvztAYpK5ssac1mMHRohib93Fy
         7eVDJSYd4XabZkagv2hicmktQDoHYZ488qhIAHYmSlIfSmiWTVUYNLQZC0RH8S+I2zQP
         tAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995051; x=1702599851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFcvWyGzy7I7g+xwi5n944IlgZ7CY3p5798f0wmNhcc=;
        b=DURv7bwjP+TtBlsqzQA+SgvzxTnC3tYK67w88jrHt8MDmX+bNykj68IcSHyZZt4Ooy
         SMUPUiHd+W2fL+BdMT3d5Czut3z6jxES5iOa/uu7JD7egQ7qPd9L7ddb6WzvCCN/lFZW
         gMh1hOfZuo9uJ2HYJfgO11Jvjp9Bmk/5OL/jZQY9b6p02hM9EVXRkl6zdEacDvJBoFVg
         AvoIXJKUd7dD/P+Rb3f49GmyJzjWnAVT7qw9u2fOFuEut9UTQ5e4Sh2ZpEdg4E2FuqvL
         exr/miTH6rI9MNmfty8OpViyP1psZxmgyeygCPotvFfDNjTlEbZrFbKRpsrGFj49dGVJ
         hWfQ==
X-Gm-Message-State: AOJu0YxEZRk4pF4BOxq5qmi2SjGObZYIUIConLECUIXWD67d8ur04/9z
	9vj0vgWh1530+BxBIM6KxL56uw==
X-Google-Smtp-Source: AGHT+IFNv/bJ3z7++RWJr3sps726MqohP1NGWMmNXo4tcWhp9NOoexZrvOdWJYl26EZFZZEDpZZ4qw==
X-Received: by 2002:a05:600c:3c86:b0:40c:7ef:2d2 with SMTP id bg6-20020a05600c3c8600b0040c07ef02d2mr2224939wmb.8.1701995051136;
        Thu, 07 Dec 2023 16:24:11 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:10 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 4/8] sched/pelt: Add a new function to approximate runtime to reach given util
Date: Fri,  8 Dec 2023 00:23:38 +0000
Message-Id: <20231208002342.367117-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208002342.367117-1-qyousef@layalina.io>
References: <20231208002342.367117-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is basically the ramp-up time from 0 to a given value. Will be used
later to implement new tunable to control response time  for schedutil.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 81555a8288be..00a1b9c1bf16 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 
 	return sa.util_avg;
 }
+
+/*
+ * Approximate the required amount of runtime in ms required to reach @util.
+ */
+u64 approximate_runtime(unsigned long util)
+{
+	struct sched_avg sa = {};
+	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 runtime = 0;
+
+	if (unlikely(!util))
+		return runtime;
+
+	while (sa.util_avg < util) {
+		accumulate_sum(delta, &sa, 1, 0, 1);
+		___update_load_avg(&sa, 0);
+		runtime++;
+	}
+
+	return runtime;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7e5a86a376f8..2de64f59853c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3003,6 +3003,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max);
 
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
+u64 approximate_runtime(unsigned long util);
 
 /*
  * DVFS decision are made at discrete points. If CPU stays busy, the util will
-- 
2.34.1


