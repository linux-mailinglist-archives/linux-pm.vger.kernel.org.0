Return-Path: <linux-pm+bounces-37537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F285EC3C7AF
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 17:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47E0B341676
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59134E768;
	Thu,  6 Nov 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D+OdZ71K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA33396FA
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446832; cv=none; b=nS8Jz8VnTc06ZAQ6j3/BYXz7uSTc9ip3VSrGto0R53kwoH+yzvd1O5pB3RxDPWo7FCOwOC39Fe+kS905JDBDGpgtha8Iv07hZ0+vPrE2IIH+hXEZLcTgZwBzHK9/mIX7adp4jfCQaVbRsywBnuEGwXjRpkUY9+zYLQvn09TrHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446832; c=relaxed/simple;
	bh=3I2vzrQn2493MZariDAPILNiax7J1mg+M2E3mdJOuYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wh+MGcP984eVYKm3fDpqsFU9Ad5xZSYj1lOYle4kH5VEe324cwv4Jg9sehz74uCdho28tg5sEJCuuQDYiVl8KsoyG6ZJDMRhxAfRwHNYLBogssfymsS8Blk1lSzsv9MXBA7sObdo6us3lbvbuXlERnmWYfoSTh820UEheJ8UcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D+OdZ71K; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47728f914a4so7248045e9.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762446828; x=1763051628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmza2AdLyO5hSkvbNEJb99o8w0t6fMLr8LtB6/z3n84=;
        b=D+OdZ71KknfJxKlViVNwBEnqXNgQGpliCb412GHPIF9HximkmCOYjwfvCSCNCZfruu
         lvDivqTwFfyK/8uvKv8lDMM7CQTEegO7uHBEMPf0OkmQcPKuy/YGKGsH0gBb3APgFe60
         0v2gHfm3SAEbXAXTZoCoNcAFSZUbsY3KPguEbchJA199h4FM8ZfvAgRQgXHkEDHNvtew
         K1F4ZaJohi/Q5CydaMDqu00Kx1VETUoPMMO1nH4YmyZmGZr2EsNyfZ/tL8pxHsh949jL
         09UAQp5LLamQJ70lXBW/8hn0/9bvFOFhBk3H7nkGBlhkxuWosizq15oEOVuQ5wbc92hk
         dwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446828; x=1763051628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wmza2AdLyO5hSkvbNEJb99o8w0t6fMLr8LtB6/z3n84=;
        b=JVvHL4SEA807onUtKZLavOy0S5FvoB2gPtiuaG2GmNHwRPQStOmkafVGzTn5ds+1IR
         OmyX3oIlKkEAFGh+mkIb1i37/7wy9wvUAw7eMoVd3nfDb8Z9B1MEO2GK8uJKstBc6F2u
         BEIS4SFlHOsFP/7I8IvRBjOncuEv8Wf48c+UqcD1XaKCJYX/LFk8sqZqw9d75ruENC5J
         iJ6tHNBPkv0oP7eb/QcRdUDyVoYmE+shrK6wcwIyl1rgmFIHXZXM4wucKm0cdz9X/GiZ
         hOjhTFjYj/quC6NV5ZX0R8cNhOpoWjm0WPvrCqNRcRMz7Xh/BS2gVC7SdXEudzV3/kts
         lTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUilUN8y0OWOdMkAQIA1+8fDCQ5BaA7DT2zheBoYS/LNm34L1Kw9/67jNamI7uFxMwK6/nHuOsE0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQhBWt1LXFgUaQqTAp6cKA/Szw2TluksFg1/a7Aew7THtr/Xa
	b5XOiS0JuVVBjpdMrJhp7p92YPb/weCmTCZgeO2hcFHRuaSD7QIAoeFbjxT7KUklt/M=
X-Gm-Gg: ASbGncub0sN6Z3It8nUprxbGXFPYdYHAN0LxkHAmvlbdgXSIjt1VYdIkB1G49S3Yfyd
	sCBrhCX9HKI3CyD1C/yySoRQQ90J1d/HQ3raeHb05hMZPi+v9a1XvH+tYK1NEJZna+Q7n1B261e
	FIsoD1wsY9eBfmBD6R/t/rDIEbvN6qqPFBatgY+HhE5jg5vSvKCzlUjWkQMgjhAzpX3NXpV65Y2
	8TH1mgFti+tDeUQYxPqjBuHAh7LKBDQ/4n9sbJIM4JEZXcrLeJeilTZunegKv6MDT/imK7/Ne/V
	cDL6Tu2MyrKhyHLuukCw4Duu7eso5QCrR4ZAjwict5+bankggEfsj2hSt3t5VfPHzm7ZZs072fM
	M59HI53zi+6RK928XPrHN3vOE36EMlHBbqXNx9lounjfG/3hBK9p6E6HPsfGBvjyyPhaVaxPhSM
	ISI7smXO62RXYO0UKYDX52ZfyHh5ayiB1XBQ==
X-Google-Smtp-Source: AGHT+IHMQwUSDo58hdMpPVw1nMtG9wyNVUVuAFCRYr+ffd6NpaE3dP6xzd/TRMuvSh7wbP1rkuh8Cw==
X-Received: by 2002:a05:600c:4f16:b0:475:daa7:ec60 with SMTP id 5b1f17b1804b1-47769d50585mr22128845e9.21.1762446828531;
        Thu, 06 Nov 2025 08:33:48 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f13dsm19539105e9.5.2025.11.06.08.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:33:47 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH] cpufreq: add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:33:41 +0100
Message-ID: <20251106163341.336989-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 9b4f516f313e..695599e1001f 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -750,7 +750,8 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(bpmp))
 		return PTR_ERR(bpmp);
 
-	read_counters_wq = alloc_workqueue("read_counters_wq", __WQ_LEGACY, 1);
+	read_counters_wq = alloc_workqueue("read_counters_wq",
+					   __WQ_LEGACY | WQ_PERCPU, 1);
 	if (!read_counters_wq) {
 		dev_err(&pdev->dev, "fail to create_workqueue\n");
 		err = -EINVAL;
-- 
2.51.1


