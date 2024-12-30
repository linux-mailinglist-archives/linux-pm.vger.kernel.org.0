Return-Path: <linux-pm+bounces-19841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493EE9FE4BE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 10:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A53A1A4D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C59B1A23A5;
	Mon, 30 Dec 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRDpcHQG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6413A88A
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735550182; cv=none; b=jDHPfwLF0V+n3+k8DVK56/NnYLxDH80qn0Ro6q+8P+zJ85JQe2Q21XNGQBzzFTCNf7n2JWl3ZfKtUyaR3d4dCbKipf14mCGhJ8h+emU7/FzAArFBzLVimVfP5ULSkNZL74k120wL+O3hWgevtca0qe1pc7zC7egIJI5XcIzfFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735550182; c=relaxed/simple;
	bh=3qODcbNZ9AfJhi+zcpWmfpiC6gLRfZWraqL//SJt5Es=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fDA53TNVCiTH3nT0kFsJan/LNFVzstAA6TOLOLTXM2a0Y7FssGXq9gsoNRcWFRrojkU0YLgzF6Pc+AecgpAm0Cgp8ieE3KFmwvy/3JfXpuYyjvXmt6PKqRg/Ju4X7TwgNPRZy0YgpKyzUMZfWaJG0XEOH2rrwyHrQPTr2QJd6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRDpcHQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE198C4CED0
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 09:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735550181;
	bh=3qODcbNZ9AfJhi+zcpWmfpiC6gLRfZWraqL//SJt5Es=;
	h=From:To:Subject:Date:From;
	b=FRDpcHQGPQKWUwa4koRhyn0n8zBe4BTgO79ODudzgvAar6SPOS+5HKmECqU+btpD6
	 Glw3SjaR8XxE/gHCZvjCc3tZ8pL5etJCV2m96pIXIzToY3sVbkffU80mzgQIV+Zl+s
	 pMbYcdBVVKlPA6wV37SdLv3s3Wwr9nPcTc7RlRWHYi8yW+K8qXe1yMSzNCAqMenGFi
	 An4CtSB9xTtHN4dkGeLsXTM64LD5vpQmAEIpITpTYq1pNSZxREReqjr7XPq4Z362tg
	 sc4AA3ldFw2qs69hiFvnpy4IZdmEqHdNx22FdM50Dfqp/uPpEGCDhZWnkhpsBCe1ps
	 5+thVzAnWSPGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C80C3C41613; Mon, 30 Dec 2024 09:16:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219640] New: Preferred cores working incorrectly for Zen3 CPU
 (regression)
Date: Mon, 30 Dec 2024 09:16:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sobrus@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219640-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219640

            Bug ID: 219640
           Summary: Preferred cores working incorrectly for Zen3 CPU
                    (regression)
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: sobrus@gmail.com
        Regression: No

Created attachment 307415
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307415&action=3Dedit
Outputs comparing affected and unaffected kernels

Hi Kernel Team,

I've noticed a preferred cores regression while using most recent CachyOS
kernels on Zen3 platform with amd_pstate_epp driver (5950x, amd_pstate=3Dac=
tive).
Regression is clearly visible in ryzen_monitor when running low thread
workloads - instead of sticking to best cores, it chooses the cores randomly
(?) for each subsequent workload run.

CachyOS team developer has bissected the issue to commit
39311a230e04eab2fe7e257ad79922040bfdaf1c

Original CachyOS forum thread:
https://discuss.cachyos.org/t/preferred-cores-stopped-working-for-zen3-cpu/=
5108/6

Steps to reproduce:
- use ryzen_monitor or some kind of system monitor to see which cores are b=
eing
utilized
- run =E2=80=9Cstress - c 2=E2=80=9D or other software causing low-thread w=
orkload.
- observe core utilization, frequency and consumed power

Below I'm attaching detailed commit info, output of cpupower frequency-info,
output of amd-pstate-triage.py and output of ryzen_monitor while running
"stress -c 4" for both affected and unaffected kernels.

The differences I've noticed are:
- affected kernel has ITMT:     Y instead of 1
- affected kernel highest performance reported by cpupower frequency-info is
166 instead of 196.

Hardware is Ryzen 5950x, undervolted using per-core PBO and voltage offset,
limited to 4750Mhz and 80C, AGESA 1.2.0.7, chipset B550.

Commit info:

commit 39311a230e04eab2fe7e257ad79922040bfdaf1c
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Mon Dec 9 12:52:34 2024 -0600

    cpufreq/amd-pstate: Store the boost numerator as highest perf again

    commit ad4caad58d91d ("cpufreq: amd-pstate: Merge
    amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
    changed the semantics for highest perf and commit 18d9b52271213
    ("cpufreq/amd-pstate: Use nominal perf for limits when boost is disable=
d")
    worked around those semantic changes.

    This however is a confusing result and furthermore makes it awkward to
    change frequency limits and boost due to the scaling differences. Resto=
re
    the boost numerator to highest perf again.

    Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
    Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
    Fixes: ad4caad58d91 ("cpufreq: amd-pstate: Merge
amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
    Link:
https://lore.kernel.org/r/20241209185248.16301-2-mario.limonciello@amd.com
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

 Documentation/admin-guide/pm/amd-pstate.rst |  4 +---
 drivers/cpufreq/amd-pstate.c                | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 13 deletions(-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

