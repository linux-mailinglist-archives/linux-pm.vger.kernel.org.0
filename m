Return-Path: <linux-pm+bounces-33937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7EDB45291
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 11:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFD21C85DEA
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC542FF17D;
	Fri,  5 Sep 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LP3rIwqg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2232701CF
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063185; cv=none; b=q7S/EuDr83blxFFe42NAU6SnuSCjkdZUuKPX6AsK3mhyIGap5+jkp8cd02Xwf3uFLHVwsd0l7W4JgkDS0ShW+hpXan4HAxYsJv14wecqmFg+G/dTOcU8OMaTUltZElJqVdw4gb0sBMRxSMQD4tpmVLt8wiGjNDpfG+zO8pBBt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063185; c=relaxed/simple;
	bh=dABGYsiKKLOX/Kq8cTybGZ4tHpgS7edgjHmr7Wzii4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJfJ0yJJagdnjjTT1GpanVcas4NcoMDP9ahGucedVFU8m406aIy02l3ziIUkmB8VjYZnxb814C5ZU7J37dosaQ8/78b5VKBdCvntzbtVFj6exBhhF9L5U70asNnXHbJak3iiFMmmlViUdVL6/yGaE+LDLcwHOuyC7bUtV/UvpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LP3rIwqg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so11321685e9.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063182; x=1757667982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HDxgh3qSSs1YrkGcZ/7kjNewL5W1+Cb6Hqr89ZZbwM=;
        b=LP3rIwqgZRuKmfMGJm800xvLv8P5llu5sH+lPQzLUPfPIMslPy+ngLkfkoxa3mjiH+
         H7suXsvVdmN9I1n/0GvdDFXNVpXGrk9TUYs4Q48Hq7XduzGpwaAnKMpA0Tk2BpR+I38U
         NOwvEaU8thdXpgAqdz6pQ9QEWDILYk6cDmMWcrh6ht75tsg/SfrQK/25MQ4lUm1xhaty
         ebkGlO64W5kNPSLtni+eMjjL3LsKuBCNL6U3pc8uY0tPI6nIVfKtSmx5nLRXHU2PCPM4
         /rvJF8AsSooJG/uB6lFxjqUtnMo29/7xRsUgvn7TNI/JOssIqbLvd65Z+CD/+Bq2+a0T
         zMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063182; x=1757667982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HDxgh3qSSs1YrkGcZ/7kjNewL5W1+Cb6Hqr89ZZbwM=;
        b=S7MCTMMy7GC7k+V9ygBr9wPQo0Cq9ylBwXQyEuX7i7M7mJ7ZV/HRxN+TQaDVJOBi7f
         /CTiD4EpZyUlfVJrWwjx6Xj+L8NDoXlk4dsMBAH1y/V1IIbPjZRCaqS9dRJprSLlCz6i
         HpPTUnlg2opuCOr6ybaiNIXT6aqdSBIb5FLXDirXvEIxtnXS03KVgdqi7mjq62nbXK8k
         h8RpHFXBmgXqkUdtBljbJ3nDh5FsM+XCD1k8P2K+jhn0NlNky2slhgIKT3vp9RicHUYL
         wZlwHGd0O67joLiBbssBS6lS0k2R6MD39bO7XQtLMTxgX0A/qMlhC5mmpYbckYMo/SCL
         IqXw==
X-Forwarded-Encrypted: i=1; AJvYcCW1xLvWs3WBtCvHQtNCfhGdqv427/Ux9NJ5Lgz+tl6o4sYNSLq0Lezp2qxCnXIgqmjmlZe/ATG/kg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy025mWa3wANTaMBCbwpmG42eeEK4gQlDbQvODM9+oM5qlvxI7H
	Tw//ONf39gOgEbsMJaYQFLpjLpbauF7/5b17eRGdxIhXK2fPBRznD6JRBNw7SCNsuWnCWTI3pjy
	ARY5v
X-Gm-Gg: ASbGncvqFgjsTnltrjJe+G6aaxXFL1J9cS9kMrU6+WghT5I8ImgSZJLCeF3/qzGlg8k
	mUOzJBpJ48IIbpffJYzH5Jzyk4/hLDMqAMxIXOzRARr0p0eex8Rru/HAB+NCHWmYkrxwzblrluU
	TqDzf5mght42/qGgTGe5FA4ZM3WRBRMt4AqU44Oi+FqFCZg1VkFHnhH8/7uyx11ZVLbCg3mZyz/
	ZxgsRb3sUIJ41WbegV32FdD6LTigf2hbUZTBkUWp+EIzrxmEaHrxUIL8Pa8p8T5Vbmz4lDBTK6T
	u7FfwwFU6fV1zawHyu6IKCXtIm8mvPbMPEm212aYrya2BDFdcjD8WnrPR8r3lMYoug0DpicYNZy
	wdryxDHdc2Ltq/pts1btwSSjYR0epTVE9zeFnpzmnCKzL5AM=
X-Google-Smtp-Source: AGHT+IF5XvCixPDSV9pw9XzuahkIIPM6RFcpr9IFw0jmi4TereK/q8xwd7vHAI9e0FeN8ZyjEyW1+Q==
X-Received: by 2002:a05:600c:45cf:b0:45b:868e:7f80 with SMTP id 5b1f17b1804b1-45dd5d2186cmr22522165e9.8.1757063181775;
        Fri, 05 Sep 2025 02:06:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfd000dasm35392835e9.5.2025.09.05.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:06:21 -0700 (PDT)
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
Subject: [PATCH 0/1] power: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:06:01 +0200
Message-ID: <20250905090602.105725-1-marco.crivellari@suse.com>
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

1) [P 1] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. This is actually enforced warning if both or none of them
        are present at the same time.

        WQ_UNBOUND will be removed in a next release cycle.

=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (1):
  PM: WQ_PERCPU added to alloc_workqueue users

 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0


