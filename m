Return-Path: <linux-pm+bounces-32206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9AB218C7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 00:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7213142298F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 22:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E642253F9;
	Mon, 11 Aug 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUG2nb4t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559AD199FAC
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952851; cv=none; b=d36gJPd4l4KjY/j1iY+l6RAd/WY6xwu90mpyaem9rQAvgaYr3RBZc13FeQsJpGzwekyHl+pMVZB1+4z1K+EM2Rb0lWE9tysIXvv0tMAQCrmDWuwZqFRs8CluxgPxZ8mLWn2VoKRLQzP0CbQ+vx7uQJ4lSwgitzmpEDhnL2Z4QWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952851; c=relaxed/simple;
	bh=0maDoTErqrYW4XvPG2WRa3DlNBt7tzcipD0Ep8dxiZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otnLoz0iziKVaEQm3lE8cHL/J9nX7ElLSPzS1y3BLbkqugnd+18ZY0kDDQETLIyB67ytOpJ8+nNfmhcwxKRwOR1+AjolrinRQMd99p41noxF9HwF/krMVMpUCGVTMPNdQ0JhhRWMGqYPkcAyaEGhkVpOSQFo5BKv6t6xJEFo7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUG2nb4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E185EC4CEED
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754952850;
	bh=0maDoTErqrYW4XvPG2WRa3DlNBt7tzcipD0Ep8dxiZM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZUG2nb4t/aCvU/jUbk3kHVJl2hbJfPJRjmFQOIc8tgpX1WHFkcm37wNkAj2EvWvDd
	 Xr8kbE/qNIxpMTQSZoMu/Vqi6OPNHVtTxTiM172kbFFPGhG5hIMksZrM8483o5G3av
	 Kb0sojY4Dy6S82LCCf6c6O6HFfCY68rpjAZFBwHFW8mtv0oE2JivPTdDxT0E7PMiQY
	 2pEdpZh/A/WkxZr6/MICEyEw0a9B2sW+l/M1otPdKU2yJxDhto44Z30DKENfBgBmfs
	 adO90Dm0nJMnC+vKA0dkEXSCrd+hJsp1PSlmb/rwnzYjkU8cQMI2jHw6XkQSj0qqL6
	 /b+oez695/gyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D8680C41614; Mon, 11 Aug 2025 22:54:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220433] Regression on AMD pstate cannot control turbo boost
 after wake from suspend
Date: Mon, 11 Aug 2025 22:54:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: me@gzgz.dev
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220433-137361-qwhikzfhQA@https.bugzilla.kernel.org/>
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

Gavin Zhao (me@gzgz.dev) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #2 from Gavin Zhao (me@gzgz.dev) ---
Ah shoot v6.16 fixed it in 98b52c6b0b528, my distro on v6.15 so didn't get =
the
fix. Sorry for the noise!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

