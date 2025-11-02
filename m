Return-Path: <linux-pm+bounces-37252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B0C28A2C
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 07:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A613A5B24
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8907262A;
	Sun,  2 Nov 2025 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svzr873t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B215D1
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762066523; cv=none; b=uS9WoaIf0WOizNSgj2Tfh81wPFKtqWxPoD57O4F9KYKI7ffAdaAjhAcOP0wNrMvXfDklHm0D3leQAU05l0j8Z683GtYUe9cWNYErfcpQ/erYueLBjcRE06HiwBvBF51PaLkHEd6N9GD+POOY49YNXpxcMNdZLIfebfFZNqY+3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762066523; c=relaxed/simple;
	bh=tBYnTGyH9qfXFlc8Aao4j3dp21bBQ/38W4gFxr38L7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKY/FZlh2ctEV/3GUrj0rN7HYZmdSrV1MUaGpjH6JBW2pDC/J9kgQPGs761kO4sics6u0l9a40o2BK3B9Fqqd9qq8MvLLr2+gp9BLyhTkaAyhlt/IfY1IT3NeTEKPSci2bUh5fQgUQigixPkwrK/1mrn4XRRuh43gNoCyFbesQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svzr873t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ADA2C4CEF7
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 06:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762066523;
	bh=tBYnTGyH9qfXFlc8Aao4j3dp21bBQ/38W4gFxr38L7c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=svzr873tOdvFdAgL2DMSX0Yug8I0NIYWUxAEUVU791aGOQ/ULEI8FyrAXbuBXuR1e
	 /CtCnWY4QmzrHpmO7/O8vuShyCnYD/XvAngmFLNUB0o1UQgC+d3xppCHnp1sEKy8cm
	 4w40+7Bc5VwJ6fRufKojBp82e5dH0JZU8anZcpEoYva8d7w00145njowWjQ8L8wQVb
	 p3trfOaoTWQD8JA5fSRAM+tzW4RUZ5rkmLF4EqOveWddj9yfgtKe4rNnuS8A8b2XA/
	 cZNLDE/3bVYAj/DZTXQtUczcPRqlutJ6nNFa15j8j1PQSxs1l3M+wp3IzjH6K4x9CG
	 2GRjTqfTK0Mww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4EFA8C41613; Sun,  2 Nov 2025 06:55:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sun, 02 Nov 2025 06:55:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-QIx3MqF8Jv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #8 from Chris Harris (chris.harris79@gmail.com) ---
Thank you for the continued engagement

1) Good suggestion to test removal of 'nosmt' in the presence of
'amd_pstate=3Dpassive' on the problem kernel versions, results:
In the absence of 'nosmt=3Dforce' *I am* successfully getting the "amd-psta=
te"
scaling driver.  In the presence of 'nosmt=3Dforce' I fail to get the
"amd-pstate" driver, and instead receive "acpi-cpufreq", along with the err=
or
"amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled".  Th=
is
behavior of 'amd_pstate=3Dpassive' failing in the presence of 'nosmt' did n=
ot
occur on the kernels prior to the commit identified. In my view, it does se=
em
to be a bug, as one should be able to achieve both 'amd_pstate=3Dpassive' a=
nd
'nosmt' (as I have been on kernels prior to the affected kernels).

2) I can confirm the Ryzen 7950X is affected.  I primarily tested against
4484PX on seven identical servers, all which behave similarly -- the logs
shared are from one of these servers.  I did a sanity-check on a single 795=
0X
server, which as I said was also similarly affected, but I did not share lo=
gs
from that server.

3) LLM: I'll test this patch shortly. Based on the findings from question 1=
,=20
this makes perfect sense - the issue is specifically the interaction betwee=
n=20
the commit and nosmt=3Dforce. Your patch changes the loop to check only ena=
bled=20
CPUs rather than all present CPUs, which should skip the disabled SMT threa=
ds=20
that don't have CPC structures initialized.

I'll apply this to a current kernel (6.11+) and test with both:
- amd_pstate=3Dpassive + nosmt=3Dforce (currently broken)
- amd_pstate=3Dpassive without nosmt (currently works)

Will report back with results tomorrow.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

