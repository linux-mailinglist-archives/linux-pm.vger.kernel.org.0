Return-Path: <linux-pm+bounces-25593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7285A9127D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0041901252
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 05:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB181A316D;
	Thu, 17 Apr 2025 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4oMVGBC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDE18C034
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744866044; cv=none; b=aE2tLKWwqdsmfftK2HgR0r77eVkQA3CUqvvPtrXuNqo3TXxwzIP7U4E2xE6+xjcniJxSV+5k1LPcwFfEZwK4Ax2l58lak1Or8A/Qlu0GwedVF23SBt9kYNjz8BY6JX4jkodr2cJw5mx4LCwjK+v9+i56kjnxtaUofDACmyjcwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744866044; c=relaxed/simple;
	bh=fA0xFEDzFcaNIwenyLxW05UWdXaVWrzNlt28HiUYcTk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/x/2coG/4mtlrnCeFMyED9jef3pBv51sNB/vzxlwH5O58Y22KwqIWaP9Cl1aJALFaK4bRxqDvxVC2iJ4Ii/HyA0Sot9TcJB515kEmkK5ox4AZTSQqzA7eZQ+sZbpKOPgxD7qzmsPTVHqhAIy0P+2DUPqVN3k0FGjapD8uEBsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4oMVGBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEFB6C4CEEB
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 05:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744866044;
	bh=fA0xFEDzFcaNIwenyLxW05UWdXaVWrzNlt28HiUYcTk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p4oMVGBCQphw82nUmhsQpYSCzQ5TWbVLYOHa/g9zH0h6lAGLS3m+zi0cG7PklRqGj
	 DP9wizpJK0nzxSpEnPeuqKeYVZTbXneD9cl4aDpu9uW2T9mWRxzzbqIKlaS1ug3Ahe
	 CHbAxkKUjp2b7Zqh3v1l+Z7jDQhUEujnCCwN1N9xe5FTM1S86QNfybrYEbFEG7Yf88
	 7YdGy3JghL2gxCKPFil/hryzUjin0bsXvGpPe/pcPzXWfJAmZ+uPq6rzBLEoDIT9he
	 aXf4M0ckjlnNuhNp6K8XiDfqXizGwOyDd5cqUCvUdzevnFysPVMFY62usd75mQshFD
	 IcgSWqwepyyrQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DEFB3C53BBF; Thu, 17 Apr 2025 05:00:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220013] [REGRESSION, BISECTED] acpi-cpufreq: Boost disablement
 not being restored after resume from suspend
Date: Thu, 17 Apr 2025 05:00:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nic.c3.14@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220013-137361-oFqLEKqrUY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220013-137361@https.bugzilla.kernel.org/>
References: <bug-220013-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220013

--- Comment #5 from Nicholas Chin (nic.c3.14@gmail.com) ---
I did some more testing and debugging and it seems like when cpufreq_online=
()
runs after waking the system, policy->boost_enabled and cpufreq_boost_enabl=
ed()
are both 0, so the set_boost() at the end of that function is never run.

cpufreq_boost_enabled() being 0 indicates that the MSR has boosting disable=
d,
but when I read out that MSR using rdmsr the bit seems to indicate that it =
is
actually enabled (I am aware of the inverted logic of that bit). set_boost()
seems to be the only place in the kernel that causes that MSR to be modifie=
d,
and I didn't see any extra calls to it in my debug logs, so it seems like
something else (outside the kernel?) is setting that MSR.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

