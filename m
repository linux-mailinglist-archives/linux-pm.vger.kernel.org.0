Return-Path: <linux-pm+bounces-2360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A568323C6
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 04:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6961728650C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 03:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429B17C9;
	Fri, 19 Jan 2024 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAXdyTBQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB4184E
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635146; cv=none; b=m6nEMi0mJTjP9QgisoduRFLUrQWN0FOlFP1OQ1epDYAjbYvKeyxqdn6nKXGj2FpMhX+IYL1ONWDYI0tJWojDcGFKIX3TYdlh45OXFWftm56SGhEvjeEQdpYAblbeIjQSiTtSI8BE+j2COvZJGGFjkgyM19wSn8WyLlbhn4VZ4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635146; c=relaxed/simple;
	bh=vtmP31xNrugtsFVfN4/mLhDmgkBs1abcz5bjId+YyEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4FRmNE8ZTaZze4VHuAAo+810U31OLK7e0y3SmvP5ksqgc4pO1yFomCvLOribHe6YGTyZpyg9cyW1jf9I9AjWKPbaqixvoDEXDhotWlH7+kwwcsSjG1DmrPX3PkabS0dTSYngtqqWxB6RCLB7Y+KvB/R6IF870wOy+ZNcR6z2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAXdyTBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1E8EC43399
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 03:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705635143;
	bh=vtmP31xNrugtsFVfN4/mLhDmgkBs1abcz5bjId+YyEk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RAXdyTBQ1LAs1m0VNUXgFtB+J7ZqOQxKDDItjjOjvmIvsJwRnVmEVpoS98yYEbZcC
	 L+6fGz5Ie5bQka/zyQAyEo7DAIKS/H9OUsKxR6ZzK4+1cADff6ZaXYmRyuF28q8Zp+
	 8P/zzQSWWJAHIdvblQH02lGZYtIxv10FJofW1Um9V8hGz+qmj2hrnWjyQZB52UF7wi
	 2Sk6jt1/cVyQVGa7AqvADvs2qUt6CrDjatwnllq/YDJb8pgl0gYmeIm4ZojqZqMoRY
	 drcuJfubcjWxj3EFBzgKpDHLSILoxlA3G0VNBWTtLCoi1Lg59FWuhCwFs0S53nxR0+
	 WJ2qc3icCXxTg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A4115C53BD0; Fri, 19 Jan 2024 03:32:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 19 Jan 2024 03:32:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alex.delorenzo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-cIEXQEFaXG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #29 from AlexDeLorenzo.dev (alex.delorenzo@gmail.com) ---
It happened again ~90min after doing a `systemctl kexec` and using `ryzenad=
j`,
so I can better answer your questions.

(In reply to Mario Limonciello (AMD) from comment #16)
> When you say getting stuck in lowest supported frequency does it resemble
> bug 218305 perhaps?

It seems to differ from bug 218305 in that the values `ryzenadj -i` returns
seem sane on my machine, whereas in the other bug report they weren't. I'm =
also
getting the correct reporting for the maximum supported frequency for all o=
f my
cores.

I can't say what triggers it, but I've noticed it most when using the machi=
ne
for a couple of hours, sometimes while using the processor moderately but n=
ot
excessively.=20

> What is your CPU scaling governor when it happened?  And does it only hap=
pen
> with suspend/resume or only with reboot?

This time it happened with the performance governor.=20

I added an attachment with the output of ryzenadj, cpupower and sysfs taken
while the machine was stuck at 400MHz

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

