Return-Path: <linux-pm+bounces-33941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D4B4529C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 11:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4781A044D8
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF1285C99;
	Fri,  5 Sep 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UVVO3r8q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF728313B
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063235; cv=none; b=W2ojA8/N8JPnrF/4Y1+MoELiugKWGwHnEXdnwJ3g1hHuuS6HF1jiyPNCi+01j05Wn3ZLv6kUFd9G9vLzZyQIQDfsJm5ogQS/LvZvYxFBU44c6kArZj24w0rhaVUdtuu+4VB/HeJQJ/XlWEDlGNBzwqrnAUPYbIDZn4pBfvohbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063235; c=relaxed/simple;
	bh=MxmeDlDN5KAsmLl6RmrOmIHNNJKRzlp34HwIOHi+2Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7UWpjLpStMn7VlYSk+CfXFRunHSGKKgxOBt2MWLLEwZn5YIll3rybTgizUnp9GUk88N0Wjih1LLOtVJTTW+WUDDj4ZOdt7OoWtcGKw0JoAJfNqBxwwQ+yKcr9+pYeVnCW7G4YbczNO60KkiEs26QMHGRe28DHMLZU6X3OjUAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UVVO3r8q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so6610465e9.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063231; x=1757668031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWlMhxr6/JAIt8xHhW6LUxkzXPJaGBgQ29vWEbfPbfw=;
        b=UVVO3r8qLEr+BI6+9Li/6sNjkH0ShAqfTpk9Y1oEFpvX59oIpd56sR7rLOAK9nTiYe
         zsJpRVZlH1nRrtHHFjXMilTVSUHx1qLPjQtL8+KYUkJskekCRlXndtEo2TKtDBHB/5fL
         NSP5QDWCUUPM3p+ufHdJ2JxR2qGWlojLDbWwcLPazSCpjhGXTu94EMXZEqdtQiktDXhU
         RIuKIabUExueLDOo7nNMuWWWfgBtM4LsT7phxpK9lN5xEcqGbeaWXeP94w4l9wfvGckc
         9h5eBoRgEwZev0yMKOPllQ47fYVLl5QW4k4UdcGbtisVNS4ciKcr5Ha7pvVSL4L2mDee
         W4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063231; x=1757668031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWlMhxr6/JAIt8xHhW6LUxkzXPJaGBgQ29vWEbfPbfw=;
        b=Qc2Kd7R5STrAUq+vBwcUseFo0jjxYIcKDzvRbpj4v6KL6vm09YUqouQcDRnwpXEtXR
         u/J8P4IHsk8D8roLU0IurGpXRessh0ziv4xh0XcdDy3TM90e5tu5GiYyRrpwk0v7G37X
         R2v2QkR+Qq0zUfi6lOsv99PvtKJe8sM4ylzk1mtNXgCra55VNynsYVKqAxBybr7SDiY9
         oKyHXe9qeX3fjw/hZq3jV8TT/ti9hOSHgBXnc+ccjhUL90PK8mtM6iqYh29Fyj2/IcAm
         EeEytQELH6+qp9WXGhxKsl+nt2cbHIOr53YgN7K1e2hjQE+buS+VWULTFRRCZ7lzvWeH
         giew==
X-Forwarded-Encrypted: i=1; AJvYcCUAQ+GmzKAEfKV2j/SuftHSvHgD3ceJO4vu3tnH1ZzKMHBzRDuQwhgKisxF8oIB8F/zKdSFfwAhIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmDsP6FCCQ9/73S8+9p9q5Fdg6KxwakD7m8g9oQUSIHMfmQzSm
	5S3fILA0oUtpDfDUb0fNsCWrhIDgi89M2HvGXF5QiE6rlZl+IQyKP6oZpDpK0Mi1G5E=
X-Gm-Gg: ASbGnctPUocswSvq/4SR4j6i5v2ekiU+kxoPR56ZPl50A92RvVYx6Dw0HrxY1gDGIvR
	kW5FWaQBRRaDs5fzXc//pyZb4x6JwFkVaBVe6WHT5LJ77fQsxwnjhxiu3vHhewxhghTw0l/lTWJ
	h/s2qG4147JyjeN/V3PyrzSIRvH0sukmCp1mFOg3wAgLzMQxZaTM5vOi+hna6rtPIJAJuPu2JQW
	0PCj2x6sttAaYQW3mAk9E+frCEWm86M1ZdPdzhFKMmuU5L+XBh0R1Gcfxh9BJbkQfkEg7cf6zOR
	Itv3vpsDvAXSQ69lQp9CvzSx7SKvErO+hOPu5T6+DWXAECU13xx5soLsY8uSMHdmfcdNWP3Vj+c
	kogksnJlB298fLFnHdZ+34Elm1Ft8uwHZ/F8s8o9RFMtWzM0=
X-Google-Smtp-Source: AGHT+IED/A3KRrjTPIg3Rfxm4o8Ll0/rnXVSCw4XqZdm4RnIIk+8IMDwa9jZJ8xmaRzlAn5M4IpdMg==
X-Received: by 2002:a05:600c:4f07:b0:45d:d6fc:2509 with SMTP id 5b1f17b1804b1-45ddc189486mr562625e9.6.1757063231266;
        Fri, 05 Sep 2025 02:07:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcf3de7sm35952735e9.4.2025.09.05.02.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:07:10 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/2] power: supply: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:06:41 +0200
Message-ID: <20250905090641.106297-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090641.106297-1-marco.crivellari@suse.com>
References: <20250905090641.106297-1-marco.crivellari@suse.com>
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
 drivers/power/supply/ab8500_btemp.c       | 3 ++-
 drivers/power/supply/ipaq_micro_battery.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index b00c84fbc33c..e5202a7b6209 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -667,7 +667,8 @@ static int ab8500_btemp_bind(struct device *dev, struct device *master,
 
 	/* Create a work queue for the btemp */
 	di->btemp_wq =
-		alloc_workqueue("ab8500_btemp_wq", WQ_MEM_RECLAIM, 0);
+		alloc_workqueue("ab8500_btemp_wq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				0);
 	if (di->btemp_wq == NULL) {
 		dev_err(dev, "failed to create work queue\n");
 		return -ENOMEM;
diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/supply/ipaq_micro_battery.c
index 7e0568a5353f..ff8573a5ca6d 100644
--- a/drivers/power/supply/ipaq_micro_battery.c
+++ b/drivers/power/supply/ipaq_micro_battery.c
@@ -232,7 +232,8 @@ static int micro_batt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mb->micro = dev_get_drvdata(pdev->dev.parent);
-	mb->wq = alloc_workqueue("ipaq-battery-wq", WQ_MEM_RECLAIM, 0);
+	mb->wq = alloc_workqueue("ipaq-battery-wq",
+				 WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!mb->wq)
 		return -ENOMEM;
 
-- 
2.51.0


