Return-Path: <linux-pm+bounces-25729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEEAA93E48
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 21:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935581B62084
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5F1E3DEF;
	Fri, 18 Apr 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE5x9gM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F45475E;
	Fri, 18 Apr 2025 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004787; cv=none; b=NS8kInNNO0aGikyd6Be8FjJQrLjETQka+Tp8M3dCB96faeLvsmbouRWQhUw4Q4Av6vZtZ1eL/w/bPkFJk0NpWj90Qo7UZtO0LDjQHpLTNYe1xGfgdgoaET3Zi07Ua6oUWlGkGgIpx56zoSLyM8LfG2X5tSMocsXTKWBuvId/q0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004787; c=relaxed/simple;
	bh=Fyg0L7GBWCmPEo3XvR0XGgx8Nk9TP1d+4kIvHTxWxh4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aI4TnbhFofLloZN3LP6I9Q3mjIwuBdVYaDlFqZV6Sl0eZnjiDiXMQcR7yDoyTYNRi1lCzQjX/gmrY7IND0VsOUrJtIUXdfn1MmhzKNuU1BenbDu/fqSBNAW4mHDq70rWqCZVDhjM8UcZmIvyEK6POJfhYegS5UCKGo+iiD9nbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE5x9gM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6523DC4AF09;
	Fri, 18 Apr 2025 19:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745004786;
	bh=Fyg0L7GBWCmPEo3XvR0XGgx8Nk9TP1d+4kIvHTxWxh4=;
	h=From:Date:Subject:To:Cc:From;
	b=uE5x9gM0fWqvpqF0e0V5OqTb+Q6cUcxU630bhDNs8w1FtsCtDjMVDq1QIhkV0fjDU
	 O3pyDXrBrmj732H8miwq6CQvtGEA9jvng5A+XO0zvqUp9pBHrnoo9T06NvBB4BX1nX
	 VIVXg9EyMvtLc1DZF99jQ6iZPKbbpjkavPazlnY9aNMhdaAOCvd24HNFsARD3JcfzP
	 /MQqymNMzNXXEJAoxZtjtrLer6DIRHeIe6zCb+q2Xk/QzRx9POg9ACB4gEjEC2vmSQ
	 LfCm47gV8JQVH6FXFaUnzQrIALmlBZ/P7zUiBbJyDkIVHeI7pmNQZcHfDMdGetpHW3
	 ZnPenpOED5MFg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2d4f832069cso881293fac.0;
        Fri, 18 Apr 2025 12:33:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6Ye37M4Z45pdKdPe9n7kB61IcuKdmjBewelrjFQm2c+yLQnJ+qekmN06y58iPFhmlwY2xfnCtssJcLAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3v4WtS4gesfxMFDYG++1k37TCE335rRvSJE0IGs/ULkTjrWT
	rP0NQ4CIifLsMm8GRviyAsNY02qO/T2yAb6E0fh/NMZzjqaqxEfsnt4/4b0orVXkq1vPckdc7E+
	NChQdl/9mipq2eTqPNHp4V2g0xeI=
X-Google-Smtp-Source: AGHT+IHpHkeR1L5oHyMvHJK+fSmsdKbT6vOfHo4dyxGcKuIngkCqCxex/NZqT9eC7GovvpwWlqgehIW9zwei3aa20II=
X-Received: by 2002:a05:6870:ef83:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-2d526e0dff2mr2239611fac.36.1745004785648; Fri, 18 Apr 2025
 12:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Apr 2025 21:32:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gpDf9mBFGRjnrU8LaPzc0foCeGhzTkOu1FwooyGFzSzg@mail.gmail.com>
X-Gm-Features: ATxdqUEHSC7CnX8PfTQUqH4k3euLoIqoS6HtH43Hegr-CbjmNYIJgnYsDY1zgUk
Message-ID: <CAJZ5v0gpDf9mBFGRjnrU8LaPzc0foCeGhzTkOu1FwooyGFzSzg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.15-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.15-rc3

with top-most commit f3b25a1b48191048e2f190d878fc3175fc08ffaa

 Merge branch 'pm-docs'

on top of commit 8ffd015db85fea3e15a77027fda6c02ced4d2444

 Linux 6.15-rc2

to receive power management fixes for 6.15-rc3.

These are mostly cpufreq fixes, some of which address recent regressions
and some address older issues that have come to light during the last
two weeks, and a runtime PM documentation correction:

 - Fix the performance-to-frequency scaling factor computation on
   systems using HWP in the intel_pstate driver after a recent incorrect
   update of it (Rafael Wysocki).

 - Fix the usage of the CPUFREQ_NEED_UPDATE_LIMITS cpufreq driver flag
   in the schedutil cpufreq governor after a recent update of it that
   has caused frequency limits changes to be missed sometimes (Rafael
   Wysocki).

 - Address some recently discovered synchronization issues related to
   frequency limits changes in the schedutil cpufreq governor and in
   the cpufreq core (Rafael Wysocki).

 - Fix ITMT support in the amd-pstate cpufreq driver so that it is
   enabled after asym priorities have been correctly initialized for
   all CPUs (K Prateek Nayak).

 - Fix changing min/max limits in the amd-pstate cpufreq driver while
   on the performance governor (Dhananjay Ugwekar).

 - Fix a function name in the runtime PM documentation that was
   previously incorrectly updated by mistake (Sakari Ailus).

Thanks!


---------------

Dhananjay Ugwekar (1):
      cpufreq/amd-pstate: Fix min_limit perf and freq updation for
performance governor

K Prateek Nayak (1):
      cpufreq/amd-pstate: Enable ITMT support after initializing core rankings

Rafael J. Wysocki (5):
      cpufreq: intel_pstate: Fix hwp_get_cpu_scaling()
      cpufreq/sched: Fix the usage of CPUFREQ_NEED_UPDATE_LIMITS
      cpufreq/sched: Explicitly synchronize limits_changed flag handling
      cpufreq/sched: Set need_freq_update in ignore_dl_rate_limit()
      cpufreq: Avoid using inconsistent policy->min and policy->max

Sakari Ailus (1):
      Documentation: PM: runtime: Fix a reference to pm_runtime_autosuspend()

---------------

 Documentation/power/runtime_pm.rst |  2 +-
 drivers/cpufreq/amd-pstate.c       | 36 ++++++++++++----------------
 drivers/cpufreq/cpufreq.c          | 32 +++++++++++++++++++------
 drivers/cpufreq/intel_pstate.c     |  2 +-
 kernel/sched/cpufreq_schedutil.c   | 49 ++++++++++++++++++++++++++++++++------
 5 files changed, 84 insertions(+), 37 deletions(-)

