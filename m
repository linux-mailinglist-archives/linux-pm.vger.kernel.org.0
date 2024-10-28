Return-Path: <linux-pm+bounces-16599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8159B3687
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5851F22082
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F3A1DD545;
	Mon, 28 Oct 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+H4Qmw8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457818785D
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133165; cv=none; b=CiTvCUokAI89/kgmBqS7+eUl8bzeu8GV1o95wF+XMN883RmIJF1H6LcNvCg3SjL0yUZvuy9IEV+sEnP9V5tt8ABwTA3Jw0Z6II/NBf6uCSLD80N4KdqhA6LBIt1kGkBOFp3eeDZd4Kx9SSmgJqGG4kW+EnGmLOPOoVk9VpLhNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133165; c=relaxed/simple;
	bh=c8ojzwmKL2gO0mzSho1rbpkK8lIbbqO0MvXWL0MSqkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHTJZOMFSI1ppVaaDvdVF2PYR5f/NoEVkyo65KYbFkiJZYGFX3gHm4btr2PHOeDWYV+P3y+DsUzISW5oO330XSNhLwOJ1Su4AyXWEF3sgA2YaC9GII9z8McE5IgYjErU3jGa+HJsEP+eryHvcs+y2Nu7wkibtUB4Boq28CE7KwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+H4Qmw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4A12C4CEC7
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133164;
	bh=c8ojzwmKL2gO0mzSho1rbpkK8lIbbqO0MvXWL0MSqkA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g+H4Qmw8OQhk4wCfw/1eoUjoYmt+yAplci+nf65XbrjMonvMgwTMmuVNjKYDq4WQr
	 aGC2XIGu/vjcaRwQ1FIhyO3m+ozU8JI83AQL4bWA9v7E2S8vsnVjnk9ZjplbRb7Xx2
	 K7RteIgGiCz8fAWv4lisbFWSjpvNMcTuqBa1vihiWR0QNQx0S9j4obDMpwrligmyNS
	 Aeq0p+ZwtxV+COjDL9yxUi9zDWgA6TSC1ebbSkCv9kk4iYxWp0Qhav3gykIYsVnDFF
	 lfijVzkC2LUzRb9Qdpal2375Khe+MEVo97U/jbxIwVbvvVd9W2gDLkjRdRZzHe/Kpq
	 aizedPIwFdnZw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C2ABFC53BBF; Mon, 28 Oct 2024 16:32:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 16:32:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandr@natalenko.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219431-137361-XUdgphMMMM@https.bugzilla.kernel.org/>
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

--- Comment #8 from Oleksandr Natalenko (oleksandr@natalenko.name) ---
Created attachment 307081
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307081&action=3Dedit
dmesg dyndbg, 5950X, ASUS Pro WS X570-ACE

Attached dmesg with dyndbg.

I do not think I can describe any functional limitations I face.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

