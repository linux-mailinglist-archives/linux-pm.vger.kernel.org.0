Return-Path: <linux-pm+bounces-14-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566317F29EF
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103B2281E57
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED493D392;
	Tue, 21 Nov 2023 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffwmLgOo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C13D390
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 10:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66FB7C433C9
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 10:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700561772;
	bh=j5vDhmAnoXyZyaKey1iXxjB5R+RpRPU8BMEM19oVRVI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ffwmLgOo7MZgKjWSfxHzUzOJiF6cQWbOSAKogdb26OFKkuB36S21iM8M9Wxe7Zhjq
	 L1eoZ8piF5YCYDXuBmLph33WA+s0eFWXaTl75TbPeoi5Q6Xr52xTaItgRrLz68gqTw
	 mNyxm5dgzy9jGEK1TZ5PfXLqlGWUaP/jdvYqpgPEaPD5Yii2f8g2k6IwgYQUj6QI8I
	 w+ngQ+yByZusv8j948HNo8dfe+N70byaT7+hK4p5Y+X6ifCyIoMehu+nf5aynVp27/
	 GFBDtbt32JyH3h5YYY4OQ7o39vPBXKDm0jWFcKmRhRvHOcnuxbRlCa9mJvjHZlrKhV
	 L2akSaXSLOenA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 51A7BC53BD1; Tue, 21 Nov 2023 10:16:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Tue, 21 Nov 2023 10:16:12 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218171-137361-W5SkmZpf1B@https.bugzilla.kernel.org/>
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

Perry Yuan(AMD) (Perry.Yuan@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Perry.Yuan@amd.com

--- Comment #2 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Have you checked your BIOS setting? Some BIOS version has the CPPC option to
change CPPC default state.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

