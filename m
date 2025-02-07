Return-Path: <linux-pm+bounces-21536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6FBA2C32B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C226D18886BB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388741DE8B7;
	Fri,  7 Feb 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOqK9GKo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0B2417FE;
	Fri,  7 Feb 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933369; cv=none; b=up7Uvpwhvj3kKa8Ps+eOH4pXAHM6DM0ls63IpNllQuAqqZldMzHZic0A1huz1YOXo5GkokkoX6eSrwWKkmGbeASNQJcRmKA+a7AGqj0/uAP+hlwcrFUZfeND8uCBxg4A9rfG7axEK5UZaOUTVTBL3K1pz2aVDrQQ5uC/+H6AqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933369; c=relaxed/simple;
	bh=srZeDIs7Y9IF1X+fjnR2YJOVKn3RWSePdJ+28JEk5Bs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NGiCSYXY+T8//mmDLAh70FoUsHGs1GLuqL2KHbUYEATPeVR6PMTQE8gB5cptbbyMInrt0VnGmJpuOmjZzKcdts02BMonv+Qiyjw428R5jGVleZqX+Kaa/A3HcXz65e/j34F7qHUsXqeHpUOP/gT038D2p354uHPphExxjFH9Djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOqK9GKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1E8C4CEE4;
	Fri,  7 Feb 2025 13:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738933368;
	bh=srZeDIs7Y9IF1X+fjnR2YJOVKn3RWSePdJ+28JEk5Bs=;
	h=From:Date:Subject:To:Cc:From;
	b=oOqK9GKoe+9tkZLvhDVs/rDLpbA+b1DOB8Yf17QvfngISAsdXR6MSUV1YgSvYRpsB
	 2W4oJBP7uhjYZEHip9XuobZSft2HfOUbT2ZBNJXYMoAaKGqVtC8Pj+8NTLdXeO4TMa
	 u86KDRdViAI/C3hZe+broN7W041TfI1APCazXCYRmVzddqfSWCNkmH8lHpCn8Zgvz/
	 XFPB8u2psjtwR4sqpsF+s6TQ9dkwGpsZ9XHB/xncAUNWUB+sz1IvLNa92wnb1+Ce+4
	 KyFrsIXIqdr4bSC71L8LzJPBcfs+xv/OFTx8MAPo7Ja+5FVrXbJTE5ng6KvdCK1vVr
	 sQZLiA0N51LYw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb7f3b1342so1078382b6e.1;
        Fri, 07 Feb 2025 05:02:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7pEXoPcJoNt6kU0Nf1n8+cWSOBY+g+sjsMdEqBFZckpfZtHJWPpcrqIpLd0oGyzzeMah6H6pkkmGk/T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4PILbqWj7iOxBRLtdI9eGIIWGMB/Q8H7Ewqu+i/OIQLOSB8W
	oIUu7P09GAIqjC+6Cj2n1e+8uqf0a6R9Q+liemolc6WIEHhRdxkrG/CONgrUxALJJnHCNICzecF
	TVLF76o6qsBqZ/9oohrIS1F/ogjQ=
X-Google-Smtp-Source: AGHT+IHavXcFvLN5VCIcGbq3CsZxYFREeA+TIs+inaHBcMCDuZ6fJkEdEcfrcoQZAF8VrkRTh9gAoBC/FY5eQ127zXc=
X-Received: by 2002:a05:6808:1804:b0:3e7:a15c:467b with SMTP id
 5614622812f47-3f392363e40mr2305496b6e.34.1738933367907; Fri, 07 Feb 2025
 05:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Feb 2025 14:02:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iU1C-K9dP+8g1PMvuuWg2UT-ocgL055ruWEX23j-KuPg@mail.gmail.com>
X-Gm-Features: AWEUYZlGmt0A3oT7293lvaMIuHBInAYX6iH5LWRwWfB-gbes8LCk5bKC25eZCnE
Message-ID: <CAJZ5v0iU1C-K9dP+8g1PMvuuWg2UT-ocgL055ruWEX23j-KuPg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.14-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.14-rc2

with top-most commit 73195bed7899150cd1005cf0a902b68793adad23

 Merge branch 'pm-powercap'

on top of commit 2014c95afecee3e76ca4a56956a936e23283f05b

 Linux 6.14-rc1

to receive power management fixes for 6.14-rc2.

These fix a handful of issues in the amd-pstate driver, the airoha
cpufreq driver build, a (recently added) possible NULL pointer
dereference in the cpufreq code and a possible memory leak in the
power capping subsystem:

 - Fix cpufreq_policy reference counting and prevent max_perf from
   going above the current limit in amd-pstate, and drop a redundant
   goto label from it (Dhananjay Ugwekar).

 - Prevent the per-policy boost_enabled flag in amd-pstate from getting
   out of sync with the actual state after boot failures (Lifeng Zheng).

 - Fix a recently added possible NULL pointer dereference in the
   cpufreq core (Aboorva Devarajan).

 - Fix a build issue related to CONFIG_OF and COMPILE_TEST dependencies
   in the airoha cpufreq driver (Arnd Bergmann).

 - Fix a possible memory leak in the power capping subsystem (Joe
   Hattori).

Thanks!


---------------

Aboorva Devarajan (1):
      cpufreq: prevent NULL dereference in cpufreq_online()

Arnd Bergmann (1):
      cpufreq: airoha: modify CONFIG_OF dependency

Dhananjay Ugwekar (3):
      cpufreq/amd-pstate: Remove the goto label in amd_pstate_update_limits
      cpufreq/amd-pstate: Fix max_perf updation with schedutil
      cpufreq/amd-pstate: Fix cpufreq_policy ref counting

Joe Hattori (1):
      powercap: call put_device() on an error path in
powercap_register_control_type()

Lifeng Zheng (1):
      cpufreq/amd-pstate: Fix per-policy boost flag incorrect when fail

---------------

 drivers/cpufreq/Kconfig.arm     |  3 ++-
 drivers/cpufreq/amd-pstate.c    | 20 ++++++++++----------
 drivers/cpufreq/cpufreq.c       |  3 ++-
 drivers/powercap/powercap_sys.c |  3 +--
 4 files changed, 15 insertions(+), 14 deletions(-)

