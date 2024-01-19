Return-Path: <linux-pm+bounces-2361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A78324D9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 08:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D661F24A7F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B97484;
	Fri, 19 Jan 2024 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZwVrgBR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48515CA4A
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647931; cv=none; b=KVTQ8MoVd33zK7ph6ONyswiPJBZiprgeH/63+eF/FjIeeNQ1MZbtj8fGF0p0blAoOyidTzD1Q5hf72f3Fsj1s0QNdezwDWMJCbz87o7ukIa3jWRLdDzROjnHHOTr7dykJIx1NwI3blyFiYhlljXDB4D5Vgj18uwtpfSDYWpYpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647931; c=relaxed/simple;
	bh=um8dSwr13hfIUir3EoU9soEp6ZePZOivH5CX24gg3qQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R+ugNw2Nd/k0SoLgRfD0QS3Sn12M2xtq0bFEjQOMzRe2xe6vS11yXhgouUVwVExoYTF12Q3+g9GloBNK3nDsEe9jhjZbW3WhJDQsy6kC6a7g4lvvtvD1WEal5MAWlxbiZRQgR17c2lGv6qtOBKiuV8KCz8cfFaFLayxlVcqXbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZwVrgBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF555C43390
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 07:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705647930;
	bh=um8dSwr13hfIUir3EoU9soEp6ZePZOivH5CX24gg3qQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MZwVrgBRhq84jCnJetfbg4VDMzAYrT4bTlbQ7GIsg4BHb1EB722Qtq/ZDvS6W/0BN
	 Ew9lXuCP2oAMCfhzbDqi/q+HO0/UnJm8TMK5MNFVZflNor8jTcNNpTf5UUo6NKW0So
	 P7llRJbzHAO3MRq+MSMAsNkgHiDx4l9s6QGif2znhKlWDTxHVkP6BFfEdSZNssdP+8
	 2PDJ9NOAjMX2NYAOwZOLWJ8gKorJzs8LIRbQtFLLdHVcHz562Lr7XwxTN5xzbLS5du
	 4/iVx+szdWeHd0H0xNlNsCI1Zh6ngh8sMnPGUzANo8YCohp0OAd3+RFsZwfccWbWd1
	 9+57U2kyFaLeg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AB859C53BD2; Fri, 19 Jan 2024 07:05:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 19 Jan 2024 07:05:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: voidpointertonull+kernelorgbugzilla@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-gEZ0ReNNpP@https.bugzilla.kernel.org/>
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

--- Comment #30 from Pedro (voidpointertonull+kernelorgbugzilla@gmail.com) =
---
(In reply to Mario Limonciello (AMD) from comment #23)
> 6.7-rc4 was /supposed/ to fix the kind of bug that Pedro described.  See
> this commit.
> https://github.com/torvalds/linux/commit/
> febab20caebac959fdc3d7520bc52de8b1184455
>=20
> There must be another problem though; I wonder if something isn't getting
> flushed out still.

Figured that was for getting the functionality working at all.
There are only 3 relevant commits in 2 days, and one from that is only a vi=
sual
change. Before those the functionality simply just didn't work at all, and
after those apparently the silly behavior described is easy to reproduce.

(In reply to AlexDeLorenzo.dev from comment #29)
> It happened again ~90min after doing a `systemctl kexec` and using
> `ryzenadj`, so I can better answer your questions.

Apparently ryzenadj directly communicates with the SMU without using an in-=
tree
kernel module to use an interface blessed by AMD, so that's highly unlikely=
 to
get support from them.

Recommending reproducing the issue without using that at all first, it's go=
ing
to keep on getting the blame until it's proven not to interfere.

Do you happen to know such tools for Raphael (7000 series, Zen 4 based
desktop)?
Investigating silly memory and/or IMC issues, was happy to see ryzen_smu
reporting a whole lot of relevant info, but then it turned out to be abando=
ned,
and forks claiming to support Raphael don't seem to target my root complex
(PCI_DEVICE_ID_AMD_19H_M60H_ROOT).
Worst case I'll make a Windows setup and check the tools there, just hoped =
to
be able to avoid that. I hate BIOS "Auto" settings with a passion not even
showing current values, and the CPU's memory controller seems to be quite
finicky.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

