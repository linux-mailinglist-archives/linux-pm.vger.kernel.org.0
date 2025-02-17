Return-Path: <linux-pm+bounces-22229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17791A38BA1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0393163FD5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE2E22DFBF;
	Mon, 17 Feb 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCY4heqb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B42137C35
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818544; cv=none; b=g7SzmGFV7Q4ddYSF1ia2SipW9nSUHaKoSOYNyjcj+IQcSD4Z/F3ZcAYIurbZnCMXrmP3i5Bw7oKQOZFtY1Dy1BC4HEV4VlxSFcy44Hb7CNkvs0Pe3WNo0k97hC1RLDhtpnHeAdUvvPpmvtUIN18wjtYgyVuABjOwwn64rfXKAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818544; c=relaxed/simple;
	bh=xCuRF7VPye7gbRkpHf8CqpTNbE3YfmyRZg9bRKjTOtg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RfTCY62uMqJ4hLP78PCuyv3CoPNAIRsrtcWLCogHfdvwbGfGt4l/JTGPWtF7xMzTKd/ALtjpMcGi4SkdeCIUb55nh8Pjzep898TvVix13Y6wbNg3wj3X1LPbv0GadTmXkw5z579a+UZxdFYhPszjoH2LYvugioQ6gpI6xgPxGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCY4heqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0CBAC4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739818544;
	bh=xCuRF7VPye7gbRkpHf8CqpTNbE3YfmyRZg9bRKjTOtg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nCY4heqbm5lUjnsjpA0i1Uwshu6FrWH7vXYGGRiMMQkoD9H3sqme0il5pCXr6PfKE
	 TVM/M9/hRywuavbJ2cFqWBSYL6Lu1uSCn2G2M2Gmiv5pyGSpMsNwAFeQfUfZ8YBg8h
	 LaQ6zzKi5GYrdedLx1hUrQMk8WR3xkVY1urNot1uZ634deUuuKaVcGEFX0jjziO2fn
	 m6eKPdOzEAkwQOPT8UxTPVK/OQ75DwZ/UlOeenhxzvApew4zXZGOCnSAymTREwEFEG
	 CGo6qzEpweKnOxV27eQgZ7TcN1QONA5jtPYqY/gUtgrH8mDEtz4dm0EpWHk4Tdm1Iq
	 SraqlNcezuzTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E9B0DC41606; Mon, 17 Feb 2025 18:55:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 18:55:43 +0000
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
Message-ID: <bug-217931-137361-CZBjjZziLB@https.bugzilla.kernel.org/>
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

--- Comment #71 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> =F0=9F=98=85 Um.. yeah, I was using modified ACPI to enable S3. I did tha=
t because
> s2idle was freezing either on suspend or on resume in most of the cases.

That's a really slippery slope.  There are absolutely low-level firmware ar=
eas
that aren't expecting an S3 flow that you're going to trip over.  I /suspec=
t/
this issue you raise is one of them.

> 2025-02-17 19:17:25,726 ERROR:        =F0=9F=91=80 Suspend must be initia=
ted by root
> user
> 2025-02-17 19:17:25,726 INFO: Your system does not meet s2idle prerequisi=
tes!

Can you please run it as root?  There are checks that require root that I'm
looking for.

> 2025-02-17 19:17:23,452 DEBUG:        bios_date: 06/06/2023

Is this the latest for your system?  Please check.


In your two logs I see this.

> feb 17 19:01:59 greenstation kernel: amd_pmc AMDI0007:00: Last suspend di=
dn't
> reach deepest state
> feb 17 19:01:59 greenstation kernel: amd_pmc AMDI0007:00: Last suspend di=
dn't
> reach deepest state

In order to explain this I need /sys/power/pm_debug_messages to be set and =
see
the logs associated with it.  Running that script as root should do a full
attempt and set /sys/power/pm_debug_messages or you can manually do this and
share the related dmesg nearby.

After that attempt it looks like there is a series of failure to recover for
your system.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

