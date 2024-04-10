Return-Path: <linux-pm+bounces-6140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4414E89E9ED
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DE31C21D29
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 05:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D1A10A03;
	Wed, 10 Apr 2024 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nox/s9EY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086C17745
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727985; cv=none; b=eAzC0O3Us3P75eKtH+533YXPtw1r32rwbtii+NF+hN8nrcQkivC3FATxdKQ1inFiZkaCjrvllpIXKGpXMuTqX+wmwdL/2LO1+wAxHf8ElLDWWbZVZIOcMEACxneM4mN2ZBYart3ZgesaIigYEgYiSU9Rolyrb4/yvNkM0d/XCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727985; c=relaxed/simple;
	bh=UoAJ+ApoK/ahR9ynHItY3w+1jRZENStH9t8em4Lf6tw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ef2ozbm6dohVE635HCvoFSLhKwzGIchyE6/sfJrqwAcrijBVA5t0R75lUl9aaVBvPkIneqotkMOP2TDjfWMOtz5RVkMF+Oy4FP3EgKo+Sp4fqfNGcnC4L7Fjp50p6y9xGxSlry9BSy1dfUE+/n+n3bwjdFqq2Nw2TTLc71CTS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nox/s9EY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC767C433F1
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712727984;
	bh=UoAJ+ApoK/ahR9ynHItY3w+1jRZENStH9t8em4Lf6tw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nox/s9EYN3PAsKsy6SRCY8My426Rj1l/KJ96JXnAfAHkTF2C8lbyIMj1n2YVFQ2Yw
	 2Am6JNRSMc9rBl9ye79sUGRp80/8VJMm2m/sNUs6TOEhpDq7y0eeRQ3XbOW99EQJFK
	 YluO+PQl3kwLQGZ6TKtqX8AXonGCi+X6NzGVhpvyHQsTtFVVWj3L/ZXVMJGZG5Qyz8
	 VP5PFfCenAa1bL7LECKnPsYDwIXVXFgO8UWktC70vK/ZH0RG5UI1m4aYoMKPztyKaR
	 EidEuLKmI8NVJfK8kEXw6JdEpg0bHx/aDYZU4pIOY+Jb59jDoAfakGsHT/g8i5oxod
	 ZPKiudbPSsrIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C5DEEC53BD9; Wed, 10 Apr 2024 05:46:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 05:46:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-1Zag86uEt9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #6 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #5)
> Hi=EF=BC=8Cplease help to provide this output with below commands.
>=20
> # cd /sys/devices/system/cpu/cpu0/cpufreq
> # grep . *
> #sudo rdmsr 0xc00102b3 -a
> #lscpu -ae
> #dmesg

Should I do this with amd_pstate=3Dactive commandline?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

