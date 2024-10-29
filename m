Return-Path: <linux-pm+bounces-16672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62319B515C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4EE1F251BB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C48B1DBB0D;
	Tue, 29 Oct 2024 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1aVbRWP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504519A298
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224405; cv=none; b=QbaZE6I7B1Xkk4RDOWMBFhTqbAXjDlf7OVMSG1P0ijpm9Enzz+BECTJ3hWAZ9x656FuRhlOGcG7+HHTRboC6vDiwNs65IysATU6G/gQokkvUCKJdeIvD3glQTtGKvaqxftEwsDHZ1w95XETiKohvLHB/m8KzmbPBMSysJ4+yh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224405; c=relaxed/simple;
	bh=JvxM0cpnpnzwyaMjyoigMVXOYIt3uvNlz9Mw8mhjoyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g/dPOREzbchma3vaT1sj37RbvwxNuLJWrIL4yWtsmN2Rzi1uLCKe+S6rH4yY5Elm2Ek5TxJTa87avr/LsdmhGDnqG6XK8O6n/HRD8BYfqV3Fyw+5qkyoov7en9SDoQlgfB/l1yacyDwzA60fl8Hj2DHz1F1OslUMwKNNlXXEZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1aVbRWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE411C4CECD
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730224404;
	bh=JvxM0cpnpnzwyaMjyoigMVXOYIt3uvNlz9Mw8mhjoyE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g1aVbRWP4rCZNJveeTBVsuFeomRxmfJShnyUq33iYYRgoYeFzEEgnz5nwvaBZLCPA
	 4Pa1dCWeDsn6hUHg0ggZDjPAyDk+IHD2DGlkjvtrODJbfG/J8zB4ZEEzEoA6HQdgT0
	 zGxA/UCbzU7txM8JSxhdwXap7tnVO3eNFFkjzcAwkmaaXl7ru0EvComVgXHeyaauHS
	 1iap+9l3+l3h5Oh+xGMymQhUVGkx2NnVVhKkJCCnwmofPePIuU7anFwVxa/FJs7X00
	 FicdaMmFF7zUQ7o3/tOJwEock9sZIQHF9mQAT1NQXG8fONBz9iS57UcQ2oonRtpr0V
	 1t1rvw1QbxTSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C5C74C53BC5; Tue, 29 Oct 2024 17:53:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Tue, 29 Oct 2024 17:53:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: mario.limonciello@amd.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status assigned_to
Message-ID: <bug-219431-137361-lHoabn2kWO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
           Assignee|linux-pm@vger.kernel.org    |mario.limonciello@amd.com

--- Comment #19 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
https://lore.kernel.org/linux-acpi/20241029174910.600482-1-superm1@kernel.o=
rg/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

