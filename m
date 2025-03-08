Return-Path: <linux-pm+bounces-23672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B3A57A3F
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 13:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0199C188FC60
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA661B3943;
	Sat,  8 Mar 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcSbrcw1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357611B0F3C
	for <linux-pm@vger.kernel.org>; Sat,  8 Mar 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741438326; cv=none; b=t/c4DtdszUFCiutgRhF9PD+8RD2GppyCx8knRIymK+TYxSjhwhICJhrkgG/Fi6Sgw/IWOX3Q7lxr9wmAHF0+vDJ/it5wB7ccgChJ1MStt/6s55FcE9kv2o1SmQaoiLq5vR6EeYkKonaHEHMXzhAs0SRd9BnokYcjKKkDHMmg3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741438326; c=relaxed/simple;
	bh=K8qwlIF4XOWxn663TE0U+F7BeEX31k8/lRG+FVMm6bQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lQyqdODNyRUxFQzHstpkpAjuvR2JVS/9Mn80VauPRhDgGMvoAvKbuxNAnRfPGPzvrEJ81O3yWPzXvLCBg16GLD6Y0q8PK2FyZbuUEzgqZqn7unoLtY7pJIoWAx5o6YV/MA/L380dNb+xJnBbmdZsC8gUie+GGxWpQwpwb94xnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcSbrcw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E3EEC4CEE7
	for <linux-pm@vger.kernel.org>; Sat,  8 Mar 2025 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741438325;
	bh=K8qwlIF4XOWxn663TE0U+F7BeEX31k8/lRG+FVMm6bQ=;
	h=From:To:Subject:Date:From;
	b=NcSbrcw1TGV8gHYuKt+DQb8/Fgos1CpdDn5m3nzEl3B+PewE3lYpF/b7gYWJj6x7a
	 0q7u59C6nx23kvPOztDasmzpfQEt8lZLikexfDKXsa/KKiZmGKSJN1wgMKblcw5EzK
	 /eAkYxqccnhnW8naCd5KEE9B+MjTVc3SAwJ7xle/OCutCyk2mZWkEnzpsXTLrk9bQV
	 NwBcOLUaMJOgpeUBzBakQTnhYzJsjGws6jtkp5fHB1lIsvJyase/C08x6aYTN/Opu2
	 4fWnKseU7aiB3bQf2/d45fTwkTWJcvGUSC65wUYbMNPH6QiYLRNXaBd9m2G7Bo1yiA
	 8gVyZ1fSwJ/LQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7DCBCC3279F; Sat,  8 Mar 2025 12:52:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219851] New: [amd-pstate 6.15] Frequency Scaling Will Not Scale
 Above Lowest Non-Linear Performance on Ryzen 7 5700U
Date: Sat, 08 Mar 2025 12:52:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dnaim@cachyos.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219851-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219851

            Bug ID: 219851
           Summary: [amd-pstate 6.15] Frequency Scaling Will Not Scale
                    Above Lowest Non-Linear Performance on Ryzen 7 5700U
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: dnaim@cachyos.org
        Regression: No

Created attachment 307781
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307781&action=3Dedit
amd-pstate-triage log from bad kernel

On a kernel build with 6.15 amd-pstate material taken from
https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/tag/?=
h=3Damd-pstate-v6.15-2025-03-03,
a user noticed that frequency scaling will not scale above Lowest Non-Linear
Perf. Git bisect shows the below as the first bad commit.

620136ced35a9329f4d1ea90e51bee2dfd7ee5b0 is the first bad commit
commit 620136ced35a9329f4d1ea90e51bee2dfd7ee5b0
Author: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Date:   Wed Feb 5 11:25:18 2025 +0000

    cpufreq/amd-pstate: Modularize perf<->freq conversion

    Delegate the perf<->frequency conversion to helper functions to reduce
    code duplication, and improve readability.

    Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
    Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
    Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
    Link:
https://lore.kernel.org/r/20250205112523.201101-8-dhananjay.ugwekar@amd.com
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

 drivers/cpufreq/amd-pstate.c | 57
++++++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

Attached are amd-pstate-triage logs from good and bad kernels. They are not
necessarily equal because a revert of the bad commit isn't trivial with the
whole 6.15 content so the "good" kernel only has patches from Dhananjay's
series and the bad commit reverted.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

