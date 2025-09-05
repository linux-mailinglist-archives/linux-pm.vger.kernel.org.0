Return-Path: <linux-pm+bounces-33938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7EB452A3
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 11:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13C37AD6D5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81249303CAA;
	Fri,  5 Sep 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XmdmO0PZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F22FDC30
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063186; cv=none; b=fIW6hzsTlQtxXim5dBGEF6OcJ3ggxfL3rEY152sqlgFWuOK+4JSfOUDUuDl+LuejgLT+TvGjJq9kyYciAQ8puhMTtzXaUTb5N8MwEURO0v+YcfyTbNOxnQXYn89lDICk0nQWWboEcL8GpzMQ7gL/ravdlohatmoiRXnWlr2ZxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063186; c=relaxed/simple;
	bh=TEHGZc4EvUV1xMIHiLNRLZQG/6cnDJNCMcleBirpd+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lym1gdCgcbJAvTl6SnX5vpqbvTm5gXyYD81/Bxc1MX2K7EhkQxu9TeqZy1SPxsd1uZ5+eZTK1LVYRPlLJDI0QO2GxYOXntojs4YXyGjO+/9Mnz0pHOz8yIbhjPhfvR6Fsc18zqsBFZq19pt8CC7bpXdOJfrLuNT1GAr/MqY7WBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XmdmO0PZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b804ed966so7621805e9.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063183; x=1757667983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhvxllmRkk7qbtcIy4x6tRpvouKSR7M6p3iibpYHVJ0=;
        b=XmdmO0PZZFYpvRkY+VfY708wdWgU3SJHLP1wqE7F3hXhLH+dxH/DUbolM8X3kUJhD2
         jxG+ZXgVVikn9gQemEprUozVO6mWxgsaGkHsyOoqYZllc4QUZSkhw1kGqupLLTdtOB7H
         J/YZTzERZ5gorC09Pax8Y1aVq3dVmQd1cPJpj10715WVa8cI+OAbxkWiHEomQS4f1CJ6
         ncwIRzxDpuJNa0P3ui6yVNMiu9tLGdIRygijh09rszUpdZq4WJaQrJW4nQgSUPSEvCHd
         J45hKWYOSz7WYpMHf5dz9gERDm+CNIUolojrvkKDpe1gCxcsgAYfUmpu/bM+FpDKAfjF
         M/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063183; x=1757667983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhvxllmRkk7qbtcIy4x6tRpvouKSR7M6p3iibpYHVJ0=;
        b=lqfjabvNNIJjZzFLhhUXq8Riv3o+RVIc4aJ4i9itHLQD9xvY3dW0FZ7wObCY7t4w8D
         c05JRwO4YqQYp3j7T4gLCTKnq8AfQyBrk0wAxr1YyxIJ77AyEaV/kmkwFodvHFEx179Z
         hdkroeZ4CGQmDq1JG6DxvqPfq5+KYsMPuXtVPIm/C04yEq8s8kt8MjORml8BANv/jQ0T
         xGVpYWkUBF2VxwPu2ccyDbADakSfIGAS9k7Mxd3gS1kyIIOSuSJrVtoc1l7lHlAuuu8C
         aFyQMTFUTG+rYDRB5oyCYihsAvqXlhEnb1M9SBz82kCSrtvc19j74ZqCflrWkqy8zASe
         FHYw==
X-Forwarded-Encrypted: i=1; AJvYcCUC4SJ6CJ+5U024cd26axkgs3K/eCWuwTgX91xFgtPygGGp6DxLgZRYbswcoRRfOFBJvQcwSuU3rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19Oo3LJAmvO4DY7O5z2ZizQYk2pe7TqLeBZq5k8BwoRDD/gIK
	0NUBq4kGj3thovB6usFTpQoW8gLEPGYCfjap65GDy/j4UEw1Jgv9yyhi+kQ3m5ZgzX3TgmLlMtf
	Q1B8d
X-Gm-Gg: ASbGncvjmUMsudnfoT5cjivGuSaCYgs2k36kp5Q8zLJYbEVuZQFdRRkrqUjXcMzYzBs
	AeOwieJsUN/+msEsWBmlgM48lKZ3oLdwe4rltiIGjL6TAvjuDo7MoYUT/uLhkwR55cIZBCbPWvH
	XX+g+swPpqFWombcQzLnhgXi3SxTcXSUtYOfwpdOQ3qUX7O9i2UyBAz0l2ktmkU/n1SqksksxfV
	vBAp1Mqa574WgVyd3L0AEMUCltifYEjEK/NLhsu3vxZro9kTDcgwQqKnVZXg+w9RKYuMDOCRC3b
	qHq0pSx/qPX49nrLHRDP9qNbx0Zo997vo85EWtTDC7C0uIn0nCYo7WzDnbteDGZUBrudZgwsjid
	T1B20A92cTpWM3bEAXZ56Fwf5/U6Z75I6mYS22rMpIz9yF+bC1E203yEJkaiooCJAIEGj
X-Google-Smtp-Source: AGHT+IFQIFlzOCxxmQ7C2Do80yKgfSPsGCHu1QihwCx2ZpKBASWum+WQU9o0sStuA2s084NA0nh7Zw==
X-Received: by 2002:a05:600c:3153:b0:458:bda4:43df with SMTP id 5b1f17b1804b1-45b85570996mr229305965e9.17.1757063182704;
        Fri, 05 Sep 2025 02:06:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfd000dasm35392835e9.5.2025.09.05.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:06:22 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] PM: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:06:02 +0200
Message-ID: <20250905090602.105725-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090602.105725-1-marco.crivellari@suse.com>
References: <20250905090602.105725-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d4817..eb55ef540032 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -1012,7 +1012,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueue(void)
 {
-	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE, 0);
+	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_PERCPU, 0);
 
 	return pm_wq ? 0 : -ENOMEM;
 }
-- 
2.51.0


