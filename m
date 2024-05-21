Return-Path: <linux-pm+bounces-8014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C08CA8CB
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 09:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272E51C211E0
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6946E45026;
	Tue, 21 May 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDV58UyI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380D4F217
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275989; cv=none; b=iHeYMRU1E7edsxc7Z725kiB3AK/GHbJrAjis4VByClB7C+T/Exr++PmJBkdp8MFeeaocRbtY3q9pGArzMqBxjew+SNogzojpeiTWZdceMKBv2aY6yrgXVjr8OSBeWItDa6+UcitSokS1FYeJx5CGF25toaeHb4bIo+D9xUWlPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275989; c=relaxed/simple;
	bh=6DjFeMVY5LYlSB/tXz+FA6gJKoHYXo7dTCC7gZzPzpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dh8AkeC5Wq5SpYIaOvAFDXHOcMb7GvuBdeJPqJl13JXH0R9BuSifVZxa3ECos08riFUuO7VsO1QIpex4wdQ4+hQNl3wLConhF9vjHJY2ptMDssJV73YK0Hb1KnMaMmN78faKWP42/+CvYaox9Ay6T6K1spbrHG8QpXO0gjegtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDV58UyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBBA5C4AF0A
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716275988;
	bh=6DjFeMVY5LYlSB/tXz+FA6gJKoHYXo7dTCC7gZzPzpw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NDV58UyItrQDXIPyDlxyAaplYvXPBLns/HTstFIHo2hoqpud6BK8V/7uyW9vw3Qi8
	 lDajqr9uqq/DVSnfaglHiVL0aCphzh/itiZbTG/8eXaQxtXKbdoT8QcH7Pk8r5NxA/
	 08YIWzE83H2+n/CA6SGxva2eyHRkwGtRTW0GJ5C7Ue1HqKpEyqiEs5XqX55gpRmO9h
	 h+QQGsuIyL57RUj+EGBxgTj3x7TBdBDu1oTif1lnpoqW9aR0cVJFvoFRy+8wTjuNpL
	 ErkyYUTERSQd9thTjx6cvlfp0LEVwNsLnm1FvJNAi6cSzUznbTrQ6f1NLco+Mtt/jb
	 +OJbzoee0fZyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D0AE7C53BB7; Tue, 21 May 2024 07:19:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Tue, 21 May 2024 07:19:48 +0000
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
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218705-137361-6w4z2Y8Mtc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

