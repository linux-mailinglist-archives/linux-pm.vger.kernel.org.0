Return-Path: <linux-pm+bounces-2396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D53D832F4E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 20:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673AE1C239D1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B154F9F;
	Fri, 19 Jan 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCPwLA7n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAA55E4A
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691484; cv=none; b=CuiG0ZQE0vcs60zFSoF79lfk8WvwS8rlMWMwd5ZYnLXZBW21aEyEGuFiMBKEp+jui9XuunUy4sPMcaxUg/83INUX+2lmUqdHQzDQyt2+mYYUgwwFvRaHNR7ijgsbGFikzv5imtL7ZJa5h5mpCQtpsH0J00ttQlZJRqWgZif5Iw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691484; c=relaxed/simple;
	bh=sp5trtM0qverWrfafpdw6vsFym1f+ikjYbtv6H6V3rw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPfX5EAtVG2jq6YiorMGRopdXSpfrKpLxgZmtGx2YFJshBlzy/+eZajqfLMFgrrV4Sv9pCQ7yggPq59okycCTxDSmUPsjEOxWrZziDAMYojInFVLJJ7q5fZ6ppU4Jn8KiKoJuMFrX/JrY1SSEkIMr3rT3Qsmfa+f7tg8GWMl6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCPwLA7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F662C43399
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 19:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705691483;
	bh=sp5trtM0qverWrfafpdw6vsFym1f+ikjYbtv6H6V3rw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GCPwLA7n3n2j7DRrUWfKKUfPD/mv+1AXPV6BgfwidDqYP2fOFEM2rdTWtZkkXIb4Z
	 nlMHGFIr1vJ+LgxzsIHslY7MzF09w5/5UKdmulozdj0ZkazBE/ix5Lsg4L85Dc2emA
	 auiLdKRqKUwRgFA1FUIuOVM5e/5IZmbKj3t3Sg0eaQ5g7v85J6ltiveJ4PmZLNBa8R
	 ZU2xJHGDT/4mNU4UdeqdLVXPC65VkhUSYoOMuKM5LsfPobhbT1IB0Vudlg53b42Ip8
	 SqsnwUCN/wZSE2nsBgKu4NHa1l+pbjBt3Cl40HTrZdt5JQYfBO3XG3bEBIA8uLiTeW
	 pK3SGbwTb3XKQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8DF8AC4332E; Fri, 19 Jan 2024 19:11:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 19 Jan 2024 19:11:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-x4dyfDSXd8@https.bugzilla.kernel.org/>
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

--- Comment #32 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> Apparently ryzenadj directly communicates with the SMU without using an
> in-tree kernel module to use an interface blessed by AMD, so that's highly
> unlikely to get support from them.
> Recommending reproducing the issue without using that at all first, it's
> going to keep on getting the blame until it's proven not to interfere.

Yes please do it without *anything* abusing that mailbox at all during the =
boot
(like ryzenadj or ryzen_smu).  It's entirely possible that another piece of
firmware fights over the same interfaces or data structures and that's part=
 of
a problem.

It's also possible that attempts to read information using that tool
unintentionally causes information to also be written (as it's a reverse
engineered tool that uses an undocumented engineering interface anything is
possible)

The simpler the reproduce the better.

As I mentioned in the other issue, to rule out a kernel bug we may want to =
look
at the output of these MSRs while the issue happened.  If those are correct=
 for
what has been programmed to scaling_max_freq, then we may be dealing with a
firmware bug.

#define MSR_AMD_CPPC_CAP1               0xc00102b0
#define MSR_AMD_CPPC_ENABLE             0xc00102b1
#define MSR_AMD_CPPC_CAP2               0xc00102b2
#define MSR_AMD_CPPC_REQ                0xc00102b3
#define MSR_AMD_CPPC_STATUS             0xc00102b4

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

