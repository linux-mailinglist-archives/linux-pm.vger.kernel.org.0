Return-Path: <linux-pm+bounces-2395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE7832F2B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 19:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEF01F26410
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10A4CE08;
	Fri, 19 Jan 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZOB3oBH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0EB3C6BA
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690123; cv=none; b=gU7T26IQPIncFxhVNaxki30NyTtphaQmW5etIH5GPU1J0Xrw1+xI3ZVgpVQa94k7drI8qDrhcD3YCYwyv9RfLxlwPLYIwqyY9RjcFPMDgXFGTwjgrHn+lzER1qb/+wVrMCKXLUTMvq81HBHk3JCrWuh6oXjVUlb0RuXtufrQcxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690123; c=relaxed/simple;
	bh=36fVe22cfgjXKvoI4HecFvXQZyekC1xRfgRaDJpBKkk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPbO/RqrOJQrOqk0a+nGuVIWGDwHQFZoXfevhE5BnXvkutiEhS2qwzlh0BSTCd5VBiCv1EXUTkpk9Rl3/tLthiEVl7cv0uL6m+DB0vaT0Px3bGiHxdOTqkZkPOjPEyQdjCth0/UsrlRWRmj6SmwwH7284F8pa/SWh1Wa+ipaxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZOB3oBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2AAEC43394
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 18:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705690122;
	bh=36fVe22cfgjXKvoI4HecFvXQZyekC1xRfgRaDJpBKkk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sZOB3oBHzVJvpNJI2tv3lMh/v6iuVtfX0JR8DSSkOFnfkPd52G0FrCDKN9cqgK4Ux
	 plBr4XNsMb61b0zRROSKEpwZKsa7QcQvBzDjTCaL+TulocGLP/cMdkyJZfhJKPDSyg
	 j/bGSbYAFG9gHLBgAlo7pVp6OLPm+ZQ7zJSf2xyuPoYKxyO35/mCPh/DMbbgFDCrIn
	 oNNkbJ3X5HdOmJh8WKbhmlwHr7WD/LLemjafakp+sggJLQ3b1BYGaJgyAdfdNs93ah
	 XnCZ1vab3/sLROHIunbeuVISoY5ho29em7DCEzKRTjJ+1t/TJs47oLgG7k7N91Jchb
	 3/Lh57AMOIFiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D0D48C53BD2; Fri, 19 Jan 2024 18:48:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 19 Jan 2024 18:48:42 +0000
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
Message-ID: <bug-217931-137361-S8jNmMRFyX@https.bugzilla.kernel.org/>
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

--- Comment #31 from Pedro (voidpointertonull+kernelorgbugzilla@gmail.com) =
---
Not sure if related, but apparently a bug was introduced back in November w=
hich
could cause the CPU to be stuck at the lowest frequency, and it was fixed
recently:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Db0d326da462e20285236e11e4cbc32085de9f363

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

