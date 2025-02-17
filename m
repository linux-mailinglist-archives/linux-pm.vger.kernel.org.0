Return-Path: <linux-pm+bounces-22228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC7A38B71
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 19:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277957A379D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199F235C03;
	Mon, 17 Feb 2025 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUruOurW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72718BBB9
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817896; cv=none; b=sjJRvuG+iq9/AVpdnY01CE01Yabt3EfEpwogh6bAFQm3a9nmnyahdjLdLuIIAL6iuitRl0F4EaUXxUH5fqMKn9LHxItv8EoB8KEfbpjB1iY7eJy9mqMXuQ1NJ0TLjyKDZboKdnmZZ4Erm4yKqV+b+D8GO6Qkw3YHBPgQI7Vo6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817896; c=relaxed/simple;
	bh=OnO0IiJShPS7E0e5CrH2/sJIvBvTfQ7NgzmYW7dJ7jI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+jBpLqOaMrLTnO1kYumjZLSHv9xIwhtPETPL+EaN+uxNTwXkjcQfMpx67fEZT8K2mQ4w6IgPFLC67y0iieGPU7Yq479fszE2p0hxlSOBaETarz4Udvb2vKvHy/ogIaNbRIchOahv0BE2RqD9sWOwsFbiOpDpFG0cQMITxFBZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUruOurW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABF51C4CEEC
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739817895;
	bh=OnO0IiJShPS7E0e5CrH2/sJIvBvTfQ7NgzmYW7dJ7jI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nUruOurW+xtF3JBbqQCBPHfPZemyHNFxiB8zmmHGwoLsuIlVgFepWt/KNelWHp0X9
	 DOA6Nr0w1n+Va5sXvDkcyVyBVCu/oiE/dNBpg9epCpIGSQsDmTEPseenl/RzXRgnQY
	 7P7NM8HbLHeMd79G5kWaUUtOSyu1YO1C2anpYpi7Fu3fB7W7mRj2lrFpNYOy6Bgg5h
	 0sbfFatWJm8F4H1vZg87ScphOchZ9AgAkvJCVBZpcu2vRHDnX81C4rObv1uRzmZqLy
	 MFNiNqEdwWfpCluElmMZXirX2hIi+4sS59CxPmJhB/o4hxejjXJYgpTsN7gRB1bTKi
	 wqUggdazxGwFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A6383C41614; Mon, 17 Feb 2025 18:44:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 18:44:55 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-R6k6ixULem@https.bugzilla.kernel.org/>
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

--- Comment #70 from Miroslav Pavleski (miroslav@pavleski.net) ---
=F0=9F=98=85 Um.. yeah, I was using modified ACPI to enable S3. I did that =
because s2idle
was freezing either on suspend or on resume in most of the cases.

The modification was done as documented in **S3_Instructions.md** in the
uploaded **2025.02.17_Report_Miroslav.zip** .


Now for testing, I've removed the **acpi-cpufreq=3Ddisable** and removed th=
e ACPI
modification.

First attempt of sleeping, to s2idle - System frooze (never turned fans off,
never got blinking power led)
Second attempt - same result
Third attempt - It went sleeping (fans off, led blinking). Did not resume, =
got
stuck.
Fourth attempt - It supsended and resumed ok.
Fifth attempt - On the same boot as the fourth, froze the system again, nev=
er
reaching suspend.

In all cases where it got stuck I had to power off using holding the power
button.

I'm attaching the part the first two attempts journals.

Also I'm attaching the results (**s2idle_report-2025-02-17.txt**) of running
**amd_s2idle.py** with unmodified ACPI, so with s2idle sleep.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

