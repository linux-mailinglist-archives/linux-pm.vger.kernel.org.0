Return-Path: <linux-pm+bounces-7739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533608C3029
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0362D284276
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77F10788;
	Sat, 11 May 2024 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrCPdGeA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9DD2FE
	for <linux-pm@vger.kernel.org>; Sat, 11 May 2024 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413906; cv=none; b=CeVZRm1neGKRiurTPHTt4+lz4eRe6y7hTpxtUcoFcC2hQadY+csnfAJdtd5lUR86QvMaVJyUadRe6A96EBK9tSftbF2fH3KUqJPQr2VNBPU4wKI/DrXa1gEDzJgX9TvfXKkD+s48NPwQpZF6aZ0rIR93MWe2Voi5dehQy3NqswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413906; c=relaxed/simple;
	bh=Req0l8MFSVPk5vSIapr3ExhBBaOLHpTGgN0zPcCysqM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Od5E4RZ12kTyD6WpU3pM7lRagcdCGbnKHi0tMHGKRx+olJ+esK155aEqcY2Xpi0QFhDM+XJRUfbhtGef9a6X6DHZ8tvlQYwt1aJ9mREzck+q1NpvL401yQZTCi+ePRGktvG90NDZ4N+b5pfvzVMTB3aafjrWojLAg1QElJZuCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrCPdGeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD7C1C32783
	for <linux-pm@vger.kernel.org>; Sat, 11 May 2024 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715413905;
	bh=Req0l8MFSVPk5vSIapr3ExhBBaOLHpTGgN0zPcCysqM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QrCPdGeAdRSX73plGIrl+8ikhqZmU88J4MO8fJ13blJniYX4XobuQQsiIiv1Tzziq
	 VVlHkudlwIlehqBwuEy71Eu82oBjOVSmIulYHjCPhKqs9Co5KImK3O4kml9BuoYf81
	 5Q4Yv6lo2heL2AgO+SatNtK8TNps5GQ8fI+U0615KItyLnrsHIVrJyiv+pmNbHAIIM
	 OqnQXJX0KAg/F8kRwEjhqdedgUtAu26Ioaum7RW8PLV0egMMqCcdJrzuc4uYwh7IJA
	 OzBFbN+xs0DFROh3TysiijLkrBYsKZEt66FVHlyEE/CV4V/8q2GFmWPNVDJwU7EZs9
	 uxusEEMHGH0BQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BE240C53B6F; Sat, 11 May 2024 07:51:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218827] A question about the cpu freq policy
Date: Sat, 11 May 2024 07:51:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218827-137361-jxJVGp4MoC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218827-137361@https.bugzilla.kernel.org/>
References: <bug-218827-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218827

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
It will be silently ignored.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

