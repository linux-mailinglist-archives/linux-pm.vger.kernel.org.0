Return-Path: <linux-pm+bounces-27325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF76ABB737
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBD18999AE
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487E269D09;
	Mon, 19 May 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3/nHjtI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9F269CF1
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643303; cv=none; b=kBuhoSXpscl5gn6Qd+LCZRkxqENuNrzocR1MZScLKNa9sUe18vX9BfF9dzcMExhi1m5+M5CkOmP7TZ/9BCA8spBwmKvKVfCwJLrN+JTTLr/MaIU7rmh5ZgxKVuR8mkWI+0i9uX+6B1274sUt7ddFcb4oaY7qLnfMGmIokhrikno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643303; c=relaxed/simple;
	bh=DT3xhTrEpNyyEmwRD93HnFf0aQFO0HQD1DP7C+LzMbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VwAfHttpqT5hl6JAO6FIm7vcVeQg4i7i8omR/ihQlZVFbjHvm1Dslyj24M4YrPkxGOYnxouq/tN0Ooco2jkJkaa0JQcixV7m23YafXsbyV0TwaXJpPHMo02BJds5OdnhoygT4qo98s5ac7zfj60bdaeCp53oNLc5yv9K4WM5Txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3/nHjtI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so1453504b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747643299; x=1748248099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8M59GVJK+m+6scfgTZEGFhkXYH4wMwQFS/55/hIcrM=;
        b=J3/nHjtIcwUrHE6qbJ5DDiTwCfzmvX7PY9Znm1t19MhIoTdp/r4dkg5sVQttdukK2I
         TCuwQUGh5IYSfnHY4tp9+Np+LTrFaKWaW+Tg0//fkgpwQ0zyYfVNKx5qcFjOQcYffdTV
         JcPEpNQj47qodzBSLJwH5JFIZzoR4ZMOfOdq44q/DPRQztC25ZuV+zw1Bp8RMuRATi3z
         oh+Fr7ClPUZxnXnzd+BAC4ZRbsQad9ANIIvsv90P5ZcxRaMAy3g4FgEShIzEMr2+NKK2
         U9ljojOlSm7FUcYyH7V0ubN4nHy5ydLqAar/79snnVvOPjztEi04Bk7ECArHLUs2GfG2
         cEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747643299; x=1748248099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8M59GVJK+m+6scfgTZEGFhkXYH4wMwQFS/55/hIcrM=;
        b=d59VuBtQOjAX6HzdqANV0TTS2MwKkl1wbMwcPQD/IVJNuclq9JQ0d0iSlERum4uOa2
         WEvupO5nIuxWj+uP87DDRfl0Qc6bogpLmObCPNBz66s/wLu4wTaGFQ+eJGSjHtXuzY2y
         OoOVnpux3D7cVa+lQT6q5AgRfFzsLDJU6uI+/4XNbqNR7t+1OvdQlljCItH33e+bG4Ch
         qvfCvh91PfNYSre7TPctFKU88JH7ZPSwyxXhRRiWjvqCuUXTcASAr5ZLDjjZzm53PXse
         kLdcwfndgpdX+xWHYersLS9hZY1I1W1JX7HYa8ZjjIKN+Vt10GtUEYdpoXNgnBwz548A
         wpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV3u38OCtc12CLgc4tvYEaI5aNiqOxLE3XkyESzTet37+GfWtn7/+E7azx/pMNWOaQPd6+eXj8eA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99rfq71+GtYbfwdC1F/EckH5RRY3vDQYaBuUPSXZhG3ZKwpVZ
	wu75G6VPSUkkp4/BVxU2olUQDrL9x6L6L3M2tDKJG0gqq4TjmYt+NNjZeAXnRy1Q
X-Gm-Gg: ASbGncvzwMHj7pveP58czpbb5SPVhW7kVAjfPUKIlHipsK8arifJEhLAgT4RgvFedgm
	Ns+1RJOAdn+GixK0Ng2RtaPpV4a+GM3eA26XGAUIrOul+BwOOKVgmjRSoZTuN0ezfB+3Py0+lnY
	tBn1J76FCtrAcN4g9A9Sra7vYLGZrFdG4BodZ+D1sIO5nMPTOuj681tVJEDjd6Yqm9ZaQJcDEPx
	zHhKv4T/LWKxhNe1ztzGss72W+zqNdWpCrkdb8RFS5enc8OUZTYZ4WnHEQfNzhecFFUsn+pk2y0
	tDC4OhWWhJhzUwuOGkewBzdCOBaS/5PtKkiKOyCVmdNNOJEVYCnFuTUTGpdE
X-Google-Smtp-Source: AGHT+IHqy650fhiUjAnLeRYmb+UVVAJk22k2f3gFjpFNixwgp4+tp9voXUhz6LH59YgjZ2SwAkh89w==
X-Received: by 2002:a05:6a20:7f9d:b0:1ee:e33d:f477 with SMTP id adf61e73a8af0-216218a2a6bmr19291022637.15.1747643298607;
        Mon, 19 May 2025 01:28:18 -0700 (PDT)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a213bsm5629215b3a.159.2025.05.19.01.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 01:28:18 -0700 (PDT)
From: "qiwu.chen" <qiwuchen55@gmail.com>
X-Google-Original-From: "qiwu.chen" <qiwu.chen@transsion.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: chmathieu.desnoyers@efficios.com,
	linux-pm@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: [PATCH] cpuidle: Add find_deepest_state trace event
Date: Mon, 19 May 2025 16:28:11 +0800
Message-Id: <20250519082811.92279-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new trace event namely cpuidle_find_deepest_state to trace
the found deepest idle state during CPUidle flow.

The new trace event will help developers debug CPUidle issues by
providing more detailed information about the CPUidle states.

Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
---
 drivers/cpuidle/cpuidle.c    |  2 ++
 include/trace/events/power.h | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..9065aa396892 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -103,6 +103,8 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 		latency_req = s->exit_latency_ns;
 		ret = i;
 	}
+	trace_cpuidle_find_deepest_state(dev->cpu, s2idle, ret);
+
 	return ret;
 }
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 9253e83b9bb4..82b5ac8c46e6 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -62,6 +62,30 @@ TRACE_EVENT(cpu_idle_miss,
 		(unsigned long)__entry->state, (__entry->below)?"below":"above")
 );
 
+TRACE_EVENT(cpuidle_find_deepest_state,
+
+	TP_PROTO(unsigned int cpu_id, bool s2idle, unsigned int deepest_state),
+
+	TP_ARGS(cpu_id, s2idle, deepest_state),
+
+	TP_STRUCT__entry(
+		__field(u32,            cpu_id)
+		__field(bool,           s2idle)
+		__field(u32,            deepest_state)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->s2idle = s2idle;
+		__entry->deepest_state = deepest_state;
+	),
+
+	TP_printk("cpu_id=%lu is_s2idle=%s deepest_state=%lu",
+		 (unsigned long)__entry->cpu_id,
+		 (__entry->s2idle)?"yes":"no",
+		 (unsigned long)__entry->deepest_state)
+);
+
 DECLARE_EVENT_CLASS(psci_domain_idle,
 
 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
-- 
2.25.1


