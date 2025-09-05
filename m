Return-Path: <linux-pm+bounces-33939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8FAB4529D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 11:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804565A6EB4
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133BC27602D;
	Fri,  5 Sep 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AoTpAeAe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02086279780
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063233; cv=none; b=eqzSsJFokHEAkeAoCmkKEheSpXvLflI2ceFT2g+WFFhNyiZ+y0osFEcmnEL6aWhpI3ImCFm65fCZ79owCYJZibmzuAAI+uQQTOXLMZ1khpTsJqkoJsgJ/ue8kVs6XytcZRa7ctgVSRZTkAhqu1Epiql8lvh+IRfxf8uw7KR0ugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063233; c=relaxed/simple;
	bh=nGsURlCSPFwMHkpwpnRBNIFq9LbFcjE48KUt2cUhCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LDCvA+Bs3RKUgx0IUW2nBS8Ogq3OSzcK+W8PqVJ4hCjiGADxK8w4tiE7OmybwVCT8DPhDX8XWSO/BUV37jDlTXzGcnOHbCXkkAzL2PLxV0O6GzzNDIByGL5HbPWNTnTha6Ep56Cbz8ewbEv1/2H0mI2PY2BRL6I1xmijD9tnBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AoTpAeAe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so9952215e9.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063229; x=1757668029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GcIUScVuiPlioGjKLRlRjgmAOi3epp++ZXELbLlRfY=;
        b=AoTpAeAeNfy+l1gufOnj8pjGi/zV2lhJoSesr0PVSkCUV4cN2w0C+U2uz0BNjkUs0R
         mgVxVfXddX28vB9SyA3ytSbUF7hm+S9ux7B1yNLmf5X5AxD0t8Eye+C8GiTMW49+uruG
         j5aBtkqWGLzVnDn4wSxhbX2kpN8dyccygdrScqzGjpLuZOd48BSsww9alcr87lBPiBO+
         CvpAovWi/1kEM51HHQtV+4h8uLsb0fHXFzk+8cPLhRXjNIu313k5ux3ELQZ7cpkeOfZk
         dwADhawCEv/1p3sivq48TTgN+hORxQPmsMOS+znYnxKRBlSRkS907FledjfqnuV/RuBx
         Cqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063229; x=1757668029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GcIUScVuiPlioGjKLRlRjgmAOi3epp++ZXELbLlRfY=;
        b=vl94AcfEJMGZ+UyLivZsqi1le3FWIFRNiTC6sYwygaEobQ3Ae5lAZxX3RpbtJ0NzZm
         sWYplr4O1OGH/UIdNwmlceNJaCbEOfYIWGeGl+gvaFIRUVlKx4kqJgjZKMUSc9PX0WUh
         2gadQVEnY701lrs7fhU9qNh/P45JnQUfFctF60FWMf3G1zYJfoRd4e39Pzo44jL7CVPv
         M9PaBIOCMITnJcE4AaE3gwWHXTlf2n4KIth2JLKhXyfcOwhqjScxaOWgwk3lS1VmP6XK
         PK5RRUJ3cLZU/Epg9xYpb6t3fH8+wxwb8ME6CtWH77QDM2wwW2WviGFzSViYh/YTRvaM
         nADQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpeY+HsKOHsf+uMm0oWND8eocFNqTkHec/9LMJBJyH/cVxEYChM8bT3axkKRoOxm14cO2ymKJNaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXfzaDDWCGIA92NT1MsSoWI+I+cu2mORMJgUN4mVdg0m5290a
	/Mi/fRCuxAOCZPjgE/FrQyDaLeOmrsQRDWpzAKSBXSdLcKBWirsePKd+s1AEDLqjX+E=
X-Gm-Gg: ASbGncssGz3gcGAA3PXrK+/IMIeIHzltGVglxiNuzsb2yA4I5DNyOK/O+q4T1hvxiXb
	rFH7t2f1xWNM5svc30qInFAyhc++JERmN3+iOO49hdorW/vlUXd9VYOHZBZYmvYV/CTETtaIzGN
	+o4TX/UG7hIpeSDFeoQCG/7uXb9i7qia0oq679R0QUbZ3Km6wPYU2YnMvlX8QL8kwkIVtFIJCnr
	RZZTMgDYndocCxMqnQ/kxhRaCuQBDDwb5l82FLZ1Vb42G3aTe7FmnSCN0XSowHVf2dakx6sr77k
	eEUeleYdwunRs4QA3Jm8V7F3I3oLW7x95ayFPcsDQO3cx3jLKYv+xxW+DJG9KUQGnS2/GJEesN1
	RCnnfGm1Zc8CohGoFOMUZJ+dM8Dx87q5/IGyDAkxwU3mW1WA=
X-Google-Smtp-Source: AGHT+IHK/rpFXhjPJeTma6YO95IHuyCp72obym5OqKOmlqjGWCVgqv0gSF2AQvVrvQpPFKJV4RqowA==
X-Received: by 2002:a05:600c:4695:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-45dd5b3c3bfmr22463695e9.8.1757063229313;
        Fri, 05 Sep 2025 02:07:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcf3de7sm35952735e9.4.2025.09.05.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:07:09 -0700 (PDT)
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
Subject: [PATCH 0/2] power: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:06:39 +0200
Message-ID: <20250905090641.106297-1-marco.crivellari@suse.com>
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

1) [P 1] Replace use of system_wq and system_unbound_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.

2) [P 2] add WQ_PERCPU to remaining alloc_workqueue() users

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

Marco Crivellari (2):
  power: supply: replace use of system_wq with system_percpu_wq
  power: supply: WQ_PERCPU added to alloc_workqueue users

 drivers/power/supply/ab8500_btemp.c       | 3 ++-
 drivers/power/supply/bq2415x_charger.c    | 2 +-
 drivers/power/supply/bq24190_charger.c    | 2 +-
 drivers/power/supply/bq27xxx_battery.c    | 6 +++---
 drivers/power/supply/ipaq_micro_battery.c | 3 ++-
 drivers/power/supply/rk817_charger.c      | 6 +++---
 drivers/power/supply/ucs1002_power.c      | 2 +-
 drivers/power/supply/ug3105_battery.c     | 6 +++---
 8 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.51.0


