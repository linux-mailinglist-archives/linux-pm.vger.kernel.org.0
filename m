Return-Path: <linux-pm+bounces-22264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E1FA38E53
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A63B140F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0231A23B5;
	Mon, 17 Feb 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOrIq/9G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6418224F0
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829364; cv=none; b=rjNkH4Hn7qkMgRUiSi3kJfrBvH3D502O5ZUO/AYUowvBnbSgI7FwGUyvA8PY91LbWUusu4KzsRBAbYoVAr2om0vhTMhlMOrBzhY4iyFElryTURbDmsL3w4SXDfY/yFesNTpiGcEBw2j+NUjdEZLn273UMPTSRFadF25907BKVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829364; c=relaxed/simple;
	bh=xPDkc0Z68TIbJMwSByfMVNN+JQCYuYqV/rxTXXuiVno=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rt5qV+KB7MMggA8YXMxSWqgH7lBMeKtU1a9ypR+xTK45vrv8c3YLGMQ4I9CMQ9/oP4+UosAhNyJX2j2o1TDT4CrGDkmfdSVY7x9lXrA6l3IJLxFPhjcYTXgfdDpFTUtK32WrEpSb1b/wRTwjS1qUInKThD6aMavdcmFKmLw+PzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOrIq/9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CDADC4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 21:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739829364;
	bh=xPDkc0Z68TIbJMwSByfMVNN+JQCYuYqV/rxTXXuiVno=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OOrIq/9GHTQmGMZMXS6s8KhkygN+n/zlGiRF7Bps5ie4KPPrngktk07wu6yKa8V30
	 W8MAp3mlsaoHinQSD2SHFLlu71k0ZbpXcJZdJ27+HKATaQeFUl5aUFhigZ4CRN+2m7
	 PPojVaySpQ6jkPXsew6r9FbDsecmaiIfGbwAz8vR/NppkRcigtlYon+Wm5F5oEy59M
	 dWWXgPPXYQDIfbvL+ccjRPUoHdMpns6Hw1Z2dTFF8Z5y9YiMad38/rRgC9o4yndBMC
	 1FOYkFCV0EbEm955FzXtsGapp4sj0CCuqwaSBEAQOqX+DxVmGAEzHNvIDi9OUdsuZw
	 hKuGWX/PU0bpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 26728C41606; Mon, 17 Feb 2025 21:56:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 21:56:03 +0000
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
Message-ID: <bug-217931-137361-lSObpBz2Qt@https.bugzilla.kernel.org/>
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

--- Comment #80 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---

OK great, it looks like the amd-pstate issue is fixed.  I'll include this i=
n my
next patch series for amd-pstate.  It's good timing because I'm overhauling=
 a
lot of this code for 6.15.

Unfortunately; your suspend failure is missing the thing I need to tell me =
some
important info about the failure mode(the idle mask print).  This is the li=
ne
we should have seen printed.=20=20
https://github.com/torvalds/linux/blob/master/drivers/platform/x86/amd/pmc/=
pmc.c#L733

I notice this at the top before your sequence starts though:

> feb 17 22:06:52 greenstation kernel: NOHZ tick-stop error: local softirq =
work
> is pending, handler #08!!!

And that has me most concerned that the kernel wasn't really ready for susp=
end.
 Let's split out your s2idle suspend issue to it's own bug and try to figure
out the pattern and what debug we'll need.  We can keep this one for the
amd-pstate issue, and I expect we can land the patch for a later 6.14-rc.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

