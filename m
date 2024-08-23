Return-Path: <linux-pm+bounces-12844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8C95D646
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 21:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72A81C21239
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 19:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8A1925BC;
	Fri, 23 Aug 2024 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk2vtveq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C073A8CE
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443002; cv=none; b=U17a0OuTw6hgsGY+VI544UOKeJuT9PW7zO3ddAQ0aK10mvI8DUCkmI7w6Hx2IbxJeXUOZw9aHquTMrR49nTSLkN/a0kyrdOGYFDeTTMtV0AH0LnHBB6AMo7+Vd1vyJRoWg/VuEglPayy5WBxxi2eO+dwkhpY+oPwRj2QmPZOeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443002; c=relaxed/simple;
	bh=2W6O9HPeZVEgziQgJw8F/zHfGLBge0DRf5JDyZ+Z088=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WgnD9pG27Tv8rYKiVtvOVoj89a78wUe0PAsoDe6Qjrkb5T3GFFcqar1jEaDrpQ4Soq6TaI7crJd9z23OR6G28GuGqLgojtDp4JqVM3f+mHYPyDrLTrW1FVy2K/6jLQZ3WZLfecRkGY10IMOpok9YC7f/ygfj40lQVL7xL+2PO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk2vtveq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2983AC4AF0C
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724443002;
	bh=2W6O9HPeZVEgziQgJw8F/zHfGLBge0DRf5JDyZ+Z088=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mk2vtveqwGUwTnrQni6W6o9I/aatqOiMEhIeVlWybYxO+AEeh574A1HOkjD0PzXZE
	 b1m6G9d/GUf9u2JIp3c9cRoR84Bfiw/HpG6bjV8meRhtC4zGpu455q1uaLaf/0cfRC
	 FN4OflkzohPKo1lE/E6JSUIqcQMbTFCz+4kVPj2an6sI9QdQgCP0+jH2tRjr/aBbuL
	 DtJGZLFUyS0fpViDVcc+uEQb7w1PFpOPkK35Vn5EhrHyi2HDGi++sRsKxg5xOHj3za
	 71ir+8h58iz7r3IeqV5yru61lVCjSjD576UrS0W/QPSBSgSqoDhWPw+43/gOZfCLfr
	 rKr2JcLrvOCuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1811EC53B73; Fri, 23 Aug 2024 19:56:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Fri, 23 Aug 2024 19:56:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219110-137361-78kLfOBEOa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
It's easy to reproduce by e.g. watching YouTube VP9 1440p/4K videos with my
Ryzen 7 7840HS with HW acceleration on.

Before suspend:
performance -> ~15W
balance_performance -> ~8-9W

After resuming when it's set to "balance_performance" we are back to ~15W.

Setting it to any other value and then back to balance_performance fixes it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

