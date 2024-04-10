Return-Path: <linux-pm+bounces-6148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BEE89EB37
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BAF1C20EFA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE72BB0E;
	Wed, 10 Apr 2024 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMganr56"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA01524A
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731430; cv=none; b=tuL9PYPU+YmH7gOOtgFBC7+LBek/85OSWrjCV5p6RKF87DFGT/Czhgd6vQShAPCAncISbbKCuPaQ2GqV4XA05KpZuUNN0DRCO/H/4Eb4rVnsQsVFfUeh3kzOK6UgOnj9GI6qWFdkiPdPuqXbYaNDuSBZ7+1fr0VJxmr9UsHsczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731430; c=relaxed/simple;
	bh=pkAVXbTJrAWNWsLdRoozjQRo7cINCSr0LLT+LrIiIXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/iuJWyKUCkbKYgU8aEnTwtE4TFrjG4zLnYJ7zDfj+jJgVpjEQbtne4qqKWLULlevnG6m5TVFLs5zN6swXcg6Pw670428pg1xeemz5Xt8zJbfU6e5KHoC8WB2RoW15LcIJFdcI/v3yrtQ5j1WbFpVIVBkuUaPZmmi+2nX8GVtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMganr56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1538CC43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712731430;
	bh=pkAVXbTJrAWNWsLdRoozjQRo7cINCSr0LLT+LrIiIXs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OMganr567p78tGHJfRF4WjRwcOq+CHLQr9DeROqrV1cIx6uDcKgrsbpoQ9jfdOA6r
	 3zxpzw2IThe2KbuVBk1G3hYHYzGThdb5evbmqCau2jvtf4fm+P7ErX+03z40jqbnCY
	 4jFrBwHeHx8d6cad4zZliy0t0+a60AE1dh++pxZiWd7DX095WTRUpcKv7nwzmwJ/Ov
	 cIveGqCgpr634y5Uujw3oddAPJo+qcU7k0EGQIQQOTauIxFAS9HQVkQnz1yp0ydFc1
	 hijPXulcluASxvxyxCEsoM6+4sCIdYbVvSQQJApze0uDLL6+ka/xam1DgowLCS5Cl1
	 17FqmaLAtRwhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0B561C53BD9; Wed, 10 Apr 2024 06:43:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:43:49 +0000
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
Message-ID: <bug-218686-137361-5CXAfX5FSZ@https.bugzilla.kernel.org/>
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

--- Comment #14 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to al0uette from comment #13)
> (In reply to Perry Yuan(AMD) from comment #10)
> > =EF=BC=83=E3=80=80sudo apt install msr-tools
> > =EF=BC=83=E3=80=80sudo rdmsr 0xc00102b3 -a
> > please try this to capture the msr values.
>=20
> It turns out that the segfault is cause by my distribution/kernel version=
. I
> changed to archlinux with 6.9.0-rc2 and got all zeros after executing rdm=
sr

Got it, I will get one same CPU system to check the issue.=20
thanks for the issue reporting.


Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

