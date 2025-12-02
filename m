Return-Path: <linux-pm+bounces-39106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E645BC9D0AD
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591313A2D5F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B22F8BD2;
	Tue,  2 Dec 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpzfHEiE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F6C2737F3
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710310; cv=none; b=f5nRPCT5RxKGaquV2SD9XQP+9iVbg3aGF4absrfzXf+NV+UjF2lxE5jPDuvQXS/kxHEnLqSx0t3qxNHeN05RHl6GqKvX8GjW9kVlHBLyD/roYL/CqMMNv+4y0Y6A45dXC/68PSJAYAAyuLwfeoeZWWj+LNj4VUaKRqMW3OWvChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710310; c=relaxed/simple;
	bh=i61XAwNuMKwisx8NtooE4TUiCGeQpb0YlglZy3hgY1I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U4rIAULQWeVqgK5HhWkcXxSSiJjSlviUnIDwo0mSEyhO1GX9Refgj7VJU760iu76DaWCPypwEYanwuS8uClvW4agdCW2h9Jut53y4ulD5amAtQLaiHXnQ/jx4hKRFKn5EFoYhVtBLBcU074nP3G27iS1HnNJOgRDNyX33okL48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpzfHEiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AF4C4CEF1
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710310;
	bh=i61XAwNuMKwisx8NtooE4TUiCGeQpb0YlglZy3hgY1I=;
	h=From:To:Subject:Date:From;
	b=YpzfHEiE64qCMU6d/1Gbox/fbcMPQ1K7hCSWsaX/eo+mPLh2s95Em88D0g2ZzJnzI
	 H0n2C0wKrucaOGAp8apKUVXTwK8HBK5VFMGVqNP3pze4vwo0pswZHBcolbSVGQy4Jx
	 QmtEDooptwvyKNB6U1ocECSDGXLliCaFWPuf+uIwy19DTf0ROrxCwzb8qpRW3REj86
	 CscIIGuCXPEdWxCjqj5JboHsTwJQT6hPTV88qH9YePfDZIwrCJ3TlVURCKF/5g69H8
	 rligHsTePaHPe9y1lyZEeDJDwNy9VDQIZhGzrDTyPK239Jir52tlYrOgXrNrX+u5At
	 7q+pfKRqCw3uQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/21] turbostat-v2025.12.02 x86_energy_policy-v2025.11.22
Date: Tue,  2 Dec 2025 16:13:18 -0500
Message-ID: <20251202211824.321697-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is staged for upstream in my public git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

In summary, since turbostat-v2025.09.09:
    
    Add LLC statistics columns:
        LLCkRPS = Last Level Cache Thousands of References Per Second
        LLC%hit = Last Level Cache Hit %
    Recognize Wildcat Lake and Nova Lake platforms
    Add MSR check for Android
    Add APERF check for VMWARE
    Add RAPL check for AWS
    minor fixes to turbostat and x86_energy_perf_policy

Please let me know if you see any issues.

thanks!
-Len Brown, Intel Open Source Technology Center

----------------------------------------------------------------
Emily Ehlert (1):
      tools/power turbostat: Set per_cpu_msr_sum to NULL after free

Kaushlendra Kumar (1):
      tools/power x86_energy_perf_policy: Add Android MSR device support

Len Brown (17):
      tools/power turbostat: Regression fix Uncore MHz printed in hex
      tools/power turbostat: Add Wildcat Lake and Nova Lake support
      tools/power turbostat: Refactor added column header printing
      tools/power turbostat: Refactor added-counter value printing code
      tools/power turbostat.8: Update example
      tools/power turbostat: Refactor floating point printout code
      tools/power turbostat: Remove dead code
      tools/power turbostat: Add LLC stats
      tools/power turbostat: Add run-time MSR driver probe
      tools/power x86_energy_perf_policy: Simplify Android MSR probe
      tools/power turbostat: Validate RAPL MSRs for AWS Nitro Hypervisor
      tools/power turbostat: Enhance perf probe
      tools/power turbostat: Validate APERF access for VMWARE
      tools/power turbostat: Print "nan" for out of range percentages
      tools/power turbostat: Print percentages in 8-columns
      tools/power turbostat: Print wide names only for RAW 64-bit columns
      tools/power turbostat: version 2025.12.02

Malaya Kumar Rout (2):
      tools/power x86_energy_perf_policy: Fix format string in error message
      tools/power x86_energy_perf_policy: Fix potential NULL pointer dereference

 tools/power/x86/turbostat/turbostat.8              |   27 +-
 tools/power/x86/turbostat/turbostat.c              | 1205 ++++++++++----------
 .../x86_energy_perf_policy.c                       |   47 +-
 3 files changed, 660 insertions(+), 619 deletions(-)

