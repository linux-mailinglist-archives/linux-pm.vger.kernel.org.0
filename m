Return-Path: <linux-pm+bounces-22234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE2A38D0B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9B1188D96D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 20:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3A22B5A3;
	Mon, 17 Feb 2025 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlK/ERDj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869A13AA5D
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823077; cv=none; b=EZ70tcSDU/WON7C1O0c8bRaIlJPXVztd5j2hC14AQ8qTcESfkDYH9/IDwa6yfZIqXABpineDryktMCFdhCLkJ5YmjD5E2aJbB8Yk80Ul8A9t13wtVIOcwQE4Si2D7Q0+OFGIV5nucfIElmTyJV0CRIB+3e9hh/QTppVpKJ2Xta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823077; c=relaxed/simple;
	bh=9Ii4P30d9LDAzOkQd4hJ8Te9yTxuu9uVX8GBjDUPrf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIN5sW2T7m9q+TlsADMbK3OGjIsXCOLWYxtL4V+pUZJkss6mu7dPk8jgEibpkiXF9B7f14PKdQ05O0C4yzG/aHxwsk6zpy0qQA7L9NzVlktKqlGFd/9h/z1otXDAow3Bnd2fD7v/7N//z6ExWamEG+FMCSURiauscEn+gjP2qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlK/ERDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B3ACC4CEEA
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 20:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739823076;
	bh=9Ii4P30d9LDAzOkQd4hJ8Te9yTxuu9uVX8GBjDUPrf8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TlK/ERDjrJPrpVAAy8thUXbIqnhQFAjCYkBIRx6eLzqmHY46+2yhmOhHs+89hNJs1
	 0nJ4d9634rwSYTWUnOYDOc3JGOzzWLBi13k0UqFRljD7/K+RKWU3d8f8S9bcfOpiyo
	 CMQmb6KJi/i1PP66RNwK3SMZRppU6WKLkUm2uIIopMYVHhzQqb4C6zQvQeQun2jgyk
	 02UUGI8fQNdxfi7zrw2ywfkf/SgIxkQet7T4U7W4o171Be7SVWYoAhmQK9w1ufL4HD
	 NpPJ7Q8D14aGDFsQOx7pD0xupjjxjWUcihRxKpbZh2KJuX8KxlaoEcZz+jHMZqe7S2
	 yiGx890ic2Sjw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 83B8BC41614; Mon, 17 Feb 2025 20:11:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 20:11:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: miroslav@pavleski.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217931-137361-n6f0vPGkEN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #75 from Miroslav Pavleski (miroslav@pavleski.net) ---
Created attachment 307681
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307681&action=3Dedit
s2idle and pstate reports after applying the 'invalidate cppc' patch on 6.1=
4rc2

Maybe those GPIOs are used on the Asus machine for handling the Hybrid
graphics. I'm just speculating here.=20

The laptop has the onboard 6900HS GPU and also an AMD Radeon RX 6800S.

I've applied the patch on 6.14rc2. Attaching
2025.02.17_s2idle_and_pstate_reports_post-patch.zip:

- s2idle_report-2025-02-17-post_patch.txt -> run after fresh boot to 6.14rc2
with the patch. Suspend/resume cycle worked normal.
- rebooted
- amd_pstate_report-2025-02-17_post_patch.txt -> run after fresh boot
- s2idle_rs2idle_report-2025-02-17-post_patch2.txt -> succeeded suspend /
resume cycle
- amd_pstate_report-2025-02-17_post_patch2.txt -> run after the resume

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

