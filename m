Return-Path: <linux-pm+bounces-1721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E7821971
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jan 2024 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CAA1F21F93
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jan 2024 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23705CA78;
	Tue,  2 Jan 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkl2+TSI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A1D266
	for <linux-pm@vger.kernel.org>; Tue,  2 Jan 2024 10:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86CE3C433CB
	for <linux-pm@vger.kernel.org>; Tue,  2 Jan 2024 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704190218;
	bh=Iff7itUVqdf5K8JiPB95MEGXkGcLNImvBb9ZrQ7ATDE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fkl2+TSICLucEg2Xd6HOUJzKAAmRweo4THSxF0vHlctM75OV/EudKrv0oUEuaf4Gt
	 t67jQzYwDGgygD63gBL2iXeGgxOl3qCnSFDlb9CoEssTWhNzJfLCCWjYI4m5FzKGZg
	 AuqyoAqDZD1SbvaMPOSYAF1wDgE8DwSGiLe0RtjUvPNnE4kI6RXtyGZX+CLPhNIK0l
	 JeKjIY8RoebXQu47zy0WgySYwljpdBDk4m8PSNTII/6rLC0CLjc3vTbLmLGLrYnKNb
	 XKAFzc3hAdtHcuz7d5ATiKsW8clJhH7g7YvvpfcIiKTGN2ojyg5B96dsuW7HxQUDHS
	 T0Tcl3vknoL/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E90AC4332E; Tue,  2 Jan 2024 10:10:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Tue, 02 Jan 2024 10:10:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218171-137361-UqH4RFVV1h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

