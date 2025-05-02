Return-Path: <linux-pm+bounces-26599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4891AA7AD6
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 22:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E14E27AF
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 20:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAF51F8AD3;
	Fri,  2 May 2025 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1wNx7XB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4481F4C89;
	Fri,  2 May 2025 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746217479; cv=none; b=ochwn6ZcSwE+6x/6kcfO7yOa3I8CB5SuXJG6GvrQhB5/scqabFhUxJPh2G+Dl4i6fOFyKRehcoSrBSny+Q6CvSECCh50ih8H1Hm4Zj8IDyoXn1lln3EW+XHog4xyYGqyV61FsQ3Y2CODHLPerIfxKm+JtMi4Df6VtpwFihgEPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746217479; c=relaxed/simple;
	bh=CKdQwCNtbgJmOIJdgIkwnIPv7ivHg8H3tUDDNRilhu4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BXbpaPsOjpBM9gfCGX5QLAcpc65SVBvkeNlz3rC/g5qdYqr+SAGA9ProcAQfrL8lVQfdO+lcpi4ahKC+T6BYxYnld/bzk45zAVdTqFHGNyZpUtqN/fpi/XwoX4Kqme+BawVLO4s/v80zgV7wliKisGxK/gf8Dle4DW6FbTM+aa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1wNx7XB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C05CC4CEE4;
	Fri,  2 May 2025 20:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746217479;
	bh=CKdQwCNtbgJmOIJdgIkwnIPv7ivHg8H3tUDDNRilhu4=;
	h=From:Date:Subject:To:Cc:From;
	b=a1wNx7XBYkalEtykc+Z3OIRyoeklvF1OsUyMWqQ7tLoDzpUJEJkJrDjxn2n4UBwcR
	 IG2hJ6SNfpxB+1J+/kxzx1XkKfWv5wagnDAgnfM2+5YCevhPAyqzXm2lUnOkLf2XrB
	 jnzX/G1JYVoX/2mz/6TzvwLH2gCwLitzohNAyXIwPWtz3+dIt/XGSn9PbZGgj0pdjU
	 SMIc8N5C++K/PaJkb5HhNJmJjbSovRsZERJh/EurZz0g+lL/JOSPavJD7DO6cfzbb1
	 7Hwil1UKnztT6xv2xrQMJRtne5jsMtG9cDEWgTKhE+S9lPzYz4vASddzAgF1DOeK9c
	 Y8CuYmFaELy4g==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2cc82edcf49so695215fac.1;
        Fri, 02 May 2025 13:24:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVign9eNtLrLzktYhgWzVQS2aFx8YKIP902pWBvsWYF4DWtOzkUm2NVL8Qv5TfEoBaKcTf137ERBQlQJRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBZiUWJyMDM+BvPi+yj5I7tSkpOHuDY/3Xm+ZHRFo3hZJ5UOJ
	5QJlYzEdjux+f/WSCpPdJVgZa+u8DnN9mRmgwiD7n1u+DjiJcFbQHZ/UQ0x98i6FRCcE+kkop0L
	poZUIBXnT1fONILabp/06AMeTWII=
X-Google-Smtp-Source: AGHT+IG5MVEHG99bUGtq3hQ19odxMAg5CRQLYjohAVivNoibLMq0qjwzbzNNUYD6uB86bNDQBOlkQi+1l88Rpk6G25k=
X-Received: by 2002:a05:6870:b004:b0:29f:97af:a1a0 with SMTP id
 586e51a60fabf-2dab3301a9cmr2305480fac.24.1746217478465; Fri, 02 May 2025
 13:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 May 2025 22:24:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hWHUokQz-cU=W7+wY4-ZRWKnz4PvUSk17vsDoPb9oqXQ@mail.gmail.com>
X-Gm-Features: ATxdqUFktImLQLMCCikDmTaLIzO0CrxcayCGg_H2QrHFELmRJvkGgat7NTIo1G8
Message-ID: <CAJZ5v0hWHUokQz-cU=W7+wY4-ZRWKnz4PvUSk17vsDoPb9oqXQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.15-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.15-rc5

with top-most commit 23203ed263f0701368468952d5004e320e5af6db

 Merge branch 'pm-cpufreq'

on top of commit b4432656b36e5cc1d50a1f2dc15357543add530e

 Linux 6.15-rc4

to receive power management fixes for 6.15-rc5.

These fix three recent regressions, two in cpufreq and one in the Intel
Soundwire driver, and an unchecked MSR access in the intel_pstate
driver:

 - Fix a recent regression causing systems where frequency tables are
   used by cpufreq to have issues with setting frequency limits (Rafael
   Wysocki).

 - Fix a recent regression causing frequency boost settings to become
   out-of-sync if platform firmware updates the registers associated
   with frequency boost during system resume (Viresh Kumar).

 - Fix a recent regression causing resume failures to occur in the
   Intel Soundwire driver if the device handled by it is in runtime
   suspend before a system-wide suspend (Rafael Wysocki).

 - Fix an unchecked MSR access in the intel_pstate driver occurring when
   CPUID indicates no turbo, but the driver attempts to enable turbo
   frequencies due to a misleading value read from an MSR (Srinivas
   Pandruvada).

Thanks!


---------------

Rafael J. Wysocki (2):
      cpufreq: Fix setting policy limits when frequency tables are used
      soundwire: intel_auxdevice: Fix system suspend/resume handling

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Unchecked MSR access in legacy mode

Viresh Kumar (1):
      cpufreq: ACPI: Re-sync CPU boost state on system resume

---------------

 drivers/cpufreq/acpi-cpufreq.c      | 15 ++++++-
 drivers/cpufreq/cpufreq.c           | 22 ++++++----
 drivers/cpufreq/cpufreq_ondemand.c  |  3 +-
 drivers/cpufreq/freq_table.c        |  6 +--
 drivers/cpufreq/intel_pstate.c      |  3 ++
 drivers/soundwire/intel_auxdevice.c | 36 ++++++----------
 include/linux/cpufreq.h             | 83 ++++++++++++++++++++++++-------------
 7 files changed, 102 insertions(+), 66 deletions(-)

