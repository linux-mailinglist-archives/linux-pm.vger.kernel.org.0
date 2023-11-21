Return-Path: <linux-pm+bounces-15-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C6C7F2AF5
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 11:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5708C1C20B51
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC647791;
	Tue, 21 Nov 2023 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib7QucXh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081B4778D
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 10:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87769C433C7
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700563722;
	bh=BROlHXq17tefW89Ks6RKTVhAeIEOOzmmF7MUs2Ap/GI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ib7QucXhTuL0jjygpWG17+5sqAWm9+mnnRe9mlHWVVDDGGoePG4qp6Og4JpXUN3xE
	 0nNnhswgkNpO2QNu8WhAPLBnTE/9+ODIfvLSkNdkC8XJNFe/rsz63JnnnY+sDE76wP
	 OyyvhNBcAXGftTWW6fqS1Rw8pz+azGvqVNtUFvA5eg7VupNJ3DejgL2KhkjvAu5mmA
	 2xhDYnu4o3WNsH/45QYqeJiKdy2JoExQTIlmhgtbe/ajJQpz2eSNGfpnPBf2CUa7nz
	 qOak8Oj7F2bWvPOhO+B1cvqm+Eeq2gXQcWAzkwPkRXiTjR5dGgGkQzd8pkfcmUz2G0
	 3YLpl0gHmvs4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 76A12C53BC6; Tue, 21 Nov 2023 10:48:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Tue, 21 Nov 2023 10:48:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-h5CKlSosSf@https.bugzilla.kernel.org/>
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

--- Comment #3 from badouri.g@gmail.com (badouri.g@gmail.com) ---
Hi Perry,

I have the following in: Advanced > AMD CBS > NBIO Common Options > SMU Com=
mon
Options

CPPC (Auto / Enabled / Disabled): Enabled
CPPC Preferred Cores: Enabled

There is no setting to change the default state.

But there seems to be more reports of TRX40 users who are having the same
problem:

https://forum.level1techs.com/t/is-there-cppc-support-on-threadripper-3000-=
platform/195804/5

https://www.reddit.com/r/threadripper/comments/151l6rn/threadripper_amdpsta=
te_driver_on_arch/

https://www.reddit.com/r/linux/comments/15p4bfs/comment/jvvr12s/?utm_source=
=3Dreddit&utm_medium=3Dweb2x&context=3D3

A while ago I was running a custom Xanmod kernel which had the amd-pstate
patchset applied before it was sent upstream.
It was an older revision of the driver of course but it was working for me.
The only requirement back then was setting the "shared_mem=3D1" flag on the
kernel command line.
But this flag doesn't seem to fix it for me when running linux 6.5.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

