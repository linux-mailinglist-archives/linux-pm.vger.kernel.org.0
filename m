Return-Path: <linux-pm+bounces-658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD2802B36
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 06:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0A81F20FF8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 05:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F4138A;
	Mon,  4 Dec 2023 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHHdrGfd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEB15A4
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 05:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A10EC433CA
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 05:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701666422;
	bh=Z+QNL1dZNUW+qDh7LgdYslzPI3UuPJNOd5IkRdvPR0Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oHHdrGfd9lvDhHjwRQy4gAY0hanNedEKxOnf3dExXv13hkWSXhLy7NvbKOMbZ9lEY
	 lrZB962PP+y4mmoj9CGkKOSN2vYdFpn28BJdaI0SlVST7Vfc6TgH6yX3xSDzxtMlTU
	 cYLefHNdAx8GND/hVWt/yfw9dEKTZL4IQJw5gl5/bh4BjB4vJNKAp06iwkFhpIayx6
	 b7NzFOM5iuXF3YF5AR0Jn2q0K//18lzc0r1cIYPfd5HpcTwdsrHZZi3hggI+V+juGG
	 LCu0S+6P+Cqn00ud9Bq6OtcyMSCm+/KGtcivCYLr9DNoia+ZhkC5FHBz4izcei9nLx
	 qem8luq1m8MNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6E49EC53BD3; Mon,  4 Dec 2023 05:07:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218217] amd_pstate, amd-pstate: power consumption above average
 in idle.
Date: Mon, 04 Dec 2023 05:07:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to
Message-ID: <bug-218217-137361-cCvth8OdLf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218217-137361@https.bugzilla.kernel.org/>
References: <bug-218217-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218217

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Other                       |cpufreq
           Assignee|rjw@rjwysocki.net           |linux-pm@vger.kernel.org

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Is this a new regression? Does 6.5.x kernel work better? Are you sure the
system is completely idle? Is it possible that you've upgraded something el=
se
in the meantime which causes an additional power draw?

Have you tried disconnecting your laptop from the mains? What's the power
consumption then?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

