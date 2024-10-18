Return-Path: <linux-pm+bounces-15981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF139A43DB
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D462814ED
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A1201101;
	Fri, 18 Oct 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWCS0i1+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED92AEF1;
	Fri, 18 Oct 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269052; cv=none; b=PtM3HgAfgemHD9wqMGPcXh92ICTRtXqwbNMQJ7bodIDsSmQMUNKMdBsA5Wi6OQpSVzCMElF6aCJPvpqdsnIBESL6BFzYFWnJkxPeRqKbZGMr43YXsOGQSzsQV3nH+4DrkLf1AY3WEib0ZAvkQ89YSp/hza0m5V/0SpOz5Fw8KLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269052; c=relaxed/simple;
	bh=LLpWnw88agcwnYcsLej0pL2PlgTKckLkE4mqUQnAwHI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WtLuSPJWNxk+jPe9rGrVeWN/GIo0JrR8vIO6VyIxk9NGOE6QS5/4qjxeKXHbIwU+mwPxOAeOOiVJYpvYBpGTm4jivl3oG+n5ueIFYPM716i/jna5hW/80FYhPn9A2hPfrQJWeMsE43SpCz5PWcj/4Xk3r7o7DHfqCeNvcj2VyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWCS0i1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E80C4CECF;
	Fri, 18 Oct 2024 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729269051;
	bh=LLpWnw88agcwnYcsLej0pL2PlgTKckLkE4mqUQnAwHI=;
	h=From:Date:Subject:To:Cc:From;
	b=LWCS0i1+GLTQAbC1AqPikQuQyHG60VycEIcTCX3mhLhAI5VrsLbXyiKrVJ2K0HH4V
	 Ov27Q3B46eAI2CFWHQh8VUFGP3qfoSPtj8Rrb8VpwCKtjjXXzcUPjcDDaB3Y6Phmhn
	 lv5fb6xwllBz2tdT69MUvL9+htfxXAXq3pfLzswqIznEZoSWpq9BZ2omKluvJsrnEe
	 BtS/8z58b9f1FtwZyJHyTrn8I4ISEj6Ia22PILz9puGW1WdOWZQZwCv+7Mrt0jiI04
	 nCmm+NDXQ2GrOIVIAkiL5/eT+LnQ8vBbBwgL3RGwaw37n7IKDwgWUC69d1MWLkxmOY
	 kUQ24lTJ6HWcQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2890f273296so1080177fac.2;
        Fri, 18 Oct 2024 09:30:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXX0R6b97xodAQA+Q1fRWJNNkhUA7bWvDePd896SZtiSRZd+EGQ9I1tKVl2N7n0w5zjgiiWipndjdR0rlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmvsIFmNjgAW/lJvWG2pkXiBlSNcroIQaF1QXiKdhOB6MEwEa
	LiUBXrwVdnm1SE/n9/ZsZ1F1adm1HeinF0KYeUSMCy8gxERpAaqtunUsnwIkdm494MPc23xv/mD
	IG1TUZb4b1Q0OPxETddbBgzEsB78=
X-Google-Smtp-Source: AGHT+IEOMP+MxadKHPQEdtY94wrj0yqlOXK3CGFKZi9ceYDRhQRlV7Uq1M4TtlmE5HZ9LHuRcnvi72sUfzlBb83C+dI=
X-Received: by 2002:a05:6870:468f:b0:260:ee13:e665 with SMTP id
 586e51a60fabf-2892c4f16a9mr2619258fac.37.1729269050861; Fri, 18 Oct 2024
 09:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Oct 2024 18:30:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hPF1RTBQiuY3NcG+qnbOKhEZQq4CyWoDSzdsJMTG5PJg@mail.gmail.com>
Message-ID: <CAJZ5v0hPF1RTBQiuY3NcG+qnbOKhEZQq4CyWoDSzdsJMTG5PJg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.12-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.12-rc4

with top-most commit cf8679bb77e99682a5a5806cc86554235fa56233

 Merge branch 'pm-cpufreq'

on top of commit 8e929cb546ee42c9a61d24fae60605e9e3192354

 Linux 6.12-rc3

to receive power management updates for 6.12-rc4.

These fix two issues in the amd-pstate cpufreq driver and update the
intel_rapl power capping driver with a new processor ID.

Specifics:

 - Enable ACPI CPPC in amd_pstate_register_driver() after disabling
   it in amd_pstate_unregister_driver() when switching driver operation
   modes (Dhananjay Ugwekar).

 - Make amd-pstate use nominal performance as the maximum performance
   level when boost is disabled (Mario Limonciello).

 - Add ArrowLake-H to the list of processors where PL4 is supported
   in the MSR part of the intel_rapl power capping driver (Srinivas
   Pandruvada).

Thanks!


---------------

Dhananjay Ugwekar (1):
      cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory systems

Mario Limonciello (1):
      cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled

Srinivas Pandruvada (1):
      powercap: intel_rapl_msr: Add PL4 support for ArrowLake-H

---------------

 drivers/cpufreq/amd-pstate.c      | 30 ++++++++++++++++++++++++------
 drivers/powercap/intel_rapl_msr.c |  1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

