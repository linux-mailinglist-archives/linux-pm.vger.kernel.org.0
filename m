Return-Path: <linux-pm+bounces-24850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B745A7CD42
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 10:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B609F1890C15
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E8913633F;
	Sun,  6 Apr 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrF0Zhl1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D51C68F
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743926811; cv=none; b=HxHJFznTR4dYSzWKHqPBQDFdtjZzyF/FKSyezbvtrTAj0xL4Cg3+Hq+PygWqolaWgknNWgvn3tjiFdxXTjNwCle5HydA/9thKpQaWqRCe6CQyVT5ZxZExf7tRkoqr88TL8FWs6dMHL2896xuZvLoeNLE+J+Xergt6+yMlUz2uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743926811; c=relaxed/simple;
	bh=nHAF0R29Rh/oZ7VffOe3EcZ+fwxDX/EIE9xVBHrw2j8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TSTyv3Sq+mrYiY8M7hZrTAi7yRBdscoD93POd/8WrtdEpSmTQP1xgc+xkw/giOmvzj/LUqKdx5awdvaCZk/gBdL2UZ0HOXVH4KvXe3A7seIU/VQwzv1VnpIqSDv0/FdKXNjans2JsiDw3QIrsV90peFu6PmvrE3RtUBVwTKFu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrF0Zhl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B115C4CEED
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743926811;
	bh=nHAF0R29Rh/oZ7VffOe3EcZ+fwxDX/EIE9xVBHrw2j8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZrF0Zhl1XQ5SyoLi8GBWc6p6F3m56NsQZ24A+piprmywBPCIbCB9aXHRDCGB3Z0tR
	 rQOuEkkeZQtUPAwxl9ayCi6KqIuAP6T8YS5rOkkOZXu+cI5oj3HtCR/IpvwtSGTxOy
	 /2ewkJz+LGMen7AxgyasIjLXglS6JPw1s6Q1QSl3rzEd3nHzD6zprKKx5z1SwRAM2W
	 5VuhAKDzdVS4OoEP6MAN2p2ADve5Uihq1b3ctQO5X87kOj4suFEqXvITs4mxKUDxmw
	 eIDR+VreW2Qiv62R0fPXiTuDYFEFJSPHNw+VNHrmqyDnXZhQndNgjroeVYfqlPWRCz
	 xKdjig/3ZEhuA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E6846C53BC7; Sun,  6 Apr 2025 08:06:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219966] modpost: EXPORT symbol "policy_has_boost_freq"
 [vmlinux] version generation failed, symbol will not be versioned.
Date: Sun, 06 Apr 2025 08:06:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219966-137361-1jVnW0bILd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219966-137361@https.bugzilla.kernel.org/>
References: <bug-219966-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219966

--- Comment #3 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Thank you. Indeed, the warnings are gone with your patch. Sorry, for not
checking that before.

@sander44, could you please confirm.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

