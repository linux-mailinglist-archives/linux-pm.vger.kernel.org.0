Return-Path: <linux-pm+bounces-12843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F41695D645
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 21:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823161C20EDD
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 19:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAF41925BC;
	Fri, 23 Aug 2024 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx1+xey2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627C1885B9
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442851; cv=none; b=dBUDYIcpwdtsTIcuMm1QrutUm5lK28Au4S59EKX7OKTBIfm6SBvF4xYMC1XJgW8Nnd1FaRFAIBkSEQt4BQslhXOJjIoYi1KgbdT0SpTDlGHce0wJMkXwthnCpc0STjOieLEU5lo02jym8+lT20nr3zEYp8s3qzJI1mgeFFpC+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442851; c=relaxed/simple;
	bh=a6YXGGbDwcwlVpb7aveFpdFWBXCGGbJYIOLU0ivpQvw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DGU4FWsEsfZd180q+10vWtn5hCOuI6QMa7zQnWlkrR0DR17ivObaItKFscXn1CBIIjndEbBQ3vNnBkqxAuYptYccytmftRKNgjv3Sg2///+U/YJInnEvzs4A2jJOi6BpFXAmTY4EGqjeqkHQY69L+QVjNu0dIjMj/vQ055x25Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx1+xey2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E3FCC32786
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724442849;
	bh=a6YXGGbDwcwlVpb7aveFpdFWBXCGGbJYIOLU0ivpQvw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xx1+xey2j3XkejsXXtzKf2pJPvwaGoeTYlIXWBTAFwG0XzHTVmAz74w/BP4qEd06S
	 ZV2ATQvxzR/gl/rHJEIb/wCOX56NkHst/+w6GVey1WL9uvlVFRuNtEiWmPrfUazjC+
	 nSx2fPgl6nR3odhnzgDxFaZsJUw9O4ub1A1NIwuLtYJTPwOJilpKbGS2FYlkwFUs5x
	 3pgi9mtOgN0y3hsWgyhBkFTKeVCxvjOZhUZpoasRGyBr3rG1MECuh+0l9jMQA1xUKh
	 q/YCTP+uitpZUjY7XLhhp3ncEVcDCwLjHQtPpUZezgFpCT4gpeLkJuU5W8oTbZQ5aw
	 6/8RnX1Cq9Xlg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8AAAAC53B73; Fri, 23 Aug 2024 19:54:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Fri, 23 Aug 2024 19:54:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219110-137361-U2onbdQtSF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
Perhaps I didn't make it clear in the bug report, Mario, but the value of t=
he
variable is correct after resuming, it's the same as you set it, but the en=
ergy
preference gets reset to the default value. In other words, the variable no
longer represents the state of the system.

I will test 6.11 once it gets released.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

