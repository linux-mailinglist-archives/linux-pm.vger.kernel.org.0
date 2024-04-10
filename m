Return-Path: <linux-pm+bounces-6157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D140C89EBDB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B244281BB8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA9813CAB4;
	Wed, 10 Apr 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnUcrVwf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E613C9A5
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734004; cv=none; b=UT2dnIjHDHgAjjjx1ZBFu5mhgPs/9sWHMcSJYuEqu0oieXCJYJXtbJY9GLqtR6HRBgIkl5LZo5xRzhOhDA0Ikc/E7ZkGpwVnlmObDGNitmn+4I6GUUF2BQ/hDJK60y6SklpaQUHOtD6z5gGIZ1n+GLNsXyFJ5pDv0pcO2UIlvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734004; c=relaxed/simple;
	bh=BtkxTmkieod1KMIm9FCqzFADgcLs456k9ruiBkF+a64=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmoodPd/iZxB6ZcPv3eKJxZSmqSNP8WD8j974RYKrOfVHGbvF/olFe/AmDq7f0j2dxbX3OQlCNh5Y6b313ZFT55cULX22bvfbGpWAnLJ3yQvBx9IjZkwUpO2k2NJTAhxIowpO0DeY30ja0uslgl5kALofhlaksm3CPdbAvYxOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnUcrVwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DEC9C43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734003;
	bh=BtkxTmkieod1KMIm9FCqzFADgcLs456k9ruiBkF+a64=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CnUcrVwfV7DbRbPdV1BUdUl89vnmvrWJFZULGekV9HHLXOomp/Hg943aSmNUyF/50
	 V54iUxUSFQYrDWC0zpagI2qqqE6yvhC3U+3Tj7HLSA3pv5v4eHc3lSeKZwvPyNm+FU
	 PRYW0Iq1Zd38xuKxaJUcEGsTKBvgfTzDTTLb4maTch29BNQ97jBYoP0RXgSpEa3BLy
	 HjZ6P3MKmAueKRD8owF+wN6YVnqh/qSqk+4kQ5Ju1Cb67/gBLQGCSkOiZsoNyawKSv
	 5CHnEGQPo+5r4HX9jTLdT0Ma1oupfgIVY4v2OohWUKh/yO3FIjwIjruJVb3qab4kQ/
	 L+o2gVvBldDjg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 78E54C53BD3; Wed, 10 Apr 2024 07:26:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 07:26:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-9BLASJuK5o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #22 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to al0uette from comment #21)
> Thank you for all of your help. But I don't know how to contact with ASUS=
 to
> request new BIOS, can you please tell me how?

I guess you can get contact window by searching the "ASUS Support" or servi=
ce
call/asus contact support something like that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

