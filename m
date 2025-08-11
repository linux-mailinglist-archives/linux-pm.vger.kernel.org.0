Return-Path: <linux-pm+bounces-32139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F07B201CF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD861882049
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E92D8798;
	Mon, 11 Aug 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n82/Jj/D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2A1E2307
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900844; cv=none; b=V2YTdVQKbsC4IIDQJF2hseZwxDGtySe0TlMBJuJ26xH8KFoFmKOX65pBoF/Fc4Z/PKYtG2kS0CM9+A6DFDAfbjrMKpuZa5JhCt38bhS2bvZ7dLrUxxDLiL6mVu3krbXnMQlyJwsbGLof6Cag2fvG/Zx1ap0tt497h2KnE038lD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900844; c=relaxed/simple;
	bh=XwtZZAJNm6DcRDOFth4OOoPF52PVMYE3jbNCEZm63pA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7RGdqIH0Wray7XKHGTP8v8eqcmOo9bImdb8kIDeP2/BZvmvVSZ3WsvlLKQbSG9qEqJFpfJoobL6O4wdET2Slrr5h2HuOyVyRJy4jJBgvRdJxTG5sVLi+xhcz8pbfyk0Iv97YwPY0Q3VafKWWneKOqmhlToY6g8X13XOwIcGTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n82/Jj/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F684C4CEF7
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900844;
	bh=XwtZZAJNm6DcRDOFth4OOoPF52PVMYE3jbNCEZm63pA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n82/Jj/DNtg2/EYoL4MnvjgJxdJYMpnx2vE+2L21c2z3O6sh3MIF5XYifzE9tVk55
	 r6XbH+hEV+8MA5VGW00MhSb9v2Dvlnhf/Y1c8qOvP1X8FrOkmBYuCXRvAkul+y6806
	 JqDXdrUk1eMzx/ZEOy2E4GcSaPChNElH97Cb72xGb/9HhbNMif+lCSI9Sl+ItSxyVS
	 beIl1s/fcx4NL7b7101tIRv441hPnuJ0xuaWRbr2NZCR1zV91IWnrtUVWnNQEW3VIj
	 aV7JPRMKsIOHMS5YQ2lf+7T3JLpxLGynWGvNXQ1chXnR6KjEHNDJL5bL/eyvVPjpcu
	 2ITsvTiVtOZYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 014EEC53BBF; Mon, 11 Aug 2025 08:27:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220433] Regression on AMD pstate cannot control turbo boost
 after wake from suspend
Date: Mon, 11 Aug 2025 08:27:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-220433-137361-fBquEyJfcy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220433-137361@https.bugzilla.kernel.org/>
References: <bug-220433-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220433

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
First check 6.16 or soon to be released 6.16.1

If it's still reproducible please bisect:

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

