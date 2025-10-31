Return-Path: <linux-pm+bounces-37156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C75C2338C
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 04:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 291C44E3137
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 03:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB5281504;
	Fri, 31 Oct 2025 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2iW+lV1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0E17A2F0
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 03:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882958; cv=none; b=HPQZvnk122RuzTZQhrMsHiQCjBXWprVCV/ZuLg5ne1ytFFJ+yWakz1HMG5grm8fr/3pEv80DDeuV9pVsRyFdtfJMaMwMp4Y5+zgLhCb41jin7lVH0KQIJzHdRdJHmY4nPb8mZwNF7HULWwPsYfdGkNi3orcl+Ng81YJwFQRfEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882958; c=relaxed/simple;
	bh=aJY5YxHjrrs+bL/E4GDrICcV7CqSPu8ZnLFwgLCxZrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDU+KUs5MAc5/PmJtQiNqyqSgmR9jzCtyewpxz8Ef4mPU7Fxjbdrr8xIWjaiXSScb5vTRGTGRT/Re8OaKgqVBVo/6AHynqt1bn2hZ9YVJfLsH9fuHPCZg0o5I83n/yXU8D+g+p4+WBYboUBD2E2EFSKcuQxGHcDqG0cOVfVRMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2iW+lV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87AEFC4CEFB
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 03:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761882957;
	bh=aJY5YxHjrrs+bL/E4GDrICcV7CqSPu8ZnLFwgLCxZrM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K2iW+lV1acvo7TV2cnxbgDt/suG1fDr0AqLh6+lH1h5yKQ8exUwRp8RxPjpI1oQR9
	 d1OcrSF8Qdk91QzmgX+zlzVHnj/QdzK0/e9fK0uIkinRWDKTIrtmWC8p8mS5n6SwWf
	 yoa2VGS55olSEZ31eJdSPebqx/gF2elHHtnY298BanQCNALL1GtCuUIllaK8b8ikiG
	 mRuRiAcyCISgBECKC9ovmANgJK/RjgG3K/qwqB/w8sUVqvufdrH+GnFcchXmtTBCoF
	 etKdrIrMKEk0Arwi0DCka9QGwxJgvwG8gs/NrfY1fSTAAOb0DbQPRsJ26YhqrGPuVO
	 BG+/gXwb+oLOg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 74E6EC4160E; Fri, 31 Oct 2025 03:55:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Fri, 31 Oct 2025 03:55:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-iZWxSRqwWs@https.bugzilla.kernel.org/>
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

--- Comment #1 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
So I do see _CPC entries in your acpi table dump, but I initially had a hard
time decoding it on a machine with a newer acpica-tools package.

I tried on a machine with older acpica tools and could decode it though.

This has me wondering if the bug is perhaps not in amd-pstate but rather in
acpica code (the kernel has an acpica based interpreter as well).

Can you please check out the kernel source and do a bisect of actual kernel
commits instead of the binary kernels from the Ubuntu mainline PPA?  This w=
ill
get us narrowed down to exactly what the root cause is.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

