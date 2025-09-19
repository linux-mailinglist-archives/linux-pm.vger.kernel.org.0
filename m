Return-Path: <linux-pm+bounces-35042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10083B8A4A3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C8E1B21C58
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B3331A80D;
	Fri, 19 Sep 2025 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hDp+3sSm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96B31A048
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295822; cv=none; b=G/1QZV0Nv9UXqN8k4kLlikzHJeSZMBvNqXgudsXHajSwvwVAMtdqU2vWpNVPC77DSW2nMYmpbzQYc/TsoCI/SfqdwEp5OSeBjuQ9NJrOMvGF4/tQ5BsxxFs4K/+/vvaDYX3f1izdUTpsLS5a2KPwjDVHHFXsqXOb7iQA9UKMz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295822; c=relaxed/simple;
	bh=gnm9chVz5ZG3NpnAbeiWQiWcPR/Yg+OBKfb9xKaxZec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q9AgmWDCl8PXvUMakgzUCNeNl4/T9t9MZEWdH4k/b0E1+jsYW8gx9tONPmomssKfMB5OvSi8Mse27uguFuag2kHuQBrJc8wQpM9UZYNbGCg5J3wJsonT6frUCCg4mGansCl/4SyIIRpk/PvJZqAsbNv5VlIv52VpqD1W65vs1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hDp+3sSm; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso857121f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758295817; x=1758900617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpRkKxn7tjXF76vLWsxNTd8HfSJGm7UW72C1XTlcArM=;
        b=hDp+3sSmt4L+qlCELXLijHqtZYeIHVCv2W0I4WreVQ3hXMlHdVFyckMsthO14PiNNK
         p0HNp13IWJfqnPoiFs5wkU2BjNSpYQOFnTwnMKkwhOwDDW5eEAhUX9+HWm0EOsE3PA6L
         Mh1/0ulRmhvSNGKhGyP7ge9IWazjVaOn/i5WpId2q+Gv0+r70lZgS/ouQVtIkwH7QxbV
         FBHg2LvYa1YLd23lOa4rscC+gum9pU9SIrSZv1ojRIQhiEXK1Lu/1JbCcPojcoozEXNZ
         i7h5PuckC0fL7tAN+k5lhrwLgQf6Jct34K00jtnMMb7bqvc9odLmPJtwW8/V+I1Af+0K
         ZBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295817; x=1758900617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpRkKxn7tjXF76vLWsxNTd8HfSJGm7UW72C1XTlcArM=;
        b=eWptkS639D/QR8og0hJWJNdu6h7aj//lW1ontz7I94pmV2EIeKcv5GLqIGIvHsyP96
         OnxcwzU22C1obMFothFFzUESO7EwnGtqbVpDQWcuRGKYA0aeyqm0UPXb8oDD8L7VZNYA
         ubAtiVfRTI9l6I6Bjt0ewyYI+E1S7xQgEC5d26av03WmKcOlxHKUBKsWokLqeizNmav3
         66bf+MsjfLeANaDODhTN3m5/1NZOL5ac6aLt9+WzgpXD0neUc3atRLYTEI7ITz3CwN5J
         I09a7lOx+TfAtilcZEviRYdbhq1AnWHxdSUmlrUZczVNliVVUqovMLVSETgwZVsvwRgT
         8rGg==
X-Forwarded-Encrypted: i=1; AJvYcCVlcqJmiyMyLLO9pzRN7vBbkwCeD4NMlHqdcyTex0gH1/IzFSxFjh6I8UQg5cswj2FedpgPnEI0ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWVIwm3jsNGEmeA0S3WM/U2KNiqyLrp2/SqKe7AdzK2Z8Ex6b
	I5zLagJrA75Ewx6BY8Sx+Jo3rmB8a7hQFwQE0QRWshAuBGEZrXP5UneeRDZ3D1icwKs=
X-Gm-Gg: ASbGncuHCi7Dk0/xfmyd2DRihGXtjoLWhHRIcNtUU417HRTN0IGNOLIYLSH+CuPJLx5
	zz6ISegdJEj9duIRcMCZaDaO7MoqFKoe3FEbUOmjEwoCfwqLd4wV36VLJKH1Nz4ABW2cCMXBAS0
	kPbUQyM3G1qmsQOYExAUQ2loduCh/5+dPmNY/pTQ5NmgLYFuXMTdQbPivm6TZ3QSq2IX6jHa8Xx
	9xYl8p7FKGKH3srCmsQNfU3LEXOxWu3jgW9wGmNdXJDhGpicrswT1pNrjzCPLGDxI4aObWUeI9L
	NhWJoiho7/J7TE41Azak/c673ro3cAcO+Qogri3U+VG6LllT7d7olgjx8ru6kvKQBqkWtdx7qMk
	PathM7kCJOCemrzAmm1U9BIEMndChdLS/6gFtuYxWFWG0mw==
X-Google-Smtp-Source: AGHT+IGGLUHgftanRqnt6pFBM7QU+24mNVwxyAUgdJ5qN+HGMiXatVpfDKxcCdUk2TKtKGgN2DDBGg==
X-Received: by 2002:a05:6000:2911:b0:3e9:b7a5:5dd6 with SMTP id ffacd0b85a97d-3ee83da05camr2855515f8f.40.1758295817190;
        Fri, 19 Sep 2025 08:30:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7284sm8619156f8f.33.2025.09.19.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:30:16 -0700 (PDT)
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
Subject: [PATCH v2 0/1] PM: WQ_UNBOUND added to pm_wq
Date: Fri, 19 Sep 2025 17:30:07 +0200
Message-ID: <20250919153008.324338-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] add WQ_UNBOUND to pm_wq (alloc_workqueue() flag)

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. Add WQ_UNBOUND to pm_wq to make it explicit this wq is
		unbound.

        WQ_UNBOUND will be removed in a next release cycle.


Thanks!


---
Changes in v2:
- WQ_PERCPU removed from pm_wq.

- WQ_UNBOUND has been added to pm_wq to make explicit this wq is unbound.


Marco Crivellari (1):
  PM: WQ_UNBOUND added to pm_wq workqueue

 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0


